Return-Path: <bpf+bounces-21433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE85884D37C
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 22:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4861C246C6
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 21:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58346127B64;
	Wed,  7 Feb 2024 21:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="EAHDGRXm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="EAHDGRXm"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E927412838E
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 21:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340149; cv=none; b=BH0Vn6o5du0HH8jF3YNS//tH4mvtm+2qzFV9wFi7o76xDGiHnLmF031bxy4NyGVyVaTQG9wxRXnnAtYHTpR2OXYUttQ6faZ7FaIDBHHfHuB8XBYZRhGK+W5uOzK8geg0sNL1Z93T/oTAhjn3sySdO50L+YnQa10/2Uht0miqeXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340149; c=relaxed/simple;
	bh=R+JjRHIuNDcmYIzilAK1qtNBe/0ehi1HJZ9kQHKuMHY=;
	h=Date:From:To:Cc:Message-ID:MIME-Version:Subject:Content-Type; b=GFdcAOveJALRarxIsMPdB4vFxX+uqLKVbX7OsBXd8qssXdXgN46mwdhZou3DvPH8YeuNVSDplXRajIcGSS6M1KQcc8Vxw4c9zkcv81azu1eKyHcS1sR8TcLzNnMje68xt1+2BYulRMd+ZtQNbIY0TpNZmvGISjtDqRq2JmdFSBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=EAHDGRXm; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=EAHDGRXm; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 455D4C14CE44
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 13:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1707340146; bh=R+JjRHIuNDcmYIzilAK1qtNBe/0ehi1HJZ9kQHKuMHY=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=EAHDGRXmfBxtDm2hVu0rYVegjcugBlqT2IiHt2H0oe9K1BE2gZXF5s2LpuqdcQ6nl
	 ZuQ9cBDqSL8CrHBaF6wQ7XsaWqnGiyfl/+sFGq4nEHjefAcNtwSaW0OLgtYsrud+SI
	 OzpoDOZ2R4VCCIKDQIHpsW6Pqcqv/6tBurzMvIY8=
X-Mailbox-Line: From bpf-bounces@ietf.org  Wed Feb  7 13:09:06 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 15AEFC14CEFE;
	Wed,  7 Feb 2024 13:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1707340146; bh=R+JjRHIuNDcmYIzilAK1qtNBe/0ehi1HJZ9kQHKuMHY=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=EAHDGRXmfBxtDm2hVu0rYVegjcugBlqT2IiHt2H0oe9K1BE2gZXF5s2LpuqdcQ6nl
	 ZuQ9cBDqSL8CrHBaF6wQ7XsaWqnGiyfl/+sFGq4nEHjefAcNtwSaW0OLgtYsrud+SI
	 OzpoDOZ2R4VCCIKDQIHpsW6Pqcqv/6tBurzMvIY8=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id D620FC14CEFE
 for <bpf@ietfa.amsl.com>; Wed,  7 Feb 2024 13:09:04 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -6.41
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XzIahLvVs4QL for <bpf@ietfa.amsl.com>;
 Wed,  7 Feb 2024 13:09:04 -0800 (PST)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 4A280C14F6AC
 for <bpf@ietf.org>; Wed,  7 Feb 2024 13:09:04 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id
 5614622812f47-3be78c26850so682328b6e.0
 for <bpf@ietf.org>; Wed, 07 Feb 2024 13:09:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707340143; x=1707944943;
 h=user-agent:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vLGf9XjL3DdNWjhnzmGmZ29RinAxja/8JX39P5DiD/8=;
 b=ZIM6VyRftOraXBPomlhJlYSg6dfrWqCpMbDXh4cS+9Vf7Q3n+ab41MQTbCYoNTDpot
 Ns0qoG7kfgjBjycmkrQl591zrqUuJmXZCLldbo44FPeFVqA8sDrL87Cd3oRa82Co/kPJ
 uADO4Q1m8Yyio4mA4Lq8erjLrP7Lm1JyI38bvBYidDWDxhOCqybMpULlR1JBanTEsyle
 oqgI3v8d0KE0iFURdiT5pzmAiTB9tCuF1yRJM3w+YmiGWq9syQcuaZkZkankt16/H4Be
 vvmJLJ+G4mn/IoVolU+GEKaeBLG35woIY2JJt0esmsKmZBcNcB0PpFekJ68jby9EGECH
 w/6Q==
X-Gm-Message-State: AOJu0YwncvCLm+Z1qwr8pX5J/fHQ5N878Mi71caXL+QRBCFl2/uju3O5
 9mLwrb9MFPKKOhMDJM0h8FZrtkddvaXCsg7Nl5gvlZ594dakDjXpI53Xu/lENRw=
X-Google-Smtp-Source: AGHT+IFbC0/Hlrl9UFG7hPOi7T/gc6pfIgAr+Nf2yo07xw2KUILAvOM+t7WmmjDSb3rKPKlWJLN4wA==
X-Received: by 2002:a05:6808:1688:b0:3bd:a8a3:7237 with SMTP id
 bb8-20020a056808168800b003bda8a37237mr7278689oib.10.1707340143044; 
 Wed, 07 Feb 2024 13:09:03 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVUjsbKcHTXvcGBt7mgPOoa02M7g44L/Hqgm/ZMRFbYaCesJCdsoPlY9H/yySKS6JTpLlQuY5xRAGlE/TYoXgV9p7DMD4c59Gdtxt4U9L1N6PtYntofb2mZ9OH5KA==
Received: from maniforge.lan (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
 by smtp.gmail.com with ESMTPSA id
 v19-20020ac87493000000b0042c218eff34sm855634qtq.70.2024.02.07.13.09.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 13:09:02 -0800 (PST)
Date: Wed, 7 Feb 2024 15:09:00 -0600
From: David Vernet <void@manifault.com>
To: bpf@ietf.org
Cc: bpf@vger.kernel.org, Erik Kline <ek.ietf@gmail.com>,
 Suresh Krishnan <suresh.krishnan@gmail.com>
Message-ID: <20240207210900.GA2087153@maniforge.lan>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mutt/2.2.12 (2023-09-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/6pJCj9ujMA5ffb0yKv6DrIOzXOo>
Subject: [Bpf] IETF 119 Call for Agenda Items
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============9047710845408671481=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


--===============9047710845408671481==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NY07BRAt1nW1FVXY"
Content-Disposition: inline


--NY07BRAt1nW1FVXY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

The BPF working group will be holding a meeting at IETF 119 in a two hour time
slot. The chairs are in the process of setting the agenda. We would like to
solicit agenda items that would be of interest to the WG participants with a
preference to the items that address the topics of interest covered by the
charter. Please send us your request(s) for slots to bpf-chairs@ietf.org,
detailing:

* Topic and presenter info
* Name of associated draft (if any)
* Requested slot duration

Thanks
Suresh and David

--NY07BRAt1nW1FVXY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZcPxbAAKCRBZ5LhpZcTz
ZDiOAQCWNirpw2d3pmQXmK5GnVEz44TCU2RP+h+xzCbhWA4rdwEA9opTFl975Tzf
YbS5nvBxV1KbGs6IaGF0+grD5G/7oA0=
=0Pb1
-----END PGP SIGNATURE-----

--NY07BRAt1nW1FVXY--


--===============9047710845408671481==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============9047710845408671481==--


