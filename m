Return-Path: <bpf+bounces-60125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0C8AD2AFB
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 02:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A399A1700AA
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 00:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6501199EBB;
	Tue, 10 Jun 2025 00:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLnIS+Lv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC3118FC84;
	Tue, 10 Jun 2025 00:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749516342; cv=none; b=h6f76A7ws5HTi9ns4MQ/IOsBGyHn3zHL+rYXxW2RRN8BKHlOtwcIerxd/3UmwV8iqGizGwxAt0VHNvxlUdqHADbaLTNvHS6+CI1kmyn8VdytzC9NqPn1/UDZVBXxR+OT1dZv2+bBBERZg6ET65676RHWHFeMJIjO9u9XzpJx2iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749516342; c=relaxed/simple;
	bh=Ori/KbuAQ4TV3cThealG1w6+EdbLKa/ruRtxvhkgFIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aba4HAsB47kXBqzVH5h1RD1F+KTfnwQ5NDa7MJt4t7cZRBizrfqrmmhfsptaVnCaGnKLVlaVXRcjLvR0IV5bE5TsJqqgClK2jkQM4qQDdOzxPDrHg7WA/HDwPaneM+6KhXilO1u40NxzCUOiHrNRj9Z5wzRjfCLp1M6V9Pcl5NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLnIS+Lv; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a54836cb7fso1100375f8f.2;
        Mon, 09 Jun 2025 17:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749516339; x=1750121139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/nvCmvL9TnMGgsBBImgevjJBae5i0pFldeGSR1tm0E=;
        b=dLnIS+LvuOk9ViQ3ZW3mZl12MhAGjEx3cBWeHPOL5fwjQ1F5FUjFOYW7vhbS7qD75E
         1e4yrrgm/MA1/0MaFdPz07yuq47iulJt84pYgLqVqzlmdQbE3g9Tt8slgipm8L5+B8PB
         td1gP97jIDyxzAHemPrFtD5r8Z1vvhlnVYSSKFIQ0JBH0P7NnFXdGHs7TYoFxv9y0bIH
         5xRjUvGJXftI9A3WIuk/48X1wHFpWvTO4+Yxh+LhhIB71SRwfBdjbM7/6sX2KBStRHNF
         XWSK5R5NiLN/WfSkN0Wg+QL85cscJoYKpbA3MheJ5Io8YoMcIui9Dvf3NnaWR3/UeUSl
         fT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749516339; x=1750121139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/nvCmvL9TnMGgsBBImgevjJBae5i0pFldeGSR1tm0E=;
        b=WIIMiML+3t+nxnWiDWTsI2ucG7IBVQo3AgXPGOmJWVFC5U5iD9UZ94DPmW/Edrpe6m
         clMAHx6bEzlgiVH7Yfla0mVW1zi/kxh07jWUZaAHCCg/VLNDYTwNFIBetlzIHja4zNQD
         kgTH1TlR4Op8iO3YPAIVe/ww7SiwV9am/wnaXs02lFsItLHX2zlpWzf35eVwB0MDzA36
         Adoc6bxOs2vWLU/D3wNzDa4+7l38/Q19ksrnMgagKqo8sOiFl3n+ibiScj9CxcLmb2L1
         jpm4OuGLvi2+pq4moObP3UhWxER87jMtiiJOzLCa+FmYBxErRHhykDraC/qNkHoIeaXs
         e7Cg==
X-Forwarded-Encrypted: i=1; AJvYcCVUwyiT7fyJXWZWoQON6mFwPiPuXDUfGwHAJV4hd/QqZFlxvoEF70hyJAs6WJpC9w8UPiel3dRA6yAy8AzcEq0LU9Ourbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNb24CLc0i6LuTh5LYU6u5SbQIE5ouoBhy44t5k5CLr85IyItQ
	VxbZ98EQ9OcEniD8BxT/RigDhXkYa/ONlZ0zII4EpO/sEQjEClOB3t0xNUVBkemUTAlxusVyozV
	Z4v3YWj33N3eVCAKcUsN3pDyhnnoZyZ4=
X-Gm-Gg: ASbGncsiqWPMU00WyY4axFY9ynr6VmgUaAtPUTrrrnViP3ZW4ab94PRc65heRjfpHPN
	GwJmODWtTPrGb1scqaKLK0Dh6Oc9RR1bZtQL2B+p6AZP9zopzzl5Nf8d8X9EcXyeA8R+1UIm5fH
	PLdPAfkPHmSzW0lRflVZQyTrsSr1jPnHnDgikhhmraVsNhLhvMj06CrrwFgOKGUCG6iX4pAvEv
X-Google-Smtp-Source: AGHT+IF2ws0FrcnMf32JfSTC7LGj9R/Fh7ZxxsVNs0jZPTiiRf8bCb68MykSBcwGYLgfBNob+mJWDPFx2/JKIPjEV4U=
X-Received: by 2002:a5d:64ec:0:b0:3a4:dbac:2db6 with SMTP id
 ffacd0b85a97d-3a531cb89e6mr12172556f8f.49.1749516338557; Mon, 09 Jun 2025
 17:45:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <20250606232914.317094-13-kpsingh@kernel.org>
In-Reply-To: <20250606232914.317094-13-kpsingh@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 9 Jun 2025 17:45:27 -0700
X-Gm-Features: AX0GCFtaCkx1n4RY_ghqGoBiTLzBBMUqEHRvoWT2T7yPn4PUCVKPTQ9iljpQ5wk
Message-ID: <CAADnVQ+bBXJMt1fK-mVzfFyK=k8xDgZuLuQ8J-SAFug294ibqw@mail.gmail.com>
Subject: Re: [PATCH 12/12] selftests/bpf: Enable signature verification for
 all lskel tests
To: KP Singh <kpsingh@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Paul Moore <paul@paul-moore.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 4:29=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote:
>
> Convert the kernel's generated verification certificate into a C header
> file using xxd.  Finally, update the main test runner to load this
> certificate into the session keyring via the add_key() syscall before
> executing any tests.
>
> The kernel's module signing verification certificate is converted to a
> headerfile and loaded as a session key and all light skeleton tests are
> updated to be signed.
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  tools/testing/selftests/bpf/.gitignore   |  1 +
>  tools/testing/selftests/bpf/Makefile     | 13 +++++++++++--
>  tools/testing/selftests/bpf/test_progs.c | 13 +++++++++++++
>  3 files changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selft=
ests/bpf/.gitignore
> index e2a2c46c008b..5ab96f8ab1c9 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -45,3 +45,4 @@ xdp_redirect_multi
>  xdp_synproxy
>  xdp_hw_metadata
>  xdp_features
> +verification_cert.h
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index cf5ed3bee573..778b54be7ef4 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -7,6 +7,7 @@ CXX ?=3D $(CROSS_COMPILE)g++
>
>  CURDIR :=3D $(abspath .)
>  TOOLSDIR :=3D $(abspath ../../..)
> +CERTSDIR :=3D $(abspath ../../../../certs)
>  LIBDIR :=3D $(TOOLSDIR)/lib
>  BPFDIR :=3D $(LIBDIR)/bpf
>  TOOLSINCDIR :=3D $(TOOLSDIR)/include
> @@ -534,7 +535,7 @@ HEADERS_FOR_BPF_OBJS :=3D $(wildcard $(BPFDIR)/*.bpf.=
h)               \
>  # $1 - test runner base binary name (e.g., test_progs)
>  # $2 - test runner extra "flavor" (e.g., no_alu32, cpuv4, bpf_gcc, etc)
>  define DEFINE_TEST_RUNNER
> -
> +LSKEL_SIGN :=3D -S -k $(CERTSDIR)/signing_key.pem -i $(CERTSDIR)/signing=
_key.x509

Can we do a fallback for setups without CONFIG_MODULE_SIG ?
Reuse setup() helper from verify_sig_setup.sh ?
Doesn't have to be right away. It can be a follow up.

