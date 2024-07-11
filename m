Return-Path: <bpf+bounces-34516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8D492E18D
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 10:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 577301F21E7A
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 08:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E064014D283;
	Thu, 11 Jul 2024 08:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="zXo89cYO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4823F51004
	for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 08:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720685279; cv=none; b=ObYW2uBE1vn08bco9CUHMc/A95ZImBzOMU7F16CGnVY7J0h5tLPNT2BclP37FXxUnOrUzQVhfeCnEbfPkHXIO/Xzpgem2hy6ixOkX7g/7nJ/Jd6z5x5cMPsCGxyqety8i+x+FUHEjcBLOhP34w2i1+kgIL25cvym04y3QiUIjYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720685279; c=relaxed/simple;
	bh=OxQXMI4hwADNPnDDsNvITF62UjyRKuL78WHsK880+J0=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=uYsJzDlA6XvW5P0W11CrloMZnq1CaeNKSUqUkZTiYPA0IRNJ09ac3BToQptUziMyAJ7lctv7L6JEmIxnFs0v9iPrYKrjow+C5LIgxZlJ+kzpbJ13qP9u3KBWnmBZccilMwG4T+iu3oQLuOLOC8m197XVw/4NFY78xb4eAEuw3mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=zXo89cYO; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1720685275; x=1720944475;
	bh=/z57iun9sRmEOEOAOX7K0UhzGB5n8q1MbGzXlOVaqgA=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=zXo89cYObDsg3RaqPoXGRUcn7EWlkvTJkQoabmih7YAvRe8mBY7K7BZjW3UWXsqi8
	 /3ky24iCr7sIP7N593EhEJHKkH53z2vJSzrw3p+sl8vb2VESY38hsiFwdVIZNdonE6
	 +J9miaTb1Y9z/TleqOLWsShTRIBJ60+mqM3suLNbw5UdoXxGE7F9CnyfOFYuW2vOno
	 DkfiinX+5b6WWEpB3iuoPZlpjgrIeIEMGIXDLxEr1ItAcJAITLLvp0kR5pJ9M4RUZR
	 xPlFdk2mNJKuFXFTaSbtZCWT4OCbIzeE6DlcIE+e9APxPdZ5SRvw22HWkVhB/u3jnh
	 SmmMFqMQw5/tw==
Date: Thu, 11 Jul 2024 08:07:49 +0000
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
From: Zac Ecob <zacecob@protonmail.com>
Subject: Fixing coerce_subreg_to_size_sx invalidly setting reg->umax_value
Message-ID: <h3qKLDEO6m9nhif0eAQX4fVrqdO0D_OPb0y5HfMK9jBePEKK33wQ3K-bqSVnr0hiZdFZtSJOsbNkcEQGpv_yJk61PAAiO8fUkgMRSO-lB50=@protonmail.com>
Feedback-ID: 29112261:user:proton
X-Pm-Message-ID: b6b1780a07af3b1d166710a38df49b736e0d6143
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_ELAKG9rJtDpbcSOQCb3UHVbylzXzQf3FACXd0ZtkXQ"

This is a multi-part message in MIME format.

--b1_ELAKG9rJtDpbcSOQCb3UHVbylzXzQf3FACXd0ZtkXQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

My fuzzer recently found another bug, in which `reg->umax_value` is being i=
nvalidly set in regards to sign extensions.

The lines below contain the bug:
```
reg->umin_value =3D reg->u32_min_value =3D s64_min;                        =
                                    =20
reg->umax_value =3D reg->u32_max_value =3D s64_max;
```

If `s64_min` / `s64_max` are negative values here, they correctly cast when=
 assigning to the u32 values. However, when assigned to `umin_value` / `uma=
x_value`, it seems there is an implicit (u32) cast applied, causing the top=
 32 bits to not be set.


I've attached the files to reproduce, as well as the patch file, based off =
of 6.10-rc4 - albeit this is my first patch so I'd appreciate someone check=
ing it's formatted fine.

Thanks.
--b1_ELAKG9rJtDpbcSOQCb3UHVbylzXzQf3FACXd0ZtkXQ
Content-Type: application/x-xz; name=repro.tar.xz
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=repro.tar.xz

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

--b1_ELAKG9rJtDpbcSOQCb3UHVbylzXzQf3FACXd0ZtkXQ
Content-Type: text/x-patch; name=0001-Fixed-sign-extension-issue-in-coerce_subreg_to_size_.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0001-Fixed-sign-extension-issue-in-coerce_subreg_to_size_.patch

RnJvbSBkYTVlZjUyM2Y3Y2QwMThmM2YwOTkxNDU0YTE4YmM5NjFlYTFhYmJhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaYWMgRWNvYiA8emFjZWNvYkBwcm90b25tYWlsLmNvbT4KRGF0
ZTogVGh1LCAxMSBKdWwgMjAyNCAxNzo0MTo1NSArMTAwMApTdWJqZWN0OiBbUEFUQ0hdIEZpeGVk
IHNpZ24tZXh0ZW5zaW9uIGlzc3VlIGluIGNvZXJjZV9zdWJyZWdfdG9fc2l6ZV9zeAoKLS0tCiBr
ZXJuZWwvYnBmL3ZlcmlmaWVyLmMgfCAxMCArKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgOCBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2tlcm5lbC9icGYvdmVy
aWZpZXIuYyBiL2tlcm5lbC9icGYvdmVyaWZpZXIuYwppbmRleCAwMTBhNmViODY0ZGMuLmVjY2Yz
YWM4OTk2YSAxMDA2NDQKLS0tIGEva2VybmVsL2JwZi92ZXJpZmllci5jCisrKyBiL2tlcm5lbC9i
cGYvdmVyaWZpZXIuYwpAQCAtNjIxMyw4ICs2MjEzLDE0IEBAIHN0YXRpYyB2b2lkIGNvZXJjZV9y
ZWdfdG9fc2l6ZV9zeChzdHJ1Y3QgYnBmX3JlZ19zdGF0ZSAqcmVnLCBpbnQgc2l6ZSkKIAlpZiAo
KHM2NF9tYXggPj0gMCkgPT0gKHM2NF9taW4gPj0gMCkpIHsKIAkJcmVnLT5zbWluX3ZhbHVlID0g
cmVnLT5zMzJfbWluX3ZhbHVlID0gczY0X21pbjsKIAkJcmVnLT5zbWF4X3ZhbHVlID0gcmVnLT5z
MzJfbWF4X3ZhbHVlID0gczY0X21heDsKLQkJcmVnLT51bWluX3ZhbHVlID0gcmVnLT51MzJfbWlu
X3ZhbHVlID0gczY0X21pbjsKLQkJcmVnLT51bWF4X3ZhbHVlID0gcmVnLT51MzJfbWF4X3ZhbHVl
ID0gczY0X21heDsKKworCQkvLyBDYW5ub3QgY2hhaW4gYXNzaWdubWVudHMsIGxpa2UgcmVnLT51
bWF4X3ZhbCA9IHJlZy0+dTMyX21heF92YWwgPSAoc2lnbmVkIGlucHV0KQorCQkvLyBCZWNhdXNl
IG9mIHRoZSBpbXBsaWNpdCBjYXN0IGxlYWRpbmcgdG8gcmVnLT51bWF4X3ZhbCBub3QgYmVpbmcg
cHJvcGVybHkgc2V0IGZvciBuZWdhdGl2ZSBudW1iZXJzCisJCXJlZy0+dTMyX21pbl92YWx1ZSA9
IHM2NF9taW47CisJCXJlZy0+dTMyX21heF92YWx1ZSA9IHM2NF9tYXg7CisJCXJlZy0+dW1pbl92
YWx1ZSAgICA9IHM2NF9taW47CisJCXJlZy0+dW1heF92YWx1ZSAgICA9IHM2NF9tYXg7CisKIAkJ
cmVnLT52YXJfb2ZmID0gdG51bV9yYW5nZShzNjRfbWluLCBzNjRfbWF4KTsKIAkJcmV0dXJuOwog
CX0KLS0gCjIuMzAuMgoK

--b1_ELAKG9rJtDpbcSOQCb3UHVbylzXzQf3FACXd0ZtkXQ--


