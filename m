Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3272615E3F5
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2020 17:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392914AbgBNQdF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Feb 2020 11:33:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:35372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406164AbgBNQZh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Feb 2020 11:25:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDBEF247C9;
        Fri, 14 Feb 2020 16:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697536;
        bh=WfLUugpGPKXn/iHU2isoZ0mKXtTg4eIb74duBSFyh0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gYW8HCa5coIQR3ZbOdeTwiYnkUutToI8a2H62Ep5Tae4Uhu9XK64PFVQqBSab5Vh+
         f3Vg5gMeZeeCnPrgCCek0g+5aT61/pzfw4eexJsezu+NbEkk4tkmhMCgrozEo+KjiB
         /WcdVqo2eLAM2jzxlVbGCdoD/p9Q7UOSdX+O8NQ8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrey Zhizhikin <andrey.z@gmail.com>,
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
Subject: [PATCH AUTOSEL 4.4 057/100] tools lib api fs: Fix gcc9 stringop-truncation compilation error
Date:   Fri, 14 Feb 2020 11:23:41 -0500
Message-Id: <20200214162425.21071-57-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214162425.21071-1-sashal@kernel.org>
References: <20200214162425.21071-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 459599d1b6c41..58f05748dd39e 100644
--- a/tools/lib/api/fs/fs.c
+++ b/tools/lib/api/fs/fs.c
@@ -179,6 +179,7 @@ static bool fs__env_override(struct fs *fs)
 	size_t name_len = strlen(fs->name);
 	/* name + "_PATH" + '\0' */
 	char upper_name[name_len + 5 + 1];
+
 	memcpy(upper_name, fs->name, name_len);
 	mem_toupper(upper_name, name_len);
 	strcpy(&upper_name[name_len], "_PATH");
@@ -188,7 +189,8 @@ static bool fs__env_override(struct fs *fs)
 		return false;
 
 	fs->found = true;
-	strncpy(fs->path, override_path, sizeof(fs->path));
+	strncpy(fs->path, override_path, sizeof(fs->path) - 1);
+	fs->path[sizeof(fs->path) - 1] = '\0';
 	return true;
 }
 
-- 
2.20.1

