Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932024AE8EF
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 06:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiBIFNj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 00:13:39 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbiBIFFV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 00:05:21 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3BEC0612C3
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 21:05:25 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id n23so2349736pfo.1
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 21:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1zTDqW7UUA/zydwPQfG6NCion3xne5o6ekt+bgOOPjg=;
        b=TjlvGb64DvXcLh6IlsTBwgyCAmSTgeuXn0qzZV+qYt5Mk8eR5Nlpj7I2XqOVKK4dNd
         VCDMluePdc71lOfdBljiYo47A530CS073tMyW5EVEM/lh97VLfFmgHyqObrDfM/4IsnF
         kRX+3/uAsM6eMybdzw7Fgmn97kT5FEAD+H71iq8NueFNw3+za6uF5ywGl/oDQLljR0+w
         edVoltoHYRlmanR+micaubmcTOiCgLvQYLhbu61unjxXpYGqu81jYKYmhaQAQVR8RS0/
         Br6yLsPawaRKlhCfz7T4mSTB2pwY6CF6nyInSeNg1zSMXTt2N7bWjZb5bODTWPNGkh7T
         +rWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1zTDqW7UUA/zydwPQfG6NCion3xne5o6ekt+bgOOPjg=;
        b=2FuoilxZQaoZPorpQGZeG4S9rqzAKfPJ5bHMI1ZoV+WQ8UiUxKwhhjpG+PB8QeIT0x
         UZaphPlQmItzdZQzelTJdYWCgX5NsXOqCp9r2L4JYzN17Pkmia7qmEM45EyI6cPsEDvD
         +m9f/AMIN1Nu2oKNG+Wpr7sBn0Yr77Cgdqa2dvzB6JzOuHIEuo56MIAwsuq/LmOWix5P
         YWxOYHflav8HLjVHAO4UwulQbBd+W0yd0hqPYTTg6rNmSigvd3XlHwESfySlMAWEmQzL
         PqG0TUt5BzKXif8cvY6ndQH9aLorC+XmXF7FoEd1/AwbPGyHJaHGwJDKCD9z3U4KbDlY
         nH1Q==
X-Gm-Message-State: AOAM533GFqRG5t6OrF2p2Fdo3niBHVgxcMC552MCoFxSUqZLhPlnPnTF
        O/sHWb9aDNJD1J9/q2MbftwNCehFNTx/mFLX7rw=
X-Google-Smtp-Source: ABdhPJwSgAH38K+8kOzrVsx3SRDUALKcozBJJihOBCykFygTluUJo8Iif4xwbm7ZAc3K8JEfpika/QMZ4xBQwSvQ82o=
X-Received: by 2002:a05:6a00:2301:: with SMTP id h1mr521559pfh.77.1644383124480;
 Tue, 08 Feb 2022 21:05:24 -0800 (PST)
MIME-Version: 1.0
References: <20220208191306.6136-1-alexei.starovoitov@gmail.com>
 <20220208191306.6136-5-alexei.starovoitov@gmail.com> <CAEf4BzbZK_DG46Tf06UmcqT5rFtGg2Wwe7HB57vLOy_RdmRtJQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbZK_DG46Tf06UmcqT5rFtGg2Wwe7HB57vLOy_RdmRtJQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 8 Feb 2022 21:05:13 -0800
Message-ID: <CAADnVQK6-CVoh3mvQLmFX3fZ85vkHAaxEtazhXPSAZuZUdMd0w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/5] bpf: Update iterators.lskel.h.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 8, 2022 at 8:40 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> > -       skel->rodata =
> > -               mmap(skel->rodata, 4096, PROT_READ, MAP_SHARED | MAP_FIXED,
> > -                       skel->maps.rodata.map_fd, 0);
> > +       skel->rodata = skel_finalize_map_data(&skel->maps.rodata.initial_value,
> > +                       4096, PROT_READ, skel->maps.rodata.map_fd);
>
> here seems like both before and now, on error, nothing happens. For
> kernel mode it matches skeleton behavior (rodata will be NULL), but
> for user-space code you'll have (void *)-1, which is probably not
> great.

Yeah, not a regression, but let's add the checks while at it.
