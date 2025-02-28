Return-Path: <bpf+bounces-52895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C388A4A280
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 20:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19DCB1898BD8
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 19:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB921F8730;
	Fri, 28 Feb 2025 19:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4KGuHVi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2391F8729
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 19:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740769992; cv=none; b=biy8tq0uQ6pfn8hb/6dLjyXdfCnn4xEdNf7tAIYHgPzfJth6NGKSbR+isU4KLLS4lDA51M9Z4SjmQ6mecQiAAUItwnVQTlMcI6W2sk7QSYfk5ylYR0HS9EUnOD2QVgBwPl3yTMDMsxynLb+jlphrFxQAjqNzIhpiCOcbHyoonSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740769992; c=relaxed/simple;
	bh=742eAE/Tg0SXcqB/hKKcFYt3T/1H8mmttwBZFcGkvrY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YrMaUtia54cQ4MpkkH4lfCw95wvVu7TtIg6RYxTX1WivqGVn2/8FU4nNsFH97qiNVFcxJqR/cOTiAi4dEimvrOmJGEo4FLuvxSl2McnI8grnIiMqfQjyfCGrQWkBVD+tr9ENhsI/+hcBV8vZLeIA6SKOoBuR5Sd8hJgrrexqI+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4KGuHVi; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-223785beedfso15397545ad.1
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 11:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740769990; x=1741374790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fmwD1hj3/p4pszA1fX3sHweQtuY9Ov5/q1WAaGw0qco=;
        b=F4KGuHVi0BeCUq2tKIMtQVbVRVndpZgSnA9gjuz8pjXxH/IzrZwh3LXi5cwbOIBNuI
         c8YJpV/cshAAwku/XZToEosDb+v7JNmQXmyzUMfz16olyssfSTZ0oMY+6tq25xECfv0R
         ijRQF/cle00gru8/8N+7qZaPwOdU/nEvd1R5rbv9EXWt6gQRMmdBssKMfyK1pTT63HRg
         /D1lKLSmfSmj8LO7NFt0i4SQcj3EYwl52HmU7ygGVinZKtX5IVEm0r1tc+bk33hR+mjV
         nMqmbHnACVT8Fk+kSGRyQoK6HEy+1gNiAtwW9CD2zQA9NUOQBsDQjRl7uGZpJYEFrLAK
         +gkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740769990; x=1741374790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fmwD1hj3/p4pszA1fX3sHweQtuY9Ov5/q1WAaGw0qco=;
        b=kq5FqzlLscomuTNS0wayFfmF0pnlko0qqpGIybi4QHSKeqQKB0frqcCkZ+OFxTA1Ez
         V+cXGq4hFefwLaiKYtZ7aTt1g1DxSY1WQkZrOU67U9Y2J60uDl59ZxWkbrQ27ZReqQ3H
         4f1NIdu7/oGrYNSHPrJAidxoSD8KnhlAVCMG4CkaUrXqCFMQAkUdPexthoosd2/Ofzjs
         Qgs6pE6UW5MLP8AHiKoTtR6qZqIakKQ9nIOlvdyZVLu4E9IRgCbq2hYkJxzKFIxb0bY4
         ARDKPDOZ3yNuCiEm2bWXA/IZbTPzclUH/8XACETerHXF5ZBJSKAn3bfRsOF3fdS6PZaI
         cPaw==
X-Gm-Message-State: AOJu0Yxer+B1cJT3o0r+5wrppl1ShGWBUbomuiofbUMU0lcUMML2RWSj
	56I39IIUbSfuHwdBCyTGn1t8jXR4gqRKTfdNFdxerYuS3VT+UGI95CULbg==
X-Gm-Gg: ASbGncu+6PRcAqv/3BgIG6mjU7Suat5n0oyz1whSQy9LIy8iItXbBfE8u8HEbNZfBYz
	hrLINXFf9BpcUxDe0AgUihnuDMtFxEtGrW1s3kci/4V9WOuNvra/8RPaMJVn/vWthauCkMgw/1E
	o3/YSSMWPcyhzAZLZyV2Q+inVqvFfU0yZAzoRSWjgQq5G7J7nwFHUHC/lMTRkiayTM/nOfJH5GU
	Cb7zgENH5bhmiomOqzhUAGMRAdUeirRuMU8kBdM++gVa48soib4H5VynMbLKGSSeSCykA86NqKz
	0h8cuB60LbWyOh3eSIuT5iF7NYeo4Ukm4B++TJNd
X-Google-Smtp-Source: AGHT+IFK0ELfNUehmt/rpsKch9H6fntTz3GZoIvGDnaPV2HFpUfg2KwGCe13Uip6iuleC+0b9746bw==
X-Received: by 2002:a05:6a00:3d0c:b0:732:1d12:ded4 with SMTP id d2e1a72fcca58-734ac351c0bmr7694799b3a.7.1740769990037;
        Fri, 28 Feb 2025 11:13:10 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe48865sm4228799b3a.50.2025.02.28.11.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 11:13:09 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 0/3] veristat: @files-list.txt notation for object files list
Date: Fri, 28 Feb 2025 11:12:17 -0800
Message-ID: <20250228191220.1488438-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few small veristat improvements:
- It is possible to hit command line parameters number limit,
  e.g. when running veristat for all object files generated for
  test_progs. This patch-set adds an option to read objects files list
  from a file.
- Correct usage of strerror() function.
- Avoid printing log lines to CSV output.

Eduard Zingerman (3):
  veristat: @files-list.txt notation for object files list
  veristat: strerror expects positive number (errno)
  veristat: report program type guess results to sdterr

 tools/testing/selftests/bpf/veristat.c | 70 +++++++++++++++++++++-----
 1 file changed, 57 insertions(+), 13 deletions(-)

-- 
2.48.1


