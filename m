Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31247167663
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2020 09:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730747AbgBUIdU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Feb 2020 03:33:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:46300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732609AbgBUIK5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Feb 2020 03:10:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1065B24670;
        Fri, 21 Feb 2020 08:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272656;
        bh=+PkrT4iG1T7Rl6JWmdEM27E+WQtpZRSY2P7dpNAA9Wc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h9NY6pwJsWssOo7ZL2obh4z6lzfcGxZxiKfoCMKRal5doga/49MaoIU4823gD4e1A
         bVR7WeM+b0Ke39RSQRlUFl8UWRv9gzVCOZ3WRpFpTe6wb5U+9iX0WofIWsD+W2n2U0
         GB8cMlMLPWdxQ0vg2XmdpYaSGSp79zc+8vozjRi0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Petr Mladek <pmladek@suse.com>, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 180/344] tools lib api fs: Fix gcc9 stringop-truncation compilation error
Date:   Fri, 21 Feb 2020 08:39:39 +0100
Message-Id: <20200221072405.326779624@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrey Zhizhikin <andrey.z@gmail.com>

[ Upstream commit 6794200fa3c9c3e6759dae099145f23e4310f4f7 ]

GCC9 introduced string hardening mechanisms, which exhibits the error
during fs api compilation:

error: '__builtin_strncpy' specified bound 4096 equals destination size
[-Werror=stringop-truncation]

This comes when the length of copy passed to strncpy is is equal to
destination size, which could potentially lead to buffer overflow.

There is a need to mitigate this potential issue by limiting the size of
destination by 1 and explicitly terminate the destination with NULL.

Signed-off-by: Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andriin@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Song Liu <songliubraving@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org
Link: http://lore.kernel.org/lkml/20191211080109.18765-1-andrey.zhizhikin@leica-geosystems.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/api/fs/fs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
index 7aba8243a0e7c..bd021a0eeef8c 100644
--- a/tools/lib/api/fs/fs.c
+++ b/tools/lib/api/fs/fs.c
@@ -210,6 +210,7 @@ static bool fs__env_override(struct fs *fs)
 	size_t name_len = strlen(fs->name);
 	/* name + "_PATH" + '\0' */
 	char upper_name[name_len + 5 + 1];
+
 	memcpy(upper_name, fs->name, name_len);
 	mem_toupper(upper_name, name_len);
 	strcpy(&upper_name[name_len], "_PATH");
@@ -219,7 +220,8 @@ static bool fs__env_override(struct fs *fs)
 		return false;
 
 	fs->found = true;
-	strncpy(fs->path, override_path, sizeof(fs->path));
+	strncpy(fs->path, override_path, sizeof(fs->path) - 1);
+	fs->path[sizeof(fs->path) - 1] = '\0';
 	return true;
 }
 
-- 
2.20.1



