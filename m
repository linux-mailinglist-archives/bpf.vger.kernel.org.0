Return-Path: <bpf+bounces-10611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 548D57AA76E
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 05:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 0461B1F21D50
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 03:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FC110F5;
	Fri, 22 Sep 2023 03:49:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C45EEB8
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 03:49:02 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5178CE8;
	Thu, 21 Sep 2023 20:49:00 -0700 (PDT)
Received: from dggpeml500010.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RsJ6x5CgPztSxV;
	Fri, 22 Sep 2023 11:44:41 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 22 Sep
 2023 11:48:57 +0800
From: Xin Liu <liuxin350@huawei.com>
To: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <yanan@huawei.com>,
	<wuchangye@huawei.com>, <xiesongyang@huawei.com>, <kongweibin2@huawei.com>,
	<liuxin350@huawei.com>, <tianmuyang@huawei.com>
Subject: The kernel fails to load the ko file because the btf information in the ko file is inconsistent.
Date: Fri, 22 Sep 2023 11:47:36 +0800
Message-ID: <20230922034736.970236-1-liuxin350@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500010.china.huawei.com (7.185.36.155)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi all:

We've had a confusing problem recently. The kfunc is used in the ko and
kfunc is registered when the ko is loaded. Even if the code is not
modified, the ko compiled at different times cannot register kfunc
success on the kernel. It seems that the inconsistency of btf id causes
this problem.

Is there any way we can solve this problem at the moment?

