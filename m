Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF2F28563F
	for <lists+bpf@lfdr.de>; Wed,  7 Oct 2020 03:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgJGBYl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Oct 2020 21:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgJGBYk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Oct 2020 21:24:40 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1DAC0613D2
        for <bpf@vger.kernel.org>; Tue,  6 Oct 2020 18:24:40 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id j13so827207ilc.4
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2020 18:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E1dFloofMfn7FRqxtkiLA1WJPnSQWg17TfBVKxTqQ7Q=;
        b=azl677csei2OlMaql1YvG4XfQSR77N2iyicOQalBnojFLrVKmTRhhFCbf+O+etiUwI
         /XIECxhTtX69YfFZnWRi+HxfXitdEWlPCSJKZJpn3tClG1IYCyzKIp7jQBaOygkI9OEn
         ouzdB/60zjS56FyQoebrSP8qqoYNBLj+eR4I+/0mbQMOoejp+KLOu2hwRuXhk9m5+Wn7
         iOVDkddYSmKbgvnwL9HAP3/d2bpmV9DhMT7E5PMB5aZZSk1x7uwazUBkFLfa4WVtR0gI
         7bwjQN+KIKul09VTV0UcPpFjFFzF8AtSvj/mTIes+RGqRjMglmU+cTbVxLK/4Y2xlZ2j
         UkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E1dFloofMfn7FRqxtkiLA1WJPnSQWg17TfBVKxTqQ7Q=;
        b=OL5eQ84VkmxaiT1jhIEYdXVL5EPMC6Gf8++bbhxPAdlmSQ6/wZ0KK0r4BwZUgqhc48
         gJAJENJm8CJga43rsDuCr0W1MMOTaAot7K6AorIN/i+aPU8rYgdcjzyXn2mj5IlTW6wo
         c9ZgMzAiuSgcgxu+KK8kTbYYijHQqQ6ZWhPktaF2NIPhfVg+OiWOPfqOppByOPhlQqD8
         b8tIHDsSAJ85XvGok3BWD15alBukmW8Tq/1f+nXF+leW3fcZC2fX6lWwFe9h3tNQY4UV
         litr1QmooylisFGPeQRYE/kNz0IbYCxzx3gLY5CF1e1NcKkBvwOyDbf/2i3pHOlhoN0G
         iYAA==
X-Gm-Message-State: AOAM532nJ2hirEBC9DdK13Bc7XQqN+z/JTPyyaeJarcSYOFeTpf7sH6A
        fHzhmRvFBolNF+XePXU986M7c30l2H11+Joxi6oLRXoIP/NEsw==
X-Google-Smtp-Source: ABdhPJzrDkLjNAhcNX1cvoHWN/nDJNz6SaUIp6T0XSS/DNMJuK3r9FApm2wNN58dxCkbu7ILNjZLWzpJhvNEBDm5QNw=
X-Received: by 2002:a92:9408:: with SMTP id c8mr726209ili.61.1602033879796;
 Tue, 06 Oct 2020 18:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <160200013701.719143.12665708317930272219.stgit@firesoul>
 <160200018165.719143.3249298786187115149.stgit@firesoul> <20201006183302.337a9502@carbon>
 <20201006181858.6003de94@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201006181858.6003de94@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date:   Tue, 6 Oct 2020 18:24:28 -0700
Message-ID: <CANP3RGe3S4eF=xVkQ22o=sxtW991jmNfq-bVtbKQQaszsLNZSA@mail.gmail.com>
Subject: Re: [PATCH bpf-next V1 3/6] bpf: add BPF-helper for reading MTU from
 net_device via ifindex
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        bpf <bpf@vger.kernel.org>, Linux NetDev <netdev@vger.kernel.org>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Shaun Crampton <shaun@tigera.io>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Marek Majkowski <marek@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 6, 2020 at 6:19 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Tue, 6 Oct 2020 18:33:02 +0200 Jesper Dangaard Brouer wrote:
> > > +static const struct bpf_func_proto bpf_xdp_mtu_lookup_proto = {
> > > +   .func           = bpf_xdp_mtu_lookup,
> > > +   .gpl_only       = true,
> > > +   .ret_type       = RET_INTEGER,
> > > +   .arg1_type      = ARG_PTR_TO_CTX,
> > > +   .arg2_type      = ARG_ANYTHING,
> > > +   .arg3_type      = ARG_ANYTHING,
> > > +};
> > > +
> > > +
>
> FWIW
>
> CHECK: Please don't use multiple blank lines
> #112: FILE: net/core/filter.c:5566:

FYI: It would be nice to have a similar function to return a device's
L2 header size (ie. 14 for ethernet) and/or hwtype.

Also, should this be restricted to gpl only?

[I'm not actually sure, I'm actually fed up with non-gpl code atm, and
wouldn't be against all bpf code needing to be gpl'ed...]
