Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435F55B41A8
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 23:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiIIVta (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 17:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiIIVt2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 17:49:28 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF8D2E7
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 14:49:22 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 2B22A240105
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 23:49:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1662760161; bh=3rMTshyvUJWma1obwyTT1MmiezlmAqKA/Is5uYaBc9c=;
        h=Date:From:To:Cc:Subject:From;
        b=sE/C3OEGbrvYVVa7dTHZcOroh3qQGxAjI497deVWsx05aMIo+d7EBEJKhiMRDj0Ew
         cV/Cf4SMvGJPCpGmm1g+GSN0I12H0yFfvN7xNfPGwp6iuye0IngLc46vYG7LoT2bPt
         F245PQVDUk20PInYuLyDAuZTCv9ieTV4X4uKAKNFY7e0YOVktOVqohl30w5VuNVl9d
         o5m6rZfUeydVX9MV5zKFwYJeKK6x8oRy15e2gflufgcbf3WZxURzI/uz8pUAxcagy1
         ohfP3pH4qsDH0IhmIzpV9EAOyiJiG0yFTDOn04pdBan72BM53euXK8tKuWGgHwXtDU
         0cTAl6tlMmrVw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4MPV4t3hPBz6tpY;
        Fri,  9 Sep 2022 23:49:18 +0200 (CEST)
Date:   Fri,  9 Sep 2022 21:49:14 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH bpf-next v3 1/2] Add subdir support to Documentation
 makefile
Message-ID: <20220909214914.hdn4rxsj6b2cy3xj@muellerd-fedora-PC2BDTX9>
References: <20220829091500.24115-1-donald.hunter@gmail.com>
 <20220829091500.24115-2-donald.hunter@gmail.com>
 <3d08894c-b3d1-37e8-664e-48e66dc664ac@iogearbox.net>
 <m2h71k6bw8.fsf@gmail.com>
 <CAEf4BzZ_2wCVTjhAe0XzJ5qfbVhV0pfZeJ=z9Jg_fj_fzD1JFw@mail.gmail.com>
 <m2bkro3lh5.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2bkro3lh5.fsf@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 09, 2022 at 11:12:22AM +0100, Donald Hunter wrote:
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> 
> > On Tue, Sep 6, 2022 at 3:50 AM Donald Hunter <donald.hunter@gmail.com> wrote:
> >>
> >> Daniel Borkmann <daniel@iogearbox.net> writes:
> >>
> >> > On 8/29/22 11:14 AM, Donald Hunter wrote:
> >> >> Run make in list of subdirs to build generated sources and migrate
> >> >> userspace-api/media to use this instead of being a special case.
> >> >> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> >> >
> >> > Jonathan, given this touches Documentation/Makefile, could you ACK if
> >> > it looks good to you? Noticed both patches don't have doc: $subj prefix,
> >> > but that's something we could fix up.
> >> >
> >> > Maybe one small request, would be nice to build Documentation/bpf/libbpf/
> >> > also with every BPF CI run to avoid breakage of program_types.csv. Donald
> >> > could you check if feasible? Follow-up might be ok too, but up to Andrii.
> >>
> >> Sure, I can look at what is needed for the BPF CI run.
> >>
> >
> > Daniel (Mueller, not Borkmann), is this something that can be added to BPF CI?

I think as long as all required packages are available in the CI distribution
(which I believe is currently a Ubuntu image, but may in the future become Arch
Linux) it should not be a problem to perform checking in CI. It seems as if
generating the documentation may take a while, so we should likely try to have
it run in a separate job. I can't tell what hidden dependencies there may be,
though.

> It looks to me like it can be added to BPF CI if we change docs/conf.py
> to call a new make target in docs/sphinx/Makefile. Hopefully Daniel can
> confirm whether this is the case.

I am not familiar with the documentation generation, but my quick search seems
to suggest that this is done by a 3rd party service and is decoupled from BPF
CI. Specifically, what you suggest may be reflected in the generated docs at
https://libbpf.readthedocs.io/, but I believe they are created from the libbpf
GitHub repository, which is only infrequently synced from bpf tree sources. I
didn't find any indication that CI triggers documentation creation, but it's
possible I missed something.

[...]

Thanks,
Daniel
