Return-Path: <bpf+bounces-7182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BCC772A57
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 18:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE61281478
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 16:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08DE11CA0;
	Mon,  7 Aug 2023 16:17:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AB820FE
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 16:17:19 +0000 (UTC)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C52E10D0;
	Mon,  7 Aug 2023 09:17:18 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-56c7eb17945so2768874eaf.2;
        Mon, 07 Aug 2023 09:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691425037; x=1692029837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJdGGiJkcrHISXvVvE0H/Vznsw3cOU8WUZgbJxZdrbE=;
        b=Lqr9tTV9yaDkHfH7Kwwtjf05PiPzScNOTXxuf2JP4cSaK08vncLoIbljVhU02C+HpB
         CzVJGJM+TlxUGMCU0XbpFDwKyt8+zKkKHGfJdmLC6+ILCsDQmUwcPOeexbNsCbAKVvI0
         XePFfug1UQ1mlizK3ERkkdU958yh+V1/QPtpLad7bUWh1UXD27TEqAsF/nnlsTvr1OF/
         ncdCXSjgNdfx2Yr4juhE2Dke8+5dr9resZ0ZUMtgh7TN4w5EVi6mIKrxFLKEgKgyaDiH
         RcclQG+paa/fDQzS2KF2oAbiNk0LFjX0LsOE4OZLbnxLTXkzIH02IeQRIayKiBT+SFrw
         2tLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691425037; x=1692029837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJdGGiJkcrHISXvVvE0H/Vznsw3cOU8WUZgbJxZdrbE=;
        b=EVFNS6mdDNRxR7vJSw7ze3uxxeISO6hDFc6d6Yj8iinF/awTJTnPmqF7nBIML/ke21
         /XJUhuhtpe35PtHOTEQWsDnXaNMgW78BqUV/xinS5nq/1CcEEeYrmZpd9OXV3t2K1BnM
         Txvn1CY/CSo3x6cFvHrwiGCTDhlI7NWhE0gU9XsIu2S+H30bpGFsn38TlhwB2LiK0s3q
         z5IJ2DyJDfgtU9WFT9Hd6KTOvl0POiS4i1UuvSao8b35U9yRj9uhx00/+Nxrs4laeai3
         By1ST8J/Rpt2rWNZYDjDWzTSPt0W66unWYiDSseRfZmTUkuGqEn2UDMAiRmXAsm3FQ2n
         7ugQ==
X-Gm-Message-State: AOJu0Yx+rxsQPiZXnDsik15byFAMWDhkTI4B5l/1WOw4/7j1pE1aDTbO
	xrso2o1Na6Abe7c2sirWjNJNAGdr1jRFjJCfMqI=
X-Google-Smtp-Source: AGHT+IEfgr1D1t716LbkpwsVqpgp8wfvTRjXYPJxegUlcNb2afgWVwvQg1ei5/WSELs+Zi5YTPj1oCeWcsZDXnjDSBM=
X-Received: by 2002:a4a:351e:0:b0:56c:8dde:bccb with SMTP id
 l30-20020a4a351e000000b0056c8ddebccbmr9926993ooa.9.1691425037321; Mon, 07 Aug
 2023 09:17:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230801011237.3913-1-sunran001@208suo.com>
In-Reply-To: <20230801011237.3913-1-sunran001@208suo.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Aug 2023 12:17:06 -0400
Message-ID: <CADnq5_NDLqDPU5n2yLJdp+OAUnnu4LW=uU4HXji0R1usJebtHQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in smu_v11_0.h
To: Ran Sun <sunran001@208suo.com>
Cc: apw@canonical.com, joe@perches.com, alexander.deucher@amd.com, 
	bpf@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Applied with the garbage hunks dropped.

Alex


On Mon, Jul 31, 2023 at 9:12=E2=80=AFPM Ran Sun <sunran001@208suo.com> wrot=
e:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: that open brace { should be on the previous line
> ERROR: code indent should use tabs where possible
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h |  7 +++---
>  scripts/checkpatch.pl                        | 23 --------------------
>  2 files changed, 3 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h b/drivers/gpu/d=
rm/amd/pm/swsmu/inc/smu_v11_0.h
> index d466db6f0ad4..1b4e0e4716ea 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
> @@ -67,8 +67,7 @@ static const __maybe_unused uint16_t link_width[] =3D {=
0, 1, 2, 4, 8, 12, 16};
>  static const __maybe_unused uint16_t link_speed[] =3D {25, 50, 80, 160};
>
>  static const
> -struct smu_temperature_range __maybe_unused smu11_thermal_policy[] =3D
> -{
> +struct smu_temperature_range __maybe_unused smu11_thermal_policy[] =3D {
>         {-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 9=
9000},
>         { 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000,=
 120000},
>  };
> @@ -96,8 +95,8 @@ struct smu_11_0_dpm_table {
>  };
>
>  struct smu_11_0_pcie_table {
> -        uint8_t  pcie_gen[MAX_PCIE_CONF];
> -        uint8_t  pcie_lane[MAX_PCIE_CONF];
> +       uint8_t  pcie_gen[MAX_PCIE_CONF];
> +       uint8_t  pcie_lane[MAX_PCIE_CONF];
>  };
>
>  struct smu_11_0_dpm_tables {
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 85a0598bf723..528f619520eb 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -7449,23 +7449,6 @@ sub process {
>                 }
>
>  # Complain about RCU Tasks Trace used outside of BPF (and of course, RCU=
).
> -<<<<<<< HEAD
> -<<<<<<< HEAD
> -               if ($line =3D~ /\brcu_read_lock_trace\s*\(/ ||
> -                   $line =3D~ /\brcu_read_lock_trace_held\s*\(/ ||
> -                   $line =3D~ /\brcu_read_unlock_trace\s*\(/ ||
> -                   $line =3D~ /\bcall_rcu_tasks_trace\s*\(/ ||
> -                   $line =3D~ /\bsynchronize_rcu_tasks_trace\s*\(/ ||
> -                   $line =3D~ /\brcu_barrier_tasks_trace\s*\(/ ||
> -                   $line =3D~ /\brcu_request_urgent_qs_task\s*\(/) {
> -                       if ($realfile !~ m@^kernel/bpf@ &&
> -                           $realfile !~ m@^include/linux/bpf@ &&
> -                           $realfile !~ m@^net/bpf@ &&
> -                           $realfile !~ m@^kernel/rcu@ &&
> -                           $realfile !~ m@^include/linux/rcu@) {
> -=3D=3D=3D=3D=3D=3D=3D
> -=3D=3D=3D=3D=3D=3D=3D
> ->>>>>>> d7b3af5a77e8d8da28f435f313e069aea5bcf172
>                 our $rcu_trace_funcs =3D qr{(?x:
>                         rcu_read_lock_trace |
>                         rcu_read_lock_trace_held |
> @@ -7482,14 +7465,8 @@ sub process {
>                         kernel/rcu/ |
>                         include/linux/rcu
>                 )};
> -<<<<<<< HEAD
> -               if ($line =3D~ /\b$rcu_trace_funcs\s*\(/) {
> -                       if ($realfile !~ m@^$rcu_trace_paths@) {
> ->>>>>>> 4d2c646ac07cf4a35ef1c4a935a1a4fd6c6b1a36
> -=3D=3D=3D=3D=3D=3D=3D
>                 if ($line =3D~ /\b($rcu_trace_funcs)\s*\(/) {
>                         if ($realfile !~ m{^$rcu_trace_paths}) {
> ->>>>>>> d7b3af5a77e8d8da28f435f313e069aea5bcf172
>                                 WARN("RCU_TASKS_TRACE",
>                                      "use of RCU tasks trace is incorrect=
 outside BPF or core RCU code\n" . $herecurr);
>                         }
> --
> 2.17.1
>

