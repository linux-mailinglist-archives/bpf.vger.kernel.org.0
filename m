Return-Path: <bpf+bounces-18856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5B78229B3
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 09:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2235D28514C
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 08:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD2F18057;
	Wed,  3 Jan 2024 08:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwikvksU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2928182D2
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 08:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55676f1faa9so1778219a12.0
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 00:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704271692; x=1704876492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WGZclCGmcTikwD7GJZ/vhwKT44C4N1TfJGNaO0t6u2U=;
        b=FwikvksUvLuNFAFcZITg6xmF0bQs15WMjqv5+RO4aNaVSYqXGWrW1xnPmZc1OKRq1m
         m9XpkUWvW38bjRpO/4CCa0Kt6TRnocxgfsMVjk6lo1VCL2o4JeB/oZ9e/cF0zjFNkyhn
         fNxcOYLRqz2KhI4OaSpD5cAZx5AtuA5HEnMHZ6q/V8oQoL6geDXh+t8NwehMUwhaTVYj
         5nD7R+xlr2Hp1v/CBqWp5/J8vgKFYJqdyqO1oqfYXoq/gdAgaYYpk3AZGCYainF5oXtW
         K+dRsqQQvAYrHhHrRyHrwq1/uXnaoVyX98fdS5JvQcMdiUjL6w626LDQgbfZKvKTKETH
         CP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704271692; x=1704876492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGZclCGmcTikwD7GJZ/vhwKT44C4N1TfJGNaO0t6u2U=;
        b=FZRWMq2f72jw2sC04Ar7DF7BxISvpWzhGIzWVKHD+qjbhMQMVZNFn/F3FsacXcyw+6
         gXbjP+JtsuUVtRd1eaeQKMd7TFF0d9Lu9ceJXXh3HuUNUGMIxqQzRZd8G92Fn1yl0nCJ
         tWm7FBwfVkUZrI2ZJ/WvesMMv+8IsW4vJ0DgE7oatEayvGYZoElXJItnwRnXR3ggR4f8
         3hb+nFQvdfCDjmX5WBoFOR5xhO7/HnjaOcq46m+wbvEm6HQwgFCSdoDy+4UvpmtmMJDO
         4x1kBoI0kXKSA4aOZDmH0cVCvrhLVisU8wStGusej1llkRTRRHwoVlBuobuhCa5DMdCf
         BOIw==
X-Gm-Message-State: AOJu0YzjWl5SO3BF8lGKj/JBCz1SVGXgZFU2+Cb5ZqYb6sU1A/bY9iDB
	Ca0Q2PMVxwjnuLTTELiM5rieMW7z2mA=
X-Google-Smtp-Source: AGHT+IFt3G6Z2PIklSIk8bgu+806kk3AKX/qNxoRV8Fq1jCVntikUVlvssVaNHRzHLyrVuNsZkv5Yw==
X-Received: by 2002:a50:9e47:0:b0:555:8ce3:a9f6 with SMTP id z65-20020a509e47000000b005558ce3a9f6mr4942382ede.3.1704271691635;
        Wed, 03 Jan 2024 00:48:11 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id u8-20020aa7d548000000b00551cddfc5b8sm17016179edr.5.2024.01.03.00.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 00:48:11 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 3 Jan 2024 09:48:09 +0100
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Jiri Olsa <olsajiri@gmail.com>, acme@kernel.org, quentin@isovalent.com,
	andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net,
	bpf@vger.kernel.org, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH dwarves] pahole: Inject kfunc decl tags into BTF
Message-ID: <ZZUfSQPFNOLfnL0l@krava>
References: <421d18942d6ad28625530a8b3247595dc05eb100.1703110747.git.dxu@dxuuu.xyz>
 <62ytcwvqvnd5wiyaic7iedfjlnh5qfclqqbsng3obx7rbpsrqv@3bjpvcep4zme>
 <ZYP40EN9U9GKOu7x@krava>
 <pciti5oczkgz3lti5auqj3r7do6luceb6jena3cfwhh3u2fcua@sk7xbxq7hmch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pciti5oczkgz3lti5auqj3r7do6luceb6jena3cfwhh3u2fcua@sk7xbxq7hmch>

On Tue, Jan 02, 2024 at 05:56:02PM -0700, Daniel Xu wrote:
> On Thu, Dec 21, 2023 at 09:35:28AM +0100, Jiri Olsa wrote:
> > On Wed, Dec 20, 2023 at 11:37:01PM -0700, Daniel Xu wrote:
> > > On Wed, Dec 20, 2023 at 03:19:52PM -0700, Daniel Xu wrote:
> > > > This commit teaches pahole to parse symbols in .BTF_ids section in
> > > > vmlinux and discover exported kfuncs. Pahole then takes the list of
> > > > kfuncs and injects a BTF_KIND_DECL_TAG for each kfunc.
> > > >
> > > > This enables downstream users and tools to dynamically discover which
> > > > kfuncs are available on a system by parsing vmlinux or module BTF, both
> > > > available in /sys/kernel/btf.
> > > >
> > > > Example of encoding:
> > > >
> > > >         $ bpftool btf dump file .tmp_vmlinux.btf | rg DECL_TAG | wc -l
> > > >         388
> > > >
> > > >         $ bpftool btf dump file .tmp_vmlinux.btf | rg 68940
> > > >         [68940] FUNC 'bpf_xdp_get_xfrm_state' type_id=68939 linkage=static
> > > >         [128124] DECL_TAG 'kfunc' type_id=68940 component_idx=-1
> > > >
> > > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > > > ---
> > > >  btf_encoder.c | 202 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 202 insertions(+)
> > > >
> > > 
> > > Hmm, looking more, seems like this will pick up non-kfunc functions as
> > > well. For example, kernel/trace/bpf_trace.c:
> > > 
> > > 
> > >         BTF_SET_START(btf_allowlist_d_path)
> > >         #ifdef CONFIG_SECURITY
> > >         BTF_ID(func, security_file_permission)
> > >         BTF_ID(func, security_inode_getattr)
> > >         BTF_ID(func, security_file_open)
> > >         #endif
> > >         #ifdef CONFIG_SECURITY_PATH
> > >         BTF_ID(func, security_path_truncate)
> > >         #endif
> > >         BTF_ID(func, vfs_truncate)
> > >         BTF_ID(func, vfs_fallocate)
> > >         BTF_ID(func, dentry_open)
> > >         BTF_ID(func, vfs_getattr)
> > >         BTF_ID(func, filp_close)
> > >         BTF_SET_END(btf_allowlist_d_path)
> > 
> > you need to pick up only 'BTF_ID(func, ...)' IDs that belongs to SET8 lists,
> > which are bounded by __BTF_ID__set8__<name> symbols, which also provide size
> > 
> > __BTF_ID__func_* symbol that has address inside the SET8 list is kfunc
> 
> I managed to add that logic. But I did some spot checks and it looks
> like SET8 lists are not quite limited to kfuncs. For example, in
> net/mptcp/bpf.c:
> 
>         BTF_SET8_START(bpf_mptcp_fmodret_ids)
>         BTF_ID_FLAGS(func, update_socket_protocol)
>         BTF_SET8_END(bpf_mptcp_fmodret_ids)
> 
>         static const struct btf_kfunc_id_set bpf_mptcp_fmodret_set = {
>                 .owner = THIS_MODULE,
>                 .set   = &bpf_mptcp_fmodret_ids,
>         };
> 
> And in net/socket.c:
> 
>         __bpf_hook_start();
>         __weak noinline int update_socket_protocol(int family, int type, int protocol)
>         {
>                 return protocol;
>         }
>         __bpf_hook_end();
> 
> IOW, update_socket_protocol() is a hook, not a kfunc.

hum, right.. we use kfuncs set8 registration now also to mark attachable
hooks for fmodret programs, see [1]

there are similar hooks registered in HID code as well

[1] 5b481acab4ce bpf: do not rely on ALLOW_ERROR_INJECTION for fmod_ret)

> 
> > 
> > > 
> > > Maybe we need a codemod from:
> > > 
> > >         BTF_ID(func, ...
> > > 
> > > to:
> > > 
> > >         BTF_ID(kfunc, ...
> > 
> > I think it's better to keep just 'func' and not to do anything special for
> > kfuncs in resolve_btfids logic to keep it simple
> > 
> > also it's going to be already in pahole so if we want to make a fix in future
> > you need to change pahole, resolve_btfids and possibly also kernel
> 
> So maybe special annotation is still needed. WDYT?

anyway, it looks like we actually do have flags field in set8 (thanks Kumar! ;-) )

	struct btf_id_set8 {
		u32 cnt;
		u32 flags;
		struct {
			u32 id;
			u32 flags;
		} pairs[];
	};

it's not mentioned in the commit changelog [2], but it looks like it was
added just to keep data aligned, and AFAICS it's not used anywhere

how about we add a flag saying this set8 has kfuncs in it

jirka


[2] ab21d6063c01 bpf: Introduce 8-byte BTF set

