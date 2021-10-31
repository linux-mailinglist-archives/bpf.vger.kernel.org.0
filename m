Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81233440FB3
	for <lists+bpf@lfdr.de>; Sun, 31 Oct 2021 18:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhJaRQH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 31 Oct 2021 13:16:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229838AbhJaRQG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 31 Oct 2021 13:16:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9288460C40;
        Sun, 31 Oct 2021 17:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635700414;
        bh=y+SaonKwc3ZtUw5OUczgHeBvQSmpGFFMlRiXtrJzwWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Aj0yb5QbvHb4g8nnOx9KelMNXeREQaxcr6GWUrHjsYRmzw2fViDqbrL15mAMGJCBB
         AWHU1mmuCCKNWazWJqFnhKaV1f4TyZ0kOvw724t1eVUAvLaVDK3aX4ceIPqtkux3nZ
         tBeaIlaFz5YepnTv1m+wBwNONuX0r+GnAqoXB937nArzWNmKMqtx4ynVpNaXLx0FRx
         CBOHBaCL6oGSRRxQaVyp5Ls+1NV/6HiTKWOgmGfzpG7ke6L1IKtbVl8hqcx81Va8tJ
         2j6nYSJVtfwjGv4OA4eafnP0kMNa6t6qS9MlxvpzK3Dn7FfjtMZJGzhRrI36NnxnAz
         NDKgSyGMLXJUA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 61DF4410A1; Sun, 31 Oct 2021 14:13:31 -0300 (-03)
Date:   Sun, 31 Oct 2021 14:13:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v2 bpf-next 3/4] perf: pull in
 bpf_program__get_prog_info_linear
Message-ID: <YX7Ou9UALUMYqgQI@kernel.org>
References: <20211011082031.4148337-1-davemarchevsky@fb.com>
 <20211011082031.4148337-4-davemarchevsky@fb.com>
 <CAEf4BzaW90Kin2RpLScizSS5mLkAsKjzs9eS+Z0c5Gbs_FZfHA@mail.gmail.com>
 <5080FF1F-8E7A-4AF7-AD7E-7349E58CFEDB@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5080FF1F-8E7A-4AF7-AD7E-7349E58CFEDB@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Oct 28, 2021 at 08:44:51PM +0000, Song Liu escreveu:
> 
> 
> > On Oct 20, 2021, at 10:37 AM, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > 
> > On Mon, Oct 11, 2021 at 1:20 AM Dave Marchevsky <davemarchevsky@fb.com> wrote:
> >> 
> >> To prepare for impending deprecation of libbpf's
> >> bpf_program__get_prog_info_linear, pull in the function and associated
> >> helpers into the perf codebase and migrate existing uses to the perf
> >> copy.
> >> 
> >> Since libbpf's deprecated definitions will still be visible to perf, it
> >> is necessary to rename perf's definitions.
> >> 
> >> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> >> ---
> > 
> > LGTM, but, Song, can you please take a look as well?
> 
> Sorry for the delay. 
> 
> Acked-by: Song Liu <songliubraving@fb.com>
> 
> Also cc'ing Arnaldo's other email. 


Thanks, I'll get to this.

- Arnaldo
