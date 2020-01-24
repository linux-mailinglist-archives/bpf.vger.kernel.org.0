Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5D85147883
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2020 07:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgAXGSG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jan 2020 01:18:06 -0500
Received: from relay.sw.ru ([185.231.240.75]:51780 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbgAXGSG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jan 2020 01:18:06 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1iusHs-0007rF-3v; Fri, 24 Jan 2020 09:17:48 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 1/1] map_seq_next should increase position index
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Message-ID: <d6e2df39-919e-8d37-0668-5c4bbf19f278@virtuozzo.com>
Date:   Fri, 24 Jan 2020 09:17:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

if seq_file .next fuction does not change position index,
read after some lseek can generate unexpected output.

https://bugzilla.kernel.org/show_bug.cgi?id=206283
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 kernel/bpf/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index ecf42be..9008a20 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -196,6 +196,7 @@ static void *map_seq_next(struct seq_file *m, void *v, loff_t *pos)
 	void *key = map_iter(m)->key;
 	void *prev_key;
 
+	(*pos)++;
 	if (map_iter(m)->done)
 		return NULL;
 
-- 
1.8.3.1

