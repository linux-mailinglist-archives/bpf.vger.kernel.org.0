Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC326B77A6
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 13:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjCMMg2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 08:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjCMMgS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 08:36:18 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBA86132F;
        Mon, 13 Mar 2023 05:36:07 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id cz13so1296431qvb.0;
        Mon, 13 Mar 2023 05:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678710966;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pewuY6x73tIaD/TbTwWFkegdaky1zmiR0ORLdt/3cIc=;
        b=pY/Q3pinQKzyUvY9TdalEzUSoDOq4Ewo43WakW0C4sAFJghiZxI0W6U2YnjHzn8xdo
         59OEeL5uMHIFKjjiTu/xoqOMAZ8SX1F6JX1xCXnqcH8KeZ2Bh/c4EMIQ5Syd9v0MA+by
         dU4p6hOuE9cNb7DMIxzVUM2q0NBRy2QpYKyIvy8sx7Wxqm5c7W9n9OKQAPZKjoPZc7OZ
         QzBxMQWxCrcEMzZ4y8P37GDHhpO4goBhQTJaYfjJ17ryimfUZfPr7c/jTUwB69Cdx82/
         QHmzqZTqPYcxV2hzIitvqK4Z4xG+nogrwIttoqoc/tC8VXdTfxlxihpwunn5r+/nTfyO
         Nbxw==
X-Gm-Message-State: AO0yUKVd+C1PCMCXxfyMdkfDKofYwfQDxGYeAbW4CsBwpkmuoAXuDtSd
        ufXsIF/kvOuvK1ZY4AkGQhE=
X-Google-Smtp-Source: AK7set/Qf7g7Yi5jpdpmzW0NkyxfghNHFm9JE/IsIA+aj9gfdGHstBUgL9TXyKxcQLZHgwNM0roD8Q==
X-Received: by 2002:a05:6214:1306:b0:56e:bb43:a07c with SMTP id pn6-20020a056214130600b0056ebb43a07cmr14042598qvb.20.1678710965919;
        Mon, 13 Mar 2023 05:36:05 -0700 (PDT)
Received: from maniforge ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id z192-20020a3765c9000000b00745727568a6sm2643649qkb.91.2023.03.13.05.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 05:36:05 -0700 (PDT)
Date:   Mon, 13 Mar 2023 07:36:02 -0500
From:   David Vernet <void@manifault.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux BPF <bpf@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        "Tobin C. Harding" <me@tobin.cc>
Subject: Re: [PATCH bpf-next] bpf, doc: use internal linking for link to
 netdev FAQ
Message-ID: <20230313123602.GA2392@maniforge>
References: <20230313025119.17430-1-bagasdotme@gmail.com>
 <20230313030938.GA152792@maniforge>
 <ZA6knaEQcddfTCyS@debian.me>
 <fefa25fe-8148-cbd7-a91e-e4713eb6b0ef@gmail.com>
 <4653cfd1-7209-6e49-4f01-fcc3f82f16ce@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4653cfd1-7209-6e49-4f01-fcc3f82f16ce@gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 13, 2023 at 02:57:59PM +0700, Bagas Sanjaya wrote:
> On 3/13/23 11:42, Bagas Sanjaya wrote:
> > On 3/13/23 11:20, Bagas Sanjaya wrote:
> >> On Sun, Mar 12, 2023 at 10:09:38PM -0500, David Vernet wrote:
> >>> This regresses all of the warnings I fixed in d56b0c461d19da ("bpf,
> >>> docs: Fix link to netdev-FAQ target"):
> >>>
> >>> [void@maniforge bpf-next]$ make -j SPHINXDIRS="bpf" htmldocs
> >>> make[2]: Nothing to be done for 'html'.
> >>> Using alabaster theme
> >>> source directory: bpf
> >>> /home/void/upstream/bpf-next/Documentation/bpf/bpf_devel_QA.rst:125: WARNING: unknown document: '/process/maintainer-netdev'
> >>> /home/void/upstream/bpf-next/Documentation/bpf/bpf_devel_QA.rst:150: WARNING: unknown document: '/process/maintainer-netdev'
> >>> /home/void/upstream/bpf-next/Documentation/bpf/bpf_devel_QA.rst:207: WARNING: unknown document: '/process/maintainer-netdev'
> >>> /home/void/upstream/bpf-next/Documentation/bpf/bpf_devel_QA.rst:232: WARNING: unknown document: '/process/maintainer-netdev'
> >>> /home/void/upstream/bpf-next/Documentation/bpf/bpf_devel_QA.rst:398: WARNING: unknown document: '/process/maintainer-netdev'
> >>> /home/void/upstream/bpf-next/Documentation/bpf/bpf_devel_QA.rst:414: WARNING: unknown document: '/process/maintainer-netdev'
> >>>
> >>> And it also causes the netdev-FAQ links to once again be broken and not
> >>> actually point to anything.
> >>
> >> Hi,
> >>
> >> I don't see these warnings in my builds. I'm using Sphinx 2.4.4
> >> (virtualenv, install with pip3 install -r
> >> Documentation/sphinx/requirements.txt). I guess your Sphinx version
> >> doesn't support :doc: directive.
> >>
> >> Also, did you enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS,
> >> and CONFIG_WARN_ABI_ERRORS?
> >>
> >> Thanks.
> >>
> > 
> > Oops, I didn't see the context.
> > 
> > When I rebuild the docs, I always omit SPHINXDIRS as you mentioned.
> > For :doc: links to work, you need to just do ``make htmldocs`` and
> > DO NOT specify that variable.

Hi Bagas,

Sure, but there are practicalities to consider here. It takes O(minutes)
to do a full docs build, as opposed to O(seconds). I've done reviews of
docs patches where the engineer tried to build the docs tree, but
thought it was hung and ended up cancelling it. Full docs builds also
unfortunately spew quite a few warnings in other subtrees. You have to
carefully wade through the warnings in those other subtrees to ensure
you haven't added any new ones.

It's hard enough to get people to write documentation. It's also hard
enough to get them to test building their documentation before
submitting it. I think there is a lot of value in being able to build
the documentation for the subtree you're contributing to, and be able to
have some expectation that it builds cleanly. Let's not make it more
difficult for the people who are actually adding substantive
documentation.

> > 
> > Anyway, these warnings make sense since the target is absolute
> > (rather than relative).
> > 
> 
> Hi again,
> 
> I think SPHINXDIRS specifies the subdir as root directory when
> resolving references, so when there are references to docs
> outside SPHINXDIRS, nonexistent doc warnings will occur. For normal
> (full) htmldocs builds though, these will go away (see [1]).
> 
> Thanks.
> 
> [1]: https://lore.kernel.org/all/f4d40da6-756b-9e75-b867-cc9eedc4b232@gmail.com/

Thanks, I understand that, but I'm not seeing why it's necessary to use
:doc: or :ref: to point to pages in other subtrees. Most people are
already going to docs.kernel.org anyways, and it's easy to map a URL
there to an internal page in the docs tree if you need to. I'm more than
happy to be corrected here, but as I said above, I'm trying to optimize
for the people who are adding substantive documentation to BPF.

Thanks,
David
