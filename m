Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0222F25FCC9
	for <lists+bpf@lfdr.de>; Mon,  7 Sep 2020 17:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbgIGPPB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Sep 2020 11:15:01 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22332 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729826AbgIGPOx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 7 Sep 2020 11:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599491691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=rqGaOWFIXNlSj3bhgxs5sVqMIMu+K7S3Y4NQ2hq64AE=;
        b=Dox/3mpXSyHwSkKJ9fAiMHHIpwg8TPivMd+LdSCAmZYRHCCjYVtT266mEHYaPkVEm462tN
        WbhPPiQWKEdjO2A0PSqTJVc9a9qmUDAha/olN/0KyVe0BHnSehWt7o5IveCUCA7DSTJzG4
        l/tg7L9Ja8rzYexBxEo2dteXtZ25Ntc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-VFb78OFOP8-QHI0IhgfhXw-1; Mon, 07 Sep 2020 11:14:49 -0400
X-MC-Unique: VFb78OFOP8-QHI0IhgfhXw-1
Received: by mail-wr1-f71.google.com with SMTP id f18so5790732wrv.19
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2020 08:14:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=rqGaOWFIXNlSj3bhgxs5sVqMIMu+K7S3Y4NQ2hq64AE=;
        b=KDza8C838wQMdIjHXqAVrnf58I1HF/xYJEpbo49l15JfIou05Q96RQpqqpeMyWha/9
         e0QNE6YjxCs3TTbRulSw+XmvaFMztCviJ27yoMR01a33Q8/lHuvp49998ynMDyUO5x0+
         75HS/KY3jH+5bI4u9uqOQBbEC2dLop06PF6TSZMx4Z3/y/ryTgeacV3kptzTCU4ogs7+
         PuWRK8BBKOw1UlCLJlBQt5zKDuLQFypjLCc6iiHqyD0Q14il/+ClGQe3xdXpG+cqvfRL
         sh9rX+b/9lX+833Obtlz+d73JaXEbFhMgezobPSkiCYJB34kyBSAfAkHOadIIlt+vOan
         wyLA==
X-Gm-Message-State: AOAM53122Cd0oaGS1oXzeNOZnL4m5nlA7jtKuDoHmpIhCngFW40UKyi4
        EIOr88XKYPtoLpxkqTmh/oJIkHFXwzGHbxGQjYfJPf/edJ2/T8NdPUQhM3a8EAFv2Kc08QgZRPr
        mA054TjJMvXNa0LKIinzVOjmplq/Q
X-Received: by 2002:a5d:4fcc:: with SMTP id h12mr22124212wrw.199.1599491688329;
        Mon, 07 Sep 2020 08:14:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4me6vRr4w/q5zn2LDtFcf3yOg4vgUaio2bYYRBHrAZG55FhqW07kod+9bi0UWY95aChmHsjmw1qGGzzh7ENw=
X-Received: by 2002:a5d:4fcc:: with SMTP id h12mr22124197wrw.199.1599491688167;
 Mon, 07 Sep 2020 08:14:48 -0700 (PDT)
MIME-Version: 1.0
From:   Yauheni Kaliuta <ykaliuta@redhat.com>
Date:   Mon, 7 Sep 2020 18:14:32 +0300
Message-ID: <CANoWswkaj1HysW3BxBMG9_nd48fm0MxM5egdtmHU6YsEc_GUtQ@mail.gmail.com>
Subject: arm64 jit ctx.offset[-1] access
To:     bpf <bpf@vger.kernel.org>
Cc:     Zi Shen Lim <zlim.lnx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi!

Looks like my first message did not reach the list, resending:

I have a question about arm64 bpf jit implementation.

The problem I observe is "taken loop with back jump to 1st insn"
verifier test, the subprogram is:

BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1),
BPF_ALU64_IMM(BPF_SUB, BPF_REG_1, 1),
BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, -3),
BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
BPF_EXIT_INSN(),

Jitting the program causes invocation of bpf2a64_offset(-1, 2, ctx)
from
        jmp_offset = bpf2a64_offset(i + off, i, ctx);

which does ctx->offset[-1] then (and works by accident when it
returns 0).

As far as I see, the offset[] keeps actually offsets of the next
instruction:

                ret = build_insn(insn, ctx, extra_pass);
                if (ret > 0) {
                        i++;
                        if (ctx->image == NULL)
                                ctx->offset[i] = ctx->idx;
                        continue;
                }
                if (ctx->image == NULL)
                        ctx->offset[i] = ctx->idx;


ctx->idx is updated by build_insn() already.

How is that supposed to work?

-- 
WBR, Yauheni

