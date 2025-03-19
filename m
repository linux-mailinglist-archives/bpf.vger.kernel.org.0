Return-Path: <bpf+bounces-54419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DBDA69BF0
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 23:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0277C16E9FC
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 22:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5EB21C185;
	Wed, 19 Mar 2025 22:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIN0GzU2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6E52147F5;
	Wed, 19 Mar 2025 22:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742422782; cv=none; b=SeZNWa2LlhpTnx0T+8XjO8OlbPB3Va5A4T3+ec5ZdKgRS757M2eYDgHwVId2fMF10Hh++pIwa0zUAzshOMUy64mVXoWHvjQIuIMuCyZkDGWeutsPzu+E+CZx5fuDu6lvW3hvf4TYpwBMGOm8FmokBKrEqGPTmdyfzaeDFdJ1ux8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742422782; c=relaxed/simple;
	bh=Y/xuKlTBlKlJ5n3sEPqtkxH20xEM5qZefy9mn8TE6TY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O5w1WKlnce+RZZ/az0IV8p4CKnURpkMuV8cf8Rx2vH2U5no6VoYz4eG4uAMP5Z0kFnnYEKah+cCbPTQAQR34Iu4Jt/1f2pet5alp5OjlJa6n0A+c3suYGYk0FudYveYVsZCAOBQC1VuD/OJ3xY0HgxzpHXfIWFhbqgmpnesKydE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NIN0GzU2; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6f6c90b51c3so1505077b3.2;
        Wed, 19 Mar 2025 15:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742422780; x=1743027580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VtFCMos0kGObeHD+XRANvleMydMjqFHddzqyL7z7zWE=;
        b=NIN0GzU2W5dikvEhI8ZOoI6drEpt2oQ/2IoAcTL+U8CEp3UfFn4dmAydMB18m3kLqZ
         oJWD+gTJmJs/AZbO5vT3UWvCE0uGu5A+6BQJ1UC7bFDuchDP1PG65WShyeN8tCccpVzC
         77JVkBOVO+Y5uDtHVwgOsxzUlJH98qUyspy5oOIfL7e0OSd9uR9JCZeL6k5gBX+6CH/x
         F8lBkP340n2eA54DGgQJEDJym+9PcgPy1BA6H3WbmtcH9lbxrB0ZpKryg8JvKWgwXboO
         XalK3HAs0EPHpipvk0XLHS4aN71HgJJmDYG9tGpO6sZben4qWoPRTzlRChgQE+jjfGh6
         dVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742422780; x=1743027580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VtFCMos0kGObeHD+XRANvleMydMjqFHddzqyL7z7zWE=;
        b=B9XbDVzKdqXVV93v2YHE2nRGZuaNsdpsYzgAYGgowdW2sk2JxIdjhEErT9mJkHvMjP
         /fPoXq4Kvt3sq4kpoq9O2JtRUaa84bq2r1s0WHdw+Bnqkv/0ebNQiWyP0Ix5Feyf8eHL
         xL5LvId4BGq5uhG3x+3K7OFdJ/lhUpPqo1L1UtkN2xWI9mOMRgw60Q+3Ch+YkmxPk6OS
         cyJTSOsxbzo8wHGea9LeidtgAlqrocdZ34Ez7CX3AOKD7NPpS/Ri/5B2zAwq2l5P3RB8
         FUTO9+h3UJqdTHT84RD6sEG2xD2vJeDdUIVb8tVeikzLM2hfeefD3PY360sC70l2gFr6
         IZTw==
X-Forwarded-Encrypted: i=1; AJvYcCUfAWjleUfQyCYhsgq/T4bFZHE6AJP7WE8e8TjwtfSeSrdQnkAfWw75E+PNj4J8+2aB5eo=@vger.kernel.org, AJvYcCV1xSFrFI6QPwarxVoflSocoL2uurAdHDU+iyVobpiqkXatMppYQpYX1jhAv8EcbEQNBSWeijSCzYxxxbLX@vger.kernel.org, AJvYcCVGAMHHj46hofRgfLMOFOCZ4jeYRO4RlxOVL/0cjnJdSJNUfud2bzEsQAbFjuX/Mcp3AWQO6N+ajZJ/VcKKrmzIwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDB+sXOeQZnhnHtBvHl+EnJgeApp13P35GLovdQ1i0zhX/xfwC
	ivX+mMspKD3GgBctS5j4Zv9cGOslWPC9c3hIjbRqsA8riND/g0j2tSnJVUPzNq1KKnkWDBjBDxj
	hlYBr2VDqAPtYeyQa2UL0odkSPc8=
X-Gm-Gg: ASbGncuK1yIrhcXq5U6pPLNSnvNh66zeCU8g+w0YlBEIRuGWgqUaeEOKEg0w+ca7us2
	MsKFV/e0Y4DXYkDmrRBfwmRq2eRlFo3/o4l6u0CDI9GZBPZbj7IPvHXmS9maaz1Q2ZLwdwlh+zL
	hIMVgqXbecPrvOgwkULoDLqQGP
X-Google-Smtp-Source: AGHT+IFIU2HA8J1MALcm5HaaBsU88dqBJiVPdQkkkinoZSp7hKWVSDVnN/CXcZMInjRslZbNm4TbgbxKp1Q8QrlczOU=
X-Received: by 2002:a05:690c:6c8e:b0:6ee:8363:96d3 with SMTP id
 00721157ae682-7009c02de96mr68993257b3.27.1742422779636; Wed, 19 Mar 2025
 15:19:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317180834.1862079-1-namhyung@kernel.org> <CAH0uvogx1-oz4ZjLpcTRArTb2YJOyY1h1pccMXYSgCnHYD9bPA@mail.gmail.com>
 <Z9tABRzmYYYUyEFO@google.com>
In-Reply-To: <Z9tABRzmYYYUyEFO@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Wed, 19 Mar 2025 15:19:28 -0700
X-Gm-Features: AQ5f1Jp25lqJtUZZi8oixdUt-G4InKr9juHsQeTVlqnP8KdpCs46Z430QijMzEA
Message-ID: <CAH0uvog7uZL2AGyfPdSjCo0eahxDESXT3ZWSNmUCGWFc_SmFYg@mail.gmail.com>
Subject: Re: [PATCH v2] perf trace: Implement syscall summary in BPF
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namhyung,

On Wed, Mar 19, 2025 at 3:07=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello Howard,
>
> On Wed, Mar 19, 2025 at 12:00:10PM -0700, Howard Chu wrote:
> > Hello Namhyung,
> >
> > Can you please rebase it? I cannot apply it, getting:
> >
> > perf $ git apply --reject --whitespace=3Dfix
> > ./v2_20250317_namhyung_perf_trace_implement_syscall_summary_in_bpf.mbx
> > Checking patch tools/perf/Documentation/perf-trace.txt...
> > Checking patch tools/perf/Makefile.perf...
> > Hunk #1 succeeded at 1198 (offset -8 lines).
> > Checking patch tools/perf/builtin-trace.c...
> > error: while searching for:
> >         bool       hexret;
> > };
> >
> > enum summary_mode {
> >         SUMMARY__NONE =3D 0,
> >         SUMMARY__BY_TOTAL,
> >         SUMMARY__BY_THREAD,
> > };
> >
> > struct trace {
> >         struct perf_tool        tool;
> >         struct {
> >
> > error: patch failed: tools/perf/builtin-trace.c:140
>
> Oops, I think I forgot to say it's on top of Ian's change.
> Please try this first.  Sorry for the confusion.
>
> https://lore.kernel.org/r/20250319050741.269828-1-irogers@google.com

Yep, with Ian's patches it successfully applied. :)

Thanks,
Howard
>
> Thanks,
> Namhyung
>

