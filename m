Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C726341C36E
	for <lists+bpf@lfdr.de>; Wed, 29 Sep 2021 13:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245199AbhI2L1y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Sep 2021 07:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244819AbhI2L1x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Sep 2021 07:27:53 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF9CC06161C
        for <bpf@vger.kernel.org>; Wed, 29 Sep 2021 04:26:13 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id y1so1272213plk.10
        for <bpf@vger.kernel.org>; Wed, 29 Sep 2021 04:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PGPx1nwGIqYTscOb6RPPr2Q3evpy6YyjpPCwl7r3izY=;
        b=i6X9YdnYXesTATQxsiL3BfJdBG2XmUUpIfotvjjCSfHs1RkQv5lMpVLvGYEjqVBa74
         va07tyWbm6Xm8Pn3dgQVwE79aW6lkQCwBg1sR3K27wm2OduFoTptfBkuQajpmJoFWhLm
         PGsPQr4nXO3l/VoCQysA+/Z0l5ROQqyu/g0pqcc9rp63Cq0fKMs6samiFAwNdbS/1Waz
         vsT0qUzk0d64E/nbFue+XLXFVLrpHkieZpGapLhkR445ibwnFP/eavwYtanWoZ8V+fzU
         GpWDVS7iLiOUHjM0bv+Dom7ta4GMBuKWsF6QrD/ZMI1xZArWD66rl8zs5yHRhZQg9tjN
         zelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PGPx1nwGIqYTscOb6RPPr2Q3evpy6YyjpPCwl7r3izY=;
        b=QLBBcYtA1GwtqA1siF7NGx2BudhiNJJdJYyTXBCV87KBKoSRn30J1wY65/Zg+tx0o+
         O2YXeLqxMc4I3ZagcPldSKw+rqrbz3HcKzyguPlGi1RCGNaTXfrTaviwUi4MR1R8oRid
         vLhqH0+m//lYkkVibadkI4ZR9Ir41uLVqcU5EbGApcwMew52Po/EuOw4E0cwxTZ0mz65
         U3OqyeSFEMwkx+ZPtyB1ky26TMG2Nhvwsv+5RQPBcUk1rxmTpRTwaWu82yxzXQHbvPPS
         KqFgmbmPC5uhL37kAA2pMWizFN5h7b4vA2yA/AkPCCluIrdsvGGqNcS/WOb0H/fjNybq
         TbIQ==
X-Gm-Message-State: AOAM532A9sf88djtIeJaeXGN+t0npQvh2bNUwv1SvGbFlBvmtNxzufMn
        tTRGGCki/orOPMsZrMp5/QVBD1Ad5x252bXOQTTnj9Q2tDuPhbUGfe8=
X-Google-Smtp-Source: ABdhPJw+HD1XkC8PCRlMJGfips6FSW5Z/3sTRD1XSQ7ROeQGk6D63t1pY8CpcHASv+gpm25Xy8zB74maO+Hmh9hpfU0=
X-Received: by 2002:a17:903:4094:b0:13e:1886:d3d8 with SMTP id
 z20-20020a170903409400b0013e1886d3d8mr9614832plc.71.1632914772644; Wed, 29
 Sep 2021 04:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210923000540.47344-1-luca.boccassi@gmail.com>
 <1aa77fde2f7f4637d9eae7807c5c55063d6a4066.camel@debian.org>
 <CAJ+HfNjsJZx62ZnA9Gi-rCuL=yBVLKZke7J+ruQFHAAKarpk=g@mail.gmail.com> <ed448659f66f2142151b34e6af9c98b46abdaaf0.camel@debian.org>
In-Reply-To: <ed448659f66f2142151b34e6af9c98b46abdaaf0.camel@debian.org>
From:   Magnus Karlsson <magnus.karlsson@gmail.com>
Date:   Wed, 29 Sep 2021 13:26:01 +0200
Message-ID: <CAJ8uoz3ammMczNQqFk0SDmTnFThV8U6Fy9YEB+wLkv4fZ5qxZA@mail.gmail.com>
Subject: Re: [PATCH] samples/bpf: relicense bpf_insn.h as GPL-2.0-only OR BSD-2-Clause
To:     Luca Boccassi <bluca@debian.org>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        bpf <bpf@vger.kernel.org>,
        "Mcnamara, John" <john.mcnamara@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 29, 2021 at 1:20 PM Luca Boccassi <bluca@debian.org> wrote:
>
> On Wed, 2021-09-29 at 13:01 +0200, Bj=C3=B6rn T=C3=B6pel wrote:
> > On Tue, 28 Sept 2021 at 17:44, Luca Boccassi <bluca@debian.org> wrote:
> > >
> >
> > [...]
> >
> > >
> > > Gentle ping. Bj=C3=B6rn and Joe, would be great to hear from you on t=
he
> > > above. TIA!
> > >
> >
> > Luca, apologies for the slow response. I'm no longer at Intel, and I'm
> > not sure if an Intel-person needs to do anything? Magnus, do you know?
> >
> > FWIW:
> > Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
>
> No worries! Unless you had an arrangement in place that made you the
> copyright owner of that contribution (eg: it was done in spare time,
> etc), then yes we'd need an ack to the relicense from an intel.com
> email address to be above board.

Will this do?

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

> John, is this something you could help with, using your manager hat?
> Full context:
>
> https://lore.kernel.org/bpf/20210923000540.47344-1-luca.boccassi@gmail.co=
m/T/#u
>
> --
> Kind regards,
> Luca Boccassi
