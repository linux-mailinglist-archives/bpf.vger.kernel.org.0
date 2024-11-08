Return-Path: <bpf+bounces-44375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 189989C24F6
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 19:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97C101F23990
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 18:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FF21A9B41;
	Fri,  8 Nov 2024 18:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="OtiEO0h5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="fHQ0HyNR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7+lFvwf"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5601A9B3C
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 18:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731091126; cv=none; b=DAoULgoVOiiVjiaZa7Y76cPd4gF5GC6VoLonhKnU44rdjsivszKZkkL4EiL7SmsnsZrFZxcy63DwpMByWzMBwTmzwYN/6PFdzhxmrTo4qroAweK/9kt4TRTORzJbh6oG/nBtK017lL3w44AO6e4DagSgif3EsJSUNOpb8o0o6YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731091126; c=relaxed/simple;
	bh=fgzB9WLETvn6FrgSP0cgl69T+lhBKfHXM0glC2SXtT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:To:CC:
	 Subject:Content-Type; b=PJv6GXYsH/DwftM+iaUEZbf+tLgcuwmqus//sDCAHskgjkEsvadcEKbm8PW/6/8joBCDqc9ZzpYYih+WFb1QKoEEqsg2y/vr0Ue5BkAd/XlQ54CahWb57O5Dqh7eJFYmkH7PdJrb9klxwOghn2La+AF1M9MIvta7JZl7grQMO58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=OtiEO0h5; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=fHQ0HyNR; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7+lFvwf reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 07731C1D4CCD
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 10:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1731091124; bh=fgzB9WLETvn6FrgSP0cgl69T+lhBKfHXM0glC2SXtT8=;
	h=References:In-Reply-To:From:Date:To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=OtiEO0h52ZaFlUVY381PIlVNeI4XkNQK96KiT377EIMN8O9cvRUOLeVl0jT2JjXui
	 SKVqRI8kFppCFeRu1uJKCFCVuhoc3T+EedJ9EOxvDg+sLeCtIwerd/xJV6OOPLwRbr
	 ICYxxU8FmfNVnD7sNoeY1KaxwFYj3nSMhl8XgBgc=
X-Mailbox-Line: From bpf-bounces+bpf=vger.kernel.org@ietf.org  Fri Nov  8 10:38:43 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id D80DDC1D5316
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 10:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1731091123; bh=fgzB9WLETvn6FrgSP0cgl69T+lhBKfHXM0glC2SXtT8=;
	h=References:In-Reply-To:From:Date:To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=fHQ0HyNRR17owO/BWhONw4NPELQRwUDMDZ8L37522KS2RvFLwWcvUrYqb1edpJivT
	 jTJgS097JyixjD5yk8oiBldKaKGmPllBCMIoaUVww3BL2mkjPYAeED67TiaQ6N4Pii
	 hzhGhXBhtmab/RaHCqDL4fif74ZOuapszOU4r5DY=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
	by ietfa.amsl.com (Postfix) with ESMTP id 582C9C169429
	for <bpf@ietfa.amsl.com>; Fri,  8 Nov 2024 10:38:33 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.106
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
	header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
	by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xQXa_fo7Whcx for <bpf@ietfa.amsl.com>;
	Fri,  8 Nov 2024 10:38:29 -0800 (PST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by ietfa.amsl.com (Postfix) with ESMTPS id 83563C18DB80
	for <bpf@ietf.org>; Fri,  8 Nov 2024 10:38:29 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43155abaf0bso22315245e9.0
        for <bpf@ietf.org>; Fri, 08 Nov 2024 10:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731091108; x=1731695908; darn=ietf.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zIiMHXCn8GO3wjMXnWJoqz2jTfy5Whqa2GXeUkA2KI=;
        b=f7+lFvwfIpgzN2qaX5lfVfmjeicpgS9NCdm8x/pCGVmV5U6a3dBdbemje2tCnblXIq
         vDvFrds5yHaOSr+BHZpwKHTbbLIdyZM3zkM3gkFPinQS8x+Sm+2SWBCk9vRukto2tTng
         0Cs9OfGpcwxYfot4nElIpVeUZ0Lhtmcle5M1gQ9YWdsp8YBFRQbIPdgWmZDiQu/UY0vy
         5/p/xvfTvXxzHKElLcBSTndT2Nhh1GViKrPgqGvCzyADzdQhorjK0BenmSVWuSrpEcMQ
         L2dyFNinqF2fU3GxZOArWY2JWN5orCM5j64+0rbFPysh0g6D/VZufj8EJpUGvwpBoq4u
         S5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731091108; x=1731695908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zIiMHXCn8GO3wjMXnWJoqz2jTfy5Whqa2GXeUkA2KI=;
        b=i0pXGxLHLkRfmStdvk5r2sgMWFD7mXRxKOlcpb9rNzbqQGiri6FA0uynP4o6voXCmk
         YPXC/G+oIxT5rw8olXmb39K7QrRcbOXoVh3+CLm83s5hAsTQhTNo8dLqm9Waiwc4XGOh
         LMbgNMHrGRKzKxhp4O1fFb/vqursa8lLLLpWIVrx1DSYAnLYjS4GwtUky78BvndoFGDV
         nALNmv5VhnCAEEU5xw+blRYcLAI3Sa3wIkAepPtlvv+nSIBDYbUEiT0P2Bs/jyRB29b1
         nLpC6sbCrdLT8dXrT0Mov70qwXA4rIep+2uTqrR39OzZPbQtYx2RFc9iMk5oIhttsCxm
         NuDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwIz32TZ+VU5nd5NzJvpFoas0aE0rWu8iNXGeXtOy4fcnt7ha6Z35N+vO+QvO5oYo7PXQ=@ietf.org
X-Gm-Message-State: AOJu0YzN6jLqSLsbS0nHM/WoAyvbrfpdaAUdguR11tPCTWvDvujuBuIp
	7gqvIIyVscxUX89en97I0d7zegI1vrr1znDV70yc9rTfK4z5yyzlqfNI7x7SnHYf2duKEV4joCT
	qbqqQMYGVPPecFF7g45JoY86UcAE=
X-Google-Smtp-Source: 
 AGHT+IHjoQgBL0kJXlbhWSeGhscglfi3McNpI1x0JYhFBBtvKjRQU6Md1q+N8Vav3koZeSpE6+fU9DAVIgKFeQFloOI=
X-Received: by 2002:a05:600c:1c98:b0:426:6edf:6597 with SMTP id
 5b1f17b1804b1-432b750a358mr33550055e9.19.1731091107756; Fri, 08 Nov 2024
 10:38:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927033904.2702474-1-yonghong.song@linux.dev>
 <CAADnVQJZLRnT3J31CLB85by=SmC2UY1pmUZX0kkyePtVdTdy9A@mail.gmail.com>
 <e93729b5-199f-4809-84f5-7efdf7c8aaf3@linux.dev>
 <181301db143b$ba6fd9c0$2f4f8d40$@gmail.com>
 <CAADnVQKDwZ0+Fjiz21AFAbOgEonVojvpojU1ZyQDu8V4Jm0DYQ@mail.gmail.com>
 <000c01db3186$1dd30930$59791b90$@gmail.com>
In-Reply-To: <000c01db3186$1dd30930$59791b90$@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 Nov 2024 10:38:16 -0800
Message-ID: 
 <CAADnVQKHHvrJjAMuXC5-wQHfMfxoSXnOBnqrZ5PC7p3C8ut3rQ@mail.gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Message-ID-Hash: IH7FNG5H3TYZ23DSPUMKYGZTUNUDV6HA
X-Message-ID-Hash: IH7FNG5H3TYZ23DSPUMKYGZTUNUDV6HA
X-MailFrom: alexei.starovoitov@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia;
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: Yonghong Song <yonghong.song@linux.dev>, bpf@ietf.org,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>
X-Mailman-Version: 3.3.9rc6
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_=5BPATCH_bpf-next=5D_docs/bpf=3A_Document_some_spe?=
	=?utf-8?q?cial_sdiv/smod_operations?=
Archived-At: 
 <https://mailarchive.ietf.org/arch/msg/bpf/Sw1Kfdknb47OdxsYYMk0l6GyVz0>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gVGh1LCBOb3YgNywgMjAyNCBhdCA2OjMw4oCvUE0gRGF2ZSBUaGFsZXIgPGR0aGFsZXIxOTY4
QGdvb2dsZW1haWwuY29tPiB3cm90ZToNCj4NCj4NCj4gQWxleGVpIFN0YXJvdm9pdG92IDxhbGV4
ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToNCj4gPiBPbiBUdWUsIE9jdCAxLCAyMDI0
IGF0IDEyOjU04oCvUE0gRGF2ZSBUaGFsZXIgPGR0aGFsZXIxOTY4QGdvb2dsZW1haWwuY29tPg0K
PiA+IHdyb3RlOg0KPiBbLi4uXQ0KPiA+ID4gSSdtIGFkZGluZyBicGZAaWV0Zi5vcmcgdG8gdGhl
IFRvIGxpbmUgc2luY2UgYWxsIGNoYW5nZXMgaW4gdGhlDQo+ID4gPiBzdGFuZGFyZGl6YXRpb24g
ZGlyZWN0b3J5IHNob3VsZCBpbmNsdWRlIHRoYXQgbWFpbGluZyBsaXN0Lg0KPiA+ID4NCj4gPiA+
IFRoZSBXRyBzaG91bGQgZGlzY3VzcyB3aGV0aGVyIGFueSBjaGFuZ2VzIHNob3VsZCBiZSBkb25l
IHZpYSBhIG5ldyBSRkMNCj4gPiA+IHRoYXQgb2Jzb2xldGVzIHRoZSBmaXJzdCBvbmUsIG9yIGFz
IFJGQ3MgdGhhdCBVcGRhdGUgYW5kIGp1c3QgZGVzY3JpYmUNCj4gPiA+IGRlbHRhcyAoYWRkaXRp
b25zLCBldGMuKS4NCj4gPiA+DQo+ID4gPiBUaGVyZSBhcmUgcHJlY2VkZW50cyBib3RoIHdheXMg
YW5kIEkgZG9uJ3QgaGF2ZSBhIHN0cm9uZyBwcmVmZXJlbmNlLA0KPiA+ID4gYnV0IEkgaGF2ZSBh
IHdlYWsgcHJlZmVyZW5jZSBmb3IgZGVsdGEtYmFzZWQgb25lcyBzaW5jZSB0aGV5J3JlDQo+ID4g
PiBzaG9ydGVyIGFuZCBhcmUgbGVzcyBsaWtlbHkgdG8gcmUtb3BlbiBkaXNjdXNzaW9uIG9uIHBy
ZXZpb3VzbHkNCj4gPiA+IHJlc29sdmVkIGlzc3VlcywgdGh1cyBvZnRlbiBzYXZpbmcgdGhlIFdH
IHRpbWUuDQo+ID4NCj4gPiBEZWx0YS1iYXNlZCBhZGRpdGlvbnMgbWFrZSBzZW5zZSB0byBtZS4N
Cj4gPg0KPiA+ID4gQWxzbyBGWUkgdG8gTGludXgga2VybmVsIGZvbGtzOg0KPiA+ID4gV2l0aCBX
RyBhbmQgQUQgYXBwcm92YWwsIGl0J3MgYWxzbyBwb3NzaWJsZSAoYnV0IG5vdCBpZGVhbCkgdG8g
dGFrZQ0KPiA+ID4gY2hhbmdlcyBhdCBBVVRINDguICBUaGF0J2QgYmUgdXAgdG8gdGhlIGNoYWly
cyBhbmQgQUQgdG8gZGVjaWRlDQo+ID4gPiB0aG91Z2gsIGFuZCBub3JtYWxseSB0aGF0J3MganVz
dCBmb3IgcHVyZWx5IGVkaXRvcmlhbCBjbGFyaWZpY2F0aW9ucywNCj4gPiA+IGUuZy4sIHRvIGNv
bmZ1c2lvbiBjYWxsZWQgb3V0IGJ5IHRoZSBSRkMgZWRpdG9yIHBhc3MuDQo+ID4NCj4gPiBBbHNv
IGFncmVlLiBXZSBzaG91bGQga2VlcCBBVVRIIGdvaW5nIGl0cyBjb3Vyc2UgYXMtaXMuDQo+ID4g
QWxsIElTQSBhZGRpdGlvbnMgY2FuIGJlIGluIHRoZSBmdXR1cmUgZGVsdGEgUkZDLg0KPiA+DQo+
ID4gQXMgZmFyIGFzIGZpbGUgbG9naXN0aWNzLi4uIG15IHByZWZlcmVuY2UgaXMgdG8ga2VlcA0K
PiA+IERvY3VtZW50YXRpb24vYnBmL3N0YW5kYXJkaXphdGlvbi9pbnN0cnVjdGlvbi1zZXQucnN0
DQo+ID4gdXAgdG8gZGF0ZS4NCj4gPiBSaWdodCBub3cgaXQncyBlZmZlY3RpdmVseSBmcm96ZW4g
d2hpbGUgYXdhaXRpbmcgY2hhbmdlcyAoaWYgYW55KSBuZWNlc3NhcnkgZm9yIEFVVEguDQo+ID4g
QWZ0ZXIgb2ZmaWNpYWwgUkZDIGlzIGlzc3VlZCB3ZSBjYW4gc3RhcnQgbGFuZGluZyBwYXRjaGVz
IGludG8gaW5zdHJ1Y3Rpb24tc2V0LnJzdCBhbmQNCj4gPiBnaXQgZGlmZiAwNGVmYWViZDcyZDEu
LndoYXRldmVyX2Z1dHVyZV9zaGEgaW5zdHJ1Y3Rpb24tc2V0LnJzdCB3aWxsIGF1dG9tYXRpY2Fs
bHkNCj4gPiBnZW5lcmF0ZSB0aGUgZnV0dXJlIGRlbHRhIFJGQy4NCj4gPiBPbmNlIFJGQyBudW1i
ZXIgaXMgaXNzdWVkIHdlIGNhbiBhZGQgYSBnaXQgdGFnIGZvciB0aGUgcGFydGljdWxhciBzaGEg
dGhhdCB3YXMgdGhlDQo+ID4gYmFzZSBmb3IgUkZDIGFzIGEgZG9jdW1lbnRhdGlvbiBzdGVwIGFu
ZCB0byBzaW1wbGlmeSBmdXR1cmUgJ2dpdCBkaWZmJy4NCj4NCj4gTXkgY29uY2VybiBpcyB0aGF0
IGluZGV4LnJzdCBzYXlzOg0KPiA+IFRoaXMgZGlyZWN0b3J5IGNvbnRhaW5zIGRvY3VtZW50cyB0
aGF0IGFyZSBiZWluZyBpdGVyYXRlZCBvbiBhcyBwYXJ0IG9mIHRoZSBCUEYNCj4gPiBzdGFuZGFy
ZGl6YXRpb24gZWZmb3J0IHdpdGggdGhlIElFVEYuIFNlZSB0aGUgYElFVEYgQlBGIFdvcmtpbmcg
R3JvdXBgXyBwYWdlDQo+ID4gZm9yIHRoZSB3b3JraW5nIGdyb3VwIGNoYXJ0ZXIsIGRvY3VtZW50
cywgYW5kIG1vcmUuDQo+DQo+IFNvIGhhdmluZyBhIGRvY3VtZW50IHRoYXQgaXMgTk9UIHBhcnQg
b2YgdGhlIElFVEYgQlBGIFdvcmtpbmcgR3JvdXAgd291bGQgc2VlbQ0KPiBvdXQgb2YgcGxhY2Ug
YW5kLCBpbiBteSB2aWV3LCBiZXR0ZXIgbG9jYXRlZCB1cCBhIGxldmVsIChvdXRzaWRlIHN0YW5k
YXJkaXphdGlvbikuDQoNCkl0J3MgYSBwYXJ0IG9mIGJwZiB3Zy4gSXQncyBub3QgYSBuZXcgZG9j
dW1lbnQuDQoNCj4gSGVyZeKAmXMgc29tZSBleGFtcGxlcyBvZiBkZWx0YS1iYXNlZCBSRkNzIHdo
aWNoIGV4cGxhaW4gdGhlIGdhcCBhbmQgcHJvdmlkZQ0KPiB0aGUgYWRkaXRpb24gb3IgY2xhcmlm
aWNhdGlvbiwgYW5kIGZvcm1hbGx5IFVwZGF0ZSAobm90IHJlcGxhY2Uvb2Jzb2xldGUpIHRoZSBv
cmlnaW5hbA0KPiBSRkM6DQo+ICogaHR0cHM6Ly93d3cucmZjLWVkaXRvci5vcmcvcmZjL3JmYzY1
ODUuaHRtbDogQWRkaXRpb25hbCBIVFRQIFN0YXR1cyBDb2Rlcw0KPiAqIGh0dHBzOi8vd3d3LnJm
Yy1lZGl0b3Iub3JnL3JmYy9yZmM2ODQwLmh0bWw6IENsYXJpZmljYXRpb25zIGFuZCBJbXBsZW1l
bnRhdGlvbiBOb3Rlcw0KPiAgICBmb3IgRE5TIFNlY3VyaXR5IChETlNTRUMpDQo+ICogaHR0cHM6
Ly93d3cucmZjLWVkaXRvci5vcmcvcmZjL3JmYzkyOTUuaHRtbDogQ2xhcmlmaWNhdGlvbnMgZm9y
IEVkMjU1MTksIEVkNDQ4LA0KPiAgICBYMjU1MTksIGFuZCBYNDQ4IEFsZ29yaXRobSBJZGVudGlm
aWVycw0KPiAqIGh0dHBzOi8vd3d3LnJmYy1lZGl0b3Iub3JnL3JmYy9yZmM1NzU2Lmh0bWw6IFVw
ZGF0ZXMgZm9yIFJTQUVTLU9BRVAgYW5kDQo+ICAgIFJTQVNTQS1QU1MgQWxnb3JpdGhtIFBhcmFt
ZXRlcnMNCj4NCj4gSGF2aW5nIGEgZnVsbCBkb2N1bWVudCB0b28gaXMgdmFsdWFibGUgYnV0IHVu
bGVzcyB0aGUgSUVURiBCUEYgV0cNCj4gZGVjaWRlcyB0byB0YWtlIG9uIGEgLWJpcyBkb2N1bWVu
dCwgSSdkIHN1Z2dlc3Qga2VlcGluZyBpdCBvdXQgb2YgdGhlICJzdGFuZGFyZGl6YXRpb24iDQo+
IChzYXkgdXAgMSBsZXZlbCkgdG8gYXZvaWQgY29uZnVzaW9uLCBhbmQganVzdCBoYXZlIG9uZSBv
ciBtb3JlIGRlbHRhLWJhc2VkIHJzdCBmaWxlcw0KPiBpbiB0aGUgc3RhbmRhcmRpemF0aW9uIGRp
cmVjdG9yeS4NCg0KVGhpcyBwYXRjaCBpcyBlZmZlY3RpdmVseSBhIGZpeCB0byB0aGUgc3RhbmRh
cmQuDQpJdCdzIGEgc3RhbmRhcmQgZ2l0IGRldmVsb3BtZW50IHByb2Nlc3Mgd2hlbiBmaXhlcyBh
cmUgYXBwbGllZA0KdG8gdGhlIGV4aXN0aW5nIGRvY3VtZW50Lg0KRm9ya2luZyB0aGUgd2hvbGUg
ZG9jIGludG8gYSBkaWZmZXJlbnQgZmlsZSBqdXN0IHRvIGFwcGx5IGZpeGVzDQptYWtlcyBubyBz
ZW5zZSB0byBtZS4NCg0KVGhlIGZvcm1hbCBkZWx0YS1zIGZvciBJRVRGIGNhbiBiZSBjcmVhdGVk
IG91dCBvZiBnaXQuDQpXZSBvbmx5IG5lZWQgdG8gdGFnIHRoZSBjdXJyZW50IHZlcnNpb24gYW5k
IHRoZW4NCmdpdCBkaWZmIHJmYzk2NjlfdGFnLi5IRUFEDQp3aWxsIGdpdmUgdXMgdGhhdCBkZWx0
YS4NClRoYXQgd2lsbCBzYXRpc2Z5IElFVEYgcHJvY2VzcyBhbmQgd29uJ3QgbWVzcyB1cCBub3Jt
YWwgZ2l0IHN0eWxlDQprZXJuZWwgZGV2ZWxvcG1lbnQuDQoNCmJ0dyBkbyB3ZSBzdGlsbCBuZWVk
IHRvIGRvIGFueSBtaW5vciBlZGl0L2ZpeGVzIHRvIGluc3RydWN0aW9uLXNldC5yc3QNCmJlZm9y
ZSB0YWdnaW5nIGl0IGFzIFJGQzk2NjkgPw0KDQotLSAKQnBmIG1haWxpbmcgbGlzdCAtLSBicGZA
aWV0Zi5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBicGYtbGVhdmVAaWV0Zi5v
cmcK

