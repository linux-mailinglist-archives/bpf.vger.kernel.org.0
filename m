Return-Path: <bpf+bounces-2036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF3B72705F
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 23:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED91528138A
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 21:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D903B8A7;
	Wed,  7 Jun 2023 21:13:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F6D12B79
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 21:13:41 +0000 (UTC)
Received: from grey.apple.relay.mailchannels.net (grey.apple.relay.mailchannels.net [23.83.208.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4BC173B
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 14:13:39 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id BB268140F63
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 21:04:18 +0000 (UTC)
Received: from pdx1-sub0-mail-a233.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 42BF0140A56
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 21:04:18 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1686171858; a=rsa-sha256;
	cv=none;
	b=2CsGICMfQ98mPl2njCbYZJiNsKSb5zBtk7ffh0ESRqoGkc7p1p1IJZypGp+xVUWrSgskmF
	1pYN2IADwGm9Nn26uOIrMNpTU3edDsfTH5sxaN05dgpw1PMd9EipkCvc3tL8QfU9k/gZnv
	7tcsMIjbNh0A1720Tj1JhO1NtDdFjV3+J2N43P5i0gTouFVR4Rz1kYO5U6w2qJO0iI13Ya
	8TF8ZUAebkRF3V92xiW2bMzB7q7sswP71BbL8SsQU4tfSPxIYJGdaD+C94Onf2P8uhiUqH
	6nHkbaLHG5yXI2YrYCL93Lvq0LHPV6WF6+Ab4kfA/SdGVWRy96A56Q45CzlikA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1686171858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 dkim-signature; bh=5/ao13F8CNYp1ZMCVek/NrMErWLjCVRsd7llF9n1i+4=;
	b=Pd8UFnfohFv3IdPv5HzBH1uB7swPP/1EWuuLabrQdhW7X+xtnLsnj6cRDvnlPOQ4X25rH5
	h2ZcEYPog6J5yrOCEE+fwr70PKKLlPdSPSHLTXzZc8eoA7ql1Z6DKIxQKT7N5I75rLzZv9
	/3fzGP3kURezUz0VJ/pNmIP0gu/ru1V8d0Ascy5xSAeotBmNDfTtNaj6PKLG8ElmNMjdWo
	F6FEYIHKGd7XQLHguiOx0dTcUo5B0KE5B5DBHfIWagLpgXzp/C/0LogVFL+bYbOJ5HjkWr
	IZOdXJMO/WhShMlisxTasle5+7oKKn+s43qeISYLOnv4eSnmlbxP4+ojkTzVzw==
ARC-Authentication-Results: i=1;
	rspamd-6f5cfd578c-c6h9m;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Tank-Bitter: 3ad257c15d1d3ca5_1686171858520_259977073
X-MC-Loop-Signature: 1686171858520:284595151
X-MC-Ingress-Time: 1686171858520
Received: from pdx1-sub0-mail-a233.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.127.59.22 (trex/6.8.1);
	Wed, 07 Jun 2023 21:04:18 +0000
Received: from kmjvbox (c-73-93-64-36.hsd1.ca.comcast.net [73.93.64.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a233.dreamhost.com (Postfix) with ESMTPSA id 4Qc0Fs1d8kzvW
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 14:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1686171857;
	bh=5/ao13F8CNYp1ZMCVek/NrMErWLjCVRsd7llF9n1i+4=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=Ks06xLF7GgKn/OTiw8dmTQO8nej2Brz6p1ADLhr2dsBmEKI2DmGH2E2TYoyVG362f
	 6xxKjIH2WwcZo10JQ1hxEzYhUGIXIcK3Dp6Nl+m4Alm0omgGG4c49q22t1Obk0kDx6
	 B6Mik2b4H+v8QyYk1XKNohlCXlCbPSxsXri5V0PY=
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e005f
	by kmjvbox (DragonFly Mail Agent v0.12);
	Wed, 07 Jun 2023 14:04:16 -0700
Date: Wed, 7 Jun 2023 14:04:16 -0700
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
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH bpf v2 0/2] bpf: fix NULL dereference during extable search
Message-ID: <cover.1686166633.git.kjlx@templeofstupid.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,
Enclosed are a pair of patches for an oops that can occur if an exception is
generated while a bpf subprogram is running.  One of the bpf_prog_aux entries
for the subprograms are missing an extable.  This can lead to an exception that
would otherwise be handled turning into a NULL pointer bug.

The bulk of the change here is simply adding a pair of programs for the
selftest.  The proposed fix in this iteration is a 1-line change.

These changes were tested via the verifier and progs selftests and no
regressions were observed.

Changes from v1:

- Add a selftest (Feedback From Alexei Starovoitov)
- Move to a 1-line verifier change instead of searching multiple extables

Krister Johansen (2):
  Add a selftest for subprogram extables
  bpf: ensure main program has an extable

 kernel/bpf/verifier.c                         |  1 +
 .../bpf/prog_tests/subprogs_extable.c         | 35 +++++++++
 .../bpf/progs/test_subprogs_extable.c         | 71 +++++++++++++++++++
 3 files changed, 107 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_subprogs_extable.c

-- 
2.25.1


