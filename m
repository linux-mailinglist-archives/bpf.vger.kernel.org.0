Return-Path: <bpf+bounces-49363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E974A17E24
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 13:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 140B83A4E25
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 12:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6294E1F237A;
	Tue, 21 Jan 2025 12:56:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A2B1F2374
	for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737464206; cv=none; b=oaGOc7lbGPccVEHLU0oJIygxdzL9kWC3iBoEEZn4VZwDOSIahSDr5eU6raMbw6xZNjI9+tbsycCpD6pJVl2C3D4bnwwOVFFXs/pCjtdGMIusqVEUHch6rI3B2yvGnvo21OBMV/Rnjdt1DuSpc8IUVZogSrabTfgtzvSaP+b+YQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737464206; c=relaxed/simple;
	bh=nu9QeniA1BMWeI11IeyFY8LJrC7k6j8NqYO6IN0Gl6g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SVYFpqlLG5uZW/WUGb/tUGvKn/yKtMA3DGqCUYyFnPRp3UoIbjylkvUyt5tZQa+IpG2waFTKf8cdTvkT8Y2XVvF0PhJB0F4WA0A+Pfv9UIS4fZfi+aWP+c5cPsx4RK3nmIi10CxseAs9CksXMNOAPYqCFehJfQbPNDI72JJPDvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YcnJb1j2Kz4f3jLR
	for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 20:56:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 1BC851A139C
	for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 20:56:37 +0800 (CST)
Received: from huawei.com (unknown [7.197.88.80])
	by APP2 (Coremail) with SMTP id Syh0CgAXIWR1mY9nPLhOBg--.23795S2;
	Tue, 21 Jan 2025 20:56:36 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	hffilwlqm@gmail.com,
	leon.hwang@linux.dev
Subject: [PATCH bpf] selftests/bpf: Fix freplace_link segfault in tailcalls prog test
Date: Tue, 21 Jan 2025 20:56:02 +0800
Message-Id: <20250121125602.683613-1-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAXIWR1mY9nPLhOBg--.23795S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw4rAw45WrWDAFy5tFW8JFb_yoW8Cw4kpa
	4vvw1DKr1F9rn0qF47Gw429FWS9F4kXFyYkr1rWwn5Ar4UXrZ7GF1I9a4jgF1rZryrX34r
	Ar1ftrn3u34xG37anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7IU0qZX5UUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

There are two bpf_link__destroy(freplace_link) calls in
test_tailcall_bpf2bpf_freplace(). After the first bpf_link__destroy()
is called, if the following bpf_map_{update,delete}_elem() throws an
exception, it will jump to the "out" label and call bpf_link__destroy()
again, causing double free and eventually leading to a segfault.

Fix this issue by moving bpf_link__destroy() out of the "out" label
and only calling it when freplace_link exists and has not been freed.

Fixes: 021611d33e78 ("selftests/bpf: Add test to verify tailcall and freplace restrictions")
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 tools/testing/selftests/bpf/prog_tests/tailcalls.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index 544144620ca6..028439dd2c5f 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -1624,7 +1624,7 @@ static void test_tailcall_bpf2bpf_freplace(void)
 	freplace_link = bpf_program__attach_freplace(freplace_skel->progs.entry_freplace,
 						     prog_fd, "subprog_tc");
 	if (!ASSERT_ERR_PTR(freplace_link, "attach_freplace failure"))
-		goto out;
+		goto out_free_link;
 
 	err = bpf_map_delete_elem(map_fd, &key);
 	if (!ASSERT_OK(err, "delete_elem from jmp_table"))
@@ -1638,11 +1638,11 @@ static void test_tailcall_bpf2bpf_freplace(void)
 		goto out;
 
 	err = bpf_map_update_elem(map_fd, &key, &prog_fd, BPF_ANY);
-	if (!ASSERT_ERR(err, "update jmp_table failure"))
-		goto out;
+	ASSERT_ERR(err, "update jmp_table failure");
 
-out:
+out_free_link:
 	bpf_link__destroy(freplace_link);
+out:
 	tailcall_freplace__destroy(freplace_skel);
 	tc_bpf2bpf__destroy(tc_skel);
 }
-- 
2.34.1


