Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2E2FE6C4
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2019 17:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbfD2Pmj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Apr 2019 11:42:39 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43216 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728394AbfD2Pmj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Apr 2019 11:42:39 -0400
Received: by mail-ot1-f66.google.com with SMTP id u15so8999560otq.10
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2019 08:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uPWRyFwOnHxJrmou63FjPEpH1GTpfepGPs3japprjXw=;
        b=lqnRekWa9dbIraNi5UiSY4ohDHSwF6B9xg46rAn6Fzw5cvwjUVJjo4VzTBcXb6Jo2o
         fyIB/+34Sk3xW1ijxE/4hNyvMjziGTrncHvQEF80t4MkTmZWrFwvANV1bwHStRaxTC9f
         1j/f28yth6HeynPkxHP4JL4lLGPi8xDzrGkLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uPWRyFwOnHxJrmou63FjPEpH1GTpfepGPs3japprjXw=;
        b=gF0X36llV/6UeyPF/7CgZxeCw50WGYE94Wtf4ky5Bb1I2l9n+42r1Z24OwQaBGSU6/
         b9vUklASImIl2Whdr0nbLNDf4wsU3ChJpgz0IJgje6hybinL3+zwRns7WukLAc0637rO
         1wWC0ZTYnXIQ0xC2gvQxPoomiF8IsTTWZOXqIiORIusKe/ycSWujcb8t1n4Ejs5/6unU
         CtwGXxhyWpay9VSHDr2lXFLa6ad93nlLhcGMS9bpIpfZ/IP0YI9QzJhsNr648Iw+INGF
         r+DEQ3r2jDrmWiLOHN140hkoR+W3wloU/JRKSrXiRFPY7NogHW5vMxv/QxN9VXjKmNXT
         wqJw==
X-Gm-Message-State: APjAAAUc5RJbBvWd44BE0Rf4d9sEXym+37yPPV//fsbTNwyaSFkn/zXo
        0m2DmvRkk6/jvcbPN+h/Xi7/0tiO8Xdf8EUvrjcEtg==
X-Google-Smtp-Source: APXvYqxCctyR9f2N/YMUieKkb1EPq5FE2J8WzcjKHu5MzAPSAsovnGOl9M1XPgQF8uw3rEldb/xBtpRenjdKT7qLV0g=
X-Received: by 2002:a9d:4d91:: with SMTP id u17mr33805040otk.356.1556552558265;
 Mon, 29 Apr 2019 08:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190426154848.23490-1-alban@kinvolk.io> <20190426140323.4edf1127@cakuba.netronome.com>
 <CADZs7q7O9TL5wXFBq_SgAdNCkzO=3tyLnF1_chthX3jao=PKqA@mail.gmail.com> <20190427113940.223fd4d1@cakuba.netronome.com>
In-Reply-To: <20190427113940.223fd4d1@cakuba.netronome.com>
From:   Alban Crequy <alban@kinvolk.io>
Date:   Mon, 29 Apr 2019 17:42:27 +0200
Message-ID: <CADZs7q6OORsEh=agQ5gzwr8uzj9emXU5x-317tF3POsO_Z2nKw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/4] bpf: sock ops: add netns ino and dev in
 bpf context
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Alban Crequy <alban.crequy@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Iago_L=C3=B3pez_Galeiras?= <iago@kinvolk.io>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 27, 2019 at 8:39 PM Jakub Kicinski
<jakub.kicinski@netronome.com> wrote:
>
> On Sat, 27 Apr 2019 12:48:25 +0200, Alban Crequy wrote:
> > On Fri, Apr 26, 2019 at 11:03 PM Jakub Kicinski
> > <jakub.kicinski@netronome.com> wrote:
> > >
> > > On Fri, 26 Apr 2019 17:48:45 +0200, Alban Crequy wrote:
> > > > In the unlikely case where network namespaces are not compiled in
> > > > (CONFIG_NET_NS=n), the verifier will not allow access to ->netns_*.
> > >
> > > Naive question - why return an error?  init_net should always be there,
> > > no?
> >
> > True for netns_dev. However, without CONFIG_NET_NS, we cannot access netns_ino:
> >
> > (struct sock_common).possible_net_t.(struct net *):
> >
> > typedef struct {
> > #ifdef CONFIG_NET_NS
> >         struct net *net;
> > #endif
> > } possible_net_t;
> >
> > And I don't think it would make much sense to allow access to
> > netns_dev but not netns_ino.
>
> Right, if CONFIG_NET_NS=n we could just take the pointer to init_net
> directly, and not worry about the field.  IMHO it'd be preferable to
> changing the UAPI based on kernel config, but I don't feel super
> strongly.

I see the point about not changing the UAPI. So I will update the patch to:
- return netns_dev unconditionally, regardless of CONFIG_NET_NS
- return netns_ino with either the correct value or zero depending on
CONFIG_NET_NS.
