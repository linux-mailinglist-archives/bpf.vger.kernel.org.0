Return-Path: <bpf+bounces-21715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72576850689
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 22:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3008C282A1D
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 21:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636DB5FDAE;
	Sat, 10 Feb 2024 21:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="pRzYxinP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="pRzYxinP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="neH1sU5K"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E174F5F872
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 21:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707601644; cv=none; b=Kv/siY1/jmoxZ8xeurjeV9Q/+b+S8K0yJg8AlCHN6VjDDHprNvAnQhyE1GeJM7PHitYgeOyShvg0ZbJJrozBUYhHCCikYI2weQKdWKa2vc79EcRuGVgDuT0PGi/exOCkpghiz4W6NHW65qSjkrZEth5egTOpQN0RLgLvBtqfGkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707601644; c=relaxed/simple;
	bh=jhXC9/idL0Zr9dukXAwYbeGopoQnzuYKWPGpz+/5Y/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:To:Cc:
	 Subject:Content-Type; b=ZAdJWCw80aLCzH0L5lQLxbFyuLKHC5VP7lh0bLgZsKtiC53iQHsLhzwt6U4Ke52O+YDAPqox/14K5AxWuVbbTtVSZBmmuj7++5M09FzuoyYIjhJA4AeEwFW0nAYFFLRdIwWl/NzaEabuhhZ+YtvnIufDxeZ6WGeN3mPTo2/3nZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=pRzYxinP; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=pRzYxinP; dkim=fail (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b=neH1sU5K reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 5E6F6C14F68D
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 13:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1707601636; bh=jhXC9/idL0Zr9dukXAwYbeGopoQnzuYKWPGpz+/5Y/Y=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=pRzYxinPyDO+TJ6juJsPh3tJpZI06SrCwgmEwCncR7X5SWv/wX/jPsf+lrGp7xWJf
	 q6vWoDYlfGGUNlbsorRfucK6SZutjULHyVTci7xRDylcFWbY/42ZwPY7HG8nINEYYF
	 fLJXWSV9Q6mg7nQzFpKDf4M8Sg6k5qvN/jJFfx5E=
X-Mailbox-Line: From bpf-bounces@ietf.org  Sat Feb 10 13:47:16 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 2E980C14F5FA;
	Sat, 10 Feb 2024 13:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1707601636; bh=jhXC9/idL0Zr9dukXAwYbeGopoQnzuYKWPGpz+/5Y/Y=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=pRzYxinPyDO+TJ6juJsPh3tJpZI06SrCwgmEwCncR7X5SWv/wX/jPsf+lrGp7xWJf
	 q6vWoDYlfGGUNlbsorRfucK6SZutjULHyVTci7xRDylcFWbY/42ZwPY7HG8nINEYYF
	 fLJXWSV9Q6mg7nQzFpKDf4M8Sg6k5qvN/jJFfx5E=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id B5ACAC14EB17
 for <bpf@ietfa.amsl.com>; Sat, 10 Feb 2024 13:47:14 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.904
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=obs-cr.20230601.gappssmtp.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TcVoCbbgEcHW for <bpf@ietfa.amsl.com>;
 Sat, 10 Feb 2024 13:47:12 -0800 (PST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 9137EC14F5E6
 for <bpf@ietf.org>; Sat, 10 Feb 2024 13:47:12 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-68cc9061c73so10413406d6.3
 for <bpf@ietf.org>; Sat, 10 Feb 2024 13:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1707601631; x=1708206431;
 darn=ietf.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7AEpMK3KT1MsXa+SSX1BqR09ZNKqXqg4aHA0Fy+hmJU=;
 b=neH1sU5Kq5/3L81jZdli3DgBaEW/GRIokavJzC08wnjLhshDznpDZL2ulQQ6fVoBk5
 GhGzp8vZrIs85PNsD5grDpPyCEHdBkIqfPWJ/HlLCPKGoHpgLFSxFqlJ35rOYArH80g7
 NvNeMeS2CAF+MDBcjPf/mxCaRnXC0EXyxL3mFqeecY1tQ5DYos7dAbzMahSJ5qNbDu1/
 30nSwRsw+ZvTN+a70nL8yNL5lxlMCXxdhGUCMyhw3VCo2RxWdwrEpFveFUqi1lImyXC+
 02H+shNQhtlgVs/AElo5+2kj0Ax1etnPxTSX19gfeXrLsRlrabMivMqmGIsDShAjsU/8
 UFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707601631; x=1708206431;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7AEpMK3KT1MsXa+SSX1BqR09ZNKqXqg4aHA0Fy+hmJU=;
 b=Cvrb1m8y1gin2Kz/BHC1MoGEhqxdU73OrS3cp32XoswWBophr0TBEoAX/Vm/zK91qB
 g9rP6paRgQeo8SqTcVeAMdzx3hQsRRB/MX4ZkFCA2w3PS3tLTlGWZacBzR2+mId+NAWG
 q4Sv+pQ9mli6tFEetU1R7V1oHxhl1ttQea7CkrXp9jSWi6nTWVnWaQvyhlYhyRaXwPHj
 AZTJ1OjaZY57bGg6+MwoTzAdod+LmXMswRSNDd0NjCNHIcOy9jpLgsSFD18BdeCF8SIc
 tAIT7ohfYP/JoJ7023uXUVE/Y7Yf7qeR5q1OCUJ6c+0bZ8RqqneXGtIv3fLexdL1MRlU
 nzUQ==
X-Gm-Message-State: AOJu0YxDQ4qXDzAoEvGL9eRALOlXbfin820S6bNWSAprMrjdYjXPisdK
 UzcAplkXRUm6GKu7rTHEUIdddj637v73DH14ivWnDaWfwfhdGLC8RmWbkNN3Wx1lnjePIxTnTb3
 EKQsPw0t4j8BRaneIYVe6OJ4r6p/kxfA++i0arA==
X-Google-Smtp-Source: AGHT+IHlDZuPMMBBjQc3nR5gNC2dJsPA3L6hQs92W0YXWGP1fQZMKN3DtalgYVkMTz2ZpEWr6AjP4MfrkmpaWxWsRMU=
X-Received: by 2002:a0c:e1cf:0:b0:68c:6746:274f with SMTP id
 v15-20020a0ce1cf000000b0068c6746274fmr3377680qvl.47.1707601631209; Sat, 10
 Feb 2024 13:47:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208223237.12528-1-dthaler1968@gmail.com>
In-Reply-To: <20240208223237.12528-1-dthaler1968@gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Sat, 10 Feb 2024 16:47:00 -0500
Message-ID: <CADx9qWiOXUVwKK50Mqj7fUMGSxF7MEP9tJ93nzXWrbWcqAp0-w@mail.gmail.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/Z7DIrHKSQnVmxNvcXj2j4Hl4AD0>
Subject: Re: [Bpf] [PATCH bpf-next] bpf,
 docs: Add callx instructions in new conformance group
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

T24gVGh1LCBGZWIgOCwgMjAyNCBhdCA1OjMy4oCvUE0gRGF2ZSBUaGFsZXIKPGR0aGFsZXIxOTY4
PTQwZ29vZ2xlbWFpbC5jb21AZG1hcmMuaWV0Zi5vcmc+IHdyb3RlOgo+Cj4gKiBBZGQgYSAiY2Fs
bHgiIGNvbmZvcm1hbmNlIGdyb3VwCj4gKiBBZGQgY2FsbHggcm93cyB0byB0YWJsZQo+ICogVXBk
YXRlIGhlbHBlciBmdW5jdGlvbiB0byBzZWN0aW9uIHRvIGJlIGFnbm9zdGljIGJldHdlZW4gQlBG
X0sgdnMKPiAgIEJQRl9YCj4gKiBSZW5hbWUgImxlZ2FjeSIgY29uZm9ybWFuY2UgZ3JvdXAgdG8g
InBhY2tldCIKPgo+IEJhc2VkIG9uIG1haWxpbmcgbGlzdCBkaXNjdXNzaW9uIGF0Cj4gaHR0cHM6
Ly9tYWlsYXJjaGl2ZS5pZXRmLm9yZy9hcmNoL21zZy9icGYvbDV0TkVnTC1XbzdxU0V1YUdzc09s
NVZDaEtrLwo+Cj4gU2lnbmVkLW9mZi1ieTogRGF2ZSBUaGFsZXIgPGR0aGFsZXIxOTY4QGdtYWls
LmNvbT4KPiAtLS0KPiAgLi4uL2JwZi9zdGFuZGFyZGl6YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJz
dCAgIHwgMzIgKysrKysrKysrKysrLS0tLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0
aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9i
cGYvc3RhbmRhcmRpemF0aW9uL2luc3RydWN0aW9uLXNldC5yc3QgYi9Eb2N1bWVudGF0aW9uL2Jw
Zi9zdGFuZGFyZGl6YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJzdAo+IGluZGV4IGJkZmUwY2QwZS4u
OGYwYWRhMjJlIDEwMDY0NAo+IC0tLSBhL0RvY3VtZW50YXRpb24vYnBmL3N0YW5kYXJkaXphdGlv
bi9pbnN0cnVjdGlvbi1zZXQucnN0Cj4gKysrIGIvRG9jdW1lbnRhdGlvbi9icGYvc3RhbmRhcmRp
emF0aW9uL2luc3RydWN0aW9uLXNldC5yc3QKPiBAQCAtMTI3LDcgKzEyNyw3IEBAIFRoaXMgZG9j
dW1lbnQgZGVmaW5lcyB0aGUgZm9sbG93aW5nIGNvbmZvcm1hbmNlIGdyb3VwczoKPiAgKiBkaXZt
dWwzMjogaW5jbHVkZXMgMzItYml0IGRpdmlzaW9uLCBtdWx0aXBsaWNhdGlvbiwgYW5kIG1vZHVs
byBpbnN0cnVjdGlvbnMuCj4gICogZGl2bXVsNjQ6IGluY2x1ZGVzIGRpdm11bDMyLCBwbHVzIDY0
LWJpdCBkaXZpc2lvbiwgbXVsdGlwbGljYXRpb24sCj4gICAgYW5kIG1vZHVsbyBpbnN0cnVjdGlv
bnMuCj4gLSogbGVnYWN5OiBkZXByZWNhdGVkIHBhY2tldCBhY2Nlc3MgaW5zdHJ1Y3Rpb25zLgo+
ICsqIHBhY2tldDogZGVwcmVjYXRlZCBwYWNrZXQgYWNjZXNzIGluc3RydWN0aW9ucy4KPgo+ICBJ
bnN0cnVjdGlvbiBlbmNvZGluZwo+ICA9PT09PT09PT09PT09PT09PT09PQo+IEBAIC00MDQsOSAr
NDA0LDEyIEBAIEJQRl9KU0VUICAweDQgICAgYW55ICBQQyArPSBvZmZzZXQgaWYgZHN0ICYgc3Jj
Cj4gIEJQRl9KTkUgICAweDUgICAgYW55ICBQQyArPSBvZmZzZXQgaWYgZHN0ICE9IHNyYwo+ICBC
UEZfSlNHVCAgMHg2ICAgIGFueSAgUEMgKz0gb2Zmc2V0IGlmIGRzdCA+IHNyYyAgICAgICAgc2ln
bmVkCj4gIEJQRl9KU0dFICAweDcgICAgYW55ICBQQyArPSBvZmZzZXQgaWYgZHN0ID49IHNyYyAg
ICAgICBzaWduZWQKPiAtQlBGX0NBTEwgIDB4OCAgICAweDAgIGNhbGwgaGVscGVyIGZ1bmN0aW9u
IGJ5IGFkZHJlc3MgIEJQRl9KTVAgfCBCUEZfSyBvbmx5LCBzZWUgYEhlbHBlciBmdW5jdGlvbnNg
Xwo+ICtCUEZfQ0FMTCAgMHg4ICAgIDB4MCAgY2FsbF9ieV9hZGRyZXNzKGltbSkgICAgICAgICAg
ICAgQlBGX0pNUCB8IEJQRl9LIG9ubHkKPiArQlBGX0NBTEwgIDB4OCAgICAweDAgIGNhbGxfYnlf
YWRkcmVzcyhyZWdfdmFsKGltbSkpICAgIEJQRl9KTVAgfCBCUEZfWCBvbmx5Cj4gIEJQRl9DQUxM
ICAweDggICAgMHgxICBjYWxsIFBDICs9IGltbSAgICAgICAgICAgICAgICAgICBCUEZfSk1QIHwg
QlBGX0sgb25seSwgc2VlIGBQcm9ncmFtLWxvY2FsIGZ1bmN0aW9uc2BfCj4gLUJQRl9DQUxMICAw
eDggICAgMHgyICBjYWxsIGhlbHBlciBmdW5jdGlvbiBieSBCVEYgSUQgICBCUEZfSk1QIHwgQlBG
X0sgb25seSwgc2VlIGBIZWxwZXIgZnVuY3Rpb25zYF8KPiArQlBGX0NBTEwgIDB4OCAgICAweDEg
IGNhbGwgUEMgKz0gcmVnX3ZhbChpbW0pICAgICAgICAgIEJQRl9KTVAgfCBCUEZfWCBvbmx5LCBz
ZWUgYFByb2dyYW0tbG9jYWwgZnVuY3Rpb25zYF8KPiArQlBGX0NBTEwgIDB4OCAgICAweDIgIGNh
bGxfYnlfYnRmaWQoaW1tKSAgICAgICAgICAgICAgIEJQRl9KTVAgfCBCUEZfSyBvbmx5Cj4gK0JQ
Rl9DQUxMICAweDggICAgMHgyICBjYWxsX2J5X2J0ZmlkKHJlZ192YWwoaW1tKSkgICAgICBCUEZf
Sk1QIHwgQlBGX1ggb25seQo+ICBCUEZfRVhJVCAgMHg5ICAgIDB4MCAgcmV0dXJuICAgICAgICAg
ICAgICAgICAgICAgICAgICAgQlBGX0pNUCB8IEJQRl9LIG9ubHkKPiAgQlBGX0pMVCAgIDB4YSAg
ICBhbnkgIFBDICs9IG9mZnNldCBpZiBkc3QgPCBzcmMgICAgICAgIHVuc2lnbmVkCj4gIEJQRl9K
TEUgICAweGIgICAgYW55ICBQQyArPSBvZmZzZXQgaWYgZHN0IDw9IHNyYyAgICAgICB1bnNpZ25l
ZAo+IEBAIC00MTQsNiArNDE3LDEyIEBAIEJQRl9KU0xUICAweGMgICAgYW55ICBQQyArPSBvZmZz
ZXQgaWYgZHN0IDwgc3JjICAgICAgICBzaWduZWQKPiAgQlBGX0pTTEUgIDB4ZCAgICBhbnkgIFBD
ICs9IG9mZnNldCBpZiBkc3QgPD0gc3JjICAgICAgIHNpZ25lZAo+ICA9PT09PT09PSAgPT09PT0g
ID09PSAgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PSAgPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09Cj4KPiArd2hlcmUKPiArCj4gKyogcmVnX3ZhbChp
bW0pIGdldHMgdGhlIHZhbHVlIG9mIHRoZSByZWdpc3RlciB3aXRoIHRoZSBzcGVjaWZpZWQgbnVt
YmVyCj4gKyogY2FsbF9ieV9hZGRyZXNzKHZhbHVlKSBtZWFucyB0byBjYWxsIGEgaGVscGVyIGZ1
bmN0aW9uIGJ5IGFkZHJlc3MgKHNlZSBgSGVscGVyIGZ1bmN0aW9uc2BfIGZvciBkZXRhaWxzKQo+
ICsqIGNhbGxfYnlfYnRmaWQodmFsdWUpIG1lYW5zIHRvIGNhbGwgYSBoZWxwZXIgZnVuY3Rpb24g
YnkgQlRGIElEIChzZWUgYEhlbHBlciBmdW5jdGlvbnNgXyBmb3IgZGV0YWlscykKPiArCgpDb3Vs
ZCB3ZSBzYXkKCiogcmVnX3ZhbChpbW0pIGdldHMgdGhlIHZhbHVlIG9mIHRoZSByZWdpc3RlciBz
cGVjaWZpZWQgYnkgYGBpbW1gYAoqIGNhbGxfYnlfYWRkcmVzcyh2YWx1ZSkgbWVhbnMgdG8gY2Fs
bCBhIGhlbHBlciBmdW5jdGlvbiBieSBhZGRyZXNzCnNwZWNpZmllZCBieSBgYHZhbHVlYGAgKHNl
ZSBgSGVscGVyIGZ1bmN0aW9uc2BfIGZvciBkZXRhaWxzKQoqIGNhbGxfYnlfYnRmaWQodmFsdWUp
IG1lYW5zIHRvIGNhbGwgYSBoZWxwZXIgZnVuY3Rpb24gYnkgQlRGIElECnNwZWNpZmllZCBieSBg
YHZhbHVlYGAgKHNlZSBgSGVscGVyIGZ1bmN0aW9uc2BfIGZvciBkZXRhaWxzKQoKSSdtIG5vdCBz
dXJlIHRoYXQgaXQgaGVscHMsIGJ1dCBJIHRob3VnaHQgSSB3b3VsZCBvZmZlciB0aGUgc3VnZ2Vz
dGlvbi4KCk90aGVyd2lzZSwgbG9va3MgZ29vZCB0byBtZSEKV2lsbAoKCgo+ICBUaGUgQlBGIHBy
b2dyYW0gbmVlZHMgdG8gc3RvcmUgdGhlIHJldHVybiB2YWx1ZSBpbnRvIHJlZ2lzdGVyIFIwIGJl
Zm9yZSBkb2luZyBhCj4gIGBgQlBGX0VYSVRgYC4KPgo+IEBAIC00MzgsOCArNDQ3LDkgQEAgc3Bl
Y2lmaWVkIGJ5IHRoZSAnaW1tJyBmaWVsZC4gQSA+IDE2LWJpdCBjb25kaXRpb25hbCBqdW1wIG1h
eSBiZQo+ICBjb252ZXJ0ZWQgdG8gYSA8IDE2LWJpdCBjb25kaXRpb25hbCBqdW1wIHBsdXMgYSAz
Mi1iaXQgdW5jb25kaXRpb25hbAo+ICBqdW1wLgo+Cj4gLUFsbCBgYEJQRl9DQUxMYGAgYW5kIGBg
QlBGX0pBYGAgaW5zdHJ1Y3Rpb25zIGJlbG9uZyB0byB0aGUKPiAtYmFzZTMyIGNvbmZvcm1hbmNl
IGdyb3VwLgo+ICtBbGwgYGBCUEZfQ0FMTCB8IEJQRl9YYGAgaW5zdHJ1Y3Rpb25zIGJlbG9uZyB0
byB0aGUgY2FsbHgKPiArY29uZm9ybWFuY2UgZ3JvdXAuICBBbGwgb3RoZXIgYGBCUEZfQ0FMTGBg
IGluc3RydWN0aW9ucyBhbmQgYWxsCj4gK2BgQlBGX0pBYGAgaW5zdHJ1Y3Rpb25zIGJlbG9uZyB0
byB0aGUgYmFzZTMyIGNvbmZvcm1hbmNlIGdyb3VwLgo+Cj4gIEhlbHBlciBmdW5jdGlvbnMKPiAg
fn5+fn5+fn5+fn5+fn5+fgo+IEBAIC00NDcsMTMgKzQ1NywxMyBAQCBIZWxwZXIgZnVuY3Rpb25z
Cj4gIEhlbHBlciBmdW5jdGlvbnMgYXJlIGEgY29uY2VwdCB3aGVyZWJ5IEJQRiBwcm9ncmFtcyBj
YW4gY2FsbCBpbnRvIGEKPiAgc2V0IG9mIGZ1bmN0aW9uIGNhbGxzIGV4cG9zZWQgYnkgdGhlIHVu
ZGVybHlpbmcgcGxhdGZvcm0uCj4KPiAtSGlzdG9yaWNhbGx5LCBlYWNoIGhlbHBlciBmdW5jdGlv
biB3YXMgaWRlbnRpZmllZCBieSBhbiBhZGRyZXNzCj4gLWVuY29kZWQgaW4gdGhlIGltbSBmaWVs
ZC4gIFRoZSBhdmFpbGFibGUgaGVscGVyIGZ1bmN0aW9ucyBtYXkgZGlmZmVyCj4gLWZvciBlYWNo
IHByb2dyYW0gdHlwZSwgYnV0IGFkZHJlc3MgdmFsdWVzIGFyZSB1bmlxdWUgYWNyb3NzIGFsbCBw
cm9ncmFtIHR5cGVzLgo+ICtIaXN0b3JpY2FsbHksIGVhY2ggaGVscGVyIGZ1bmN0aW9uIHdhcyBp
ZGVudGlmaWVkIGJ5IGFuIGFkZHJlc3MuCj4gK1RoZSBhdmFpbGFibGUgaGVscGVyIGZ1bmN0aW9u
cyBtYXkgZGlmZmVyIGZvciBlYWNoIHByb2dyYW0gdHlwZSwKPiArYnV0IGFkZHJlc3MgdmFsdWVz
IGFyZSB1bmlxdWUgYWNyb3NzIGFsbCBwcm9ncmFtIHR5cGVzLgo+Cj4gIFBsYXRmb3JtcyB0aGF0
IHN1cHBvcnQgdGhlIEJQRiBUeXBlIEZvcm1hdCAoQlRGKSBzdXBwb3J0IGlkZW50aWZ5aW5nCj4g
LWEgaGVscGVyIGZ1bmN0aW9uIGJ5IGEgQlRGIElEIGVuY29kZWQgaW4gdGhlIGltbSBmaWVsZCwg
d2hlcmUgdGhlIEJURiBJRAo+IC1pZGVudGlmaWVzIHRoZSBoZWxwZXIgbmFtZSBhbmQgdHlwZS4K
PiArYSBoZWxwZXIgZnVuY3Rpb24gYnkgYSBCVEYgSUQsIHdoZXJlIHRoZSBCVEYgSUQgaWRlbnRp
ZmllcyB0aGUgaGVscGVyCj4gK25hbWUgYW5kIHR5cGUuCj4KPiAgUHJvZ3JhbS1sb2NhbCBmdW5j
dGlvbnMKPiAgfn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KPiBAQCAtNjYwLDQgKzY3MCw0IEBAIGNh
cnJpZWQgb3ZlciBmcm9tIGNsYXNzaWMgQlBGLiBUaGVzZSBpbnN0cnVjdGlvbnMgdXNlZCBhbiBp
bnN0cnVjdGlvbgo+ICBjbGFzcyBvZiBCUEZfTEQsIGEgc2l6ZSBtb2RpZmllciBvZiBCUEZfVywg
QlBGX0gsIG9yIEJQRl9CLCBhbmQgYQo+ICBtb2RlIG1vZGlmaWVyIG9mIEJQRl9BQlMgb3IgQlBG
X0lORC4gIEhvd2V2ZXIsIHRoZXNlIGluc3RydWN0aW9ucyBhcmUKPiAgZGVwcmVjYXRlZCBhbmQg
c2hvdWxkIG5vIGxvbmdlciBiZSB1c2VkLiAgQWxsIGxlZ2FjeSBwYWNrZXQgYWNjZXNzCj4gLWlu
c3RydWN0aW9ucyBiZWxvbmcgdG8gdGhlICJsZWdhY3kiIGNvbmZvcm1hbmNlIGdyb3VwLgo+ICtp
bnN0cnVjdGlvbnMgYmVsb25nIHRvIHRoZSAicGFja2V0IiBjb25mb3JtYW5jZSBncm91cC4KPiAt
LQo+IDIuNDAuMQo+Cj4gLS0KPiBCcGYgbWFpbGluZyBsaXN0Cj4gQnBmQGlldGYub3JnCj4gaHR0
cHM6Ly93d3cuaWV0Zi5vcmcvbWFpbG1hbi9saXN0aW5mby9icGYKCi0tIApCcGYgbWFpbGluZyBs
aXN0CkJwZkBpZXRmLm9yZwpodHRwczovL3d3dy5pZXRmLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Jw
Zgo=

