Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2372F6B6A24
	for <lists+bpf@lfdr.de>; Sun, 12 Mar 2023 19:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjCLSfv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 12 Mar 2023 14:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjCLSfh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 12 Mar 2023 14:35:37 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D00523867
        for <bpf@vger.kernel.org>; Sun, 12 Mar 2023 11:33:36 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id s11so40199369edy.8
        for <bpf@vger.kernel.org>; Sun, 12 Mar 2023 11:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678645635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WsRZT+ef9H+1lqwwsdIJLrDXHSy+DiA97fB5isTTWo=;
        b=J5WttiKioYp2eZFRfIpHpbP4hEG8edUT9XmSmn/QUHjBWXnFTntM7gS9xA2x3oRZVA
         rWRQFsSO+220RkqynQZd1DjNl7D4BHuB58KOog/nEWIoblZvfI2+/kaL51gz6gDjaDSJ
         j8AUHdWiENmd8LYLUWxTjPEu7aOWw0IwCRKgt/4Vq8CKvcMTw0/dzwBZueiMLRUrcCs/
         zdMvUMDpU50cGYbjc242tq+KMcxxrCo9E/Po/tinvVEBhzJSrSOr4lV9bojQmQQ+GTJx
         Gp4HiUo1QPBDqQk3bCmUTkCx6ZoIWk3iHD/V7112p+8XWEJcFSuhZ29Uxq5TSfo3G3y4
         N6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678645635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5WsRZT+ef9H+1lqwwsdIJLrDXHSy+DiA97fB5isTTWo=;
        b=hZlvFaz2AuqxcOfLhRvFRJg8ps0l5+oqHmMu80Jv12LcvRzesvkKkkXPaS96BI+gPb
         UO+BHz2f+wzO/TPyZfI/PcO2R01qyrpAZ1pwyIPHT4Uir9Azlza1EZEKBtYrdaX4Izl5
         +H8XFTV5tp+YYBSu+5tdNuBshomXVJZ3Lu8gJUM12CZLqCvBfaj7ZCaAJRRTmtwxHpMK
         iJ31UIfU7yEY2Jzci1ocgNTORvG3ZBOCD9USeU1eSPNTf1mIU7GO0RK2CJygOohI6/70
         HMCif5EtPSgk6SOZOwHbjD6npzrMZUai8w3moTRJTLKP/CyoLRIypbXkdWhOOQ4p+dTr
         3viQ==
X-Gm-Message-State: AO0yUKUQqPppeieFbbyxz8tvt6A/pe87WyXyRXokD1JVyEh6Iup/cq3Z
        meHc3BOxC0KH0D1D+8Hdj8xI5DzMb7rMRsFDktM=
X-Google-Smtp-Source: AK7set/HQAmkUIiGUFZRPifsxVgNCPckt3WWuAA47iybfJlHmOIfr9/edxg/7cIlciaz48CA1eEMAHwVx9zmIoUpHSI=
X-Received: by 2002:a17:906:a00a:b0:8ae:9f1e:a1c5 with SMTP id
 p10-20020a170906a00a00b008ae9f1ea1c5mr15327624ejy.3.1678645635399; Sun, 12
 Mar 2023 11:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <CANk7y0gsUpnVnDMh=Wbs5h2Z=25bzMEZ5La03-MX133DPd=eDA@mail.gmail.com>
 <CANk7y0gPMe3tgUbWSgD9wiiN0RM=FZfws1ZrgM_AmvNxSkpQiQ@mail.gmail.com>
In-Reply-To: <CANk7y0gPMe3tgUbWSgD9wiiN0RM=FZfws1ZrgM_AmvNxSkpQiQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 12 Mar 2023 11:27:04 -0700
Message-ID: <CAADnVQ+8P6JpvkzFKDT1jyX9d2Bdvx1iCbvzEcToYZ16Koak-g@mail.gmail.com>
Subject: Re: [RFC] Implementing the BPF dispatcher on ARM64
To:     Puranjay Mohan <puranjay12@gmail.com>,
        Florent Revest <revest@chromium.org>,
        KP Singh <kpsingh@kernel.org>
Cc:     bjorn@rivosinc.com, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Mar 12, 2023 at 11:24=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.c=
om> wrote:
>
> Hi,
>
> On Fri, Mar 10, 2023 at 3:03=E2=80=AFPM Puranjay Mohan <puranjay12@gmail.=
com> wrote:
> >
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
>
> I realized that after [2] the BPF dispatcher is using the
> bpf_prog_pack allocator.
>
> We need to implement bpf_arch_text_copy() and bpf_arch_text_invalidate() =
to
> enable the bpf_prog_pack allocator for ARM64. Then we can use it in
> the JIT as well.

You probably want to sync up with Florent. He is working on arm64
trampoline support. Your works don't conflict as far as I can tell,
but still good
to align.
