Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD9C3D0236
	for <lists+bpf@lfdr.de>; Tue, 20 Jul 2021 21:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbhGTS5q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Jul 2021 14:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhGTS5k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Jul 2021 14:57:40 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E177C061574
        for <bpf@vger.kernel.org>; Tue, 20 Jul 2021 12:38:18 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id k27so29877044edk.9
        for <bpf@vger.kernel.org>; Tue, 20 Jul 2021 12:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=87Zu39x22hmlFVxsx4EXxi/tQ2Z0//4hyVMFspFKZ8s=;
        b=XuIICKqzMgRiLrIbKr2ZXZcCod4eJvj1ey1UW4sGwJhpLrwurwWTlEGaraSTrNFin8
         bb69ti2wa41XKvuzTyGXEPpxScI50MAgHuadB0r5i9wOuXwgVhq9EBzNrJ1RsCjXhdv4
         a7IpflI+5BfHoWfsulcjPb+xlA4IwChcPZ9T0wWP3uY7lfYHiZ5wes3RzBsfc/dmPKih
         WQ/Q7RB07wgv6Cua/+gU6sY66lQJyAE0ja5HYdt9gVLYrQyCL0AmCHb6+HAxsgTHc7Et
         S6WhBK0BTpwE6zRllNsVEAd5+h0Z4N/Hsc1ExEEB2fW9TPc1chnrRcdEw0BdmHIW/miJ
         LrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=87Zu39x22hmlFVxsx4EXxi/tQ2Z0//4hyVMFspFKZ8s=;
        b=oh6S2X0SVYFzBgfl+ATc3CTdmMO+9KqWIyiPupqnsr4va3nlBxQEIg/q+SAirXDDPK
         4Zv4a0ugvPekQzB850+WY9tlvc7nSYbjV8CwJMO2X2TFJgrbMHKj8DlEmz6/okpp8UsX
         W+NdNkmPydWEk2vtS+EjWA7M6OTRwP4/Iy8JH+m/KhWCcTLccqUSUALZ/jozMBHcRYU0
         O/9F+OldTB9PJmtzaXh1pisGdCtzwmVlpRrsYRVSMX3Ngx9rPgV1Fr2WzkgDBvZio9Ge
         adBz8NZ2Yak1hMwFBPOIbfNva++/zZh8ckrdmXuhAj+LEKbL2eqXZHWPJakFrOpKoEem
         DPMQ==
X-Gm-Message-State: AOAM530c1dOFXbPjVOFSu2nC7jPMkec3wmksMwYV74l2RVyRrZwdrQsW
        +X3q4q7mh+zeJtwaB/OD+sDP5gjMwQef68TwkoQ=
X-Google-Smtp-Source: ABdhPJxx6V0/BygzDZh3J856ETFukGabswAF05a3CObOmOzrGkOvnX9OFTbnLu7YuMWHXyKQ9y+/n87LqSo4SjU8XEE=
X-Received: by 2002:aa7:c7d0:: with SMTP id o16mr42985049eds.75.1626809897182;
 Tue, 20 Jul 2021 12:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210719223022.66681-1-vincent.mc.li@gmail.com> <20210720181913.ps2qj7ttxszijv5i@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210720181913.ps2qj7ttxszijv5i@kafai-mbp.dhcp.thefacebook.com>
From:   Vincent Li <vincent.mc.li@gmail.com>
Date:   Tue, 20 Jul 2021 12:38:06 -0700
Message-ID: <CAK3+h2ygPYPkqusDBrYwGPtDga+XNug-Jh-NE8V_kbWMM7-WBw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests, bpf: test_tc_tunnel.sh nc: cannot use
 -p and -l
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 20, 2021 at 11:19 AM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Mon, Jul 19, 2021 at 03:30:22PM -0700, Vincent Li wrote:
> > When run test_tc_tunnel.sh, it complains following error
> >
> > ipip
> > encap 192.168.1.1 to 192.168.1.2, type ipip, mac none len 100
> > test basic connectivity
> > nc: cannot use -p and -l
> >
> > nc man page has:
> >
> >      -l  Listen for an incoming connection rather than initiating
> >          a connection to a remote host.Cannot be used together with
> >          any of the options -psxz. Additionally, any timeouts specified
> >          with the -w option are ignored.
> >
> > Correct nc in server_listen().
> I have two distros and both work with -p in listen.
> However, they also work the same without -p, so it makes sense to remove it.
>

Thanks Martin, I use Centos 8 distro.

> Acked-by: Martin KaFai Lau <kafai@fb.com>
