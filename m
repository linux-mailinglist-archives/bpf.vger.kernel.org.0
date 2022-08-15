Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA58559521F
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 07:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiHPFhU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 01:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiHPFhC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 01:37:02 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00594B1EB
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 15:18:56 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id c20so6776715qtw.8
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 15:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=qxtNf6fX8cIw0yI1Ur7Wz/3t9xhxT41iz4xhFQ5+c6A=;
        b=J105rOAy7cvLXsOnDlW/cwvKMmLL+skCwMd8MHOjXbwkf4k0KF6LOaRoZuSmdIhxd/
         zbmAXRg2LuI/J1649EGU6NjSJf/FxsEILzjw0CmadSXnG8anLfaYFGrVaJR5nS0i4JMC
         r75Zey16Zd7H6sojFSNrAtusCLek6LyRC0LRr/XMSpRw5WHeorMjRcweWENrkVKPXO8/
         Nl1h9QnbbzFK40Y+zFBxuT6qWQhiHiYatiSLw0qZ23CaQjmiOAJQ7iRmcoAk8cnQ1b81
         1hGgV++fUw5EOVYszlt0skt4bG2iPCMCYPeZtHWk2Bcga6hcvleObNu/n4Dju0GP648C
         MYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=qxtNf6fX8cIw0yI1Ur7Wz/3t9xhxT41iz4xhFQ5+c6A=;
        b=o9b2TubReZc13hcwxUGEloKWKDw8bGq8vhWplXDsEDrjm1GHBvsZD4dZKChCDS15hh
         MAOGBwJwQEMup9UENPHdvzkgtvcbDghv3Sa/rWxhNLk5lxf5XK3E+DCjxo50R9JY6si/
         ooYKylaqmucyo9kWL+s77t+hDAE63PndKEPKzZOoQEhprB2tVmkU/sAkMlFx7jKYy0uU
         HFDizRBW3jpGcWQl21cKxKu9yKadBQpD4Ll4j4aF9+Ic/2TuFZY/1ZDqPc+opjCoZCuL
         VtPfv51kS526fcncwn1X+dQz2hzXyxwAKzNvwAhA3iISeVQOU2pGTikXbPSBVmbfs35Q
         VQtw==
X-Gm-Message-State: ACgBeo2G33JJKv81hGmPvXwRnksIg1fLpEFK+iu+8E7MxIGm42Hwz0ne
        F199b8vBsrcaM1uVE4NV86On4hKo0o2Od5MsFz8pjn22/Jouzw==
X-Google-Smtp-Source: AA6agR5WvbM0X0EeI47wlv0vLtPpbCvpoclz3DGmTe5PYsjV9CiY45b5OqFx7u8Eu1sCf/gmy5GC1+kgnL+fRg7vkBs=
X-Received: by 2002:a05:622a:20c:b0:343:f3:b191 with SMTP id
 b12-20020a05622a020c00b0034300f3b191mr16584523qtx.389.1660601936083; Mon, 15
 Aug 2022 15:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAK3+h2zUvfa8pQ37h3ZzSx9n34sTPSUAmSR8grvwQU3OtksiTg@mail.gmail.com>
In-Reply-To: <CAK3+h2zUvfa8pQ37h3ZzSx9n34sTPSUAmSR8grvwQU3OtksiTg@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Mon, 15 Aug 2022 23:18:44 +0100
Message-ID: <CACdoK4LOu7S5GzDwjEBkOyFqEo2uG-0c7AQF7nN0Fif6rbHFKA@mail.gmail.com>
Subject: Re: Error: bug: failed to retrieve CAP_BPF status: Invalid argument
To:     Vincent Li <vincent.mc.li@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Vincent,

On Mon, 15 Aug 2022 at 18:46, Vincent Li <vincent.mc.li@gmail.com> wrote:
>
> Hi,
>
> I compile and run kernel 5.18.0 in Centos 8 from bpf-next in my dev
> machine, I also compiled bpftool from bpf-next on same machine, when
> run bpftool on same machine, I got :
>
> ./bpftool feature probe
>
> Error: bug: failed to retrieve CAP_BPF status: Invalid argument
>
> where bpftool to retrieve CAP_BPF ? from running kernel or from somewhere else?

Yes, bpftool calls cap_get_proc() to get the capabilities of the
current process. From what I understand of your output, it looks like
capget() returns CAP_BPF: I believe the "0x1c0" value at the end is
(1<<(CAP_CHECKPOINT_RESTORE-32)) + (1<<(CAP_BPF-32)) +
(1<<(CAP_PERFMON-32)). You could probably check this with a more
recent version of strace.

Then assuming you do retrieve CAP_BPF from capget(), I don't know why
cap_get_flag() in bpftool fails to retrieve the capability state. It
would be worth running bpftool in GDB to check what happens. The check
in libcap is here [0] but I don't see where we would fail to provide
valid arguments. Just in case, could you please let me know what
version of libcap you're using when compiling bpftool?

Thanks,
Quentin

[0] https://git.kernel.org/pub/scm/libs/libcap/libcap.git/tree/libcap/cap_flag.c?h=libcap-2.65#n12
