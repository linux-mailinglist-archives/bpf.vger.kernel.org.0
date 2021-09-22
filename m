Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E86415310
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 23:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238097AbhIVVww (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Sep 2021 17:52:52 -0400
Received: from www62.your-server.de ([213.133.104.62]:41716 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238066AbhIVVww (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Sep 2021 17:52:52 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mTA9A-000EqB-FM; Wed, 22 Sep 2021 23:51:20 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mTA9A-000Jul-8S; Wed, 22 Sep 2021 23:51:20 +0200
Subject: Re: bpf_jit_limit close shave
To:     Lorenz Bauer <lmb@cloudflare.com>,
        Frank Hofmann <fhofmann@cloudflare.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
References: <CACAyw9_TjUMu1s46X3jE3ubcszAW3yoj39ADADOFseL0x96MeQ@mail.gmail.com>
 <CAADnVQKxmNDET97wfi-k7L_ot9WXDX7CnqPNe=wK=rXpQJDcyg@mail.gmail.com>
 <CACAyw9_1s2ZCBWTHvT-rGufW+-m3F722GvhHb_rSR3mEr2gfGA@mail.gmail.com>
 <CABEBQi=WfdJ-h+5+fgFXOptDWSk2Oe_V85gR90G2V+PQh9ME0A@mail.gmail.com>
 <CAADnVQKX+ngPV=ZD9+Mm-odr=g-Neqm21TtxZ_rHpt+ybs-8RQ@mail.gmail.com>
 <CABEBQi=aZNfOdPH1999sfpD_dvSiOnhnudH3d=XEuQ=0q_bBCA@mail.gmail.com>
 <CACAyw99oxFvPFCvN5HovoOnJxdKzqbRvfSMCm0Ds-jh3A4XT5Q@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <97d6e8ab-7a02-f317-81ed-6f45d26ad3c6@iogearbox.net>
Date:   Wed, 22 Sep 2021 23:51:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CACAyw99oxFvPFCvN5HovoOnJxdKzqbRvfSMCm0Ds-jh3A4XT5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.3/26300/Wed Sep 22 11:04:22 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/22/21 1:07 PM, Lorenz Bauer wrote:
> On Wed, 22 Sept 2021 at 09:20, Frank Hofmann <fhofmann@cloudflare.com> wrote:
>>
>>> That jit limit is not there on older kernels and doesn't apply to root.
>>> How would you notice such a kernel bug in such conditions?
>>
>> I'm talking about bpf_jit_current - it's an "overall gauge" for
>> allocation, priv and unpriv. I understood Lorenz' note as "change it
>> so it only tracks unpriv BPF mem usage - since we'll never act on
>> privileged usage anyway"
> 
> Yes, that was my suggestion indeed. What Frank is saying: it looks
> like our leak of JIT memory is due to a privileged process. By
> exempting privileged processes it would be even harder to notice /
> debug. That's true, and brings me back to my question: what is
> different about JIT memory that we can't do a better limit?

The knob with the limit was basically added back then as a band-aid to avoid
unprivileged BPF JIT (cBPF or eBPF) eating up all the module memory to the
point where we cannot even load kernel modules anymore. Given that memory
resource is global, we added the bpf_jit_limit / bpf_jit_current acounting
as a fix/heuristic via ede95a63b5e8 ("bpf: add bpf_jit_limit knob to restrict
unpriv allocations"). If we wouldn't account for root, how would such detection
proposal work otherwise to block unprivileged? I don't think it's feasible to
only account the latter given privileged progs might have occupied most of the
budget already.

Thanks,
Daniel
