Return-Path: <bpf+bounces-20384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8E583D9B3
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 12:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99DCF299C9B
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 11:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CBC18EA1;
	Fri, 26 Jan 2024 11:54:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5521B942;
	Fri, 26 Jan 2024 11:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706270041; cv=none; b=qiA+AjB95WKqqN5DbgKPJ0IOhmLCWfb+IkNqHUMMXPsJ00afitB18PaP11UwXLY3hFwcuOgZTlOGYF2R+XeXmWpr//5llLnUDC8Jjbg/+5b2gJldUhoflG685c6jGx1M9gM7hO/sDJvpCNLcqz22NGiqX+0BEVKhUj3S5c4i3ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706270041; c=relaxed/simple;
	bh=R4KIdldmuAPxvE+dKo2d3Bmt5lX4dAInQbxjdGrFa6E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZU6dfsN7Q8xFgaG/1YvxJ/vTK8LkXGq3ITZPKXYf9ONjFq5T4/6wfdWZmpx8CY4KNyoHpwN8vQAvMKb7IRGpXJo+gCi/gLBxhEBu4VFtCLKos3arqsMJFI6vCHA4iiHWrq+RAgobESFPmDnNH9/G9RnC3l+5bLueoDlZMjhJGQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TLx1D2kqXz4f3jqC;
	Fri, 26 Jan 2024 19:53:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C374E1A0232;
	Fri, 26 Jan 2024 19:53:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgBHZQ42nbNllmgoCA--.1892S4;
	Fri, 26 Jan 2024 19:53:53 +0800 (CST)
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
	Sohil Mehta <sohil.mehta@intel.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	houtao1@huawei.com
Subject: [PATCH bpf v2 0/3] Fix the read of vsyscall page through bpf
Date: Fri, 26 Jan 2024 19:54:20 +0800
Message-Id: <20240126115423.3943360-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHZQ42nbNllmgoCA--.1892S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4rKrWUGF13trWkAr43Wrg_yoW8tFWDpa
	y8A343Kr4rKFy3Ar43W3srZayrAwn5tF47Wrn7Wr1rZ3y7XFyFvryIga4Yqr9xAF9xKryY
	vr4ftFykG3Wjqa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Hi,

As reported by syzboot [1] and [2], when trying to read vsyscall page
by using bpf_probe_read_kernel() or bpf_probe_read(), oops may happen.

Thomas Gleixner had proposed a test patch [3], but it seems that no
formal patch is posted after about one month [4], so I post it instead
and add an Originally-by tag in patch #2.

Patch #1 makes is_vsyscall_vaddr() being a common helper. Patch #2 fixes
the problem by disallowing vsyscall page read for
copy_from_kernel_nofault(). Patch #3 adds one test case to ensure the
read of vsyscall page through bpf is rejected. Please see individual
patches for more details.

Comments are always welcome.

[1]: https://lore.kernel.org/bpf/CAG48ez06TZft=ATH1qh2c5mpS5BT8UakwNkzi6nvK5_djC-4Nw@mail.gmail.com/
[2]: https://lore.kernel.org/bpf/CABOYnLynjBoFZOf3Z4BhaZkc5hx_kHfsjiW+UWLoB=w33LvScw@mail.gmail.com/
[3]: https://lore.kernel.org/bpf/87r0jwquhv.ffs@tglx/
[4]: https://lore.kernel.org/bpf/e24b125c-8ff4-9031-6c53-67ff2e01f316@huaweicloud.com/

Change Log:
v2:
  * move is_vsyscall_vaddr to asm/vsyscall.h instead (Sohil)
  * elaborate on the reason for disallowing of vsyscall page read in
    copy_from_kernel_nofault_allowed() (Sohil)
  * update the commit message of patch #2 to more clearly explain how
    the oops occurs. (Sohil)
  * update the commit message of patch #3 to explain the expected return
    values of various bpf helpers (Yonghong)

v1: https://lore.kernel.org/bpf/20240119073019.1528573-1-houtao@huaweicloud.com/

Hou Tao (3):
  x86/mm: Move is_vsyscall_vaddr() into asm/vsyscall.h
  x86/mm: Disallow vsyscall page read for copy_from_kernel_nofault()
  selftest/bpf: Test the read of vsyscall page under x86-64

 arch/x86/include/asm/vsyscall.h               | 10 ++++
 arch/x86/mm/fault.c                           |  9 ---
 arch/x86/mm/maccess.c                         |  9 +++
 .../selftests/bpf/prog_tests/read_vsyscall.c  | 57 +++++++++++++++++++
 .../selftests/bpf/progs/read_vsyscall.c       | 45 +++++++++++++++
 5 files changed, 121 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
 create mode 100644 tools/testing/selftests/bpf/progs/read_vsyscall.c

-- 
2.29.2


