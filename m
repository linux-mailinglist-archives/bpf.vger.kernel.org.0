Return-Path: <bpf+bounces-64500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE69B1386D
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 11:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4DD13A1A19
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 09:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2161A314E;
	Mon, 28 Jul 2025 09:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qac3I4gJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0D42153C1
	for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753696310; cv=none; b=IlmMJC6P6kh4f3TXN+vJ4Lzrdy6H7yxZWsE02sQONH/mOg60E8D9ZfCs7PNk7Hm3cwAOCNWsBj7juIrffbiW2ZIu8DapH0QDZXyQhjrrHgEsHl2vc9WBqTk3hTgrZu16uP+hjACGAT1GGkmcNqWHMK76/q18SsFAwoz4TzSV0N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753696310; c=relaxed/simple;
	bh=FCzvUaHvy8HJyHoDBzPkSLkZwfMV+5PKgCVqt7y4e+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHHqcA+yWXEkHxLU1sMmAXLvaQj6yXt8lPM5xTGKqfKRopWcfz7nURcNiylD2TuL8bjbn135qyYt9OAKSJRuFzM4vMnSKqRSFEotK8CGlwBMgGk9g9k7nMw0EH+xrMfhGcCHKAZXo+UI4CBCLbX6AltBXY/rMZv3EOjM6fQ61f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qac3I4gJ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-455b002833bso15767255e9.0
        for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 02:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753696308; x=1754301108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LH1Soz8lMJcxg2I4lYHxpQi2Q97v2O4ASrMDNjdev9A=;
        b=Qac3I4gJbeqLOyInckCsFdVSu4KpVHXePoi7wQeCfwnEK0x3IayGE711hIajbNr08g
         qUgBkAim1Zzhssyz+TCiHiuWoQjlFMWKKXCnWU69ijfPjkvXf73QO9G6DWPD2szofXm2
         6A9cfGKVyiJg1n+/CgCVD8uZF04JtvMGr7H6Vs4hTihw7lsNlx75Lt/+7m9grRkLIH4g
         geD8IeJ+2qI9mRCmJO2NT25Ezu0mq8FAOrVeq7RQTRf5xOlACrFTCCskgEDs4G+h3dP7
         4MPlHbX/IxYGKuT6ODNQLQF5lNQBfhWfs5WAMOYtmMYhBLoZsgoFG4eCs2GXK+dakXYi
         FKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753696308; x=1754301108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LH1Soz8lMJcxg2I4lYHxpQi2Q97v2O4ASrMDNjdev9A=;
        b=K8v9BRMj+4lcVAd+xD+lLUyTkEbWLt2MZ2+Hc8xKjAkEe6jIwzUM4ETOjBUB7me3Ie
         kp5yZ29I2dENaHWdhFjsXDO9Cua39/pjnpZKnY3AAAdJA9VjaPt69M52Jq9zmIoVSTMz
         FSiYc8ypY0TVoHXviBN37MOOw2NzJNzwWzAcE89PTbz6q9NJeBtn2xOm86t5PEju0qju
         nEJegt6jjwx19L/2ylnbd/4VY87+kqTyjQP0q4WtcHcKG3MJOioHX0/SiWD1OkWchpMy
         on/Rd4abhLQ5/PaHqZj6bRrAqe3VORhcBNuq29u9iBcuwPxmYResUL67U53zp3+ltmQs
         XwUA==
X-Gm-Message-State: AOJu0YzeKe5o0U17wWikF/m45dRftPTo4uw+Qhq2I3otnhqqKjn5pgUz
	hOIprGxYdCaqjJWz75y+V76TxH1YuoUYT0F96OkzehlGOMjFjlVMfFIgz9uj1syd
X-Gm-Gg: ASbGncuHbaLr45UrNv4TKxrVCwz8N9X2OEqs2A3rJXAB+gdSChYxCx/SPB5rO4KFe/H
	IrezHPlVZeoPdNmX44Jf1AJkMnJzhZmcDGcJ68A5fH+o28tB6OYotDk8Eo0b8Na28S5xq8hEUxM
	d94UZ/4oCXfO/BFUwXy2Gve0/3k13g9yY7srPCMmkzjS5qhnaQAhQu8XKVIGSe+g0SvQLt8br+E
	l0ezgeGb7Ol/K8/onhr9eJ/cYq2W6TKSeOiUPOcRdarFhbRFWi7oQT2GcElKbPg91VHLikzhcJZ
	aABWNFR3ybdXlrteOTohlIbfnwTz6/I162ZxKhWYz0KCd/3FKWTegCTfx7ZAi+Tg4do8MDIC6f8
	CsiQgCjEhVFfJnKgkAxBi7hih8ClVnYgH08mNXFF/gBk5zYKYV3E6BJxDnkqbXc5mHY0a/Ny1OT
	qYx8J6ThvVwWfZaY5e4Ww=
X-Google-Smtp-Source: AGHT+IHbWf9D8cbpV5M8tOMNzMwCAPqxEOfluIvH2/AtcB9GGXhje/XFZGV0yaEPGO2N1dSvTkYbwQ==
X-Received: by 2002:a05:600c:c166:b0:43c:ec0a:ddfd with SMTP id 5b1f17b1804b1-4587630761emr79435095e9.6.1753696307550;
        Mon, 28 Jul 2025 02:51:47 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00616c0b53953fa0e3.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:616c:b53:953f:a0e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587ac77c7asm92935755e9.34.2025.07.28.02.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 02:51:47 -0700 (PDT)
Date: Mon, 28 Jul 2025 11:51:45 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v4 4/5] selftests/bpf: Test invariants on JSLT
 crossing sign
Message-ID: <ad046fb0016428f1a33c3b81617aabf31b51183f.1753695655.git.paul.chaignon@gmail.com>
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
index 41f4389e08c7..34b3f259b7a4 100644
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


