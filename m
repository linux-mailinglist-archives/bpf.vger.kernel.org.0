Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2BC836D811
	for <lists+bpf@lfdr.de>; Wed, 28 Apr 2021 15:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239711AbhD1NLj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Apr 2021 09:11:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:45480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239201AbhD1NLj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Apr 2021 09:11:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F114D613C2;
        Wed, 28 Apr 2021 13:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619615454;
        bh=2Ibkd7Pge7HJjN3dGzr1Td0vru6DS1RxYXZaon8ku3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QM1wPsmh/cx5qTIq9qICo7EkJtksp+xW0piMTnLgCiK0zXj4mPKWwd6HQsTjVkdrL
         OEcBHAe+QZ5efxnSBu09tqP952fEEfmNkSs6f6ytlfsnbMPAm14nm/3j8qMmGa+NFn
         9xTE6ZFTkMoIfclhut6rFfM0EVxDfol0DzF9iwDVhNWSM1PQdrh6tF9z3NMRNMsjcy
         RAthyG+J9bIbJS9KJdLOf4B3qTp9fOWZ3YA8hNwVfzFkClCjhfduqSl241/Miu2TnT
         B3w3POZVW6CezKXqTdGNj26HUyPMohk9qO3uVQsSKqpGH73wgGaPClLlESYNS/fVYa
         phiU4brxGLkdQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 81E2940647; Wed, 28 Apr 2021 10:10:50 -0300 (-03)
Date:   Wed, 28 Apr 2021 10:10:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Martin KaFai Lau <kafai@fb.com>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH dwarves] btf: Generate btf for functions in the .BTF_ids
 section
Message-ID: <YIle2kdR4IniQnbN@kernel.org>
References: <20210423213728.3538141-1-kafai@fb.com>
 <CAEf4BzY16ziMkOMdNGNjQOmiACF3E5nFn2LhtUUQbo-y-AP7Tg@mail.gmail.com>
 <YIf3rHTLqW7yZxFJ@krava>
 <YIgE1hAaa3Hzwni8@kernel.org>
 <CAEf4Bzbh7+WJ502J_MQKiHDZ_Ab-Vb_ysHO6NNuZwNfThKCAKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzbh7+WJ502J_MQKiHDZ_Ab-Vb_ysHO6NNuZwNfThKCAKw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Apr 27, 2021 at 01:38:51PM -0700, Andrii Nakryiko escreveu:
> On Tue, Apr 27, 2021 at 5:34 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> > And tools that expect to trace a function can get that information from
> > the BTF info instead of getting some failure when trying to trace those
> > functions, right?
 
> I don't think it belongs in BTF, though.

My thinking was that since BTF is used when tracing, one would be
interested in knowing if some functions can't be used for that.

> Plus there are additional limitations enforced by BPF verifier that
> will prevent some functions to be attached. So just because the
> function is in BTF doesn't mean it's 100% attachable.

Well, at least we would avoid some that can't for sure be used for
tracing. But, a bit in there is precious, so probably geting a NACK from
the kernel should be a good enough capability query. :-)

Tools should just silently prune things in wildcards provided by the
user that aren't traceable, silently, and provide an error message when
the user explicitely asks for tracing a verbotten function.

- Arnaldo
