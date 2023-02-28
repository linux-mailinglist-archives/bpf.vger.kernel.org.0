Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055C36A625E
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 23:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjB1WXl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 17:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjB1WXk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 17:23:40 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308108A60
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 14:23:39 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id A06F924071C
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 23:23:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1677623017; bh=7kJHf3luHjX9QtaRBl1/zwUKu4fNJMQaoPSwdistYUQ=;
        h=Date:From:To:Cc:Subject:From;
        b=AWYfX0jI+betH4Tm3+hAiUxkIdCBvPPwMyGLQBW/I7Dc8PwHq/8JcbbXVAwslGfqy
         65qdnOT1HUphIAAEyN7tZgrdCmjebAFqrFnzr78Qde4ZEB5hiNHH1BBxhGisKSouax
         xx4HUPiKxNLbKHeXx9siq0xM9MXIA8EdyYwverbwFM1+x9+nFv2wIDu2L9CfT1D2LE
         DCUlfedJZQlfR3zWaVFNxDWtMyHWMNpN5Nxo2pRHB8FDxN2LlF/Rh2P9j01D/QS1g1
         gMFi5FUJcLYReMqF/2fGwZzruPtlMt8EvjDQqmAs1O+7+ZyUoyVj3RZ2ssk6eztrfB
         zkF7s6H5+LGug==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PRBj26kMzz9rxQ;
        Tue, 28 Feb 2023 23:23:34 +0100 (CET)
Date:   Tue, 28 Feb 2023 22:23:31 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 3/3] libbpf: Add support for attaching uprobes
 to shared objects in APKs
Message-ID: <20230228222331.vjmidio5f3l7afue@muellerd-fedora-PC2BDTX9>
References: <20230217191908.1000004-1-deso@posteo.net>
 <20230217191908.1000004-4-deso@posteo.net>
 <CAEf4BzasONdYA6JPvF=pAjBW9hotVw34itVG3AoGRJV5pjERBA@mail.gmail.com>
 <20230221213655.zu7zl77damfzxeat@muellerd-fedora-PC2BDTX9>
 <CAEf4BzbwoAtQO6BWm1tBe51VE_BvS+mfVdcjC+uzi5s4A=L4-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbwoAtQO6BWm1tBe51VE_BvS+mfVdcjC+uzi5s4A=L4-Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 23, 2023 at 04:18:28PM -0800, Andrii Nakryiko wrote:
> On Tue, Feb 21, 2023 at 1:37 PM Daniel Müller <deso@posteo.net> wrote:
> >
> > On Fri, Feb 17, 2023 at 04:32:05PM -0800, Andrii Nakryiko wrote:
> > > On Fri, Feb 17, 2023 at 11:19 AM Daniel Müller <deso@posteo.net> wrote:
> > > >
> > > > This change adds support for attaching uprobes to shared objects located
> > > > in APKs, which is relevant for Android systems where various libraries
> > >
> > > Is there a good link with description of APK that we can record
> > > somewhere in the comments for future us?
> >
> > Perhaps
> > https://en.wikipedia.org/w/index.php?title=Apk_(file_format)&oldid=1139099120#Package_contents.
> >
> > Will add it.
> >
> > > Also, does .apk contains only shared libraries, or it could be also
> > > just a binary?
> >
> > It probably could also be for a binary, judging from applications being
> > available for download in the form of APKs.
> >
> > > > may reside in APKs. To make that happen, we extend the syntax for the
> > > > "binary path" argument to attach to with that supported by various
> > > > Android tools:
> > > >   <archive>!/<binary-in-archive>
> > > >
> > > > For example:
> > > >   /system/app/test-app/test-app.apk!/lib/arm64-v8a/libc++_shared.so
> > > >
> > > > APKs need to be specified via full path, i.e., we do not attempt to
> > > > resolve mere file names by searching system directories.
> > >
> > > mere?
> >
> > Yes?
> 
> I'm just confused what "resolve mere file names" means in this
> context. Like, which file names are not "mere"?

It's meant to convey the fact that a "mere file name" is not everything we could
be dealing with. It could also be a full path.

[...]

Thanks,
Daniel
