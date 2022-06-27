Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121A255D712
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 15:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbiF0ReW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jun 2022 13:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbiF0ReW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jun 2022 13:34:22 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE0DAE7B
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 10:34:20 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 4F78B240029
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 19:34:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1656351258; bh=maJYakzj1ZZ753ieK623DU3q30Uh6Z0d8dI5BPPcXR0=;
        h=Date:From:To:Cc:Subject:From;
        b=SqQ9atlJasUyvikeMOCya2CXw74FTOuUUJa+MTnf+WNc98nftB/8QLpMkttIGLcyb
         WdZmBSjheK7V82o8GeHeXkS0nQn9M90pJTvfNWj0QLGzT31ckRT6TLET/cSf11IDi3
         N4KpCGi2PXr1d0SkTufCMugt9uIe3LaSlEJVqNE7NHhvbJKoZ8zal4v8WiunTpvslI
         Tj32f/C6+jzDrwAw8brJCMj/48ymwDBt7ANVPPR+M+kXtfXOot6GMO034cGgHD+Dlf
         ccg7lm49xg7LfqYT0SfKHvpFAjn9GzhserEeowyK+aW110WogguPbKbW7n7PeaWZQo
         5uNl89StT/r4g==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LWvwk5FNxz6tqB;
        Mon, 27 Jun 2022 19:34:14 +0200 (CEST)
Date:   Mon, 27 Jun 2022 17:34:11 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Joanne Koong <joannelkoong@gmail.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 3/7] bpf: Add type match support
Message-ID: <20220627173411.c27mgwtj7qg22qpd@muellerd-fedora-MJ0AC3F3>
References: <20220620231713.2143355-1-deso@posteo.net>
 <20220620231713.2143355-4-deso@posteo.net>
 <CAJnrk1YL9E2GJN+8Gnr9Db=yAHDOm2nwLb_LUQTEuStkm1jHEg@mail.gmail.com>
 <20220622172224.4curfsv7h7gfjwh5@muellerd-fedora-MJ0AC3F3>
 <CAEf4BzbyU-W8a3fzZoy7DDb=DtqdfGM2U3YpgYaS+EqHWZ0qag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbyU-W8a3fzZoy7DDb=DtqdfGM2U3YpgYaS+EqHWZ0qag@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 24, 2022 at 02:09:33PM -0700, Andrii Nakryiko wrote:
> On Wed, Jun 22, 2022 at 10:22 AM Daniel Müller <deso@posteo.net> wrote:
> >
> > On Tue, Jun 21, 2022 at 12:41:22PM -0700, Joanne Koong wrote:
> > >  On Mon, Jun 20, 2022 at 4:25 PM Daniel Müller <deso@posteo.net> wrote:
> >
> > > > +
> > > > +       return local_len == targ_len && strncmp(local_n, targ_n, local_len) == 0;
> > > Does calling "return !strcmp(local_n, targ_n);" do the same thing here?
> >
> > I think it does. Changed. Thanks!
> 
> No, it doesn't. task_struct___kernel and task_struct___libbpf will
> have same local_len and targ_len and should be considered a name
> match, but strcmp() will return false. That strncmp() is there for a
> very good reason.

Ah, I actually misread the request to be for keeping strncmp(), but omitting the
explicit length equality check beforehand. That's how I updated the code.

[...]

Daniel
