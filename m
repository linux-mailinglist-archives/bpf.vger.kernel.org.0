Return-Path: <bpf+bounces-1085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C94070D9F4
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 12:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CBD2281299
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 10:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7810B1EA7C;
	Tue, 23 May 2023 10:06:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497071E501
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 10:06:56 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1F494
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 03:06:53 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-510ea8d0bb5so1044708a12.0
        for <bpf@vger.kernel.org>; Tue, 23 May 2023 03:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1684836412; x=1687428412;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=2wIg9RHGPcv4RTIyxfMtnu/Hi4Bm5KU5/UJUYFTe5tc=;
        b=IwdiSYO9U6n83Gkv92odzbjAJxZhHUMlBJOPkXFU08NDP7JObD3UiodCVlEtuIGGWL
         Qj3GD7mkXFMcc0D/jEYe3I83CsaKTg6Wb2fwJ0kTkfVc4s2jNDfIJ4p4J2Ey7y15J2Fp
         TMVOWdOc+nKZF4hbZN2J6qTlE4WiLizHJjYU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684836412; x=1687428412;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wIg9RHGPcv4RTIyxfMtnu/Hi4Bm5KU5/UJUYFTe5tc=;
        b=SwHrcu/McM1jimClJNMGKcpqfemumtAzc9q51arejS6UPGhHAQpEXo4X5wrJBjQyv0
         hmAFrPsRHnYfzyEBuzmOqJB0qxR5TrnqB4w6gSyrNh/uJD2BTdQ8yrHMK3jxNRqLnHmK
         kr6S73WaAHphX0sW/YAl9sGusOfIsS3FVOcUhZ0U1Q6+fovcDcxUaf7aRP1G0xcu1MPK
         +w3pA13MmMSaWDrZ6Z3nWf3TBxUB8rdvymc9W/AaDAAcsx7R2ACjgxEM2PFGIQ6XxjRA
         R7xXApRyuAM22QnoKtF+gIRcVNtqkjPCpuT5jlZ1jjwHzHC0QUeYAHLTr+rsFzZ0gp4d
         V5aA==
X-Gm-Message-State: AC+VfDyjyZAPi547mYFOpBZ2xw4RBvPR4eylpBN6ltqwAUG5LuHO+LeP
	V2fJRKHdft7xaiWm6/aqcGBUVQ==
X-Google-Smtp-Source: ACHHUZ6ZIuyMY9NnMYOnTwIF5UF5Frr/J9aPqXwyKPkbzeFkgL0GsuDfvWbz3hsurTOM6MUlFiTUOA==
X-Received: by 2002:a05:6402:160d:b0:510:a5a1:b36d with SMTP id f13-20020a056402160d00b00510a5a1b36dmr10595783edv.33.1684836412361;
        Tue, 23 May 2023 03:06:52 -0700 (PDT)
Received: from cloudflare.com (79.184.126.163.ipv4.supernova.orange.pl. [79.184.126.163])
        by smtp.gmail.com with ESMTPSA id r10-20020a056402034a00b0050c03520f68sm3909742edw.71.2023.05.23.03.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 03:06:51 -0700 (PDT)
References: <20230523025618.113937-1-john.fastabend@gmail.com>
 <20230523025618.113937-15-john.fastabend@gmail.com>
User-agent: mu4e 1.6.10; emacs 28.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: daniel@iogearbox.net, bpf@vger.kernel.org, netdev@vger.kernel.org,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, will@isovalent.com
Subject: Re: [PATCH bpf v10 14/14] bpf: sockmap, test progs verifier error
 with latest clang
Date: Tue, 23 May 2023 12:00:07 +0200
In-reply-to: <20230523025618.113937-15-john.fastabend@gmail.com>
Message-ID: <87wn0z5pl1.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, May 22, 2023 at 07:56 PM -07, John Fastabend wrote:
> With a relatively recent clang (7090c10273119) and with this commit
> to fix warnings in selftests (c8ed668593972) that uses __sink(err)
> to resolve unused variables. We get the following verifier error.
>
> root@6e731a24b33a:/host/tools/testing/selftests/bpf# ./test_sockmap
> libbpf: prog 'bpf_sockmap': BPF program load failed: Permission denied
> libbpf: prog 'bpf_sockmap': -- BEGIN PROG LOAD LOG --
> 0: R1=ctx(off=0,imm=0) R10=fp0
> ; op = (int) skops->op;
> 0: (61) r2 = *(u32 *)(r1 +0)          ; R1=ctx(off=0,imm=0) R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
> ; switch (op) {
> 1: (16) if w2 == 0x4 goto pc+5        ; R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
> 2: (56) if w2 != 0x5 goto pc+15       ; R2_w=5
> ; lport = skops->local_port;
> 3: (61) r2 = *(u32 *)(r1 +68)         ; R1=ctx(off=0,imm=0) R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
> ; if (lport == 10000) {
> 4: (56) if w2 != 0x2710 goto pc+13 18: R1=ctx(off=0,imm=0) R2=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R10=fp0
> ; __sink(err);
> 18: (bc) w1 = w0
> R0 !read_ok
> processed 18 insns (limit 1000000) max_states_per_insn 0 total_states 2 peak_states 2 mark_read 1
> -- END PROG LOAD LOG --
> libbpf: prog 'bpf_sockmap': failed to load: -13
> libbpf: failed to load object 'test_sockmap_kern.bpf.o'
> load_bpf_file: (-1) No such file or directory
> ERROR: (-1) load bpf failed
> libbpf: prog 'bpf_sockmap': BPF program load failed: Permission denied
> libbpf: prog 'bpf_sockmap': -- BEGIN PROG LOAD LOG --
> 0: R1=ctx(off=0,imm=0) R10=fp0
> ; op = (int) skops->op;
> 0: (61) r2 = *(u32 *)(r1 +0)          ; R1=ctx(off=0,imm=0) R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
> ; switch (op) {
> 1: (16) if w2 == 0x4 goto pc+5        ; R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
> 2: (56) if w2 != 0x5 goto pc+15       ; R2_w=5
> ; lport = skops->local_port;
> 3: (61) r2 = *(u32 *)(r1 +68)         ; R1=ctx(off=0,imm=0) R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
> ; if (lport == 10000) {
> 4: (56) if w2 != 0x2710 goto pc+13 18: R1=ctx(off=0,imm=0) R2=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R10=fp0
> ; __sink(err);
> 18: (bc) w1 = w0
> R0 !read_ok
> processed 18 insns (limit 1000000) max_states_per_insn 0 total_states 2 peak_states 2 mark_read 1
> -- END PROG LOAD LOG --
> libbpf: prog 'bpf_sockmap': failed to load: -13
> libbpf: failed to load object 'test_sockhash_kern.bpf.o'
> load_bpf_file: (-1) No such file or directory
> ERROR: (-1) load bpf failed
> libbpf: prog 'bpf_sockmap': BPF program load failed: Permission denied
> libbpf: prog 'bpf_sockmap': -- BEGIN PROG LOAD LOG --
> 0: R1=ctx(off=0,imm=0) R10=fp0
> ; op = (int) skops->op;
> 0: (61) r2 = *(u32 *)(r1 +0)          ; R1=ctx(off=0,imm=0) R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
> ; switch (op) {
> 1: (16) if w2 == 0x4 goto pc+5        ; R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
> 2: (56) if w2 != 0x5 goto pc+15       ; R2_w=5
> ; lport = skops->local_port;
> 3: (61) r2 = *(u32 *)(r1 +68)         ; R1=ctx(off=0,imm=0) R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
> ; if (lport == 10000) {
> 4: (56) if w2 != 0x2710 goto pc+13 18: R1=ctx(off=0,imm=0) R2=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R10=fp0
> ; __sink(err);
> 18: (bc) w1 = w0
> R0 !read_ok
> processed 18 insns (limit 1000000) max_states_per_insn 0 total_states 2 peak_states 2 mark_read 1
> -- END PROG LOAD LOG --
>
> To fix simply remove the err value because its not actually used anywhere
> in the testing. We can investigate the root cause later. Future patch should
> probably actually test the err value as well. Although if the map updates
> fail they will get caught eventually by userspace.
>
> Fixes: c8ed668593972 ("selftests/bpf: fix lots of silly mistakes pointed out by compiler")
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---

I think the problem is that err is not initialized when we hit the default
switch branch. And __sink() generates a read.

Since we don't really consume the error value, this fix LGTM.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

