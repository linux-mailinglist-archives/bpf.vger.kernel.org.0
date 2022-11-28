Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A569639F02
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 02:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiK1Blb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 27 Nov 2022 20:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiK1Bla (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 27 Nov 2022 20:41:30 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26418A47D;
        Sun, 27 Nov 2022 17:41:28 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id o12so269001pjo.4;
        Sun, 27 Nov 2022 17:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PaR7LgzX2MZo4rJ3PVl0tctTYz/3NOJLXLMUsXTLGD4=;
        b=Pau7HecAGXX1ueUtl74grj3/J1c/RLQ+W+jYaJZ6EHWllnaY6Acziy3bxu2m7xIi5K
         Rkk3Rz+1hGBw7/USdwCwkql3pclhcToikSCyM6dTy0QjkuWrpnWb+rFgU6FqacRNVTUV
         gzPkf/I9GExvlnTC45hKFhbo6hB8XUuMzjISntm8SJugYpoKhscn52KE7jrkiWmUJQKj
         azIYKNuzPRTt8GqPTujEZx2RHcm+AqIMK3V65xUQJHupQVtl4EMZiPfEdoQep+/++am7
         P0f9CEmq12oSyM7EQTrxYq3xSSZv9bQOKNZRZu/3nSvgLMZHd9rvtNC/3Cwh2VZiLZ18
         TUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PaR7LgzX2MZo4rJ3PVl0tctTYz/3NOJLXLMUsXTLGD4=;
        b=EDCqFqDE9llGElWSZxLwiT5VsaoJMerXXfgpgDTsLos/l5NXKroFUMV5o+mT3UD4QH
         X6zcc7Ph5ijQ4sBXLipauZh7tZq50jp2306gFUUPRixveYowULlU8vNFJdN8E5z4AuqL
         TtANbW68tM22fmQnymGLssOoJ4P9anN4jana28crDOIfUb4uAmLeksGDuTWiq1orMmOO
         7uMWoTGoPXiisRyxZgcZ36Ku6ZgMZuZQ7hXchRfWB2YeFRUiqG7xluh1yYkqljGaVgjB
         ySbxGUG3FlVqqSJPNSTQY7YS3BlV7GQLx44e5yrB1YBv3DfqcHp/QrqVtr9Hj5igOkVI
         Ynjw==
X-Gm-Message-State: ANoB5pnDI5D47f9TqLEz+6MLHHOLJCamhnayZUxo5iTNr3URcr4oENm/
        Q9Yzp8VUYKddAopiq3kp+feJrSMnQtn572X1vQ==
X-Google-Smtp-Source: AA0mqf4mFfYLCW1AxKxylFwSF4KzvebqyOsDWWDoMZ4XTTDIviAfprItj4RgHXP21gT8XWFIQfFAL8qn74iWKtUJJrs=
X-Received: by 2002:a17:902:bd42:b0:188:ca57:8945 with SMTP id
 b2-20020a170902bd4200b00188ca578945mr29912075plx.116.1669599687417; Sun, 27
 Nov 2022 17:41:27 -0800 (PST)
MIME-Version: 1.0
References: <20221125122912.54709-1-sunhao.th@gmail.com> <20221128003800.h2bmqcv5dfqmfbcf@MacBook-Pro-5.local>
In-Reply-To: <20221128003800.h2bmqcv5dfqmfbcf@MacBook-Pro-5.local>
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Mon, 28 Nov 2022 09:41:16 +0800
Message-ID: <CACkBjsY_Jy9seMfcMMPbYN-YMubcUzABpMm7VFe8wU+X6LKAUQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/3] bpf: Add LDX/STX/ST sanitize in jited BPF progs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,
        URIBL_DBL_ABUSE_REDIR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> =E4=BA=8E2022=E5=B9=B411=
=E6=9C=8828=E6=97=A5=E5=91=A8=E4=B8=80 08:38=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Nov 25, 2022 at 08:29:09PM +0800, Hao Sun wrote:
> > The verifier sometimes makes mistakes[1][2] that may be exploited to
> > achieve arbitrary read/write. Currently, syzbot is continuously testing
> > bpf, and can find memory issues in bpf syscalls, but it can hardly find
> > mischecking/bugs in the verifier. We need runtime checks like KASAN in
> > BPF programs for this. This patch series implements address sanitize
> > in jited BPF progs for testing purpose, so that tools like syzbot can
> > find interesting bugs in the verifier automatically by, if possible,
> > generating and executing BPF programs that bypass the verifier but have
> > memory issues, then triggering this sanitizing.
>
> The above paragraph makes it sound that it's currently impossible to
> use kasan with BPF. Which is confusing and incorrect statement.
> kasan adds all the necessary instrumentation to BPF interpreter already
> and syzbot can perform bug discovery.
> syzbot runner should just disable JIT and run all progs via interpreter.
> Adding all this logic to run JITed progs in kasan kernel is
> just unnecessary complexity.

Sorry for the confusion, I mean JITed BPF prog can't use KASAN currently,
maybe it should be called BPF_JITED_PROG_KASAN.

It's actually useful because JIT is used in most real cases for testing/fuz=
zing,
syzbot uses WITH_JIT_ALWAYS_ON[1][2]. For those tools, they may need
to run hundred times for each generated BPF prog to find interesting bugs i=
n
the verifier, JIT makes it much faster. Also, bugs in JIT can be
missed if they're
disabled.

[1] http://bit.do/syzbot-bpf-config
[2] http://bit.do/syzbot-bpf-next-config
