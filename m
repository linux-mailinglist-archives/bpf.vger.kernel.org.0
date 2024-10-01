Return-Path: <bpf+bounces-40697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD65D98C446
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 19:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6572EB21E2B
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 17:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061071A00FE;
	Tue,  1 Oct 2024 17:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTOfm801"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B030E1CBE91
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727802907; cv=none; b=c0A2bX2sCmP7Xc53zFk545HRe1Q37ArF8ISKIPTFbjakoyHLnPRWdE5R8Qn1nGreTRmny4m/oaEpysoQD2JXYZrr6SYqWIQaGG/8nbVV1X9nqlDwuNt3Hlz3G2rjmF4b/H0EM4/BwYdrsYSLEqD72m3ntZK2OOEefwFOBA+uDPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727802907; c=relaxed/simple;
	bh=GjXOM0JWnRCQ8LqRHkLqiasXoeUsIKrFM/0r/I3WhMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XFrLarZ6Z17Pguxg7RZjnjCQSwXktNr5WqUJPxkcg5Wor6B6HkKD5b24bnA0sYPnJ/C78S4g8LnqPjw89VBNFKJTRv5Rj0XcpYsHTkMRyIxfXtbFNBGMz9fU/5IqPPNpnxA9yT/urrasmHTAZ2kmols0PmAUghni1Er/dnHcCAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTOfm801; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e07ad50a03so4343479a91.3
        for <bpf@vger.kernel.org>; Tue, 01 Oct 2024 10:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727802905; x=1728407705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cELQrU3Gq9Ot8CqEKbr0//ePOKSHPxaoc+Yt5YjVgE=;
        b=WTOfm801Fulu4sUfGrBUfbnHeid99xdMkn4D1rZpy6tk1UpJNQ6Dpu6vwB0Rj0UYfD
         ILw4G5vub7FXuH/Q3GO9wqumcuA0PZhnEmRSuaMx5hqz+aACnk/GtZqD+V2Lnl5ScMYF
         3V/xPYGP9PluKicyX5apJnpVE1YSJ0LtzOBjeP+kOLiR5rr2u0vqNpZ5J8YBfh0tw/6y
         IsROe6UCTqNXi9flwfB+G3S6T6lU0Wx9B0oc+nmVUOM77Jm3KR5IOyVb1E/qJ8dCPpyA
         O6tDSHfUFnVTpqQpeWYUgbaGb8ZtReG30GKv+FkvCWOGYjHh3uLJgl6agB7eKGRSVDoj
         isXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727802905; x=1728407705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7cELQrU3Gq9Ot8CqEKbr0//ePOKSHPxaoc+Yt5YjVgE=;
        b=OsC9u+5onVUEP9n42dBobOXDAgvTBZC5oDlq4WQNzTXmDvBHxfH0uXOKqK5uGHEX44
         tKcs8/b7bd+DFgpaxG42Y3xdkj0AQkQbowA3s2Kcy+NpS5m82bgvs+B7PmZ60kvAyJAA
         O8SZHBr2aR0SMpQrEb28GPGFJaKvjAdDbF7WyodXRWG17wSQbDssPE6aobOh6jsvXyuW
         xDPafFtgrOONBcFsu1XINV5x2LNwKAVTrlOTy2jXBRp5hd1SXo6xnGQtuxk5qwyOrZNV
         DiztOxM9GdInLyw/Q0TMtGy8RZqJ459lhKgmH8P3ESE27f3OCQHb1QjB8Tme7XbDTiqP
         g2lQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdDpcAexqF2S2qWj/0tK6tn0QyOpqpBZkVHh3d1aGjKFRmTeoXTMHpmnM9cxcwBqjweM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbuf5ax69Guqgzf6WhuGtDDwPVxfLuOt2eUN2eOseXEnBbImGe
	X9mm2IjO2LQzAAEXl9VNkP1qxO6GF83+gltEhyR9xGsWHCHrBZpfZzUpLoWkd5nUIvqJwfGaJp+
	fyff+zO7AfGzx39gHHT8yH8xlRg8=
X-Google-Smtp-Source: AGHT+IGbkMQFfEBOKBfntDNRXuCETglwJe43A6rTgZYAD8WxTOs3EOj5kEs89W24I+uP85GWVOyfbdhketXMYbdoKr0=
X-Received: by 2002:a17:90b:4a51:b0:2e0:876c:8cb4 with SMTP id
 98e67ed59e1d1-2e1849009e3mr480941a91.30.1727802904968; Tue, 01 Oct 2024
 10:15:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001012540.39007-1-kerneljasonxing@gmail.com>
In-Reply-To: <20241001012540.39007-1-kerneljasonxing@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 1 Oct 2024 10:14:53 -0700
Message-ID: <CAEf4Bzb6vkSLt+t2FOq=amNiU-6zwx1=rN43W2cn11JmzEn5Qg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: syscall_nrs: disable no previous
 prototype warnning
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 6:25=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> In some environments (gcc treated as error in W=3D1, which is default), i=
f we
> make -C samples/bpf/, it will be stopped because of
> "no previous prototype" error like this:
>
>   ../samples/bpf/syscall_nrs.c:7:6:
>   error: no previous prototype for =E2=80=98syscall_defines=E2=80=99 [-We=
rror=3Dmissing-prototypes]
>    void syscall_defines(void)
>         ^~~~~~~~~~~~~~~
>
> Actually, this file meets our expectatations because it will be converted=
 to
> a .h file. In this way, it's correct. Considering the warnning stopping u=
s
> compiling, we can remove the warnning directly.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> v2
> Link: https://lore.kernel.org/all/CAEf4BzaVdr_0kQo=3D+jPLN++PvcU6pwTjaPVE=
A880kgDN94TZYw@mail.gmail.com/
> 1. use #pragma GCC diagnostic ignored to disable warnning (Andrii Nakryik=
o)
> ---
>  samples/bpf/syscall_nrs.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/samples/bpf/syscall_nrs.c b/samples/bpf/syscall_nrs.c
> index 88f940052450..8f6ae21d358f 100644
> --- a/samples/bpf/syscall_nrs.c
> +++ b/samples/bpf/syscall_nrs.c
> @@ -2,6 +2,11 @@
>  #include <uapi/linux/unistd.h>
>  #include <linux/kbuild.h>
>
> +#pragma GCC diagnostic push

please add matching pop as well

> +#ifndef __clang__

I don't think you need this, clang supports this pragma as well (even
though it says "GCC")

pw-bot: cr

> +#pragma GCC diagnostic ignored "-Wmissing-prototypes"
> +#endif
> +
>  #define SYSNR(_NR) DEFINE(SYS ## _NR, _NR)
>
>  void syscall_defines(void)
> --
> 2.37.3
>

