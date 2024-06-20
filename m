Return-Path: <bpf+bounces-32637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1298F9112A8
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 21:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB2F282EB0
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 19:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE251B9AAD;
	Thu, 20 Jun 2024 19:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="coQE4GQZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="zHq6Gzeb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Pm1hWHs5"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088681B5814
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 19:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718913566; cv=none; b=INKELXzm1/dwf02QzdfJIGZ/WqYWi8jjqbMlYagkcetqL/DNhXGlF5RphbMZNf8lhHVlPOz/eOo3FD7Xngq1JnaoKrWSbtgpWV7wT62fulDU52FIujJY+tIUOgtsol2A0U68yrHN752PAf6XygDQ1dPVPf/WLnRb1DdxO8m4PQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718913566; c=relaxed/simple;
	bh=mSU6jXAYrhaPz1VX2TX/05vQ8gD0p4MXmC/Jqo34t4w=;
	h=To:References:In-Reply-To:Date:Message-ID:MIME-Version:CC:Subject:
	 Content-Type:From; b=qiLmY6cmwARM3If3fLJFN+Q6j2O/tvqVjtMLNzL2awryvHNnK75R/aHqHA+EdGhiz6qr7Asm+sxf93CJhNhDVi4eEuhATZLt/qzymhQ8HfljmloxgeJ/qDeSw07LBeAnzTb8qWj7TSA5kXBQLMGWp0PwvMYTZ7cdqBE2GqcGivY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=coQE4GQZ; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=zHq6Gzeb reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Pm1hWHs5 reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 25781C180B64
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 12:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1718913558; bh=mSU6jXAYrhaPz1VX2TX/05vQ8gD0p4MXmC/Jqo34t4w=;
	h=To:References:In-Reply-To:Date:CC:Subject:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=coQE4GQZ3HXcFZf1ODXWdV4fXyED6ZyyapX10SiYRS10RHP2FkI4qtj7F+45wLvW8
	 6UItnAFgXHCybyv/eg8x9Gmy8Sf8gzvOEU82DmWBKwuM1qY/3jgZl4/5IsFfpmnW3S
	 MaZ4xELjtdeCc/AyqcgSz1xJzq532d4Q1B3yb5NM=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 19D24C1CAE68
 for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 12:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1718913558; bh=mSU6jXAYrhaPz1VX2TX/05vQ8gD0p4MXmC/Jqo34t4w=;
 h=From:To:References:In-Reply-To:Date:CC:Subject:List-Id:
 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
 List-Unsubscribe;
 b=zHq6Gzeb8jgUOr9l4S12KIfgD9N0C2c/uszfaI//iz44yLLbGYcFKE8/4VBsQb0dK
 JFuAiKBJS/EL1HdNWnj4QrRyU6rV0bQkSrNONh9bX9+i+zc2Ln80rioKBy0Tg/zYtk
 hMQjKqExNhG6Gqr2pL+rxFVCcIRsk8NDUVtC8jtg=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 28BCEC1840CB;
 Thu, 20 Jun 2024 12:58:28 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.856
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tVevt-JfTXp7; Thu, 20 Jun 2024 12:58:23 -0700 (PDT)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id B4683C15154E;
 Thu, 20 Jun 2024 12:58:23 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-63bf3452359so13083287b3.2;
 Thu, 20 Jun 2024 12:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1718913502; x=1719518302;
 darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=zcvZYLOScb+/oW3/WVg/h2Scd9FY9aOUmiQFOB/rav8=;
 b=Pm1hWHs5DX5yHHhBcAUjeEUR36/TOdj/XE3OSLjxb4ry9QN2iCi1An1AonlnF2l4os
 7lcMwoF+WXhcKoCe3ovI+6zgICI4koWVsftmxLg4FENNPIHaCRuwZjxJq+GAO2YHaAP3
 6YpZ20GL+JLHlGevDb52t6G2n9lShEY+I5/3BiyYwmfxAizG+m0QK6WAm163yXePWBWN
 kb8groaOyWuxJfY9Q9I0WxYkkZosG3D6zCinm0dWIb8Af4rTtBt7Au5k4hyXjjycrCD/
 JVkgT4XKYOhORXejtGXOOVDFCZs1FWf2AUqSfpwJBluRw8meQITLC2ZXEAME8RQgAjWI
 4Yew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718913502; x=1719518302;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zcvZYLOScb+/oW3/WVg/h2Scd9FY9aOUmiQFOB/rav8=;
 b=s/QRIr/hiG5ZI/s2xw/YIDOTGy8RNyvr3+qVrw3E5PnXysH18bBCJHRyBYiatz2Kkf
 hgniEhAoD4cZVV7vKkacmmNDlA+6ief7tCiTb6KgVSKElVVvYOV3AKmDJQD9MJpGF97B
 JuEULtxGSfdfwdpKHegfkUUDfE/F77PoXE4XBehC81swpFCPD9zJBjZ/3oHSJ9Nxpj8n
 FiTlU5J7yJn+IRUAGa5NAkTar7i57j93EefErQzmF6XYvJEsGxIt4C66+97ySguUTTE7
 Y6CCdrCBhp2xq0Ci4fvDwIifgckQTM37ImAVWHpld4TlrU3WchzUJ+XINVjPqdUgCiUA
 Tj9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7jIRZsVwFIObIU6GIi7nmSwnJ+5TDLhhlz2DFCaT6vkdBdK2+4pkVqtd1trSViUW7eoJM9u5X301uD1BAX3bM882NFWYhgoW5W4RhQES2bZE=
X-Gm-Message-State: AOJu0YzFPxm10gT0bMtxhlFAJwcbPwqxLQkEtuC/fHMVPTTP+xNeqokg
 HuCdbiDaIB7C39Helmt0emakklnLuQCOax28g+jnJSp8YWu1Fz5pJC4wfw==
X-Google-Smtp-Source: AGHT+IGJq4cY0j8YwGaRz0X6OJ5+wPEuke1d7oG1DHMJqKedr89nqQFYGg8juiMCl0/7/gGkyylGUg==
X-Received: by 2002:a0d:c1c2:0:b0:627:778f:b0a8 with SMTP id
 00721157ae682-63a8fddc0a0mr66997317b3.42.1718913501931;
 Thu, 20 Jun 2024 12:58:21 -0700 (PDT)
Received: from ArmidaleLaptop ([2600:381:bf1c:7784:eca4:cc56:8003:c9fb])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-63f154d5df7sm303737b3.107.2024.06.20.12.58.19
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2024 12:58:21 -0700 (PDT)
X-Google-Original-From: "Dave Thaler" <dthaler1968@gmail.com>
To: =?utf-8?Q?'=C3=89ric_Vyncke'?= <evyncke@cisco.com>,
 <gunter.van_de_velde@nokia.com>
References: <171811793126.62184.9537540105321678706@ietfa.amsl.com>
In-Reply-To: <171811793126.62184.9537540105321678706@ietfa.amsl.com>
Date: Thu, 20 Jun 2024 12:58:16 -0700
Message-ID: <1b3301dac34c$3347df50$99d79df0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdrDTCZXKUDNVTXeTPW8fVu0QvWxug==
Content-Language: en-us
Message-ID-Hash: P4XFIQHATAWDM5XZ2PWPYDLGPVVHEXBS
X-Message-ID-Hash: P4XFIQHATAWDM5XZ2PWPYDLGPVVHEXBS
X-MailFrom: dthaler1968@googlemail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia; 
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: draft-ietf-bpf-isa@ietf.org, bpf-chairs@ietf.org, bpf@ietf.org,
 void@manifault.com, bpf@vger.kernel.org
X-Mailman-Version: 3.3.9rc4
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_BPF/eBPF_non-acronym_feedback_from_Gunter_Van_de_Velde_a?=
 =?utf-8?q?nd_=C3=89ric_Vyncke?=
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/yI3vl12akSke2KfVR7g2pKfglog>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Original-From: Dave Thaler <dthaler1968@googlemail.com>
From: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>

R3VudGVyIFZhbiBkZSBWZWxkZSwgUlRHIEFELCB3cm90ZToNCj4gPiAxMiBlQlBGICh3aGljaCBp
cyBubyBsb25nZXIgYW4gYWNyb255bSBmb3IgYW55dGhpbmcpLCBhbHNvIGNvbW1vbmx5DQo+DQo+
IEkgYXNzdW1lZCB0aGF0ICdlJyB3YXMgZm9yICdleHRlbmRlZCcgYW5kIHRoYXQgQlBGIHN0YW5k
cyBmb3IgJ0JTRCBQYWNrZXQNCj4gRmlsdGVyJyBvcmlnaW5hbGx5IGRlc2NyaWJlZCBhbmQgc3Bl
Y2lmaWVkIGluIGEgcGFwZXIgdGl0bGVkICJUaGUgQlNEDQo+IFBhY2tldCBGaWx0ZXI6IEEgTmV3
IEFyY2hpdGVjdHVyZSBmb3IgVXNlci1sZXZlbCBQYWNrZXQgQ2FwdHVyZSIgYnkNCj4gU3RldmVu
IE1jQ2FubmUgYW5kIFZhbiBKYWNvYnNvbiwgcHJlc2VudGVkIGF0IHRoZSAxOTkzIFdpbnRlcg0K
PiBVU0VOSVggQ29uZmVyZW5jZS4gVGhpcyBwYXBlciBpbnRyb2R1Y2VkIHRoZSBCUEYgYXJjaGl0
ZWN0dXJlLCB3aGljaA0KPiB3YXMgZGVzaWduZWQgZm9yIGVmZmljaWVudCBwYWNrZXQgZmlsdGVy
aW5nIGFuZCBjYXB0dXJlLg0KPg0KPiBIZW5jZSBhIGJpdCBzdXJwcmlzZWQgd2h5IHRoZSBmaXJz
dCB3b3JkcyBvZiB0aGUgZmlyc3QgbGluZSBpbg0KPiB0aGUgZmlyc3QgcGFyYWdyYXBoIG9mIHRo
ZSBkcmFmdCBhYnN0cmFjdCBzdWdnZXN0IHRoYXQgaXRzDQo+IG5vdCBhbiBhY3JvbnltPw0KDQrD
iXJpYyBWeW5ja2Ugd3JvdGU6IA0KPiDDiXJpYyBWeW5ja2UgaGFzIGVudGVyZWQgdGhlIGZvbGxv
d2luZyBiYWxsb3QgcG9zaXRpb24gZm9yDQo+IGRyYWZ0LWlldGYtYnBmLWlzYS0wMzogWWVzDQo+
IA0KPiBXaGVuIHJlc3BvbmRpbmcsIHBsZWFzZSBrZWVwIHRoZSBzdWJqZWN0IGxpbmUgaW50YWN0
IGFuZCByZXBseSB0byBhbGwgZW1haWwgYWRkcmVzc2VzDQo+IGluY2x1ZGVkIGluIHRoZSBUbyBh
bmQgQ0MgbGluZXMuIChGZWVsIGZyZWUgdG8gY3V0IHRoaXMgaW50cm9kdWN0b3J5IHBhcmFncmFw
aCwNCj4gaG93ZXZlci4pDQo+IA0KPiANCj4gUGxlYXNlIHJlZmVyIHRvIGh0dHBzOi8vd3d3Lmll
dGYub3JnL2Fib3V0L2dyb3Vwcy9pZXNnL3N0YXRlbWVudHMvaGFuZGxpbmctYmFsbG90LQ0KPiBw
b3NpdGlvbnMvDQo+IGZvciBtb3JlIGluZm9ybWF0aW9uIGFib3V0IGhvdyB0byBoYW5kbGUgRElT
Q1VTUyBhbmQgQ09NTUVOVCBwb3NpdGlvbnMuDQo+IA0KPiANCj4gVGhlIGRvY3VtZW50LCBhbG9u
ZyB3aXRoIG90aGVyIGJhbGxvdCBwb3NpdGlvbnMsIGNhbiBiZSBmb3VuZCBoZXJlOg0KPiBodHRw
czovL2RhdGF0cmFja2VyLmlldGYub3JnL2RvYy9kcmFmdC1pZXRmLWJwZi1pc2EvDQo+IA0KPiAN
Cj4gDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gQ09NTUVOVDoNCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiANCj4g
TmljZSBkb2N1bWVudCwgZWFzeSB0byByZWFkIGFuZCB1bmRlcnN0YW5kIGFuZCB0aGUgc2hlcGhl
cmQncyB3cml0ZS11cA0KPiBjb21wYW5pb24gaXMgYWxzbyBjbGVhci4NCj4gDQo+IEp1c3QgdHdv
IENPTU1FTlRzIChubyBuZWVkIHRvIHJlcGx5LCBidXQgcmVwbGllcyB3aWxsIGJlIGFwcHJlY2lh
dGVkKToNCj4gDQo+IDEpIGxpa2UgR3VudGVyLCBoYXZpbmcgYW4gZXhwYW5zaW9uIHRvICJlQlBG
IGlzIHJlbGF0ZWQgb3IgaXMgdGhlIHN1Y2Nlc3NvciBvZg0KPiBleHRlbmRlZCBCZXJrZWxleSBQ
YWNrZXQgRmlsdGVyIiB3b3VsZCBjb21mb3J0IHRoZSByZWFkZXJzIGFib3V0IHdoYXQgdGhleSBh
cmUNCj4gcmVhZGluZy4NCg0KVGhlIGV4aXN0aW5nIHRleHQgaXMgZGVyaXZlZCBmcm9tIHdoYXQg
aXMgYXQgaHR0cHM6Ly9lYnBmLmlvL3doYXQtaXMtZWJwZi8NCmFuZCBhIG11Y2ggbG9uZ2VyIGV4
cG9zaXRpb24gd291bGQgYmUgbW9yZSBhcHByb3ByaWF0ZSBmb3IgYSBkaWZmZXJlbnQgZG9jdW1l
bnQgb24gdGhlIFdHIGNoYXJ0ZXIgKCJbSV0gYW4gYXJjaGl0ZWN0dXJlIGFuZCBmcmFtZXdvcmsg
ZG9jdW1lbnQiKS4NCg0KSG93ZXZlciwgaHR0cHM6Ly9lYnBmLmlvL3doYXQtaXMtZWJwZi8jd2hh
dC1kby1lYnBmLWFuZC1icGYtc3RhbmQtZm9yIGRvZXMgaGF2ZSB0aGUgRkFRIGFuc3dlciBmb3Ig
IldoYXQgZG8gZUJQRiBhbmQgQlBGIHN0YW5kIGZvcj8iOg0KDQo+IEJQRiBvcmlnaW5hbGx5IHN0
b29kIGZvciBCZXJrZWxleSBQYWNrZXQgRmlsdGVyLCBidXQgbm93IHRoYXQgZUJQRg0KPiAoZXh0
ZW5kZWQgQlBGKSBjYW4gZG8gc28gbXVjaCBtb3JlIHRoYW4gcGFja2V0IGZpbHRlcmluZywgdGhl
IGFjcm9ueW0NCj4gbm8gbG9uZ2VyIG1ha2VzIHNlbnNlLiBlQlBGIGlzIG5vdyBjb25zaWRlcmVk
IGEgc3RhbmRhbG9uZSB0ZXJtIHRoYXQNCj4gZG9lc27igJl0IHN0YW5kIGZvciBhbnl0aGluZy4g
SW4gdGhlIExpbnV4IHNvdXJjZSBjb2RlLCB0aGUgdGVybSBCUEYNCj4gcGVyc2lzdHMsIGFuZCBp
biB0b29saW5nIGFuZCBpbiBkb2N1bWVudGF0aW9uLCB0aGUgdGVybXMgQlBGIGFuZCBlQlBGDQo+
IGFyZSBnZW5lcmFsbHkgdXNlZCBpbnRlcmNoYW5nZWFibHkuIFRoZSBvcmlnaW5hbCBCUEYgaXMg
c29tZXRpbWVzDQo+IHJlZmVycmVkIHRvIGFzIGNCUEYgKGNsYXNzaWMgQlBGKSB0byBkaXN0aW5n
dWlzaCBpdCBmcm9tIGVCUEYuDQoNClRoYXQgcGFyYWdyYXBoLCBvciBzb21lIHZhcmlhdGlvbiBv
ZiBpdCwgd291bGQgaW4gbXkgb3BpbmlvbiBiZSBhcHByb3ByaWF0ZQ0KaW4gdGhlIGFyY2hpdGVj
dHVyZS8gZnJhbWV3b3JrIGRvY3VtZW50LCBidXQgZG8gd2UgcmVhbGx5IHdhbnQgaXQgaW4gKmV2
ZXJ5Kg0Kb3RoZXIgZG9jdW1lbnQgZnJvbSB0aGUgV0c/ICBUaGF0IHdvdWxkIHNlZW0gbmVlZGxl
c3NseSByZWR1bmRhbnQgdG8gbWUuDQoNClRoZXJlIGFyZSBwbGVudHkgb2YgZXhhbXBsZXMgaW4g
dGhlIHdvcmxkIG9mIHRoaW5ncyB0aGF0IHN0YXJ0ZWQgYXMgYWNyb255bXMNCmFuZCBubyBsb25n
ZXIgc3RhbmQgZm9yIGFueXRoaW5nIGFuZCBzbyBhcmUgbm90IGV4cGFuZGVkIChBVCZULA0KTlBS
LCBDQlMsIDNNLCBTT1MsIGV0Yy4pICAgU2VlDQpodHRwOi8vYmxvZy53cml0ZWF0aG9tZS5jb20v
aW5kZXgucGhwLzIwMTMvMTAvMTItaW5pdGlhbHMtdGhhdC1zdGFuZC1mb3Itbm90aGluZy8NCmZv
ciBvbmUgb2YgbWFueSBhcnRpY2xlcyB3aXRoIGEgbGlzdCBvZiBzdWNoIHRlcm1zLCBidXQgd2Vi
IHNlYXJjaGVzIHdpbGwgdHVybg0KdXAgcGxlbnR5IG9mIG90aGVyIHJlZmVyZW5jZXMuDQoNClRy
eWluZyB0byBleHBsYWluIGluIGV2ZXJ5IG5ld3MgYXJ0aWNsZSB0aGF0IHVzZXMNCm9uZSBvZiB0
aG9zZSB0ZXJtcyB3aGF0IGl0IG9yaWdpbmFsbHkgc3Rvb2QgZm9yIGJ1dCBkb2Vzbid0IGFueSBt
b3JlLCBkb2Vzbid0DQpzZWVtIHBhcnRpY3VsYXJseSBoZWxwZnVsIHRvIG1lIGFuZCBjZXJ0YWlu
bHkgaXNuJ3QgY29tbW9ubHkgZG9uZS4NCg0KRGF2ZQ0KDQotLSAKQnBmIG1haWxpbmcgbGlzdCAt
LSBicGZAaWV0Zi5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBicGYtbGVhdmVA
aWV0Zi5vcmcK

