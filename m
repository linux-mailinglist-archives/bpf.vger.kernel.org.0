Return-Path: <bpf+bounces-62848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BD4AFF520
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 01:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328A1561E85
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 23:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A2E24169E;
	Wed,  9 Jul 2025 23:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="XkYdVV2n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BFB16DEB1
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 23:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752102221; cv=none; b=nTkQ+FZ8/OqUmbPuUVNrnfHs8P/u43RTbt/irBdKuP8sWedkx0JIJ+fNsKl1DfxDqRFMaWRvz1Jm5yAcgi1MsnlhPX3ElUX+zhVrAvkwAxSLChIaK4SiO8XrJepQsjw4u6d5NmFrCFteVNij3l/dp9x3MRjl520wvrEALjsnMTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752102221; c=relaxed/simple;
	bh=P2TM48kjMxPSr7YwvwYsCNfh+euwlg0K2KRkqviR9cM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rwp6zV1VaMNOokSXGsLLM0QJwlWrpJrqG3KQmoKQ5l00qP5JIEMR3U14pA5FUbCuPnt89DF4ga9lTi7XL1fJcPeZOZwrWduCvLyoE3wKyZZlzjTT8X+u3yyG9ZKXjhwOcmFkm0VVpm3Uow9oF/JAx+yzrPmSeaebmrvSB1/SUGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=XkYdVV2n; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-234eaea2e4eso728845ad.0
        for <bpf@vger.kernel.org>; Wed, 09 Jul 2025 16:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752102219; x=1752707019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imTCW/X3yNchRElFuavT2VHyvLPxQFd7uC5iHjhIYP0=;
        b=XkYdVV2ndl0iF1gZhqYWBO980A7Ixp6GDuhoto0pHyZDCn3GvKztZFHtx/7uUXCOW8
         /1WE0CU7TC+V8Dt0NQgNNT4LtJj7YJXXYWbVfbBhYqi7D0I6jkhyEiBAvlL1mi2/geVg
         oxXcF9mYI88c44xM8CU08nAMLXz2cwkXT7NdI6gOhaMoyK72a3EO1IgbTB0OvlLtsH+u
         O3hpJqCDSvfdE2YlcKKphCP3KfMDQdW85kKQved1wazBzita3O0T+B/DfUvgdxOdrh1S
         xC1ZbsZFYSPnsjoQl50p68lkY8ZcNZwsLf6XdLU63goqHbbPV3M3s7XKB3Cf+qlG+4Jx
         f/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752102219; x=1752707019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imTCW/X3yNchRElFuavT2VHyvLPxQFd7uC5iHjhIYP0=;
        b=LBKXuoMO5b+qBYrRNL1CNqn+CrcHJonSHuwLB6IOk52yxhJitdbmUfUxhdUX4DsAdG
         3cyYMn6mSBOVhWWsODnxlSD5k9c9w63/ABL2aqhcalGSAMiaTZm5FI1kcOkczEbJwajW
         75tmlPLlPrEt8cbZFrXPT8j3fxgyIA+gq4c8CRoT5qf41ykQLCFWN4ptzKIU+88Webmw
         wmwRbY+kkUMHUiPAIFvGij568K0M3lHB+dGXhtG03/R+PL44/w/wK0b03nuzD/1xKDXg
         njbK1g3bz7kZ2Vi3bI9Re98V37iSdK5O6f2gbkLk+qHIzO0sXrkhx0eXEaksAn9M3oP1
         vO8w==
X-Forwarded-Encrypted: i=1; AJvYcCXu35D0Me95JPXaG7mRQ+sHwZRCtXW6bMctIV0C4e8lUOEQDyDH9RrMfd/eBnuwq9xn+Ao=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj6aCC1f6zAJvd0xVi33hm0lCIFtyi5Hx3s65CO2aXfnrfbQE8
	EhWS55sqcuAATbY/v+1CRZWHsEBUr0g7kPNB1dTHcHSLTIxFCEJHWKDKF3sLNkFbvdw=
X-Gm-Gg: ASbGnctP/j5d+PvXxpYcvJ1QmQhhpk71w57mKIy0urkrp9swRCinQhW/rCZh+YqmFv6
	ttAaOrOQV1VbFZLhB+2dIRI3G06tHWPE3Do13c0cfZ4NdXvkuEz0frH9EdyEdX/I41Wg5l17VdY
	eWfGLWokou3jro2A4skBy/Mql3oFh8PU/85pC8bHirsAf7PYdez6c36SO0p0bcD7DzQjy36DEmH
	3bQEtef1OcFsawnen3ma8IgHxBzdE70LI/+g5HaFrAMGF0yWQu74gIpkO6nWwuqfJP8qayFjcTo
	3c/fWl78zeJgBS5y4C6ULfzJ+cNn4lyHMAb/rrJ+ZGjbxEEDvCA=
X-Google-Smtp-Source: AGHT+IG3VDOjJQ7/ydj4NTL7TeB/TBwJ9CmnRlJ1GQSUfgSW+FxhDDXSpzpQhCpkvcuLT8z4MjdxIA==
X-Received: by 2002:a17:902:c408:b0:236:6f37:8da6 with SMTP id d9443c01a7336-23ddb1a6c60mr26239645ad.5.1752102219017;
        Wed, 09 Jul 2025 16:03:39 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d121:1d56:91c1:bbff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ad212sm2679015ad.80.2025.07.09.16.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 16:03:38 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Stanislav Fomichev <stfomichev@gmail.com>
Subject: [PATCH v5 bpf-next 01/12] bpf: tcp: Make mem flags configurable through bpf_iter_tcp_realloc_batch
Date: Wed,  9 Jul 2025 16:03:21 -0700
Message-ID: <20250709230333.926222-2-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709230333.926222-1-jordan@jrife.io>
References: <20250709230333.926222-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for the next patch which needs to be able to choose either
GFP_USER or GFP_NOWAIT for calls to bpf_iter_tcp_realloc_batch.

Signed-off-by: Jordan Rife <jordan@jrife.io>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/tcp_ipv4.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 6a14f9e6fef6..2e40af6aff37 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3048,12 +3048,12 @@ static void bpf_iter_tcp_put_batch(struct bpf_tcp_iter_state *iter)
 }
 
 static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
-				      unsigned int new_batch_sz)
+				      unsigned int new_batch_sz, gfp_t flags)
 {
 	struct sock **new_batch;
 
 	new_batch = kvmalloc(sizeof(*new_batch) * new_batch_sz,
-			     GFP_USER | __GFP_NOWARN);
+			     flags | __GFP_NOWARN);
 	if (!new_batch)
 		return -ENOMEM;
 
@@ -3165,7 +3165,8 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 		return sk;
 	}
 
-	if (!resized && !bpf_iter_tcp_realloc_batch(iter, expected * 3 / 2)) {
+	if (!resized && !bpf_iter_tcp_realloc_batch(iter, expected * 3 / 2,
+						    GFP_USER)) {
 		resized = true;
 		goto again;
 	}
@@ -3596,7 +3597,7 @@ static int bpf_iter_init_tcp(void *priv_data, struct bpf_iter_aux_info *aux)
 	if (err)
 		return err;
 
-	err = bpf_iter_tcp_realloc_batch(iter, INIT_BATCH_SZ);
+	err = bpf_iter_tcp_realloc_batch(iter, INIT_BATCH_SZ, GFP_USER);
 	if (err) {
 		bpf_iter_fini_seq_net(priv_data);
 		return err;
-- 
2.43.0


