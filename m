Return-Path: <bpf+bounces-73580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4265BC34656
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 09:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63528188F7D1
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 08:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A0B2BFC8F;
	Wed,  5 Nov 2025 08:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FL0N+/S7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D03819D093
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762330003; cv=none; b=uqVrOE9JowUA/7FltwcPG16FRqjiDdiI39D6zQg+94prdMZQ+aaTWPKsWH7wdWYeIYy7dT9F+FrL4k2Y0OEd8rniCtl5il1IaJoY5ihdtaNSMZQKP3ElEkyH311AsoN4GFDP66FWW3jWnFK2+QKWz+OxN+z8pm1nNJREGWp4gBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762330003; c=relaxed/simple;
	bh=Uv7SDer7fJPRPl9nDSC257yOgldqh9OeKMmP2n3OgXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yyc78CzA6F6/1EIZA6AJWqbgeVK3Te0i2z68pOFRMAow/MeKK+2IU0s1Tg9B2RXoDv8glxDI58MLInDBohtpYQ6cYJcOhP+42V5QfUp9mJ68Df55HBNCzuNYAILGh/haiZoB4bUSXZFedfo6/j9GXzpFrKdEZQVlxaS8DWYX9uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FL0N+/S7; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64080ccf749so8543683a12.2
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 00:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762330000; x=1762934800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+OzouEQuO5rEyQeXXmlsr23WJFij52aHKE421nHJqfk=;
        b=FL0N+/S7x9pidwDcrCOyud7CcjzFwbiqh0+DoltQizqp0/6KG0FO1/IeV3ADRfOm9n
         cJEaB01RjnBanmK0aVsswlJ9gRlQ2pbJQ76idxe7Zsnu3FZUlwntwyULEAdGnjZMDU8n
         abCKbynjc2Ml/5YAJZCXMHnXBkj+m91wirxvFs9gvLf1k5YqRjlgwpGdauB+l4KpSxUq
         VtwFBUV84NdLk+r002PLuj53m1YgK03iHa7f9bDowkxQikfQDuUFjELyQ4IO6gtYVhmX
         Oqivr3oxnCo0yNbsLWIF4hNbLCmF2eiKm6i2o2wREZrAuRyE+sk1qLoKYiPZSoy5tdjm
         bJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762330000; x=1762934800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OzouEQuO5rEyQeXXmlsr23WJFij52aHKE421nHJqfk=;
        b=H7GWpvrylqGtzC/RcF5wwP6P44OFDhy8+6/zgQxGcO+kXBvNGWm2ccH9Q8+6H3D/6G
         6LJ5MvVdnOc6ppZNjmWa/nTPH4weSDFcTB/QBDRPd8yactuqzfdgew2Q3weVR+soZUHE
         JrLxYs7n9EcOJLH5kLGwyMHc4bi9JLhIhavlAKFPhtMmWZNtfGrC9c5cNSLUbpUH16O2
         mTh5lW+Nj+FIYvLm2uhRr7C0P+N7qmwLz6FXLV6rhA/aXz5TyrxVAODtSa5lNvliPR+t
         MMAlgChNTT/0EA/9sADQ9GW+7UH0iNFYGw4cvX/X27FI/IK9gjFPqIBwzuY4XZ/7VHqk
         3OLw==
X-Forwarded-Encrypted: i=1; AJvYcCXxErk+EgCmBaR6MB483x7e97tvpgp27CCExfJk82rSQDfPYcHP+marOdTQEo4F+dFr3D8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfMONyo+lzX3PUPOaXx5ZHZUVgFxHy0ATKCa/BsvXAo+b8peOY
	Qk304zAGIHUrhlMBvfkG+cxCbiu4qFqZ1KALVvaIjjrWxpFE4Z1sS0YW
X-Gm-Gg: ASbGncuSx8YEjAG2LS4KqKzS2NjPJ4LEr5R8rXied25UX0bFDCfbtxxgHpNbDYr07xB
	QY/Ysjr/cbi7Bq3z7A5HnleH7QCta9l3dZ46MygQQzEmPHQP83wS4WQvQB8gWInId23kU5emyly
	eU3awCa/dayaE42NjwHYgrQqzY7wNkOxrCq+2xBYzH2Z3++di3zl3z4RhSehAANXtsUBEziYsj3
	zSJBXJZHsKq9PRwfXmt0O86Bc2YYoVvJWfsDfzCjmNiblcQkKX8Qd1Fjl4jUCgfcPBVcxpOTsYG
	xDY7fykkxEeRq4k+eewpa0azvW0CO5shUAK4+E105+V4p6JVZkEpN/qSzExUteRm4phDMiLobEN
	VTSjWlLJ/CuYkcDu4m573fcbTdFEkg5YAmKtwaMHVFQCtijdwqne5dCjaJN7xUJyXAm3Vjuyb5a
	6rbmjD5ucDuB8O1TQY6t83
X-Google-Smtp-Source: AGHT+IEhJ0W+wQJgQoKctrcdRAymJcsxQdue6K0p0kz7XD1iXEN5BrmjE3//EvRLDRwUjfOiInn1kA==
X-Received: by 2002:a17:907:7256:b0:b6d:8ce4:ff18 with SMTP id a640c23a62f3a-b72651557c0mr208900766b.9.1762329998510;
        Wed, 05 Nov 2025 00:06:38 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723fa038f1sm416779766b.55.2025.11.05.00.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 00:06:38 -0800 (PST)
Date: Wed, 5 Nov 2025 08:12:52 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH v10 bpf-next 08/11] libbpf: support llvm-generated
 indirect jumps
Message-ID: <aQsHBJbvOro9QKLh@mail.gmail.com>
References: <20251102205722.3266908-1-a.s.protopopov@gmail.com>
 <20251102205722.3266908-9-a.s.protopopov@gmail.com>
 <4c9b089ea2c24b12d0d83f507c986d544f2c4e75.camel@gmail.com>
 <45c6e54a-d715-424e-b9c8-ad53956686da@linux.dev>
 <4c4ecade1a8297dada4c398a10aaa965ddf08399.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c4ecade1a8297dada4c398a10aaa965ddf08399.camel@gmail.com>

On 25/11/04 10:31AM, Eduard Zingerman wrote:
> On Mon, 2025-11-03 at 21:26 -0800, Yonghong Song wrote:
> 
> [...]
> 
> > > > +		if (subprog_idx >= 0) {
> > > > +			insn_off -= prog->subprogs[subprog_idx].sec_insn_off;
> > > > +			insn_off += prog->subprogs[subprog_idx].sub_insn_off;
> > > I'd like to reiterate my point about relocation related warnings [1]:
> > > 
> > >    > I'm seeing the following messages when rebuilding bpf_gotox using
> > >    > llvm main, where Yonghong added __BPF_FEATURE_GOTOX.
> > >    >
> > >    >     CLNG-BPF [test_progs-cpuv4] bpf_gotox.bpf.o
> > >    >     GEN-SKEL [test_progs-cpuv4] bpf_gotox.skel.h
> > >    >   libbpf: elf: skipping relo section(13) .rel.jumptables for section(6) .jumptables
> > >    >   libbpf: elf: skipping relo section(13) .rel.jumptables for section(6) .jumptables
> > > 
> > > In the context of Yonghong's reply [2].
> > > 
> > > I inserted some debug prints and confirm that these relocations are
> > > generated for basic block labels, e.g.:
> > > 
> > >    .S file corresponding to shortened bpf_gotox.c:
> > >        ...
> > >               gotox r1
> > >       .Ltmp25:
> > >       .Ltmp26:
> > >       .Ltmp27:                                # Block address taken
> > >       LBB0_5:                                 # %l1
> > >               #DEBUG_LABEL: one_jump_two_maps:l1
> > >               .loc    0 36 10 is_stmt 1               # progs/bpf_gotox.c:36:10
> > >       .Ltmp28:
> > >               w1 = *(u32 *)(r10 - 4)
> > >        ...
> > >               .section        .jumptables,"",@progbits
> > >      BPF.JT.0.0:
> > >              .quad   LBB0_5
> > > 
> > >    objdump --symbols, corresponding to same shortened bpf_gotox.c:
> > > 
> > >      Symbol table '.symtab' contains 18 entries:
> > >         Num:    Value          Size Type    Bind   Vis       Ndx Name
> > >           ...
> > >           2: 0000000000000000     0 SECTION LOCAL  DEFAULT     3 syscall
> > > 
> > >    objdump --relocations, corresponding to same shortened bpf_gotox.c:
> > > 
> > >      Relocation section '.rel.jumptables' at offset 0xde8 contains 4 entries:
> > >           Offset             Info             Type               Symbol's Value  Symbol's Name
> > >       0000000000000000  0000000200000002 R_BPF_64_ABS64         0000000000000000 syscall
> > >       ...
> > > 
> > > Here the first entry corresponds to LBB0_5 symbol, specifically:
> > > 
> > >                           Relocation type (R_BPF_64_ABS64).
> > >                               vvvvvvvv
> > >     0000000000000000  0000000200000002 R_BPF_64_ABS64         0000000000000000 syscall
> > >     ^^^^^^^^^^^^^^^^  ^^^^^^^^                                ^^^^^^^^^^^^^^^^
> > >     Offset at which   Section                                 Given that relocation type is
> > >     to apply the      index                                   R_BPF_64_ABS64, this is the value
> > >     relocation,       for 'syscall'.                          which has to be written at offset.
> > >     first jumptables                                          (See [3]).
> > >     record.
> > > 
> > > Given above, I conclude that:
> > > 
> > > - [to Anton] libbpf has to apply the relocations from .rel.jumptables
> > >    in order to assign correct the sec_insn_off for records in the jump
> > >    table.  Right now we imply that each record in the table corresponds
> > >    to a section where jump table is referenced from, but that is not
> > >    true.
> > > 
> > > - [to Yonghong] LLVM should generate a different relocation kind,
> > >    or a different "Symbol's Value", otherwise applying relocations as
> > >    instructed in [3] will lead to zeroes in the jump table:
> > >    
> > >    > In another case, R_BPF_64_ABS64 relocation type is used for normal
> > >    > 64-bit data. The actual to-be-relocated data is stored at
> > >    > r_offset and the read/write data bitsize is 64 (8 bytes). The
> > >    > relocation can be resolved with the symbol value plus implicit
> > >    > addend.
> > 
> > I think the following llvm patch
> >     https://github.com/llvm/llvm-project/pull/166301
> > should avoid jumptable relocation. The idea is originated from one of
> > Eduard's idea which put the label difference in the jump table entry.
> > Please give a try. I think it should work.
> 
> I tried Yonghong's llvm change, and it solves the issue.
> Relocations are no longer generated for .jumptables section.
> So, nothing to change on the libbpf side.

Thanks Eduard and Yonghong! It does work, I've removed the check from libbpf.

One additional change I had to do is to fix verifier_gotox not
to generate .jumptables.rel:

        SEC("socket")                                                   \
        OUTCOME                                                         \
        __naked void jump_table_ ## NAME(void)                          \
        {                                                               \
                asm volatile ("                                         \
                .pushsection .jumptables,\"\",@progbits;                \
        jt0_%=:                                                         \
-               .quad ret0_%=;                                          \
-               .quad ret1_%=;                                          \
+               .quad ret0_%= - socket;                                 \
+               .quad ret1_%= - socket;                                 \
                .size jt0_%=, 16;                                       \
                .global jt0_%=;                                         \
                .popsection;                                            \

(And alike in other subtests, of course.)

> [...]

