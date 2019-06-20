Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAD0A4C6C4
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2019 07:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbfFTF0K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jun 2019 01:26:10 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:43200 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfFTF0K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Jun 2019 01:26:10 -0400
Received: by mail-lf1-f48.google.com with SMTP id j29so1413335lfk.10
        for <bpf@vger.kernel.org>; Wed, 19 Jun 2019 22:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=/rGEfnqdAgH4gl3pXwx/rPnL2IjceIYThgcJqqNw2Ns=;
        b=pTCNaa9QRonDpyAJNaesmLNQAYhdznvWDECqVw/8LdPWNsFeXdGdeW+bC01ZQu9srZ
         HL+BB8oAl/sbR8BUeKMgQsuDO14feO/X+F6mNDba1ZBYyz18jQ8xAB/m7W1w+neX+Tqk
         AVq3iqZ5/SUYEqym5SCoRocjIpxlSeC8eNm98rKgz5s3ICD936iWEa/KrIGz3iP/ltmR
         CHLlh1y2JWdUFvtR/M0NtiLFnVTBXBN9KNrDkLSs88pL1PZjVN/RJfsTQowT3XeYXGlL
         HunYE9vaIcSeRwd+gU/M8zYqB+auNU0C7v4qtZIlcBNN2NYNi4lTjEOVglj/4gNbF9LR
         Uubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=/rGEfnqdAgH4gl3pXwx/rPnL2IjceIYThgcJqqNw2Ns=;
        b=FTND/Tv8DXjROd0K5qad1PklzvBv0PuHxSVa6WX8ON8UwU50UPZDEVEWT8CsX7J4V5
         G06ot2JYiT/9LxmfbWmjwxd7LUI1KUFMSNZdv8PnkStjhk3x/u7az7nHOCREedNGsWc8
         UkGgaIizlaYtY0jM85KKdzMsiLX6RzMV6RDTDFarzxfloB4YWfEBlzHlLMqg82RRecRP
         TWlFwFRa/q/RONevQ9wN+I7DnSmre33KkeDphE2E3qQl/3LC2xRhjB/0gcS0zJVYtjYM
         Ke/gF+c441uK0akuQj6hzt/4i0ljn9LAi+0KUoLyxm2Ene0C4ZaKgeSbWx8Nc4tjK1vl
         XDSg==
X-Gm-Message-State: APjAAAUKYWnb73BD1KIGswCD1YbnEmWgTScf3E2oRzVgqeI+iqZbJcYy
        BrEGsn/yLVh2zy6G2NXErzWv14HZsbyJQ2tptpWICA==
X-Google-Smtp-Source: APXvYqw5jSWH+KfsCtGbkM36a/w4J8qSOaa2Bl8v1+6MdOHqv8WblCgEsa8OG6KOEeGslJUMMGB/uztVewXZryauGJQ=
X-Received: by 2002:ac2:4ace:: with SMTP id m14mr7274158lfp.99.1561008367883;
 Wed, 19 Jun 2019 22:26:07 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 20 Jun 2019 10:55:56 +0530
Message-ID: <CA+G9fYs=JNPe7=xjrWfCugGs4v1s2xjHTjETBJh7LvxZ1Qojww@mail.gmail.com>
Subject: selftests: bpf: test_align Test 4 unknown shift Failed to find match
 7 R0=pkt(id=0,off=8,r=8,imm=0)
To:     Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        bpf@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, kafai@fb.com,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

selftests: bpf: test_align failed running Linux -next kernel
5.2.0-rc5-next-20190619.

Here is the log from x86_64,

# selftests bpf test_align
bpf: test_align_ #
# Test   0 mov ... PASS
0: mov_... #
# Test   1 shift ... PASS
1: shift_... #
# Test   2 addsub ... PASS
2: addsub_... #
# Test   3 mul ... PASS
3: mul_... #
# Test   4 unknown shift ... Failed to find match 7 R0=pkt(id=0,off=8,r=8,imm=0)
4: unknown_shift #
# func#0 @0
@0: _ #
# 0 R1=ctx(id=0,off=0,imm=0) R10=fp0
R1=ctx(id=0,off=0,imm=0): R10=fp0_ #
# 0 (61) r2 = *(u32 *)(r1 +76)
(61): r2_= #
# 1 R1=ctx(id=0,off=0,imm=0) R2_w=pkt(id=0,off=0,r=0,imm=0) R10=fp0
R1=ctx(id=0,off=0,imm=0): R2_w=pkt(id=0,off=0,r=0,imm=0)_R10=fp0 #
# 1 (61) r3 = *(u32 *)(r1 +80)
(61): r3_= #
# 2 R1=ctx(id=0,off=0,imm=0) R2_w=pkt(id=0,off=0,r=0,imm=0)
R3_w=pkt_end(id=0,off=0,imm=0) R10=fp0
R1=ctx(id=0,off=0,imm=0):
R2_w=pkt(id=0,off=0,r=0,imm=0)_R3_w=pkt_end(id=0,off=0,imm=0) #
# 2 (bf) r0 = r2
(bf): r0_= #
...
# processed 22 insns (limit 1000000) max_states_per_insn 0
total_states 1 peak_states 1 mark_read 1
22: insns_(limit #
# FAIL
: _ #
# Results 6 pass 6 fail
6: pass_6 #
[FAIL] 7 selftests bpf test_align
selftests: bpf_test_align [FAIL]

Full test log,
https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20190619/testrun/781777/log

Test results comparison,
https://qa-reports.linaro.org/lkft/linux-next-oe/tests/kselftest/bpf_test_align

Good linux -next tag: next-20190618
Bad linux -next tag: next-20190619
git branch     master
git commit    c0e4c41afeef66d21dc5704f614624cecac806ac
git describe  next-20190618
git repo
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

Best regards
Naresh Kamboju
