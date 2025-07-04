Return-Path: <bpf+bounces-62448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7208AF9BF7
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 23:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C72C21C874E3
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 21:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245EB239E9E;
	Fri,  4 Jul 2025 21:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqguSjDP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AA1217F56;
	Fri,  4 Jul 2025 21:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751664482; cv=none; b=pn9m9uMqcE6lFiybJq9vvk99nzkiqG/r+TFAwmC+Y1iJKWaSr7/uTTvNqg/sZwk0Pv7IfI3ZX0KmP6Ol1vgNEHaxuUMp8IFfDWnqFbXPBqgnuBObieZB0Nf+OoCpDCf5vuk5jRfvpSLxIU+z4Pd0dOpFArnsEQPIE2ATHhEFMk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751664482; c=relaxed/simple;
	bh=Hi7Ma97EhiJia6SDb6ekeqld+ewzhpjYKC+3RRNZXxY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kTeYnD3G1QrgjvMOFQAlCmwFDzuoT7zy8dLE0yF6fUHxmP5+M2sqHErvUybPeERH3QFweSRrjZKj2Yln297CW/Ga0r+pZ2gHLbEDhu5esxm/1BXU63dRe/NzRlI4V8ytqhpYHfGWZJtZD77+qbi85s8KLMZie7nP5+hs1Uo4fJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqguSjDP; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-234c5b57557so12464515ad.3;
        Fri, 04 Jul 2025 14:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751664480; x=1752269280; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hi7Ma97EhiJia6SDb6ekeqld+ewzhpjYKC+3RRNZXxY=;
        b=AqguSjDPgdsr1gz4peTvwpvktrsF417d+YTKk5KJQBZmBAF1zZGZZ9VOFisx09sKdJ
         A8kdIUm24wOO3E5ngQO3BJSXYxzqYmcPIZefVrqhH408r5uifjCQu50Jb0DVcRysiC5G
         feXCsrAAdLpsMnzpEoUzrrH8bBenyEdc1GiZIq9DMHlEs+mtuU3svnx2v0KsGSnBMfEH
         qP+ehPv1orgfiPd5GYMLYvPhGxMmY2RRth0r9QdD4N6KH2yX5EGirCq1yShLLTIKHD/S
         lrmPn6Zq1OIWjUsGpzleZtrtR/oxoUD/zA5J/u+/ccCCCfIqVZwQ88if2LMG+kNB+qpD
         ZdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751664480; x=1752269280;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hi7Ma97EhiJia6SDb6ekeqld+ewzhpjYKC+3RRNZXxY=;
        b=Ce1GahJyMs0Mkgm2duvUrDpQBUUoOP5VyeYuofJ2ajR7HDECDEjwLIr6FzmPSa4xOF
         /W73Ze/kx8e4GXm2ZWxyISK28fKKZ2lBxFD2/sABClw/Cvkj2zeuJksVT/S8c3xGPvdb
         2l9Pf5h5YXeddV2Y2Sa/XaveVjSxBcpnU6bHNyHswU9Qt593BwxLSCh6Z/IbhNqbkJne
         wEIWjaUR+UOm5MACV/BZ+2FGUG6HOowIZXOf/T1Dve+dit93tK68ll2DBXrJ/T1wyoQB
         +0v2CFyuubLG8DGo9IBuDumW24DlAjv2NKYfl/gI2zo1U0yWAGDyIt4uZfUc8f/k0luX
         mp+w==
X-Forwarded-Encrypted: i=1; AJvYcCUNyxcNxuKiIVJD1B06PNiNZtRNVpjljaItvDSf3LwDck5i1xeAdXRNd8wXzglLdS+RI8g6Vij7@vger.kernel.org, AJvYcCUkif6l9sHsRQEXoR4gFLOm4mnnKYP9wo4TIQqxw9X/vF8bmz9FAND1FTjzFsmXUw/Yc+Y=@vger.kernel.org, AJvYcCVy6tbWx2ZiJe2yq8qqF7aKqSEddT5HmgDjsuh85CBi9zzoS/ptXaB8NIFAoGFsumDek7u7Uc18z5vi9EtB@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4WbcIH9T7pJxVSfclBWUzA5mnAKSQxpSbGALDQYDnPop4r6ky
	aZj27sDuZKbp7E2OYhD955vPtQXm2x7/wjWGIcsJfhaUM55dK5VnOV+h
X-Gm-Gg: ASbGncu2uKkiujFQ+d9EB1oMjNYTfqtWiwXwV681654cWfc54nGYLkqAdeWXjizCiQa
	r4Ug31MrEsxGCGi1PLHDMKgr611NnwwDyZTC6mR+DWt1EDaPviTeM5tgKpzyyTuA7RCv3U4qZXV
	e+cl9PG0zoSk3uo8TzMDqJM4S4F0Akh4nevNfbDuITciImq8vIEYHiwVgX2MSy2v6so186dOgXS
	ICpguF3gtalodr3bh/6QVedtK2FXJM1nKBm4Ks1KYEHSBgKWlT9rqfgRzuFLJXdecxyfg8vnYQo
	bKa1b1O11rj53ushqL0lyswI1pECWz32F8tqN6/D6OI7a6tRFQh4Pycihw==
X-Google-Smtp-Source: AGHT+IE9p7oqFc2ZfPMQ9fnWDUmB9GVJSNcMDyZHu2ytyB4sHzoWGYA0fuXPgGp5d+J9h7JS55t43w==
X-Received: by 2002:a17:902:f78a:b0:234:bfcb:5bfa with SMTP id d9443c01a7336-23c85de488emr54208885ad.15.1751664480522;
        Fri, 04 Jul 2025 14:28:00 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455dafcsm27271255ad.96.2025.07.04.14.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 14:28:00 -0700 (PDT)
Message-ID: <c794309d89d0ffb49d891d7b600831abbfa4dc65.camel@gmail.com>
Subject: Re: [syzbot] [bpf?] WARNING in reg_bounds_sanity_check
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: syzbot <syzbot+c711ce17dd78e5d4fdcf@syzkaller.appspotmail.com>, 
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, 	linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, netdev@vger.kernel.org, 	sdf@fomichev.me,
 song@kernel.org, syzkaller-bugs@googlegroups.com, 	yonghong.song@linux.dev
Date: Fri, 04 Jul 2025 14:27:58 -0700
In-Reply-To: <e43c25b451395edff0886201ad3358acd9670eda.camel@gmail.com>
References: <68649190.a70a0220.3b7e22.20e8.GAE@google.com>
			 <aGa3iOI1IgGuPDYV@Tunnel>
			 <865f2345eaa61afbd26d9de0917e3b1d887c647d.camel@gmail.com>
			 <aGgL_g3wA2w3yRrG@mail.gmail.com>
		 <df2cdc5f4fa16a4e3e08e6a997af3722f3673d38.camel@gmail.com>
	 <e43c25b451395edff0886201ad3358acd9670eda.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-07-04 at 14:13 -0700, Eduard Zingerman wrote:

[...]

> I think the mask can be computed as in or_range() function at the
> bottom of the email. This gives the following algorithm, if only
> unsigned range is considered:
>=20
> - assume prediction is needed for "if a & b goto ..."
> - bits that may be set in 'a' are or_range(a_min, a_max)
> - bits that may be set in 'b' are or_range(b_min, b_max)
> - if computed bit masks intersect: both branches are possible
> - otherwise only false branch is possible.
>=20
> Wdyt?

This does not help with problem at hand, however.
Possible bits set for range [0x1, 0xff] are 0xff,
so there would be no prediction.

