Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622EE4CB274
	for <lists+bpf@lfdr.de>; Wed,  2 Mar 2022 23:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiCBWp5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 17:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiCBWp4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 17:45:56 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272F538D82;
        Wed,  2 Mar 2022 14:45:10 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id a5so3170577pfv.9;
        Wed, 02 Mar 2022 14:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bu1m8QE7xycjxrnGexY9vNyLC1cQoJ9MRpYoO3qPQyQ=;
        b=avOlyqO0PsKAkdGgIHP0gTDxTLboi2RcrN+BJNxNMCIerAZFFa81WUrORROdz7/omO
         nNzPM/rPve/tNk0ap4tR7su31RvrA9WKmBLhhBTQrYmBnnglQnbUMw9IhZZxYQLj7ESF
         QLXQ+dfnTQr9JJ6rjQgyjJ/cwDBB7K3PEB3F0/CMF75Mt9Rc+PNNT2Uebenqey020OP0
         A/+9Aqz6Xy7RRC4P+lN6tKKzlQ5uEtN1P693aNxkCa0iz4dEie/y8nHgXMkoL3B5WXl/
         XVgq4uw+IcMsKcH0KifSP6hCZkgt7jjU5DFbRB/ZFOENQTgttPUNt5U+A20Ee8zn4Crz
         HXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bu1m8QE7xycjxrnGexY9vNyLC1cQoJ9MRpYoO3qPQyQ=;
        b=svGa9fNADuYTd3m2i4lrp8cNUf7WxCQCLehEdHg4zvK/isHJi8VED8pGo+QrXRw8x3
         VP7wDE0SqUCmwsfUtqDhihU2WjaGMZM9N8dS9mDkuolWzObK5oSM+ia2FR4u++5nS+1O
         rGx3KG5wZ7Uq+j4kD8zKrpwHD3onGYhO0MoiEdaORBR2N+4QD70IWSNk4Xm8qLNdEOB3
         iUfYwyMryn7fPTyAN3v5bIvhk61DlQwHWBiesRpst+RIvQYGv9v+bDLvRyoOWRtKtOCx
         Qu84nWOAFHFh1wRcouON/seiTqpCmIKmQVJ/BaWZcIHGPjxkvfM3u1QemDZQgL6U2FHn
         GgvA==
X-Gm-Message-State: AOAM5302cC/iy7/t/15p4bDjlK7FAcUPZgjL4S8Bmt3syiXYF+xxk9zT
        TEQHOqOmm0dPaZSnc9PmaJY=
X-Google-Smtp-Source: ABdhPJwnD7avpCpK886IAUGLL7iydkYwBRettoU9e5I3A5GQJFV2Z+hQTHbDRrIy0M3ZL53jolzRGQ==
X-Received: by 2002:a05:6a00:b49:b0:4cf:432f:9cd9 with SMTP id p9-20020a056a000b4900b004cf432f9cd9mr35426442pfo.10.1646261109563;
        Wed, 02 Mar 2022 14:45:09 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id 17-20020a056a00071100b004f0f941d1e8sm201102pfl.24.2022.03.02.14.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 14:45:09 -0800 (PST)
Date:   Thu, 3 Mar 2022 04:15:06 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, joshdon@google.com, sdf@google.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 8/9] bpf: Introduce cgroup iter
Message-ID: <20220302224506.jc7jwkdaatukicik@apollo.legion>
References: <20220225234339.2386398-1-haoluo@google.com>
 <20220225234339.2386398-9-haoluo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225234339.2386398-9-haoluo@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 26, 2022 at 05:13:38AM IST, Hao Luo wrote:
> Introduce a new type of iter prog: cgroup. Unlike other bpf_iter, this
> iter doesn't iterate a set of kernel objects. Instead, it is supposed to
> be parameterized by a cgroup id and prints only that cgroup. So one
> needs to specify a target cgroup id when attaching this iter.
>
> The target cgroup's state can be read out via a link of this iter.
> Typically, we can monitor cgroup creation and deletion using sleepable
> tracing and use it to create corresponding directories in bpffs and pin
> a cgroup id parameterized link in the directory. Then we can read the
> auto-pinned iter link to get cgroup's state. The output of the iter link
> is determined by the program. See the selftest test_cgroup_stats.c for
> an example.
>
> Signed-off-by: Hao Luo <haoluo@google.com>
> ---
>  include/linux/bpf.h            |   1 +
>  include/uapi/linux/bpf.h       |   6 ++
>  kernel/bpf/Makefile            |   2 +-
>  kernel/bpf/cgroup_iter.c       | 141 +++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |   6 ++
>  5 files changed, 155 insertions(+), 1 deletion(-)
>  create mode 100644 kernel/bpf/cgroup_iter.c
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 759ade7b24b3..3ce9b0b7ed89 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1595,6 +1595,7 @@ int bpf_obj_get_path(bpfptr_t pathname, int flags);
>
>  struct bpf_iter_aux_info {
>  	struct bpf_map *map;
> +	u64 cgroup_id;
>  };
>
>  typedef int (*bpf_iter_attach_target_t)(struct bpf_prog *prog,
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index a5dbc794403d..855ad80d9983 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -91,6 +91,9 @@ union bpf_iter_link_info {
>  	struct {
>  		__u32	map_fd;
>  	} map;
> +	struct {
> +		__u64	cgroup_id;
> +	} cgroup;
>  };
>
>  /* BPF syscall commands, see bpf(2) man-page for more details. */
> @@ -5887,6 +5890,9 @@ struct bpf_link_info {
>  				struct {
>  					__u32 map_id;
>  				} map;
> +				struct {
> +					__u64 cgroup_id;
> +				} cgroup;
>  			};
>  		} iter;
>  		struct  {
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index c1a9be6a4b9f..52a0e4c6e96e 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -8,7 +8,7 @@ CFLAGS_core.o += $(call cc-disable-warning, override-init) $(cflags-nogcse-yy)
>
>  obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o bpf_iter.o map_iter.o task_iter.o prog_iter.o
>  obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
> -obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
> +obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o cgroup_iter.o
>  obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
>  obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
>  obj-$(CONFIG_BPF_SYSCALL) += disasm.o
> diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
> new file mode 100644
> index 000000000000..011d9dcd1d51
> --- /dev/null
> +++ b/kernel/bpf/cgroup_iter.c
> @@ -0,0 +1,141 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2022 Google */
> +#include <linux/bpf.h>
> +#include <linux/btf_ids.h>
> +#include <linux/cgroup.h>
> +#include <linux/kernel.h>
> +#include <linux/seq_file.h>
> +
> +struct bpf_iter__cgroup {
> +	__bpf_md_ptr(struct bpf_iter_meta *, meta);
> +	__bpf_md_ptr(struct cgroup *, cgroup);
> +};
> +
> +static void *cgroup_iter_seq_start(struct seq_file *seq, loff_t *pos)
> +{
> +	struct cgroup *cgroup;
> +	u64 cgroup_id;
> +
> +	/* Only one session is supported. */
> +	if (*pos > 0)
> +		return NULL;
> +
> +	cgroup_id = *(u64 *)seq->private;
> +	cgroup = cgroup_get_from_id(cgroup_id);
> +	if (!cgroup)
> +		return NULL;
> +
> +	if (*pos == 0)
> +		++*pos;
> +
> +	return cgroup;
> +}
> +
> +static void *cgroup_iter_seq_next(struct seq_file *seq, void *v, loff_t *pos)
> +{
> +	++*pos;
> +	return NULL;
> +}
> +
> +static int cgroup_iter_seq_show(struct seq_file *seq, void *v)
> +{
> +	struct bpf_iter__cgroup ctx;
> +	struct bpf_iter_meta meta;
> +	struct bpf_prog *prog;
> +	int ret = 0;
> +
> +	ctx.meta = &meta;
> +	ctx.cgroup = v;
> +	meta.seq = seq;
> +	prog = bpf_iter_get_info(&meta, false);
> +	if (prog)
> +		ret = bpf_iter_run_prog(prog, &ctx);
> +
> +	return ret;
> +}
> +
> +static void cgroup_iter_seq_stop(struct seq_file *seq, void *v)
> +{
> +	if (v)
> +		cgroup_put(v);
> +}

I think in existing iterators, we make a final call to seq_show, with v as NULL,
is there a specific reason to do it differently for this? There is logic in
bpf_iter.c to trigger ->stop() callback again when ->start() or ->next() returns
NULL, to execute BPF program with NULL p, see the comment above stop label.

If you do add the seq_show call with NULL, you'd also need to change the
ctx_arg_info PTR_TO_BTF_ID to PTR_TO_BTF_ID_OR_NULL.

> +
> +static const struct seq_operations cgroup_iter_seq_ops = {
> +	.start  = cgroup_iter_seq_start,
> +	.next   = cgroup_iter_seq_next,
> +	.stop   = cgroup_iter_seq_stop,
> +	.show   = cgroup_iter_seq_show,
> +};
> +
> +BTF_ID_LIST_SINGLE(bpf_cgroup_btf_id, struct, cgroup)
> +
> +static int cgroup_iter_seq_init(void *priv_data, struct bpf_iter_aux_info *aux)
> +{
> +	*(u64 *)priv_data = aux->cgroup_id;
> +	return 0;
> +}
> +
> +static void cgroup_iter_seq_fini(void *priv_data)
> +{
> +}
> +
> +static const struct bpf_iter_seq_info cgroup_iter_seq_info = {
> +	.seq_ops                = &cgroup_iter_seq_ops,
> +	.init_seq_private       = cgroup_iter_seq_init,
> +	.fini_seq_private       = cgroup_iter_seq_fini,
> +	.seq_priv_size          = sizeof(u64),
> +};
> +
> +static int bpf_iter_attach_cgroup(struct bpf_prog *prog,
> +				  union bpf_iter_link_info *linfo,
> +				  struct bpf_iter_aux_info *aux)
> +{
> +	aux->cgroup_id = linfo->cgroup.cgroup_id;
> +	return 0;
> +}
> +
> +static void bpf_iter_detach_cgroup(struct bpf_iter_aux_info *aux)
> +{
> +}
> +
> +void bpf_iter_cgroup_show_fdinfo(const struct bpf_iter_aux_info *aux,
> +				 struct seq_file *seq)
> +{
> +	char buf[64] = {0};
> +
> +	cgroup_path_from_kernfs_id(aux->cgroup_id, buf, sizeof(buf));
> +	seq_printf(seq, "cgroup_id:\t%lu\n", aux->cgroup_id);
> +	seq_printf(seq, "cgroup_path:\t%s\n", buf);
> +}
> +
> +int bpf_iter_cgroup_fill_link_info(const struct bpf_iter_aux_info *aux,
> +				   struct bpf_link_info *info)
> +{
> +	info->iter.cgroup.cgroup_id = aux->cgroup_id;
> +	return 0;
> +}
> +
> +DEFINE_BPF_ITER_FUNC(cgroup, struct bpf_iter_meta *meta,
> +		     struct cgroup *cgroup)
> +
> +static struct bpf_iter_reg bpf_cgroup_reg_info = {
> +	.target			= "cgroup",
> +	.attach_target		= bpf_iter_attach_cgroup,
> +	.detach_target		= bpf_iter_detach_cgroup,
> +	.show_fdinfo		= bpf_iter_cgroup_show_fdinfo,
> +	.fill_link_info		= bpf_iter_cgroup_fill_link_info,
> +	.ctx_arg_info_size	= 1,
> +	.ctx_arg_info		= {
> +		{ offsetof(struct bpf_iter__cgroup, cgroup),
> +		  PTR_TO_BTF_ID },
> +	},
> +	.seq_info		= &cgroup_iter_seq_info,
> +};
> +
> +static int __init bpf_cgroup_iter_init(void)
> +{
> +	bpf_cgroup_reg_info.ctx_arg_info[0].btf_id = bpf_cgroup_btf_id[0];
> +	return bpf_iter_reg_target(&bpf_cgroup_reg_info);
> +}
> +
> +late_initcall(bpf_cgroup_iter_init);
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index a5dbc794403d..855ad80d9983 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -91,6 +91,9 @@ union bpf_iter_link_info {
>  	struct {
>  		__u32	map_fd;
>  	} map;
> +	struct {
> +		__u64	cgroup_id;
> +	} cgroup;
>  };
>
>  /* BPF syscall commands, see bpf(2) man-page for more details. */
> @@ -5887,6 +5890,9 @@ struct bpf_link_info {
>  				struct {
>  					__u32 map_id;
>  				} map;
> +				struct {
> +					__u64 cgroup_id;
> +				} cgroup;
>  			};
>  		} iter;
>  		struct  {
> --
> 2.35.1.574.g5d30c73bfb-goog
>

--
Kartikeya
