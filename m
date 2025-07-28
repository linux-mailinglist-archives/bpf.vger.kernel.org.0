Return-Path: <bpf+bounces-64498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF139B1385C
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 11:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E65517B9FE
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 09:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C5322C35D;
	Mon, 28 Jul 2025 09:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gu3AE6Hv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327381A5BBC
	for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753696281; cv=none; b=KLQ5xDmV2BoQgVOiq9Vl6FRdIwEQCbw6ZyiDViIDL186/Tg+j8od83fD0/9yqabeeVbSGxsud58nSl8L+nK2G3DXiIXipGyO0/tJk5ui4anxJRm4Pp4xOV/BdPoecku2gZhexYfawBUKLncCQHtiC1D+zM8jJK1eVUSL4ElPss4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753696281; c=relaxed/simple;
	bh=dRKTDUVG7/xiIl5HiW1yY1/sAfNNaIOpAG4v3Opb9jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9efmKnUnLG3UH6YqxGg2ua11F/aMjuf81ITbGtqFHLYf5Z4cb5G866W43uQ7+qIE382YMIO9IQiSqbWaLhkKnnnbTswyWhkyWnD3/D28y951bhYAEHsuhK3nVv48oSrTUpzgQjJtRKHzHd9K5jS1hQzaXKYlIM9ySKeoynt5r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gu3AE6Hv; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so26077245e9.1
        for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 02:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753696278; x=1754301078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X5Fw78ow4x5Fx5TApRahrmGDNzn/qx8zIne4a94WQLk=;
        b=gu3AE6Hvggglyl8PcEg2AeiEyhKjfPLY+TnuPPue2o9YYhL//pngz+nLus1FY3FRiU
         tkI7e9p3rsxcfwfv2OO5b6/BJCMfU0OqhglDzjzALmxb8nFvQ3qQ8Rg06O3FuA12SObJ
         veX5N1ewT7oUA/R6llqkWGXGHOPdQ7/+QxOCpVx3pAPpQdSY68Jqp5KHBXkW4cvg7g2c
         YYwbsUANPmsmJtq6gskkD2fCZ4qc8K180MJYcC45F6kpLcOkqQ/hAzNT8s6w1Gab6gag
         hio5i3GcChSu00n5QGwN6Cc9FmvichcjZivvBXdbSqO8MAbfyyE1rHAoAFhB8aMeE5Ar
         UiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753696278; x=1754301078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5Fw78ow4x5Fx5TApRahrmGDNzn/qx8zIne4a94WQLk=;
        b=jfp4URVMHkhIwftfOcY9plW69MEtw9nDBP8c9qagt22NvcvHVsUz18FJKFX8Jz1ahn
         qwaKzYHiFINxWrxTMT+LLJKVuf3+rK68y2qxg4N6NNiCcoaGVR9IqNBvOEiXId4B2pf6
         NWDwARGpLhRIoSAJwFoeRpF8wyAo/HVursf1QWCoSGVni0pawHQuXRPickyLMgoZPMuW
         X/QNI3lmkV70+Tg0qSvMNRRBTRdjq2LC7K2NaDgKWJT+hT5axT5u/SPYaQYs5ejvz4D3
         w/5L4wKfzHHJqWV9VSNi55iD+4PX6Cfjiad2VMSM8XCUE9FuG/AeVoMWN1/HV5myuR1H
         H88Q==
X-Gm-Message-State: AOJu0Yy+MlB5NKpXzgZGOmuWQrS9BiulG6Fnas0ryXNxF4m9IwehhwAY
	dXfLd/0rj/zE35lPEsabhARmZwJf+o67DYrEzVt6QLBylnxIJv2BQmmfgbSMNcJw
X-Gm-Gg: ASbGncsFo9zixMchMbVL1Fsfwca6+YAr42UnIYSgEyZS4bFqtf9RvMJCBd5LJwqvCI4
	zbbHFDBiSvUCL6NV8gNwL76PMMDhAAe9XCj49hPo/cj09oz14LG/gqWUWi13R6iXimlN0AfeFug
	Tf0NXjEIrC6hCmSzrL6eqGXQw8lab07KCNH6K5SL/1eEcBFKLBdu4cVUwr7GiIgfRfJDnq4VsNG
	kmvI2qxYW+i7Phryz6/MAoewt+I5oVZJ2jSQvX3VLxuK5WogZ/8JXfjjV6Ylo7mef4rkc5yFGyJ
	ITfQc2TsKNjYbymxqmK/sr3Ueorv23wFTb+vyjWo19URDvteq87SqsQ6Ac95JUwOq5OFLu1lpXH
	CgOrDw/+vOSbK+axiGM2TnIr7Y+ssqLn6Vs+AMW8wb1DHdf7hot5TpUksThprpef4cpdgGmm7pQ
	OTvHYXAI3Oxyi7DTvtXE0=
X-Google-Smtp-Source: AGHT+IFUuzH26LkP+fMzVn8dwF8XfHxd+lRUOJsJZ+iH3kKF9GstGJMMRXkukmHplPOVXA4LHQjk5A==
X-Received: by 2002:a05:600c:8283:b0:455:bd8a:7e7 with SMTP id 5b1f17b1804b1-458763127a4mr101290505e9.9.1753696278386;
        Mon, 28 Jul 2025 02:51:18 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00616c0b53953fa0e3.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:616c:b53:953f:a0e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4586ec63d29sm130069185e9.1.2025.07.28.02.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 02:51:17 -0700 (PDT)
Date: Mon, 28 Jul 2025 11:51:16 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v4 2/5] selftests/bpf: Update reg_bound range
 refinement logic
Message-ID: <b7f6b1fbe03373cca4e1bb6a113035a6cd2b3ff7.1753695655.git.paul.chaignon@gmail.com>
References: <cover.1753695655.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1753695655.git.paul.chaignon@gmail.com>

This patch updates the range refinement logic in the reg_bound test to
match the new logic from the previous commit. Without this change, tests
would fail because we end with more precise ranges than the tests
expect.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/reg_bounds.c  | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
index 39d42271cc46..e261b0e872db 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -465,6 +465,20 @@ static struct range range_refine(enum num_t x_t, struct range x, enum num_t y_t,
 		return range_improve(x_t, x, x_swap);
 	}
 
+	if (!t_is_32(x_t) && !t_is_32(y_t) && x_t != y_t) {
+		if (x_t == S64 && x.a > x.b) {
+			if (x.b < y.a && x.a <= y.b)
+				return range(x_t, x.a, y.b);
+			if (x.a > y.b && x.b >= y.a)
+				return range(x_t, y.a, x.b);
+		} else if (x_t == U64 && y.a > y.b) {
+			if (y.b < x.a && y.a <= x.b)
+				return range(x_t, y.a, x.b);
+			if (y.a > x.b && y.b >= x.a)
+				return range(x_t, x.a, y.b);
+		}
+	}
+
 	/* otherwise, plain range cast and intersection works */
 	return range_improve(x_t, x, y_cast);
 }
-- 
2.43.0


