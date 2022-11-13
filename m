Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C81626D64
	for <lists+bpf@lfdr.de>; Sun, 13 Nov 2022 02:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbiKMB7O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 12 Nov 2022 20:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbiKMB7N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 12 Nov 2022 20:59:13 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7949512095
        for <bpf@vger.kernel.org>; Sat, 12 Nov 2022 17:59:12 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id pj8-20020a17090b4f4800b002140219b2b3so6769393pjb.0
        for <bpf@vger.kernel.org>; Sat, 12 Nov 2022 17:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cwvnTT8XsFQgeMY9WLZEWiAWbNDJVRw92+nUL51hdD8=;
        b=Efc0Xvx4nHF6PidQM1BXAGJlSfe74Ey7g2l/loPFXgp23BltBxCydFqgc1F9jfSXyX
         7X6EnFZDH9wNlAnPyG3nDyGS77vV3o79GCHfoGZaTMrT7bdxXwCUwTednwxdBaw3Rpai
         akN1xDk0LuYPttGH7ziXm3lDKRrDwRdborebgIxsmWdsWOyzO4n93Tg7lE0BcArP3jc9
         TPbhA09LSn+EO2Pnic2gV50B0zzbJ6oz8VG8oU6Z6/af5qbW49dDMIGgE1d2FZ0yGmAz
         7Hf49fql8jCPiHIf5+XBRqe6FJcrgY+sb1DY4tUcuqUQJGsJlCIKFAc4fGoCxP4kfupo
         LTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cwvnTT8XsFQgeMY9WLZEWiAWbNDJVRw92+nUL51hdD8=;
        b=7fukgTmXyzCUIfZ5KGtXMz1tQI3QMaF9Hle2tRNZb7wXOIdK6eCCQQmoqqWyUHlxkm
         RFAuTcUm5R6cUsfcHanyFeridWOPuXujHf5FsVZvUTWl7ZG7oH5N/ICMeamqiMegMH4G
         +cKL37z9lOU0jpDMVxmwZ5wBIVzCkgYzHujcPUyN6daUIa5k+bEV/nIcwjcGyjNxothC
         Oqe6/6+2LA/+OZL8jUtQjoK9g9RkD+/mQvBTJYCkSzf4UMmTGPEtgRtWjVnbpX+8iEbm
         o3sw5L73ER2uA65KBpt0LUjzi9s5qx2BGWR6irOtpjYZCrzmFMCglFgbn0qoALPJ5JgB
         X2xw==
X-Gm-Message-State: ANoB5pkW/5yT+1iSuhbcIF6QQg+Z2xlAOIc1vJpSiIK2QTYkHFsT0rGK
        21FYHizBxyByoir3DvX61EGN/uk=
X-Google-Smtp-Source: AA0mqf42vWcv7kuoO9XkZIaErd8x/509BsJO8HzbMbu4lCXazV/dwMbG/0z7hDzKksj8WdlUM2bTy4Y=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:9b97:b0:186:5f71:7939 with SMTP id
 y23-20020a1709029b9700b001865f717939mr8170250plp.162.1668304751915; Sat, 12
 Nov 2022 17:59:11 -0800 (PST)
Date:   Sat, 12 Nov 2022 17:59:10 -0800
In-Reply-To: <20221111202719.982118-3-memxor@gmail.com>
Mime-Version: 1.0
References: <20221111202719.982118-1-memxor@gmail.com> <20221111202719.982118-3-memxor@gmail.com>
Message-ID: <Y3BPbmkCCQfR2xqt@google.com>
Subject: Re: [PATCH bpf v1 2/2] selftests/bpf: Add pruning test case for bpf_spin_lock
From:   sdf@google.com
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Edward Cree <ecree.xilinx@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/12, Kumar Kartikeya Dwivedi wrote:
> Test that when reg->id is not same for the same register of type
> PTR_TO_MAP_VALUE between current and old explored state, we currently
> return false from regsafe and continue exploring.

> Without the fix in prior commit, the test case fails.

> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
>   .../selftests/bpf/verifier/spin_lock.c        | 39 +++++++++++++++++++
>   1 file changed, 39 insertions(+)

> diff --git a/tools/testing/selftests/bpf/verifier/spin_lock.c  
> b/tools/testing/selftests/bpf/verifier/spin_lock.c
> index 781621facae4..0a8dcfc37fc6 100644
> --- a/tools/testing/selftests/bpf/verifier/spin_lock.c
> +++ b/tools/testing/selftests/bpf/verifier/spin_lock.c
> @@ -331,3 +331,42 @@
>   	.errstr = "inside bpf_spin_lock",
>   	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
>   },
> +{
> +	"spin_lock: regsafe compare reg->id for map value",
> +	.insns = {
> +	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
> +	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_6, offsetof(struct __sk_buff,  
> mark)),
> +	BPF_LD_MAP_FD(BPF_REG_1, 0),
> +	BPF_MOV64_REG(BPF_REG_9, BPF_REG_1),
> +	BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0),
> +	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
> +	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
> +	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
> +	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
> +	BPF_EXIT_INSN(),
> +	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
> +	BPF_MOV64_REG(BPF_REG_1, BPF_REG_9),
> +	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
> +	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
> +	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
> +	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
> +	BPF_EXIT_INSN(),
> +	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
> +	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
> +	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
> +	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
> +	BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 1),
> +	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
> +	BPF_MOV64_REG(BPF_REG_7, BPF_REG_8),
> +	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
> +	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
> +	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
> +	BPF_MOV64_IMM(BPF_REG_0, 0),
> +	BPF_EXIT_INSN(),
> +	},
> +	.fixup_map_spin_lock = { 2 },
> +	.result = REJECT,
> +	.errstr = "bpf_spin_unlock of different lock",
> +	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
> +	.flags = BPF_F_TEST_STATE_FREQ,
> +},
> --
> 2.38.1

