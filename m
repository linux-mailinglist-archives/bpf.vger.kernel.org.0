Return-Path: <bpf+bounces-68967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A60B8AF0B
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 20:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 739561C8542B
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 18:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AEF258EF5;
	Fri, 19 Sep 2025 18:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6b+3kQt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4723E21C186
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 18:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758307014; cv=none; b=FZ8yJ0BcDIO/VVjFnfr2Woq0hzTEyFpk4QxnfxfEEf/AgvWvwM5s02/uxF3O4bqxVswLM02JrCjsfXcg1pnM2e5FcihoZlhT9grYMELEbH1coqOQIpFTAHq7+w2q7u2Frvt+8OjG3l/mzELlI2nFjeCHwiwM2Oa5Q+sbzsTqOCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758307014; c=relaxed/simple;
	bh=IJvXw3qxvXpl+zvMRqZYNH7uqB1WANN47ALPqYIl60E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVfpsZ5EZ3dATS+hEDST2bJAdy9gWC58MdQn4FskiWZ72qxDiJbEq0Xa5kWZcjE7DlTho1a4xvkZXJZB5GjX/OMNkg4IiQpr8FR6ug8KaFsThPnr9t370C+5Ra/QzMQRzUdFxCGosGKm96nxfeGtRJlZzanK8pKQ5bPNC6nhUWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6b+3kQt; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ece0e4c5faso2915581f8f.1
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 11:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758307011; x=1758911811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2YuZTriEOyvPgLEn0yesaI5ZcNsO2RclRcPnA4EA/4=;
        b=P6b+3kQtxi4rv/AgJRTdqKNxBj9QknTp/LYH4eX9R8xN1HnKuzBDuoMyQmiCzfREvY
         1P+rXTa02lwGyceEhgo1ai72D8+IT5HqSboHWs3x7I0kiLpsJs0M73RQglywUg1r5TjA
         imncUHoh8qJr+pkStGELWtH9VzYazMCWLvBORmjFRGxqN7FqGNENdfi8Qj+4WPv1Pt/3
         AQkTC5sbxiaXvI5ryGZEpXjZapGsemfxgx/RfQPqvNJR2kaosNuifmcjctV9JTxSNYvJ
         GjPbHhfBK4RXd3jeE+kPWNGj5uLaJEcNnbiY3o4bCRDaBG4v28BCWTVb21rmZYZUv+Pf
         dapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758307011; x=1758911811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2YuZTriEOyvPgLEn0yesaI5ZcNsO2RclRcPnA4EA/4=;
        b=FyYSb315YehDX3LmLdiiOmLZa+kk/ana4AgPdqzbBhr1/6K2un2Zu9W5Vd2yJMOl9m
         3muDMhGv6Sy0W8g8fRq3Gu3Z/L1GYynZ/5YA5rKRHqd8hW9Vx9beXZK0LD+/3S/gYMie
         6nBOP86z1rdR62bttX9Ms4IY4/Ps7HqBZ5TxBibMbia30PvxQWxQOLUDCsN/UYnxxveL
         eIBbLid5KSzUvi4Eyf1iOn8mPy2F/amQZ3POKr4P+NqNeyD0Z3GCbNc1nuPbtqOHTokF
         lmFPXafpqiUYKmKET0o/nrH1h9ELLh3DAQ0FESTXIeVDlFtrTpeVsktS5DQlvac9YWYi
         eT+A==
X-Gm-Message-State: AOJu0YwN1fr9QDf8XvDLH7Vuzw6IYqA+bM0huezY2kFYO8mIjNc5crEG
	7njlUpCr7Ry+DAE66UL0T113x94F+OnLrEe918SpLjkaPefongiKMMRVsB7oE5+IvfZ6yPdMix3
	PW3Zir027S31NZjKewTxa3g0DfxEKc5g=
X-Gm-Gg: ASbGncu2PkIiC5u69mM6y8cTUN3y13KMiHJYGTJbTTDxiJeFnJaFVsP7KAlovhXWMOa
	+keSQvbcvk8effAtjrT9Nvqa4Bj9/wccgwW9MSKj9k6ktZeYijFlrzd7EnU4zipzsoUNjwxTrCa
	36zY+3DxcIdgv4ZwgqOUSF0UBncNS0v8x2QrUbMU1sAHEsuZoeIuDPlJtIcm0w3XPwMbHhbo2az
	MNj1x7Y0xEPJAXz+c0F9pjECrqS1sOttQ==
X-Google-Smtp-Source: AGHT+IHTknOIzM6nLnsJkheCA7yhVrkCE5qI3nBB3wfUZ5TuD76JD/Txuf99iYd0sPHSyhUxudClWNuDCF9BkuJrP4I=
X-Received: by 2002:adf:b30c:0:b0:3f0:9bf0:a369 with SMTP id
 ffacd0b85a97d-3f09bf0a490mr2055480f8f.14.1758307011297; Fri, 19 Sep 2025
 11:36:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919162252.174386-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250919162252.174386-1-mykyta.yatsenko5@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 19 Sep 2025 11:36:36 -0700
X-Gm-Features: AS18NWDMsh6wxayc9uDHXQh3M0aJWbhR4X_q1_r3jK6N8HPi0jalLwv_ywTyXCw
Message-ID: <CAADnVQLXf4zkKxhGMiQVmthZPoHwhv-c-kbfbNKrU4oJm5oHAA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: introduce kfunc flags for dynptr types
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 9:23=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> The verifier currently special-cases dynptr initialization kfuncs to set
> the correct dynptr type for an uninitialized argument. This patch moves
> that logic into kfunc metadata.
>
> Introduce KF_DYNPTR_* kfunc flags and a helper,
> dynptr_type_from_kfunc_flags(), which translates those flags into the
> appropriate DYNPTR_TYPE_* mask. With the type encoded in the kfunc
> declaration, the verifier no longer needs explicit checks for
> bpf_dynptr_from_xdp(), bpf_dynptr_from_skb(), and
> bpf_dynptr_from_skb_meta().
>
> This simplifies the verifier and centralizes dynptr typing in kfunc
> declarations, helps with future changes, adding new dynptr types.
> No user-visible behavior change.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  include/linux/btf.h   |  3 +++
>  kernel/bpf/verifier.c | 40 ++++++++++++++++++++++++++++++++--------
>  net/core/filter.c     |  6 +++---
>  3 files changed, 38 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 9eda6b113f9b..d41d6a0d1085 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -79,6 +79,9 @@
>  #define KF_ARENA_RET    (1 << 13) /* kfunc returns an arena pointer */
>  #define KF_ARENA_ARG1   (1 << 14) /* kfunc takes an arena pointer as its=
 first argument */
>  #define KF_ARENA_ARG2   (1 << 15) /* kfunc takes an arena pointer as its=
 second argument */
> +#define KF_DYNPTR_XDP   (1 << 16) /* kfunc takes dynptr to XDP */
> +#define KF_DYNPTR_SKB   (1 << 17) /* kfunc takes dynptr to SKB */
> +#define KF_DYNPTR_SKB_META   (1 << 18) /* kfunc takes dynptr to SKB meta=
data */

I feel this way we will run out of bits too quickly.
Let's hold on to such cleanup until we have a scalable path.

pw-bot: cr

