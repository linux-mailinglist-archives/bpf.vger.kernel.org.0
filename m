Return-Path: <bpf+bounces-59537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB04ACCE43
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 22:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9E8F16FA4D
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 20:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56143200B99;
	Tue,  3 Jun 2025 20:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FFaIgmgy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476F31A0B08
	for <bpf@vger.kernel.org>; Tue,  3 Jun 2025 20:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748982994; cv=none; b=F7XhUH1VRP7Od9j+pe5w5V3NOrP+FLnhw4pSQCDmmgql/Uxa2rHOKPTuersj9EICLPs35Wv3LvJxNU8szDl1GzhLg4VKBMyMahI0fsmL6k7EhS5E7LvRnqerrCp0/JGDDNCWHWWM067lUe9B7QX4EcFAJL0rURVihRoctaP5RsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748982994; c=relaxed/simple;
	bh=yfm0amT5NtwY4hnU1FL15bhuF3XOKunYKYTy7ZjhN84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XxMOCgY7gHswoGP9mrWBb0gboytZowQZKBPbYg/9lNl9lDlPlOkcD6OcaAjL5/rtA5NGVhRSicslpY+z4a63Kx1LocjE0VSt/VjQiYmIm/A8Ed8m0MU8S46QJQ3LhS0MXScbI020w0u0eCW+Yut8Riz+AXAooI7aXnwXlypvi0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FFaIgmgy; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-52617ceae0dso2128583e0c.0
        for <bpf@vger.kernel.org>; Tue, 03 Jun 2025 13:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748982992; x=1749587792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgkRH+3yLQUgKV5wOSUdEvO3hRUeuun/3TUnglkvQDw=;
        b=FFaIgmgy8V0Mf86VDojKovRSRnMDCGIORBJQzvSwzuixIuuukl+LrMEQD+WsbaJdes
         oO5VDrPb4vuxtQ8afhfnqQawAMFcOaQdYi5el4Q1JJ4+rOqZo4P9x8F5Ynvvy+D9+dPJ
         rUqQlnd2gdKwHQ7PdoUpD1CqPdWqlZuCTRiNTlia2p5R6/tfMqAirNku/yK4Ek1ire+1
         rAgrsGZ7FxtuI/NdcfVO40HXwrHht52RsgVEU93RXV9cwO201GbxPZLGnL1el5ZvP0sX
         NYE6CE1Tv05wZb80KaX21x1UL3hjOBDIoqoyGj0vr5qekv5RGTdFyByFP8Fn3pGbPSUq
         JA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748982992; x=1749587792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IgkRH+3yLQUgKV5wOSUdEvO3hRUeuun/3TUnglkvQDw=;
        b=WNfGNcgeYIUYFB2ms6+bQBgv3ZXGHc5TqCTE2CX3PEHTj+QbYaxmojQIkFOWVIEGQm
         toTjOdogsufl4XrC4SxiGEOJs/xV52yz61qPDwtvflDaClBVueMeJBT1ZEBVnmCJHxwJ
         3Wl3No8IuUITLHLLnzWnfmirN9Urv2TcalGldUT2oOpiuWyCYMHywJX1OQLTOhCmRDIT
         XUK+/F6xrixVTbz+9NxCgvlE4alBZ2ZHZ5xCpLJm/1cJleyvcPz6GgAx0dr+u1yteqCM
         UhUuutPKHBrdVp2koSC5Zx1yjxYXHvEyDE60zIZsCH8Fgvuv+uYBXoKA7PAB9G4Zv2pz
         4aLg==
X-Forwarded-Encrypted: i=1; AJvYcCXGW+N3kw495u+l8RbewmaOmGyIBM3V24XhesDK+OEkBzEN8TCZKnoiI6s/T/mu2fcWkNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLe+I4DwqE48gVZizGzK1IBXSNi54vyfzTdn0+JXb1Q9K+iHus
	WqkeHuPbAiumNU4cadCBBW2DKVvOBlPjoHmqclMdks7gC8mmybIPQBCFfqgBuPKeNRXeiBuziaq
	vLLYtzkWZwyhL1R7mtmjlyOj4N9XnP6a2uka9SeRh
X-Gm-Gg: ASbGncsbqcilI6KIRN4tTOza+noKvFu4uh1FIBU0yNsJAMhkyw0EVExjJn+462h+V8k
	+bXaWsns83YoUgZuJwCL0gguB8QFf598ZvOyl943He/NHNFREP2ffUrDkrXTDbH2YZC1ll1gH38
	SCgG4/XuRSY/jwhoMUKC2iClbRzhgFAQ4NWXQLrvx8a/UX4iu0J1JuR2O+bUd2l/n1wWZaGvW+R
	g==
X-Google-Smtp-Source: AGHT+IGHTtd8GwYL6s47duOtvI11yvQhyMCmulRFLFgan9XM4NL5YqgUm7lrMXaSMf7Xg+hGF009Ceh+BvemOxenRjE=
X-Received: by 2002:a05:6122:8d1:b0:52c:4eb0:118d with SMTP id
 71dfb90a1353d-530c72aea25mr471405e0c.4.1748982991815; Tue, 03 Jun 2025
 13:36:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603044813.88265-1-blakejones@google.com> <aD72CVq-kWr3G4S3@krava>
 <CAP_z_CgAAAaAPGfYY2DErT_V2-E2e8E+fDHcGPVSaOq+_D9EeQ@mail.gmail.com> <CAEf4BzbYrjOwzhvSn0M5sPtOJu5dXuPDhrWPkkLvLaL3+R20=A@mail.gmail.com>
In-Reply-To: <CAEf4BzbYrjOwzhvSn0M5sPtOJu5dXuPDhrWPkkLvLaL3+R20=A@mail.gmail.com>
From: Blake Jones <blakejones@google.com>
Date: Tue, 3 Jun 2025 13:36:21 -0700
X-Gm-Features: AX0GCFux8Pf7j5PbJWHTWQG8crurwVe0RL2F0e4S34PAatQdl9mJe8_5ita_d1Y
Message-ID: <CAP_z_Cj-v+h6giXb4W3NuVEN5+QMJwTQgqWO7cQHMgPxzSCZ=Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] libbpf: add support for printing BTF character
 arrays as strings
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrii,

On Tue, Jun 3, 2025 at 11:39=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> > Good question. That E2BIG error would happen, for example, if we tried
> > to print the array "{ 'a', 'b', 'c' }" when the type was "char[4]".
>
> Exactly, data is truncated, we have to return E2BIG. But I think that
> is checked earlier with btf_dump_type_data_check_overflow(), so we
> probably don't need to do this here?

btf_dump_type_data_check_overflow() only looks at INT, FLOAT, PTR, ENUM,
and ENUM64 types:
https://elixir.bootlin.com/linux/v6.15/source/tools/lib/bpf/btf_dump.c#L230=
4-L2315

So we still need to do this manually for this ARRAY type.

> Please add tests with truncated data so we know for sure?

I've added tests; see below.

> > I'd say your proposed behavior would be consistent with the semantic of
> > ".emit_strings should display strings in an intuitively useful way",
>
> It still should follow the overall contract, so I think E2BIG is
> justified for truncated data.
>
> But there is also a bit of a quirk. If a string is not
> zero-terminated, we actually don't distinguish it in any way. Would it
> make sense to detect this and still print it as an array of individual
> characters? It's clearly not a valid C string at that point, so
> emit_strings doesn't have to apply. WDYT? The implementation would be
> simple -- find zero in an array, if found - emit everything up to that
> point as string, if not - emit character array?

I don't have strong feelings one way or another, so I've just implemented
this.  btf_dump_array_data() now keeps going and does its current behavior
if btf_dump_string_data() hit an error. In practice, btf_dump_array_data()
does *not* return E2BIG if the provided array is too big for the type; it
just displays the first N elements of the array and then returns. I don't
plan to change this behavior.

Updated patches coming shortly.

Blake

