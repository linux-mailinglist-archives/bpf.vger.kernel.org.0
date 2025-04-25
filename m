Return-Path: <bpf+bounces-56693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAF1A9C9BC
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 15:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1BD8171C05
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 12:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C17425178F;
	Fri, 25 Apr 2025 12:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clTgzMME"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0515E2522AD
	for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 12:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745585977; cv=none; b=k0rKBaErxKGk48y6J9FvqSN8+lERZHORbiFAm0q/OsSyHZasdEM/VPRx7FgjeHHegkl+dWSFSzS7KrYc03PY1M2fUKLa8qg9jXN5LvPx2Zpjlljxk4kOv8ikrhppejSNYG7kUpm4Q6G+vU7bFQEPwfmaJXulcOKOOZ5KhNS362E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745585977; c=relaxed/simple;
	bh=gTbPkBJxN1vTwZgyaZCEd2xtjCadw9KLjM59OEv9uJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S3AVtgUN8orXqJfp3rTgJtER7UfcMWc34Z/q3NNoAHh5IpXWCiOMKuFDmbTk/qk+i6kkhMN/heODXeXvR96yzUBUsSXsbPVnmNKQh2U0akL30wHecH8fPfLRXSl+45WyuXCIAL0HsWmopjJQJvprWCpAqtvxpgplwpy684D8vz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clTgzMME; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e6c18e2c7dso4131272a12.3
        for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 05:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745585974; x=1746190774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXwNGTGcddLFLDY7Y3oYEDHgPehPjG2D+X8E8ewRcls=;
        b=clTgzMMEVv10X2xRg+NovIhxrnGxOpSYk0oa4V/GsctC4fIh+oIJKff1WB+ddlAWXI
         dGv3QyQCcVnmQnKNmwf10Ldg3LMKmlNSAc7JbQp/IoOWNBTHthH2bPFgFTISuJ7almyg
         0RfSqpMe8mChnkf9lViMPfgL5s5rRII2fLZuRpEeKBBAx2tBqzcc6ZGyadIZo36kNyD4
         LDdL5qq1juLsxdPbe5YxED8hLB3F0lSrSh6fjdBQVy3WmasNyfPyg+ibv6yOAZd0kOO3
         CYXgHbY4g3DvcqLQVDh8Kn4ELmEUuuYfzIKC+C7YVwZlp47lPO8ugMtgiF8P2aKu1xV1
         j3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745585974; x=1746190774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXwNGTGcddLFLDY7Y3oYEDHgPehPjG2D+X8E8ewRcls=;
        b=dHOOaF+OlpzXDPzs8DJtM4ZAe2rp0cNVXDhQP52rknnvJNG0YNJqigerlbZAI1e7hV
         gWeKjaCmYSPvsLBeIEe+UuTsmWzjNXRxvbhuV/TRqi3ZEzUTbuPKh4gTGbzkYkFqbHoU
         zXSnHDxUEJkBJ6kMXD9p3Ycp5MPaR6yCBs9r0Ppj5dIIqSv1pc5xOEDkK01UPrCf5lUe
         wbceAG6uVChRfYd7ZSNOglL98/fyD6KOAw4J8QXATu+1JGkiGucsFu3RSD5cXJdqyWn7
         Hyv9wQGNiyHwi5vSmh9AxA/sOw8Zf3N2pdAg/p5Sh3lNpHpcpW8Oi6MPCd/zqBjnutVA
         hrYw==
X-Gm-Message-State: AOJu0YyneMItEj1gGmoJ0SLRcszqfWTsCQEkS0FvvpcMQmoVDuHB6+ne
	PxG9vgUwJ2f2r77zpz9PtX8yLqRm7AleuQV+PsBQC12qgRt0g2K8WAq/xQ==
X-Gm-Gg: ASbGncswl6drjjXzFwSFk6XFY+GNvyeD4FY8apgZqWlxvSofJIXelJncDOAyp2dCT1D
	SsH8Omuxe87hXxT6K5gxmA2/N13mC2XbKJbEaslqbLgbPq/XOSazd7nWKkaldOxLhJr482Sm27D
	twAcl45hp4TD8Za6gFwh2EFGTFUi3CTQIdkfIfndJThDaLNxlzASbY6i9Cel0NrGQMte1B6zKqz
	A4kM1yAezExk1cQHX6OOoERQpedQYa+joPrN9OOsEMiPYOPi/GsCjZEkNZyWmgEf+2EC8opI6/k
	GE3+8nM7qO9DhFfgmdMdP3bDaYAK5PUYTIq5cTHJRPTnnbrN+/TG
X-Google-Smtp-Source: AGHT+IE4j4HBSGrr+mRV3+NpbAm2SDICYm1ikqJWL7MfG7P8+3wg7bWLr02x1kZcvTG51nvpVJ4d1w==
X-Received: by 2002:a17:906:d54a:b0:ac8:179a:42f5 with SMTP id a640c23a62f3a-ace7108a276mr216685066b.14.1745585974103;
        Fri, 25 Apr 2025 05:59:34 -0700 (PDT)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:400::5:eb6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f701106bcbsm1224669a12.10.2025.04.25.05.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 05:59:33 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next 4/4] selftests/bpf: disable test_probe_read_user_str_dynptr
Date: Fri, 25 Apr 2025 13:58:39 +0100
Message-ID: <20250425125839.71346-5-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425125839.71346-1-mykyta.yatsenko5@gmail.com>
References: <20250425125839.71346-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Disable test that triggers bug in strncpy_from_user_nofault.
Patch to fix the issue [1].

[1] https://patchwork.kernel.org/project/linux-mm/patch/20250422131449.57177-1-mykyta.yatsenko5@gmail.com/

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/DENYLIST | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/DENYLIST b/tools/testing/selftests/bpf/DENYLIST
index f748f2c33b22..839eb892adc7 100644
--- a/tools/testing/selftests/bpf/DENYLIST
+++ b/tools/testing/selftests/bpf/DENYLIST
@@ -1,5 +1,6 @@
 # TEMPORARY
 # Alphabetical order
+dynptr/test_probe_read_user_str_dynptr # disabled until https://patchwork.kernel.org/project/linux-mm/patch/20250422131449.57177-1-mykyta.yatsenko5@gmail.com/ is landed
 get_stack_raw_tp    # spams with kernel warnings until next bpf -> bpf-next merge
 stacktrace_build_id
 stacktrace_build_id_nmi
-- 
2.49.0


