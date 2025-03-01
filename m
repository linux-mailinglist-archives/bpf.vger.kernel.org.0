Return-Path: <bpf+bounces-52943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22807A4A6D1
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 01:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29EA07A3DF3
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 00:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3B7A935;
	Sat,  1 Mar 2025 00:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrdZwLnF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DDD23F399
	for <bpf@vger.kernel.org>; Sat,  1 Mar 2025 00:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740787337; cv=none; b=K/Z7jA8A7BQE5KNcXhqxmjWQP3qxTmpDGZmefQhlfbXy9YFpb4G78EQ/aw7wR3QLLxG1QpYgIDovPWkXUACfkXvxrDLgDMQc7o/u/zpR7zsnfLYM+KctV1pmbn/GEhjrjIIR6bTPZ0aNzHzXAgW9cvcgzJP7+iQrCUEf7qhhcm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740787337; c=relaxed/simple;
	bh=wCITQNvqfhoeKlNMmQPgk8ObVKLQLcrqoMuH1n92puY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oWVQItajH1+NPtVwFvB0XWmiMqTVYE0dljb9bovFJHUCfqkKezGMTEtb+TeRXxMzBbFQ+YT04yce3ZtsC5XVMoBpeN0ab5Zv4SV1WL7yLVEmZOUGvPiYUeT21EyZ05kmk3xumBUlrTp0zcPggcpu8B6HDlv8FtQzgDp3YYDwOmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TrdZwLnF; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2230c74c8b6so6553865ad.0
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 16:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740787335; x=1741392135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4BrRbkfHH7UOUxrf/eNy7zq1XLAGTtKKtshvdCxU8U=;
        b=TrdZwLnFxz5dt467GdKOuspilbNeqvQIIK3SMn7Q99+zSex9CTKvBp310cbie27Ttc
         CMEcsfpyqyTdPJJHQah1SPQNZViVVFlgGf+gjiK2yJs9Y4ZNIrZsUfX5mK3WnDJmHjMS
         GjHn2XJASvYWjX+KQHI2P0hHxBDz4VYc8mPfcLzEtJzfWBQekvlYGpBgPG3DvGB09MKt
         Q7fsrozwc6JEZSaJ/dyKByZVMjGKNvy4A+s3da+DnK9DzaR2ZMKjeR+EXfB+Qfgb2yUH
         yAgiYFfS+2haGNFVLe1IDmdRPbYa/3aOFFkho3IuWvKpV8kKKGwL2Z9WmPMqoyP2+9fk
         ucPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740787335; x=1741392135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4BrRbkfHH7UOUxrf/eNy7zq1XLAGTtKKtshvdCxU8U=;
        b=WZniLNXMRGVoGMQ96HWVSRG+shVKAJ4fIYl0CMK1SaOlSd7vXerw3KcbPM57mPjY7k
         Pv+SdmvdsK4+EJTZ0CY3S0UW3wPjzMhNS89BP9uKHwGflQk4BqVBo63n/NDcoRR0BwCc
         QS1ZCOoxbtLJktBVdmtv3s5+yerFlAfN2+a8RTZW0uHzC7Gqrhco2dB+hlUP6E14lWNr
         76VQs/z1nyC/Z+xOkTH+w7AYOfdsUThmmmlKaJG3wZBn8w/B5OJdaj1h4MMVY8oLSt/o
         hf4v69wZzDFhsOxQCgmdMpVc0JfqdXNkfwy6uhoi4cPatkGheoSmehVKx/pPI86ICJxB
         /jlQ==
X-Gm-Message-State: AOJu0YxOTxnoXfiHnmfyRtVXiJSizJ/HPxSOJ1G9WpWSuhQFsc0yhfCN
	vH45L3oYHYHIUxL+x23qKwWe3WAkynGFh7HPRp3qjsgGVvkgb1MJjNqrkQ==
X-Gm-Gg: ASbGncvdhlwFaLjEQL2V2yAKm5eyT01t7CHBLbpsGD4VQQWMoEZxM+xLPpW6tnj6V5G
	t/f8taoAW74PEBZN9p2thT9VBo140UA/J3r7cv3TewdAlWOYcWsjI0rwB7JdiomTmygdOnt0tQj
	yC+R7KWHny4pIJ3giBTmXc2HmprybuSeRxmzTaoHTxoLCrFeREBIeDKQVBfT7ud4HfQAXgYE9ve
	s80cqRCWt09cw8YeP0w3DjVTTyxUrGMeZjXPh3BOIgbJtfl3I156CulLlgSNx3P3TJx3coJFk+l
	abBYuMPIWvKCjVubD9yhyT5RNmn2JPQq3zW7nQxo
X-Google-Smtp-Source: AGHT+IFKNj7hJWC4oJMBLwcHrbJKFzU741fyJjpiEA0lvIzSZBvtVDRvza7UfLchuqR7n2uWLN2Fyw==
X-Received: by 2002:a05:6a20:144f:b0:1ee:c390:58a3 with SMTP id adf61e73a8af0-1f2f4cace5fmr10369405637.6.1740787335522;
        Fri, 28 Feb 2025 16:02:15 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7dedf5a8sm3993425a12.70.2025.02.28.16.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 16:02:15 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next v2 3/3] veristat: report program type guess results to sdterr
Date: Fri, 28 Feb 2025 16:01:47 -0800
Message-ID: <20250301000147.1583999-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250301000147.1583999-1-eddyz87@gmail.com>
References: <20250301000147.1583999-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order not to pollute CSV output, e.g.:

  $ ./veristat -o csv exceptions_ext.bpf.o > test.csv
  Using guessed program type 'sched_cls' for exceptions_ext.bpf.o/extension...
  Using guessed program type 'sched_cls' for exceptions_ext.bpf.o/throwing_extension...

Acked-by: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/veristat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 41dfcb6f5690..a18972ffdeb6 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -1234,13 +1234,13 @@ static void fixup_obj(struct bpf_object *obj, struct bpf_program *prog, const ch
 			bpf_program__set_expected_attach_type(prog, attach_type);
 
 			if (!env.quiet) {
-				printf("Using guessed program type '%s' for %s/%s...\n",
+				fprintf(stderr, "Using guessed program type '%s' for %s/%s...\n",
 					libbpf_bpf_prog_type_str(prog_type),
 					filename, prog_name);
 			}
 		} else {
 			if (!env.quiet) {
-				printf("Failed to guess program type for freplace program with context type name '%s' for %s/%s. Consider using canonical type names to help veristat...\n",
+				fprintf(stderr, "Failed to guess program type for freplace program with context type name '%s' for %s/%s. Consider using canonical type names to help veristat...\n",
 					ctx_name, filename, prog_name);
 			}
 		}
-- 
2.48.1


