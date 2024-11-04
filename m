Return-Path: <bpf+bounces-43945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8E19BBE86
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 21:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54F621F21490
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 20:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14C11D47C6;
	Mon,  4 Nov 2024 20:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="Gr1qEJmj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AB61CCEFA
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 20:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730750704; cv=none; b=j8ELDjSTyI2gOjnvYnTrowKMP+XA1cMi2ih3XF+YXI6BrBAQHGGSJpWpW0Yj7ZK1b0fGG9ZsW6YwXWltTW2lDn/ZBt4RmgAJlAfHSIzOhUJ/sxiNg2LXitTxYPiIIIJ1Jr0tw3c9wSa1uAGVCTp2gM5M/3KMPx6NaQtXTLLFZrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730750704; c=relaxed/simple;
	bh=Br+X2zAaJ+8QvF2nbaUO502GcB/I0wKPaxyQNItvLPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JsWSpeQiaRAeJHt0epbwU+iIQinAXXocOyODdc0H3MizWCkyYd2DVRQuCmS2yGO9PBpLLFmQWGjMjPUBw0Ai38jHcGBCqdvnjzLGELTmC844M5T0N+mrKvDcKD09dcy9e2bAeAxicV/K0gVmdenB+XGXqd9aC5HVe2r9Z9iJLRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=Gr1qEJmj; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb4fa17044so47403621fa.3
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 12:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1730750700; x=1731355500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k45SEOSbY3HGYHBp9pW2SHm40S/1VTk9+rL+96Q3x+M=;
        b=Gr1qEJmjTX3lp+y+XTwK2iEUb0kRIqNDcs1w+8Ept+wZBc8jDP5pWOSBfsJbPieAUW
         CjOpyjdGZPRL2+29vV4zPsX3cQm9oxH+2+zDfgy3btZDbqK890+EnAdzu8kQR4H1ie8P
         JWvkdMlHDdwxNAQ/asvGyZBpH6FsYg+t/9OUW7WypTCAdV3KcI+/z7DsuP331LRa9ImY
         sK/dQ86y3r/8JJA6VCajCoiZsWGN/UXDHsyPxozrKchqdlZKQWJ6I2pOoDfEhbfnu29T
         JFI0rqyQI+URPbWbKtMBwNli5NDubaDXA8spTPnLLJg4resGZe98eGUQJev1C7bvJvh4
         0cYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730750700; x=1731355500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k45SEOSbY3HGYHBp9pW2SHm40S/1VTk9+rL+96Q3x+M=;
        b=P+siUYbfYwty6IPpbAw+UkFXMYF73CGcQDGw9SMm2qNFNzRVNyt3J0ZB5Obdw3I2l3
         dxdwWpNnHAdm5liJHmNL7y8wrTZCN95a00vmgOH9pJG5d5+FFtiI9CpjpuQ1dG4LxI7I
         OW3InIs2JQZI3bMLCQRYR2WnnkYcieARZh3fGQhQdiNYeh8IeDEP68xr4XzPgjBmj/C4
         5nFDUBeRKoGKgO0XjhAGbOo8SVm9pQzC0gObFpi9/ftXsvV0hayzOWpauGX2hLASCrlu
         Yb/xzrGe3lWxYMN/VYXAhCDy/QNAbqTbAMMuRADa098r21kAjGS993AWgqlua/AEpmJD
         zVFw==
X-Gm-Message-State: AOJu0YwIVCrKIdk9P0MUfxhY8qKLPJE5nEnB2T6NUldTojjMq+1PA+xO
	trkmjI5ujjZwjrFtaxANfjbI/yJ5q8fsYftSOxSa391y/FTU50faNSM1TMtEPAwel2P2aMkZvHE
	9
X-Google-Smtp-Source: AGHT+IGyLvBd/emVmQ1/4uSAABtiM/1KkOyVmWM+5dJKMfZS9mCUsiq4fVEKMdvyck/jQeBMKxxswg==
X-Received: by 2002:a2e:bd08:0:b0:2fa:cf5b:1e8e with SMTP id 38308e7fff4ca-2fedb758b32mr60972811fa.2.1730750699644;
        Mon, 04 Nov 2024 12:04:59 -0800 (PST)
Received: from bell.fritz.box (p200300f6af056e00c6570c15b61f00e3.dip0.t-ipconnect.de. [2003:f6:af05:6e00:c657:c15:b61f:e3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cee6a9a5c6sm249160a12.17.2024.11.04.12.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 12:04:58 -0800 (PST)
From: Mathias Krause <minipli@grsecurity.net>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mathias Krause <minipli@grsecurity.net>
Subject: [PATCH bpf-next 2/3] bpf: Allow calling bpf_jit_blinding_enabled() with a NULL program
Date: Mon,  4 Nov 2024 21:04:51 +0100
Message-Id: <20241104200452.2651529-3-minipli@grsecurity.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241104200452.2651529-1-minipli@grsecurity.net>
References: <20241104200452.2651529-1-minipli@grsecurity.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To allow probing if constant blinding will be applied, support calling
bpf_jit_blinding_enabled() with a NULL program.

This allows to tailor the creation of a BPF program accordingly.

Signed-off-by: Mathias Krause <minipli@grsecurity.net>
---
 include/linux/filter.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 7d7578a8eac1..a1b4a9739f81 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1297,11 +1297,12 @@ static inline bool bpf_jit_blinding_enabled(struct bpf_prog *prog)
 	 */
 	if (!bpf_jit_is_ebpf())
 		return false;
-	if (!prog->jit_requested)
+	if (prog && !prog->jit_requested)
 		return false;
 	if (!bpf_jit_harden)
 		return false;
-	if (bpf_jit_harden == 1 && bpf_token_capable(prog->aux->token, CAP_BPF))
+	if (bpf_jit_harden == 1 &&
+	    bpf_token_capable(prog ? prog->aux->token : NULL, CAP_BPF))
 		return false;
 
 	return true;
-- 
2.30.2


