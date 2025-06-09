Return-Path: <bpf+bounces-60102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B21AD2923
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 00:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA37118922C0
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 22:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7749F224889;
	Mon,  9 Jun 2025 22:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cfMfkQG8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525BD21CA02
	for <bpf@vger.kernel.org>; Mon,  9 Jun 2025 22:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749506545; cv=none; b=fK2OxoHhsxcYP+9VhArxR+pLNAWhfmb9XfgVrNtUEA9LjYMEqCegUpaGbNHcW8z+3B0/QBFh3jmhEQqRab4M+BMUm0kfvrihjvvoGq+eFzwGRDN4soMqfczGWxR874GLmVJ3qriAUMkk2jzMFkdfCmobQKlrMXC1bAEPfa+ik3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749506545; c=relaxed/simple;
	bh=vJ7vwoEH/pDxChm0RuJpIo6mifBRQChAuirwu8RlfXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDT569OvMU3zYatZBx5iSOutaxBAO8dWPDTa7w0DoLJ7rxEcEHrjzylQqwXGDFkvpvLhl/sn6hTIeEfAkw+MwCuK4kiz3prNaUEvnjtQtoG9ensSxQZVpzIoCDQfQKewgK3x75eckPEApMtQisf109Em3g4TVyb/OvPyg8al7kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cfMfkQG8; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6024087086dso1032a12.0
        for <bpf@vger.kernel.org>; Mon, 09 Jun 2025 15:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749506542; x=1750111342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bCk3OwXgakmShms97NNqM6EdI2vclTH5gJUQ/SWU7Oc=;
        b=cfMfkQG8HeMltrwp5Dq1g/jQ3b+OImUltKeL0d4+xknG0uSItjut7kt6Z+/2ZQHFHR
         lSF3T91QFR5YKStebpHrOlMYNY0tUf0yc1hsBFvrwZlMZlj2CPSl3ZaBmSFZYqGBZz3K
         SqBiaSsSdefOX6j004fUS6ghZQKVB4D7J+FPrasMO/Owlug1ZvTA0EKDcqrCu+P4Vu1L
         yDqQphykAdhF6sUUUbELo1o3yUrkiKbNHFeOrJN8/IFAb/dN9Azvt5QMKdqNcItKoyVW
         6XXPGfo1spbvd8gHLBTax8+2VBbioUO3NQiNoX+xpKxBerlV47a/cP8BP8+2eSFuHnR3
         EQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749506542; x=1750111342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bCk3OwXgakmShms97NNqM6EdI2vclTH5gJUQ/SWU7Oc=;
        b=BL2WfNKPUXxJR1+LUt6/VEvAnCRadWJvRikfhPT3TM40ocEqgCSczyL76uAWx+F9Ob
         a7Wlt2qUyVZ8xkQ9Ir7EldjPpryOqvqOGg6NY2Qt+jM04ub+/30eUpD+nnvFJqR737GI
         fjgzLPI3T0tselRpuqb93fnp3LClHhICzmbyky/l32aEc/Lmg6EeyBPEvaNKLnqdojZb
         HjokmcgxJT0BChqN1mVNRwOfucxlFT3Y1lNjb84MscOLP8/TXkq4E9U6cJFWdv2yKgi6
         mbjwMOpcUc4rweh/H6Z/Z1m/6yvuNbd3zKwtt9QIAhcR0IHyYMBwBe3a9Gx9aMYgqne1
         vR7A==
X-Forwarded-Encrypted: i=1; AJvYcCXqG2U15eJ4Pqv1k0veT7Lhgo2dHwxxlYEF0kh39J5ff9XV9ipixWg+us5y6ULkRnwqK9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPdSdfW/Mj3i3/Q5o3WAnZqCWYNVBBhdVmn731RtWYHY3nDpgT
	t5cedZDLqU5jaXWapiUqiX0bmhTKiN4uPkyTocDSh7LZAz1jFafEX7nqjRWQ3cHg2t+F9OCxlKa
	AdPUlEMI8+e/7IhOFUG/A7+QiDINcBj67Su0mRIgy
X-Gm-Gg: ASbGncufyP1qZkchPBlM007YC0tw92wJLY55oPMXjW6NlGOytufYEf2zjNSsfJC5gsc
	+yArn5OsuYdYNu9LN/0UYiqiziclM5cULwuuK+x0TKEblXM40Bhy7BBfL8VzKxj+AJeHgJRxPGl
	sgWc/jySAQZsd77RPjaomrSCLRdVxLUGL0YEpajjzoGZbjjas/HcTZc9lC1ZgRUq5Gs6L9R4mzO
	HqFBv+L7XqDHQ==
X-Google-Smtp-Source: AGHT+IEbyIF7CSd+WRJZbLDF/+Itzq7vC/RRb8uqa3+Uo1W4YpTLoFUlg6mNBUmA1xLYGDFVl3NHkQUFqIXtjt2kWeU=
X-Received: by 2002:a05:6402:da:b0:607:e1f1:ecf0 with SMTP id
 4fb4d7f45d1cf-607e1f1ed58mr132174a12.3.1749506541446; Mon, 09 Jun 2025
 15:02:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250607204734.1588964-1-kuba@kernel.org> <CANP3RGcUbSG3dQQbDrsYq9YSMStXbmEsq6U34jcieA_45H4_JQ@mail.gmail.com>
 <20250609145928.014a72c6@kernel.org>
In-Reply-To: <20250609145928.014a72c6@kernel.org>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Tue, 10 Jun 2025 00:02:09 +0200
X-Gm-Features: AX0GCFutj74rlH_Ud09IHNAnLPpkxULmxSrij6mqjJUQJhxSAN9xsb13A9CPzro
Message-ID: <CANP3RGc+BjY-7LRFZmeXLqXVAbf3aYce=_H-Ru7B2sw8O+mbGQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net: clear the dst when changing skb protocol
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, martin.lau@linux.dev, john.fastabend@gmail.com, 
	eddyz87@gmail.com, sdf@fomichev.me, haoluo@google.com, willemb@google.com, 
	william.xuanziyang@huawei.com, alan.maguire@oracle.com, bpf@vger.kernel.org, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 11:59=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 7 Jun 2025 23:33:39 +0200 Maciej =C5=BBenczykowski wrote:
> > 1 meta question: as this is a fix and will thus be backported into
> > 5.4+ LTS, should this be split into two patches? Either making the
> > test a follow up, or even going with only the crash fix in patch 1 and
> > putting the 4-in-4 and 6-in-6 behavioural change in patch 2?  We'd end
> > up in the same state at tip of tree... but it would affect the LTS
> > backports.  Honestly I'm not even sure what's best.
>
> :) Did we go from wondering if we can strip dst unconditionally to
> wondering if stripping it on encap/decap may introduce regressions?

Yeah, well I have utterly enough regression chasing in my day job.

Just spent two days chasing this fun one.

enum bpf_cmd {
        BPF_MAP_CREATE,
...
        BPF_PROG_DETACH,
        BPF_GET_COMM_HASH,    <--- added
        BPF_PROG_TEST_RUN,
...
        BPF_OBJ_GET_INFO_BY_FD,
};

> I suppose it may be useful to split, just to make it clear which
> portion of the change is the crash fix and which one is just because
> we think it's more consistent.

Your call.
> --
> pw-bot: cr

--
Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google

