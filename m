Return-Path: <bpf+bounces-71139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3C3BE5135
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 20:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0D31A63284
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 18:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3ACA235362;
	Thu, 16 Oct 2025 18:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGDIKHOK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A7D231858
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 18:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760639868; cv=none; b=UIEeOA+pZAI6Kcfkkkk7Pir9Q51pIGwqN3gyVvZaZMNUa01toMbvUlJbu03+HOa+xoxOhxQZnX8sPR13tGMbEGnnUZitigVuiRTyKvH0goR3pt2yLAqrcViB8/41sdhkwJ7iYCR7dY6e1s9rsaNy6fky0r2+KfeN/taujIQJRRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760639868; c=relaxed/simple;
	bh=mEk/ihgjrTuNNnkjy/cHNlZgaSrP44BKM7C4+20O3Kg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1v7BCRjUSJ+N7kDL1It+7wKtOOorKONtvHarFmuPCK0m6kyulTQ1jmoyKp3Z/fzCuHqXm3cBmxkdlMTMeK+HoSPf2Oayah4IhiBNSfKViqhgMK36Kc7gEK3ljyddBfs1KIf1nYx/3C860tcjmmn6g1OVj33+iz98+q4yVpTpWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGDIKHOK; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-339d7c4039aso1070165a91.0
        for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 11:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760639865; x=1761244665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hpYzCt8aE/wCxxGZYRuLTHqRQveqeD55HUUcOTJNlI=;
        b=eGDIKHOKo24YcqRWGs5PqbdWlIdMDnQp6dF7Fyh9SpSev0R7xkyztBm8faqqnHinh3
         PvzD7uazPDNWi0RghoPPAubqFZWKBIjkdBqg1dDyFkGZGH4+fwrTMumc0ZBsV0W/JPmE
         HtwVkbSFZozpVUc0SYwLMXx8Okdg/ke9JFUy6i9j7gZ2pxzAHhGmRlcFvjd7rgp4cg2J
         UlD1DK8b1pUN9bOZI0Q4OrsGw1lIajOe+siQC4gbU+BtDCtFzjG66P4it5ybDbvt1gxx
         EdhPmiJowMMpJjjBqWStLou1NJj5tPZlRpQ7ASQjX9fuhKVidFLmWUQPIsDAInj+yL0Z
         l1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760639865; x=1761244665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hpYzCt8aE/wCxxGZYRuLTHqRQveqeD55HUUcOTJNlI=;
        b=VnARoDnCoc5g//32njauVQ9ztn/NxldjfBC8SfF9YyWQo6/93qNuDUtCJ1sjPNsTBN
         UCLb1Pqluos6U+dn/guDkP885stG2pdHY95Vk9yLs98ajnm1FNmdtbJYH46V6XWaBqn7
         JjmT39vLoO1UQJQhV1z7tsvzdPZ0LnA3S+eUZ2kn/07xiGtkAsywI3Lz1Qd0GieHaxa7
         pVZrZXIUgT9+DZT5eXWE6djJ5OFyc8x7jXF7P0XMc76Bdeus6oja/i39k5VaPkGaGBVW
         xPFZhApsLBLtbMePGzSetT+XWwd+/avjUYOnW1xIuAzBBAeZmyrMobEWVMeIoIPqhoDw
         G8ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbwjvRPZUV2yexAFUIL2YJRNHpZMCXdNI5ZchSEBHzrWhKBe1XrOUldEGT/E7X9GVI3cc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxfcaTGgBMWsX4XaV3BJlgtTJ3grCZSQ9Z6FRLX52UKh76RuqL
	ibGDliLBwmeQ4+r4LqUvjSgTqx2KYoJk9+Ru2ns+JBnOolbBJWWhv4DvX+++2KZh601HMrbK0+9
	VTMIM9/mseyttnBeznW7pnqKQtGta1ZA=
X-Gm-Gg: ASbGnctI1SzLY5gpocEhX1zyrIquePBtdPc1BzzkvPTgHYtQ+3I3t4/wZi/cuBNnCMM
	vCZERlXDA1//7uYEi8BYs2QFzjxVF+vCm/cd21FCP0M9rDEiBVwk9I3/RmffH3fE22WbNaQOosy
	GqZiiUkhIVIbfFNa/9uvomADB8KmfNPliaqulKJtp7MUAwhHffL0rLAsXcaFLBkFnMB/RD6CSm1
	jwKkEMexchVIhQDnUqHg2oAa3qHPXu6TfMZ3TSFoUAw/irz25ykKYrrEmcf5JRs0Rw0+xof5Edu
X-Google-Smtp-Source: AGHT+IE5rKGvc6OrrMnSDNQktfGAL8EcS5Ab2dzXlyTjLneNVTb/Vz7Zyvp3ClViojp4pg4kDQ8cEmKkDcl6ey+kIW8=
X-Received: by 2002:a17:90b:4f:b0:33b:bf8d:6172 with SMTP id
 98e67ed59e1d1-33bcf92aae9mr899435a91.34.1760639865380; Thu, 16 Oct 2025
 11:37:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008173512.731801-1-alan.maguire@oracle.com> <20251008173512.731801-13-alan.maguire@oracle.com>
In-Reply-To: <20251008173512.731801-13-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 16 Oct 2025 11:37:30 -0700
X-Gm-Features: AS18NWCZW89mWeFPQxtXNQFxHRAg-r_TLnvmVJpIq4KKP-WUMx2aeLnnIqP9BjY
Message-ID: <CAEf4BzaharR9cnR9Yd5Shoq8A6afJo0HW+N7cw3k9JhGZmqY4w@mail.gmail.com>
Subject: Re: [RFC bpf-next 12/15] kbuild, module, bpf: Support CONFIG_DEBUG_INFO_BTF_EXTRA=m
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com, 
	yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	qmo@kernel.org, ihor.solodrai@linux.dev, david.faust@oracle.com, 
	jose.marchesi@oracle.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 10:36=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> Allow module-based delivery of potentially large vmlinux .BTF.extra secti=
on;
> section; also support visibility of BTF data in kernel, modules in
> /sys/kernel/btf_extra.
>

nit: whatever naming we pick, I'd keep all the BTF exposed under the
same /sys/kernel/btf/ directory. And then use suffixes to denote extra
subsets of BTF. E.g., vmlinux is base vmlinux BTF, vmlinux.funcs (or
whatever we will agree on) will be split BTF on top of vmlinux BTF
with all this function information. Same for kernel modules: <module>
for "base module BTF" (which is itself split on top of vmlinux, of
course), and <module>.funcs for this extra func info stuff,
(multi-)split on top of <module> BTF itself.

> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  include/linux/bpf.h       |   1 +
>  include/linux/btf.h       |   2 +
>  include/linux/module.h    |   4 ++
>  kernel/bpf/Makefile       |   1 +
>  kernel/bpf/btf.c          | 114 +++++++++++++++++++++++++++-----------
>  kernel/bpf/btf_extra.c    |  25 +++++++++
>  kernel/bpf/sysfs_btf.c    |  21 ++++++-
>  kernel/module/main.c      |   4 ++
>  lib/Kconfig.debug         |   2 +-
>  scripts/Makefile.btf      |   3 +-
>  scripts/Makefile.modfinal |   5 ++
>  scripts/link-vmlinux.sh   |   6 ++
>  12 files changed, 154 insertions(+), 34 deletions(-)
>  create mode 100644 kernel/bpf/btf_extra.c
>

[...]

