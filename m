Return-Path: <bpf+bounces-22516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B246885FF5F
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 18:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2491F23262
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 17:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888EB157E89;
	Thu, 22 Feb 2024 17:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="Rx6ciVzH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="K6z++6Rq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATDqusFN"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCC115699C
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 17:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622946; cv=none; b=DC/YfmwtLl7IFaEWcNOIqRsWRniHLoatcfGi7mw55JKhvPmA+kdJLQIXassTrNpPXAXJbqeuL8F7m7dbvQ1iG6JcGNVTU+cBLJwxJeYucXd+WkU1u/fx2ElrgbTXxxZC/lTU8IdMJeb09DNqvLGXEEYqPHUurUPpZWCPQG4w06o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622946; c=relaxed/simple;
	bh=+KbNzrTOzOAcVeDWE7Tmr4lFOyaxriGwwgkUpHhrN3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:To:Cc:
	 Subject:Content-Type; b=RkSvdVJbKOpGQVFwBmK1DwQeB6GwvWKeXjoe1Hq93k9b0WTnj/FDdQbmht483AhVy1IEY4u6KpjzwYXgrJNvNpcIIMUV58EhqfnbvrzhDIykTakjXO0SIrg4boOKtnQ8ChBb44+VU6dG5OC6ikfJidZmBMEH+KyMPYcfCHQw6iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=Rx6ciVzH; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=K6z++6Rq; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATDqusFN reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 0B44AC18DB9D
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 09:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1708622944; bh=+KbNzrTOzOAcVeDWE7Tmr4lFOyaxriGwwgkUpHhrN3A=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=Rx6ciVzHm+KGVn7zk5xvAe2Jut24rjPqRclebzzaXlR7mOPTs5VBuXuMdJCeOmxgr
	 xhDmBnpfGsGEBpBuBF4rQAXgIJ0YCbspFlwnci52spUDbumgyF/MPV3OuC9JoBrmpq
	 X09jsKfKdnbU9dK9nAz+qqLhrCUi4qBaPmN1BS+A=
X-Mailbox-Line: From bpf-bounces@ietf.org  Thu Feb 22 09:29:03 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id DF0A2C17C8B0;
	Thu, 22 Feb 2024 09:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1708622943; bh=+KbNzrTOzOAcVeDWE7Tmr4lFOyaxriGwwgkUpHhrN3A=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=K6z++6RqEKmMyIkvi/h8O6iw+tHQrfirIRZPscummhgoiAGZyQKS9CTul+M9r/O5z
	 d5BK+l3H1Uh3S4a9NXy8H6qk7szIAOY34pUI531l41bxDJUUopbVAflDwD0eWqqyX3
	 mdWfTQWsub+RqpGZxb5XNsbJUsO20TdEbLSqu6zE=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 1824DC17C8B0
 for <bpf@ietfa.amsl.com>; Thu, 22 Feb 2024 09:29:03 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.108
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 22yZF23D-WQK for <bpf@ietfa.amsl.com>;
 Thu, 22 Feb 2024 09:29:01 -0800 (PST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id F2E53C15170B
 for <bpf@ietf.org>; Thu, 22 Feb 2024 09:29:00 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33d8d5165dbso581838f8f.1
 for <bpf@ietf.org>; Thu, 22 Feb 2024 09:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708622939; x=1709227739; darn=ietf.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bmVOvrfBOyH5HYw70mAyWuU5BlTwyJCt3mxbttKweDo=;
 b=ATDqusFNb6wI4DvlOynDhr5CYnzJ5Qd4OoSjO+XJk1WOCg/Ryz4N+8KrIxstlzticP
 QGeMAB8+9IS2ypQfYFMkz5ofkAfzyTKZDuhw6gmSbhySR3fIwOzFh7AwLld9gPjBK6H+
 9fNV/AQpXwg7vT4XQYOfHByG+q+Cgbh7medHWaTt/Qq0QVvQrnXFO+e/MuKc5oFh9JIL
 mQ/ThigK2kviKxxs/hA4fhyCQeQutbfKmRP6SiR8UYIWp1j94Xxzud93nEix8uSWOqhC
 /8ncdAaG6GRMXyCArkALcfY3ZoVUoz4DSWJ0CSRyIzmTAgiVZiB17h7pYz1AdelUCFIx
 EltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708622939; x=1709227739;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bmVOvrfBOyH5HYw70mAyWuU5BlTwyJCt3mxbttKweDo=;
 b=Veq38NH+XjKBGanmf8uGUah/dyamIqYZgpz9qlJvtX/K0AeVGfJAe3FiTw1gFX5owN
 P+PGfJaGAfCpkoRKlhbCTA2/EZ1EmeCBxEE8RQL+cP97zOJxNSjSAnJdcXWkiwfwArjC
 9sk5HgVuX1tHtqxSyRJ2SEU+e2xLyUzgHIKS5dq/gCSs6tlyl3fuq8E9Rni7W4uRyaYc
 daiqnaqirF2yFCnozrN8TCjoEyDpPdHRyL48nIfk71MwfbZtEzeGFbDoKopBGVmt02vY
 F5tcH/gDskBAKk1fiTJ8yNdbSp4MG6n7e1hMjxWtIYM7Qs2eocLAsStZZA8VszlQaN/D
 arUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtti/NfgA0ncuu+cmWjk37kDGkKnQ74rh/Mku/omW8jPR3u90WiRggs8bqht+E+Tj1KpQKIRBtEGY33fg=
X-Gm-Message-State: AOJu0YyjRedux4K9rIptU6LVjyY4X4ZOkYl6DwCEBbFizWoVYvFdlc1w
 pHELyD2S17uVWqIGmpcc9/2ns28N2hlK3ZrjksC6l69OjP/rob1ClYabHabywSBgtmGj7MEYDml
 xYN5xEgvABtj7gjG1ePwAsHd/S0s=
X-Google-Smtp-Source: AGHT+IGtBUxwQVQR+4XZGBCh39LhtLKXvCgK5lVDvYph37wboINgejFecRbM6gtDmmPASF5y7Sk2G8mdTNBtiec/H6A=
X-Received: by 2002:a5d:5645:0:b0:33d:3b83:c0a with SMTP id
 j5-20020a5d5645000000b0033d3b830c0amr9254121wrw.34.1708622939255; Thu, 22 Feb
 2024 09:28:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221191725.17586-1-dthaler1968@gmail.com>
In-Reply-To: <20240221191725.17586-1-dthaler1968@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 Feb 2024 09:28:47 -0800
Message-ID: <CAADnVQJq0aG2kF2KN1SCM9cZtRLqxKG=UkF=5-XWjFBbvLZhhQ@mail.gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>, 
 "Jose E. Marchesi" <jose.marchesi@oracle.com>,
 Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, bpf@ietf.org,
 Dave Thaler <dthaler1968@gmail.com>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/vIc2DtkDl5txehMy7L6vtmkCJfU>
Subject: Re: [Bpf] [PATCH bpf-next v4] bpf,
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

T24gV2VkLCBGZWIgMjEsIDIwMjQgYXQgMTE6MTfigK9BTSBEYXZlIFRoYWxlciA8ZHRoYWxlcjE5
NjhAZ29vZ2xlbWFpbC5jb20+IHdyb3RlOgo+Cj4gLUJQRl9DQUxMICAweDggICAgMHgwICBjYWxs
IGhlbHBlciBmdW5jdGlvbiBieSBhZGRyZXNzICBCUEZfSk1QIHwgQlBGX0sgb25seSwgc2VlIGBI
ZWxwZXIgZnVuY3Rpb25zYF8KPiArQlBGX0NBTEwgIDB4OCAgICAweDAgIGNhbGxfYnlfYWRkcmVz
cyhpbW0pICAgICAgICAgICAgIEJQRl9KTVAgfCBCUEZfSyBvbmx5Cj4gK0JQRl9DQUxMICAweDgg
ICAgMHgwICBjYWxsX2J5X2FkZHJlc3MoZHN0KSAgICAgICAgICAgICBCUEZfSk1QIHwgQlBGX1gg
b25seQoKLi4uCgo+ICsqIGNhbGxfYnlfYWRkcmVzcyh2YWx1ZSkgbWVhbnMgdG8gY2FsbCBhIGhl
bHBlciBmdW5jdGlvbiBieSB0aGUgYWRkcmVzcyBzcGVjaWZpZWQgYnkgJ3ZhbHVlJyAoc2VlIGBI
ZWxwZXIgZnVuY3Rpb25zYF8gZm9yIGRldGFpbHMpCgoKU29ycnksIHdlJ3JlIG5vdCBnb2luZyB0
byB0YWtlIHRoaXMgcGF0aCBpbiB0aGUga2VybmVsIHZlcmlmaWVyLgpJIHVuZGVyc3RhbmQgdGhh
dCB5b3Ugd2VudCB3aXRoIHRoaXMgc2VtYW50aWNzIGluIFBSRVZBSUwgdmVyaWZpZXIsCmJ1dCB0
aGlzIGlzIHVzZXIgc3BhY2UgYW5kIEkgc3VzcGVjdCBvbmNlIFBSRVZBSUwgZm9sa3MgcmVhbGl6
ZQp0aGF0IGl0J3Mgbm90IHRoYXQgdXNlZnVsIHlvdSB3aWxsIGNoYW5nZSB0aGF0LgpVc2VyIHNw
YWNlIGhhcyBhIGx1eHVyeSB0byBjaGFuZ2UuIFRoZSBrZXJuZWwgZG9lc24ndAphbmQgd2Ugd29u
J3QgYmUgYWJsZSB0byBjaGFuZ2Ugc3VjaCB0aGluZ3MgaW4gdGhlIHN0YW5kYXJkIGVpdGhlci4K
CkVzc2VudGlhbGx5IHdoYXQgeW91J3JlIHByb3Bvc2luZyBpcyB0byB0cmVhdApjYWxseCBkc3Rf
cmVnCmFzIGNhbGxpbmcgYW55IG9mIHRoZSBleGlzdGluZyBoZWxwZXJzIGJ5IGEgbnVtYmVyLgpM
ZXQncyBsb29rIGF0IHRoZSBmaXJzdCB+NjoKaWQgPSAxICB2b2lkICpicGZfbWFwX2xvb2t1cF9l
bGVtKHN0cnVjdCBicGZfbWFwICptYXAsIGNvbnN0IHZvaWQgKmtleSkKaWQgPSAyIGxvbmcgYnBm
X21hcF91cGRhdGVfZWxlbShzdHJ1Y3QgYnBmX21hcCAqbWFwLCBjb25zdCB2b2lkICprZXksCmNv
bnN0IHZvaWQgKnZhbHVlLCB1NjQgZmxhZ3MpCi4uLgppZCA9IDYgbG9uZyBicGZfdHJhY2VfcHJp
bnRrKGNvbnN0IGNoYXIgKmZtdCwgdTMyIGZtdF9zaXplLCAuLi4pCgpUaGV5IGhhdmUgYWxtb3N0
IG5vdGhpbmcgaW4gY29tbW9uLgpJbiBDIHRoYXQgd291bGQgYmUgYW4gaW5kaXJlY3QgY2FsbCBv
ZiAibG9uZyAoKmZuKSguLi4pIgpqdXN0IGNhbGwgYW55dGhpbmcgYW5kIGhvcGUgaXQgd29ya3Mu
ClRoaXMgaXMgbm90IHVzZWZ1bCBpbiBwcmFjdGljZS4KCkFsc28gY29tbWl0IGxvZyBpcyB3cm9u
ZzoKCj4gT25seSBzcmM9MCBpcyBjdXJyZW50bHkgbGlzdGVkIGZvciBjYWxseC4gTmVpdGhlciBj
bGFuZyBub3IgZ2NjCj4gdXNlIHNyYz0xIG9yIHNyYz0yLCBhbmQgYm90aCB1c2UgZXhhY3RseSB0
aGUgc2FtZSBzZW1hbnRpY3MgZm9yCj4gc3JjPTAgd2hpY2ggd2FzIGFncmVlZCBiZXR3ZWVuIHRo
ZW0gKFlvbmdob25nIGFuZCBKb3NlKS4KCnRoaXMgaXMgbm90IGF0IGFsbCB3aGF0IGdjYyBhbmQg
Y2xhbmcgYXJlIGRvaW5nLgpUaGV5IGVtaXQgImNhbGx4IGRzdF9yZWciIHdoZW4gdGhleSBuZWVk
IHRvIGNvbXBpbGUgYSBub3JtYWwgaW5kaXJlY3QgY2FsbAp3aGljaCBhZGRyZXNzIGlzIGluIGRz
dF9yZWcuCkl0J3MgdGhlIHJlYWwgYWRkcmVzcyBvZiB0aGUgZnVuY3Rpb24gYW5kIG5vdCBhIGhl
bHBlciBJRC4KCkhlbmNlIHRoZXNlIHR3bzoKPiArQlBGX0NBTEwgIDB4OCAgICAweDAgIGNhbGxf
YnlfYWRkcmVzcyhpbW0pICAgICAgICAgICAgIEJQRl9KTVAgfCBCUEZfSyBvbmx5Cj4gK0JQRl9D
QUxMICAweDggICAgMHgwICBjYWxsX2J5X2FkZHJlc3MoZHN0KSAgICAgICAgICAgICBCUEZfSk1Q
IHwgQlBGX1ggb25seQoKYXJlIG5vdCBjb3JyZWN0LgpjYWxsIGltbSBpcyBhIGNhbGwgb2YgaGVs
cGVyIHdpdGggYSBnaXZlbiBJRC4KY2FsbHggZHN0X3JlZyBpcyBhIGNhbGwgb2YgYSBmdW5jdGlv
biBieSBpdHMgcmVhbCBhZGRyZXNzLgoKVGhpcyBpcyBfcHJlbG1pbmFyeV8gZGVmaW5pdGlvbiBv
ZiBjYWxseCBkc3RfcmVnIGZyb20gY29tcGlsZXIgcG92LApidXQgdGhlcmUgaXMgbm8gaW1wbGVt
ZW50YXRpb24gb2YgaXQgaW4gdGhlIGtlcm5lbCwgc28KaXQncyB3YXkgdG9vIGVhcmx5IHRvIGhh
cmQgY29kZSBzdWNoIHNlbWFudGljcyBpbiB0aGUgc3RhbmRhcmQuCgpwdy1ib3Q6IGNyCgotLSAK
QnBmIG1haWxpbmcgbGlzdApCcGZAaWV0Zi5vcmcKaHR0cHM6Ly93d3cuaWV0Zi5vcmcvbWFpbG1h
bi9saXN0aW5mby9icGYK

