Return-Path: <bpf+bounces-2270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 443D172A56E
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 23:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F09A1281A69
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 21:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7134F23409;
	Fri,  9 Jun 2023 21:38:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44843408E0
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 21:38:29 +0000 (UTC)
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0915CF
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 14:38:27 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 0B3A4421CB
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 21:38:27 +0000 (UTC)
Received: from pdx1-sub0-mail-a291.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 9FEE142477
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 21:38:26 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1686346706; a=rsa-sha256;
	cv=none;
	b=EFFBxSTRZ+oPBiHTRaXG2UYwNSJLRnog0yUTQiu35yPXnN1FDlW2P5quTom/o+vSOhgw7C
	LHMj+uPs8qa9SI279NV0Zlm4TEMCoawOoXVw3J+YHkAdmOiYUOaKn3gUXeCT8cTUG7zy0+
	jjgEctrgf7ZoyubEaSMgZF23FJegnVN3uqjKvdzibGLd6ogJes6qHcYLffD1Hm98JdfLb4
	BCJuGUCyE2pRFfasM2Whw5pWALoovmTKahbC3EaVXm1Lc6PxY/SqA7jC1ggAda3H3NaiBs
	XMspWnvCLhastqUkdZ4T3a/R2QoZ/7dAA0SHIZVr3sHJHzp5rXI1A86Xnecu1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1686346706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 dkim-signature; bh=hfp8+qdPxPXYNum6peL8A5iWGjltwxBPJ7qhqGCpSWI=;
	b=d1qtEoYxWQ0W59LRDmX9jhlSX67U0CqQ66RYFHrzbL+786DhKZLH+XhNKdXNkLCpDeNR+R
	FtkDKrX0J/SCXfx1EUOnA5kTH+szgO6hhd8yZJCkJvLb2KC2VEMpyjDmv/e2hwHZEjkb+W
	2dFJn5MuUt6vmo5Wsigysak6VDg9VUjqxzw/7SU5n35P7QPzBy4LgRAaO8QX1/ZpFaVlHl
	bwZOXUbNifrZU+EhLsWbhB1zgowf2iDrY97px+jLx9u8i8yUeIlekW+5bskjVZcu3Q6a/E
	2NTFXp40SIU9rKyludCxEXuU3QqHWR29/sRW2dsFjKrlp6TFiJrVALaej7dA/w==
ARC-Authentication-Results: i=1;
	rspamd-7c78575475-9f5qk;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Hook-Blushing: 6d1eedf71e942ca8_1686346706874_3896804438
X-MC-Loop-Signature: 1686346706874:2243973940
X-MC-Ingress-Time: 1686346706874
Received: from pdx1-sub0-mail-a291.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.48.103 (trex/6.8.1);
	Fri, 09 Jun 2023 21:38:26 +0000
Received: from kmjvbox (c-73-93-64-36.hsd1.ca.comcast.net [73.93.64.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a291.dreamhost.com (Postfix) with ESMTPSA id 4QdDwL3B8Jz71
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 14:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1686346706;
	bh=hfp8+qdPxPXYNum6peL8A5iWGjltwxBPJ7qhqGCpSWI=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=RHKXM+CvKcDBPT3gPCAWB5AfadQASGmY/AtfQhSpAPGoiE3VPfAz1lQnarU4Geo3F
	 L20hXgbbjeWiDrfhOGmnIRH062nY3uafl3cL241qF2lSebn8FbMHMxRQQ9BiPGxOqx
	 ydgjoQUwSGPxWsDSUiI8r42gFvY6H3gUbygeLA68=
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e00d9
	by kmjvbox (DragonFly Mail Agent v0.12);
	Fri, 09 Jun 2023 14:38:25 -0700
Date: Fri, 9 Jun 2023 14:38:25 -0700
From: Krister Johansen <kjlx@templeofstupid.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v4 0/2] bpf: fix NULL dereference during extable search
Message-ID: <cover.1686345886.git.kjlx@templeofstupid.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,
Enclosed are a pair of patches for an oops that can occur if an exception is
generated while a bpf subprogram is running.  One of the bpf_prog_aux entries
for the subprograms are missing an extable.  This can lead to an exception that
would otherwise be handled turning into a NULL pointer bug.

These changes were tested via the verifier and progs selftests and no
regressions were observed.

Changes from v3:
- Selftest style fixups (Feedback from Yonghong Song)
- Selftest needs to assert that test bpf program executed (Feedback from
  Yonghong Song)
- Selftest should combine open and load using open_and_load (Feedback from
  Yonghong Song)

Changes from v2:
- Insert only the main program's kallsyms (Feedback from Yonghong Song and
  Alexei Starovoitov)
- Selftest should use ASSERT instead of CHECK (Feedback from Yonghong Song)
- Selftest needs some cleanup (Feedback from Yonghong Song)
- Switch patch order (Feedback from Alexei Starovoitov)

Changes from v1:
- Add a selftest (Feedback From Alexei Starovoitov)
- Move to a 1-line verifier change instead of searching multiple extables

Krister Johansen (2):
  bpf: ensure main program has an extable
  selftests/bpf: add a test for subprogram extables

 kernel/bpf/verifier.c                         |  6 ++-
 .../bpf/prog_tests/subprogs_extable.c         | 29 +++++++++++
 .../bpf/progs/test_subprogs_extable.c         | 51 +++++++++++++++++++
 3 files changed, 84 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_subprogs_extable.c

-- 
2.25.1


