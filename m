Return-Path: <bpf+bounces-9163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F78790F71
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 03:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 255B51C203A0
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 01:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD5B385;
	Mon,  4 Sep 2023 01:01:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F08381
	for <bpf@vger.kernel.org>; Mon,  4 Sep 2023 01:01:57 +0000 (UTC)
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977E7C6;
	Sun,  3 Sep 2023 18:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1693789312;
	bh=TB5AzkK7BN11nl5AAqPvegLlqHhbbgXPppq8dVRYyGk=;
	h=From:To:Cc:Subject:Date;
	b=H/frfDkLoDJ22Ssoz/+NRxF4uUDmRvT6dmbMOYOtDAs3kKJ4HMAbJV7+KcdD7Osc3
	 6QW+WFFS6/bjimFIPN3zlpULOZUPtACQ1vyW0ZOT9xq3skU+blHKHeIV4QnX+fK0FL
	 gbJ2J6Y/1RifMMk0uoetX23BAahF/Z3JvYL2FuQ8=
Received: from RT-NUC.. ([39.156.73.12])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 6E8B05F; Mon, 04 Sep 2023 09:01:46 +0800
X-QQ-mid: xmsmtpt1693789306t6uqnk9ls
Message-ID: <tencent_8898BD228E12207A1A1408E167C15C86AB0A@qq.com>
X-QQ-XMAILINFO: OZsapEVPoiO6QpYiUEonvb5tVEG3ziOcQU89e5g17iOLxmlH/jeJMynwsFCWL5
	 +QX7n8L4bIZHqCdtCxK3KPd024ZwMQB7fI8Gmd+f3VRNSab2yi59MvAij/GnwQ9tvVAc5eHLSZxi
	 gAGbTmi9p8OIbDTgTBWMZ4vX1gRT4UDe+IfUzzLWizarcHfsHVOnhlicgfmBAPgdO25ZzRquq4xJ
	 hpTscWhQT16Qa5bnu107g6ozuN/GfYz37ld8M1CmCssaEiLuSyW0grFat2FbPCimccF5BNujElKa
	 /kqBqYrRBBLbEfX5LMDTst0LIzvGLdAYVwblxP7BXAbNRvT0vwQMXaARYnW+VeuwlSZF3c52MCkq
	 08Yg5OiGKQqahrcIU6nnV6X+aDTG+0gXfLzwx12ZmLZ2D7n68F9dvZ/KogPr1DjJ+mZGpxRieDpu
	 E/B1vBaM7+I5XPPKFhtGIW4RbHOqxknUQablIRW48LQr+zmJ5UCGNL4rH2v4yx8R42cVwbsWBcZQ
	 mUA6/WeASZl1qVj0Px7Foq/uS+PTdIAqLTsKUyFsAVYpT9DCmHdOz4HzL/cag36mVepRH8K/P4d7
	 CLs+KET//xzq2F4AcY9FQ+QMrbBakpx0h2vQFLWhB/K9om0dyxRaFnLS/+TZgl5uUZsCCQWcoHjL
	 eWwT/N23Z9LuOfWApXWPt64DNVMGdbVhD/wAFcbyyEI/ySYXs9UOfMKzDqd7b53wvtpbA8fn7MME
	 EejKAxI/DY1NXBbJV/PpdRwaKTWcuEFZE26NlJ4iRnMOg9aPri4E2GUqEz+9Pw1SXTnTi4IOvleB
	 YljKS8+I/ATs1dLH9eNugFpDB/sknp3Tex1zVsSXUPbxgLxeWClJsv22YtYujqwOoLMnWqyokc5T
	 jjr60J0D155quUhPUvCR6VQuHhj+Y9cWtgX/5fmqERFNebqm9jQxhA9kKQssfM8hgunelZ2IWSS+
	 CxOyqi0cWymQxNcRSj/msou3f39u7uZwXgselfXIo=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Rong Tao <rtoax@foxmail.com>
To: olsajiri@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	sdf@google.com
Cc: Rong Tao <rongtao@cestc.cn>,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32 ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32 ARCHITECTURE)
Subject: [PATCH bpf-next v10 0/2] selftests/bpf: Optimize kallsyms cache
Date: Mon,  4 Sep 2023 09:01:19 +0800
X-OQ-MSGID: <cover.1693788910.git.rongtao@cestc.cn>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Rong Tao <rongtao@cestc.cn>

We need to optimize the kallsyms cache, including optimizations for the
number of symbols limit, and, some test cases add new kernel symbols
(such as testmods) and we need to refresh kallsyms (reload or refresh).

Rong Tao (2):
  selftests/bpf: trace_helpers.c: optimize kallsyms cache
  selftests/bpf: trace_helpers.c: Add a global ksyms initialization
    mutex

 samples/bpf/Makefile                          |   4 +
 .../selftests/bpf/prog_tests/fill_link_info.c |   9 +-
 .../prog_tests/kprobe_multi_testmod_test.c    |  24 ++-
 tools/testing/selftests/bpf/trace_helpers.c   | 141 +++++++++++++-----
 tools/testing/selftests/bpf/trace_helpers.h   |  10 +-
 5 files changed, 141 insertions(+), 47 deletions(-)

-- 
2.41.0


