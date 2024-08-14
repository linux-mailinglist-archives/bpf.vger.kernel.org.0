Return-Path: <bpf+bounces-37213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9192195243B
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 22:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7DE61C21251
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 20:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC261CB334;
	Wed, 14 Aug 2024 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ejs61Rhs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967CC1C3F0E
	for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 20:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723668526; cv=none; b=Kujm1ykftPZjwuBpxkh85do3RpzkuA7zzWnEW+whcbQLs/IiJyT883dkc8rNF5b91iMaHwU02XX3qDjbFDEElTf2sdVmM2TTSZXAOFoIfHUwY/tQydYhHHiuGN6immUGZHxO4CWqovqjKIbnAa6JhAcOsWqp5UgLBwfdFx/GWJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723668526; c=relaxed/simple;
	bh=49r1HWd47q8a9EDHBuCDiHOay8yVIDG+ficHLI1nQz4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JA92Z2EzRlwLjxCTvUgf/s67Pq498ALE/kY8o2SKp4KF5dHgP8idUn1K692wNVcd5kS2CznJqgUl1TVFC+mZdbrvfICUbVpHsjRtOKN9diyaaB6FD9yN1vG9sJMHNg0eZpimtVXgwsJwAxPFLbu8yevAdMOcjtX9yy4TU37oBqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ejs61Rhs; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70d316f0060so982018b3a.1
        for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 13:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723668524; x=1724273324; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CHhjnuY+QzqNRDjpkRW7RsIx5nC9uNTAADjTPGAGmZs=;
        b=Ejs61RhskPMrjfRh6c325oR2+yQccc4dz/umgbhgv2FBeoSs5uxt87d5JGGPBDzZT5
         SCzRfiSePNYUdnFqgmyD1AgubZ8oKAByMF+fvKppr0QkpuGRoAwnQB3DQIP3IekI0r5F
         mat4YRcn/qkKsuHvDsRTfHNrREvHNjG6JQUFfimnADIsDWm10D4aeh6kxzHznGiIHUNI
         TcSb4R3BqUDEZbZ99vJQdoiu5rakmoUN6zbT2bCKGEZG7bbibFf+NMn4/WtA1VX6b2aa
         dUuG44Np+4yz9w0HKThcdbLlVK3aJ0Qrm+snuxyePbEcxXXHBdbO+O9PaaH0ewXm6Zzj
         npMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723668524; x=1724273324;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHhjnuY+QzqNRDjpkRW7RsIx5nC9uNTAADjTPGAGmZs=;
        b=A2g6ZxT/RC5qvAYiV3Ho3eLJH+KkvSAxLdTfuRJvIEW0Gv0WQSNESqovVqVD1za0m5
         genYDgBw6GHu7fVbPkqBuFvbQXsoHhguvxysnBTuA34ggpBk/5EhvaZ5Zw1uz4MoBL+k
         1EancmQUbA3vp3Tj9RRO/IbNUUWKsxEQ0MWgDM1rbNQvA/ZmN0Q9y/Hx2OIbrlkBcF8U
         cjJJAcK1dLRlmy/ySZiZKY/Zh+szeMCNPyT+fDfshXvxS5ZN3rChr1mLN1n9Yfrxetpv
         HDlfNkspbRK7p6akIPThcGkuousSRzwa061hF0gZeVkA7hutwn0j8kBSvlGAMHmAFvZw
         p5tA==
X-Forwarded-Encrypted: i=1; AJvYcCUj07M9zUlhT1n/V9aEbsa5+h3n8oz98d7zG/HcouhTDtadXVWcDJ46lOXnL59gEEpPRt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQxBERsyZD411NNGZEto+B1TaB1dekWCdY/vRbC6o/p115qSa1
	vCoK166GTmy1e/KTdkxqGRuvmgg8jjOU5Y/oVjRJPRLLIzud3wBl
X-Google-Smtp-Source: AGHT+IEFAJifIIgiTbIZ9AlM1QIIovU1NwKEaw1ObDziDxleXA7KjRRlDfZt9+LRfKpMKDgLXpTcuQ==
X-Received: by 2002:a05:6a20:7490:b0:1c4:823a:6ce9 with SMTP id adf61e73a8af0-1c8f870f7e6mr1210877637.27.1723668523651;
        Wed, 14 Aug 2024 13:48:43 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6979eb64asm3606772a12.34.2024.08.14.13.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 13:48:42 -0700 (PDT)
Message-ID: <b9fc529dbe218419820f1055fed6567e2290201c.camel@gmail.com>
Subject: Re: [RFC PATCH bpf-next 3/6] selftests/test: test gen_prologue and
 gen_epilogue
From: Eduard Zingerman <eddyz87@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song
 <yonghong.song@linux.dev>, Amery Hung <ameryhung@gmail.com>, 
 kernel-team@meta.com
Date: Wed, 14 Aug 2024 13:48:38 -0700
In-Reply-To: <20240813184943.3759630-4-martin.lau@linux.dev>
References: <20240813184943.3759630-1-martin.lau@linux.dev>
	 <20240813184943.3759630-4-martin.lau@linux.dev>
Content-Type: multipart/mixed; boundary="=-B/HjIcxOLErPAiCBbqDa"
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-B/HjIcxOLErPAiCBbqDa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Martin,

Please note that after changes for struct_ops map autoload by libbpf,
test_loader could be use to test struct_ops related changes.
Also, test_loader now supports __xlated macro which allows to verify
rewrites applied by verifier.
For example, the sample below works:

    struct st_ops_args;
   =20
    struct bpf_testmod_st_ops {
    	int (*test_prologue)(struct st_ops_args *args);
    	int (*test_epilogue)(struct st_ops_args *args);
    	int (*test_pro_epilogue)(struct st_ops_args *args);
    	struct module *owner;
    };
   =20
    __success
    __xlated("0: *(u64 *)(r10 -8) =3D r1")
    __xlated("1: r0 =3D 0")
    __xlated("2: r1 =3D *(u64 *)(r10 -8)")
    __xlated("3: r1 =3D *(u64 *)(r1 +0)")
    __xlated("4: r6 =3D *(u32 *)(r1 +0)")
    __xlated("5: w6 +=3D 10000")
    __xlated("6: *(u32 *)(r1 +0) =3D r6")
    __xlated("7: r6 =3D r1")
    __xlated("8: call kernel-function")
    __xlated("9: r1 =3D r6")
    __xlated("10: call kernel-function")
    __xlated("11: w0 *=3D 2")
    __xlated("12: exit")
    SEC("struct_ops/test_epilogue")
    __naked int test_epilogue(void)
    {
    	asm volatile (
    	"r0 =3D 0;"
    	"exit;"
    	::: __clobber_all);
    }
   =20
    SEC(".struct_ops.link")
    struct bpf_testmod_st_ops st_ops =3D {
    	.test_epilogue =3D (void *)test_epilogue,
    };

(Complete example is in the attachment).
test_loader based tests can also trigger program execution via __retval() m=
acro.
The only (minor) shortcoming that I see, is that test_loader would
load/unload st_ops map multiple times because of the following
interaction:
- test_loader assumes that each bpf program defines a test;
- test_loader re-creates all maps before each test;
- libbpf struct_ops autocreate logic marks all programs referenced
  from struct_ops map as autoloaded.

I think that writing tests this way is easier to follow,
compared to arithmetic manipulations done currently.
What do you think?

Thanks,
Eduard


--=-B/HjIcxOLErPAiCBbqDa
Content-Disposition: attachment; filename="struct_ops-test_loader-example.patch"
Content-Type: text/x-patch; name="struct_ops-test_loader-example.patch"; charset="UTF-8"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL3N0cnVj
dF9vcHNfZXBpbG9ndWUuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3Rz
L3N0cnVjdF9vcHNfZXBpbG9ndWUuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAw
MDAwMDAuLjAyODI1ZDkxMDdhYwotLS0gL2Rldi9udWxsCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL3N0cnVjdF9vcHNfZXBpbG9ndWUuYwpAQCAtMCwwICsxLDkg
QEAKKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkKKworI2luY2x1ZGUg
PHRlc3RfcHJvZ3MuaD4KKyNpbmNsdWRlICJzdHJ1Y3Rfb3BzX2VwaWxvZ3VlLnNrZWwuaCIKKwor
dm9pZCB0ZXN0X3N0cnVjdF9vcHNfZXBpbG9ndWUodm9pZCkKK3sKKwlSVU5fVEVTVFMoc3RydWN0
X29wc19lcGlsb2d1ZSk7Cit9CmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9i
cGYvcHJvZ3Mvc3RydWN0X29wc19lcGlsb2d1ZS5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
YnBmL3Byb2dzL3N0cnVjdF9vcHNfZXBpbG9ndWUuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRl
eCAwMDAwMDAwMDAwMDAuLjg3MDJjOTM3NTAyMwotLS0gL2Rldi9udWxsCisrKyBiL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9ncy9zdHJ1Y3Rfb3BzX2VwaWxvZ3VlLmMKQEAgLTAsMCAr
MSw3MCBAQAorLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKKworI2luY2x1ZGUg
PGxpbnV4L2JwZi5oPgorI2luY2x1ZGUgPGJwZi9icGZfaGVscGVycy5oPgorI2luY2x1ZGUgPGJw
Zi9icGZfdHJhY2luZy5oPgorI2luY2x1ZGUgImJwZl9taXNjLmgiCisKK2NoYXIgX2xpY2Vuc2Vb
XSBTRUMoImxpY2Vuc2UiKSA9ICJHUEwiOworCitzdHJ1Y3Qgc3Rfb3BzX2FyZ3MgeworCWludCBh
OworfTsKKworc3RydWN0IGJwZl90ZXN0bW9kX3N0X29wcyB7CisJaW50ICgqdGVzdF9wcm9sb2d1
ZSkoc3RydWN0IHN0X29wc19hcmdzICphcmdzKTsKKwlpbnQgKCp0ZXN0X2VwaWxvZ3VlKShzdHJ1
Y3Qgc3Rfb3BzX2FyZ3MgKmFyZ3MpOworCWludCAoKnRlc3RfcHJvX2VwaWxvZ3VlKShzdHJ1Y3Qg
c3Rfb3BzX2FyZ3MgKmFyZ3MpOworCXN0cnVjdCBtb2R1bGUgKm93bmVyOworfTsKKworX19zdWNj
ZXNzCitfX3hsYXRlZCgiMDogKih1NjQgKikocjEwIC04KSA9IHIxIikKK19feGxhdGVkKCIxOiBy
MCA9IDAiKQorX194bGF0ZWQoIjI6IHIxID0gKih1NjQgKikocjEwIC04KSIpCitfX3hsYXRlZCgi
MzogcjEgPSAqKHU2NCAqKShyMSArMCkiKQorX194bGF0ZWQoIjQ6IHI2ID0gKih1MzIgKikocjEg
KzApIikKK19feGxhdGVkKCI1OiB3NiArPSAxMDAwMCIpCitfX3hsYXRlZCgiNjogKih1MzIgKiko
cjEgKzApID0gcjYiKQorX194bGF0ZWQoIjc6IHI2ID0gcjEiKQorX194bGF0ZWQoIjg6IGNhbGwg
a2VybmVsLWZ1bmN0aW9uIikKK19feGxhdGVkKCI5OiByMSA9IHI2IikKK19feGxhdGVkKCIxMDog
Y2FsbCBrZXJuZWwtZnVuY3Rpb24iKQorX194bGF0ZWQoIjExOiB3MCAqPSAyIikKK19feGxhdGVk
KCIxMjogZXhpdCIpCitTRUMoInN0cnVjdF9vcHMvdGVzdF9lcGlsb2d1ZSIpCitfX25ha2VkIGlu
dCB0ZXN0X2VwaWxvZ3VlKHZvaWQpCit7CisJYXNtIHZvbGF0aWxlICgKKwkicjAgPSAwOyIKKwki
ZXhpdDsiCisJOjo6IF9fY2xvYmJlcl9hbGwpOworfQorCitfX3N1Y2Nlc3MKK19feGxhdGVkKCIw
OiByNiA9ICoodTY0ICopKHIxICswKSIpCitfX3hsYXRlZCgiMTogcjcgPSAqKHUzMiAqKShyNiAr
MCkiKQorX194bGF0ZWQoIjI6IHc3ICs9IDEwMDAiKQorX194bGF0ZWQoIjM6ICoodTMyICopKHI2
ICswKSA9IHI3IikKK19feGxhdGVkKCI0OiByNyA9IHIxIikKK19feGxhdGVkKCI1OiByMSA9IHI2
IikKK19feGxhdGVkKCI2OiBjYWxsIGtlcm5lbC1mdW5jdGlvbiIpCitfX3hsYXRlZCgiNzogcjEg
PSByNiIpCitfX3hsYXRlZCgiODogY2FsbCBrZXJuZWwtZnVuY3Rpb24iKQorX194bGF0ZWQoIjk6
IHIxID0gcjciKQorX194bGF0ZWQoIjEwOiByMCA9IDAiKQorX194bGF0ZWQoIjExOiBleGl0IikK
K1NFQygic3RydWN0X29wcy90ZXN0X3Byb2xvZ3VlIikKK19fbmFrZWQgaW50IHRlc3RfcHJvbG9n
dWUodm9pZCkKK3sKKwlhc20gdm9sYXRpbGUgKAorCSJyMCA9IDA7IgorCSJleGl0OyIKKwk6Ojog
X19jbG9iYmVyX2FsbCk7Cit9CisKK1NFQygiLnN0cnVjdF9vcHMubGluayIpCitzdHJ1Y3QgYnBm
X3Rlc3Rtb2Rfc3Rfb3BzIHN0X29wcyA9IHsKKwkudGVzdF9lcGlsb2d1ZSA9ICh2b2lkICopdGVz
dF9lcGlsb2d1ZSwKKwkudGVzdF9wcm9sb2d1ZSA9ICh2b2lkICopdGVzdF9wcm9sb2d1ZSwKK307
Cg==


--=-B/HjIcxOLErPAiCBbqDa--

