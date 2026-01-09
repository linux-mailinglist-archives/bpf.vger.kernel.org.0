Return-Path: <bpf+bounces-78426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B49D2D0C8F0
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 00:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED6CF302E616
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 23:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA57634251C;
	Fri,  9 Jan 2026 23:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbR2tvXy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E527033D6CE
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 23:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768001836; cv=none; b=qGHidvQCMWduq2ZCI0Y1mJ71BxVCDU7B2ANau5inCF2sWVIlVdtXm5bIMqkLUl2CfkvtOnUMlecax2WD1zAWgGnHmH8NMJdPYYdmaEyxJd1RzYk2YEd3GT42GDTEiHcuMqnFNERhnSyagRQ9ozpMvbjRY+q0nLySAz5PDWv7ALE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768001836; c=relaxed/simple;
	bh=1SlvpZwfawOOFUbunaO4aOZEDljdwcY5JnICiqQ/8qo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U8+CYJT1C/RCNwJcJi/1wDCcRNi9xHVJ2ThSugUEKrto9O1Ez/PDZieWvKx0Y4fhaF0XWdO3oMHy/3/cbHSxZIBJMOA87ITnK689/5uUba+fZb+Zdh8U/hWSMHxgsVXM/JiXNqAAR0C5o536zl/XMTiM8nrmjS+zRDYMyG5GL8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbR2tvXy; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34c30f0f12eso2788547a91.1
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 15:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768001834; x=1768606634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZETOpYKlt2aIMK30at0U6iQ9diSp7g6ayNJ4wI5uaek=;
        b=lbR2tvXyBBav/AVLELFWzMeSi8dBPL3VSa+gkX3WeC7HnfrIPSkzgo7dyWHH6hUhHz
         x7HnXJOD4vXmK+2XCYyx0xxjdNJxUcIO+Ej5Z87zHJdygYolqmBP5+aJF1p6CmxZ6226
         Z577wueCUa0JcmD7T9Yu4bi5yxMGyeuVJhIBkQhMX+R/fHZcvAz6JBMK9aGaKhJ+ujiK
         SUR/Q5wZklsLauTk5qpODMGz0EM8Ft+0I84WJeFtGFbfEQiT3qQoBnKM+thuw1f3PtDh
         eXUhgGvLe2IiYgMqeZDEk8+qAzdhBPKt8f5iK9o1EezxtSoZciUbE5W1aiy6oqf3tzWr
         4GYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768001834; x=1768606634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZETOpYKlt2aIMK30at0U6iQ9diSp7g6ayNJ4wI5uaek=;
        b=erOHkRyRUUMKJUAhoxtYx0mSAWQrQSRQ3ZJi4W4qNGKU2al9VYsGe6OloSWQHnxgDW
         QkKTPKfWiHsD+TLQyXBo6tcIbx7g/BWtgzdcH/SAFl0zZS+PjUQ98GZ6EAZGUxY5RADL
         SmlBzNu7BoSKrOtIW+wHsSp8+lKnJHScFVQAQ4Ol4FIov3lf5NJhSDA3s+B45pTA3Ori
         RQevzPIIXJwNPi6sJ1jdNM9aajVTLBEVKcjGcdmvr2lRSEXCpvV6sV4YMYxd/N2y16Kp
         6wlEin7J+LTCVhVKpvGxnsaWJmhQDrx15maJhMpc5A4at4y+jeMgYZ6ph3wECq++90wR
         ZhIA==
X-Forwarded-Encrypted: i=1; AJvYcCVklH74BD/+jEAeCtICJpaRrY+9pzZdQAwkKAMYEviD19o75B6kMd5HTf51xtgbz84fLgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRuvgK9RxARpcEaixQpIpdMeqQoOofVyFQteFM4HX2w6rjm3/t
	oTjiUL/n9OpYv+GMJtKll5BFV/D3Ufid584gM3G2b26zOblWczfjBQyp/ZwBb2ipfpTCP40q9mb
	9kzGT/vdLWTSx8K9nHHO3YdHVxoaXf+s=
X-Gm-Gg: AY/fxX6KroubguWsWv+rNeBzKWNpsp/VIF/XbI6tEnaDoqwC8zHevVSu1s1NNoSRpSm
	moAQGKwN8wuLq0lQFwNZRZtPShU6rZejahhyckdqL2L/7HeF+dTcqam/8BAJo/iioROGR1bRSqG
	S+4s+8SSMhm8dpY1RDetF+1tmWAYWXcYVPHiv+3g/rkSforInyF6Btz2SQnLYuZYT6s320V+Pjb
	DSvhGiAn+CsWRh+yiVS37C1fDGfZKPuw8K/CtbFwizeZJRB8mfAsNxcao/UAczUX0Pt0LEuzueo
	QZublSqR
X-Google-Smtp-Source: AGHT+IGOpR73HGmsdZPqBRAPTMSGiSBBXviNkDMHjCXiL4Wfh991JTJhNzAWgluLVqxIQYzhOuAz42p4QQc1bZL4hr8=
X-Received: by 2002:a17:90b:17cf:b0:33b:bf8d:6172 with SMTP id
 98e67ed59e1d1-34f68c47b32mr9547057a91.34.1768001834119; Fri, 09 Jan 2026
 15:37:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108225523.3268383-1-wusamuel@google.com>
In-Reply-To: <20260108225523.3268383-1-wusamuel@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Jan 2026 15:37:02 -0800
X-Gm-Features: AQt7F2rytjA3C04wtUx2mrFaOoAem4wdNbep4rCP4kTsqog7NcxooRbuSyKXfj0
Message-ID: <CAEf4BzZv9kCAmX0Fo4kR8qh9mu5NB-wLDmNAK_R=VzcxL7VPpQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/4] Add wakeup_source iterators
To: Samuel Wu <wusamuel@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 2:56=E2=80=AFPM Samuel Wu <wusamuel@google.com> wrot=
e:
>
> This patch series introduces BPF iterators for wakeup_source, enabling
> BPF programs to efficiently traverse a device's wakeup sources.
>
> Currently, inspecting wakeup sources typically involves reading interface=
s
> like /sys/class/wakeup/* or debugfs. The repeated syscalls to query the
> sysfs nodes is inefficient, as there can be hundreds of wakeup_sources, a=
nd
> each wakeup source have multiple stats, with one sysfs node per stat.
> debugfs is unstable and insecure.
>
> This series implements two types of iterators:
> 1. Standard BPF Iterator: Allows creating a BPF link to iterate over
>    wakeup sources
> 2. Open-coded Iterator: Enables the use of wakeup_source iterators direct=
ly
>    within BPF programs
>
> Both iterators utilize pre-existing APIs wakeup_sources_walk_* to travers=
e
> over the SRCU that backs the list of wakeup_sources.

One reason to add either open-coded iterator or iterator program is
when you need to work with some kernel object (i.e., if there is some
additional API that takes that object and somehow manipulates it) or
if traversal logic is involved in terms of synchronization primitives
necessary.

In your case neither concern seems to apply. Looking at
wakeup_sources_walk_* helpers, it's just a simple linked list
traversal and struct wakeup_source has plenty of plain data fields of
interest, if I understand correctly. You probably are not intending to
allow locking it or manipulate wakeirq, is that right?

So I'd say you should do this using bpf_for() generic loop and
bpf_core_cast() helper. The only problem is that wakeup_sources global
variable is static, so it's not that easy to get its memory address
(to start iteration). Maybe look into working around that first?

pw-bot: cr


>
> Changes in v2:
>  - Guard BPF Makefile with CONFIG_PM_SLEEP to fix build errors
>  - Update copyright from 2025 to 2026
>  - v1 link: https://lore.kernel.org/all/20251204025003.3162056-1-wusamuel=
@google.com/
>
> Samuel Wu (4):
>   bpf: Add wakeup_source iterator
>   bpf: Open coded BPF for wakeup_sources
>   selftests/bpf: Add tests for wakeup_sources
>   selftests/bpf: Open coded BPF wakeup_sources test
>
>  kernel/bpf/Makefile                           |   3 +
>  kernel/bpf/helpers.c                          |   3 +
>  kernel/bpf/wakeup_source_iter.c               | 137 ++++++++
>  .../testing/selftests/bpf/bpf_experimental.h  |   5 +
>  tools/testing/selftests/bpf/config            |   1 +
>  .../bpf/prog_tests/wakeup_source_iter.c       | 323 ++++++++++++++++++
>  .../selftests/bpf/progs/wakeup_source_iter.c  | 117 +++++++
>  7 files changed, 589 insertions(+)
>  create mode 100644 kernel/bpf/wakeup_source_iter.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/wakeup_source_=
iter.c
>  create mode 100644 tools/testing/selftests/bpf/progs/wakeup_source_iter.=
c
>
> --
> 2.52.0.457.g6b5491de43-goog
>

