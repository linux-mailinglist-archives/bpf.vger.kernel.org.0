Return-Path: <bpf+bounces-60259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5F1AD46D9
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 01:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BDF5163032
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 23:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A8C2820D7;
	Tue, 10 Jun 2025 23:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJVCLt83"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7F126462A
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 23:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749598659; cv=none; b=aVwAUGS557eqHed45bSpt3Ydroac+HlSEzMcd8e7JGztsbh8DxwGKkiY/2AFuVWar1ENao6nZNf7NrgPeHuTyOb81KjTWzdnwRy7pQGs81RkgaSi8n+AiDKxRHhqcayL0Fve8v9254ViWGwAcY36K7TLE4cJQrowyqhfmfpMBlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749598659; c=relaxed/simple;
	bh=2q7NaV04e3MKyJUvpqLZCizr3qBo7fXmudOQrQM/cnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V4zDrmUEvXrJDnTyY8yRaKNz80V6ON2bo6UfKFGQUUMiIjmdH6ZomnfDvpDKylYNcALIjyzNiMGzGudVsnoTfPiK7Aw2lFOKuxL9FGMdG4DX7WBkabS3ItfLnd6y8CoNDJ/bpjObqD1lEgeZQ0vHI5l1IYJ0Ovh5Fktk7wdwFQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJVCLt83; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45024721cbdso51711135e9.2
        for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 16:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749598656; x=1750203456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJNzFE7VvnlPZNhCFn8ImmUxFTpbrysBKDM1JZHDXZM=;
        b=fJVCLt83TT0gsIgmWbPRd6B8x/iA+r6/3TF3IO3KVaJ+L57fKMk3D0b0yuM7tsfduT
         kqxTWmfMw986kKwDkS28+C0L8kFgUI4YJneHDNgYELnqwU9nsQge4bdI3b+mpzWKXk4O
         1h6ApMxBzxW/5be8WMlSsxk/hUzpUPGUyjLXjHAhvgJsokDBMU4V62VIGIEpsG7aPYw2
         4dsTnH2qHvUPl2O7rnvBXKGQqmYBAhrpNyKBxYFrkFHmwmX8xkiFJQRNLqrsfbmjO24Q
         bkbMsV+JmOHVz0JiubYKvOQDsUb4qiq1rG2DRSOwLo8HeWibr24j2AqZklxf6aw71aXL
         xw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749598656; x=1750203456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dJNzFE7VvnlPZNhCFn8ImmUxFTpbrysBKDM1JZHDXZM=;
        b=vD+MnsUFGnFKEOt11Kep6DQVeokCZ879Gzw2yRuCanU+7taAUyzkKXbde9b5bCkJDD
         1hH+bXzDl/0NG7hqFhX5kKkb/Vaq5fwWgX8XB8Nqssx3/vfiRN9o95AWnf2El8gz8pOb
         VZSWOTfUU4f+6GAzb9ugFupRp6TskDkvKqEKNhnk8s/PfGj464f+080GdjzOL1o4VB+F
         T9v43D+6u3RCc66Ciz8W9rikXjZgcgtFtrMe3Z+nk+zoANaR6XHlZDm7PXBssp6zobLY
         PVvX7nie6Acgsk8ah/jWP7s5Lp+5n8VEWXyan2xXzbko9c7ChkcAnA+rPkB6zWu2Zvwq
         rkVQ==
X-Gm-Message-State: AOJu0YwvGkZh6bqclhHqZfqFzN725VnEUjqxNwHlo9qdt3+QqEyoGR+p
	w1LnDijnT6rur19Dr6+JRl+F6yhJq9OD2NOVsX3ohcx8XhnKSJYwmhMK0vOp+qh3iGtQK4HYUFv
	5kvaqmvJw04AExSUUbFhPvfkNEt1rocw=
X-Gm-Gg: ASbGncus8tGjd5TbTbDLH0/M1mbHI+fL+wIWn31GBzqDoo6LK9v2GElFAok0S3g+NQR
	t8MGFEqwXu2qA5ZP6KH2kaZRL9rrIqFGOoEY1KuX7YW7Y6EkWHk762ugns+tvP1HzZo82rHowan
	1JHN3lBjbd6ZKBJ7+LTCyQl+gAkBot2tC9UgUWoMP6uPwHIc0wuhgQlRuvz4I3IWlVdJs2Nhg0
X-Google-Smtp-Source: AGHT+IElMJ3i2PmuTfa/qFjfOX4sNk3pxcRArmvT4ejCh5bYu9oIAifBXR0vhj40iwi8qO3TMDySg23ge7hNiffsMJA=
X-Received: by 2002:a05:600c:c04e:b0:44b:eb56:1d45 with SMTP id
 5b1f17b1804b1-453249a1500mr4594725e9.15.1749598655721; Tue, 10 Jun 2025
 16:37:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610232418.GA3544567@ax162>
In-Reply-To: <20250610232418.GA3544567@ax162>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 10 Jun 2025 16:37:24 -0700
X-Gm-Features: AX0GCFtk53WMO2eoVm0bCjNtOL0Qa7RHkS0ZCpiTafT9vpr0jFRVwCZdt3LGp5U
Message-ID: <CAADnVQ+jNQyC=RcoiwDXeHj9y6CGzr322scz_8uGwCDVx-Od4Q@mail.gmail.com>
Subject: Re: bpf-restrict-fs fails to load without DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 on arm64
To: Nathan Chancellor <nathan@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 4:24=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Hi all,
>
> I recently adjusted my kernel configuration for my arm64 systems that
> boot Fedora to enable debug information so that BTF could be generated
> so that systemd's bpf-restrict-fs program [1] can run, as it would show
>
>   systemd[1]: bpf-restrict-fs: Failed to load BPF object: No such process
>
> in the kernel log. After doing so though, I still get an error when the
> program is loaded:
>
>   systemd[1]: bpf-restrict-fs: Failed to link program; assuming BPF LSM i=
s not available.
>
> With Fedora's configuration from upstream, I see:
>
>   systemd[1]: bpf-restrict-fs: LSM BPF program attached
>
> I was able to figure out that enabling CONFIG_CFI_CLANG was the culprit
> for the change in behavior but it does not appear to be the root cause,
> as I can get the same error with GCC and the following diff (which
> happens with CFI_CLANG because of the CALL_OPS dependency):
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 55fc331af337..a55754e54cd8 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -210,8 +210,8 @@ config ARM64
>         select HAVE_DYNAMIC_FTRACE_WITH_ARGS \
>                 if (GCC_SUPPORTS_DYNAMIC_FTRACE_WITH_ARGS || \
>                     CLANG_SUPPORTS_DYNAMIC_FTRACE_WITH_ARGS)
> -       select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS \
> -               if DYNAMIC_FTRACE_WITH_ARGS && DYNAMIC_FTRACE_WITH_CALL_O=
PS
> +       #select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS \
> +       #       if DYNAMIC_FTRACE_WITH_ARGS && DYNAMIC_FTRACE_WITH_CALL_O=
PS
>         select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS \
>                 if (DYNAMIC_FTRACE_WITH_ARGS && !CFI_CLANG && \
>                     (CC_IS_CLANG || !CC_OPTIMIZE_FOR_SIZE))
>
> which results in the following diff between the good and bad
> configurations (and I already ruled out HID-BPF being involved here):
>
> diff --git a/good-config b/bad-config
> index 252f730..539e8fd 100644
> --- a/good-config
> +++ b/bad-config
> @@ -4882,7 +4882,6 @@ CONFIG_HID_NTRIG=3Dy
>  #
>  # HID-BPF support
>  #
> -CONFIG_HID_BPF=3Dy
>  # end of HID-BPF support
>
>  CONFIG_I2C_HID=3Dy
> @@ -7534,7 +7533,6 @@ CONFIG_HAVE_FUNCTION_GRAPH_TRACER=3Dy
>  CONFIG_HAVE_FUNCTION_GRAPH_FREGS=3Dy
>  CONFIG_HAVE_FTRACE_GRAPH_FUNC=3Dy
>  CONFIG_HAVE_DYNAMIC_FTRACE=3Dy
> -CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=3Dy
>  CONFIG_HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS=3Dy
>  CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=3Dy
>  CONFIG_HAVE_FTRACE_MCOUNT_RECORD=3Dy
> @@ -7558,7 +7556,6 @@ CONFIG_FUNCTION_GRAPH_RETVAL=3Dy
>  # CONFIG_FUNCTION_GRAPH_RETADDR is not set
>  CONFIG_FUNCTION_TRACE_ARGS=3Dy
>  CONFIG_DYNAMIC_FTRACE=3Dy
> -CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=3Dy
>  CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS=3Dy
>  CONFIG_DYNAMIC_FTRACE_WITH_ARGS=3Dy
>  CONFIG_FPROBE=3Dy
>
> Is this expected behavior or is there some other issue here?

That's expected.
See how kernel/bpf/trampoline.c is using DYNAMIC_FTRACE_WITH_DIRECT_CALLS.

Theoretically we can make bpf trampoline work without it,
but why bother? Just enable this config.

