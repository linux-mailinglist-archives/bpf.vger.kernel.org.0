Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB2D6AFB13
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 01:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjCHA2Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 19:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjCHA2R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 19:28:17 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350618C51C
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 16:28:15 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id o12so59382589edb.9
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 16:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678235293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6k1xxXe+87729zRsewJNGVn4oC/ZvaqeCfirVdX3Lg=;
        b=CwsoS/hIvsafIrQE3BOGYWfYFkxXhMf0nhaPjGFbi9zZ0Liyu7dbDjhfIU90LFTH8Z
         TIQG20CJovLVLtI7e6aD0WFF9Z5nTCYyTAfOrCfyQ4mx/25Fp4A8r4U4Cq7Mi17x+o/N
         WiKFdyX1paomNa1VZCW3Hd/i0qa9EkAaDfMuZZEfKll/kfb94414a7E5Coz/BHnr5HQi
         Ef1IaaiptbUtbRy/dGS0l889MSDFgGaoDgm4squl0bTM+Dhb719wnPWPhY4z+T6t849O
         W6fKH4dUqUVaiXcG2h77WboMxfCAp4/3+4B527EgLcbrub84bTsC4e9/Pp8oNg6+PHoY
         pwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678235293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6k1xxXe+87729zRsewJNGVn4oC/ZvaqeCfirVdX3Lg=;
        b=6fsYCl7DaeAPx9fG5O2z5BakZMJW+w54s57BCPU1cExVTig3mrRnjYGyr8RmXDOWL+
         NEyL3H89guKZj2hDYUn70p3nwpvI2LD6cbZeqHLFaGit8x4OpuCiva4JbSuZO7AKrE9T
         Nj3BoyIB4fu6C3WqueHBpoU0TyB9Qqh48tc5yru/TWrYn3S/oNC7+7dOcPq+EZq7EeVg
         jfvjVhUEjYi9/nwx3R9rE6BK/Hq1GVMkSmQ9nWRmq6wgVO03T+5FKtc8sbYjmzddpMAV
         q1e9FlCt7ogMuYb0x3IWMJyvlHvHNrB1C3CusuG+8mVW+DerxE37dC/tRPh9U8qixPXz
         EioQ==
X-Gm-Message-State: AO0yUKUu+nk2cs4ACBfJHiTc5tegKfv1+ALVWWpEleknwxXaZP1Qm9oW
        WXoLMnmg/W/MndXg5Bh/CqD7menrRwIumPErGds=
X-Google-Smtp-Source: AK7set8QLMVFlxjHInvR8YbxvO/drktFlfIJf/oSU1NCeMAOGkInSp0/6wAdzHJDOncK/oKVl7RuAs2XorZRc9ZNgig=
X-Received: by 2002:a50:c057:0:b0:4c1:b5de:b72d with SMTP id
 u23-20020a50c057000000b004c1b5deb72dmr9155392edd.5.1678235293532; Tue, 07 Mar
 2023 16:28:13 -0800 (PST)
MIME-Version: 1.0
References: <CAO658oXX+_7FnAsv02x27FQRbm_Dw7d=tOmQ_Gfe=fB5Hv+C+g@mail.gmail.com>
In-Reply-To: <CAO658oXX+_7FnAsv02x27FQRbm_Dw7d=tOmQ_Gfe=fB5Hv+C+g@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 7 Mar 2023 16:28:01 -0800
Message-ID: <CAEf4BzZDv8hUD=_KYXNAO+EQMqHjqgEWurOcNF_huwX+CvmHXA@mail.gmail.com>
Subject: Re: [Question] How can I get floating point registers on arm64
To:     Grant Seltzer Richman <grantseltzer@gmail.com>,
        Dave Marchevsky <davemarchevsky@meta.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 2, 2023 at 11:06=E2=80=AFAM Grant Seltzer Richman
<grantseltzer@gmail.com> wrote:
>
> Hi everyone,
>
> I'm writing a uprobe program that I'm attaching to a function in a go
> program on arm64. The function takes a float and as such loads the
> parameters via 64-bit floating point registers i.e. `D0`.
>
> However, the struct pt_regs context that uprobe programs have access
> to only has a single set of 31 64-bit registers. These appear to be
> the regular general purpose integer registers. My question is - how do
> I access the second set of registers? If this question doesn't make
> sense, am I misunderstanding how arm64 works?
>

cc'ing Dave, as he was looking at this problem in the past (in the
context of accessing xmm registers, but similar problem).

The conclusion was that we'd need to add a new helper (kfunc nowadays)
that would do it for BPF program. Few things to consider:

  - designing generic enough interface to allow reading various
families of registers (FPU, XMM, etc) in some generic way
  - consider whether do platform-specific or platform-agnostic
interface (both possible)
  - and most annoyingly, we'd need to handle kernel potentially
modifying FPU state without (yet) restoring it. Dave investigated
this, and in some recent kernels it seems like kernel code doesn't
necessarily restore FPU state right after it's done with it, and
rather sets some special flag to restore FPU state as kernel exits to
user-space.

Hopefully Dave can correct me and fill in details.


> Thanks so much,
> Grant
