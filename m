Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D416B791D
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 14:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjCMNha (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 09:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjCMNh3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 09:37:29 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D419618B4;
        Mon, 13 Mar 2023 06:37:26 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7331344A;
        Mon, 13 Mar 2023 13:37:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7331344A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1678714646; bh=Ln4hPU22u2IyXOmWwQJeCluL6l9PhBQP9wv6XXjbGR8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=S/cRnPNHzznTXixzHt9TuGwGy8nUuRUdtUOtugauCOhrH0Mh/cU0v/6eXLJ2wPM5C
         ZaHPkt2ACZgUuPwgNfxFpcwQo/h19PyekS+Olzl/iC6rmEUmYR4mCjdAI7ARn7XoFb
         CXQ5J9hP/xTCL7K4Mk00TvK2zZgWrvsSXWq8PZtgOw/3s5FPy6AAQ6K2kYZwScwev2
         wmY30Q/2ZrEW7juvbtQvFEqxFzKwOFqtydHqFin95nAFs2vyP9lbVCnWTGFVdRqrUq
         JEAI7OiKULB629D2ioy0+kpY5zo1irnbfvbgv/7oRstFsiH8PU4Tj2ga51ZqLafJRr
         0uCwPZz5T044Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     David Vernet <void@manifault.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
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
        "David S. Miller" <davem@davemloft.net>,
        "Tobin C. Harding" <me@tobin.cc>
Subject: Re: [PATCH bpf-next] bpf, doc: use internal linking for link to
 netdev FAQ
In-Reply-To: <20230313123602.GA2392@maniforge>
References: <20230313025119.17430-1-bagasdotme@gmail.com>
 <20230313030938.GA152792@maniforge> <ZA6knaEQcddfTCyS@debian.me>
 <fefa25fe-8148-cbd7-a91e-e4713eb6b0ef@gmail.com>
 <4653cfd1-7209-6e49-4f01-fcc3f82f16ce@gmail.com>
 <20230313123602.GA2392@maniforge>
Date:   Mon, 13 Mar 2023 07:37:25 -0600
Message-ID: <87wn3kvkkq.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

David Vernet <void@manifault.com> writes:

> Sure, but there are practicalities to consider here. It takes O(minutes)
> to do a full docs build, as opposed to O(seconds). I've done reviews of
> docs patches where the engineer tried to build the docs tree, but
> thought it was hung and ended up cancelling it. Full docs builds also
> unfortunately spew quite a few warnings in other subtrees. You have to
> carefully wade through the warnings in those other subtrees to ensure
> you haven't added any new ones.
>
> It's hard enough to get people to write documentation. It's also hard
> enough to get them to test building their documentation before
> submitting it. I think there is a lot of value in being able to build
> the documentation for the subtree you're contributing to, and be able to
> have some expectation that it builds cleanly. Let's not make it more
> difficult for the people who are actually adding substantive
> documentation.

I get your point, but that is essentially saying that there should be no
linkages between our documentation subtrees, which defeats much of the
purpose of using a system like Sphinx.

In this specific case, though, there is a better solution.  Text like:

  see the netdev FAQ (Documentation/process/maintainer-netdev.rst)

will add links in the built docs, and also tells readers of the
plain-text files where they should be looking.  Without adding warnings.

For the bigger problem, the right answer is to start using intersphinx.
I guess I need to get serious about playing with that.

Thanks,

jon
