Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD995573DAF
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 22:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbiGMUSW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 16:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiGMUSW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 16:18:22 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846BB2314B
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 13:18:20 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 001AB24002A
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 22:18:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1657743498; bh=GdC5B28xplq5rJ/CBv40uaz8naF3OXrhg4Og50ogl/I=;
        h=Date:From:To:Cc:Subject:From;
        b=huVZOy17S0kGEN8Mkhb3EMIZOp/pXEeOgxJWAOPwyQRXyXYvceGiETPoZJjpyNyn1
         DVWG8I3TMGGuNI0i+wm5WGN0ZouXlzzjbTuZGmGhoNjMM3NaZDh24ahVRHU0ePHlRl
         uP0x2uh3ET0Jl+iL/z0aiRlvoisAz4vcvlKmx5djqmtaKo4Hjearwt4qN8+y7vhysO
         6zUcfmC+pcqlg0dyG3SZgFLLd7dh0KRohyR4ZhFedUxgHBpFe0b6/9Lw3emVYyWJ1U
         07NivabOTqoDD8oXYt9jK5cuXaCFDOkqiHWdqksyVusONBJZ4h2sSB/Tx8nMemf4eo
         JhMcrvWp7V8Nw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LjppY5Rspz6tmM;
        Wed, 13 Jul 2022 22:18:13 +0200 (CEST)
Date:   Wed, 13 Jul 2022 20:18:10 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     sdf@google.com
Cc:     oak.zeng@intel.com, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "song@kernel.org" <song@kernel.org>, "yhs@fb.com" <yhs@fb.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "haoluo@google.com" <haoluo@google.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>
Subject: Re: Build error of samples/bpf
Message-ID: <20220713201810.srddhocttytfufdr@muellerd-fedora-PC2BDTX9>
References: <BN6PR11MB16338E9998353C6B239CD27792869@BN6PR11MB1633.namprd11.prod.outlook.com>
 <BN6PR11MB16332A018C2FAB69B479EA2B92869@BN6PR11MB1633.namprd11.prod.outlook.com>
 <Ys2tkthkFE1XkEPh@google.com>
 <BN6PR11MB16331BEF1C7F6F37F76C55DD92899@BN6PR11MB1633.namprd11.prod.outlook.com>
 <Ys7wVqnuK3QWlnRH@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys7wVqnuK3QWlnRH@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 13, 2022 at 09:18:43AM -0700, sdf@google.com wrote:
> On 07/13, Zeng, Oak wrote:
> > Thank you sdf for the reply.
> 
> > It is news to me that samples/bpf tend to go stale. When I looked the
> > samples/bpf folder git history, the last update is from only 2 months
> > ago. And yes I can see samples/bfp is not actively updated recently. We
> > are from Intel's GPU group and we are working on some bpf tools for GPU
> > profiling purpose. We made our work based on the structure of
> > samples/bpf because we can conveniently use libbpf. We chose bpf c
> > frontend (vs python frontend) because python bpf program seems can't
> > execute under non-root leading to some security concerns. This work is
> > not yet upstream but we planned to upstream it.
> 
> I'm mostly talking from the following perspective:
> http://vger.kernel.org/bpfconf2022_material/lsfmmbpf2022-bpf-ci.pdf
> 
> BPF maintainers have a CI that continuously builds and runs
> tools/testing/selftests/bpf. I don't think it includes samples/bpf;
> that's what I mean by "go stale". Eventually, people fix samples, but
> there is no continuous system to verify they are healthy.

I am looking into some aspects of the CI. I will see what it would take to
build and/or test samples/bpf in an automated fashion there.

[...]

Thanks,
Daniel
