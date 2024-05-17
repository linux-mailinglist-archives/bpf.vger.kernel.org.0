Return-Path: <bpf+bounces-29958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 810AB8C89E7
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 18:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4D51F25E96
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 16:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB2212FB18;
	Fri, 17 May 2024 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="B+Df7mFI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="ocvFJgbp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="TkGb5dzN"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1321141C68
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 16:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715962662; cv=none; b=uOhVQVb8vgJQumxDcrjvRHErUM+pZQlXQ+6xk71myfFyyNN9gYXpYpcT1i/W1wDSGXUsrOMD0LQZi9MZsVdGwIxnlO5Xi/I/8YGmAdyM897N8bR+dxeI0DlXzw8tihde0EgKYk8PCcn9DiHFgWKFpkJRTRajkCXgg42VlljIFYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715962662; c=relaxed/simple;
	bh=iVSFTyBeDmuC2JF02tEYKejZo+7DkbivdG/DU4R68wQ=;
	h=To:Date:Message-Id:MIME-Version:CC:Subject:Content-Type:From; b=t0F73gc0FBoe7tjRyQrRDH2FeKuzPFlMjF6K3/w3UwoKT0k/a8sWdp0whs1rp3JepZJe+WVNrOZ9CDxZRTkmN3zKHzljLX6J4X5XBIzryqjuF/HP6WWV0XvZM1RMJfR9cQ5SFwvlV05v9WWZugjBfkv4BZ2At1J/lP07nJg6Ayg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=B+Df7mFI; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=ocvFJgbp reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=TkGb5dzN reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 879BBC180B60
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 09:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1715962660; bh=iVSFTyBeDmuC2JF02tEYKejZo+7DkbivdG/DU4R68wQ=;
	h=To:Date:CC:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=B+Df7mFIXBsAdmuYqBQMKGh8cLSZdB5hiHpTFLMOXqx/rftQrEdpP6yrCN8C84Bww
	 T+lNq+GuJ2A7BB9xAK0oWQJQUP7+yqbN7GOkDEQmdA6/nZxz1yl7eBKGI1hO0wEWRh
	 yGPKjBVH2VBD1V9YB6Bl1EpOnAOSSPiwTd0XcpKg=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 6DDE8C1519B4
 for <bpf@vger.kernel.org>; Fri, 17 May 2024 09:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1715962660; bh=iVSFTyBeDmuC2JF02tEYKejZo+7DkbivdG/DU4R68wQ=;
 h=From:To:Date:CC:Subject:List-Id:List-Archive:List-Help:List-Owner:
 List-Post:List-Subscribe:List-Unsubscribe;
 b=ocvFJgbp+BTxFAQS7P03FbX5pr7rCTzB2NvhSnwJysJf0dC4g07RQyCY5i2E2riao
 2QTzHL8x7qVt5o9KPjT2Xb8PuBx69s2a1pfl4wrZ/CTxCnr8inJ31cPWF0qjnf2QXQ
 8ccSnNS/TB1o69enwlZTybj8PE2rh4tafE2F/zZI=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 022A5C16941E
 for <bpf@ietfa.amsl.com>; Fri, 17 May 2024 09:16:24 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.845
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z2DHU_l1ZJ5e for <bpf@ietfa.amsl.com>;
 Fri, 17 May 2024 09:16:19 -0700 (PDT)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 56C35C14F6EA
 for <bpf@ietf.org>; Fri, 17 May 2024 09:16:19 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1ed41eb3382so13013755ad.0
 for <bpf@ietf.org>; Fri, 17 May 2024 09:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1715962578; x=1716567378;
 darn=ietf.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7armfeLAXQsQMrjI6vgVSTIgmnXDgZlGhC1Cl43yCcA=;
 b=TkGb5dzN+qBBXOTuDyjCALfAaYhaQs69Kkrlq9r6KwUfuLG0AcQFxcgbi/SaNDHXxQ
 MZhLdypFHPE1FyjfogQzmibvSEid+8r7hp0tCAjuedirGqCuVt0HWHdk/yl04LDdW4Zp
 26mPnFK2H3IhwTX1AyoNeiIHgrF04VVB8R0yR4bYnqtIheQCKGK5VCOBOoCUvwXGn/Hb
 Um5a4A1PwNuMLjmHmtxpxZVCfPihNHVv3MKK8QY1kGMWNiI8+BHi4u4WBQn9sS+tbxQF
 U3hsQRreD/LQUcjifi/l5C9M//c6TAgIoNkTtxPL8Av7V5pzHF4oOgReSrJmIMzw+Me7
 1beA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715962578; x=1716567378;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7armfeLAXQsQMrjI6vgVSTIgmnXDgZlGhC1Cl43yCcA=;
 b=AXZ3rEgIjP1kiy7CKC9erODyV2G4/h1llpHmF2Wlcu3oLvnIyBrhFELDN6FhKEormu
 DSnzOys2Xv/xDgdEl1uZ3TgtmDlN6Vuzcvb3jlbWUYb8o2U7xANG/1XM7BEIF3p7fdLK
 yOXQPQxfYYxQ08uzNGYe+PGpA/ZMLNvXvJybXJX1IKnzvsRyqoEebqFlmhFFguq20Vd2
 UjTv2GIVe7KuTODoXZfdztgM+6N7GrdyGiXKYeylCmKPxRFg4W3NcXiEx/9YLM5uqLWW
 OcU1FB2Yj7r23sRTXWJL3xYC+sm3/jtou3TxSp6yhDrT4O1AERySPXkglk0roV6pSEqX
 Yx4A==
X-Gm-Message-State: AOJu0YyN++U1r8rq35GXT8C015VB7ISEUFW8/IZqcTIg7tdTP+bMO3vX
 D7lLEx3SiSmUtmk8IGOykbYm0NECRikc92KsYXhBHH4EvVRJjq3eJ+GNAg==
X-Google-Smtp-Source: AGHT+IELgdG7dj3psWg2I6LwndPnLGU73+zzMKxqQ0QkyQOw8zjQDpy6DpP2Wg52aAuohVDSevg3kw==
X-Received: by 2002:a17:90a:fb4d:b0:2b1:50:cad4 with SMTP id
 98e67ed59e1d1-2b6cc450329mr24365693a91.1.1715962578510;
 Fri, 17 May 2024 09:16:18 -0700 (PDT)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bd47ba8c2dsm2300933a91.27.2024.05.17.09.16.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 May 2024 09:16:18 -0700 (PDT)
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Date: Fri, 17 May 2024 09:16:12 -0700
Message-Id: <20240517161612.4385-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID-Hash: NK7KKO5CZK4RDBH4H4V4DBG52754B5GW
X-Message-ID-Hash: NK7KKO5CZK4RDBH4H4V4DBG52754B5GW
X-MailFrom: dthaler1968@googlemail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia; 
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>,
 Dave Thaler <dthaler1968@googlemail.com>
X-Mailman-Version: 3.3.9rc4
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_=5BPATCH_bpf-next=5D_bpf=2C_docs=3A_clarify_sign_extensi?=
 =?utf-8?q?on_of_64-bit_use_of_32-bit_imm?=
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/hdq2f6aJWKIkx8f6GI8oLI87QMY>
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
VTY0fSBzYXlzIGl0IGRvZXMgImRzdCA9IHNyYyIgKHdoZXJlIHNyYyBpcyAnaW1tJykgYnV0IGl0
IGRvZXMNCm5vdCBzaWduIGV4dGVuZCwgYnV0IGluc3RlYWQgZG9lcyBkc3QgPSAodTMyKXNyYy4g
IFRoZSAiSnVtcCBpbnN0cnVjdGlvbnMiDQpzZWN0aW9uIGhhcyAidW5zaWduZWQiIGJ5IHNvbWUg
aW5zdHJ1Y3Rpb25zLCBidXQgdGhlICJBcml0aG1ldGljIGluc3RydWN0aW9ucyINCnNlY3Rpb24g
aGFzIG5vIHN1Y2ggbm90ZSBhYm91dCB0aGUgTU9WIGluc3RydWN0aW9uLCBzbyBhZGRlZCBhbiBl
eGFtcGxlIHRvDQptYWtlIHRoaXMgbW9yZSBjbGVhci4NCg0Ke0pMRSwgSywgSk1QfSBzYXlzIGl0
IGRvZXMgIlBDICs9IG9mZnNldCBpZiBkc3QgPD0gc3JjIiAod2hlcmUgc3JjIGlzICdpbW0nLA0K
YW5kIHRoZSBjb21wYXJpc29uIGlzIHVuc2lnbmVkKS4gVGhpcyB3YXMgYXBwYXJlbnRseSBhbWJp
Z3VvdXMgdG8gc29tZQ0KcmVhZGVycyBhcyB0byB3aGV0aGVyIHRoZSBjb21wYXJpc29uIHdhcyAi
ZHN0IDw9ICh1NjQpKHUzMilpbW0iIG9yDQoiZHN0IDw9ICh1NjQpKHM2NClpbW0iLCBzaW5jZSB0
aGUgY29ycmVjdCBhc3N1bXB0aW9uIHdvdWxkIGJlIHRoZSBsYXR0ZXINCmV4Y2VwdCB0aGF0IHRo
ZSBNT1YgaW5zdHJ1Y3Rpb24gZG9lc24ndCBmb2xsb3cgdGhhdCwgc28gYWRkZWQgYW4gZXhhbXBs
ZQ0KdG8gbWFrZSB0aGlzIG1vcmUgY2xlYXIuDQoNClNpZ25lZC1vZmYtYnk6IERhdmUgVGhhbGVy
IDxkdGhhbGVyMTk2OEBnb29nbGVtYWlsLmNvbT4NCi0tLQ0KIC4uLi9icGYvc3RhbmRhcmRpemF0
aW9uL2luc3RydWN0aW9uLXNldC5yc3QgICAgICAgfCAxNSArKysrKysrKysrKysrKy0NCiAxIGZp
bGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi9icGYvc3RhbmRhcmRpemF0aW9uL2luc3RydWN0aW9uLXNldC5yc3Qg
Yi9Eb2N1bWVudGF0aW9uL2JwZi9zdGFuZGFyZGl6YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJzdA0K
aW5kZXggOTk3NTYwYWJhLi5mOTZlYmIxNjkgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2Jw
Zi9zdGFuZGFyZGl6YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJzdA0KKysrIGIvRG9jdW1lbnRhdGlv
bi9icGYvc3RhbmRhcmRpemF0aW9uL2luc3RydWN0aW9uLXNldC5yc3QNCkBAIC0zNzgsMTMgKzM3
OCwyMiBAQCBldGMuIFRoaXMgc3BlY2lmaWNhdGlvbiByZXF1aXJlcyB0aGF0IHNpZ25lZCBtb2R1
bG8gdXNlIHRydW5jYXRlZCBkaXZpc2lvbg0KIA0KICAgIGEgJSBuID0gYSAtIG4gKiB0cnVuYyhh
IC8gbikNCiANCi1UaGUgYGBNT1ZTWGBgIGluc3RydWN0aW9uIGRvZXMgYSBtb3ZlIG9wZXJhdGlv
biB3aXRoIHNpZ24gZXh0ZW5zaW9uLg0KK1RoZSBgYE1PVmBgIGluc3RydWN0aW9uIGRvZXMgYSBt
b3ZlIG9wZXJhdGlvbiB3aXRob3V0IHNpZ24gZXh0ZW5zaW9uLCB3aGVyZWFzDQordGhlIGBgTU9W
U1hgYCBpbnN0cnVjdGlvbiBkb2VzIGEgbW92ZSBvcGVyYXRpb24gd2l0aCBzaWduIGV4dGVuc2lv
bi4NCiBgYHtNT1ZTWCwgWCwgQUxVfWBgIDp0ZXJtOmBzaWduIGV4dGVuZHM8U2lnbiBFeHRlbmQ+
YCA4LWJpdCBhbmQgMTYtYml0IG9wZXJhbmRzIGludG8NCiAzMi1iaXQgb3BlcmFuZHMsIGFuZCB6
ZXJvZXMgdGhlIHJlbWFpbmluZyB1cHBlciAzMiBiaXRzLg0KIGBge01PVlNYLCBYLCBBTFU2NH1g
YCA6dGVybTpgc2lnbiBleHRlbmRzPFNpZ24gRXh0ZW5kPmAgOC1iaXQsIDE2LWJpdCwgYW5kIDMy
LWJpdA0KIG9wZXJhbmRzIGludG8gNjQtYml0IG9wZXJhbmRzLiAgVW5saWtlIG90aGVyIGFyaXRo
bWV0aWMgaW5zdHJ1Y3Rpb25zLA0KIGBgTU9WU1hgYCBpcyBvbmx5IGRlZmluZWQgZm9yIHJlZ2lz
dGVyIHNvdXJjZSBvcGVyYW5kcyAoYGBYYGApLg0KIA0KK2Bge01PViwgSywgQUxVfWBgIG1lYW5z
OjoNCisNCisgIGRzdCA9ICh1MzIpIGltbQ0KKw0KK2Bge01PVlNYLCBYLCBBTFV9YGAgd2l0aCAn
b2Zmc2V0JyAzMiBtZWFuczo6DQorDQorICBkc3QgPSAoczMyKSBzcmMNCisNCiBUaGUgYGBORUdg
YCBpbnN0cnVjdGlvbiBpcyBvbmx5IGRlZmluZWQgd2hlbiB0aGUgc291cmNlIGJpdCBpcyBjbGVh
cg0KIChgYEtgYCkuDQogDQpAQCAtNDg2LDYgKzQ5NSwxMCBAQCBFeGFtcGxlOg0KIA0KIHdoZXJl
ICdzPj0nIGluZGljYXRlcyBhIHNpZ25lZCAnPj0nIGNvbXBhcmlzb24uDQogDQorYGB7SkxFLCBL
LCBKTVB9YGAgbWVhbnM6Og0KKw0KKyAgaWYgZHN0IDw9ICh1NjQpKHM2NClpbW0gZ290byArb2Zm
c2V0DQorDQogYGB7SkEsIEssIEpNUDMyfWBgIG1lYW5zOjoNCiANCiAgIGdvdG9sICtpbW0NCi0t
IA0KMi40MC4xDQoNCi0tIApCcGYgbWFpbGluZyBsaXN0IC0tIGJwZkBpZXRmLm9yZwpUbyB1bnN1
YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGJwZi1sZWF2ZUBpZXRmLm9yZwo=

