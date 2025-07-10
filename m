Return-Path: <bpf+bounces-62922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47004B005CB
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 16:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B3E54772D
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 14:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FD52741C9;
	Thu, 10 Jul 2025 14:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H70rhRaI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0AB273D91
	for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752159113; cv=none; b=gtajGJ84r2dOZsH7AeJfEZeB66Wc6lQDAnG5rb2flJALmBSp1FWt7rW7dXTPggMI9A4v6PizhbVbNhCaNI7X9RFBPDQdbu5hyoEOVTIIqUY7e86abyYBMgRvNQzKPKuvsZw7EDcI18USE6eB/TlMR9/YDULdro7fwGxeZ/EawaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752159113; c=relaxed/simple;
	bh=X/u+IqPG3TSlztV4LkiGZmn/hGIoBFjgMa8f6CT1j5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuXeAzdTu8Jzz9GdidKNfoNQDrQXyVwHCeTIwfytDzkRwKQKCRl2yIWWOW1/rb9Lp1YfP4YuISo5Gnu+Qo46rUZpW85alslGXynWY7ptb5lor/YyW7hn/XmDVKtiaWeKekZ49Vh9JbZ1kFITm8vgyNVU62RGcTeeNnFzc9IL5FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H70rhRaI; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-454df871875so2467645e9.0
        for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 07:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752159110; x=1752763910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KH3l7xSht23pIvklA77IjqezpBbprKaHOMDn0v+7PuA=;
        b=H70rhRaIlA6plAJ10Ek/nQqof1R6Sybp5tj1ZF22QjuF7eZ4NO4OKk8rWvhdvFQ//s
         iSGXkPdOl4PJYxiYfIOGzLSgeIvnDLjjuWVvVcfXONPxfFtjsN8NVNV+hEzBfJHyivhg
         1w+Aj8aXFFkH5b3JQFgt5na+b9XCkSVXPf+ZxflpLzXaHJpJJvkA1tDiSJ4EzQPG48zp
         8tz0BI+53DwxYfU4A1bl4C4GEetl0L4ikr1W8KnBY0XabBQaVO3HfpD6ltjogvEiAcB6
         hCyVzTMph6N3ONPNUMNHC1QOvoKFr9SVzk9eK/bN0KSP6oMuK6waapLWJakVz+wtxqFR
         P6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752159110; x=1752763910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KH3l7xSht23pIvklA77IjqezpBbprKaHOMDn0v+7PuA=;
        b=uFJzHDY6NCbr+OwFX/CPteILOrRYKu/DbkJsPPMae1QmU24JpQCIeR6dyCXhTlKuI8
         A3gmzKFA8IIv8qEU5daCaI2H7Y7wMNzAbcPu9ZWd25mcq8oL/qnfgNMp+h271/5dJ+TP
         5OMwh65+VLfuRvjLRm02YTpy2KELK7UWllUcgFByuQcqjRKDXfQFojDVYpPYuQUAR2eS
         yS8/kpVcepk9M6gcIciQJw8g0KG0xUi7zAiHdBAkhz8mra+9Sjua1QrcDdpb5kfL1nEN
         9SVfa4epWE8qWLbJxwmvnkmx+hW32IRbTaSp71PFaw9TOPfPUT3yAeaINVvd9mvXhtIi
         OewQ==
X-Gm-Message-State: AOJu0YwnvT3tEsbIFliDPv0rJODUdy3p89UugIkSWHvK2f1L3ioM4yoW
	cctfOVV72LS0/MUF93Rj2Ho2U0Bmqt/kOwgPHbauTp/An8sloHJ27sTDuM0Quy82
X-Gm-Gg: ASbGncvJmdpSe6uxVx+X5ntb3o6PT9bDPoPw4KYv+kwfMKT6MJn+IAqiRXaHBOl0reD
	rstiDH91CyxyxEmtXDo0z1M61dJN0MGCCQ7EQsp7Udj+oWWU45O7IzSgx5lCsLEHFkj5gH5UsCK
	94bDzHNMsCpm0z2ADC1G3sMSA3Ds4efif5cDvlMcJNqZjMX5WTefD6iaEDWHsMWFo/VhoCe22Eo
	IikfohdAk+9TeykoYO4E4k5cl6BI8wvR/BbiZVOQaW5Q1tZe29eWCDJK2PzBOH5BZH0i5w7dkjk
	+W4n0ofcIRq7E3sYvDKkK3gmBxakyEgc2HL2Cf+/VjEQQx4qTXJ7dcQ8z50M0VBJotxjnyNVP/D
	UHzNAPmC3rybsjMn2Jehr2dwvdSn7TGIN0TV1TLQWiG2/iXMFFup94JKMuNVOjA==
X-Google-Smtp-Source: AGHT+IGj8Fk3wwpAwIzyjd5kjx4PfOgwkIYi3DTid8OLnKLzx0BxZLJR6Z3bpEHkzRTcCjYytL2ecQ==
X-Received: by 2002:a05:600c:548d:b0:454:ac5d:3919 with SMTP id 5b1f17b1804b1-454d530eb35mr66490155e9.2.1752159109548;
        Thu, 10 Jul 2025 07:51:49 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00939f1ea551223a20.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:939f:1ea5:5122:3a20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd537c6fsm22248875e9.21.2025.07.10.07.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 07:51:49 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:51:47 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Forget ranges when refining tnum after
 JSET
Message-ID: <aG_Tg6rfexLf3qOl@mail.gmail.com>
References: <75b3af3d315d60c1c5bfc8e3929ac69bb57d5cea.1752099022.git.paul.chaignon@gmail.com>
 <ba1b52e3-a938-4ead-943c-267e4c06b1ae@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba1b52e3-a938-4ead-943c-267e4c06b1ae@linux.dev>

On Wed, Jul 09, 2025 at 04:57:28PM -0700, Yonghong Song wrote:
> 
> 
> On 7/9/25 3:26 PM, Paul Chaignon wrote:
> > Syzbot reported a kernel warning due to a range invariant violation on
> > the following BPF program.
> > 
> >    0: call bpf_get_netns_cookie
> >    1: if r0 == 0 goto <exit>
> >    2: if r0 & Oxffffffff goto <exit>
> > 
> > The issue is on the path where we fall through both jumps.
> > 
> > That path is unreachable at runtime: after insn 1, we know r0 != 0, but
> > with the sign extension on the jset, we would only fallthrough insn 2
> > if r0 == 0. Unfortunately, is_branch_taken() isn't currently able to
> > figure this out, so the verifier walks all branches. The verifier then
> > refines the register bounds using the second condition and we end
> > up with inconsistent bounds on this unreachable path:
> > 
> >    1: if r0 == 0 goto <exit>
> >      r0: u64=[0x1, 0xffffffffffffffff] var_off=(0, 0xffffffffffffffff)
> >    2: if r0 & 0xffffffff goto <exit>
> >      r0 before reg_bounds_sync: u64=[0x1, 0xffffffffffffffff] var_off=(0, 0)
> >      r0 after reg_bounds_sync:  u64=[0x1, 0] var_off=(0, 0)
> > 
> > Improving the range refinement for JSET to cover all cases is tricky. We
> > also don't expect many users to rely on JSET given LLVM doesn't generate
> > those instructions. So instead of reducing false positives due to JSETs,
> > Eduard suggested we forget the ranges whenever we're narrowing tnums
> > after a JSET. This patch implements that approach.
> > 
> > Reported-by: syzbot+c711ce17dd78e5d4fdcf@syzkaller.appspotmail.com
> > Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> > Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> > ---
> >   kernel/bpf/verifier.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 53007182b46b..e2fcea860755 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -16208,6 +16208,10 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
> >   		if (!is_reg_const(reg2, is_jmp32))
> >   			break;
> >   		val = reg_const_value(reg2, is_jmp32);
> > +		/* Forget the ranges before narrowing tnums, to avoid invariant
> > +		 * violations if we're on a dead branch.
> > +		 */
> > +		__mark_reg_unbounded(reg1);
> >   		if (is_jmp32) {
> >   			t = tnum_and(tnum_subreg(reg1->var_off), tnum_const(~val));
> >   			reg1->var_off = tnum_with_subreg(reg1->var_off, t);
> 
> The CI reports some invariant violation:
>   https://github.com/kernel-patches/bpf/actions/runs/16182458904/job/45681940946?pr=9283

AFAICS, these invariant violations predate this change. They seem to be
expected and caused by selftests crossing_64_bit_signed_boundary_2 and
crossing_32_bit_signed_boundary_2 which are both marked as "known
invariants violation". They look like fairly different violations as
they are not caused by JSET instructions.

I think it's still worth having the above change for JSET because we
lose only the ranges and not the tnums, whereas with an invariant
violation, we lose all info on the register. I'm looking into the two
other invariant violations to see if there's anything we can improve
there.

> 
> [ 283.030177] ------------[ cut here ]------------ [ 283.030517] verifier
> bug: REG INVARIANTS VIOLATION (false_reg2): range bounds violation
> u64=[0x8000000000000010, 0x800000000000000f] s64=[0x8000000000000010,
> 0x800000000000000f] u32=[0x10, 0xf] s32=[0x10, 0xf]
> var_off=(0x8000000000000000, 0x1f)(1)
> [ 283.032139] WARNING: CPU: 0 PID: 103 at kernel/bpf/verifier.c:2689
> reg_bounds_sanity_check+0x1dd/0x1f0 ... Probably this change triggered some
> other violations. Please take a look.
> 

