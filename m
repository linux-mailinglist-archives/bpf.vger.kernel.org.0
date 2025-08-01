Return-Path: <bpf+bounces-64873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEF8B17FA0
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 11:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60F91C27FCD
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 09:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81100230268;
	Fri,  1 Aug 2025 09:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fS5HGUT/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756502264D4;
	Fri,  1 Aug 2025 09:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754041761; cv=none; b=dnmVmIF8g2Md+Rh2jwSTTVIItOpgmDFIPTeUnYsM4bsb7wjxPNZL1hkOrOM8d8GFVW0sp0cOy7jBHkZO0FXARNCs4HLL51oFEu16BmoDUzJz9+chA1cDQiapxBxh1mpFp8z3dXvVbjH7NL7pAQR8HKU0cdHSS5Xo3bIJg44U4rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754041761; c=relaxed/simple;
	bh=GL2qHDOEp28iCvB+mEwHuNLaDoYJs2UQkuxg2gpVPSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sX2RBLiqMG0IDZqtwYA75TkzaEeZK/OBENvxHL3iPhHZDDeOGz44H0MiXLms9vkkTkEdkHYPYxoBSYuB6sRQRA2sFoRJukFhdhcinOMYCLdGyB2DFvMUH/LDi8wIjirmSTHSVhhHwN1XMwCxdBH9TDive67nmK8h97ZomtXUj6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fS5HGUT/; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b7862bd22bso1744956f8f.1;
        Fri, 01 Aug 2025 02:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754041758; x=1754646558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iTifzuLXru4ao0ulRwUD+TgBPGzEb8TM65p6fRnWBJE=;
        b=fS5HGUT/fQMn0WhFyz+FIZA+gKsdVT6sOVm/OhAEBEd9QoMZe3wo8PlB/ADg9HZOFX
         pRoZSvpIj4k2Zm27VazlAiqgX93VGH4y1HdeIU7+EQdfeKz+ddhw32T45FjC5VMs0pXL
         3m9QIDaiscrGHVWK5nHZdF4/PsMFMYyEXePOGw5K8CtBmPHdf4Jd4deiefOt4jYVkFwv
         R/yhgtnlS5ZKY15uFmh7bkxqyI+RgsM85rEo0sDARD99S4nyHmAEHEpM5qjudM/0eg7p
         F5gz1WMikpVxP7j5tDoKV4P5D9CQNRWWuLLV5ArfWdqprgEJEQmiuxHW7YNm0gbFm+PG
         lXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754041758; x=1754646558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTifzuLXru4ao0ulRwUD+TgBPGzEb8TM65p6fRnWBJE=;
        b=A9X8LZEZP7LTezGhxeotcxGPn0m6MALGQVNWFdy2InVQJMm8kFTKEm8iJguFDaZAhl
         J6m1mqhTR4YzN6z/9wKMnB9b5HikTqnfcIUdeO9WkrtnAdZl67ud9eAldZPWp4AF5D52
         k1CIES15jA0Y412QvqJrzbrjtD6B8LiJ8BfLINHxtb3bHvxzL/G3ebnmJZlTd20s0opf
         7Kzyi4gEWbAQPEqqDrl7w6hYmiMCMthYoIIEkCxYOqXAy7w87lEJK+rHR00OYXtFGyqy
         MDUEFSOYrbBHoQNwAFmGMrJh/d1hKUvWiR8kuMYFsnDcCoPvhKg0D+u66vp9/1pnhBS+
         OkWw==
X-Forwarded-Encrypted: i=1; AJvYcCX1+BcrSO1Plm741Q3f1jfb2sN3tJNidm2H0/JOwMaulpBRQd03SspjEVgbytYGdOT2kYMHMh1l3yX7PEwCt7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg99CPBUFW2Po7pbr/UXNg8Ol8OgLPGr9/vqf063TWNSTlO5Ud
	SOK7IhXNfCUIigRiVIwjyUOgByNsb/b2ldMWjrhoa3UWFmXtGjgi25oYWTp+H9nJ
X-Gm-Gg: ASbGnctG+Uc/XdmCiWcSnJsX+QBdjNpEv9NxWJoYlY8KK/PGf4ShKYL5INe70pP+6ok
	icwRvkrBE857Q/ZTiJzv1YI0sudoIga1CnUuFjVi2tB4hcpD3Q8RRDBFoX3dJyS2qe/IW046yEI
	PcKzer6ZAjIL2J9TZE7AkIwB/FckA2figkiEikDctfFZQV3JoWnvKB9q9rVGTQ/hIpfVDEAvS/q
	I3PYV3k2LQW9ZLbbs4ERUyErBwxtGC5pUI29QsjrPY51y+5EAkh3ED1SGSdvarDG5OMHRTb/Anq
	0pwubTIgnZJpP29O6zgEwa/6hBLV1pX3UL2m9YBRPa0nb0fiWK720xRfeNzt1Hb4ulPCYf4DWIm
	VU1sxNAFCBqX6qMR9SxLmQ2Di0zpLpiho0Ut5vMhYBxkiU9pywX7J4S0NRgJmEcYcWVn1ThQMdR
	qfT1dCbapfzUUZMTXKVII=
X-Google-Smtp-Source: AGHT+IH1sAYP2n0WoRZXy0OwgQmLK+UG4GA9aVvs55bz0uUENQAbS5dLlqTAGpAvBVTGthIHXFcWyA==
X-Received: by 2002:a05:6000:220d:b0:3b7:8ba2:9818 with SMTP id ffacd0b85a97d-3b79d4e3419mr5192699f8f.22.1754041757719;
        Fri, 01 Aug 2025 02:49:17 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e000cb332f63428a027.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:cb3:32f6:3428:a027])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453aeasm5481786f8f.40.2025.08.01.02.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 02:49:17 -0700 (PDT)
Date: Fri, 1 Aug 2025 11:49:15 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	netfilter-devel@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Petar Penkov <ppenkov@google.com>, Florian Westphal <fw@strlen.de>
Subject: [PATCH bpf 3/4] bpf: Improve ctx access verifier error message
Message-ID: <cc94316c30dd76fae4a75a664b61a2dbfe68e205.1754039605.git.paul.chaignon@gmail.com>
References: <cc1b036be484c99be45eddf48bd78cc6f72839b1.1754039605.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc1b036be484c99be45eddf48bd78cc6f72839b1.1754039605.git.paul.chaignon@gmail.com>

We've already had two "error during ctx access conversion" warnings
triggered by syzkaller. Let's improve the error message by dumping the
cnt variable so that we can more easily differentiate between the
different error cases.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 399f03e62508..0806295945e4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21445,7 +21445,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 					 &target_size);
 		if (cnt == 0 || cnt >= INSN_BUF_SIZE ||
 		    (ctx_field_size && !target_size)) {
-			verifier_bug(env, "error during ctx access conversion");
+			verifier_bug(env, "error during ctx access conversion (%d)", cnt);
 			return -EFAULT;
 		}
 
-- 
2.43.0


