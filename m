Return-Path: <bpf+bounces-21-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 454496F76E3
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 22:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82EC51C21680
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 20:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1BB156E1;
	Thu,  4 May 2023 19:52:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C222D156DB
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 19:52:49 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9EE23A04;
	Thu,  4 May 2023 12:52:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2D1A463855;
	Thu,  4 May 2023 19:51:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0618C433D2;
	Thu,  4 May 2023 19:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683229875;
	bh=pmOPMzuPiL8Ga03MT73efD/AV8WBuz1sppmxcNEbGV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jDpDlfaEJf5gquQzDdIzLI77J5KFQ2scCZYAUz+MuefPIX5GIWUrtJJblxzhEmeRY
	 1qSP570SE+9xYIEK2tDcFv3yLzxE5ybtv9v340cs4zvOC/oAT0Rz3Eyrw6zgzevXHB
	 Wvl6El1yNLcmJlEAXRtbPZai4mfgOcxjPbT2vNmTOE2hAD808n26/Fu8mX6sBK0lYw
	 ghcjgRMZ2vwVcZGMNMkIM3mqXT/8wwbAMXgPtCP0OQ3BwYnRMcfnVdKtODPo8MrzLY
	 UwBMkUA6sKHpyVuHWUqnegE3YuLfONat4cttOVRNtrneQlMZqlOKvHPGX171j48VKy
	 yVZshAh/M/JLg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hao Zeng <zenghao@kylinos.cn>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 14/18] samples/bpf: Fix fout leak in hbm's run_bpf_prog
Date: Thu,  4 May 2023 15:50:36 -0400
Message-Id: <20230504195042.3808716-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504195042.3808716-1-sashal@kernel.org>
References: <20230504195042.3808716-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Hao Zeng <zenghao@kylinos.cn>

[ Upstream commit 23acb14af1914010dd0aae1bbb7fab28bf518b8e ]

Fix fout being fopen'ed but then not subsequently fclose'd. In the affected
branch, fout is otherwise going out of scope.

Signed-off-by: Hao Zeng <zenghao@kylinos.cn>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20230411084349.1999628-1-zenghao@kylinos.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/bpf/hbm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/bpf/hbm.c b/samples/bpf/hbm.c
index e0fbab9bec83e..6d6d4e4ea8437 100644
--- a/samples/bpf/hbm.c
+++ b/samples/bpf/hbm.c
@@ -307,6 +307,7 @@ static int run_bpf_prog(char *prog, int cg_id)
 		fout = fopen(fname, "w");
 		fprintf(fout, "id:%d\n", cg_id);
 		fprintf(fout, "ERROR: Could not lookup queue_stats\n");
+		fclose(fout);
 	} else if (stats_flag && qstats.lastPacketTime >
 		   qstats.firstPacketTime) {
 		long long delta_us = (qstats.lastPacketTime -
-- 
2.39.2


