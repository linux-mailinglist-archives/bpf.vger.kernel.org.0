Return-Path: <bpf+bounces-34875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AD6931E9F
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 04:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF2F91C2208F
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 02:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF31B4C9F;
	Tue, 16 Jul 2024 02:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBta9ndM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B7C17C2
	for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 02:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721095243; cv=none; b=ZeY0m3uoGw5upZqEgYVByWo9rIqJUx9flm2Ljq5HTvgUusF7R+sqUY5yhkQNMmsyd6hITLEwfQiYpk0yWhQzRYPrFCDE7E7twXU1yXCOVwT4ZAo89IbkuohDDefrfhftZ21x8ZZKm0eJylBHrq5nMZLkOAFPp7rRwfGVj1TIBVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721095243; c=relaxed/simple;
	bh=6SiYrYTR0M0ARVS0ih7s68zjZXn4/m+hmfveXuZCE7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=onfitLQv/N6Z6XoXnwJTlpP0ybHcJjlNvHfb2Kd9m4bUbtPDfmKt87DEH5xNPP1m4NtrGu4SBf/HouZ+pK4GgiXQ7s7CXw2tXif1eaViMdiWJhv0IN9UJHOJvT6vOeu/J/Je8IbJX85Xjdh/6YDDuiL6YgBb12Na3273nvv9yVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBta9ndM; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-426526d30aaso34554625e9.0
        for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 19:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721095240; x=1721700040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYu+8JiqXzgTdpti2nY6QOeitO9mE4B6mHOno4Ka11k=;
        b=UBta9ndMpgFmB83dMe7LGNXZzud4jR0HNuF0eXdBpLV9vb2qxDXp+LDbqGc63H2Ohf
         C28OD1kxArQ3S64L7OMrY3MJX8a/1YmKyI/LOEaTCoATJ5HApM41ThfunNklcrTgLBpZ
         eXRsiLcxlFJYOAf5wv3g01Rw4UrXxRqtZb6Qhdw3Hsx/dsZPVCY/n/uBqUuSHD1W2tjx
         wsiZ4/4X3JoHRs3hlpQmd/Jnb1njrPVrSKSeKwmmJI3GXFOTAgmo6OFyGR0r5AOnktsR
         8q5tXIiRLDdaEt2Kdm0093PszWQahoeghwlFr8nb5OrB7f+8sGwizAzX4K5wJ29vcdVB
         UfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721095240; x=1721700040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nYu+8JiqXzgTdpti2nY6QOeitO9mE4B6mHOno4Ka11k=;
        b=jo+6DRKh+nodgv35O6512axjIHnaXkTzldr2jAkghmdhoH2FkMhTWeMfFZ/3zOeucB
         AQViSlmsjQ9kAElgZkZ8r3ZvVTPSFqK28L02bYukEi8YuMPQOQTcStTgg70Rcn3jdtdK
         NIM6u9NDid+mLFqy9b84Ze83I25MOntx82B2d5YlC0w3NqExIWIZZuWCSg6W4kT4GnIh
         a7PwPMbIVSYRq5UhRyLibSnei9txM2Y6Mv+7u2N0eMFBNWRtXKHCvOiRFeleYx2CVLwb
         0GIQlTDzs6bJ1dzvyfqRiY9jdq7i14qMo5HRsV+Lnyt5Yf6PY0RCbYsyRmMERu6baavt
         GKBA==
X-Gm-Message-State: AOJu0YxxtETx/d0bfx6hsLRT9KIYQBlsJiENVK7Mdug7OJJrN5h8DMOD
	15cjUWEN6qxrn2pp7strXeC7B6I95Mex0olYTPPaY83sv0jPbGskrBOgf1CmTMmfeaxntzR7OLr
	ES27R2ysGTXM1+2Yek99gZ1wcy3cnUoLb
X-Google-Smtp-Source: AGHT+IGn8LGdl3MFt8dfy7EJje5IDA6igr5eHY84UmU3Sg5KOHkXSY6tIW76iTQQerfFLmM60k35IQJOeZ5SEEEy2rg=
X-Received: by 2002:a05:600c:4e4a:b0:426:618f:1a31 with SMTP id
 5b1f17b1804b1-427ba71dae7mr3566135e9.34.1721095240032; Mon, 15 Jul 2024
 19:00:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715230201.3901423-1-eddyz87@gmail.com> <20240715230201.3901423-12-eddyz87@gmail.com>
In-Reply-To: <20240715230201.3901423-12-eddyz87@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 15 Jul 2024 19:00:29 -0700
Message-ID: <CAADnVQ+2SC6w2h+bNBEZ-R--RVk5zgz2AA-x2=7X8azL26ua0Q@mail.gmail.com>
Subject: Re: [bpf-next v3 11/12] bpf: do check_nocsr_stack_contract() for
 ARG_ANYTHING helper params
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, "Jose E. Marchesi" <jose.marchesi@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 4:02=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> There is a number of BPF helper functions that use ARG_ANYTHING to
> mark parameters that are used as memory addresses.
> An address of BPF stack slot could be passed as such parameter
> for two such helper functions:
> - bpf_probe_read_kernel
> - bpf_probe_read_kernel_str
>
> This might lead to a surprising behavior in combination with nocsr
> rewrites, e.g. consider the program below:
>
>      1: r1 =3D 1;
>         /* nocsr pattern with stack offset -16 */
>      2: *(u64 *)(r10 - 16) =3D r1;
>      3: call %[bpf_get_smp_processor_id];
>      4: r1 =3D *(u64 *)(r10 - 16);
>      5: r1 =3D r10;
>      6: r1 +=3D -8;
>      7: r2 =3D 1;
>      8: r3 =3D r10;
>      9: r3 +=3D -16;
>         /* bpf_probe_read_kernel(dst: &fp[-8], size: 1, src: &fp[-16]) */
>     10: call %[bpf_probe_read_kernel];
>     11: exit;
>
> Here nocsr rewrite logic would remove instructions (2) and (4).
> However, (2) writes a value that is later read by a call at (10).

This makes no sense to me.
This bpf prog is broken.
If probe_read is used to read stack it will read garbage.
JITs and the verifier are allowed to do any transformation
that keeps the program semantics and safety.

pw-bot: cr

