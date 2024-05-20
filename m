Return-Path: <bpf+bounces-30056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9D18CA404
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 23:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EA731C214F7
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 21:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DE413A271;
	Mon, 20 May 2024 21:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="MtbgeSPZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="MdKtQZ6u";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="losTusdQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783AA1386D5
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 21:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716241995; cv=none; b=KD8QxLtlWKTFH4d7gJhztcX3Wptv0FuyM+U4REoDGD1GPk6OXD5Ffp4rd6QReK+Ky1w8C0FVobsvzXG7hffQJx/mZV38drnsE5PhTWBjDb6YfJnOadD02Xqzl+M8L/gEuxAS8zBRYapBFZXF0CWpvBJCIKvpcdBBfYoMEeaTC5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716241995; c=relaxed/simple;
	bh=choxlXEvdS4Hhw4ocXb+73Vp9jW0fn9Sd0zJ9jDl4fo=;
	h=To:Date:Message-Id:MIME-Version:CC:Subject:Content-Type:From; b=IuDN1TVIhLme2QKOavQtdgU1vQ0k0/UZyq2qalkrd3XxJp/TqKt+eFOKmZcnfcG83GPgFyX8PlIZM7WiLWc4HZ9FOr7GInLn//nAjaPjTRc3FgMGogm/1I8DBZTIFFa8kjhGmfv3IaO5vdkjXWp2gQLOPj17R3tCPzXAfT6ttlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=MtbgeSPZ; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=MdKtQZ6u reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=losTusdQ reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id BA12FC18DBBF
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 14:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1716241992; bh=choxlXEvdS4Hhw4ocXb+73Vp9jW0fn9Sd0zJ9jDl4fo=;
	h=To:Date:CC:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=MtbgeSPZbn+xzaiITE3qXxIqK0wlFSALlMoQWVdtyH7qqOi0S3Ge1TyH9lQ5A6jtP
	 FaEbwuOsxOUzg2VsYVLLYJ2a5mLj7u8wslPnH3gyXKVvy6dxzvefHj9fB+evqkrDZS
	 gkuVCnuXXI29E/7UCSwNUwpIwW1P3xkRcJwVaNW0=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 96DFCC16943F
 for <bpf@vger.kernel.org>; Mon, 20 May 2024 14:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1716241992; bh=choxlXEvdS4Hhw4ocXb+73Vp9jW0fn9Sd0zJ9jDl4fo=;
 h=From:To:Date:CC:Subject:List-Id:List-Archive:List-Help:List-Owner:
 List-Post:List-Subscribe:List-Unsubscribe;
 b=MdKtQZ6ujiU/xCdWdIt1jnifmtiqPJPoJwQ1UZ4LhPpfQG7GIeyjvfaPkn3aQJKis
 MRPwt6D7RupQ64zE11uBmsNGOWlxw7gYZmCZxW11ZNhKhnTeknMaDj7vB/15fhHDWR
 i7rdX+De45EZv6zUbFB5OfGoOrgESygzxXLNTRsc=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 2F005C14F71E
 for <bpf@ietfa.amsl.com>; Mon, 20 May 2024 14:53:04 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.845
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id unxpZL3bM0uU for <bpf@ietfa.amsl.com>;
 Mon, 20 May 2024 14:53:00 -0700 (PDT)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 5539BC14F609
 for <bpf@ietf.org>; Mon, 20 May 2024 14:53:00 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1ee7963db64so21605215ad.1
 for <bpf@ietf.org>; Mon, 20 May 2024 14:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1716241979; x=1716846779;
 darn=ietf.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/vWskpXNzxNtnQzRVqcAY8ey1nFXzxi3crSbI25m+TA=;
 b=losTusdQfHC1wN1MbOYUODKU9P0j7m9iUyDMgIXnCu8xeHeGupKISf4C+N+DFtSNFN
 MFhLnt0htP6jOqoWsA8yiwqQ/4B4wDrO2lmNy/oR68O4CJx1l1eiMJq/mZn3MiwVQyoV
 0Rfz8nCG51KHZDGq7TcJKEum9RZiEISIZXAdIxiQP7WAqnO9EGGaJR3G7TJ0b5/RnvUk
 cYniKjZmImJbQa9wUsz042YPckVhdULM28SvFvADByn0nGA86q/yUifj2lQyTgDF9sKS
 0j7Li9he3r7JY3B3jEgisuKeBmr2g+DucyjHJBeg23WHouC6zwCD+PdOddmFd4NkihHh
 VKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716241979; x=1716846779;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/vWskpXNzxNtnQzRVqcAY8ey1nFXzxi3crSbI25m+TA=;
 b=L8BnHWh0AyxJJ7dtyI58CvJVQKqAhwbdVZbOjvpmGw0iNDkyrEf04iTQ8Var3o81Ic
 PsRUJtI/hxPwHQxxZqNDa6FY1CcfQ4UvHKlkcXMvtydYC2D8LbUwOLRMpBsaZbPk8iJ/
 giDa8p4/xninQgxNPmS3ZwW2reg2VAhKXCsO7XG7D5xRAKV4q8yNwctZr0DzOtjU8mWH
 EgHkZjuIg1iG9CzDsQfZRy2BikIi2/W93feDjJycB/5hAHfwgmiX1Jm2hIU4a6cDYxNo
 oK0WNbp3uTbJui922pHFDPybuPqZv71gwc9/j9TWc5D30vZvHWQx7pHw66aK04hSy97m
 9sLA==
X-Gm-Message-State: AOJu0YzbKSkrFK+huSNFSrlyfpfGxKGzPYZqYb61c2Gh56C3oWins9/C
 frK401ArP63HlaHSaHIBb5L+iCunpcmLmC6z2nC8YruPLdBYobtV
X-Google-Smtp-Source: AGHT+IEiOHXbwnlCTxA5hWZQFMd63KNQ995CsH4UziWHlnhPD88DXjoZHNxl6JhDZGymmc0LhoC9sQ==
X-Received: by 2002:a17:902:82ca:b0:1e6:116b:b0d3 with SMTP id
 d9443c01a7336-1ef43d2ec00mr343736645ad.28.1716241979567;
 Mon, 20 May 2024 14:52:59 -0700 (PDT)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0c138c04sm208265605ad.267.2024.05.20.14.52.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 May 2024 14:52:59 -0700 (PDT)
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Date: Mon, 20 May 2024 14:52:55 -0700
Message-Id: <20240520215255.10595-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID-Hash: NWGJVTEDF4PWPVZG35T6RXBPNCZ26626
X-Message-ID-Hash: NWGJVTEDF4PWPVZG35T6RXBPNCZ26626
X-MailFrom: dthaler1968@googlemail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia; 
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>,
 Dave Thaler <dthaler1968@googlemail.com>
X-Mailman-Version: 3.3.9rc4
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_=5BPATCH_bpf-next_v2=5D_bpf=2C_docs=3A_clarify_sign_exte?=
 =?utf-8?q?nsion_of_64-bit_use_of_32-bit_imm?=
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/0n7nSlGJAi-bxxvoMQ05K8iNxKw>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Original-From: Dave Thaler <dthaler1968@googlemail.com>
From: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>

aW1tIGlzIGRlZmluZWQgYXMgYSAzMi1iaXQgc2lnbmVkIGludGVnZXIuDQoNCntNT1YsIEssIEFM
VTY0fSBzYXlzIGl0IGRvZXMgImRzdCA9IHNyYyIgKHdoZXJlIHNyYyBpcyAnaW1tJykgYW5kIGl0
DQpkb2VzIGRvIGRzdCA9IChzNjQpaW1tLCB3aGljaCBpbiB0aGF0IHNlbnNlIGRvZXMgc2lnbiBl
eHRlbmQgaW1tLiBUaGUgTU9WU1gNCmluc3RydWN0aW9uIGlzIGV4cGxhaW5lZCBhcyBzaWduIGV4
dGVuZGluZywgc28gYWRkZWQgdGhlIGV4YW1wbGUgb2YNCntNT1YsIEssIEFMVTY0fSB0byBtYWtl
IHRoaXMgbW9yZSBjbGVhci4NCg0Ke0pMRSwgSywgSk1QfSBzYXlzIGl0IGRvZXMgIlBDICs9IG9m
ZnNldCBpZiBkc3QgPD0gc3JjIiAod2hlcmUgc3JjIGlzICdpbW0nLA0KYW5kIHRoZSBjb21wYXJp
c29uIGlzIHVuc2lnbmVkKS4gVGhpcyB3YXMgYXBwYXJlbnRseSBhbWJpZ3VvdXMgdG8gc29tZQ0K
cmVhZGVycyBhcyB0byB3aGV0aGVyIHRoZSBjb21wYXJpc29uIHdhcyAiZHN0IDw9ICh1NjQpKHUz
MilpbW0iIG9yDQoiZHN0IDw9ICh1NjQpKHM2NClpbW0iIHNvIGFkZGVkIGFuIGV4YW1wbGUgdG8g
bWFrZSB0aGlzIG1vcmUgY2xlYXIuDQoNCnYxIC0+IHYyOiBBZGRyZXNzIGNvbW1lbnRzIGZyb20g
WW9uZ2hvbmcNCg0KU2lnbmVkLW9mZi1ieTogRGF2ZSBUaGFsZXIgPGR0aGFsZXIxOTY4QGdvb2ds
ZW1haWwuY29tPg0KLS0tDQogLi4uL2JwZi9zdGFuZGFyZGl6YXRpb24vaW5zdHJ1Y3Rpb24tc2V0
LnJzdCAgICAgfCAxNyArKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNl
cnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2JwZi9zdGFuZGFyZGl6YXRp
b24vaW5zdHJ1Y3Rpb24tc2V0LnJzdCBiL0RvY3VtZW50YXRpb24vYnBmL3N0YW5kYXJkaXphdGlv
bi9pbnN0cnVjdGlvbi1zZXQucnN0DQppbmRleCA5OTc1NjBhYmEuLjdiYjEyODFjNSAxMDA2NDQN
Ci0tLSBhL0RvY3VtZW50YXRpb24vYnBmL3N0YW5kYXJkaXphdGlvbi9pbnN0cnVjdGlvbi1zZXQu
cnN0DQorKysgYi9Eb2N1bWVudGF0aW9uL2JwZi9zdGFuZGFyZGl6YXRpb24vaW5zdHJ1Y3Rpb24t
c2V0LnJzdA0KQEAgLTM4NSw2ICszODUsMTkgQEAgVGhlIGBgTU9WU1hgYCBpbnN0cnVjdGlvbiBk
b2VzIGEgbW92ZSBvcGVyYXRpb24gd2l0aCBzaWduIGV4dGVuc2lvbi4NCiBvcGVyYW5kcyBpbnRv
IDY0LWJpdCBvcGVyYW5kcy4gIFVubGlrZSBvdGhlciBhcml0aG1ldGljIGluc3RydWN0aW9ucywN
CiBgYE1PVlNYYGAgaXMgb25seSBkZWZpbmVkIGZvciByZWdpc3RlciBzb3VyY2Ugb3BlcmFuZHMg
KGBgWGBgKS4NCiANCitgYHtNT1YsIEssIEFMVTY0fWBgIG1lYW5zOjoNCisNCisgIGRzdCA9IChz
NjQpaW1tDQorDQorYGB7TU9WLCBYLCBBTFV9YGAgbWVhbnM6Og0KKw0KKyAgZHN0ID0gKHUzMilz
cmMNCisNCitgYHtNT1ZTWCwgWCwgQUxVfWBgIHdpdGggJ29mZnNldCcgOCBtZWFuczo6DQorDQor
ICBkc3QgPSAodTMyKShzMzIpKHM4KXNyYw0KKw0KKw0KIFRoZSBgYE5FR2BgIGluc3RydWN0aW9u
IGlzIG9ubHkgZGVmaW5lZCB3aGVuIHRoZSBzb3VyY2UgYml0IGlzIGNsZWFyDQogKGBgS2BgKS4N
CiANCkBAIC00ODYsNiArNDk5LDEwIEBAIEV4YW1wbGU6DQogDQogd2hlcmUgJ3M+PScgaW5kaWNh
dGVzIGEgc2lnbmVkICc+PScgY29tcGFyaXNvbi4NCiANCitgYHtKTEUsIEssIEpNUH1gYCBtZWFu
czo6DQorDQorICBpZiBkc3QgPD0gKHU2NCkoczY0KWltbSBnb3RvICtvZmZzZXQNCisNCiBgYHtK
QSwgSywgSk1QMzJ9YGAgbWVhbnM6Og0KIA0KICAgZ290b2wgK2ltbQ0KLS0gDQoyLjQwLjENCg0K
LS0gCkJwZiBtYWlsaW5nIGxpc3QgLS0gYnBmQGlldGYub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQg
YW4gZW1haWwgdG8gYnBmLWxlYXZlQGlldGYub3JnCg==

