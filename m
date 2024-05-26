Return-Path: <bpf+bounces-30607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2732C8CF2A7
	for <lists+bpf@lfdr.de>; Sun, 26 May 2024 08:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D31E72813E4
	for <lists+bpf@lfdr.de>; Sun, 26 May 2024 06:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72B9184D;
	Sun, 26 May 2024 06:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="XPpf5e8L";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="HsmAH9k2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RxtabZIm"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DE71849
	for <bpf@vger.kernel.org>; Sun, 26 May 2024 06:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716704311; cv=none; b=ShffBQTuv3ImIOguovqkZ7FhHrbti7AZVJvP6fNHkq9IQA8JjbHk+xGgFZSLChF5jAloKaZLe2zoPDaOLg2EaLrduh+zP+AVfaOOTS3fguKT7jTriOtCnV4BY8MM1Y2jVHzi1ljJCfq/QHBEG1SFINkyxlMQurE/CFBgiXmoOYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716704311; c=relaxed/simple;
	bh=kGc2gm0DR8116T9X4/409Xio4YbZqaCS5xbanFzWa4o=;
	h=To:Date:Message-Id:MIME-Version:CC:Subject:Content-Type:From; b=iT21qMJO2u4KRZuhJhxfOLdwQtXxmN5+LMNNyvB8dXyGHiKn4QmhW21dQLSHnmSoEAMkPvyburjeG8Rp0DEGkds1Y4qGKKuiPhDNx/JJSkLffPi3Tinqpzw4rIiYhg9J2k37S+K5MTySFtJW2RGpSL4LwkUBJ6IZkcAiJ9W/BVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=XPpf5e8L; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=HsmAH9k2 reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=RxtabZIm reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id E7812C14CF1D
	for <bpf@vger.kernel.org>; Sat, 25 May 2024 23:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1716704308; bh=kGc2gm0DR8116T9X4/409Xio4YbZqaCS5xbanFzWa4o=;
	h=To:Date:CC:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=XPpf5e8L5tc5aPixXTaQYRoyqQzSWq63/NZy2krv7u1zmZA9wF7/JWtuBcFmigy3n
	 ahhUsuatcQcVmVQEulBLMXk+dWkn2XT/dDYACvMnVqoHv/IK9D3Le1EP6wHjT7YXj9
	 JRFSkRJM98QSMgiIME6wl/tql77SH9UgLGLWGnxI=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id CC7EAC14CEFE
 for <bpf@vger.kernel.org>; Sat, 25 May 2024 23:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1716704308; bh=kGc2gm0DR8116T9X4/409Xio4YbZqaCS5xbanFzWa4o=;
 h=From:To:Date:CC:Subject:List-Id:List-Archive:List-Help:List-Owner:
 List-Post:List-Subscribe:List-Unsubscribe;
 b=HsmAH9k2KgnBOnVyfHGrfJiUovOXWmwh3PnY/RXpdtsh3KObWHddYoXiEgYL2qnmL
 L1CRzDKEwh4W4VMtKCP/gMFcmA5wAmpJ9xOpHara4G35Ot8dD3XXraWnGxtbElOGSQ
 eIkSK1Mtb9cMlvXOH+MX4PNsccyj7ynVABtRrbWE=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id BC8F2C14F700
 for <bpf@ietfa.amsl.com>; Sat, 25 May 2024 23:18:23 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.845
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ykIFZrs9gOyv for <bpf@ietfa.amsl.com>;
 Sat, 25 May 2024 23:18:19 -0700 (PDT)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id E8C45C14F6F3
 for <bpf@ietf.org>; Sat, 25 May 2024 23:18:19 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6f8f34cb0beso1568004b3a.1
 for <bpf@ietf.org>; Sat, 25 May 2024 23:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1716704299; x=1717309099;
 darn=ietf.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VOdcBgu9Aq5+isa9I4zoSOyXomOsAMJXMKaz27e1n4k=;
 b=RxtabZImUxtnu7d+kYcVrk3Y8qTowbZ/ztIsK0Q2bk6ZeDQKjc8O3bRP3kf+yB2A2B
 ZIFrJOsS6g7iyaavHVU5u7BMGJQoBDnbV47CB3pXYiuEwJPe3u/8frfkQf6a/lFvFj8W
 EVhngVIINI4kVK7bynoR12jJi1CgYU2d0yDspzV1+bcGWt/pGVZ2UWzE/HbB2Z3umJ13
 u5gym+oTB2SEvKpkmwrkeaUQLkSNCgsCj0HMK2YUKQ1BIDT6D/QHdvlY1PX78B9CJzFb
 QBmL7r9ghkvTdDGW7Vdz5Fm0Njr7wZZcX/tbaQnAszD9YLCnQAi7LwRkwuv7Ussv3/Yv
 uLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716704299; x=1717309099;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VOdcBgu9Aq5+isa9I4zoSOyXomOsAMJXMKaz27e1n4k=;
 b=O/qE4o7CTxApTSfZQvK4CWXbqELMsxEyrvrndSGZm5Asj8pRhuKG7Q7ru/fkYhGcO/
 NWxVpaS7gI5mv9Qd5TT2LNvQR/Cfv3Js+TSGtr7lTcF+3P4BqrkXUop3FKKBGuSbSji8
 SsmoEulahnR2qnG9+ox9yBOSraPlAC042tpp6wJ9wOQpbMSVriC10bP6aC1TeeZeD0rS
 ifV+fauJM9VmGN+f3/dDauOqyHRTypOYX80ZPwVxvTUCCu5wFuHoEgJ0ZWzm4WrHSHi2
 ia3PvXWTpZ9+m4t2ioyTA/cE3ji38HGScnthstGvonq5SvWJy/J9D/yXX9T4ZMt6u0C0
 bMEQ==
X-Gm-Message-State: AOJu0YxUejhDQgwofzYLyNS3azWP0PQMPiQlXxuKwcKHVBaxi9bK3h9d
 pK528CCd0xyBJWZV8plV9lZPedX62ycANwOx+NJw1vmEfWKt+dYi
X-Google-Smtp-Source: AGHT+IFPMeGSuOxnLNcuF2GZoyt6oel7eXZq227r8N+xreUb5az0JouP+12c3YkY6KXYyni0yZgTTg==
X-Received: by 2002:a17:902:da8a:b0:1f3:3b0:61a7 with SMTP id
 d9443c01a7336-1f339f0b3c7mr121684405ad.12.1716704298855;
 Sat, 25 May 2024 23:18:18 -0700 (PDT)
Received: from localhost.localdomain (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c7d42a7sm39763975ad.117.2024.05.25.23.18.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 May 2024 23:18:18 -0700 (PDT)
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Date: Sat, 25 May 2024 23:18:15 -0700
Message-Id: <20240526061815.22497-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID-Hash: ALB5JVYGOB77WIMNGHHDSPSLDTCCIIPL
X-Message-ID-Hash: ALB5JVYGOB77WIMNGHHDSPSLDTCCIIPL
X-MailFrom: dthaler1968@googlemail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia; 
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
X-Mailman-Version: 3.3.9rc4
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_=5BPATCH_bpf-next=5D_bpf=2C_docs=3A_Fix_instruction=2Ers?=
 =?utf-8?q?t_indentation?=
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/P_AeRgHrfQ1RG7UpapDn6kKTaRg>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Original-From: Dave Thaler <dthaler1968@googlemail.com>
From: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>

VGhlIHRhYmxlIGNhcHRpb25zIHBhdGNoIGNvcnJlY3RlZCBpbmRlbnRlZCBtb3N0IHRhYmxlcyB0
byB3b3JrIHdpdGgNCnRoZSB0YWJsZSBkaXJlY3RpdmUgZm9yIGFkZGluZyBhIGNhcHRpb24gYnV0
IG1pc3NlZCB0d28gb2YgdGhlbS4NCg0KU2lnbmVkLW9mZi1ieTogRGF2ZSBUaGFsZXIgPGR0aGFs
ZXIxOTY4QGdtYWlsLmNvbT4NCi0tLQ0KIC4uLi9icGYvc3RhbmRhcmRpemF0aW9uL2luc3RydWN0
aW9uLXNldC5yc3QgICB8IDI2ICsrKysrKysrKy0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwg
MTMgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVu
dGF0aW9uL2JwZi9zdGFuZGFyZGl6YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJzdCBiL0RvY3VtZW50
YXRpb24vYnBmL3N0YW5kYXJkaXphdGlvbi9pbnN0cnVjdGlvbi1zZXQucnN0DQppbmRleCAwOGY2
MTRiMTAuLjhkMTk4MTA1MCAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vYnBmL3N0YW5kYXJk
aXphdGlvbi9pbnN0cnVjdGlvbi1zZXQucnN0DQorKysgYi9Eb2N1bWVudGF0aW9uL2JwZi9zdGFu
ZGFyZGl6YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJzdA0KQEAgLTI5NiwxMiArMjk2LDEyIEBAIEZv
ciBhcml0aG1ldGljIGFuZCBqdW1wIGluc3RydWN0aW9ucyAoYGBBTFVgYCwgYGBBTFU2NGBgLCBg
YEpNUGBgIGFuZA0KIA0KICAgLi4gdGFibGU6OiBTb3VyY2Ugb3BlcmFuZCBsb2NhdGlvbg0KIA0K
LSAgPT09PT09ICA9PT09PSAgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQ0KLSAgc291cmNlICB2YWx1ZSAgZGVzY3JpcHRpb24NCi0gID09PT09PSAgPT09PT0g
ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCi0gIEsgICAg
ICAgMCAgICAgIHVzZSAzMi1iaXQgJ2ltbScgdmFsdWUgYXMgc291cmNlIG9wZXJhbmQNCi0gIFgg
ICAgICAgMSAgICAgIHVzZSAnc3JjX3JlZycgcmVnaXN0ZXIgdmFsdWUgYXMgc291cmNlIG9wZXJh
bmQNCi0gID09PT09PSAgPT09PT0gID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT0NCisgICAgPT09PT09ICA9PT09PSAgPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQ0KKyAgICBzb3VyY2UgIHZhbHVlICBkZXNjcmlwdGlvbg0K
KyAgICA9PT09PT0gID09PT09ICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09DQorICAgIEsgICAgICAgMCAgICAgIHVzZSAzMi1iaXQgJ2ltbScgdmFsdWUgYXMg
c291cmNlIG9wZXJhbmQNCisgICAgWCAgICAgICAxICAgICAgdXNlICdzcmNfcmVnJyByZWdpc3Rl
ciB2YWx1ZSBhcyBzb3VyY2Ugb3BlcmFuZA0KKyAgICA9PT09PT0gID09PT09ICA9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQogDQogKippbnN0cnVjdGlvbiBj
bGFzcyoqDQogICB0aGUgaW5zdHJ1Y3Rpb24gY2xhc3MgKHNlZSBgSW5zdHJ1Y3Rpb24gY2xhc3Nl
c2BfKQ0KQEAgLTY4MSwxMyArNjgxLDEzIEBAIHR3byBjb21wbGV4IGF0b21pYyBvcGVyYXRpb25z
Og0KIA0KIC4uIHRhYmxlOjogQ29tcGxleCBhdG9taWMgb3BlcmF0aW9ucw0KIA0KLT09PT09PT09
PT09ICA9PT09PT09PT09PT09PT09ICA9PT09PT09PT09PT09PT09PT09PT09PT09PT0NCi1pbW0g
ICAgICAgICAgdmFsdWUgICAgICAgICAgICAgZGVzY3JpcHRpb24NCi09PT09PT09PT09PSAgPT09
PT09PT09PT09PT09PSAgPT09PT09PT09PT09PT09PT09PT09PT09PT09DQotRkVUQ0ggICAgICAg
IDB4MDEgICAgICAgICAgICAgIG1vZGlmaWVyOiByZXR1cm4gb2xkIHZhbHVlDQotWENIRyAgICAg
ICAgIDB4ZTAgfCBGRVRDSCAgICAgIGF0b21pYyBleGNoYW5nZQ0KLUNNUFhDSEcgICAgICAweGYw
IHwgRkVUQ0ggICAgICBhdG9taWMgY29tcGFyZSBhbmQgZXhjaGFuZ2UNCi09PT09PT09PT09PSAg
PT09PT09PT09PT09PT09PSAgPT09PT09PT09PT09PT09PT09PT09PT09PT09DQorICA9PT09PT09
PT09PSAgPT09PT09PT09PT09PT09PSAgPT09PT09PT09PT09PT09PT09PT09PT09PT09DQorICBp
bW0gICAgICAgICAgdmFsdWUgICAgICAgICAgICAgZGVzY3JpcHRpb24NCisgID09PT09PT09PT09
ICA9PT09PT09PT09PT09PT09ICA9PT09PT09PT09PT09PT09PT09PT09PT09PT0NCisgIEZFVENI
ICAgICAgICAweDAxICAgICAgICAgICAgICBtb2RpZmllcjogcmV0dXJuIG9sZCB2YWx1ZQ0KKyAg
WENIRyAgICAgICAgIDB4ZTAgfCBGRVRDSCAgICAgIGF0b21pYyBleGNoYW5nZQ0KKyAgQ01QWENI
RyAgICAgIDB4ZjAgfCBGRVRDSCAgICAgIGF0b21pYyBjb21wYXJlIGFuZCBleGNoYW5nZQ0KKyAg
PT09PT09PT09PT0gID09PT09PT09PT09PT09PT0gID09PT09PT09PT09PT09PT09PT09PT09PT09
PQ0KIA0KIFRoZSBgYEZFVENIYGAgbW9kaWZpZXIgaXMgb3B0aW9uYWwgZm9yIHNpbXBsZSBhdG9t
aWMgb3BlcmF0aW9ucywgYW5kDQogYWx3YXlzIHNldCBmb3IgdGhlIGNvbXBsZXggYXRvbWljIG9w
ZXJhdGlvbnMuICBJZiB0aGUgYGBGRVRDSGBgIGZsYWcNCi0tIA0KMi40MC4xDQoNCi0tIApCcGYg
bWFpbGluZyBsaXN0IC0tIGJwZkBpZXRmLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWls
IHRvIGJwZi1sZWF2ZUBpZXRmLm9yZwo=

