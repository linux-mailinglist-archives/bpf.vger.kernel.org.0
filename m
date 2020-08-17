Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90FA024683F
	for <lists+bpf@lfdr.de>; Mon, 17 Aug 2020 16:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgHQOSk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Aug 2020 10:18:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47142 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728774AbgHQOSi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Aug 2020 10:18:38 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07HECSnb038967;
        Mon, 17 Aug 2020 14:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=L7zEDgtkVyvC/Q8YX9CjmxluRLc1B/KNEzcsJ0hCqYk=;
 b=bPXYRcz/XdWXJn+qeRUx7mqXdoTSdOrj/UN9HD2OpnaqNoVRspalBDRTnp3iRnEjRae0
 W2obyXlbpRINAKR7hKGDuTvWhPP2rsscSTybtRgeAGP3Ok6wva1tuJ5DpYSa6Ui3e37C
 cmshZErjUduXtEdfsyKPVQE0obHT2jKt1VJXtEA1C+AztiHUmJCg6pMFAUYzxt9SPrbC
 JhCWfdwSklg5OcWSP1MC8AHWsUUS1HReafaByZtbczb9mIgsCbTgWnSzBVKNr2hm9cSd
 iDUNDPFhX1fNoO97lYbsrxOXdpRhNELbQ2R7F3wWEbDZ2TXAAltSSVERF+rfVnMam7s0 Gg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 32x74qy5bv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Aug 2020 14:18:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07HEDhlV131707;
        Mon, 17 Aug 2020 14:18:29 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 32xsm06esp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Aug 2020 14:18:29 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07HEIRW4007043;
        Mon, 17 Aug 2020 14:18:27 GMT
Received: from [192.168.1.8] (/180.165.80.125)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Aug 2020 07:18:26 -0700
Subject: Re: [RFC PATCH 1/4] bpf: add new prog_type BPF_PROG_TYPE_IO_FILTER
To:     Leah Rumancik <leah.rumancik@gmail.com>, bpf@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     orbekk@google.com, harshads@google.com, jasiu@google.com,
        saranyamohan@google.com, tytso@google.com, bvanassche@google.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20200812163305.545447-1-leah.rumancik@gmail.com>
 <20200812163305.545447-2-leah.rumancik@gmail.com>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <a0a97488-58c7-1f00-c987-d75e1329159c@oracle.com>
Date:   Mon, 17 Aug 2020 22:18:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200812163305.545447-2-leah.rumancik@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9715 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=2
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008170109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9715 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=2 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008170109
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/13/20 12:33 AM, Leah Rumancik wrote:
> Introducing a new program type BPF_PROG_TYPE_IO_FILTER and a new
> attach type BPF_BIO_SUBMIT.
> 

Nice work!

> This program type is intended to help filter and monitor IO requests.
> 

I was also working on similar tasks.

> Co-developed-by: Saranya Muruganandam <saranyamohan@google.com>
> Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
> Signed-off-by: Kjetil Ørbekk <orbekk@google.com>
> Signed-off-by: Harshad Shirwadkar <harshads@google.com>
> Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> ---
>  block/Makefile                                |   1 +
>  block/blk-bpf-io-filter.c                     | 209 ++++++++++++++++++
>  block/blk-bpf-io-filter.h                     |  16 ++
>  block/blk-core.c                              |   6 +
>  block/genhd.c                                 |   3 +
>  include/linux/bpf_io_filter.h                 |  23 ++
>  include/linux/bpf_types.h                     |   4 +
>  include/linux/genhd.h                         |   4 +
>  include/uapi/linux/bpf.h                      |  11 +
>  init/Kconfig                                  |   8 +
>  kernel/bpf/syscall.c                          |   9 +
>  kernel/bpf/verifier.c                         |   1 +
>  tools/bpf/bpftool/feature.c                   |   2 +
>  tools/bpf/bpftool/main.h                      |   2 +
>  tools/include/uapi/linux/bpf.h                |  11 +
>  tools/lib/bpf/libbpf.c                        |   2 +
>  tools/lib/bpf/libbpf_probes.c                 |   1 +
>  .../selftests/bpf/prog_tests/section_names.c  |   5 +
>  18 files changed, 318 insertions(+)
>  create mode 100644 block/blk-bpf-io-filter.c
>  create mode 100644 block/blk-bpf-io-filter.h
>  create mode 100644 include/linux/bpf_io_filter.h
> 

It would be better to review if this changes can be separated to small patches.

> diff --git a/block/Makefile b/block/Makefile
> index 78719169fb2a..358ace8002cd 100644
> --- a/block/Makefile
> +++ b/block/Makefile
> @@ -38,3 +38,4 @@ obj-$(CONFIG_BLK_SED_OPAL)	+= sed-opal.o
>  obj-$(CONFIG_BLK_PM)		+= blk-pm.o
>  obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= keyslot-manager.o blk-crypto.o
>  obj-$(CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK)	+= blk-crypto-fallback.o
> +obj-$(CONFIG_BPF_IO_FILTER) += blk-bpf-io-filter.o
> diff --git a/block/blk-bpf-io-filter.c b/block/blk-bpf-io-filter.c
> new file mode 100644
> index 000000000000..453d6b156bd2
> --- /dev/null
> +++ b/block/blk-bpf-io-filter.c
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf_io_filter.h>
> +
> +#include <linux/bpf.h>
> +#include <linux/bpf_trace.h>
> +#include <linux/filter.h>
> +#include <linux/kallsyms.h>
> +#include <linux/bpf_verifier.h>
> +#include <linux/kobject.h>
> +#include <linux/sysfs.h>
> +#include <linux/genhd.h>
> +#include <uapi/linux/bpf.h>
> +#include <linux/bio.h>
> +
> +#include "blk-bpf-io-filter.h"
> +
> +#define io_filter_rcu_dereference_progs(disk)	\
> +	rcu_dereference_protected(disk->progs, lockdep_is_held(&disk->io_filter_lock))
> +
> +static const struct bpf_func_proto *
> +io_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> +{
> +	switch (func_id) {
> +	case BPF_FUNC_map_lookup_elem:
> +		return &bpf_map_lookup_elem_proto;
> +	case BPF_FUNC_map_update_elem:
> +		return &bpf_map_update_elem_proto;
> +	case BPF_FUNC_map_delete_elem:
> +		return &bpf_map_delete_elem_proto;
> +	case BPF_FUNC_map_push_elem:
> +		return &bpf_map_push_elem_proto;
> +	case BPF_FUNC_map_pop_elem:
> +		return &bpf_map_pop_elem_proto;
> +	case BPF_FUNC_map_peek_elem:
> +		return &bpf_map_peek_elem_proto;
> +	case BPF_FUNC_trace_printk:
> +		if (capable(CAP_SYS_ADMIN))
> +			return bpf_get_trace_printk_proto();
> +		fallthrough;
> +	default:
> +		return NULL;
> +	}
> +}
> +
> +const struct bpf_prog_ops io_filter_prog_ops = {
> +};
> +
> +static bool io_filter_is_valid_access(int off, int size,
> +				      enum bpf_access_type type,
> +				      const struct bpf_prog *prog,
> +				      struct bpf_insn_access_aux *info)
> +{
> +	const __u32 size_default = sizeof(__u32);
> +
> +	if (type != BPF_READ)
> +		return false;
> +
> +	if (off < 0 || off >= offsetofend(struct bpf_io_request, opf))
> +		return false;
> +
> +	if (off % size != 0)
> +		return false;
> +
> +	switch (off) {
> +	case offsetof(struct bpf_io_request, sector_start):
> +		return size == sizeof(__u64);
> +	case offsetof(struct bpf_io_request, sector_cnt):
> +		return size == sizeof(__u32);
> +	case bpf_ctx_range(struct bpf_io_request, opf):
> +		bpf_ctx_record_field_size(info, size_default);
> +		return bpf_ctx_narrow_access_ok(off, size, size_default);
> +	default:
> +		return false;
> +	}
> +}
> +
> +const struct bpf_verifier_ops io_filter_verifier_ops = {
> +	.get_func_proto = io_filter_func_proto,
> +	.is_valid_access = io_filter_is_valid_access,
> +};
> +
> +#define BPF_MAX_PROGS 64
> +
> +int io_filter_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> +{
> +	struct gendisk *disk;
> +	struct fd f;
> +	struct bpf_prog_array *old_array;
> +	struct bpf_prog_array *new_array;
> +	int ret;
> +
> +	if (attr->attach_flags)
> +		return -EINVAL;
> +
> +	f = fdget(attr->target_fd);
> +	if (!f.file)
> +		return -EBADF;
> +
> +	disk = I_BDEV(f.file->f_mapping->host)->bd_disk;
> +	if (disk == NULL)
> +		return -ENXIO;
> +
> +	ret = mutex_lock_interruptible(&disk->io_filter_lock);
> +	if (ret)
> +		return ret;
> +
> +	old_array = io_filter_rcu_dereference_progs(disk);
> +	if (old_array && bpf_prog_array_length(old_array) >= BPF_MAX_PROGS) {
> +		ret = -E2BIG;
> +		goto unlock;
> +	}
> +
> +	ret = bpf_prog_array_copy(old_array, NULL, prog, &new_array);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	rcu_assign_pointer(disk->progs, new_array);
> +	bpf_prog_array_free(old_array);
> +
> +unlock:
> +	mutex_unlock(&disk->io_filter_lock);
> +	return ret;
> +}
> +
> +int io_filter_prog_detach(const union bpf_attr *attr)
> +{
> +	struct bpf_prog *prog;
> +	struct gendisk *disk;
> +	struct fd f;
> +	struct bpf_prog_array *old_array;
> +	struct bpf_prog_array *new_array;
> +	int ret;
> +
> +	if (attr->attach_flags)
> +		return -EINVAL;
> +
> +	/* increments prog refcnt */
> +	prog = bpf_prog_get_type(attr->attach_bpf_fd,
> +				 BPF_PROG_TYPE_IO_FILTER);
> +
> +	if (IS_ERR(prog))
> +		return PTR_ERR(prog);
> +
> +	f = fdget(attr->target_fd);
> +	if (!f.file) {
> +		ret = -EBADF;
> +		goto put;
> +	}
> +
> +	disk  = I_BDEV(f.file->f_mapping->host)->bd_disk;
> +	if (disk == NULL) {
> +		ret = -ENXIO;
> +		goto put;
> +	}
> +
> +	ret = mutex_lock_interruptible(&disk->io_filter_lock);
> +	if (ret)
> +		goto put;
> +
> +	old_array = io_filter_rcu_dereference_progs(disk);
> +	ret = bpf_prog_array_copy(old_array, prog, NULL, &new_array);
> +	if (ret)
> +		goto unlock;
> +
> +	rcu_assign_pointer(disk->progs, new_array);
> +	bpf_prog_array_free(old_array);
> +	bpf_prog_put(prog);	/* put for detaching of program from dev */
> +
> +unlock:
> +	mutex_unlock(&disk->io_filter_lock);
> +put:
> +	bpf_prog_put(prog);	/* put for bpf_prog_get_type */
> +	return ret;
> +}
> +
> +/* allows IO by default if no programs attached */
> +int io_filter_bpf_run(struct bio *bio)
> +{
> +	struct bpf_io_request io_req = {
> +		.sector_start = bio->bi_iter.bi_sector,
> +		.sector_cnt = bio_sectors(bio),
> +		.opf = bio->bi_opf,
> +	};
> +
> +	return BPF_PROG_RUN_ARRAY_CHECK(bio->bi_disk->progs, &io_req, BPF_PROG_RUN);


I think pass "struct bpf_io_request" is not enough, since we may want to do the filter based on
some special patterns against the io data.

I used to pass "page_to_virt(bio->bi_io_vec->bv_page)" into ebpf program..

Regards,
Bob

> +}
> +
> +void io_filter_bpf_init(struct gendisk *disk)
> +{
> +	mutex_init(&disk->io_filter_lock);
> +}
> +
> +void io_filter_bpf_free(struct gendisk *disk)
> +{
> +	struct bpf_prog_array_item *item;
> +	struct bpf_prog_array *array;
> +
> +	mutex_destroy(&disk->io_filter_lock);
> +
> +	array = io_filter_rcu_dereference_progs(disk);
> +	if (!array)
> +		return;
> +
> +	for (item = array->items; item->prog; item++)
> +		bpf_prog_put(item->prog);
> +
> +	bpf_prog_array_free(array);
> +}
> diff --git a/block/blk-bpf-io-filter.h b/block/blk-bpf-io-filter.h
> new file mode 100644
> index 000000000000..cca705c4659e
> --- /dev/null
> +++ b/block/blk-bpf-io-filter.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _BLK_BPF_IO_FILTER
> +#define _BLK_BPF_IO_FILTER
> +
> +#ifdef CONFIG_BPF_IO_FILTER
> +void io_filter_bpf_init(struct gendisk *disk);
> +void io_filter_bpf_free(struct gendisk *disk);
> +int io_filter_bpf_run(struct bio *bio);
> +#else
> +static inline void io_filter_bpf_init(struct gendisk *disk) { }
> +static inline void io_filter_bpf_free(struct gendisk *disk) { }
> +static inline int io_filter_bpf_run(struct bio *bio) { return IO_ALLOW; }
> +#endif
> +
> +#endif	/* _BLK_BPF_IO_FILTER */
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 03252af8c82c..740ac4807f41 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -50,6 +50,7 @@
>  #include "blk-mq-sched.h"
>  #include "blk-pm.h"
>  #include "blk-rq-qos.h"
> +#include "blk-bpf-io-filter.h"
>  
>  #ifdef CONFIG_DEBUG_FS
>  struct dentry *blk_debugfs_root;
> @@ -1005,6 +1006,11 @@ generic_make_request_checks(struct bio *bio)
>  		}
>  	}
>  
> +	if (!io_filter_bpf_run(bio)) {
> +		status = BLK_STS_PROTECTION;
> +		goto end_io;
> +	}
> +
>  	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
>  		bio->bi_opf &= ~REQ_HIPRI;
>  
> diff --git a/block/genhd.c b/block/genhd.c
> index 1a7659327664..cff346c78ec6 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -25,6 +25,7 @@
>  #include <linux/badblocks.h>
>  
>  #include "blk.h"
> +#include "blk-bpf-io-filter.h"
>  
>  static DEFINE_MUTEX(block_class_lock);
>  static struct kobject *block_depr;
> @@ -935,6 +936,7 @@ void del_gendisk(struct gendisk *disk)
>  	if (!sysfs_deprecated)
>  		sysfs_remove_link(block_depr, dev_name(disk_to_dev(disk)));
>  	pm_runtime_set_memalloc_noio(disk_to_dev(disk), false);
> +	io_filter_bpf_free(disk);
>  	device_del(disk_to_dev(disk));
>  }
>  EXPORT_SYMBOL(del_gendisk);
> @@ -1719,6 +1721,7 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
>  
>  		disk->minors = minors;
>  		rand_initialize_disk(disk);
> +		io_filter_bpf_init(disk);
>  		disk_to_dev(disk)->class = &block_class;
>  		disk_to_dev(disk)->type = &disk_type;
>  		device_initialize(disk_to_dev(disk));
> diff --git a/include/linux/bpf_io_filter.h b/include/linux/bpf_io_filter.h
> new file mode 100644
> index 000000000000..6f8a3da963ed
> --- /dev/null
> +++ b/include/linux/bpf_io_filter.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _BPF_IO_FILTER_H
> +#define _BPF_IO_FILTER_H
> +
> +#include <uapi/linux/bpf.h>
> +struct bpf_prog;
> +
> +#ifdef CONFIG_BPF_IO_FILTER
> +int io_filter_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog);
> +int io_filter_prog_detach(const union bpf_attr *attr);
> +#else
> +static inline int io_filter_prog_attach(const union bpf_attr *attr,
> +					struct bpf_prog *prog)
> +{
> +	return -EINVAL;
> +}
> +static inline int io_filter_prog_detach(const union bpf_attr *attr)
> +{
> +	return -EINVAL;
> +}
> +#endif
> +#endif /* _BPF_IO_FILTER_H */
> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> index a18ae82a298a..f05193a2756e 100644
> --- a/include/linux/bpf_types.h
> +++ b/include/linux/bpf_types.h
> @@ -49,6 +49,10 @@ BPF_PROG_TYPE(BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE, raw_tracepoint_writable,
>  BPF_PROG_TYPE(BPF_PROG_TYPE_TRACING, tracing,
>  	      void *, void *)
>  #endif
> +#ifdef CONFIG_BPF_IO_FILTER
> +BPF_PROG_TYPE(BPF_PROG_TYPE_IO_FILTER, io_filter,
> +	      struct bpf_io_request, struct bpf_io_request)
> +#endif
>  #ifdef CONFIG_CGROUP_BPF
>  BPF_PROG_TYPE(BPF_PROG_TYPE_CGROUP_DEVICE, cg_dev,
>  	      struct bpf_cgroup_dev_ctx, struct bpf_cgroup_dev_ctx)
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index 392aad5e29a2..2da2cb1d0c46 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -209,6 +209,10 @@ struct gendisk {
>  	int node_id;
>  	struct badblocks *bb;
>  	struct lockdep_map lockdep_map;
> +#ifdef CONFIG_BPF_IO_FILTER
> +	struct bpf_prog_array __rcu *progs;
> +	struct mutex io_filter_lock;
> +#endif
>  };
>  
>  #if IS_REACHABLE(CONFIG_CDROM)
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 8bd33050b7bb..4f84ab93d82c 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -189,6 +189,7 @@ enum bpf_prog_type {
>  	BPF_PROG_TYPE_STRUCT_OPS,
>  	BPF_PROG_TYPE_EXT,
>  	BPF_PROG_TYPE_LSM,
> +	BPF_PROG_TYPE_IO_FILTER,
>  };
>  
>  enum bpf_attach_type {
> @@ -226,6 +227,7 @@ enum bpf_attach_type {
>  	BPF_CGROUP_INET4_GETSOCKNAME,
>  	BPF_CGROUP_INET6_GETSOCKNAME,
>  	BPF_XDP_DEVMAP,
> +	BPF_BIO_SUBMIT,
>  	__MAX_BPF_ATTACH_TYPE
>  };
>  
> @@ -4261,4 +4263,13 @@ struct bpf_pidns_info {
>  	__u32 pid;
>  	__u32 tgid;
>  };
> +
> +#define IO_ALLOW 1
> +#define IO_BLOCK 0
> +
> +struct bpf_io_request {
> +	__u64 sector_start;	/* first sector */
> +	__u32 sector_cnt;	/* number of sectors */
> +	__u32 opf;		/* bio->bi_opf */
> +};
>  #endif /* _UAPI__LINUX_BPF_H__ */
> diff --git a/init/Kconfig b/init/Kconfig
> index 0498af567f70..f44de091757e 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1647,6 +1647,14 @@ config KALLSYMS_BASE_RELATIVE
>  
>  # syscall, maps, verifier
>  
> +config BPF_IO_FILTER
> +	bool "Instrumentation of block io filtering subsystem with BPF"
> +	depends on BPF_EVENTS
> +	depends on BPF_SYSCALL
> +	help
> +	  Enables instrumentation of the hooks in block subsystem with eBPF
> +	  programs for observing and filtering io.
> +
>  config BPF_LSM
>  	bool "LSM Instrumentation with BPF"
>  	depends on BPF_EVENTS
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 0fd80ac81f70..179c37efe8e2 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -29,6 +29,7 @@
>  #include <linux/bpf_lsm.h>
>  #include <linux/poll.h>
>  #include <linux/bpf-netns.h>
> +#include <linux/bpf_io_filter.h>
>  
>  #define IS_FD_ARRAY(map) ((map)->map_type == BPF_MAP_TYPE_PERF_EVENT_ARRAY || \
>  			  (map)->map_type == BPF_MAP_TYPE_CGROUP_ARRAY || \
> @@ -1964,6 +1965,7 @@ bpf_prog_load_check_attach(enum bpf_prog_type prog_type,
>  
>  		switch (prog_type) {
>  		case BPF_PROG_TYPE_TRACING:
> +		case BPF_PROG_TYPE_IO_FILTER:
>  		case BPF_PROG_TYPE_LSM:
>  		case BPF_PROG_TYPE_STRUCT_OPS:
>  		case BPF_PROG_TYPE_EXT:
> @@ -2815,6 +2817,8 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
>  		return BPF_PROG_TYPE_CGROUP_SOCKOPT;
>  	case BPF_TRACE_ITER:
>  		return BPF_PROG_TYPE_TRACING;
> +	case BPF_BIO_SUBMIT:
> +		return BPF_PROG_TYPE_IO_FILTER;
>  	default:
>  		return BPF_PROG_TYPE_UNSPEC;
>  	}
> @@ -2858,6 +2862,9 @@ static int bpf_prog_attach(const union bpf_attr *attr)
>  	case BPF_PROG_TYPE_LIRC_MODE2:
>  		ret = lirc_prog_attach(attr, prog);
>  		break;
> +	case BPF_PROG_TYPE_IO_FILTER:
> +		ret = io_filter_prog_attach(attr, prog);
> +		break;
>  	case BPF_PROG_TYPE_FLOW_DISSECTOR:
>  		ret = netns_bpf_prog_attach(attr, prog);
>  		break;
> @@ -2906,6 +2913,8 @@ static int bpf_prog_detach(const union bpf_attr *attr)
>  	case BPF_PROG_TYPE_CGROUP_SYSCTL:
>  	case BPF_PROG_TYPE_SOCK_OPS:
>  		return cgroup_bpf_prog_detach(attr, ptype);
> +	case BPF_PROG_TYPE_IO_FILTER:
> +		return io_filter_prog_detach(attr);
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 94cead5a43e5..71372e99a722 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2613,6 +2613,7 @@ static bool may_access_direct_pkt_data(struct bpf_verifier_env *env,
>  	case BPF_PROG_TYPE_LWT_SEG6LOCAL:
>  	case BPF_PROG_TYPE_SK_REUSEPORT:
>  	case BPF_PROG_TYPE_FLOW_DISSECTOR:
> +	case BPF_PROG_TYPE_IO_FILTER:
>  	case BPF_PROG_TYPE_CGROUP_SKB:
>  		if (t == BPF_WRITE)
>  			return false;
> diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
> index 768bf77df886..765702ae0189 100644
> --- a/tools/bpf/bpftool/feature.c
> +++ b/tools/bpf/bpftool/feature.c
> @@ -383,6 +383,8 @@ static void probe_kernel_image_config(const char *define_prefix)
>  		{ "CONFIG_IPV6_SEG6_BPF", },
>  		/* BPF_PROG_TYPE_LIRC_MODE2 and related helpers */
>  		{ "CONFIG_BPF_LIRC_MODE2", },
> +		/* BPF_PROG_TYPE_IO_FILTER */
> +		{ "CONFIG_BPF_IO_FILTER", },
>  		/* BPF stream parser and BPF socket maps */
>  		{ "CONFIG_BPF_STREAM_PARSER", },
>  		/* xt_bpf module for passing BPF programs to netfilter  */
> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
> index 5cdf0bc049bd..0607ae6f6d90 100644
> --- a/tools/bpf/bpftool/main.h
> +++ b/tools/bpf/bpftool/main.h
> @@ -86,6 +86,7 @@ static const char * const prog_type_name[] = {
>  	[BPF_PROG_TYPE_TRACING]			= "tracing",
>  	[BPF_PROG_TYPE_STRUCT_OPS]		= "struct_ops",
>  	[BPF_PROG_TYPE_EXT]			= "ext",
> +	[BPF_PROG_TYPE_IO_FILTER]		= "io_filter",
>  };
>  
>  static const char * const attach_type_name[__MAX_BPF_ATTACH_TYPE] = {
> @@ -122,6 +123,7 @@ static const char * const attach_type_name[__MAX_BPF_ATTACH_TYPE] = {
>  	[BPF_TRACE_FEXIT] = "fexit",
>  	[BPF_MODIFY_RETURN] = "mod_ret",
>  	[BPF_LSM_MAC] = "lsm_mac",
> +	[BPF_BIO_SUBMIT] = "bio_submit",
>  };
>  
>  extern const char * const map_type_name[];
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 8bd33050b7bb..f665e37b7277 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -189,6 +189,7 @@ enum bpf_prog_type {
>  	BPF_PROG_TYPE_STRUCT_OPS,
>  	BPF_PROG_TYPE_EXT,
>  	BPF_PROG_TYPE_LSM,
> +	BPF_PROG_TYPE_IO_FILTER,
>  };
>  
>  enum bpf_attach_type {
> @@ -226,6 +227,7 @@ enum bpf_attach_type {
>  	BPF_CGROUP_INET4_GETSOCKNAME,
>  	BPF_CGROUP_INET6_GETSOCKNAME,
>  	BPF_XDP_DEVMAP,
> +	BPF_BIO_SUBMIT,
>  	__MAX_BPF_ATTACH_TYPE
>  };
>  
> @@ -4261,4 +4263,13 @@ struct bpf_pidns_info {
>  	__u32 pid;
>  	__u32 tgid;
>  };
> +
> +#define IO_ALLOW 1
> +#define IO_BLOCK 0
> +
> +struct bpf_io_request {
> +	__u64 sector_start;     /* first sector */
> +	__u32 sector_cnt;       /* number of sectors */
> +	__u32 opf;              /* bio->bi_opf */
> +};
>  #endif /* _UAPI__LINUX_BPF_H__ */
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 11e4725b8b1c..609b16007891 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -6724,6 +6724,8 @@ static const struct bpf_sec_def section_defs[] = {
>  	BPF_EAPROG_SEC("cgroup/setsockopt",	BPF_PROG_TYPE_CGROUP_SOCKOPT,
>  						BPF_CGROUP_SETSOCKOPT),
>  	BPF_PROG_SEC("struct_ops",		BPF_PROG_TYPE_STRUCT_OPS),
> +	BPF_APROG_SEC("io_filter",		BPF_PROG_TYPE_IO_FILTER,
> +						BPF_BIO_SUBMIT),
>  };
>  
>  #undef BPF_PROG_SEC_IMPL
> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
> index 10cd8d1891f5..b882b200a402 100644
> --- a/tools/lib/bpf/libbpf_probes.c
> +++ b/tools/lib/bpf/libbpf_probes.c
> @@ -109,6 +109,7 @@ probe_load(enum bpf_prog_type prog_type, const struct bpf_insn *insns,
>  	case BPF_PROG_TYPE_STRUCT_OPS:
>  	case BPF_PROG_TYPE_EXT:
>  	case BPF_PROG_TYPE_LSM:
> +	case BPF_PROG_TYPE_IO_FILTER:
>  	default:
>  		break;
>  	}
> diff --git a/tools/testing/selftests/bpf/prog_tests/section_names.c b/tools/testing/selftests/bpf/prog_tests/section_names.c
> index 713167449c98..ef6658a776b1 100644
> --- a/tools/testing/selftests/bpf/prog_tests/section_names.c
> +++ b/tools/testing/selftests/bpf/prog_tests/section_names.c
> @@ -158,6 +158,11 @@ static struct sec_name_test tests[] = {
>  		{0, BPF_PROG_TYPE_CGROUP_SOCKOPT, BPF_CGROUP_SETSOCKOPT},
>  		{0, BPF_CGROUP_SETSOCKOPT},
>  	},
> +	{
> +		"io_filter",
> +		{0, BPF_PROG_TYPE_IO_FILTER, BPF_BIO_SUBMIT},
> +		{0, BPF_BIO_SUBMIT},
> +	},
>  };
>  
>  static void test_prog_type_by_name(const struct sec_name_test *test)
> 

