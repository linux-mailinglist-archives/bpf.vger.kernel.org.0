Return-Path: <bpf+bounces-63806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EE5B0B069
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 16:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094FFAA4570
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 14:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5093C28750B;
	Sat, 19 Jul 2025 14:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mb44dHZ9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4863F1DC9A3
	for <bpf@vger.kernel.org>; Sat, 19 Jul 2025 14:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752934966; cv=none; b=AgCjQhY/IThPGxTSXp9/rxsEn8THZd2N2heaXz9WIblFMojvUBbUIodoA2enrP1dHz4xChFLgiPJs5keGANtPeAeIjhxj3hsfoC9EvMNnv6eaqqWpEpboI/oUO8GDlkAm1ZJxrmkaukflE6Cwq9cF200lvnu8V6lFMxMqpDU5wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752934966; c=relaxed/simple;
	bh=Z0MDe3LHAfrawqW0N3X+qA+QAiayFMBilX7JcNxF64U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RgxS9aSYKuUX/EJ6qaXWMmjuUnXG5iHftoJ/ulCLKsEf/ngceY5HqDcOh2OMhVk4Nv9x7tVMd14W8QT2oWzoEXVRktdbean953v31Kk3fbxYMLdCtS2mbSwvj4GbgZmgX6cY44NEmo7NT3VKTAsX02D52+orqF8IBy2A+C9+3no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mb44dHZ9; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a503d9ef59so2107815f8f.3
        for <bpf@vger.kernel.org>; Sat, 19 Jul 2025 07:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752934963; x=1753539763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Iyar+rw2bBx03KbdYGZt5nl6MmAcBgI/wFI8/eBGUv0=;
        b=mb44dHZ9XoBYNRcP3ufciwrMS83EODUVD74aDd8IfzXxvWZT45lSpRfOk2VP42sn1I
         mqGz/8Lo68n8uKW84R1GaBNQY1dfy+cwL68oO1r+2FOn3SVGl24YeRFgpSsdlzB0AupJ
         6GjfRJP+eFRhLV04Rarh1JotdAlCU18jta3asbyJCrCfF1mifOQhbKhbpz4cWFz3FPk+
         mcYOciTzaF92DWz78y8LSu2Kd/mYR6lu4f18Br6UP+oekWCFBgS5AVnRW3rRcnWcG1C6
         pLd+tmEIBMnQNOXplgI6toeKS2MN/bpys4mdwdLM9X5S97WVwUY9Ahcm9WeFcuMXlRa2
         mCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752934963; x=1753539763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iyar+rw2bBx03KbdYGZt5nl6MmAcBgI/wFI8/eBGUv0=;
        b=BTaaH0srqqqmlvmJA4++KhK5QQt+dX6H0yyYcpeTVwCtknh9P776Ba1chPMnaeGVP3
         T2kzuALzqakz4NshKUOeKP7g7rnm7WPIliUPcroCKzpolGjyMNt9l/FCFVJlzqx5CITH
         sNjjmaidg06RQAGEOKk+H3+UBy/nFBqNkhWte6eNJrgF77cMk9qfwaO0g1C07YFM5WzK
         /A2puo+PCmWZolMphaQl9i2WT6PRXsk4JJuRiYLb0IUUVOkTLbLRqGnzzc5NpSZ/b9i3
         xNy89nYvUsXHhSyqMtSG4i8q42pK/ygX8cKa7HhDqqawXZtR/17zsVSGJA97KUg25c6Z
         0+8Q==
X-Gm-Message-State: AOJu0YzyvxTVvrQ+jSt0Y+6kvyi2huKGEgjHKAEscanwAMTotoIcbKBf
	JM1eOWCHFisV4niLqRnjCXV2jFRxVQCdDM7FWGvT7lmwmgcao28TOSUezDeYTvQJ
X-Gm-Gg: ASbGnctpXZJMtpS7xZCXbGAu3obGwaq0H2RRDP6tMj5BshNcBbGAMiEYYlpDROkQ5Mn
	OKJlr8Zj18FI9arOQuKP60f7ShWv4K58VTbp28g9ukw6jFhTV9ObD/81MvqSd9P5AWznyTtYFGN
	MeHohoinIQ43/9CEYYShZV4RZnDrsIa5DfQ+aWm+HYT9fc5yOP4ffcskoZRP+kEI6pLqFYiMbE1
	ezTqsN4H1Hj4JPWXOVl9wzNwP9Ik0NguW0W3F9djk3aEHegFAink7Gpaj0jjWLkRk/JKo0RGmuf
	RlbZTpKr7jc6BnTfqm0SEolZJvMCo1ypFGrKaHvk8++kv5U6NwNnqCESV5K2cXsKbrJNHOngTko
	N/EpMHv7smTPvYStc3DDavD1ob6091k7a2IlZcf2T8MCpa5CiJ8UcMH9xVqxuO5Rgx3W8WZpf2s
	BTnU3NSUY9WQ==
X-Google-Smtp-Source: AGHT+IExrzECqg/5Ax5ZZ9d1t62C1d2x13i52czTraVPuWza0n26Ni82xHV3ZuIH0L6GRNLGq3zqRg==
X-Received: by 2002:a5d:588f:0:b0:3a4:d64a:3df6 with SMTP id ffacd0b85a97d-3b60e4c914amr11964908f8f.3.1752934963401;
        Sat, 19 Jul 2025 07:22:43 -0700 (PDT)
Received: from Tunnel (2a01cb089436c000eab97b50918e1e74.ipv6.abo.wanadoo.fr. [2a01:cb08:9436:c000:eab9:7b50:918e:1e74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca5c298sm4885375f8f.76.2025.07.19.07.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 07:22:42 -0700 (PDT)
Date: Sat, 19 Jul 2025 16:22:41 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next 2/4] selftests/bpf: Update reg_bound range
 refinement logic
Message-ID: <4636f494d90da3627e955d62e54a7927c6b2b92e.1752934170.git.paul.chaignon@gmail.com>
References: <cover.1752934170.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752934170.git.paul.chaignon@gmail.com>

This patch updates the range refinement logic in the reg_bound test to
match the new logic from the previous commit. Without this change, tests
would fail because we end with more precise ranges than the tests
expect.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/reg_bounds.c  | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
index 39d42271cc46..e261b0e872db 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -465,6 +465,20 @@ static struct range range_refine(enum num_t x_t, struct range x, enum num_t y_t,
 		return range_improve(x_t, x, x_swap);
 	}
 
+	if (!t_is_32(x_t) && !t_is_32(y_t) && x_t != y_t) {
+		if (x_t == S64 && x.a > x.b) {
+			if (x.b < y.a && x.a <= y.b)
+				return range(x_t, x.a, y.b);
+			if (x.a > y.b && x.b >= y.a)
+				return range(x_t, y.a, x.b);
+		} else if (x_t == U64 && y.a > y.b) {
+			if (y.b < x.a && y.a <= x.b)
+				return range(x_t, y.a, x.b);
+			if (y.a > x.b && y.b >= x.a)
+				return range(x_t, x.a, y.b);
+		}
+	}
+
 	/* otherwise, plain range cast and intersection works */
 	return range_improve(x_t, x, y_cast);
 }
-- 
2.43.0


