Return-Path: <bpf+bounces-15743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3827F5AEA
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 10:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CE961C20D69
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 09:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EE321102;
	Thu, 23 Nov 2023 09:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pi96pgRM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BF71A5
	for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 01:20:11 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-547e7de7b6fso1317287a12.0
        for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 01:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700731210; x=1701336010; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1uK465ZGSCuMXnO+mMcmDEHklhsiyFFAJUP+dBFfpNs=;
        b=Pi96pgRMmVN9nDFGXZVQZqSHjRppxOH/l7vWaVOlZthe/9/sjHfBEn8zdTs9oEILKF
         8xbzKgm8yuF2H6Neq7wPvMFnjJyE4oCA3kIrasWwiDASR0PVyOCDX9FQMigm1Eak8eWA
         wdBc8QiCKRqkTjTL2yb9HDVKMPyl9i2RlbGALwrF9q3wgQAKlm9c4GuJnDysa2rXvYjx
         AxUk85KOx8vctFUveDJhkWVWYNCavelpVzktU6f05VDy91Bgzi/USebVe0ovkzWK4f27
         G0yzOEbohEEvfEwFpzKDXjT+IqVPfQKSCJAH9GIV2xqzX304SSpJIbA1ySeVVn3wJe9V
         t3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700731210; x=1701336010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1uK465ZGSCuMXnO+mMcmDEHklhsiyFFAJUP+dBFfpNs=;
        b=FNw8XqnKpjRnH1tXdPjiQyra2LvQ9V8t+OWPzWNDXjlGWri/kFlEQCPsc2KZONErf3
         5r0N/T/2uZQeivLByeJh2oUN76zvEKD6zEneTtQLmwHmoxal+TLDymx7kFWOvL6O1g/m
         FlsT4L6plHXc7iEBUew6q9s+SO2x1vP8N0Ry4bIKAtEzZgcWkTFEfHFaLaJ9cppV6wsF
         fiM/50ZTdBg1vIElCWgk5cnvogzry5oOx10l/YO8S9u54dlyAkMxiAWHTgNGkFqWFyxA
         yD+jtcPXz/DAFhn9tC7s22+y2EEA8Hs3PK5MkKN6HAsKLH38CgyA9X5eoKBGXkAoWrUp
         Hs9w==
X-Gm-Message-State: AOJu0Yz3tzVfNPdq9hYgPHsR2e9yqHn/ctagiaU4uIw4Ls34sv50gBJE
	sPYe77UWO7JKT0rYeqDuLjU=
X-Google-Smtp-Source: AGHT+IE9CVZkP7cu9GCzO7or99V9dzanoPvx/4y8vQfQh7uQcCYWy+g0d5Cg7mCogROjg/cCv1oPwA==
X-Received: by 2002:a50:ee96:0:b0:548:a1cd:a92c with SMTP id f22-20020a50ee96000000b00548a1cda92cmr1877586edr.5.1700731210042;
        Thu, 23 Nov 2023 01:20:10 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id e12-20020a50fb8c000000b0053e88c4d004sm415371edq.66.2023.11.23.01.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 01:20:09 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 23 Nov 2023 10:20:07 +0100
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
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
Message-ID: <ZV8ZR0UD8A7tJiil@krava>
References: <20231120145639.3179656-1-jolsa@kernel.org>
 <20231120145639.3179656-4-jolsa@kernel.org>
 <70c4f23e-7de2-4373-a5f3-a6ef0ed31ef7@linux.dev>
 <ZV53jlOMcLu3dRVt@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV53jlOMcLu3dRVt@krava>

On Wed, Nov 22, 2023 at 10:50:06PM +0100, Jiri Olsa wrote:
> On Mon, Nov 20, 2023 at 10:04:16AM -0800, Yonghong Song wrote:
> 
> SNIP
> 
> > > +static int bpf_uprobe_multi_link_fill_link_info(const struct bpf_link *link,
> > > +						struct bpf_link_info *info)
> > > +{
> > > +	u64 __user *uref_ctr_offsets = u64_to_user_ptr(info->uprobe_multi.ref_ctr_offsets);
> > > +	u64 __user *ucookies = u64_to_user_ptr(info->uprobe_multi.cookies);
> > > +	u64 __user *uoffsets = u64_to_user_ptr(info->uprobe_multi.offsets);
> > > +	u64 __user *upath = u64_to_user_ptr(info->uprobe_multi.path);
> > > +	u32 upath_size = info->uprobe_multi.path_size;
> > > +	struct bpf_uprobe_multi_link *umulti_link;
> > > +	u32 ucount = info->uprobe_multi.count;
> > > +	int err = 0, i;
> > > +	long left;
> > > +
> > > +	if (!upath ^ !upath_size)
> > > +		return -EINVAL;
> > > +
> > > +	if ((uoffsets || uref_ctr_offsets || ucookies) && !ucount)
> > > +		return -EINVAL;
> > > +
> > > +	umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
> > > +	info->uprobe_multi.count = umulti_link->cnt;
> > > +	info->uprobe_multi.flags = umulti_link->flags;
> > > +	info->uprobe_multi.pid = umulti_link->task ?
> > > +				 task_pid_nr_ns(umulti_link->task, task_active_pid_ns(current)) : 0;
> > > +
> > > +	if (upath) {
> > > +		char *p, *buf;
> > > +
> > > +		upath_size = min_t(u32, upath_size, PATH_MAX);
> > > +
> > > +		buf = kmalloc(upath_size, GFP_KERNEL);
> > > +		if (!buf)
> > > +			return -ENOMEM;
> > > +		p = d_path(&umulti_link->path, buf, upath_size);
> > > +		if (IS_ERR(p)) {
> > > +			kfree(buf);
> > > +			return -ENOSPC;
> > 
> > Should we just return PTR_ERR(p)? In d_path, it is possible that
> > -ENAMETOOLONG is returned. But path->dentry->d_op->d_dname() might
> > return a different error reason than  -ENAMETOOLONG or -ENOSPC?
> 
> true, will change
> 
> > 
> > > +		}
> > > +		upath_size = buf + upath_size - p;
> > > +		left = copy_to_user(upath, p, upath_size);
> > 
> > Here, the data copied to user may contain more than
> > actual path itself. I am okay with this since this
> > is not in critical path. But early buf allocation is using
> > kmalloc whose content could be arbitrary. Should we
> > use kzalloc for the above 'buf' allocation?
> 
> good catch, will use kzalloc

hum, actually.. after checking d_path IIUC it copies into the end of buffer,
so I can't see this code copying more data to user buffer

jirka

