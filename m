Return-Path: <bpf+bounces-59690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C9BACE6C5
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 00:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD573A3E3D
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 22:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B8D23184B;
	Wed,  4 Jun 2025 22:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wg2V7AUC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F3E22F75C
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 22:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749076886; cv=none; b=qUVIim7HIDbqlRyMgX72cYekm/Nx/a3N2/vwJ6xm1YsYtn4InI6IvYkC/JXEJv19mLIIxdcDs8QbTT+dq0aCASap62c9Pc3plh39d8jnjZfKCcQQQ48GnZuXu6iBvH0CUzrqX5RwHnNWRsOfjIlrY0khGIprw+BPj0kFjTIBegM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749076886; c=relaxed/simple;
	bh=l0Myg1hhSDa7aUGY2ZdpXBZy1BWgI63tOzL5gLJTXuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QbeUrKJ+YtAgK5I8jYeA9eGUWJPSDk0qDohaS+AtPKrF3UXhSA06pWfE8GrWG5KKBBBkDiSGV3pADBcEMau1bSI0Se5FRRZHArYww8wFFB1FfarhA0FBnIZe0L/mnF2bPhduRTpa11AV5tPTTbw5nwNP8B6pjS+Q+x5U0f3TEyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wg2V7AUC; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-451ebd3d149so1927735e9.2
        for <bpf@vger.kernel.org>; Wed, 04 Jun 2025 15:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749076883; x=1749681683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ey7/9lMkvct6eknaxY6LUmrUmXlwGmP3YaMcHdJ1fX4=;
        b=Wg2V7AUCDjP4GZj/B+PrlbKkKpOCPqPqe6jPcF4R5cG2T5dbRyQMi6gZ3Eo7M77QZ/
         7UZUHyBoD0yWCyFxZ0qNEZ4Lash4colY0lN/XAP9phZbT4j/f7zq3nhkYUbL6IwP/x9y
         KypStdY4HQXTmpGJU7Rv/N2UK8reyBJh4446vSWINzgt7hF0nZBJG2naCkSYrkpvw8kx
         d1/eexdWHNo8kRqxfu+0IpZkLsxBfFL92F6HwQTITye/BWSyY32ZHZ0hATExf3w5N2ei
         /N1bP61rlnDy7dWTdW87gsEtNDzbQmT8G6xHrbjRLYyq26pIncQi+HECAfYUfc9hnUjY
         AQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749076883; x=1749681683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ey7/9lMkvct6eknaxY6LUmrUmXlwGmP3YaMcHdJ1fX4=;
        b=xB5h1lWlNtbAgc3YlTecCRZWP/wyDxmOcvcvX6ncxycy+nv7NMS9SQxxs43IeyvhtU
         tJdZw7rDT/P18jQNngL6MgVC8KR6ochRt1TkK9cwaY2yR20Eaz/u/kg/1nVghIuwP3Nu
         Yxqk4Y7hVTnCx66kjlUpbWrRpdVrq5EKPFwINBXzm3qnUv9ueVFmg+9j/rZ9tZHH2emL
         HRtY9lThWFGqTlwV3ERJkDkp6lrfr7UhG78DxxcwoMYFKvVkfhytPapCYGektRsgK5Lb
         RNdqeB1P0oISTM3vdFJ79iQxh7X5YFisW3rzXGcgoViEcFgIpjoTSzkR6Y4NW3V1p/zP
         xUBw==
X-Forwarded-Encrypted: i=1; AJvYcCVPB5PvgXH7zGOYXS70IWU83qXQQljdvurzKKUia6ESBmfVdm8jePSlu4JC2nG3swKOaR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmCQIHoBa46cro2VIXhTUEF0Gn02KYE+xL+Jy39+Rmq+a/msqs
	y2is8VGhhqt4SFhLFPsQSDObmKMm4q/O+dZ4F8RTi8R+xNHkGprgmnLwBMKG2J2hncne0FH8tIP
	rOMlEst7EeYDbEyNqVGyn2D/lDE/UnlU=
X-Gm-Gg: ASbGncuoWVGtOmivCxYcGHNtfadZUGizgcInk+WMMfcwWhkKGntkR5/lD1bTOGTk3u9
	r//kyId37nWcBwasFF6s/yfw21D3e1h8Ri6Gvp/R2M8neM4r0aysBVAr3c2vGzM6oNr7te8v+vI
	1Yd6JccUrSVhFbzn6iJW9qicCRc85w4WX/mcOD9iukp1AL2JOC
X-Google-Smtp-Source: AGHT+IGh9YeiLZi2Lb9GrzTZYuWQKZsQ71/0eMcbUbiauVYSsQBVJZY4YU3l7UBDIFVNgZvU/Lf7zvlACZgFQDH0Yus=
X-Received: by 2002:a05:600c:154f:b0:442:f4a3:8c5c with SMTP id
 5b1f17b1804b1-451f0a72b3cmr51827845e9.10.1749076882660; Wed, 04 Jun 2025
 15:41:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604222729.3351946-1-isolodrai@meta.com> <20250604222729.3351946-2-isolodrai@meta.com>
In-Reply-To: <20250604222729.3351946-2-isolodrai@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 4 Jun 2025 15:41:11 -0700
X-Gm-Features: AX0GCFuC65kd-isQJFcrXrNUM7FhOrw9iHSyJsa1Ad8K3BTQShaD0322YolmmXc
Message-ID: <CAADnVQJr0JZ1BKeSEE0YM=xcnP0QEBM0smmCkjNs2oaOR1jcbw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: add cmp_map_pointer_with_const
 test
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, 
	Mykola Lysenko <mykolal@fb.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 3:28=E2=80=AFPM Ihor Solodrai <isolodrai@meta.com> w=
rote:
>
> Add a test for CONST_PTR_TO_MAP comparison with a non-0 constant. A
> BPF program with this code must not pass verification in unpriv.
>
> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
> ---
>  .../selftests/bpf/progs/verifier_unpriv.c       | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/=
testing/selftests/bpf/progs/verifier_unpriv.c
> index 28200f068ce5..c4a48b57e167 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
> @@ -634,6 +634,23 @@ l0_%=3D:     r0 =3D 0;                              =
           \
>         : __clobber_all);
>  }
>
> +SEC("socket")
> +__description("unpriv: cmp map pointer with const")
> +__success __failure_unpriv __msg_unpriv("R1 pointer comparison prohibite=
d")
> +__retval(0)
> +__naked void cmp_map_pointer_with_const(void)
> +{
> +       asm volatile ("                                 \
> +       r1 =3D 0;                                         \
> +       r1 =3D %[map_hash_8b] ll;                         \
> +       if r1 =3D=3D 0xdeadbeef goto l0_%=3D;         \

I bet this doesn't fit into imm32 either.
It should fit into _signed_ imm32.

