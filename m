Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79A5346732
	for <lists+bpf@lfdr.de>; Tue, 23 Mar 2021 19:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhCWSH5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Mar 2021 14:07:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231380AbhCWSH0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Mar 2021 14:07:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FA206192B;
        Tue, 23 Mar 2021 18:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616522845;
        bh=W+whf0yJ5mHA5L3YEDhDIDgBeKosoxqWVmeQTKORvWE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XF0QBxGmv9lZwnLiIMAzKxsHht7j5q39KJtRY87XSBDEV5P10T7pNvAlNCwEbNM0w
         FZUSv1Souz9sXXPXTyC6Qyc1ShA8KEjJ/aH4v9dTL9Z4jxaqNHVg0oFEev3KDAviUQ
         ITXw7kf7TGmnYU6jxK55S1P89heyRtxhcTcP43eCty9atE0D/H9BT5D837NttKmMuc
         V3Cm93Ixf/DPTz5H8NS9Npsf3Hw51L+/bCdtCpApz7wvcjzqBrehUegcaLr2GICElj
         eps+CNDOYV0LJgA59s/RMjtuUye5NpHs4hMT0MDFX6UmqPaS0ci/XnnCaUqrzsLkxv
         IPRgceapLTZ5g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3F7DF40647; Tue, 23 Mar 2021 15:07:23 -0300 (-03)
Date:   Tue, 23 Mar 2021 15:07:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH PING dwarves] btf: Add --btf_gen_all flag
Message-ID: <YFouW2D2Y1XpcjKA@kernel.org>
References: <20210312000808.175262-1-iii@linux.ibm.com>
 <YEtvIvODFEQHgt8m@kernel.org>
 <41d244ba53881fa99dda3d0a65c4a8cfb557a755.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41d244ba53881fa99dda3d0a65c4a8cfb557a755.camel@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Mar 23, 2021 at 02:36:48PM +0100, Ilya Leoshkevich escreveu:
> On Fri, 2021-03-12 at 10:39 -0300, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Mar 12, 2021 at 01:08:08AM +0100, Ilya Leoshkevich escreveu:
> > > By default, pahole makes use only of BTF features introduced with
> > > kernel v5.2. Features that are added later need to be turned on with
> > > explicit feature flags, such as --btf_gen_floats. According to [1],
> > > this will hinder the people who generate BTF for kernels externally
> > > (e.g. for old kernels to support BPF CO-RE).
> > > 
> > > Introduce --btf_gen_all that allows using all BTF features supported
> > > by pahole.
> > > 
> > > [1] 
> > > https://lore.kernel.org/dwarves/CAEf4Bzbyugfb2RkBkRuxNGKwSk40Tbq4zAvhQT8W=fVMYWuaxA@mail.gmail.com/
> > 
> > Applied locally, testing ongoing.
> > 
> > Also added this:
> > 
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > 
> > - Arnaldo
> 
> [...]
> 
> Hi Arnaldo,
> 
> I'd like to ping this patch (and
> https://lore.kernel.org/dwarves/20210310201550.170599-1-iii@linux.ibm.com/
> too).

So I finally finished testing, pushing out now.

- Arnaldo
