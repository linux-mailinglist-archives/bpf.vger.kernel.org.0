Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8308C4CB534
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 04:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiCCDEj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 22:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbiCCDEi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 22:04:38 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DCDED96C;
        Wed,  2 Mar 2022 19:03:53 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id 12so3376907pgd.0;
        Wed, 02 Mar 2022 19:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1T2pQiZbXMlGRmXFIqTrOqvgWauP+ciwm+r1geHJ1uw=;
        b=cw+fwGH+AFgfI573z/Ws8CS0mauU3imZKGGexYFtW6cSLkZYt0SkWENuPuy+pCMCq7
         1EZVnDReKyHSZj9UGj2VL+sDQJm6VS/7fCYcSWVsjCiIS+ketVqBJWlAzk9yBCJn4xox
         pG0SD1pkfgEVZF4UOMfJ8gKBJfAuqZRfbUR9RWnLHQiTId28XLioZIHDKuYacJSMV66k
         hh2Flbv18XxBuDvIx2s91Ijo1Gnw9eLGE/wp97+slWQb/YwgM1/SFDeRTvCpGmR3tVM5
         ybmQma7l7D5r5Lvo6bwU/YELWXMoWGyPgefrcWZHEckrniVLnmDDsMgJf1WGwRrtoAvi
         z+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1T2pQiZbXMlGRmXFIqTrOqvgWauP+ciwm+r1geHJ1uw=;
        b=1wrlRWGM/i1Nk2++X6F8M3DMm0L8DR9zTQTJGFB0gyCkWyNrIIbNCG8I9OKPZczzdZ
         bD/Y2nemkqjaahCwakVIpuhCKQGXo4O51bLYEFVOP9QnQdLogstLekyJjCPjEXCevKI3
         AQdYywAPBa13im9TDKQWIiE5cQXXcqhTZgU3VV+wnVAfBg/vx2aY3mjTPXmJZh3pOi/J
         DnQRFK0S/63gaYLV4ljiInsNR8CRvacoalV4x4GtlTRZhPRzUc+I5hF5HFbSZSzfNr08
         LSyd/72ygqu6PeQgomAYwjWymFIlXb7uyq80+06ouZffMWzRC+NL7mL9QO6ZcZt8YQap
         l6cw==
X-Gm-Message-State: AOAM5320f+yTPVS9aPg+crm/R44Y1ZjTQ1GF3BhqOQoN3r7121JxEWA2
        8/CijGjjHr6MWWC4PAOrOcg=
X-Google-Smtp-Source: ABdhPJz5Mddl9rcZtv4HDTnH0mTxyJ7dFwmBYJCQvR3sS9HN8w9/82ndp6bB7WqGsFMmXqSm779Y4w==
X-Received: by 2002:a63:1c15:0:b0:372:ffcd:4d21 with SMTP id c21-20020a631c15000000b00372ffcd4d21mr28631649pgc.450.1646276633238;
        Wed, 02 Mar 2022 19:03:53 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id bh3-20020a056a02020300b00378b62df320sm470171pgb.73.2022.03.02.19.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 19:03:52 -0800 (PST)
Date:   Thu, 3 Mar 2022 08:33:49 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     Hao Luo <haoluo@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, joshdon@google.com, sdf@google.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 8/9] bpf: Introduce cgroup iter
Message-ID: <20220303030349.drd7mmwtufl45p3u@apollo.legion>
References: <20220225234339.2386398-1-haoluo@google.com>
 <20220225234339.2386398-9-haoluo@google.com>
 <20220302224506.jc7jwkdaatukicik@apollo.legion>
 <f780fc3a-dbc2-986c-d5a0-6b0ef1c4311f@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f780fc3a-dbc2-986c-d5a0-6b0ef1c4311f@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 03, 2022 at 07:33:16AM IST, Yonghong Song wrote:
>
>
> On 3/2/22 2:45 PM, Kumar Kartikeya Dwivedi wrote:
> > On Sat, Feb 26, 2022 at 05:13:38AM IST, Hao Luo wrote:
> > > Introduce a new type of iter prog: cgroup. Unlike other bpf_iter, this
> > > iter doesn't iterate a set of kernel objects. Instead, it is supposed to
> > > be parameterized by a cgroup id and prints only that cgroup. So one
> > > needs to specify a target cgroup id when attaching this iter.
> > >
> > > The target cgroup's state can be read out via a link of this iter.
> > > Typically, we can monitor cgroup creation and deletion using sleepable
> > > tracing and use it to create corresponding directories in bpffs and pin
> > > a cgroup id parameterized link in the directory. Then we can read the
> > > auto-pinned iter link to get cgroup's state. The output of the iter link
> > > is determined by the program. See the selftest test_cgroup_stats.c for
> > > an example.
> > >
> > > Signed-off-by: Hao Luo <haoluo@google.com>
> > > ---
> > >   include/linux/bpf.h            |   1 +
> > >   include/uapi/linux/bpf.h       |   6 ++
> > >   kernel/bpf/Makefile            |   2 +-
> > >   kernel/bpf/cgroup_iter.c       | 141 +++++++++++++++++++++++++++++++++
> > >   tools/include/uapi/linux/bpf.h |   6 ++
> > >   5 files changed, 155 insertions(+), 1 deletion(-)
> > >   create mode 100644 kernel/bpf/cgroup_iter.c
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index 759ade7b24b3..3ce9b0b7ed89 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -1595,6 +1595,7 @@ int bpf_obj_get_path(bpfptr_t pathname, int flags);
> > >
> > >   struct bpf_iter_aux_info {
> > >   	struct bpf_map *map;
> > > +	u64 cgroup_id;
> > >   };
> > >
> > >   typedef int (*bpf_iter_attach_target_t)(struct bpf_prog *prog,
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index a5dbc794403d..855ad80d9983 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -91,6 +91,9 @@ union bpf_iter_link_info {
> > >   	struct {
> > >   		__u32	map_fd;
> > >   	} map;
> > > +	struct {
> > > +		__u64	cgroup_id;
> > > +	} cgroup;
> > >   };
> > >
> > >   /* BPF syscall commands, see bpf(2) man-page for more details. */
> > > @@ -5887,6 +5890,9 @@ struct bpf_link_info {
> > >   				struct {
> > >   					__u32 map_id;
> > >   				} map;
> > > +				struct {
> > > +					__u64 cgroup_id;
> > > +				} cgroup;
> > >   			};
> > >   		} iter;
> > >   		struct  {
> > > diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> > > index c1a9be6a4b9f..52a0e4c6e96e 100644
> > > --- a/kernel/bpf/Makefile
> > > +++ b/kernel/bpf/Makefile
> > > @@ -8,7 +8,7 @@ CFLAGS_core.o += $(call cc-disable-warning, override-init) $(cflags-nogcse-yy)
> > >
> > >   obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o bpf_iter.o map_iter.o task_iter.o prog_iter.o
> > >   obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
> > > -obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
> > > +obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o cgroup_iter.o
> > >   obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
> > >   obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
> > >   obj-$(CONFIG_BPF_SYSCALL) += disasm.o
> > > diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
> > > new file mode 100644
> > > index 000000000000..011d9dcd1d51
> > > --- /dev/null
> > > +++ b/kernel/bpf/cgroup_iter.c
> > > @@ -0,0 +1,141 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/* Copyright (c) 2022 Google */
> > > +#include <linux/bpf.h>
> > > +#include <linux/btf_ids.h>
> > > +#include <linux/cgroup.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/seq_file.h>
> > > +
> > > +struct bpf_iter__cgroup {
> > > +	__bpf_md_ptr(struct bpf_iter_meta *, meta);
> > > +	__bpf_md_ptr(struct cgroup *, cgroup);
> > > +};
> > > +
> > > +static void *cgroup_iter_seq_start(struct seq_file *seq, loff_t *pos)
> > > +{
> > > +	struct cgroup *cgroup;
> > > +	u64 cgroup_id;
> > > +
> > > +	/* Only one session is supported. */
> > > +	if (*pos > 0)
> > > +		return NULL;
> > > +
> > > +	cgroup_id = *(u64 *)seq->private;
> > > +	cgroup = cgroup_get_from_id(cgroup_id);
> > > +	if (!cgroup)
> > > +		return NULL;
> > > +
> > > +	if (*pos == 0)
> > > +		++*pos;
> > > +
> > > +	return cgroup;
> > > +}
> > > +
> > > +static void *cgroup_iter_seq_next(struct seq_file *seq, void *v, loff_t *pos)
> > > +{
> > > +	++*pos;
> > > +	return NULL;
> > > +}
> > > +
> > > +static int cgroup_iter_seq_show(struct seq_file *seq, void *v)
> > > +{
> > > +	struct bpf_iter__cgroup ctx;
> > > +	struct bpf_iter_meta meta;
> > > +	struct bpf_prog *prog;
> > > +	int ret = 0;
> > > +
> > > +	ctx.meta = &meta;
> > > +	ctx.cgroup = v;
> > > +	meta.seq = seq;
> > > +	prog = bpf_iter_get_info(&meta, false);
> > > +	if (prog)
> > > +		ret = bpf_iter_run_prog(prog, &ctx);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static void cgroup_iter_seq_stop(struct seq_file *seq, void *v)
> > > +{
> > > +	if (v)
> > > +		cgroup_put(v);
> > > +}
> >
> > I think in existing iterators, we make a final call to seq_show, with v as NULL,
> > is there a specific reason to do it differently for this? There is logic in
> > bpf_iter.c to trigger ->stop() callback again when ->start() or ->next() returns
> > NULL, to execute BPF program with NULL p, see the comment above stop label.
> >
> > If you do add the seq_show call with NULL, you'd also need to change the
> > ctx_arg_info PTR_TO_BTF_ID to PTR_TO_BTF_ID_OR_NULL.
>
> Kumar, PTR_TO_BTF_ID should be okay since the show() never takes a non-NULL
> cgroup. But we do have issues for cgroup_iter_seq_stop() which I missed
> earlier.
>

Right, I was thinking whether it should call seq_show for v == NULL case. All
other iterators seem to do so, it's a bit different here since it is only
iterating over a single cgroup, I guess, but it would be nice to have some
consistency.

> For cgroup_iter, the following is the current workflow:
>    start -> not NULL -> show -> next -> NULL -> stop
> or
>    start -> NULL -> stop
>
> So for cgroup_iter_seq_stop, the input parameter 'v' will be NULL, so
> the cgroup_put() is not actually called, i.e., corresponding cgroup is
> not freed.
>
> There are two ways to fix the issue:
>   . call cgroup_put() in next() before return NULL. This way,
>     stop() will be a noop.
>   . put cgroup_get_from_id() and cgroup_put() in
>     bpf_iter_attach_cgroup() and bpf_iter_detach_cgroup().
>
> I prefer the second approach as it is cleaner.
>

I think current approach is also not safe if cgroup_id gets reused, right? I.e.
it only does cgroup_get_from_id in seq_start, not at attach time, so it may not
be the same cgroup when calling read(2). kernfs is using idr_alloc_cyclic, so it
is less likely to occur, but since it wraps around to find a free ID it might
not be theoretical.

> >
> > > +
> > > +static const struct seq_operations cgroup_iter_seq_ops = {
> > > +	.start  = cgroup_iter_seq_start,
> > > +	.next   = cgroup_iter_seq_next,
> > > +	.stop   = cgroup_iter_seq_stop,
> > > +	.show   = cgroup_iter_seq_show,
> > > +};
> > > +
> > > +BTF_ID_LIST_SINGLE(bpf_cgroup_btf_id, struct, cgroup)
> > > +
> > > +static int cgroup_iter_seq_init(void *priv_data, struct bpf_iter_aux_info *aux)
> > > +{
> > > +	*(u64 *)priv_data = aux->cgroup_id;
> > > +	return 0;
> > > +}
> > > +
> > > +static void cgroup_iter_seq_fini(void *priv_data)
> > > +{
> > > +}
> > > +
> > > +static const struct bpf_iter_seq_info cgroup_iter_seq_info = {
> > > +	.seq_ops                = &cgroup_iter_seq_ops,
> > > +	.init_seq_private       = cgroup_iter_seq_init,
> > > +	.fini_seq_private       = cgroup_iter_seq_fini,
> > > +	.seq_priv_size          = sizeof(u64),
> > > +};
> > > +
> > > +static int bpf_iter_attach_cgroup(struct bpf_prog *prog,
> > > +				  union bpf_iter_link_info *linfo,
> > > +				  struct bpf_iter_aux_info *aux)
> > > +{
> > > +	aux->cgroup_id = linfo->cgroup.cgroup_id;
> > > +	return 0;
> > > +}
> > > +
> > > +static void bpf_iter_detach_cgroup(struct bpf_iter_aux_info *aux)
> > > +{
> > > +}
> > > +
> > > +void bpf_iter_cgroup_show_fdinfo(const struct bpf_iter_aux_info *aux,
> > > +				 struct seq_file *seq)
> > > +{
> > > +	char buf[64] = {0};
> > > +
> > > +	cgroup_path_from_kernfs_id(aux->cgroup_id, buf, sizeof(buf));
> > > +	seq_printf(seq, "cgroup_id:\t%lu\n", aux->cgroup_id);
> > > +	seq_printf(seq, "cgroup_path:\t%s\n", buf);
> > > +}
> > > +
> > > +int bpf_iter_cgroup_fill_link_info(const struct bpf_iter_aux_info *aux,
> > > +				   struct bpf_link_info *info)
> > > +{
> > > +	info->iter.cgroup.cgroup_id = aux->cgroup_id;
> > > +	return 0;
> > > +}
> > > +
> > > +DEFINE_BPF_ITER_FUNC(cgroup, struct bpf_iter_meta *meta,
> > > +		     struct cgroup *cgroup)
> > > +
> > > +static struct bpf_iter_reg bpf_cgroup_reg_info = {
> > > +	.target			= "cgroup",
> > > +	.attach_target		= bpf_iter_attach_cgroup,
> > > +	.detach_target		= bpf_iter_detach_cgroup,
> > > +	.show_fdinfo		= bpf_iter_cgroup_show_fdinfo,
> > > +	.fill_link_info		= bpf_iter_cgroup_fill_link_info,
> > > +	.ctx_arg_info_size	= 1,
> > > +	.ctx_arg_info		= {
> > > +		{ offsetof(struct bpf_iter__cgroup, cgroup),
> > > +		  PTR_TO_BTF_ID },
> > > +	},
> > > +	.seq_info		= &cgroup_iter_seq_info,
> > > +};
> > > +
> > > +static int __init bpf_cgroup_iter_init(void)
> > > +{
> > > +	bpf_cgroup_reg_info.ctx_arg_info[0].btf_id = bpf_cgroup_btf_id[0];
> > > +	return bpf_iter_reg_target(&bpf_cgroup_reg_info);
> > > +}
> > > +
> > > +late_initcall(bpf_cgroup_iter_init);
> > > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> > > index a5dbc794403d..855ad80d9983 100644
> > > --- a/tools/include/uapi/linux/bpf.h
> > > +++ b/tools/include/uapi/linux/bpf.h
> > > @@ -91,6 +91,9 @@ union bpf_iter_link_info {
> > >   	struct {
> > >   		__u32	map_fd;
> > >   	} map;
> > > +	struct {
> > > +		__u64	cgroup_id;
> > > +	} cgroup;
> > >   };
> > >
> > >   /* BPF syscall commands, see bpf(2) man-page for more details. */
> > > @@ -5887,6 +5890,9 @@ struct bpf_link_info {
> > >   				struct {
> > >   					__u32 map_id;
> > >   				} map;
> > > +				struct {
> > > +					__u64 cgroup_id;
> > > +				} cgroup;
> > >   			};
> > >   		} iter;
> > >   		struct  {
> > > --
> > > 2.35.1.574.g5d30c73bfb-goog
> > >
> >
> > --
> > Kartikeya

--
Kartikeya
