Return-Path: <bpf+bounces-7051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82B0770B46
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 23:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54D36282609
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 21:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E18021D3B;
	Fri,  4 Aug 2023 21:55:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12061AA9F
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 21:55:43 +0000 (UTC)
Received: from out-72.mta1.migadu.com (out-72.mta1.migadu.com [IPv6:2001:41d0:203:375::48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B66D110
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 14:55:41 -0700 (PDT)
Message-ID: <8f678d1a-d2c2-c979-f37e-db0f4bf6e933@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691186139; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=730Y59/OWQAvjQvNbYCbKWLxvlsX2FVt//iV5ADTThg=;
	b=HUb5RJcudf/65D1qnxgFA8IFr326RJcS9go8CZnswNKw5tbzMhxOBFkXZT4cTW1CLxwpJb
	xCH64d5aP8hU4sVrKfwTD9N514sPE0uXJlS58TIjOX5jrYKxBJpj4HH5iGfM8gNhKKL7mx
	HQ3oUxsS99Yr9FSumkV6d54cT6Tdng0=
Date: Fri, 4 Aug 2023 14:55:29 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCHv6 bpf-next 03/28] bpf: Add multi uprobe link
Content-Language: en-US
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, bpf@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@chromium.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>
References: <20230803073420.1558613-1-jolsa@kernel.org>
 <20230803073420.1558613-4-jolsa@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230803073420.1558613-4-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/3/23 12:33 AM, Jiri Olsa wrote:
> Adding new multi uprobe link that allows to attach bpf program
> to multiple uprobes.
> 
> Uprobes to attach are specified via new link_create uprobe_multi
> union:
> 
>    struct {
>      __aligned_u64   path;
>      __aligned_u64   offsets;
>      __aligned_u64   ref_ctr_offsets;
>      __u32           cnt;
>      __u32           flags;
>    } uprobe_multi;
> 
> Uprobes are defined for single binary specified in path and multiple
> calling sites specified in offsets array with optional reference
> counters specified in ref_ctr_offsets array. All specified arrays
> have length of 'cnt'.
> 
> The 'flags' supports single bit for now that marks the uprobe as
> return probe.
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Acked-by: Yafang Shao <laoar.shao@gmail.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>   include/linux/trace_events.h   |   6 +
>   include/uapi/linux/bpf.h       |  16 +++
>   kernel/bpf/syscall.c           |  14 +-
>   kernel/trace/bpf_trace.c       | 237 +++++++++++++++++++++++++++++++++
>   tools/include/uapi/linux/bpf.h |  16 +++
>   5 files changed, 286 insertions(+), 3 deletions(-)
> 
[...]
> +
> +static int uprobe_prog_run(struct bpf_uprobe *uprobe,
> +			   unsigned long entry_ip,
> +			   struct pt_regs *regs)
> +{
> +	struct bpf_uprobe_multi_link *link = uprobe->link;
> +	struct bpf_uprobe_multi_run_ctx run_ctx = {
> +		.entry_ip = entry_ip,
> +	};
> +	struct bpf_prog *prog = link->link.prog;
> +	bool sleepable = prog->aux->sleepable;
> +	struct bpf_run_ctx *old_run_ctx;
> +	int err = 0;
> +
> +	might_fault();

Could you explain what you try to protect here
with might_fault()?

In my opinion, might_fault() is unnecessary here
since the calling context is process context and
there is no mmap_lock held, so might_fault()
won't capture anything.

might_fault() is used in iter.c and trampoline.c
since their calling context is more complex
than here and might_fault() may actually capture
issues.

> +
> +	migrate_disable();
> +
> +	if (sleepable)
> +		rcu_read_lock_trace();
> +	else
> +		rcu_read_lock();

Looking at trampoline.c and iter.c, typical
usage is
	rcu_read_lock_trace()/rcu_read_lock()
	migrate_disable()

Your above sequenence could be correct too. But it
is great if we can keep consistency here.

> +
> +	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
> +	err = bpf_prog_run(link->link.prog, regs);
> +	bpf_reset_run_ctx(old_run_ctx);
> +
> +	if (sleepable)
> +		rcu_read_unlock_trace();
> +	else
> +		rcu_read_unlock();
> +
> +	migrate_enable();
> +	return err;
> +}
> +
> +static int
> +uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs)
> +{
> +	struct bpf_uprobe *uprobe;
> +
> +	uprobe = container_of(con, struct bpf_uprobe, consumer);
> +	return uprobe_prog_run(uprobe, instruction_pointer(regs), regs);
> +}
> +
> +static int
> +uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, struct pt_regs *regs)
> +{
> +	struct bpf_uprobe *uprobe;
> +
> +	uprobe = container_of(con, struct bpf_uprobe, consumer);
> +	return uprobe_prog_run(uprobe, func, regs);
> +}
> +
> +int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> +{
> +	struct bpf_uprobe_multi_link *link = NULL;
> +	unsigned long __user *uref_ctr_offsets;
> +	unsigned long *ref_ctr_offsets = NULL;
> +	struct bpf_link_primer link_primer;
> +	struct bpf_uprobe *uprobes = NULL;
> +	unsigned long __user *uoffsets;
> +	void __user *upath;
> +	u32 flags, cnt, i;
> +	struct path path;
> +	char *name;
> +	int err;
> +
> +	/* no support for 32bit archs yet */
> +	if (sizeof(u64) != sizeof(void *))
> +		return -EOPNOTSUPP;
> +
> +	if (prog->expected_attach_type != BPF_TRACE_UPROBE_MULTI)
> +		return -EINVAL;
> +
> +	flags = attr->link_create.uprobe_multi.flags;
> +	if (flags & ~BPF_F_UPROBE_MULTI_RETURN)
> +		return -EINVAL;
> +
> +	/*
> +	 * path, offsets and cnt are mandatory,
> +	 * ref_ctr_offsets is optional
> +	 */
> +	upath = u64_to_user_ptr(attr->link_create.uprobe_multi.path);
> +	uoffsets = u64_to_user_ptr(attr->link_create.uprobe_multi.offsets);
> +	cnt = attr->link_create.uprobe_multi.cnt;
> +
> +	if (!upath || !uoffsets || !cnt)
> +		return -EINVAL;
> +
> +	uref_ctr_offsets = u64_to_user_ptr(attr->link_create.uprobe_multi.ref_ctr_offsets);
> +
> +	name = strndup_user(upath, PATH_MAX);
> +	if (IS_ERR(name)) {
> +		err = PTR_ERR(name);
> +		return err;
> +	}
> +
> +	err = kern_path(name, LOOKUP_FOLLOW, &path);
> +	kfree(name);
> +	if (err)
> +		return err;
> +
> +	if (!d_is_reg(path.dentry)) {
> +		err = -EBADF;
> +		goto error_path_put;
> +	}
> +
> +	err = -ENOMEM;
> +
> +	link = kzalloc(sizeof(*link), GFP_KERNEL);
> +	uprobes = kvcalloc(cnt, sizeof(*uprobes), GFP_KERNEL);
> +
> +	if (!uprobes || !link)
> +		goto error_free;
> +
> +	if (uref_ctr_offsets) {
> +		ref_ctr_offsets = kvcalloc(cnt, sizeof(*ref_ctr_offsets), GFP_KERNEL);
> +		if (!ref_ctr_offsets)
> +			goto error_free;
> +	}
> +
> +	for (i = 0; i < cnt; i++) {
> +		if (uref_ctr_offsets && __get_user(ref_ctr_offsets[i], uref_ctr_offsets + i)) {
> +			err = -EFAULT;
> +			goto error_free;
> +		}
> +		if (__get_user(uprobes[i].offset, uoffsets + i)) {
> +			err = -EFAULT;
> +			goto error_free;
> +		}
> +
> +		uprobes[i].link = link;
> +
> +		if (flags & BPF_F_UPROBE_MULTI_RETURN)
> +			uprobes[i].consumer.ret_handler = uprobe_multi_link_ret_handler;
> +		else
> +			uprobes[i].consumer.handler = uprobe_multi_link_handler;
> +	}
> +
> +	link->cnt = cnt;
> +	link->uprobes = uprobes;
> +	link->path = path;
> +
> +	bpf_link_init(&link->link, BPF_LINK_TYPE_UPROBE_MULTI,
> +		      &bpf_uprobe_multi_link_lops, prog);
> +
> +	err = bpf_link_prime(&link->link, &link_primer);
> +	if (err)
> +		goto error_free;
> +
> +	for (i = 0; i < cnt; i++) {
> +		err = uprobe_register_refctr(d_real_inode(link->path.dentry),
> +					     uprobes[i].offset,
> +					     ref_ctr_offsets ? ref_ctr_offsets[i] : 0,
> +					     &uprobes[i].consumer);
> +		if (err) {
> +			bpf_uprobe_unregister(&path, uprobes, i);
> +			bpf_link_cleanup(&link_primer);
> +			kvfree(ref_ctr_offsets);

Is it possible we may miss some of below 'error_free' cleanups?
In my opinion, we should replace
			kvfree(ref_ctr_offsets);
			return err;
with
			goto error_free;

Could you double check?

> +			return err;
> +		}
> +	}
> +
> +	kvfree(ref_ctr_offsets);
> +	return bpf_link_settle(&link_primer);
> +
> +error_free:
> +	kvfree(ref_ctr_offsets);
> +	kvfree(uprobes);
> +	kfree(link);
> +error_path_put:
> +	path_put(&path);
> +	return err;
> +}
> +#else /* !CONFIG_UPROBES */
> +int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif /* CONFIG_UPROBES */
[...]

