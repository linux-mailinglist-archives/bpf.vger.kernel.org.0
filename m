Return-Path: <bpf+bounces-60530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0105AD7D9A
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 23:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A83783B5D5B
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 21:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7622C2D8DA1;
	Thu, 12 Jun 2025 21:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+of4RXm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D66018DB2A;
	Thu, 12 Jun 2025 21:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749763767; cv=none; b=lATfi39hhp+j0uGCz3TEBqPiiZwrQFQPvIKDtZLw5j7q1UaK63wpzduFLJnRbWSCb8V7dxCOqX+dp3PIioLjzZjdK4EikWVyTTqi1CbAP/2v4cU8IVTq796zmel7vqUQG+sjx5KDrf7pnPAumYMTtz6+w6/D7Iu8Qzl97JX7oMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749763767; c=relaxed/simple;
	bh=5W/YqfShlCHUTyY/DIeDvpacRhlL+WLbiLqLA5CCOMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BBWvPwsuPk4f3MH7KfgA1qAHb9KIrWrFVkJKiccZV1NmvCWdKePsy+f1l19S4yyvxi1StIwB+qyv7IcapulMxfEhTTPeDcAdNnEs49zcu1Ack3ukj5me44M9zJbsBFMiztD+ccBjMrdrVAVxvP3WoBGgfbstAR1aUKMKL42FGIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+of4RXm; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-73972a54919so1416295b3a.3;
        Thu, 12 Jun 2025 14:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749763765; x=1750368565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUOuGKmouWTCGC9WhLKzsnt3gDMUj6WGMFR+tJi5hws=;
        b=R+of4RXmq4WJhfk47H9bCRffw/9REBzFGijQZ2E17JG2ahNkSwZpyMAKEZ6fE6oHOX
         MAV8g7OnGDCIc02M1SESLfDPTVtmn9Cui64XUJ4mtn4J/FpcFApSBTh2FHD/ixip/uM9
         AihVnHuSo8J6x6ZVTJiP2LoMsGnKU7HSXTzt4sHT7hf8sY4AjJZRnwaQmLUF2W2UVcNT
         0IJ3rNbJH+rtdvrmSPPZQkJDHwirZ+MkhiHtPcAZDZ78fDXPA6653Yo/dFW3l5J9FZY1
         HNqMp49KGfSFOLwhqAqIW6K5hG6uiFYkOkHoTs1kUKYGgzUD69p1FnDoNtbfze8Kgfw2
         psaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749763765; x=1750368565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUOuGKmouWTCGC9WhLKzsnt3gDMUj6WGMFR+tJi5hws=;
        b=DXNz7ogxX9sjGpCsCR0M7M+cz/VIIOdlx/AVD3Vuhi5qvcaoYXUgll2OgccT4ec+ZL
         GGaOAwLu4sqadj90IXrnA9hVt+Lw1rJSGzJ+Ob7yjkreLzLLV5ej2CgZnqzEVTIgZ1/6
         tIgLBQFsnqnHiHf9N+ZZghB0BRg+GdqD4zX07ikDbppEmMKwHzBYtn5jwJec3apZs31i
         ygzOyL0QloSWO1p5JSuivTEgUHGlb6OST8J7oiE/5ZbyYvuF/5qZ4j1X81hBmxr1Kn5L
         +LpSL2JBj6HgdrVDcbMtHZ3eh6O1IKLcKPrySBYjORg4szbcZbCCYIjtQB6r51Eq9JHf
         vrng==
X-Forwarded-Encrypted: i=1; AJvYcCV+rIRtpISPmJOeMcvnl+NMrBdDDgoET4emNr/Wdp12ZA8WUgTE0aEKz4xdFlGEmuLpO3RWe14BV++Y24fW@vger.kernel.org, AJvYcCVXtb0X+Bz/lIYCtzu/OipNEXEO01pKkt/t9Xw4jxp027hN7alZ2bY+BhQ7v5sgt1cXVgg=@vger.kernel.org, AJvYcCX8+mV80yFxzZZTCYjtqfbCU6TLXXh2Qhmzeio2T2+suu2MCbISN7aVGfOCVYyV7tE6HbMtDkUdjq9c2mdHlx2KudqM@vger.kernel.org
X-Gm-Message-State: AOJu0YyX8/L3zaDiQI7GigEsAIyXD5qqU385e8PhuPTt6cFo/0FWuJ1U
	BR4xzoyACKeTUhCV3a6h0vNDIshykQ2vNdMN5vbzNOJaV8zVLTG21HDyU32LsFaRwoCESwMTZvo
	mApfONpTGEEO9iHwUH5q/aXuNjYc24co=
X-Gm-Gg: ASbGncu/ZcqILicYRFM49bHt5I0P06cW1BriqV+GH2207HVIOKUTY6eCRyVKXEpzJd/
	7yCqyKP6QI4PFXOwU/s5YdHWDRwHFWK668keeSYKtltDPmsUZEVNDNno4GbEQ866Ukq2sOKA4vh
	iY72gwlJhbur6ZCSCdAMaWOes1LyUNNvyaph50Rs7HcFvZpVz+DrArEDKDhtA=
X-Google-Smtp-Source: AGHT+IGogl48W5RBmja4Gye95lYVyB0DCcNPxyl1oM0sjLSuMS+F8qW5ia7I3pwUYbU1rVX71Bar7YpLieQmF3fONXc=
X-Received: by 2002:a05:6a21:6da1:b0:217:4f95:6a51 with SMTP id
 adf61e73a8af0-21facc878c1mr674145637.29.1749763764823; Thu, 12 Jun 2025
 14:29:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611154859.259682-1-chen.dylane@linux.dev>
In-Reply-To: <20250611154859.259682-1-chen.dylane@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Jun 2025 14:29:12 -0700
X-Gm-Features: AX0GCFvJFhBgfXD5SqubEiQJZ0Dc6KFRm6d2kuM9JQhOBCsd9ou8DGkqwmhgrKs
Message-ID: <CAEf4Bzbn=RVhMOR7RapYwi+s8gbVS=1msOuZ7MhPvgz8zHiE9w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: clear user buf when bpf_d_path failed
To: Tao Chen <chen.dylane@linux.dev>
Cc: kpsingh@kernel.org, mattbobrowski@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, sdf@fomichev.me, haoluo@google.com, 
	jolsa@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 8:49=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> The bpf_d_path() function may fail. If it does,
> clear the user buf, like bpf_probe_read etc.
>

But that doesn't mean we *have to* do memset(0) for bpf_d_path(),
though. Especially given that path buffer can be pretty large (4KB).

Is there an issue you are trying to address with this, or is it more
of a consistency clean up? Note, that more or less recently we made
this zero filling behavior an option with an extra flag
(BPF_F_PAD_ZEROS) for newer APIs. And if anything, bpf_d_path() is
more akin to variable-sized string probing APIs rather than
fixed-sized bpf_probe_read* family.

In short, I feel like we should revert this and let users do
zero-filling, if they really need to. bpf_probe_read_kernel(dst, sz,
NULL) would do. But we should think about adding dynptr-based
bpf_dynptr_memset() API for cases when the size is not known
statically, IMO.


> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  kernel/trace/bpf_trace.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 0998cbbb963..bb1003cb271 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -916,11 +916,14 @@ BPF_CALL_3(bpf_d_path, struct path *, path, char *,=
 buf, u32, sz)
>          * potentially broken verifier.
>          */
>         len =3D copy_from_kernel_nofault(&copy, path, sizeof(*path));
> -       if (len < 0)
> +       if (len < 0) {
> +               memset(buf, 0, sz);
>                 return len;
> +       }
>
>         p =3D d_path(&copy, buf, sz);
>         if (IS_ERR(p)) {
> +               memset(buf, 0, sz);
>                 len =3D PTR_ERR(p);
>         } else {
>                 len =3D buf + sz - p;
> --
> 2.48.1
>
>

