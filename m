Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0456761FFD7
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 21:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbiKGUwO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 15:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbiKGUwN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 15:52:13 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8551427176;
        Mon,  7 Nov 2022 12:52:12 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id r14so19534159edc.7;
        Mon, 07 Nov 2022 12:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uw4Vs7V4/db0GHoTeanpNzIRHKp6KNfFs3tBhi1t9+c=;
        b=Y22KOS3q31AOjnyWsz4u2EVdUM/ELgOvBXEQihO6s1ZqHGew1qTCJ2e+breRRHvTVz
         BlwSf4IYUMpSbfNC0fYx0kdH1gwCRVAPpb5D8iOlMZJUElgQYYSdpx9kB04z8ua3Hkdu
         D06KrvPUcx6ywKBPxTLvxTDkzyw2agjQBEi97QGZqsfsP9O0HxKBh3Ryl1WaDwpwV+xM
         QiTM4sGvCThd9BKrubYMaeIy5P6VkkIM4szsATpZh7ThC+9YH/GdU/aoGzfgkhSO9B4f
         lEMDkiv2xYX3PXfGG76mz7JNmw576050FLsNbdHt4cP6eOjRTGPDqaX6nr+SorrLuVFs
         afwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uw4Vs7V4/db0GHoTeanpNzIRHKp6KNfFs3tBhi1t9+c=;
        b=Sq36mjWReRXtdeo1WfUPbdv1CKonObAPIxC4Bpt6h9/2oX7SCRulKiyFVZFt4pNr1M
         sXizvHqBScCgahKx77H3lTFB3d4jxQnfl7psjgosg5ZRxHQp4QngPaIrnkKlqhKLEby7
         FdUq8sF56z7gvEnpoWH6BZh9sJNkElyj0wuvCZ8nw0ePAQd4/iHQLlWUELI7sZ8Et5jb
         19fsvqbKHIKghm/vFTqYhEdCvaOtzowWuL5lujDoh2U8bbruOk27je4GYsocXsFmBe2B
         K9FNJLGsYWXzLYvwSWEdG778Xgas45xhGk0Q3J2QknQsluCjlVcvO+wX1+3othOMvR5J
         1KwA==
X-Gm-Message-State: ACrzQf3AnJ+809q0hTIYFDfxe6rh0Ap5/cD16wHjAaskRVqlvwqDmAZJ
        rrqpG0LYyUiuG+lYTDyGHn5lHzVtujGWFidwRLY=
X-Google-Smtp-Source: AMsMyM57cLd5i+vKoebyI8Ryrlhm9wyaIxjBLTQVzSCYGrMC+CnckRjZIzUuih4MWFOcgwsG9i6z0CCTROPBJSjQZhk=
X-Received: by 2002:a05:6402:2791:b0:461:c5b4:d114 with SMTP id
 b17-20020a056402279100b00461c5b4d114mr51485078ede.357.1667854330945; Mon, 07
 Nov 2022 12:52:10 -0800 (PST)
MIME-Version: 1.0
References: <CACkBjsaRPHUpfST=3-FTWbQycHsNgvWyVFpCLkJEwcrLhSZfnQ@mail.gmail.com>
In-Reply-To: <CACkBjsaRPHUpfST=3-FTWbQycHsNgvWyVFpCLkJEwcrLhSZfnQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 7 Nov 2022 12:51:59 -0800
Message-ID: <CAADnVQLev0xX3wHm-dgD-eJcV0vkuvZ0Tm=X_P68qcUabKw8eA@mail.gmail.com>
Subject: Re: BUG in BPF verifier, 10 insns costs 2 mins+ to load
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, ong@kernel.org,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Nov 6, 2022 at 8:26 PM Hao Sun <sunhao.th@gmail.com> wrote:
>
> Hi,
>
> I've just written a BPF verifier fuzzer, targeting logic bugs in the
> BPF verifier.
> The following is an abnormal case it generated. The case only contains 10
> BPF instructions but costs more than 2 mins to load on :

with full verbose verifier logging, right?
That is expected for any prog that is going to hit the 1M insn limit.

>     HEAD commit: f0c4d9fc9cc9 Linux 6.1-rc4
>     git tree: upstream
>     kernel config: https://pastebin.com/raw/SBxaikiG
>     C reproducer: https://pastebin.com/raw/HsDXdraZ
>     verifier log: https://pastebin.com/raw/sNmSsVxs
>
> Ideally, the verifier should exit quickly in this case, since R2=42
> always holds.
> The behaviour of the verifier does not make sense to me, seems it lost
> the range information of R2.
>
> Please point out if I missed anything, the C reproducer in the link
> (https://pastebin.com/raw/HsDXdraZ)
> essentially loads the following case into `test_verifier.c`:
> {
> "BVF verifier test",
> .insns = {
> BPF_MOV64_IMM(BPF_REG_1, 42),
> BPF_MOV64_IMM(BPF_REG_2, 0),
> BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
> BPF_EXIT_INSN(),
> BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1),
> BPF_ALU32_IMM(BPF_DIV, BPF_REG_2, 1),
> BPF_ALU64_IMM(BPF_SUB, BPF_REG_1, 108),
> BPF_JMP32_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, -3),
> BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
> BPF_EXIT_INSN(),
> },
> .prog_type = BPF_PROG_TYPE_XDP,
> },
>
> The verifier's log is more then 4M, but essentially is:
>     0: R1=ctx(off=0,imm=0) R10=fp0
>     0: (b7) r1 = 42                       ; R1_w=P42
>     1: (b7) r2 = 0                        ; R2_w=P0
>     2: (85) call pc+1
>     caller:
>      R10=fp0
>     callee:
>      frame1: R1_w=P42 R2_w=P0 R10=fp0
>     4: (57) r2 &= -52                     ; frame1: R2_w=P0
>     5: (0f) r2 += r1                      ; frame1: R1_w=P42 R2_w=P42
>     6: (34) w2 /= 1                       ; frame1:
> R2_w=Pscalar(umax=4294967295,var_off=(0x0; 0xffffffff))
>     7: (17) r1 -= 108                     ; frame1: R1_w=P-66
>     8: (2e) if w1 > w2 goto pc-3 6: frame1: R1_w=P-66
> R2_w=Pscalar(umax=4294967229,var_off=(0x0; 0xffffffff)) R10=fp0
>     6: (34) w2 /= 1                       ; frame1:
> R2_w=Pscalar(umax=4294967295,var_off=(0x0; 0xffffffff))
>     7: (17) r1 -= 108                     ; frame1: R1_w=P-174
>     8: (2e) if w1 > w2 goto pc-3 6: frame1: R1_w=P-174
> R2_w=Pscalar(umax=4294967121,var_off=(0x0; 0xffffffff)) R10=fp0
>     6: (34) w2 /= 1                       ; frame1:
> R2_w=Pscalar(umax=4294967295,var_off=(0x0; 0xffffffff))
>     7: (17) r1 -= 108                     ; frame1: R1=P-282
>     8: (2e) if w1 > w2 goto pc-3 6: frame1: R1=P-282
> R2=Pscalar(umax=4294967013,var_off=(0x0; 0xffffffff)) R10=fp0
>     ...
>     6: (34) w2 /= 1                       ; frame1:
> R2_w=Pscalar(umax=4294967295,var_off=(0x0; 0xffffffff))
>     7: (17) r1 -= 108                     ; frame1: R1_w=P-6342690
>     8: (2e) if w1 > w2 goto pc-3 6: frame1: R1_w=P-6342690
> R2_w=Pscalar(umax=4288624605,var_off=(0x0; 0xffffffff)) R10=fp0
>     6: (34) w2 /= 1                       ; frame1:
> R2_w=Pscalar(umax=4294967295,var_off=(0x0; 0xffffffff))
>     7: (17) r1 -= 108                     ; frame1: R1_w=P-6342798
>     8: (2e) if w1 > w2 goto pc-3          ; frame1: R1_w=P-6342798
> R2_w=Pscalar(umin=4288624498,umax=4294967295,var_off=(0xff800000;
> 0x7fffff),s32_min=-6342798,s32_max=-1)
>     9: (bf) r0 = r2                       ; frame1:
> R0_w=Pscalar(id=58730,umin=4288624498,umax=4294967295,var_off=(0xff800000;
> 0x7fffff),s32_min=-6342798,s32_max=-1)
> R2_w=Pscalar(id=58730,umin=4288624498,umax=4294967295,var_off=(0xff800000;
> 0x7fffff),s32_min=-6342798,s32_max=-1)
>     10: (95) exit
>     returning from callee:
>      frame1: R0_w=Pscalar(id=58730,umin=4288624498,umax=4294967295,var_off=(0xff800000;
> 0x7fffff),s32_min=-6342798,s32_max=-1) R1_w=P-6342798
> R2_w=Pscalar(id=58730,umin=4288624498,umax=4294967295,var_off=(0xff800000;
> 0x7fffff),s32_min=-6342798,s32_max=-1) R10=fp0
>     to caller at 3:
>      R0_w=Pscalar(id=58730,umin=4288624498,umax=429496
