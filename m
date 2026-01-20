Return-Path: <bpf+bounces-79571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 419CED3C2D5
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 10:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBEE3621FC1
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 08:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265723B8BCE;
	Tue, 20 Jan 2026 08:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G43801pa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5DC349AE0
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 08:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768897774; cv=none; b=cxt/W5M7R/bKHVT9hy5WPb6c5pg8MAJwH3a/+65pM8uGOmZrj6PX1eXAm1jg1pa03oKMfsEFmW80eo6z9oLAq9eXMDwQTR6np6P83S7cxvYzuDBvHj6fNdCD5wAXQ0208xQCYgRGx7lDqZbGnXcRH92TF74mzAJxUwDfIM0351c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768897774; c=relaxed/simple;
	bh=W9qdqjI867EXujfA1lB2A9WGNgOq4xDjQzueH0l+Gs8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=h40WrBND9c0fq7rMlzvfcIAysaTAawxcqHMK5ptz2upMuBI2lgPzrMoUuoazLpjgToUseePnB1ITFktHaF7kgaYMnuM906bvmN34fiskhfSigMeh98A16T7ibHpglEjWeDaaG+R9+WW4V82LbijM3HJ/goTnd3J8SAe0g6fGMMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G43801pa; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-81e8a9d521dso3058502b3a.2
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 00:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768897772; x=1769502572; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xjDUsPk8fY36wyI2DKjFv73iBZj8W3INU7HTBWcMBpo=;
        b=G43801paBJ7nfzab5dHxkE3MEXtT+3hacC6g41/NODCSuZtdXR/cKOnyIzCxwPWtRr
         hW/kjSs4tVew/kq2bLfpohzzYJAjWrizXTIgm9UZS1vsptpi8u4c+JK699W242JImJwP
         uoXBXDqVdOnYuu3kOQxkEYORFS/G5GTOUX8hr5FTHF5OVCEg+VXHAqVMQn5uP9YcKPy1
         NXOGBTAmLBF5h9ysOSxPEbiU8EulkiVw3NlEwrJSLvv4UIlf9641FBwXizha5yRD2j5x
         kthXV15EW5oUqoDMP3Wl5LnHTvyufrIJHxvzU9/lWuorlEc7yRYj0F5IyacIh1or4dbX
         /rqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768897772; x=1769502572;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjDUsPk8fY36wyI2DKjFv73iBZj8W3INU7HTBWcMBpo=;
        b=nOOo5ukhBvTISa3AxibWY+GknyhbDX49CMT/7gDQmVqQYDk3dZU6rgE2YXifO0mXo3
         vguUhR7khaerIJr62FCexqHK0ZUa3uAr3bIlTZybHWERKIaO8D40j1TzYZ089HYEe1dk
         W+mNdQsvdW0ZYVL51INFbz3zxsxAmksNbffotz6/5yguptnDw9YlgBNqHWlVW+tCn2c9
         glL04ang9gZUXp7mRpIzHHIIcOnhbReWUkUHP8VPiw9qtZDpt2XSupmcNGFCUWvOFvfm
         w0ybb5GW4LWPVf5ajC8wIH1qAiKSuTb9awpWOt89UD2FBbzGA948xfnHQnOpgPwXw/0x
         1LKw==
X-Gm-Message-State: AOJu0YzbFU6fRMbSGCq4LIqMlJ6kPUhX1zIjwxtgaxb12UMROtO+T3Y+
	KtRAbjuKmeXcKuBOQgyreDhPuEXK6iIBqdJ1p0Y2y5TKPrAjgAhD5fJ8
X-Gm-Gg: AY/fxX61u3Wwf/XP0aUhO1mbaRSbWhBK7GBdSLthP7ySzzqBABSECpKFXIcOZOcmhG6
	cUGDCmyj198PR5uIasWsCop4FRtdqCQjnd9Vdq4IXEhVPjIaf+cX7W7D+yFnIcJ7Z74xEZY1pwf
	1o+pnXi1i31ha+G9HvV9cUUqHsB2nmLpYHmktni6G/LhhcstBTk8bHWN7pZM728cTZAjFJVgmqh
	ra/W9/FoKckt6hoP+IM2iznkUMNW8h7Bhg8J9mDXYjVN+K3AmEe8mbLa81mhwaGxNaGGeYVzKsD
	1+SmQEQJXWwKF5z6ix+jcg4ouqIT/WWMN9scllCK94zFvfsPx5QD8S4CceDXVTHnYwBg49pjUmi
	nzmn70RuKBdTLyQR6QOdr40GqNFY3AkgqEqAlKZYC+Yi8K9nYQzkBW8aCOmerzFWc7VMJAwVi0i
	4OdiT6dxBE
X-Received: by 2002:a05:6a00:139d:b0:81f:4999:ae46 with SMTP id d2e1a72fcca58-81fa1862010mr11150464b3a.48.1768897771925;
        Tue, 20 Jan 2026 00:29:31 -0800 (PST)
Received: from [127.0.0.1] ([38.207.158.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa12b51d9sm11282275b3a.65.2026.01.20.00.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 00:29:31 -0800 (PST)
From: Zesen Liu <ftyghome@gmail.com>
Subject: [PATCH bpf-next v3 0/2] bpf: Fix memory access flags in helper
 prototypes
Date: Tue, 20 Jan 2026 16:28:45 +0800
Message-Id: <20260120-helper_proto-v3-0-27b0180b4e77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL48b2kC/42Oy2rDMBBFfyVoXRXNyHq0q/5HKUUej2JBYhnZm
 JTgf69iKGShRZd3LueeuYuFS+JFvJ/uovCWlpSnGvTLSdAYpjPLNNQsUKEBRCVHvsxcvueS1yx
 jb9l24LGzTlRkLhzT7Zj7FP0c5cS3VXzVZkzLmsvP4dng6NuTG0gl69WyGt46xOHjfA3p8kr5+
 jBUyCpQrgVBDAZ1JIr/h1h7x8qjA6In6PHyhn9vtmCscEfGYk8UTPAtI/gGFHodQGvHzphn477
 vv4pbIx6OAQAA
X-Change-ID: 20251220-helper_proto-fb6e64182467
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Shuran Liu <electronlsr@gmail.com>, Peili Gao <gplhust955@gmail.com>, 
 Haoran Ni <haoran.ni.cs@gmail.com>, Zesen Liu <ftyghome@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2372; i=ftyghome@gmail.com;
 h=from:subject:message-id; bh=W9qdqjI867EXujfA1lB2A9WGNgOq4xDjQzueH0l+Gs8=;
 b=owGbwMvMwCXWI1/u+8bXqJ3xtFoSQ2a+zeP2AzrqMZ+Od/UXpW0yPnTD7M9ON82K9WzirOE8B
 9+/kT/bUcrCIMbFICumyNL7w/Duykxz4202Cw7CzGFlAhnCwMUpABMRfMPIcMRUIvi4Qm4SF5/b
 9TBzzsW6ateP5/KXr323tiR+1+HbYowMW77VJD5x8Paoq5/0dP5Ki69VbzOVTlv1Pf09JVRJzWc
 LPwA=
X-Developer-Key: i=ftyghome@gmail.com; a=openpgp;
 fpr=8DF831DDA9693733B63CA0C18C1F774DEC4D3287

Hi,

This series adds missing memory access flags (MEM_RDONLY or MEM_WRITE) to
several bpf helper function prototypes that use ARG_PTR_TO_MEM but lack the
correct flag. It also adds a new check in verifier to ensure the flag is
specified.

Missing memory access flags in helper prototypes can lead to critical
correctness issues when the verifier tries to perform code optimization.
After commit 37cce22dbd51 ("bpf: verifier: Refactor helper access type
tracking"), the verifier relies on the memory access flags, rather than
treating all arguments in helper functions as potentially modifying the
pointed-to memory.

Using ARG_PTR_TO_MEM alone without flags does not make sense because:

- If the helper does not change the argument, missing MEM_RDONLY causes the
   verifier to incorrectly reject a read-only buffer.
- If the helper does change the argument, missing MEM_WRITE causes the
   verifier to incorrectly assume the memory is unchanged, leading to
   errors in code optimization.

We have already seen several reports regarding this:

- commit ac44dcc788b9 ("bpf: Fix verifier assumptions of bpf_d_path's
   output buffer") adds MEM_WRITE to bpf_d_path;
- commit 2eb7648558a7 ("bpf: Specify access type of bpf_sysctl_get_name
   args") adds MEM_WRITE to bpf_sysctl_get_name.

This series looks through all prototypes in the kernel and completes the
flags. It also adds check_mem_arg_rw_flag_ok() and wires it into
check_func_proto() to statically restrict ARG_PTR_TO_MEM from appearing
without memory access flags. 

Changelog
=========

v3:
  - Rebased to bpf-next to address check_func_proto() signature changes, as
    suggested by Eduard Zingerman.

v2:
  - Add missing MEM_RDONLY flags to protos with ARG_PTR_TO_FIXED_SIZE_MEM.

Thanks,

Zesen Liu

---
Zesen Liu (2):
      bpf: Fix memory access flags in helper prototypes
      bpf: Require ARG_PTR_TO_MEM with memory flag

 kernel/bpf/helpers.c     |  2 +-
 kernel/bpf/syscall.c     |  2 +-
 kernel/bpf/verifier.c    | 17 +++++++++++++++++
 kernel/trace/bpf_trace.c |  6 +++---
 net/core/filter.c        | 20 ++++++++++----------
 5 files changed, 32 insertions(+), 15 deletions(-)
---
base-commit: efad162f5a840ae178e7761c176c49f433c7bb68
change-id: 20251220-helper_proto-fb6e64182467

Best regards,
-- 
Zesen Liu <ftyghome@gmail.com>


