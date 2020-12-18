Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B719A2DE047
	for <lists+bpf@lfdr.de>; Fri, 18 Dec 2020 10:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgLRJKv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Dec 2020 04:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbgLRJKv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Dec 2020 04:10:51 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E0AC0617A7;
        Fri, 18 Dec 2020 01:10:10 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 3so1742955wmg.4;
        Fri, 18 Dec 2020 01:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qMPRh9MP38sJYR7ol3nI1aJ7XpSFfS8INGmpVpJM9FM=;
        b=GlHhy4KcL2KUgQ9gvb3nBOTYFZoukhrrSZrbQ7OW98oLL7Fl6NlLXDJgXLkq/VdBMm
         0wQ0tiN2ssVLon8Sj7U+Rx1Dal/etDpv3HiCF9YLf5mKJerAvIxXuRc38BIzhb0e6s+4
         XaSL1JbAr5qNs7uwUcp12foYfXQXpsBUrV+AuRrdUhCZo0ZalYT3J9sVKGc+HUzcFYf+
         fx39PEdKfEX6xahXgtDbbQ2A1CFkuJAMUHW5EKUH/kAasWG1WmjjEDG62QtJEUrb1CP5
         CRSvEOJt3ErSFAlOYyurM4OiibdxBYEYDVUwt9BOV/k9fQvZBM5e4C43pAekJlZoZFLG
         7HRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qMPRh9MP38sJYR7ol3nI1aJ7XpSFfS8INGmpVpJM9FM=;
        b=iPEguXImIxZ24mjxYNxmh8jv9RsWvKkeqkBZ2i5jomq8eYyzskEBN5ikrVN8h6zIio
         p43fr577eomkKfwm9H5l9s2q1cb1kbg7doOCGdjK+jAtuyTJSK4b5r/ZCkUOB6MwN/bv
         nseL8uEh0Mxpd4FbAtQuyl4jdrRfOIF1ISfzH80hs9J+BlZ8oe+DVZ4+xHmkxjTeyoZO
         xP1t/sQjLkmrQ7KtN6AbKW/krkOsgIwr/nYsEBfPfzPsk4ZynvZfWxjnAys9UYJ7Nt6k
         1yIb+YawsQP+OIhUUKKTncu2/KFCahRG3yOoaZ5rLHj2jXwtUt8RRok73Me+8trMrOAk
         XkZA==
X-Gm-Message-State: AOAM533bMBd3GgIn9ADHI7H1wTVBo4DFe6b86GGwjueWJTZkggZO1B0N
        0IzH63CzT1a4zawqxJp2BQsfEm6Wowcw1U7NoPsWEDjlcAA=
X-Google-Smtp-Source: ABdhPJwEbz2leXoMgtTxLSNPszQaehKvulgRUQjEkNapMNG4o6OXevXNsFkqBq5KVv0EFJjVbbGwo5aKATaMdxSsddA=
X-Received: by 2002:a1c:f405:: with SMTP id z5mr3153938wma.93.1608282609391;
 Fri, 18 Dec 2020 01:10:09 -0800 (PST)
MIME-Version: 1.0
References: <CACt3ES2LCfNDq-nskrySJjWD5EO9WCAst_+kJT7UbhYOmD+45g@mail.gmail.com>
 <X9xu2q8QFCCf70r7@kroah.com>
In-Reply-To: <X9xu2q8QFCCf70r7@kroah.com>
From:   Meng Zhuo <mengzhuo1203@gmail.com>
Date:   Fri, 18 Dec 2020 17:09:58 +0800
Message-ID: <CACt3ES3NTRZF4jbCjgHybGHofNypQ3EPnYvuJi-eZZXJtonQUg@mail.gmail.com>
Subject: Re: Please remove all bit fields in bpf uapi
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-api@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Greg

Thank you for your reply
It's fine to do compile bit fields "by hand".
However is it possible to setup a guideline that forrbid "bit fields"
in uapi in the future?

Thanks

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2020=E5=B9=B412=E6=9C=8818=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=884:57=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Dec 18, 2020 at 04:52:15PM +0800, Meng Zhuo wrote:
> > Hi, all
> >
> > I'm tring to port bpf.h to Go, however it's very hard to make it right
> > with cgo since bit fields some fields didn't match any type of Go.
> >
> > i.e.
> > struct bpf_prog_info {
> >         /* .... */
> >         __u32 gpl_compatible:1;             <-- boolean ?
> >         __u32 :31; /* alignment pad */   <--- padding with 31 ?
> >
> > UAPI(User application interface) not just for GCC only right? If it's
> > true, I think remove all bit fields is more appropriate.
>
> It's a bit late to change a user-visable api, sorry.  Go has to have
> some way of properly handling bit fields, this isn't a new thing :)
>
> good luck!
>
> greg k-h
