Return-Path: <bpf+bounces-11111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615487B365A
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 17:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9FA73288C7E
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 15:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B1851B82;
	Fri, 29 Sep 2023 15:08:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86CBC2CF;
	Fri, 29 Sep 2023 15:07:56 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC08DD;
	Fri, 29 Sep 2023 08:07:53 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id B1E595C2612;
	Fri, 29 Sep 2023 11:07:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 29 Sep 2023 11:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lambda.lt; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to; s=fm3; t=1696000072; x=1696086472; bh=TJNNZltcRr
	dHbeEysw25mplXXfRGFR5K2gvnhfLJL5Q=; b=YE/oGEqe98dywCt7Uii/8PvfdW
	wzej5IXol8TMwPuJgts95W82QevbTYOAqemslt3mESJpSdEDTeFIUdlxZovOhoQe
	to9Wqwc3VTh4zm8a0Sg+r9uAaSl5aWmDTRhwKiN4rSpSumBLdgYKppPV4FKbSqYP
	7jA2FURdeQdfRQDFgb9X1jk/bHNvB63mlzzvUmE0Rla3vwsid1Yws79g6vNMcuyC
	lnqWzrLWso8QLeKmEvVyU5oXGOP7knVsg0tSDOCoFwrJicc2U6Ar/Zx6LmjrrdR6
	DjSUUwW3TyGkmnwqszdJGY4fIIUmwh9wZmu6jJUhBZk1uc1TMkXfkaKDlUkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1696000072; x=1696086472; bh=TJNNZltcRrdHb
	eEysw25mplXXfRGFR5K2gvnhfLJL5Q=; b=FdDy5Le01eInwc+cyYagxKnq48i3G
	ybPv01ZwaTQwn61sUPc+yvg1q0IgHS84+RzgK2gcUyjAE+O3CDoJs/iqd4ESPsJQ
	iGupM0/x26tDINaK+9RvPWrXgKw0LyZ500nZ1PfRgNX9wCXNwjpqF4jZ0f0DRQWf
	ZvNTs5M6gZ9ZGaG/ChvGeqJNyhDdTn8nOrts8GhHEa8oQrnZykX63D2TsalRmLbZ
	qngJa4bARN6qDl671jTG4fRuQuY8/y2Qllq43OBAs12fa0+dph9wld55DogqLxfS
	zRsnCZyHpO2A5af+EsQmWEE/9Bg5paG/SYKUHiFlPNCf71k5LgMMOuOtA==
X-ME-Sender: <xms:R-gWZYycIUSdTDKG-db7geCjLZPU-59K-iZm_mg4-4xlEwr0G-OuRQ>
    <xme:R-gWZcSL-zX6NC_rAlfktm9wj-Lh8JXfQm4gSXekozEbFWGQiYi6RJyDMA2q4PhE3
    fh4Uf5lWf8fSkam1tw>
X-ME-Received: <xmr:R-gWZaXyvMMN9WhETXdVOcB0Ws3A24G0UQd9sSOPbKFXT78FELcocCK-tVSEa4yKZTrcsnZOLbfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrtddvgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeforghrthihnhgr
    shcurfhumhhpuhhtihhsuceomheslhgrmhgsuggrrdhltheqnecuggftrfgrthhtvghrnh
    epveeggeegudefvedvteejieeftddutefgveetheffgfekhfeltedvjeeuudetleeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmheslhgrmh
    gsuggrrdhlth
X-ME-Proxy: <xmx:R-gWZWj6ciTC9l2L5xCPbllzWi_3IBnKWI_SqawNKC5jDPQ9QdvQiQ>
    <xmx:R-gWZaDSERYC4WpYqbc-Atj_0OsvCx1D-zuZlmNyh70c6p4zp__FBQ>
    <xmx:R-gWZXIKOdWrXPSBepz6MoYrP-Yx9gV7O93jbreBv57UpS9PbS0H6g>
    <xmx:SOgWZd_wagDuxlFFvBcl1HAPER4QKm4fUjKYsHoS2qhRQcFGGvFfEQ>
Feedback-ID: i215944fb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Sep 2023 11:07:50 -0400 (EDT)
From: Martynas Pumputis <m@lambda.lt>
To: bpf@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Martynas Pumputis <m@lambda.lt>
Subject: [PATCH bpf 0/2] bpf: Derive source IP addr via bpf_*_fib_lookup()
Date: Fri, 29 Sep 2023 17:07:15 +0200
Message-ID: <20230929150717.120463-1-m@lambda.lt>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The patchset fixes the limitation of bpf_*_fib_lookup() helper, which
prevents it from being used in BPF dataplanes with network interfaces
which have more than one IP addr. See the first patch for more details.
Thanks!

Martynas Pumputis (2):
  bpf: Derive source IP addr via bpf_*_fib_lookup()
  selftests/bpf: Add BPF_FIB_LOOKUP_SET_SRC tests

 include/uapi/linux/bpf.h                      |  9 +++
 net/core/filter.c                             | 13 +++-
 tools/include/uapi/linux/bpf.h                | 10 +++
 .../selftests/bpf/prog_tests/fib_lookup.c     | 76 +++++++++++++++++--
 4 files changed, 101 insertions(+), 7 deletions(-)

-- 
2.42.0


