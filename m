Return-Path: <bpf+bounces-39583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E07D9749FC
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 07:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 870BC1F26921
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 05:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6F66F2FD;
	Wed, 11 Sep 2024 05:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="rijKneC/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="rijKneC/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="iZBfKWOU"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC45A37171
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 05:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726034259; cv=none; b=ogkOE1Avwc2nNH6nmNteKF8LyBAzZbSaMbuw7OYoNobHUiFpeLDAfrDilNg6WkLz5AEWWTZ6KolNzWyS8Zit9l4eJxzMc1Pt8X0hvNs+Ff+k+hllgItCl6yWGFaEjclVrcy5FTGOy7YppF2Mo2uScCn0GcTZEBKqv3tv8ZnjJ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726034259; c=relaxed/simple;
	bh=FQs3i+NI97L9kxsfDiszgO/vX5t3NWmJsYjKNV82LnE=;
	h=From:To:Date:Message-ID:MIME-Version:CC:Subject:Content-Type; b=W4NlKC9uo+fp4m4YVJ+TVivPVqsvtOFzjVfQ/qV3+SFak2QyuMZhrNvGLVEkIz7Ku2BePIYK4V9dPjSXBTi1jjpaZ9iKjsjIhmOepGbcgYWO7DKaqasPYpMgjAUkD+gpff85fR/YmUuBwa8PMS2lCVp8jbelMZcRbx5r6Kgogfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=rijKneC/; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=rijKneC/; dkim=fail (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b=iZBfKWOU reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 91AA8C1D4A80
	for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 22:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1726033840; bh=FQs3i+NI97L9kxsfDiszgO/vX5t3NWmJsYjKNV82LnE=;
	h=From:To:Date:CC:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe;
	b=rijKneC/Ifmel9Za1uZspjYJHVdLy0OFl5Dk0IEDj4ADJqTrW3WBZA14gkqAdM0ul
	 mzQQ5cyQqh9FQxettlWu6YO8XYCxWHDYV1GZUBCyIapJfevOayidTaf1o2WnIl7aFV
	 /jtKR+IEPcaHcEFdsk6kiI6UqJag9RUh+DiB0a1w=
X-Mailbox-Line: From bpf-bounces+bpf=vger.kernel.org@ietf.org  Tue Sep 10 22:50:40 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 7FD46C1D4A78
	for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 22:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1726033840; bh=FQs3i+NI97L9kxsfDiszgO/vX5t3NWmJsYjKNV82LnE=;
	h=From:To:Date:CC:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe;
	b=rijKneC/Ifmel9Za1uZspjYJHVdLy0OFl5Dk0IEDj4ADJqTrW3WBZA14gkqAdM0ul
	 mzQQ5cyQqh9FQxettlWu6YO8XYCxWHDYV1GZUBCyIapJfevOayidTaf1o2WnIl7aFV
	 /jtKR+IEPcaHcEFdsk6kiI6UqJag9RUh+DiB0a1w=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
	by ietfa.amsl.com (Postfix) with ESMTP id E4B49C1CAE9F
	for <bpf@ietfa.amsl.com>; Tue, 10 Sep 2024 22:50:37 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -6.907
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
	header.d=obs-cr.20230601.gappssmtp.com
Received: from mail.ietf.org ([50.223.129.194])
	by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cvu9x0xJiqYx for <bpf@ietfa.amsl.com>;
	Tue, 10 Sep 2024 22:50:37 -0700 (PDT)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by ietfa.amsl.com (Postfix) with ESMTPS id 697E6C14CE53
	for <bpf@ietf.org>; Tue, 10 Sep 2024 22:50:36 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7a9ad15d11bso350821385a.0
        for <bpf@ietf.org>; Tue, 10 Sep 2024 22:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1726033835;
 x=1726638635; darn=ietf.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KKMHrpR5X9WXAcYhedLYlZ3oPCaG5UH+cdvsRKtIGFk=;
        b=iZBfKWOUhpKDPIteyDRUJWv7N+hWTj3l+jmhMmcHt8B/AFLmw7+1RZfEUbs+b19ZTs
         8oLUGsm2H92yVCfiMjSV7PngXwL2DWOCT+zyXnDLJjurcjduKdiHS89yA2i4VgxWKdh/
         YTcoEf/WfFrBgym9Qd3x6hXg+fKFqh4RyRP1aSXMoNzu6FeBpMfcD/T2BLJGp6TjtPcu
         1eksiXVOhEPCQcvpzLSNcflSKg9RT3ekbHkkIwHYWWRfs0pE5uAeQQNXgGEAZ1kpq7tX
         egIcdL5mxoFwpeb2WE5RQV5gboBgJjB/xUYNd13e45rPGVON/SynkfPllTvG3DbEEUX1
         2M8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726033835; x=1726638635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KKMHrpR5X9WXAcYhedLYlZ3oPCaG5UH+cdvsRKtIGFk=;
        b=Tl9dJCmsdTOIyPKQDeFM12nGXNcr0DDyOWN8zqkjpIXz/mb4lJLZOYXHfQirPDLxrZ
         xzJyiVpXElrGgbSqDByujAtTehF4ap4sccHUAxlKJuEfhKwqfz0rTDsc5q7bnyiwXqdt
         N/syi9l9QrmEVrKeYe2QFKe2LAiERJpmE8ITVYl5DoMzQiYdlnpNYnwEUXRNuNBugbk/
         PnE/jtr4kX+Ldyj0LtcjHub3tIjWWDmxy8wdmpu0IPtJiaZuUC8044c+VRVV8+UZlPdM
         c5poKpRGVV4uCnxqyQah/SK3TlEy+ZpVs9rXx3kNiN5dJW5/STW4f5k2ehJMO3xOdvtt
         4KxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrXrjJSKpiiVpnyzECuSZOQC+EN7KnINPC1w0dCJ/ZQinEDq0RVP+RILIaOeseoTHT3+8=@ietf.org
X-Gm-Message-State: AOJu0YxvewoevXnMgVYoZ0SneIwYwLRqX/2bDOf3s3q4Pfc1SyutyaWn
	JX16ySrxbdO7t8ZEUKHqz/y86/Nrz01JDEgKKxR2nWlniufj7aCsL1S2JemCuLt7qIb5xUB2ux3
	W
X-Google-Smtp-Source: 
 AGHT+IH1+5WzwhvwUxARcN34XPKfWywXQLulDvz6VObaTDekveqtRbPPEVcL0Rs2wBbEp6fEEeMclA==
X-Received: by 2002:a05:620a:1996:b0:7a9:a63a:9f5e with SMTP id
 af79cd13be357-7a9a63aadbdmr2658262485a.41.1726033835371;
        Tue, 10 Sep 2024 22:50:35 -0700 (PDT)
Received: from ininer.rhod.uc.edu ([129.137.96.15])
        by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a9a7a040dbsm378999185a.86.2024.09.10.22.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 22:50:35 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: bpf@vger.kernel.org,
	bpf@ietf.org
Date: Wed, 11 Sep 2024 01:50:32 -0400
Message-ID: <20240911055033.2084881-1-hawkinsw@obs.cr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID-Hash: NYGPNGPCOPIUCTGGBVSC3WFBGNQUGD6F
X-Message-ID-Hash: NYGPNGPCOPIUCTGGBVSC3WFBGNQUGD6F
X-MailFrom: hawkinsw@obs.cr
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia;
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: Will Hawkins <hawkinsw@obs.cr>
X-Mailman-Version: 3.3.9rc4
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_=5BPATCH_v2=5D_docs/bpf=3A_Add_constant_values_for_linka?=
	=?utf-8?q?ges?=
Archived-At: 
 <https://mailarchive.ietf.org/arch/msg/bpf/RfgLleAeE1-6mvC8cKWJMcHJEKY>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

TWFrZSB0aGUgdmFsdWVzIG9mIHRoZSBzeW1ib2xpYyBjb25zdGFudHMgdGhhdCBkZWZpbmUgdGhl
IHZhbGlkIGxpbmthZ2VzDQpmb3IgZnVuY3Rpb25zIGFuZCB2YXJpYWJsZXMgZXhwbGljaXQuDQoN
ClNpZ25lZC1vZmYtYnk6IFdpbGwgSGF3a2lucyA8aGF3a2luc3dAb2JzLmNyPg0KLS0tDQogICAg
djEgLT4gdjI6DQogICAgICAtIFJlZm9ybWF0IHRvIG1hdGNoIHN0eWxlIGluIEJQRiBJU0EgZG9j
dW1lbnQNCiAgICAgIC0gQWRkIGluZm9ybWF0aW9uIGFib3V0IEJURl9WQVJfR0xPQkFMX0VYVEVS
Tg0KDQogRG9jdW1lbnRhdGlvbi9icGYvYnRmLnJzdCB8IDM5ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9icGYvYnRmLnJzdCBi
L0RvY3VtZW50YXRpb24vYnBmL2J0Zi5yc3QNCmluZGV4IDI1N2E3ZTFjZGY1ZC4uOTMwNjAyODNi
NmZkIDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9icGYvYnRmLnJzdA0KKysrIGIvRG9jdW1l
bnRhdGlvbi9icGYvYnRmLnJzdA0KQEAgLTM2OCw3ICszNjgsNyBAQCBObyBhZGRpdGlvbmFsIHR5
cGUgZGF0YSBmb2xsb3cgYGBidGZfdHlwZWBgLg0KICAgKiBgYGluZm8ua2luZF9mbGFnYGA6IDAN
CiAgICogYGBpbmZvLmtpbmRgYDogQlRGX0tJTkRfRlVOQw0KICAgKiBgYGluZm8udmxlbmBgOiBs
aW5rYWdlIGluZm9ybWF0aW9uIChCVEZfRlVOQ19TVEFUSUMsIEJURl9GVU5DX0dMT0JBTA0KLSAg
ICAgICAgICAgICAgICAgICBvciBCVEZfRlVOQ19FWFRFUk4pDQorICAgICAgICAgICAgICAgICAg
IG9yIEJURl9GVU5DX0VYVEVSTiAtIHNlZSA6cmVmOmBCVEZfRnVuY3Rpb25fTGlua2FnZV9Db25z
dGFudHNgKQ0KICAgKiBgYHR5cGVgYDogYSBCVEZfS0lORF9GVU5DX1BST1RPIHR5cGUNCiANCiBO
byBhZGRpdGlvbmFsIHR5cGUgZGF0YSBmb2xsb3cgYGBidGZfdHlwZWBgLg0KQEAgLTQyNCw5ICs0
MjQsOCBAQCBmb2xsb3dpbmcgZGF0YTo6DQogICAgICAgICBfX3UzMiAgIGxpbmthZ2U7DQogICAg
IH07DQogDQotYGBzdHJ1Y3QgYnRmX3ZhcmBgIGVuY29kaW5nOg0KLSAgKiBgYGxpbmthZ2VgYDog
Y3VycmVudGx5IG9ubHkgc3RhdGljIHZhcmlhYmxlIDAsIG9yIGdsb2JhbGx5IGFsbG9jYXRlZA0K
LSAgICAgICAgICAgICAgICAgdmFyaWFibGUgaW4gRUxGIHNlY3Rpb25zIDENCitgYGJ0Zl92YXIu
bGlua2FnZWBgIG1heSB0YWtlIHRoZSB2YWx1ZXM6IEJURl9WQVJfU1RBVElDLCBCVEZfVkFSX0dM
T0JBTF9BTExPQ0FURUQgb3IgQlRGX1ZBUl9HTE9CQUxfRVhURVJOIC0NCitzZWUgOnJlZjpgQlRG
X1Zhcl9MaW5rYWdlX0NvbnN0YW50c2AuDQogDQogTm90IGFsbCB0eXBlIG9mIGdsb2JhbCB2YXJp
YWJsZXMgYXJlIHN1cHBvcnRlZCBieSBMTFZNIGF0IHRoaXMgcG9pbnQuDQogVGhlIGZvbGxvd2lu
ZyBpcyBjdXJyZW50bHkgYXZhaWxhYmxlOg0KQEAgLTU0OSw2ICs1NDgsMzggQEAgVGhlIGBgYnRm
X2VudW02NGBgIGVuY29kaW5nOg0KIElmIHRoZSBvcmlnaW5hbCBlbnVtIHZhbHVlIGlzIHNpZ25l
ZCBhbmQgdGhlIHNpemUgaXMgbGVzcyB0aGFuIDgsDQogdGhhdCB2YWx1ZSB3aWxsIGJlIHNpZ24g
ZXh0ZW5kZWQgaW50byA4IGJ5dGVzLg0KIA0KKzIuMyBDb25zdGFudCBWYWx1ZXMNCistLS0tLS0t
LS0tLS0tLS0tLS0tDQorDQorLi4gX0JURl9GdW5jdGlvbl9MaW5rYWdlX0NvbnN0YW50czoNCisN
CisyLjMuMSBGdW5jdGlvbiBMaW5rYWdlIENvbnN0YW50IFZhbHVlcw0KK35+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQorLi4gdGFibGU6OiBGdW5jdGlvbiBMaW5rYWdlIFZh
bHVlcyBhbmQgTWVhbmluZ3MNCisNCisgID09PT09PT09PT09PT09PT09PT0gID09PT09ICA9PT09
PT09PT09PQ0KKyAga2luZCAgICAgICAgICAgICAgICAgdmFsdWUgIGRlc2NyaXB0aW9uDQorICA9
PT09PT09PT09PT09PT09PT09ICA9PT09PSAgPT09PT09PT09PT0NCisgIGBgQlRGX0ZVTkNfU1RB
VElDYGAgIDB4MCAgICBkZWZpbml0aW9uIG9mIHN1YnByb2dyYW0gbm90IHZpc2libGUgb3V0c2lk
ZSBjb250YWluaW5nIGNvbXBpbGF0aW9uIHVuaXQNCisgIGBgQlRGX0ZVTkNfR0xPQkFMYGAgIDB4
MSAgICBkZWZpbml0aW9uIG9mIHN1YnByb2dyYW0gdmlzaWJsZSBvdXRzaWRlIGNvbnRhaW5pbmcg
Y29tcGlsYXRpb24gdW5pdA0KKyAgYGBCVEZfRlVOQ19FWFRFUk5gYCAgMHgyICAgIGRlY2xhcmF0
aW9uIG9mIGEgc3VicHJvZ3JhbSB3aG9zZSBkZWZpbml0aW9uIGlzIG91dHNpZGUgdGhlIGNvbnRh
aW5pbmcgY29tcGlsYXRpb24gdW5pdA0KKyAgPT09PT09PT09PT09PT09PT09PSAgPT09PT0gID09
PT09PT09PT09DQorDQorDQorLi4gX0JURl9WYXJfTGlua2FnZV9Db25zdGFudHM6DQorDQorMi4z
LjIgVmFyaWFibGUgTGlua2FnZSBDb25zdGFudCBWYWx1ZXMNCit+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fg0KKy4uIHRhYmxlOjogVmFyaWFibGUgTGlua2FnZSBWYWx1ZXMg
YW5kIE1lYW5pbmdzDQorDQorICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09ICA9PT09PSAg
PT09PT09PT09PT0NCisgIGtpbmQgICAgICAgICAgICAgICAgICAgICAgICAgIHZhbHVlICBkZXNj
cmlwdGlvbg0KKyAgPT09PT09PT09PT09PT09PT09PT09PT09PT09PSAgPT09PT0gID09PT09PT09
PT09DQorICBgYEJURl9WQVJfU1RBVElDYGAgICAgICAgICAgICAweDAgICAgZGVmaW5pdGlvbiBv
ZiBnbG9iYWwgdmFyaWFibGUgbm90IHZpc2libGUgb3V0c2lkZSBjb250YWluaW5nIGNvbXBpbGF0
aW9uIHVuaXQNCisgIGBgQlRGX1ZBUl9HTE9CQUxfQUxMT0NBVEVEYGAgIDB4MSAgICBkZWZpbml0
aW9uIG9mIGdsb2JhbCB2YXJpYWJsZSB2aXNpYmxlIG91dHNpZGUgY29udGFpbmluZyBjb21waWxh
dGlvbiB1bml0DQorICBgYEJURl9WQVJfR0xPQkFMX0VYVEVSTmBgICAgICAweDIgICAgZGVjbGFy
YXRpb24gb2YgZ2xvYmFsIHZhcmlhYmxlIHdob3NlIGRlZmluaXRpb24gaXMgb3V0c2lkZSB0aGUg
Y29udGFpbmluZyBjb21waWxhdGlvbiB1bml0DQorICA9PT09PT09PT09PT09PT09PT09PT09PT09
PT09ICA9PT09PSAgPT09PT09PT09PT0NCisNCiAzLiBCVEYgS2VybmVsIEFQSQ0KID09PT09PT09
PT09PT09PT09DQogDQotLSANCjIuNDUuMg0KDQotLSAKQnBmIG1haWxpbmcgbGlzdCAtLSBicGZA
aWV0Zi5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBicGYtbGVhdmVAaWV0Zi5v
cmcK

