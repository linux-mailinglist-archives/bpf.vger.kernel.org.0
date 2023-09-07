Return-Path: <bpf+bounces-9385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 750B6796EBC
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 04:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26EDC280F2D
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 02:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B79A47;
	Thu,  7 Sep 2023 02:00:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A974A29
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 02:00:05 +0000 (UTC)
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65BD19BA;
	Wed,  6 Sep 2023 18:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1694051989;
	bh=nq+60wHAJ2wJHOUYum8hucxDGb9mfXG5LmjcPS0ZQiw=;
	h=From:To:Cc:Subject:Date;
	b=pAq9/bzyWDpnDk5lchNWWr75HUzuiAv36CUwIpsfsiFTFLfJpLAjQv0t/+feAf69V
	 +onwmVAeXDaTv5x12L5N6cbz1P71SMk2ZB9wG3xAq+jQefyPG8Kfd6HJePcjmFZFh5
	 OOIzG5Iq/5MZ+GKMW8VVqKJFiqfNDYAWjlUrQSfw=
Received: from RT-NUC.. ([39.156.73.12])
	by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
	id EEB27808; Thu, 07 Sep 2023 09:59:43 +0800
X-QQ-mid: xmsmtpt1694051983tn9019r1q
Message-ID: <tencent_FA47B711AB0DEC843EB3362E6355505ED509@qq.com>
X-QQ-XMAILINFO: NSObNE1Kae7Zzzod1N7QKTYip8Xoa7hH7x1+fzHTul/lt2xBwVTotcqQC+/02Y
	 yQbCRw9vKFLyVqahY6Dq/PhRZaSZxQVOvhKhPU+acOJJJEudhyI6upQWh6Nlq3fk1OKDSY7lfgLR
	 6fO9c8NlcGNNiSn8bO8BzcUBd5LnnPxE/ilNYNInTlHXpH2F4ClZbHjLrl7qpVrO4Uc84H8RblEs
	 fIBh2K97YaAOYHlloU+abUBhbuLRZl2CYQmGjRH+l7ffz8X1OsgGAo5xnSJYrsfx3Js33xNrV2GH
	 IdB65Z0OiAZl4mNOnuiO707r6nJVanfR0sV4/eanf73KVsDZF1ffQfuWA3M0EgqoVZdBOqg9QA4t
	 gxZv7Gx4IzpURCxZKRx8Bqv3rQBBoCMtGtFHjLht2Pcbuhxon4vTp7kHCXiM7V3TCkqpZaMVVw/w
	 O1otMUlk3pZFkaJ7DveudMBsS/PWpN7ITVaWopYrvveyRSwQLyLXlNicxM8ik4IS64nN76p5obPi
	 h6z2a75Rzb1zToUFJOLVi5yZMgZjjMTDvOlUbvR5Ayp99MbI209gjeAdN1ra+N1iHhijxVZNyWDj
	 R3omh2juneK3We6XP5gSYEHROkvzvgqPYrNNS5vzEBV80kD7W75ukR/a+LWaYwaKAmwcW2QwcczG
	 WJTbFr34c2zFFAi24//INCErAn7hfZhpY/tODV6Z3eROD2JA7X9XplLMOPi1Sbz9LEY70Mu0/sqd
	 k1Q1JalGo1N6z7dK576Awtn4Ui/VWwznsD3LSSM3LrXtwueRNfF2VeTN5gIgE4d1fKTT98ty0ME7
	 I8sRrSrtvQPTrk0lLQTfK5IW6LOXhgCEQk6K4JL78yzPAKrq7sbWzpwW7h04/UvRSmMqwlAHZGYf
	 6JIwsTbrtbPlSaqhuoUnpyQTjY/hOVgXrWHJb20LHCZu1KEnnhgAspm7BkG3hXzBzNuBawy6c5L2
	 grIQVzeQeH4zO5MJW4na7hRkE8Sr/Vvl+Skdgta64=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Rong Tao <rtoax@foxmail.com>
To: olsajiri@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net
Cc: Rong Tao <rongtao@cestc.cn>,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
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
Subject: [PATCH bpf-next v12 0/2] selftests/bpf: Optimize kallsyms cache
Date: Thu,  7 Sep 2023 09:59:12 +0800
X-OQ-MSGID: <cover.1694051654.git.rongtao@cestc.cn>
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
	HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
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
 .../selftests/bpf/prog_tests/fill_link_info.c |   2 +-
 .../prog_tests/kprobe_multi_testmod_test.c    |  20 ++-
 tools/testing/selftests/bpf/trace_helpers.c   | 134 +++++++++++++-----
 tools/testing/selftests/bpf/trace_helpers.h   |   8 +-
 5 files changed, 122 insertions(+), 46 deletions(-)

-- 
2.41.0


