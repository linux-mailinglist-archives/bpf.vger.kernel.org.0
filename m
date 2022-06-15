Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CDA54D239
	for <lists+bpf@lfdr.de>; Wed, 15 Jun 2022 22:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbiFOUBj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jun 2022 16:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiFOUBd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jun 2022 16:01:33 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6D93EB96;
        Wed, 15 Jun 2022 13:01:31 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id h23so25297048ejj.12;
        Wed, 15 Jun 2022 13:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hIlp8V9Q8v6hu5DNptd3+GZdAUxwOd6BVN7T3SmNAC0=;
        b=GludlRjE3UvJ9aeG2sXp9y0eSoTdXTV8d0YUkjkL3rUOGggpigV7Rg4z31Rfu7ogjS
         zt7i9NoaUmf5YZSrJvEOlY11za6NPfgEI17l5lgltsou3m7D+VP86CAg69La1QeWHu0R
         ev3ziHbuWozAGUvPu9pS3ZxWUvcJHT9S9EraYMdKV5811qkvIg0Odc3Q2zzWDjPpl8tC
         mT9DJKXsABfokUYUX/f4vGs9Nn0CrAzGfxq0uPRI5Qu7SgBn3tCtJtcb3byCx8fDlyy4
         SRpbZWmmPkg1geBtCxxhnoZceVHevBE7QCO+HErOsAzbbOXjCwt5RDZbd5UU16TUwjlj
         B3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hIlp8V9Q8v6hu5DNptd3+GZdAUxwOd6BVN7T3SmNAC0=;
        b=AekOZd3Tziz/YDt3FVhBJg/vdLj5w87A346TFAZD04qbQKxZHpldVWybdnaMNd9vx/
         wsaoNr8574ZhbOpneTMnLWSNni2HyhWZxOWECqDbv2rVSqTbxwLt8Y9jafyMmD1qLFk0
         OiZrhFfgIYrFSmRKLPwKkrxP76mfwNvzeWasX9erdp9ZZTyvuHcyzYrSprb28MpW44II
         uFFTzaab7TOYoI3B35uX8FEK/P/RGYoqNnH+X5dXdRkH7e7CaWWczVGS8EP+4IxUdSME
         joPzPXbXfKa0OLWTrtWrMrEAoVimRN6g2865q7Ga/GXiPi+qEWDE6goWbQTsFLh6+77T
         rLHw==
X-Gm-Message-State: AJIora8aPa/yTgndf7VJbSUpAhxg5LALdQd+DlMQ4D7w3FB+4LLaJzz8
        si2HEXgWwZcPZTrJWggBEvg=
X-Google-Smtp-Source: AGRyM1vborzrD0jc6uxsycNAdKtdxUFE1HBGt7Xa82xesY7UIGRgX0JHwkHieFpgybdVVoOtXFsFKQ==
X-Received: by 2002:a17:907:a064:b0:711:c819:3cbf with SMTP id ia4-20020a170907a06400b00711c8193cbfmr1419984ejc.460.1655323290449;
        Wed, 15 Jun 2022 13:01:30 -0700 (PDT)
Received: from erthalion.local (dslb-094-222-028-039.094.222.pools.vodafone-ip.de. [94.222.28.39])
        by smtp.gmail.com with ESMTPSA id z18-20020a170906241200b006f3ef214da8sm6859880eja.14.2022.06.15.13.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 13:01:29 -0700 (PDT)
Date:   Wed, 15 Jun 2022 22:00:29 +0200
From:   Dmitry Dolgov <9erthalion6@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] perf/kprobe: maxactive for fd-based kprobe
Message-ID: <20220615200029.ngyayghtnma3ywnb@erthalion.local>
References: <20220609192936.23985-1-9erthalion6@gmail.com>
 <20220609193028.zhxpxscawnd3sep6@erthalion.local>
 <CAADnVQLLq+=gc1r+5pxrf3=VL29yZG=_9z6Th-rzcpC+xxsoyA@mail.gmail.com>
 <20220612211232.3b82015bfabd194893cf0418@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220612211232.3b82015bfabd194893cf0418@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Sun, Jun 12, 2022 at 09:12:32PM +0900, Masami Hiramatsu wrote:
> On Sat, 11 Jun 2022 11:28:36 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > On Thu, Jun 9, 2022 at 1:14 PM Dmitry Dolgov <9erthalion6@gmail.com> wrote:
> > >
> > > > On Thu, Jun 09, 2022 at 09:29:36PM +0200, Dmitrii Dolgov wrote:
> > > >
> > > > Enable specifying maxactive for fd based kretprobe. This will be useful
> > > > for tracing tools like bcc and bpftrace (see for example discussion [1]).
> > > > Use highest 12 bit (bit 52-63) to allow maximal maxactive of 4095.
> > > >
> > > > The original patch [2] seems to be fallen through the cracks and wasn't
> > > > applied. I've merely rebased the work done by Song Liu and verififed it
> > > > still works.
> > > >
> > > > [1]: https://github.com/iovisor/bpftrace/issues/835
> > > > [2]: https://lore.kernel.org/all/20191007223111.1142454-1-songliubraving@fb.com/
> > >
> > > I've recently stumbled upon this seemingly lost topic, and wanted to raise it
> > > again. Please let me know if there is a more appropriate way to do so.
> >
> > With kretprobe using rethook the maxactive limit is no longer used.
> > So we probably don't need this patch.
> >
> > Masami, wdyt?
>
> No, rethook is just a library version of kretprobe return hook,
> so the maxactive is still alive. I would like to make the rethook
> to use(share with) function graph's per-task shadow stack. When
> that is done, the maxactive will be removed.

Thanks for clarification! Does it mean that the possibility of setting
maxactive still makes sense, until the rethook changes you've mentioned
will land?

On a side note, is it possible to somehow follow/review/test the work
about rethook and function graph's shadow stack?
