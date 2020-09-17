Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78DFA26E3AC
	for <lists+bpf@lfdr.de>; Thu, 17 Sep 2020 20:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgIQSeG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Sep 2020 14:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgIQSdk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Sep 2020 14:33:40 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBB0C061221;
        Thu, 17 Sep 2020 11:33:32 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id o5so3256701qke.12;
        Thu, 17 Sep 2020 11:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kwyClgVXC2Igl5yTeFKCxrxdDCb1R0CjcYruuMDE9mI=;
        b=HNVdAl2UQKT6AxPA/uo5+yCr7Ep036pU+X3WFBXP4GCGzjUJ5gmOd0NnNFQwd1k6R3
         Z+voSqPDxBm7zcyPmygqbnvqmAljIakuYDr/WQcNMMOHT5LHOYmWByQ7PyeTPwyDioT7
         dePNLO9w/8/N0ofevNB6ppQNqPyvzI+zvRU0bYjI96LFquTFY2/hM6PYma9LPXDVle2l
         yESEy5As+BWjg2FpUkbzXMw7sV3q+O1FSz38l2g5ZPulDUrT7qV+haIIBtPcMSXkLlLB
         1Pv5i/9px7XtCUCqdwH5/F4dELuP5EuD34l75LDXRHfCGj5wELOfgZdpISiJgZOpn1Kw
         QLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kwyClgVXC2Igl5yTeFKCxrxdDCb1R0CjcYruuMDE9mI=;
        b=thBDYVFLMi4FBY2+xCDPCWafzK86D5CTutj712qZ15Ky6Yu9ZJm/kaFG3b+oO5zjy0
         uZCBxSxtT414ygoJMYFB8frTGj3y6V1YS4Eiz/THNTJXvhTheujBbrCZDHhBaVWN+2aK
         S/yHiiU4EUXB9qdWZBkqBqRzVWm7tXmvbMoi5bIZUbOFE5lsMcWU3Eh7H4pUISabVHO6
         7YdOi8wA59PiJGVuBhYSe6xPH4AZeIOmqXhff8GOCM4ZO+4jOzzny1H34OrjUiBKIxRp
         3gsDCVSxqoeyjeEv8KcS6PwSsxlnY6Fh9VjgwIQCEBSWZ2RlHZdsQ+mCiJ26lnuWm8ao
         pqbw==
X-Gm-Message-State: AOAM530JJbXWyHrjDIc6knrVQlrjAi9zCXs4anqeg4UPTt9nHPWe6ROX
        8UoInxJU+jroa895FxjEdhQ=
X-Google-Smtp-Source: ABdhPJzUx+EgfpoRkMQrhLmNtotPDwvPX2UuG5vrtwlTd2/gmjdR4jG3V+EDCTeTiXa7AoXqRBgQRQ==
X-Received: by 2002:a37:a514:: with SMTP id o20mr28202780qke.374.1600367611814;
        Thu, 17 Sep 2020 11:33:31 -0700 (PDT)
Received: from leah-Ubuntu ([2601:4c3:200:c230:2ce1:e264:e965:fa9])
        by smtp.gmail.com with ESMTPSA id g64sm423001qkf.71.2020.09.17.11.33.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Sep 2020 11:33:31 -0700 (PDT)
Date:   Thu, 17 Sep 2020 14:33:29 -0400
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Bob Liu <bob.liu@oracle.com>, bpf <bpf@vger.kernel.org>,
        linux-block@vger.kernel.org,
        KJ =?utf-8?Q?=C3=98rbekk?= <orbekk@google.com>,
        Harshad Shirwadkar <harshads@google.com>,
        Michal Jaszczyk <jasiu@google.com>, saranyamohan@google.com,
        Theodore Tso <tytso@google.com>,
        Bart Van Assche <bvanassche@google.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [RFC PATCH 1/4] bpf: add new prog_type BPF_PROG_TYPE_IO_FILTER
Message-ID: <20200917183328.GA6689@leah-Ubuntu>
References: <20200812163305.545447-1-leah.rumancik@gmail.com>
 <20200812163305.545447-2-leah.rumancik@gmail.com>
 <a0a97488-58c7-1f00-c987-d75e1329159c@oracle.com>
 <20200817163207.p53guehd7kpxfvat@ast-mbp.dhcp.thefacebook.com>
 <20200904164605.GB2048@leah-Ubuntu>
 <CAADnVQK3VVzUHsteMcZ_iBFqQaoUJc5q-Rx9zxtCMw+-OhTHbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQK3VVzUHsteMcZ_iBFqQaoUJc5q-Rx9zxtCMw+-OhTHbA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 04, 2020 at 11:50:06AM -0700, Alexei Starovoitov wrote:
> On Fri, Sep 4, 2020 at 9:46 AM Leah Rumancik <leah.rumancik@gmail.com> wrote:
> >
> > On Mon, Aug 17, 2020 at 09:32:07AM -0700, Alexei Starovoitov wrote:
> > > On Mon, Aug 17, 2020 at 10:18:47PM +0800, Bob Liu wrote:
> > > > > +
> > > > > +/* allows IO by default if no programs attached */
> > > > > +int io_filter_bpf_run(struct bio *bio)
> > > > > +{
> > > > > + struct bpf_io_request io_req = {
> > > > > +         .sector_start = bio->bi_iter.bi_sector,
> > > > > +         .sector_cnt = bio_sectors(bio),
> > > > > +         .opf = bio->bi_opf,
> > > > > + };
> > > > > +
> > > > > + return BPF_PROG_RUN_ARRAY_CHECK(bio->bi_disk->progs, &io_req, BPF_PROG_RUN);
> > > >
> > > >
> > > > I think pass "struct bpf_io_request" is not enough, since we may want to do the filter based on
> > > > some special patterns against the io data.
> > > >
> > > > I used to pass "page_to_virt(bio->bi_io_vec->bv_page)" into ebpf program..
> > >
> > > Bob,
> > >
> > > Just like other bpf uapi structs the bpf_io_request is extensible and
> > > such pointer can be added later, but I have a different question.
> > >
> > > Leah,
> > >
> > > Do you really need the arguments to be stable?
> > > If so 'opf' above is not enough.
> > > sector_start, sector_cnt are clean from uapi pov,
> > > but 'opf' exposes kernel internals.
> > > The patch 2 is doing:
> > > +int protect_gpt(struct bpf_io_request *io_req)
> > > +{
> > > +       /* within GPT and not a read operation */
> > > +       if (io_req->sector_start < GPT_SECTORS && (io_req->opf & REQ_OP_MASK) != REQ_OP_READ)
> > > +               return IO_BLOCK;
> > >
> > > The way ops are encoded changed quite a bit over the kernel releases.
> > > First it was REQ_WRITE, then REQ_OP_SHIFT, now REQ_OP_MASK.
> > > From kernel pov it would be simpler if bpf side didn't impose stability
> > > requriment on the program arguments. Then the kernel will be free to change
> > > REG_OP_READ into something else. The progs would break, of course, and would
> > > have to be adjusted. That's what we've been doing with tools like biosnoop.
> > > If you're ok with unstable arguments then you wouldn't need to introduce
> > > new prog type and this patch set.
> > > You can do this filtering already with should_fail_bio().
> > > bpf prog can attach to should_fail_bio() and walk all bio arguments
> > > in unstable way.
> > > Instead of:
> > > +       if (io_req->sector_start < GPT_SECTORS && (io_req->opf & REQ_OP_MASK) != REQ_OP_READ)
> > > you'll write:
> > >   if (bio->bi_iter.bi_sector < GPT_SECTORS && (bio->bi_opf & REQ_OP_MASK) != REQ_OP_READ)
> > > It will also work on different kernels because libbpf can adjust field offsets and
> > > check for type matching via CO-RE facility.
> > > Will that work for you?
> >
> > Alexei,
> >
> > I need the arguments to be stable. What would be the best way to go
> > about this? Pulling selected information from the opf field and defining
> > my own constants?
> 
> "stable" in what sense? To run on different kernels ?
> CO-RE already achieves that.
> I think what I proposed above is "stable" enough based on the description
> of what you wanted to achieve.

I see, I looked into the stability via CO-RE some more and I believe
this will work. Thanks for your help.

Leah
