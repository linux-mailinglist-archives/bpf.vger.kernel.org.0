Return-Path: <bpf+bounces-47121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A859F4AAB
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 13:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFE33189079C
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 12:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460A41F1917;
	Tue, 17 Dec 2024 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KR2MrwCN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5291E5708;
	Tue, 17 Dec 2024 12:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734437404; cv=none; b=WVcfBgGgmNjYYu7DQRwMa/GWKqAogxnl3lkQESooQ7O3F5sc16+Kaenl9R+RoRpzYC5zKpviX5WDYxcwVp7ctIc7D60va0U87yylvNCr3ZldErBNuU0dgkMaL6sIvblps6gvYB17xzCETTWoxdKLeS4akumDTdSbYuuts+hQKMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734437404; c=relaxed/simple;
	bh=gac8ql6ts3lihvjphPVIhS+Eq+RhAv3kl8wQtvQ4ZdU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YXOd6RLPvoQnKXc0VqFbVpgQEb02FU6mO4jDuS6PR7MXgtwyJwPW+SID7sdipgH5Sfchl8OAmuzTzLK+f4aossAtaGB0vlv4PGee2MaOhEX9D5VOCt8QR4FXQQD6c+MBA3fCeIdFIT5DuFk7WwUwOosBDOGy3E4YTRkK1xPXdQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KR2MrwCN; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2156e078563so38966675ad.2;
        Tue, 17 Dec 2024 04:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734437402; x=1735042202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gk0oaVX4f1jnLyQuTOGkGWyylI3KWC0+6v2HjUrWfmw=;
        b=KR2MrwCNrA+5DELt3AAiA1Moua4cQCVnKu17Ct7YEeNvdN6slLtPozhrkR9CV4zAFY
         Im9qSLEh2z3UDNDbBa80agWM2hYxFlNgLCVsoOsbfYXtNZklvTkKextxM2wz82+e85Gq
         fz2NRhCC+7jkAn0Kal0ZM2m2BxUhEIZWxTrdQ5I0Tr/hH0XvRNzoJFaxXOgB3CkeYcJk
         Mq3dhPdCsVlDUQtrwdanJIySWf1zRZ2T/4NIz0QIcxXAp4VNmuFQM4WnTJDY+Q2rGNp0
         Y14Po+BwB5gDsCfJSwFIOQS1Ztpfr5aIDWYtafIDGwbG7zn8Iz48V8VHZsB8YvL6Urgu
         FCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734437402; x=1735042202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gk0oaVX4f1jnLyQuTOGkGWyylI3KWC0+6v2HjUrWfmw=;
        b=maBSLg72yF8tQEw38OtpGbQGvz3fdFu5ya3yiDNn2BzYpaDO0oC8MwNzjKy/XCQhgr
         Ic1kMnnJRDz8AyKWeFG0Gx6q5nCE2dqoIwsoLYdikQ9XOcD9PZfIu3wWSe02ZE8Detpg
         Jszdf5oUXHcG50qdpuecQFpk12vrN7Xg17d5av3UL4mAbPQT5EX+38UJfVwiJV4z7bWz
         BOf1rD9r6i/PCbTJcckDlL5nOMV7YSysBsDzuL5t7jo5A8fHG1l2NfX5y5TEQ8Zmp9X3
         c5TjUh1EyhE7mOlcQidpIKg58WUc3DtcaWwfBJfCt0dYQ16yTTBnFXAYWmo/hA71juzA
         0TOg==
X-Forwarded-Encrypted: i=1; AJvYcCUKBOXGRz1hrzESi9svY9OyxnBbmnIeuDEhyeLOiNbQmZjyRrXMIyTVGrQMvRE+dXjBtfs=@vger.kernel.org, AJvYcCVqnRJTgtZbcQ6PYqToX2OcPWj3qo6YMjUJMIlTeyM81+A8erbE82UOxPiK7kYTUOWPKiUxIf6z@vger.kernel.org, AJvYcCWued9O/I79Kgr0rmItO5u7PxWIzse7eqfWx3iDi4TjxjWLIxtJaCPNAoo8tuty7sqibiUMA7ZKWV/zlw8c@vger.kernel.org
X-Gm-Message-State: AOJu0YzNFNpXArWh8OnuA96KN3nnWQadFhJwst7qlHlc2DUJde1Vrlbj
	N4wlmURr0s/sfVeyIiJIfgxcrGeDrwIvOgK26V1BYYZrv5aSRlNo
X-Gm-Gg: ASbGncsRuF3R8v1iSNMBHul9+vivMVHCTybqIcLSow/xJcGylan71IsBRI2Iz0Qo4Mp
	D8ways4WGEfXg6u5/lZFTRlLdhMewCwPJjWvT90Hzm+teO+BSl0WW8xxcZ256wjkaNhtbeyAYL0
	ke7x/D2Oy1JwftZ6ANU6iUY9CaH4A35hCK3Wuv+Ps3GuTcJYmidAyQzj9U/bDEsTOWEyd3A/lL7
	lrsktQuCIwu7zFPOYKHRJi1XAekbDrOPHrkUZacRgr8JEGhysxUmg==
X-Google-Smtp-Source: AGHT+IH172+O5cWLAzm88+O1nCTzfqDJrh1eXruu2g9IjpXWXMeav1TOvKMsGfuPjCK0wT7Vfh2AJQ==
X-Received: by 2002:a17:903:234d:b0:216:70b6:8723 with SMTP id d9443c01a7336-21892a5440cmr215041055ad.44.1734437402485;
        Tue, 17 Dec 2024 04:10:02 -0800 (PST)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e50299sm58486205ad.143.2024.12.17.04.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 04:10:02 -0800 (PST)
Date: Tue, 17 Dec 2024 20:09:52 +0800
From: Furong Xu <0x1207@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH iwl-next 6/9] igc: Add support for frame preemption
 verification
Message-ID: <20241217200952.000059f2@gmail.com>
In-Reply-To: <20241217002254.lyakuia32jbnva46@skbuf>
References: <20241216064720.931522-1-faizal.abdul.rahim@linux.intel.com>
	<20241216064720.931522-1-faizal.abdul.rahim@linux.intel.com>
	<20241216064720.931522-7-faizal.abdul.rahim@linux.intel.com>
	<20241216064720.931522-7-faizal.abdul.rahim@linux.intel.com>
	<20241217002254.lyakuia32jbnva46@skbuf>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Dec 2024 02:22:54 +0200, Vladimir Oltean <olteanv@gmail.com> wrote:

> Anyway, while browsing through this software implementation of a
> verification process, I cannot help but think we'd be making a huge
> mistake to allow each driver to reimplement it on its own. We just
> recently got stmmac to do something fairly clean, with the help and
> great perseverence of Furong Xu (now copied).
> 
> I spent a bit of time extracting stmmac's core logic and putting it in
> ethtool. If Furong had such good will so as to regression-test the
> attached patch, do you think you could use this as a starting place
> instead, and implement some ops and call some library methods, instead
> of writing the entire logic yourself?
> 

I am quiet busy these days, especially near the end of the year :)

Maybe I can help testing the attached patch when the next time net-next opens.

Thanks.

