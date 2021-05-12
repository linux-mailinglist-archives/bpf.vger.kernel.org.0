Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D24937B584
	for <lists+bpf@lfdr.de>; Wed, 12 May 2021 07:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhELFgd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 01:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhELFgd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 May 2021 01:36:33 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C6CC061574
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 22:35:26 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id bo23-20020a17090b0917b029015cb1f2fd59so376289pjb.2
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 22:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IfUQPgDJlW2Do2oxkhPyrMOtLHgkYhezO9CMsgNLTfQ=;
        b=EeWnA/PgNFGP1GLXuVZXnjd/6YZIAO4re2AwR4dhI5MrPvu0VOxMYaXgk5miZ1sMfX
         tUyQZ1dK4jyN6ROMaFFAzrvBwGMxF8crY8MNry+NizxC919oOGIab8TIQ7gCEqvHrVFK
         DQbOChKekq2sxao103Uo5E3NBXMcsEFlva4FyHbHGNIqYkAAbkp/393IWz3dz6/S5Aep
         XRRHIcaFpGYy/k7yXf+A5oSvfSF7uYUoKn9HF+BD+at5KKTzPDaqWF6I1kjvb0dRFhOc
         DxwWNjwsiQ37Ai6mKXknDLhdXCdzMpyVilUN/6xt5tNc8yHQsr74Q9l1VTLCeBGOwmPf
         h/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IfUQPgDJlW2Do2oxkhPyrMOtLHgkYhezO9CMsgNLTfQ=;
        b=DkXT7LNaZ/lBjCZDgI/UdHzM3Vl7QNxrW4mHFIjux46yFusoVkHz9jp6cEfIp1cijj
         e78UnEbF7ZA27NnpujhRYF7Pr9AzMqmKfV98G2LJASaFn1KHH+S8H6HG7+JoDOKUPtk8
         KpqHJlZNDEWEiut5U7YdS5NZBxOauncJIMiQrGdyTgTSjGGahjMg9Wct0nEsJUZWJabo
         BTTg7uBlSVNThSKM4WIPnlWIR/h1ySf7y2j+xOrz/OKPolKCXLlorpHtMz/p2g9qDDvi
         xoLqym0eW1dYKaDplkPOp5oUiv49I+2kn35e67vl0yO1mjb6Z22WwgGcEwcN72ga/Jqt
         ERHQ==
X-Gm-Message-State: AOAM530O04GGgU4AEohF8FqdGZhehUKxxkqnv30EJF1tPL+7OJhp+YNq
        0M3jV+Mn/RyWKmoTf6GVsS6prhNhXv4G9lMSkjIvl/oSw9+dJA==
X-Google-Smtp-Source: ABdhPJzVvizZx9J62L5HM4LbMmdeExYhI5/CHpoR/SAHUORfeOB7qHf+Lw5WVZNssHexwVO1hs/noS2FEdXVgz5zxMA=
X-Received: by 2002:a17:902:b412:b029:ef:1737:ed with SMTP id
 x18-20020a170902b412b02900ef173700edmr24632284plr.43.1620797725269; Tue, 11
 May 2021 22:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <BYAPR11MB365382C5DB1E5FCC53242609C1549@BYAPR11MB3653.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB365382C5DB1E5FCC53242609C1549@BYAPR11MB3653.namprd11.prod.outlook.com>
From:   Magnus Karlsson <magnus.karlsson@gmail.com>
Date:   Wed, 12 May 2021 07:35:14 +0200
Message-ID: <CAJ8uoz16WLwqP+=dtphm7KWh=c9QYiU25k33hNrAg8ciaGe9vw@mail.gmail.com>
Subject: Re: AF_XDP poll() / sendmsg() race + headroom changes
To:     "Benoit Ganne (bganne)" <bganne@cisco.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 10, 2021 at 7:53 PM Benoit Ganne (bganne) <bganne@cisco.com> wr=
ote:
>
> Hi everyone,
>
> Please CC me as I am not subscribed to the list.
> I am the maintainer of the AF_XDP driver for VPP, an open-source userspac=
e networking stack, and I ran into an issue recently with kernels < 5.6 (in=
cluding LTS kernel 5.4 which is shipped in eg. Ubuntu 20.04 LTS): it seems =
like one cannot call poll() and sendmsg() concurrently on the same AF_XDP s=
ocket. Is this a supported usecase? I know the rings are single producer/si=
ngle consumer and I use them like this, but can I have one thread doing RX =
(and poll) while another thread is doing TX (and sendmsg)?
> A typical usecase is when using more processing threads than AF_XDP queue=
s for an interface, eg. because I use several interfaces: each thread can p=
oll its own set of RX queues from different NICs, but depending of the pack=
et processing decisions, I must be able to send through any other interface=
 - hence TX queues can be shared. In this case they are protected with a lo=
ck, but rx and tx can still happen in parallel.
> The problem has been fixed with commit 11cc2d21499cabe7e7964389634ed1de3e=
e91d33 "xsk: Simplify detection of empty and full rings" [1] but it looks l=
ike pure luck.
> From what I can see the issue stems that prior to this patch, poll() will=
 update the cached txq prod_tail while sendmsg() is running and doing the s=
ame and because of that the txq cons_head can moved back, causing AF_XDP to=
 process the same descriptor twice.
>
> I hit a 2nd issue with kernel >=3D 5.9, where the headroom on rx for copy=
 mode has grown from 0 to XDP_PACKET_HEADROOM (256-bytes). This change of b=
ehavior was introduced by commit 2b43470add8c8ff1e1ee28dffc5c5df97e955d09 "=
xsk: Introduce AF_XDP buffer allocation API" [2].
> Previously, the headroom in copy mode was set to "configured headroom + 0=
" whereas the headroom in 0-copy mode was set to "configured headroom + XDP=
_PACKET_HEADROOM". This patch changed copy mode headroom to "configured hea=
droom + XDP_PACKET_HEADROOM", identical to 0-copy.
> I agree the previous behavior was a bit weird, but is there a way to dete=
ct old vs new behavior? Otherwise it is difficult to run the same code befo=
re/after this patch.
>
> Thanks in advance for your help,
> ben

Hi Benoit. Thank you for reporting, I will take a look at this and get
back to you. Next time, please add me and Bj=C3=B6rn on the to line so that
you get a quicker response.

> [1] https://lore.kernel.org/bpf/1576759171-28550-3-git-send-email-magnus.=
karlsson@intel.com/
> [2] https://lore.kernel.org/bpf/20200520192103.355233-6-bjorn.topel@gmail=
.com
