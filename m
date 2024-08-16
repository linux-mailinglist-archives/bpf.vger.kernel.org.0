Return-Path: <bpf+bounces-37398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B68049551D2
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 22:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 169D1B22AB7
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 20:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2433D1C4637;
	Fri, 16 Aug 2024 20:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c47lrLeA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A011BD006
	for <bpf@vger.kernel.org>; Fri, 16 Aug 2024 20:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723840086; cv=none; b=thLMeGehzElARLhu7ZqcLxhOMS+U14Ql0JkPm2zPZq2OPOeeXLWeAbKA5iBKpmHc8UzudCA2b8rJcQlLu3lqK6vsGBq987NnKPFmd2qnaU3KUxtbLPp3e3HePoHk4+AKYw1uReY+Oj0bmUXJg5GvV2RriRfy0M1ApTWZOgAHXXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723840086; c=relaxed/simple;
	bh=m6cKv5KjSFU3KCGsphIDNgyQrGRFjdVH9ag+CuoEYJM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zx5FgpX7Miyq0LZeK7YVkxAkDVTwTzKMSxL7fVEEZu/QsdzxJMuftPUp1opXRfNiC/eBkgeVQ/i71OeKlJZNwR6N6sErcJY9h3iSpel/QvNKs67bkGF0s7eQXBeFhjc6LxTsnfN1ltt1GhX35lwQmxDebI8ivYHYX70m79BtzXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c47lrLeA; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7a1be7b7bb5so1844164a12.0
        for <bpf@vger.kernel.org>; Fri, 16 Aug 2024 13:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723840084; x=1724444884; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ciNJEW7gYNiJLfaRyGpEvzEiWA/n7KyjWMaJDrYbiJI=;
        b=c47lrLeAjAmLXxsLywBdrvoeCw687iENCMoKIN17lFoEGNqbrcJIbQGQqBIPXdXtHJ
         fQ3eLBLohSmStIuVXZ6wvk6m4W2i72XUHFKuq9EqKinwTGyxfcgvwfp5AgdOR/Bh6mqQ
         U0z3lJBAylcbXSNj6juTOpw2ykVL4xX2C+S/PPGl52matbpcdU+bj/bucw99VhSRxNgP
         rLo/rwzg11UbEGv+mu71mRuU4HeqX471Uf9tBoLSyyvn77W9qK0q8Og7YcoKVbvflgKK
         txSuXOON6ls5Q7pzHWeIrNUv0VSOj8HyZV/hWZ/dc9/ZN0M2JzWD/0bfTFxmPdqYyZLl
         jODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723840084; x=1724444884;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciNJEW7gYNiJLfaRyGpEvzEiWA/n7KyjWMaJDrYbiJI=;
        b=RXK6kH4cZgc8ex9ZihDndhgz22YQglMZUJMYN29f+Xm94rydFof3Auh+UlKiWO3Inx
         OxBcthL/TJKs+6LBiEglrDRxAZOdFQrWLBYfOMzAwqNQKKAasrES+okkhc5YEAmUth03
         JIhPvQQ4+T7AbKLiM+6PU6bpwCqtTVs4o79fB5pFAmhtPj1Yu0ibndPbFSjm2uIpmN3j
         QhIjsgA3IXcvYIbHUt4b60YG0JcJARB1h0Fi9F5yfbnXlosxdK7Mt7XdD49f1yIkU5up
         0zTRAiuNfFRoAz+H+TTAsUrLEznT/ZnZIFBKNBUGUI7k8cGZyk7QHxG99U5POn3ZHNAK
         uqqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6LZOJZwW3OE06xOQFKSaRawGA0ASsB1Sc4y9IQARWFp7mI8nPwNsPkho85aFlA7QljURX+LDuUd2Hqux2NaW/V4V3
X-Gm-Message-State: AOJu0YxDyF/qIqUsIQKwf1/41rGBFEbaXKuO/qdmnlToSi44WcdBKe5V
	jgO6X9Y8IdwcENFVXZraWFPPu9j/1qKXMaR0A7Aprq5sBrPqpO+M
X-Google-Smtp-Source: AGHT+IFG7k9Hx0lLUAJbOY5cXhBbpO6mbaawiuq59881IelPIMPQWRa1F0hdl6gIAj4HcIcpJjmVCA==
X-Received: by 2002:a17:90a:c28b:b0:2c9:96fc:ac52 with SMTP id 98e67ed59e1d1-2d3dffddd10mr4747949a91.26.1723840084224;
        Fri, 16 Aug 2024 13:28:04 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2b65aa7sm2357419a91.5.2024.08.16.13.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 13:28:03 -0700 (PDT)
Message-ID: <82a85e54945e6832f5eed24b59dd8950941345c5.camel@gmail.com>
Subject: Re: [RFC PATCH bpf-next 3/6] selftests/test: test gen_prologue and
 gen_epilogue
From: Eduard Zingerman <eddyz87@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song
 <yonghong.song@linux.dev>, Amery Hung <ameryhung@gmail.com>, 
 kernel-team@meta.com, bpf@vger.kernel.org
Date: Fri, 16 Aug 2024 13:27:58 -0700
In-Reply-To: <13f4dee5-845a-4eae-95e3-27c340261098@linux.dev>
References: <20240813184943.3759630-1-martin.lau@linux.dev>
	 <20240813184943.3759630-4-martin.lau@linux.dev>
	 <b9fc529dbe218419820f1055fed6567e2290201c.camel@gmail.com>
	 <0625a342-887c-4c27-a7a7-9f0eadc31b9d@linux.dev>
	 <92f724366153f2fbd7d9e92b6ba6f82408970dd7.camel@gmail.com>
	 <2e86ab640b6acbe8e21af826ccfeeac6c055bc69.camel@gmail.com>
	 <13f4dee5-845a-4eae-95e3-27c340261098@linux.dev>
Content-Type: multipart/mixed; boundary="=-HDZb/jIjk20p1Gms3lkz"
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-HDZb/jIjk20p1Gms3lkz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2024-08-16 at 10:27 -0700, Martin KaFai Lau wrote:

[...]

> Thanks for checking!
>=20
> I think the bpf_map__attach_struct_ops() is not done such that st_ops is =
NULL.
>=20
> It probably needs another tag in the SEC("syscall") program to tell which=
 st_ops=20
> map should be attached first before executing the "syscall" program.
>=20
> I like the idea of using the __xlated macro to check the patched prologue=
, ctx=20
> pointer saving, and epilogue. I will add this test in the respin. I will =
keep=20
> the current way in this patch to exercise syscall and the ops/func in st_=
ops for=20
> now. We can iterate on it later and use it as an example on what supports=
 are=20
> needed on the test_loader side for st_ops map testing. On the repetitive-=
enough=20
> to worth test_loader refactoring side, I suspect some of the existing st_=
ops=20
> load-success/load-failure tests may be worth to look at also. Thoughts?

You are correct, this happens because bpf_map__attach_struct_ops() is
not called. Fortunately, the change for test_loader.c is not very big.
Please check two patches in the attachment.

> I suspect some of the existing st_ops load-success/load-failure
> tests may be worth to look at also.

I suspect this is the case, but would prefer not worry about it for now :)


--=-HDZb/jIjk20p1Gms3lkz
Content-Disposition: attachment;
	filename*0=0001-selftests-bpf-attach-struct_ops-maps-before-test-pro.pat;
	filename*1=ch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch;
	name="0001-selftests-bpf-attach-struct_ops-maps-before-test-pro.patch";
	charset="UTF-8"

RnJvbSA3Yzc3ZGM1NzU3MmQ2OGUyMDZlMmZjZjIzMGIzYWExYzk0MDNmYTkzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFZHVhcmQgWmluZ2VybWFuIDxlZGR5ejg3QGdtYWlsLmNvbT4K
RGF0ZTogRnJpLCAxNiBBdWcgMjAyNCAxMzoxNjo0NiAtMDcwMApTdWJqZWN0OiBbUEFUQ0ggYnBm
LW5leHQgMS8yXSBzZWxmdGVzdHMvYnBmOiBhdHRhY2ggc3RydWN0X29wcyBtYXBzIGJlZm9yZQog
dGVzdCBwcm9nIHJ1bnMKCkluIHRlc3RfbG9hZGVyIGJhc2VkIHRlc3RzIHRvIGJwZl9tYXBfX2F0
dGFjaF9zdHJ1Y3Rfb3BzKCkKYmVmb3JlIGNhbGwgdG8gYnBmX3Byb2dfdGVzdF9ydW5fb3B0cygp
IGluIG9yZGVyIHRvIHRyaWdnZXIKYnBmX3N0cnVjdF9vcHMtPnJlZygpIGNhbGxiYWNrcyBvbiBr
ZXJuZWwgc2lkZS4KVGhpcyBhbGxvd3MgdG8gdXNlIF9fcmV0dmFsIG1hY3JvIGZvciBzdHJ1Y3Rf
b3BzIHRlc3RzLgoKU2lnbmVkLW9mZi1ieTogRWR1YXJkIFppbmdlcm1hbiA8ZWRkeXo4N0BnbWFp
bC5jb20+Ci0tLQogdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Rlc3RfbG9hZGVyLmMgfCAy
NiArKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMo
KykKCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvdGVzdF9sb2FkZXIu
YyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi90ZXN0X2xvYWRlci5jCmluZGV4IDEyYjBj
NDFlOGQ2NC4uNjdmOGQ0MjdjZmI1IDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9icGYvdGVzdF9sb2FkZXIuYworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvdGVz
dF9sb2FkZXIuYwpAQCAtNzI5LDExICs3MjksMTMgQEAgdm9pZCBydW5fc3VidGVzdChzdHJ1Y3Qg
dGVzdF9sb2FkZXIgKnRlc3RlciwKIHsKIAlzdHJ1Y3QgdGVzdF9zdWJzcGVjICpzdWJzcGVjID0g
dW5wcml2ID8gJnNwZWMtPnVucHJpdiA6ICZzcGVjLT5wcml2OwogCXN0cnVjdCBicGZfcHJvZ3Jh
bSAqdHByb2cgPSBOVUxMLCAqdHByb2dfaXRlcjsKKwlzdHJ1Y3QgYnBmX2xpbmsgKmxpbmssICps
aW5rc1szMl0gPSB7fTsKIAlzdHJ1Y3QgdGVzdF9zcGVjICpzcGVjX2l0ZXI7CiAJc3RydWN0IGNh
cF9zdGF0ZSBjYXBzID0ge307CiAJc3RydWN0IGJwZl9vYmplY3QgKnRvYmo7CiAJc3RydWN0IGJw
Zl9tYXAgKm1hcDsKIAlpbnQgcmV0dmFsLCBlcnIsIGk7CisJaW50IGxpbmtzX2NudCA9IDA7CiAJ
Ym9vbCBzaG91bGRfbG9hZDsKIAogCWlmICghdGVzdF9fc3RhcnRfc3VidGVzdChzdWJzcGVjLT5u
YW1lKSkKQEAgLTgyMyw2ICs4MjUsMjUgQEAgdm9pZCBydW5fc3VidGVzdChzdHJ1Y3QgdGVzdF9s
b2FkZXIgKnRlc3RlciwKIAkJaWYgKHJlc3RvcmVfY2FwYWJpbGl0aWVzKCZjYXBzKSkKIAkJCWdv
dG8gdG9ial9jbGVhbnVwOwogCisJCS8qIERvIGJwZl9tYXBfX2F0dGFjaF9zdHJ1Y3Rfb3BzKCkg
Zm9yIGVhY2ggc3RydWN0X29wcyBtYXAuCisJCSAqIFRoaXMgc2hvdWxkIHRyaWdnZXIgYnBmX3N0
cnVjdF9vcHMtPnJlZyBjYWxsYmFjayBvbiBrZXJuZWwgc2lkZS4KKwkJICovCisJCWJwZl9vYmpl
Y3RfX2Zvcl9lYWNoX21hcChtYXAsIHRvYmopIHsKKwkJCWlmICghYnBmX21hcF9fYXV0b2NyZWF0
ZShtYXApIHx8IGJwZl9tYXBfX3R5cGUobWFwKSAhPSBCUEZfTUFQX1RZUEVfU1RSVUNUX09QUykK
KwkJCQljb250aW51ZTsKKwkJCWlmIChsaW5rc19jbnQgPj0gQVJSQVlfU0laRShsaW5rcykpIHsK
KwkJCQlQUklOVF9GQUlMKCJ0b28gbWFueSBzdHJ1Y3Rfb3BzIG1hcHMiKTsKKwkJCQlnb3RvIHRv
YmpfY2xlYW51cDsKKwkJCX0KKwkJCWxpbmsgPSBicGZfbWFwX19hdHRhY2hfc3RydWN0X29wcyht
YXApOworCQkJaWYgKCFsaW5rKSB7CisJCQkJUFJJTlRfRkFJTCgiYnBmX21hcF9fYXR0YWNoX3N0
cnVjdF9vcHMgZmFpbGVkIGZvciBtYXAgJXM6IGVycj0lZFxuIiwKKwkJCQkJICAgYnBmX21hcF9f
bmFtZShtYXApLCBlcnIpOworCQkJCWdvdG8gdG9ial9jbGVhbnVwOworCQkJfQorCQkJbGlua3Nb
bGlua3NfY250KytdID0gbGluazsKKwkJfQorCiAJCWlmICh0ZXN0ZXItPnByZV9leGVjdXRpb25f
Y2IpIHsKIAkJCWVyciA9IHRlc3Rlci0+cHJlX2V4ZWN1dGlvbl9jYih0b2JqKTsKIAkJCWlmIChl
cnIpIHsKQEAgLTgzNyw5ICs4NTgsMTQgQEAgdm9pZCBydW5fc3VidGVzdChzdHJ1Y3QgdGVzdF9s
b2FkZXIgKnRlc3RlciwKIAkJCVBSSU5UX0ZBSUwoIlVuZXhwZWN0ZWQgcmV0dmFsOiAlZCAhPSAl
ZFxuIiwgcmV0dmFsLCBzdWJzcGVjLT5yZXR2YWwpOwogCQkJZ290byB0b2JqX2NsZWFudXA7CiAJ
CX0KKwkJLyogcmVkbyBicGZfbWFwX19hdHRhY2hfc3RydWN0X29wcyBmb3IgZWFjaCB0ZXN0ICov
CisJCXdoaWxlIChsaW5rc19jbnQgPiAwKQorCQkJYnBmX2xpbmtfX2Rlc3Ryb3kobGlua3NbLS1s
aW5rc19jbnRdKTsKIAl9CiAKIHRvYmpfY2xlYW51cDoKKwl3aGlsZSAobGlua3NfY250ID4gMCkK
KwkJYnBmX2xpbmtfX2Rlc3Ryb3kobGlua3NbLS1saW5rc19jbnRdKTsKIAlicGZfb2JqZWN0X19j
bG9zZSh0b2JqKTsKIHN1YnRlc3RfY2xlYW51cDoKIAl0ZXN0X19lbmRfc3VidGVzdCgpOwotLSAK
Mi40NS4yCgo=


--=-HDZb/jIjk20p1Gms3lkz
Content-Disposition: attachment;
	filename*0=0002-selftests-bpf-example-struct_ops-test-using-test_loa.pat;
	filename*1=ch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch;
	name="0002-selftests-bpf-example-struct_ops-test-using-test_loa.patch";
	charset="UTF-8"

RnJvbSBiYmMzNmIyYjBlYzQyZjU5OTRiZWY3NzFiZjhhODU2NDFhZWI5NjllIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFZHVhcmQgWmluZ2VybWFuIDxlZGR5ejg3QGdtYWlsLmNvbT4K
RGF0ZTogRnJpLCAxNiBBdWcgMjAyNCAxMzoxOTozOSAtMDcwMApTdWJqZWN0OiBbUEFUQ0ggYnBm
LW5leHQgMi8yXSBzZWxmdGVzdHMvYnBmOiBleGFtcGxlIHN0cnVjdF9vcHMgdGVzdCB1c2luZwog
dGVzdF9sb2FkZXIKClRoaXMgaXMgYmFzZWQgb24gc3RydWN0X29wc19zeXNjYWxsLmMgYW5kIGFp
bXMgdG8gc2hvdyB1c2FnZSBvZgpfX3hsYXRlZCBhbmQgX19yZXR2YWwgbWFjcm9zIHdoZW4gdGVz
dGluZyBzdHJ1Y3Rfb3BzIHJlbGF0ZWQKZnVuY3Rpb25hbGl0eS4KLS0tCiAuLi4vYnBmL3Byb2df
dGVzdHMvc3RydWN0X29wc19lcGlsb2d1ZS5jICAgICAgfCAgOSArKwogLi4uL3NlbGZ0ZXN0cy9i
cGYvcHJvZ3Mvc3RydWN0X29wc19lcGlsb2d1ZS5jIHwgODIgKysrKysrKysrKysrKysrKysrKwog
MiBmaWxlcyBjaGFuZ2VkLCA5MSBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA2NDQgdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvc3RydWN0X29wc19lcGlsb2d1ZS5j
CiBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL3N0
cnVjdF9vcHNfZXBpbG9ndWUuYwoKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2JwZi9wcm9nX3Rlc3RzL3N0cnVjdF9vcHNfZXBpbG9ndWUuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL3N0cnVjdF9vcHNfZXBpbG9ndWUuYwpuZXcgZmlsZSBtb2Rl
IDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMDAuLjAyODI1ZDkxMDdhYwotLS0gL2Rldi9udWxsCisr
KyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL3N0cnVjdF9vcHNfZXBp
bG9ndWUuYwpAQCAtMCwwICsxLDkgQEAKKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwt
Mi4wLW9ubHkKKworI2luY2x1ZGUgPHRlc3RfcHJvZ3MuaD4KKyNpbmNsdWRlICJzdHJ1Y3Rfb3Bz
X2VwaWxvZ3VlLnNrZWwuaCIKKwordm9pZCB0ZXN0X3N0cnVjdF9vcHNfZXBpbG9ndWUodm9pZCkK
K3sKKwlSVU5fVEVTVFMoc3RydWN0X29wc19lcGlsb2d1ZSk7Cit9CmRpZmYgLS1naXQgYS90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3Mvc3RydWN0X29wc19lcGlsb2d1ZS5jIGIvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL3N0cnVjdF9vcHNfZXBpbG9ndWUuYwpuZXcg
ZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMDAuLmNhMjM0M2U1MTU4YQotLS0gL2Rl
di9udWxsCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9ncy9zdHJ1Y3Rfb3Bz
X2VwaWxvZ3VlLmMKQEAgLTAsMCArMSw4MiBAQAorLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IEdQTC0yLjAKKworI2luY2x1ZGUgPGxpbnV4L2JwZi5oPgorI2luY2x1ZGUgPGJwZi9icGZfaGVs
cGVycy5oPgorI2luY2x1ZGUgPGJwZi9icGZfdHJhY2luZy5oPgorI2luY2x1ZGUgImJwZl9taXNj
LmgiCisKK2NoYXIgX2xpY2Vuc2VbXSBTRUMoImxpY2Vuc2UiKSA9ICJHUEwiOworCitzdHJ1Y3Qg
c3Rfb3BzX2FyZ3MgeworCWludCBhOworfTsKKworc3RydWN0IGJwZl90ZXN0bW9kX3N0X29wcyB7
CisJaW50ICgqdGVzdF9wcm9sb2d1ZSkoc3RydWN0IHN0X29wc19hcmdzICphcmdzKTsKKwlpbnQg
KCp0ZXN0X2VwaWxvZ3VlKShzdHJ1Y3Qgc3Rfb3BzX2FyZ3MgKmFyZ3MpOworCWludCAoKnRlc3Rf
cHJvX2VwaWxvZ3VlKShzdHJ1Y3Qgc3Rfb3BzX2FyZ3MgKmFyZ3MpOworCXN0cnVjdCBtb2R1bGUg
Km93bmVyOworfTsKKworX19zdWNjZXNzCitfX3hsYXRlZCgiMDogKih1NjQgKikocjEwIC04KSA9
IHIxIikKK19feGxhdGVkKCIxOiByMCA9IDAiKQorX194bGF0ZWQoIjI6IHIxID0gKih1NjQgKiko
cjEwIC04KSIpCitfX3hsYXRlZCgiMzogcjEgPSAqKHU2NCAqKShyMSArMCkiKQorX194bGF0ZWQo
IjQ6IHI2ID0gKih1MzIgKikocjEgKzApIikKK19feGxhdGVkKCI1OiB3NiArPSAxMDAwMCIpCitf
X3hsYXRlZCgiNjogKih1MzIgKikocjEgKzApID0gcjYiKQorX194bGF0ZWQoIjc6IHI2ID0gcjEi
KQorX194bGF0ZWQoIjg6IGNhbGwga2VybmVsLWZ1bmN0aW9uIikKK19feGxhdGVkKCI5OiByMSA9
IHI2IikKK19feGxhdGVkKCIxMDogY2FsbCBrZXJuZWwtZnVuY3Rpb24iKQorX194bGF0ZWQoIjEx
OiB3MCAqPSAyIikKK19feGxhdGVkKCIxMjogZXhpdCIpCitTRUMoInN0cnVjdF9vcHMvdGVzdF9l
cGlsb2d1ZSIpCitfX25ha2VkIGludCB0ZXN0X2VwaWxvZ3VlKHZvaWQpCit7CisJYXNtIHZvbGF0
aWxlICgKKwkicjAgPSAwOyIKKwkiZXhpdDsiCisJOjo6IF9fY2xvYmJlcl9hbGwpOworfQorCitf
X3N1Y2Nlc3MKK19feGxhdGVkKCIwOiByNiA9ICoodTY0ICopKHIxICswKSIpCitfX3hsYXRlZCgi
MTogcjcgPSAqKHUzMiAqKShyNiArMCkiKQorX194bGF0ZWQoIjI6IHc3ICs9IDEwMDAiKQorX194
bGF0ZWQoIjM6ICoodTMyICopKHI2ICswKSA9IHI3IikKK19feGxhdGVkKCI0OiByNyA9IHIxIikK
K19feGxhdGVkKCI1OiByMSA9IHI2IikKK19feGxhdGVkKCI2OiBjYWxsIGtlcm5lbC1mdW5jdGlv
biIpCitfX3hsYXRlZCgiNzogcjEgPSByNiIpCitfX3hsYXRlZCgiODogY2FsbCBrZXJuZWwtZnVu
Y3Rpb24iKQorX194bGF0ZWQoIjk6IHIxID0gcjciKQorX194bGF0ZWQoIjEwOiByMCA9IDAiKQor
X194bGF0ZWQoIjExOiBleGl0IikKK1NFQygic3RydWN0X29wcy90ZXN0X3Byb2xvZ3VlIikKK19f
bmFrZWQgaW50IHRlc3RfcHJvbG9ndWUodm9pZCkKK3sKKwlhc20gdm9sYXRpbGUgKAorCSJyMCA9
IDA7IgorCSJleGl0OyIKKwk6OjogX19jbG9iYmVyX2FsbCk7Cit9CisKK3N0cnVjdCBzdF9vcHNf
YXJnczsKK2ludCBicGZfa2Z1bmNfc3Rfb3BzX3Rlc3RfcHJvbG9ndWUoc3RydWN0IHN0X29wc19h
cmdzICphcmdzKSBfX2tzeW07CisKK1NFQygic3lzY2FsbCIpCitfX3JldHZhbCgxMTEwKQoraW50
IHN5c2NhbGxfcHJvbG9ndWUodm9pZCAqY3R4KQoreworCXN0cnVjdCBzdF9vcHNfYXJncyBhcmdz
ID0ge307CisJYnBmX2tmdW5jX3N0X29wc190ZXN0X3Byb2xvZ3VlKCZhcmdzKTsKKwlyZXR1cm4g
YXJncy5hOworfQorCitTRUMoIi5zdHJ1Y3Rfb3BzLmxpbmsiKQorc3RydWN0IGJwZl90ZXN0bW9k
X3N0X29wcyBzdF9vcHMgPSB7CisJLnRlc3RfZXBpbG9ndWUgPSAodm9pZCAqKXRlc3RfZXBpbG9n
dWUsCisJLnRlc3RfcHJvbG9ndWUgPSAodm9pZCAqKXRlc3RfcHJvbG9ndWUsCit9OwotLSAKMi40
NS4yCgo=


--=-HDZb/jIjk20p1Gms3lkz--

