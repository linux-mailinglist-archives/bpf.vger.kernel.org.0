Return-Path: <bpf+bounces-1230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD935710E78
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 16:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63AB6280DC5
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 14:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B21156CE;
	Thu, 25 May 2023 14:38:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A152BE62
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 14:38:40 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00F4101;
	Thu, 25 May 2023 07:38:37 -0700 (PDT)
Received: from dggpeml500001.china.huawei.com (unknown [172.30.72.57])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QRrCY2B65z18Lj2;
	Thu, 25 May 2023 22:34:01 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500001.china.huawei.com
 (7.185.36.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 25 May
 2023 22:38:31 +0800
From: kongweibin <kongweibin2@huawei.com>
To: <daniel@iogearbox.net>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <hsinweih@uci.edu>,
	<jakub@cloudflare.com>, <john.fastabend@gmail.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <liuxin350@huawei.com>, <yanan@huawei.com>,
	<wuchangye@huawei.com>, <xiesongyang@huawei.com>, <kongweibin2@huawei.com>,
	<zhangmingyi5@huawei.com>
Subject: [bpf?] [net?] Questions about the impact of ebpf sockmap/redirection on socket performance improvement
Date: Thu, 25 May 2023 22:38:14 +0800
Message-ID: <20230525143814.361127-1-kongweibin2@huawei.com>
X-Mailer: git-send-email 2.23.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500001.china.huawei.com (7.185.36.227)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I'm using ebpf sockmap/redirection to bypass the TCP/IP stack to improve
socket communication performance (throughput, latency) between different
PODs on the same machine. As concurrent connections or payloads increase,
there may be unconspicuous performance improvement or even performance
degradation compared to the TCP/IP stack. I have retrieved some performance
data, but it does not seem to involve high concurrency and high payloads,
I would like to know if community have conducted relevant tests on these
scenarios and have any opinions on the poor performance improvement in these
scenarios.

