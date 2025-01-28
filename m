Return-Path: <bpf+bounces-49922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D008EA2028A
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 01:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E2AB1631EC
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 00:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF1F1FA4;
	Tue, 28 Jan 2025 00:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLZ0bXpo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3D016415;
	Tue, 28 Jan 2025 00:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738023587; cv=none; b=O0XW9eSiLDOvZPBLXPtTRw3b4dv/s2DP1lBgeDvHjqZIODiyBaqQreyWiyXWWT9w82kwGoCbg8Jf5m2SG5T70sDmoRE7xDkQMDLKKXpxpocXZc2pRSJqRTAk/gOGP+pAbl90L7OpcnQK4r+LihGxcNQiGg2W4AcNtn3KOHRl6Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738023587; c=relaxed/simple;
	bh=CQPutVse/DEyP2XKii8SJ79omHPZaCdgojtQO4vSnEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=It+rHlET/sLDywOon244QY1pDSPoiC2oP0NnZzNRqat/Mp9pDVupwEs28DHyv7vNL9dUNpGwLvRbyHdjK6E0QiCgg6r1d+agf2ra4SLSIR88wBJQ4aapn85PVGKIYToR3C4vo3oXKz+w+dva0Ll/Rgbj89Lov3cRs1iJdcSrYkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLZ0bXpo; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-844ce213af6so138964039f.1;
        Mon, 27 Jan 2025 16:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738023585; x=1738628385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQPutVse/DEyP2XKii8SJ79omHPZaCdgojtQO4vSnEo=;
        b=aLZ0bXpo3+ig5zdqscbuEmp64gefOXxLSiWk9IGDrBr0H7/wwXkNwM9LSGWixWwkPN
         Pv6N/KExUbOlaf+39uM22WKxCwN2Ll46AT7ac3aEn0JdRNiEwVAg2L0r7vjX+owsgvvZ
         Wx73P3Hn5ZBd0+5WeJF6HG0YGq5Xg4+t1Ay9loPoYITzEK2HJiWtzQ19vuvixTWRwzdz
         wyBdqdm2gaUBhR3XKXm7TZlH0JJJeraZDfZJjth028NH6zaMpdFLQXNzh4Y4rGUOkOEt
         ac18gSeJ8ieit19wDvPb55PfOV6lQqF4eafNV3DtuZGQGcBCjJK3QN3MWrM5CXA4Yju1
         WmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738023585; x=1738628385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQPutVse/DEyP2XKii8SJ79omHPZaCdgojtQO4vSnEo=;
        b=hyCPPSLOi7sbxn99Et72zft2OmCwx/40ULbhj3DFlPtevSppIpRToVOv2WpHwaXRNW
         tOKZ3zHsb4txGqtmKN2tCvyUy0RIsLF6ylEApJ4FqLgWRk1Gl7rqEJeG6z5NzFK+XH/y
         tFKhNQm+73WigZRY+a2NImkN3veugSQZm/fQkZAu+pYDn1cejgwdPLb85O0SVYJfLSsY
         1/DxrHq9PXWSZTCTPjgIi6oAbuwJLmwhWRjZezoOgWld288VgbMOhJaLQ2uWeMqMSngC
         P+XQVUuoVi02UsrUHiz1eSNEW2euj8Qlr9jg5FgIstiGwl/Rbdu5Tw63PJw40ZCQRYV3
         95uw==
X-Forwarded-Encrypted: i=1; AJvYcCV0UuD9jJN4XPRE8rHVIJ3JG5w8QcJwB2+ff3l2iyv0uQ4neHsZLfmVebsSUqGjUv3V6do=@vger.kernel.org, AJvYcCW9gA9AdXbFEq67kQDJOAGm0gSC49Khos2kT/Wg12dBFxRMJHG8xHrq8U8FnAK7te5goukIU3Vt@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6fRSGPagiTRHgVUqouNxjg7hzXhSKPS9DmFXjclsi0kUTrKHm
	zLHG2ih9cDI2+cH9jYnw4FhHkpQP51LDTakr/LgMsK/r0p4wF/aMxShR7PzbN4y4IRkDwBmfIwR
	R0Ag8PTysVzGPOoJdOTuNec4SX54=
X-Gm-Gg: ASbGncs39ETtuAnuheAmqlbSr/y5uwa0Bom2e+ItpgYZdyCa4NwBloSoozkxVKe7/03
	6woy3WbZG9RF8WAdANWQOa4iPwdU6bW7EXtyMc+op/hDh/CdeoGkIrrogc0yF
X-Google-Smtp-Source: AGHT+IH5YfvUQofN/ifqH3btdlsZaUo8Yu7ZpRSJieOZ9sdpcy2svVfl3QxvK9Zgw8/0y6p/cDPPm+UWf44gIxxJ2kQ=
X-Received: by 2002:a05:6e02:20e7:b0:3ce:7fc3:9f76 with SMTP id
 e9e14a558f8ab-3cf743eae5amr325895715ab.6.1738023585074; Mon, 27 Jan 2025
 16:19:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121012901.87763-1-kerneljasonxing@gmail.com>
 <20250121012901.87763-14-kerneljasonxing@gmail.com> <564d8d62-3148-41a1-ae08-ed4ad08996d3@linux.dev>
 <CAL+tcoCpJESydmRXp9ASeXYjFkjOyXn+dF+7dYa0Ek6DdnMHKw@mail.gmail.com> <29073a9e-23ea-49c2-b0ad-d33bd3ea8974@linux.dev>
In-Reply-To: <29073a9e-23ea-49c2-b0ad-d33bd3ea8974@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 28 Jan 2025 08:19:09 +0800
X-Gm-Features: AWEUYZlxauSbaAiKtImkBAcXJAZ5a4vSHBqSdcRo6g46Ajkj_6nC5gSfDt6wnUw
Message-ID: <CAL+tcoCOLZy-hsASN5St+9HK_y47VHGO3fbyvzxG5-D0jBB5WQ@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 13/13] bpf: add simple bpf tests in the tx
 path for so_timestamping feature
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 7:49=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 1/24/25 7:42 PM, Jason Xing wrote:
> >> Please also add some details on how the UDP BPF_SOCK_OPS_TS_TCP_SND_CB=
 (or to be
> >> renamed to BPF_SOCK_OPS_TS_SND_CB ?) will look like. It is the only ca=
llback
> >> that I don't have a clear idea for UDP.
> > I think I will rename it as you said. But I wonder if I can add more
> > details about UDP after this series gets merged which should not be
> > too late. After this series, I will carefully consider and test how we
> > use for UDP type.
>
> Not asking for a full UDP implementation, having this set staying with TC=
P is
> ok. We have pretty clear idea on all the new TS_*_CB will work in UDP exc=
ept the
> TS_SND_CB.
>
> I am asking at least a description on where this SND hook will be in UDP =
and how
> the delay will be measured from the udp_sendmsg(). I haven't looked, so t=
he
> question. It is better to get some visibility first instead of scrambling=
 to
> change it after landing to -next.

No problem. Let me give it more thoughts :)

Thanks,
Jason

