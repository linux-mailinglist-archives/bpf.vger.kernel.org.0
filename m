Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE97E215FEF
	for <lists+bpf@lfdr.de>; Mon,  6 Jul 2020 22:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgGFULy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Jul 2020 16:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgGFULx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Jul 2020 16:11:53 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F88CC061794
        for <bpf@vger.kernel.org>; Mon,  6 Jul 2020 13:11:52 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id h1so10442013otq.12
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2020 13:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NH51QzKoo8vcvgmX1earnUW3W8VarBLxn3wxnDS2NOk=;
        b=y1/ZKuIhjHhOsxpSw+1xMcKmg2e5dWBH3F1+AO7aZkt4nuahkvlotHPyJkqTmzHRcU
         dayynd91m96Pxs75SBm30PdnqAQSw9PL8yc4R6iUdxaAF1DhMjqCqX5AiCR1neYMayFs
         YcV2BKubqr6RmiXZqJp8NyNrKmK28zR8AhFYLntpBZX43yc4BitVunCWcr/iQBkUgeor
         rhyMSBQvEvS+98Wzh3MLqUIDMsOKDiXerdn7gA2pjwesgHWpial6dAPS2MAqVfiQBxqR
         MGIVvMl/Md/p013QyXWb4A0uMaG16Xbv1m23EGeoS82CBXGGKDuB5gOktniOknC0nkwX
         B2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NH51QzKoo8vcvgmX1earnUW3W8VarBLxn3wxnDS2NOk=;
        b=tJdmT8rUXJmyiKLMYItx0BYYBJwv3CKrSiiZ9///LRVjIAdPzHlkhZ1ExPVdqyEA8/
         wKd0cSVY9mLt6XmlC6/xqdfc6IekckZevZKjYxWrKEL46kHt5KcJZf7Y0uTwHIi3m2W4
         ubYAHXizkcoHJVazBV/VUpjaTexNA6OPpInJzSxh0/rTqOvTyLnrazC79S89Q25RwCmZ
         OzkQiVu6Fifr3qE279fnBlncmQhYSRBy9RU2NchUgpxL2n7UF7vtdyrmVM8YbPWkE7cA
         dsw+f76Uqi2FRjSCzu7W3iUPCbu7OIgEioHSGQx+UBA32sPLdCZ/QmLECYgMkNsSlln8
         fI6g==
X-Gm-Message-State: AOAM5309xCA5wOGa7VJdww8SO5EsBl9V8xteLhXXCtDSY6k3UYjCeh7E
        U0D0Ka7qKb5Z+Hzcd9I9ub/TZh6F+kQ8Makq3S3QRw==
X-Google-Smtp-Source: ABdhPJxWWUEOZiTzl4XMzBiep/6hLNneDCfCqQ3s06apjoLTB29tsG8ceo9LV97cMRx0HUQs4qjZVEIL4axcOjO71UI=
X-Received: by 2002:a05:6830:1e13:: with SMTP id s19mr45133059otr.102.1594066311761;
 Mon, 06 Jul 2020 13:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAADnVQ+BqPeVqbgojN+nhYTE0nDcGF2-TfaeqyfPLOF-+DLn5Q@mail.gmail.com>
 <20200620212616.93894-1-zenczykowski@gmail.com> <CALAqxLVeg=EE06Eh5yMBoXtb2KTHLKKnBLXwGu-yGV4aGgoVMA@mail.gmail.com>
 <CAADnVQJOpsQhT0oY5GZikf00MT1=pR3vpCZkn+Z4hp2_duUFSQ@mail.gmail.com>
In-Reply-To: <CAADnVQJOpsQhT0oY5GZikf00MT1=pR3vpCZkn+Z4hp2_duUFSQ@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 6 Jul 2020 13:11:42 -0700
Message-ID: <CALAqxLVfxSj961C5muL5iAYjB5p_JTx7T6E7zQ7nsfQGC-exFA@mail.gmail.com>
Subject: Re: [PATCH bpf v2] restore behaviour of CAP_SYS_ADMIN allowing the
 loading of networking bpf programs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>,
        =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linux Network Development Mailing List 
        <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BPF Mailing List <bpf@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 23, 2020 at 5:54 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Mon, Jun 22, 2020 at 12:44 PM John Stultz <john.stultz@linaro.org> wro=
te:
> > On Sat, Jun 20, 2020 at 2:26 PM Maciej =C5=BBenczykowski
> > <zenczykowski@gmail.com> wrote:
> > > From: Maciej =C5=BBenczykowski <maze@google.com>
> > >
> > > This is a fix for a regression introduced in 5.8-rc1 by:
> > >   commit 2c78ee898d8f10ae6fb2fa23a3fbaec96b1b7366
> > >   'bpf: Implement CAP_BPF'
> > >
> > > Before the above commit it was possible to load network bpf programs
> > > with just the CAP_SYS_ADMIN privilege.
> > >
> > > The Android bpfloader happens to run in such a configuration (it has
> > > SYS_ADMIN but not NET_ADMIN) and creates maps and loads bpf programs
> > > for later use by Android's netd (which has NET_ADMIN but not SYS_ADMI=
N).
> > >
> > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > > Reported-by: John Stultz <john.stultz@linaro.org>
> > > Fixes: 2c78ee898d8f ("bpf: Implement CAP_BPF")
> > > Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
> >
> > Thanks so much for helping narrow this regression down and submitting t=
his fix!
> > It's much appreciated!
> >
> > Tested-by: John Stultz <john.stultz@linaro.org>
>
> Applied to bpf tree. Thanks

Hey all,
  Just wanted to follow up on this as I've not seen the regression fix
land in 5.8-rc4 yet? Is it still pending, or did it fall through a
gap?

thanks
-john
