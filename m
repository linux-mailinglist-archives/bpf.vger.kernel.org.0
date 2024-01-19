Return-Path: <bpf+bounces-19874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07412832503
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 08:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41C261C22430
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 07:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A20D51A;
	Fri, 19 Jan 2024 07:29:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C17944F;
	Fri, 19 Jan 2024 07:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705649370; cv=none; b=gpgB+zfDXaRVBqrAgGz8aO5Dez4fXKGyH/hk7rbDnDuWaBBmrczvXEAeXBrwAHk/9nvuFhCHVJDOlxHUHuJ+WnzF/mGH12rSWNlC+XC/15JcixMrw50fp1wIFQh8D5ncvxqFzAqgYUAu/DUhIB/oBfUmAhjGf07lU97MWWhNnpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705649370; c=relaxed/simple;
	bh=tytnvRSUO7zZOO5vPr/o6H9cIOFeDZolqtImBleFC/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KvxHwu82F0Vp8ea7uCsNDwe3N7sWYoq69yFLHtmWEibjw6V4J0H9Pb9UuxaLkxSFEEX3e1/SpW0/wtWIO449oSdg2cna5bw1ChvtJIVQoY5G5V6KuvclZzUl9/B8c3QzCcvfrIT15RU1EnsW1i1NS0eBrnEX1QSavBywkGCEIRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TGWT96wH9z4f3lVk;
	Fri, 19 Jan 2024 15:29:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 22F131A0171;
	Fri, 19 Jan 2024 15:29:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RHQJKplBOsuBQ--.42435S4;
	Fri, 19 Jan 2024 15:29:22 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: x86@kernel.org,
	bpf@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	xingwei lee <xrivendell7@gmail.com>,
	Jann Horn <jannh@google.com>,
	houtao1@huawei.com
Subject: [PATCH bpf 0/3] Fix the read of vsyscall page through bpf
Date: Fri, 19 Jan 2024 15:30:16 +0800
Message-Id: <20240119073019.1528573-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6RHQJKplBOsuBQ--.42435S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4rKrWUGF13trWkWr1Dtrb_yoW8CrW8pa
	93Cw15Kr1rKFyayr43WasFvayrJ3WktF43Wrn7Ww1rZ3y7XF9Y9ryIga4UWry3AFyagry5
	Zrs3tFykGw1jqF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
	cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
	IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
	42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
	IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
	87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Hi,

As reported by syzboot [1] and [2], when trying to read vsyscall page
by using bpf_probe_read_kernel() or bpf_probe_read(), oops will happen.

Thomas Gleixner had proposed a test patch [3], but it seems that no
formal patch is posted after about one month [4], so I post it instead
and add an Originally-from tag in patch #2.

Patch #1 makes is_vsyscall_vaddr() being a common helper. Patch #2 fixes
the problem by disallowing vsyscall page read for
copy_from_kernel_nofault(). Patch #3 adds one test case to ensure the
read of vsyscall page through bpf is rejected. Although vsyscall page
can be disabled by vsyscall=none, but it doesn't affect the reproduce of
the problem and the added test.

Comments are always welcome.

[1]: https://lore.kernel.org/bpf/CAG48ez06TZft=ATH1qh2c5mpS5BT8UakwNkzi6nvK5_djC-4Nw@mail.gmail.com/
[2]: https://lore.kernel.org/bpf/CABOYnLynjBoFZOf3Z4BhaZkc5hx_kHfsjiW+UWLoB=w33LvScw@mail.gmail.com/
[3]: https://lore.kernel.org/bpf/87r0jwquhv.ffs@tglx/
[4]: https://lore.kernel.org/bpf/e24b125c-8ff4-9031-6c53-67ff2e01f316@huaweicloud.com/

Hou Tao (3):
  x86/mm: Move is_vsyscall_vaddr() into mm_internal.h
  x86/mm: Disallow vsyscall page read for copy_from_kernel_nofault()
  selftest/bpf: Test the read of vsyscall page under x86-64

 arch/x86/mm/fault.c                           | 11 +---
 arch/x86/mm/maccess.c                         |  6 ++
 arch/x86/mm/mm_internal.h                     | 13 ++++
 .../selftests/bpf/prog_tests/read_vsyscall.c  | 61 +++++++++++++++++++
 .../selftests/bpf/progs/read_vsyscall.c       | 45 ++++++++++++++
 5 files changed, 127 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
 create mode 100644 tools/testing/selftests/bpf/progs/read_vsyscall.c

-- 
2.29.2


