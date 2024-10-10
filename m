Return-Path: <bpf+bounces-41551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E62C99821D
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 11:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 706ECB22462
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 09:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9C41A0BDC;
	Thu, 10 Oct 2024 09:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYPEB+n0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f195.google.com (mail-yb1-f195.google.com [209.85.219.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A641BF336;
	Thu, 10 Oct 2024 09:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728551887; cv=none; b=N0+O+TUf2/dm+iQkougjftdB7cSuOKDRXZbn8XceUjo97BAH/2Mek2ToyQw7zedwtubjBTAeFkMWxxF5HhlZ2EbzN7+MYzPkrWrbVNr9Kb9euEmL0qYaw5QPcdnHDO9RiRVi9DEyz7OXQnLyuLaGBOI2DD+6qSNLnP9eTFSrdeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728551887; c=relaxed/simple;
	bh=rUHHk8rgJHWQvI6g2briKgZOqZvbsnK5PdnEPkVLbfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mms4TWYDe6dZlGVV6NGpYXoekV9UYo4qNZQb143s+cHdQ+2+Fj5cTdmdi4Ew01FA8i8trVV4q7mpgAepYgCX2lPjSfU8GWwGy7zD6ud0HqffMSpL6YaRSduvnfiokCaZWmpdHSnzUozN3yYNzaxLY6CYswa2v8/wDVLJ1tjkR9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYPEB+n0; arc=none smtp.client-ip=209.85.219.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f195.google.com with SMTP id 3f1490d57ef6-e25cc9e94eeso565293276.3;
        Thu, 10 Oct 2024 02:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728551884; x=1729156684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgEoSDXOx4rxS6fo7C9XyhinmE5c4V0uc58RByhFdoc=;
        b=EYPEB+n0+loOPbd0UwdgYJukPTa0LFbZLn6aVKTeleASBxwSkUdS9Pg7ngrk0v79hR
         7dRkuMp1P6HezlcRXPYNB5p3SRzNepB6sbQB/syHuPxUGqyM+GnkBH2DwBShs5Y++gh/
         vH4L8Ewf97SH1qzniu7xYc7Ue2JPIT5Wj0w3wj5dhd60Zqu41fgzYRYrtXknhvNwqLe7
         K8Mrg/DU/mMIp2y0Ft/UF5H1O02Uspk7sA1stokp2DCK7DvSVbQDZDoADDTkCdRfsdxV
         oT30khUH5dRNUDzfBNTcBB+xkB0WOAyaXc+w1nwc7zUfPu0B36ziZHDwDLPx10qrHyTl
         Keuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728551884; x=1729156684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vgEoSDXOx4rxS6fo7C9XyhinmE5c4V0uc58RByhFdoc=;
        b=dswf4zLfgX1dXz3Bjzy7yEv5X6pn9v/BKLOQxzOIflYmKCHA2ogKZfKtioS7IyNrGt
         3CX5Qz5G2lPTtnKuaqWtTzEvMkzGT+H+Aq7NH3sB2tx39ODbSgSv0XK/FMtKh4Eo26Rl
         xHmqovdn0QmstOfiAMcyfETM/svolSFfaRk/8KwOaLNffFp7m+2DvovY2iTtfn8pJE2D
         VeW8+sEuC2M2dux1tSrCkEgiaWfaImb/Kw4BuK7TkXM/ZYDj7jWq3VeGPFBYjof8OvLP
         Hi6X7zgzHdA0SrvEWkXgiXd/3aYcUrun8Wvr0Ftgo+rzKmj9Oip0Vrq/0wDlkgDheo62
         Cd0w==
X-Forwarded-Encrypted: i=1; AJvYcCUAgyJBcJoE6HUenWfAT9tNKdCV8hM9hhzFkONSkjZMIEIEqmliOt6Gi8TgFSLQmfRpU94=@vger.kernel.org, AJvYcCVlvY7omyqTKgOXhg9vKFU5oZGSvkxNisBnLbmVbFEaF+tJTl9aQbZ91+NfLvVkHttnqnupI7j3@vger.kernel.org, AJvYcCWLKm94mfm4MMsU+GnRNzFEjvfwRfAOl/3Hjp/sGa0ghJ616yRCP+WQAbzRPqE8ildy7cqzMqgERZc1z273@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm6+mAMpny1Upx8SKN9VW1eLtgIREmzQQgC1jroLFVSWDmC6AA
	zkYj0fV5UjSvJW2Lq83H/CL3VARSDlpk9xZpsrFkdgBxcAUNPgNniFcMbtgUvn69nUyLGUPFgrD
	19dvAoLZ6Q/vT8A9/CqisjBkOsWU=
X-Google-Smtp-Source: AGHT+IEs7eWnfTZKB14a5GrK0aqxuXs9/I7G3sqBW7ksOuF23qKYuOoSI9ITP1aD/hko3sqoVtCcuoKDNhAAzj2w4IM=
X-Received: by 2002:a05:6902:240d:b0:e28:f558:ae4c with SMTP id
 3f1490d57ef6-e28fe32dddcmr4949218276.1.1728551884329; Thu, 10 Oct 2024
 02:18:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007074702.249543-1-dongml2@chinatelecom.cn>
 <20241007074702.249543-2-dongml2@chinatelecom.cn> <7caf130c-56f0-4f78-a006-5323e237cef1@redhat.com>
In-Reply-To: <7caf130c-56f0-4f78-a006-5323e237cef1@redhat.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Thu, 10 Oct 2024 17:18:45 +0800
Message-ID: <CADxym3baw2nLvANd-D5D2kCNRRoDmdgexBeGmD-uCcYYqAf=EQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/7] net: ip: make fib_validate_source()
 return drop reason
To: Paolo Abeni <pabeni@redhat.com>
Cc: edumazet@google.com, kuba@kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	dongml2@chinatelecom.cn, bigeasy@linutronix.de, toke@redhat.com, 
	idosch@nvidia.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 4:25=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
>
>
> On 10/7/24 09:46, Menglong Dong wrote:
> > In this commit, we make fib_validate_source/__fib_validate_source retur=
n
> > -reason instead of errno on error. As the return value of them can be
> > -errno, 0, and 1, we can't make it return enum skb_drop_reason directly=
.
> >
> > In the origin logic, if __fib_validate_source() return -EXDEV,
> > LINUX_MIB_IPRPFILTER will be counted. And now, we need to adjust it by
> > checking "reason =3D=3D SKB_DROP_REASON_IP_RPFILTER". However, this wil=
l take
> > effect only after the patch "net: ip: make ip_route_input_noref() retur=
n
> > drop reasons", as we can't pass the drop reasons from
> > fib_validate_source() to ip_rcv_finish_core() in this patch.
> >
> > We set the errno to -EINVAL when fib_validate_source() is called and th=
e
> > validation fails, as the errno can be checked in the caller and now its
> > value is -reason, which can lead misunderstand.
> >
> > Following new drop reasons are added in this patch:
> >
> >    SKB_DROP_REASON_IP_LOCAL_SOURCE
> >    SKB_DROP_REASON_IP_INVALID_SOURCE
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
>
> Looking at the next patches, I'm under the impression that the overall
> code will be simpler if you let __fib_validate_source() return directly
> a drop reason, and fib_validate_source(), too. Hard to be sure without
> actually do the attempt... did you try such patch by any chance?
>

I analysed the usages of fib_validate_source() before. The
return value of fib_validate_source() can be -errno, "0", and "1".
And the value "1" can be used by the caller, such as
__mkroute_input(). Making it return drop reasons can't cover this
case.

It seems that __mkroute_input() is the only case that uses the
positive returning value of fib_validate_source(). Let me think
about it more in this case.

Thanks!
Menglong Dong

> Thanks!
>
> Paolo
>

