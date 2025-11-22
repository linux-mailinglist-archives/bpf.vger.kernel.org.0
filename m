Return-Path: <bpf+bounces-75272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB8BC7C013
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 01:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DB494E1E35
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 00:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D100B1F3B8A;
	Sat, 22 Nov 2025 00:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLHuy5+w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB2E1C5D72
	for <bpf@vger.kernel.org>; Sat, 22 Nov 2025 00:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763770942; cv=none; b=oa+cG8NVQC/8lU1eEHx4+jxo3FQPhu7WTDMX4QEAkbHdPWv6v9tF8LIqAfKORCS/l7p65zkoLNFsfs3MM9C2C3hH+P/GlLu4haP+wtiUxke45Czn0JHeTJNBAMkX9gDXXyxVauMwzCJoVaXrdpasaELb5bPmvYg1voNjDOqEbW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763770942; c=relaxed/simple;
	bh=tKH+9xUvJ61C5pXpNcuqHhVpbRiIKMR++rhv9UJ+sSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NuPC/PDELJMp5hPkJiKOBrW9++GTghWXLEl7GUb+mAtaN0gNf8h752TimAvU0t90gPc291gh7cF9jhur7/JAc1ppBr33OevyEUYlnVzoNd/1loZLhi89TrVJA5U7ikG6U2wEhcHQc8jRFCBMaE0oemqpJhxT41Jb2xw9tcOtSBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLHuy5+w; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4779d47be12so20081345e9.2
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 16:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763770939; x=1764375739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+/6paGrk3006qZ7Bm65iZEZez0fPXCo38RfPda/UHI=;
        b=fLHuy5+w1jL9J98an5q6MQe/z9wVcMBKqyAxaSxGAQYMji+N72hpPP38S+NHHjF0Cu
         SeJAtensfm5iLM7BlQkpr1yLbYGENUVn7CUNhLGM6f44VgT3hwOsloUByUwJh6K1g3AQ
         50mr06Llh8Wl9oSt+QR4i0c5kd7fLYQ+M3xmSnLdOdEBepu5w76ntNHiyKjhT1y108lE
         dXobeUAuvRNq/UwgQLuEUzPExfPhR3XzxZh0QKKaJnj976DvXqwuH1V7dT+EdyEjEic5
         xAmMlHGj81dnJRqQ9oY0lr7yi5ktxVYjaRTSP4bIbQgM7M5Syz2Qe6bX56csLn4eDEyc
         ni9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763770939; x=1764375739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p+/6paGrk3006qZ7Bm65iZEZez0fPXCo38RfPda/UHI=;
        b=Q2PcxsAzE3FE0ejukOzsU98+rwlDDRHZN7jOTeIKy+tiF7l27tvXxP7utJwt7sW2qd
         M93zbyCWyNDPaIPQTGEObpQBBOAv7T3iMG0z29ixOXvncgl+Z+q6QTYBjiTFXAyAX0en
         RCXkFuH2C/ItIhn8g5jxyqaHKbpe29lIZH9k5OObns5JSh5CX08f83nycc2DhFnBFacr
         WMMdAptkupCWF9Ree/SdxR6qlcw8184LMF6Ncgj3R1beL5ScbNjeoeHgJV/xPSaCxbpw
         rJd5FlHGjmlI+bISSjuSlR1RQ2qlN6XKY2p+U4puSm2WJUq15162SX3bZZ6d65SzEnae
         5StA==
X-Gm-Message-State: AOJu0YwNSdMRb5dcMGtQbFNLXeWUWa/dwZePTXhU5feQz5fOY/z02htI
	jzZr5ZQx38XKAMBpHM+edfgez7q8GdA/dy4BodFF8khXNYPFBuEINl5zA0rEttiv47jdLqdC47y
	HF/9qcLu5Xn1vwpRbWQWrkokv6RfMowk=
X-Gm-Gg: ASbGncuZQXMAHoEYMPzgXrNYVPCJGDmciElOgVkVdGkrpvIfaN+hFvJepjMVMqet7Pd
	4zUcAf1rCnbrIHoKBYrXZrpESqFLhY7vJqCKECuk/wzxvDP3bzpv5sbFZ1lRtrOz1ehqbG7wek+
	wXcc/AC4sphkmKWvz11qkDSig9Yf/5sC2Y0DIX/Ji4jvqvbMi5y3XeubK4gjaaedWmXojcznEpI
	8p3S2hIDDeZ/vUYpVSv6JzR845EHN0aqiHJ1g10Ht91lRy2A7fvBr3mkQqNMhBsWLx7C3s5sv3V
	dymks8y339HvBYRsyRpsiqPxTo8u
X-Google-Smtp-Source: AGHT+IFIlUv8CTTWAH9IDvU/D0EemTGa28qR8HOnKbaKdoxlazAqs4uFh8qzWMlmPckLI7FsLKQ0hY+UcakGnnRYyaI=
X-Received: by 2002:a05:600c:1d1d:b0:477:7a87:48d1 with SMTP id
 5b1f17b1804b1-477c01ff5bbmr50295515e9.30.1763770938648; Fri, 21 Nov 2025
 16:22:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121231352.4032020-1-ameryhung@gmail.com> <20251121231352.4032020-5-ameryhung@gmail.com>
In-Reply-To: <20251121231352.4032020-5-ameryhung@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 21 Nov 2025 16:22:07 -0800
X-Gm-Features: AWmQ_bkbfNC8AbX41EiWAyASc5eiyX3WLpQNEoA9qHterxF2eSEcbHVcDGbOwU0
Message-ID: <CAADnVQLeSP654facoQxW9EHJpLBivdM3rm6WpCsimsnXPbYJ1g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 4/6] selftests/bpf: Test BPF_PROG_ASSOC_STRUCT_OPS
 command
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Tejun Heo <tj@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 3:13=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> +/* Call test_1() of the associated struct_ops map */
> +int bpf_kfunc_multi_st_ops_test_1_prog_arg(struct st_ops_args *args, voi=
d *aux__prog)
> +{
> +       struct bpf_prog_aux *prog_aux =3D (struct bpf_prog_aux *)aux__pro=
g;

Doesn't matter for selftest that much, but it's better to use _impl
suffix here like all other kfuncs with implicit args.

