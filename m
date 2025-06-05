Return-Path: <bpf+bounces-59782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B18B4ACF751
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 20:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65DF818899A7
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 18:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D2827C15B;
	Thu,  5 Jun 2025 18:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhlz2LIE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A23E27A46A
	for <bpf@vger.kernel.org>; Thu,  5 Jun 2025 18:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749148611; cv=none; b=itz6i4UV3zbk5G/cULwGk4I5AKsL/HBK0FFwRyozkDsjnjbOLDmLcUNOcI3UwaoXV+ErXCqjVGc5OWF6b+lEEyjoomlNP49Ai/te73uyIKXFogYefXezG/XBOrzD0K7Z45gQHrpRa8O48kFB8sYXCXP+xt4rKo5adsTfvEYh7Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749148611; c=relaxed/simple;
	bh=pfmPZGuh3wX/YWA1/1lNG0E/eVhXjFPIRZoMOMlpBpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i13qt9dQIR+1AwJvvAohjxGS/4EDHNti4PLbqQHfqhGDEDkhyHzVvqNcu7enbApABv/IZ3z16Ttz0suedFe9OzPvDw95dwa59K1kOMNPF8MfCKWk5GBqt7wBKF47JcIZGPZFOKjd1WHT9rPDGIrs93LHMzWoTGfs4l27xPTyCds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhlz2LIE; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9ebdfso2413960a12.3
        for <bpf@vger.kernel.org>; Thu, 05 Jun 2025 11:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749148607; x=1749753407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uxjmvfaX/qBVvEyzjWhhUHc8DxeDmwK8AM/5vP4Km6U=;
        b=hhlz2LIEi0x5w4NrRM2De/GUveMHvqh8376CVBkVUpoMa80LM0DmJYj5PmDLUcdiu/
         +TgWLwTgZdDYfpSUiOCeHY2e0OAX1399Ab9+DMqMthJB70rCm8Z7CHEQFz/bA1NJpt2G
         HEsTOHUtYRBCYodF5kQqiGwgDaxAN05vt2aHM5pcR4yx0BfefutxbeQV8PUkjranJcOx
         Sc/2VcQs0mgqkjawDaG7ap08xkBFjIgJf5UHuCzUnSEJxRUB4nS/+RBg6oIJ8aqX76/o
         Z3wRKgL78Re9E4rnqMDFaLwXdb4aWlSBVyI2JezSqjIU0wchIRGzjgsu0inK6/SqTEmM
         hAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749148607; x=1749753407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uxjmvfaX/qBVvEyzjWhhUHc8DxeDmwK8AM/5vP4Km6U=;
        b=q5n5TohJcTHsHBcwgIehOUtBL2j02CWYjuQtElPxnYux4HKwKcHr79GkLfY+3DnyA1
         lJY3huZn/T4MfqjP0LASLnLqD0eCjWdqZMDYUdVknoumylLhEwO5OuueETJVFnlkqLpR
         JPSZtNk5Ztkq5rL6nCCIZWpcvI3YqyWSHgrYFz1wo8Kfa28RAacx0+QG/uyi3v3y+Udv
         WiObzFfGJu3aHNseG/lx60nukHxN3MFaixGkYUZ1H3yezO+Fv8Y2efWtSRQwv+yZokGO
         h6XzThaMY5KJLB3kw4sJBQ6CR5SlRR/hp/EnNSgNpPswYKvj1zkkgufSjrkVM2UiUdw5
         tcHQ==
X-Gm-Message-State: AOJu0Yysr+mBkgoCdaqYGp9CiUYVC/3OLFftjhZiPjz8/OQZM11Q3CDa
	TSgqi+9WgGKApsQqmrkmAtQjK2LDTehqpsn4Go+cYogBH6OGZTOhV3hSN37wfLRcNyU=
X-Gm-Gg: ASbGncuBqjNcx7MYSk7+xl55rij6mMQJyRri/cZ+TM/mrr0Dbkg/cQvRgnZOblUufrA
	Y7/shXck3GWf+rduLtIUyKmhexEDGq0kJO2zf6DOSTfZbMrgwvaYgUV0mDTgBbzWbk6KcTjkTcp
	XPu9F1WJtV5yRr6UfaK2w3uOcDL7+RWZQ1h+Qg8Tzyo2l06B1E2IRfTiQg7zdzRatjRKGviU9sz
	9ipB8DM4k4vLFFtiaskN5a8qccnwIpy86OArOXNgjC6BMLpievDSLSglY+NE50QQYEYzwqm7xF1
	yUbTUJEj3YoCfgk5xIomlm72P1xQALJI20kJYJ2kpQ==
X-Google-Smtp-Source: AGHT+IHy4+pM/yUEkdgz5Xi205tlIASDPtAsyrAbq/7pBQzUvDr/j4Gy2lf4Iy4FezMCLSXHUfafkA==
X-Received: by 2002:a05:6402:5256:b0:606:ebd9:c58b with SMTP id 4fb4d7f45d1cf-607734170dfmr228906a12.1.1749148607298;
        Thu, 05 Jun 2025 11:36:47 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::7:1013])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6075793bba8sm356782a12.16.2025.06.05.11.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 11:36:46 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2 0/3] Support array presets in veristat
Date: Thu,  5 Jun 2025 19:36:39 +0100
Message-ID: <20250605183642.1323795-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

This patch series implements support for array variable presets in
veristat. Currently users can set values to global variables before
loading BPF program, but not for arrays. With this change array
elements are supported as well, for example:
```
sudo ./veristat set_global_vars.bpf.o -G "arr[0] = 1"
```

v1 -> v2
 * Support enums as indexes
 * Separating parsing logic from preset processing
 * Add more tests

Mykyta Yatsenko (3):
  selftests/bpf: separate var preset parsing in veristat
  selftests/bpf: support array presets in veristat
  selftests/bpf: test array presets in veristat

 .../selftests/bpf/prog_tests/test_veristat.c  |  86 +++++-
 .../selftests/bpf/progs/set_global_vars.c     |  51 +--
 tools/testing/selftests/bpf/veristat.c        | 290 +++++++++++++-----
 3 files changed, 335 insertions(+), 92 deletions(-)

-- 
2.49.0


