Return-Path: <bpf+bounces-55641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE85CA83CFF
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 10:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A9C84617AC
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 08:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542F920AF63;
	Thu, 10 Apr 2025 08:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neXH7VwV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAA138F80
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 08:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744273934; cv=none; b=U5PucrvOeWYPnNfj6kd+B1aEEAZGmt2YNu61OxmFztcLxlCruaXzgthB8KImN0o5kZY47qZ/JZK/Gr47CJf0zMzVXcqAaBo1uEcRo0bEoVk00OKmnChWFyNGeA+DedjbZfGUaciKr7vklYKZm1YKYBjuazGBGVgmAu80CMtHf8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744273934; c=relaxed/simple;
	bh=1uemT1baXrCJTqIpXsbFzNBzqFtHpiqyD0xSwH8xrgY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=l0Ph4YrGBWYCmab9KYpTzUMhTUeMXbThQFFf0JOJQGkBG3c4VJkbeYe4AT2rkBx59j60g9Djz6xQYQiy3cWbDnFdUjm7YTA/CwhIZCdtUom5w2Mm+waGl36c75gCYUlnvjeCVjf4tTBE4fs/d9o94ouW91rEiAv/G9CoDRxZKwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=neXH7VwV; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39c266c2dd5so385141f8f.3
        for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 01:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744273931; x=1744878731; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UiVKlGIxjA7r8JnSQokMv0lKYGCP9sz+H9+UQzWn6hQ=;
        b=neXH7VwVe1+9jKKe7EgeZS7ngXHht5s+CQ/OXikqWalXhGn14TT1in5SDU4QNOxOj7
         N2yWSdui0js9pr4Eaej692TMpUdq4r7udIQkA1yDA0d56Yfi/l5eF/DIaDVjpCsN48sJ
         SlDGgeNFS/EiU/xIZwJP5IPy9Qg1z/hhCro+iVxzfkmSlW9OFeWnbmemfRDUnsm9QnCr
         MnnUO9RnYtTR3QtfgrlBsATbEaHAoDs1fIJwZW7cpNluXNcBrbqICPn8+aCyfZeuLC0V
         /asTapLCiL7+O6I5nzdvQs6Sz5q1Q5r2xpaWU9Id2NN9xHD/qNjmfTGXrPnreyAhevGV
         9WQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744273931; x=1744878731;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UiVKlGIxjA7r8JnSQokMv0lKYGCP9sz+H9+UQzWn6hQ=;
        b=r/ibqrJfyYN1YaXaCp3rVTF4ni5veQm+JvE/GO+cUdDz3vqV370hELHRg7kxIrJ/Lm
         jO7YBpD3ExONpowmYl01Atq36PKCWMmYoVJ9OrO9tjcMxU+phnZ6i271iE+pgGi60LV9
         ihNaGC11ugfVnvXQMgfbjC/xmVs7WmRqYtEJYh+T79kmPEfrNOhxwggUNwtMZ1DjnpeR
         5qDYBMRv4HwhFdC9HxFpztcXjsqMq8nQwehmuDCnhsQ9SfSRB9Ypd61iWX7+9K/iAIZE
         aZWZnTnUFAj1wTPp8q0gT9bDDuipPOgabNKMXQ3CGHkkxH9LqJzqLdUbLKlgYT3YrDD7
         4F9g==
X-Gm-Message-State: AOJu0YzERmC8+zAjMZNG2Z/ub/Oo3vdSdSge8VhcKtE+ookkQIJ2dEyp
	yi3U741JJLKWkAOOhq2hwnTbFkDLRICYdi+g8+8oowQapvhhDqxvf8snwk+PbQQ=
X-Gm-Gg: ASbGnct8kodsoAZEAwfu9tC1xAZLmJLUUHVEcxgFQAkoJXaScRHyCkqu9/jlYAorfSp
	k1uApv6fGfnpfztx+UotCD5GMlNycMjZr/fLE3HI8L50TXTGtCuDEfu4MKtYGOWOeuuLaC/ex2l
	ctxg2Tp7mVxGx5IpKmKSeZJwuBDGDNjPbTUrh5FFOZwqiYQomS0ITwwBr/PsILZRlC3tUWPtNvr
	cpTSJVtrwJ+R+mwP+nozLBrKIlF50btk9rJ5Kdt8XLrHMnhMRXdebOXBAjocG9ZnHpa7ogA86fJ
	6VeJ2JF8+2dJ/AtXP8QjZE5Kgc0gb3GBK1IGWUqzmQ8u0e46lrTzX2JQI/l9EG5w4LMbvoltO1m
	7TxhNPA61quomX6E2+0o0+9ze5hDfy/UsnzoU2lpHshKhQ5cI/CJgeShBZXFifMIE5V6IGNNN6A
	IFMzZU
X-Google-Smtp-Source: AGHT+IFf1Ahrpch1YxGzw1sLztdFiUispMyyRKgT767xZ95dfRr1OHByPvHkhPZYthBOQzrKNaf9Dg==
X-Received: by 2002:a5d:64a9:0:b0:390:e311:a8c7 with SMTP id ffacd0b85a97d-39d8fd63d7bmr1293069f8f.5.1744273931103;
        Thu, 10 Apr 2025 01:32:11 -0700 (PDT)
Received: from ?IPV6:2003:ed:7734:bb65:1ffb:2412:2a99:44d2? (p200300ed7734bb651ffb24122a9944d2.dip0.t-ipconnect.de. [2003:ed:7734:bb65:1ffb:2412:2a99:44d2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d89362fbfsm4051313f8f.13.2025.04.10.01.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 01:32:10 -0700 (PDT)
Message-ID: <525d54bc-5259-49f2-acbf-7396bab48dec@gmail.com>
Date: Thu, 10 Apr 2025 10:32:09 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: bpf@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
From: Lion Ackermann <nnamrec@gmail.com>
Subject: [PATCH net-next] net: filter: remove dead instructions in filter code
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

It is well-known to be possible to abuse the eBPF JIT to construct
gadgets for code re-use attacks. To hinder this constant blinding was
added in "bpf: add generic constant blinding for use in jits". This
mitigation has one weakness though: It ignores jump instructions due to
their correct offsets not being known when constant blinding is applied.
This can be abused to construct "jump-chains" with crafted offsets so
that certain desirable instructions are generated by the JIT compiler.
F.e. two consecutive BPF_JMP | BPF_JA codes with an appropriate offset
might generate the following jumps:

    ...
    0xffffffffc000f822:    jmp    0xffffffffc00108df
    0xffffffffc000f827:    jmp    0xffffffffc0010861
    ...

If those are hit unaligned we can get two consecutive useful
instructions:

    ...
    0xffffffffc000f823:    mov    $0xe9000010,%eax
    0xffffffffc000f828:    xor    $0xe9000010,%eax
    ...

This patch adds a mitigation to prevent said chains from being
generated by re-writing any instructions which are not reachable
anyways. By preventing consecutive jumps, only a single instruction can
be encoded, which is believed to be insufficient to be useful.

No functional changes for a benign filter program are intended.

Fixes: 4f3446bb809f ("bpf: add generic constant blinding for use in jits")
Signed-off-by: Lion <nnamrec@gmail.com>
---
 net/core/filter.c | 68 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 65 insertions(+), 3 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index bc6828761a47..b8eb2fa309c6 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -970,6 +970,65 @@ static int check_load_and_stores(const struct sock_filter *filter, int flen)
 	return ret;
 }
 
+/* Security:
+ *
+ * As it is possible to abuse the JIT compiler to produce instructions for
+ * code re-use, remove anything which is not reachable in a benign program
+ * anyways
+ */
+static int remove_dead_code(struct sock_filter *filter, int flen)
+{
+	int pc;
+	unsigned long *live;
+
+	if (flen == 0)
+		return 0;
+
+	live = bitmap_zalloc(flen, GFP_KERNEL);
+	if (!live)
+		return -ENOMEM;
+
+	/* No back jumps and no loops, can do a single forward pass here */
+	set_bit(0, live);
+	for (pc = 0; pc < flen; pc++) {
+		if (!test_bit(pc, live)) {
+			/* Dead. Some arbitrary instruction here. */
+			filter[pc].code = BPF_LD | BPF_IMM;
+			filter[pc].k = 0;
+			filter[pc].jt = 0;
+			filter[pc].jf = 0;
+			continue;
+		}
+
+		switch (filter[pc].code) {
+		case BPF_RET | BPF_K:
+		case BPF_RET | BPF_A:
+			break;
+		case BPF_JMP | BPF_JA:
+			set_bit(pc + 1 + filter[pc].k, live);
+			break;
+		case BPF_JMP | BPF_JEQ | BPF_K:
+		case BPF_JMP | BPF_JEQ | BPF_X:
+		case BPF_JMP | BPF_JGE | BPF_K:
+		case BPF_JMP | BPF_JGE | BPF_X:
+		case BPF_JMP | BPF_JGT | BPF_K:
+		case BPF_JMP | BPF_JGT | BPF_X:
+		case BPF_JMP | BPF_JSET | BPF_K:
+		case BPF_JMP | BPF_JSET | BPF_X:
+			set_bit(pc + 1 + filter[pc].jt, live);
+			set_bit(pc + 1 + filter[pc].jf, live);
+			break;
+		default:
+			/* Continue to next instruction */
+			set_bit(pc + 1, live);
+			break;
+		}
+	}
+
+	kfree(live);
+	return 0;
+}
+
 static bool chk_code_allowed(u16 code_to_probe)
 {
 	static const bool codes[] = {
@@ -1061,11 +1120,11 @@ static bool bpf_check_basics_ok(const struct sock_filter *filter,
  *
  * Returns 0 if the rule set is legal or -EINVAL if not.
  */
-static int bpf_check_classic(const struct sock_filter *filter,
+static int bpf_check_classic(struct sock_filter *filter,
 			     unsigned int flen)
 {
 	bool anc_found;
-	int pc;
+	int pc, ret;
 
 	/* Check the filter code now */
 	for (pc = 0; pc < flen; pc++) {
@@ -1133,7 +1192,10 @@ static int bpf_check_classic(const struct sock_filter *filter,
 	switch (filter[flen - 1].code) {
 	case BPF_RET | BPF_K:
 	case BPF_RET | BPF_A:
-		return check_load_and_stores(filter, flen);
+		ret = check_load_and_stores(filter, flen);
+		if (ret)
+			return ret;
+		return remove_dead_code(filter, flen);
 	}
 
 	return -EINVAL;
-- 
2.49.0



