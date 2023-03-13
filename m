Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917A36B7821
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 13:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjCMM4y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 08:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjCMM4x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 08:56:53 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CCA664E1
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 05:56:43 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id t11so15601097lfr.1
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 05:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678712202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDE5RvMJtcPYzl9Ly1ZFRH+AZ97YrCUrt9zJU4/kSHA=;
        b=eR7Di6+1FttoAWWg+0Dcviq/EuIwWALhfpBR6TrGACptMNwNEc8gtuMnrnewC3ieYM
         vOr/LoiFRiXp7XjKBYAWm8TBFgT/AZWfLnVSPSJXescOU3J5tVRAyYTU+C1Xc0chWcbV
         gwCGQP7JdA+OyEt7AzRskwf4X6OU3XmARi1Rzx6r+XRjDKm+MVyMPNykWuozYhDlE6EL
         bLkfGCl0jKSF7LtzfrY9mim2BiYMyjKuxSYPs7X+uRxGxnvDAZhgTnZcNZj9UBBj2NKS
         Zt+emgKJnAuCu9a55OZVpE8qPz5PFeiRD5uzBDo9668Bz2wkCzpN1bjrE1Xki11DVhgT
         TuQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678712202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDE5RvMJtcPYzl9Ly1ZFRH+AZ97YrCUrt9zJU4/kSHA=;
        b=jWlcV1xNggzP/IdqUWZc+M394VTIlw2Xv2Sye9st8sMIkL57OpXRfJDzplzpCWSe3I
         GrRpxdYP0P3eCw0/T8QlN9amm/0m1v8nYvxkIoeMHCY8K4OkxH1y5mdIOsXG31s8XlAf
         +fU4NfiSS5e3u7PndnN1vcEgQJU6q1cDEh4kc43Wcz8dNQLHYTkxy2xfuJdpjyOU5OgO
         /Eu+YEQ+2pZ5hFCu/XCxlxqxIU633yY/yqu/dDWx33H8AE7oCNoqxV3TqQBlYhqNnnOG
         yERkU3N7fgyFcyvQfbLMA1dCjbQ4TJL6EVr5a2lRvJ945iiD8tDhPGYu2iYd3uo32S7E
         n8VA==
X-Gm-Message-State: AO0yUKVkR5mPDE7DUVneXauHNGsyNOLC2zPqOJ44VE+swmo/xl5VA0EE
        nAY9ZmLyZluyji0Y7bjQ1G8DFd9th1Jyg1DcXwk=
X-Google-Smtp-Source: AK7set8dBEb26HDOLnwbu24Nr1KdjuPuRf39RhDwiy4LFF6BE2ieYh/OxolgnRtyQzYCQaWN9JJ52PT7YKPLV0A3Lhk=
X-Received: by 2002:ac2:43d5:0:b0:4db:266c:4337 with SMTP id
 u21-20020ac243d5000000b004db266c4337mr10710347lfl.1.1678712201591; Mon, 13
 Mar 2023 05:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <CANk7y0gsUpnVnDMh=Wbs5h2Z=25bzMEZ5La03-MX133DPd=eDA@mail.gmail.com>
 <c6d5e819-3e57-8e54-3cfd-d5a9814d96d1@huawei.com>
In-Reply-To: <c6d5e819-3e57-8e54-3cfd-d5a9814d96d1@huawei.com>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Mon, 13 Mar 2023 18:26:30 +0530
Message-ID: <CANk7y0jYf46AQV7=FXkJAie0F_dXoMXp5A4CWgDhRcMR3o1ZDQ@mail.gmail.com>
Subject: Re: [RFC] Implementing the BPF dispatcher on ARM64
To:     Xu Kuohai <xukuohai@huawei.com>
Cc:     bjorn@rivosinc.com, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        daniel@iogearbox.net, bjorn@kernel.org, andrii@kernel.org,
        ast@kernel.org, bpf@vger.kernel.org, memxor@gmail.com,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Florent Revest <revest@chromium.org>,
        KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[CC: Florent, KP]

On Mon, Mar 13, 2023 at 7:50=E2=80=AFAM Xu Kuohai <xukuohai@huawei.com> wro=
te:
>
> [ cc arm list ]
>
> On 3/10/2023 5:33 PM, Puranjay Mohan wrote:
> > Hi,
> > I am starting this thread to know if someone is implementing the BPF
> > dispatcher for ARM64 and if not, what would be needed to make this
> > happen.
> >
> > The basic infra + x86 specific code was introduced in [1] by Bj=C3=B6rn=
 T=C3=B6pel.
> >
> > To make BPF dispatcher work on ARM64, the
> > arch_prepare_bpf_dispatcher() has to be implemented in
> > arch/arm64/net/bpf_jit_comp.c.
> >
> > As I am not well versed with XDP and the JIT, I have a few questions
> > regarding this.
> >
> > 1. What is the best way to test this? Is there a selftest that will
> > fail now and will pass once the dispatcher is implemented?
> > 2. As there is no CONFIG_RETPOLINE in ARM64, will the dispatcher be use=
ful.
>
> Hello,
>
> I have some thoughts for bpf dispatcher in arm64.
>
> bpf dispatcher uses static call to convert indirect call instructions to =
direct
> call instructions, to avoid performance penalty introduced by retpoline. =
Since
> there is no retpoline or static call in arm64, bpf dispatcher seems usele=
ss.
>
> In addition, the range for a direct call instruction in arm64 is +-128MB,=
 but
> jited bpf image address is outside of +-128MB, so it may not be possible =
to call
> a bpf prog with direct call instruction.

So, to summarize all the information about BPF Dispatcher on ARM64:
1. The range for the B and BL instructions in arm64 is +-128MB, so we
can't use direct jump.
2. Static Calls are not supported on ARM64 yet.
3. bpf_prog_pack allocator for ARM64 is not yet enabled because
bpf_arch_text_copy()
and bpf_arch_text_invalidate() are not implemented.

Even if static calls are implemented the dispatcher can't be
implemented because of point 1.

What would be required to implement bpf_arch_text_copy()
and bpf_arch_text_invalidate(). As enabling the bpf_prog_pack
allocator for ARM64
would be useful in the JIT as well.

>
> >
> > [1] https://github.com/torvalds/linux/commit/75ccbef6369e94ecac696a152a=
998a978d41376b
> >
>


--=20
Thanks and Regards

Yours Truly,

Puranjay Mohan
