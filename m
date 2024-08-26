Return-Path: <bpf+bounces-38059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8325C95E9E3
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 09:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 383411F235F3
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 07:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A7F126F02;
	Mon, 26 Aug 2024 07:06:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF3C5FBBA
	for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 07:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724655979; cv=none; b=c7i88LkimIfBQGiDdYQGMqb8cIZR1Ytfdsb5901r2VY8Rp8DHBtbnfVKlFpquaOaJ3tolmCvKJPotylTfNp1uzDXO2mW/3XwH+hSn9tcCe9gnVKrdl4ouZ1/KuVk0p26T75oBj+7kRxIcY786+n/qRbNj6DokhGZ2of1vXcqRSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724655979; c=relaxed/simple;
	bh=aSBMGi6B2YDSPsYItqgasMoI2OwJPvdbyy0YPDpw5sQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sxuiV9l5FPIIqc5CqVDTksMSib3+qcouxalW4hOs68z+XjVk/9GprcaRPj0orcB/FSsk42CJ5f/hr7+MKJdPFdg/+g6hlW1mo5dZ11VW67TGDxs95uCXRqly1GGCGbhvOQb0xZngRqM1iNKEQHOSQQ9PZe8nFq6mKSBaJRRKhYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WshXq1Yxrz4f3jk1
	for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 15:06:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 18F611A018D
	for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 15:06:13 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP2 (Coremail) with SMTP id Syh0CgAH8L5jKcxmTz_5Cg--.20237S2;
	Mon, 26 Aug 2024 15:06:12 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Leon Hwang <hffilwlqm@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH bpf-next 0/2] bpf, arm64: Simplify jited prologue/epilogue
Date: Mon, 26 Aug 2024 15:16:22 +0800
Message-Id: <20240826071624.350108-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAH8L5jKcxmTz_5Cg--.20237S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyfGFyxXFy5tF17XFy7KFg_yoW8XryUp3
	W3XF4aqr1Du393WrZxJr43JFyrXF4fta4UXa47XF10y34UuF98uF1Sga4fKFWrJFyIvF45
	WrW8Cr45Cr98Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

The arm64 jit blindly saves/restores all callee-saved registers, making
the jited result looks a bit too compliated. For example, for an empty
prog, the jited result is:

   0:   bti jc
   4:   mov     x9, lr
   8:   nop
   c:   paciasp
  10:   stp     fp, lr, [sp, #-16]!
  14:   mov     fp, sp
  18:   stp     x19, x20, [sp, #-16]!
  1c:   stp     x21, x22, [sp, #-16]!
  20:   stp     x26, x25, [sp, #-16]!
  24:   mov     x26, #0
  28:   stp     x26, x25, [sp, #-16]!
  2c:   mov     x26, sp
  30:   stp     x27, x28, [sp, #-16]!
  34:   mov     x25, sp
  38:   bti j 		// tailcall target
  3c:   sub     sp, sp, #0
  40:   mov     x7, #0
  44:   add     sp, sp, #0
  48:   ldp     x27, x28, [sp], #16
  4c:   ldp     x26, x25, [sp], #16
  50:   ldp     x26, x25, [sp], #16
  54:   ldp     x21, x22, [sp], #16
  58:   ldp     x19, x20, [sp], #16
  5c:   ldp     fp, lr, [sp], #16
  60:   mov     x0, x7
  64:   autiasp
  68:   ret

Clearly, there is no need to save/restore unused callee-saved registers.
This patch does this change, making the jited image to only save/restore
the callee-saved registers it uses.

Now the jited result of empty prog is:

   0:   bti jc
   4:   mov     x9, lr
   8:   nop
   c:   paciasp
  10:   stp     fp, lr, [sp, #-16]!
  14:   mov     fp, sp
  18:   stp     xzr, x26, [sp, #-16]!
  1c:   mov     x26, sp
  20:   bti j		// tailcall target
  24:   mov     x7, #0
  28:   ldp     xzr, x26, [sp], #16
  2c:   ldp     fp, lr, [sp], #16
  30:   mov     x0, x7
  34:   autiasp
  38:   ret

Xu Kuohai (2):
  bpf, arm64: Get rid of fpb
  bpf, arm64: Avoid blindly saving/restoring all callee-saved registers

 arch/arm64/net/bpf_jit_comp.c | 394 +++++++++++++++++-----------------
 1 file changed, 192 insertions(+), 202 deletions(-)

-- 
2.43.0


