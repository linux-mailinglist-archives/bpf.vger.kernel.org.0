Return-Path: <bpf+bounces-70961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EBDBDC0E9
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 03:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBEFF422BDE
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 01:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553D92FCBEB;
	Wed, 15 Oct 2025 01:51:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CAD2FB998;
	Wed, 15 Oct 2025 01:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760493084; cv=none; b=cy8aj6Um7qQzYTQ9eegmCdH3AEY2X3s//cM1MkaYTWTvNxHHfhCc3PJ/MnONmFYV0dRDeLildaB0wHVBhrWZ0RmCXJge5BzUWSH16OB4S19+AbxfEZa2NnYeSJ9ZZp3/+7KeWG4ELfkXVcW7jyg592uQjzrLFOpO8dNOnD/UfL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760493084; c=relaxed/simple;
	bh=VlbW2Wo/jtLRKfINMxCi2gJq/1N0aUyE8+uDSooIGFY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W2HI1BeNcRgCDvVqkPZIrfjk+ayykHz6GeSUkv7cVYJvRSi9/s7+/LbHU68iIVtLdbnkDdXrISmMyXIAoFyUh2VTRBDqjSsItWyNR+WTsYw+Jnhj29bY85vJM46KyBWjLiaSShghlmgiPze5ln50Im64XnB0S+s5wq1lM0rUnQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201615.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202510150951133084;
        Wed, 15 Oct 2025 09:51:13 +0800
Received: from jtjnmailAR01.home.langchao.com (10.100.2.42) by
 Jtjnmail201615.home.langchao.com (10.100.2.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 15 Oct 2025 09:51:12 +0800
Received: from inspur.com (10.100.2.108) by jtjnmailAR01.home.langchao.com
 (10.100.2.42) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 15 Oct 2025 09:51:12 +0800
Received: from localhost.localdomain.com (unknown [10.94.16.205])
	by app4 (Coremail) with SMTP id bAJkCsDwybQO_u5o8rwJAA--.1663S4;
	Wed, 15 Oct 2025 09:51:11 +0800 (CST)
From: Chu Guangqing <chuguangqing@inspur.com>
To: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <eddyz87@gmail.com>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
	<sdf@fomichev.me>, <haoluo@google.com>, <jolsa@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Chu Guangqing
	<chuguangqing@inspur.com>
Subject: [PATCH v3 0/1] Fix spelling typo in samples/bpf
Date: Wed, 15 Oct 2025 09:50:23 +0800
Message-ID: <20251015015024.2212-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: bAJkCsDwybQO_u5o8rwJAA--.1663S4
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY97AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aV
	CY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAq
	x4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6x
	CaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAC
	I402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxV
	WUtVW8ZwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQvtAUUUUU=
X-CM-SenderInfo: 5fkxw35dqj1xlqj6x0hvsx2hhfrp/
X-CM-DELIVERINFO: =?B?UIvcAJRRTeOiUs3aOqHZ50hzsfHKF9Ds6CbXmDm38RucXu3DYXJR7Zlh9zE0nt/Iac
	D+KQ3ZFDy+DjjrTwdLfzCWA+i8sDC08dxneMamGk7rui/mLMUtIcfI5+ZXyQtcyso7qjf+
	ykGW5A+exgSBZzzGbfU=
Content-Type: text/plain
tUid: 20251015095113d3ee9d5a5a62b5f2be5a1f89ceb6afed
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Fixes for some spelling errors in samples/bpf

v3:
 - The BPF module patch as a separate thread

v2:
 - Merge into a single commit 
 (https://lore.kernel.org/all/20251014060849.3074-1-chuguangqing@inspur.com/
)
v1:
 (https://lore.kernel.org/all/20251014023450.1023-1-chuguangqing@inspur.com/) 

Chu Guangqing (1):
  samples/bpf: Fix spelling typo in samples/bpf

 samples/bpf/do_hbm_test.sh  | 2 +-
 samples/bpf/hbm.c           | 4 ++--
 samples/bpf/tcp_cong_kern.c | 2 +-
 samples/bpf/tracex1.bpf.c   | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.43.7


