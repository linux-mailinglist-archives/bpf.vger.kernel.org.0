Return-Path: <bpf+bounces-30324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F0A8CC639
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 20:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16D528207B
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 18:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEE8144D02;
	Wed, 22 May 2024 18:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="TiG2Tpgi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="TiG2Tpgi"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FCD1BF40
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 18:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716402123; cv=none; b=jpYPBQWu0iqGRcm8nnSKVaPyXEs4JHPJY+sAYKnfE9tSxORh25WtzMifh1Ct4ApexPD4jGWlZlP6QjooY+jw77HxEnPuEJnmZH9wjkGUH5ZoWcz3epbz1G+uT+pw4+tR0t2zY1k9iBx5byYbaj4uV5VBaMURbvmWIW4y/GjPhKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716402123; c=relaxed/simple;
	bh=aBIyfBcTJeG5P4MoiljG/55DB9QZdPxmAU8PTPidDz8=;
	h=Date:From:To:Message-ID:References:MIME-Version:In-Reply-To:CC:
	 Subject:Content-Type; b=FhfpuJSDWosi2RU8QqPol8KO9h8iVL53I/eBsGsPx8zBpbYtyPHa8iqnGAcEt7Fcdu8+pkP/pnyj7zB6g/62d7kDLfh9CoAQWxPhctl+uK6wQEa0GggUvc5Z8/vhmjRWMOKR5RYUsJIruXRTxppkd5oHMyeNP+gAl9HYPlqa9Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=TiG2Tpgi; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=TiG2Tpgi; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 9A17BC1D4CCE
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 11:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1716402121; bh=aBIyfBcTJeG5P4MoiljG/55DB9QZdPxmAU8PTPidDz8=;
	h=Date:From:To:References:In-Reply-To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=TiG2TpgimpcBfA1uLVBtKCYVFhD+KVbfn8OavRQNKcYnFlR6qIUq4lXrUSggeJrw0
	 efK3hAXV0s7QolG6jpu7mDZwT6pAJwmsYgAQApPMTXEAZqlB+cDOv3GLDGyc9d0pbw
	 ElTDbJHGJGG0wP7zJ8BRrhgj4wlaRyH5qpLDy1R4=
X-Mailbox-Line: From bpf-bounces+bpf=vger.kernel.org@ietf.org  Wed May 22 11:22:01 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 8ACD7C1CAF28
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 11:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1716402121; bh=aBIyfBcTJeG5P4MoiljG/55DB9QZdPxmAU8PTPidDz8=;
	h=Date:From:To:References:In-Reply-To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=TiG2TpgimpcBfA1uLVBtKCYVFhD+KVbfn8OavRQNKcYnFlR6qIUq4lXrUSggeJrw0
	 efK3hAXV0s7QolG6jpu7mDZwT6pAJwmsYgAQApPMTXEAZqlB+cDOv3GLDGyc9d0pbw
	 ElTDbJHGJGG0wP7zJ8BRrhgj4wlaRyH5qpLDy1R4=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
	by ietfa.amsl.com (Postfix) with ESMTP id 1E0CAC180B6A
	for <bpf@ietfa.amsl.com>; Wed, 22 May 2024 11:21:36 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -6.649
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
	by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GdO-ep08NxWf for <bpf@ietfa.amsl.com>;
	Wed, 22 May 2024 11:21:35 -0700 (PDT)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256)
	(No client certificate requested)
	by ietfa.amsl.com (Postfix) with ESMTPS id 7F2FBC1519B1
	for <bpf@ietf.org>; Wed, 22 May 2024 11:21:35 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-7930531494aso113466285a.0
        for <bpf@ietf.org>; Wed, 22 May 2024 11:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716402094; x=1717006894;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ko5WsgRc5I9vEWJbi0+a+Fs851AshJz1K+UozTOt1Is=;
        b=NCSwXDZthOUhLG9HB2EknCRT0XmPhg/SLKe5yc9yIrLMaK879JRMHCHwDuJChJV9ip
         yqJ3SkE5hIFSvhxReh8fEKo/itNk8SZKwaRQmTq+Wb1WfbG3ZYiyfcfcUIeyqPyaeWJx
         vVAIr++cFQnXbxUfv9l7EtovTPZVQoCOCTMvgW6NpEMPU//liXyV+h6+xRMsr+5HmPMp
         DRBeQNYg9LGZ3ayJBkln+La60GLbvfXTKpSxULWn3ebvnmkhIcXq5c9zcJhkqqPVOYPc
         rJF2K4YSl+0AAGfQzbBv++oMkbyX9AMOKYWxD4Bjkj3SOHqihJQITVzTnzvu8wN9a1G4
         IZ0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiTQjtXmI5PviS6fiPTTNeISF5VXPfMEHj33iCIGzZRrhpsqhGwQ/yOnMfNz+nFohRDrB+KCPoZ1b6UKM=
X-Gm-Message-State: AOJu0Yw5ilgBU7qgzOlOaoYAD4fQF0lxDp3k5Jv3Wpgt5LC3aiI6KTQZ
	zY4BYFBqFXkw58OCpTcpZukbWK85CNi+0hX1BZwxdX/ewAQI0gJv
X-Google-Smtp-Source: 
 AGHT+IFYxeNiB8g6QFxEj7wJcUYAxoIhRHKYsm7YN0Sa6xDSgrw0pOUycThO5PmaPK6z4JWNSkGEUQ==
X-Received: by 2002:a05:620a:55ae:b0:792:741b:3a27 with SMTP id
 af79cd13be357-794994b60f4mr302103885a.53.1716402094092;
        Wed, 22 May 2024 11:21:34 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
        by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf310bc3sm1419500485a.99.2024.05.22.11.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 11:21:33 -0700 (PDT)
Date: Wed, 22 May 2024 13:21:31 -0500
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Message-ID: <20240522182131.GA41164@maniforge>
References: <20240520215255.10595-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240520215255.10595-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)
Message-ID-Hash: WWXIHE3I4QMNI7WAD7UNMDATZ6SNT7WP
X-Message-ID-Hash: WWXIHE3I4QMNI7WAD7UNMDATZ6SNT7WP
X-MailFrom: dcvernet@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia;
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
X-Mailman-Version: 3.3.9rc4
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_=5BPATCH_bpf-next_v2=5D_bpf=2C_docs=3A_clarify_sig?=
 =?utf-8?q?n_extension_of_64-bit_use_of_32-bit_imm?=
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: multipart/mixed; boundary="===============4205246454581227923=="


--===============4205246454581227923==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="efIhC89kt0lWJZM8"
Content-Disposition: inline


--efIhC89kt0lWJZM8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 02:52:55PM -0700, Dave Thaler wrote:
> imm is defined as a 32-bit signed integer.
>=20
> {MOV, K, ALU64} says it does "dst =3D src" (where src is 'imm') and it
> does do dst =3D (s64)imm, which in that sense does sign extend imm. The M=
OVSX
> instruction is explained as sign extending, so added the example of
> {MOV, K, ALU64} to make this more clear.
>=20
> {JLE, K, JMP} says it does "PC +=3D offset if dst <=3D src" (where src is=
 'imm',
> and the comparison is unsigned). This was apparently ambiguous to some
> readers as to whether the comparison was "dst <=3D (u64)(u32)imm" or
> "dst <=3D (u64)(s64)imm" so added an example to make this more clear.
>=20
> v1 -> v2: Address comments from Yonghong
>=20
> Signed-off-by: Dave Thaler <dthaler1968@googlemail.com>

Acked-by: David Vernet <void@manifault.com>

--efIhC89kt0lWJZM8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZk43qwAKCRBZ5LhpZcTz
ZAVwAP0QevFkqXGOT8QtAEdQfzTlozxFu4FCnoTP3coMnGphwQEAvt0ZVubRouOs
vsUXVCiw9Ah1AF9w7Ux9zskyuVMyzQ8=
=Qjps
-----END PGP SIGNATURE-----

--efIhC89kt0lWJZM8--


--===============4205246454581227923==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

LS0gCkJwZiBtYWlsaW5nIGxpc3QgLS0gYnBmQGlldGYub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQg
YW4gZW1haWwgdG8gYnBmLWxlYXZlQGlldGYub3JnCg==

--===============4205246454581227923==--


