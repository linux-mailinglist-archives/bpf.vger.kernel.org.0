Return-Path: <bpf+bounces-31879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FD690458A
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 22:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B800B21B34
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 20:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73690147C86;
	Tue, 11 Jun 2024 20:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfDDPdZe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A4E2628D
	for <bpf@vger.kernel.org>; Tue, 11 Jun 2024 20:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718136595; cv=none; b=tE19IBhwNQQoeYdfX922nfhC9oyRX0Vk9B7QrGbnNdBoBlcEQJW6yrTJkTTZ+hSvr+qDPKmaErNSUSAsYSADKF1zeMW1Fp1JDrbGRpl0tt4Qnua+7p3mSwvQKA4qgMzHvUNivCWy/TLrLrRS+Te+X9k8MXXZ28dkkO15zeKX+Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718136595; c=relaxed/simple;
	bh=Pg+4uS9C6CMwDSf7sSrxpzWrngn92/RvhsbmeKO+5to=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u3TQaWrU2imnIKSQejsIRJzcpYj7eHULiPUfMn99foCCdSo5rGJvVq0I4gSslfz7xmgNost7IrT60mAec9egBtWG9qE0hj4KD61HfK7PpaEIRkIxPprxfi0ryq4Lo5R/YKGMourmVvWGWSV9X971yVT8R8ETF4d5jJGWauN6Xus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfDDPdZe; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f6f38b1ab0so11371815ad.1
        for <bpf@vger.kernel.org>; Tue, 11 Jun 2024 13:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718136593; x=1718741393; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YIzuGKna/lvduLGXKinDZ+dPv563Iqvl9Nx8SBjhiRU=;
        b=TfDDPdZe2U5XCM+ePXrItaZB3DOvaxD+uvJ2zb7airBoID3Mn1InRMRRPTn2MG1Vn0
         LLfy+1DW8vqCaUm3Yo27l6AkNfPeMPLhbr2f0grFFJ7roXXmmW69rJe0x7i+DhXhokxW
         hkm+IAlvAwMoKm2nLZI5pd0rKZoIrqo1taspKZsagxv4ZK3H3TXpORFO7n0JV9/NF3z/
         CJhQ3jbhXhxCXE5HEEjsYqZKA6YRRH7aU9kmnm9z+vDOEqieEhslhv97N52DFIC3+IJ4
         LQ6ixQcioGMwGG12BzmvuinUaIT3bMQLYC62ggXrvbsBlTRZF/GEXi4UCTc/TlrJnoQf
         G9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718136593; x=1718741393;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YIzuGKna/lvduLGXKinDZ+dPv563Iqvl9Nx8SBjhiRU=;
        b=tS2HpgXtBLajrOeR4Md8pu5t7LvXAaqmWIBbyuZtTprnS8lJSvbc6F+0lg6x2hkOy8
         V434BID5SsYBrRYdBDoim3HkwaF0PP0eUcsPNM/fh2Oe8pfECe2rEAumRAP0wK9zbBqJ
         e8ZVvbdPLT4rAjOz0FLnmF+HBuTik3vqhRko9vrcmXywZW1l9aV+QdkZHrTs46aZVaDA
         qs+cKJ7bKBqX16X1HFpjw7JOcLcFHRwAgnUYJ68PmaIhLC4jCmp/DDJzwCdSOSGuoq9B
         HceZZDDP2uBAnsIp/RrFUP7P0xGZ8UObXUrAlOh7ohov7+U/W/kkqQxQ/43G/I3VwYhD
         XHhQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2etDXkWx/B5Wt+6WbM4dqYS0gMU14uRI2oT7PZDmnwt1SaXqE384ThJZunsqO4QRdi09smTiTYUVdxLMUbPtQbB8t
X-Gm-Message-State: AOJu0YynUwEaCgiZmtRZVRbj4Xxy6YZDzthgBaqr7npqoHyVwkkJxevG
	q/smvIm2p8ylYoQS0DwPYn+It1bE0Adq1lWsw3nLLl0jre6j+9J34/1JOQ==
X-Google-Smtp-Source: AGHT+IFgZnLp+BYx7skkUkOOIqxAwA5ikl/zo7Yez5ca/DBJ/ppyRHA6haBa1y1CCOnlkvyNyra5Og==
X-Received: by 2002:a17:902:dace:b0:1f7:2ab7:380f with SMTP id d9443c01a7336-1f72ab74b4fmr40058525ad.21.1718136592702;
        Tue, 11 Jun 2024 13:09:52 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6ed896cc9sm71922965ad.232.2024.06.11.13.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 13:09:52 -0700 (PDT)
Message-ID: <d454304daffd5fcd8b442f2e29aa493c426dc991.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/4] bpf: Track delta between "linked"
 registers.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	memxor@gmail.com, kernel-team@fb.com
Date: Tue, 11 Jun 2024 13:09:47 -0700
In-Reply-To: <20240610230849.80820-3-alexei.starovoitov@gmail.com>
References: <20240610230849.80820-1-alexei.starovoitov@gmail.com>
	 <20240610230849.80820-3-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-10 at 16:08 -0700, Alexei Starovoitov wrote:

[...]

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 50aa87f8d77f..2b54e25d2364 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -73,7 +73,10 @@ enum bpf_iter_state {
>  struct bpf_reg_state {
>  	/* Ordering of fields matters.  See states_equal() */
>  	enum bpf_reg_type type;
> -	/* Fixed part of pointer offset, pointer types only */
> +	/*
> +	 * Fixed part of pointer offset, pointer types only.
> +	 * Or constant delta between "linked" scalars with the same ID.
> +	 */
>  	s32 off;

After thinking about this some more I came to conclusion that ->off
has to be checked for scalar registers in regsafe().
Otherwise the following test is marked as safe:

char buf[10] SEC(".data.buf");

SEC("socket")
__failure
__flag(BPF_F_TEST_STATE_FREQ)
__naked void check_add_const_regsafe_off(void)
{
	asm volatile (
	"r8 =3D %[buf];"
	"call %[bpf_ktime_get_ns];"
	"r6 =3D r0;"
	"call %[bpf_ktime_get_ns];"
	"r7 =3D r0;"
	"call %[bpf_ktime_get_ns];"
	"r1 =3D r0;"		/* same ids for r1 and r0 */
	"if r6 > r7 goto 1f;"	/* this jump can't be predicted */
	"r1 +=3D 1;"		/* r1.off =3D=3D +1 */
	"goto 2f;"
	"1: r1 +=3D 100;"		/* r1.off =3D=3D +100 */
	"goto +0;"		/* force checkpoint, must verify r1.off in regsafe() here */
	"2: if r0 > 8 goto 3f;"	/* r0 range [0,8], r1 range either [1,9] or [100,1=
08]*/
	"r8 +=3D r1;"
	"*(u8 *)(r8 +0) =3D r0;"	/* potentially unsafe, buf size is 10 */
	"3: exit;"
	:
	: __imm(bpf_ktime_get_ns),
	  __imm_ptr(buf)
	: __clobber_common);
}

Sorry for missing this yesterday.
Something like below is necessary.
(To trigger ((rold->id & BPF_ADD_CONST) !=3D (rcur->id & BPF_ADD_CONST))
 a variation of the test where r1 +=3D 1 is not done is necessary).

---

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ad11e5441860..70e44fa4f765 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16797,6 +16797,10 @@ static bool regsafe(struct bpf_verifier_env *env, =
struct bpf_reg_state *rold,
                }
                if (!rold->precise && exact =3D=3D NOT_EXACT)
                        return true;
+               if ((rold->id & BPF_ADD_CONST) !=3D (rcur->id & BPF_ADD_CON=
ST))
+                       return false;
+               if ((rold->id & BPF_ADD_CONST) && (rold->off !=3D rcur->off=
))
+                       return false;
                /* Why check_ids() for scalar registers?
                 *
                 * Consider the following BPF code:


