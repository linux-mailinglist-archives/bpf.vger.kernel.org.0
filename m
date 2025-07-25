Return-Path: <bpf+bounces-64412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B78FAB1249B
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 21:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CCBA4E41D9
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 19:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E38D257AC2;
	Fri, 25 Jul 2025 19:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDE33N0h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE89254877
	for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 19:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753470526; cv=none; b=K52tMTBHvTAIvUyOj78UNxUb/psgQeCRXbJOMfN7WswcU1mw/qW5YgAAubE395469aLDq3NUOtdDJy1MFCQ3DaOm+BiFG+9o9B5182eThnv5mSl6KWsbeVqAYbpIIiWjyjnjaCKiOVWbSai75Pg86wl5mglcnSSNZf8so0TGYWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753470526; c=relaxed/simple;
	bh=brZJG9DnchSsXrtijXxyRXn/Pos2fp5nFRi/8ezs+8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2x9kejdRBYsvPKpZHjH0yxIUvBjCK1+mn0xVMRMb5zKeF/ZMMJbqzToaPxW/TtKT6cpr6/ipZwLVWOBk6Q7kJ6l6ANsWOh/LrGTuvTsNzkK9S8owX34OuVhb9SY0d6adLfKlXqjztp0rNpYC5EoW7/SNcjZHx+jFIWaI7HdIdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDE33N0h; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45618ddd62fso26585565e9.3
        for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 12:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753470523; x=1754075323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S9ReIHvkjEV61C+WifLMJCcOTz7BQCWIcyvKC+w/W0U=;
        b=nDE33N0hhLT8rpNE/2xEv874qx5CpGGf87Nu74hiCUhkvtbCA5TrmK7dhqvblOmS/2
         3tEzqSX8oAMOqEb0UiRsT5SIywH9dzm8oNaoRc5a6YUsgdXqV/4/pxJzMU8n2pWqccqQ
         Btwdwh77CRcgiUpltYBt1R1GYhctxsfFXpNRtRpwbxBtPcixfbLhk6of87GCbbZKYW/B
         O2KuMMQL4WYCLI6srDQE5euhCm0HjNYOLuEHLQnL18a0/FeE6TPy/tSad7mncv8RtLtg
         1papbFCOrAnR/uOEzZiaEDR5coIaXBkhwHgJ3kk/RoEb1i/onL72bLXG3AJephjhMiFI
         YSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753470523; x=1754075323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9ReIHvkjEV61C+WifLMJCcOTz7BQCWIcyvKC+w/W0U=;
        b=ArAG9qXMmfQegBRqkkkGpkA6NWPxtTG5ep12cvEDJPSdLBRCBYWv9mJx+SUMBD2F/+
         khXSnqHJQ+mf4aFVlWysi79MzbVPWf0gpvGDwQI6oUMNVsH6CU8Hnxz26YGWmoJ4OXjl
         rL8vftYg8O+1iwhRDjcbG1FED5JdyLkZQWog4ZQja2UbKMetNfoo8GQ7nB/hXMCRNRcF
         0WaT5ffcwZ+shKo/hVvsKJUVbu6WHyefY6kDFFDR3B2jpr8VUqdi1XRO7sUAsTcPHgFY
         qBpJDuhhgT7rkiSUWj5KT+JmUGmp1sXk/0L4jTxtntxTPUztBw2ky0PRB4brfjuNgtmG
         xUYw==
X-Gm-Message-State: AOJu0YzNCT31WTq4p3e830LcmrKIxFBLG2piStV8WAfTanY0593iJzVa
	rzEUftTw0jPMtdxuGecqOnnghL9dyBjZ9/WrHPwAGtNSYhyXq3CK9fodJ4AiJdE2
X-Gm-Gg: ASbGncvMcVR7mTiylYJtyueG35rFuKYPzr7ed+7lGS3k5ChOnSZF4hvaF97V2azigsR
	xaRkLmlaPdMSgHvEj+0XAzQtyVkP0V3Led9S9iVL50UDvyAddCE9Lv3HLNi2CosVm+AUS//dYr0
	Z0/ZOEw8RNJH5X9b0STKpeal9Ywzx2pcbrlt2Zgl20mXTHXkqE9S0Sd5QtAX2KlGmJSNtGcZL0z
	3sOp46GlsqWukjlEmcbW8QQrvZ98g9APXzu2YH3mjK+ij+zncpowSYd8tmzkbrhYXKgMiWnK1RJ
	mQYNMe6iJZBLtqeL07ZPr2hiIS8sbLSEF7bu1RJ9AgwewAK8A6lPzBMQC5MuVrbD6r7N9O6ulRl
	27YMHjunqvMxTpVqmxiN3m/uzsRyLDFcVhgo/tsnKu4jwCbVJInM25/tIXlOcKDBcQOE+NfbWwH
	+2LjUTzyvANSuys2BkR5Ys
X-Google-Smtp-Source: AGHT+IGmTF4nB+0id7joLxH1cFCXY3eUoM/cyuLC73tHG29GFplLwP0w5pp/mf6ZRcvzBt7rkpkyAA==
X-Received: by 2002:a05:600c:1992:b0:456:d1c:ef38 with SMTP id 5b1f17b1804b1-4587655bce3mr25911445e9.24.1753470523159;
        Fri, 25 Jul 2025 12:08:43 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e008dd2b4234fb07c80.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:8dd2:b423:4fb0:7c80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587abeaa74sm6396555e9.12.2025.07.25.12.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 12:08:42 -0700 (PDT)
Date: Fri, 25 Jul 2025 21:08:41 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v3 4/5] selftests/bpf: Test invariants on JSLT
 crossing sign
Message-ID: <c9affb5910173b1f4f2afa6950b306e1d68fc584.1753468667.git.paul.chaignon@gmail.com>
References: <cover.1753468667.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1753468667.git.paul.chaignon@gmail.com>

The improvement of the u64/s64 range refinement fixed the invariant
violation that was happening on this test for BPF_JSLT when crossing the
sign boundary.

After this patch, we have one test remaining with a known invariant
violation. It's the same test as fixed here but for 32 bits ranges.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_bounds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index dd4e3e9f41d3..85e488b27756 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1066,7 +1066,7 @@ l0_%=:	r0 = 0;						\
 SEC("xdp")
 __description("bound check with JMP_JSLT for crossing 64-bit signed boundary")
 __success __retval(0)
-__flag(!BPF_F_TEST_REG_INVARIANTS) /* known invariants violation */
+__flag(BPF_F_TEST_REG_INVARIANTS)
 __naked void crossing_64_bit_signed_boundary_2(void)
 {
 	asm volatile ("					\
-- 
2.43.0


