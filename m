Return-Path: <bpf+bounces-20296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8018583B7AC
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 04:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1521E1F2577B
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 03:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E256063B1;
	Thu, 25 Jan 2024 03:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="eJdsdlkA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="eJdsdlkA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Erzt8S4R"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB74E5C9A
	for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 03:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706152446; cv=none; b=EqFwPptuMNE6xgSx2g3CdSnpbz5Ip48VA6BFZ+fpHuft6pjxeMNuBAK3fL52QT7yYV8tN7fhyJBlhXO62Cwo9RGYxhhPY6Q3hQgDNbb64CdorWTddcbdn16HvY8Ft/LBpXgrb7+vJHGJ+CBvwe4mg18PZemP4mlHsFp4bNAFdLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706152446; c=relaxed/simple;
	bh=VpoBirG+0QmQGh9DCnIBAE8KxKNNybHC2eNxThX4GJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:To:Cc:
	 Subject:Content-Type; b=qNEGvpB6xNuCmXNYFaW4mz3r1zJckeBzNDEXclBRy6S3EnRcEEurYs3igY76eUA1iKBYoeb53O0yDnlxF0V/U4/mw6TDJXdCNaULClaClRc1Jl7XvheKqOmEftKuRexfq4DyOtPmp1XOFNEZyjQUvSYIJVctNkhfJ3Df1w6WKJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=eJdsdlkA; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=eJdsdlkA; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Erzt8S4R reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 4ACBDC151983
	for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 19:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706152444; bh=VpoBirG+0QmQGh9DCnIBAE8KxKNNybHC2eNxThX4GJE=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=eJdsdlkAYOBuss9+Tnp62d49EGly1t7906LMnmzuF7OrU3N3cgSeBO6MzIAyKJ/+X
	 +WBmRbEH1Fxl/N2YKlGFn0INtW8HyRsPpedd5hmSY9xPR+s5UuLVo/ZTbvWs6Fw2F6
	 wbJruElLvtfK+h5zx2dSeyAeDSa7wYNjpTOGqj4Q=
X-Mailbox-Line: From bpf-bounces@ietf.org  Wed Jan 24 19:14:04 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 1968EC14F71B;
	Wed, 24 Jan 2024 19:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706152444; bh=VpoBirG+0QmQGh9DCnIBAE8KxKNNybHC2eNxThX4GJE=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=eJdsdlkAYOBuss9+Tnp62d49EGly1t7906LMnmzuF7OrU3N3cgSeBO6MzIAyKJ/+X
	 +WBmRbEH1Fxl/N2YKlGFn0INtW8HyRsPpedd5hmSY9xPR+s5UuLVo/ZTbvWs6Fw2F6
	 wbJruElLvtfK+h5zx2dSeyAeDSa7wYNjpTOGqj4Q=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 2DF7EC14F71B
 for <bpf@ietfa.amsl.com>; Wed, 24 Jan 2024 19:14:02 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.108
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0iStJCy2Nolx for <bpf@ietfa.amsl.com>;
 Wed, 24 Jan 2024 19:14:01 -0800 (PST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 9CB5BC14F6BC
 for <bpf@ietf.org>; Wed, 24 Jan 2024 19:14:01 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3387ef9fc62so5672880f8f.2
 for <bpf@ietf.org>; Wed, 24 Jan 2024 19:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706152440; x=1706757240; darn=ietf.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ur8a1M1Lx57Kx2hOFLmI+GGhr/ervjcbPnLVkkXV/m8=;
 b=Erzt8S4R+0+N0/Kn6afPdg5Kd/rTS24F5KWU2wEl5E73uUgIikRfpHlwNP9GgNFH1h
 3iS++Bmd/b9eM99jHnzJSqDvZjIVk0YjbjKlStku3o250ZR3XOjhT+WTWOXkRD1N5SKN
 Yrb9//+USAMv31rKnCDlJLEW1TpW0wDSHrOlfd84lxYI+05n2+k5ePnZa4M8JgkQPync
 3eW8Kp1bnyAyrwn1smgBh8n/eqyolPq5LVQGcVrkVqZLGJJKuJ/bsq0lc7XsmZro/eeq
 eicMXpJAxvHk/O2/CmZukVdfwnnCSiJhlqkHeyyd6Biov2AtzHkZ5C4dimvZXHk++J/D
 WsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706152440; x=1706757240;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ur8a1M1Lx57Kx2hOFLmI+GGhr/ervjcbPnLVkkXV/m8=;
 b=HkwRt/JG35fklauMrQy0+OoMmEFS2WljNptbbu3Bu245rW19FsTASCrMyPY1sB3tjx
 OtSh2XAcFhL3rKubv1JyanY62Ihy+WwNAAI0ZQo1A8zqK3DJOz091fwuq8NfTmE77SH3
 OvZU8Xk5m351eNlKBJOMGA+N+sTyL95IbmLJUxoliwBEki+Pt6knnJPG/d2CK/8UN2cW
 AdqF7NkTb2/wfbQE3Lf+KPNTxYl+BuHD2th7tDqhUeDhtNgb3XbuWZeAgWHXzJTMT+UG
 IxWmJyF+w8zagblhA7zJBPQoxfrw0kAQdR7ePnHqVFZcaq/YE9O0FSE9liBY3Zsj07TZ
 8rJQ==
X-Gm-Message-State: AOJu0YyFjZ//SeK34W8vpsEa1Uy1woZbnqs5p05y+TLnWnWjm3zI2RIf
 KXhtHShLb/6/XN595M7yqjMGokrNbxFvje73XEubyfF2X8TbWj3BWQDw9LsdP2T9ZpVTxuBZfau
 k3t+U1fHtQ0ik0VcB+YuR9l2Q748JaVpF
X-Google-Smtp-Source: AGHT+IFdeH+hshm0prdv1DcuTNzyNgJFMEn7bWZrZqnOrTi6Ux6z7TLQ2aYkkhyTZIujvcJ/FPE2bMKVn+C2Z2ztWsg=
X-Received: by 2002:a05:6000:1cf:b0:337:3b9e:d01c with SMTP id
 t15-20020a05600001cf00b003373b9ed01cmr105068wrx.143.1706152439695; Wed, 24
 Jan 2024 19:13:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1b5d01da4e1b$95506b50$bff141f0$@gmail.com>
In-Reply-To: <1b5d01da4e1b$95506b50$bff141f0$@gmail.com>
From: Watson Ladd <watsonbladd@gmail.com>
Date: Wed, 24 Jan 2024 19:13:48 -0800
Message-ID: <CACsn0cmG5yui1Xt_HPDK+uTUk-4eML+Aw_wm5f9GKHUS+shycw@mail.gmail.com>
To: dthaler1968=40googlemail.com@dmarc.ietf.org
Cc: bpf@ietf.org, bpf@vger.kernel.org
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/ehyLRDw7w0LVzXldNdvYR7PkwRE>
Subject: Re: [Bpf] Standardizing BPF assembly language?
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

T24gVHVlLCBKYW4gMjMsIDIwMjQgYXQgODo0NuKAr0FNCjxkdGhhbGVyMTk2OD00MGdvb2dsZW1h
aWwuY29tQGRtYXJjLmlldGYub3JnPiB3cm90ZToKPgo+IEF0IExTRi9NTS9CUEYgMjAyMywgSm9z
ZSBnYXZlIGEgcHJlc2VudGF0aW9uIGFib3V0IEJQRiBhc3NlbWJseQo+IGxhbmd1YWdlIChodHRw
Oi8vdmdlci5rZXJuZWwub3JnL2JwZmNvbmYyMDIzX21hdGVyaWFsL2NvbXBpbGVkX2JwZi50eHQp
Lgo+Cj4gSm9zZSB3cm90ZSBpbiB0aGF0IGxpbms6Cj4gPiBUaGVyZSBhcmUgdHdvIGRpYWxlY3Rz
IG9mIEJQRiBhc3NlbWJsZXIgaW4gdXNlIHRvZGF5Ogo+ID4KPiA+IC0gQSAicHNldWRvLWMiIGRp
YWxlY3QgKG9yaWdpbmFsbHkgIkJQRiB2ZXJpZmllciBmb3JtYXQiKQo+ID4gIDogcjEgPSAqKHU2
NCAqKShyMiArIDB4MDBmMCkKPiA+ICA6IGlmIHIxID4gMiBnb3RvIGxhYmVsCj4gPiAgOiBsb2Nr
ICoodTMyICopKHIyICsgMTApICs9IHIzCj4gPgo+ID4gLSBBbiAiYXNzZW1ibGVyLWxpa2UiIGRp
YWxlY3QKPiA+ICA6IGxkeGR3ICVyMSwgWyVyMiArIDB4MDBmMF0KPiA+ICA6IGpndCAlcjEsIDIs
IGxhYmVsCj4gPiAgOiB4YWRkdyBbJXIyICsgMl0sIHIzCj4KPiBEdXJpbmcgSm9zZSdzIHRhbGss
IEkgZGlzY292ZXJlZCB0aGF0IHVCUEYgZGlkbid0IHF1b3RlIG1hdGNoIHRoZSBzZWNvbmQKPiBk
aWFsZWN0Cj4gYW5kIHN1Ym1pdHRlZCBhIGJ1ZyByZXBvcnQuICBCeSB0aGUgdGltZSB0aGUgY29u
ZmVyZW5jZSB3YXMgb3ZlciwgdUJQRiBoYWQKPiBiZWVuIHVwZGF0ZWQgdG8gbWF0Y2ggR0NDLCBz
byB0aGF0IGRpc2N1c3Npb24gd29ya2VkIHRvIHJlZHVjZSB0aGUgbnVtYmVyIG9mCj4gdmFyaWFu
dHMuCj4KPiBBcyBtb3JlIGluc3RydWN0aW9ucyBnZXQgYWRkZWQgYW5kIHN1cHBvcnRlZCBieSBt
b3JlIHRvb2xzIGFuZCBjb21waWxlcnMKPiB0aGVyZSdzIHRoZSByaXNrIG9mIGV2ZW4gbW9yZSB2
YXJpYW50cyB1bmxlc3MgaXQncyBzdGFuZGFyZGl6ZWQuCj4KPiBIZW5jZSBJJ2QgcmVjb21tZW5k
IHRoYXQgQlBGIGFzc2VtYmx5IGxhbmd1YWdlIGdldCBkb2N1bWVudGVkIGluIHNvbWUgV0cKPiBk
cmFmdC4gIElmIGZvbGtzIGFncmVlIHdpdGggdGhhdCBwcmVtaXNlLCB0aGUgZmlyc3QgcXVlc3Rp
b24gaXMgdGhlbjogd2hpY2gKPiBkb2N1bWVudD8KPiBPbmUgcG9zc2libGUgYW5zd2VyIHdvdWxk
IGJlIHRoZSBJU0EgZG9jdW1lbnQgdGhhdCBzcGVjaWZpZXMgdGhlCj4gaW5zdHJ1Y3Rpb25zLAo+
IHNpbmNlIHRoYXQgd291bGQgdGhlIElBTkEgcmVnaXN0cnkgY291bGQgbGlzdCB0aGUgYXNzZW1i
bHkgZm9yIGVhY2gKPiBpbnN0cnVjdGlvbiwKPiBhbmQgYW55IGZ1dHVyZSBkb2N1bWVudHMgdGhh
dCBhZGQgaW5zdHJ1Y3Rpb25zIHdvdWxkIG5lY2Vzc2FyaWx5IG5lZWQgdG8KPiBzcGVjaWZ5Cj4g
dGhlIGFzc2VtYmx5IGZvciB0aGVtLCBwcmV2ZW50aW5nIHZhcmlhbnRzIGZyb20gc3ByaW5naW5n
IHVwIGZvciBuZXcKPiBpbnN0cnVjdGlvbnMuCj4KPiBBIHNlY29uZCBxdWVzdGlvbiB3b3VsZCBi
ZSwgd2hpY2ggZGlhbGVjdChzKSB0byBzdGFuZGFyZGl6ZS4gIEpvc2UncyBsaW5rCj4gYWJvdmUK
PiBhcmd1ZXMgdGhhdCB0aGUgc2Vjb25kIGRpYWxlY3Qgc2hvdWxkIGJlIHRoZSBvbmUgc3RhbmRh
cmRpemVkICh0b29scyBhcmUKPiBmcmVlIHRvCj4gc3VwcG9ydCBtdWx0aXBsZSBkaWFsZWN0cyBm
b3IgYmFja3dhcmRzIGNvbXBhdCBpZiB0aGV5IHdhbnQpLiAgU2VlIHRoZSBsaW5rCj4gZm9yCj4g
cmF0aW9uYWxlLgo+Cj4gVGhvdWdodHM/CgpTb21lb25lIGZyb20gQmVsbCB3aWxsIGdvIG9mZiBh
bmQgaW52ZW50IHRoZWlyIG93biB2YXJpYXRpb24gbm8gbWF0dGVyCndoYXQgd2UgZG8uIFNuYXJr
IGFzaWRlIEkgdGhpbmsgaXQncyB1c2VmdWwgZm9yIGRvY3VtZW50cyB0byBiZSBhYmxlCnRvIGNv
bnRhaW4gZXhjZXB0cyBvZiBjb2RlIHdpdGhvdXQgbmVlZGluZyB0byBleHBlY3QgcmVhZGVycyB0
byBkZWNvZGUKQlBGIGZyb20gaGV4IGluIHRoZWlyIGhlYWRzLCBhbmQgd2Ugc2hvdWxkIHdyaXRl
IGRvd24gdGhhdCBmb3JtYXQKc29tZXdoZXJlLgoKU2luY2VyZWx5LApXYXRzb24KCgotLQpBc3Ry
YSBtb3J0ZW1xdWUgcHJhZXN0YXJlIGdyYWRhdGltCgotLSAKQnBmIG1haWxpbmcgbGlzdApCcGZA
aWV0Zi5vcmcKaHR0cHM6Ly93d3cuaWV0Zi5vcmcvbWFpbG1hbi9saXN0aW5mby9icGYK

