Return-Path: <bpf+bounces-57901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C8EAB1BD7
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 19:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C12B04A52FE
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 17:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B60215060;
	Fri,  9 May 2025 17:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GS3XVLfJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815E822CBF6
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 17:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746813495; cv=none; b=JWweKOrlLazsGE4ysjrnY5GVFm13ALMaLVNN/zp/3sschQTealDnW7/b0CfMmiQNCZZuc1vt6RF1UT4G65RQqDS9e5sHMIUSJv+E9r1cRs6dqBd19513mCrY/16YW9uUZhu2PohNuYKsnQVu+b/SKSEIM3XKH5FhAvlVO0Oz9vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746813495; c=relaxed/simple;
	bh=OmrylIdl1ejTJ1IY3F1XNmOPA7lXudYqAJw+rFLTCbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cbaak28+KQxPuTp6yE8szPzIFsA1uvmQ8eIXATeRa4IbBnSrO7pYcU1kyH2vku+4trqhbiEEZBSqZyfMPkq1JXKRqwOTgrtQ+sVKHWOOW9Q9uRqTz2npaaz6uLSvD9t7XbD9vNcsYx/MQ8IHpmjzwQ8VlJrxlL2qLzL6bQ/1w/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GS3XVLfJ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a0b646eff7so1951348f8f.2
        for <bpf@vger.kernel.org>; Fri, 09 May 2025 10:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746813492; x=1747418292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmrylIdl1ejTJ1IY3F1XNmOPA7lXudYqAJw+rFLTCbM=;
        b=GS3XVLfJSCr9uocXyScUsI6BWQhCkPn5vCzt9nzDsb+BWWEdeUk+eT94ZBw+9vbQCG
         4Dyhptj5Hf0bEzkdTg0pDGQR7P7JqhRVI/XWkJA9Ccjnkqm0KHTbOfvo82P9MMxdE6DP
         rh0UPp6u/aEaHOM9pFrydW0TLY6ENBS2CVB1/93n5hjPFaJxdqZbiBsWO5Vr/iajZn2k
         f26DdVpi4Ni9EajGUYhbBtiED1P2qxj9ohO0hZT0CEladNOTdgb98LcTmsBXgIQPJEG8
         K/31nRB4eF1Yu40Rd5szHXW740mx6CKADMPEMjYx3d0S/1oyAj35H608byU7siCClwt4
         FnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746813492; x=1747418292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OmrylIdl1ejTJ1IY3F1XNmOPA7lXudYqAJw+rFLTCbM=;
        b=ja3PJqVP0MsBlpZeqgDS6xM5kRUB5rpFuOOiP7LFtCgd13uKmORUhSRdqpB+T8Stt3
         srCimKgLkkfxr6PAyTAqggOuM34qN3hLzCHkefrQnznSPsJPynXdS8ZSAMD/Y34oDvas
         hs6v6onJIz7rRtJBJAA/ec6djMzGsexLthzbhDuA0GK6V8qoLke8ud7PvGuYbBkRYFAL
         16uGY0ntK4LtqfvW71j6kJgYw7vl7OpVyyyc3v5FSn47TSBIDAPyAbDAoEQYK829YnRw
         Jg+jtiDc3Jt+Fa90mz665JznkSw7aTCigGW++4DNr/zSkZCNwSFwIkb3JsPPBRgfwOnx
         0FkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhjAwXwsAr8vUrUdC6MiG2YibXK/aAUyKQ4y1Vm5dzFl2FgVNnzJ9/FX6ihm/px6GddWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBtUw9wqm1LPqk8HDDv0WQMGBHQsMzdi87whelX7h6hqIJ6h1b
	Gswix//oXmzLxsY72he8AZdhDdlQ0nJZm26t9VKRUVfgGSEyBVURid37bkyvaEMflUbTEOXkNWh
	XEVnjUhiZMkrunM5/ZFPr2TKV5+M=
X-Gm-Gg: ASbGncuifMEi5PafHdrcpgHgqSF2B6qWk1xo+3eFjFR0LGQwXyJDaHSas2j6JTdY2Mq
	sm+VgGl7k6yo5lVKoVlHH2WEppkwdWdPLqd4OtfesqJz/6gJEVDVlpKtuICv5Bkhd+F4nNwqcbE
	2gt7MXJkvZjPfYoV1Am8C8DtBaxWsbAW7khS5F8w==
X-Google-Smtp-Source: AGHT+IFcd5Jh4PFzIo712x84NHzk77k+wmldU1UuDQ1ovZt5VUoTIOUqiZfFCKhQ9moynTaoB26M0m8qy9huh386uMc=
X-Received: by 2002:a05:6000:2502:b0:3a0:aed9:e39 with SMTP id
 ffacd0b85a97d-3a1f646c6e3mr4016474f8f.28.1746813491657; Fri, 09 May 2025
 10:58:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aB0WvXLMx5DIivc-@mail.gmail.com> <CAADnVQK7m=B7qg_uWV_GguG7NA+H4Wk-Rz7XNckUw0fww8zW9A@mail.gmail.com>
 <1a803587-508c-4e73-9c06-344fb9330023@iogearbox.net>
In-Reply-To: <1a803587-508c-4e73-9c06-344fb9330023@iogearbox.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 May 2025 10:58:00 -0700
X-Gm-Features: AX0GCFvcJEN0orkv_U4sp5y-5d8T6ZAFfokJOxBDvPmTJcZvDuTbuKVQ6SUufB8
Message-ID: <CAADnVQJySbzjgMVC7+ENW=dXuU-CpN+XKHPgb+Q4twuMadmOMA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Always WARN_ONCE on verifier bugs
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 1:26=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> On 5/9/25 12:31 AM, Alexei Starovoitov wrote:
> > On Thu, May 8, 2025 at 1:40=E2=80=AFPM Paul Chaignon <paul.chaignon@gma=
il.com> wrote:
> >>
> >> Throughout the verifier's logic, there are multiple checks for
> >> inconsistent states that should never happen and would indicate a
> >> verifier bug. These bugs are typically logged in the verifier logs and
> >> sometimes preceded by a WARN_ONCE.
> >>
> >> This patch reworks these checks to consistently emit a verifier log AN=
D
> >> a warning. The consistent use of WARN_ONCE should help fuzzers (ex.
> >> syzkaller) expose any situation where they are actually able to reach
> >> one of those buggy verifier states.
> >
> > No. We cannot do it.
> > WARN_ONCE is for kernel level issues.
> > In some configs use panic_on_warn=3D1 too.
> > Whereas a verifier bug is contained within a verifier.
> > It will not bring the kernel down.
>
> Agree.
>
> > We should remove most of the existing WARN_ONCE instead.
> > Potentially replace them with pr_info_once().
>
> Just a thought, maybe one potential avenue could be to have an equivalent=
 of
> CONFIG_DEBUG_NET which we make a hard dependency of CONFIG_DEBUG_KERNEL s=
o that
> /noone/ enables this anywhere in production, and then fuzzers could use i=
t
> to their advantage. The default case for a DEBUG_BPF_WARN_ONCE would then=
 fall
> to BUILD_BUG_ON_INVALID() which lets compiler check validity but not gene=
rate
> code.

Good idea.
but I'm not a fan of the new kconfig.
I'd rather combine some of them.
Like make CONFIG_BPF_JIT depend on CONFIG_BPF_SYSCALL.
That would remove a ton of empty static inline helpers.

For this case doing WARN_ON only when IS_ENABLED(CONFIG_DEBUG_KERNEL)
should be fine.

I guess we can introduce BPF_WARN_ONCE() and friends family of macros
and use them everywhere in kernel/bpf/ where the warning is not
harmful to the kernel ?

