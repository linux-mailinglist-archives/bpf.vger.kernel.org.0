Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B81564766
	for <lists+bpf@lfdr.de>; Sun,  3 Jul 2022 15:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiGCNM0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Jul 2022 09:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiGCNMZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Jul 2022 09:12:25 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AD76361
        for <bpf@vger.kernel.org>; Sun,  3 Jul 2022 06:12:23 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e28so9754067wra.0
        for <bpf@vger.kernel.org>; Sun, 03 Jul 2022 06:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=b2qZjru2AawbgH9jyJa3uiCOU1FEJ+Z4cEYmO5LMBTI=;
        b=Vqo0MXFxvrz0CdYVFug56sJ0ZOEnGDrO/jKRHUiIHMmO5KoJf/kNYRSR9U7CeI/etA
         NO3vH4GS3TfaGrKbzumHWt/WrwE3XH6Ak0LfGPAD9mSBJ3unOdk0cO3+j+rariAvDLfr
         PceDbxaeUXLc2LbQaxVcfFvWWHMnRlgrZBUeFzBFHRZtJW6XfqAsR5bCy+YKOciDZ+0G
         NRYE5lhGEgTZMyfo+UmSD/Yxmj0nR/bPx7OWuNI6FWHH+MJypRrx7o0c3AqKH7jO4a/l
         uKY7FLfyt9rAD7cMEvf9Or882hrIfuprgqBti8ijLZD4YRDsRSsQjzMwye7SvL9nWtHe
         lNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=b2qZjru2AawbgH9jyJa3uiCOU1FEJ+Z4cEYmO5LMBTI=;
        b=7a3JOC4xEtDepNCkq7ehB+qiN8XvlP5q1S0Vv0OJvC8WAq0aSa2fq0URS+S9DfZBlM
         BUy5dWaQa8Typm9p5RVOMlkrNoDg7m7GI4M3ClLhXiYwbScIh1xBx+GpkxqyVpxC5ZMm
         HeMkOc63p19x8hAX4Tqfmvt+Fjo8xSgka7i87mrm02wD93T/4cY5q+ZKhvMP1S+YAVuw
         Tc0z8PmoYKaJ5orbDFusLGa78dffjTGQ5yrzHtGqGJubSDtpoctBkDCNL5+bT3nODw86
         ZvP0tzfLyOIVwzkF/ssUkPZQfnj6hgxnAcPBuolw17pZHlDJs7mhcIOeVTT5XOdk/IhX
         XsmQ==
X-Gm-Message-State: AJIora/cuoXW/+IIHpLlYhzG+814QaXDSdGAxN4de+vcCSGf/ZDce44u
        YwR5DaVL8sDhokHKNNR92IDEtA==
X-Google-Smtp-Source: AGRyM1uXArjvOOMo1FwzrB3m4V1RuMD/HIns9AME3FbmZRXJYIgUQQRLJuq4YI4OHIaEVsz16Zt6kw==
X-Received: by 2002:adf:fb08:0:b0:21b:af81:2ffd with SMTP id c8-20020adffb08000000b0021baf812ffdmr22820107wrr.685.1656853941578;
        Sun, 03 Jul 2022 06:12:21 -0700 (PDT)
Received: from [192.168.2.222] ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id h13-20020adff4cd000000b002103aebe8absm27452656wrp.93.2022.07.03.06.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jul 2022 06:12:21 -0700 (PDT)
Message-ID: <c373eec7-2cc4-a41d-916c-f073aba5494b@conchuod.ie>
Date:   Sun, 3 Jul 2022 14:12:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] RISC-V/bpf: Enable bpf_probe_read{, str}()
Content-Language: en-US
To:     Yixun Lan <dlan@gentoo.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20220703130924.57240-1-dlan@gentoo.org>
From:   Conor Dooley <mail@conchuod.ie>
In-Reply-To: <20220703130924.57240-1-dlan@gentoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/07/2022 14:09, Yixun Lan wrote:
> Enable this option to fix a bcc error in RISC-V platform
> 
> And, the error shows as follows:
> 
> ~ # runqlen
> WARNING: This target JIT is not designed for the host you are running. \
> If bad things happen, please choose a different -march switch.
> bpf: Failed to load program: Invalid argument
> 0: R1=ctx(off=0,imm=0) R10=fp0
> 0: (85) call bpf_get_current_task#35          ; R0_w=scalar()
> 1: (b7) r6 = 0                        ; R6_w=0
> 2: (7b) *(u64 *)(r10 -8) = r6         ; R6_w=P0 R10=fp0 fp-8_w=00000000
> 3: (07) r0 += 312                     ; R0_w=scalar()
> 4: (bf) r1 = r10                      ; R1_w=fp0 R10=fp0
> 5: (07) r1 += -8                      ; R1_w=fp-8
> 6: (b7) r2 = 8                        ; R2_w=8
> 7: (bf) r3 = r0                       ; R0_w=scalar(id=1) R3_w=scalar(id=1)
> 8: (85) call bpf_probe_read#4
> unknown func bpf_probe_read#4
> processed 9 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
> 
> Traceback (most recent call last):
>   File "/usr/lib/python-exec/python3.9/runqlen", line 187, in <module>
>     b.attach_perf_event(ev_type=PerfType.SOFTWARE,
>   File "/usr/lib/python3.9/site-packages/bcc/__init__.py", line 1228, in attach_perf_event
>     fn = self.load_func(fn_name, BPF.PERF_EVENT)
>   File "/usr/lib/python3.9/site-packages/bcc/__init__.py", line 522, in load_func
>     raise Exception("Failed to load BPF program %s: %s" %
> Exception: Failed to load BPF program b'do_perf_event': Invalid argument
> 
> Signed-off-by: Yixun Lan <dlan@gentoo.org>

Do you know what commit this fixes?
Thanks,
Conor.

> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 32ffef9f6e5b4..da0016f1be6ce 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -25,6 +25,7 @@ config RISCV
>  	select ARCH_HAS_GIGANTIC_PAGE
>  	select ARCH_HAS_KCOV
>  	select ARCH_HAS_MMIOWB
> +	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>  	select ARCH_HAS_PTE_SPECIAL
>  	select ARCH_HAS_SET_DIRECT_MAP if MMU
>  	select ARCH_HAS_SET_MEMORY if MMU
