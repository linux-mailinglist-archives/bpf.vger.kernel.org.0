Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B604B6D729C
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 04:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235312AbjDEC5c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Apr 2023 22:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjDEC5b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 22:57:31 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914E2121
        for <bpf@vger.kernel.org>; Tue,  4 Apr 2023 19:57:30 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so35898518pjt.5
        for <bpf@vger.kernel.org>; Tue, 04 Apr 2023 19:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680663450; x=1683255450;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P+qjICYYDpbKvY0ycTrCF8hV6eLNr0gm84MHvC4iRoU=;
        b=AX2XgkFyjYTDHUjxUKvJ6wYBkwc22FJSLSpuJU+CMoeNqsS+IoH2uDFENLI1hhB/5b
         6Oe4tP5UYMGczELvyYRIZM6yPWWGK5WCvCuDCA1itKCWFxsUF2pJBXhG9LPVHlmTR1rl
         GR02CLVcccu1MitJwcvjuVWGoagtPFg0F4PFqPHzG1yqrpk3umAiFbYkseb9u7sJiCW2
         xANFyx9rqyUE86CXTjmmXW90qy3RlGRAbInEmqiU5etoEJ46+XqdNuTyX7+cMw0eS8+G
         5BmAov1npfTmBtxjSzqlz3RfZBMF553semgFqkhlegqDBenT4S2IfiGN/CzcsTv1nUz4
         LgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680663450; x=1683255450;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P+qjICYYDpbKvY0ycTrCF8hV6eLNr0gm84MHvC4iRoU=;
        b=JL8JHrsaQZ2OtiFvR4beiAAiq0VpgWsaU2OvoT/3PRfI+94vrF+OZ7f6FQozLjckSQ
         Vtq+t/Vf2CMPdtr/8uoGfV1kq8H3/SF1PB2Rvc1RCZe6NU2OgadFCmUxdonr+rWaao9G
         75ZJQCvg8LD5VdTIwN0euzK/bu1EfRQImV7mi0w4jNFYt+hg14YavLVsOpbnuXPyAFCW
         q8bDjqidt6vBg7MxO0Y5u2SP8WsRBea5jso06ztCWlRhHOch5EWs7xUwavWvn/Otrx+I
         1i/23cfVxoDIp5lZSYFtYfexZhfbY0KogX0PX1ml7wPPv5RoBXd65auCmv6uBYr628mo
         liFA==
X-Gm-Message-State: AAQBX9ehZw3GE0/zl7igkOs/xpR36yd/uQHZAoqow/he4CNCCIePzNlh
        /gWUfawzHYWDHPuqLumD4Ik=
X-Google-Smtp-Source: AKy350YKAEPPkgPWSmdSQmgWKaPBOEQVsGqdlxrdpaqIbfR9IV1GlzJ6SpHahakt3Y/0gw2plezEZA==
X-Received: by 2002:a05:6a20:131c:b0:de:4f40:e226 with SMTP id g28-20020a056a20131c00b000de4f40e226mr3390980pzh.52.1680663449773;
        Tue, 04 Apr 2023 19:57:29 -0700 (PDT)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:f79f])
        by smtp.gmail.com with ESMTPSA id u7-20020a63df07000000b004fc1d91e695sm8216058pgg.79.2023.04.04.19.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 19:57:29 -0700 (PDT)
Date:   Tue, 4 Apr 2023 19:57:26 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Paul Lawrence <paullawrence@google.com>
Subject: Re: Dynptrs and Strings
Message-ID: <20230405025726.nesfo5rwuiqnzgqc@macbook-pro-6.dhcp.thefacebook.com>
References: <CA+PiJmRwv8UTyQuEBmn1aHg5mXGqHSpAiOJF0Xo9SwZLfW623A@mail.gmail.com>
 <CAEf4BzZntoM0fHzgBuGiqiTNkq=jT-f09nwub-MHyguJCfLeNA@mail.gmail.com>
 <CA+PiJmSNnQ9DD+JVc9hG7iEj5ZDZfhOhYAMKs+f=kXs=DZxuAA@mail.gmail.com>
 <CAADnVQKMrsc+Dxz3uWeKzCPDfr0XKWaWsbn3AeEm+RCmp-apUQ@mail.gmail.com>
 <CA+PiJmT4KyWAAEbYWggOLdy-WR=m1D+EO3j1+=UbY-wVUpzYDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+PiJmT4KyWAAEbYWggOLdy-WR=m1D+EO3j1+=UbY-wVUpzYDA@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 04, 2023 at 06:50:08PM -0700, Daniel Rosenberg wrote:
> On Tue, Apr 4, 2023 at 3:58 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > I'm pretty sure we can make bpf_dynptr_data() support readonly dynptrs.
> > Should be easy to add in the verifier.
> > But could you pseudo code what you're trying to do first?
> >
> 
> I'm trying to do something like this:
> 
> bpf_fuse_get_ro_dynptr(name, &name_ptr);

so the idea that bpf prog will see opaque ctx == name and a set
of kfuncs will extract different things from ctx into local dynptrs ?

Have you considered passing dynptr-s directly into bpf progs
as arguments of struct_ops callbacks?
That would be faster or slower performance wise?

> name_buf = bpf_dynptr_data(&name_ptr, 4);
> if (!bpf_strncmp(name_buf, 4, "test"))
>    return 42;
> return 0;
> 
> Really I just want to work with the data in the dynptrs in as
> convenient a way as possible.
> I'd like to avoid copying the data if it isn't necessary.

of course.

> At the moment I'm using bpf_dynptr_slice and declaring an empty and
> unused buffer. I'm then hitting an issue with bpf_strncmp not
> expecting mem that's tagged as being associated with a dynptr. I'm
> currently working around that by adjusting check_reg_type to be less
> picky, stripping away DYNPTR_TYPE_LOCAL if we're looking at an
> ARG_PTR_TO_MEM. I suspect that would also be the case for other dynptr
> types.
> 
> I guess for dynptr_data to support R/O, the dynptr in question would
> just need to be tagged as read-only or read/write by the verifier
> previously, and then it could just pass along that tag to the mem it
> returns.

yep. Don't be shy from improving the verifier to your needs.

> >
> > Do you expect bpf prog to see both ro and rw dynptrs on input?
> > And you want bpf prog to use bpf_dynptr_data() to access these buffers
> > wrapped as dynptr-s?
> > The string manipulation questions muddy the picture here.
> > If bpf progs deals with file system block data why strings?
> > Is that a separate set of bpf prog hooks that receive strings on
> > input wrapped as dynptrs?
> > What are those strings? file path?
> > We need more info to help you design the interface, so it's easy to
> > use from bpf prog pov.
> 
> I have a few usecases for them. I've restructured fuse-bpf to use
> struct ops. Each fuse operation has an associated prefilter and
> postfilter op.
> At the moment I'm using dynptrs for any variable length block of data
> that these ops need. For many operations, this includes the file name.
> In some, a path. Other times, it's file data, or xattr names/data.
> They can all have different sizes, and may be backed by data that may
> not be changed, like the dentry name field. I have a pair of kfuncs
> for requesting a dynptr from an opaque storage type, so you can avoid
> having to make unnecessary copies if you're not planning on making
> modifications. The r/w version of the kfunc will allocate new space
> and copy data as needed. They're a direct analog of the helper
> functions from the initial patch. The opaque structure includes
> information about the current and max size of the argument, whether
> the current backing is read-only, and other flags for cleanup if the
> helper allocates memory.
> 
> The Fuse bpf programs may alter those fields, and then returns whether
> it was able to handle the request, or if the request must go to
> userspace.
> 
> While the fields have a max size, their actual size isn't available
> until runtime. That makes the current set of dynptr functions largely
> unusable, since I believe they all require a known constant size to
> access, and I don't think the helper to return the length of a dynptr
> counts for that as far as the verifier is concerned. Worst case, I
> suppose more of those interactions could happen behind kfuncs, where
> they can perform runtime checks. That may end up being overly
> restrictive though.

Overall makes sense, but a bit too abstract for concrete suggestions.
I think it would be best if you just send your rough patches to the list
with comments where things still need work and we will go from there.
