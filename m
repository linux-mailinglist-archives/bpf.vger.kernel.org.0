Return-Path: <bpf+bounces-13803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E1E7DE1CA
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 14:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8EA7281312
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 13:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8780A134CD;
	Wed,  1 Nov 2023 13:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Osfx+K2g"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0637489
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 13:56:47 +0000 (UTC)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D2D102;
	Wed,  1 Nov 2023 06:56:46 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-da2b9234a9fso4494675276.3;
        Wed, 01 Nov 2023 06:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698847005; x=1699451805; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+yzQj0RPB9P3n6Qwul4am9clWs3GiZYO1kyhQz5cK1w=;
        b=Osfx+K2gQNayvuHziBP9OY/dhFAHAPXp9P4ErXVCXtLwAIGHBHuRO320+mez+AjYYP
         g2uBlSdrl/nwR0GyQ1aGOtqle4gBef9gx5p9+wlYuLdUgcVBpkXNEV1pgwgRHqnf1s5K
         rwCNNn2a7R24JuOLCnR7WnFP03vqhXpw90f4trkm1jtAGQRQyf+8w+wCu8lcADt1bQ7r
         hgm+xYGZyyl8v5K5qpp06mUE/7GEIacypbW9g8d6aMi/q4EoE6MWdCoMVaMY+DcUaLAU
         rxzTvODcCGtVFciNBB0U5dEPej5RQiC7xZdEbViWw2GlpfZ9n9jRE+SU+Z0nIjHW1qXV
         biwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698847005; x=1699451805;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+yzQj0RPB9P3n6Qwul4am9clWs3GiZYO1kyhQz5cK1w=;
        b=aFM8PH4JwqbcfDgS+tl9vt3RiYFeWseP8WZhSnglVnyK0KgwF89+wkA6xkqaMGYThW
         VCiMoWAvBmkk3Dt2j1WaSiN7NNArCdH9sg0GB8CeXOKGHb9zFcKnDGCYogDYtSAN/zh1
         n3vc2DKs/iA8+cxzCGxyYBh4JHxlIYnvCu/a9kGG3ABsw10RCsE0w/RBznBJoYaQcjl8
         /M7QGu01OHfm2c8Ubz1X6ncmyRiROccISczOc6g0NVKhJErZGNkzfhCaVsx8m01FfUrC
         UFKQj91+3tr7yIpRICedZlIVz+IrMfv5uT0q+geCIgi9/7Nc0oOzc4STj+Fq2i4j0VWv
         jUWQ==
X-Gm-Message-State: AOJu0YzU5ZMfeF/lPLbhxs6kNvt7FkgbImlqr3ehODf8eWsa72+T7rff
	5wZ/jnPZk5rQVCTUm6up63vRAgCOHgYfDEUOuQ==
X-Google-Smtp-Source: AGHT+IG8OT/aPb+YD5fmyru6znQxDBGEj56fps4ehM2NQ/K5TG8vM4JwTwp9jgTGCkJ+xpBoKSyogKS3vN2dlYxjqow=
X-Received: by 2002:a25:b790:0:b0:da1:5a1a:e79c with SMTP id
 n16-20020a25b790000000b00da15a1ae79cmr10500772ybh.50.1698847005123; Wed, 01
 Nov 2023 06:56:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hao Sun <sunhao.th@gmail.com>
Date: Wed, 1 Nov 2023 14:56:34 +0100
Message-ID: <CACkBjsY3vMLVVO0zHd+CRcQPdykDhXv8-f2oD82+Jk5KJpq_8w@mail.gmail.com>
Subject: bpf: incorrectly reject program with `back-edge insn from 7 to 8`
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

The verifier incorrectly rejects the following prog in check_cfg() when
loading with root with confusing log `back-edge insn from 7 to 8`:
  /* 0: r9 = 2
   * 1: r3 = 0x20
   * 2: r4 = 0x35
   * 3: r8 = r4
   * 4: goto+3
   * 5: r9 -= r3
   * 6: r9 -= r4
   * 7: r9 -= r8
   * 8: r8 += r4
   * 9: if r8 < 0x64 goto-5
   * 10: r0 = r9
   * 11: exit
   * */
  BPF_MOV64_IMM(BPF_REG_9, 2),
  BPF_MOV64_IMM(BPF_REG_3, 0x20),
  BPF_MOV64_IMM(BPF_REG_4, 0x35),
  BPF_MOV64_REG(BPF_REG_8, BPF_REG_4),
  BPF_JMP_IMM(BPF_JA, 0, 0, 3),
  BPF_ALU64_REG(BPF_SUB, BPF_REG_9, BPF_REG_3),
  BPF_ALU64_REG(BPF_SUB, BPF_REG_9, BPF_REG_4),
  BPF_ALU64_REG(BPF_SUB, BPF_REG_9, BPF_REG_8),
  BPF_ALU64_REG(BPF_ADD, BPF_REG_8, BPF_REG_4),
  BPF_JMP32_IMM(BPF_JLT, BPF_REG_8, 0x68, -5),
  BPF_MOV64_REG(BPF_REG_0, BPF_REG_9),
  BPF_EXIT_INSN()

-------- Verifier Log --------
func#0 @0
back-edge from insn 7 to 8
processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0
peak_states 0 mark_read 0

This is not intentionally rejected, right?

Best
Hao

