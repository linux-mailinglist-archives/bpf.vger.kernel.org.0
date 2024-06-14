Return-Path: <bpf+bounces-32202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CA99092EB
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 21:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49E95B254A5
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 19:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B844E1A38EF;
	Fri, 14 Jun 2024 19:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="go2Eu4j/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98CA148836;
	Fri, 14 Jun 2024 19:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718393227; cv=none; b=UM75SbUzDF+GowKDuueYjFViZJ/hFln5W2ZFl+/GjDjCKhU16zDpp2zyJcDTlWpCdti7ulXmC8mFicQFVDhymED9SIF3vdiHZzzHg/B8Fw2R2JXDKW2PI4D25rZQ4fx43fBmhoeovxkfH4+Y2EOTmPL58PfRGd/dqErijos4SXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718393227; c=relaxed/simple;
	bh=35nCSzvM8kCj1i7vnYnO/mrxOdXV2sc3Q/F9sfkJAOc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihRyv5O+Almroh9eAy1DxVchkH/yT58lDzQGaoX0ccURt8n2RWynivhPhCPM8DutckIPIFLu5M4Sd/1IS92woEwWteAV7dgyApxlAgUYPxOz3ord+5xcGrj4uZ7Ve0pLYJ3uLFXlJ4yzIJcOfW0A/4TPgrVp/GWVThBnONn/RZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=go2Eu4j/; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57ca578ce8dso3005870a12.2;
        Fri, 14 Jun 2024 12:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718393224; x=1718998024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N/f45cUWEGs5NCDhyksDKpsG/5a7jeEGEkHeXxZvwig=;
        b=go2Eu4j/PImXlbuTEChpaD4fPHSE7L15xEatrCWJhrS2MBCz/dxdS5qD09tYP5AKWQ
         ssD20+qLqEPn+SoeKEA3Y2/8yZm2KMLuFbmrz01v4R+aH5gUpqiM7mDIugtArcSsaJrC
         RV5mCWzB2xM8vHvvVyxwLzgezRsidi5uEdtaZjpVWSeKMAhdznGzerS1yUeflaOVGhFE
         QQ1XhfLvDo+dbrqHnbepYapwSAU8H66DU5UUGb9c1bYft9B/3tfpbm7S4KDJuT9VdW9F
         7xM9xuJ5zHqrCTZQPmyN6ag2eaQySwZDBrRu6/zakG0R9asWfmCC7e8X/D+dtfGxrbwh
         K6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718393224; x=1718998024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/f45cUWEGs5NCDhyksDKpsG/5a7jeEGEkHeXxZvwig=;
        b=Cs05IvDblJxFoWRclzJjWiTcO+AATZHCLkWfILEX+tuusBhx0sxBsGfFEkA0APWWW1
         V+6myTTn+MMMUeuHVpJP7xlx0/hYpWledSBAqCx6UjowSjdprs1yWurpCwyzwhE/sXNy
         h4sf7YWT4iILbhRg87Jezy6PiJqNyFEhT2/k6Qo1F/nJQQylMcWXg0xCuFazpasMaF/d
         hnB7QN5htuJ3Ja/POqPor+VsmgJruwtwYlJLU9dLRwmUVP9Mi03KSbIdMFWN2bGHLSG8
         8K+5ZsXDKg9K94AOC00u8D4ln8UuOAP4qip85URf7smBWY+iTwxrae/+HoVeO/q+V4Pv
         G8iA==
X-Forwarded-Encrypted: i=1; AJvYcCVc+eJwiyeW8bmU7HunmuD6V4gIWdxg/ou7BnuCyCgEqIYjAv0HkvIjIhZHfRMbd5rvB40nWOQnGuQ3z99zuhz/s23d7sgBNdIjwAKVoyQ2vSwmZnv4/r8Q1sKMfpDAWRUhmD3Y+VB61+uhsV+ofid81cWA2g3gsC9GR9iVEQh09TqRJcvkdD37Ap6Cm7D9GWWsnpod/pEAnflyvmlOmulyaWime0mYmklcwUtduj3ASBd5DbxoneNlLF54
X-Gm-Message-State: AOJu0Ywh0d85l5GkWhBii8JkLGoGACSZpZH5sIRhd6gxm2IIGeOsDsEg
	u3fSPSpFBaXzDhSZlEX+jkd/U9QjOrZaIeRG2neHTNcQSCyrGNAv
X-Google-Smtp-Source: AGHT+IE5P2ppWpL73Yodf7MQMfk0pnKefj/Rj7aJgWIatWunL9deqlc5gXv5FoQ7KDjv22ttI6eDEw==
X-Received: by 2002:a05:6402:520d:b0:57c:c166:ba6 with SMTP id 4fb4d7f45d1cf-57cc1660fc5mr2433523a12.19.1718393223504;
        Fri, 14 Jun 2024 12:27:03 -0700 (PDT)
Received: from krava (85-193-35-172.rib.o2.cz. [85.193.35.172])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72cdfc4sm2607662a12.19.2024.06.14.12.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 12:27:03 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 14 Jun 2024 21:26:59 +0200
To: Nathan Chancellor <nathan@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-man@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev
Subject: Re: [PATCHv8 bpf-next 3/9] uprobe: Add uretprobe syscall to speed up
 return probe
Message-ID: <ZmyZgzqsowkGyqmH@krava>
References: <20240611112158.40795-1-jolsa@kernel.org>
 <20240611112158.40795-4-jolsa@kernel.org>
 <20240614174822.GA1185149@thelio-3990X>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614174822.GA1185149@thelio-3990X>

On Fri, Jun 14, 2024 at 10:48:22AM -0700, Nathan Chancellor wrote:
> Hi Jiri,
> 
> On Tue, Jun 11, 2024 at 01:21:52PM +0200, Jiri Olsa wrote:
> > Adding uretprobe syscall instead of trap to speed up return probe.
> ...
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 2c83ba776fc7..2816e65729ac 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -1474,11 +1474,20 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
> >  	return ret;
> >  }
> >  
> > +void * __weak arch_uprobe_trampoline(unsigned long *psize)
> > +{
> > +	static uprobe_opcode_t insn = UPROBE_SWBP_INSN;
> 
> This change as commit ff474a78cef5 ("uprobe: Add uretprobe syscall to
> speed up return probe") in -next causes the following build error for
> ARCH=loongarch allmodconfig:
> 
>   In file included from include/linux/uprobes.h:49,
>                    from include/linux/mm_types.h:16,
>                    from include/linux/mmzone.h:22,
>                    from include/linux/gfp.h:7,
>                    from include/linux/xarray.h:16,
>                    from include/linux/list_lru.h:14,
>                    from include/linux/fs.h:13,
>                    from include/linux/highmem.h:5,
>                    from kernel/events/uprobes.c:13:
>   kernel/events/uprobes.c: In function 'arch_uprobe_trampoline':
>   arch/loongarch/include/asm/uprobes.h:12:33: error: initializer element is not constant
>      12 | #define UPROBE_SWBP_INSN        larch_insn_gen_break(BRK_UPROBE_BP)
>         |                                 ^~~~~~~~~~~~~~~~~~~~
>   kernel/events/uprobes.c:1479:39: note: in expansion of macro 'UPROBE_SWBP_INSN'
>    1479 |         static uprobe_opcode_t insn = UPROBE_SWBP_INSN;

reproduced, could you please try the change below

thanks,
jirka


---
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2816e65729ac..6986bd993702 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1476,8 +1476,9 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 
 void * __weak arch_uprobe_trampoline(unsigned long *psize)
 {
-	static uprobe_opcode_t insn = UPROBE_SWBP_INSN;
+	static uprobe_opcode_t insn;
 
+	insn = insn ?: UPROBE_SWBP_INSN;
 	*psize = UPROBE_SWBP_INSN_SIZE;
 	return &insn;
 }

