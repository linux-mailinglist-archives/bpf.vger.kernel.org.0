Return-Path: <bpf+bounces-18253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13213817F31
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 02:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA3F2856F4
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 01:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBBA137C;
	Tue, 19 Dec 2023 01:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="mYznMoE0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="mYznMoE0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFvqcPj6"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6448515A0
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 01:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 8393FC151981
	for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 17:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1702948536; bh=4DEGrQcKFEBbtZVvBQRMO3GlHbXPIjYoyjnWBnVq0t8=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=mYznMoE0mRMA1CyESWUSKeHPjYgWfH9GAAFXcZqemmAru9SIzMs6VexHcJvY5V9Ll
	 2V3FWX4Ha043pSaAVjaV/x9RDLD0kKi5YCCPwbkOHh50H0qMaxVLdiCnBApQrWjiO4
	 zPyaSUMLIagxtVdY/DDyiMCVegFqqBNuOw9lN538=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Dec 18 17:15:36 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 30C9DC14CE4D;
	Mon, 18 Dec 2023 17:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1702948536; bh=4DEGrQcKFEBbtZVvBQRMO3GlHbXPIjYoyjnWBnVq0t8=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=mYznMoE0mRMA1CyESWUSKeHPjYgWfH9GAAFXcZqemmAru9SIzMs6VexHcJvY5V9Ll
	 2V3FWX4Ha043pSaAVjaV/x9RDLD0kKi5YCCPwbkOHh50H0qMaxVLdiCnBApQrWjiO4
	 zPyaSUMLIagxtVdY/DDyiMCVegFqqBNuOw9lN538=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id DBC4BC14CE4D
 for <bpf@ietfa.amsl.com>; Mon, 18 Dec 2023 17:15:34 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.108
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1Xi_DDFCykGo for <bpf@ietfa.amsl.com>;
 Mon, 18 Dec 2023 17:15:30 -0800 (PST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 6ACE2C14EB17
 for <bpf@ietf.org>; Mon, 18 Dec 2023 17:15:30 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-32f8441dfb5so3785602f8f.0
 for <bpf@ietf.org>; Mon, 18 Dec 2023 17:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702948529; x=1703553329; darn=ietf.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=50OUIIqph5wXqODzVeWVSRaHi5HO6yKUd5PpBi4ufIk=;
 b=ZFvqcPj6oMzVku+30nQpRbd6mdDKhPsn2oxX2BTo7kZf+tQKNqw70TIigLjAqiOuJ0
 Vvd6ORbSSAbdfhCX/FkMOJidbkhQnxocLGOXqrYGUONK/pnx1Ua8INcplZ7lC2RdhsfO
 75zrfwwITyL/QJ647YlWV/7QAHYZkQCVNQO6yD6SdqgCyfP3atitGe5MfRE5wv7ouhwK
 yYWygWGLUtr6YIODJJpg3W3mZ2USAdBVvun4V9W7LaUBOKs0sF2dBup84iKzhlb4W++L
 KigyF8vcCphPPMFtpWHwSEeNSiGWoAdHWsVhiSSs65rA8Aif3rLRhNH7I96xXm0hwTJh
 OAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702948529; x=1703553329;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=50OUIIqph5wXqODzVeWVSRaHi5HO6yKUd5PpBi4ufIk=;
 b=visiMWfvyopGQAoRzS5rk19AJboiAyAaLiGBypB7WUxL/JqD+HWMvAgLVjr/msJrwu
 Bt+T6OejwGAeQXH4WCMindhHHx7eJfz7mtNJTCuYJYSpWkiJaE/AVptwv0Qz7IEC61/V
 yjpbLJv/zauNi32MNvRHPRHHlp7CkF4OJwf6obfWhMrnDX28um/eWX4A05ia4hjwmyIk
 azWPnDTu9dNkjh8FO45cwnYRH+upqAyT5UJTBaMWnBeQIx5MLRA8z/2/wiGbaHZbbtGx
 VbFgSwTt/jSwpEucGqHdgmBDLO2uXOJ8GsNPqEDSntBSTMW2vrkV6tEg5D9j2djP/Bi2
 tr7A==
X-Gm-Message-State: AOJu0YyWiGJ8dZpRDd0Ekq8kHUcFGdKQtpqB6+ZWT5PQ3w6AJsB60AGO
 omraaIdJK01gSXNJQXP1dgHg/xfMI37a1KYSb3o=
X-Google-Smtp-Source: AGHT+IHZa/VMCz915fiAiIe2ynBdaU1bzV+Xote9kzNTYL6LUlAsCyXWwE80BGKR7Ot6n57uQ4AClZk9wSprPZREN1c=
X-Received: by 2002:adf:e781:0:b0:336:616f:c1ec with SMTP id
 n1-20020adfe781000000b00336616fc1ecmr1998825wrm.103.1702948528480; Mon, 18
 Dec 2023 17:15:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207215152.GA168514@maniforge>
 <CAADnVQ+Mhe6ean6J3vH1ugTyrgWNxupLoFfwKu6-U=3R8i1TNQ@mail.gmail.com>
 <20231212214532.GB1222@maniforge> <157b01da2d46$b7453e20$25cfba60$@gmail.com>
 <CAADnVQKd7X1v6CwCa2MyJjQkN8hKsHJ_g9Kk5CwWSbp9+1_3zw@mail.gmail.com>
 <20231212233555.GA53579@maniforge>
 <CAADnVQJ-JwNTY5fW-oXdTur9aDrv2NQoreTH3yYZemVBVtq9fQ@mail.gmail.com>
 <20231213185603.GA1968@maniforge>
 <CAADnVQLOjByUKJNyLdvDzwuegtjZFwrttHft_1o8BoyDCXQvDQ@mail.gmail.com>
 <20231214174437.GA2853@maniforge> <ZXvkS4qmRMZqlWhA@infradead.org>
In-Reply-To: <ZXvkS4qmRMZqlWhA@infradead.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 18 Dec 2023 17:15:16 -0800
Message-ID: <CAADnVQ+ExRC_RavN_sbuOmuwyP6+HKnV9bFjJOseORBaVw0Jcg@mail.gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: David Vernet <void@manifault.com>, Dave Thaler <dthaler1968@googlemail.com>,
 bpf@ietf.org, bpf <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/UqkPbYHSPI5L3v-9THordnYd1A4>
Subject: Re: [Bpf] BPF ISA conformance groups
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>

T24gVGh1LCBEZWMgMTQsIDIwMjMgYXQgOToyOeKAr1BNIENocmlzdG9waCBIZWxsd2lnIDxoY2hA
aW5mcmFkZWFkLm9yZz4gd3JvdGU6Cj4KPiBXZSBuZWVkIHRoZSBjb25jZXB0IGluIHRoZSBzcGVj
IGp1c3QgdG8gYWxsb3cgZnV0dXJlIGV4dGVuc2FiaWxpdHkuCgpDb21wbGV0ZWx5IGFncmVlIHRo
YXQgdGhlIGNvbmNlcHQgb2YgdGhlIGdyb3VwcyBpcyBuZWNlc3NhcnkuCgpJJ20gYXJndWluZyB0
aGF0IHdoYXQgd2FzIHByb3Bvc2VkOgoxLiAiYmFzaWMiOiBhbGwgaW5zdHJ1Y3Rpb25zIG5vdCBj
b3ZlcmVkIGJ5IGFub3RoZXIgZ3JvdXAgYmVsb3cuCjIuICJhdG9taWMiOiBhbGwgQXRvbWljIG9w
ZXJhdGlvbnMuCjMuICJkaXZpZGUiOiBhbGwgZGl2aXNpb24gYW5kIG1vZHVsbyBvcGVyYXRpb25z
Lgo0LiAibGVnYWN5IjogYWxsIGxlZ2FjeSBwYWNrZXQgYWNjZXNzIGluc3RydWN0aW9ucyAoZGVw
cmVjYXRlZCkuCjUuICJtYXAiOiA2NC1iaXQgaW1tZWRpYXRlIGluc3RydWN0aW9ucyB0aGF0IGRl
YWwgd2l0aCBtYXAgZmRzIG9yIG1hcAppbmRpY2VzLgo2LiAiY29kZSI6IDY0LWJpdCBpbW1lZGlh
dGUgaW5zdHJ1Y3Rpb24gdGhhdCBoYXMgYSAiY29kZSBwb2ludGVyIiB0eXBlLgo3LiAiZnVuYyI6
IHByb2dyYW0tbG9jYWwgZnVuY3Rpb25zLgoKbG9naWNhbGx5IG1ha2VzIHNlbnNlLCBidXQgbWln
aHQgbm90IHdvcmsgZm9yIEhXCihiYXNlZCBvbiB0aGUgaGlzdG9yeSBvZiBuZnAgb2ZmbG9hZCku
CmltbyAiYmFzaWMiIGFuZCAibGVnYWN5IiB3b24ndCB3b3JrIGVpdGhlci4KU28gaXQncyBhIGxl
c3NlciBldmlsLgoKQW55d2F5LCBsZXQncyBsb29rIGF0OgoKICAgfCBCUEZfQ0FMTCB8IDB4OCAg
IHwgMHgwIHwgY2FsbCBoZWxwZXIgICAgICAgICB8IHNlZSBIZWxwZXIgICAgICAgIHwKICAgfCAg
ICAgICAgICB8ICAgICAgIHwgICAgIHwgZnVuY3Rpb24gYnkgYWRkcmVzcyB8IGZ1bmN0aW9ucyAg
ICAgICAgIHwKICAgfCAgICAgICAgICB8ICAgICAgIHwgICAgIHwgICAgICAgICAgICAgICAgICAg
ICB8IChTZWN0aW9uIDMuMy4xKSAgIHwKICAgKy0tLS0tLS0tLS0rLS0tLS0tLSstLS0tLSstLS0t
LS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLSsKICAgfCBCUEZfQ0FMTCB8IDB4
OCAgIHwgMHgxIHwgY2FsbCBQQyArPSBpbW0gICAgICB8IHNlZSBQcm9ncmFtLWxvY2FsIHwKICAg
fCAgICAgICAgICB8ICAgICAgIHwgICAgIHwgICAgICAgICAgICAgICAgICAgICB8IGZ1bmN0aW9u
cyAgICAgICAgIHwKICAgfCAgICAgICAgICB8ICAgICAgIHwgICAgIHwgICAgICAgICAgICAgICAg
ICAgICB8IChTZWN0aW9uIDMuMy4yKSAgIHwKICAgKy0tLS0tLS0tLS0rLS0tLS0tLSstLS0tLSst
LS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLSsKICAgfCBCUEZfQ0FMTCB8
IDB4OCAgIHwgMHgyIHwgY2FsbCBoZWxwZXIgICAgICAgICB8IHNlZSBIZWxwZXIgICAgICAgIHwK
ICAgfCAgICAgICAgICB8ICAgICAgIHwgICAgIHwgZnVuY3Rpb24gYnkgQlRGIElEICB8IGZ1bmN0
aW9ucyAgICAgICAgIHwKICAgfCAgICAgICAgICB8ICAgICAgIHwgICAgIHwgICAgICAgICAgICAg
ICAgICAgICB8IChTZWN0aW9uIDMuMy4KCkhhdmluZyBzZXBhcmF0ZSBjYXRlZ29yeSA3IGZvciBz
aW5nbGUgaW5zbiBCUEZfQ0FMTCAweDggMHgxCndoaWxlIGtlZXBpbmcgMHg4IDB4MCBhbmQgMHg4
IDB4MiBpbiAiYmFzaWMiIHNlZW1zIGp1c3QKYXMgbG9naWNhbCBhcyBoYXZpbmcgYXRvbWljX2Fk
ZCBpbnNuIGluICJiYXNpYyIgaW5zdGVhZCBvZiAiYXRvbWljIi4KClRoZW4gd2UgaGF2ZSBzZXZl
cmFsIGtpbmRzIG9mIGxkX2ltbTY0LiBTb3VuZHMgbGlrZSB0aGUgaWRlYQppcyB0byBzcGxpdCAw
eDE4IDB4NCBpbnRvICJjb2RlIiBhbmQgdGhlIHJlc3QgaW50byAibWFwIiBncm91cD8KSXMgaXQg
bG9naWNhbCBvciBub3Q/CgpNYXliZSB3ZSBzaG91bGQgZG8gcmlzYy12IGxpa2UgZ3JvdXAgaW5z
dGVhZD8KSnVzdCB0aGVzZSA0OgotIEJhc2UgSW50ZWdlciBJbnN0cnVjdGlvbiBTZXQsIDMyLWJp
dAotIEJhc2UgSW50ZWdlciBJbnN0cnVjdGlvbiBTZXQsIDY0LWJpdAotIEludGVnZXIgTXVsdGlw
bGljYXRpb24gYW5kIERpdmlzaW9uCi0gQXRvbWljIEluc3RydWN0aW9ucwoKQW5kIHRoYXQncyBp
dC4gVGhlIHJlc3Qgb2YgcmlzYy12IGdyb3VwcyBoYXZlIG5vIGVxdWl2YWxlbnQgaW4gYnBmIGlz
YS4KCi0tIApCcGYgbWFpbGluZyBsaXN0CkJwZkBpZXRmLm9yZwpodHRwczovL3d3dy5pZXRmLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2JwZgo=

