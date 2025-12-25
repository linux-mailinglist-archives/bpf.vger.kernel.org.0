Return-Path: <bpf+bounces-77436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A0063CDDB18
	for <lists+bpf@lfdr.de>; Thu, 25 Dec 2025 11:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51B853010E7D
	for <lists+bpf@lfdr.de>; Thu, 25 Dec 2025 10:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A36F314B71;
	Thu, 25 Dec 2025 10:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZOS1OEN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901572F4A14
	for <bpf@vger.kernel.org>; Thu, 25 Dec 2025 10:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766659517; cv=none; b=KALO1aVT0BUe9zM4ASPbsiF9p7uteJ2yh4soq0jtO0Nd1VKGJ9GmR9bFKxFX1x/1nhln9ZrVfyqLqFiMazGNA2RcT1ADRLGB4SgBhe4hEn5hSG05VS/b+HLavjyWj6OEsSHVEKSXQnvLDefFs58k/tz2VbjcMxCuacn6cEySIm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766659517; c=relaxed/simple;
	bh=ooda17nRlgzaWXxyIFbJgZPuJX16QrZkoNK6HccLzn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IuU5esuGPqHf++EZBMCZCewrHDY/yeNFDxpENXbYKX7Dsa1/LxSrGzYf1K6cyF6RtvBmi7gQw29COY/r2m/rNbjShiBuAZ3j+MXs7yugwGBv9CQ7bJCpzS7Ex+VdIJevRH1aqoEL/KUsTFprd4DnQIT0pLw/SyWFhi/zQL3sv/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZOS1OEN; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-34c21417781so6558037a91.3
        for <bpf@vger.kernel.org>; Thu, 25 Dec 2025 02:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766659515; x=1767264315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8xxF3kFQmHFC/i/qRiYm9vYsPAXcnfy31W/R9Oc0Ir4=;
        b=jZOS1OENxyCDycYyFRnAzbgDKGu8RGWN5fLhaRz0DtTXSWSA14R0z54n2nmcJQGZ1g
         wnDs2ZQKluUEWGYipQ0If8tGPxFskWCPBdad9vc47i+fkyiMLLh+rDq6yDPjvx6RHdxN
         xjnCHcXpASY4WhdXGDHWW2SA7voN3+hAYXgySiQjyJpMmSlg3o0YMVZZOKX5dRxpsTDA
         bidHh9MAOA7k3PSbdVTPVLofwjQ1Ho5aL0/N8oM1M7WKVU0byyuT3tipPiZgAXlf42qX
         ISwo+aP4bwDkwyazV3Tu/yA6ewJ6ZaDnMjqpMlcfi+7/0GVN+INy79agYOhpX13exk8A
         D+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766659515; x=1767264315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xxF3kFQmHFC/i/qRiYm9vYsPAXcnfy31W/R9Oc0Ir4=;
        b=X0EXKqSf/m4+wB7u2pVv6gbmfSHrgLnKRnwtgU542rP6mt+oUmRpl7VDxUs6/p6or+
         waBSYboCL0Nc/Td0z/D0Esu6ed9PPhf5xN2uZnrM1+smOblFWEgJjrKejHxwwLfbIZHs
         44SejlMWoDPnP//P4fsI5HcJgPiTXzaS05vuCE1zUVASgmJWrj6upMqb8YrPRA2GkBdk
         XuZUp42PzsuTTOYT37tECVUH+3FwuuUtXVEoXG1jtyVQ2db4nSwiov9USHCmxHe1RTB8
         iUNIxa2SZZSoYcL5MYvLRI3HY9/nk0pFs3xepXNporEAHsFqEluo2nzetVMA5Fc9yUo8
         D5rg==
X-Forwarded-Encrypted: i=1; AJvYcCWUKh6BmMKOsaCkuvRaTPYLa0tm1iF4CsWtzR8x2gt5TMLAbB6CWR+onIMiuqFzE46tJ3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiEl2XcuIqc1iOXObaiqlDposnxjWPJgDqo8uF9PHLc265RPxe
	WMYsIIlqVGL5o5f4IOJCksnrvV2JXAefwuAEb6OUq9rDYquSXhgUF72m
X-Gm-Gg: AY/fxX7XSOQF9Q9FE3M8aNh8pt+Fd5PdKtlELbGyBp1J9NXwBXaaZHrnSJygH3xCT8L
	C+TZdpqnq2lhTUexUP6n3/fMfQLwKg8pN5bjp5JcAtdP6F6XrszbqEVpAGfyhsDS2EZGXAX0NaD
	0oEzgiswP66gRxNNVnUiMFcefFapXoquDb13ca4OOKNh6CyxNIjK6r9z3UqknSN5eAyXWpxWOQL
	nYBAIwjneicKECR/YHvkQvgnlQ3WcE9n4PLkS1jfEEoIUhdfQt4QYgBTwnZ0Xqz/9UwnewvQ7SY
	05SKf/ZJ/LlF+/86bz34FY52RU+ampBTon3c5apXYBjkpLbvg0iUVlQFeiKuEAL0ipoq3B6zYq8
	+PMr8Izn0s8jOt/d/OnAnj8emoUXEqxUGY6ZUOOx26c7sLlo7BCftnx12NwFINuJSDq27aAT44+
	wjIEFr6/o16ZQbGl25Ng==
X-Google-Smtp-Source: AGHT+IFbVIhBTT0zROCFj/DYziq38CbJr650ni+iD1kul5A+SyuRB0jXgOZgjQFJ5hvYqb5XPA1zVA==
X-Received: by 2002:a17:90b:3c4e:b0:349:8116:a2d8 with SMTP id 98e67ed59e1d1-34e9211367cmr18738470a91.7.1766659514802;
        Thu, 25 Dec 2025 02:45:14 -0800 (PST)
Received: from 7940hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e772ac06fsm9091379a91.11.2025.12.25.02.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 02:45:14 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	jiang.biao@linux.dev,
	x86@kernel.org,
	hpa@zytor.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf, x86: inline bpf_get_current_task() for x86_64
Date: Thu, 25 Dec 2025 18:44:59 +0800
Message-ID: <20251225104459.204104-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inline bpf_get_current_task() and bpf_get_current_task_btf() for x86_64
to obtain better performance. The instruction we use here is:

  65 48 8B 04 25 [offset] // mov rax, gs:[offset]

Not sure if there is any side effect here.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 arch/x86/net/bpf_jit_comp.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index b69dc7194e2c..7f38481816f0 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1300,6 +1300,19 @@ static void emit_st_r12(u8 **pprog, u32 size, u32 dst_reg, int off, int imm)
 	emit_st_index(pprog, size, dst_reg, X86_REG_R12, off, imm);
 }
 
+static void emit_ldx_percpu_r0(u8 **pprog, const void __percpu *ptr)
+{
+	u8 *prog = *pprog;
+
+	/* mov rax, gs:[offset] */
+	EMIT2(0x65, 0x48);
+	EMIT2(0x8B, 0x04);
+	EMIT1(0x25);
+	EMIT((u32)(unsigned long)ptr, 4);
+
+	*pprog = prog;
+}
+
 static int emit_atomic_rmw(u8 **pprog, u32 atomic_op,
 			   u32 dst_reg, u32 src_reg, s16 off, u8 bpf_size)
 {
@@ -2435,6 +2448,15 @@ st:			if (is_imm8(insn->off))
 		case BPF_JMP | BPF_CALL: {
 			u8 *ip = image + addrs[i - 1];
 
+			if (insn->src_reg == 0 && (insn->imm == BPF_FUNC_get_current_task ||
+						   insn->imm == BPF_FUNC_get_current_task_btf)) {
+				if (IS_ENABLED(CONFIG_USE_X86_SEG_SUPPORT))
+					emit_ldx_percpu_r0(&prog, &const_current_task);
+				else
+					emit_ldx_percpu_r0(&prog, &current_task);
+				break;
+			}
+
 			func = (u8 *) __bpf_call_base + imm32;
 			if (src_reg == BPF_PSEUDO_CALL && tail_call_reachable) {
 				LOAD_TAIL_CALL_CNT_PTR(stack_depth);
@@ -4067,3 +4089,14 @@ bool bpf_jit_supports_timed_may_goto(void)
 {
 	return true;
 }
+
+bool bpf_jit_inlines_helper_call(s32 imm)
+{
+	switch (imm) {
+	case BPF_FUNC_get_current_task:
+	case BPF_FUNC_get_current_task_btf:
+		return true;
+	default:
+		return false;
+	}
+}
-- 
2.52.0


