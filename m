Return-Path: <bpf+bounces-11971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CACC7C609D
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 00:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86EFB2826C3
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 22:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191701D6BA;
	Wed, 11 Oct 2023 22:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPN7B7ua"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D6BD2E5
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 22:53:23 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687869D
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 15:53:22 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5334d78c5f6so669393a12.2
        for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 15:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697064801; x=1697669601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhsWFntJo3mtfaYykVwHroYyIBKoWbszAq07NsXcx/s=;
        b=YPN7B7uaMqLL25oAhWq2UyX+Biejt90PnDJ0qMr1oObk8dVqEAU06AGrrYdH0xkOWu
         y4FTbGUIkjZGpbprmdma76MHQCqlulCZjmdaOaXzTXG1qQQCraWMOnT7pSgVIy/C8rGq
         az5xukXJ4CjFHoJD8aj1p4z4tyefUKiciYcJWi1reYGBHo4MmMaY2Imzt7Ak5nfzLBCH
         r8Uum6Ca9m11Dh74QxPsmMXqFprsgQAVoPyDZFWji+DV5/yDY8qiKFRgN1LMV7Xt6rXi
         cJUXx520LjCyc1e6hNxE3WE0XkR206dQ7fx5pkTKWxTrGUAx907SpZW9HMRxOrYYJehz
         oyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697064801; x=1697669601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhsWFntJo3mtfaYykVwHroYyIBKoWbszAq07NsXcx/s=;
        b=MO65AnvoJ4zjLy4/XnA68hFrUSwYU78p/c0vixZmV6UNZtJDzLLxSdj+/LzdXdzg4R
         j7Ko0f9WeYp+2JGLYePm+RpVtpeSUdkNMhA3AZ76UDuTgosJ/sIMCTZ+n+VLqcqVw9X4
         GlgZ2RnF8QrBTDY6Q8w4xR1yOwkZEkNwShHuNXRy0hisZGLRwm1iyrzUEGk0yo6vwqi8
         ir8tliminnAICHqEBmDX/tj6oo9+BXsdUwObX/Ssdb5NiteDUifVvxOGMhTbOTp1XfYG
         HIjGXSxPOL9uAjgCJGJJYgPB9cQZqpjKu4Nh19zYsemrDoPl82/NM7n15PD4ewP43ebm
         18Ug==
X-Gm-Message-State: AOJu0YwDQlun6/oET6Asy5NU013a7MZmBx8Ryg2g5aUo5xdATD/ozkCB
	qMSt5I4mgfwCn9T2WJGiBR0VvkSo1q5JhW+U1In9tLaR
X-Google-Smtp-Source: AGHT+IH0ZDWkvAzC8oLW7dHmr7MwFh6FTkx+agkPM5G9qCuIV+k+CwKsNLPnnIYZY0C0Yhkf5nztU0WGe1VodURpQCo=
X-Received: by 2002:aa7:d70b:0:b0:523:387d:f5f1 with SMTP id
 t11-20020aa7d70b000000b00523387df5f1mr21025448edq.24.1697064800607; Wed, 11
 Oct 2023 15:53:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005084123.1338-1-laoar.shao@gmail.com>
In-Reply-To: <20231005084123.1338-1-laoar.shao@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Oct 2023 15:53:09 -0700
Message-ID: <CAEf4Bza6UVUWqcWQ-66weZ-nMDr+TFU3Mtq=dumZFD-pSqU7Ow@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Inherit system settings for CPU security mitigations
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	Luis Gerhorst <gerhorst@cs.fau.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 5, 2023 at 1:41=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> Currently, there exists a system-wide setting related to CPU security
> mitigations, denoted as 'mitigations=3D'. When set to 'mitigations=3Doff'=
, it
> deactivates all optional CPU mitigations. Therefore, if we implement a
> system-wide 'mitigations=3Doff' setting, it should inherently bypass Spec=
tre
> v1 and Spectre v4 in the BPF subsystem.
>
> Please note that there is also a 'nospectre_v1' setting on x86 and ppc
> architectures, though it is not currently exported. For the time being,
> let's disregard it.
>
> This idea emerged during our discussion about potential Spectre v1 attack=
s
> with Luis[1].
>
> [1]. https://lore.kernel.org/bpf/b4fc15f7-b204-767e-ebb9-fdb4233961fb@iog=
earbox.net/
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Luis Gerhorst <gerhorst@cs.fau.de>
> ---
>  include/linux/bpf.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index a82efd34b741..61bde4520f5c 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2164,12 +2164,12 @@ static inline bool bpf_allow_uninit_stack(void)
>
>  static inline bool bpf_bypass_spec_v1(void)
>  {
> -       return perfmon_capable();
> +       return perfmon_capable() || cpu_mitigations_off();

Should we check cpu_mitigations_off() first before perfmon_capable()
to avoid unnecessary capability checks, which generate audit messages?

>  }
>
>  static inline bool bpf_bypass_spec_v4(void)
>  {
> -       return perfmon_capable();
> +       return perfmon_capable() || cpu_mitigations_off();
>  }
>
>  int bpf_map_new_fd(struct bpf_map *map, int flags);
> --
> 2.30.1 (Apple Git-130)
>

