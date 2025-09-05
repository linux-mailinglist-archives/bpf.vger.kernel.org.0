Return-Path: <bpf+bounces-67617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EADB4654D
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 23:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FD1E7B9D96
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 21:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C716F28688D;
	Fri,  5 Sep 2025 21:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNqfQABR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D963DE55A
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 21:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757106935; cv=none; b=cZnCYGALEHJuQip8lIyJ4PzBOBXKf+7b0YqCfCZJ/Nlk2zlxyVYZmAsKtFU4RnJJfBZTI6k3leYCZ38g8xq7AUCZXZbwSip/1D4CJi3TcQ4OpZbh8glOlDviY45R+33qHY3EopPfxq1czWXlDW1y4C+wHtQStsbhMOPriITO/04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757106935; c=relaxed/simple;
	bh=/Zo+BJ034XfB9IXj+SZSw2X5ujbS712DkzBxuoduMig=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HB2ZfgZtfcFFk5nn/8yxFlTNu4WW34qs8RG6dStcIyVFQzgEMgX+xxJ3OGTrClVsML3LiN7TGvx0yPYv2XHroXjINT3lXWfqH7ZiWOO0Ne+iYu1/UOAOfK8359QfdxMB3KKso52DlM01qZZ8sgpPFYrCmtnFAGBNty5FuoBcPU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNqfQABR; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32bab30eefbso1802594a91.1
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 14:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757106933; x=1757711733; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YsAahVQ/b0j1s5HBuHSi26LXW4hrWqCW4rYNBrB45ZA=;
        b=dNqfQABR5cyeaTyBP5nqWfVJ4wx98gMdGkewG1CQLI0dPLCSm0TMMTbkIwyb1o99pM
         W3UWKUKdYZED/lfWygb+ZE8Y7NqdBuQaDbJ7nHmT8MHN6ChbQ9tx/IHgRSSxN9G5S/4I
         Tm8fnX5FIR/6lVsHc/eLMNbsOaA6gfrkQs8GjgGyCi1o8t0saCGoCgV+b5GHtti2xvQX
         3R9uzWCuP0Vacd86LH1DE+9WgpnbAi0d+NMQsknQzMUy/XlDUmLJAcL5MzHDAhTm14fX
         cXcRFvAh92EctGc9nSflqlOtqGzlrebkXPABFu1Cwu9Crbs7fuXrOZekoSFRFFKNyf7x
         8rGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757106933; x=1757711733;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YsAahVQ/b0j1s5HBuHSi26LXW4hrWqCW4rYNBrB45ZA=;
        b=LtxooJTs2I+mg/CCxZSd8orUox4hXb2hePbOy5AM5RAhAKnVuuieOSgSeFMNd6DCF5
         C/fuW5a4pyiFxAXLV9ioBiPGNwWWWpc+BuiTe9O7F8nvSz5zDuG0B1ekNehfRUutLCOM
         smXqXL7NQ8MOH8Mm3OZdeq7XtyPOoVgAkDiYhOx5kB4LfJi3QjdhEuxESuCiRZL4jwn4
         gjLwMPCtFqi21tdJxRj1oiKsIJR7hZ0y6vQZtCDSHEa+GlqGkAK2JuXCVrWePrIkUh8W
         FL1RLchN2aGpbiw0fTaglXDRGvPxPER6I1K80m+dh2DDqOqe1PcWhxoujQhpTc5+rJxP
         RrLA==
X-Forwarded-Encrypted: i=1; AJvYcCUGsbBw5qbGoDrinuShYC0OSLuCqDXfSX/NrRnGzB6B45FhEjrMUx77PpmDu/DW+j6WgN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwheYMskpG/XXCnd7Uw/XMk1ZHal3uhhYINiw4IhrANvn5l7121
	XDvXOamiZZwqno5L8D2AYBX31fmBG6K3+xwiiH1MnzBa6IVX0iy6ywtL
X-Gm-Gg: ASbGncshu3fm3CnZO4qjkqZt6ONiFP6KR55twOjVvrKF0TjbYFcFQCnyQxdzK9CzxPw
	dn+wtjtCr0GbI/HkGfWtOu86dOIbQ1sS39RbtVjQBaZHzoOjw1PGrsCgkMdMvEh5hvxBV8e8Ab0
	nbkOpnBm7Kcx09lYcBhT2YWUqXbRwfD28+jSa2UVrLvVJoA3jKiyTDp3MRwT0E3jV8SznkJEjqW
	IieHbFLr7mJfIT3SfZgAotn8kiA7Y0UA0rki5DdydrmXL/nD/pGZ2/3CB1gG1eko6O4dHU1PZxi
	R8N2UNO1sHVPlnglnq2H3funEHIP6DZbaI6u4UmW3acekQWwFhkO72Ueoyqn9+y1wEtHKyFMy4H
	Y/tq4eF+DMUBChsv5uRvbHYsV/Vyu
X-Google-Smtp-Source: AGHT+IF0CHnTR3gOm0t5P9/vSGlMFn76+1+CkizmWIuAm6xzBZ+3OBfOzdi381SvB6GkiG5dqonjrw==
X-Received: by 2002:a17:90b:52:b0:32b:94a2:b0c4 with SMTP id 98e67ed59e1d1-32bbe227874mr5246300a91.16.1757106932998;
        Fri, 05 Sep 2025 14:15:32 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b94a2feacsm2205153a91.8.2025.09.05.14.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 14:15:32 -0700 (PDT)
Message-ID: <e7fb3f7ee5da846cfa0a477a5d31ce032416b4ee.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/7] bpf: extract generic helper from
 process_timer_func()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Fri, 05 Sep 2025 14:15:28 -0700
In-Reply-To: <20250905164508.1489482-3-mykyta.yatsenko5@gmail.com>
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
	 <20250905164508.1489482-3-mykyta.yatsenko5@gmail.com>
Content-Type: multipart/mixed; boundary="=-IaD0eJjzucoQQCrzZoH1"
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-IaD0eJjzucoQQCrzZoH1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-09-05 at 17:45 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Refactor the verifier by pulling the common logic from
> process_timer_func() into a dedicated helper. This allows reusing
> process_async_func() helper for verifying bpf_task_work struct in the
> next patch.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

The discrepancy between bpf_call_arg_meta and bpf_kfunc_call_arg_meta
is unfortunate. Maybe the bigger refactoring is possible.
Wdyt about avoiding pointers to pointers and accepting some code
duplication for now? E.g. rename process_async_func:

  /* Check if @regno is a pointer to a specific field in a map value */
  static int check_map_field_pointer(struct bpf_verifier_env *env,
                                     u32 regno,
                                     enum btf_field_type field_type,
                                     u32 field_off)

And proceed as in the attached patch?

[...]

--=-IaD0eJjzucoQQCrzZoH1
Content-Disposition: attachment; filename="check_map_field_pointer.diff"
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name="check_map_field_pointer.diff"; charset="UTF-8"

ZGlmZiAtLWdpdCBhL2tlcm5lbC9icGYvdmVyaWZpZXIuYyBiL2tlcm5lbC9icGYvdmVyaWZpZXIu
YwppbmRleCA2MTUyNTM2YTgzNGYuLjc2ZGFkN2UwZGI1ZiAxMDA2NDQKLS0tIGEva2VybmVsL2Jw
Zi92ZXJpZmllci5jCisrKyBiL2tlcm5lbC9icGYvdmVyaWZpZXIuYwpAQCAtODUyMiwxNSArODUy
MiwxNyBAQCBzdGF0aWMgaW50IHByb2Nlc3Nfc3Bpbl9sb2NrKHN0cnVjdCBicGZfdmVyaWZpZXJf
ZW52ICplbnYsIGludCByZWdubywgaW50IGZsYWdzKQogCXJldHVybiAwOwogfQogCi1zdGF0aWMg
aW50IHByb2Nlc3NfYXN5bmNfZnVuYyhzdHJ1Y3QgYnBmX3ZlcmlmaWVyX2VudiAqZW52LCBpbnQg
cmVnbm8sIHN0cnVjdCBicGZfbWFwICoqbWFwX3B0ciwKLQkJCSAgICAgIGludCAqbWFwX3VpZCwg
dTMyIHJlY19vZmYsIGVudW0gYnRmX2ZpZWxkX3R5cGUgZmllbGRfdHlwZSwKLQkJCSAgICAgIGNv
bnN0IGNoYXIgKnN0cnVjdF9uYW1lKQorLyogQ2hlY2sgaWYgQHJlZ25vIGlzIGEgcG9pbnRlciB0
byBhIHNwZWNpZmljIGZpZWxkIGluIGEgbWFwIHZhbHVlICovCitzdGF0aWMgaW50IGNoZWNrX21h
cF9maWVsZF9wb2ludGVyKHN0cnVjdCBicGZfdmVyaWZpZXJfZW52ICplbnYsCisJCQkJICAgdTMy
IHJlZ25vLAorCQkJCSAgIGVudW0gYnRmX2ZpZWxkX3R5cGUgZmllbGRfdHlwZSwKKwkJCQkgICB1
MzIgZmllbGRfb2ZmKQogewogCXN0cnVjdCBicGZfcmVnX3N0YXRlICpyZWdzID0gY3VyX3JlZ3Mo
ZW52KSwgKnJlZyA9ICZyZWdzW3JlZ25vXTsKKwljb25zdCBjaGFyICpzdHJ1Y3RfbmFtZSA9IGJ0
Zl9maWVsZF90eXBlX25hbWUoZmllbGRfdHlwZSk7CiAJYm9vbCBpc19jb25zdCA9IHRudW1faXNf
Y29uc3QocmVnLT52YXJfb2ZmKTsKIAlzdHJ1Y3QgYnBmX21hcCAqbWFwID0gcmVnLT5tYXBfcHRy
OwogCXU2NCB2YWwgPSByZWctPnZhcl9vZmYudmFsdWU7Ci0JaW50ICpzdHJ1Y3Rfb2ZmID0gKHZv
aWQgKiltYXAtPnJlY29yZCArIHJlY19vZmY7CiAKIAlpZiAoIWlzX2NvbnN0KSB7CiAJCXZlcmJv
c2UoZW52LApAQCAtODU0NywyNSArODU0OSwzMCBAQCBzdGF0aWMgaW50IHByb2Nlc3NfYXN5bmNf
ZnVuYyhzdHJ1Y3QgYnBmX3ZlcmlmaWVyX2VudiAqZW52LCBpbnQgcmVnbm8sIHN0cnVjdCBicAog
CQl2ZXJib3NlKGVudiwgIm1hcCAnJXMnIGhhcyBubyB2YWxpZCAlc1xuIiwgbWFwLT5uYW1lLCBz
dHJ1Y3RfbmFtZSk7CiAJCXJldHVybiAtRUlOVkFMOwogCX0KLQlpZiAoKnN0cnVjdF9vZmYgIT0g
dmFsICsgcmVnLT5vZmYpIHsKKwlpZiAoZmllbGRfb2ZmICE9IHZhbCArIHJlZy0+b2ZmKSB7CiAJ
CXZlcmJvc2UoZW52LCAib2ZmICVsbGQgZG9lc24ndCBwb2ludCB0byAnc3RydWN0ICVzJyB0aGF0
IGlzIGF0ICVkXG4iLAotCQkJdmFsICsgcmVnLT5vZmYsIHN0cnVjdF9uYW1lLCAqc3RydWN0X29m
Zik7CisJCQl2YWwgKyByZWctPm9mZiwgc3RydWN0X25hbWUsIGZpZWxkX29mZik7CiAJCXJldHVy
biAtRUlOVkFMOwogCX0KLQlpZiAoKm1hcF9wdHIpIHsKLQkJdmVyaWZpZXJfYnVnKGVudiwgIlR3
byBtYXAgcG9pbnRlcnMgaW4gYSAlcyBoZWxwZXIiLCBzdHJ1Y3RfbmFtZSk7Ci0JCXJldHVybiAt
RUZBVUxUOwotCX0KLQkqbWFwX3VpZCA9IHJlZy0+bWFwX3VpZDsKLQkqbWFwX3B0ciA9IG1hcDsK
IAlyZXR1cm4gMDsKIH0KIAogc3RhdGljIGludCBwcm9jZXNzX3RpbWVyX2Z1bmMoc3RydWN0IGJw
Zl92ZXJpZmllcl9lbnYgKmVudiwgaW50IHJlZ25vLAogCQkJICAgICAgc3RydWN0IGJwZl9jYWxs
X2FyZ19tZXRhICptZXRhKQogewotCXJldHVybiBwcm9jZXNzX2FzeW5jX2Z1bmMoZW52LCByZWdu
bywgJm1ldGEtPm1hcF9wdHIsICZtZXRhLT5tYXBfdWlkLAotCQkJCSAgb2Zmc2V0b2Yoc3RydWN0
IGJ0Zl9yZWNvcmQsIHRpbWVyX29mZiksIEJQRl9USU1FUiwgImJwZl90aW1lciIpOworCXN0cnVj
dCBicGZfcmVnX3N0YXRlICpyZWdzID0gY3VyX3JlZ3MoZW52KSwgKnJlZyA9ICZyZWdzW3JlZ25v
XTsKKwlpbnQgZXJyOworCisJZXJyID0gY2hlY2tfbWFwX2ZpZWxkX3BvaW50ZXIoZW52LCByZWdu
bywgQlBGX1RJTUVSLCBvZmZzZXRvZihzdHJ1Y3QgYnRmX3JlY29yZCwgdGltZXJfb2ZmKSk7CisJ
aWYgKGVycikKKwkJcmV0dXJuIGVycjsKKworCWlmICh2ZXJpZmllcl9idWdfaWYobWV0YS0+bWFw
X3B0ciwgZW52LCAiVHdvIG1hcCBwb2ludGVycyBpbiBhIGJwZl90aW1lciBoZWxwZXIiKSkKKwkJ
cmV0dXJuIC1FRkFVTFQ7CisKKwltZXRhLT5tYXBfcHRyID0gcmVnLT5tYXBfcHRyOworCW1ldGEt
Pm1hcF91aWQgPSByZWctPm1hcF91aWQ7CisJcmV0dXJuIDA7CiB9CiAKIHN0YXRpYyBpbnQgcHJv
Y2Vzc193cV9mdW5jKHN0cnVjdCBicGZfdmVyaWZpZXJfZW52ICplbnYsIGludCByZWdubywKQEAg
LTg1ODgsOSArODU5NSwyMCBAQCBzdGF0aWMgaW50IHByb2Nlc3Nfd3FfZnVuYyhzdHJ1Y3QgYnBm
X3ZlcmlmaWVyX2VudiAqZW52LCBpbnQgcmVnbm8sCiBzdGF0aWMgaW50IHByb2Nlc3NfdGFza193
b3JrX2Z1bmMoc3RydWN0IGJwZl92ZXJpZmllcl9lbnYgKmVudiwgaW50IHJlZ25vLAogCQkJCSAg
c3RydWN0IGJwZl9rZnVuY19jYWxsX2FyZ19tZXRhICptZXRhKQogewotCXJldHVybiBwcm9jZXNz
X2FzeW5jX2Z1bmMoZW52LCByZWdubywgJm1ldGEtPm1hcC5wdHIsICZtZXRhLT5tYXAudWlkLAot
CQkJCSAgb2Zmc2V0b2Yoc3RydWN0IGJ0Zl9yZWNvcmQsIHRhc2tfd29ya19vZmYpLCBCUEZfVEFT
S19XT1JLLAotCQkJCSAgImJwZl90YXNrX3dvcmsiKTsKKwlzdHJ1Y3QgYnBmX3JlZ19zdGF0ZSAq
cmVncyA9IGN1cl9yZWdzKGVudiksICpyZWcgPSAmcmVnc1tyZWdub107CisJaW50IGVycjsKKwor
CWVyciA9IGNoZWNrX21hcF9maWVsZF9wb2ludGVyKGVudiwgcmVnbm8sIEJQRl9UQVNLX1dPUkss
CisJCQkJICAgICAgb2Zmc2V0b2Yoc3RydWN0IGJ0Zl9yZWNvcmQsIHRhc2tfd29ya19vZmYpKTsK
KwlpZiAoZXJyKQorCQlyZXR1cm4gZXJyOworCisJaWYgKHZlcmlmaWVyX2J1Z19pZihtZXRhLT5t
YXAucHRyLCBlbnYsICJUd28gbWFwIHBvaW50ZXJzIGluIGEgYnBmX3Rhc2tfd29yayBoZWxwZXIi
KSkKKwkJcmV0dXJuIC1FRkFVTFQ7CisKKwltZXRhLT5tYXAucHRyID0gcmVnLT5tYXBfcHRyOwor
CW1ldGEtPm1hcC51aWQgPSByZWctPm1hcF91aWQ7CisJcmV0dXJuIDA7CiB9CiAKIHN0YXRpYyBp
bnQgcHJvY2Vzc19rcHRyX2Z1bmMoc3RydWN0IGJwZl92ZXJpZmllcl9lbnYgKmVudiwgaW50IHJl
Z25vLAo=


--=-IaD0eJjzucoQQCrzZoH1--

