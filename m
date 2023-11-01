Return-Path: <bpf+bounces-13847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2637DE7D8
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 22:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ED971C20E35
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 21:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC48D1BDDD;
	Wed,  1 Nov 2023 21:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="pDAgC1L3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vGFIV5Se"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A8515E83
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 21:59:09 +0000 (UTC)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B04F139;
	Wed,  1 Nov 2023 14:59:00 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id C83773200A06;
	Wed,  1 Nov 2023 17:58:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 01 Nov 2023 17:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1698875938; x=
	1698962338; bh=KK2MSw+ePMRXTZH/SbfDOSqSIdpqVExAhBHLCe+DNog=; b=p
	DAgC1L3836BlhtLQ49NyWQ+xJShuybBQ7p+n+FS21GYJhH3f+dI3f4MSSA7HNm4T
	yT8VGaYjiTSORJMRABLFi0/E+zuD8fyxVEyuA9nJIPBKFSxydSFKlB/VF4YSdT4m
	Vj+FyVPQuLKwCckqT3btm5KfgFCHzKuwhkJqy5sfrwVO2cUTsMqM6t2dfcoykB6r
	pph3/sdcM/nOUwVzZGIByIK2VWz0lQvCuttUakqpqcvjoQS6nO3VbHxmmWxCr9GW
	E/7FH4hThH8VwSPGeSmzv3ZcD0PiiZjo5KQkLrskCld1RzuHBYY8mXUc0L+z/LxY
	d6+KObZJlNapQi8G3eZMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698875938; x=
	1698962338; bh=KK2MSw+ePMRXTZH/SbfDOSqSIdpqVExAhBHLCe+DNog=; b=v
	GFIV5SeOc3k6inxUYPJJ00tbyKmDypjYzC4TRLecv7gdUkUYx9WAXGRDy77gOVM+
	1xCJw6YREQD8O/qTxkhwns8Dn7FtBT707X6cR3+/lfRCJclWBGUMr4QklbfJvzwg
	AhIl2R77V1ECcGfqBGG+3q1HDwswd8Le9SFxbf8fe9GlaJuGFgQswwo5EPNoCMCu
	se4FKziEYkqKMpnme2jgpGS1Wky3SSUkU46X9blYpsxkTRYfOciBvaq5fG0xhPWd
	xTltTsC0e9ugXvvkNScZuwPAtRIMLcExAAimOAxElMrzFytL2sau69yeIEaA8t+L
	T5oACAP579HTRoLJ57Dzw==
X-ME-Sender: <xms:IspCZc9q7i_NdSiPIq-dsg6tiUSpwJGWQX8rFsToSUJrPS5SqiXfBA>
    <xme:IspCZUuQQ91qAX8xU5z0e9OGC1Edi1nPYTOiA4tVTZSdIf3zg4ocUQ8OGmCcKUZkH
    1EAYNZNBNjsulGSzg>
X-ME-Received: <xmr:IspCZSAq7O_6_s6PPzqU8pScfxvQlz_sFdhqJYCdsNfAqwor-NEtYg8Ys8hXPDOQLz6kxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgedgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:IspCZccbyi8I1VeL-nsJrjD8My3i2f3hbeYWwIyUHifgrmEoc_ZtWA>
    <xmx:IspCZRNiuldN7IL9Hbe85IuG_GXgjNDELtdOXj_if2ooqpiRl_YSsQ>
    <xmx:IspCZWlw4zLMCXcv94uSzEnt0r8TU3MC-J1Kskox63GRRjfVWPrQoQ>
    <xmx:IspCZSyXt9e1qno4s6VNp5-gBym47Bp-m43NL99dS2UB4ikHMjfe0Q>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Nov 2023 17:58:56 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: daniel@iogearbox.net,
	shuah@kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	steffen.klassert@secunet.com,
	antony.antony@secunet.com
Cc: mykolal@fb.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devel@linux-ipsec.org
Subject: [RFCv2 bpf-next 6/7] bpf: selftests: test_tunnel: Disable CO-RE relocations
Date: Wed,  1 Nov 2023 14:57:50 -0700
Message-ID: <8f31cf3c28b1e69d872e51614dce548a12a54b94.1698875025.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1698875025.git.dxu@dxuuu.xyz>
References: <cover.1698875025.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switching to vmlinux.h definitions seems to make the verifier very
unhappy with bitfield accesses. The error is:

    ; md.u.md2.dir = direction;
    33: (69) r1 = *(u16 *)(r2 +11)
    misaligned stack access off (0x0; 0x0)+-64+11 size 2

It looks like disabling CO-RE relocations seem to make the error go
away.

Co-developed-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/progs/test_tunnel_kern.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
index 3065a716544d..ec7e04e012ae 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -6,6 +6,7 @@
  * modify it under the terms of version 2 of the GNU General Public
  * License as published by the Free Software Foundation.
  */
+#define BPF_NO_PRESERVE_ACCESS_INDEX
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
-- 
2.42.0


