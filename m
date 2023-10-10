Return-Path: <bpf+bounces-11793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DCF7BF39B
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 09:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AA471C20BF1
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 07:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10258BA57;
	Tue, 10 Oct 2023 07:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFzV2OgP"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD1C63DF
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 07:02:34 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52A19E;
	Tue, 10 Oct 2023 00:02:32 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-690fa0eea3cso4774701b3a.0;
        Tue, 10 Oct 2023 00:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696921352; x=1697526152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7TlUT4iA6Enp4+NnUvxoflcvwXu+Bej6qibbzSZJLY=;
        b=AFzV2OgPcf8qKyls0ZOZc3l1Klwpfcz83sW43SmmDe2Wvbn4/MXRdrWSw0v+dDttVq
         KXihX621s3L9mbj74jppR70mlDBnNvUse5woXZPPV2zJy7dnYSTkVH6CjS3jdCzjErTr
         rNJKxD6NJFKx1sExNXIUj4pwBEpp1PfniFGpRBfDjRxEIkQPeipCNmPNZu1lsUBQKMeP
         3HvK5nWgxXCXJRtKcEh2leHkOHEUtuDwjSRrlkxI3J5G83wG2x4p5pVdtpZmC2xvVpAq
         t26/hZaHgI2ujJcZGyDZB2Quwt4ySnNAq2N58ipkqwOUQAQYrd1YkDBDg9RpQu7QkQr5
         CTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696921352; x=1697526152;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J7TlUT4iA6Enp4+NnUvxoflcvwXu+Bej6qibbzSZJLY=;
        b=lR1xwZox5MekU8MkbiEIz1q2k5BEGJFoIhASMS/atXlbWC1q6MgLF86OnhSwNhtOKS
         BJuEUOVyzBGi9E9CBEEUTbxVeqMGxVDcYUrtGnBkjAEJOCiA+eoKK1DfOmzMvsnDhaQD
         mVg+vIXvTDMuepLQakWrFQn6/+razpHqPC7A2wdu9dkjuY6v/2U1JjOj6vH0dBRpGb1F
         FxravH5+0rTcnKDxBVwvadS5U7B5a+HqIMGFNsgyyvd8K9qx5xYy18DH0NUBEP8TdClB
         1nLQlGzmCrWHrFmtbUotRi18U1fuRETNFnq8y9vTOtPxjnbnLzELOy8suSRPO4tqSZAs
         /EqQ==
X-Gm-Message-State: AOJu0YweI6/fLb9oEDyHlHNoVpqM0ZCKptMM73q1p+oWxhfIE+icg3oY
	g3duGKBAtOEZcKw2F/NbY97TlhM1kUY=
X-Google-Smtp-Source: AGHT+IEJdCgB6VlU/kck/9RNK712UtUdnMajU8Cf9zT5nkdzujAEkzTqhz64lxxFuH1tDxotuB6UMA==
X-Received: by 2002:a05:6a21:3284:b0:16b:79b3:222b with SMTP id yt4-20020a056a21328400b0016b79b3222bmr14874878pzb.34.1696921352101;
        Tue, 10 Oct 2023 00:02:32 -0700 (PDT)
Received: from localhost ([98.97.32.4])
        by smtp.gmail.com with ESMTPSA id y17-20020a056a001c9100b0068fcc7f6b00sm1236452pfw.74.2023.10.10.00.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 00:02:22 -0700 (PDT)
Date: Tue, 10 Oct 2023 00:02:15 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Hao Sun <sunhao.th@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Hao Sun <sunhao.th@gmail.com>
Message-ID: <6524f6f77b896_66abc2084d@john.notmuch>
In-Reply-To: <20231009-jmp-into-reserved-fields-v1-1-d8006e2ac1f6@gmail.com>
References: <20231009-jmp-into-reserved-fields-v1-1-d8006e2ac1f6@gmail.com>
Subject: RE: [PATCH bpf-next] Detect jumping to reserved code during
 check_cfg()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hao Sun wrote:
> Currently, we don't check if the branch-taken of a jump is reserved code of
> ld_imm64. Instead, such a issue is captured in check_ld_imm(). The verifier
> gives the following log in such case:
> 
> func#0 @0
> 0: R1=ctx(off=0,imm=0) R10=fp0
> 0: (18) r4 = 0xffff888103436000       ; R4_w=map_ptr(off=0,ks=4,vs=128,imm=0)
> 2: (18) r1 = 0x1d                     ; R1_w=29
> 4: (55) if r4 != 0x0 goto pc+4        ; R4_w=map_ptr(off=0,ks=4,vs=128,imm=0)
> 5: (1c) w1 -= w1                      ; R1_w=0
> 6: (18) r5 = 0x32                     ; R5_w=50
> 8: (56) if w5 != 0xfffffff4 goto pc-2
> mark_precise: frame0: last_idx 8 first_idx 0 subseq_idx -1
> mark_precise: frame0: regs=r5 stack= before 6: (18) r5 = 0x32
> 7: R5_w=50
> 7: BUG_ld_00
> invalid BPF_LD_IMM insn
> 
> Here the verifier rejects the program because it thinks insn at 7 is an
> invalid BPF_LD_IMM, but such a error log is not accurate since the issue
> is jumping to reserved code not because the program contains invalid insn.
> Therefore, make the verifier check the jump target during check_cfg(). For
> the same program, the verifier reports the following log:

I think we at least would want a test case for this. Also how did you create
this case? Is it just something you did manually and noticed a strange error?

> 
> func#0 @0
> jump to reserved code from insn 8 to 7
> 
> ---
> 
> 
> Signed-off-by: Hao Sun <sunhao.th@gmail.com>
> ---
>  kernel/bpf/verifier.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index eed7350e15f4..725ac0b464cf 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14980,6 +14980,7 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env,
>  {
>  	int *insn_stack = env->cfg.insn_stack;
>  	int *insn_state = env->cfg.insn_state;
> +	struct bpf_insn *insns = env->prog->insnsi;
>  
>  	if (e == FALLTHROUGH && insn_state[t] >= (DISCOVERED | FALLTHROUGH))
>  		return DONE_EXPLORING;
> @@ -14993,6 +14994,12 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env,
>  		return -EINVAL;
>  	}
>  
> +	if (e == BRANCH && insns[w].code == 0) {
> +		verbose_linfo(env, t, "%d", t);
> +		verbose(env, "jump to reserved code from insn %d to %d\n", t, w);
> +		return -EINVAL;
> +	}
> +
>  	if (e == BRANCH) {
>  		/* mark branch target for state pruning */
>  		mark_prune_point(env, w);
> 
> ---
> base-commit: 3157b7ce14bbf468b0ca8613322a05c37b5ae25d
> change-id: 20231009-jmp-into-reserved-fields-fc1a98a8e7dc
> 
> Best regards,
> -- 
> Hao Sun <sunhao.th@gmail.com>
> 

