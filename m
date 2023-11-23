Return-Path: <bpf+bounces-15768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB827F662C
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 19:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0363281BEA
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 18:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E9E4B5DC;
	Thu, 23 Nov 2023 18:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JbRLAr7n"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F5FD8
	for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 10:26:40 -0800 (PST)
Message-ID: <a6f81e2d-6f6c-422b-a099-272d54efb4f1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700763999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tZUnjWqk6NKYtBERPPkwJtgxetNdeWam1kLrDUIAcaM=;
	b=JbRLAr7nnY+B/sPitFvJwvGnbFWUFZfrVmw/6xeC8AI/Y3dwQO/B/9OQL5czAqXt1Yxa3Q
	hZbn6XWbgCwdSjXUT5pdgFVAMmWU5rFiRoUBiw9RdGUp02gVxgzIPojQxYBxxxB71a7lF/
	w5Q6RFikp063lMIhuOyMTmNHnAwOqnw=
Date: Thu, 23 Nov 2023 10:26:30 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv3 bpf-next 3/6] bpf: Add link_info support for uprobe
 multi link
Content-Language: en-GB
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Yafang Shao <laoar.shao@gmail.com>
References: <20231120145639.3179656-1-jolsa@kernel.org>
 <20231120145639.3179656-4-jolsa@kernel.org>
 <70c4f23e-7de2-4373-a5f3-a6ef0ed31ef7@linux.dev> <ZV53jlOMcLu3dRVt@krava>
 <ZV8ZR0UD8A7tJiil@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ZV8ZR0UD8A7tJiil@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/23/23 4:20 AM, Jiri Olsa wrote:
> On Wed, Nov 22, 2023 at 10:50:06PM +0100, Jiri Olsa wrote:
>> On Mon, Nov 20, 2023 at 10:04:16AM -0800, Yonghong Song wrote:
>>
>> SNIP
>>
>>>> +static int bpf_uprobe_multi_link_fill_link_info(const struct bpf_link *link,
>>>> +						struct bpf_link_info *info)
>>>> +{
>>>> +	u64 __user *uref_ctr_offsets = u64_to_user_ptr(info->uprobe_multi.ref_ctr_offsets);
>>>> +	u64 __user *ucookies = u64_to_user_ptr(info->uprobe_multi.cookies);
>>>> +	u64 __user *uoffsets = u64_to_user_ptr(info->uprobe_multi.offsets);
>>>> +	u64 __user *upath = u64_to_user_ptr(info->uprobe_multi.path);
>>>> +	u32 upath_size = info->uprobe_multi.path_size;
>>>> +	struct bpf_uprobe_multi_link *umulti_link;
>>>> +	u32 ucount = info->uprobe_multi.count;
>>>> +	int err = 0, i;
>>>> +	long left;
>>>> +
>>>> +	if (!upath ^ !upath_size)
>>>> +		return -EINVAL;
>>>> +
>>>> +	if ((uoffsets || uref_ctr_offsets || ucookies) && !ucount)
>>>> +		return -EINVAL;
>>>> +
>>>> +	umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
>>>> +	info->uprobe_multi.count = umulti_link->cnt;
>>>> +	info->uprobe_multi.flags = umulti_link->flags;
>>>> +	info->uprobe_multi.pid = umulti_link->task ?
>>>> +				 task_pid_nr_ns(umulti_link->task, task_active_pid_ns(current)) : 0;
>>>> +
>>>> +	if (upath) {
>>>> +		char *p, *buf;
>>>> +
>>>> +		upath_size = min_t(u32, upath_size, PATH_MAX);
>>>> +
>>>> +		buf = kmalloc(upath_size, GFP_KERNEL);
>>>> +		if (!buf)
>>>> +			return -ENOMEM;
>>>> +		p = d_path(&umulti_link->path, buf, upath_size);
>>>> +		if (IS_ERR(p)) {
>>>> +			kfree(buf);
>>>> +			return -ENOSPC;
>>> Should we just return PTR_ERR(p)? In d_path, it is possible that
>>> -ENAMETOOLONG is returned. But path->dentry->d_op->d_dname() might
>>> return a different error reason than  -ENAMETOOLONG or -ENOSPC?
>> true, will change
>>
>>>> +		}
>>>> +		upath_size = buf + upath_size - p;
>>>> +		left = copy_to_user(upath, p, upath_size);
>>> Here, the data copied to user may contain more than
>>> actual path itself. I am okay with this since this
>>> is not in critical path. But early buf allocation is using
>>> kmalloc whose content could be arbitrary. Should we
>>> use kzalloc for the above 'buf' allocation?
>> good catch, will use kzalloc
> hum, actually.. after checking d_path IIUC it copies into the end of buffer,
> so I can't see this code copying more data to user buffer

Double checked as well. Indeed, the path is copied to the end of buffer,
so kmalloc() should be okay. Sorry for noise.


