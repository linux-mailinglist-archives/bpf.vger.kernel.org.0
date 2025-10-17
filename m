Return-Path: <bpf+bounces-71236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04361BEB19F
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 19:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DD586E4EC9
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 17:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E88B3081D1;
	Fri, 17 Oct 2025 17:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpYX0lXc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D5F29D265
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 17:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760722828; cv=none; b=RRz62Q8U/V6jx+pfzByP00/iHMxxq6f0ESnjeWPocnLemQq9nYQDF1KZCr0+PUzNWGWk/uprW8FoV5duMNqcrkjMNyQ3FtqD7hbAr0lxTCK82KPNrqK+9DShmREtsoiWiheUvIyN32+LdPo3Blo/ZDQhUB/bSHUuP6Fb+G3uVSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760722828; c=relaxed/simple;
	bh=2RysdHxuMiEeGX3LMu1oRMBi5KuQC1DwjQsH18ggAek=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WJMoM7dn5/o19nLhQcj3TR+Z0pnTkUZ0V7FBD2nfQEU0GZLZgpI9aVXSlFdzO09a5d1LRG79W51L4YW05ARlWETFYyynXm8E0OWy9A7OKIaExUvz/k6QBM1vRKgURWGcJdmBsAmhvVD6JtoqRwKrofU0HoHmEKRC2FvrBvNtfT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpYX0lXc; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-292322d10feso4125005ad.0
        for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 10:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760722825; x=1761327625; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i7J12+qTHU1oshcnB/C58fDfVlviejVYuguJOo2R2Bs=;
        b=SpYX0lXcy64oQYQEd0HVIY0IERhReUTR6SEibjDLESsggu9RHXZ851vcErOlOqMa5R
         lfGOeQnEOa9jeA5q6J239Q7NTeOt4gac/J0/7NJH3kmFcEy4DsAyHUCVwcKAtCeieV9h
         qXdI5MMqS8U9qaLrMqsYttzxA6BYIP5sgenKA1u5ZQl7lBorFjoQLvwN/dI2cez78Ivd
         PxkmToqbO8O6vTqJPAW8owBxSvuwRU+u7ZZdQ1rNI4B5F9Qsm1LbzfjUtNLN5RpX7xuP
         U31I5jNPN4ap43qQKXCEARHGlPJKDoMpVle8ststA8Z13fjRZXeuTIx+JW38wB81R8yO
         mSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760722825; x=1761327625;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i7J12+qTHU1oshcnB/C58fDfVlviejVYuguJOo2R2Bs=;
        b=bJKEylpxHNhFtMmi0b0adUTZwblPlzlwjdExxjTmJBP+9Kcq3ygGbF00cMQkkoEBh/
         hgrbXCt1ry4zlLELESnW+DYPE/e9JIMNPPo3t+MfQceER+6U464mjLP3u3zrZKYZ3rdU
         252WOC5KmLm9QYBdAN+6V1ins9v2Jlt6vju74udtkT6LTcaJXooCPyAsev8OSdKYkNu2
         dfbEjAVaVcWWLrvYX8TnvxURMwJOddNSQq96qBc5onG6PqZ9D32k4RlPzbxErGDxald9
         +1jwpVJpnN9Uq4Jm5u2rjptw2QKFdYyXaPRZtAx+F9QuF7iB2IAy2bLc8Wzj1nWc43GF
         F5yg==
X-Forwarded-Encrypted: i=1; AJvYcCVzRCL6KjqeDA7MrT1wNzCOHKIKpy/leGVn+eGk+E0unZCuRyrLOmmQ64s+rwIaJ7ZLm0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVK1f8xULoXDHoWnjK8HKUu3bNvqOmp/hSkSPUBU6kmUpAYEPH
	9/huLsALVxWbDfRY5bSIKQqNljh6uYDn5ghpldgRqZHXT2OhSZp2AUf8mo7JTQVo
X-Gm-Gg: ASbGncs1YrNd/MCPigcgld1qrOsVcIXmHH4LtY0o6t7+gC854Ct0Injhm7ID6/bmqO/
	ewyEYTxZiI9YhLMTEvqVQ4aQkMFm4UrJcTg6JCCXjA+NJlga4GFomzO87dfCifxZE0ACyR1ai8R
	Zwt1USnkMb0jyHVVzXvTUwPxc1d2vLHx0LSBojQhlMVUsk66HI3Xe2Gyr1boNFHW1COErMrb38C
	uYvOwdMXpKxvqoD5Kl3zRVnn8ESuhuMEnmrq42I5RyJQm+jdACTXuPkzcrNcZaqBevb2NpVNzCA
	Yj24MI7zfjjvOGn6IcxKercGEJzO3hRGO/nG0nI800v0XBC3ldJAFnjKkk0LWY1fQGq17U2J8hs
	j3pQMqyDIE13NHEy5RIPeWgErPOueSKgCItb5jx34WM0/SoVmrTSn5PAAMjJEV2yKc89cVL6+45
	UQ9tjLtkK1QvLsjaP/8wNWHhjce1XOe7AMz5U=
X-Google-Smtp-Source: AGHT+IE1kHqHrep5C3xUFAnjuWiDhRo+OW5gMsEsbnV93uBVizwW/D3B1IfWyTNFusVOT9RxT3CGtg==
X-Received: by 2002:a17:902:dacd:b0:282:2c52:508e with SMTP id d9443c01a7336-290c67e981cmr65676475ad.8.1760722825391;
        Fri, 17 Oct 2025 10:40:25 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:49ef:d9f5:3ec:b542? ([2620:10d:c090:500::7:77fa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ebcdefsm1127105ad.16.2025.10.17.10.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 10:40:24 -0700 (PDT)
Message-ID: <1ce0c35c4c444ba85f753df5b0d0c5cd4870d887.camel@gmail.com>
Subject: Re: [PATCH bpf v1] selftests/bpf: Fix set but not used errors
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Tiezhu Yang
	 <yangtiezhu@loongson.cn>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, LKML
	 <linux-kernel@vger.kernel.org>
Date: Fri, 17 Oct 2025 10:40:23 -0700
In-Reply-To: <CAADnVQJjSNEuX=HJKrD=pefC4C9dQk2aqP+hnRscUEDTntVXyA@mail.gmail.com>
References: <20251017092156.27270-1-yangtiezhu@loongson.cn>
	 <CAADnVQJjSNEuX=HJKrD=pefC4C9dQk2aqP+hnRscUEDTntVXyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-17 at 10:20 -0700, Alexei Starovoitov wrote:
> On Fri, Oct 17, 2025 at 2:35=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.=
cn> wrote:
> >
> > There are some set but not used errors under tools/testing/selftests/bp=
f
> > when compiling with the latest upstream mainline GCC, add the compiler
> > attribute __maybe_unused for the variables that may be used to fix the
> > errors, compile tested only.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > ---
> >  tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c | 3 ++-
> >  tools/testing/selftests/bpf/prog_tests/bpf_cookie.c            | 3 ++-
> >  tools/testing/selftests/bpf/prog_tests/find_vma.c              | 3 ++-
> >  tools/testing/selftests/bpf/prog_tests/perf_branches.c         | 3 ++-
> >  tools/testing/selftests/bpf/prog_tests/perf_link.c             | 3 ++-
> >  tools/testing/selftests/bpf/test_maps.h                        | 1 +
> >  tools/testing/selftests/bpf/test_progs.h                       | 1 +
> >  7 files changed, 12 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_o=
ps.c b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c
> > index d32e4edac930..2b8edf996126 100644
> > --- a/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c
> > +++ b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c
> > @@ -226,7 +226,8 @@ static void test_lpm_order(void)
> >  static void test_lpm_map(int keysize)
> >  {
> >         LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags =3D BPF_F_NO_=
PREALLOC);
> > -       volatile size_t n_matches, n_matches_after_delete;
> > +       /* To avoid a -Wunused-but-set-variable warning. */
> > +       __maybe_unused volatile size_t n_matches, n_matches_after_delet=
e;
>
> I think it's better to disable the warning instead of hacking the tests.
> Arguably it's a grey zone whether n_matches++ qualifies as a "use".
> It's certainly not a nop, since it's a volatile variable.
>
> pw-bot: cr

Maybe something like below?

--- a/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c
+++ b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c
@@ -223,6 +223,8 @@ static void test_lpm_order(void)
        tlpm_clear(l2);
 }

+static int print_stats; /* debug knob */
+
 static void test_lpm_map(int keysize)
 {
        LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags =3D BPF_F_NO_PREA=
LLOC);
@@ -334,14 +336,14 @@ static void test_lpm_map(int keysize)
        tlpm_clear(list);

        /* With 255 random nodes in the map, we are pretty likely to match
-        * something on every lookup. For statistics, use this:
-        *
-        *     printf("          nodes: %zu\n"
-        *            "        lookups: %zu\n"
-        *            "        matches: %zu\n"
-        *            "matches(delete): %zu\n",
-        *            n_nodes, n_lookups, n_matches, n_matches_after_delete=
);
+        * something on every lookup.
         */
+       if (print_stats)
+               printf("          nodes: %zu\n"
+                      "        lookups: %zu\n"
+                      "        matches: %zu\n"
+                      "matches(delete): %zu\n",
+                      n_nodes, n_lookups, n_matches, n_matches_after_delet=
e);
 }

