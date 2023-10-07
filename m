Return-Path: <bpf+bounces-11601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F28FE7BC5FE
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 10:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F369F2824C1
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 08:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F3D16415;
	Sat,  7 Oct 2023 08:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lambda.lt header.i=@lambda.lt header.b="TKLtoSLi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="anYNZJNB"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12151401F;
	Sat,  7 Oct 2023 08:14:54 +0000 (UTC)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07E5A6;
	Sat,  7 Oct 2023 01:14:50 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 0A82932009D0;
	Sat,  7 Oct 2023 04:14:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 07 Oct 2023 04:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lambda.lt; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to; s=fm1; t=1696666487; x=1696752887; bh=D6TQVNMDTi
	Nfw7saiMqjuRjHe2DYxdpdhODXSLdxamc=; b=TKLtoSLixOcq2DARxs8nqFtZ47
	xs4TIYqa+WXO7fdz+t55S7G1vLS6Pt9Hj0LaVW3Xm3fTR6zPFqwffB4eERwrrCaH
	lXSgPtiDzj2Vucynb8GjJQ4SuBGvianPFBbN1z1P8Ze/aATAwa8ky7P6ltCMgXk/
	1Gzi4Fc/WcGklGRhpgiF99M5tweqSCS/Ift4lts8Bw9QzwgFnv2W1c1c80yumUNn
	eYzt04xBqw2mDKfMMYSIeq/tUle+N1ujV/BI8sDWODou1sbq1Pen2tj0NUxmKbir
	xNUECZKft8eU6MAMUx3/+1fd+BAiqvkELbqBEQaa3Rkaz0KVqzeIYn4T7V9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1696666487; x=1696752887; bh=D6TQVNMDTiNfw
	7saiMqjuRjHe2DYxdpdhODXSLdxamc=; b=anYNZJNB5/KbeblOamg5VVXOyxpcE
	CChfjICRFaYFA1JJvDkvyeGDTUB4hzsyRYynNRDsNXhJ1ImBXFmQvT7NqwAoQ/M+
	MRlKTKkmtkCs0jrWtbeTp/V933uVoJQk4+z1i5SyvVmcL3RVFNOpvEMO/FACIgJX
	AZSb5ovrkSUsTHQh8B1EkUGLArpUD3Ud3BWqZp8gcj8Kq/ZDOWLDGIJgJhbC7G+W
	s9+k2aUsqQj1QKYU84OGX3gcg1EWUbQgF5P15S9N+llv4vzM0maNx7k2upUOqUWu
	sRGr76LIAImtOU86+JppA1qn/6R+ZtRUhWii0WXeBbYNi98RNtL3AOWeQ==
X-ME-Sender: <xms:dhMhZWk4Ke5p26F7zIRELTyISs-fWJAFIsx7z0zGyb3NuG1Ly2E3VQ>
    <xme:dhMhZd12_cbRA7mwACzLZMspAtH4ZKW3-iHcnxjLDtfhDdgGppmuMXHaqRLVAMRPE
    se5W3MvUHvxgVLomDA>
X-ME-Received: <xmr:dhMhZUqC0qNfvOUmfF7RpEUh13yYLCoViLmPw2iSeSiBiMjqWPYVsSG59LlIoYrnaeejJFYQ2dMyEB0UjrnORsFOJjbOw-W1mbUP-xc5uUYFmQ0j>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgeelgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeforghrthihnhgr
    shcurfhumhhpuhhtihhsuceomheslhgrmhgsuggrrdhltheqnecuggftrfgrthhtvghrnh
    epveeggeegudefvedvteejieeftddutefgveetheffgfekhfeltedvjeeuudetleeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmheslhgrmh
    gsuggrrdhlth
X-ME-Proxy: <xmx:dhMhZalhy240uOnfoY7ixs5W5dbz4qvhaDGd3kXOrPFLhWQ2OySOtw>
    <xmx:dhMhZU0vZrhoBjb37PZJbH2QJ0wWy6RCW7nT6SHx0FevfEdVn-ToWw>
    <xmx:dhMhZRvu4zMu5p3Iot60jSnGjAgSRsb-NXVEvqVoGacMjDo9pu4LhQ>
    <xmx:dxMhZXR_We2GPRI7dBmzyyLO4FbPbH4iRJXU_6C8aGQFU3fqV3CYEQ>
Feedback-ID: i215944fb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Oct 2023 04:14:44 -0400 (EDT)
From: Martynas Pumputis <m@lambda.lt>
To: bpf@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Martynas Pumputis <m@lambda.lt>
Subject: [PATCH bpf v3 0/2] bpf: Fix src IP addr related limitation in bpf_*_fib_lookup()
Date: Sat,  7 Oct 2023 10:14:13 +0200
Message-ID: <20231007081415.33502-1-m@lambda.lt>
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
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The patchset fixes the limitation of bpf_*_fib_lookup() helper, which
prevents it from being used in BPF dataplanes with network interfaces
which have more than one IP addr. See the first patch for more details.
Thanks!

* v2->v3: Address Martin KaFai Lau's feedback
* v1->v2: Use IPv6 stubs to fix compilation when CONFIG_IPV6=m.

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


