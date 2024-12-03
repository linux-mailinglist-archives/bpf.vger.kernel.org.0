Return-Path: <bpf+bounces-45977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6139E0F90
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 01:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33D551643B6
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 00:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1D1136E;
	Tue,  3 Dec 2024 00:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YelpreuN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894D710E3
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 00:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733185011; cv=none; b=lMblhkQRrWAWaqsUZs8DV9/6+Kwkz9xJkVksiR5R6gZXOc1lm1kYQrSZEOWoW2vv3tcfA6tqTgqSPhf16mMfhuPmlrVPTUK8ja1kusExCqnaIhlUUjK9YtWTt0dGa07Y8+m4z9eFd6vO2XwfTpJOlMSyZCt/8+4LjEmYWIKh00Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733185011; c=relaxed/simple;
	bh=usNjXRvb2HxUxzCKsabiW++EkhasmHU313+FLIwbkUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZSV5+BsRgU3DWAAVnJOg5uqbh1SV+7uiFsaQN+/XqezirgKacp+MojgmJFupbps9GFeBymcclpuV5KbEfJ1yr8ySo/nf4jevSxYD9JrlOBXQnkhbKlzPdASyp6e0qfmWHNj9TFDAvHct43cgWvC8Ux6XWLcp2MCnOQK2NQygZjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YelpreuN; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-724d57a9f7cso4161318b3a.3
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 16:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733185010; x=1733789810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNP8ibJx5byLbM9/7twO8R1FhJfQOzQIrJyb2SOsZ1s=;
        b=YelpreuNjh2iaPajX7AwpsEHQNfQg3KXAsiTriXf8Z2Xi3fNnwcn6SgqmSJw2T3tiS
         /KLQiPwpUzLRgpBa6Gwq7lrAuI83CwFuq/wtczBSZ2bxKVHITuYVaeq2cWxjOiD5mm1Y
         9HEkWyu3qlga78TLgMr9Qxzid3tOtwSDOVlO6XKGwiLeI3JXpohK1KDVNe5Ipi4Qj/cX
         rN9GNi9oU29dl0rToQPIMDCjgMzzuXNdgQ7JALvhLzod2C87JKOKLSWTHMP24KZsx/ED
         y8gWO9NmaN3yRX5gFjIFMi9mSC0GKPs9sFDI9a3zpd1TfL71jPrnXLsZR4hIrFMHoQoo
         QXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733185010; x=1733789810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNP8ibJx5byLbM9/7twO8R1FhJfQOzQIrJyb2SOsZ1s=;
        b=dbMzOO0RBYdkkVWhFPd6hkt5ppHJQSre0XVFgvaUAYPoLSSS3bkGFgFVgpJJ7wr4g6
         VV8H3+cX1+snlnaQv55vaOWL0kTPtL51x9lqCBOiTIf1Z4n+S7kcY1GzugKIQQjFOWD9
         XHpZiv456fvE3vWjsemIyVDNF3f6q9OwJ7SGb3NMSFeQhImOGQtgOwdFNJ7M0XbVP3FN
         iaLHmARin4YKZBiJUZ44D+EA9Y5UQQxKFzdInIZgAA10tKRZP9LM3cjUtFhjOWLxTtOY
         VYzdJnlmQje2uQFPpkaBzv0rnexaVhY9MkjrFCxWFcakxqjrn1EIkePdQpJ8A2l0TaqO
         E86g==
X-Gm-Message-State: AOJu0YyLYGl6LIU+22SILJXscLQfvX0IweRro0oiaojmk+DiIGcWCaw4
	AjYyIzdPNr2O60ANjlhrTwTrc8mdmvvhiY5RuoEvpKAQlVFRNSZaaEvR3i1FEq2SauNnopT4i3V
	/hr7ybpNssRCHPy3lwjKlO6IHdxU=
X-Gm-Gg: ASbGnctHcPhXQ+xP7THOyxMK/DwGkGDIw1rSy/H9nkx5EXgcNjuGxVPNHDZGWg8y+He
	X2avJY80aiyVYHlZ8fp9l8IRGOkIJmIGDY81A60Nzr70eNlQ=
X-Google-Smtp-Source: AGHT+IGL1GA9yHU/bycSJymdFlIWXqIF7ex5uEKHvLpMyv+bbt0tflf3Nu5kIWbopAkyPuOrqW4tlTUdvtRhJIZn/SM=
X-Received: by 2002:a17:90b:1b06:b0:2ee:eb5b:6e06 with SMTP id
 98e67ed59e1d1-2ef0127f3cdmr677422a91.36.1733185009793; Mon, 02 Dec 2024
 16:16:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202083814.1888784-1-memxor@gmail.com> <20241202083814.1888784-5-memxor@gmail.com>
In-Reply-To: <20241202083814.1888784-5-memxor@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 2 Dec 2024 16:16:35 -0800
Message-ID: <CAEf4BzZpU0MXf1DWjHLfQNOEiFJ3JNmhYJQPzvVHxqfrX36F4Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/5] selftests/bpf: Add test for reading from
 STACK_INVALID slots
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Tao Lyu <tao.lyu@epfl.ch>, 
	Mathias Payer <mathias.payer@nebelwelt.net>, Meng Xu <meng.xu.cs@uwaterloo.ca>, 
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 12:38=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Ensure that when CAP_PERFMON is dropped, and the verifier sees
> allow_ptr_leaks as false, we are not permitted to read from a
> STACK_INVALID slot. Without the fix, the test will report unexpected
> success in loading.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  .../selftests/bpf/progs/verifier_spill_fill.c   | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/to=
ols/testing/selftests/bpf/progs/verifier_spill_fill.c
> index 671d9f415dbf..f5cd21326811 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> @@ -1244,4 +1244,21 @@ __naked void old_stack_misc_vs_cur_ctx_ptr(void)
>         : __clobber_all);
>  }
>
> +SEC("tc")
> +__description("stack_noperfmon: reject read of invalid slots")
> +__success __failure_unpriv __msg_unpriv("invalid read from stack off -8+=
1 size 8")
> +__caps_unpriv(CAP_BPF)

same styling nit about __success staying on a separate line

I'd actually do it this way to make it a bit more explicit that we
have custom unpriv caps:

__success
__caps_unpriv(CAP_BPF)
__failure_unpriv __msg_unpriv("...")

but it's minor

> +__naked void stack_noperfmon_reject_invalid_read(void)
> +{
> +       asm volatile ("                                 \
> +       r2 =3D 1;                                         \
> +       r6 =3D r10;                                       \
> +       r6 +=3D -8;                                       \
> +       *(u8 *)(r6 + 0) =3D r2;                           \
> +       r2 =3D *(u64 *)(r6 + 0);                          \
> +       r0 =3D 0;                                         \
> +       exit;                                           \
> +"      ::: __clobber_all);
> +}
> +
>  char _license[] SEC("license") =3D "GPL";
> --
> 2.43.5
>

