Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450A446A938
	for <lists+bpf@lfdr.de>; Mon,  6 Dec 2021 22:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350242AbhLFVPa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Dec 2021 16:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346639AbhLFVPa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Dec 2021 16:15:30 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C602AC061746;
        Mon,  6 Dec 2021 13:12:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 751A2CE1410;
        Mon,  6 Dec 2021 21:11:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8F1C341C1;
        Mon,  6 Dec 2021 21:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638825116;
        bh=3+mh5XMGmu3VxF7wKK2q9cEzMYrDXlkMauvHqb0Gfbg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dRRVPhDr6H+kRWQFYcNx9bkXAUzTmSHB+aFoEBsiJ8Y8u/l4COWhOm3l7Pa69sg8U
         0xzcDRN7GqI2cOHcXjzrYn/5Fk9vul12o9m58ZHsX4AobktbuGFJv3eC7OX4ZYDBhb
         vadaLid+mK4D55E5awutAMQF1YWyKHkSHDRxsOo3uIa1X/UwWa2SJutLLUgBSNe17T
         AwgYDPo2meF7Gs9YxUMOwpcVLqwwzO2mKUfTkReG7n+JDw2z3CVZfeGbRozQDv+Lh8
         IvY/vUzzBUbCCv7rl4W4bOwh+M6uFqDHBcUVGpRlop/P9+J4wBEiSWCLb8SQg3Pg1S
         F1ahRSCcJdH6w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F058B40002; Mon,  6 Dec 2021 18:11:53 -0300 (-03)
Date:   Mon, 6 Dec 2021 18:11:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Luca Boccassi <bluca@debian.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@linux.microsoft.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        keyrings@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH bpf-next 0/3] bpf: add signature
Message-ID: <Ya58mWyqlVzgQc9F@kernel.org>
References: <CAADnVQLDEPxOvGn8CxwcG7phy26BKuOqpSQ5j7yZhZeEVoCC4w@mail.gmail.com>
 <CAFnufp1_p8XCUf-RdHpByKnR9MfXQoDWw6Pvm_dtuH4nD6dZnQ@mail.gmail.com>
 <CAADnVQ+DSGoF2YoTrp2kTLoFBNAgdU8KbcCupicrVGCWvdxZ7w@mail.gmail.com>
 <86e70da74cb34b59c53b1e5e4d94375c1ef30aa1.camel@debian.org>
 <CAADnVQLCmbUJD29y2ovD+SV93r8jon2-f+fJzJFp6qZOUTWA4w@mail.gmail.com>
 <CAFnufp2S7fPt7CKSjH+MBBvvFu9F9Yop_RAkX_3ZtgtZhRqrHw@mail.gmail.com>
 <CAADnVQ+WLGiQvaoTPwu_oRj54h4oMwh-z5RV0WAMFRA9Wco_iA@mail.gmail.com>
 <61aae2da8c7b0_68de0208dd@john.notmuch>
 <0079fd757676e62f45f28510a5fd13a9996870be.camel@debian.org>
 <61ae75487d445_c5bd20827@john.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61ae75487d445_c5bd20827@john.notmuch>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Dec 06, 2021 at 12:40:40PM -0800, John Fastabend escreveu:
> I'll just reiterate (I think you get it though) that simply signing
> enforcement doesn't mean now BPF is safe. Further these programs

I think this was clear from the get go, at most this would help with
fingerpointing :-) I.e. BPF signing is not about making things safer,
its just an attempt to know who messed up.

> have very high privileges and can do all sorts of things to the
> system. But, sure sig enforcement locks down one avenue of loading
> bogus program.
 
> > the capability of calling bpf(). Trying to define heuristics is also
> > not good enough for us - creative malicious actors have a tendency to
> > come up with ways to chain things that individually are allowed and
> > benign, but combined in a way that you just couldn't foresee. It would
 
> Sure, but I would argue some things can be very restrictive and
> generally useful. For example, never allow kernel memory read could be
> enforced from BPF side directly. Never allow pkt redirect, etc.

But this is something unrelated to BPF signing, right? Its something
desirable, I'd say this will be at some point required, i.e. one more
step in having BPF programs to be more like userspace apps, where you
can limit all sorts of things it can do, programmatically, a BPF ulimit,
hey, blimit?
 
- Arnaldo
