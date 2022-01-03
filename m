Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99659483125
	for <lists+bpf@lfdr.de>; Mon,  3 Jan 2022 13:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbiACMwd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Jan 2022 07:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiACMwd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Jan 2022 07:52:33 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663B2C061761
        for <bpf@vger.kernel.org>; Mon,  3 Jan 2022 04:52:32 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id y130so74346948ybe.8
        for <bpf@vger.kernel.org>; Mon, 03 Jan 2022 04:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:cc;
        bh=24EFpZU5AMMCntdM+3YfQ+A/kKth8PZ34wiS7rq1lOE=;
        b=NW9OLxIhyjfku9gY4x0MtG5LDoUpoHqMraO18oZwkHvYHaTuAOyA05RMRMZaQVbSws
         vhKmfbs0avD1YH0yur6+e+2Rxn13ipXlE8KxPFHKX6LnHdbM8C0HWx0/Ydymc267gpZ1
         rv/iqgEwpEjtM5jzAvQUnFTOjVl4+38kW+agAP5bO4udPQk6J99TT56Wo93BqrpudJk3
         WeM3YDCRF9UiT+GBKsZNnU/vLEiMeBZC4lASjgx1TeJPdU+7n8R8LKox4zhftJw4qcjF
         18KkmWeo/TErUqiW9Ma4pwpjQRl2tALCs2k1wwcm78F7n7+XwKrjMa+ytFaFu0RBpJ4b
         sVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:cc;
        bh=24EFpZU5AMMCntdM+3YfQ+A/kKth8PZ34wiS7rq1lOE=;
        b=i7TQfWcHjBhxCf9RbjRBJ7vaYov0OfvlBO/Lea8+X8s4X8hGfyfnvAb/oedKjkNml/
         XVXPDcP3XNkf8tlyDrHg9UQO5EP6PkaPgveD5fIxvaH+aNxlCcqkFANmpgG1Xzm9nOPy
         qDkDz97hLUUrjNg96PC8WmGfzh23dPgLgXNL7CGuiF7cTuWbhO3n9RNIVYWr3sksM9n9
         Cl003JKZ3jS8Al5y05BYTF9F/UPAqdBcLbTg3jAxGUyPHpWozid0eFR3Biq4OJTao0Ij
         zA9gLYbYHsyfjTuHYbz1HHrAhlHQxQMScswKAL0XSXHSfUa9KxiNoC1ZEKap6S146xvg
         rY6Q==
X-Gm-Message-State: AOAM530057Iqi7/KydogABKM+hQj4hE5Txp6H+e7xkPeetsxRMCIr5Bg
        EDsyZSxdHEA8FQ23/4XIP4Og2iyjcJcDZVgG1pc=
X-Received: by 2002:a05:6902:1245:: with SMTP id t5mt14580806ybu.263.1641214351616;
 Mon, 03 Jan 2022 04:52:31 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:9004:b0:11e:3248:a837 with HTTP; Mon, 3 Jan 2022
 04:52:31 -0800 (PST)
Reply-To: israelbarney287@gmail.com
In-Reply-To: <CAOpEvthMky+1K7N2-qPMnOZ3nj1FWcNX_5S_36R7Sp8U1iJPww@mail.gmail.com>
References: <CAOpEvtj8u6pMg1HzFpAxnO6_tcMD-HMcTkfvsEavUq8i8XG7EA@mail.gmail.com>
 <CAOpEvtiYHJzTxpsEwqyAogRP1SunnRMeT9qDR2H3LS0kFX2WtA@mail.gmail.com>
 <CAOpEvtjMo_g0Kq2=k1xg9SBTWsGy9XkX5z2t2bm70sW75wAb2A@mail.gmail.com>
 <CAOpEvtjCG3+0igRP3yEaVQoyG7iFQbVHyhK-GfSH9UzdDOBjeA@mail.gmail.com>
 <CAOpEvtjrJRHw2jA-dxNqve22e8Dh-biOXjfFrtBCZHbcRZubGw@mail.gmail.com>
 <CAOpEvtj=4xLUWw6epvPTevs_Qa5JSaMOyrfD0giH-QF+H29cKg@mail.gmail.com>
 <CAOpEvtgESSGDL4h+T6naaFJ5Pw3wsbDmrUtrSkZwAsMBtwUjHg@mail.gmail.com>
 <CAOpEvtikbA1go=rGTZpyU-PWWp0j12c7oNBsSU2jxf0OgVkKMw@mail.gmail.com>
 <CAOpEvthwj_fN3dX-rdmBgdRQ-METBtXpbsRzCrBFiNb9bdzW+g@mail.gmail.com>
 <CAOpEvtiSMp+HtjbMxB2xJT_YSOhqG11CpvnBe21Fs48qcSccgQ@mail.gmail.com>
 <CAOpEvtiU+hjgUC53wU71gFxSFLKmx49HgmYr=U5GXpW-+_WZTw@mail.gmail.com>
 <CAOpEvtivW=5LYc+Ve8Rqfsj2mvCua2su5EeuC3-q4wWKs98pCQ@mail.gmail.com>
 <CAOpEvthbXWWtjJ0GsdK5Br3=V+9uBdc8GAAyqvxMHqPxwsXQWw@mail.gmail.com>
 <CAOpEvtiqnT3-0GWziarop=BtWdN-GEqRqM7om7fJCFoDJKABgQ@mail.gmail.com>
 <CAOpEvthoM1NVSEYStsV5YpH1hL7bsEEnQfNYaKuaKTPPihRvxw@mail.gmail.com> <CAOpEvthMky+1K7N2-qPMnOZ3nj1FWcNX_5S_36R7Sp8U1iJPww@mail.gmail.com>
From:   israel barney <amedodziyaovi@gmail.com>
Date:   Mon, 3 Jan 2022 13:52:31 +0100
Message-ID: <CAOpEvtgz9QxPMWCTUBRU8voUO01zJ=DpFcVvWDy2Ld63HxrcBg@mail.gmail.com>
Subject: Greetings
Cc:     israelbarney287@gmail.com
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Good Day My Good Friend.

I am deeply sorry if I have in any manner disturbed your privacy.
Please forgive this unusual manner of contacting you, there is
absolutely going to be a great doubt and distrust in your heart in
respect for this email. There is no way for me to know whether I will
be properly understood, but it is my duty to write and reach out to
you as a person of transparency, honesty and high caliber. I'll
introduce myself once again, I am Mr. Israel Barney, from Togo Republic. I
am also the Branch Bank Manager of Biatogo Bank, I was also the
Account Manager of my late client Mrs. Anna Who might or might
not be related to you.

She traveled down to china on the 28th of December 2019 on a five
weeks business trip and after the successful transaction in china, she
flew back, not knowing she has been infected with the deadly
Coronavirus (COVID-19). And she sadly passed away on March 20th 2020.
She left the sum of $3.2 Million (Three Million, Two Hundred Thousand
United States Dollars) in our financial institute (Bank), she
specifically confided in me told me that "no one else knows about her
funds in our bank" that the funds was for a project before she passed
away while she was ill. And down here in our country at this present
day, once anyone passes away, after 1 Year if no relatives of the late
the customer doesn't come to claim the funds/assets, it'll be recycled, and
reported to the Central Bank where the greedy government will then
want to have their hands on the funds.

That's where you come in, since you bear the same surnames with her, I
want you to stand as her next of kin since no one else knows about
this funds in our bank besides me, and i don't think anyone will be
coming for it. I promise you that if you agree to assist in claiming
this funds from my Bank, we'll not bridge the law in any way because
I'll be your eyes and ears here in the Bank.

After all is settled we'll share the fund $3.2 Million 50% equally or
rather invest on whatever we choose. So I would really like to know
what you have to say in regards to my proposal.

Thanks
Mr. Israel Barney.
