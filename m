Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77BE3A9E4B
	for <lists+bpf@lfdr.de>; Wed, 16 Jun 2021 16:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbhFPO6P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Jun 2021 10:58:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234220AbhFPO6P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Jun 2021 10:58:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7020861075;
        Wed, 16 Jun 2021 14:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623855369;
        bh=fAr4eEtDErPD5HaZ2H649dFKgvV4j5BKjzBGdfnsEl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TW6kQyGbLD/+hG2SFgoGkMBlWUtkc6ab4jZTNPqMKzcwVGUfAPewyBn8tHt/5ZwzK
         i0yfW03c2OKK2mu36ERHeWV2tLsEp3BpQxD3T105DNVgSimgUUKfaSRJIsXYuqdPQY
         R5Qw7oQCZB23RFJ6y8buU96rl1Wz1rtPO9D+e/rKIqBI6gY8uQhOvCUHkJT589lKcr
         v8DtWD2Jb+HB/dIxdSXPNsltGo+587ZepGM5YpLfzywAKX5IxLTJgjjKjyknVyBelW
         UwJ3797FqBURUDu1TLBXlaAzASoXyTNYIiqKGC5W39Lojolm0vv4llndwZRz6f5+IV
         bhbvH0IoxY1Iw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9AD0C40B1A; Wed, 16 Jun 2021 11:56:06 -0300 (-03)
Date:   Wed, 16 Jun 2021 11:56:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org, siudin@fb.com
Subject: Re: latest pahole breaks libbpf CI and let's talk about staging
Message-ID: <YMoRBvTdD0qzjYf4@kernel.org>
References: <CAEf4BzZnZN2mt4+5F-00ggO9YHWrL3Jru_u3Qt2JJ+SMkHwg+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZnZN2mt4+5F-00ggO9YHWrL3Jru_u3Qt2JJ+SMkHwg+w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Jun 15, 2021 at 04:30:03PM -0700, Andrii Nakryiko escreveu:
> Hey Arnaldo,
> 
> Seems like de3a7f912559 ("btf_encoder: Reduce the size of encode_cu()
> by moving function encoding to separate method") break two selftests
> in libbpf CI (see [0]). Please take a look. I suspect some bad BTF,
> because both tests rely on kernel BTF info.
> 
> You've previously asked about staging pahole changes. Did you make up
> your mind about branch names and the process overall? Seems like a
> good chance to bring this up ;-P
> 
>   [0] https://travis-ci.com/github/libbpf/libbpf/jobs/514329152

Ok, please add tmp.master as the staging branch, I'll move things to
master only after it passing thru CI.

Now looking at that code, must be something subtle...

- Arnaldo
