Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D923274C2
	for <lists+bpf@lfdr.de>; Sun, 28 Feb 2021 23:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhB1WO5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Feb 2021 17:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbhB1WO4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Feb 2021 17:14:56 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926E3C06174A
        for <bpf@vger.kernel.org>; Sun, 28 Feb 2021 14:14:16 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id t1so6242943qvj.8
        for <bpf@vger.kernel.org>; Sun, 28 Feb 2021 14:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=S81LxPv327MbBsFrGn0SGl8cs3hh88jE0kp0tTmg6qE=;
        b=UmiBpnlGWPed4rJuq/s9SvrOSTVoV++CfYG+HniG04VuAhKJFm9R5o6rG/iJN1ed3T
         o/5r3PJmo4ij+inZD7j7p1NPGhvuncIOcOr8BA0Y+Kg/+HjHuJtVX124B4FsYORa2PER
         PPAO9yyncPDFtcsJP+KDDyryFft++QRwu77+Yw90/6UDy+wVwTyRzffRHxbJ0TqIaug0
         2YOPu6JH+Phgw6/OyuZKp3xnovWuXkojoqh5roEB4+MBooBK618jroa8jG/VGy2P4gDp
         kIN/8DMUZiW7bGxYBiz9KitaKRpETr2Ww9oHpmMNVD4KBxp2iU17CZNQXObvGaZHHYzv
         eq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=S81LxPv327MbBsFrGn0SGl8cs3hh88jE0kp0tTmg6qE=;
        b=MgBdM43qzggv83vk3JdxHaLHyNWBkqf1kLjXeXnFXnlBUgfoBRcnZ8tkbBKkLuaJVY
         nCLkkCVxFuVsQ7+VbvwEzwxMm3AJCX0Z+V7q3IMvmMTIQZl3G+4RXLNxuv/p7xtQ6Kr3
         xTivAbbiza1rsZ+o/9G+kbjzwtk2/LdWiQLoTczxeRcFJOMv2E0Xhv9z4xPEdB/RavWW
         day3mkDLLh0sxss1Uz9CUnZNHU7tWKtuYKxUXAdEHX8JBoIiSGCWUgPl88aBbDhto8Vv
         keJS/wDKYHIx4BRfcByKxQOFbCpNVFkYlmv6d18/uwDV0V/upQDo05CEsJTX7aTpNY/D
         xypg==
X-Gm-Message-State: AOAM531GI9djgsDflVv1KDw9Y2YA17gxTaLBBo4xL9EWaKtiqntlxCkw
        WgtwlIyQxfTGYXzyHMiY4k+PHArpOBR28A==
X-Google-Smtp-Source: ABdhPJx/n86q3liY/BaSkv8cgg12Mh8+Ril+16jrBFowEnHjFWVEB3VdirGDXLTSea6XCSK1GN6tHw==
X-Received: by 2002:a05:6214:1424:: with SMTP id o4mr12373522qvx.34.1614550455169;
        Sun, 28 Feb 2021 14:14:15 -0800 (PST)
Received: from [192.168.1.149] (pool-100-33-73-206.nycmny.fios.verizon.net. [100.33.73.206])
        by smtp.gmail.com with ESMTPSA id o6sm1709734qtw.56.2021.02.28.14.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Feb 2021 14:14:14 -0800 (PST)
Subject: clang crash for target BPF
From:   Andrei Matei <andreimatei1@gmail.com>
To:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
References: <CABWLset0aqju=tkCVQJ3p8QyVwFUi21HkfxBS3rK7qC5oScyWw@mail.gmail.com>
Message-ID: <747ea282-d158-f65f-65ac-c13dac694974@gmail.com>
Date:   Sun, 28 Feb 2021 17:14:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CABWLset0aqju=tkCVQJ3p8QyVwFUi21HkfxBS3rK7qC5oScyWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

I've encountered an assertion failure / crash on clang master 
(5de09ef02e24) as well as the older version 11. Happens for "-target 
bpf", not otherwise.
I've reported it to clang but there's been no response so far. Alexei, I 
believe you've invited me to raise the issue here.
clang bugzilla: https://bugs.llvm.org/show_bug.cgi?id=48578


The repro program and instructions are in the bug report above.
The assertion failure reads:

clang: 
/home/andrei/src/llvm-project/llvm/lib/CodeGen/LiveVariables.cpp:130: 
void llvm::LiveVariables::HandleVirtRegUse(llvm::Register, 
llvm::MachineBasicBlock*, llvm::MachineInstr&): Assertion 
`MRI->getVRegDef(Reg) && "Register use before def!"' failed.
PLEASE submit a bug report to https://bugs.llvm.org/ and include the 
crash backtrace, preprocessed source, and associated run script.
Stack dump:
0.      Program arguments: bin/clang -O2 -target bpf -c -o probe.bpf.o 
/home/andrei/Downloads/probe.bpf.preprocessed.c
1.      <eof> parser at end of file
2.      Code generation
3.      Running pass 'Function Pass Manager' on module 
'/home/andrei/Downloads/probe.bpf.preprocessed.c'.
4.      Running pass 'Live Variable Analysis' on function '@probe'


Thanks!

