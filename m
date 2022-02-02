Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FAA4A79E0
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 21:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238325AbiBBU70 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Feb 2022 15:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiBBU7Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Feb 2022 15:59:25 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647EFC061714
        for <bpf@vger.kernel.org>; Wed,  2 Feb 2022 12:59:24 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id a13so852629wrh.9
        for <bpf@vger.kernel.org>; Wed, 02 Feb 2022 12:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=D4AguVXGaTCkeHSfo9EdotBSEnw7/5v1KAUvI8xr3XY=;
        b=YbmJuNll88M1UyVzT++CM7kXZDZ4Sb+D9ZhGwOvMecq+pqoVmnUwQIb/7P/1Z9t3be
         POgI0TbLWlx4LjtpKGhjgF3x7bYS1F3aabl1sJuS6f2kZoqR6SNFVuATNbxAvIIqC1qI
         TeHko+nNRxOnguoppLXYpQDb2p7O4Q3gQSjsKoqiPqEfJ/bnNXCtIgZ/n8b9TZJTIp5H
         dGyXwc7fvkntgeb/1e+mnLhFrnflZmpMmqymgRExc+Da0llPoMuQ8mVoGHoYDzXNXHDW
         RyyBGwM7uTzyD9N5VT7u5GMj9fAF0dzXQ9qcIjb3fnxCnMC9KifxFgEkbDdPP0aRJfkT
         wjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=D4AguVXGaTCkeHSfo9EdotBSEnw7/5v1KAUvI8xr3XY=;
        b=dR/k0Qec+XDgx4yMo73XEGx44Fy159nrVaz/6vXNLLl8NRYYANPmm9MfSDhWWC4xYC
         zUrwwmM4ftAJ+smfZNATDmqMB626d3INb7pPr7i7yXYbmGPkrSHVSEmtxOdtzEgPHN7J
         cpdrnNcIocNrwC8WKB0dXkwlV6CduQY81NbsiJepJ2c7NpaJHwQUSfgHUj+M5NL4dnFO
         p8K2KnJCiQuR4pfjgq9ymGe1Ps7sveyp9s1QvmrZREz01SDdegm9Vx/oPNvbgvIQZ/jg
         Sgbg265utaB4SA+k6LKu1uu6imumM0wFO+POdbx/Za1YdFzi1yanGtXnFYT9fjviyAQD
         OJKQ==
X-Gm-Message-State: AOAM533Y3UtD0yY+uEHAD3vAarpztMCqeeihnde3P3DVUXzkKDITKjZO
        M0edTd03Ph2lV7nPXrBqlTgQTMNnt2kj
X-Google-Smtp-Source: ABdhPJysPE0d3+X+sd9k3+6hezb7rALOyjeh0l17OAFcZnEy4We5o7JW26L/Q7Nii/2NImM+XdOdwA==
X-Received: by 2002:a05:6000:18a4:: with SMTP id b4mr27012566wri.228.1643835562855;
        Wed, 02 Feb 2022 12:59:22 -0800 (PST)
Received: from Mem (2a01cb088160fc00aceb97be319ea013.ipv6.abo.wanadoo.fr. [2a01:cb08:8160:fc00:aceb:97be:319e:a013])
        by smtp.gmail.com with ESMTPSA id m12sm21832573wrp.61.2022.02.02.12.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 12:59:22 -0800 (PST)
Date:   Wed, 2 Feb 2022 21:59:21 +0100
From:   Paul Chaignon <paul@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     Yonghong Song <yhs@fb.com>
Subject: Packet pointers with 32-bit assignments
Message-ID: <20220202205921.GA96712@Mem>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

We're hitting the following verifier error in Cilium, on bpf-next
(86c7ecad3bf8) with LLVM 10.0.0 and mcpu=v3.

    ; return (void *)(unsigned long)ctx->data;
    2: (61) r9 = *(u32 *)(r7 +76)
    ; R7_w=ctx(id=0,off=0,imm=0) R9_w=pkt(id=0,off=0,r=0,imm=0)
    ; return (void *)(unsigned long)ctx->data;
    3: (bc) w6 = w9
    ; R6_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R9_w=pkt(id=0,off=0,r=0,imm=0)
    ; if (data + tot_len > data_end)
    4: (bf) r2 = r6
    ; R2_w=inv(id=1,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6_w=inv(id=1,umax_value=4294967295,var_off=(0x0; 0xffffffff))
    5: (07) r2 += 54
    ; R2_w=inv(id=0,umin_value=54,umax_value=4294967349,var_off=(0x0; 0x1ffffffff))
    ; if (data + tot_len > data_end)
    6: (2d) if r2 > r1 goto pc+466
    ; R1_w=pkt_end(id=0,off=0,imm=0) R2_w=inv(id=0,umin_value=54,umax_value=4294967349,var_off=(0x0; 0x1ffffffff))
    ; tmp = a->d1 - b->d1;
    7: (71) r2 = *(u8 *)(r6 +22)
    R6 invalid mem access 'inv'

As seen above, the verifier loses track of the packet pointer at
instruction 3, which then leads to an invalid memory access. Since
ctx->data is on 32 bits, LLVM generated a 32-bit assignment at
instruction 3.

We're usually able to avoid this by removing all 32-bit comparisons and
additions with the 64-bit variables for data and data_end. But in this
case, all variables are already on 64 bits.

Is there maybe a compiler patch we're missing which prevents such
assignments? If not, could we teach the verifier to track and convert
such assignments?

Regards,
Paul
