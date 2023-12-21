Return-Path: <bpf+bounces-18508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 642F981B05A
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 09:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187551F2299E
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 08:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6BA168D3;
	Thu, 21 Dec 2023 08:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VK2rmg0j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0FF16432
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 08:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5534dcfdd61so949426a12.0
        for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 00:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703147731; x=1703752531; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=389j2VzUkRDn6py+X4XUTrSN2S2Zs0esdujOFdL2z3s=;
        b=VK2rmg0jpStJU1mXf/cmNJXdg2Glo4h3QUIJEMbw+Y3o4AGeeJH4KqhOIxIvHlCUEy
         mLvEPAAUPR6L8MUkYa48IjB9whs5O08i5OG7IIMUKf+G/Ydmgh8U/R83xGHQFrh2a2it
         1fSOgetEPacLg3wBIe+2ThElKnXrd99Ce5tcS9pRTXGIVS4yDK+V8KqLEil+82wyH+QI
         phRvvMCmhcKmoljmlEntuNZZCpW9S3rbpUX/Za7qTfqDQzbF/DLPNfvo2YpcNcnfkyoZ
         QJdXb+J1unFMyFCnW+1e5jj58XSB5sFr7WDiRqQYqaY419DY0DotBMrTt8B49E8ODF0N
         D5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703147731; x=1703752531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=389j2VzUkRDn6py+X4XUTrSN2S2Zs0esdujOFdL2z3s=;
        b=UJ8s7+pKhO6MGwYh/YKY7lGBHzYhf3O6LOPncRpUO+459iZs7D5UnAn9g+WYZX7bBb
         myn2zB+8WupY2czMdfPVENrBzg6kVnwiBKDX7eWzbK+sycF9hVVXzrgSgwCAU585pv1A
         n3VZQKPI2YJvE0BfUx/de8my0CADSbTm/oOFrq3XEuSZlu+WAQKXFMVoabDbNOmmN6LP
         8UHVsAroWcqDkWlbIrGfB3fGkkGqsnC/8vgYI3dkC+F98Rna460lSAetSOIsPdORDIHG
         99GIHDP4YzWQfqTIA+6YbrVHCCaV288QIgh491g+in2zl/Q7+w/aj7YXWg0IiDdHW/T8
         42ig==
X-Gm-Message-State: AOJu0YyNTIC3iEkjHWJ6Sd9S5VXZDhXv+NovtBnBjx0CT8g9RIeN2Mo4
	R2vWUt47oh7h9NucHZDsKpI=
X-Google-Smtp-Source: AGHT+IEu00SrskBPoqZLZNaT7gjLNJRxaoZY1y56NVnfjLOw9udijMRj9zn5jZ+/DK2zs09oIuwV0w==
X-Received: by 2002:a50:c05a:0:b0:553:6eb3:e92 with SMTP id u26-20020a50c05a000000b005536eb30e92mr331774edd.35.1703147730543;
        Thu, 21 Dec 2023 00:35:30 -0800 (PST)
Received: from krava ([83.240.62.111])
        by smtp.gmail.com with ESMTPSA id ez11-20020a056402450b00b005532f5abaedsm859163edb.72.2023.12.21.00.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 00:35:30 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 21 Dec 2023 09:35:28 +0100
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: acme@kernel.org, quentin@isovalent.com, andrii.nakryiko@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves] pahole: Inject kfunc decl tags into BTF
Message-ID: <ZYP40EN9U9GKOu7x@krava>
References: <421d18942d6ad28625530a8b3247595dc05eb100.1703110747.git.dxu@dxuuu.xyz>
 <62ytcwvqvnd5wiyaic7iedfjlnh5qfclqqbsng3obx7rbpsrqv@3bjpvcep4zme>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62ytcwvqvnd5wiyaic7iedfjlnh5qfclqqbsng3obx7rbpsrqv@3bjpvcep4zme>

On Wed, Dec 20, 2023 at 11:37:01PM -0700, Daniel Xu wrote:
> On Wed, Dec 20, 2023 at 03:19:52PM -0700, Daniel Xu wrote:
> > This commit teaches pahole to parse symbols in .BTF_ids section in
> > vmlinux and discover exported kfuncs. Pahole then takes the list of
> > kfuncs and injects a BTF_KIND_DECL_TAG for each kfunc.
> >
> > This enables downstream users and tools to dynamically discover which
> > kfuncs are available on a system by parsing vmlinux or module BTF, both
> > available in /sys/kernel/btf.
> >
> > Example of encoding:
> >
> >         $ bpftool btf dump file .tmp_vmlinux.btf | rg DECL_TAG | wc -l
> >         388
> >
> >         $ bpftool btf dump file .tmp_vmlinux.btf | rg 68940
> >         [68940] FUNC 'bpf_xdp_get_xfrm_state' type_id=68939 linkage=static
> >         [128124] DECL_TAG 'kfunc' type_id=68940 component_idx=-1
> >
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> >  btf_encoder.c | 202 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 202 insertions(+)
> >
> 
> Hmm, looking more, seems like this will pick up non-kfunc functions as
> well. For example, kernel/trace/bpf_trace.c:
> 
> 
>         BTF_SET_START(btf_allowlist_d_path)
>         #ifdef CONFIG_SECURITY
>         BTF_ID(func, security_file_permission)
>         BTF_ID(func, security_inode_getattr)
>         BTF_ID(func, security_file_open)
>         #endif
>         #ifdef CONFIG_SECURITY_PATH
>         BTF_ID(func, security_path_truncate)
>         #endif
>         BTF_ID(func, vfs_truncate)
>         BTF_ID(func, vfs_fallocate)
>         BTF_ID(func, dentry_open)
>         BTF_ID(func, vfs_getattr)
>         BTF_ID(func, filp_close)
>         BTF_SET_END(btf_allowlist_d_path)

you need to pick up only 'BTF_ID(func, ...)' IDs that belongs to SET8 lists,
which are bounded by __BTF_ID__set8__<name> symbols, which also provide size

__BTF_ID__func_* symbol that has address inside the SET8 list is kfunc

> 
> Maybe we need a codemod from:
> 
>         BTF_ID(func, ...
> 
> to:
> 
>         BTF_ID(kfunc, ...

I think it's better to keep just 'func' and not to do anything special for
kfuncs in resolve_btfids logic to keep it simple

also it's going to be already in pahole so if we want to make a fix in future
you need to change pahole, resolve_btfids and possibly also kernel

jirka

> 
> 
> The change to resolve_btfids would be relatively small. Not sure what
> the drawbacks are yet.
> 
> One way or another we'll need to annotate the kfuncs in source.

