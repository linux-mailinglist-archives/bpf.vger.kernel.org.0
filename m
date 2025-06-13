Return-Path: <bpf+bounces-60623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 655C2AD93ED
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 19:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 629721BC2C10
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 17:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E051211A23;
	Fri, 13 Jun 2025 17:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDds7UR1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B156F1DF751
	for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 17:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749836825; cv=none; b=emU73OFhTQNlNmOdtf+Qs+MM62DVgB0RBCaUweV+cd4t1FJfxorMHRkbcocQZBpyeJXl42dIqQNoCxQVuS86lWx8M4IFnfzwaTsPWrrOVxLrSG+Yd0AKF0gTBG85hq1bn/3jNZx97FEQaTlmcEc+/lLqoIClw83tFtAhgKXnkuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749836825; c=relaxed/simple;
	bh=pH7T8p8/YBAg1NL5UfOcdAq2pSxXgMHGf23J5eS0Xnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gVavkX8pNcC4M2Z3vbbb9A7sP9GhiCNktvMZZ9cE+OSQa/k3EbEKrisRu7+VTqmnqb27vnTB9xFg2yI4FB63nt4dA6ugdRUClonoRvZ+B63B4LZHLu/peTMSKN8UFQz9pOnFguk5NOE72Nj/rcM7bx5Y4EEFTwYXOIXQTk4EL9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDds7UR1; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-af51596da56so2154456a12.0
        for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 10:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749836823; x=1750441623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Ppsj0vi51ApFAZ+uJpu5EQrwywr4TnH/0V+YUF5Kjg=;
        b=ZDds7UR1Qa+lIpDet4fPx/i9eRIlOVfXImQu1eg+d8S9qUYOAVrc8km5xWqJomaBeN
         y4dfTnNTs5v7IUZyjS43dQgAf06BwefyqCXt6uUwDq4dCb0kPRyIGIMmPyrIH7cxxWwt
         rb1Mq1S/heArAhcCqGV3od+yW/6d77J98ZcYV0/QuoDGwOjOCQC9RdgOLR1+UoyBA9AL
         Q/uGvtHMmoOTN7MHedSCjkxEJIhPZjiAndII2P6u7GKiNO/JU8mpGMal1D3XYBn2O8NR
         P42/B/oBhJ36En8joRugDLBhFi1Gp4YxW26l+i1VpJnwdY66ueQqYJojA+Z85Meln0ZK
         DC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749836823; x=1750441623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Ppsj0vi51ApFAZ+uJpu5EQrwywr4TnH/0V+YUF5Kjg=;
        b=DeHmlkC0avATMTOkGZ2/xh4gHdsFB6PtSB2ctyfCVPVffqnD32A1XFe2QXnuPSRzwY
         E/k93QRbymwPBglmhNokXth3HRRTadHXeKTuIrO2xXsKjKKhXCPhhhxuuFL8xF3ww2IN
         50c9rI0iQ0481rACKzRz9qpZSHIV7E2Qc0kHTCadGCRb7GuQbHypHZ/owRzrxN+Xn36V
         IG1ljK9oAJNaIRfIhShm39C+kS1AHQdclkrE+V5sAVbpLZN/tF62gbH/Pf/eblH5uh2B
         TgYeTjGALi9QvOGIJ8dAkEjmU7YxTSYiMICGZsVn0ot253mDGy/KDoe37TrJxg+o2Ztu
         dnhQ==
X-Gm-Message-State: AOJu0YybDntZFXzdWxBN3+7W2UHnHZkW5imzJvx9Diwy/UIdvLhLxKey
	ZqtJyyx1d4jku9KAaoBa+bYSIjRrVyByZQJvR4RLZINTIJ+uYS54LcefL4VpCCHz+CaymMzP8G2
	Z3MxfV9uuWajH3lHp0eE+yElr7Wj9PQ4=
X-Gm-Gg: ASbGncvRPwbBds6dAJCcxEtm0aphg0ywAAe7olASp87jLd41gyfL2/csYVVE9VpQKfD
	EgH33pQM/GdTaftFyGDtKFdY93hb6E5sAG+Qw8naGF72FwxhFAD5Oagia8Wo8BiSHbPKtz2bDw6
	nov68AwpKvW8xLPp2ZmorH+YvsI0RnbRsIXfRmdZmeuFZuNGMAcnn9OVpvbBg=
X-Google-Smtp-Source: AGHT+IEHAwk1kdaGPHZG48a0o4E36KpDvXZbSPXxinOujDtX0RzahP1XrwEDM5VkZro1z1fj8O3VqBL9cM+Uahb32oY=
X-Received: by 2002:a05:6a21:2d8c:b0:1f5:6e00:14db with SMTP id
 adf61e73a8af0-21fbd4d57a5mr341316637.14.1749836822838; Fri, 13 Jun 2025
 10:47:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613072147.3938139-1-eddyz87@gmail.com> <20250613072147.3938139-3-eddyz87@gmail.com>
In-Reply-To: <20250613072147.3938139-3-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 13 Jun 2025 10:46:50 -0700
X-Gm-Features: AX0GCFugkcVXqCxm08oP3-QR-BN_VaUorySiUvqFKkEfFWuiYmHLqtctXwvEBAI
Message-ID: <CAEf4Bzas8GQdw8u1ZHwbs4QgXGwwf1-sfo38OBm6Gk36nEcvJg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] veristat: memory accounting for bpf programs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, mykyta.yatsenko5@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 12:21=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> This commit adds a new field mem_peak / "Peak memory (MiB)" field to a
> set of gathered statistics. The field is intended as an estimate for
> peak verifier memory consumption for processing of a given program.
>
> Mechanically stat is collected as follows:
> - At the beginning of handle_verif_mode() a new cgroup is created
>   and veristat process is moved into this cgroup.
> - At each program load:
>   - bpf_object__load() is split into bpf_object__prepare() and
>     bpf_object__load() to avoid accounting for memory allocated for
>     maps;
>   - before bpf_object__load():
>     - a write to "memory.peak" file of the new cgroup is used to reset
>       cgroup statistics;
>     - updated value is read from "memory.peak" file and stashed;
>   - after bpf_object__load() "memory.peak" is read again and
>     difference between new and stashed values is used as a metric.
>
> If any of the above steps fails veristat proceeds w/o collecting
> mem_peak information for a program, reporting mem_peak as -1.
>
> While memcg provides data in bytes (converted from pages), veristat
> converts it to megabytes to avoid jitter when comparing results of
> different executions.
>
> The change has no measurable impact on veristat running time.
>
> A correlation between "Peak states" and "Peak memory" fields provides
> a sanity check for gathered statistics, e.g. a sample of data for
> sched_ext programs:
>
> Program                   Peak states  Peak memory (MiB)
> ------------------------  -----------  -----------------
> lavd_select_cpu                  2153                 44
> lavd_enqueue                     1982                 41
> lavd_dispatch                    3480                 28
> layered_dispatch                 1417                 17
> layered_enqueue                   760                 11
> lavd_cpu_offline                  349                  6
> lavd_cpu_online                   349                  6
> lavd_init                         394                  6
> rusty_init                        350                  5
> layered_select_cpu                391                  4
> ...
> rusty_stopping                    134                  1
> arena_topology_node_init          170                  0
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/testing/selftests/bpf/Makefile   |   8 +
>  tools/testing/selftests/bpf/veristat.c | 248 ++++++++++++++++++++++++-
>  2 files changed, 249 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index cf5ed3bee573..dd598ca771c5 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -841,6 +841,14 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
>         $(call msg,BINARY,,$@)
>         $(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o =
$@
>
> +# This works around GCC warning about snprintf truncating strings like:
> +#
> +#   char a[PATH_MAX], b[PATH_MAX];
> +#   snprintf(a, "%s/foo", b);      // triggers -Wformat-truncation
> +ifeq ($(LLVM),)
> +$(OUTPUT)/veristat.o: CFLAGS+=3D-Wno-format-truncation

fixed formatting around +=3D, and dropped LLVM check, I think that
should be handled by -Wno-unused-command-line-argument we set earlier
(`make LLVM=3D1 veristat` succeeded without any warnings for me, FWIW)

applied to bpf-next, thanks

> +endif
> +
>  $(OUTPUT)/veristat.o: $(BPFOBJ)
>  $(OUTPUT)/veristat: $(OUTPUT)/veristat.o
>         $(call msg,BINARY,,$@)

[...]

> +/*
> + * Creates a cgroup at /sys/fs/cgroup/veristat-accounting-<pid>,
> + * moves current process to this cgroup.
> + */
> +static void create_stat_cgroup(void)
> +{
> +       char cgroup_fs_mount[PATH_MAX];
> +       char buf[PATH_MAX];

I hard-coded these to 4096 given we hard-coded 4095 below.

[...]

