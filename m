Return-Path: <bpf+bounces-62114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2E7AF5A32
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 15:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1F7517C468
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 13:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D97275846;
	Wed,  2 Jul 2025 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdJT2zp+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E83253934
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751464409; cv=none; b=JJ6oUX9eWG1axpBLTHromWYHZI5BZihiH6nsFvTyJ/W3l16FbdaCH0dQ1I2ZMG6B9H4uo3TKX6amK6EDoRucWpJhWAW4FGKccxZw6fr3mwOJlITVQqQB4TGFDEfzEl3Kox5VcFafUFhG0B5YlT3qK+hJVi+QN158Bm506EajhGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751464409; c=relaxed/simple;
	bh=KA5NtdIcSFcAO9ncyk7PSDbj6bbeRBww8Kirc1UAVDs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=h7AQnaUVqkztTwZ9o/lyvbdMiAZobrnXOU9CkWzgtVd1tqTN5czpTy9xqdtIhYJw/r2fvvXXtS6kz7QoWb7HYgb21B+hDtIYixlxa6qpDqrIR1yQWNf4z4THztUilLLKNK9BkOfDlGjowmH7Kbx2wpII6FDEBAJW7NcPZzSwxhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdJT2zp+; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-453647147c6so73400215e9.2
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 06:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751464406; x=1752069206; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v7yHhlPoIMabzewVRqD2Y6dYidGZrlrN63HdEaADeVA=;
        b=mdJT2zp+xU6mj+eMyM6uIglIWNuu3klgjlrcu0MYmvcSbdu5T6fShfbMXFAkSO+vwF
         5crxrJ/JQ5Z9TpSsITnPD9jiEEA2P22MBkbiWm3O9sjpdtuOatG7MtuWpXSHZnRDm8Jx
         +9KC4mxUM8a0cKPcnkJR4tZLG3ylr1TsHhVxtoTdA/9kfB7PHUcbeP7A/ZveZXL4J/Ut
         r57Zq5rTu6ICsgMlohML1uvae971otTKrYttpKWh+eEyW4AtWD8WVHWNuGGa50DaPYqV
         IsrOVQL5xh00JLyGgZwB/6GI+9fXiMfGLSTkhC7vLcGjROYqhVM1n1JavwL5n4jOobUU
         83PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751464406; x=1752069206;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v7yHhlPoIMabzewVRqD2Y6dYidGZrlrN63HdEaADeVA=;
        b=XFUcHaPRJ6xkKxQToySe/L8WfEFtCMbP/WWdCP/rylGdwdpOcmkTZBj3E4CbDwaKsM
         KaAQdbiDVNUR/FXWecj+Xq0+BTDFxpIXQlVsiEF/W+Y2ZiQKba4X55bmPvX+noEkCTrG
         NDZR4SK1TRHCeNOnH+mdCttepXM2gyt0KYCZF0bdYjDi+SZZJyDLdNmYyw78hlKgLVbv
         ITLWe16i27hupJ6lU91w05bxkx2p+XodMXtJqic5vrafjQI/Zd/Mmk12z7aLSKF/TyL1
         H61L5H++yVAGEX8w+Voh7E3xC9nQRg8d0biOLRSKWQApSfqEgicg3rm159O7JAysUbZI
         h0EQ==
X-Gm-Message-State: AOJu0YyZpdlCoelMAVhVNxyKLqG05MS92wiQ9cmiBVjqV+067t3Q4leK
	kK+tTJc0rYAjLTKtSysBfiXT5wiS/ael5LI999g1JiTEi+tFlN2EM8vYKFjwACMW
X-Gm-Gg: ASbGncuXvLnTx1xdG9L4OFGwN5ZuZSMepk2pPqr+bOpXYxWgBGf+LSYftp8JbMbMRmr
	MbVdTtyo9XA6Qxly4Xl0cYobG0Zd64pOdUjY1DlT91ouAnJIxgb9/1tbnL7n3E5/yizscKvl9fl
	nGCFYNzIFRzF7fY33tfoF1eSG5Z70SpowwxY/gj+ieK6TKeFV4xqUJJK6agmag8K8r4+/MFXuGP
	QdobVcq3vIBKsp/31WdtCuetoC3OTzWaxhj+Nbk7odx1qn5Z71j+mFh73qcW5wSXw2TooX9gxT7
	7ydrNDG3IbHEaPuQJlOPPms9BbdSr/EsjAZ9Cl11D/gqCU/dAf8155BT5TddFmp5jYXNe9EyEDK
	tUV7+UOnZhSUsnIS+E+cN7MqufVGbRibs7HRIaVeRFvCvuOm/2ckjM/B0xrYL
X-Google-Smtp-Source: AGHT+IERwROyeWcgOK7442R8i6RM5E7q437U50tzVR+bSm5Hmo+5amfBBP85eHiYWOmbdM8FP//u6w==
X-Received: by 2002:a5d:5f8a:0:b0:3a4:f439:e715 with SMTP id ffacd0b85a97d-3b1fd74c424mr2416459f8f.9.1751464406224;
        Wed, 02 Jul 2025 06:53:26 -0700 (PDT)
Received: from Tunnel (2a01cb089436c000d0fa69457aba7254.ipv6.abo.wanadoo.fr. [2a01:cb08:9436:c000:d0fa:6945:7aba:7254])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453b3542838sm33703985e9.1.2025.07.02.06.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 06:53:25 -0700 (PDT)
Date: Wed, 2 Jul 2025 15:53:23 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 1/2] selftests/bpf: Negative test case for
 ref_obj_id in args
Message-ID: <3ba78e6cda47ccafd6ea70dadbc718d020154664.1751463262.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch adds a test case, as shown below, for the verifier error
"more than one arg with ref_obj_id".

    0: (b7) r2 = 20
    1: (b7) r3 = 0
    2: (18) r1 = 0xffff92cee3cbc600
    4: (85) call bpf_ringbuf_reserve#131
    5: (55) if r0 == 0x0 goto pc+3
    6: (bf) r1 = r0
    7: (bf) r2 = r0
    8: (85) call bpf_tcp_raw_gen_syncookie_ipv4#204
    9: (95) exit

This error is currently incorrectly reported as a verifier bug, with a
warning. The next patch in this series will address that.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 tools/testing/selftests/bpf/verifier/calls.c | 24 ++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 18596ae0b0c1..f3492efc8834 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -2409,3 +2409,27 @@
 	.errstr_unpriv = "",
 	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
 },
+{
+	"calls: several args with ref_obj_id",
+	.insns = {
+	/* Reserve at least sizeof(struct iphdr) bytes in the ring buffer.
+	 * With a smaller size, the verifier would reject the call to
+	 * bpf_tcp_raw_gen_syncookie_ipv4 before we can reach the
+	 * ref_obj_id error.
+	 */
+	BPF_MOV64_IMM(BPF_REG_2, 20),
+	BPF_MOV64_IMM(BPF_REG_3, 0),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_reserve),
+	/* if r0 == 0 goto <exit> */
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tcp_raw_gen_syncookie_ipv4),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_ringbuf = { 2 },
+	.result = REJECT,
+	.errstr = "more than one arg with ref_obj_id",
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+},
-- 
2.43.0


