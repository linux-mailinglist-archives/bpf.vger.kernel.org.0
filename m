Return-Path: <bpf+bounces-30060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3158CA4F0
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 01:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55E99281DA7
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 23:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03EF481CD;
	Mon, 20 May 2024 23:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="ugKp4PUc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="ugKp4PUc"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D95B3D3BC
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 23:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716247128; cv=none; b=H2YY5be+21vImEkwYXU0DUVpVyYDeueXx+OM/nv+IUsGs7rjmfta6++m0kjL8OugDUemXfFLd2sicTBIRmDDRaETBaYS9Mw+u5XmNVYi9b6QWW9pKOpDnQ1eaZyhZt3hklwEAe60xLafsKl0AaBIu7jSfhMD3d14flYmzin0sRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716247128; c=relaxed/simple;
	bh=e/VMKR0iS+POli58PXWS+zSjq60nQTFP1p+5EAPF6zs=;
	h=Date:From:To:Message-ID:References:MIME-Version:In-Reply-To:CC:
	 Subject:Content-Type; b=r4bB5ySYpkNgkDRGlV8y/FMd4hR9YoW8tiIzkrWTpaEyT9yZZvhiPmeoIY42Moo31XZrfyJskQHjyfsfRoPCPMWmaE4Jc/RngRbTxZBj1IdrOWTwVxvxWI0JsOWRux/rGt/79o4UyBnuTsrvHJ9mfF8+9kSs8eL4FUy32QunuDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=ugKp4PUc; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=ugKp4PUc; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id E8352C1CAF3B
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 16:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1716247125; bh=e/VMKR0iS+POli58PXWS+zSjq60nQTFP1p+5EAPF6zs=;
	h=Date:From:To:References:In-Reply-To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=ugKp4PUc3mAE8YgYWsduP3dRXSIBHQYrjS4/mO6fYOvsVQMyK8QnnkyRXC1jY80vq
	 tfnRqfnLj3gULy+MutyYjUlUYchT/9EE4xRcizGin+ovimtUavAB326ZYq7aOwWJ1H
	 4ZIklbdyNiREs1sjrnu8VO7K+6p1/H1wQKexPvgw=
X-Mailbox-Line: From bpf-bounces+bpf=vger.kernel.org@ietf.org  Mon May 20 16:18:45 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id D0C1DC1CAF3C
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 16:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1716247125; bh=e/VMKR0iS+POli58PXWS+zSjq60nQTFP1p+5EAPF6zs=;
	h=Date:From:To:References:In-Reply-To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=ugKp4PUc3mAE8YgYWsduP3dRXSIBHQYrjS4/mO6fYOvsVQMyK8QnnkyRXC1jY80vq
	 tfnRqfnLj3gULy+MutyYjUlUYchT/9EE4xRcizGin+ovimtUavAB326ZYq7aOwWJ1H
	 4ZIklbdyNiREs1sjrnu8VO7K+6p1/H1wQKexPvgw=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
	by ietfa.amsl.com (Postfix) with ESMTP id 1170AC1CAF35
	for <bpf@ietfa.amsl.com>; Mon, 20 May 2024 16:18:37 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.646
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
	by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ooAqS0uiyqwt for <bpf@ietfa.amsl.com>;
	Mon, 20 May 2024 16:18:35 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256)
	(No client certificate requested)
	by ietfa.amsl.com (Postfix) with ESMTPS id F31F0C1C3D70
	for <bpf@ietf.org>; Mon, 20 May 2024 16:18:34 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-43df23e034cso29598021cf.0
        for <bpf@ietf.org>; Mon, 20 May 2024 16:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716247114; x=1716851914;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kUqc4wSdLpnCjuNLhKWLrdKDKKNiFfKFYw1o3HNF77A=;
        b=GgHFJ9nUsWGA2YscskwyapFKPj4FZ9VVUq8cQEgrUWCL918Z9UdzDdXMTH/vL8WQJq
         rPAgF/BHgTpBNSs6SA3pJrI9LcvoZoT4Sedlfz1JLf1nGuviWzcTTOK2PP7jDmPRT15A
         LLNYzgEyB3fJdiTHyGQPyaaaA2mj0i24TRxoi7d9e3SKi0GwrDULZqvgutb+SLKEEsko
         UQjv7C0Mk5N1ZPZYag1P62NesstirES7z3zmusZ6N9Ras6XWpgcH7s0W3ITwG4Ir2ZKg
         8HefcM9ux4IHxCRgGqTnHmX2erk9YcmBN3Cq92pGt4bp64AaiMi5H0ZcaqC1CufvibI2
         Aerw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWV9SCj0nzjCiuRgQRR8P/eE0RBVY5PihzZTanie4M55qA7cAu1XCbVw3ra/euUokllEsxUbz1PyApWrSo=
X-Gm-Message-State: AOJu0Yxd2nbDbeC7acjAGu6VXIF9Yoby1UnY2peTtuB0MjSVYMje8eCH
	SDJvhSbMqBtohUdYz8+sXMUXi9U76jEEXC4HCgvMsXpevK+QM+n7
X-Google-Smtp-Source: 
 AGHT+IHpmMGWcnB8KO/+DZP9KczQN171J6UBUIucH5+w7M14R9ULkMNx/8ORoWyb9Mffkt8zNLcbYA==
X-Received: by 2002:a05:6214:4808:b0:6aa:2697:2747 with SMTP id
 6a1803df08f44-6aa26973847mr78998536d6.13.1716247113757;
        Mon, 20 May 2024 16:18:33 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
        by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a93a73a4besm23230906d6.99.2024.05.20.16.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 16:18:33 -0700 (PDT)
Date: Mon, 20 May 2024 18:18:29 -0500
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Message-ID: <20240520231829.GC1116559@maniforge>
References: <20240517165855.4688-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240517165855.4688-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)
Message-ID-Hash: 7IONCXKFI5DII5Q4MTXANTXII5KTLWQ5
X-Message-ID-Hash: 7IONCXKFI5DII5Q4MTXANTXII5KTLWQ5
X-MailFrom: dcvernet@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia;
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
X-Mailman-Version: 3.3.9rc4
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_=5BPATCH_bpf-next=5D_bpf=2C_docs=3A_Use_RFC_2119_l?=
 =?utf-8?q?anguage_for_ISA_requirements?=
Archived-At: 
 <https://mailarchive.ietf.org/arch/msg/bpf/bRLyawTEh6Dc5PRg_RaDQaoRYGw>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: multipart/mixed; boundary="===============4183454722442434038=="


--===============4183454722442434038==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YOkmkFmqSH7Tl1oq"
Content-Disposition: inline


--YOkmkFmqSH7Tl1oq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 09:58:55AM -0700, Dave Thaler wrote:
> Per IETF convention and discussion at LSF/MM/BPF, use MUST etc.
> keywords as requested by IETF Area Director review.  Also as
> requested, indicate that documenting BTF is out of scope of this
> document and will be covered by a separate IETF specification.
>=20
> Added paragraph about the terminology that is required IETF boilerplate
> and must be worded exactly as such.
>=20
> Signed-off-by: Dave Thaler <dthaler1968@googlemail.com>

Acked-by: David Vernet <void@manifault.com>

We still have "may" in a couple of places, as in e.g.:

Note that there are two flavors of ``JA`` instructions. The ``JMP``
class permits a 16-bit jump offset specified by the 'offset' field,
whereas the ``JMP32`` class permits a 32-bit jump offset specified by
the 'imm' field. A > 16-bit conditional jump may be converted to a <
16-bit conditional jump plus a 32-bit unconditional jump.

Also in the "Helper functions" and "Maps" sections.

Do we need to fix those as well? Or are they considered semantically
different than how RFC 2119 would define the terms?

Thanks,
David

--YOkmkFmqSH7Tl1oq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZkvaRQAKCRBZ5LhpZcTz
ZPiWAP4juqPoXiDzaTMmnyCqgJbSAjhwr/p2C+mXZrbefsmlXQEA/RFCnTeneiKz
racIp8x5MDJDumrlDO4Y3SIZeyEbIgY=
=xG1k
-----END PGP SIGNATURE-----

--YOkmkFmqSH7Tl1oq--


--===============4183454722442434038==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

LS0gCkJwZiBtYWlsaW5nIGxpc3QgLS0gYnBmQGlldGYub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQg
YW4gZW1haWwgdG8gYnBmLWxlYXZlQGlldGYub3JnCg==

--===============4183454722442434038==--


