Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B7F2F1FC9
	for <lists+bpf@lfdr.de>; Mon, 11 Jan 2021 20:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391018AbhAKTtk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jan 2021 14:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388832AbhAKTtk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jan 2021 14:49:40 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA92C0617A2
        for <bpf@vger.kernel.org>; Mon, 11 Jan 2021 11:48:59 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id jx16so43295ejb.10
        for <bpf@vger.kernel.org>; Mon, 11 Jan 2021 11:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5h4A0L7tVN4UX2Z9TEeukCL57ohmt7+pkrlPJsYpILQ=;
        b=VDg8dCYtAFhytjYdQX3IeN8lvLiYAz0Cn/mrMOCp8xwLfm7tMImb2UMwRiwNRPglte
         htUiDgZqfjxPpoXjARbTocD6qg70FQ3KAEkE1T1QXqgMBgAr9FxG2n28rm9vwAYVY+eN
         KVlkv4MUgpbRrN+t5JKrQ0FN2frPiCt8GfZljxHMaeA5eLKmma8yh7sjy3ujQFJyA7Mz
         fxeIwgzHBCp/3B6Pfk6y2AZti+ZrWBRxJyyMDGKOVlBiqI6F8dXxAsmKhtC5kp+iTOBr
         3lmy0D1cBK8jRomDIyb4vuVioKfdzN+lJKtwQ2enxe7SPr9KMHby/AUlR6tWZIin5Ns+
         6wIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5h4A0L7tVN4UX2Z9TEeukCL57ohmt7+pkrlPJsYpILQ=;
        b=YLc/i0Wo7np/6Eu4OcLBCoN1+HcZgazIrIfveg1BEtqQ5QSurJL4CieYHR2oukIyui
         PiQQBsgPBsuiPv+mu3Av7d6uCaxg4izfbMpn/ZJMl7n7JF/QIglvA8BnXE1yP/jjCh6R
         vDEKaX3bt41H0CXhe/o4alABDHNKKCTLeJtpVF12lBRp0Y5S/suavmkuCb74iBdVAuXE
         icmikmh+rPoSxA6c65Cn9ydKDtpoMO01h7osZF+2IM5YVWUhOeR7luSvqr/pYMIJZlUa
         cAhmit98X6IDcVqEi01wouagaTt8pAB3FOiBiL8YiDopAQU15jiPbHyZuqJtEe3eP3sB
         h9cg==
X-Gm-Message-State: AOAM533C5mgFuhr9qXer62fAvtOKRg80/FKKssP6INK2FkYSMiR/nMOd
        P0hnz2pz1/ygVP0kieyMO+S3Z0MSlfsiQYP57Rg=
X-Google-Smtp-Source: ABdhPJz2NajkdpKj1LFdnnybXKVqQsqYY4hG4XF/gzBvHvg247f7Zrh7gm2H03E5fHmO8KhJGLR5EEm4ZwKRgcR8WLs=
X-Received: by 2002:a17:907:4243:: with SMTP id np3mr736413ejb.212.1610394538702;
 Mon, 11 Jan 2021 11:48:58 -0800 (PST)
MIME-Version: 1.0
References: <CAHAzn3rz5ZH25-53+ijGXhzoV2DqiOhEtV==V2k2R72AwpGAdA@mail.gmail.com>
 <20210111111949.18236404@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210111111949.18236404@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Konstantinos Kaffes <kkaffes@gmail.com>
Date:   Mon, 11 Jan 2021 11:48:47 -0800
Message-ID: <CAHAzn3o4HQQAXXnGg8My14z8dJmREkVDsBheNtxwtNHZB+xp-Q@mail.gmail.com>
Subject: Re: [QUESTION] TCP connected socket selection
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 11 Jan 2021 at 11:19, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Mon, 11 Jan 2021 10:33:49 -0800 Konstantinos Kaffes wrote:
> > Hi everyone,
> >
> > It is the first time I am posting to a kernel mailing list so please
> > let me know if this question needs to be directed elsewhere.
> >
> > I have been using BPF to programmatically steer UDP datagrams to
> > sockets using the "sk_reuseport" hook.
> >
> > Similarly, I would like to identify request boundaries within a TCP
> > stream/connection and programmably forward requests to different
> > sockets *after* a connection is established. Is there a way to do that
> > in the kernel using BPF?
>
> Sounds like what KCM does.

Thanks! KCM would work but it is unclear to me how I can specify the
policy used by the multiplexor to match messages to specific sockets.

The documentation has examples on how to do the delineation but
nothing on how to specify the matching policy.
