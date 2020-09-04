Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8717725E19E
	for <lists+bpf@lfdr.de>; Fri,  4 Sep 2020 20:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgIDSua (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Sep 2020 14:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbgIDSuV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Sep 2020 14:50:21 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C42C061244;
        Fri,  4 Sep 2020 11:50:20 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id t23so9192784ljc.3;
        Fri, 04 Sep 2020 11:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YtKx/BkJtpRlTWwmfq1br0XSeXd7ZgOWgZ7CcNA6fU4=;
        b=UB4c4dgv5HvkI1cloRBNUnahHpluNnVf7Ci6WUQSTQkAkfbf0rM0GeQP49L0GvGqTY
         fgh7HiLOU3n/kSes7dmEwuuxI3dGwr3P+qku0qLVnwD+ezBRVPHT8bkGTTAEjNbgNjyp
         +JD2BgESFH/OqWfQP8HlZ7q3mZ0r50oFCqIZSBSi+btjo6iwJSRxPvtCMFcZp7eNNU7E
         kRVTkVlL93DLO6GkkLeGZMAhmXaBEMwyMlM/mWTwNqi1ZNgv7PexTrnscnJ1q2eY0ZIF
         WGwj8Qx3G8s5s42OpMN0qL980ygLXLgNIk4I32eHqRkDJNnUKZ9vyhgm238Ozc8MLsmw
         pDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YtKx/BkJtpRlTWwmfq1br0XSeXd7ZgOWgZ7CcNA6fU4=;
        b=Ol/PuGxZ2ScBs92Z36YF3iT1qYPhVROuYAmSgDr2TAcrIzNzri7CrPSS2CfWgygxC8
         qsAhttJBm+Vui9/7jAvprdFHrIUp3k8Z0IKWU/edJZU3k56S8OXL+K+R9elfnrduudJx
         M+QnbfIbeeTf+o8WrokIztE/5fai46Nx/ZHwrGXRyXBwQtEA+29LVIZNbwXvXbMaqYrM
         qjV+/u7V0cBtVC/WQTXYH2j3nK01XTF9Vnx6sqXQ9iS6PL5zOPfyFtQDgAa7ucwoF36V
         XBNQGyliQ71MOegticFOH/TkxgFGkPa0LJc18gPTUXFzo8opGcoRj8qdJ/sogc2O97ss
         EVmQ==
X-Gm-Message-State: AOAM531Ae2+1uXWO0v0Zrd9FgQAYorrt5jAynkkdfXzAZ3dLhRgX4HyL
        4nvEprt6MQOCRoMOC4uf1pNnuUNE5fywfy+JiClFbtLW
X-Google-Smtp-Source: ABdhPJyjC2mdiG2BYeodygZPZL0MK5GS6pcPsLA2b9DxuOy5u60byR0+dfXSOQdjCw7F8TCKi4UiXkCaV51eeXVeC5I=
X-Received: by 2002:a2e:4e09:: with SMTP id c9mr4790625ljb.283.1599245418496;
 Fri, 04 Sep 2020 11:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200812163305.545447-1-leah.rumancik@gmail.com>
 <20200812163305.545447-2-leah.rumancik@gmail.com> <a0a97488-58c7-1f00-c987-d75e1329159c@oracle.com>
 <20200817163207.p53guehd7kpxfvat@ast-mbp.dhcp.thefacebook.com> <20200904164605.GB2048@leah-Ubuntu>
In-Reply-To: <20200904164605.GB2048@leah-Ubuntu>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 4 Sep 2020 11:50:06 -0700
Message-ID: <CAADnVQK3VVzUHsteMcZ_iBFqQaoUJc5q-Rx9zxtCMw+-OhTHbA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] bpf: add new prog_type BPF_PROG_TYPE_IO_FILTER
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     Bob Liu <bob.liu@oracle.com>, bpf <bpf@vger.kernel.org>,
        linux-block@vger.kernel.org,
        =?UTF-8?Q?KJ_=C3=98rbekk?= <orbekk@google.com>,
        Harshad Shirwadkar <harshads@google.com>,
        Michal Jaszczyk <jasiu@google.com>, saranyamohan@google.com,
        Theodore Tso <tytso@google.com>,
        Bart Van Assche <bvanassche@google.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 4, 2020 at 9:46 AM Leah Rumancik <leah.rumancik@gmail.com> wrote:
>
> On Mon, Aug 17, 2020 at 09:32:07AM -0700, Alexei Starovoitov wrote:
> > On Mon, Aug 17, 2020 at 10:18:47PM +0800, Bob Liu wrote:
> > > > +
> > > > +/* allows IO by default if no programs attached */
> > > > +int io_filter_bpf_run(struct bio *bio)
> > > > +{
> > > > + struct bpf_io_request io_req = {
> > > > +         .sector_start = bio->bi_iter.bi_sector,
> > > > +         .sector_cnt = bio_sectors(bio),
> > > > +         .opf = bio->bi_opf,
> > > > + };
> > > > +
> > > > + return BPF_PROG_RUN_ARRAY_CHECK(bio->bi_disk->progs, &io_req, BPF_PROG_RUN);
> > >
> > >
> > > I think pass "struct bpf_io_request" is not enough, since we may want to do the filter based on
> > > some special patterns against the io data.
> > >
> > > I used to pass "page_to_virt(bio->bi_io_vec->bv_page)" into ebpf program..
> >
> > Bob,
> >
> > Just like other bpf uapi structs the bpf_io_request is extensible and
> > such pointer can be added later, but I have a different question.
> >
> > Leah,
> >
> > Do you really need the arguments to be stable?
> > If so 'opf' above is not enough.
> > sector_start, sector_cnt are clean from uapi pov,
> > but 'opf' exposes kernel internals.
> > The patch 2 is doing:
> > +int protect_gpt(struct bpf_io_request *io_req)
> > +{
> > +       /* within GPT and not a read operation */
> > +       if (io_req->sector_start < GPT_SECTORS && (io_req->opf & REQ_OP_MASK) != REQ_OP_READ)
> > +               return IO_BLOCK;
> >
> > The way ops are encoded changed quite a bit over the kernel releases.
> > First it was REQ_WRITE, then REQ_OP_SHIFT, now REQ_OP_MASK.
> > From kernel pov it would be simpler if bpf side didn't impose stability
> > requriment on the program arguments. Then the kernel will be free to change
> > REG_OP_READ into something else. The progs would break, of course, and would
> > have to be adjusted. That's what we've been doing with tools like biosnoop.
> > If you're ok with unstable arguments then you wouldn't need to introduce
> > new prog type and this patch set.
> > You can do this filtering already with should_fail_bio().
> > bpf prog can attach to should_fail_bio() and walk all bio arguments
> > in unstable way.
> > Instead of:
> > +       if (io_req->sector_start < GPT_SECTORS && (io_req->opf & REQ_OP_MASK) != REQ_OP_READ)
> > you'll write:
> >   if (bio->bi_iter.bi_sector < GPT_SECTORS && (bio->bi_opf & REQ_OP_MASK) != REQ_OP_READ)
> > It will also work on different kernels because libbpf can adjust field offsets and
> > check for type matching via CO-RE facility.
> > Will that work for you?
>
> Alexei,
>
> I need the arguments to be stable. What would be the best way to go
> about this? Pulling selected information from the opf field and defining
> my own constants?

"stable" in what sense? To run on different kernels ?
CO-RE already achieves that.
I think what I proposed above is "stable" enough based on the description
of what you wanted to achieve.
