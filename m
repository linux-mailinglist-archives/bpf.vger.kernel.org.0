Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA586B7A5F
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 15:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjCMOcr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 10:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjCMOcq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 10:32:46 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D85A64AA5;
        Mon, 13 Mar 2023 07:32:44 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id d7so13225368qtr.12;
        Mon, 13 Mar 2023 07:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678717963;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTi73Q81+ETNnAfOPWev/jD86ObO6SL82+Ks7Qrg148=;
        b=nJpwrQWQdIIYvjbX8XcFtxUk4k98Amnq6t1OwEpIJi9MDC0TKRx1c2PBpNJJk3RIw0
         YdKVwXxyjy8dMop8fFOY1Rv/vtw+hipkYNyQSjykoI68IUTB+l4f+LrnYKfbtf3rD0ax
         +DNnjrr7A3LAJ3xNvWHCKyjdyKSlOlIORcK1RUrEDnDo781bhiBxWmPXoeBhpI6CY+UD
         LC7WC6i2vgAWS+1XHwB6b6+VPE0SKsGoyGfMkVfB6yWY5Ellqc3FgXsKODy3WU5Kpx2l
         hm52yp83fp6FY5g5n9kC1hbdzmrIrS0XW2GlxegZ0PWTwUXLtR6sujy41G59N3pBrJuv
         jktg==
X-Gm-Message-State: AO0yUKWb426iamzYvtEoa02gtCAeVjIumdvmvVdmkPjKr1UvFh4wbvwG
        405kywtnQHAB0HXJReLKXKw=
X-Google-Smtp-Source: AK7set9Q+JPZ2i1V6OMj9i68y+HnrzPjdi6QEw689/b6Zj7pl7FbRyDq8rVsfPRvScvQuOV3PhOCBA==
X-Received: by 2002:a05:622a:1b9e:b0:3bf:e2d8:28d4 with SMTP id bp30-20020a05622a1b9e00b003bfe2d828d4mr24052310qtb.14.1678717963117;
        Mon, 13 Mar 2023 07:32:43 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:b967])
        by smtp.gmail.com with ESMTPSA id a5-20020ac84345000000b003bfaff2a6b9sm5541060qtn.10.2023.03.13.07.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 07:32:42 -0700 (PDT)
Date:   Mon, 13 Mar 2023 09:32:40 -0500
From:   David Vernet <void@manifault.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux BPF <bpf@vger.kernel.org>,
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
        "David S. Miller" <davem@davemloft.net>,
        "Tobin C. Harding" <me@tobin.cc>
Subject: Re: [PATCH bpf-next] bpf, doc: use internal linking for link to
 netdev FAQ
Message-ID: <20230313143240.GE2392@maniforge>
References: <20230313025119.17430-1-bagasdotme@gmail.com>
 <20230313030938.GA152792@maniforge>
 <ZA6knaEQcddfTCyS@debian.me>
 <fefa25fe-8148-cbd7-a91e-e4713eb6b0ef@gmail.com>
 <4653cfd1-7209-6e49-4f01-fcc3f82f16ce@gmail.com>
 <20230313123602.GA2392@maniforge>
 <87wn3kvkkq.fsf@meer.lwn.net>
 <20230313135638.GD2392@maniforge>
 <87sfe8vi9s.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sfe8vi9s.fsf@meer.lwn.net>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 13, 2023 at 08:27:11AM -0600, Jonathan Corbet wrote:
> David Vernet <void@manifault.com> writes:
> 
> >> In this specific case, though, there is a better solution.  Text like:
> >> 
> >>   see the netdev FAQ (Documentation/process/maintainer-netdev.rst)
> >> 
> >> will add links in the built docs, and also tells readers of the
> >> plain-text files where they should be looking.  Without adding warnings.
> >
> > Nice, seems like the best of both worlds. A syntax clarification
> > question: are you saying that this would work?
> >
> >> see the `netdev-FAQ`_.
> >>
> >>   <snip>
> >>
> >> .. _netdev-FAQ: Documentation/process/maintainer-netdev.rst
> >
> > Or is it required to have the full path inline in the text, as in your
> > example:
> >
> >>   see the netdev FAQ (Documentation/process/maintainer-netdev.rst)
> >
> > The benefit of the former is of course that you only have to specify the
> > link in one place.
> 
> Yeah, but the latter is what we actually have.

Ack, just wanted to make sure I understood the suggestion. I think this
is just fine. There's really no need to add 5 - 6 links in the same file
anyways.

Bagas would you be OK with submitting a v2 patch which changes the first
instance of the `netdev-FAQ`_ to netdev FAQ
(Documentation/process/maintainer-netdev.rst) per Jon's suggestion?

Thanks,
David
