Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8FCE41C4CB
	for <lists+bpf@lfdr.de>; Wed, 29 Sep 2021 14:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343810AbhI2MeK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Sep 2021 08:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343788AbhI2MeJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Sep 2021 08:34:09 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20992C061755
        for <bpf@vger.kernel.org>; Wed, 29 Sep 2021 05:32:28 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id m3so10079377lfu.2
        for <bpf@vger.kernel.org>; Wed, 29 Sep 2021 05:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ndDKb4ocgk1iK0hmC5H/ny854jlbnAfasAKNdkETtL4=;
        b=KfftChFrLOLM8wlW4kmiNVvAoNKl9qqCwKqwfT+RP5bRXl5T4baBvHKk9efzO7vYVk
         +E8KRD40L/mPbLJpZdb71SUDKqd41phKxet34zq+q7xjoIONjnad5clcGUD/cPR9rwdr
         jiEaiQAvaZJzPyNvLU7aTFix7ixi4oJk3eJTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ndDKb4ocgk1iK0hmC5H/ny854jlbnAfasAKNdkETtL4=;
        b=3UPHghKIpkN1La7X346jHkAHcreXhA2zHxm/SKC1lXcj0OlwHujGhZBIXXP1fKS3lc
         Yn52kaUgT16IR7jLaQQtW5cudv2Vnb8wOu1FfOEA7WBIBPynP5ZCOZMsG4sMwsKatYe4
         xJqJHo4In4KyWgvu9B5ZfxFWIEGHrI4CQJD+XQ4geLMHfIj3DBSuD40wJ8KP/7WDTQpY
         yO2ZyKtnUWrLzN5qGgtW2N/IfaiHR2V1UihSc9muzQNc5LldJX1AEmZ/0evrD3V6Vhnu
         WPvZWpj1aCKpnTf4WmT5dtqCKLe0/5O/Gtrr+gqagTGOZDCABTJtpUOPzXDZiHZE7fwA
         oKbQ==
X-Gm-Message-State: AOAM5308WabDRY8LcuR4G5OuO7KfavcU3yDrePkTToyrPClsJkEjLDbu
        zWPBOfqd7SCdhvhPiJOXmN1KSMLWtmAeBHwzNMtWOA==
X-Google-Smtp-Source: ABdhPJyhIkFlhqEH6hUVdyzJzolTdBw/zS6TUI63McPfkMK8YRiz5FojUSAdpY25pMgcHh3nmcANAnV7mQAcpjsbBjk=
X-Received: by 2002:ac2:4c45:: with SMTP id o5mr11382759lfk.620.1632918746426;
 Wed, 29 Sep 2021 05:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631289870.git.lorenzo@kernel.org> <20210916095539.4696ae27@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <YUSrWiWh57Ys7UdB@lore-desk> <20210917113310.4be9b586@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAADnVQL15NAqbswXedF0r2om8SOiMQE80OSjbyCA56s-B4y8zA@mail.gmail.com>
 <20210917120053.1ec617c2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAADnVQKbrkOxfNoixUx-RLJEWULJLyhqjZ=M_X2cFG_APwNyCg@mail.gmail.com>
 <614511bc3408b_8d5120862@john-XPS-13-9370.notmuch> <8735q25ccg.fsf@toke.dk>
 <20210920110216.4c54c9a3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <87lf3r3qrn.fsf@toke.dk> <20210920142542.7b451b78@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <87ilyu50kl.fsf@toke.dk> <CACAyw98tVmuRbMr5RpPY_0GmU_bQAH+d9=UoEx3u5g+nGSwfYQ@mail.gmail.com>
 <87sfxnin6i.fsf@toke.dk>
In-Reply-To: <87sfxnin6i.fsf@toke.dk>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 29 Sep 2021 13:32:15 +0100
Message-ID: <CACAyw9-Ni4UaZuUOJHpO2xm2y6Dwtcn98gWsYW1ShmQg-W8TxQ@mail.gmail.com>
Subject: Re: [PATCH v14 bpf-next 00/18] mvneta: introduce XDP multi-buffer support
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, shayagr@amazon.com,
        David Ahern <dsahern@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Saeed Mahameed <saeed@kernel.org>,
        "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        tirthendu.sarkar@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 29 Sept 2021 at 13:25, Toke H=C3=B8iland-J=C3=B8rgensen <toke@redha=
t.com> wrote:
>
> > Then use the already existing (right ;P) inlining to do the following:
> >
> >    if (md->ptr + args->off !=3D ret_ptr)
> >      __pointer_flush(...)
>
> The inlining is orthogonal, though, right? The helper can do this check
> whether or not it's a proper CALL or not (although obviously for
> performance reasons we do want it to inline, at least eventually). In
> particular, I believe we can make progress on this patch series without
> working out the inlining :)

Yes, I was just worried that your answer would be "it's too expensive" ;)

> > This means that __pointer_flush has to deal with aliased memory
> > though, so it would always have to memmove. Probably OK for the "slow"
> > path?
>
> Erm, not sure what you mean here? Yeah, flushing is going to take longer
> if you ended up using the stack pointer instead of writing directly to
> the packet. That's kinda intrinsic? Or am I misunderstanding you?

I think I misunderstood your comment about memcpy to mean "want to
avoid aliased memory for perf reasons". Never mind!

--=20
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
