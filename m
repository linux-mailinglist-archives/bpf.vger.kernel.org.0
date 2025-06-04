Return-Path: <bpf+bounces-59691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 319C0ACE6F2
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 01:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7691891195
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 23:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7F81D88AC;
	Wed,  4 Jun 2025 23:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7bfktWr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895461C861D
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 23:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749078153; cv=none; b=G8sOvtTXXyRoV+4KrCjK3PU6KiGZf9/+rqPlJhyE9D7iWL9WHKHgUBHwdOV8p8lUpq42C8SJBNgO+vTlKW0A/ef8EvwZ5c0OyoMwLCdrRTgIfKwcMU+Iuigwm1kDFzPzrqVgc/Gc9SqHFAIrm8wxN7FQHJyu/6MF1ny6ne5i7UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749078153; c=relaxed/simple;
	bh=6Q2Xf0hO6UVHBnoN/VD4br2Y/EFeArGvFeNwP9QL9nE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YC8VcCR42/h3zwanBtZEHMh71nUXeX4ZxD/SY2kG7loINduvo/hwhmT/EZbcxEBIWHbHALarPbcfHlUoT+RpnoG3r6xtSE15aKHtlG0vxogy4xiJq+xuuo5iKSV0YtPn1Vge65c4Z0MVbeC8vIUSlUqaTGpa33jTLKA0MsdEu1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7bfktWr; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a5257748e1so261920f8f.2
        for <bpf@vger.kernel.org>; Wed, 04 Jun 2025 16:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749078150; x=1749682950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFcBOmqaRy3pzTDVSd8u2+Hosf+SSBT5ctjbfjV1ysY=;
        b=N7bfktWrmNc1E6y4/8xWyDaOtnm6lq2oaeAHZfJteQvSFaJDYE+x0WBtQUkt25ZYFf
         0p3xoaAfELoaiIPDKdjcvOo8yw/bRrKa45kCn26iWjMiLE/6xxoSw3U12S0fPrXg0dTz
         c9DUB+jcs1Me+MAhms1vL5WffKcDfywz9rP+Hhvs69QBnKARqEwJhgY0aUD87cqBrx1t
         9jMymrPf8G4LccGpFq9g3uLYVsEmegzCn/bhDgaIXJm++hXjRKBVNrhTy8M1SBwhYUld
         TGsYERw/IipEg+JT2s8v8iemrhJJ9A8NfHh8QH/cl+k2zprKqxPv+INGKVCiu1dcaVcJ
         p+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749078150; x=1749682950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFcBOmqaRy3pzTDVSd8u2+Hosf+SSBT5ctjbfjV1ysY=;
        b=xQQmKHdCjEvAIviroy7Ym2bWajmaJFwuqi2YcU0VieOyJTigPFiCALXu1VtJz7g5Ir
         QWHAJ5xO5TiBb8D0EtwLldAJ6dncoD7nh4XScYZ4ImW4BCA8hL8gyypaxGOUrGzwidkq
         4Lq+DEvrBLppPsqhYnJmh1DRgoGMLXteLnWeEclfi+lKVTBzGoWj0SvcH5EhTjPijNcc
         cZor9bz0S9WnTRjenWQ8/2pdP2UkZkysTfFYe9yOZ9TgxYp9j6QatdcnpDOYCNqo2ssp
         4QO9gjdJ6BctoXSAyx532pHW9Wkz3duaa19f8GuPyo28cF5qtbtS+hrJ2wcELsOE0EoY
         FLZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR7+60KenEW+lAElmTdLyXeGHVKmXos5qVfJjX8TDA8dj4DNKJO+LFCZvkl1ocb/QVz+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKX9Copxm02FPx2l0BRLGtHggoGIP7euvGZjgp95xQLzmfLTkM
	8LCWkPqkSzC5Wxc06YJDzY4NsYWAo3JGx7iWD9ya7iFBuF8DTGF6sq7+fh6B5gwT/nX1w5GIQbg
	Jd2n1ooKcpCqBegoSupAHA5qCKisvuOqqwg==
X-Gm-Gg: ASbGnctpxL23bLuQxSPUzZ/L7iS8xe3pkaDug3rlC0VjjiAL4VU0d4WNas3nszt12xF
	nWWki8umuMrqi/QOicw6F/FlxIAwStCD2LuWd647fz0+0GyYBDxDdEmrTh7CVsjvwgTm3Su6DUs
	i7vVGsgqukHx/5ke4SaJk7Q67C9UWnfGi75vv31GkOI/G7fSA+
X-Google-Smtp-Source: AGHT+IGuefjFB0gJhG1Ap0qb5UVNOdTV/zWN4e3zKdJG6gQstnpXDgARLgQICChtMvHkIrq/j+OgtKuP6xvINuYl3bI=
X-Received: by 2002:a05:6000:18ac:b0:3a4:ec02:739f with SMTP id
 ffacd0b85a97d-3a51d9838a3mr3613686f8f.53.1749078149548; Wed, 04 Jun 2025
 16:02:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420105524.2115690-1-rjsu26@gmail.com> <20250420105524.2115690-4-rjsu26@gmail.com>
 <m27c2l1ihl.fsf@gmail.com> <CAADnVQJZpyqY9TWanRKjmViOZxppAeh7FGAnxV_1CKAih7drkA@mail.gmail.com>
 <CAE5sdEh3NuXUcjScj4Auvtc2701NAS6fu0hpzLGVnaoQ7ESnfg@mail.gmail.com>
 <CAADnVQKX2=jYfs5TBBKdKxHPi_ssUvrSuxbr22-dmYoP_e3=dA@mail.gmail.com>
 <CAM6KYssQwOnOqQT6TxHuu1_vDmmuw+OtFB=FwPLqbFcv+QdVrg@mail.gmail.com>
 <CAADnVQLFM9s_Ss7eqyx47tiY8i2b2dt=RMPHMC_s67Ang1rNBw@mail.gmail.com> <CAM6KYsuVe10f39kfaJaQEUGGA7xjmkALxjRSQxJRcGKAw4KtGQ@mail.gmail.com>
In-Reply-To: <CAM6KYsuVe10f39kfaJaQEUGGA7xjmkALxjRSQxJRcGKAw4KtGQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 4 Jun 2025 16:02:18 -0700
X-Gm-Features: AX0GCFsEvdgTN4INjtXq7_9z6jUor-bYET-mWOf3kiwqSFD-IHYrJ4kjZ0lX4nM
Message-ID: <CAADnVQ+qS2V4j8ADCK+6GoUXcDnS+6+t3yLiTQY-GQ=Kmj0ymQ@mail.gmail.com>
Subject: Re: [RFC bpf-next 3/4] bpf: Generating a stubbed version of BPF
 program for termination
To: Raj Sahu <rjsu26@gmail.com>
Cc: Siddharth Chintamaneni <sidchintamaneni@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Dan Williams <djwillia@vt.edu>, miloc@vt.edu, ericts@vt.edu, 
	rahult@vt.edu, doniaghazy@vt.edu, quanzhif@vt.edu, 
	Jinghao Jia <jinghao7@illinois.edu>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 12:11=E2=80=AFAM Raj Sahu <rjsu26@gmail.com> wrote:
>
> > That's exactly the case I was concerned about earlier.
> > These two insns might generate different JIT images,
> > so to prepare patches for text_poke_bp_batch()
> > the verifier needs to coordinate with JIT.
> > Replacing call with mov is a danger zone.
> > iirc "mov %eax, 1" is 5 bytes, just like "call foo" is 5 bytes.
> > But this is pure luck.
> > We should only replace a call with a call or a jmp or a nop.
> > See map_poke_track/untrack/run logic.
> > Maybe we can reuse some of it.
> .
> .
> > text_poke_bp() takes care of that.
> > That's what the "_bp" suffix signifies. It's modifying live text
> > via 'bp' (breakpoint). It has a multistep process to make it safe.
>
> We were exploring the suggested design on a high-level.
> The idea of moving patch generation after verification is really
> simplifying the code.  We are also exploring whether we can
> move it all the way after JIT.
> There is a clarification needed.
> If we need to support global termination, we need the call sites
> (prepared during load-time) and pass it to text_poke_queue() which
> will take care of patching the call instructions in-memory.
> In this case, the only information we need is the call sites and not
> the patched program (which we can free-up towards the end of program
> load once the call_site information is obtained).
>
> However, if we want to support per-CPU termination (for the case of a
> super large per-CPU map causing large runtime, etc), we will need the
> patch to stay around.
> In this case, the termination handler (bpf_die in code) will perform
> the `rip` change and stack modifications.
>
> So, are we looking to support both, or just global termination?

I would keep things simple and support global termination only.

