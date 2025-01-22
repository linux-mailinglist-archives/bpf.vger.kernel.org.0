Return-Path: <bpf+bounces-49428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC6EA189E6
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 03:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6EC87A463B
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 02:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BCD146D6A;
	Wed, 22 Jan 2025 02:29:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6048F7D
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 02:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737512952; cv=none; b=T7JKEEuGH8pk7kdotmdvwoKpRlqDr5gFzxOOcjv5/MrncgG7lL9GUscM9XCjqIe1hOfQdAEgrZyD5bDGovapP4tQqhxqj2DsaAHJAUbGcwcMqomNt8SllzkaDlVf53F9WS4NFWDQFvBWHTwHFcV5N1P6feWaCrLRtLKkPWed8XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737512952; c=relaxed/simple;
	bh=y5B/FvgceATzEQlFuhfDirP+o7v97RJQ0zVB6Lqd0Og=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cMW6AcMXxodrEcAW1cORBLHLbl/QhW8xj8D7sxMVZ1rJMpJJqTKhAj7nQrqL+2F3n2YjZiWPV4ncMDQ/R6EEEJfx/bLnXUdfCWcfrGCDh3k+SPfPHfBpAi7RFUx/9F733Nmin4Rp/sdnQDgFWtkfXl56gFKJyVijpMNjIM0ut44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Yd7L56rQfz4f3jMw
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 10:28:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8FDF81A07F2
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 10:29:06 +0800 (CST)
Received: from huawei.com (unknown [7.197.88.80])
	by APP1 (Coremail) with SMTP id cCh0CgBnGHnqV5BnEMp2Bg--.2728S2;
	Wed, 22 Jan 2025 10:29:06 +0800 (CST)
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
Subject: [PATCH bpf v2] selftests/bpf: Fix freplace_link segfault in tailcalls prog test
Date: Wed, 22 Jan 2025 10:28:38 +0800
Message-Id: <20250122022838.1079157-1-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnGHnqV5BnEMp2Bg--.2728S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw4rAw45WrWDAFy5tFW8JFb_yoW8JFykpa
	48Zw1jkF1F9F1avF47GF4I9rWS9F4kXry5Cr1rWwn5Ar4UXFZ7GF1I9FyjqF1fZrZ5Xw1Y
	vw1ftrn5uws7ArJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU0ceOJUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

There are two bpf_link__destroy(freplace_link) calls in
test_tailcall_bpf2bpf_freplace(). After the first bpf_link__destroy()
is called, if the following bpf_map_{update,delete}_elem() throws an
exception, it will jump to the "out" label and call bpf_link__destroy()
again, causing double free and eventually leading to a segfault.

Fix it by directly resetting freplace_link to NULL after the first
bpf_link__destroy() call.

Fixes: 021611d33e78 ("selftests/bpf: Add test to verify tailcall and freplace restrictions")
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 tools/testing/selftests/bpf/prog_tests/tailcalls.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index 544144620ca6..a12fa0521ccc 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -1602,6 +1602,7 @@ static void test_tailcall_bpf2bpf_freplace(void)
 	err = bpf_link__destroy(freplace_link);
 	if (!ASSERT_OK(err, "destroy link"))
 		goto out;
+	freplace_link = NULL;
 
 	/* OK to update prog_array map then delete element from the map. */
 
-- 
2.34.1


