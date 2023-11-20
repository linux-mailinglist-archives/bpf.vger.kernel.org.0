Return-Path: <bpf+bounces-15385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF587F1BE6
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 19:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C7331C20B34
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 18:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7912FC3E;
	Mon, 20 Nov 2023 18:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eiJ4qaFW"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [IPv6:2001:41d0:203:375::b4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5697F9
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 10:04:29 -0800 (PST)
Message-ID: <70c4f23e-7de2-4373-a5f3-a6ef0ed31ef7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700503468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pdx+JpccDHVwxWbFZVWbQcklcdAbLLqJxjViGVVn/sE=;
	b=eiJ4qaFWz9a4HxlOt1I89+O4fMdVlp2SMmp1nIqPWaSIK27A5aURp8J2NyigQAJompcxlJ
	/v0q72CDLX42ceqjAKwkSYGtwxML6GkTfYqm0iqogwjxiMqHBerAAdqUtHSzehT4S3W7QF
	4HnaMM/1DPdWVgF19R+I/EIKZlIZcUs=
Date: Mon, 20 Nov 2023 10:04:16 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv3 bpf-next 3/6] bpf: Add link_info support for uprobe
 multi link
Content-Language: en-GB
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Yafang Shao <laoar.shao@gmail.com>
References: <20231120145639.3179656-1-jolsa@kernel.org>
 <20231120145639.3179656-4-jolsa@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231120145639.3179656-4-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/20/23 9:56 AM, Jiri Olsa wrote:
> Adding support to get uprobe_link details through bpf_link_info
> interface.
>
> Adding new struct uprobe_multi to struct bpf_link_info to carry
> the uprobe_multi link details.
>
> The uprobe_multi.count is passed from user space to denote size
> of array fields (offsets/ref_ctr_offsets/cookies). The actual
> array size is stored back to uprobe_multi.count (allowing user
> to find out the actual array size) and array fields are populated
> up to the user passed size.
>
> All the non-array fields (path/count/flags/pid) are always set.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>   include/uapi/linux/bpf.h       | 10 +++++
>   kernel/trace/bpf_trace.c       | 72 ++++++++++++++++++++++++++++++++++
>   tools/include/uapi/linux/bpf.h | 10 +++++
>   3 files changed, 92 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 7a5498242eaa..a63b5eb7f9ec 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6562,6 +6562,16 @@ struct bpf_link_info {
>   			__u32 flags;
>   			__u64 missed;
>   		} kprobe_multi;
> +		struct {
> +			__aligned_u64 path;
> +			__aligned_u64 offsets;
> +			__aligned_u64 ref_ctr_offsets;
> +			__aligned_u64 cookies;
> +			__u32 path_size; /* in/out: real path size on success */
> +			__u32 count; /* in/out: uprobe_multi offsets/ref_ctr_offsets/cookies count */
> +			__u32 flags;
> +			__u32 pid;
> +		} uprobe_multi;
>   		struct {
>   			__u32 type; /* enum bpf_perf_event_type */
>   			__u32 :32;
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index ad0323f27288..ca453b642819 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3044,6 +3044,7 @@ struct bpf_uprobe_multi_link {
>   	u32 cnt;
>   	struct bpf_uprobe *uprobes;
>   	struct task_struct *task;
> +	u32 flags;
>   };
>   
>   struct bpf_uprobe_multi_run_ctx {
> @@ -3083,9 +3084,79 @@ static void bpf_uprobe_multi_link_dealloc(struct bpf_link *link)
>   	kfree(umulti_link);
>   }
>   
> +static int bpf_uprobe_multi_link_fill_link_info(const struct bpf_link *link,
> +						struct bpf_link_info *info)
> +{
> +	u64 __user *uref_ctr_offsets = u64_to_user_ptr(info->uprobe_multi.ref_ctr_offsets);
> +	u64 __user *ucookies = u64_to_user_ptr(info->uprobe_multi.cookies);
> +	u64 __user *uoffsets = u64_to_user_ptr(info->uprobe_multi.offsets);
> +	u64 __user *upath = u64_to_user_ptr(info->uprobe_multi.path);
> +	u32 upath_size = info->uprobe_multi.path_size;
> +	struct bpf_uprobe_multi_link *umulti_link;
> +	u32 ucount = info->uprobe_multi.count;
> +	int err = 0, i;
> +	long left;
> +
> +	if (!upath ^ !upath_size)
> +		return -EINVAL;
> +
> +	if ((uoffsets || uref_ctr_offsets || ucookies) && !ucount)
> +		return -EINVAL;
> +
> +	umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
> +	info->uprobe_multi.count = umulti_link->cnt;
> +	info->uprobe_multi.flags = umulti_link->flags;
> +	info->uprobe_multi.pid = umulti_link->task ?
> +				 task_pid_nr_ns(umulti_link->task, task_active_pid_ns(current)) : 0;
> +
> +	if (upath) {
> +		char *p, *buf;
> +
> +		upath_size = min_t(u32, upath_size, PATH_MAX);
> +
> +		buf = kmalloc(upath_size, GFP_KERNEL);
> +		if (!buf)
> +			return -ENOMEM;
> +		p = d_path(&umulti_link->path, buf, upath_size);
> +		if (IS_ERR(p)) {
> +			kfree(buf);
> +			return -ENOSPC;

Should we just return PTR_ERR(p)? In d_path, it is possible that
-ENAMETOOLONG is returned. But path->dentry->d_op->d_dname() might
return a different error reason than  -ENAMETOOLONG or -ENOSPC?

> +		}
> +		upath_size = buf + upath_size - p;
> +		left = copy_to_user(upath, p, upath_size);

Here, the data copied to user may contain more than
actual path itself. I am okay with this since this
is not in critical path. But early buf allocation is using
kmalloc whose content could be arbitrary. Should we
use kzalloc for the above 'buf' allocation?


> +		kfree(buf);
> +		if (left)
> +			return -EFAULT;
> +		info->uprobe_multi.path_size = upath_size - 1 /* NULL */;
> +	}
> +
> +	if (!uoffsets && !ucookies && !uref_ctr_offsets)
> +		return 0;
> +
> +	if (ucount < umulti_link->cnt)
> +		err = -ENOSPC;
> +	else
> +		ucount = umulti_link->cnt;
> +
> +	for (i = 0; i < ucount; i++) {
> +		if (uoffsets &&
> +		    put_user(umulti_link->uprobes[i].offset, uoffsets + i))
> +			return -EFAULT;
> +		if (uref_ctr_offsets &&
> +		    put_user(umulti_link->uprobes[i].ref_ctr_offset, uref_ctr_offsets + i))
> +			return -EFAULT;
> +		if (ucookies &&
> +		    put_user(umulti_link->uprobes[i].cookie, ucookies + i))
> +			return -EFAULT;
> +	}
> +
> +	return err;
> +}
> +
>   [...]

