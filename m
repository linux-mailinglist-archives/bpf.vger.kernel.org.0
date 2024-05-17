Return-Path: <bpf+bounces-29962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0FD8C8A6F
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 19:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5EA1C21D29
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 17:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EADA13D8B4;
	Fri, 17 May 2024 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="DYIpFy/e";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="GTdhaMpG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LtbP1feN"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4B712F5A3
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715965225; cv=none; b=CY7YgboswTZ64i1gTIG9F1Lssojdmm3Zi+12JlJtMifG1C30aR7ltlcARVPraAHzRthnKMpKkjWBRQ+8IBfJK+x1ZeqoN9BIrGUSIivjwHsSFtANTrwZ7T3MeHUvhxP+xvRcdgGjBloCJnhy4bhafi5SW7YaxMwGRwWP1rqbApE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715965225; c=relaxed/simple;
	bh=dFjz47S3uIWSCHGSuFpbAotTgqY1rSUEWSy8PP9XjZY=;
	h=To:Date:Message-Id:MIME-Version:CC:Subject:Content-Type:From; b=KJ8CPJgM80h8zUUd8XTSdlmmGWBvaJNDJmY9lxgTq72B/Pqt6Pbix84vDdaoQ7pug2WljAoEVdZOTh0JLC6WgecQ6MBzYt9opfJJyuKGMfuo85h+ukngu9jaG4qLgcpydseOrwYWpT0EJAAAIF0Fi96PbA3hv9hTf3gSnfH36x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=DYIpFy/e; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=GTdhaMpG reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=LtbP1feN reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 497EEC1840DF
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 10:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1715965223; bh=dFjz47S3uIWSCHGSuFpbAotTgqY1rSUEWSy8PP9XjZY=;
	h=To:Date:CC:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=DYIpFy/eKed/vxSilbTRxYTJOb8foI4KMqHAOfq9hW1B6m9gNmL1KsD10FBQM4OYI
	 Z9LC93owLd7sogwGdlv1dRci6R2/AddAoEmvCQOn8B+cISkKvonLRMJ/S6qOUEls+h
	 gMLza3vpji/gfS9ivD9QufIn/MtAf48NZbQOLM+E=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 31AFAC14F74A
 for <bpf@vger.kernel.org>; Fri, 17 May 2024 10:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1715965223; bh=dFjz47S3uIWSCHGSuFpbAotTgqY1rSUEWSy8PP9XjZY=;
 h=From:To:Date:CC:Subject:List-Id:List-Archive:List-Help:List-Owner:
 List-Post:List-Subscribe:List-Unsubscribe;
 b=GTdhaMpGwCqQyWvZyC7POF+9a983F7CmCeK0bsNwQgfng+Sg1tvHknqqNPjDldQvV
 Zy2rfcpT1RsooCCw5DzBCyoWcib+XzXOYfR/zSmQlmQmNUvs04pVwGPFTE2lS+XUb+
 qLBOqDfrvkZPMmcMIgnp4P7r3yzSY0A7XoLBQ240=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 4E814C1D5C4E
 for <bpf@ietfa.amsl.com>; Fri, 17 May 2024 09:59:04 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.845
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3ZLNy7HusQqA for <bpf@ietfa.amsl.com>;
 Fri, 17 May 2024 09:59:00 -0700 (PDT)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 45A6BC151086
 for <bpf@ietf.org>; Fri, 17 May 2024 09:59:00 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1edc696df2bso17319045ad.0
 for <bpf@ietf.org>; Fri, 17 May 2024 09:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1715965139; x=1716569939;
 darn=ietf.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5+pYUkfOgnCOs3dkE4Q29vvT0TtpAPJIkLifqxKN6Jk=;
 b=LtbP1feNuqauF9oYDGWKb/SOP5J8Gk/L4h45rb7vgc/hRBq0JFEsdSwIcGkFRgaBBS
 UoiPyLz5tJh/BPVUS74VI/p3kScFRcbeyFUGgBGfGKVp1uqIwH7O8Ew+ylUytp5bEj0j
 wR3ZyhgzkJkgOIcTOk1ch7Hm1pAYy2s6H+M8DnIo5Jrw+9B5C9aaNL37mrJznlS8t5P0
 TqCpqbE/F2NbZwjYGG5DIx79xh2J5nHz+gG17/UGczW1aNOgB96DtFX/acmhBcVSGmTV
 5EgMLRRbM4jhAw8BrkTxSvPRRIwhr7sUusk4bKaSyjSBPJP4jIfka5ruU/ZU7ZStuWyG
 6EoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715965139; x=1716569939;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5+pYUkfOgnCOs3dkE4Q29vvT0TtpAPJIkLifqxKN6Jk=;
 b=f9pIOe6/74ihtQgf6rvu9jnlyyoB2Tls7F7aK/j/uD4r3VFOii7xjThnoRudQf/eOS
 tvnfabkw4wPyZ6UPuAt0atzKTQ6vk8LbiJZP8Z/R2EavKogiAoviFZqa+ElIFAhqLH1w
 GoSzvjmvzvaLx8pPKjUh9rf5IyIq3poq9KBUIbV2Cj+1enBZ4GeUAOWbBcIRjiAhctDM
 VnRiNyEGRf9bkJGNQZtEydbkoLhOGrxUTACxHbiC5mtBkGeOziniAn3sNQpCN+X8JUCy
 ark+AwdQWio9xRPy++0gww7F6m3wAX/b90ix4Xcmp5z+mE7byvlWEq4SGmcXMLRFoVDI
 cHaw==
X-Gm-Message-State: AOJu0YwfNHfeLmbJgvjM6qWitpZyae9TVCb53eVdEsyYpEy40iwHFE0F
 +7ueH7qevZogjPCjDQ4nirmRG3pQZCfbhmMYjZrmGWGhdwOPh4DG
X-Google-Smtp-Source: AGHT+IH4c20X1DopewNmBfkhe/1R8IYE3BdsjQmrmONldtpcy67DwXaVCWSA7XCCGoZILHuI0t56hg==
X-Received: by 2002:a05:6a21:789f:b0:1af:cdd4:9bf3 with SMTP id
 adf61e73a8af0-1afde10f1b3mr26423599637.32.1715965139222;
 Fri, 17 May 2024 09:58:59 -0700 (PDT)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f6603bb3e9sm8438608b3a.74.2024.05.17.09.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 May 2024 09:58:58 -0700 (PDT)
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Date: Fri, 17 May 2024 09:58:55 -0700
Message-Id: <20240517165855.4688-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID-Hash: JEZM5KA7HX2PKJF6C2VEARTWDHCHG5GC
X-Message-ID-Hash: JEZM5KA7HX2PKJF6C2VEARTWDHCHG5GC
X-MailFrom: dthaler1968@googlemail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia; 
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>,
 Dave Thaler <dthaler1968@googlemail.com>
X-Mailman-Version: 3.3.9rc4
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_=5BPATCH_bpf-next=5D_bpf=2C_docs=3A_Use_RFC_2119_languag?=
 =?utf-8?q?e_for_ISA_requirements?=
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/OKVjbo8-GtvAncW7017dthBFYSs>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Original-From: Dave Thaler <dthaler1968@googlemail.com>
From: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>

UGVyIElFVEYgY29udmVudGlvbiBhbmQgZGlzY3Vzc2lvbiBhdCBMU0YvTU0vQlBGLCB1c2UgTVVT
VCBldGMuDQprZXl3b3JkcyBhcyByZXF1ZXN0ZWQgYnkgSUVURiBBcmVhIERpcmVjdG9yIHJldmll
dy4gIEFsc28gYXMNCnJlcXVlc3RlZCwgaW5kaWNhdGUgdGhhdCBkb2N1bWVudGluZyBCVEYgaXMg
b3V0IG9mIHNjb3BlIG9mIHRoaXMNCmRvY3VtZW50IGFuZCB3aWxsIGJlIGNvdmVyZWQgYnkgYSBz
ZXBhcmF0ZSBJRVRGIHNwZWNpZmljYXRpb24uDQoNCkFkZGVkIHBhcmFncmFwaCBhYm91dCB0aGUg
dGVybWlub2xvZ3kgdGhhdCBpcyByZXF1aXJlZCBJRVRGIGJvaWxlcnBsYXRlDQphbmQgbXVzdCBi
ZSB3b3JkZWQgZXhhY3RseSBhcyBzdWNoLg0KDQpTaWduZWQtb2ZmLWJ5OiBEYXZlIFRoYWxlciA8
ZHRoYWxlcjE5NjhAZ29vZ2xlbWFpbC5jb20+DQotLS0NCiAuLi4vYnBmL3N0YW5kYXJkaXphdGlv
bi9pbnN0cnVjdGlvbi1zZXQucnN0ICAgfCAyNCArKysrKysrKysrKystLS0tLS0tDQogMSBmaWxl
IGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL2JwZi9zdGFuZGFyZGl6YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJzdCBi
L0RvY3VtZW50YXRpb24vYnBmL3N0YW5kYXJkaXphdGlvbi9pbnN0cnVjdGlvbi1zZXQucnN0DQpp
bmRleCA5OTc1NjBhYmEuLmViNzk2ZWJkZSAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vYnBm
L3N0YW5kYXJkaXphdGlvbi9pbnN0cnVjdGlvbi1zZXQucnN0DQorKysgYi9Eb2N1bWVudGF0aW9u
L2JwZi9zdGFuZGFyZGl6YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJzdA0KQEAgLTE0LDYgKzE0LDEz
IEBAIHNldCBhcmNoaXRlY3R1cmUgKElTQSkuDQogRG9jdW1lbnRhdGlvbiBjb252ZW50aW9ucw0K
ID09PT09PT09PT09PT09PT09PT09PT09PT0NCiANCitUaGUga2V5IHdvcmRzICJNVVNUIiwgIk1V
U1QgTk9UIiwgIlJFUVVJUkVEIiwgIlNIQUxMIiwgIlNIQUxMIE5PVCIsDQorIlNIT1VMRCIsICJT
SE9VTEQgTk9UIiwgIlJFQ09NTUVOREVEIiwgIk5PVCBSRUNPTU1FTkRFRCIsICJNQVkiLCBhbmQN
CisiT1BUSU9OQUwiIGluIHRoaXMgZG9jdW1lbnQgYXJlIHRvIGJlIGludGVycHJldGVkIGFzIGRl
c2NyaWJlZCBpbg0KK0JDUCAxNCBgPGh0dHBzOi8vd3d3LnJmYy1lZGl0b3Iub3JnL2luZm8vcmZj
MjExOT5gXw0KK2BSRkM4MTc0IDxodHRwczovL3d3dy5yZmMtZWRpdG9yLm9yZy9pbmZvL3JmYzgx
NzQ+YF8NCit3aGVuLCBhbmQgb25seSB3aGVuLCB0aGV5IGFwcGVhciBpbiBhbGwgY2FwaXRhbHMs
IGFzIHNob3duIGhlcmUuDQorDQogRm9yIGJyZXZpdHkgYW5kIGNvbnNpc3RlbmN5LCB0aGlzIGRv
Y3VtZW50IHJlZmVycyB0byBmYW1pbGllcw0KIG9mIHR5cGVzIHVzaW5nIGEgc2hvcnRoYW5kIHN5
bnRheCBhbmQgcmVmZXJzIHRvIHNldmVyYWwgZXhwb3NpdG9yeSwNCiBtbmVtb25pYyBmdW5jdGlv
bnMgd2hlbiBkZXNjcmliaW5nIHRoZSBzZW1hbnRpY3Mgb2YgaW5zdHJ1Y3Rpb25zLg0KQEAgLTEw
Niw5ICsxMTMsOSBAQCBDb25mb3JtYW5jZSBncm91cHMNCiANCiBBbiBpbXBsZW1lbnRhdGlvbiBk
b2VzIG5vdCBuZWVkIHRvIHN1cHBvcnQgYWxsIGluc3RydWN0aW9ucyBzcGVjaWZpZWQgaW4gdGhp
cw0KIGRvY3VtZW50IChlLmcuLCBkZXByZWNhdGVkIGluc3RydWN0aW9ucykuICBJbnN0ZWFkLCBh
IG51bWJlciBvZiBjb25mb3JtYW5jZQ0KLWdyb3VwcyBhcmUgc3BlY2lmaWVkLiAgQW4gaW1wbGVt
ZW50YXRpb24gbXVzdCBzdXBwb3J0IHRoZSBiYXNlMzIgY29uZm9ybWFuY2UNCi1ncm91cCBhbmQg
bWF5IHN1cHBvcnQgYWRkaXRpb25hbCBjb25mb3JtYW5jZSBncm91cHMsIHdoZXJlIHN1cHBvcnRp
bmcgYQ0KLWNvbmZvcm1hbmNlIGdyb3VwIG1lYW5zIGl0IG11c3Qgc3VwcG9ydCBhbGwgaW5zdHJ1
Y3Rpb25zIGluIHRoYXQgY29uZm9ybWFuY2UNCitncm91cHMgYXJlIHNwZWNpZmllZC4gIEFuIGlt
cGxlbWVudGF0aW9uIE1VU1Qgc3VwcG9ydCB0aGUgYmFzZTMyIGNvbmZvcm1hbmNlDQorZ3JvdXAg
YW5kIE1BWSBzdXBwb3J0IGFkZGl0aW9uYWwgY29uZm9ybWFuY2UgZ3JvdXBzLCB3aGVyZSBzdXBw
b3J0aW5nIGENCitjb25mb3JtYW5jZSBncm91cCBtZWFucyBpdCBNVVNUIHN1cHBvcnQgYWxsIGlu
c3RydWN0aW9ucyBpbiB0aGF0IGNvbmZvcm1hbmNlDQogZ3JvdXAuDQogDQogVGhlIHVzZSBvZiBu
YW1lZCBjb25mb3JtYW5jZSBncm91cHMgZW5hYmxlcyBpbnRlcm9wZXJhYmlsaXR5IGJldHdlZW4g
YSBydW50aW1lDQpAQCAtMjA5LDcgKzIxNiw3IEBAIEZvciBleGFtcGxlOjoNCiAgIDA3ICAgICAx
ICAgICAgIDAgICAgICAgIDAwIDAwICAxMSAyMiAzMyA0NCAgcjEgKz0gMHgxMTIyMzM0NCAvLyBi
aWcNCiANCiBOb3RlIHRoYXQgbW9zdCBpbnN0cnVjdGlvbnMgZG8gbm90IHVzZSBhbGwgb2YgdGhl
IGZpZWxkcy4NCi1VbnVzZWQgZmllbGRzIHNoYWxsIGJlIGNsZWFyZWQgdG8gemVyby4NCitVbnVz
ZWQgZmllbGRzIFNIQUxMIGJlIGNsZWFyZWQgdG8gemVyby4NCiANCiBXaWRlIGluc3RydWN0aW9u
IGVuY29kaW5nDQogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkBAIC0zNzMsNyArMzgwLDcg
QEAgaW50ZXJwcmV0ZWQgYXMgYSA2NC1iaXQgc2lnbmVkIHZhbHVlLg0KIE5vdGUgdGhhdCB0aGVy
ZSBhcmUgdmFyeWluZyBkZWZpbml0aW9ucyBvZiB0aGUgc2lnbmVkIG1vZHVsbyBvcGVyYXRpb24N
CiB3aGVuIHRoZSBkaXZpZGVuZCBvciBkaXZpc29yIGFyZSBuZWdhdGl2ZSwgd2hlcmUgaW1wbGVt
ZW50YXRpb25zIG9mdGVuDQogdmFyeSBieSBsYW5ndWFnZSBzdWNoIHRoYXQgUHl0aG9uLCBSdWJ5
LCBldGMuICBkaWZmZXIgZnJvbSBDLCBHbywgSmF2YSwNCi1ldGMuIFRoaXMgc3BlY2lmaWNhdGlv
biByZXF1aXJlcyB0aGF0IHNpZ25lZCBtb2R1bG8gdXNlIHRydW5jYXRlZCBkaXZpc2lvbg0KK2V0
Yy4gVGhpcyBzcGVjaWZpY2F0aW9uIHJlcXVpcmVzIHRoYXQgc2lnbmVkIG1vZHVsbyBNVVNUIHVz
ZSB0cnVuY2F0ZWQgZGl2aXNpb24NCiAod2hlcmUgLTEzICUgMyA9PSAtMSkgYXMgaW1wbGVtZW50
ZWQgaW4gQywgR28sIGV0Yy46Og0KIA0KICAgIGEgJSBuID0gYSAtIG4gKiB0cnVuYyhhIC8gbikN
CkBAIC00MDMsNyArNDEwLDcgQEAgb25seSBhbmQgZG8gbm90IHVzZSBhIHNlcGFyYXRlIHNvdXJj
ZSByZWdpc3RlciBvciBpbW1lZGlhdGUgdmFsdWUuDQogRm9yIGBgQUxVYGAsIHRoZSAxLWJpdCBz
b3VyY2Ugb3BlcmFuZCBmaWVsZCBpbiB0aGUgb3Bjb2RlIGlzIHVzZWQgdG8NCiBzZWxlY3Qgd2hh
dCBieXRlIG9yZGVyIHRoZSBvcGVyYXRpb24gY29udmVydHMgZnJvbSBvciB0by4gRm9yDQogYGBB
TFU2NGBgLCB0aGUgMS1iaXQgc291cmNlIG9wZXJhbmQgZmllbGQgaW4gdGhlIG9wY29kZSBpcyBy
ZXNlcnZlZA0KLWFuZCBtdXN0IGJlIHNldCB0byAwLg0KK2FuZCBNVVNUIGJlIHNldCB0byAwLg0K
IA0KID09PT09ICA9PT09PT09PSAgPT09PT0gID09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0NCiBjbGFzcyAgc291cmNlICAgIHZhbHVlICBkZXNjcmlwdGlv
bg0KQEAgLTUxNCw3ICs1MjEsOCBAQCBmb3IgZWFjaCBwcm9ncmFtIHR5cGUsIGJ1dCBzdGF0aWMg
SURzIGFyZSB1bmlxdWUgYWNyb3NzIGFsbCBwcm9ncmFtIHR5cGVzLg0KIA0KIFBsYXRmb3JtcyB0
aGF0IHN1cHBvcnQgdGhlIEJQRiBUeXBlIEZvcm1hdCAoQlRGKSBzdXBwb3J0IGlkZW50aWZ5aW5n
DQogYSBoZWxwZXIgZnVuY3Rpb24gYnkgYSBCVEYgSUQgZW5jb2RlZCBpbiB0aGUgJ2ltbScgZmll
bGQsIHdoZXJlIHRoZSBCVEYgSUQNCi1pZGVudGlmaWVzIHRoZSBoZWxwZXIgbmFtZSBhbmQgdHlw
ZS4NCitpZGVudGlmaWVzIHRoZSBoZWxwZXIgbmFtZSBhbmQgdHlwZS4gIEZ1cnRoZXIgZG9jdW1l
bnRhdGlvbiBvZiBCVEYNCitpcyBvdXRzaWRlIHRoZSBzY29wZSBvZiB0aGlzIGRvY3VtZW50IGFu
ZCBpcyBsZWZ0IGZvciBmdXR1cmUgd29yay4NCiANCiBQcm9ncmFtLWxvY2FsIGZ1bmN0aW9ucw0K
IH5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQpAQCAtNzI0LDUgKzczMiw1IEBAIGNhcnJpZWQgb3Zl
ciBmcm9tIGNsYXNzaWMgQlBGLiBUaGVzZSBpbnN0cnVjdGlvbnMgdXNlZCBhbiBpbnN0cnVjdGlv
bg0KIGNsYXNzIG9mIGBgTERgYCwgYSBzaXplIG1vZGlmaWVyIG9mIGBgV2BgLCBgYEhgYCwgb3Ig
YGBCYGAsIGFuZCBhDQogbW9kZSBtb2RpZmllciBvZiBgYEFCU2BgIG9yIGBgSU5EYGAuICBUaGUg
J2RzdF9yZWcnIGFuZCAnb2Zmc2V0JyBmaWVsZHMgd2VyZQ0KIHNldCB0byB6ZXJvLCBhbmQgJ3Ny
Y19yZWcnIHdhcyBzZXQgdG8gemVybyBmb3IgYGBBQlNgYC4gIEhvd2V2ZXIsIHRoZXNlDQotaW5z
dHJ1Y3Rpb25zIGFyZSBkZXByZWNhdGVkIGFuZCBzaG91bGQgbm8gbG9uZ2VyIGJlIHVzZWQuICBB
bGwgbGVnYWN5IHBhY2tldA0KK2luc3RydWN0aW9ucyBhcmUgZGVwcmVjYXRlZCBhbmQgU0hPVUxE
IG5vIGxvbmdlciBiZSB1c2VkLiAgQWxsIGxlZ2FjeSBwYWNrZXQNCiBhY2Nlc3MgaW5zdHJ1Y3Rp
b25zIGJlbG9uZyB0byB0aGUgInBhY2tldCIgY29uZm9ybWFuY2UgZ3JvdXAuDQotLSANCjIuNDAu
MQ0KDQotLSAKQnBmIG1haWxpbmcgbGlzdCAtLSBicGZAaWV0Zi5vcmcKVG8gdW5zdWJzY3JpYmUg
c2VuZCBhbiBlbWFpbCB0byBicGYtbGVhdmVAaWV0Zi5vcmcK

