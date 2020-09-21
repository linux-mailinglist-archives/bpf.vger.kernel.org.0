Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F470272164
	for <lists+bpf@lfdr.de>; Mon, 21 Sep 2020 12:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgIUKm0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Sep 2020 06:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbgIUKm0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Sep 2020 06:42:26 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEF1C0613CF
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2020 03:42:25 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id q21so11869190ota.8
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2020 03:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eiqKXCgFyWoEq7QNpOK12+3aj0NswHIzyZ3TKneSQF4=;
        b=NjI0mAaUYL/HUJI/VrhYDGv5CLMyG+jEW1093JlJ2HAVDPStcI1KShkcaobKTvil2+
         uzkGKQoLMBilgca7XlfhO5ZHM/hDaGyPo1h0NCMqOb8Fk1c9tmmttPEe2Aph32O+Vmmj
         HeJLsoq+ZRyx9y51RxeP2Ot+Rxyuw2kHx0JSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eiqKXCgFyWoEq7QNpOK12+3aj0NswHIzyZ3TKneSQF4=;
        b=l9/BZJVLKMLJeQtar13tCwH9GpS1ltwPPkDf2k3eg4Q3NeP9FX4PJqvIEqE1iy/zAr
         xBjsQjSSyKXla0IcQOa+dGwKmv32JcJTq7e38z/i+TR2TMklnqmpkKNpKRMHb7nzIiod
         KOqe8dVSJ0VKnzlfvedMpZJVR7w6AjSEkMjkemsVF6TqGDY7rlnNyGRBnAh40F+cJuDm
         HzGt19rB52rYhMHW2ahdgJRBZ8MorzbWy6EkkB835MnefjCzJAtc6kt64p2bXxRJuHyS
         x7PJc/LZ/SappNFPFdgBckBpOOydxi3KQjVLM1bMTLBG0nb7jgjiNsFdT85Ayl7ZdT37
         XuhQ==
X-Gm-Message-State: AOAM5313XQmLCNPV6SH5pUF+R2og+m2LVppc3fh4HhDXqsMr8MRbHYZN
        4HoldBTNSmlbrBGWa6RgrwspWFFHqGa6MbQ02IXXHQ==
X-Google-Smtp-Source: ABdhPJxA1eoYtL/ZI9HjDGY3w/o2O6bzqOeN1hDAXGziWntDKlIgre+zowpezhHLCLzoPemTJYDHdF0bTj666njAPGA=
X-Received: by 2002:a05:6830:1653:: with SMTP id h19mr28512243otr.147.1600684945120;
 Mon, 21 Sep 2020 03:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200917143846.37ce43a0@carbon> <CANP3RGcxM-Cno=Qw5Lut9DgmV=1suXqetnybA9RgxmW3KmwivQ@mail.gmail.com>
In-Reply-To: <CANP3RGcxM-Cno=Qw5Lut9DgmV=1suXqetnybA9RgxmW3KmwivQ@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Mon, 21 Sep 2020 11:42:13 +0100
Message-ID: <CACAyw98EW2PiS8igjk08doQPSoJCxN3U2XO_Su3aiJ7uVCfg7w@mail.gmail.com>
Subject: Re: BPF redirect API design issue for BPF-prog MTU feedback?
To:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
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

On Thu, 17 Sep 2020 at 13:55, Maciej =C5=BBenczykowski <maze@google.com> wr=
ote:
>
>
> (b) another complexity with bpf_redirect() is you can call it, it can suc=
ceed,
> but then you can not return TC_ACT_REDIRECT from the bpf program,
> which effectively makes the earlier *successful* bpf_redirect() call
> an utter no-op.
>
> (bpf_redirect() just determines what a future return TC_ACT_REDIRECT will=
 do)
>
> so if you bpf_redirect to interface with larger mtu, then increase packet=
 size,
> then return TC_ACT_OK, then you potentially end up with excessively large
> packet egressing through original interface (with small mtu).

Yeah, this isn't nice. What is the use case for allowing this in the
first place?

For sk_lookup programs, we have a similar situation, except that we
"redirect" to a socket. Here the redirect happens if the helper call
is successful and the program returns SK_PASS. Maybe that is a
feasible approach if we introduce new helpers.

--=20
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
