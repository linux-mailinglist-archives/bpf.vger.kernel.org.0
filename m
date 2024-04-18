Return-Path: <bpf+bounces-27098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E74A8A9057
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 03:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEAA9282080
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 01:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AB55465B;
	Thu, 18 Apr 2024 01:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nKy8Ip0E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAECA4F889
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 01:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713402463; cv=none; b=Ud+gx5wuVMdl4Jo7vhPI/CCyi3Omwv29z05GWtc65cPxMPCNzbpe+zD7FnV3Z07o+MxjOWH3gPl0GITlc+DGDn8lLjlR03fML/ZLOtYmyds6XTLV4wbnQfoNTS35zCqia8G/sX7BZRj2JbhHp6kZySdoN3j6y1qlZ4OGeme8TDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713402463; c=relaxed/simple;
	bh=Gy+v3kHc6gUJFOVz0cecKLWhrUu0SiEkWzcElEXVN2Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H/obESEkwbgKpy1yWCwMYOnXdH8Gt2TIexuLcNYAcWLPq+gHQDJrIv7/g+Gk/eD10fJ0zb/M05CwMvwDYxUg0k/yHo3huuAXHonADmkJqeUWc5AhNoMsRixFCP9Uq5w1fNEOLbNvNR60EEey8M9LgmNu6KCguLfGmr59jNbaBfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nKy8Ip0E; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5e4df21f22dso335255a12.0
        for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 18:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713402460; x=1714007260; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cs92mryat0OzgsnGDmpmqjunv7BtT58JcaK8X9mxrOg=;
        b=nKy8Ip0EpUHHR27Yj3g3IcfwKxkfDi7O+ooHXdM1g6ytEgen15I5dJR0O/jgjBzoHT
         fi3d0eiQYrd68/zAlfQcIV52wCh7Y+Lu32OOvI9DDmIk6di1/z9WQzMJFhN8p+nC1z14
         nxvXyeQ9iPRYbiM+xmLhwiINykmY1wcSgqmcDllZgId+2JS8J7c7P/A6gah4VPcsq2PN
         HioRhwgGggI1ZI02IAOJY88wfqER4gdYgA7gHSn0XVkmvIyRU0qVxS8xHPJuE8nGrBYJ
         vRWxB5iAx24Fdw6adqBKZ/rF9+omauuJHF7Bsz7TUEUoSBCjItdOoQTkL27pPuZde8qv
         zlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713402460; x=1714007260;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cs92mryat0OzgsnGDmpmqjunv7BtT58JcaK8X9mxrOg=;
        b=IdV6Ckiw4Tax7h/6pvPy0toKY2pD4ueRO/p48qbbpO/G2+JpjaEKkc0IscccbQOXeV
         HmmdSsl2927ebgDr2vH4KrdQfsGzuuat1L1zVyAvaOvyDcnr/neR93YkqfYDTVxikDq0
         80vja+Fyh7P5XedmfucFNMTv5uMMs+JkyQtlxGXMGY09VJ6BPpit8Oe3YFMi4iAkakrq
         zlz25HO57W4NiAXsWmg1+PpWYRSBwNUWGhspLhU2tVeaPqorj2TsVqMFzZpuV4tgUHKX
         MMcYTupdIouISya4PdKehqc+GfkO3BHns8spjtwkClyzNaNJlH1PeMaqwRctYbuuc+NY
         ONQw==
X-Gm-Message-State: AOJu0Yw6wDCXjAe5ez26+Mv09s03klrUO5i8WHQgAbCpZWF4gATNFa18
	MswobYOXEyU77kx7ztG+47o1zv2uQviqNEovKRk7xlapAeRFDSLd/ZAZyUQ1pjFLL6Jd7VfJ+Dh
	WQA==
X-Google-Smtp-Source: AGHT+IHJxc7eNFka5oLm+urHCgHJgtjUp/kG6lLtOsi7pjI5NnoubZUAgtsoYBT/QXLuYw7ioKAL5C8eHnk=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:af54:0:b0:5e8:65ae:1142 with SMTP id
 s20-20020a63af54000000b005e865ae1142mr3079pgo.4.1713402459921; Wed, 17 Apr
 2024 18:07:39 -0700 (PDT)
Date: Thu, 18 Apr 2024 01:07:13 +0000
In-Reply-To: <20240418010723.3069001-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <16430256912363@kroah.com> <20240418010723.3069001-1-edliaw@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240418010723.3069001-5-edliaw@google.com>
Subject: [PATCH 5.15.y v2 4/5] bpf: Fix out of bounds access for ringbuf helpers
From: Edward Liaw <edliaw@google.com>
To: stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>
Cc: bpf@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tr3e.wang@gmail.com
Content-Type: text/plain; charset="UTF-8"

From: Daniel Borkmann <daniel@iogearbox.net>

Both bpf_ringbuf_submit() and bpf_ringbuf_discard() have ARG_PTR_TO_ALLOC_MEM
in their bpf_func_proto definition as their first argument. They both expect
the result from a prior bpf_ringbuf_reserve() call which has a return type of
RET_PTR_TO_ALLOC_MEM_OR_NULL.

Meaning, after a NULL check in the code, the verifier will promote the register
type in the non-NULL branch to a PTR_TO_MEM and in the NULL branch to a known
zero scalar. Generally, pointer arithmetic on PTR_TO_MEM is allowed, so the
latter could have an offset.

The ARG_PTR_TO_ALLOC_MEM expects a PTR_TO_MEM register type. However, the non-
zero result from bpf_ringbuf_reserve() must be fed into either bpf_ringbuf_submit()
or bpf_ringbuf_discard() but with the original offset given it will then read
out the struct bpf_ringbuf_hdr mapping.

The verifier missed to enforce a zero offset, so that out of bounds access
can be triggered which could be used to escalate privileges if unprivileged
BPF was enabled (disabled by default in kernel).

Fixes: 457f44363a88 ("bpf: Implement BPF ring buffer and verifier support for it")
Reported-by: <tr3e.wang@gmail.com> (SecCoder Security Lab)
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
(cherry picked from commit 64620e0a1e712a778095bd35cbb277dc2259281f)
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 kernel/bpf/verifier.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 14813fbebc9f..3dfc45ed428a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5153,9 +5153,15 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	case PTR_TO_BUF:
 	case PTR_TO_BUF | MEM_RDONLY:
 	case PTR_TO_STACK:
+		/* Some of the argument types nevertheless require a
+		 * zero register offset.
+		 */
+		if (arg_type == ARG_PTR_TO_ALLOC_MEM)
+			goto force_off_check;
 		break;
 	/* All the rest must be rejected: */
 	default:
+force_off_check:
 		err = __check_ptr_off_reg(env, reg, regno,
 					  type == PTR_TO_BTF_ID);
 		if (err < 0)
-- 
2.44.0.769.g3c40516874-goog


