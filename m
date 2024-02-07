Return-Path: <bpf+bounces-21453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F06084D6C1
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 00:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06ACD2830F5
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 23:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0323E535B7;
	Wed,  7 Feb 2024 23:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="i/wbPEOj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="i/wbPEOj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jN22Ogmh"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98CD535B3
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 23:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707349397; cv=none; b=q+tyMLEtaAFI3+wK2vvvpLa/PxgBhpTWtnSnX9J0COm3Jj/UBpyEEjEiEsygyTV21R0dMNhTKnosfreQg0mGnf+GqPLSZzgGf0Kfa4nQmkgrd4TsH4XZ6r6/P6rp5jl/cYhBAeeZSH8Bzza2lWcXkpFbCIs6621u3N3kKWRDWso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707349397; c=relaxed/simple;
	bh=Ks6U4R+BPyiE9pLp0+6quN7KDwGsqkK45ekedgJu0gA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:To:Cc:
	 Subject:Content-Type; b=CeTa0lgZ9jlm2rccLJ/B9q0yNP927slMuuhLFgDCv4EPJgD501Oh9MSmnYN5djPAwlTRok0ENklYbT5lURGwsr65aqvtPXiHNOzgfHZz7MrujvJkTzSFrZpK+s367xNu8Oe0ehp71z4e0etI5rrzeHTNmsdYGcf1pKUcmXWlfAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=i/wbPEOj; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=i/wbPEOj; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jN22Ogmh reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 44567C151092
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 15:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1707349395; bh=Ks6U4R+BPyiE9pLp0+6quN7KDwGsqkK45ekedgJu0gA=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=i/wbPEOj8peddIcKw+ahjWa7WR9ClqpHSEjWk2Y2ZLaZvKAqIK9Tz/s7EZ4d2YQVp
	 9gEZqO9f5qKBXDvw3O9/JB/vH8dEkfdVPozVDt0C0zZjLqPhW/Z4PdshGj4GR4YNwe
	 jdMwJTz5+xemGeDBiBO9+5Ed47dN+rHV4JTNP5kA=
X-Mailbox-Line: From bpf-bounces@ietf.org  Wed Feb  7 15:43:15 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 0DDF4C14CF1F;
	Wed,  7 Feb 2024 15:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1707349395; bh=Ks6U4R+BPyiE9pLp0+6quN7KDwGsqkK45ekedgJu0gA=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=i/wbPEOj8peddIcKw+ahjWa7WR9ClqpHSEjWk2Y2ZLaZvKAqIK9Tz/s7EZ4d2YQVp
	 9gEZqO9f5qKBXDvw3O9/JB/vH8dEkfdVPozVDt0C0zZjLqPhW/Z4PdshGj4GR4YNwe
	 jdMwJTz5+xemGeDBiBO9+5Ed47dN+rHV4JTNP5kA=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 884B4C14CE39
 for <bpf@ietfa.amsl.com>; Wed,  7 Feb 2024 15:43:13 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.108
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VZPPbcKFuAGg for <bpf@ietfa.amsl.com>;
 Wed,  7 Feb 2024 15:43:13 -0800 (PST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 1E8AEC14CF0D
 for <bpf@ietf.org>; Wed,  7 Feb 2024 15:43:13 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40fd72f7125so10621425e9.1
 for <bpf@ietf.org>; Wed, 07 Feb 2024 15:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707349391; x=1707954191; darn=ietf.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N2Scllvs6f1zTQW8kpli9koI4OYoj8W192QFTfrrhao=;
 b=jN22Ogmhx6D3Lsl8op6a8HzdrcRAyl+2o0dRkDYMENNYjj2I/a7tAJCy4n6DWdueyt
 vmwenu14uecsofA8j67+GPQsJch5K8h+MwJ6puTO3829ICoCszZkMCGdNL2EGkfyvsfe
 2drZc6t6ey+5GcIQwP8bpqv0CsRPJ6xBQpAYvAVf7iKUk/bprCyZq8zD8XLan3854bAO
 zEYDf8Ad5d9G2GYqmxWystb/fn1gCx2T2izN2OLk4IIJ3XDPQivrmSxVcrmlDaKcjDji
 JpwcBlnERtBJcb516QYy2UiJPwS9uQfxrbk/vP32vIzBbYq95YJTaTIWZ2dbyT5JOh0X
 FR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707349391; x=1707954191;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N2Scllvs6f1zTQW8kpli9koI4OYoj8W192QFTfrrhao=;
 b=uTHmFvtMM8DT6Yfh8QARAliC5h2uFd7QaAjwWn6XKIb+T5npIy+h5SToY1au7M/i7t
 qFBeEogtijdXXq0YVZHi8nHX4zPb5gwUD7s+OyWEjj7yLoFTaxlxB4y6hGeGy9BWw7Qm
 Ipbf3UKOde+M1LGDgEfI+vSq4WtjXETes1cWaAyhd2KqaOhoIukLQ6rbpupDy2lQGRZW
 dq+1l41Dim0Qy5go/gWfkFYMUJGqqFEA9ofu+FtAKHB8OSwAonigy5cs+hdYBpVOUnDq
 JYSpA/no0D0Gus8WYtboUCM8oc7Rp0zCoc5tvMzxKlkM+t1KVp6Jb2AfQ2Aae1A9pcc/
 2NNA==
X-Gm-Message-State: AOJu0YxAo/4rnz23fCYdqPiqEBT8cpK+tab6e//bUvgapOuXG7uVdO1f
 ht3MTN2HjZz06fUXbCPVUJF3aqyx2FHC3cZ7NJ12uDpOqfVc7s4NNLno0kwDuGYWuI03BznJ+Rg
 BR2PbN786GddfUw92wHyPclGQPVE=
X-Google-Smtp-Source: AGHT+IFyonh2XQ6XAoVnFLbKGZMCTebHtcCJvC2MAwznJ63WdehuhfSFcfghTBs6iXBWz256TyRJ6cx3r7Eav15i84Q=
X-Received: by 2002:a5d:618a:0:b0:33b:5359:85c6 with SMTP id
 j10-20020a5d618a000000b0033b535985c6mr1030116wru.18.1707349390076; Wed, 07
 Feb 2024 15:43:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <134701da5a0e$2c80c710$85825530$@gmail.com>
In-Reply-To: <134701da5a0e$2c80c710$85825530$@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 7 Feb 2024 15:42:58 -0800
Message-ID: <CAADnVQ+sF2Zq0S+2XaVfu=tuWY0d-MecnExwdxj-pm+2JjpO2Q@mail.gmail.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf <bpf@vger.kernel.org>, bpf@ietf.org
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/lfAsmcSxegyCVGcJGn6NBPdRwUc>
Subject: Re: [Bpf] ISA document title question
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

T24gV2VkLCBGZWIgNywgMjAyNCBhdCAxOjM54oCvUE0KPGR0aGFsZXIxOTY4PTQwZ29vZ2xlbWFp
bC5jb21AZG1hcmMuaWV0Zi5vcmc+IHdyb3RlOgo+Cj4gVGhlIEludGVybmV0IERyYWZ0IGZpbGVu
YW1lIGlzIGRyYWZ0LWlldGYtYnBmLWlzYS1YWCwgYW5kIHRoZSBjaGFydGVyIGhhczoKPiA+IFtQ
U10gdGhlIEJQRiBpbnN0cnVjdGlvbiBzZXQgYXJjaGl0ZWN0dXJlIChJU0EpIHRoYXQgZGVmaW5l
cyB0aGUKPiA+IGluc3RydWN0aW9ucyBhbmQgbG93LWxldmVsIHZpcnR1YWwgbWFjaGluZSBmb3Ig
QlBGIHByb2dyYW1zLAo+Cj4gVGhhdCBpcywgImluc3RydWN0aW9uIHNldCBhcmNoaXRlY3R1cmUg
KElTQSkiLCBidXQgdGhlIGRvY3VtZW50IGl0c2VsZiBoYXM6Cj4gPiA9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT0KPiA+IEJQRiBJbnN0cnVjdGlvbiBTZXQgU3BlY2lmaWNh
dGlvbiwgdjEuMAo+ID4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Cj4g
Pgo+ID4gVGhpcyBkb2N1bWVudCBzcGVjaWZpZXMgdmVyc2lvbiAxLjAgb2YgdGhlIEJQRiBpbnN0
cnVjdGlvbiBzZXQuCj4KPiBOb3RhYmx5LCBubyAiYXJjaGl0ZWN0dXJlIChJU0EpIi4gICBBbHNv
LCB3ZSBub3cgaGF2ZSBhIG1lY2hhbmlzbQo+IHRvIGV4dGVuZCBpdCB3aXRoIGNvbmZvcm1hbmNl
IGdyb3VwcyBvdmVyIHRpbWUsIHNvICJ2MS4wIiBzZWVtcwo+IGxlc3MgcmVsZXZhbnQgYW5kIHBl
cmhhcHMgbm90IGltcG9ydGFudCBnaXZlbiB0aGVyZSdzIG9ubHkgb25lCj4gdmVyc2lvbiBiZWlu
ZyBzdGFuZGFyZGl6ZWQgYXQgcHJlc2VudC4KPgo+IFdoYXQgZG8gZm9sa3MgdGhpbmsgYWJvdXQg
Y2hhbmdpbmcgdGhlIGRvYyB0byBzYXk6Cj4gPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT0KPiA+IEJQRiBJbnN0cnVjdGlvbiBTZXQgQXJjaGl0ZWN0dXJlCj4gPiA9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KPiA+Cj4gPiBUaGlzIGRvY3VtZW50
IHNwZWNpZmllcyB0aGUgQlBGIGluc3RydWN0aW9uIHNldCBhcmNoaXRlY3R1cmUgKElTQSkuCj4g
PwoKR29vZCBpZGVhLiBNYWtlcyBzZW5zZSB0byBtZS4KCi0tIApCcGYgbWFpbGluZyBsaXN0CkJw
ZkBpZXRmLm9yZwpodHRwczovL3d3dy5pZXRmLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2JwZgo=

