Return-Path: <bpf+bounces-30588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3518CEFD8
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 17:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F6F01C20944
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 15:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC7F4EB45;
	Sat, 25 May 2024 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="ZHAVbpWx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="lQmcOUqm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kYOd1CK6"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E351DFFC
	for <bpf@vger.kernel.org>; Sat, 25 May 2024 15:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716651233; cv=none; b=Ir6UX5pKmo4fKBmAR2KXXbnP8JY5CD+hAlkEdh66ukxpFq/0L0jH1I2kZxbSGCTM1ikSOER1A1zWyudGybVDLBB3OPPXKT7pfDc/AmQzslCdY/oX17Q/aWsgzGemOAG6k4EL/5oD5m6t+5jFwSKHAmpDwEk84aG+/67Ry3OzUaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716651233; c=relaxed/simple;
	bh=HmzY/e6/lrsYHcYzUC4KA8e0GCzuXfBjW5ubZ6NBYQw=;
	h=To:Date:Message-Id:MIME-Version:CC:Subject:Content-Type:From; b=BhIwEm4a0FYRhXjPz6Sby+s/MsWYkmU76JZUXtpBeK63mI4ZMKp13fKmsRHNk7nfGfhv7Bov6SmIjTmQsEfJNImWSg1vqnfcBgtv0XeNCdTiCDAOXEjvGhwZy++4ehqrfL94RwPeUqrhJNLaAQBayYGTDOkBx2h83WtBI7+pH8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=ZHAVbpWx; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=lQmcOUqm reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=kYOd1CK6 reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 7EB7BC14CEFD
	for <bpf@vger.kernel.org>; Sat, 25 May 2024 08:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1716651225; bh=HmzY/e6/lrsYHcYzUC4KA8e0GCzuXfBjW5ubZ6NBYQw=;
	h=To:Date:CC:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=ZHAVbpWxDrJWxDdyvXncv0dIoTL+olaSY1FTyywvoI/xpuYSYQi3wYgWLBrUE7Mbp
	 2ZlYifHr2ibEtCADlrkaW6AjighyuppQMEV81swHURRbhPFJVXf48sKn3yKCkOvoOb
	 vgkUMWIP3i+YiBlO8tSn/kCk2DjxqgvO7ICWDGCs=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 601E2C14CE3F
 for <bpf@vger.kernel.org>; Sat, 25 May 2024 08:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1716651225; bh=HmzY/e6/lrsYHcYzUC4KA8e0GCzuXfBjW5ubZ6NBYQw=;
 h=From:To:Date:CC:Subject:List-Id:List-Archive:List-Help:List-Owner:
 List-Post:List-Subscribe:List-Unsubscribe;
 b=lQmcOUqmlVoboa84upDN6KAVbZeQuXEDNtIplGknJFPEK3T7WP3C44YUJSi5uyM9r
 Idq0lhZ81+FJipi16CKC/K48zdeYwz8KeLZTuZm2w7LJlscnsuQd2PZF2oJzRXwTW6
 wYP+dgWzNQwsYb3kPcXKUjPHOjvxtfKvBoWM1UBA=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id E4271C14F60F
 for <bpf@ietfa.amsl.com>; Sat, 25 May 2024 08:33:39 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -6.845
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V9LRHed56Diy for <bpf@ietfa.amsl.com>;
 Sat, 25 May 2024 08:33:36 -0700 (PDT)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 14642C14F604
 for <bpf@ietf.org>; Sat, 25 May 2024 08:33:36 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1f082d92864so137453335ad.1
 for <bpf@ietf.org>; Sat, 25 May 2024 08:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1716651215; x=1717256015;
 darn=ietf.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WhgM3TzL1k+cJvnIJ9yiuydwQ2hP9//8jGA/WrlIoG8=;
 b=kYOd1CK6gZm8lW3q5WdNLQmbys/YDbS111UuTv5TwMgCC4Bc2B6Xp4lz+zOmpmvvLf
 Esrv5Fo6PqWOyNtJQktFg8wDqCJd1axZmIdObg+2QcEcHFRDXgU5g7LazX10+z88JK9e
 mbzpDEa6fT2gbl1esE5gO4/eTevhjG1TsXVASJ/1XHsEY+jbj687xWsotSGdWyrQcNpQ
 Va5+LNFpKOYg04d43egsXRDXIAV08N1KsIICEVgdUP6ZdiiATZN9tMI1fHAFVd2BHTAT
 gAYWpTT8mHuyCR5aboXUM7wouJIkIyuOXqna5aTGQ5qOBiduQ1DtoED6N2h6mzVq0dPm
 eQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716651215; x=1717256015;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WhgM3TzL1k+cJvnIJ9yiuydwQ2hP9//8jGA/WrlIoG8=;
 b=A85z0X6qtUuvD/hlnOWYhekGZedYRSuutRhGs3/UFu4/nsLAzmBjCBLzrulzAJXYQ9
 mtN2zBe8D9znr7Ub/X5mSPxQ1kSUGP/Bke8acEGybVgrKcBBizc/Dk3X0yHyNub5RNcn
 hb8BH14xyNB1llwxRUvVFs+GDuQoE6aIfl973yg7nXNAsAuaSkf5eRBnuIvBiQUnAXqA
 8xL9lJSNzO4anbcn3iqMclkyTZC8x9lNiPAoytdGlwAdMcKXmACqMgYLLzVLv9qcY9B4
 8b9Bol6U2soLX4aL+L/P/GQLyzRIkJPbhiqroZ44PL5tsbVyhcHzBBRquswnfhWRFQCR
 7Njw==
X-Gm-Message-State: AOJu0YxQ7wsvhRWQKV0/N231YxJvtPYzYo2keQdDCSj2pa7P63PuLpDr
 vHToRwmCaxCA4Q9QjrIUllJs3BQPH2nSIIWWK0YXrrKjAUySDs37
X-Google-Smtp-Source: AGHT+IEmDQZqj1300++gHaFZYQuNrJSs/0y3Sdlv2EkEsUW2Ya+rfHEBXre6C5l12oDbAJ4B7Us7tA==
X-Received: by 2002:a17:902:f68a:b0:1ea:cb6f:ee5b with SMTP id
 d9443c01a7336-1f44883876dmr63477225ad.38.1716651215310;
 Sat, 25 May 2024 08:33:35 -0700 (PDT)
Received: from localhost.localdomain (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c7cadf4sm31468335ad.109.2024.05.25.08.33.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 May 2024 08:33:34 -0700 (PDT)
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Date: Sat, 25 May 2024 08:33:32 -0700
Message-Id: <20240525153332.21355-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID-Hash: VXMPKSSYS7HYBLF75LAL46AVGP2TUFG7
X-Message-ID-Hash: VXMPKSSYS7HYBLF75LAL46AVGP2TUFG7
X-MailFrom: dthaler1968@googlemail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia; 
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
X-Mailman-Version: 3.3.9rc4
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_=5BPATCH_bpf-next=5D_bpf=2C_docs=3A_Clarify_call_local_o?=
 =?utf-8?q?ffset?=
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/ihI1175Pg574h-biBvimsce2ayA>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Original-From: Dave Thaler <dthaler1968@googlemail.com>
From: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>

SW4gdGhlIEp1bXAgaW5zdHJ1Y3Rpb25zIHNlY3Rpb24gaXQgZXhwbGFpbnMgdGhhdCB0aGUgb2Zm
c2V0IGlzDQoicmVsYXRpdmUgdG8gdGhlIGluc3RydWN0aW9uIGZvbGxvd2luZyB0aGUganVtcCBp
bnN0cnVjdGlvbiIuDQpCdXQgdGhlIHByb2dyYW0tbG9jYWwgc2VjdGlvbiBjb25mdXNpbmdseSBz
YWlkICJyZWZlcmVuY2VkIGJ5DQpvZmZzZXQgZnJvbSB0aGUgY2FsbCBpbnN0cnVjdGlvbiwgc2lt
aWxhciB0byBKQSIuDQoNClRoaXMgcGF0Y2ggdXBkYXRlcyB0aGF0IHNlbnRlbmNlIHdpdGggY29u
c2lzdGVudCB3b3JkaW5nLCBzYXlpbmcNCml0J3MgcmVsYXRpdmUgdG8gdGhlIGluc3RydWN0aW9u
IGZvbGxvd2luZyB0aGUgY2FsbCBpbnN0cnVjdGlvbi4NCg0KU2lnbmVkLW9mZi1ieTogRGF2ZSBU
aGFsZXIgPGR0aGFsZXIxOTY4QGdtYWlsLmNvbT4NCi0tLQ0KIERvY3VtZW50YXRpb24vYnBmL3N0
YW5kYXJkaXphdGlvbi9pbnN0cnVjdGlvbi1zZXQucnN0IHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRh
dGlvbi9icGYvc3RhbmRhcmRpemF0aW9uL2luc3RydWN0aW9uLXNldC5yc3QgYi9Eb2N1bWVudGF0
aW9uL2JwZi9zdGFuZGFyZGl6YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJzdA0KaW5kZXggMDBjOTNl
YjQyLi42YmI1YWU3ZTQgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2JwZi9zdGFuZGFyZGl6
YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJzdA0KKysrIGIvRG9jdW1lbnRhdGlvbi9icGYvc3RhbmRh
cmRpemF0aW9uL2luc3RydWN0aW9uLXNldC5yc3QNCkBAIC01MjAsNyArNTIwLDcgQEAgaWRlbnRp
ZmllcyB0aGUgaGVscGVyIG5hbWUgYW5kIHR5cGUuDQogUHJvZ3JhbS1sb2NhbCBmdW5jdGlvbnMN
CiB+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KIFByb2dyYW0tbG9jYWwgZnVuY3Rpb25zIGFyZSBm
dW5jdGlvbnMgZXhwb3NlZCBieSB0aGUgc2FtZSBCUEYgcHJvZ3JhbSBhcyB0aGUNCi1jYWxsZXIs
IGFuZCBhcmUgcmVmZXJlbmNlZCBieSBvZmZzZXQgZnJvbSB0aGUgY2FsbCBpbnN0cnVjdGlvbiwg
c2ltaWxhciB0bw0KK2NhbGxlciwgYW5kIGFyZSByZWZlcmVuY2VkIGJ5IG9mZnNldCBmcm9tIHRo
ZSBpbnN0cnVjdGlvbiBmb2xsb3dpbmcgdGhlIGNhbGwgaW5zdHJ1Y3Rpb24sIHNpbWlsYXIgdG8N
CiBgYEpBYGAuICBUaGUgb2Zmc2V0IGlzIGVuY29kZWQgaW4gdGhlICdpbW0nIGZpZWxkIG9mIHRo
ZSBjYWxsIGluc3RydWN0aW9uLg0KIEFuIGBgRVhJVGBgIHdpdGhpbiB0aGUgcHJvZ3JhbS1sb2Nh
bCBmdW5jdGlvbiB3aWxsIHJldHVybiB0byB0aGUgY2FsbGVyLg0KIA0KLS0gDQoyLjQwLjENCg0K
LS0gCkJwZiBtYWlsaW5nIGxpc3QgLS0gYnBmQGlldGYub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQg
YW4gZW1haWwgdG8gYnBmLWxlYXZlQGlldGYub3JnCg==

