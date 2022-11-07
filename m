Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCB561EA2F
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 05:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiKGE0X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 6 Nov 2022 23:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiKGE0M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 6 Nov 2022 23:26:12 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B01111A23;
        Sun,  6 Nov 2022 20:26:11 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-36ad4cf9132so93628097b3.6;
        Sun, 06 Nov 2022 20:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hTwEdJ6Q5b7fJb+x3X+z0isTFJ/JKgG4BXZ2DTVYqdY=;
        b=gdQ9k0zUTVW7tp99OrZdjhE6eMIp4gund8VnOWplDrON6vWqeMM07Eyhmof+kYfS4y
         DfQtHx555kCxIn7LRsGiPEarVc0RRu8M1ghRDOr6Sm1NOB+C+QxtB7gSM3yn7ibdbFKD
         MUhj98HWCwG3G5Lvl4V3RyzZ+hTywEXX76NDrmYHwy6KKhoBGQSu/VRTHzN4rwMqtSzK
         Cnong0G3/XEtAoAiXtPnrY3Q8XLisbAvGVjNVcy3aZmOQdv0bxsRQXCi1R1GAMEgJrF3
         GvtXIpAc8DW68Pl9Lifir/519zDySPs0TuRJG6WK+qQuzu8jhwxvjM+vt3YPxxaqu22l
         ip0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hTwEdJ6Q5b7fJb+x3X+z0isTFJ/JKgG4BXZ2DTVYqdY=;
        b=ERIzNHDjql388RVV3jpPcVF5K2T2WZTrDjAB+ZXnuRCpw5chu+aWGaPr+kpLcwcVJb
         KkVyDl++0S2xzd5Ai0W76NOqURXb0wpiOVE4GKoTruPrm45T4mKyZLeX/UyLmAXuCwbT
         EhMC3YMyeOagBDSpcxyzv45nYQNDDbWAa0u3j/yNR+VwvxuAqNiMURKQIAjr87KFIRKq
         QllJuoC7wwVkbzvW8yYIPP8odI+tHkfwlcv52pJ3GIoKGRcVfCEx17jd+0aMtaENxIvM
         FyC92OPKzBfVW8COFcJ6Pz39bkpfC9OUoM7kdOVGDJRrwoEBoGIsZ9lnogW1qVUaXnMo
         lS1g==
X-Gm-Message-State: ACrzQf2hyzXFNWLJIEdl3cWbOrz6IQnyerK6k49gqhFLWnxPHGRfQK61
        e1tPw1j+chE7xUivdNJWOvBM6X7A8cRqpU+twwK8xg5sYA==
X-Google-Smtp-Source: AMsMyM7DIRRe5qZgvO4rXPmMTCXl0aRiOgTf0gsmobU8klbIhRtLMCxsxMNlbLb0FaBRp/k0qD4bPkHrRgi8szRuUfM=
X-Received: by 2002:a81:1b53:0:b0:373:6185:b72 with SMTP id
 b80-20020a811b53000000b0037361850b72mr24440522ywb.104.1667795170068; Sun, 06
 Nov 2022 20:26:10 -0800 (PST)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Mon, 7 Nov 2022 12:25:59 +0800
Message-ID: <CACkBjsaRPHUpfST=3-FTWbQycHsNgvWyVFpCLkJEwcrLhSZfnQ@mail.gmail.com>
Subject: BUG in BPF verifier, 10 insns costs 2 mins+ to load
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, ong@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org
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

Hi,

I've just written a BPF verifier fuzzer, targeting logic bugs in the
BPF verifier.
The following is an abnormal case it generated. The case only contains 10
BPF instructions but costs more than 2 mins to load on :
    HEAD commit: f0c4d9fc9cc9 Linux 6.1-rc4
    git tree: upstream
    kernel config: https://pastebin.com/raw/SBxaikiG
    C reproducer: https://pastebin.com/raw/HsDXdraZ
    verifier log: https://pastebin.com/raw/sNmSsVxs

Ideally, the verifier should exit quickly in this case, since R2=42
always holds.
The behaviour of the verifier does not make sense to me, seems it lost
the range information of R2.

Please point out if I missed anything, the C reproducer in the link
(https://pastebin.com/raw/HsDXdraZ)
essentially loads the following case into `test_verifier.c`:
{
"BVF verifier test",
.insns = {
BPF_MOV64_IMM(BPF_REG_1, 42),
BPF_MOV64_IMM(BPF_REG_2, 0),
BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
BPF_EXIT_INSN(),
BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1),
BPF_ALU32_IMM(BPF_DIV, BPF_REG_2, 1),
BPF_ALU64_IMM(BPF_SUB, BPF_REG_1, 108),
BPF_JMP32_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, -3),
BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
BPF_EXIT_INSN(),
},
.prog_type = BPF_PROG_TYPE_XDP,
},

The verifier's log is more then 4M, but essentially is:
    0: R1=ctx(off=0,imm=0) R10=fp0
    0: (b7) r1 = 42                       ; R1_w=P42
    1: (b7) r2 = 0                        ; R2_w=P0
    2: (85) call pc+1
    caller:
     R10=fp0
    callee:
     frame1: R1_w=P42 R2_w=P0 R10=fp0
    4: (57) r2 &= -52                     ; frame1: R2_w=P0
    5: (0f) r2 += r1                      ; frame1: R1_w=P42 R2_w=P42
    6: (34) w2 /= 1                       ; frame1:
R2_w=Pscalar(umax=4294967295,var_off=(0x0; 0xffffffff))
    7: (17) r1 -= 108                     ; frame1: R1_w=P-66
    8: (2e) if w1 > w2 goto pc-3 6: frame1: R1_w=P-66
R2_w=Pscalar(umax=4294967229,var_off=(0x0; 0xffffffff)) R10=fp0
    6: (34) w2 /= 1                       ; frame1:
R2_w=Pscalar(umax=4294967295,var_off=(0x0; 0xffffffff))
    7: (17) r1 -= 108                     ; frame1: R1_w=P-174
    8: (2e) if w1 > w2 goto pc-3 6: frame1: R1_w=P-174
R2_w=Pscalar(umax=4294967121,var_off=(0x0; 0xffffffff)) R10=fp0
    6: (34) w2 /= 1                       ; frame1:
R2_w=Pscalar(umax=4294967295,var_off=(0x0; 0xffffffff))
    7: (17) r1 -= 108                     ; frame1: R1=P-282
    8: (2e) if w1 > w2 goto pc-3 6: frame1: R1=P-282
R2=Pscalar(umax=4294967013,var_off=(0x0; 0xffffffff)) R10=fp0
    ...
    6: (34) w2 /= 1                       ; frame1:
R2_w=Pscalar(umax=4294967295,var_off=(0x0; 0xffffffff))
    7: (17) r1 -= 108                     ; frame1: R1_w=P-6342690
    8: (2e) if w1 > w2 goto pc-3 6: frame1: R1_w=P-6342690
R2_w=Pscalar(umax=4288624605,var_off=(0x0; 0xffffffff)) R10=fp0
    6: (34) w2 /= 1                       ; frame1:
R2_w=Pscalar(umax=4294967295,var_off=(0x0; 0xffffffff))
    7: (17) r1 -= 108                     ; frame1: R1_w=P-6342798
    8: (2e) if w1 > w2 goto pc-3          ; frame1: R1_w=P-6342798
R2_w=Pscalar(umin=4288624498,umax=4294967295,var_off=(0xff800000;
0x7fffff),s32_min=-6342798,s32_max=-1)
    9: (bf) r0 = r2                       ; frame1:
R0_w=Pscalar(id=58730,umin=4288624498,umax=4294967295,var_off=(0xff800000;
0x7fffff),s32_min=-6342798,s32_max=-1)
R2_w=Pscalar(id=58730,umin=4288624498,umax=4294967295,var_off=(0xff800000;
0x7fffff),s32_min=-6342798,s32_max=-1)
    10: (95) exit
    returning from callee:
     frame1: R0_w=Pscalar(id=58730,umin=4288624498,umax=4294967295,var_off=(0xff800000;
0x7fffff),s32_min=-6342798,s32_max=-1) R1_w=P-6342798
R2_w=Pscalar(id=58730,umin=4288624498,umax=4294967295,var_off=(0xff800000;
0x7fffff),s32_min=-6342798,s32_max=-1) R10=fp0
    to caller at 3:
     R0_w=Pscalar(id=58730,umin=4288624498,umax=429496
