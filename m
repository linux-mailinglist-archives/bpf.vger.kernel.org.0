Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1143367058
	for <lists+bpf@lfdr.de>; Wed, 21 Apr 2021 18:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241202AbhDUQmF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Apr 2021 12:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241399AbhDUQl5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Apr 2021 12:41:57 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC008C06138A;
        Wed, 21 Apr 2021 09:41:23 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id l19so31556629ilk.13;
        Wed, 21 Apr 2021 09:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=3OjZNLUcaWPhCXBSI1zBOXgxHoSv4A+YzxMp3DdNijI=;
        b=fWz/dSDZ6ha1J83BysSTDfMmGmRI07BKjaDnKgxqkzxN7WchgxgmtGDYk54siKB1co
         Utqk9SyZL/Z8u5uZF/+vFVPPMOdH9goMtdZGwPatuXFCkTTxTm2sOy9HDtKdj5B3nyS3
         O0UjCwIMFRiPDA0KR2yrngGAkbU+39LdFOZSk85sgG4kXSBfncqCqVN9fk3DBposh0ID
         wdwr2v6/zmy2zAyKtmKPQfaTOHs7smAqVVEVne4zRfvxIPr1jsx9uzXHzD0IxK3PEell
         MX5XLDkppIYYrt0Sl2PcGs+JAz1+ZUSUfMBvymp7O+Rj069KlgUjPZw9CRcB+Gu/BW0Q
         ZAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=3OjZNLUcaWPhCXBSI1zBOXgxHoSv4A+YzxMp3DdNijI=;
        b=baCcLdXIWd8uqAOK6kcNBt7Pi4+QgjKu8m61u4ladpKlFhYltu51Z0+qgZM5gJaWoT
         6AH5HzfygbSkA11dudvIby3aQVG0b2DdkaIhbdTfYPtC4uBHhhtFVbPVeyGUaKw30Kdw
         PBfPzttzrF27TR2bIymulml2G1he3lL26oLHmludLTQ0r65af7eWRPT/rzM4UPqR0teD
         sA2C0cBH9VXC3g0ukbnaMeqYU0L/IHfnR8/yCSeNip6Sw+cvAfEHKDzKIJGoCZkFUkIL
         zI5Lz4OV05aiRXij6c0aXvyrCr5hoj2Aan4OtYCQPzDgOPEHRNG5sTDnOAXarF8cx3kt
         BYrQ==
X-Gm-Message-State: AOAM5311XZI3X1I4myw0idzXR/g0R4xnU93/iN3SOYRVL+XyBf+GihhY
        A6yAWm+Y60KVHBFD4EJXwG4=
X-Google-Smtp-Source: ABdhPJwAiN4+rRptpkaB7o5ijyT0nwWvnM0JzyPTPcn5p4Zp+d7+Oua/uUHPId8dzQUDN8qH7CNS6w==
X-Received: by 2002:a92:cc0f:: with SMTP id s15mr10344488ilp.187.1619023283433;
        Wed, 21 Apr 2021 09:41:23 -0700 (PDT)
Received: from localhost ([172.242.244.146])
        by smtp.gmail.com with ESMTPSA id y10sm1177550ilv.73.2021.04.21.09.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 09:41:23 -0700 (PDT)
Date:   Wed, 21 Apr 2021 09:41:13 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Brendan Jackman <jackmanb@google.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Message-ID: <608055a9a6f4d_46b9208b0@john-XPS-13-9370.notmuch>
In-Reply-To: <20210421122348.547922-1-jackmanb@google.com>
References: <20210421122348.547922-1-jackmanb@google.com>
Subject: RE: Help with verifier failure
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Brendan Jackman wrote:
> Hi,
> 
> Recently when our internal Clang build was updated to 0e92cbd6a652 we started
> hitting a verifier issue that I can't see an easy fix for. I've narrowed it down
> to a minimal reproducer - this email is a patch to add that repro as a prog
> test (./test_progs -t example).
> 
> Here's the BPF code I get from the attached source:
> 

[...]

> 
> w2 can't exceed 4096 but the verifier doesn't seem to "backpropagate" those
> bounds from r8 (note the umax_value for R8 goes to 4095 after the branch from 36
> to 20, but R2's umax_value is still 266342399)
> 
> from 31 to 34: R0_w=inv(id=0) R1_w=inv2097152 R6=inv(id=2,umin_value=2093057,umax_value=268435455,var_off=(0x0; 0xfffffff)) R7_w=inv2093056 R8_w=inv(id=0,umax_value=266342399,var_off=(0x0; 0xfffffff)) R9_w=invP511 R10=fp0 fp-8=mmmm???? fp-16=map_value fp-24=ptr_
> ; int BPF_PROG(exec, struct linux_binprm *bprm) {
> 34: (bf) r7 = r1
> ; (void) bpf_probe_read_user(buf, read_size, src);
> 35: (bc) w2 = w8
> 36: (a5) if r8 < 0x1000 goto pc-17
> 
> from 36 to 20: R0_w=inv(id=0) R1_w=inv2097152 R2_w=inv(id=0,umax_value=266342399,var_off=(0x0; 0xfffffff)) R6=inv(id=2,umin_value=2093057,umax_value=268435455,var_off=(0x0; 0xfffffff)) R7_w=inv2097152 R8_w=inv(id=0,umax_value=4095,var_off=(0x0; 0xfff)) R9_w=invP511 R10=fp0 fp-8=mmmm???? fp-16=map_value fp-24=ptr_
> ; void *src = (void *)(char *)bprm->p + offset;
> 20: (79) r1 = *(u64 *)(r10 -24)
> 21: (79) r3 = *(u64 *)(r1 +24)
> ; uint64_t read_size = args_size - offset;
> 22: (0f) r3 += r7
> 23: (07) r3 += -4096
> ; (void) bpf_probe_read_user(buf, read_size, src);
> 24: (79) r1 = *(u64 *)(r10 -16)
> 25: (85) call bpf_probe_read_user#112
>  R0_w=inv(id=0) R1_w=map_value(id=0,off=0,ks=4,vs=4096,imm=0) R2_w=inv(id=0,umax_value=266342399,var_off=(0x0; 0xfffffff)) R3_w=inv(id=0) R6=inv(id=2,umin_value=2093057,umax_value=268435455,var_off=(0x0; 0xfffffff)) R7_w=inv2097152 R8_w=inv(id=0,umax_value=4095,var_off=(0x0; 0xfff)) R9_w=invP511 R10=fp0 fp-8=mmmm???? fp-16=map_value fp-24=ptr_
>  R0_w=inv(id=0) R1_w=map_value(id=0,off=0,ks=4,vs=4096,imm=0) R2_w=inv(id=0,umax_value=266342399,var_off=(0x0; 0xfffffff)) R3_w=inv(id=0) R6=inv(id=2,umin_value=2093057,umax_value=268435455,var_off=(0x0; 0xfffffff)) R7_w=inv2097152 R8_w=inv(id=0,umax_value=4095,var_off=(0x0; 0xfff)) R9_w=invP511 R10=fp0 fp-8=mmmm???? fp-16=map_value fp-24=ptr_
> invalid access to map value, value_size=4096 off=0 size=266342399
> R1 min value is outside of the allowed memory range
> processed 9239 insns (limit 1000000) max_states_per_insn 4 total_states 133 peak_states 133 mark_read 2
> 
> This seems like it must be a common pitfall, any idea what we can do to fix it
> and avoid it in future? Am I misunderstanding the issue?

We also hit this from time to time. I have asm blocks to work-around
at the moment. I was going to see how ugly propagating the bounds
backwards gets. I had some code for this some time ago but never
pushed it, it was smashed in with some CFG building for loops back
before loops were possible. I can take a look next week unless someone
beats me there.

> 
> Cheers,
> Brendan
> 
