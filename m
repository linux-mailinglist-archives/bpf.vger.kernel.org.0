Return-Path: <bpf+bounces-31915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF55904F99
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 11:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE8C21C23222
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 09:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD3E16DEC8;
	Wed, 12 Jun 2024 09:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDyft+Uk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C861A34;
	Wed, 12 Jun 2024 09:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718185900; cv=none; b=o4FJAMh0/5ZfF9N4yQQSPJI4eqpCZHt6+wl0CPGH0W0wZ0OvjCiP+NoCQSLBEJfBZCKEH+yMpWvOlCHcWCdF3qKgHSJFlamdcOcRpCC5U2RLagpNZ1qHRt2uP3+49LEDhsOPjUoFMTuQCXvbc9fBZKwTfckR2pYG6VocPqLK8Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718185900; c=relaxed/simple;
	bh=8dFZrXMQrpSMEZnw2V6V7d9rPJd3f8Fhs33OTTxQ9Fc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z8pY0Wc5bHHALmCog4/MWLxzUOlu6cC4hKKJBC9cPjAucMoKMm1kwYiG87kZJI5qjDmM6kTraxk6KqAECtcQv4+dvAxZNZTIiD+xKx4yMAnLyaUtYxsJ8fn2/E5yHSCWINkKHUTiCxWVls4PymSxjHrPOspJF2sdWQsAhPEYdc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDyft+Uk; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-6ce533b6409so1601079a12.1;
        Wed, 12 Jun 2024 02:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718185899; x=1718790699; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0gzrM6EvAqCUYyubpdKPvo+y6fnT5QsRDHvsxqtQtqU=;
        b=NDyft+UkATa2UFldp+y4RdEVUCDXHkQnmjFPVY/a4y4kXD4nJGtpkXFINy70XzajOW
         jGjAiTkEenKzh4A5ScHq7pLs+ty1vWIpK9ROAqY8vS7CVM0HuUOXby37MI8O0o8w7Lo5
         8nXtPPdfOLeLnJ4NtdJpHk00b3IHIiyIOU9HRU9Lc5gzTrKBVjc75KtvSWEsyHaKLAxo
         8rogKJDZW9ryn10JRVsxCjw3QokRHj6VKWu/BmWzrSADBCVICWPK/JfQOy4E7ll4PdIF
         7UjYH6fyBgvS3ab6awSk13Dq3WD8I8YAp+zBk6s+Sh3s2aw+Yp9hNCb0lNN40j6yWtKC
         TuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718185899; x=1718790699;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0gzrM6EvAqCUYyubpdKPvo+y6fnT5QsRDHvsxqtQtqU=;
        b=sAW67aX0+eUTyGU0lh2T5s5t9vIcHtrz+dBrjqS+hx4S99oaFPi01i3ISNfXmB3d/e
         x05hVG/zY6tfqiyYr6Qep7IRHV9bGI+JSGQvupMeMYJV9+O3IDUw+Iri4gfoVhpcKzEh
         d1MCA6INfLPb7wVnh3e2JVVLxaR23RrifM40g7NKNB/PQAVvqFnmJJhlyN1VgECUSzbD
         x46SPnWd7/j6A3ojnNethbOULm+zKhzioW8by5hO8ypnwABKn7UgSFPB0m0JXH7ALLM7
         8HCcTIQRWeADnF0X5MNc7ArAtOjNikkzHhsSQA7eVy5CdqYrDKqOudMUyoOOc7Hw7hWy
         I/gQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpKBFUdYnA6z/1p+jHDlh5YTpU4jruBf92UeaWFJhNBgFX9u8pvdTFbC4ytcdXEoYIyK+eyQT9ycqLNvwE5PkvpWlh98CCQRjNcdxi
X-Gm-Message-State: AOJu0YxZjo8y2kOjD3uttfzeGvXtjJ+HFv0tQkTulrrIcEs3UQVPAz+T
	fGuS7d/oiMCWbUOij9WySkGcnkiVs/IP/Nc25VrTtK6u55hXpgzCpfU1MvWVnAc=
X-Google-Smtp-Source: AGHT+IGJN0M/2lFf49OeqFh31ecKXXTeS9tXciHX6sjFHJ0uuRZ48YpqlzWs/E6lU0N4L+wFzLxLjA==
X-Received: by 2002:a17:90b:1d0d:b0:2c3:40b7:1f6d with SMTP id 98e67ed59e1d1-2c4a7530740mr1817234a91.0.1718185898396;
        Wed, 12 Jun 2024 02:51:38 -0700 (PDT)
Received: from localhost ([2405:201:a42a:e05e:b15d:9596:9397:9fee])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2c4a9c2fa34sm1161774a91.38.2024.06.12.02.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 02:51:38 -0700 (PDT)
From: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
Date: Wed, 12 Jun 2024 15:21:25 +0530
Subject: [PATCH RESEND] bpf: fix order of args in call to bpf_map_kvcalloc
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-master-v1-1-a95f24339dab@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJxvaWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDM0Mj3dzE4pLUIt20VMtUM+PEJNNkS1MloOKCotS0zAqwQdFKQa7Brn4
 uSrG1tQD2m2AGYAAAAA==
To: Martin KaFai Lau <martin.lau@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1428;
 i=sheharyaar48@gmail.com; h=from:subject:message-id;
 bh=8dFZrXMQrpSMEZnw2V6V7d9rPJd3f8Fhs33OTTxQ9Fc=;
 b=owEBbQKS/ZANAwAIAVeh+rkVtmsSAcsmYgBmaW+j/5SiyBV1U+kYa1ezq8Z+KA1egtQ3xxPiO
 TjQprR/7qWJAjMEAAEIAB0WIQSJaujhf+zhb4nUAadXofq5FbZrEgUCZmlvowAKCRBXofq5FbZr
 Er8pD/488YlR0TVjaPLg3f8HjCYciHzDhSZtlc+mgsxn6oHHV5fwRfchyp82ZzPLyLaucoC0xec
 8buWJEjWFJ+IoHURJ0uLl1lts58UyHHLOdu3CvQsoHzZBqpU75zDaZVDckeco2LvfuJ6Y5tZM9x
 VzmAkEYoYKNMWg4rMaMZ7fgaUHfKwUlLRlcuhZ2dYsqXT93ZkytWTAc5MCbryuh2y1XpUm98nwx
 n1pi8LzdZwKdF1QfpAKflwH7pwLi7zVLJceWZUg5FpoygGtnw4dQIwP8FtnUSpVv0f/AaJBYwou
 AeJIDCAJ6llJ97a+Afpdfj4zJB6Ji6K0wihM3TxA1McSqNdERYWB5Eg2Ny/K3cstxcI2bp83xMm
 q2WlZBydVdxQaFvxLrXGUujwENW6CoqbHYr4af5w++Otb0jriVdKqzU97XysGbZQg9owH4Iq3DB
 TWQyTF7NBhZapQgQNlk8dDgjl077bhdu7nOvEm+wQw7JsHOI5j2IS5By41XiHyi05/9UZovnQcX
 Xy3LpqGaWgiConcdPNRRGMIVkuh2kQd/j1eTlqObpRMcJ4AlhEr5xjyrGiIVtHk7NQxpNZcNY7p
 EjtgAgCslE6AMOlf8UpbG6KgXRjLM6MZtMf4SqqCRns1gJSxPKCqKKEoBfCFAMbeRXb4x2HY2C2
 1ca/CydMvbPiNyg==
X-Developer-Key: i=sheharyaar48@gmail.com; a=openpgp;
 fpr=896AE8E17FECE16F89D401A757A1FAB915B66B12

The original function call passed size of smap->bucket before the number of
buckets which raises the error 'calloc-transposed-args' on compilation.

Fixes: 62827d612ae5 ("bpf: Remove __bpf_local_storage_map_alloc")
Reviewed-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
---
- already merged in linux-next
- [1] suggested sending as a fix for 6.10 cycle

[1] https://lore.kernel.org/all/363ad8d1-a2d2-4fca-b66a-3d838eb5def9@intel.com/
---
 kernel/bpf/bpf_local_storage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 976cb258a0ed..c938dea5ddbf 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -782,8 +782,8 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 	nbuckets = max_t(u32, 2, nbuckets);
 	smap->bucket_log = ilog2(nbuckets);
 
-	smap->buckets = bpf_map_kvcalloc(&smap->map, sizeof(*smap->buckets),
-					 nbuckets, GFP_USER | __GFP_NOWARN);
+	smap->buckets = bpf_map_kvcalloc(&smap->map, nbuckets,
+					 sizeof(*smap->buckets), GFP_USER | __GFP_NOWARN);
 	if (!smap->buckets) {
 		err = -ENOMEM;
 		goto free_smap;

---
base-commit: 2ef5971ff345d3c000873725db555085e0131961
change-id: 20240612-master-fe9e63ab5c95

Best regards,
-- 
Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>


