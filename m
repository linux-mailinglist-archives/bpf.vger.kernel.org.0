Return-Path: <bpf+bounces-29952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 123858C8967
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 17:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5886281107
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 15:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E91912D755;
	Fri, 17 May 2024 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="FxcULPk4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="MvC9gGmL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Ja5BDERg"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D3354673
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715960105; cv=none; b=j/adLel+G/SCyhs4u8vPFJeD6LOcS45dm2NTMrcqGrU7r7bG2UiSCi7Sx+8SOoPpHGrd+AeEycnT+1VhSRngOySfVhH8AeN08eIyMXU97/d15j6v7ixcC7BSmSulW6qSBmbBF3Zzd1SoELeSUNx+nuZnf63sa4TVNAnvur1VsLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715960105; c=relaxed/simple;
	bh=nj48mcF7ntqeKT5K10mLaxwH7gG5FYJhrEpbQbuF3RM=;
	h=To:Date:Message-Id:MIME-Version:CC:Subject:Content-Type:From; b=M0FUbtZ0GlOd5Uodr3u8f3GMpaXZIJ+6BQCRqjzkEaev0P5VJHApeMBtyvlv2Ie21l0OIG/owVFvZ8lOKwHFYEu/pxk7eZrjo78BpAgaJwEnqL3eBMqKRNxEpzlHtYDwhiPMpUXX9lXsBiSLAaoTsRJnEGLnr/qGwNH2VUzpJ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=FxcULPk4; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=MvC9gGmL reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Ja5BDERg reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 90AEAC1D4A8D
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 08:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1715960102; bh=nj48mcF7ntqeKT5K10mLaxwH7gG5FYJhrEpbQbuF3RM=;
	h=To:Date:CC:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=FxcULPk4Y9ps4+oZkZbnek6DI+1KlK203/zjYRZO0wOndQCDVOEPxe1/EZiAKjhAh
	 2t9f0xzzuDmH7IVD37gyoUgQ+T00v4om6DK+rs1atrscozNVeNKIMQDk6duk03HMkz
	 fWakrxPYl+V2Ie0EsYi1tz+U5bUIyzlPcfDkkrHg=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 78E78C14F61E
 for <bpf@vger.kernel.org>; Fri, 17 May 2024 08:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1715960102; bh=nj48mcF7ntqeKT5K10mLaxwH7gG5FYJhrEpbQbuF3RM=;
 h=From:To:Date:CC:Subject:List-Id:List-Archive:List-Help:List-Owner:
 List-Post:List-Subscribe:List-Unsubscribe;
 b=MvC9gGmLZyt90Je40PqZzJR+x+KH76krpOkGN2C3LPt1+FACvSrsHwnFqP2YhCeKL
 v9yF9aVdOOvbZxKd4ZYGj/oZuzOQcbE9lUz+2l8+hwMWLAKaBgVznrNvPZXWKiLH+r
 PpzYMLCR2XJCNvf29k6VKtimVnvR9GA3NMj3kuoA=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id BDD48C14EB1E
 for <bpf@ietfa.amsl.com>; Fri, 17 May 2024 08:34:53 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -6.845
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QrHruz1q_aLy for <bpf@ietfa.amsl.com>;
 Fri, 17 May 2024 08:34:49 -0700 (PDT)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id ECEF4C14F5E5
 for <bpf@ietf.org>; Fri, 17 May 2024 08:34:49 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2b27eec1eb1so47898a91.0
 for <bpf@ietf.org>; Fri, 17 May 2024 08:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1715960089; x=1716564889;
 darn=ietf.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gu9rHXjrQNiuEdfil+6Qxyl1dIA+C1Ezul/fpNnbzX0=;
 b=Ja5BDERgBgTifhW7xvsOa3m4ShkcGP8/G+OTPkx6tDFE7P6sgPVyf0v1rJ6asnHZ4D
 RMoOZZwQ2NIpsyNG+0S4pKqaC1OVZfNQFWPeY5wTCW/tTmlXWnZxyQZTOAT8booRC3DH
 JjijTwCigToFFrmf5QfeY7a4IH2OIazlp9yAlqPVOAeSp2gQDdK3gSh3hh4HkCPefx3h
 esc7/GRcTzzutRRokdIOgr5FvnLjTIk5hQfo0ipPv6q3nNTjp7uWJtJn/0PPoIQY5u3E
 m+3B0tYyxxg5AGS6rFex8I7Ti49uKNZoOH9sNQVX7nDoFRBbfEIh2ZOLgJfYOlewu5fC
 3uoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715960089; x=1716564889;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gu9rHXjrQNiuEdfil+6Qxyl1dIA+C1Ezul/fpNnbzX0=;
 b=jupc6dtcKWdsUXBzkhV+63KetRk6zbXFzE6QzrZR6O8JUIEI9pqBXbao2lwSfJjfQB
 StaAVPlMUfOl23i35BYsT9G2v3FLUoIrJcbP7AddRAkHYuOM5Um1w/7JV5l5nggfGrc9
 d3JzOinAvlTFXxB9CqK8ffokFKMOMw09BBtu4QLnHRjsn7sGOUgBH3DDUl1HeAVpx+Ud
 2f2juso89U9Ft8qOl08o/MMEPmFauKoQYF3IYpX8VqWQDKrAb/YrjxwH1BQvx9Og+mMZ
 4JrUBZ2k9OOnrlAlvZDwu7rbLCA406KAzE8D2beqeA/W3PVH3EI19QPhtkOSOqGeVxxb
 xaYg==
X-Gm-Message-State: AOJu0YxoQJAgOO7v09IYZ2C/yD2u2f7K81SXRePoALP+DJ0I7s4yQdWe
 6kqi/79tZ7CsX2c4QmU5GOhJfXkyjGR90lNU85PoIe0yTqd7wAl7
X-Google-Smtp-Source: AGHT+IEmwrGI+mO352Ret0QmpEQXcshi8dtdOKXoKXqgkRXtzbmexGrV7Gnc7qYFKDIm26al4/xBrw==
X-Received: by 2002:a17:90a:ea12:b0:2b2:7c52:e175 with SMTP id
 98e67ed59e1d1-2b6cceef2f7mr20254508a91.31.1715960088955;
 Fri, 17 May 2024 08:34:48 -0700 (PDT)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b628ca5124sm17494864a91.43.2024.05.17.08.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 May 2024 08:34:48 -0700 (PDT)
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Date: Fri, 17 May 2024 08:34:45 -0700
Message-Id: <20240517153445.3914-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID-Hash: FCNFA6O74P2HVGMO6HLIRXHCMXSMV76P
X-Message-ID-Hash: FCNFA6O74P2HVGMO6HLIRXHCMXSMV76P
X-MailFrom: dthaler1968@googlemail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia; 
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>,
 Dave Thaler <dthaler1968@googlemail.com>
X-Mailman-Version: 3.3.9rc4
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_=5BPATCH_bpf-next=5D_bpf=2C_docs=3A_Move_sentence_about_?=
 =?utf-8?q?returning_R0_to_abi=2Erst?=
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/RHjXOXRkTc3i5F_wXQjL4MNQvks>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Original-From: Dave Thaler <dthaler1968@googlemail.com>
From: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>

QXMgZGlzY3Vzc2VkIGF0IExTRi9NTS9CUEYsIHRoZSBzZW50ZW5jZSBhYm91dCB1c2luZyBSMCBm
b3IgcmV0dXJuaW5nDQp2YWx1ZXMgZnJvbSBjYWxscyBpcyBwYXJ0IG9mIHRoZSBjYWxsaW5nIGNv
bnZlbnRpb24gYW5kIGJlbG9uZ3MgaW4NCmFiaS5yc3QuICBBbnkgZnVydGhlciBhZGRpdGlvbnMg
b3IgY2xhcmlmaWNhdGlvbnMgdG8gdGhpcyB0ZXh0IGFyZSBsZWZ0DQpmb3IgZnV0dXJlIHBhdGNo
ZXMgb24gYWJpLnJzdC4gIFRoZSBjdXJyZW50IHBhdGNoIGlzIHNpbXBseSB0byB1bmJsb2NrDQpw
cm9ncmVzc2lvbiBvZiBpbnN0cnVjdGlvbi1zZXQucnN0IHRvIGEgc3RhbmRhcmQuDQoNCkluIGNv
bnRyYXN0LCB0aGUgcmVzdHJpY3Rpb24gb2YgcmVnaXN0ZXIgbnVtYmVycyB0byB0aGUgcmFuZ2Ug
MC0xMA0KaXMgdW50b3VjaGVkLCBsZWZ0IGluIHRoZSBpbnN0cnVjdGlvbi1zZXQucnN0IGRlZmlu
aXRpb24gb2YgdGhlDQpzcmNfcmVnIGFuZCBkc3RfcmVnIGZpZWxkcy4NCg0KU2lnbmVkLW9mZi1i
eTogRGF2ZSBUaGFsZXIgPGR0aGFsZXIxOTY4QGdvb2dsZW1haWwuY29tPg0KLS0tDQogRG9jdW1l
bnRhdGlvbi9icGYvc3RhbmRhcmRpemF0aW9uL2FiaS5yc3QgICAgICAgICAgICAgfCAzICsrKw0K
IERvY3VtZW50YXRpb24vYnBmL3N0YW5kYXJkaXphdGlvbi9pbnN0cnVjdGlvbi1zZXQucnN0IHwg
MyAtLS0NCiAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkN
Cg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vYnBmL3N0YW5kYXJkaXphdGlvbi9hYmkucnN0
IGIvRG9jdW1lbnRhdGlvbi9icGYvc3RhbmRhcmRpemF0aW9uL2FiaS5yc3QNCmluZGV4IDBjMmUx
MGVlYi4uNDE1MTQxMzdjIDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9icGYvc3RhbmRhcmRp
emF0aW9uL2FiaS5yc3QNCisrKyBiL0RvY3VtZW50YXRpb24vYnBmL3N0YW5kYXJkaXphdGlvbi9h
YmkucnN0DQpAQCAtMjMsMyArMjMsNiBAQCBUaGUgQlBGIGNhbGxpbmcgY29udmVudGlvbiBpcyBk
ZWZpbmVkIGFzOg0KIA0KIFIwIC0gUjUgYXJlIHNjcmF0Y2ggcmVnaXN0ZXJzIGFuZCBCUEYgcHJv
Z3JhbXMgbmVlZHMgdG8gc3BpbGwvZmlsbCB0aGVtIGlmDQogbmVjZXNzYXJ5IGFjcm9zcyBjYWxs
cy4NCisNCitUaGUgQlBGIHByb2dyYW0gbmVlZHMgdG8gc3RvcmUgdGhlIHJldHVybiB2YWx1ZSBp
bnRvIHJlZ2lzdGVyIFIwIGJlZm9yZSBkb2luZyBhbg0KK2BgRVhJVGBgLg0KZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vYnBmL3N0YW5kYXJkaXphdGlvbi9pbnN0cnVjdGlvbi1zZXQucnN0IGIv
RG9jdW1lbnRhdGlvbi9icGYvc3RhbmRhcmRpemF0aW9uL2luc3RydWN0aW9uLXNldC5yc3QNCmlu
ZGV4IDk5NzU2MGFiYS4uYzBkN2Q3NGUwIDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9icGYv
c3RhbmRhcmRpemF0aW9uL2luc3RydWN0aW9uLXNldC5yc3QNCisrKyBiL0RvY3VtZW50YXRpb24v
YnBmL3N0YW5kYXJkaXphdGlvbi9pbnN0cnVjdGlvbi1zZXQucnN0DQpAQCAtNDc1LDkgKzQ3NSw2
IEBAIHRoZSBqdW1wIGluc3RydWN0aW9uLiAgVGh1cyAnUEMgKz0gMScgc2tpcHMgZXhlY3V0aW9u
IG9mIHRoZSBuZXh0DQogaW5zdHJ1Y3Rpb24gaWYgaXQncyBhIGJhc2ljIGluc3RydWN0aW9uIG9y
IHJlc3VsdHMgaW4gdW5kZWZpbmVkIGJlaGF2aW9yDQogaWYgdGhlIG5leHQgaW5zdHJ1Y3Rpb24g
aXMgYSAxMjgtYml0IHdpZGUgaW5zdHJ1Y3Rpb24uDQogDQotVGhlIEJQRiBwcm9ncmFtIG5lZWRz
IHRvIHN0b3JlIHRoZSByZXR1cm4gdmFsdWUgaW50byByZWdpc3RlciBSMCBiZWZvcmUgZG9pbmcg
YW4NCi1gYEVYSVRgYC4NCi0NCiBFeGFtcGxlOg0KIA0KIGBge0pTR0UsIFgsIEpNUDMyfWBgIG1l
YW5zOjoNCi0tIA0KMi40MC4xDQoNCi0tIApCcGYgbWFpbGluZyBsaXN0IC0tIGJwZkBpZXRmLm9y
ZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGJwZi1sZWF2ZUBpZXRmLm9yZwo=

