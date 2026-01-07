Return-Path: <bpf+bounces-78074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4815ACFCE9C
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 10:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 894F4305A229
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 09:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CEE2FFF8E;
	Wed,  7 Jan 2026 09:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="URJg4wzl"
X-Original-To: bpf@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0190A3128BC
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767778787; cv=none; b=XShsSwfmWLfB0amL9KOSWO5L96OZQh90+d0YWXOHTyvWD1JMeEYVZiIuHFKfBH8lOc1eDiSC4GuBOn0AEb3M1c7PT9YhkOTi77yPW8yxI3P9yh2F6cQyRiDxwPnyZllIoCm9/cnX8erex4Quz0JRVMSKNEde0bGipIWxCvGeP2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767778787; c=relaxed/simple;
	bh=e5Z9BMyTMDb2QZfqzAeyDiin2K0Q7WTCGMXvX7EV/tg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=DHU2XeVZhiaY2LJz6j6XCzZ48vS0d4R6w1OJLTWjPwgimyVZhLYFw3pHMq7z8CN8SRfD5HMN54lJ8pTCQQyp3LiIx8yJjx9vDVp6ON7hPq2uvyYvnEM8tGQi22pW8mxv+svX70+HVENg05BZPOtYRwZkA5GooxeovM6QJsGGe5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=URJg4wzl; arc=none smtp.client-ip=43.163.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1767778781; bh=+bJiMBFBrn/FC4AjXuqOVF1bcIPRgzlAJLWD5B04d3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=URJg4wzldbcH6K8dfhD/pZ/TQw+wpfHVtTt+0XD3+sWLp+yNCfQabp5DWLu04DM5T
	 WjltxBHFnNdXaLvLd5xh80oSgVU+5GbW9/xMw/0F7BJgVJ9N23WUdKyLPk8hN3/8xq
	 /tgWIi8hbixXvE0SZvdXBoExIREDUZ3TKZZTlz9Y=
Received: from lxu-ped-host.. ([114.244.57.24])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 9E539CC6; Wed, 07 Jan 2026 17:39:37 +0800
X-QQ-mid: xmsmtpt1767778777t5wze93sj
Message-ID: <tencent_8D33CB9E2A1B8D4B511BB0250FBAA8BB8708@qq.com>
X-QQ-XMAILINFO: MlsYLnHA0UVj0lNvl/JwsaMpgzWBFFEbb9PqA1DSUfdUMRO+mX8BI1sVvoCLZ8
	 B/AkqJTIS1FwBUM4uFLcbLY9Vhou9IHvpbZf4BGuSxEDTtFyf+5JYCO6ZwZ2hVdUvwAKMDJ7lMAj
	 LGNiVPcZDopwd9Dmh8ZE4EniLvU6X93X2FHQ+EQn2wdV7FwN0XCBocv/bRMHhPZjfu4FxC1tIFDC
	 YiyA7gDGVAsSxEl3pgZnzDQ8PB+HFmP2Yk63bdqxX3AaGKC93Q0447TBjhzXw/APwzBiXuKwACX+
	 g1nHPsBknAjpgtkOaxhl2bwzcTVQwulMSpyRq8fG4Z/3euiH1sLOXxqvAXQni5NfcD+GfaD8CTt3
	 r5iDUt3v54tZLtuMVXaSuFRMzSTUAfxnmsUQ/9rGhth5yuTP27ItlYnFBbpXgGiIwlf/7dRZLFPH
	 roB4aRkhEZqrsM/EEkmq0yxoFtUgtJoGyarezj/h1e36JEy+ni6MQyX3rawniKAOCeA/whRL0uA5
	 vHEMLax/Gd75o/kBaA7Ll5L4Xn3dCAXFZuvfoN+SRdXo4hygL94ZVsxh7FxxPWo19oYr9ArEVVuO
	 1E2+S04PSGw66cTSdDpYO6DjgvpcV67o0IxHCdP55XuDuUbdKEL9jggWudJckDDSiL/k9hUB5DOE
	 N1rwzhpngZnfVCUPq53Tn7cfQRIpPhP8Xnbalyi7yX0WgKj9WiwiLcMtwcrjq5IB1YGxM/ULk5UM
	 9bZM28LHy1LUulF9834o/G4EVKFFs/kyUSmCTrZMmYMmbGYLP4wlHiL1dh2KWfeDNlJC0xtehZPa
	 WiE4WeYe32Deas73fCihDfexJZYRvVZZFCjgAxlIeFJ39ViqwSsImutRLDGAsyWOYjflI6NcgYcJ
	 oAXW8RdcIISCMkAtIgcV29tgA+MkqGHaAcKVm3+42pkTmktGVud8jDyk1DhYFXhPqoMSntbCoGdw
	 EkHUVZg/7Z2LEVE1q09/qQtKt4oPg/6IS0wrQ4JIL1+FT7L0menymD4/5I7xvMEJF58/W51Z4=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+2c29addf92581b410079@syzkaller.appspotmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	sdf@fomichev.me,
	song@kernel.org,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: [PATCH] bpf: Format string can't be empty
Date: Wed,  7 Jan 2026 17:39:36 +0800
X-OQ-MSGID: <20260107093935.474079-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <695bc686.050a0220.1c677c.032f.GAE@google.com>
References: <695bc686.050a0220.1c677c.032f.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The user constructed a BPF program containing a bpf_snprintf() call.
The fmt parameter passed to bpf_snprintf() was not assigned a value;
it only executed the BPF_MAP_FREEZE command to freeze the fmt string.
Furthermore, when bpf_check() executed check_reg_const_str() and
check_bpf_snprintf_call() to check the fmt input parameter of the
user-constructed BPF program's bpf_snprintf() call, strnchr() only
checked if fmt was a null-terminated string. This led the BPF verifier
to incorrectly assume the constant format string was valid.
When the BPF program was actually executed, the out-of-bounds (OOB)
issue reported by syzbot occurred [1].

This issue is strongly related to bpf_snprintf(), therefore adding a
check for an empty format string in check_bpf_snprintf_call() would
be beneficial. Since it calls bpf_bprintf_prepare(), only adding a
check on the result of strnchr() is needed to prevent the case where
the format string is empty.

[1]
BUG: KASAN: slab-out-of-bounds in strnchr+0x5e/0x80 lib/string.c:405
Read of size 1 at addr ffff888029e093b0 by task ksoftirqd/1/23
Call Trace:
 strnchr+0x5e/0x80 lib/string.c:405
 bpf_bprintf_prepare+0x167/0x13d0 kernel/bpf/helpers.c:829
 ____bpf_snprintf kernel/bpf/helpers.c:1065 [inline]
 bpf_snprintf+0xd3/0x1b0 kernel/bpf/helpers.c:1049

Allocated by task 6022:
 __bpf_map_area_alloc kernel/bpf/syscall.c:395 [inline]
 bpf_map_area_alloc+0x64/0x180 kernel/bpf/syscall.c:408
 insn_array_alloc+0x52/0x140 kernel/bpf/bpf_insn_array.c:49
 map_create+0xafd/0x16a0 kernel/bpf/syscall.c:1514

The buggy address is located 0 bytes to the right of
 allocated 944-byte region [ffff888029e09000, ffff888029e093b0)

Fixes: d9c9e4db186a ("bpf: Factorize bpf_trace_printk and bpf_seq_printf")
Reported-by: syzbot+2c29addf92581b410079@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2c29addf92581b410079
Tested-by: syzbot+2c29addf92581b410079@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 kernel/bpf/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index db72b96f9c8c..88da2d0e634c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -827,7 +827,7 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
 	char fmt_ptype, cur_ip[16], ip_spec[] = "%pXX";
 
 	fmt_end = strnchr(fmt, fmt_size, 0);
-	if (!fmt_end)
+	if (!fmt_end || fmt_end == fmt)
 		return -EINVAL;
 	fmt_size = fmt_end - fmt;
 
-- 
2.43.0


