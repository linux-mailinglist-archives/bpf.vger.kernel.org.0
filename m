Return-Path: <bpf+bounces-57694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 099AFAAE8DE
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 20:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31FE1BA28EF
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 18:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED6D28E561;
	Wed,  7 May 2025 18:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvKTBGUB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F47928B4F9;
	Wed,  7 May 2025 18:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746641910; cv=none; b=dMbnH7wb56Ev5uIwYBK9Gh+k5ht8AkyZ4Vy3hf0R4bDiM0AQPHrQHpY5c4Y0v6Hv1EQxJWvvSbSewlsSvFN3DJWV9FYXFIL0IIoKM1mFykA4Bi5tDBLUBlWEMCtYcrKyn9LK5laQngbHUAaY/oINwkuez3A03Z5dJvPM5b14Ee8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746641910; c=relaxed/simple;
	bh=F+Xnu6PQbi3T4Wkg/GHyn4Jj0vjwAEy6UneJsbqIPv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O73L03vYX/cLO9JUDsYTxeIolz0h/SI/CQ34ve6p4hGFRjG+hh3soUzqGuENuakz/Ep41zej65br5XugtTcILiNDu+5te60zhVa4wZmeNc45WRCpoq2wq/8+Rs5nnPHk5lu3RYDu5/pPUm4fNueJ7p7KSaLFylhByurywQWDoCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvKTBGUB; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-736aaeed234so245646b3a.0;
        Wed, 07 May 2025 11:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746641908; x=1747246708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ykkdjkXW3JCGwoicQaugKr7maJVyx5Tj8MypKlbh5U=;
        b=BvKTBGUB/0OVdnk9LHX2NxYkzqjFlnlURZ/wEqLOpGMk6FiO7OpYgyShq8GCAxJ9ly
         RP1OZ+9lUHDvqadyJwWWhN2D99LEUMOh9Uaw3ms+ruwOygaFrrmZTBmrPUJ2zOs5P1u+
         hUODuj8bcTirqiYNnWB/CcR7jbV0agXjbpD8jtIMej8K60Fnfli6UWsSVOz/LrnQqcgo
         uyU4kR0MeJwTkatvkkRsSIYRvJA9lFbBpfLEQpuUIi0hK5SaZrsd1/KRQib8kgmbtWEI
         oksxeUzLSfEJw+kvIypXzWM0+bIO53XrErHVjVuqjSlIoyTOSxYf7LKIsIL0m4t9X2r/
         ioNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746641908; x=1747246708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ykkdjkXW3JCGwoicQaugKr7maJVyx5Tj8MypKlbh5U=;
        b=pmmasT7Z9rm9gHPoo8CobJ/qnO1ICHdBBLQ4t7jdO+kgCZGPIDk1jIw9HvW7tX4zHD
         TljsqWJsGSz0pHsjmIJdqsVEa1mFXfBGobHiEeRN2SIA+AI70qqppsRxZSQ3AY8SVhNT
         /C70VyqvaqT5GydNFOfs0J8/za92RNLyNosYA2CMeJvdSmhVfkOFmyDA6dEKOeZ0dVvE
         dm5FJnknvmnzdL4GlmMD9fciJ2RjgOqcskAxtwHlcaHWwT0vCDlN8esY+4Mg10t0+CRw
         FQ8m5yrbMDhUh3pEpYpoivZ4t5vCBL4/kEVAZhzE/s4APeEiNGynZOJpV0rvFx8pu2AL
         sewA==
X-Forwarded-Encrypted: i=1; AJvYcCV2yN2oOAUMIanOlUvAvfiT/U/hJ59v1ZM7OBPxmKaTMO16stV8J1BKDKMzUjZzWLGXPNy4gTEO7i0VgE3OHV6pdQ==@vger.kernel.org, AJvYcCWrnu1wnARoM/RgVrU3M0ZI6FbRpfWRxdFhBjTScE5z0cXqGV6MhVWVsL1OcdvGwHqYTE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDU8LQsBQm/7jSUEwgP13lDlXZQ7jqscfrrdUXogjQoFLOb20B
	Fz0oBetuXQ5eKv7KkFwWsWZgeAGe7yqnYTtEzaDE9HAMkfqF7JNuXDZ+5j/2y7M513/kb7olOcL
	aReRSj04B9rI6jGEjyzHeIJWa9k4=
X-Gm-Gg: ASbGncv44jEsHF6D4cof92udIsSLeC7r52YPrTZssn7IxjQVUqApkR5gcJiBkgPnkvF
	YpSVRI6Wuik/gGruXPC3Jd1S/mDPKSzjj2TqrgxU0se+etRnbPAPNjsTbM24TcRwSiPDkxbKpf+
	7KwWrI9rmPdnFAUCw0k2psQcxnQoJgCQJUJFo2JFVnwu4TlYl6
X-Google-Smtp-Source: AGHT+IEwrG04KfvN0Sm5IMEbJ31M92rsLJW5TODK5sQZ2RUKu4hFOhM/oejl+e88Nd9DQsT8cYykc74cVHm/k8rNnEQ=
X-Received: by 2002:a05:6a20:3952:b0:1f5:5b77:3818 with SMTP id
 adf61e73a8af0-2159b01b23bmr280952637.27.1746641908429; Wed, 07 May 2025
 11:18:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506135727.3977467-1-jolsa@kernel.org> <20250506135727.3977467-4-jolsa@kernel.org>
 <CAEf4Bzbpn8kQV8ORoBv7iDR1VxT0uUf=qqjanFQFtFx1fSjrQQ@mail.gmail.com>
 <aBsgQw1kzJsRzM5p@krava> <1392a5c9-f67b-49fe-9f05-f2bc63fe01bb@kernel.org>
In-Reply-To: <1392a5c9-f67b-49fe-9f05-f2bc63fe01bb@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 7 May 2025 11:18:15 -0700
X-Gm-Features: ATxdqUG9qEGa0gANWEJhzjvfK9b_Pt_XTKW096PXo3aMsFz6Rq3SZcpdKwec2Wg
Message-ID: <CAEf4Bzar5Ai5WdaFvSPR_z8izoTE_Wejo-pewaH2FtQbm=nd7w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] bpftool: Display ref_ctr_offset for uprobe
 link info
To: Quentin Monnet <qmo@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 2:40=E2=80=AFAM Quentin Monnet <qmo@kernel.org> wrot=
e:
>
> 2025-05-07 10:56 UTC+0200 ~ Jiri Olsa <olsajiri@gmail.com>
> > On Tue, May 06, 2025 at 03:33:33PM -0700, Andrii Nakryiko wrote:
> >> On Tue, May 6, 2025 at 6:58=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wr=
ote:
> >>>
> >>> Adding support to display ref_ctr_offset in link output, like:
> >>>
> >>>   # bpftool link
> >>>   ...
> >>>   42: perf_event  prog 174
> >>>           uprobe /proc/self/exe+0x102f13  cookie 3735928559  ref_ctr_=
offset 50500538
> >>
> >> let's use hex for ref_ctr_offset?
> >
> > I had that, then I saw cookie was dec ;-) either way is fine for me
>
> I'm fine either way, but let's use the same base for the two values
> please. If you want to change the cookie to hexa (in the plain output)
> for better readability, that's OK as well (JSON output needs to remain a
> decimal in both cases, of course).

Why should cookie and offset use the same base? Offset is always
address-like, so hex makes most sense there, 100%. But a cookie is
most probably going to be some small value (index into array, or small
number representing attachment point number, etc), so decimal is most
natural. Importantly, BPF cookie can't really be a pointer (what will
you do with it on BPF side?), so it's something a bit more
human-driven, and thus decimal seems like a better default.

>
> Quentin

