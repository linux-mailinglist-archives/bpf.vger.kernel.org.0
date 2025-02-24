Return-Path: <bpf+bounces-52393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D73A4290A
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 18:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0711667ED
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 17:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55005267706;
	Mon, 24 Feb 2025 17:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V5ChfgId"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9BA2676F9
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 17:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416569; cv=none; b=otrsw1nXc7dVFkb8gO2/zEmAihrwJpS+3tJJGJFxdyJNmnWIcOcU2aZP8hs9Si18RxvHBWk+oV9og5TV0DmjHMUVo+2Ffr7oXWlXKecwPT63SqRfblpdd4/tIMYOj71+mdbRgntIsYRwHoJOl3UOFx5WZmCC9vWJjhAvvQR0gW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416569; c=relaxed/simple;
	bh=2/tNsQbKiTkaxCoHs1UKZQvUCGIwo1zazwTLngtVyq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e2FzctBDytnG1iLJKN0bM8DC76Aps6eRc9uxHY1h+I5Q00icosbi93xeOGQAeYb+Gb6R2UjcGO5eSCxL5HcEVBFhG10McGh5owmauBD60G/JjK4Se2sr2ctGb2mA7kzQRe2wQuGcoDEbcTZY4bUSE5faWG7sySPFUaJ6Q0ehg5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V5ChfgId; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740416565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z6dFsrJK1KUGJWoZLEUFQHIqOltFLVPZ4LRzfSz7zsM=;
	b=V5ChfgIdY+YuXDWOmrz5dDv7LDtZpqj3plpZq5HR6FE8Mp/6gXq9WETqpPal5m9wiPBSe5
	PfCihKDs9jgUVJt/b72G+O6c35N2j+VDY2NIdDEWFWDCNVNYj/8H+lVxP7Hy2QIJBMcEKa
	chKZ/qBrAnhr2K68D+2eTJ4W2g3p7xk=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	jolsa@kernel.org,
	qmo@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chen.dylane@gmail.com,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v8 4/5] libbpf: Init kprobe prog expected_attach_type for kfunc probe
Date: Tue, 25 Feb 2025 00:59:11 +0800
Message-Id: <20250224165912.599068-5-chen.dylane@linux.dev>
In-Reply-To: <20250224165912.599068-1-chen.dylane@linux.dev>
References: <20250224165912.599068-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Kprobe prog type kfuncs like bpf_session_is_return and
bpf_session_cookie will check the expected_attach_type,
so init the expected_attach_type here.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 tools/lib/bpf/libbpf_probes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 8efebc18a215..bb5b457ddc80 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -126,6 +126,7 @@ static int probe_prog_load(enum bpf_prog_type prog_type,
 		break;
 	case BPF_PROG_TYPE_KPROBE:
 		opts.kern_version = get_kernel_version();
+		opts.expected_attach_type = BPF_TRACE_KPROBE_SESSION;
 		break;
 	case BPF_PROG_TYPE_LIRC_MODE2:
 		opts.expected_attach_type = BPF_LIRC_MODE2;
-- 
2.43.0


