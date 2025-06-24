Return-Path: <bpf+bounces-61446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C221AE71BF
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 23:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BD537AF572
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 21:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D4225A62D;
	Tue, 24 Jun 2025 21:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LndE7gAE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D1725A355
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 21:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750802117; cv=none; b=ZOVn7aMrici69IRJ49qn5WAy1FtN4vKnnSPucFLfVy3fht0lXoL1o3sqy+48jaikKVGm5liPfiiiL33H0oe1Hl2S+6CGKcx9Y66rJu6ym/IvVvVm7gFzbSIgccSehgAJEwS123Xmqry6L6tJKvNpUDolJ3dDI+T4qgcM2Zvf9y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750802117; c=relaxed/simple;
	bh=kj/15xQKBt2PyklmaSa6UcDflK2ZKZZluYTL2L0E9Wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DuPfJgsFRAqo8mCYOJBqSb0eXLfUdrehSjxIE+X/SsKeTCdBHqNnxWiNK5/Wr91xaTtlcinSOEMQC/MFF2SzNq3odsnY5GDPGrZrDVMw+rf+oZ4Q1tTcv2lLE6Owz+hly+50oM+w6h1l5Nn1lPBjKwnp0lIFv6HdTyiQ9E2lRa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LndE7gAE; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a6e8b1fa37so1185456f8f.2
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 14:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750802114; x=1751406914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdHq59Fef6P+EgWDFK6rQN23zyzoAzZVpUSjo0E1sn8=;
        b=LndE7gAER+sCR3WxHlnG3oU19cpvsTNyVakTBSovACvfvUThFsBB+ET53og30ZST9i
         Tris+xLDDd6tFJaLFa9XEgbj+Px+h3deo8Xt3PjIhtv4iKXFgqZCIsG3lI76qayZ67CA
         PAPkz1YyZpReYorOIwKaWBdpiCgp0OPtMEan7bHBHtrcYgbNKWU4xXoxfBwY/PO1t8KV
         PPgJTmSuVOJHygZvgrA46KsQKMXKpzjLuNPlOJbfpYvweLZMRLxiL91290O+OIJ3oYCF
         wkK2v0Jq3nVXSfPPLbrXFXqxFOeQ+G12uodujp/DqK3XzdC3UXbz35LjCV/RphmSvXrp
         qmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750802114; x=1751406914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdHq59Fef6P+EgWDFK6rQN23zyzoAzZVpUSjo0E1sn8=;
        b=lKo6FSEkRYH+WxDllwWHR5pqODY9k/70ZDafFpqvtdsna2bflNkqZgJdQLfzDtVUTH
         1XuI+ONu+XByxNLfndRc0qaOJchyPUhqNpWT6ojlbzQn/3CXQLp+ERHNDK6tLjxStKiC
         YQnB92Iyzt5lrFfc/PtWmU4zQEKm0ErFnuxqtgIURBXZ0FymEgTukIDjzGe/bx4er0ej
         0cPmvCo40JOhfNPCmNsTvixWedipb1m0ud4Ry46J7MWmNKC+zF5/m5GSJf4cAhh2iFB+
         VOtGcsBuUZoiJ4eYCFjCry5RkRrzQNPnqj5A/xeql6cMUQjMrqg+i4xS4qUN84/bfniG
         iK3A==
X-Gm-Message-State: AOJu0Yz8HNAN2K6aCkGa7P6N11MIeb19jx9KRiZg1q3ZWbgyJD8tTZKu
	xYIXEs1rpSfSO7nWg8B5Ch/p55YZsMyjP9vPNy4y2TiUWY3H3ClR7bp5Fel/DAinHklM0GZQj9r
	XvcIdt7mrb+VobrNX3koDJHdrGmM+jAI=
X-Gm-Gg: ASbGncv/gpJAHiIeUkFOZsJ2Xo6PplOV2BI7X2CNd1BLb57xS031KZy4Xkt501EUkRV
	7rDRuPzmPuVl5IYZb0ubmiGDvm93xAw4l3ynlq4ZlZg/yU88BNJeL24WxTWo1LRHwwCrSgtVuBU
	fkcYBsb3WP/yWsn4lJgUvuwUl+jkzbIlcuxp8PFmVr5G/GL5jirUCwIkWGl9DQJULVK9r7JSPb
X-Google-Smtp-Source: AGHT+IFm/nsaeQzyzQI78QGFdUYSqG3ZMpboJNyrDOfapaWJlknBm0M3cXvHso179KzpDCu+gQjF0jorzHxccD5VDWc=
X-Received: by 2002:adf:e19d:0:b0:3a4:d994:be4b with SMTP id
 ffacd0b85a97d-3a6ed5b84b2mr229349f8f.1.1750802114055; Tue, 24 Jun 2025
 14:55:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624191009.902874-1-eddyz87@gmail.com> <20250624191009.902874-4-eddyz87@gmail.com>
In-Reply-To: <20250624191009.902874-4-eddyz87@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Jun 2025 14:55:02 -0700
X-Gm-Features: Ac12FXy5pVzEZeaKkpTEFpir52ZYSlbHeBuQw1Wp4acQVqDT8XVKC-bnVl_tYYM
Message-ID: <CAADnVQK8e7SqSRDab8xw1onFHe6YoBnTqoXJ+Pjg-_bDk5=sXA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/4] selftests/bpf: allow tests from
 verifier.c not to drop CAP_SYS_ADMIN
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 12:10=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> Originally prog_tests/verifier.c was developed to run tests ported
> from test_verifier binary. test_verifier runs tests with CAP_SYS_ADMIN
> dropped, hence this behaviour was copied in prog_tests/verifier.c.
> BPF_OBJ_GET_NEXT_ID BPF syscall command fails w/o CAP_SYS_ADMIN and
> this prevents libbpf from loading module BTFs.

You need this only because of 'bpf_kfunc_trusted_num_test' access
in patch 4?
Can you use kernel kfunc instead?
This needs more thought.
s/RUN/RUN_FULL_CAPS/ just because of kfunc in the bpf_testmod
doesn't look like a good long term approach.

I thought we agreed to relax BPF_OBJ_GET_NEXT_ID to allow for CAP_BPF.
Probably even unpriv can do it.
Just knowing a set of prog, map, bpf IDs is not a security threat.

BPF_BTF_GET_FD_BY_ID can also be allowed for unpriv,
since one can do it already from /sys/kernel/btf/

> This commit adds an optout from capability drop.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  .../testing/selftests/bpf/prog_tests/verifier.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
> index c9da06741104..cedb86d8f717 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -115,14 +115,16 @@ struct test_val {
>  __maybe_unused
>  static void run_tests_aux(const char *skel_name,
>                           skel_elf_bytes_fn elf_bytes_factory,
> -                         pre_execution_cb pre_execution_cb)
> +                         pre_execution_cb pre_execution_cb,
> +                         bool drop_sysadmin)

I have an allergic reaction to bool arguments.

>         run_tests_aux("verifier_array_access",
>                       verifier_array_access__elf_bytes,
> -                     init_array_access_maps);
> +                     init_array_access_maps,
> +                     true);

This is not readable without looking at the argument name.

--
pw-bot: cr

