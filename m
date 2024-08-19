Return-Path: <bpf+bounces-37552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AF6957784
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 00:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF355B21CAA
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 22:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0EE1DC49B;
	Mon, 19 Aug 2024 22:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="qhljrB5C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="qhljrB5C";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="cYhWgYG6"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AD71DC46C
	for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 22:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724106946; cv=none; b=tSQ3KyCuOwBXa13hnr+Lv427W31QJ7JdyoacOnPIHpcy4NQOtovGCVXs22ZQW3qnBp8yGsgj34UCuFoY4xAr7iYirflSgLlj7pBTcAZ+fdDyZdgoL/xgFPoHeaMcNGVQ8BhUd+HF3xIsT8L8eTpopaA+Rcm+PmvCT6eKbnvptUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724106946; c=relaxed/simple;
	bh=KTj2x9vP72woXYiQ69HNoeC+ADn9T1Xw8b/3iEewehc=;
	h=From:To:Date:Message-ID:MIME-Version:CC:Subject:Content-Type; b=IHqweOErJWjCVgbExHpithtg5Q+lMjeNK9HHhSQ27hDT5dcvcrv1eVmW7qJ8kMI4Xn45WrONgZ0Or8YXHcKYOKYz6G+3jw7rjPVyYURCMIWkkpeoBTrgm7+II2o38HYpeutlLQnPMSHAhjOpJPpKfVor7ZRVSw0a8YsDegp4k5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=qhljrB5C; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=qhljrB5C; dkim=fail (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b=cYhWgYG6 reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id CA332C18DB91
	for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 15:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1724106619; bh=KTj2x9vP72woXYiQ69HNoeC+ADn9T1Xw8b/3iEewehc=;
	h=From:To:Date:CC:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe;
	b=qhljrB5Cqo7cgdygIPVgcvW6mku00X7N74LX+I3ccfnKTWBuKhFhEd4sK9Iffu3i5
	 auQet/UQ2NuIjmfGfiS91FyvHlKw/lyaDcGgolnngJmW3+LKsFjc9iuRdEJCd+kql1
	 kRopihcghatBPxj4GMVwkgs511ln2iPZh3mn13ZI=
X-Mailbox-Line: From bpf-bounces+bpf=vger.kernel.org@ietf.org  Mon Aug 19 15:30:19 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id ABB57C180B4D
	for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 15:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1724106619; bh=KTj2x9vP72woXYiQ69HNoeC+ADn9T1Xw8b/3iEewehc=;
	h=From:To:Date:CC:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe;
	b=qhljrB5Cqo7cgdygIPVgcvW6mku00X7N74LX+I3ccfnKTWBuKhFhEd4sK9Iffu3i5
	 auQet/UQ2NuIjmfGfiS91FyvHlKw/lyaDcGgolnngJmW3+LKsFjc9iuRdEJCd+kql1
	 kRopihcghatBPxj4GMVwkgs511ln2iPZh3mn13ZI=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
	by ietfa.amsl.com (Postfix) with ESMTP id 6D054C1840E8
	for <bpf@ietfa.amsl.com>; Mon, 19 Aug 2024 15:30:17 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.907
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
	header.d=obs-cr.20230601.gappssmtp.com
Received: from mail.ietf.org ([50.223.129.194])
	by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KVb_H9Or8VHw for <bpf@ietfa.amsl.com>;
	Mon, 19 Aug 2024 15:30:16 -0700 (PDT)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by ietfa.amsl.com (Postfix) with ESMTPS id EAD6AC180B4D
	for <bpf@ietf.org>; Mon, 19 Aug 2024 15:30:11 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-39d37d9767dso9061935ab.3
        for <bpf@ietf.org>; Mon, 19 Aug 2024 15:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1724106611;
 x=1724711411; darn=ietf.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zlBO7op9yV0iOsawm3E4xQTL5C6nZ1QNeejEc0p0YVM=;
        b=cYhWgYG6gC1aVLh8hDhwvIfDrf7KTyDFRjewjs7b4ek3XFLNpE/+QdNg8fAoXr0Jub
         mpcYxaFWLZr07mq6De4ehXcfptAwRPJHEAoknqlW2/10yt1T+PUr6Unj+Nozh/t5YQY1
         N94AGLascBkn/mo5ZMwq2CpnQ+itRJO2FL0oxpOzqJwbQ9l5UmaHj8z7MclaKyyZqyn0
         gamqa5SUA2QgOa1pkFC488HTPY0qRsWzToqnw0AY8dzOKkmL1CTGruA0XbPzyE8YrZ8W
         cQqoWgLvRKExzgYT/d5p3lcGE8uqrLwf3JMCguvheEEOm6iEgpou+xz/N7IZZtfLfnW3
         +p6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724106611; x=1724711411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zlBO7op9yV0iOsawm3E4xQTL5C6nZ1QNeejEc0p0YVM=;
        b=JnW+m8KTO2C9/hLBezL6MJS7woCzT3dltuaCk1wrz791iOYhLNbEeGlC1z5tj+mO7C
         WrNQ7vvGhDydOho5Du6g7knHeXOhULXPtTO/28rhzwVP94r2p5/vaOtXo8kx5pFxdZja
         PivSyU7rds6jKySiUPyfq9cuOiRAKJAp6qrA1G7ikASKj745ChGKlejVjG1oB+Y4iouU
         uHR/HsWB8BZO39/kF/V6ekivX9WRqx++zV+d80OQUYjqbqUM0IIcAOqXT9BEsW8ruc+x
         KebPPR3FbgLGgnimWvW5AmmKWvz3J67oNJlh00oHPt5vwlV/MKA886wmc6Lu6KfhcWl6
         wBJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUExKoHrZzBDIfumbYk9S8mcnCVlcfR9Got7W29tbPZIaaGaXrcOToc+g5pLGEJAo+24ZM=@ietf.org
X-Gm-Message-State: AOJu0YwMoTEjYPetg8vpRXo9uIuEU5mI132SeJ6ucHc4a4KU3PXqi2IZ
	paKHbDoZz9Dp5S8ZB4bQoidelpd4A2aetUtr9kDQKvI5CM791K1ApjvlGIZqOmQ=
X-Google-Smtp-Source: 
 AGHT+IHmnzdQB1KFZi18yDin1p4609NZfm5womPqkarl0qMMm62alm/L7gBbuedvrFFFA4ECQ5e2eg==
X-Received: by 2002:a05:6e02:1d8e:b0:39d:189a:edf6 with SMTP id
 e9e14a558f8ab-39d26d64478mr107657435ab.22.1724106610652;
        Mon, 19 Aug 2024 15:30:10 -0700 (PDT)
Received: from ininer.rhod.uc.edu ([129.137.96.15])
        by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d1ec03069sm37092255ab.32.2024.08.19.15.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 15:30:10 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: bpf@vger.kernel.org,
	bpf@ietf.org
Date: Mon, 19 Aug 2024 18:30:06 -0400
Message-ID: <20240819223008.469271-1-hawkinsw@obs.cr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID-Hash: 57OBVOELUXOWY4MBA6M2LGUVGPXKPQAU
X-Message-ID-Hash: 57OBVOELUXOWY4MBA6M2LGUVGPXKPQAU
X-MailFrom: hawkinsw@obs.cr
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia;
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: Will Hawkins <hawkinsw@obs.cr>
X-Mailman-Version: 3.3.9rc4
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_=5BPATCH=5D_docs/bpf=3A_Add_constant_values_for_linkages?=
Archived-At: 
 <https://mailarchive.ietf.org/arch/msg/bpf/yKM03P1xhKU7FTNg30HSCp29kWU>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

TWFrZSB0aGUgdmFsdWVzIG9mIHRoZSBzeW1ib2xpYyBjb25zdGFudHMgdGhhdCBkZWZpbmUgdGhl
IHZhbGlkIGxpbmthZ2VzDQpmb3IgZnVuY3Rpb25zIGFuZCB2YXJpYWJsZXMgZXhwbGljaXQuDQoN
ClNpZ25lZC1vZmYtYnk6IFdpbGwgSGF3a2lucyA8aGF3a2luc3dAb2JzLmNyPg0KLS0tDQogRG9j
dW1lbnRhdGlvbi9icGYvYnRmLnJzdCB8IDQ0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0MCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9u
cygtKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9icGYvYnRmLnJzdCBiL0RvY3VtZW50
YXRpb24vYnBmL2J0Zi5yc3QNCmluZGV4IDI1N2E3ZTFjZGY1ZC4uY2NlMDNmMWU1NTJhIDEwMDY0
NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9icGYvYnRmLnJzdA0KKysrIGIvRG9jdW1lbnRhdGlvbi9i
cGYvYnRmLnJzdA0KQEAgLTM2OCw3ICszNjgsNyBAQCBObyBhZGRpdGlvbmFsIHR5cGUgZGF0YSBm
b2xsb3cgYGBidGZfdHlwZWBgLg0KICAgKiBgYGluZm8ua2luZF9mbGFnYGA6IDANCiAgICogYGBp
bmZvLmtpbmRgYDogQlRGX0tJTkRfRlVOQw0KICAgKiBgYGluZm8udmxlbmBgOiBsaW5rYWdlIGlu
Zm9ybWF0aW9uIChCVEZfRlVOQ19TVEFUSUMsIEJURl9GVU5DX0dMT0JBTA0KLSAgICAgICAgICAg
ICAgICAgICBvciBCVEZfRlVOQ19FWFRFUk4pDQorICAgICAgICAgICAgICAgICAgIG9yIEJURl9G
VU5DX0VYVEVSTiAtIHNlZSA6cmVmOmBCVEZfRnVuY3Rpb25fTGlua2FnZV9Db25zdGFudHNgKQ0K
ICAgKiBgYHR5cGVgYDogYSBCVEZfS0lORF9GVU5DX1BST1RPIHR5cGUNCiANCiBObyBhZGRpdGlv
bmFsIHR5cGUgZGF0YSBmb2xsb3cgYGBidGZfdHlwZWBgLg0KQEAgLTQyNCw5ICs0MjQsOSBAQCBm
b2xsb3dpbmcgZGF0YTo6DQogICAgICAgICBfX3UzMiAgIGxpbmthZ2U7DQogICAgIH07DQogDQot
YGBzdHJ1Y3QgYnRmX3ZhcmBgIGVuY29kaW5nOg0KLSAgKiBgYGxpbmthZ2VgYDogY3VycmVudGx5
IG9ubHkgc3RhdGljIHZhcmlhYmxlIDAsIG9yIGdsb2JhbGx5IGFsbG9jYXRlZA0KLSAgICAgICAg
ICAgICAgICAgdmFyaWFibGUgaW4gRUxGIHNlY3Rpb25zIDENCitgYGJ0Zl92YXIubGlua2FnZWBg
IG1heSB0YWtlIHRoZSB2YWx1ZXM6IEJURl9WQVJfU1RBVElDIChmb3IgYSBzdGF0aWMgdmFyaWFi
bGUpLA0KK29yIEJURl9WQVJfR0xPQkFMX0FMTE9DQVRFRCAoZm9yIGEgZ2xvYmFsbHkgYWxsb2Nh
dGVkIHZhcmlhYmxlIHN0b3JlZCBpbiBFTEYgc2VjdGlvbnMgMSkgLQ0KK3NlZSA6cmVmOmBCVEZf
VmFyX0xpbmthZ2VfQ29uc3RhbnRzYC4NCiANCiBOb3QgYWxsIHR5cGUgb2YgZ2xvYmFsIHZhcmlh
YmxlcyBhcmUgc3VwcG9ydGVkIGJ5IExMVk0gYXQgdGhpcyBwb2ludC4NCiBUaGUgZm9sbG93aW5n
IGlzIGN1cnJlbnRseSBhdmFpbGFibGU6DQpAQCAtNTQ5LDYgKzU0OSw0MiBAQCBUaGUgYGBidGZf
ZW51bTY0YGAgZW5jb2Rpbmc6DQogSWYgdGhlIG9yaWdpbmFsIGVudW0gdmFsdWUgaXMgc2lnbmVk
IGFuZCB0aGUgc2l6ZSBpcyBsZXNzIHRoYW4gOCwNCiB0aGF0IHZhbHVlIHdpbGwgYmUgc2lnbiBl
eHRlbmRlZCBpbnRvIDggYnl0ZXMuDQogDQorMi4zIENvbnN0YW50IFZhbHVlcw0KKy0tLS0tLS0t
LS0tLS0tLS0tLS0NCisNCisuLiBfQlRGX0Z1bmN0aW9uX0xpbmthZ2VfQ29uc3RhbnRzOg0KKw0K
KzIuMy4xIEZ1bmN0aW9uIExpbmthZ2UgQ29uc3RhbnQgVmFsdWVzDQorfn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCisuLiBsaXN0LXRhYmxlOjoNCisgICA6d2lkdGhzOiAx
IDENCisgICA6aGVhZGVyLXJvd3M6IDENCisNCisgICAqIC0gTmFtZQ0KKyAgICAgLSBWYWx1ZQ0K
KyAgICogLSBgYEJURl9GVU5DX1NUQVRJQ2BgDQorICAgICAtIGBgMGBgDQorICAgKiAtIGBgQlRG
X0ZVTkNfR0xPQkFMYGANCisgICAgIC0gYGAxYGANCisgICAqIC0gYGBCVEZfRlVOQ19FWFRFUk5g
YA0KKyAgICAgLSBgYDJgYA0KKw0KKy4uIF9CVEZfVmFyX0xpbmthZ2VfQ29uc3RhbnRzOg0KKw0K
KzIuMy4yIFZhcmlhYmxlIExpbmthZ2UgQ29uc3RhbnQgVmFsdWVzDQorfn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCisuLiBsaXN0LXRhYmxlOjoNCisgICA6d2lkdGhzOiAx
IDENCisgICA6aGVhZGVyLXJvd3M6IDENCisNCisgICAqIC0gTmFtZQ0KKyAgICAgLSBWYWx1ZQ0K
KyAgICogLSBgYEJURl9WQVJfU1RBVElDYGANCisgICAgIC0gYGAwYGANCisgICAqIC0gYGBCVEZf
VkFSX0dMT0JBTF9BTExPQ0FURURgYA0KKyAgICAgLSBgYDFgYA0KKw0KKw0KIDMuIEJURiBLZXJu
ZWwgQVBJDQogPT09PT09PT09PT09PT09PT0NCiANCi0tIA0KMi40NS4yDQoNCi0tIApCcGYgbWFp
bGluZyBsaXN0IC0tIGJwZkBpZXRmLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRv
IGJwZi1sZWF2ZUBpZXRmLm9yZwo=

