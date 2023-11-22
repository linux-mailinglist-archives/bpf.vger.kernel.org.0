Return-Path: <bpf+bounces-15708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F85C7F52DA
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 22:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B51D281031
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 21:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799801D6A5;
	Wed, 22 Nov 2023 21:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GL5ZzqPl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F99DA9
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 13:50:16 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c87acba73bso3601871fa.1
        for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 13:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700689814; x=1701294614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QsCRSylyHi6x7qRXO3i1EJe0apQp53G7vBdDkCDj+MU=;
        b=GL5ZzqPl5u0VZWTX88StMUJoHuwCD1y5yWv64J3Gnpy8IsCHUZDQGTV1z9ZBrdaDGH
         fOSTwxwTfxPZNHJWICPbjSeHHpnXRjzd2qJfHS8SBshKkgsJj6qo2pSR7X/wJTO1azY2
         My108BY8NAADDPystugWrK5RhCv9KmW3Aol5JCPjhUZ0iirX91HJl8qVmVzY0YqLXOFA
         FrPRrcVTUE7O4PQa64CHlx4uE/lZ1M0MKOHExzXyeqgvvZHQFnTrf4QHLKBwbRHcV1xv
         JC56WwzsTQFN3CGAdiCFG7JBzYXzTE21JkSbJZIzT3j6lL3ekDQsj0pS+n8S96XUpyud
         gVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700689814; x=1701294614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QsCRSylyHi6x7qRXO3i1EJe0apQp53G7vBdDkCDj+MU=;
        b=Upg6YDOgrLwwvwry8sT+pxSB5L7MD6ioExW2Pjxrxy0k2aJyz7etnFOuZU8UDbfDnm
         2ATzBhiV27jbr08FYDucc55I1rSDzMR6kebk6BcysvA3SkKceIF2rBztSLhfnk+2XKTw
         kR9Ycptwpf160IGCuRWsq95tv7WTN44iUaTWugWthSsakiNNwn23uZppyqPPXo5SsQHQ
         4AxVcBI+8yeCCsDGa1dugr8IyWiwhUzvwznjBo3rD5dxxMGNYbJFFz67OYN1+5FYzAal
         kXztyP4wsxQChulEXLN9hZ+SvRU9PtTqAsU48tIS8ctzrPuEePypNPLDhe39d82sIBL6
         HApg==
X-Gm-Message-State: AOJu0YwQ3k2dvp1LTTP6zzyMHO+6miSv+4oEdKbaYa8IJW24OxIo+Or6
	fxozzcQSLHKuGEVz9V3MSNU=
X-Google-Smtp-Source: AGHT+IFAA6sGK7Yat4Ubzvy6Ce/xi2wCb6+l3IvTwT63aXM52lsuGrsY/dpnoFMot2Glo8WIjcrbdg==
X-Received: by 2002:a2e:a285:0:b0:2c6:f51f:c96d with SMTP id k5-20020a2ea285000000b002c6f51fc96dmr2474025lja.13.1700689814077;
        Wed, 22 Nov 2023 13:50:14 -0800 (PST)
Received: from krava ([83.240.61.242])
        by smtp.gmail.com with ESMTPSA id g8-20020a17090670c800b009b65a834dd6sm244546ejk.215.2023.11.22.13.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 13:50:13 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 22 Nov 2023 22:50:06 +0100
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCHv3 bpf-next 3/6] bpf: Add link_info support for uprobe
 multi link
Message-ID: <ZV53jlOMcLu3dRVt@krava>
References: <20231120145639.3179656-1-jolsa@kernel.org>
 <20231120145639.3179656-4-jolsa@kernel.org>
 <70c4f23e-7de2-4373-a5f3-a6ef0ed31ef7@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70c4f23e-7de2-4373-a5f3-a6ef0ed31ef7@linux.dev>

On Mon, Nov 20, 2023 at 10:04:16AM -0800, Yonghong Song wrote:

SNIP

> > +static int bpf_uprobe_multi_link_fill_link_info(const struct bpf_link *link,
> > +						struct bpf_link_info *info)
> > +{
> > +	u64 __user *uref_ctr_offsets = u64_to_user_ptr(info->uprobe_multi.ref_ctr_offsets);
> > +	u64 __user *ucookies = u64_to_user_ptr(info->uprobe_multi.cookies);
> > +	u64 __user *uoffsets = u64_to_user_ptr(info->uprobe_multi.offsets);
> > +	u64 __user *upath = u64_to_user_ptr(info->uprobe_multi.path);
> > +	u32 upath_size = info->uprobe_multi.path_size;
> > +	struct bpf_uprobe_multi_link *umulti_link;
> > +	u32 ucount = info->uprobe_multi.count;
> > +	int err = 0, i;
> > +	long left;
> > +
> > +	if (!upath ^ !upath_size)
> > +		return -EINVAL;
> > +
> > +	if ((uoffsets || uref_ctr_offsets || ucookies) && !ucount)
> > +		return -EINVAL;
> > +
> > +	umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
> > +	info->uprobe_multi.count = umulti_link->cnt;
> > +	info->uprobe_multi.flags = umulti_link->flags;
> > +	info->uprobe_multi.pid = umulti_link->task ?
> > +				 task_pid_nr_ns(umulti_link->task, task_active_pid_ns(current)) : 0;
> > +
> > +	if (upath) {
> > +		char *p, *buf;
> > +
> > +		upath_size = min_t(u32, upath_size, PATH_MAX);
> > +
> > +		buf = kmalloc(upath_size, GFP_KERNEL);
> > +		if (!buf)
> > +			return -ENOMEM;
> > +		p = d_path(&umulti_link->path, buf, upath_size);
> > +		if (IS_ERR(p)) {
> > +			kfree(buf);
> > +			return -ENOSPC;
> 
> Should we just return PTR_ERR(p)? In d_path, it is possible that
> -ENAMETOOLONG is returned. But path->dentry->d_op->d_dname() might
> return a different error reason than  -ENAMETOOLONG or -ENOSPC?

true, will change

> 
> > +		}
> > +		upath_size = buf + upath_size - p;
> > +		left = copy_to_user(upath, p, upath_size);
> 
> Here, the data copied to user may contain more than
> actual path itself. I am okay with this since this
> is not in critical path. But early buf allocation is using
> kmalloc whose content could be arbitrary. Should we
> use kzalloc for the above 'buf' allocation?

good catch, will use kzalloc

thanks,
jirka

