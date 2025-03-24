Return-Path: <bpf+bounces-54597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E06AA6D581
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 08:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4A917A3EBB
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 07:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E0E25C6F6;
	Mon, 24 Mar 2025 07:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zKcVZgFP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7201F4CBA
	for <bpf@vger.kernel.org>; Mon, 24 Mar 2025 07:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742802825; cv=none; b=jQIvnGvA99XccbTl4U7Y20kzONmD7zVml1W6kgqVRbsjMhjh4s9IwK0dVMEhx4afgagDzZPwU/B8GkMScnydDY8o5OVwboUQ2+pRxdH7W5OhNp+xAl9s2cja0sbG9JGhSMWUScE55TVsia9tNa+A2lgmPzYjUsy0ncMw60UFz3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742802825; c=relaxed/simple;
	bh=+f+zTy+HCdb0nsVnI6YMF9DFCrlapfwDiIEaJAlJXcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8frpg2/vIJFSavqJEVedpXyk5NP9BUhfDx5KBhtp2tuyCICWcuVLBn9LehiGAwhqH8uxsY69DGc8A2ne/r0718s8s0e8y02u3qDQxSXB85y4RO+EfMCNhtm6brTT9DU8iONcgNszTkTUHdp6g97U813VaazpEMAjWtensmVWfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zKcVZgFP; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4769f3e19a9so25753621cf.0
        for <bpf@vger.kernel.org>; Mon, 24 Mar 2025 00:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742802822; x=1743407622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IoORNtbY+B2IUJ3dsVJjusx0671z0wqj3fYYp3L4WQk=;
        b=zKcVZgFPTsVNtdKaPMgj9ynLjkchYceTBXU0MTD9eCP0hP84+ZjuD3rpBz4phcOvHk
         XiAnSgLZbpysc35eoVtjQ15UlDPAxRaIl0M1XgoWiur+GF6VNOzUtQh2ue0flm1qdnT2
         ClbvZb/gTJZ8V8I5pMolHSRY6FrZml9DHZ4ol37jtkYegbvuEgX5AMMQQdFSOuv6q/3V
         XgcRdQ4kKhgJOQerKJnQkflibZnFK3886VYPzHtoe6eDm4+dBS14Xmq+Pi7hY1tXX513
         Xn9nKHj4mkfji5k21L9wQ1cx8F+UKnmBccV8ZDE2SpXFysoNVsezpD4DSkYiuDHJBVkB
         tl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742802822; x=1743407622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IoORNtbY+B2IUJ3dsVJjusx0671z0wqj3fYYp3L4WQk=;
        b=Ph41wDcJ3VCFAoqgRX2E4usks+mEc+utezn8BJrk+jl6rxSmf1Q8UH0cLhEvaQcEn5
         lZ4yuSyvkG0iiaaI/1MWullDlfqJzb4hC8bHP5EkyQgnIYDa/gNaCRLnS8TVvQ7/IbRY
         IBZNsYCL/+HCM1eUDNcvIkvKwyL69tYU3Gy4APvgXclYdr+WNI9UKPKCF2D4PB+eAIBH
         XQcUteLeQl8QQQPUre7FRrJJuOaXnVFEvCjnjbHy8cr1Jd+/2rYS1VT2EpWGUZexr7dk
         1W1AQeuXv1PERtq+xFstSZULvtZdrpUac9Ib/gWBoB/N8aqQTSVBKNIDmln6/UbA5fqW
         I2wg==
X-Forwarded-Encrypted: i=1; AJvYcCWZxeHhg7IOAEkFb703QdMiI7/PzfqW2iXcDS3D4v+k3c4+HJH2D8YtKvOUygr/2Tn3OSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCvAkloud/J2X8opIw5ksIRNA+HIJ6X2lq0MGQfFzuV40n/Bng
	Xq2nAvKZfsSn6Y+kgW66fSo0u6+toeaCXtnTFZe4xeoqrYZO9kckkNHE+xb4p4L5hPdXPKRH/Nq
	009zNZwpbPEWjHiCD6M4iPDZX82Tx6TmJ3Rq5
X-Gm-Gg: ASbGncuB7ad7Lg4+ym6CY2AeKb0H1n1Noejm3w/HRMjpTJHBw5kpRHnBeIiNFNIl/ms
	/0hY1+xPEJrM3iced9eSDAYeN0nczwXF9Bzerg7F67JF2Oe75W8OA1I+xviu8t+1FMyVu5kQfUK
	wT/hEyLdmnk85UwI3F3mihctsPnKI=
X-Google-Smtp-Source: AGHT+IGiwsWFuYsLMNRyd+YyNDH5S9vrOYtns1KAlBv0TwB+wIKjZFlUfAJvYJceCxx7xV/sibpXW8eyBJzWnUP1oqA=
X-Received: by 2002:a05:622a:4009:b0:476:8cad:72d9 with SMTP id
 d75a77b69052e-4771de3f530mr200487331cf.33.1742802822174; Mon, 24 Mar 2025
 00:53:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250323072511.2353342-1-edumazet@google.com> <Z-B_R737uM31m6_K@gmail.com>
 <CANn89i+fmyJ8p=vBpwBy38yhVMCJv8XjrTkrXSUnSGedboCM_Q@mail.gmail.com>
 <Z-EGvjhkg6llyX24@gmail.com> <CANn89iL8o0UZTpomaT1oaMxRTBv1YdaXZGwXQn3H0dDO81UyGA@mail.gmail.com>
In-Reply-To: <CANn89iL8o0UZTpomaT1oaMxRTBv1YdaXZGwXQn3H0dDO81UyGA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 24 Mar 2025 08:53:31 +0100
X-Gm-Features: AQ5f1JrzgIBhkWXtEZlLxzH8STpfXyvqiZx0ev4PTk9UGx7V7iWN5IFKTjlaI7Y
Message-ID: <CANn89iKwPpV7v=EnK2ac5KjHSef64eyVwUST=q=+oFaqTB95sQ@mail.gmail.com>
Subject: Re: [PATCH] x86/alternatives: remove false sharing in poke_int3_handler()
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org, 
	bpf@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>, 
	Greg Thelen <gthelen@google.com>, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 8:47=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Mar 24, 2025 at 8:16=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wr=
ote:
> >
> >
> > * Eric Dumazet <edumazet@google.com> wrote:
> >
> > > > What's the adversarial workload here? Spamming bpf_stats_enabled on=
 all
> > > > CPUs in parallel? Or mixing it with some other text_poke_bp_batch()
> > > > user if bpf_stats_enabled serializes access?
> >             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >
> > > > Does anything undesirable happen in that case?
> > >
> > > The case of multiple threads trying to flip bpf_stats_enabled is
> > > handled by bpf_stats_enabled_mutex.
> >
> > So my suggested workload wasn't adversarial enough due to
> > bpf_stats_enabled_mutex: how about some other workload that doesn't
> > serialize access to text_poke_bp_batch()?
>
> Do you have a specific case in mind that I can test on these big platform=
s ?
>
> text_poke_bp_batch() calls themselves are serialized by text_mutex, it
> is not clear what you are looking for.


BTW the atomic_cond_read_acquire() part is never called even during my
stress test.

We could add this eventually:

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index d7afbf822c45..5d364e990055 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2418,7 +2418,7 @@ static void text_poke_bp_batch(struct
text_poke_loc *tp, unsigned int nr_entries
        for_each_possible_cpu(i) {
                atomic_t *refs =3D per_cpu_ptr(&bp_refs, i);

-               if (!atomic_dec_and_test(refs))
+               if (unlikely(!atomic_dec_and_test(refs)))
                        atomic_cond_read_acquire(refs, !VAL);
        }
 }

