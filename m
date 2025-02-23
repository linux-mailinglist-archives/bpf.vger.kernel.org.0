Return-Path: <bpf+bounces-52265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCABA40CFA
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 07:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38D06178318
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 06:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8DA1DC99C;
	Sun, 23 Feb 2025 06:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYI+QlWf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD2713C81B;
	Sun, 23 Feb 2025 06:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740292088; cv=none; b=Nulxj5+oaFV0dTpUKX+Zcr++zY5t4X+T1Nwuk+hzrLGWuddFo2QUp/4FZiLh+VXpdsCGtkAwGHN8sTLiLXPhnJ5ln9LqLwS78HwLcXWujm2TRoipeYMqY+fQ08gDWnpjGFIBsM0O2DJ1mwxEp1NvkyvaynGzKz+l5AdUWwmMZ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740292088; c=relaxed/simple;
	bh=W1uoJUFLNS5GVMa7NKovUsgkcndyHlQTOW+TrQ+u8CY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tL3Wc2EkzDoGJTqbc/ObSyDYnmkm5TIgA3CfP0Gz3682VRd9vC8C3Lv1oFENdr7ALT0SFBvCK5Z6t6EMrnN2IPVo7kQ/VGo9BQNkkDBI6bMa1YctWqLmz4DjGgz/Bt1kCD5g30YRxZV8M/dyBpWFBHaYpfBuabVas7zl4wJoI2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYI+QlWf; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220c8eb195aso75073695ad.0;
        Sat, 22 Feb 2025 22:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740292086; x=1740896886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwVFyQdfu6h3TLQXNFRRbzSXRYiI40nRpz0C8SZPokU=;
        b=ZYI+QlWfTwoC4e47UT65j5KkbGzF4pi/eqzQZFaFannV+0efbwe/CYc+tUgUw5wq0V
         Y+FqJMl3xoySpfJvoRXKpkAW62KAu1HF54jiMsex7VkSIFVzoWEAExzy04258IKfJfLB
         JpdwigAL0zBF3f7dahUQqt6kTsokgEz/J/0uK/e1+cfrRmk8pOWFLR5iPmhtoUALcxw4
         /n+4hs5xZZK9iGssIvAwJgWLioVFB998BRcyuMsT9vCGPwTle+wbwzvcvueFHxMLE+TN
         fMzSnLFq+Mz1wWXMVHFQDCFo6GJxLfDB/Mx1h8Mhns5Wdi3BTtHcW4dwv1BB9yTcjN7G
         6axA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740292086; x=1740896886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EwVFyQdfu6h3TLQXNFRRbzSXRYiI40nRpz0C8SZPokU=;
        b=tNVapy8JEHkjrvw/MBZiD4JU3St0loFGWuMhoLf/oNIPnQfY5FGNMxZ23KGfLdbjXZ
         vwp5YiDDJOi2vouKr60UbTb/vmm49NHv0OaCGVh/+eOEPSi7bWrWTab21MdX/69z6Ng2
         ecvdBynb7rFXnhz0gOR5KW3QRqyGK1zLnouCFl3lyTqr0iGAxC5JS1gjiegolg6d9hRy
         dL1cDD25sHE+hKhHxizGarG2INuOGDG0w+sV5+qi/TcA0Cs/Um1xQAtSLMpGF/t8L0Ky
         ZE1au7g5GBy0j1MDi4n0OaJ3Wo9/LfZHRhO1WCI2ftFkdMGLVqL7mb+XFHskCk7t7vMT
         qrkA==
X-Forwarded-Encrypted: i=1; AJvYcCVTaV1Z3Po7DBGc30cpJV3KWeSXTZf9PTKX0lLomhbCRX+Vv/fuTEWW6AYpNSireF7uEE3H90KhTzpiBys=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuxGZnv3cidbAPhZL9HYNZRHpox1Cm8j0ch/3EoTPtlCBf6J11
	yTkOynwrPUATAxYLrFdQI8LuiJGi/hLOAD2WxxEXFm1MossLYZIs
X-Gm-Gg: ASbGncsow00K+S9uMJMjLIAxWWVI2aWHDKbCZXft/KUrbRqL0w0tNg79Um9ei8Xl9g5
	enQTl/NNm2xKTdKxdjHleV4cUmhPPrDclLvLGvjQN5Ne0dTP+OHfrEPhzT2Vbbd04+Q4yc/mRC2
	qbZXY18C27d8tSOyCT4T9789J8QSmNRjHISQnNmmYDA4/ciPqn9inlX8diBSNTFoP5aczUxrcGp
	pY4+zXl7XRjaZJxsBJCsF/WsA/AERilsdYXacJZCAEZBWwz+jGKqy118z0AQaKIRrO63zPt3dTz
	pGDNNFbVp5oKa4dAszkk+To/4+wxejACBK9UYGLx71URCayHDrM=
X-Google-Smtp-Source: AGHT+IFZ3F9psOq0wIOAJv1eDPZp9Rbu8InvBB/8FO3r5fqlb01Xdoum2RfbIm6naFLdFhrhFZB6sA==
X-Received: by 2002:a05:6a00:4fc4:b0:730:7771:39c6 with SMTP id d2e1a72fcca58-73426cab09emr17922937b3a.8.1740292085980;
        Sat, 22 Feb 2025 22:28:05 -0800 (PST)
Received: from localhost.localdomain ([39.144.244.105])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732521b82b3sm16693128b3a.92.2025.02.22.22.27.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Feb 2025 22:28:05 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
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
	jpoimboe@kernel.org,
	peterz@infradead.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 bpf-next 2/3] bpf: Reject attaching fexit to functions annotated with __noreturn
Date: Sun, 23 Feb 2025 14:27:34 +0800
Message-Id: <20250223062735.3341-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250223062735.3341-1-laoar.shao@gmail.com>
References: <20250223062735.3341-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we attach fexit to a function annotated with __noreturn, it will
cause an issue that the bpf trampoline image will be left over even if
the bpf link has been destroyed. Take attaching do_exit() for example. The
fexit works as follows,

  bpf_trampoline
  + __bpf_tramp_enter
    + percpu_ref_get(&tr->pcref);

  + call do_exit()

  + __bpf_tramp_exit
    + percpu_ref_put(&tr->pcref);

Since do_exit() never returns, the refcnt of the trampoline image is
never decremented, preventing it from being freed. That can be verified
with as follows,

  $ bpftool link show                                   <<<< nothing output
  $ grep "bpf_trampoline_[0-9]" /proc/kallsyms
  ffffffffc04cb000 t bpf_trampoline_6442526459    [bpf] <<<< leftover

With this change, attaching fexit probes to functions like do_exit() will
be rejected.

$ ./fexit
libbpf: prog 'fexit': BPF program load failed: -EINVAL
libbpf: prog 'fexit': -- BEGIN PROG LOAD LOG --
Attaching fexit to __noreturn functions is rejected.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/verifier.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9971c03adfd5..329af451c936 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22841,6 +22841,13 @@ BTF_ID(func, __rcu_read_unlock)
 #endif
 BTF_SET_END(btf_id_deny)
 
+/* The functions annotated with __noreturn are denied. */
+BTF_SET_START(fexit_deny)
+#define NORETURN(fn) BTF_ID(func, fn)
+#include <linux/noreturns.h>
+#undef NORETURN
+BTF_SET_END(fexit_deny)
+
 static bool can_be_sleepable(struct bpf_prog *prog)
 {
 	if (prog->type == BPF_PROG_TYPE_TRACING) {
@@ -22929,6 +22936,10 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	} else if (prog->type == BPF_PROG_TYPE_TRACING &&
 		   btf_id_set_contains(&btf_id_deny, btf_id)) {
 		return -EINVAL;
+	} else if (prog->expected_attach_type == BPF_TRACE_FEXIT &&
+		   btf_id_set_contains(&fexit_deny, btf_id)) {
+		verbose(env, "Attaching fexit to __noreturn functions is rejected.\n");
+		return -EINVAL;
 	}
 
 	key = bpf_trampoline_compute_key(tgt_prog, prog->aux->attach_btf, btf_id);
-- 
2.43.5


