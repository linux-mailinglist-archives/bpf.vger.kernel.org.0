Return-Path: <bpf+bounces-63915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A6BB0C4AE
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 15:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96EE37A9A47
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 13:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DDB2D8DA2;
	Mon, 21 Jul 2025 13:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5BrADtD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF91B2D7805
	for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753102934; cv=none; b=L5kdqtttuMEupEGlF2xAmdLUhgAxgFmyN3zKv8I5DiXk55YhISLnOS8+Pn63a8CXRtvhO7uG4OXa0EO+M2euXh2EKolAU/EgGB9dvimezAeeKRL08JJzeu+rpKby2k+2HI2isxdirhCffW/5FzxFV5j5SGCIpXqiK7U5vOklGpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753102934; c=relaxed/simple;
	bh=Fg1v8wdC9+2t5SKqqKz2aK7kP63jDTShaZZn6+/i79c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECLcn9jWWuqAEmuMrmsNsfq/hvSuClcJOLMdncUoYqzn2WO4CvBLfgYQlEgtg6uDtUCDL9WZUCpRn/fuqYiHh2k8CJi8Tcesj65kFM8txXOV165rgAK9uIckeCUvLn5OzokmkfZQaY12QNg5Dx0rMOw61K9QOym6sF07pO9/QNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5BrADtD; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a50956e5d3so3238690f8f.1
        for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 06:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753102931; x=1753707731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mgRiJK8k0fgyXFvxK0EjPIiisb1JJxvC/hpj33S990g=;
        b=j5BrADtD+alMmqQ8TePIlT/KmF5P5khVWUTFBujqzfGc/zs4wRT2K54VPISzbSq/gn
         hTG7oLpNucnkSwCz4VTY37XzTT+4Qe7fp9tdIChC/2z5IaYdJhObqTWEnWiIxf3N/VS5
         QSZXmi+M+UMJd1FsByRDikY3IVahtLpXHwg6J1amP+cAi0Eny15ljMhIB5CIPI0EkkJu
         rceGto7vjujjvy5jRywHMbrUYZaA0rSg7+RfnxRqbKHfHk3YINCngEHTUvFHuny08bMD
         V9RmvQlhN4cH8QQJWIs/oU24Ddiu0NGgd8f29Jhy+t6SGfb3yBvEZHDxneG0JySUTp8T
         OZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753102931; x=1753707731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgRiJK8k0fgyXFvxK0EjPIiisb1JJxvC/hpj33S990g=;
        b=t51UaI0sNKo14INxUpc6erHYXLGXQ0k06+4DGlMYCpl5BlGC77FQjREK39+Xlt57BL
         Y/tKLB9p+XFzlMojxiF3UI0oZpcvor/+rO9ScX2O4jvMpmsqnU5MCxSmKU8ueFZDpT7E
         iIfzEXLHYZau7FJaGkX16CxnIlH0njYYkM0HWVLxZmXGro8Bm4Zm/SLky6cpfskSMsFn
         Pz0YHJxRQqC4BWouGuKKVZ66fTFFdGDCrCMceX+4k42jMsfrDp1Od/GdOaFeum73ybza
         nylAIpaAhQnf6oytu7ycF/1MqOfbe7a/UC1F3ZPu4xX+r/BvbOvimdZiuML2Fs40BcfL
         2m0w==
X-Gm-Message-State: AOJu0Yx+woYkRESTRA5Qyi0Mj6gXbZOLEuMw1xYPR5jpdUNjzpAw5Czb
	CtZsYh5H+ZHvQ95XBpR5uLyq7T+c9MRr5AMhxITvr2EbyLM+MkQb//NDmDlrTA==
X-Gm-Gg: ASbGnct6VgS8awcTWzPimRQsLTuWBsasrEKdf97OUDQo/AB94PL2vEfJy2fAPu542gD
	kq3nwCTZeu/CnRfNLBmHJd4vSuxL+3n2Tsia09BRyY2KoRLHXSk0+ysTkrdTMvyCIclBMl4mDgJ
	m1tQ2JtVGnDIYP/cp31CFRKP+qO6uGok41wZlcQII6C5S2aWpCKOFqNKJ2dMydIh+zj1Fxf9bc1
	mcL80MJeOrySAMaXZ4X4GhOFh/w1hI4q3YNbcrae333iF5lVXBjuz+JOHRJBHA5tfCqMPAYeXUc
	nnh6HcWOTpwj8f2B627GGK36x1mMxYareHpza/QyrUBSckO0DGxLJ3An+PV4/sp5qQ8pcCUxo/i
	a2KmD1GhHiYUET7lk38N+3gSZcKG+9mB4LOXU6oR7VKvPQBFDM70M4VyEG3gnhC1PruD9u2PKLj
	d8GSBWtG1SEA==
X-Google-Smtp-Source: AGHT+IFw9i8aiks8FHozWoB9Pg7ACEpnI++Ut69uo09FWxJzoMjKxOwQerYkLZmRCCrRUyT0ihNO6w==
X-Received: by 2002:a05:6000:21c8:b0:3a3:65b5:51d7 with SMTP id ffacd0b85a97d-3b60dd55666mr11210014f8f.26.1753102929343;
        Mon, 21 Jul 2025 06:02:09 -0700 (PDT)
Received: from Tunnel (2a01cb089436c00043594f5ece104811.ipv6.abo.wanadoo.fr. [2a01:cb08:9436:c000:4359:4f5e:ce10:4811])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4d475sm10204073f8f.65.2025.07.21.06.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 06:02:07 -0700 (PDT)
Date: Mon, 21 Jul 2025 15:02:05 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test invalid narrower ctx load
Message-ID: <3d518d4e6c90c3338eea8786291ee3102181ab57.1753099618.git.paul.chaignon@gmail.com>
References: <e900f2e8c188460284127fe1403728c10c1eb8f4.1753099618.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e900f2e8c188460284127fe1403728c10c1eb8f4.1753099618.git.paul.chaignon@gmail.com>

This patch adds two selftests to cover invalid narrower loads on the
context. These used to cause kernel warning before the previous patch.
To trigger the warning, the load had to be aligned, to read an affected
pointer field (ex., skb->sk), and not starting at the beginning of the
pointer field. The new selftests show two such loads of 1B and 4B sizes.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 .../selftests/bpf/progs/verifier_ctx.c        | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_ctx.c b/tools/testing/selftests/bpf/progs/verifier_ctx.c
index a83809a1dbbf..229f26d1d413 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ctx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ctx.c
@@ -218,4 +218,31 @@ __naked void null_check_8_null_bind(void)
 	: __clobber_all);
 }
 
+SEC("tc")
+__description("invalid narrow skb->sk load")
+__failure __msg("invalid bpf_context access")
+__naked void invalid_narrow_skb_sk_load(void)
+{
+	asm volatile ("				\
+	r0 = *(u8 *)(r1 + %[__sk_buff_sk]);	\
+	exit;					\
+"	:
+	: __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk) + 1)
+	: __clobber_all);
+}
+
+SEC("sockops")
+__description("invalid narrow skops->sk_data load")
+__failure __msg("invalid bpf_context access")
+__naked void invalid_narrow_skops_sk_data_load(void)
+{
+	asm volatile ("				\
+	r1 = *(u32 *)(r1 + %[sk_data]);		\
+	r0 = 0;					\
+	exit;					\
+"	:
+	: __imm_const(sk_data, offsetof(struct bpf_sock_ops, skb_data) + 4)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


