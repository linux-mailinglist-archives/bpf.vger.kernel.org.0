Return-Path: <bpf+bounces-62961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3BCB00B3E
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 20:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D5F91CA11D4
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 18:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70712FCE04;
	Thu, 10 Jul 2025 18:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4B5JKk3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCAF2F433B
	for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 18:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752171660; cv=none; b=PqDAhFWMOsB1kY+TmE0YI5I11Cf6VJBViZ3g9pdjw74vPrCBt9+7TVri6xLTRoj60lxEGTfCwtmAnpvozk3LXqLFEYxX0HKirPlJkQylIouozS9Yr+QrnX0+yIkGirQad4+76jVNQ/8DuasNhVmyDYKIT0BKiPWMage2VQCQNnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752171660; c=relaxed/simple;
	bh=5eKic4YIIojKmBsjXAXhCFDPSnh1FmlXDx4R25tQoAY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=We4QxbYhz1L7SjriPph9HRhZ1bhxZUzmSzWTkycYCBUoVPSNXasjmDx/0CUOe4EYJht6WXI3fJoxpS3E/LRAkfV2ibUeNmVtGgiHl/GhswA4SWjlx0fiVPPCtjk/ja2s1G32ZSEs5SwFEc1TSuyV/13ti+EL7xTzeKPi6aI8SlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4B5JKk3; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-454aaade1fbso13488195e9.3
        for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 11:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752171657; x=1752776457; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DpM3K4tqdMR50mNhSFkpebgluFGsW8WE5E4WMSQ1K7M=;
        b=Q4B5JKk3tX+i7Mz47NicZESzP7b3PfGzW+PS2uoFGA+DEHxqshLAh8Pxw8W5RCxGle
         NB7jAOn8je40VmDShKrH/hnmMyxT1NeZErrbq5AesyK13leIcWShGwS+qaswp1bYL+eo
         dnWbEpYeT0xPpkU++exnUc28BqVo3o8DI9vCuNruXrZxEoyq80+Md56MVDe5nBW4Ru0/
         8wdHkdL5NU21o1DZMqdtZ1gyYNQWtse52kZGkdPfBKCTpoTm2UXsxlvFifGU+h/HIAJv
         T9Ow0uQXkQVqcZUDMBHnbVnOrJ9wxDFCzo9VFGKs10IYntN5prSTlL79ZcybHRJKa+XL
         y75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752171657; x=1752776457;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DpM3K4tqdMR50mNhSFkpebgluFGsW8WE5E4WMSQ1K7M=;
        b=XryFnh8Ew6/LG/gNA9gW80VWraCRbkIT/gCB2hbrt+sX0oAYxidmTFBwl1qL6OLpe7
         JHekIEK97DWbm3bmSi562Q05/LlgaBkQOdSd8blDxiaVa79axiIKWXCWh2f67KghIr2P
         QrAhE62A+cszsOiouXvYSHDVk1SEc47TmmjwyOmKVZFATQrL72ACD5PSACnpZDV1FgWO
         79Hsj7Jyccq1PYU7/jisHCOxvlMa7YsE/WzJ9ilIKcZ4LZVA4roqUF12GKhyXAJsZS4D
         +FphsRtpTd1XFHJZ1sgnQb1Gcfcd2GKFtPxEwRMjmrcS2QhDyHNBlqofufSpRpKpMTXz
         SCMg==
X-Gm-Message-State: AOJu0Yz4edTeQTB9h9k431VijcbSZY7PfN7+kPcUhopilqPgqIKOf7pH
	46LLdz8zJg24DCDoY4QoMwG6w55wWAMs/m6piFOrT9TqdnU2dzDS08tZZiz0LYoH
X-Gm-Gg: ASbGncsSsfqMJ87XB3pPnG88SV4Khyc3WfK0VA9cgm76LNqDWON2H+Z9xmCGvmVnW+Y
	ZSfRw92Zl/0YNEq4dGPD8sseOkcGcjNCmxxNbPORzBxypwr7tExzjdy5dGcC/gd5jNX1uqw8on3
	z/Eo82/DIcoNng1TVcVbdPBtjssctaJcmLQ7MyTPU4hE6CoRr2V1GY0QixVc0ThsnCkLXq5gqq2
	dr2ETVRg/DFFQCaUsmkZSglUb/Zl8RfeT/wgkTIOLNnlEFQMdlsDwIOSjXj1R9ZPSgPWf53wAU2
	gGOi2v09fc3b6+bjNdwAgJxAhWFVhONwBXrgJvz1PJUpVZME4opcZ0KYKR7M/kGqZn5R5LirpFs
	LOhxw7xleoMudkwufBuRVsqRbHBynKtGlEe04tTMKCIViSL38UfTA+SAR+Hcrzg==
X-Google-Smtp-Source: AGHT+IFZMKr+LCxV8m6RfT6wRmua1UjDZFDCNHIOhdopmQTRcU4nJEh9JW1bARYNpYxVYILUXPTGsg==
X-Received: by 2002:a05:600c:8882:b0:442:ff8e:11ac with SMTP id 5b1f17b1804b1-454dd2024e6mr31933395e9.12.1752171655872;
        Thu, 10 Jul 2025 11:20:55 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00939f1ea551223a20.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:939f:1ea5:5122:3a20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d867sm2513751f8f.61.2025.07.10.11.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 11:20:55 -0700 (PDT)
Date: Thu, 10 Jul 2025 20:20:53 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 1/2] bpf: Forget ranges when refining tnum after
 JSET
Message-ID: <9d4fd6432a095d281f815770608fdcd16028ce0b.1752171365.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Syzbot reported a kernel warning due to a range invariant violation on
the following BPF program.

  0: call bpf_get_netns_cookie
  1: if r0 == 0 goto <exit>
  2: if r0 & Oxffffffff goto <exit>

The issue is on the path where we fall through both jumps.

That path is unreachable at runtime: after insn 1, we know r0 != 0, but
with the sign extension on the jset, we would only fallthrough insn 2
if r0 == 0. Unfortunately, is_branch_taken() isn't currently able to
figure this out, so the verifier walks all branches. The verifier then
refines the register bounds using the second condition and we end
up with inconsistent bounds on this unreachable path:

  1: if r0 == 0 goto <exit>
    r0: u64=[0x1, 0xffffffffffffffff] var_off=(0, 0xffffffffffffffff)
  2: if r0 & 0xffffffff goto <exit>
    r0 before reg_bounds_sync: u64=[0x1, 0xffffffffffffffff] var_off=(0, 0)
    r0 after reg_bounds_sync:  u64=[0x1, 0] var_off=(0, 0)

Improving the range refinement for JSET to cover all cases is tricky. We
also don't expect many users to rely on JSET given LLVM doesn't generate
those instructions. So instead of improving the range refinement for
JSETs, Eduard suggested we forget the ranges whenever we're narrowing
tnums after a JSET. This patch implements that approach.

Reported-by: syzbot+c711ce17dd78e5d4fdcf@syzkaller.appspotmail.com
Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 53007182b46b..e2fcea860755 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16208,6 +16208,10 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
 		if (!is_reg_const(reg2, is_jmp32))
 			break;
 		val = reg_const_value(reg2, is_jmp32);
+		/* Forget the ranges before narrowing tnums, to avoid invariant
+		 * violations if we're on a dead branch.
+		 */
+		__mark_reg_unbounded(reg1);
 		if (is_jmp32) {
 			t = tnum_and(tnum_subreg(reg1->var_off), tnum_const(~val));
 			reg1->var_off = tnum_with_subreg(reg1->var_off, t);
-- 
2.43.0


