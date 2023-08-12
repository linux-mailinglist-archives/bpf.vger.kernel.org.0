Return-Path: <bpf+bounces-7645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B9B779D6F
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 07:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9B9A1C20AE8
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 05:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54414186A;
	Sat, 12 Aug 2023 05:58:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F8B1867
	for <bpf@vger.kernel.org>; Sat, 12 Aug 2023 05:58:42 +0000 (UTC)
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602D518F;
	Fri, 11 Aug 2023 22:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1691819919;
	bh=6k+2tlcHY6MZU1kfTY6UiFMgENXZRojososrfddZu4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LPQVLmrsKYLI9e9HiVnPxJiYj+MVC5PGhSXNXy1gz1VDHtt4myPeM0IAwqVCp/1x0
	 2yMRQkcsZleN6VpM5sXaT7koNtlFJo/xIpSH5Impt5h8uDI+0/IT2NBcuDBm3n+3/u
	 Gf5enaMUJyvt3MJTzKckMqrW2wPTtsKpmw1necg4=
Received: from localhost.localdomain ([183.197.149.136])
	by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
	id E97B6647; Sat, 12 Aug 2023 13:58:23 +0800
X-QQ-mid: xmsmtpt1691819907tjhossl2a
Message-ID: <tencent_50B4B2622FE7546A5FF9464310650C008509@qq.com>
X-QQ-XMAILINFO: MpO6L0LObisWlSPyv0ox+ZvMrl6iV1FUX3NaeEq6C+iNu2Xfz/4TfRjebT0iwT
	 jRO2L4CZ8senOrM1WgysUkFrCY9MDXEcFoEdjONCfIqk8yzynKkc8DvKvb2/BXLLIWZwA9/KUZXX
	 h7Sw1SckGjvWMulxOgVVEQtTBIwfTpDF80SV+YfkZCaBN0cvEJW8ABUL/FZdJ39pAQ18z8hr8IzV
	 mel8lr/rjN7bS1LFBGdiCpMgcBEGqaoCa1pyPBr7rQWJPvPj43IvehKPTsNfEX9fKJ49FPtfQ/qe
	 IQa8LRQY2Xz0wbdnxH0KVe15p1sWFbLgz5IJwkadS7c947YelRQ9P/x4uSvF62Jkc3mhZTh5ksch
	 XV0kelJvfMZHClTO8bwzFIEYK7U/H4VArDCN5U5oP4lo3hseBlwnt1BOouNaImdDsDCdD2ecC075
	 6gZ86VxIYxBmpEP7zK7j0fBXRiWbTAU5R20g9578yxK+iKRm7wVAU13e/Pa3lemy9+H4lTQxc5id
	 3mW4VlPXq3fhnrr03fIzNPU59zrVn8mVcqoFeD9+ijAjIs6GrgnZHj8vjRCtziRK+ZVGQ7sBD9Pb
	 YXLBVS9eGHWdEPAo1gNESRjErU9tUSvYN2SG90NFdNLaiEupzEP5NxiUDv1zf8l7+70m9qvJdmQA
	 7Dk8potQQIftKVhxBRS/Bz/9KXilmvzDwz/4JVM8OdZvUQEIiYFezP2lTNMaG5LNjQEHU/uwrYVN
	 pNTQCNlRLcfVqReM7i5Ou9yCuAkD5IvShNlaqHrgB4cdwq51kpiHECSt+ddInqdxVkDOFZu5vtlC
	 hR8vR7y83s7aF2kAO2J2x+YiHqglNddCnYlCWH+Vn99f9SVhqiIW6DpSJLSuKUkBK2h4WmGeOi7B
	 lfkINmi6Ep3mvGlUuysnRvuaQ5oWppxA7a6KKoTUrLHRGNy88GWI1IbfdLT9TojIDwp3LvbiWHW6
	 FmTn3FRfjQJ3MJNC/0asszYu6BfmaJJYLVLsNbj9+bcI84M7piKRtG68OBwJQ0GeWva9KtyfjXoQ
	 rtAxIumjDt1vZVJbleo+iU2j9hgl8auCm/suww8ejBNg0fCeOy
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Rong Tao <rtoax@foxmail.com>
To: sdf@google.com,
	ast@kernel.org
Cc: rongtao@cestc.cn,
	rtoax@foxmail.com,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf-next v3] selftests/bpf: trace_helpers.c: optimize kallsyms cache
Date: Sat, 12 Aug 2023 13:57:03 +0800
X-OQ-MSGID: <20230812055703.7218-2-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230812055703.7218-1-rtoax@foxmail.com>
References: <20230812055703.7218-1-rtoax@foxmail.com>
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
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Rong Tao <rongtao@cestc.cn>

Static ksyms often have problems because the number of symbols exceeds the
MAX_SYMS limit. Like changing the MAX_SYMS from 300000 to 400000 in
commit e76a014334a6("selftests/bpf: Bump and validate MAX_SYMS") solves
the problem somewhat, but it's not the perfect way.

This commit uses dynamic memory allocation, which completely solves the
problem caused by the limitation of the number of kallsyms.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
v3: Do not use structs and judge ksyms__add_symbol function return value.
v2: https://lore.kernel.org/lkml/tencent_B655EE5E5D463110D70CD2846AB3262EED09@qq.com/
    Do the usual len/capacity scheme here to amortize the cost of realloc, and
    don't free symbols.
v1: https://lore.kernel.org/lkml/tencent_AB461510B10CD484E0B2F62E3754165F2909@qq.com/
---
 tools/testing/selftests/bpf/trace_helpers.c | 42 ++++++++++++++++-----
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index f83d9f65c65b..d8391a2122b4 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -18,10 +18,32 @@
 #define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
 #define DEBUGFS_PIPE	"/sys/kernel/debug/tracing/trace_pipe"
 
-#define MAX_SYMS 400000
-static struct ksym syms[MAX_SYMS];
+static struct ksym *syms;
+static int sym_cap;
 static int sym_cnt;
 
+static int ksyms__add_symbol(const char *name, unsigned long addr)
+{
+	void *tmp;
+	unsigned int new_cap;
+
+	if (sym_cnt + 1 > sym_cap) {
+		new_cap = sym_cap * 4 / 3;
+		tmp = realloc(syms, sizeof(struct ksym) * new_cap);
+		if (!tmp)
+			return -ENOMEM;
+		syms = tmp;
+		sym_cap = new_cap;
+	}
+
+	syms[sym_cnt].addr = addr;
+	syms[sym_cnt].name = strdup(name);
+
+	sym_cnt++;
+
+	return 0;
+}
+
 static int ksym_cmp(const void *p1, const void *p2)
 {
 	return ((struct ksym *)p1)->addr - ((struct ksym *)p2)->addr;
@@ -33,9 +55,13 @@ int load_kallsyms_refresh(void)
 	char func[256], buf[256];
 	char symbol;
 	void *addr;
-	int i = 0;
+	int ret;
 
+	sym_cap = 1024;
 	sym_cnt = 0;
+	syms = malloc(sizeof(struct ksym) * sym_cap);
+	if (!syms)
+		return -ENOMEM;
 
 	f = fopen("/proc/kallsyms", "r");
 	if (!f)
@@ -46,15 +72,11 @@ int load_kallsyms_refresh(void)
 			break;
 		if (!addr)
 			continue;
-		if (i >= MAX_SYMS)
-			return -EFBIG;
-
-		syms[i].addr = (long) addr;
-		syms[i].name = strdup(func);
-		i++;
+		ret = ksyms__add_symbol(func, (unsigned long)addr);
+		if (ret)
+			return ret;
 	}
 	fclose(f);
-	sym_cnt = i;
 	qsort(syms, sym_cnt, sizeof(struct ksym), ksym_cmp);
 	return 0;
 }
-- 
2.41.0


