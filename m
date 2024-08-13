Return-Path: <bpf+bounces-37111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9CE950F84
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 00:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F3241F23908
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 22:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EC71A38D0;
	Tue, 13 Aug 2024 22:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Izldg9G3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2821125776
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 22:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723586475; cv=none; b=dBWYXZb1PUVpfdtQGFpgk5whIU8UE80CdSUSexs1IJz3eRlZ2vdsnneciEiDqxM/GZVo05ehrYAWxLIRbhziGJUML/dtEsbYVdmKRddOpOmk7tawpDE6qC7TtkI0OOD417v5oDKvNv6SlkpF7M6D+R2bJ04CvTCpzP82DQfqo3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723586475; c=relaxed/simple;
	bh=pa0wiu5uxGmI2ILe3G0KF6DqXYO/Nxspukst4UHzSOM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oFbI0/p3PoIPM5GsZVX8oN7t+j9LjRLSZGMC4VjVQH0b3o3IG+pgKELgwFaRQRiC4ZyIkOHTFpJR+zsphxUbpT3Bbb2XiPdBVuzdViRoFp0xGH11Yy7D43kGWJqdWk2l90dLmMyLmVvh+Qh8kaP2SvKpnEiQ5T1jmx4UiThr9Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Izldg9G3; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fc52394c92so54863515ad.1
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 15:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723586473; x=1724191273; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g9rhVKCVd7SNly8KU3/h4zfoX8MB4NOin4V/BWv3CJ4=;
        b=Izldg9G3Vpon43ndG7K8ueUtxLMm2Vq7QeHzEtGFNq7D/RzVe2XDUjCI9gWHele5yv
         dN4BP7x+eywy8Y5ojTbC0AF2FyykcCnVzd2MtCO8SBH5qrAbI78lS0LTKEobCfzaCgSq
         mKs1QsvwaaSWwUbd8VVfrYPK1w43ZnVT3l+ZWNSg9aaXgpTsBsD/rndZr1EoFdc9Cl/h
         43hsIzzgedkJfeJ8lCSvP64gzycIM/eXrhtKx5N/BvXiakI3qMk/reDV6NWf9mhc36+G
         gXAqodMes+o9G2ot/Nb7hPzKq+9kDzxubAd+693Vqdu9M+7XTk8wfwqJ0nhuCiHideWT
         vdhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723586473; x=1724191273;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g9rhVKCVd7SNly8KU3/h4zfoX8MB4NOin4V/BWv3CJ4=;
        b=J1jnHvYOOhyHdCb16LV74NsWjv77azb1XvcWZk+Di1PMAg8xoJP8ayLXgmqzo0eJTT
         P8eTWkadMaKuTl3B6ikDbW6IHbytlhuOl8k2UgSHLaXG5tEselKjolAB5JLn2XxTlxKu
         DtkTTFsRHsScDt+2T78vZNe15LTWP4S5l8Lqpacz67VB+PQeiAJmbXvknZklpkPIpBkA
         gGiYcgOGtb4CvtYQeo16C/WAvVasMh+IjTxgI795EFsl2kqakBlLSot/5zjsmgSOd+MP
         5G4L+ZjHq17YmL59fIaSfPepvdtW0/NyFvwT85sW3nhAjoEqPv2QoKPclsFlDBEgIDjU
         Xebw==
X-Forwarded-Encrypted: i=1; AJvYcCWM6OelWJVb1Vwcx4McifPIZl4MJkRLHAYo7M6mo4LkDU2KDpqJiO4PzOZvaicJFJxUlpwhY5g1BILh4I+eHLCwHGnx
X-Gm-Message-State: AOJu0YxmHUsjFWeCrHjtomSbQSnptsrKLK/zq9GM3M1HpSxFrWElc9k5
	N48vdcnyv2Akdkyiz7UR9cpAKcuKDZKKX7p6qO82N3Gf3gZbmI/9
X-Google-Smtp-Source: AGHT+IETnSPota5BCST1j0hLA29+Uxuks2C1ALqkB7nwPgIOxisNZgtxidyyZOCmTky9VB6m0ZQChA==
X-Received: by 2002:a17:902:cf0b:b0:1fd:664b:224 with SMTP id d9443c01a7336-201d64d0260mr10503225ad.56.1723586473111;
        Tue, 13 Aug 2024 15:01:13 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1a951asm18113695ad.163.2024.08.13.15.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 15:01:12 -0700 (PDT)
Message-ID: <b151f671928bb397917afe8af596df5a934c6b55.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: utility function to get
 program disassembly after jit
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, hffilwlqm@gmail.com
Date: Tue, 13 Aug 2024 15:01:07 -0700
In-Reply-To: <59186574-984c-4ccc-9861-27a9db15d2e6@linux.dev>
References: <20240809010518.1137758-1-eddyz87@gmail.com>
	 <20240809010518.1137758-3-eddyz87@gmail.com>
	 <59186574-984c-4ccc-9861-27a9db15d2e6@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-13 at 09:05 -0700, Yonghong Song wrote:

[...]

> > +	/* GCC can't figure max bound for i and thus reports possible truncat=
ion */
> > +#pragma GCC diagnostic push
> > +#pragma GCC diagnostic ignored "-Wformat-truncation"
> > +	for (i =3D 0; i < labels.cnt; ++i)
> > +		snprintf(labels.names[i], sizeof(labels.names[i]), "L%d", i);
> > +#pragma GCC diagnostic pop
>=20
> "-Wformat-truncation" is only available for llvm >=3D 18. One of my build=
 with llvm15
> has the following warning/error:
>=20
> jit_disasm_helpers.c:113:32: error: unknown warning group '-Wformat-trunc=
ation', ignored [-Werror,-Wunknown-warning-option]
> #pragma GCC diagnostic ignored "-Wformat-truncation"
>=20
> Maybe you want to guard with proper clang version?
> Not sure on gcc side when "-Wformat-truncation" is supported.

Thank you for catching this, I think I'll fix it as below in the v2.
Will wait for additional comments before submitting v2.

---

--- a/tools/testing/selftests/bpf/jit_disasm_helpers.c
+++ b/tools/testing/selftests/bpf/jit_disasm_helpers.c
@@ -108,12 +108,9 @@ static int disasm_one_func(FILE *text_out, uint8_t *im=
age, __u32 len)
                pc +=3D cnt;
        }
        qsort(labels.pcs, labels.cnt, sizeof(*labels.pcs), cmp_u32);
-       /* GCC can't figure max bound for i and thus reports possible trunc=
ation */
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wformat-truncation"
        for (i =3D 0; i < labels.cnt; ++i)
-               snprintf(labels.names[i], sizeof(labels.names[i]), "L%d", i=
);
-#pragma GCC diagnostic pop
+               /* use (i % 100) to avoid format truncation warning */
+               snprintf(labels.names[i], sizeof(labels.names[i]), "L%d", i=
 % 100);
=20
        /* now print with labels */
        labels.print_phase =3D true;


