Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C71B508DAC
	for <lists+bpf@lfdr.de>; Wed, 20 Apr 2022 18:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380773AbiDTQwe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Apr 2022 12:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380776AbiDTQvR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Apr 2022 12:51:17 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE864553C
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 09:48:30 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id f5so1339713ilj.13
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 09:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YP8pKzZaMyor7RijCaD0FwE70N1V1zzFv3K68LOOOv8=;
        b=MeA/oWaSCL5YyOZHyiNJGEeZNYby5Tzxtp9YN9dv9wZkYkhfMkcPSCXndsyIXiRCVW
         l6xhAeUPt97i24p8bw0RYWFdAG2H7mmD3A6tKW8lkwrya3xHhCQtb+tAjFFypqTuzDid
         D2sTzipR1SBx7q9KpbweYHYz0RLZSpLIzTpK3MjJtBcCDh194eZY+nNHuncsGWpXZlag
         Tc+sG1nZX1Qd8z67wZGbW/h7saomKLj2u0EN3xV5lHkivlKGTalqcPVWI1twqyUIZU2G
         c9PLmVVVGH7/bIRoY+ClUGyaeyoU1ihZh3ICxvMu3s5CRWfSmpM5E51mM1KMBZBcfvwg
         kzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YP8pKzZaMyor7RijCaD0FwE70N1V1zzFv3K68LOOOv8=;
        b=0fkYw8/hIpBdDpQ32gAA5RE7hgtBw6WgfgFqAvNbEHrSTe5FRCfIa+hfrndK7B5W7P
         3MqKXRHndSFtJ/6d7DDnrVHZhZAauMheV1P+uyScupJgftUjTHO8upZsRYZxFbJchjiX
         yACu+lBRHGY42GA/MksmsyPhzWRIKZ6++jxtTm345HKAY4AI4GNf75MkcaKAHkQ+KIcZ
         s9ibwnRuwH5d8VhlILhYx6YvYTwo9JFWx4X9/rt/IsGhOu9r21MezG1uwE4iEhSKJjG0
         oGC9i8ER5zFXpIQDwl7N7y/0AkTXYTyr/MBA7Acz5d71A4m5lP6sPG91MQv11qYsvtEA
         nIEA==
X-Gm-Message-State: AOAM532DTxGh3WIRydX5GwSTqIWDCm2Lxq1NWmcUJlLNclwPXRBw1ncD
        jRjfg8ytZsvwUEBZurampxDC/lRxQmJxtRlD9OA=
X-Google-Smtp-Source: ABdhPJylhb0GmVxHqO5Bgs7XSkIeypc5kJ6ACpSUIv/EqwZKrVWc4cKuXRMZPesRenRSXACqlT0P3TYRkprVFiJWYC0=
X-Received: by 2002:a92:c247:0:b0:2cc:1798:74fe with SMTP id
 k7-20020a92c247000000b002cc179874femr8219700ilo.239.1650473310202; Wed, 20
 Apr 2022 09:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <4ed4a01e-3d1e-bf1e-803a-608df187bde5@I-love.SAKURA.ne.jp> <909c72b6-83f9-69a0-af80-d9cb3bc2bd0e@I-love.SAKURA.ne.jp>
In-Reply-To: <909c72b6-83f9-69a0-af80-d9cb3bc2bd0e@I-love.SAKURA.ne.jp>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 20 Apr 2022 09:48:19 -0700
Message-ID: <CAEf4Bzbugg4dy_2J=cFKYYQEJx-irF-cRZvkkwCx4QQwXm5OpA@mail.gmail.com>
Subject: Re: How to disassemble a BPF program?
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
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

On Wed, Apr 20, 2022 at 4:38 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Ping?
>
> Since how to fix this "current top five crasher" bug depends on how a kernel
> socket is created via BPF program, this bug wants help from BPF developers.

If the BPF program is loaded/verified successfully, the easiest way to
go about this would be to prevent repro from proceeding right after
successful validation (e.g, do scanf()) and then use bpftool to find
that program's ID and dump disassembly while that program is in the
kernel.

$ sudo bpftool prog show
...
654439: cgroup_skb  tag 6deef7357e7b4530  gpl
        loaded_at 2022-04-20T06:14:08-0700  uid 0
        xlated 64B  jited 54B  memlock 4096B
        pids systemd(1)

$ sudo bpftool prog dump xlat id 654439
   0: (bf) r6 = r1
   1: (69) r7 = *(u16 *)(r6 +176)
   2: (b4) w8 = 0
   3: (44) w8 |= 2
   4: (b7) r0 = 1
   5: (55) if r8 != 0x2 goto pc+1
   6: (b7) r0 = 0
   7: (95) exit

Hope that helps. I don't know any tool that allows to disassemble raw
bytes into BPF assembly. Normally I use llvm-objdump to disassemble
well-formed BPF ELF files. Not sure if you can wrange llvm-objdump to
disassemble raw bytes without ELF file itself.

>
> On 2022/04/12 20:04, Tetsuo Handa wrote:
> > Hello.
> >
> > I'm not a BPF user, but I want to know what a BPF program stored in
> > "static const char program[2053] =" at
> > https://lkml.kernel.org/r/c389e47f-8f82-fd62-8c1d-d9481d2f71ff@I-love.SAKURA.ne.jp
> > is doing so that I can parse syzkaller-generated BPF programs like C programs.
> >
> > Do you have a utility for this purpose?
> >
> > Regards.
