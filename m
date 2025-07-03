Return-Path: <bpf+bounces-62323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDB4AF810E
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 21:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C227954724D
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 19:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0882F236B;
	Thu,  3 Jul 2025 18:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jl8OG6di"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79BCBE5E
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 18:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751569092; cv=none; b=Czx14zQ5eVhpEBZ3HT5yRTnhy6GFlyA8X+I8HjVS8bM8El927kJ3eL7I+PWiC/NFK71yEGtFW+H/wfkMQeyo8JTcWm2E1UbyHq6uUk1YQHM6Sqr7U+sWoHJWVqyfT/TtlHBP6Qn+fnYpibFdB4GvZclbs8h9dJanpZy0A8J+Eew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751569092; c=relaxed/simple;
	bh=J8DivPb9+tinMn3/Rk5hzCuZd8RTSM7w9vllsMrucZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yn31upI0Q8Mq0+svR/rqtsSv+K22v98szK0nXPaVpAeqTMHxzPzFhPE/GJgKy945OXw8Q/2UpPSuLVxxu1no5688awNun0nxVX2sbSDVw31l9C4kOfipfshrULVnhJv0hmpgte/4xUXgJ/x6QheHvuWN/bbySAsWnqjRv62Mo5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jl8OG6di; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-451d6ade159so1837925e9.1
        for <bpf@vger.kernel.org>; Thu, 03 Jul 2025 11:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751569089; x=1752173889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eDzNsvrMQlVg0hFOiWPuvKro4LC7wPqPAshN0O1HGHE=;
        b=Jl8OG6diHt/Dm5yKJOLsd12H2isO4JIqoTWb+7bbVjdmgwlqbuSykDH2/uMCgmpZUs
         TIR4klOSH1evxa18AcY1MVUSRM17j4GibecrrTKhDoIF5zuiHnbtlVHWKK69gLuF5sv7
         5N/GAQ0pQJjCub6Xl1KuSBgrHib2VyfiUKUla/pY7/9TRUEqc+Aa/DfnPvVMZM96U+kB
         KPXzfz47QOtHFx+JuoF7fQKKOZ3xGsOXrlikuC0vSi87M4lY5mKipZdF2guPCNYxL8v/
         2G5emJrEA1Re6Ah2rYgidZFyqksUkeQboFgXXkeDJ4cHB3/iEqNhJXhmCOM/TP5b2Scv
         7gQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751569089; x=1752173889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDzNsvrMQlVg0hFOiWPuvKro4LC7wPqPAshN0O1HGHE=;
        b=Onr29AZRE5E2Vb6bYvPFH+6yYKj8sT4VklpZ8byGTkATDqZLmbEEwT3D5AILgLPtqU
         OkxaDorETHB0od4dhjsHkxwMOMauZQPGbUb7q7TlLDflMSfBiPVpY05cfsdoy1YqV7oc
         Ha0PZJGM98Boci6GFvnmTnj9E2AeGyETshppWh56g1Mel95cWZLHOriAuIz881pB/TRJ
         hyqWfUHCS2hD+udZ0jrj7i07pHxTN0t9tVPuARZbeb3n/gE9U1aaAE93d6by0Vei9PBG
         F+ySFFbvdjH9+ZYBxWm1JSsTX0Mg3xrvfa3gt8MrF5l7Vg7mm1gvmeUCPoWT5OiTkU5w
         +QxQ==
X-Gm-Message-State: AOJu0YzpMYl/nBbGur5RM2K0TDb5EZqPW3gpLo2WRdZ33n61YhyTEewc
	VUH3x/xXVWp0i9LRSJRHo+fwJ+v2vbdctfRtrIALw55fadWr1DNcbpWw
X-Gm-Gg: ASbGncsvWAo7KvMlQCRcsvxCnvtrsg4FnzS3b97MO+sRRDGfg0pmOFLhJIV+c03/6NT
	msHci5IFq0WNCfvxBvaA/2diQXw3+ICTQDuE89WsiROr6Lw4T6TqQuvW4pgP7XKOJNoW/VRegT/
	vOIvF+4jcWh5LT7r10A2Uan4c7DS9Ter3nMAntxu7TvctE0+yiZk9eNS2I5UMXJCJIbr9zIvcah
	Xgq8VAYkA3YeYStMrRgX9DMBkvBzmqbh7JDuvs7d31AwZNd8vlOSFpt2/MsTqg/kRHwa8qbBNY2
	03X7YI6sT+qSHclsQmOLAKaGWiEcTA7v7Nuua0rB7iHeuwyy5S0jHkB2X9OIsnYLUbGRWl7gOw=
	=
X-Google-Smtp-Source: AGHT+IEMFNREqgBkmG9kbVJMoS9yoSJ/jAiVXdU1RBE3W3qat+SI6QZ2v870HKOhK/tebYBGthmx+Q==
X-Received: by 2002:a05:600c:871a:b0:445:1984:247d with SMTP id 5b1f17b1804b1-454b26b3446mr121005e9.7.1751569088694;
        Thu, 03 Jul 2025 11:58:08 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47225a720sm468896f8f.77.2025.07.03.11.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 11:58:08 -0700 (PDT)
Date: Thu, 3 Jul 2025 19:03:57 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [RFC bpf-next 8/9] libbpf: support llvm-generated indirect jumps
Message-ID: <aGbUHfcggEa/hHZj@mail.gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
 <20250615085943.3871208-9-a.s.protopopov@gmail.com>
 <1c17cd755a3e8865ad06baad86d42e42e289439a.camel@gmail.com>
 <f8bc4e5469e73b99943ff7783fbe4a7758bbbe32.camel@gmail.com>
 <aF5v8Yw5LUgVDgjB@mail.gmail.com>
 <454128db01c0a01f3459783cd5a0ea37af01c34e.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454128db01c0a01f3459783cd5a0ea37af01c34e.camel@gmail.com>

On 25/07/03 11:21AM, Eduard Zingerman wrote:
> On Fri, 2025-06-27 at 10:18 +0000, Anton Protopopov wrote:
> > On 25/06/26 07:28PM, Eduard Zingerman wrote:
> > > On Wed, 2025-06-18 at 12:49 -0700, Eduard Zingerman wrote:
> > > > On Sun, 2025-06-15 at 08:59 +0000, Anton Protopopov wrote:
> > > > 
> > > > [...]
> > > > 
> > > > > @@ -698,6 +712,14 @@ struct bpf_object {
> > > > >  	bool has_subcalls;
> > > > >  	bool has_rodata;
> > > > >  
> > > > > +	const void *rodata;
> > > > > +	size_t rodata_size;
> > > > > +	int rodata_map_fd;
> > > > 
> > > > This is sort-of strange, that jump table metadata resides in one
> > > > section, while jump section itself is in .rodata. Wouldn't it be
> > > > simpler make LLVM emit all jump tables info in one section?
> > > > Also note that Elf_Sym has name, section index, value and size,
> > > > hence symbols defined for jump table section can encode jump tables.
> > > > E.g. the following implementation seems more intuitive:
> > > > 
> > > >   .jumptables
> > > >     <subprog-rel-off-0>
> > > >     <subprog-rel-off-1> | <--- jump table #1 symbol:
> > > >     <subprog-rel-off-2> |        .size = 2   // number of entries in the jump table
> > > >     ...                          .value = 1  // offset within .jumptables
> > > >     <subprog-rel-off-N>                          ^
> > > >                                                  |
> > > >   .text                                          |
> > > >     ...                                          |
> > > >     <insn-N>     <------ relocation referencing -'
> > > >     ...                  jump table #1 symbol
> > > 
> > > Anton, Yonghong,
> > > 
> > > I talked to Alexei about this yesterday and we agreed that the above
> > > arrangement (separate jump tables section, separate symbols for each
> > > individual jump table) makes sense on two counts:
> > > - there is no need for jump table to occupy space in .rodata at
> > >   runtime, actual offsets are read from map object;
> > > - it simplifies processing on libbpf side, as there is no need to
> > >   visit both .rodata and jump table size sections.
> > > 
> > > Wdyt?
> > 
> > Yes, this seems more straightforward. Also this will look ~ the same
> > for used-defined (= non-llvm-generated) jump tables.
> > 
> > Yonghong, what do you think, are there any problems with this?
> > Also, how complex this would be to directly link a gotox instruction
> > to a particular jump table? (For a switch, for "user-defined" jump
> > tables this is obviously easy to do.)
> 
> I think I know how to hack this:
> - in BPFAsmPrinter add a function generating a global symbol for jump
>   table (same as MachineFunction::getJTISymbol(), but that one always
>   produces a private symbol (one starting with "L"));
> - override TargetLowering::getPICJumpTableRelocBaseExpr to use the
>   above function;
> - modify BPFMCInstLower::Lower to use the above function;
> - override AsmPrinter::emitJumpTableInfo, a simplified version of the
>   original one:
>   - a loop over all jump tables:
> 	- before each jump table emit start global symbol
> 	- after each jump table emit temporary symbol to mark jt end
> 	- set jump table symbol size to
> 		OutStreamer->emitELFSize(StartSym,
> 		                         MCBinaryExpr::createSub(MCSymbolRefExpr::create(EndSym, OutContext),
> 								 MCSymbolRefExpr::create(StartSym, OutContext),
> 								 OutContext)
> 	- use AsmPrinter::emitJumpTableEntry to emit individual jump table
>       entries;
> - plus the code to create jump tables section.
> 
> I should be able to share the code for this tomorrow or on the weekend.

Would be great, thanks a lot for looking into this! I will
try to address other comments by about the same time. (I am
now in the middle of the list or so.)

