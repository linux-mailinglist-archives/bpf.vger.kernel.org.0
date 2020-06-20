Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98C3201F9C
	for <lists+bpf@lfdr.de>; Sat, 20 Jun 2020 03:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731633AbgFTB7n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Jun 2020 21:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731607AbgFTB7m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Jun 2020 21:59:42 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A47C06174E
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2020 18:59:42 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id k15so8761429otp.8
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2020 18:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EmjYBfcthFLPAfNoGJ7hw7/jo1fvXpgJwBGS5L4D8b4=;
        b=JUu9wN8tB2mQGhbfk1UAnnZ9RfWt4vRSHqS2c2IR/dDaG+FIbAsKkLZRIQyien00EQ
         h9KP5bUiwUuxThdXBJnhHhKQ3NUyEUCpXIDVd6KXKy/RZXWlZik5fOv5H5HJse3g+rzA
         +2eNGrjp9nXosSb0gLylF/fvzLTFe5Bh7t7iqkVUZ8oFXvGbkODTc6rIdWgTvANKv8hs
         l1mHPVv/nhAS8hEpN03JOIQhBvXIeQfmmEZTsZzRzlpDcJdtD8sZLOVCcKZ9JPNydrK2
         k8mi4ewOpjsqC5iycw7eBK1uiYCTrNmiMQNfut3Py0/rVADgwixBtiFqg+EROPzk36EG
         vpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EmjYBfcthFLPAfNoGJ7hw7/jo1fvXpgJwBGS5L4D8b4=;
        b=me+SKucV3xUHtZWqMDK74tQ01WbtehmYvllwSNFCePgIJ7zrtnNCGKfTdqPghtC1z2
         7pkfyYYikSrpmFX6YFm/pmO9A6+qhwQV2FTpGQwWkmlQsAxRJYjGT71ePkrCZthXAuXg
         iAcqStF9L3bqM8TtxsCGwqb6C6MbXwnhvPv6PI7HfGWRqGBgSawoDRQfYldswE1ZrQZz
         1/fAAAqx9vsacBIq5K1pV3yPNI2Ra7JvDBCHiI+SKeQxQom3G6Le60klYAxYAaImOzVK
         rWxhFNTYxsZXT7/5zeV87cHo2LYZWEIS2fyQ8MIWU8soCdwF1vTAhWk0DmFU2KEHmY9g
         QuSQ==
X-Gm-Message-State: AOAM530egqx+EdU/g4zgh/OjwNNqLW4mqSf1StWdn+Sleu0VsdK8+Rtd
        KixYkoJdhkWPDENW3ripym2nvUk1kJTTGfj0l6vDxA==
X-Google-Smtp-Source: ABdhPJxpYhBG2nZ2YN90j9UbA2QJ1Y14NL9UvQ43Bq0YaLX35Ie768LFhckIRxykRS2R2MN0bp+CuBRT0OC7XsbkHFY=
X-Received: by 2002:a9d:26:: with SMTP id 35mr5141074ota.352.1592618380818;
 Fri, 19 Jun 2020 18:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAHo-OoxJ6XBrBDXUxhCr0J58eOGq3FZu5+Rg6GLeeCjThrA8rg@mail.gmail.com>
 <CAADnVQKXbd986SrW2u4nxY-0nNuC7VoVM29=3LeD9potOJTdZQ@mail.gmail.com>
 <CAHo-Ooz4smKgTDTit4NAnaasUDLJLkX7iRcYouv4KY=AG5SUaA@mail.gmail.com>
 <CALAqxLXgnqSM16=a3O1NyqYae1n_rMyw4_hcx5APm9s-h3TBtQ@mail.gmail.com> <CAHo-OoyU5OHQuqpTEo-uAQcwcLpzkXezFY6Re-Hv6jGM9aSFSA@mail.gmail.com>
In-Reply-To: <CAHo-OoyU5OHQuqpTEo-uAQcwcLpzkXezFY6Re-Hv6jGM9aSFSA@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 19 Jun 2020 18:59:29 -0700
Message-ID: <CALAqxLWLAVcYWk9qx-3ZvwG0urZmHfgbDd=wEx8rBLtC-OEv3A@mail.gmail.com>
Subject: Re: capable_bpf_net_admin()
To:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        BPF Mailing List <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 18, 2020 at 12:22 PM Maciej =C5=BBenczykowski
<zenczykowski@gmail.com> wrote:
>
> Ok so I think
>
> > +       if (is_net_admin_prog_type(type) && !capable(CAP_NET_ADMIN))
> > +               return -EPERM;
>
> should be
>
> > +       if (is_net_admin_prog_type(type) && !capable(CAP_NET_ADMIN) && =
!capable(CAP_SYS_ADMIN))
> > +               return -EPERM;
>
> and presumably similar change just below that for perfmon.

Looks ok to me. Do you want to send out such a patch? If not I'll do
so on Monday.

thanks
-john
