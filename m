Return-Path: <bpf+bounces-20688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C55F5841D89
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 09:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C00528D526
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 08:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458846A340;
	Tue, 30 Jan 2024 08:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTaaweuJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D54355C2D;
	Tue, 30 Jan 2024 08:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706602540; cv=none; b=BYE1Cf31sxUed7d4ib1mQ07GJxUih05cvbu4l+8LvtVe+vl1iZ+MHEYstZTf1fA1CPUDa1kplLz6yz5XZ084nbhd5IvGcJEtb5TAfSBo0s86Pe/F/PZNVdmuCUaOf7QfTFHK2ErVwJzZ87rGTDMRqipqnc2w2/+XFdMzZRq7o/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706602540; c=relaxed/simple;
	bh=zcBiUnh0+FoPyWXm+vLSKyGSXfIq6oNcDKyh+2nVAvk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YU6YxpQpLhG8iVD/8FD/nfUM7j+0VvyiHX6amOMFN5ORIRyvbE9USSPFxw+EhzmdyeuieDGFUSiCJF1DXeXI6iG4nt4PJhDsdQdyvzvTMkuVNlRwszm5YbMDB/vx3YTkA3r3B38h/lfG5fHGbVUp0Jh1yEwbofZcpuaurgDRIf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTaaweuJ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55a9008c185so6333312a12.1;
        Tue, 30 Jan 2024 00:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706602537; x=1707207337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MLUH2MrbJbyTg2PanUyjcCyUfWbIFdefagwcMnDabUw=;
        b=lTaaweuJWxGbt4Xz/y0vJbh6WxRCbpWpwehYI3JtVPEJ3ZSGpdAxj5LYynDoGwjp5p
         0ul7qJV7Awcr8FOdyeBWSABVHG+YP/IiibtEtzPhxfbNDpWCdeTiJWGc/P3SqlyQPCi8
         Duc+UWWrdkB9g/BjANlQYw0mk512H7qpfJnoLFIE1soG3//rCuJjip8soSulrtfnxpEG
         9xygh73PI6vZb4yxJtY8D4rUm6gxbw/tY3N64QOHXdOD0N4zUrFbDJjlSDKFwIIeUEL9
         z/UzUzDFmWh9nqFIBTmJ/izbUSjm+UbfjiLLQINlfJM1qrEXJNaLib0o1KLw2tAxySWJ
         lSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706602537; x=1707207337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLUH2MrbJbyTg2PanUyjcCyUfWbIFdefagwcMnDabUw=;
        b=VmEL0Smm9thZIEBwohtxuo8rKaaXb94H7uKri+6USrxa+s6xfBCC1jJhT+XU9fTlXT
         h5PQ5bUERKOqfmUT3cVNqFMv0y0xPhY8Z6vIYCN7PIojH/cmEM5y7T7GeluXzR7d/f79
         4K+bKafX/MjtxyZjhjvSWT+s7sXIcUCGcFCNMs3Uezzs5jpqDyxZFbL/GSlGzlKqE8Qs
         XjSOs2RR9QcFki4idnVNviyvQMSQsbxy+JbiLXTHEDZEXytxjl2jEO5gl0lh/Ec8Z2K6
         55UPP4uNSLy1133Tv1gefvGMRr0FgxXp198JXBaBu1+ULku7GanV2kwPNndDiJjOnU1g
         QjlQ==
X-Gm-Message-State: AOJu0YzSrPzty3cZKx95T4QHaNMlXTf07Hh0GULFJ+llxaOdbUci4/Np
	+V4i4T8pg1h30/jKnDvSZdbFae4N+mQmUmF6WHV//q+V3ZOUdgDw
X-Google-Smtp-Source: AGHT+IHmbVaKEFFu5UC6wRDiDl9tlq36I8zO0g8kbmj94fbSOk7KyNY1q6pubajKfZ15ODIg9oUScw==
X-Received: by 2002:a50:9e82:0:b0:55e:eb6e:ff51 with SMTP id a2-20020a509e82000000b0055eeb6eff51mr803378edf.12.1706602536959;
        Tue, 30 Jan 2024 00:15:36 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id p14-20020a056402500e00b0055c67e6454asm4652639eda.70.2024.01.30.00.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 00:15:36 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 30 Jan 2024 09:15:33 +0100
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Jiri Olsa <olsajiri@gmail.com>, quentin@isovalent.com,
	daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org,
	alexei.starovoitov@gmail.com, alan.maguire@oracle.com,
	memxor@gmail.com, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpftool: Support dumping kfunc prototypes from
 BTF
Message-ID: <ZbiwJcfN6snXZ0Vn@krava>
References: <373d86f4c26c0ebf5046b6627c8988fa75ea7a1d.1706492080.git.dxu@dxuuu.xyz>
 <ZbeV5adWhiNZu5xj@krava>
 <spuzs32tv6v5czb76gstpvisv2xkfzz2scqw4hmqncflhxoj66@hie6m7pctfdo>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <spuzs32tv6v5czb76gstpvisv2xkfzz2scqw4hmqncflhxoj66@hie6m7pctfdo>

On Mon, Jan 29, 2024 at 09:13:13AM -0700, Daniel Xu wrote:
> Hi Jiri,
> 
> On Mon, Jan 29, 2024 at 01:11:17PM +0100, Jiri Olsa wrote:
> > On Sun, Jan 28, 2024 at 06:35:33PM -0700, Daniel Xu wrote:
> > > This patch enables dumping kfunc prototypes from bpftool. This is useful
> > > b/c with this patch, end users will no longer have to manually define
> > > kfunc prototypes. For the kernel tree, this also means we can drop
> > > kfunc prototypes from:
> > > 
> > >         tools/testing/selftests/bpf/bpf_kfuncs.h
> > >         tools/testing/selftests/bpf/bpf_experimental.h
> > > 
> > > Example usage:
> > > 
> > >         $ make PAHOLE=/home/dxu/dev/pahole/build/pahole -j30 vmlinux
> > > 
> > >         $ ./tools/bpf/bpftool/bpftool btf dump file ./vmlinux format c | rg "__ksym;" | head -3
> > >         extern void cgroup_rstat_updated(struct cgroup * cgrp, int cpu) __ksym;
> > >         extern void cgroup_rstat_flush(struct cgroup * cgrp) __ksym;
> > >         extern struct bpf_key * bpf_lookup_user_key(u32 serial, u64 flags) __ksym;
> > 
> > hi,
> > I'm getting following declaration for bpf_rbtree_add_impl:
> > 
> > 	extern int bpf_rbtree_add_impl(struct bpf_rb_root * root, struct bpf_rb_node * node, bool (struct bpf_rb_node *, const struct bpf_rb_node *)* less, void * meta__ign, u64 off) __ksym; 
> > 
> > and it fails to compile with:
> > 
> > 	In file included from skeleton/pid_iter.bpf.c:3:
> > 	./vmlinux.h:164511:141: error: expected ')'
> > 	 164511 | extern int bpf_rbtree_add_impl(struct bpf_rb_root * root, struct bpf_rb_node * node, bool (struct bpf_rb_node *, const struct bpf_rb_node *)* less, void * meta__ign, u64 off) __ksym;
> > 		|                                                                                                                                             ^
> > 	./vmlinux.h:164511:31: note: to match this '('
> > 	 164511 | extern int bpf_rbtree_add_impl(struct bpf_rb_root * root, struct bpf_rb_node * node, bool (struct bpf_rb_node *, const struct bpf_rb_node *)* less, void * meta__ign, u64 off) __ksym;
> > 
> > looks like the btf_dumper_type_only won't dump function pointer argument
> > properly.. I guess we should fix that, but looking at the other stuff in
> > vmlinux.h like *_ops struct we can print function pointers properly, so
> > perhaps another way around is to use btf_dumper interface instead
> 
> Ah, crap, looks like between all the branch switching I didn't build
> vmlinux with kfunc annotations. Having fixed that, I can repro this
> build failure.
> 
> I'll take a look and see what the best way to fix this is.
> 
> Given that end to end the whole flow basically works, should we start
> working on merging patches?

yes, the flow looks good to me.. will check the rest of the patches

jirka

