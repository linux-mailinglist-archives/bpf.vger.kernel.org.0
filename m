Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEDD1EB94E
	for <lists+bpf@lfdr.de>; Tue,  2 Jun 2020 12:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgFBKNh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Jun 2020 06:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgFBKNh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Jun 2020 06:13:37 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7731AC061A0E
        for <bpf@vger.kernel.org>; Tue,  2 Jun 2020 03:13:36 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id e5so3112163ote.11
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2020 03:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PYkyYuO+K0IbSvklnuIVXc7+pRVpwEFri33hk6ziZGs=;
        b=Sg4fm5pqNTXPVevEgnLoH6WKtxa5GcpTflO+Grnm329qZzg+ZqZ+R4eR0eUzAGvUqE
         t4kXIBg1YUV8gT1wuASV8sx49NqneGS9IWpT2qvkcGSMsdjC73fOcY/hDg3wIiJutVkX
         mddCgckOg1aSb9kxJUzvGdghpnXQsPlAviGgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PYkyYuO+K0IbSvklnuIVXc7+pRVpwEFri33hk6ziZGs=;
        b=gFObLFGmfeks49JaPJM3RstZQ7c+7kEi6ovlsuNuyGHYqfzHcik/dSL5owIBxjcM1a
         u3jFTy88FUMciUFp5dmXJaWK9D+g1kUr4WC6kGwuQMK74/+b7tmeJvDI3FnSuJruhesO
         jN0fjzffDRb2cDqGXtp613vkV7lnyDvZcr2jt9I/gtzfl+foKXkhssYh6oCfMzVu1G03
         dEG8mv58G+t7T8Zjc5UUE+HLt9z7bi2B3LNoaw1qT37N4YLPhehFO0WXMJWYRoDoPs58
         82TFbK3WWVZq7J85S7hoCYc90im34h3TPU2XJXd6jd/e/yp05YdIDOP4UVUWCJqakZQy
         fKFQ==
X-Gm-Message-State: AOAM532taDTvHeJaRrL+eXCITXbTM7ZxcYM6TD6FNJVqPE9U4TeMyr6j
        M6pBdAVEqyHCiDwXLDDiR5/Pfom/h5hLPxeSd0yAxw==
X-Google-Smtp-Source: ABdhPJxUGS55A1IBSfhFpkv1YTXzaxW3Kc3xHYICwrVhxTw+/ptkO8t7gBt7zhtfhF7KJiAgnYg9wO9zGlAcTgv1aUs=
X-Received: by 2002:a05:6830:2303:: with SMTP id u3mr18093642ote.147.1591092815856;
 Tue, 02 Jun 2020 03:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw9-uU_52esMd1JjuA80fRPHJv5vsSg8GnfW3t_qDU4aVKQ@mail.gmail.com>
 <CAADnVQKZ63d5A+Jv8bbXzo2RKNCXFH78zos0AjpbJ3ii9OHW0g@mail.gmail.com>
 <CACAyw9_ygNV1J+PkBJ-i7ysU_Y=rN3Z5adKYExNXCic0gumaow@mail.gmail.com>
 <39d3bee2-dcfc-8240-4c78-2110d639d386@iogearbox.net> <CACAyw996Q9SdLz0tAn2jL9wg+m5h1FBsXHmUN0ZtP7D5ohY2pg@mail.gmail.com>
 <a4830bd4-d998-9e5c-afd5-c5ec5504f1f3@iogearbox.net> <CACAyw99_GkLrxEj13R1ZJpnw_eWxhZas=72rtR8Pgt_Vq3dbeg@mail.gmail.com>
 <ff8e3902-9385-11ee-3cc5-44dd3355c9fc@iogearbox.net> <CACAyw9_LPEOvHbmP8UrpwVkwYT57rKWRisai=Z7kbKxOPh5XNQ@mail.gmail.com>
 <alpine.LRH.2.21.2006011839430.623@localhost> <835af597-c346-e178-09c4-9f67c9480020@iogearbox.net>
 <alpine.LRH.2.21.2006012217530.15886@localhost>
In-Reply-To: <alpine.LRH.2.21.2006012217530.15886@localhost>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 2 Jun 2020 11:13:24 +0100
Message-ID: <CACAyw98FxUjxmr4ai5JiudV5p3pd4U6fxxULrkMWJtuBKtUDgA@mail.gmail.com>
Subject: Re: Checksum behaviour of bpf_redirected packets
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 1 Jun 2020 at 22:25, Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On Mon, 1 Jun 2020, Daniel Borkmann wrote:
>
> > On 6/1/20 7:48 PM, Alan Maguire wrote:
> > > On Wed, 13 May 2020, Lorenz Bauer wrote:
> > >
> > >>>> Option 1: always downgrade UNNECESSARY to NONE
> > >>>> - Easiest to back port
> > >>>> - The helper is safe by default
> > >>>> - Performance impact unclear
> > >>>> - No escape hatch for Cilium
> > >>>>
> > >>>> Option 2: add a flag to force CHECKSUM_NONE
> > >>>> - New UAPI, can this be backported?
> > >>>> - The helper isn't safe by default, needs documentation
> > >>>> - Escape hatch for Cilium
> > >>>>
> > >>>> Option 3: downgrade to CHECKSUM_NONE, add flag to skip this
> > >>>> - New UAPI, can this be backported?
> > >>>> - The helper is safe by default
> > >>>> - Escape hatch for Cilium (though you'd need to detect availability of
> > >>>> the
> > >>>>     flag somehow)
> > >>>
> > >>> This seems most reasonable to me; I can try and cook a proposal for
> > >>> tomorrow as
> > >>> potential fix. Even if we add a flag, this is still backportable to stable
> > >>> (as
> > >>> long as the overall patch doesn't get too complex and the backport itself
> > >>> stays
> > >>> compatible uapi-wise to latest kernels. We've done that before.). I happen
> > >>> to
> > >>> have two ixgbe NICs on some of my test machines which seem to be setting
> > >>> the
> > >>> CHECKSUM_UNNECESSARY, so I'll run some experiments from over here as well.
> > >>
> > >> Great! I'm happy to test, of course.
> > >
> > > I had a go at implementing option 3 as a few colleagues ran into this
> > > problem. They confirmed the fix below resolved the issue.  Daniel is
> > > this  roughly what you had in mind? I can submit a patch for the bpf
> > > tree if that's acceptable with the new flag. Do we need a few
> > > tests though?
> >
> > Coded this [0] up last week which Lorenz gave a spin as well. Originally
> > wanted to
> > get it out Friday night, but due to internal release stuff it got too late Fri
> > night
> > and didn't want to rush it at 3am anymore, so the series as fixes is going out
> > tomorrow
> > morning [today was public holiday in CH over here].
> >
>
> Looks great! Although I've only seen this issue arise
> for cases where csum_level == 0, should we also
> add "skb->csum_level = 0;" when we reset the
> ip_summed value?

FWIW I had the same reaction. Maybe it's worth adding after all, Daniel?

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
