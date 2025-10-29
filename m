Return-Path: <bpf+bounces-72913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F80C1D833
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 22:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1E9F4E36BC
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 21:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CEC35965;
	Wed, 29 Oct 2025 21:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9vPy88+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23422D2391
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 21:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761774595; cv=none; b=lKKsCDM4fkxdnXsPR8OtzJIZvayFPQi6SDYZ53tRoiWXs9khQ8OkpMUBhVQ1j9brtJySJ3u7IuiMXQAY4GbEbTHb+l/eGKENxPFLxwUnISOlZwBazHNq3pfuFKQtheQ7pbuuCu9ohTKtFFxsjf2G7EHwL3abo6qrcq7CqoGDhQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761774595; c=relaxed/simple;
	bh=a6dkDuGtSE7NaV931tlm2QmegFBOj7Gmcbvim5VK5EA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jTqHABrE5pd4P9x5iKMLA88jR+NsbnlQ/soH3k++q1wB/0iNyJrJD0zbu/4HLDof1cHRduaKSEFZpxdo9xsFXWUKvtm3N+heDEzFV8T68mTXgayjTxoFloyLG9achrEZHrIlUF2jqEbk7B+E+Jhv4g4XmaCwPxGNbQ+/oJuyw7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9vPy88+; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7a26dab3a97so289905b3a.0
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 14:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761774593; x=1762379393; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:to:from:subject
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a6dkDuGtSE7NaV931tlm2QmegFBOj7Gmcbvim5VK5EA=;
        b=F9vPy88+sG2ac4RmpyXWMaP0GTcXX5DckrGnYW95Og5I0dmNkQwbCoRe27dFAmE4or
         AXEnKJWVmiJWjiGupOd/Lx5yCEc+czNBh9/0lPLwypLgWRt9eDY5Vbgmy6KbSVum2Hrp
         f6rWb7SQWcocZ8lNSLZlpLyKtq+mRdZXHNlI4llmwPm25vM7qsMR2lH9IeWn2jk7E+yf
         DKUl4nMBlwQviJ8mS4jfmni7zUyzquGGbcfkDRAnPih7DRqS3ww/jPXOoAQD9KUZQYJY
         E4JZG5iosDt8olka5l5soGYAdtf9dPyTt+7pfXpMLfSPE9ZbraLLdac97kSsDmFGx8E9
         eWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761774593; x=1762379393;
        h=mime-version:user-agent:references:in-reply-to:date:to:from:subject
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a6dkDuGtSE7NaV931tlm2QmegFBOj7Gmcbvim5VK5EA=;
        b=EQHpZARu1rkayv0+3Egk/r5nQocGsU3v8AWWqRF82g39aGo88MTuiAZFVvn903Wv8y
         GBCCeYG3St4JGPdxGXMZxghD2L38CISwYLQA1xePFXLbr8njFxLoxlLrbzaDeR4ToxSU
         oELu8wlETVD2YgaAHCcjw2rxuHjmjNd9viTp3Rc3GXKXRo70RPUHvpCwIYZBfG0e9CVp
         7qcvsOXnoqZUwIm3nUbYgsZYbWBa1qj6dlfGXLDAQbrrOERFkwXXq53Phg8oQAO6OLxH
         d1Hga7IUNcNOdYSHwwhr1H+MPMSW6Sq11/PrO7RJKo91XmQpmDGgVKCrCJdqHfNKMVim
         lHVA==
X-Forwarded-Encrypted: i=1; AJvYcCVhac6FV6MbFujS8PNFEdds+BJVpukjs6JtGkAb4krXKprZbvd27gi30ChIau3smlFHy60=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQwE7kQEnnjSROspWaWFiGaaIhV7OR2WBpGNNxJ4SffYstKGdo
	/VtZCBNZYt9T0rOgUowq3X5HzFBU87lGhp+xoZsbYxLLlrlW3a9ETurI
X-Gm-Gg: ASbGncuM0z0zcVvbAWmxkIvMQf7FKmQaeZ3B/bCcyCxCvJQRGOZJZXhlHJKSYdq2ORJ
	sSo3R4i/pRAnfgBMhXX7Et6CxGIFpalFvxI6lgHSkATvfbI8F82FnNCyQVsJDPL9+k33IwmLGMr
	52MQtgn8LnGtbcnHe8KPLBkpQY0Ef1XjId8x3esTtR1H8jPOELIdCg+1SoiBwIVQMjH2HcK4wzA
	YpiQT/HGuUhrjRX4MoRb8f/X6L90ffoBp65Q15sXHBcqGIcuNBlgRZwqubKLbtCuTLI+vzbUMLj
	HEUo2ALNbahc6K2U319Hm+E6UuIgq3KTHRxBEGpcGCmDBKNXOoHSUdFKgBi6jQaWIrouxXpMNCT
	aOANA+nCn+pjSBgr2F10cl6T9gmSDPyEl2RAoTAxsmCzW7ZJw16pJJdxJFUwjlc1yLcE+CUQf5X
	fekEPgpCfRdKs5GmM/w+Ogxj3BfedDERYbsOSA
X-Google-Smtp-Source: AGHT+IE+l1kPnKGmAUxtBupnW7Axj1B9L6509DvlQkfaiyHh6S08xSGZWSxbhBTty+t/+6h825B2Pg==
X-Received: by 2002:a05:6a00:92a7:b0:7a4:2dca:8f06 with SMTP id d2e1a72fcca58-7a62476b9f1mr941349b3a.4.1761774593205;
        Wed, 29 Oct 2025 14:49:53 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:3086:7e8a:8b32:fa24? ([2620:10d:c090:500::5:6b34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414012d13sm16509127b3a.9.2025.10.29.14.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 14:49:52 -0700 (PDT)
Message-ID: <aa216ba69c31ae6cb253813379e3065ae5a850d6.camel@gmail.com>
Subject: Re: [PATCH v8 bpf-next 11/11] selftests/bpf: add C-level selftests
 for indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Wed, 29 Oct 2025 14:49:51 -0700
In-Reply-To: <20251028142049.1324520-12-a.s.protopopov@gmail.com>
References: <20251028142049.1324520-1-a.s.protopopov@gmail.com>
	 <20251028142049.1324520-12-a.s.protopopov@gmail.com>
Content-Type: multipart/mixed; boundary="=-EDbMbRes2cHw1Bvsu1fM"
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-EDbMbRes2cHw1Bvsu1fM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-10-28 at 14:20 +0000, Anton Protopopov wrote:
> Add C-level selftests for indirect jumps to validate LLVM and libbpf
> functionality. The tests are intentionally disabled, to be run
> locally by developers, but will not make the CI red.
>=20
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---

Yonghong added __BPF_FEATURE_GOTOX macro to llvm yesterday.
I think it should be used instead of '#if 0' things.
E.g. as in the attached diff (does not handle one-map-two-jumps and
one-jump-two-maps).

Still think that amount of tests added is a bit excessive,
but defer to you and Yonghong to decide.

Confirm that tests are passing when compiled with llvm
commit b2fe5d1482eb ("[SimplifyCFG] Hoist common code when succ is unreacha=
ble block (#165570)").

[...]

--=-EDbMbRes2cHw1Bvsu1fM
Content-Disposition: attachment; filename="skip.patch"
Content-Type: text/x-patch; name="skip.patch"; charset="UTF-8"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL2JwZl9n
b3RveC5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvYnBmX2dvdG94
LmMKaW5kZXggYmIwZWJkMTZkZjQzLi4yNTJmYjkwMTlkNzAgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL2JwZl9nb3RveC5jCisrKyBiL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL2JwZl9nb3RveC5jCkBAIC0xNSw3ICsxNSw2
IEBACiAKICNpbmNsdWRlICJicGZfZ290b3guc2tlbC5oIgogCi0jaWYgMAogc3RhdGljIHZvaWQg
X190ZXN0X3J1bihzdHJ1Y3QgYnBmX3Byb2dyYW0gKnByb2csIHZvaWQgKmN0eF9pbiwgc2l6ZV90
IGN0eF9zaXplX2luKQogewogCUxJQkJQRl9PUFRTKGJwZl90ZXN0X3J1bl9vcHRzLCB0b3B0cywK
QEAgLTI5LDYgKzI4LDE2IEBAIHN0YXRpYyB2b2lkIF9fdGVzdF9ydW4oc3RydWN0IGJwZl9wcm9n
cmFtICpwcm9nLCB2b2lkICpjdHhfaW4sIHNpemVfdCBjdHhfc2l6ZV9pCiAJQVNTRVJUX09LKGVy
ciwgInRlc3RfcnVuX29wdHMgZXJyIik7CiB9CiAKK3N0YXRpYyBib29sIHNraXAoc3RydWN0IGJw
Zl9nb3RveCAqc2tlbCkKK3sKKwlpZiAoc2tlbC0+YnNzLT5za2lwKSB7CisJCXRlc3RfX3NraXAo
KTsKKwkJc2tlbC0+YnNzLT5za2lwID0gMDsKKwkJcmV0dXJuIHRydWU7CisJfQorCXJldHVybiBm
YWxzZTsKK30KKwogc3RhdGljIHZvaWQgY2hlY2tfc2ltcGxlKHN0cnVjdCBicGZfZ290b3ggKnNr
ZWwsCiAJCQkgc3RydWN0IGJwZl9wcm9ncmFtICpwcm9nLAogCQkJIF9fdTY0IGN0eF9pbiwKQEAg
LTM3LDYgKzQ2LDggQEAgc3RhdGljIHZvaWQgY2hlY2tfc2ltcGxlKHN0cnVjdCBicGZfZ290b3gg
KnNrZWwsCiAJc2tlbC0+YnNzLT5yZXRfdXNlciA9IDA7CiAKIAlfX3Rlc3RfcnVuKHByb2csICZj
dHhfaW4sIHNpemVvZihjdHhfaW4pKTsKKwlpZiAoc2tpcChza2VsKSkKKwkJcmV0dXJuOwogCiAJ
aWYgKCFBU1NFUlRfRVEoc2tlbC0+YnNzLT5yZXRfdXNlciwgZXhwZWN0ZWQsICJza2VsLT5ic3Mt
PnJldF91c2VyIikpCiAJCXJldHVybjsKQEAgLTUzLDYgKzY0LDggQEAgc3RhdGljIHZvaWQgY2hl
Y2tfc2ltcGxlX2ZlbnRyeShzdHJ1Y3QgYnBmX2dvdG94ICpza2VsLAogCS8qIHRyaWdnZXIgKi8K
IAl1c2xlZXAoMSk7CiAKKwlpZiAoc2tpcChza2VsKSkKKwkJcmV0dXJuOwogCWlmICghQVNTRVJU
X0VRKHNrZWwtPmJzcy0+cmV0X3VzZXIsIGV4cGVjdGVkLCAic2tlbC0+YnNzLT5yZXRfdXNlciIp
KQogCQlyZXR1cm47CiB9CkBAIC0yMTUsNyArMjI4LDcgQEAgc3RhdGljIHZvaWQgY2hlY2tfbm9u
c3RhdGljX2dsb2JhbF9vdGhlcl9zZWMoc3RydWN0IGJwZl9nb3RveCAqc2tlbCkKIAkJY2hlY2tf
c2ltcGxlX2ZlbnRyeShza2VsLCBza2VsLT5wcm9ncy51c2Vfbm9uc3RhdGljX2dsb2JhbF9vdGhl
cl9zZWMsIGluW2ldLCBvdXRbaV0pOwogfQogCi1zdGF0aWMgdm9pZCBfX3Rlc3RfYnBmX2dvdG94
KHZvaWQpCit2b2lkIHRlc3RfYnBmX2dvdG94KHZvaWQpCiB7CiAJc3RydWN0IGJwZl9nb3RveCAq
c2tlbDsKIAlpbnQgcmV0OwpAQCAtMjYzLDE0ICsyNzYsMyBAQCBzdGF0aWMgdm9pZCBfX3Rlc3Rf
YnBmX2dvdG94KHZvaWQpCiAKIAlicGZfZ290b3hfX2Rlc3Ryb3koc2tlbCk7CiB9Ci0jZWxzZQot
c3RhdGljIHZvaWQgX190ZXN0X2JwZl9nb3RveCh2b2lkKQotewotCXRlc3RfX3NraXAoKTsKLX0K
LSNlbmRpZgotCi12b2lkIHRlc3RfYnBmX2dvdG94KHZvaWQpCi17Ci0JX190ZXN0X2JwZl9nb3Rv
eCgpOwotfQpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL2Jw
Zl9nb3RveC5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL2JwZl9nb3RveC5j
CmluZGV4IDE2YWQ2Y2YyNzljMC4uMmY3MDRmMjYwODc0IDEwMDY0NAotLS0gYS90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvYnBmX2dvdG94LmMKKysrIGIvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvYnBmL3Byb2dzL2JwZl9nb3RveC5jCkBAIC02LDkgKzYsOSBAQAogI2luY2x1ZGUg
PGJwZi9icGZfY29yZV9yZWFkLmg+CiAjaW5jbHVkZSAiYnBmX21pc2MuaCIKIAotI2lmIDAKIF9f
dTY0IGluX3VzZXI7CiBfX3U2NCByZXRfdXNlcjsKK19fdTY0IHNraXA7CiAKIHN0cnVjdCBzaW1w
bGVfY3R4IHsKIAlfX3U2NCB4OwpAQCAtMjEsMTQgKzIxLDE3IEBAIF9fdTY0IHNvbWVfdmFyOwog
ICogbnVtYmVyIG9mIGluc3RydWN0aW9ucyBieSB0aGUgdmVyaWZpZXIuIFRoaXMgYWRkcyBhZGRp
dGlvbmFsCiAgKiBzdHJlc3Mgb24gdGVzdGluZyB0aGUgaW5zbl9hcnJheSBtYXBzIGNvcnJlc3Bv
bmRpbmcgdG8gaW5kaXJlY3QganVtcHMuCiAgKi8KKyNpZmRlZiBfX0JQRl9GRUFUVVJFX0dPVE9Y
CiBzdGF0aWMgX19hbHdheXNfaW5saW5lIHZvaWQgYWRqdXN0X2luc25zKF9fdTY0IHgpCiB7CiAJ
c29tZV92YXIgXj0geCArIGJwZl9qaWZmaWVzNjQoKTsKIH0KKyNlbmRpZgogCiBTRUMoInN5c2Nh
bGwiKQogaW50IG9uZV9zd2l0Y2goc3RydWN0IHNpbXBsZV9jdHggKmN0eCkKIHsKKyNpZmRlZiBf
X0JQRl9GRUFUVVJFX0dPVE9YCiAJc3dpdGNoIChjdHgtPngpIHsKIAljYXNlIDA6CiAJCWFkanVz
dF9pbnNucyhjdHgtPnggKyAxKTsKQEAgLTU1LDEzICs1OCwxNiBAQCBpbnQgb25lX3N3aXRjaChz
dHJ1Y3Qgc2ltcGxlX2N0eCAqY3R4KQogCQlyZXRfdXNlciA9IDE5OwogCQlicmVhazsKIAl9Ci0K
KyNlbHNlCisJc2tpcCA9IDE7CisjZW5kaWYKIAlyZXR1cm4gMDsKIH0KIAogU0VDKCJzeXNjYWxs
IikKIGludCBvbmVfc3dpdGNoX25vbl96ZXJvX3NlY19vZmYoc3RydWN0IHNpbXBsZV9jdHggKmN0
eCkKIHsKKyNpZmRlZiBfX0JQRl9GRUFUVVJFX0dPVE9YCiAJc3dpdGNoIChjdHgtPngpIHsKIAlj
YXNlIDA6CiAJCWFkanVzdF9pbnNucyhjdHgtPnggKyAxKTsKQEAgLTkwLDExICs5NiwxNiBAQCBp
bnQgb25lX3N3aXRjaF9ub25femVyb19zZWNfb2ZmKHN0cnVjdCBzaW1wbGVfY3R4ICpjdHgpCiAJ
fQogCiAJcmV0dXJuIDA7CisjZWxzZQorCXNraXAgPSAxOworCXJldHVybiAwOworI2VuZGlmCiB9
CiAKIFNFQygiZmVudHJ5LyIgU1lTX1BSRUZJWCAic3lzX25hbm9zbGVlcCIpCiBpbnQgc2ltcGxl
X3Rlc3Rfb3RoZXJfc2VjKHN0cnVjdCBwdF9yZWdzICpjdHgpCiB7CisjaWZkZWYgX19CUEZfRkVB
VFVSRV9HT1RPWAogCV9fdTY0IHggPSBpbl91c2VyOwogCiAJc3dpdGNoICh4KSB7CkBAIC0xMjUs
MTEgKzEzNiwxNiBAQCBpbnQgc2ltcGxlX3Rlc3Rfb3RoZXJfc2VjKHN0cnVjdCBwdF9yZWdzICpj
dHgpCiAJfQogCiAJcmV0dXJuIDA7CisjZWxzZQorCXNraXAgPSAxOworCXJldHVybiAwOworI2Vu
ZGlmCiB9CiAKIFNFQygic3lzY2FsbCIpCiBpbnQgdHdvX3N3aXRjaGVzKHN0cnVjdCBzaW1wbGVf
Y3R4ICpjdHgpCiB7CisjaWZkZWYgX19CUEZfRkVBVFVSRV9HT1RPWAogCXN3aXRjaCAoY3R4LT54
KSB7CiAJY2FzZSAwOgogCQlhZGp1c3RfaW5zbnMoY3R4LT54ICsgMSk7CkBAIC0xODUsMTEgKzIw
MSwxNiBAQCBpbnQgdHdvX3N3aXRjaGVzKHN0cnVjdCBzaW1wbGVfY3R4ICpjdHgpCiAJfQogCiAJ
cmV0dXJuIDA7CisjZWxzZQorCXNraXAgPSAxOworCXJldHVybiAwOworI2VuZGlmCiB9CiAKIFNF
Qygic3lzY2FsbCIpCiBpbnQgYmlnX2p1bXBfdGFibGUoc3RydWN0IHNpbXBsZV9jdHggKmN0eCBf
X2F0dHJpYnV0ZV9fKCh1bnVzZWQpKSkKIHsKKyNpZmRlZiBfX0JQRl9GRUFUVVJFX0dPVE9YCiAJ
Y29uc3Qgdm9pZCAqY29uc3QganRbMjU2XSA9IHsKIAkJWzAgLi4uIDI1NV0gPSAmJmRlZmF1bHRf
bGFiZWwsCiAJCVswXSA9ICYmbDAsCkBAIC0yMjMsMTIgKzI0NCwxNiBAQCBpbnQgYmlnX2p1bXBf
dGFibGUoc3RydWN0IHNpbXBsZV9jdHggKmN0eCBfX2F0dHJpYnV0ZV9fKCh1bnVzZWQpKSkKIGRl
ZmF1bHRfbGFiZWw6CiAJYWRqdXN0X2luc25zKGN0eC0+eCArIDE3Nyk7CiAJcmV0X3VzZXIgPSAx
OTsKKyNlbHNlCisJc2tpcCA9IDE7CisjZW5kaWYKIAlyZXR1cm4gMDsKIH0KIAogU0VDKCJzeXNj
YWxsIikKIGludCBvbmVfanVtcF90d29fbWFwcyhzdHJ1Y3Qgc2ltcGxlX2N0eCAqY3R4IF9fYXR0
cmlidXRlX18oKHVudXNlZCkpKQogeworI2lmZGVmIF9fQlBGX0ZFQVRVUkVfR09UT1gKIAlfX2xh
YmVsX18gbDEsIGwyLCBsMywgbDQ7CiAJdm9pZCAqanQxWzJdID0geyAmJmwxLCAmJmwyIH07CiAJ
dm9pZCAqanQyWzJdID0geyAmJmwzLCAmJmw0IH07CkBAIC0yNTEsMTEgKzI3NiwxNiBAQCBpbnQg
b25lX2p1bXBfdHdvX21hcHMoc3RydWN0IHNpbXBsZV9jdHggKmN0eCBfX2F0dHJpYnV0ZV9fKCh1
bnVzZWQpKSkKIAogCXJldF91c2VyID0gcmV0OwogCXJldHVybiByZXQ7CisjZWxzZQorCXNraXAg
PSAxOworCXJldHVybiAwOworI2VuZGlmCiB9CiAKIFNFQygic3lzY2FsbCIpCiBpbnQgb25lX21h
cF90d29fanVtcHMoc3RydWN0IHNpbXBsZV9jdHggKmN0eCBfX2F0dHJpYnV0ZV9fKCh1bnVzZWQp
KSkKIHsKKyNpZmRlZiBfX0JQRl9GRUFUVVJFX0dPVE9YCiAJX19sYWJlbF9fIGwxLCBsMiwgbDM7
CiAJdm9pZCAqanRbM10gPSB7ICYmbDEsICYmbDIsICYmbDMgfTsKIAl1bnNpZ25lZCBpbnQgYSA9
IChjdHgtPnggPj4gMikgJiAxOwpAQCAtMjc0LDkgKzMwNCwxNCBAQCBpbnQgb25lX21hcF90d29f
anVtcHMoc3RydWN0IHNpbXBsZV9jdHggKmN0eCBfX2F0dHJpYnV0ZV9fKCh1bnVzZWQpKSkKIAog
CXJldF91c2VyID0gcmV0OwogCXJldHVybiByZXQ7CisjZWxzZQorCXNraXAgPSAxOworCXJldHVy
biAwOworI2VuZGlmCiB9CiAKIC8qIEp1c3QgdG8gaW50cm9kdWNlIHNvbWUgbm9uLXplcm8gb2Zm
c2V0cyBpbiAudGV4dCAqLworI2lmZGVmIF9fQlBGX0ZFQVRVUkVfR09UT1gKIHN0YXRpYyBfX25v
aW5saW5lIGludCBmMCh2b2xhdGlsZSBzdHJ1Y3Qgc2ltcGxlX2N0eCAqY3R4IF9fYXJnX2N0eCkK
IHsKIAlpZiAoY3R4KQpAQCAtMjg0LDEzICszMTksMjAgQEAgc3RhdGljIF9fbm9pbmxpbmUgaW50
IGYwKHZvbGF0aWxlIHN0cnVjdCBzaW1wbGVfY3R4ICpjdHggX19hcmdfY3R4KQogCWVsc2UKIAkJ
cmV0dXJuIDEzOwogfQorI2VuZGlmCiAKIFNFQygic3lzY2FsbCIpIGludCBmMShzdHJ1Y3Qgc2lt
cGxlX2N0eCAqY3R4KQogeworI2lmZGVmIF9fQlBGX0ZFQVRVUkVfR09UT1gKIAlyZXRfdXNlciA9
IDA7CiAJcmV0dXJuIGYwKGN0eCk7CisjZWxzZQorCXNraXAgPSAxOworCXJldHVybiAwOworI2Vu
ZGlmCiB9CiAKKyNpZmRlZiBfX0JQRl9GRUFUVVJFX0dPVE9YCiBzdGF0aWMgX19ub2lubGluZSBp
bnQgX19zdGF0aWNfZ2xvYmFsKF9fdTY0IHgpCiB7CiAJc3dpdGNoICh4KSB7CkBAIC0zMjIsMzAg
KzM2NCw0NyBAQCBzdGF0aWMgX19ub2lubGluZSBpbnQgX19zdGF0aWNfZ2xvYmFsKF9fdTY0IHgp
CiAKIAlyZXR1cm4gMDsKIH0KKyNlbmRpZgogCiBTRUMoInN5c2NhbGwiKQogaW50IHVzZV9zdGF0
aWNfZ2xvYmFsMShzdHJ1Y3Qgc2ltcGxlX2N0eCAqY3R4KQogeworI2lmZGVmIF9fQlBGX0ZFQVRV
UkVfR09UT1gKIAlyZXRfdXNlciA9IDA7CiAJcmV0dXJuIF9fc3RhdGljX2dsb2JhbChjdHgtPngp
OworI2Vsc2UKKwlza2lwID0gMTsKKwlyZXR1cm4gMDsKKyNlbmRpZgogfQogCiBTRUMoInN5c2Nh
bGwiKQogaW50IHVzZV9zdGF0aWNfZ2xvYmFsMihzdHJ1Y3Qgc2ltcGxlX2N0eCAqY3R4KQogewor
I2lmZGVmIF9fQlBGX0ZFQVRVUkVfR09UT1gKIAlyZXRfdXNlciA9IDA7CiAJYWRqdXN0X2luc25z
KGN0eC0+eCArIDEpOwogCXJldHVybiBfX3N0YXRpY19nbG9iYWwoY3R4LT54KTsKKyNlbHNlCisJ
c2tpcCA9IDE7CisJcmV0dXJuIDA7CisjZW5kaWYKIH0KIAogU0VDKCJmZW50cnkvIiBTWVNfUFJF
RklYICJzeXNfbmFub3NsZWVwIikKIGludCB1c2Vfc3RhdGljX2dsb2JhbF9vdGhlcl9zZWModm9p
ZCAqY3R4KQogeworI2lmZGVmIF9fQlBGX0ZFQVRVUkVfR09UT1gKIAlyZXR1cm4gX19zdGF0aWNf
Z2xvYmFsKGluX3VzZXIpOworI2Vsc2UKKwlza2lwID0gMTsKKwlyZXR1cm4gMDsKKyNlbmRpZgog
fQogCiBfX25vaW5saW5lIGludCBfX25vbnN0YXRpY19nbG9iYWwoX191NjQgeCkKIHsKKyNpZmRl
ZiBfX0JQRl9GRUFUVVJFX0dPVE9YCiAJc3dpdGNoICh4KSB7CiAJY2FzZSAwOgogCQlhZGp1c3Rf
aW5zbnMoeCArIDEpOwpAQCAtMzc0LDI4ICs0MzMsNDYgQEAgX19ub2lubGluZSBpbnQgX19ub25z
dGF0aWNfZ2xvYmFsKF9fdTY0IHgpCiAJfQogCiAJcmV0dXJuIDA7CisjZWxzZQorCXNraXAgPSAx
OworCXJldHVybiAwOworI2VuZGlmCiB9CiAKIFNFQygic3lzY2FsbCIpCiBpbnQgdXNlX25vbnN0
YXRpY19nbG9iYWwxKHN0cnVjdCBzaW1wbGVfY3R4ICpjdHgpCiB7CisjaWZkZWYgX19CUEZfRkVB
VFVSRV9HT1RPWAogCXJldF91c2VyID0gMDsKIAlyZXR1cm4gX19ub25zdGF0aWNfZ2xvYmFsKGN0
eC0+eCk7CisjZWxzZQorCXNraXAgPSAxOworCXJldHVybiAwOworI2VuZGlmCiB9CiAKIFNFQygi
c3lzY2FsbCIpCiBpbnQgdXNlX25vbnN0YXRpY19nbG9iYWwyKHN0cnVjdCBzaW1wbGVfY3R4ICpj
dHgpCiB7CisjaWZkZWYgX19CUEZfRkVBVFVSRV9HT1RPWAogCXJldF91c2VyID0gMDsKIAlhZGp1
c3RfaW5zbnMoY3R4LT54ICsgMSk7CiAJcmV0dXJuIF9fbm9uc3RhdGljX2dsb2JhbChjdHgtPngp
OworI2Vsc2UKKwlza2lwID0gMTsKKwlyZXR1cm4gMDsKKyNlbmRpZgogfQogCiBTRUMoImZlbnRy
eS8iIFNZU19QUkVGSVggInN5c19uYW5vc2xlZXAiKQogaW50IHVzZV9ub25zdGF0aWNfZ2xvYmFs
X290aGVyX3NlYyh2b2lkICpjdHgpCiB7CisjaWZkZWYgX19CUEZfRkVBVFVSRV9HT1RPWAogCXJl
dHVybiBfX25vbnN0YXRpY19nbG9iYWwoaW5fdXNlcik7Ci19CisjZWxzZQorCXNraXAgPSAxOwor
CXJldHVybiAwOwogI2VuZGlmCit9CiAKIGNoYXIgX2xpY2Vuc2VbXSBTRUMoImxpY2Vuc2UiKSA9
ICJHUEwiOwo=


--=-EDbMbRes2cHw1Bvsu1fM--

