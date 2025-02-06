Return-Path: <bpf+bounces-50609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 596CDA29FFD
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 06:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE01418881CA
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 05:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1AA22258C;
	Thu,  6 Feb 2025 05:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBvSO+Xd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D76320B1E8;
	Thu,  6 Feb 2025 05:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738819104; cv=none; b=LD4Uwvi6ZG/uNxQJp86E+h1V2Qa7vixQBTUStRqJo2tcvH77H5bcpTnUUgSrlTXu7uHiFBO+Wv2kSwFcDSnm2FvEXHVdCeMjx52ZEU7AAPkXyMoO6mGEHVRWMDlDS9YYuep9Wi8M62iXsu1aghvBgkAW9k/N1oXjBv0OoUAxLnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738819104; c=relaxed/simple;
	bh=a4ECPYDwfk63dHhyrW+wHnNNRmnBF5bgFkDjFdSmp2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=X+PbarAxQPv0dvtmJZPGORqrCxJc4+s2X5nj58HioCs9eoFR2LBggTVqc03F3XxfTapZUE0e7ZO8XkWihziXElfyt37biP89NgqcZZ940fupvqGwoMl6dRzw1LVFG65rOPxh8Wsi4+CwEtGN2Jdwew4VSQ1FKeRLnfm6hXqYWag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBvSO+Xd; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21670dce0a7so12598855ad.1;
        Wed, 05 Feb 2025 21:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738819102; x=1739423902; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K/Fl6jr3f6WWgFY+GTM3oxPBToNoP/PIu+n5lwCsix8=;
        b=mBvSO+XdaWJWfCJvRbAiNTVhKY5a2e/TIQjNxEphwaoASAJp5vgzH/cJFhociut3fW
         uEcoi/1fWADRewXX6YLfEy0+hw6Su8cH8fcSEZQL+TdxdUVwF4j2GW+cHljpi40BhWEy
         8Q1Mo/VMe53EwJMTfJuGqRHj96OnlAC0AOzgz2cYStw/z4QlkwlGXFthdRr8CcjdmAqh
         9GZjD9ZtbC09HyykLb/eE8LiN6tIDqoYr9zP4cNaUdVIgZYKA+Xigw98OmpAJqZalqLT
         J7RvMAjqB+uC6i1gcRB5qMTWp9jd/z2OC5jWgPq5Wpx3q4UACfzhwWCLEknjA4CcwhS2
         Rrrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738819102; x=1739423902;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K/Fl6jr3f6WWgFY+GTM3oxPBToNoP/PIu+n5lwCsix8=;
        b=PaRFMSfHVg8pLJ4lHDzzBdyLgHVOUbWp9UzG4712gi5akH1Piqp/bMEBrT7n3uc7cC
         AOrCW5//GNH/bhbtzYuKDa1ht0l+KN0pkkqSFf+NaPWtDaf21ylHeGi3zZ3s+XrGTKzP
         regmtvydQkQRwwAmhLwg7ZrWxwyRtX49ymWyEOnW8L44P0jwDx9IwTkPXt+KopGRur/0
         FmzVKpJmDeN7w2uUg9fD3iCoJODUc0GqK9rFZb/W9kB1qbYwK5yF04yHbGBuDdTgDRql
         /EsA2sJMmMMdzBsYWTHOYeTSOSxcUO5vndCTx4L7bQRgfk1V9zjbTuMOEO5BX17gs8UX
         b/JA==
X-Forwarded-Encrypted: i=1; AJvYcCVPiene1C4GehGM1naP9XKaZyzmzPfl7PErDZZRHOFROKJgXZg9caImR6JyBlj1hQVxG2/k5W03tKQPmL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWvoQIHaLRB7IqcGrpbJkuIEryYyksIHfkgOtLHnM0W6IyWqIc
	DCMPA7qTrYeTnsdxS62ye5BI8bqQLuvDkR15PvpPFZ2m8bDArsci
X-Gm-Gg: ASbGncs2ut4RxTEw1+eE7QAZ1OKrmq/k7RBDLovI2KViBOTyHgFNOdsKxYYxLy1sK46
	Ot6xJBFAsLPDJbQgssigGM+YRcF+82HaLCDQHjyFRQAXhMTKbkTbRxKJk3dbb+kuBmNbJHoEjeT
	+TwdQurYjJD6HYBUK3Dt9KHkPxCBrmXhJ7DpRHoxgeDIAZZgWbtnFJNUbbT0oh56uAEC9L1zvqM
	RX8XI1FZXhsbBR4JFxPlq23NvYGiT8BuP9kCYkQHG8kRKHJcpJlhW6kKPrfomZi296TvoKtVuli
	OtOIp9IPJgdrPhpZ
X-Google-Smtp-Source: AGHT+IEBYCYZOCuffiu5N/+ExDF5yVg0V0Em0xXZikU5xRdhVmpNizklaZghEC3SsWGVtImGiuFd4w==
X-Received: by 2002:a17:902:f64f:b0:21d:3bd7:afdd with SMTP id d9443c01a7336-21f17d114a9mr106222235ad.0.1738819102390;
        Wed, 05 Feb 2025 21:18:22 -0800 (PST)
Received: from localhost ([111.229.209.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09b5ad4esm362074a91.41.2025.02.05.21.18.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Feb 2025 21:18:21 -0800 (PST)
From: Tao Chen <chen.dylane@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	jolsa@kernel.org,
	qmo@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chen.dylane@gmail.com
Subject: [PATCH bpf-next v4 2/4] libbpf: Init fd_array when prog probe load
Date: Thu,  6 Feb 2025 13:15:55 +0800
Message-Id: <20250206051557.27913-3-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250206051557.27913-1-chen.dylane@gmail.com>
References: <20250206051557.27913-1-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

fd_array used to store module btf fd, which will
be used for kfunc probe in module btf.

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 tools/lib/bpf/libbpf_probes.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index aeb4fd97d801..e142130cb83c 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -102,12 +102,15 @@ __u32 get_kernel_version(void)
 
 static int probe_prog_load(enum bpf_prog_type prog_type,
 			   const struct bpf_insn *insns, size_t insns_cnt,
+			   int *fd_array, size_t fd_array_cnt,
 			   char *log_buf, size_t log_buf_sz)
 {
 	LIBBPF_OPTS(bpf_prog_load_opts, opts,
 		.log_buf = log_buf,
 		.log_size = log_buf_sz,
 		.log_level = log_buf ? 1 : 0,
+		.fd_array = fd_array,
+		.fd_array_cnt = fd_array_cnt,
 	);
 	int fd, err, exp_err = 0;
 	const char *exp_msg = NULL;
@@ -214,7 +217,7 @@ int libbpf_probe_bpf_prog_type(enum bpf_prog_type prog_type, const void *opts)
 	if (opts)
 		return libbpf_err(-EINVAL);
 
-	ret = probe_prog_load(prog_type, insns, insn_cnt, NULL, 0);
+	ret = probe_prog_load(prog_type, insns, insn_cnt, NULL, 0, NULL, 0);
 	return libbpf_err(ret);
 }
 
@@ -448,7 +451,7 @@ int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helpe
 		return -EOPNOTSUPP;
 
 	buf[0] = '\0';
-	ret = probe_prog_load(prog_type, insns, insn_cnt, buf, sizeof(buf));
+	ret = probe_prog_load(prog_type, insns, insn_cnt, NULL, 0, buf, sizeof(buf));
 	if (ret < 0)
 		return libbpf_err(ret);
 
-- 
2.43.0


