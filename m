Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D7D272147
	for <lists+bpf@lfdr.de>; Mon, 21 Sep 2020 12:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgIUKhb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Sep 2020 06:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgIUKhb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Sep 2020 06:37:31 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF67C0613CF
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2020 03:37:30 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id x14so16384030oic.9
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2020 03:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iBfaAsgP2Wc9m9ukTSp0WO8VtZOp1OXSL6zmdWQTUqs=;
        b=crpc0nfVJbvYCNSWQXOHLOgtivRJkJBwhtZQJQd0LOq9z7JrIirEIdKKArFXNrEp65
         J7JrdkSevJkvTo9RgQQJ5soCztHibsj8PzcZke7k6WBxIKs5q/Vvr/VCAsyQkZPV8HDJ
         2SbO9eil48bZkIhN3NCANO4hrnnm0LN63u6vI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iBfaAsgP2Wc9m9ukTSp0WO8VtZOp1OXSL6zmdWQTUqs=;
        b=f183NQCbpNFvAIXgYQxTey4II8Eqgy9erc4SjuyOG0Af/0KhG1by1vrDxUMeFKMUfU
         MePaDjGXbhSjJ9WBF4LdaR+kC9sppiCzSFWbxUrLXe+yAraw0u8/sJnoLAJ/t0dxz7Wd
         anW4jaVlLzsXqrer1oerUojeP5adBYwf0Bl4je2pQ7Fyrs/9mhCmywGJ9pnpr9F+UPH5
         7XbC6t2qYnTN+qF7DUCAx7dC+zoDvQDXt9kKbyvDAGcG+1J2CvWO7l7HMFpoJZD28XDX
         UmnzT61IrT9SNNYxm1YfMaqPMfwiHHSgFnaO5+plAy5F6WXowH2DrzYsJzB9cVpKEqhO
         +X9Q==
X-Gm-Message-State: AOAM530kSbAjyZwmJKb8sWkXaF1NC1/hcpOo/qfg7om/av4sTKFeCAy1
        Si/AMdv5EbDTNwcRHY887s06l9mE+fIDf0Jx7vrwPQ==
X-Google-Smtp-Source: ABdhPJywbTIiUXIiz9lQFxuFUQCwQleYQ72E4bh5DGZlkZA8Jby0MTiFSuvmdWHYEFCXlnaWZJAeZzLPj+aEfR7c/kQ=
X-Received: by 2002:aca:f0a:: with SMTP id 10mr17598746oip.13.1600684649900;
 Mon, 21 Sep 2020 03:37:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200917143846.37ce43a0@carbon> <CANP3RGcxM-Cno=Qw5Lut9DgmV=1suXqetnybA9RgxmW3KmwivQ@mail.gmail.com>
 <56ccfc21195b19d5b25559aca4cef5c450d0c402.camel@kernel.org>
 <20200918120016.7007f437@carbon> <CANP3RGfUj-KKHHQtbggiZ4V-Xrr_sk+TWyN5FgYUGZS6rOX1yw@mail.gmail.com>
In-Reply-To: <CANP3RGfUj-KKHHQtbggiZ4V-Xrr_sk+TWyN5FgYUGZS6rOX1yw@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Mon, 21 Sep 2020 11:37:18 +0100
Message-ID: <CACAyw9-v_o+gPUpC-R9SXsfzMywrdGsWV13Nk=tx2aS-fEBFYg@mail.gmail.com>
Subject: Re: BPF redirect API design issue for BPF-prog MTU feedback?
To:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Saeed Mahameed <saeed@kernel.org>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        BPF-dev-list <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Shaun Crampton <shaun@tigera.io>,
        David Miller <davem@davemloft.net>,
        Marek Majkowski <marek@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 19 Sep 2020 at 00:06, Maciej =C5=BBenczykowski <maze@google.com> wr=
ote:
>
> > This is a good point.  As bpf_skb_adjust_room() can just be run after
> > bpf_redirect() call, then a MTU check in bpf_redirect() actually
> > doesn't make much sense.  As clever/bad BPF program can then avoid the
> > MTU check anyhow.  This basically means that we have to do the MTU
> > check (again) on kernel side anyhow to catch such clever/bad BPF
> > programs.  (And I don't like wasting cycles on doing the same check two
> > times).
>
> If you get rid of the check in bpf_redirect() you might as well get
> rid of *all* the checks for excessive mtu in all the helpers that
> adjust packet size one way or another way.  They *all* then become
> useless overhead.
>
> I don't like that.  There may be something the bpf program could do to
> react to the error condition (for example in my case, not modify
> things and just let the core stack deal with things - which will
> probably just generate packet too big icmp error).
>
> btw. right now our forwarding programs first adjust the packet size
> then call bpf_redirect() and almost immediately return what it
> returned.
>
> but this could I think easily be changed to reverse the ordering, so
> we wouldn't increase packet size before the core stack was informed we
> would be forwarding via a different interface.

We do the same, except that we also use XDP_TX when appropriate. This
complicates the matter, because there is no helper call we could
return an error from.

My preference would be to have three helpers: get MTU for a device,
redirect ctx to a device (with MTU check), resize ctx (without MTU
check) but that doesn't work with XDP_TX. Your idea of doing checks in
redirect and adjust_room is pragmatic and seems easier to implement.

--=20
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
