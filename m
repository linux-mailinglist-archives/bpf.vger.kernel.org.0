Return-Path: <bpf+bounces-2468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4D672D68D
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 02:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7DA21C20B0C
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 00:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D2E17C7;
	Tue, 13 Jun 2023 00:44:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1F6196
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 00:44:35 +0000 (UTC)
Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502D110D8
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 17:44:29 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 4A22A7E2473
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 00:44:26 +0000 (UTC)
Received: from pdx1-sub0-mail-a313.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C8BB77E23B7
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 00:44:25 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1686617065; a=rsa-sha256;
	cv=none;
	b=VCPPxSefpy//vbi98/7Hcs2PSUWn+aeeFGBU50h6DeNelEJm0XzGxK1m5lZh3gZCHmw6wN
	3B6Q+DqhcVjdSSezO6QTPRC7UIFhbSLZWjsL1lKAxG0JZRwpSK2dd/SMiUKiQw0D+eyAxB
	eTtXNQz84cy3/lUzxKnIiTd3ab9AkCVgLqoyibKNOdUNTYYoeJ3bq81euYu8Z2IhPewfi7
	1PEWJ3evcNbyaCqjZuaCSaPQL82jrQigOEOsYJKz4WP9NfU46U2vorYoZm8IJKf38zOuif
	g55CDb2kq9nBtPMo0rTFBNntPfx3VzOHCNN2SlGPvS7EhEdT8Oe/z5UX4JTiJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1686617065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 dkim-signature; bh=vmQhC6SeaPxx97c+zFJ563SLRjLwlbU/iq8B+BP3oDM=;
	b=o66KDktqdBPUqCwGb/TUP3T0by3vFEI3MLnL4l/V+XS/WSW/VVCQyak/UtHxew6Lw1MHNY
	LZhWjhnyynDKzyuj7BqqUzaJ+f7iHMiQDSpPP3jfwZXrxXfnomceDI/uNqCIxYdIwPsWe/
	rPCAuMePKir6/he0YTDATAfjg++L9eg+2QtKm7USn3F8SblAHlVAlPDd7x81Eo1RZzLkJH
	AVxScNGiNXt/yRjFOZJMSB2f7mIWFg9bZAdL/oPuvr1HT5vhrfIZqsVnGWt5bp/0cqSCvs
	69Le/FLtSxeqMxjMJWLUD4bxQ0Hklu+w10IBPc80Ul94h7UgdQDWPLiH7KH7eA==
ARC-Authentication-Results: i=1;
	rspamd-7c78575475-97xkg;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Supply-Bottle: 6a2ee4c272386bd2_1686617066061_3230371519
X-MC-Loop-Signature: 1686617066061:1001707762
X-MC-Ingress-Time: 1686617066061
Received: from pdx1-sub0-mail-a313.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.104.253.196 (trex/6.8.1);
	Tue, 13 Jun 2023 00:44:26 +0000
Received: from kmjvbox (c-73-93-64-36.hsd1.ca.comcast.net [73.93.64.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a313.dreamhost.com (Postfix) with ESMTPSA id 4Qg8vY16cFzmF
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 17:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1686617065;
	bh=vmQhC6SeaPxx97c+zFJ563SLRjLwlbU/iq8B+BP3oDM=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=bTIfQAi0v35ZalghH08IYi7gkPdgICLUA3+w/CA7XBekZmY+arRr33qiX7O85W04o
	 rpvdgcC4rWEezjTo9KM5bO2pvp2lleBKf40ZQZe8hrbaKhHlHgPWcdp8aEXc81R4Jj
	 ohGM6qvt+BAgKTpSf3/qQoMNjiFfs+6j6X8GsQKY=
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e027c
	by kmjvbox (DragonFly Mail Agent v0.12);
	Mon, 12 Jun 2023 17:44:24 -0700
Date: Mon, 12 Jun 2023 17:44:24 -0700
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
	Ilya Leoshkevich <iii@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v5 0/2] bpf: fix NULL dereference during extable search
Message-ID: <cover.1686616663.git.kjlx@templeofstupid.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
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

Changes from v4:
- Ensure that num_exentries is copied to prog->aux from func[0] (Feedback from
  Ilya Leoshkevich)

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

 kernel/bpf/verifier.c                         |  7 ++-
 .../bpf/prog_tests/subprogs_extable.c         | 29 +++++++++++
 .../bpf/progs/test_subprogs_extable.c         | 51 +++++++++++++++++++
 3 files changed, 85 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_subprogs_extable.c

-- 
2.25.1


