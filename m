Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34026698EAF
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 09:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjBPIaD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 03:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBPIaC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 03:30:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7C92CC50
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 00:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676536152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yWe59C3zukH1hXHPi3xSqXe+d3YhK+Sr2LV3xpxp7IE=;
        b=SqwJ/t69djh/Dj4Y1cssSr1P1IgKFS5KErFeoLr4bW17QmMXDAoLKNTjgpK3yg812lrPGK
        EncTtkL/8qlUl9GZyIbnB6PKR4Lgw6X1fobe90P0PijkCbOA6Y/jqFGJd/h7j0yO4SWzNz
        yA57CRuMZ9kV9RfBshLmgla7o+Gq4wE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-599-DIT4l3xaOwSOJBH_dl76lQ-1; Thu, 16 Feb 2023 03:29:08 -0500
X-MC-Unique: DIT4l3xaOwSOJBH_dl76lQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22D833C10EDA;
        Thu, 16 Feb 2023 08:29:08 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9988D40CF8E4;
        Thu, 16 Feb 2023 08:29:01 +0000 (UTC)
Date:   Thu, 16 Feb 2023 16:28:55 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org, io-uring@vger.kernel.org,
        bpf@vger.kernel.org, axboe@kernel.dk, asml.silence@gmail.com,
        ZiyangZhang@linux.alibaba.com, ming.lei@redhat.com
Subject: Re: [UBLKSRV] Add ebpf support.
Message-ID: <Y+3pR991R9nrdg5Y@T590>
References: <20230215004122.28917-1-xiaoguang.wang@linux.alibaba.com>
 <20230215004618.35503-1-xiaoguang.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215004618.35503-1-xiaoguang.wang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 15, 2023 at 08:46:18AM +0800, Xiaoguang Wang wrote:
> Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
> ---
>  bpf/ublk.bpf.c         | 168 +++++++++++++++++++++++++++++++++++++++++
>  include/ublk_cmd.h     |   2 +
>  include/ublksrv.h      |   8 ++
>  include/ublksrv_priv.h |   1 +
>  include/ublksrv_tgt.h  |   1 +
>  lib/ublksrv.c          |   4 +
>  lib/ublksrv_cmd.c      |  21 ++++++
>  tgt_loop.cpp           |  31 +++++++-
>  ublksrv_tgt.cpp        |  33 ++++++++
>  9 files changed, 268 insertions(+), 1 deletion(-)
>  create mode 100644 bpf/ublk.bpf.c
> 
> diff --git a/bpf/ublk.bpf.c b/bpf/ublk.bpf.c
> new file mode 100644
> index 0000000..80e79de
> --- /dev/null
> +++ b/bpf/ublk.bpf.c
> @@ -0,0 +1,168 @@
> +#include "vmlinux.h"

Where is vmlinux.h?

> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_core_read.h>
> +
> +
> +static long (*bpf_ublk_queue_sqe)(void *ctx, struct io_uring_sqe *sqe,
> +		u32 sqe_len, u32 fd) = (void *) 212;
> +
> +int target_fd = -1;
> +
> +struct sqe_key {
> +	u16 q_id;
> +	u16 tag;
> +	u32 res;
> +	u64 offset;
> +};
> +
> +struct sqe_data {
> +	char data[128];
> +};
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(max_entries, 8192);
> +	__type(key, struct sqe_key);
> +	__type(value, struct sqe_data);
> +} sqes_map SEC(".maps");
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(max_entries, 128);
> +	__type(key, int);
> +	__type(value, int);
> +} uring_fd_map SEC(".maps");
> +
> +static inline void io_uring_prep_rw(__u8 op, struct io_uring_sqe *sqe, int fd,
> +				    const void *addr, unsigned len,
> +				    __u64 offset)
> +{
> +	sqe->opcode = op;
> +	sqe->flags = 0;
> +	sqe->ioprio = 0;
> +	sqe->fd = fd;
> +	sqe->off = offset;
> +	sqe->addr = (unsigned long) addr;
> +	sqe->len = len;
> +	sqe->fsync_flags = 0;
> +	sqe->buf_index = 0;
> +	sqe->personality = 0;
> +	sqe->splice_fd_in = 0;
> +	sqe->addr3 = 0;
> +	sqe->__pad2[0] = 0;
> +}
> +
> +static inline void io_uring_prep_nop(struct io_uring_sqe *sqe)
> +{
> +	io_uring_prep_rw(IORING_OP_NOP, sqe, -1, 0, 0, 0);
> +}
> +
> +static inline void io_uring_prep_read(struct io_uring_sqe *sqe, int fd,
> +			void *buf, unsigned nbytes, off_t offset)
> +{
> +	io_uring_prep_rw(IORING_OP_READ, sqe, fd, buf, nbytes, offset);
> +}
> +
> +static inline void io_uring_prep_write(struct io_uring_sqe *sqe, int fd,
> +	const void *buf, unsigned nbytes, off_t offset)
> +{
> +	io_uring_prep_rw(IORING_OP_WRITE, sqe, fd, buf, nbytes, offset);
> +}
> +
> +/*
> +static u64 submit_sqe(struct bpf_map *map, void *key, void *value, void *data)
> +{
> +	struct io_uring_sqe *sqe = (struct io_uring_sqe *)value;
> +	struct ublk_bpf_ctx *ctx = ((struct callback_ctx *)data)->ctx;
> +	struct sqe_key *skey = (struct sqe_key *)key;
> +	char fmt[] ="submit sqe for req[qid:%u tag:%u]\n";
> +	char fmt2[] ="submit sqe test prep\n";
> +	u16 qid, tag;
> +	int q_id = skey->q_id, *ring_fd;
> +
> +	bpf_trace_printk(fmt2, sizeof(fmt2));
> +	ring_fd = bpf_map_lookup_elem(&uring_fd_map, &q_id);
> +	if (ring_fd) {
> +		bpf_trace_printk(fmt, sizeof(fmt), qid, skey->tag);
> +		bpf_ublk_queue_sqe(ctx, sqe, 128, *ring_fd);
> +		bpf_map_delete_elem(map, key);
> +	}
> +	return 0;
> +}
> +*/
> +
> +static inline __u64 build_user_data(unsigned tag, unsigned op,
> +			unsigned tgt_data, unsigned is_target_io,
> +			unsigned is_bpf_io)
> +{
> +	return tag | (op << 16) | (tgt_data << 24) | (__u64)is_target_io << 63 |
> +		(__u64)is_bpf_io << 60;
> +}
> +
> +SEC("ublk.s/")
> +int ublk_io_prep_prog(struct ublk_bpf_ctx *ctx)
> +{
> +	struct io_uring_sqe *sqe;
> +	struct sqe_data sd = {0};
> +	struct sqe_key key;
> +	u16 q_id = ctx->q_id;
> +	u8 op; // = ctx->op;
> +	u32 nr_sectors = ctx->nr_sectors;
> +	u64 start_sector = ctx->start_sector;
> +	char fmt_1[] ="ublk_io_prep_prog %d %d\n";
> +
> +	key.q_id = ctx->q_id;
> +	key.tag = ctx->tag;
> +	key.offset = 0;
> +	key.res = 0;
> +
> +	bpf_probe_read_kernel(&op, 1, &ctx->op);
> +	bpf_trace_printk(fmt_1, sizeof(fmt_1), q_id, op);
> +	sqe = (struct io_uring_sqe *)&sd;
> +	if (op == REQ_OP_READ) {
> +		char fmt[] ="add read sae\n";
> +
> +		bpf_trace_printk(fmt, sizeof(fmt));
> +		io_uring_prep_read(sqe, target_fd, 0, nr_sectors << 9,
> +				   start_sector << 9);
> +		sqe->user_data = build_user_data(ctx->tag, op, 0, 1, 1);
> +		bpf_map_update_elem(&sqes_map, &key, &sd, BPF_NOEXIST);
> +	} else if (op == REQ_OP_WRITE) {
> +		char fmt[] ="add write sae\n";
> +
> +		bpf_trace_printk(fmt, sizeof(fmt));
> +
> +		io_uring_prep_write(sqe, target_fd, 0, nr_sectors << 9,
> +				    start_sector << 9);
> +		sqe->user_data = build_user_data(ctx->tag, op, 0, 1, 1);
> +		bpf_map_update_elem(&sqes_map, &key, &sd, BPF_NOEXIST);
> +	} else {
> +		;
> +	}
> +	return 0;
> +}
> +
> +SEC("ublk.s/")
> +int ublk_io_submit_prog(struct ublk_bpf_ctx *ctx)
> +{
> +	struct io_uring_sqe *sqe;
> +	char fmt[] ="submit sqe for req[qid:%u tag:%u]\n";
> +	int q_id = ctx->q_id, *ring_fd;
> +	struct sqe_key key;
> +
> +	key.q_id = ctx->q_id;
> +	key.tag = ctx->tag;
> +	key.offset = 0;
> +	key.res = 0;
> +
> +	sqe = bpf_map_lookup_elem(&sqes_map, &key);
> +	ring_fd = bpf_map_lookup_elem(&uring_fd_map, &q_id);
> +	if (ring_fd) {
> +		bpf_trace_printk(fmt, sizeof(fmt), key.q_id, key.tag);
> +		bpf_ublk_queue_sqe(ctx, sqe, 128, *ring_fd);
> +		bpf_map_delete_elem(&sqes_map, &key);
> +	}
> +	return 0;
> +}
> +
> +char LICENSE[] SEC("license") = "GPL";
> diff --git a/include/ublk_cmd.h b/include/ublk_cmd.h
> index f6238cc..893ba8c 100644
> --- a/include/ublk_cmd.h
> +++ b/include/ublk_cmd.h
> @@ -17,6 +17,8 @@
>  #define	UBLK_CMD_STOP_DEV	0x07
>  #define	UBLK_CMD_SET_PARAMS	0x08
>  #define	UBLK_CMD_GET_PARAMS	0x09
> +#define UBLK_CMD_REG_BPF_PROG		0x0a
> +#define UBLK_CMD_UNREG_BPF_PROG		0x0b
>  #define	UBLK_CMD_START_USER_RECOVERY	0x10
>  #define	UBLK_CMD_END_USER_RECOVERY	0x11
>  #define	UBLK_CMD_GET_DEV_INFO2		0x12
> diff --git a/include/ublksrv.h b/include/ublksrv.h
> index d38bd46..f5deddb 100644
> --- a/include/ublksrv.h
> +++ b/include/ublksrv.h
> @@ -106,6 +106,7 @@ struct ublksrv_tgt_info {
>  	unsigned int nr_fds;
>  	int fds[UBLKSRV_TGT_MAX_FDS];
>  	void *tgt_data;
> +	void *tgt_bpf_obj;
>  
>  	/*
>  	 * Extra IO slots for each queue, target code can reserve some
> @@ -263,6 +264,8 @@ struct ublksrv_tgt_type {
>  	int (*init_queue)(const struct ublksrv_queue *, void **queue_data_ptr);
>  	void (*deinit_queue)(const struct ublksrv_queue *);
>  
> +	int (*init_queue_bpf)(const struct ublksrv_dev *dev, const struct ublksrv_queue *q);
> +
>  	unsigned long reserved[5];
>  };
>  
> @@ -318,6 +321,11 @@ extern void ublksrv_ctrl_prep_recovery(struct ublksrv_ctrl_dev *dev,
>  		const char *recovery_jbuf);
>  extern const char *ublksrv_ctrl_get_recovery_jbuf(const struct ublksrv_ctrl_dev *dev);
>  
> +extern void ublksrv_ctrl_set_bpf_obj_info(struct ublksrv_ctrl_dev *dev,
> +					  void *obj);
> +extern int ublksrv_ctrl_reg_bpf_prog(struct ublksrv_ctrl_dev *dev,
> +				     int io_prep_fd, int io_submit_fd);
> +
>  /* ublksrv device ("/dev/ublkcN") level APIs */
>  extern const struct ublksrv_dev *ublksrv_dev_init(const struct ublksrv_ctrl_dev *
>  		ctrl_dev);
> diff --git a/include/ublksrv_priv.h b/include/ublksrv_priv.h
> index 2996baa..8da8866 100644
> --- a/include/ublksrv_priv.h
> +++ b/include/ublksrv_priv.h
> @@ -42,6 +42,7 @@ struct ublksrv_ctrl_dev {
>  
>  	const char *tgt_type;
>  	const struct ublksrv_tgt_type *tgt_ops;
> +	void *bpf_obj;
>  
>  	/*
>  	 * default is UBLKSRV_RUN_DIR but can be specified via command line,
> diff --git a/include/ublksrv_tgt.h b/include/ublksrv_tgt.h
> index 234d31e..e0db7d9 100644
> --- a/include/ublksrv_tgt.h
> +++ b/include/ublksrv_tgt.h
> @@ -9,6 +9,7 @@
>  #include <getopt.h>
>  #include <string.h>
>  #include <stdarg.h>
> +#include <limits.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <sys/ioctl.h>
> diff --git a/lib/ublksrv.c b/lib/ublksrv.c
> index 96bed95..110ccb3 100644
> --- a/lib/ublksrv.c
> +++ b/lib/ublksrv.c
> @@ -603,6 +603,9 @@ skip_alloc_buf:
>  		goto fail;
>  	}
>  
> +	if (dev->tgt.ops->init_queue_bpf)
> +		dev->tgt.ops->init_queue_bpf(tdev, local_to_tq(q));
> +
>  	ublksrv_dev_init_io_cmds(dev, q);
>  
>  	/*
> @@ -723,6 +726,7 @@ const struct ublksrv_dev *ublksrv_dev_init(const struct ublksrv_ctrl_dev *ctrl_d
>  	}
>  
>  	tgt->fds[0] = dev->cdev_fd;
> +	tgt->tgt_bpf_obj = ctrl_dev->bpf_obj;
>  
>  	ret = ublksrv_tgt_init(dev, ctrl_dev->tgt_type, ctrl_dev->tgt_ops,
>  			ctrl_dev->tgt_argc, ctrl_dev->tgt_argv);
> diff --git a/lib/ublksrv_cmd.c b/lib/ublksrv_cmd.c
> index 0d7265d..0101cb9 100644
> --- a/lib/ublksrv_cmd.c
> +++ b/lib/ublksrv_cmd.c
> @@ -502,6 +502,27 @@ int ublksrv_ctrl_end_recovery(struct ublksrv_ctrl_dev *dev, int daemon_pid)
>  	return ret;
>  }
>  
> +int ublksrv_ctrl_reg_bpf_prog(struct ublksrv_ctrl_dev *dev,
> +			      int io_prep_fd, int io_submit_fd)
> +{
> +	struct ublksrv_ctrl_cmd_data data = {
> +		.cmd_op = UBLK_CMD_REG_BPF_PROG,
> +		.flags = CTRL_CMD_HAS_DATA,
> +	};
> +	int ret;
> +
> +	data.data[0] = io_prep_fd;
> +	data.data[1] = io_submit_fd;
> +
> +	ret = __ublksrv_ctrl_cmd(dev, &data);
> +	return ret;
> +}
> +
> +void ublksrv_ctrl_set_bpf_obj_info(struct ublksrv_ctrl_dev *dev,  void *obj)
> +{
> +	dev->bpf_obj = obj;
> +}
> +
>  const struct ublksrv_ctrl_dev_info *ublksrv_ctrl_get_dev_info(
>  		const struct ublksrv_ctrl_dev *dev)
>  {
> diff --git a/tgt_loop.cpp b/tgt_loop.cpp
> index 79a65d3..b1568fe 100644
> --- a/tgt_loop.cpp
> +++ b/tgt_loop.cpp
> @@ -4,7 +4,11 @@
>  
>  #include <poll.h>
>  #include <sys/epoll.h>
> +#include <linux/bpf.h>
> +#include <bpf/bpf.h>
> +#include <bpf/libbpf.h>
>  #include "ublksrv_tgt.h"
> +#include "bpf/.tmp/ublk.skel.h"

Where is bpf/.tmp/ublk.skel.h?

>  
>  static bool backing_supports_discard(char *name)
>  {
> @@ -88,6 +92,20 @@ static int loop_recovery_tgt(struct ublksrv_dev *dev, int type)
>  	return 0;
>  }
>  
> +static int loop_init_queue_bpf(const struct ublksrv_dev *dev,
> +			       const struct ublksrv_queue *q)
> +{
> +	int ret, q_id, ring_fd;
> +	const struct ublksrv_tgt_info *tgt = &dev->tgt;
> +	struct ublk_bpf *obj = (struct ublk_bpf*)tgt->tgt_bpf_obj;
> +
> +	q_id = q->q_id;
> +	ring_fd = q->ring_ptr->ring_fd;
> +	ret = bpf_map_update_elem(bpf_map__fd(obj->maps.uring_fd_map), &q_id,
> +				  &ring_fd,  0);
> +	return ret;
> +}
> +
>  static int loop_init_tgt(struct ublksrv_dev *dev, int type, int argc, char
>  		*argv[])
>  {
> @@ -125,6 +143,7 @@ static int loop_init_tgt(struct ublksrv_dev *dev, int type, int argc, char
>  		},
>  	};
>  	bool can_discard = false;
> +	struct ublk_bpf *bpf_obj;
>  
>  	strcpy(tgt_json.name, "loop");
>  
> @@ -218,6 +237,10 @@ static int loop_init_tgt(struct ublksrv_dev *dev, int type, int argc, char
>  			jbuf = ublksrv_tgt_realloc_json_buf(dev, &jbuf_size);
>  	} while (ret < 0);
>  
> +	if (tgt->tgt_bpf_obj) {
> +		bpf_obj = (struct ublk_bpf *)tgt->tgt_bpf_obj;
> +		bpf_obj->data->target_fd = tgt->fds[1];
> +	}
>  	return 0;
>  }
>  
> @@ -252,9 +275,14 @@ static int loop_queue_tgt_io(const struct ublksrv_queue *q,
>  		const struct ublk_io_data *data, int tag)
>  {
>  	const struct ublksrv_io_desc *iod = data->iod;
> -	struct io_uring_sqe *sqe = io_uring_get_sqe(q->ring_ptr);
> +	struct io_uring_sqe *sqe;
>  	unsigned ublk_op = ublksrv_get_op(iod);
>  
> +	/* ebpf prog wil handle read/write requests. */
> +	if ((ublk_op == UBLK_IO_OP_READ) || (ublk_op == UBLK_IO_OP_WRITE))
> +		return 1;
> +
> +	sqe = io_uring_get_sqe(q->ring_ptr);
>  	if (!sqe)
>  		return 0;
>  
> @@ -374,6 +402,7 @@ struct ublksrv_tgt_type  loop_tgt_type = {
>  	.type	= UBLKSRV_TGT_TYPE_LOOP,
>  	.name	=  "loop",
>  	.recovery_tgt = loop_recovery_tgt,
> +	.init_queue_bpf = loop_init_queue_bpf,
>  };
>  
>  static void tgt_loop_init() __attribute__((constructor));
> diff --git a/ublksrv_tgt.cpp b/ublksrv_tgt.cpp
> index 5ed328d..d3796cf 100644
> --- a/ublksrv_tgt.cpp
> +++ b/ublksrv_tgt.cpp
> @@ -2,6 +2,7 @@
>  
>  #include "config.h"
>  #include "ublksrv_tgt.h"
> +#include "bpf/.tmp/ublk.skel.h"

Same with above


Thanks, 
Ming

