Return-Path: <bpf+bounces-6781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 795E576DE48
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 04:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 323B8281FBD
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 02:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A6346A8;
	Thu,  3 Aug 2023 02:34:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A7F20F6
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 02:34:21 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4B146A1
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 19:34:20 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RGXrt74FrztRp1;
	Thu,  3 Aug 2023 10:30:54 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 10:34:17 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 10:34:16 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <bpf@vger.kernel.org>
CC: <yonghong.song@linux.dev>, <eddyz87@gmail.com>, <quentin@isovalent.com>,
	<ast@kernel.org>, <yangyingliang@huawei.com>
Subject: [PATCH -next] bpf: change bpf_alu_sign_string and bpf_movsx_string to static
Date: Thu, 3 Aug 2023 10:31:28 +0800
Message-ID: <20230803023128.3753323-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The bpf_alu_sign_string and bpf_movsx_string introduced in commit
f835bb622299 ("bpf: Add kernel/bpftool asm support for new instructions")
are only used in disasm.c now, change them to static.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 kernel/bpf/disasm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index d7bff608f299..d99ab716d78e 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -87,12 +87,12 @@ const char *const bpf_alu_string[16] = {
 	[BPF_END >> 4]  = "endian",
 };
 
-const char *const bpf_alu_sign_string[16] = {
+static const char *const bpf_alu_sign_string[16] = {
 	[BPF_DIV >> 4]  = "s/=",
 	[BPF_MOD >> 4]  = "s%=",
 };
 
-const char *const bpf_movsx_string[4] = {
+static const char *const bpf_movsx_string[4] = {
 	[0] = "(s8)",
 	[1] = "(s16)",
 	[3] = "(s32)",
-- 
2.25.1


