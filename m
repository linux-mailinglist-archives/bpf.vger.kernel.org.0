Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0CC34677C
	for <lists+bpf@lfdr.de>; Tue, 23 Mar 2021 19:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhCWSWq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Mar 2021 14:22:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231672AbhCWSW3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Mar 2021 14:22:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB0E8619C0;
        Tue, 23 Mar 2021 18:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616523748;
        bh=f4wFTVCoRTVeuLMzFxkYBGsqBPGxi/DZT9+X3D4zjeA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fu0+Qh2JSi61SSfyClIFo9nPizBp2SbLNHu2f+1f9B9aULqYLivS+cDo9GHZNU/sI
         BZfsAUd9/oaLCzujOdA4V4bkLHhZZCNW1wStXCZykGfNAPqke22fy+4LenXzcmD6Bi
         i5BxS/4sqK+bxBXIZwqMLrSEt6Xiaoc7LATzdB/B7gFVSmMN+a1uM8NbZZMLLkvVX7
         sFtTHHGYGaCr3fI8jGBH3M84ry17hthfz36bKbvj795Vvjnxx3tf5aLgFAf4AFsNe4
         01Ypj5NqwpA9IKnfN1+4ltNzEzG58YddaaG+PwA2SGyYxjvgM+K9S4XPQr83XWS+SX
         gQW3Jx5+zXRMg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 105A340647; Tue, 23 Mar 2021 15:22:26 -0300 (-03)
Date:   Tue, 23 Mar 2021 15:22:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH PING dwarves] btf: Add --btf_gen_all flag
Message-ID: <YFox4XQ611jHo7Wj@kernel.org>
References: <20210312000808.175262-1-iii@linux.ibm.com>
 <YEtvIvODFEQHgt8m@kernel.org>
 <41d244ba53881fa99dda3d0a65c4a8cfb557a755.camel@linux.ibm.com>
 <YFouW2D2Y1XpcjKA@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFouW2D2Y1XpcjKA@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Mar 23, 2021 at 03:07:23PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Mar 23, 2021 at 02:36:48PM +0100, Ilya Leoshkevich escreveu:
> > On Fri, 2021-03-12 at 10:39 -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Fri, Mar 12, 2021 at 01:08:08AM +0100, Ilya Leoshkevich escreveu:
> > > > By default, pahole makes use only of BTF features introduced with
> > > > kernel v5.2. Features that are added later need to be turned on with
> > > > explicit feature flags, such as --btf_gen_floats. According to [1],
> > > > this will hinder the people who generate BTF for kernels externally
> > > > (e.g. for old kernels to support BPF CO-RE).
> > > > 
> > > > Introduce --btf_gen_all that allows using all BTF features supported
> > > > by pahole.
> > > > 
> > > > [1] 
> > > > https://lore.kernel.org/dwarves/CAEf4Bzbyugfb2RkBkRuxNGKwSk40Tbq4zAvhQT8W=fVMYWuaxA@mail.gmail.com/
> > > 
> > > Applied locally, testing ongoing.
> > > 
> > > Also added this:
> > > 
> > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > 
> > > - Arnaldo
> > 
> > [...]
> > 
> > Hi Arnaldo,
> > 
> > I'd like to ping this patch (and
> > https://lore.kernel.org/dwarves/20210310201550.170599-1-iii@linux.ibm.com/
> > too).
> 
> So I finally finished testing, pushing out now.

Please check what is in
https://git.kernel.org/pub/scm/devel/pahole/pahole.git/, I'm having some
problems with 2FA on github, will fix soon.

- Arnaldo
