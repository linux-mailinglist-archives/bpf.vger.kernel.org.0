Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2021BFEB
	for <lists+bpf@lfdr.de>; Tue, 14 May 2019 01:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfEMXpi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 May 2019 19:45:38 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41854 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfEMXph (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 May 2019 19:45:37 -0400
Received: by mail-yw1-f67.google.com with SMTP id o65so12470383ywd.8
        for <bpf@vger.kernel.org>; Mon, 13 May 2019 16:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I61dv/srKkbPr0MSpNNyf5HMVuXv4XnCDZMGZoEsBtg=;
        b=edP2unho3JGfLVtRf4xIIeNbT/1DKDyqQVTwvP5XUpMVKx5NqhxzehVcbDKHzP6RC2
         dV1+g8QZah6EIbPImPJIGmLn0c+8Gq7azQ+fl0CcULfpfJsnhdODBzNXSgHawHmMR2x3
         RP3kG+SJf47u611zaWk0uB4C0OLU3JJ5tCLEzP48lELR9A6YNbipT2rIXjROr/YAiABB
         wXJsu1kd8qhiHxSJxcEW7auCj6xPGrxFE4+90qvoBRwxlHZ0uaLJhuX6GFExFV7Gth0G
         CcgUw48M2f3YB/cWWjKB7lmNGtYpn+C4xSt47jmsj/qFklkQ6P3pAmslQaT1CKvrVnh2
         gdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I61dv/srKkbPr0MSpNNyf5HMVuXv4XnCDZMGZoEsBtg=;
        b=mY22JTfaP0gIy5YNSqywEYb1C7oVtXk+VuYalVQmNEIhMon5dUk5KsvAl5GiHetwas
         64K6EKdpM3830q03dkPg0kYU6py0BbBoYdBA84ku/6H7bgF1NDFbunf2g+EdWlByWw4/
         hCNrnWy1z0ARPFG3Ef0/76SBQIS6K3lXp8NJyNuWdG8VTmnaVrZyhJxfisGe1uMAuZHS
         udCSg9tZicKByffu6IRfrLTFP7Yyt3ClS0Ypj2QSh000UrOVq1DR6RNjs/Dzvj+QR3Xd
         sJFvC700FWkiilaAxj6tOu1a7VZ9sk9Qr+dPFImLwNTaK44mVKrhA99PbaZ5viEs/Vid
         y1SA==
X-Gm-Message-State: APjAAAV+CKsnh2TpzXpppavNLBbmBt/j8IqJFrx8ILBF45NkYnkTQC+g
        tbVHzrmKFYaJ1Zc7fUTICrPLtr4Q
X-Google-Smtp-Source: APXvYqxxnJT1ugPDT0lzKtpAFQXHJvQanNBo4/Q3UycxJ2gvtttVKJGmJYNpo4x6mD0rmvkrACZbOQ==
X-Received: by 2002:a25:d196:: with SMTP id i144mr14928630ybg.241.1557791136278;
        Mon, 13 May 2019 16:45:36 -0700 (PDT)
Received: from mail-yw1-f47.google.com (mail-yw1-f47.google.com. [209.85.161.47])
        by smtp.gmail.com with ESMTPSA id 136sm1166583yww.63.2019.05.13.16.45.34
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 16:45:35 -0700 (PDT)
Received: by mail-yw1-f47.google.com with SMTP id 186so12481049ywo.4
        for <bpf@vger.kernel.org>; Mon, 13 May 2019 16:45:34 -0700 (PDT)
X-Received: by 2002:a0d:e386:: with SMTP id m128mr16039351ywe.283.1557791134580;
 Mon, 13 May 2019 16:45:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190513185402.220122-1-sdf@google.com> <CAF=yD-LO6o=uZ-aT-J9uPiBcO4f2Zc9uyGZ+f7M7mPtRSB44gA@mail.gmail.com>
 <20190513210239.GC24057@mini-arch> <CAF=yD-JKbzuoF_q7gPRjMNCBexn4pxgQ6pTeQSRfPXmwWk5dzg@mail.gmail.com>
 <CAF=yD-Lg16ETT09=fRd2FTx2FJoGZ9K0s-JHrhv-9OMTqE+5BQ@mail.gmail.com>
 <20190513230513.GA10244@mini-arch> <CAKH8qBvG00EJVQ+YqNDOP-YuCRACB0q0c9G51Dgow9a1uzZnGQ@mail.gmail.com>
In-Reply-To: <CAKH8qBvG00EJVQ+YqNDOP-YuCRACB0q0c9G51Dgow9a1uzZnGQ@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 13 May 2019 19:44:58 -0400
X-Gmail-Original-Message-ID: <CA+FuTScvioH_f2Gew0e9Qh48bWYYBzAdVV4Hk3roGNEmLE8rfQ@mail.gmail.com>
Message-ID: <CA+FuTScvioH_f2Gew0e9Qh48bWYYBzAdVV4Hk3roGNEmLE8rfQ@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] flow_dissector: support FLOW_DISSECTOR_KEY_ETH_ADDRS
 with BPF
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Stanislav Fomichev <sdf@fomichev.me>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Petar Penkov <ppenkov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Stanislav Fomichev <sdf@google.com>
Date: Mon, May 13, 2019 at 7:21 PM
To: Stanislav Fomichev
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Network
Development, bpf, David Miller, Alexei Starovoitov, Daniel Borkmann,
Willem de Bruijn <willemb@google.com>, Petar Penkov

> > On 05/13, Willem de Bruijn wrote:
> > > On Mon, May 13, 2019 at 5:21 PM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > On Mon, May 13, 2019 at 5:02 PM Stanislav Fomichev <sdf@fomichev.me> wrote:
> > > > >
> > > > > On 05/13, Willem de Bruijn wrote:
> > > > > > On Mon, May 13, 2019 at 3:53 PM Stanislav Fomichev <sdf@google.com> wrote:
> > > > > > >
> > > > > > > If we have a flow dissector BPF program attached to the namespace,
> > > > > > > FLOW_DISSECTOR_KEY_ETH_ADDRS won't trigger because we exit early.
> > > > > >
> > > > > > I suppose that this is true for a variety of keys? For instance, also
> > > > > > FLOW_DISSECTOR_KEY_IPV4_ADDRS.
> > > >
> > > > > I though the intent was to support most of the basic stuff (eth/ip/tcp/udp)
> > > > > without any esoteric protocols.
> > > >
> > > > Indeed. But this applies both to protocols and the feature set. Both
> > > > are more limited.
> > > >
> > > > > Not sure about FLOW_DISSECTOR_KEY_IPV4_ADDRS,
> > > > > looks like we support that (except FLOW_DISSECTOR_KEY_TIPC part).
> > > >
> > > > Ah, I chose a bad example then.
> > > >
> > > > > > We originally intended BPF flow dissection for all paths except
> > > > > > tc_flower. As that catches all the vulnerable cases on the ingress
> > > > > > path on the one hand and it is infeasible to support all the
> > > > > > flower features, now and future. I think that is the real fix.
> > > >
> > > > > Sorry, didn't get what you meant by the real fix.
> > > > > Don't care about tc_flower? Just support a minimal set of features
> > > > > needed by selftests?
> > > >
> > > > I do mean exclude BPF flow dissector (only) for tc_flower, as we
> > > > cannot guarantee that the BPF program can fully implement the
> > > > requested feature.
> > >
> > > Though, the user inserting the BPF flow dissector is the same as the
> > > user inserting the flower program, the (per netns) admin. So arguably
> > > is aware of the constraints incurred by BPF flow dissection. And else
> > > can still detect when a feature is not supported from the (lack of)
> > > output, as in this case of Ethernet address. I don't think we want to
> > > mix BPF and non-BPF flow dissection though. That subverts the safety
> > > argument of switching to BPF for flow dissection.
> > Yes, we cannot completely avoid tc_flower because we use it to do
> > the end-to-end testing. That's why I was trying to make sure "basic"
> > stuff works (it might feel confusing that tc_flower {src,dst}_mac
> > stop working with a bpf program installed).
> >
> > TBH, I'd not call this particular piece of code that exports src/dst
> > addresses a dissection. At this point, it's a well-formed skb with
> > a proper l2 header and we just copy the addresses out. It's probably
> > part of the reason the original patch didn't include any skb->protocol
> > checks.

But it is not guaranteed to be an Ethernet link layer device. Making
this a good example of why when moving to BPF for safety we should not
keep any C dissection code in the path at all.

> On the other hand, we can probably follow a simple rule:
> if it's not exported via bpf_flow_keys (and src/dsc mac is not),
> tc_flower is not supported as well.

Agreed. I was using that as point of reference just now, too.
