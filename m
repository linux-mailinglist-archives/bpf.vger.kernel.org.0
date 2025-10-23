Return-Path: <bpf+bounces-71951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB2AC02525
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 18:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 556E91882B30
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 16:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B16B28314A;
	Thu, 23 Oct 2025 16:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O9+Xzi/M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DC9278761
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 16:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235746; cv=none; b=WW6onr1xhn14Epu9FatOKYEzVWvltFgeH7xAJ5dYFoT+peLH9BNTSFecet7nfZzQeBSLTe1oidlgZwV+0+Xfc6BBTgJ5jEJHPAyFYjfUfAO9rWUNLsGnqU0dBPCZrLWVFjSOLF1DyW71XIjciFabuFP74N4iMbNjav16g2SggP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235746; c=relaxed/simple;
	bh=iicqHqIRyiknDU8aj031heEdaLM9JecB5tKouPwEMLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DKnzrsXM1ihfygmBHbzdLUBttJn3lEvRKQ301bB6R4fOyyn0Ywt7qkpp6sWo4fTQGAci64axAuPj3EhMeHM7BdFkX4L8KbNlTWQ+zK2+5kefvu+WLuIagA2v8Kjyp12Gp/xKDPe7Ab6uTyXgkAQeR66pfzqQbdP/JPifN5/Yj5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O9+Xzi/M; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-290d48e9f1fso205535ad.1
        for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 09:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761235744; x=1761840544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DD2FrCR3h7s6+/jsUTtH0YJbnzDwL7eNDOT6HMeIno=;
        b=O9+Xzi/M1akcZRLHH11g8Za/ira4T/ufAxTwrgdVhrCYDS2C2VFEbiceBC0eVp2kD6
         NzoP3GDNZ6QdjjCSJHQqq2SeZiTIBLO1ISjpyPLWBW8FMMq2nf8pZ7ArEQsriUYKnoQz
         6Gwm1GgvewJNBTmwGeG340GkFm2HeiUFKIdeO1a5yXFYOySt9LHTnfXs0LCS3HjOYAVc
         6hKVX+szCT8WRJTLVbymXel7cjB+tDww+UEZEAltGni3KmFNlhJvL8qAV39/KZDLmg/g
         GIE+ON/VNztvq/QlI1+9kTuu6GkAUWwEQCQXx+Fh76VLtpkqLGUS8+pZDjGcNKgr0bUT
         BUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761235744; x=1761840544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DD2FrCR3h7s6+/jsUTtH0YJbnzDwL7eNDOT6HMeIno=;
        b=Yd2ZNa+8VIRxMCWdrspZrsXWgRAyKBD2QDYG9gzfGfW0LPydDBxk7SmXrmqUVFeWG3
         r3P1wbTeO+HNMl2rMLQiUgUXlReAWTgaV1+apdvcg3si4w9Y+IlY0yYOr9gXsK9E38iR
         FnJcMFwsYdTv4Y6MUymFTujen0B64z1u0flGP0417VnUulE8rfwNiQblysIIvqXlXFbG
         V+kCjO5rGO9q7+0RpkvKbvFplj1gcLD5NmyiJz4QVAmGqd8dYXrn0wcvpb2FOpTECWGy
         iGlBi89z+Dg2KChME3m+HdADdZ7YDHVKvIv7k87T30/VF5OvN1L5UnhgMNnf+NsoNo0e
         2P5g==
X-Forwarded-Encrypted: i=1; AJvYcCUyk56dadma0cQGG0HPMS3AFX46NgZquIlMDJAsUzlTJ6E9GJ2Ze9R7GwAVlSGp0fA3WTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQAzScSN5Bp61S0o1CjnzdoaoQzMqSD3kDN/VO9ORKU0vcjVax
	iFZguJFAfC293ASCVXKgzV64TG/oikJbWTXnm7LA5sKLrTQAww+VVX/K5F4aIjRMtRRlTFcrgFq
	DZcDpkShQEuouNp5QA9vghC4QmcQ1HFWKa8XMLHkE
X-Gm-Gg: ASbGncvBAj+qVC04SBmUubfjj3gK/7tKLO4ttM3Vp9TvrSJ1IqUnz2loWFlIRSvVp20
	OVXC0RbUyBc9XQrXzRP5qqznwKoa/bY5jCxPtV1b2RUlZ2tFI9lq/AmzosMJb1jLsmvS8Ndb0yS
	4ADuZAUnsqlxgjkiKOhNrzh2Px5BCUMm6J6Nz/UO7NVYy14/zgcsbN1ZgQavZxW7kUoza0m24Jx
	rANVIlKYpZmdAbbLfNFydKwmF/LqbsDTfYIL/F4i565P1O4BXxbaWPusX32xh7q7ZHUSpnAP2wt
	yhKSy3WOGiH9TUc=
X-Google-Smtp-Source: AGHT+IFm2MFLeK85YermsOMu5zYpTpjbtEK4xI00o5TLBfizVMtB0lHY5AA/2uze9+mJDbIqCwZ3M48UjYiYnpTrzDk=
X-Received: by 2002:a17:903:1c2:b0:290:dc44:d6fa with SMTP id
 d9443c01a7336-29487303b51mr523455ad.16.1761235744060; Thu, 23 Oct 2025
 09:09:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023015043.38868-1-xueshuai@linux.alibaba.com>
In-Reply-To: <20251023015043.38868-1-xueshuai@linux.alibaba.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 23 Oct 2025 09:08:52 -0700
X-Gm-Features: AS18NWDd7pnd6R6MJu2L_vLKwKGtCotRaE8bGYrXMIICN6v6EliIOYkLKsl-DF8
Message-ID: <CAP-5=fWupb62_QKM3bZO9K9yeJqC2H-bdi6dQNM7zAsLTJoDow@mail.gmail.com>
Subject: Re: [PATCH] perf record: skip synthesize event when open evsel failed
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: alexander.shishkin@linux.intel.com, peterz@infradead.org, 
	james.clark@arm.com, leo.yan@linaro.org, mingo@redhat.com, 
	baolin.wang@linux.alibaba.com, acme@kernel.org, mark.rutland@arm.com, 
	jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nathan@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 6:50=E2=80=AFPM Shuai Xue <xueshuai@linux.alibaba.c=
om> wrote:
>
> When using perf record with the `--overwrite` option, a segmentation faul=
t
> occurs if an event fails to open. For example:
>
>   perf record -e cycles-ct -F 1000 -a --overwrite
>   Error:
>   cycles-ct:H: PMU Hardware doesn't support sampling/overflow-interrupts.=
 Try 'perf stat'
>   perf: Segmentation fault
>       #0 0x6466b6 in dump_stack debug.c:366
>       #1 0x646729 in sighandler_dump_stack debug.c:378
>       #2 0x453fd1 in sigsegv_handler builtin-record.c:722
>       #3 0x7f8454e65090 in __restore_rt libc-2.32.so[54090]
>       #4 0x6c5671 in __perf_event__synthesize_id_index synthetic-events.c=
:1862
>       #5 0x6c5ac0 in perf_event__synthesize_id_index synthetic-events.c:1=
943
>       #6 0x458090 in record__synthesize builtin-record.c:2075
>       #7 0x45a85a in __cmd_record builtin-record.c:2888
>       #8 0x45deb6 in cmd_record builtin-record.c:4374
>       #9 0x4e5e33 in run_builtin perf.c:349
>       #10 0x4e60bf in handle_internal_command perf.c:401
>       #11 0x4e6215 in run_argv perf.c:448
>       #12 0x4e653a in main perf.c:555
>       #13 0x7f8454e4fa72 in __libc_start_main libc-2.32.so[3ea72]
>       #14 0x43a3ee in _start ??:0
>
> The --overwrite option implies --tail-synthesize, which collects non-samp=
le
> events reflecting the system status when recording finishes. However, whe=
n
> evsel opening fails (e.g., unsupported event 'cycles-ct'), session->evlis=
t
> is not initialized and remains NULL. The code unconditionally calls
> record__synthesize() in the error path, which iterates through the NULL
> evlist pointer and causes a segfault.
>
> To fix it, move the record__synthesize() call inside the error check bloc=
k, so
> it's only called when there was no error during recording, ensuring that =
evlist
> is properly initialized.
>
> Fixes: 4ea648aec019 ("perf record: Add --tail-synthesize option")
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

This looks great! I wonder if we can add a test, perhaps here:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/shell/record.sh?h=3Dperf-tools-next#n435
something like:
```
$ perf record -e foobar -F 1000 -a --overwrite -o /dev/null -- sleep 0.1
```
in a new test subsection for test_overwrite? foobar would be an event
that we could assume isn't present. Could you help with a test
covering the problems you've uncovered and perhaps related flags?

Thanks,
Ian

> ---
>  tools/perf/builtin-record.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index d76f01956e33..b1fb87016d5a 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -2883,11 +2883,11 @@ static int __cmd_record(struct record *rec, int a=
rgc, const char **argv)
>                 rec->bytes_written +=3D off_cpu_write(rec->session);
>
>         record__read_lost_samples(rec);
> -       record__synthesize(rec, true);
>         /* this will be recalculated during process_buildids() */
>         rec->samples =3D 0;
>
>         if (!err) {
> +               record__synthesize(rec, true);
>                 if (!rec->timestamp_filename) {
>                         record__finish_output(rec);
>                 } else {
> --
> 2.39.3
>

