Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A56A14940E
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2020 10:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725767AbgAYJKV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Jan 2020 04:10:21 -0500
Received: from relay.sw.ru ([185.231.240.75]:52196 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgAYJKV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Jan 2020 04:10:21 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1ivHS6-0006e1-Mc; Sat, 25 Jan 2020 12:10:02 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2] map_seq_next should increase position index
To:     bpf@vger.kernel.org
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
References: <a17c846a-f957-1506-d397-bdc1ee957fab@iogearbox.net>
Message-ID: <eca84fdd-c374-a154-d874-6c7b55fc3bc4@virtuozzo.com>
Date:   Sat, 25 Jan 2020 12:10:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <a17c846a-f957-1506-d397-bdc1ee957fab@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

v2: removed missed increment in end of function

if seq_file .next fuction does not change position index,
read after some lseek can generate unexpected output.

https://bugzilla.kernel.org/show_bug.cgi?id=206283
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 kernel/bpf/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index ecf42be..6f22e0e 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -196,6 +196,7 @@ static void *map_seq_next(struct seq_file *m, void *v, loff_t *pos)
 	void *key = map_iter(m)->key;
 	void *prev_key;
 
+	(*pos)++;
 	if (map_iter(m)->done)
 		return NULL;
 
@@ -208,8 +209,6 @@ static void *map_seq_next(struct seq_file *m, void *v, loff_t *pos)
 		map_iter(m)->done = true;
 		return NULL;
 	}
-
-	++(*pos);
 	return key;
 }
 
-- 
1.8.3.1

