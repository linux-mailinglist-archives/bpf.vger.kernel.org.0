Return-Path: <bpf+bounces-66621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 889AFB3786B
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 05:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 694444E1BD2
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 03:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95C31D8A10;
	Wed, 27 Aug 2025 03:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCzVeDaF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8D614F9FB;
	Wed, 27 Aug 2025 03:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756263896; cv=none; b=EMFengMmWKjsxAJTkzVdmCO6mG3FDerL5h/S0Ub7rS99xR1faoj35HDGJcvbrPAUvasBg3URy+qQSti+nI+8SvqUtHsOK8WLVRCejBtdn+7b8+tyheUlb0EJ1WUtOdviUvkSovICDJLagz3CsmLDz2qpO2MLn0jM9HJ6psQ9njA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756263896; c=relaxed/simple;
	bh=smOktKjtdRWIwgo7/OB0VenJcvMyx+oeyyre95NO4P0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XhALR5tYQpqGyY2H78TUvZDBd+FMiqheDuk63aQidUIw+8Cd25ttw83ubTu0ZV9WF/rMOR0gMvqtQhzSMj8/TgyGm01m1h7+o3RDBZVc919M8PEmqN/4yOWh58AlmaVAh6mviy30spPEuCxrgPnNJrJReWaNH6iizxBm2I2OX58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCzVeDaF; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45a1b066b5eso34069155e9.1;
        Tue, 26 Aug 2025 20:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756263893; x=1756868693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smOktKjtdRWIwgo7/OB0VenJcvMyx+oeyyre95NO4P0=;
        b=hCzVeDaFGaJha1OUZHsquva3/C8b5Kl/3TNL0D174oMRTpLdOmrtadgJmuvrBvKSx3
         hlH/FDc4vVEtiHIfVxduqNSDrbxjETwLmfNbcwMrLO9nK2tJSM0WrdoD6g7kkveQoomL
         I7fqWk8KFiOx/mV2ajDtQbqOMrR7KCnQXCGxbdJAHw1pCxaPulZuF75Xte0Li51ztqqL
         MnoDOO+NtfJiylCg9cjdX7jbeAcd7681IodnT9XPQDisjrqkdx2dR8GQ6VtysddYw95z
         pcerQB2F0fGnmoRz0qw8E7RaV8JpstH1dM0N3tCxK/n2Wurfq2wwGUsfs92gthN39nlJ
         jEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756263893; x=1756868693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smOktKjtdRWIwgo7/OB0VenJcvMyx+oeyyre95NO4P0=;
        b=eoI4/TZKre6PxMexZOS+FOhhn7VJCCemIRvyGtxUwlN88b2sSOjhjxktH5tnASOZDG
         oGvRnIIMdkUYp8K3itUY/l8CmT8wnmVOtzWNhUZvMq0YQwMI4kyANXOJ0Gx8A/XjG8z7
         IQ1OiMZIPJhuu5lgx9EhzsxjIwAX34YOg8VePMcwMFou/ZWCzctOKHgHprLYbDJB56ZC
         9g8WggjhvVONVchwhHcqy5o26JeOcdpVajyxRlIypJGx/CEoPERrk8e1NaPhaPA2tbbW
         WxiOk7eMrQlyVTYkF9mI1bS3RM5TE9SxqpJpon5GMUZGl5DkS5tllqj3K4aOEeXkkVoM
         FNrQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1zeJcA13nhKfg2rjdPQyfmE6Irf8T5vo8gW/+PqSTeMGQ3ZBLqLFoeRCIbCSd8hTL+FU=@vger.kernel.org, AJvYcCWetxAwwJ+pmnTjPUzEp2fGgUpNPC8Lbf3hTjdWBdjYJO5AisVObycMa2KeR8XplOBQCAaoT4lz5pBsoG4h@vger.kernel.org
X-Gm-Message-State: AOJu0YzdiJcw+Ak+9a5anRHS6wggEDumPAQuk5ZMH8QZPabGMxH4osze
	2f29IiYTRaOlX7JIYQPXiWFDwDLNdL09kE6A99S86KQsWN7MWldeu1C5Y8oCuvqb0eyuoKBDxwq
	NIaBk/y3c+fiYiNtnc4Kq+p/WVZSFL5g=
X-Gm-Gg: ASbGnctt7w0cfHz/FF6fjBXHVuwxU2rGXWZDq1xf68mEc6TWjOhzMTN+0AX5neCKQzD
	tJSOnFhYnxCYXs9o2fU2F6I8oLcwDY/wTWWzw7IEILbrL/Bgf2PVLczZdU+HMweuPn6QKrTjM8k
	uWEbN+KYwm5WZo9ClTntfp1lafi02DMS0FEhLaWUHYFK0/6wlRyyBmVikuDqGJv1Hnjh9ygHq97
	dLrHL7jR97zEJ3w4ztgT+q0g3wLZpGWEcA5s2+dkHyZyS0=
X-Google-Smtp-Source: AGHT+IFitAmGYZ56kr5IFaTzqBojnOv6C7rCTjgvF16llJhFePceMI6lrkUpiozItpobt4XgXOYYFrG79nOnv0ObZPQ=
X-Received: by 2002:a05:600c:5493:b0:459:eeaf:d6c7 with SMTP id
 5b1f17b1804b1-45b517c2e69mr130967235e9.26.1756263892927; Tue, 26 Aug 2025
 20:04:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821093807.49750-1-dongml2@chinatelecom.cn> <20250821093807.49750-2-dongml2@chinatelecom.cn>
In-Reply-To: <20250821093807.49750-2-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 26 Aug 2025 20:04:41 -0700
X-Gm-Features: Ac12FXxG2JTrP3izXMlp35kGr_LV5o12GnoztWhZlRDTE1Syy9dnAPr999ZkpCY
Message-ID: <CAADnVQLtvygmqCk5QHmHCURAYiLET6BpCxX7TkqmuAdXZ5trZg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] arch: add the macro COMPILE_OFFSETS to all the asm-offsets.c
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Benjamin Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	tzimmermann@suse.de, simona.vetter@ffwll.ch, 
	Jani Nikula <jani.nikula@intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 2:38=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> The include/generated/asm-offsets.h is generated in Kbuild during
> compiling from arch/SRCARCH/kernel/asm-offsets.c. When we want to
> generate another similar offset header file, circular dependency can
> happen.

Is there a way to avoid all this churn?

> For example, we want to generate a offset file include/generated/test.h,
> which is included in include/sched/sched.h. If we generate asm-offsets.h
> first, it will fail, as include/sched/sched.h is included in asm-offsets.=
c

if so, may be don't add "static inline void migrate_disable()" to sched.h
and instead add it to preempt.h and it will avoid this issue?

> and include/generated/test.h doesn't exist; If we generate test.h first,
> it can't success neither, as include/generated/asm-offsets.h is included
> by it.
>
> In x86_64, the macro COMPILE_OFFSETS is used to avoid such circular
> dependency. We can generate asm-offsets.h first, and if the
> COMPILE_OFFSETS is defined, we don't include the "generated/test.h".
>
> And we define the macro COMPILE_OFFSETS for all the asm-offsets.c for thi=
s
> purpose.

