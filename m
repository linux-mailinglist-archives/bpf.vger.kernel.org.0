Return-Path: <bpf+bounces-63808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF970B0B06B
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 16:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 683DB1AA3810
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 14:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86927287255;
	Sat, 19 Jul 2025 14:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4MALlyE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDA91DC9A3
	for <bpf@vger.kernel.org>; Sat, 19 Jul 2025 14:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752935070; cv=none; b=rvQWPQbDWIylKhOtuRp+cyismxPl/gPOi4r/ZPEEPpxjEYH6K3/A+RLthRMlWegT7iHSfkuwhj31MxE9Mdp/WeroL+tYrn9S0DBH/Pi1IvAOeBKfF4fGGqOLGpB1S++YqCKIB7R9P5Bh4DkTFTB2+NkgCxePQztCte2eBts+x78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752935070; c=relaxed/simple;
	bh=iwGHIFFfN/CzQWzwpYwAd5dSWVK+9CGzDtmtixXHpTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmcRT2A/9ctteN3XKb3XNf9Oh7uJ3koAikD0TkkyhPd0GnHg9kv/tR01xJ0CPvM3EmtEQ7eFsW7bPsEOowAkbWZIMmYNnSBiBUuROLxHTpRrK4TfhZRhFyZx4SqyM02jxABDKmZszeQ8jThAutc7HC17i83b6zQ3YokVsrxZQC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4MALlyE; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a588da60dfso1806823f8f.1
        for <bpf@vger.kernel.org>; Sat, 19 Jul 2025 07:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752935067; x=1753539867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sF+xvVmHZPhTzNR1UoHcqNUN0jk8rLNsh8L6Q+kGkzw=;
        b=D4MALlyEv2Tra9AUE6V8geqrhT583fZrE1iGQece1+8Iw6T9zxHxk5cLCArX3CxymQ
         8pK0PiNft8NHPspOv3CUhB2O5KPmms6NqIU50crRGVohczdRvzS1OJ0Hnv2mC/CtqDfe
         z3zTy74WfMcBpntSNrxd8OOvZ+8QM5N0tEmh9wgv2rUvHhgXO6hFgcEwlqs/2VaeHnt3
         f2fQq1yg+ytLAmVsZeXBpsrtRWQxvTMAJNU5yoxkwGtaW6qA8DTDhIaTFBa/FAlj/AW7
         TWHUruvNnWqLNMTnuJLoRO0ptlVF9BCtPYJR/C31I+N6wo1/3u8eX4JOM85etoxyj2Ke
         Owrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752935067; x=1753539867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sF+xvVmHZPhTzNR1UoHcqNUN0jk8rLNsh8L6Q+kGkzw=;
        b=G8FFNjqM1xIAk9h5Bt1ay420bU+c+hUmW9erViA7/DzgZ89BNJeNy+t4cIlUDO85HO
         jlDz+EZhCu5SEhHyeGQlI3g7DTMuteWA85ZbWhUXX8mgju39WSdrvsHIv3oWwxpyH7VT
         zM5C58aul7P8sbYVtZbAfLi33bzqpQ9SlgdKBf1yZhkejUZkDYupc4lJFBZ3uCPG2cZJ
         JLev2lzZnnt2musWJwiHwt4KYNIBSkOE9EL+ODn9CAQKt8GxmkRK5vY6UK4JljH/FYyK
         pyEkdWo4Q71B0g1A9QhVMHJqUCtOa4hVP1oBManqVnVuEELEi5bcdZQ38hPaUZhgpGN+
         VXXw==
X-Gm-Message-State: AOJu0YwlbpZeFzwCD6pjdX5Jz8Qrna9bD1Ko4HtIkOI1ranE5ow0M4Rr
	WLEJhMhUxq+8pG3Dutr2xSuztmwh+VKc1AGKRMajFHlbF1RjUB6bOhzGeEsGk8so
X-Gm-Gg: ASbGncsKPZHSTI8nHQIKabdpbRTjLPd2j+ly1Du+6WVV8VQmaqjLfBHEk/KmDmkon+9
	ZLSFLVJIcgGbnMthzXBN0eshRiXArHGzkI93zF8IJNo3bCoD7kSfkooS5GCXzmcMZBPU72TsY9J
	BkGwO9AUrlHtTD79r5uNxKvuR/N/bq8KXBo7hYJXUZ0E0gc2kzgvh52ZAXseHeWsaW6x0OCmqKW
	vpU5RhM5Q7U90xkb4C2STcQHq8KXFD4PKK5njvI4MX4NCq8pW3qJHak7puqiDiAJsietNGnyHIZ
	5ATHphXBP2wPfP8YwYQbTot4hNkcXPOLZ1wuFhbdDkST66VGHh8AZzj2eK1/54FNzUHT0X9xlXI
	PEey+O7UHom4wtn8xq33tL3w+WRZ9ubTm556nGikL+7ad3MVR0BoL0ulrs6nabeK1jBo8DwJOks
	PawbUNLVfKo4s8fQcanex9
X-Google-Smtp-Source: AGHT+IFLAekQOO19a2lFRLKqYBpnFWYjahuEuIIW/wlq+GTuPNJMeQDwUZLjCfyHl+BrSOvwGCiLuw==
X-Received: by 2002:a5d:6f0e:0:b0:3a6:d92d:9f7c with SMTP id ffacd0b85a97d-3b60e4c5212mr12847153f8f.9.1752935066515;
        Sat, 19 Jul 2025 07:24:26 -0700 (PDT)
Received: from Tunnel (2a01cb089436c000eab97b50918e1e74.ipv6.abo.wanadoo.fr. [2a01:cb08:9436:c000:eab9:7b50:918e:1e74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48cb9sm4961884f8f.45.2025.07.19.07.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 07:24:25 -0700 (PDT)
Date: Sat, 19 Jul 2025 16:24:24 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next 4/4] selftests/bpf: Test invariants on JSLT crossing
 sign
Message-ID: <e5cc3f2135707d463997e3ecc02f8a70c248223f.1752934170.git.paul.chaignon@gmail.com>
References: <cover.1752934170.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752934170.git.paul.chaignon@gmail.com>

The improvement of the u64/s64 range refinement fixed the invariant
violation that was happening on this test for BPF_JSLT when crossing the
sign boundary.

After this patch, we have one test remaining with a known invariant
violation. It's the same test as fixed here but for 32 bits ranges.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_bounds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index d104d43ff911..ddf36d8ab07a 100644
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


