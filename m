Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22AE2310E8
	for <lists+bpf@lfdr.de>; Tue, 28 Jul 2020 19:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732047AbgG1R3h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jul 2020 13:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731779AbgG1R3h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jul 2020 13:29:37 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01E8C061794
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 10:29:36 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r2so14001309wrs.8
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 10:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=tlG4ND3F12nqTQOAAMVd6IJgfqHomUEDab5OVqxaacQ=;
        b=mCi5caLcu5YJn+xtLrtIdocKwvqQYS4bArDGPzxsF/I4as7yZbGlmOfWGNhTYEkwF5
         UeEOiF1AN6kzZdPicJZcDM9hBUDYwPRt6s7E8JCZHgE1LjgcglbxeuOE+cFqwXDSulVp
         6mkl0M/duG5LDk/LaUP9y0i7t5YGY3PtJXTd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=tlG4ND3F12nqTQOAAMVd6IJgfqHomUEDab5OVqxaacQ=;
        b=ZhSq5FZltnIaslEs3BLfcOPtA9DeNWznLe+DAYuDunlQs6psJzc4vTeQNvvnKVSrCP
         iz0dVrpVGxEb5b6uXtPOIfdHCZuJxAOKr99StNXyOKMfNqFMGjjHQya0/fj+tXgM9wqA
         akQj9dGkiC25L+23ox6sepv0eEP1uaDY8H0YjeUp8x9/C4uvGLm+lIPfNS5z+BeCgex/
         QP4qx/8lGLmUButGuyjN/0GnzhtDrM2M6I0vtzTcfKYUglE+WQ/9QmBCWenzbHpeo09a
         WHbJpPQnsmtqCngzJWJcgDf89v6SuO1QuJjuePNOLs8mlRZkA/udQH1kiaMCKegaWDbu
         G5Ig==
X-Gm-Message-State: AOAM533DWF0L0hcRbg3jaUFOCllm7KAFAXciZ6isbdCTKvQDHB3nzn34
        yvsazaBZymCJAPvDxHilhh6dQA==
X-Google-Smtp-Source: ABdhPJyldkssbHaeWQ/Iczr9EWDvK02hkGyLr+CeLxrWXBafanxjNXSCVNX9PIi+J4eDJTjAlnPdTw==
X-Received: by 2002:adf:c3c8:: with SMTP id d8mr6377286wrg.406.1595957375164;
        Tue, 28 Jul 2020 10:29:35 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id g145sm8417657wmg.23.2020.07.28.10.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 10:29:34 -0700 (PDT)
References: <20200726120228.1414348-1-jakub@cloudflare.com> <20200728012042.r3gkkeg6ib3r2diy@kafai-mbp> <87pn8fwskq.fsf@cloudflare.com> <20200728163758.2thfltlhsn2nse57@kafai-mbp>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com, Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Willem de Bruijn <willemb@google.com>,
        Marek Majkowski <marek@cloudflare.com>
Subject: Re: [PATCH bpf-next] udp, bpf: Ignore connections in reuseport group after BPF sk lookup
In-reply-to: <20200728163758.2thfltlhsn2nse57@kafai-mbp>
Date:   Tue, 28 Jul 2020 19:29:33 +0200
Message-ID: <87o8nzwnsy.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 28, 2020 at 06:37 PM CEST, Martin KaFai Lau wrote:
> On Tue, Jul 28, 2020 at 05:46:29PM +0200, Jakub Sitnicki wrote:
>> On Tue, Jul 28, 2020 at 03:20 AM CEST, Martin KaFai Lau wrote:
>> > On Sun, Jul 26, 2020 at 02:02:28PM +0200, Jakub Sitnicki wrote:
>> >> When BPF sk lookup invokes reuseport handling for the selected socket, it
>> >> should ignore the fact that reuseport group can contain connected UDP
>> >> sockets. With BPF sk lookup this is not relevant as we are not scoring
>> >> sockets to find the best match, which might be a connected UDP socket.
>> >>
>> >> Fix it by unconditionally accepting the socket selected by reuseport.
>> >>
>> >> This fixes the following two failures reported by test_progs.
>> >>
>> >>   # ./test_progs -t sk_lookup
>> >>   ...
>> >>   #73/14 UDP IPv4 redir and reuseport with conns:FAIL
>> >>   ...
>> >>   #73/20 UDP IPv6 redir and reuseport with conns:FAIL
>> >>   ...
>> >>
>> >> Fixes: a57066b1a019 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
>> >> Cc: David S. Miller <davem@davemloft.net>
>> >> Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>> >> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> >> ---
>> >>  net/ipv4/udp.c | 2 +-
>> >>  net/ipv6/udp.c | 2 +-
>> >>  2 files changed, 2 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
>> >> index 7ce31beccfc2..e88efba07551 100644
>> >> --- a/net/ipv4/udp.c
>> >> +++ b/net/ipv4/udp.c
>> >> @@ -473,7 +473,7 @@ static struct sock *udp4_lookup_run_bpf(struct net *net,
>> >>  		return sk;
>> >>
>> >>  	reuse_sk = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
>> >> -	if (reuse_sk && !reuseport_has_conns(sk, false))
>> >> +	if (reuse_sk)
>> >>  		sk = reuse_sk;
>> >>  	return sk;
>> >>  }
>> >> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
>> >> index c394e674f486..29d9691359b9 100644
>> >> --- a/net/ipv6/udp.c
>> >> +++ b/net/ipv6/udp.c
>> >> @@ -208,7 +208,7 @@ static inline struct sock *udp6_lookup_run_bpf(struct net *net,
>> >>  		return sk;
>> >>
>> >>  	reuse_sk = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
>> >> -	if (reuse_sk && !reuseport_has_conns(sk, false))
>> >> +	if (reuse_sk)
>> > From __udp[46]_lib_lookup,
>> > 1. The connected udp is picked by the kernel first.
>> >    If a 4-tuple-matched connected udp is found.  It should have already
>> >    been returned there.
>> >
>> > 2. If kernel cannot find a connected udp, the sk-lookup bpf prog can
>> >    get a chance to pick another socket (likely bound to a different
>> >    IP/PORT that the packet is destinated to) by bpf_sk_lookup_assign().
>> >    However, bpf_sk_lookup_assign() does not allow TCP_ESTABLISHED.
>> >
>> >    With the change in this patch, it then allows the reuseport-bpf-prog
>> >    to pick a connected udp which cannot be found in step (1).  Can you
>> >    explain a use case for this?
>>
>> It is not intentional. It should not allow reuseport to pick a connected
>> udp socket to be consistent with what sk-lookup prog can select. Thanks
>> for pointing it out.
>>
>> I've incorrectly assumed that after acdcecc61285 ("udp: correct
>> reuseport selection with connected sockets") reuseport returns only
>> unconnected udp sockets, but thats not true for bpf reuseport.
>>
>> So this patch fixes one corner base, but breaks another one.
>>
>> I'll change the check to the below and respin:
>>
>> -	if (reuse_sk && !reuseport_has_conns(sk, false))
>> +	if (reuse_sk && reuse_sk->sk_state != TCP_ESTABLISHED)
> May be disallow TCP_ESTABLISHED in bpf_sk_select_reuseport() instead
> so that the bpf reuseport prog can have a more consistent
> behavior among sk-lookup and the regular sk-reuseport-select case.
> Thought?

Ah, I see now what you had in mind. If that option is on the table, I'm
all for it. Being consistent makes it easier to explain and use.

In that case, let me make that change in a separate submission. I want
to get test coverage in for the three reuseport flavors.

> From reuseport_select_sock(), it seems the kernel's select_by_hash
> also avoids returning established sk.

Right. CC'ing Willem to check if bpf was left out on purpose or not.

> In the mid term, we may consider to remove the connected udp
> from the sockmap and reuseport_array.

SGTM.

> I am a bit confused in the current situation on bpf@reuseport returning
> connected sk and I also can't think of a use case in the
> sk-reuseport-prog-type side.  It was why I was curious on
> the sk-lookup use case.

I don't know about any use cases for selecting a connected udp socket
from bpf reuseport either. It certainly sounds like unexpected behavior
for the receiving process, which expects traffic from just one remote
peer.

Marek, does anything come to mind?

If not, I guess we'll see if anyone screams when the change is proposed.
