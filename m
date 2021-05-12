Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B9037B9E5
	for <lists+bpf@lfdr.de>; Wed, 12 May 2021 12:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhELKDk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 06:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhELKDj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 May 2021 06:03:39 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58ACC061574
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 03:02:28 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id b21so11041211pft.10
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 03:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XImLM2gPV1cME3LY6f4i7AUPaWTUKrLWrdGBC1p3V4s=;
        b=fWrmiGas9fBrvAvcN6UJ7mJWBgooECT3sCF0XibQdQ+G0Vnjpn1LqSJBNuiFbSL/tQ
         Igok/n9/Y5kxW5dhEAK1US2pj8vkJcabI5yOvVfApD1JKY+Xb2nCFQOj7MiIhi7J+1PV
         ilCpTuJvG5l4ZfTzFmeLwvEuQuLIhhy5SNjxmfyJ0AAeCYuEkp3lhycR9BQMMHqDH+Os
         PtBrNYwGdtSudv/hCEwJhHwztP4y0XY17kS1C1ZAeWyyDSHLeGlQ17FftJ+Dk4LVW8zX
         HXSIb2zP5V0SRzGTTAhAyp/O0s3X7Ox4N0H2QeqGT66s3mNviGRXedl7SPDKY+NRW/nV
         OWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XImLM2gPV1cME3LY6f4i7AUPaWTUKrLWrdGBC1p3V4s=;
        b=mNcstyuE6soucgkF1W91OxwpDpeUj3wpyFo7+Uh0EDO3DUsytmX8vlFgzCJBx3pp7X
         w5xPW0nHMt7ZfQascXTW9ZIrvuC09J02l1knZhDEFb7sar/vPjmGscbKFEDXNElzn/t1
         kjEYQkqdIC6cweKsKMgcJOLa6MkFQ1MOfPPJA/rjZFNFVJe+L/l4uhKb8HAJtrpX8Rx9
         kzIebb1j/QV6tBxpM6XpBNE6PFziE9p++mW6uKfWpLjLEPNxXruI5xArs0FCffYOJdqM
         nx8u9ONzhgFc9iX7h1fAwSsw3f1lTar1noq4YeME3kTfeUYxa6JUbxnL2eOZdaIkL1Cb
         wdIQ==
X-Gm-Message-State: AOAM532qRvOBenuCvg2jHQcUuxVFKNwilsrdvfwWNNLUk2EdgICLqaEq
        BAmtPdoGMLhA0QUo48d1IWiO3crQSyCEaVGlBuc=
X-Google-Smtp-Source: ABdhPJx/YV2W7FD3Y7Wj6K6ARjrJJfwhNWpU0pgxENuYZ1aKIY9hm3AU7vad2daFuo1YYOv1xxNuOotmII7/FKjaMq4=
X-Received: by 2002:a63:f818:: with SMTP id n24mr29860478pgh.208.1620813747713;
 Wed, 12 May 2021 03:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <BYAPR11MB365382C5DB1E5FCC53242609C1549@BYAPR11MB3653.namprd11.prod.outlook.com>
 <CAJ8uoz16WLwqP+=dtphm7KWh=c9QYiU25k33hNrAg8ciaGe9vw@mail.gmail.com> <DM6PR11MB3660A5132EB554ED746C8C92C1529@DM6PR11MB3660.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB3660A5132EB554ED746C8C92C1529@DM6PR11MB3660.namprd11.prod.outlook.com>
From:   Magnus Karlsson <magnus.karlsson@gmail.com>
Date:   Wed, 12 May 2021 12:02:16 +0200
Message-ID: <CAJ8uoz3hPH6Ezappjh2FZyMXj0L+qF_92jg7o3mrREyWJ20f4A@mail.gmail.com>
Subject: Re: AF_XDP poll() / sendmsg() race + headroom changes
To:     "Benoit Ganne (bganne)" <bganne@cisco.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 12, 2021 at 10:26 AM Benoit Ganne (bganne) <bganne@cisco.com> w=
rote:
>
> Hi Magnus,
>
> >> I am the maintainer of the AF_XDP driver for VPP, an open-source
> >> userspace networking stack, and I ran into an issue recently with kern=
els
> >> < 5.6 (including LTS kernel 5.4 which is shipped in eg. Ubuntu 20.04 L=
TS):
> >> it seems like one cannot call poll() and sendmsg() concurrently on the
> >> same AF_XDP socket. Is this a supported usecase?
> [...]
> >> I hit a 2nd issue with kernel >=3D 5.9, where the headroom on rx for c=
opy
> >> mode has grown from 0 to XDP_PACKET_HEADROOM (256-bytes).
> [...]
>
> > Hi Benoit. Thank you for reporting, I will take a look at this and get
> > back to you. Next time, please add me and Bj=C3=B6rn on the to line so =
that
> > you get a quicker response.
>
> Thanks! Sure I will in the future.
> If I may, an ideal scenario would be:
>  1) the concurrent rx/tx usecase is officially supported, and 11cc2d21499=
cabe7e7964389634ed1de3ee91d33 should be backported to LTS

I will fix this. The (unintentional) fix you refer to should apply
cleanly to 5.4 and 4.19 LTS kernels. I just have to verify this and
submit a request to Greg. Probably with a new commit message that
describes what problem it fixes, since it is not just a simplification
anymore.

>  2) had a way to detect different version of AF_XDP (through an ioctl() o=
r getsockopt() or...) so that I can detect more easily what I should do at =
init time. Eg. managing both headroom (0 and 256) for copy mode is not very=
 difficult if I can detect it easily

Bj=C3=B6rn and I have yet to come up with a good way to detect this that
does not involve receiving a packet. Another possible way would be to
backport a fix for this to 5.4 and 4.19 LTS too. But this seems to be
a less straightforward patch, so let us see what that would entail.
Bj=C3=B6rn is working on this and will get back to you.

>
> Best
> ben
