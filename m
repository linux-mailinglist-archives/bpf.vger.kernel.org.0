Return-Path: <bpf+bounces-9130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DD07904FF
	for <lists+bpf@lfdr.de>; Sat,  2 Sep 2023 06:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2FFB28199D
	for <lists+bpf@lfdr.de>; Sat,  2 Sep 2023 04:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED5C1864;
	Sat,  2 Sep 2023 04:41:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5264C15C1
	for <bpf@vger.kernel.org>; Sat,  2 Sep 2023 04:41:13 +0000 (UTC)
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410891702;
	Fri,  1 Sep 2023 21:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1693629668;
	bh=TB5AzkK7BN11nl5AAqPvegLlqHhbbgXPppq8dVRYyGk=;
	h=From:To:Cc:Subject:Date;
	b=nxlvie0mTV55LYVcYJ/Gmk8LRZfwJHGF6m+eeR52DrzTLIlpZGMqKOIaZyRxYYxCo
	 LyOPeDv+A7MXPQ3vRRO10B+BQgMUoM4psX7L5AEleJ6g/Uv5thOg8gs59HN/esVI43
	 FeGc84H/ykOkbW1TJohDEnuv7W2jf1BEGoQdDzuU=
Received: from rtoax.lan ([120.245.114.63])
	by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
	id A4223C8B; Sat, 02 Sep 2023 12:41:02 +0800
X-QQ-mid: xmsmtpt1693629662tcmxrwzup
Message-ID: <tencent_4F0CF08592B31A2E69546C5E174785109F09@qq.com>
X-QQ-XMAILINFO: NPwOoMPVnumVrk0WlvgQ5/KlGSuOPPLb/zmXV3pzh/F3IfZonwXumnrpV9lLkg
	 7o6VwApLYu4nGrGgJY1tEkoTBdrZhhzxqfnxMa6Emkk7yY3xHIw7Ggrwrk5sj6dMdcMwBOOoTK9l
	 luJ3Dr/NyTXk/UrqSKzyWBhWQ391LtIERaJ1eXe2Ws8Zd8VyxwR54VWfkIxjxF3lni1Q588FuvwD
	 qu4fU4Z0nSW4mKndGMXvmi9x28DkYh2Bk5OhEkcTv5IFYeug7BP4gtnP3PLqQ62U/tmfnQFCvP41
	 XLGEHnyiVz28fut8LCXOHnuBKWUQv++vB4g9RzBzSRCMwiDX5YrxMHKN7zmUajqN9VT5Cg0S5Y5h
	 Ep1zeL13fJrRRB+JyC6877ky7yuL4fHTLSMao3qC6Vh9UhiXHLb25+S8UQzhXGgYVBmorgSeZSOi
	 JTzWR8UnzVImO8kjHghviILQ0iu1kQagqsCnMlA5xWRtu+0IG2l+KU3W898/wlAN5n/2bu+uBFs3
	 lGsY8gspUVIjmsUupGqXK19A4t7LiXqTnic+iS3ISE+L6Nojm9isJ7gkienl+O9b5Di2Qb7UDsN6
	 IerJz6Qbaj80eRtVEnH1l4C3qSaW4E3xamBF8yl1BtT+NObRJMepXBAt2KbvoAKfyoL9dSviyTTt
	 hQ3Glsi1vAfydQjdhAhxOUzLbCgubquVQxzG9dVhaTgXlxvWk3bQYgGB5de1qNCRBihYKCSXUFDV
	 1qB4q9u3/gGvkJM5GUQH77lXomx/MYE80Gv4JKTQ5FeJbbP3OjU+Rm0ppf1jgwCCCh43rAxwLKCm
	 LCSRmnnil4DGk1oVk3RqAq2NT9axBFaA3FjnlV7fRcirjsWLQKCaNqdjaCRtSK5Rbuz6Dx2InhJn
	 f6tnLIVH4ZK9kaFd6hbtMguPZ1HzBsdKW1tfx+sY4aTu/jLTbIGKESCZZxoUEacjXmmmd4NL3FgA
	 ynugw/E2d48JFUlSi65uAWvgfYf/F+
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
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
Date: Sat,  2 Sep 2023 12:40:17 +0800
X-OQ-MSGID: <20230902044040.137804-1-rtoax@foxmail.com>
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


