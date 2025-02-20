Return-Path: <bpf+bounces-52023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F99DA3CE9A
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 02:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62C2B3AD019
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 01:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9E41C1F07;
	Thu, 20 Feb 2025 01:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lFQm5esG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74FD1B423C
	for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 01:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740014485; cv=none; b=TxO7k1SvHjDkZML/FNb4BJt5x2lo2LKXBbMlyMzsh9Bas0Tf6VsvNSLxpzV/wm7PQQfFckR6NparjzdE2Wo9WlHYsffnxbDxX8Y3aqp05Mtx/sSXKk1oci6EdLqt4nGtybanFsIL0O7WKUrWx/w69tpvfKyiAKK2ibC6CUb3BLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740014485; c=relaxed/simple;
	bh=naOgejgL5qt+vPzbgEHxGefAA7ItWVic+i9Fp/7SJCY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qraB4FkXu0MRvezjxg8xqvjhADAVYfee7Z6HZNc9526nEaoTkfrG78vTb9UuT51/LPa5rn2Of+H5powXpxbnKdxKc8Fb8RH29E8Gh2MnyTD+QZSMqi5hbukdzSWU/wSOjsH42dCwhgA8jdNEDQteAbM7lopomsBQn3eRCL1ZGZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lFQm5esG; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2bc8670f78aso110983fac.3
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 17:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740014483; x=1740619283; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hei31XB5q84gJBI2emRDlm0CWOqQ1amJYg+XT3qGNfs=;
        b=lFQm5esGjCXiotAtcIcw6jvQ7qxopNXzwqivydMc4EshMwetjI+WwOOaXJej1UTHfS
         a3kqXjQtOFHq/uNH/saSpKeHT5wJE2fjpmxYOzfCwF8gkYVMMti+P28yk0XDW1QupW9n
         /SKEGnZJIh4APyrXQ/6WjO+SJ9uh5fkf7fjqtZBC4OU34qk/E+t3Z5phwdnoTTIXcnbF
         QoZCL7dWT6mCgLjT8MXNOspUuF9MhuCJiUejQ0swxgjG1nzHoIDRaEkZmjFrNMmoR1aw
         7sJ1GXUiRMSgBAjVlLxcJeluthI3O7k1qWJpY21FmRszBOt4vkfPr+VrQFwjeMegrqRz
         1ypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740014483; x=1740619283;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hei31XB5q84gJBI2emRDlm0CWOqQ1amJYg+XT3qGNfs=;
        b=AoI2rRDgQoFPyjwaydWZGtsl1tRSbKOmTLX2mvStUmMtu+qLo0On1C2EEAIrwh2E3U
         HYYSvRXQKcaTlR2Y2GG9QZfyio4fHchzSLi67aknUWGjh33G/sDjoaWUI3E2qPXs+HFl
         7ILdoFODXLns/Bbxfj0ZALBxFLpUHU2fTEdP3f/chzw0qKLG+QvdJgNzWOa0HCxyl/L5
         LCI6BmT1gH42+qA7cEnxv5yVE6UgULLOs283jRP5/KGp6mf7Vh5eZy2eoXJ+ggSYIUev
         MsUlYmjhpiM+N+hacz3JTKX3XFvXtY3uRnKuZ8I36N/qOC4tGQCw2r+ZD/TNGtC1col/
         g5/g==
X-Gm-Message-State: AOJu0YxvoYplU65IHbI9ZSv8duopDejJiWeBpbqshcd4R1Oygf/iYJ7W
	yVyyNGqWh0Eqsn6B5VmdyNQUWxAlpFSoR8Bef2Ek+VX0Yjm97TzqQp1jfktU4sLbBxZGcveleq+
	/7RQEH/nuUXk+gVgIbYbgrYpfsQOJ9EbIkvAEPOgM45agAZTvF3vLFl7y/76YrrRH7W5ykQeZ7Z
	F+oJRjPu7gzEC8aepMlUtbOhbGZVXuAEzaw4+FKjo=
X-Google-Smtp-Source: AGHT+IGd2vxuU1amb7+qDvbCnYAoKOoMiZRrGABm5B0rQidw0j6221m951cHdyKwGYS7pdZw4DijvpwPVgm+Og==
X-Received: from oablm17.prod.google.com ([2002:a05:6870:3d91:b0:2bc:69a2:abd1])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6870:fbaa:b0:29e:5de2:cffb with SMTP id 586e51a60fabf-2bc99b721admr13444186fac.17.1740014482734;
 Wed, 19 Feb 2025 17:21:22 -0800 (PST)
Date: Thu, 20 Feb 2025 01:21:19 +0000
In-Reply-To: <cover.1740009184.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1740009184.git.yepeilin@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <6888a87af6ea47ea29d429b91a57cb146d1f69c8.1740009184.git.yepeilin@google.com>
Subject: [PATCH bpf-next v3 5/9] arm64: insn: Add BIT(23) to {load,store}_ex's mask
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Peilin Ye <yepeilin@google.com>, bpf@ietf.org, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, David Vernet <void@manifault.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Yingchi Long <longyingchi24s@ict.ac.cn>, 
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>, 
	Benjamin Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We are planning to add load-acquire (LDAR{,B,H}) and store-release
(STLR{,B,H}) instructions to insn.{c,h}; add BIT(23) to mask of load_ex
and store_ex to prevent aarch64_insn_is_{load,store}_ex() from returning
false-positives for load-acquire and store-release instructions.

Reference: Arm Architecture Reference Manual (ARM DDI 0487K.a,
           ID032224),

  * C6.2.228 LDXR
  * C6.2.165 LDAXR
  * C6.2.161 LDAR
  * C6.2.393 STXR
  * C6.2.360 STLXR
  * C6.2.353 STLR

Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 arch/arm64/include/asm/insn.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index e390c432f546..2d8316b3abaf 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -351,8 +351,8 @@ __AARCH64_INSN_FUNCS(ldr_imm,	0x3FC00000, 0x39400000)
 __AARCH64_INSN_FUNCS(ldr_lit,	0xBF000000, 0x18000000)
 __AARCH64_INSN_FUNCS(ldrsw_lit,	0xFF000000, 0x98000000)
 __AARCH64_INSN_FUNCS(exclusive,	0x3F800000, 0x08000000)
-__AARCH64_INSN_FUNCS(load_ex,	0x3F400000, 0x08400000)
-__AARCH64_INSN_FUNCS(store_ex,	0x3F400000, 0x08000000)
+__AARCH64_INSN_FUNCS(load_ex,	0x3FC00000, 0x08400000)
+__AARCH64_INSN_FUNCS(store_ex,	0x3FC00000, 0x08000000)
 __AARCH64_INSN_FUNCS(mops,	0x3B200C00, 0x19000400)
 __AARCH64_INSN_FUNCS(stp,	0x7FC00000, 0x29000000)
 __AARCH64_INSN_FUNCS(ldp,	0x7FC00000, 0x29400000)
-- 
2.48.1.601.g30ceb7b040-goog


