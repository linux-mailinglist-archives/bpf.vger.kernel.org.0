Return-Path: <bpf+bounces-15097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 332AF7EC7F6
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 16:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B8081C209A5
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 15:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FCE433A8;
	Wed, 15 Nov 2023 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIKGNKUZ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C013D31720
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 15:54:28 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB67101;
	Wed, 15 Nov 2023 07:54:27 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32f8441dfb5so4798388f8f.0;
        Wed, 15 Nov 2023 07:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700063666; x=1700668466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mAv4yuO0oAcw2e4HAvKfHMXrrbl1fK6mnENT61XvBWY=;
        b=AIKGNKUZrHb9SQ2bIEipp9BsNkiEZCWOGm8HXoATxJ5M83eCBTHgdSPgtb/oTn+xlJ
         A/sxi64MbAgf9Skwvu+mYSkiiID4NcXFEanXZzawoJYOuGIG0N7Ah/ekQghwypVcdm0D
         DYtff8nuGaUzpgLgNEWBbrZZOvs55n1iqkJ1I4GxOFVJ3Fml7sEIH2zKeKElmP2qpcad
         lhzFvgzDDMGxjseRQqTOAPhVq0hK93pOSO+uPs4NYGmBIExkYa85JXC0tc4IHiGaoxd1
         0YTinYXg/ykUvnFKNaWR2j+1VDCy/1KOOeAEjg6mTWW5yKWYJZnqTs4RBqub4JXGz+KZ
         XP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700063666; x=1700668466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mAv4yuO0oAcw2e4HAvKfHMXrrbl1fK6mnENT61XvBWY=;
        b=It/22BStVCJI3gVcA29ccdagAiz9IVQ1l2YggbeZD0pJpCnqd3z6CTV8uYw024ySnH
         dzdgVPwbnReH69n9/E2UJWNOdjy5FiFx7nqcHc/R/MJhdh6mlrA+Ejx881M1mz15D2Pb
         CpGFb3cD65afb5+sbPOFyiTRGFfx9+CytG7wORWWpt3dihriDwaHGO+CDhPL4W5MvLvR
         3XGZ5Txqbsv1b8ph41kAMkByiGZmCu17iXPwV8k4a+V0oDocmTka13qgv/BtWVAZou2G
         VL7kkVVTH1zXPmAciRltIMOJyCf97hvIW3rX4JH4it6cXA81rMazRv2b17VrwfXDM6fd
         rrfQ==
X-Gm-Message-State: AOJu0YxTrBqdAprYFQn3shlr49hzcI0yM2Gw0aa6PdN67fqR0Lj0PQS1
	xjJN6Hw/U9G2v4jv+Ev5MAARgmS2SxI5FtieXZQ=
X-Google-Smtp-Source: AGHT+IGARab6HUI1V/sfRL6+E0bofbX6pKhItjE2MLcbMVX1OBGE29yLWwD0mRPq7cK2FCCSO9iaAjC9K28VvXBk4Eo=
X-Received: by 2002:a5d:64c8:0:b0:32d:8220:8991 with SMTP id
 f8-20020a5d64c8000000b0032d82208991mr10045645wri.8.1700063665559; Wed, 15 Nov
 2023 07:54:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230827152729.1995219-1-yonghong.song@linux.dev>
 <20230827152734.1995725-1-yonghong.song@linux.dev> <20231115153139.29313-A-hca@linux.ibm.com>
In-Reply-To: <20231115153139.29313-A-hca@linux.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 15 Nov 2023 07:54:14 -0800
Message-ID: <CAADnVQLmFp7WmzDzYEhE8PgnNpv8SrWfuCB1bz493L98dsER6Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 01/13] bpf: Add support for non-fix-size
 percpu mem allocation
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Marc Hartmayer <mhartmay@linux.ibm.com>, 
	Mikhail Zaslonko <zaslonko@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 7:32=E2=80=AFAM Heiko Carstens <hca@linux.ibm.com> =
wrote:
>
> On Sun, Aug 27, 2023 at 08:27:34AM -0700, Yonghong Song wrote:
> > This is needed for later percpu mem allocation when the
> > allocation is done by bpf program. For such cases, a global
> > bpf_global_percpu_ma is added where a flexible allocation
> > size is needed.
> >
> > Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> > ---
> >  include/linux/bpf.h   |  4 ++--
> >  kernel/bpf/core.c     |  8 +++++---
> >  kernel/bpf/memalloc.c | 14 ++++++--------
> >  3 files changed, 13 insertions(+), 13 deletions(-)
>
> Both Marc and Mikhail reported out-of-memory conditions on s390 machines,
> and bisected it down to this upstream commit 41a5db8d8161 ("bpf: Add
> support for non-fix-size percpu mem allocation").
> This seems to eat up a lot of memory only based on the number of possible
> CPUs.
>
> If we have a machine with 8GB, 6 present CPUs and 512 possible CPUs (yes,
> this is a realistic scenario) the memory consumption directly after boot
> is:
>
> $ cat /sys/devices/system/cpu/present
> 0-5
> $ cat /sys/devices/system/cpu/possible
> 0-511
>
> Before this commit:
>
> $ cat /proc/meminfo
> MemTotal:        8141924 kB
> MemFree:         7639872 kB
>
> With this commit
>
> $ cat /proc/meminfo
> MemTotal:        8141924 kB
> MemFree:         4852248 kB
>
> So, this appears to be a significant regression.
> I'm quoting the rest of the original patch below for reference only.

Yes. Sorry about this. The issue slipped through.
It's fixed in bpf tree by commit:
https://patchwork.kernel.org/project/netdevbpf/patch/20231111013928.948838-=
1-yonghong.song@linux.dev/

The fix will be sent to Linus soon.

