Return-Path: <bpf+bounces-11247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEFA7B623C
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 09:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 97E631C20A1F
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 07:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183F2D27D;
	Tue,  3 Oct 2023 07:10:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10692D271;
	Tue,  3 Oct 2023 07:10:46 +0000 (UTC)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9CBF2;
	Tue,  3 Oct 2023 00:10:43 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 672F05C032F;
	Tue,  3 Oct 2023 03:10:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 03 Oct 2023 03:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lambda.lt; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to; s=fm1; t=1696317042; x=1696403442; bh=TJNNZltcRr
	dHbeEysw25mplXXfRGFR5K2gvnhfLJL5Q=; b=BfXieYunjQl1t4zpUoMdQi7onz
	gxcAe/ca5yqrBWya6kVbsrXuHHH+CF5UEL9vLsjgVZKvsqpyZBYa89NWnrvJB7RW
	vZoK6FfVAKuP6H6tZ7rc3RT16OcSN4wwA9+/HT0QHbH6utCT/v/1QTOvXR44w5Ik
	t1ODQw/zJ3zovMVgPJyZU4mM7JhfiE0jN9eKKAH3+BYHPk3n3+L50o5yN7urB+Vv
	EvjmfS6/RHd29HmwcTjVHKXsmMllgdU8QTlphGlSeWyThLl+DnWh9Uz/mCjOe06L
	+GKrU5UdfEOr77iVkM/XgPWmpyDiu4OGALrzu7vaK/GMIfoHbVEPezgoczzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1696317042; x=1696403442; bh=TJNNZltcRrdHb
	eEysw25mplXXfRGFR5K2gvnhfLJL5Q=; b=E0osIfGwqAD9hr0tKURql9kWp6ByM
	SvvUfmUb7krY7GwUB/AFeOIVjaFH48b2K/RHwAtxl90ZjWONVXz6Z5lDSrt39syD
	RDm1xrAZ7BD1c5Dfmky6r9cgKnwapkIegmnun9qmdYqhgCTv/WOnjydbDOEAcSP0
	BgpQC60Ir8gnHR7cw4ZHd/woOE+e9N27rmG+PUveCM4x3I8NbD+XdELddBP/wi6+
	AHuRaGVVNkY3r9yk8fdkw3eHcsFc4m+XossrCCpHClF+nJe+IhVv0uTGI93jAfuj
	eR53pjAiJWKBxTgLwYiYxO2ibJS021kGSvKrN0cB6cve+lJ/XHf/62JHw==
X-ME-Sender: <xms:cb4bZVH04HPWWMkRPLhGlma4vQhC5R3n6J7TmBBUpEQNWjkpDZ3DLA>
    <xme:cb4bZaXo6jIFMg-qf39ZIWXCR9LutWunmPPRttyLV26mwzZ1HdNKYz9zANpUFcJ9F
    pxuAr0bMbvtKdTqKBw>
X-ME-Received: <xmr:cb4bZXKkhUD_oetqVr8Gk0DaiQjGImvdxW6e9ojfwtIqLmTqiJ9rCe53EHvO3h4p9umQ-kO9GaBO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeehgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeforghrthihnhgr
    shcurfhumhhpuhhtihhsuceomheslhgrmhgsuggrrdhltheqnecuggftrfgrthhtvghrnh
    epveeggeegudefvedvteejieeftddutefgveetheffgfekhfeltedvjeeuudetleeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmheslhgrmh
    gsuggrrdhlth
X-ME-Proxy: <xmx:cb4bZbHcoEQ3Ih2LfRYLKXLu_nt65GdDUWIuc7Ho1isIeIVwUXbSlQ>
    <xmx:cb4bZbXBNOx-VJbwweOQpZY6Gd3C1X1S_yQIwua-wJnRRi-I0SXRMw>
    <xmx:cb4bZWO0QQISY-5bahI9PhmSO7vHi8OdWCVOi8LxE7Rt5Njh-7BB0w>
    <xmx:cr4bZRyJI7DwRUxewfrSm42iv_9xBXe7JVRXZZACr8c3TxgZHoW0kg>
Feedback-ID: i215944fb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Oct 2023 03:10:40 -0400 (EDT)
From: Martynas Pumputis <m@lambda.lt>
To: bpf@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Martynas Pumputis <m@lambda.lt>
Subject: [PATCH bpf v2 0/2] bpf: Fix src IP addr related limitation in bpf_*_fib_lookup()
Date: Tue,  3 Oct 2023 09:10:11 +0200
Message-ID: <20231003071013.824623-1-m@lambda.lt>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
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


