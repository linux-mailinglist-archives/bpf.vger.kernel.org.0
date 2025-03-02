Return-Path: <bpf+bounces-52990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB3EA4AE92
	for <lists+bpf@lfdr.de>; Sun,  2 Mar 2025 01:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2780716FA35
	for <lists+bpf@lfdr.de>; Sun,  2 Mar 2025 00:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099F63C00;
	Sun,  2 Mar 2025 00:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdXHVKHU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B423C2F
	for <bpf@vger.kernel.org>; Sun,  2 Mar 2025 00:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740874196; cv=none; b=esmuhgZE+qPIWD8ewyLIEq+CnPRTQg7dH6nvqtZzD4tRQrDKJlqCSg3lFH8FsSQm50VMauqdBiOQop39c/k4Mzcz3LKHfRTWFFN+vE1zAJeUscp1dfcC1r9XGhQv1xJf95QUc649t0gl075g0XOC2lLiXbFsvXjzICNvaBUEZBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740874196; c=relaxed/simple;
	bh=JurvktHcgzMavJsI0KwcVtEQBwZktG2RfJN4I+H0K0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=moTY7lS4Jo0mHt0tQg8uSeNz+xWPRRarUwW6g2t2dS6vBtIiNI5jIPohoMVUKNUwwaNUAPS6cw7KlzvFXmoaP8k/XhN/eggrP3u4IFBfKEQH8NWlr+umCVW38qVt0ztf3rLSIH2YdRx+JBl+WpF6q3RF7qTJYzRGugMsAubLFP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdXHVKHU; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so1976222f8f.0
        for <bpf@vger.kernel.org>; Sat, 01 Mar 2025 16:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740874192; x=1741478992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XStD0s5zLuW8GBAODOykOnxUYxI7dL81qe11NaduEqM=;
        b=UdXHVKHUw1bv5GerRzQTsGvHYGq2isXft8rhPq++1bT/WTz9LaGwFHRNSzAe4tK0ZH
         oyTXOHOusQQlfzCs1Vo+YUF5ibaiY9KQXkkAsDAIi+ppPN7tfKUWfnmPCWl6m1geJJbK
         JUQyBUL0OSaZyMJM5Z/PYjb+AhRNtii5yohzr3EaaDGAvnPRAvGHrfnpvrgWs/lswRA+
         Zatk8yqxrq7v4HAsFxubdqOjUAsznuPfsUlQSZpDQiyL04CSM1RWjzShuo8RpVpVqTGm
         bntC9afY+/6ygCjG8NUupDJ3pQStAxaQg3AY5IQKaKwX9erDPmyZcw9oYGDfjEROelPe
         uW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740874192; x=1741478992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XStD0s5zLuW8GBAODOykOnxUYxI7dL81qe11NaduEqM=;
        b=QdlSJD4/ChBJwlicw5tyYUFbYU7DrueCoqgL+UfXzDgp2kPJZv1wRE4q4TqXCOJk9r
         cYgaYLWR2rvI6KAPbBLpkRTwszhH2Dx23FJFxulPWJv3OqxPhrz91BO61V2ZZpMdLC1d
         X4BBTscCBxZKIAouc76zOrQnuAGVBzHyw9cXU01ESqI3jMViuymCQdvNIeilOEvUjrxP
         M3vkoZXNAG1aXP+yokJnX5u+5A0Chksyc2y/1DpKIx8g48Mko83OxNgLZkiI4ntpLIk+
         6ilVBULeFKcN4qIJzD/bhzs6gkxQMPX5ylDNWmHeh/ZLpM7RKQMPoXaYTkeEBXKK1yhs
         6gLw==
X-Gm-Message-State: AOJu0Yx7yD9ZQNeOZQ3aMo/dhwlYErMPX8E7QhVLedjX2leipNXgc7Ri
	zOmWesV8lF5UNpZ3K80dZwqv927Q8TmsyeKVB/aM3wWgk88WQ1Imct/NwYhicSGai4Zm8OmSwQ3
	GlZndvP903CNtNEIV0aAQGHC3sFM=
X-Gm-Gg: ASbGncuJpJ4KS4dKb1dvtAXPJ+aiaiRRxz+KVsQnt6HSgqu7ewIJrBjdsCDdh7+fnmN
	o1fpY90qxQCL9RNb1tNgljP1QgvUO4x4zDe6TxlAB5otYcBraod1NtqKG+cIQuYFMiG73Dv/yrm
	Ms10wOKU410ro1iB5P7afMiTsbTI7TXGANRyo3xwfT2WWU6rQZHy+c8mZpkw==
X-Google-Smtp-Source: AGHT+IEjdKt9cqF4cUo5uf3fSX3KJcZsT42KgXuF2XVL8MQcrA6doJ9fZ4mTxRJU2FbkOQ23SrBTAn7OYAHLeaPyWb8=
X-Received: by 2002:a05:6000:1541:b0:390:e62e:f320 with SMTP id
 ffacd0b85a97d-390eca37c8fmr6929616f8f.45.1740874191932; Sat, 01 Mar 2025
 16:09:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228060032.1425870-1-eddyz87@gmail.com> <CAADnVQ+BEW_yTsm-pMYcCsHhpZ4=FhAMmGvY7AhwyiUOZ+X1Gg@mail.gmail.com>
 <cc29975fbaf163d0c2ed904a9a4d6d9452177542.camel@gmail.com>
In-Reply-To: <cc29975fbaf163d0c2ed904a9a4d6d9452177542.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 1 Mar 2025 16:09:40 -0800
X-Gm-Features: AQ5f1JpevwmYeL7EsY_wiPueIS0FcBKR6pUSuRB-Exj82EH8Gk2tWiChDAtosdE
Message-ID: <CAADnVQKcOLDqwhhQpy6YU13ZbY3edGgx1XpXF5VsmXt9Byxokg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/3] bpf: simple DFA-based live registers analysis
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 8:40=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2025-02-28 at 18:10 -0800, Alexei Starovoitov wrote:
>
> [...]
>
> > I think the end goal is to get rid of mark_reg_read() and
> > switch to proper live reg analysis.
> > So please include the numbers to see how much work left.
>
> Complete removal of mark_reg_read() means that analysis needs to be
> done for stack slots as well. The algorithm to handle stack slots is
> much more complicated:
> - it needs to track register / stack slot type to handle cases like
>   "r1 =3D r10" and spills of the stack pointer to stack;
> - it needs to track register values, at-least crudely, to handle cases
>   like "r1 =3D r10; r1 +=3D r2;" (array access).

Doing this kind of register movement tracking before do_check()
may be difficult indeed.
Can we do this use/def tracking inline similar to current liveness,
but without ->parent logic.
Using postorder array that this patch adds ?

verifier states are path sensitive and more accurate
while this one will be insn based, but maybe good enough ?

> The worst case scenario, as you suggested, is just to assume stack
> slots live, but it is a big verification performance hit.
> Exact numbers are at the end of the email.
>
> > Also note that mark_reg_read() tracks 32 vs 64 reads separately.
> > iirc we did it to support fine grain mark_insn_zext
> > to help architectures where zext has to be inserted by JIT.
> > I'm not sure whether new liveness has to do it as well.
>
> As far as I understand, this is important for one check in
> propagate_liveness(). And that check means something like:
> "if this register was read as 64-bit value, remember that
>  it needs zero extension on 32-bit load".
>
> Meaning that either DFA would need to track this bit of information
> (should be simple), or more zero extensions would be added.

Right. New liveness doesn't break zext, but makes it worse
for arch that needs it. We would need to quantify the impact.
iirc it was noticeable enough that we added this support.

>
> ---
>
> Repository [1] shared in cover letter was used for benchmarks below.
> Abbreviations are as follows:
> - Name: dfa-opts
>   Commit: b73005452a4a
>   Meaning: DFA as shared in this patch-set + a set of small
>            improvements which I decided to exclude from the
>            patch-set as described in the cover letter.
> - Name: dfa-opts-no-rm
>   Commit: e486757fdada
>   Meaning: dfa-opts + read marks are disabled for registers.
> - Name: dfa-opts-no-rm-sl
>   Commit: a9930e8127a9
>   Meaning: dfa-opts + read marks are disabled for registers
>            and stack.
>
> [1] https://github.com/eddyz87/bpf/tree/liveregs-dfa-std-liveregs-off
>
> Veristat output is filtered using -f "states_pct>5" -f "!insns<200".
> Veristat results are followed by a histogram that accounts for all
> tests.
>
> Two comparisons are made:
> - dfa-opts vs dfa-opts-no-rm (small negative impact, except two
>   sched_ext programs that hit 1M instructions limit; positive impact
>   would have indicated a bug);

Let's figure out what is causing rusty_init[_task]
to explode.
And proceed with this set in parallel.

> - dfa-opts vs dfa-opts-no-rm-sl (big negative impact).

I don't read it as a big negative.
cls_redirect and balancer_ingress need to be understood,
but nothing exploded to hit 1M insns,
so hopefully bare minimum stack tracking would do the trick.

So in terms of priorities, let's land this set, then
figure out rusty_init,
figure out read32 vs 64 for zext,
at that time we may land -no-rm.
Then stack tracking.

