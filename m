Return-Path: <bpf+bounces-55575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE67A82F14
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 20:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3EC94A2117
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 18:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD88D278149;
	Wed,  9 Apr 2025 18:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICYACEYp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC39277803;
	Wed,  9 Apr 2025 18:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224047; cv=none; b=qUM6wBJInVZD8z/kz1ZetCZU9m+4AiHahjdrAiNdlNHqicyRXukDNkCI5Nm5TMNMVpzzexHUmQ5T8UUDS7C2OMYZ734D9Lf355zkGJtDNs62ONseP19ZDNeV+95i9j7ea3/6cgsX++3s55RJgtVF8OrGg11DHMMnP4/DeiojzQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224047; c=relaxed/simple;
	bh=m2Ulz8Ki9eBeJga+EOBkc6Fy468i1ip8F/hipSFiAyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tEF1wUbyJ5ozvAAag92QjmjSrUyUFu0goW+UtFPqQkKAWf+dGT1X76VH60L2ugbYKPNHJ4TJDVK4M+meTo9tvkCwlAr8W7kThl0PqWykK/vHuJ1Yo1iqStoFO1h37DfwXIMjPf7VPe2Qm9sxVpoddr5jVtGRAToImoTaWkGTvtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICYACEYp; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-30384072398so5688545a91.0;
        Wed, 09 Apr 2025 11:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744224045; x=1744828845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2Ulz8Ki9eBeJga+EOBkc6Fy468i1ip8F/hipSFiAyU=;
        b=ICYACEYpZC9ZJBIuxoQnP7nNxdQYv7l0/dmNoegACY3Wc5JpKOr4bzYV0QD/EF8Aj+
         9cJgMKizoxHV3Zg1T26B0vRDCjqw9FCbO1Yz8i5ZkVZk3IkKa8Fv5S+9mVTUWWoo4Pk1
         QKyP+A7s7OvKT19j6kO9tOCz2VS4hXs/+DLRCcRZrJL/TiggfTSAbFDSkxNM7lwU/9MJ
         SI2IgKOFzKdT/N5sAStLtKTg6Ee9VfErURyuhbAIVoB8zHOV1lvTSjf2G0ZqhyTz2XB6
         BFzuHU1troKibTTbURZ6+u5KV/HM81DHW+FYrTdgWje/Daq1OLgrKE3x+5LirTllgMyg
         WCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224045; x=1744828845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2Ulz8Ki9eBeJga+EOBkc6Fy468i1ip8F/hipSFiAyU=;
        b=IIMZpvOGNB1qwmdmUmpsie2IbM6yRN4dEH/OG373ad6i4WJXKcrQLw30yMaQL0mNmO
         Jnek7GB46lN8+HCyeqwVLTcupFnK/V21mAObIC2aez6WzZfg7i07eWWWY2dIahr7D4Sm
         W6duAije+EJ5domK5mEy2pdb22O44zgIszDPHuhDQ/VJ7DrBBj1EJUzl1/GM6+zJ/Lzn
         hxya9OyifBbBjKuQBkhA9RTrazF8RcJ9CQYoZ5pjJ0+fM7HeZZ2xlXb9okbwunclY9ZU
         /zaY0rmmQNWe8o1U/yKjzdVMLH/8qecwaLQKhu2USdVhObGKS9+OqXuCSO0Cx7JddbFd
         muLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFOtZBhExvDVIDMgL6BjALuT+eNMmSVMJp+uUeNa/SiKtJ/PwAr4lzSN2n1CQ8HmLQAgXw3GVh@vger.kernel.org, AJvYcCVZGbaE4bgw95F5ML2xuEt0CyBiqsK7xef5ktG1+pko3bFAJAOxHWV4kt2zFuZD2LI250E=@vger.kernel.org
X-Gm-Message-State: AOJu0YynfRmUDs/uLwp1UkBbvfq6dJDw31ljhqYbDpi9YTL7sINFKMSR
	fRwBOsCjAlLgEqwmBuobhNMTmhGUxVmREAGdSpbm06y93gmYtpxEE9iha3/oqF4jRd821zIT8mN
	twX0dA/kAa01TM0dhwpXgfMkfhAw=
X-Gm-Gg: ASbGncuV62o4duKPXUAJT4tHvG0bpaWv947rUHQ1Q3reeGCYAYk8Zr8mQl6qtpYtN8y
	b0UDf3NYjPfeE6lkHfof6C/BId3fIXTBBsPmyxTt9VRTuHp4NIXWRW8ZeS8kjQQZ4j/co6ZCz5v
	B+2kGhcKyqG8xLK7tb6+n9I0FnjIAWaUoeeBvrHA==
X-Google-Smtp-Source: AGHT+IFgGD4BadLUwUSLvunFq8HV23HukOTTVXPByiDMIWE+sf7TYy7ZgEzlhdR7kYb9ydO24HIbRVQ4UwTZCBKpo70=
X-Received: by 2002:a17:90b:2b8b:b0:2ff:692b:b15 with SMTP id
 98e67ed59e1d1-3072ba1d28fmr23101a91.33.1744224044931; Wed, 09 Apr 2025
 11:40:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408195956.412733-1-kuba@kernel.org> <20250408195956.412733-6-kuba@kernel.org>
In-Reply-To: <20250408195956.412733-6-kuba@kernel.org>
From: Martin KaFai Lau <iamkafai@gmail.com>
Date: Wed, 9 Apr 2025 11:40:32 -0700
X-Gm-Features: ATxdqUE9YgnEktTrzKu_hre6xsqOnXo0xxTVttxs0w1EUsuzydb2fSyU6hBywxE
Message-ID: <CABx7vpXYCaUGzmqq7Y3Sx+KZ10mkhBKeyewEycSJcPH0Dq2YzA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/8] xdp: double protect netdev->xdp_flags
 with netdev->lock
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me, 
	hramamurthy@google.com, kuniyu@amazon.com, jdamato@fastly.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 1:01=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Protect xdp_features with netdev->lock. This way pure readers
> no longer have to take rtnl_lock to access the field.
>
> This includes calling NETDEV_XDP_FEAT_CHANGE under the lock.
> Looks like that's fine for bonding, the only "real" listener,
> it's the same as ethtool feature change.
>
> In terms of normal drivers - only GVE need special consideration
> (other drivers don't use instance lock or don't support XDP).
> It calls xdp_set_features_flag() helper from gve_init_priv() which
> in turn is called from gve_reset_recovery() (locked), or prior
> to netdev registration. So switch to _locked.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

