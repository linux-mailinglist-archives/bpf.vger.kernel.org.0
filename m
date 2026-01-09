Return-Path: <bpf+bounces-78269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B78AD06B91
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 02:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E21E630399A1
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 01:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B409223DE5;
	Fri,  9 Jan 2026 01:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mq3X+gkd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD64233D9C
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 01:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767921524; cv=none; b=uyMzQ0LJFjgSJmLOhfTazMDOAyMIg+COIgUq+2SLwpcWnFKT17pL0VtG8ULbJk8jkImDjg+HREBmvnvy6mgl6hDhXSaiICD7IpLhADrAWr/CngOWT4Ml9BjUVZB9quv5eUhFfD3m0OT+nE5tIDjA1vs/7q0Ap+1lQEIJTtsSdE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767921524; c=relaxed/simple;
	bh=kPupsil01lWK94Mn8krMH0uzEvHSP7my6LVeKbDgX7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QVJ3C7ZmjbcGFj9aJBqMCBgbAWocaxvFhaNZLdSGuZVXcEooo2evq2oZKy7z9P6ehHVptvcfDgSwMWec4CTvcQJn2zzuVx1bcufONa3am+7prfLQJH9CORccAB5Gxbby15X7ziVESYjuIANcxM/npRezNPRricEVImDw4BiYEjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mq3X+gkd; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42fb2314eb0so3002293f8f.2
        for <bpf@vger.kernel.org>; Thu, 08 Jan 2026 17:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767921521; x=1768526321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JBuddKJ+z3FxzaqAzQ7zcqFkWaUpFxAn79lcA8MJu0=;
        b=Mq3X+gkd/PE7pnHmqrcwVBruIvzSOuRs1EcZ/4msADDNNnUIHiqodCFTw8mFrpvlnI
         ZFJBsxoza1mqm0HlmBaevPQtL7qvgDHDcrJpq5en38D+1k/jdv8106l3tc+SogsCkAWe
         oo0Cjz27FVKiTFs2AAk52VNZUV6BBkGXy56XupKjNNkBR8N3iGy0SiENXCcpDmxv9DcM
         VgdHHLubpyUpHSeba3KX0jzJ6vgOMKTneJl1dNCjJs53VBWpg2BR/mI1P6I4UUR3dCuJ
         s/LhDsE2FMeL2KeVwzfAM7IjU5R84vZdi9tYLRtzPx9BnWh3CUFAywWjukv9kSAe7KxP
         L0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767921521; x=1768526321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9JBuddKJ+z3FxzaqAzQ7zcqFkWaUpFxAn79lcA8MJu0=;
        b=ovvmc6p7ZNVA8NJRm+fn1hwGaaYzwKOiz+wNwzjULBV8IjAd5T+lZthK+1Bh/G5QnE
         8cqivNHm9pUY0dc/Y0lUQS2mB3Bp6FPz8pPv4A3cUeLa/rGHVdJEYuml2i7M9CToi3vk
         OZrYLHVzqkOxAOfXod6uTCn0oXNDukmdfINgCzLTsEs4yKd4+TcWv5GStPKyTM5+3YQD
         ibrhZv90qLeXiwT1MfB5n5p2cUasiGeFjRoVGwyM//zmJ7k9SXb0uiQFpbn+NHVqQnoC
         Utcbl/ssa1yMGWRDHy6pJLmpqXt47e4DHXdf+mzEv4rNldEBm4SgI3COmEw1qowbeoAV
         0skA==
X-Forwarded-Encrypted: i=1; AJvYcCUqiPLh0po6/5vKIMTaEtHSWBqdm+8YkJwlPFT1RX+omOHPLkZ5iqFqj67T9qIYb4Vb/DA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYwFo+COi1JC1/X9+DmV9lF+MDWtFKo7Iww9eUkyhvog04yKf5
	mLB4mKSlyUfc1IXZfV7CJyd6wjPDXdV9YpaoqUGUgszG4Y4uAWaPFgUisZm/YCmKABBPzw2BdRO
	DlACKWyIn2N7QNvVRPCDj93+EaDaxHd4=
X-Gm-Gg: AY/fxX6Y9soW6+NFXvBQ9N1oHIdmtUBztoZQbwYx8+lCpzIthab24ZhqqI+7Tqer2WM
	JJZHdkDU2VxVgG1fkpXcaKufUIKA/wW+wnHqGH2n/bEqO/YnQnk/PDa+oWWDWP/tN5wryhJ2rQ9
	WuBBvS83AoMVxOVbMOfSX+oETxFPRNIf4J06iag5E+P50YcHPid7x9mdqK6W3oMN8PDdXSnNA1/
	TxuByYo/y5NmijdbJuJLBlGwWfVAflrmyrHH+rhmWtymT2f30q7ljoekUjYbV0zDtspT1cH+2RG
	l23+mHNC38sFGQf0/oH/m5sWRArE
X-Google-Smtp-Source: AGHT+IHnI1HmWbYy6Ms67lVPBSw3Zeb2ctE6Z7OTIaWk2d8XivX4r7IQkAhKpEyPawzUd/iJ9v+fL9wr9Bl4LEtQZzA=
X-Received: by 2002:a05:6000:184d:b0:431:3a5:d9c1 with SMTP id
 ffacd0b85a97d-432c37c8701mr9866318f8f.30.1767921520974; Thu, 08 Jan 2026
 17:18:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260103022310.935686-1-puranjay@kernel.org> <20260103022310.935686-2-puranjay@kernel.org>
 <CAEf4BzYeF2sUqEzfT6aLuBVuh1W8fkxHoFjBf-e5nvJW9UgQLw@mail.gmail.com>
 <CANk7y0j_BW_t7Y6rPm-UaCsamJ6G3S9i5_0cYLWZ56xp1Dehkw@mail.gmail.com> <cf707af183cd296c33576e478c5ba5f561350b43.camel@gmail.com>
In-Reply-To: <cf707af183cd296c33576e478c5ba5f561350b43.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 8 Jan 2026 17:18:29 -0800
X-Gm-Features: AZwV_Qj5aIS8ToPLauwbk0Ba_04vzUQ9y5hhjtqR8gGtE4xAn1kshP5-QfAfb_A
Message-ID: <CAADnVQ+wK8qYt=Gm=Q26Kh_enOHGOk7_t8FX70J08WUMu5y_Nw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Recognize special arithmetic shift
 in the verifier
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Puranjay Mohan <puranjay12@gmail.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Kernel Team <kernel-team@meta.com>, 
	Hao Sun <sunhao.th@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 10:45=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2026-01-08 at 18:28 +0000, Puranjay Mohan wrote:
>
> [...]
>
> > This is what you see when you compare this version (fork before and)
> > and previous (fork after arsh) on the selftests added in this set:
> >
> > ../../veristat/src/veristat -C -e file,prog,states,insns -f
> > "insns_pct>1" fork_after_arsh fork_before_and
> > File                   Program  States (A)  States (B)  States (DIFF)
> > Insns (A)  Insns (B)  Insns (DIFF)
> > ---------------------  -------  ----------  ----------  -------------
> > ---------  ---------  ------------
> > verifier_subreg.bpf.o  arsh_31           1           1    +0 (+0.00%)
> >        12         11   -1 (-8.33%)
> > verifier_subreg.bpf.o  arsh_63           1           1    +0 (+0.00%)
> >        12         11   -1 (-8.33%)
>
> Given that difference is very small, I'd prefer forking after arsh.

why?
I thought last time we discussed the conclusion was to fork it
before AND, since at the time of ARSH the range is still properly represent=
ed,
so reason to take chances and do it early.

> Could you please take a cursory look at DAGCombiner implementation and
> try to check if there are other patterns that use arsh or arsh+and is
> the only one?

Well, it's in commit log:

  // select_cc setlt X, 0, A, 0 -> and (sra X, size(X)-1), A
  // select_cc setgt X, 0, A, 0 -> and (not (sra X, size(X)-1)), A

I suspect 2nd case should work with 'before AND' approach too,
since 'not' should be compiled into XOR which suppose to [-1,0] ->
into the same [-1, 0]
But better to double check, of course.

