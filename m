Return-Path: <bpf+bounces-9249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 912A3792345
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 16:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780641C209CE
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 14:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124F7D52C;
	Tue,  5 Sep 2023 14:04:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE926D529
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 14:04:57 +0000 (UTC)
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4BC1A7;
	Tue,  5 Sep 2023 07:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1693922690;
	bh=j++hW7hBYNWYYglVpF7psTQmZPPLAOIfD9k/RR4Upqo=;
	h=From:To:Cc:Subject:Date;
	b=j/IQUsC/EESb1q4AeQqU+dalDf3SFgdICLJLidLNdHH/dmA7L6uu2NoJ69b1WRI78
	 YCf1YOqU697fkBXLLMfHENx5MzIrz5rTTFGcXJy+m69qGDCB9AMvh2mUarg9xB7ZIs
	 2XAfURCSWuMxSat+50a+2rLQ9QkQG5JHLXHuuBZE=
Received: from rtoax.lan ([120.245.114.157])
	by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
	id 12C80033; Tue, 05 Sep 2023 22:04:44 +0800
X-QQ-mid: xmsmtpt1693922684t6nawmh8y
Message-ID: <tencent_F04BD6C8A5A70AD82BCCE820E2B2419CD006@qq.com>
X-QQ-XMAILINFO: N+tZcXNNUKPOwN8ITHEbltp5Kv0oYE5xRtAsesoPEBX00pQKxTUQdryVDwTyG6
	 wYKJ3XGWaTwkGxuIAbuFhCQvhBxCwznGoRZzqC3TPkj394XYog3SL7i4MRjC0gPer8KYNJRAf1tU
	 uiHLwIIq6PnJ6cyHp6wocXi1uZrKaHm96TeRVhke9KhluVkwfITTElINqGvABHZyl0qnsnCxv8JO
	 b7OI7c5sxnwMGnmumY6+TEnRcNKYwXEG6qsoc30uYDKx78kgUFORWRV9Ozuzi3dt9NAS5sZMD6DK
	 1DLFJGRZC28DbC9Vv2FD1i1eMMsehbH/zwqgk7JI4c30U6ZouPguqHtZzH6fTEUe/LS8Y2zZMVLy
	 P0yajztAvNdqelFBG/1Z8vSEOa7mQ0fqmF5UeQQTzF1r65ecIAelqKNnvO/u+EEXNouz+V/K7V7I
	 OqFaQor91AREutPIBgwzGsd2gRIKThj+YTHm57r5laQxP5SUAkSN1c65mR0mNe7GKpFlMkQtQpr0
	 +oxdgRozTckXGAhKtUuDwndd7gb7tLVYBQsuvPfneY70+0StawrgQX0iKUF42AiVZfZ+rUQJ4iTM
	 XjMeYW7rn9u2w+pk1nDMp9DyU2aF8oGZHRcgXTE5yk1wL3XzbBWdN9sZhJyOhoEhwfy2VxRTZ/jR
	 zefo+lun4sOikIPbr2IhB7gAcfKYYZE+O+er7KNuGuF4UmYzDO/VrIOte2UhDB4X3rgyOUxuH+20
	 I6DvITNEriHaOrtXkfqJDsTKLyZu3XYZFOQJmohCVCrz9MkwgrXbxJfRmh14iAcKnOVL/3R4P3qr
	 fwK7t3YqYbUKd900F6VAuyG4zKQLyBQSKsb8QMH55++/zu9IiSWDK6OGrFdjgwh8xJHDKZwU1f2M
	 VJU/mYok5RxTEqp1yUbmEAwQTW7pmf5r/RXT30eQEcCNBpDS4hdLqsiRBjSE/60GnPN7o7od5qSU
	 IQ+y7StIzTGMIRZEItsyLq65RZqSIu35JcLgT2tZ4oEc+vE9AFc7Mebs5asUE5
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
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
Subject: [PATCH bpf-next v11 0/2] selftests/bpf: Optimize kallsyms cache
Date: Tue,  5 Sep 2023 22:04:17 +0800
X-OQ-MSGID: <cover.1693922135.git.rongtao@cestc.cn>
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
 .../selftests/bpf/prog_tests/fill_link_info.c |   2 +-
 .../prog_tests/kprobe_multi_testmod_test.c    |  20 ++-
 tools/testing/selftests/bpf/trace_helpers.c   | 136 +++++++++++++-----
 tools/testing/selftests/bpf/trace_helpers.h   |   9 +-
 5 files changed, 126 insertions(+), 45 deletions(-)

-- 
2.41.0


