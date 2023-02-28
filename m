Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69086A63CE
	for <lists+bpf@lfdr.de>; Wed,  1 Mar 2023 00:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjB1X37 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 18:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjB1X36 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 18:29:58 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8102AF97B
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 15:29:57 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 05A642404D5
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 00:29:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1677626996; bh=45WsL4e+J7q3yECE3w+ft8fT3yOWkxc4Pu60A+Js32s=;
        h=Date:From:To:Cc:Subject:From;
        b=nyI9jAvSAjTaH7OQjiWaa6EP8mPLa60kdNZ0Kxaw18b+0NxmTJNPLH/2FDNK7v2BG
         3dOYNGQSGhWoJJqZDBQgjo+10mfImTJaImb/0vhrj/U7IEvVJZs3pGdEbBE2GqIgxL
         koIvu04pa4tUY/u+Da5/IY6oG35sAuRx+in14bl7mqMYItIvYB5+p5m0E77+gKv+vs
         aTJPE6s0tcDv5KFd2A54Fj734UbTgYVI6fln2OMMGSyEpBLuyYkLEX+6f8/DNJ0Nax
         MyKrN/ieHKEj7XqOOSNYg2HtaKDJApYC3rTY3TPxyY4snWcUdIIIUN7lqVADbJaXaS
         b6iPESn9h+Syw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PRD9X66Kfz6tm5;
        Wed,  1 Mar 2023 00:29:52 +0100 (CET)
Date:   Tue, 28 Feb 2023 23:29:49 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
        =?utf-8?Q?Micha=C5=82?= Gregorczyk <michalgr@meta.com>
Subject: Re: [PATCH bpf-next v2 1/3] libbpf: Implement basic zip archive
 parsing support
Message-ID: <20230228232949.b4ezo2cozqfnef6b@muellerd-fedora-PC2BDTX9>
References: <20230221234500.2653976-1-deso@posteo.net>
 <20230221234500.2653976-2-deso@posteo.net>
 <CAEf4BzZq3PUUaG_samYSAtFPnJKJP0QF9saUx4Wr+r84j4=O5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZq3PUUaG_samYSAtFPnJKJP0QF9saUx4Wr+r84j4=O5g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 24, 2023 at 10:55:13AM -0800, Andrii Nakryiko wrote:
> On Tue, Feb 21, 2023 at 3:45 PM Daniel Müller <deso@posteo.net> wrote:
> >
> > This change implements support for reading zip archives, including
> > opening an archive, finding an entry based on its path and name in it,
> > and closing it.
> > The code was copied from https://github.com/iovisor/bcc/pull/4440, which
> > implements similar functionality for bcc. The author confirmed that he
> > is fine with this usage and the corresponding relicensing. I adjusted it
> > to adhere to libbpf coding standards.
> >
> > Signed-off-by: Daniel Müller <deso@posteo.net>
> > Acked-by: Michał Gregorczyk <michalgr@meta.com>
> > ---
> >  tools/lib/bpf/Build |   2 +-
> >  tools/lib/bpf/zip.c | 326 ++++++++++++++++++++++++++++++++++++++++++++
> >  tools/lib/bpf/zip.h |  47 +++++++
> >  3 files changed, 374 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/lib/bpf/zip.c
> >  create mode 100644 tools/lib/bpf/zip.h
> >
> 
> [...]
> 
> > +
> > +static int find_cd(struct zip_archive *archive)
> > +{
> > +       __u32 offset;
> > +       int64_t limit;
> > +       int rc = -1;
> > +
> > +       if (archive->size <= sizeof(struct end_of_cd_record))
> > +               return -EINVAL;
> > +
> > +       /* Because the end of central directory ends with a variable length array of
> > +        * up to 0xFFFF bytes we can't know exactly where it starts and need to
> > +        * search for it at the end of the file, scanning the (limit, offset] range.
> > +        */
> > +       offset = archive->size - sizeof(struct end_of_cd_record);
> > +       limit = (int64_t)offset - (1 << 16);
> > +
> > +       for (; offset >= 0 && offset > limit && rc == -1; offset--)
> 
> rc != 0 here to handle -EINVAL? It will keep going for -ENOTSUP,
> though, which is probably not right, so maybe (rc != 0 && rc !=
> -ENOTSUP)?
> 
> but with the latter it feels better to just have explicit if with
> return inside the for loop

Sounds good, will change.

[...]

Thanks,
Daniel
