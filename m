Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950921C9094
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 16:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgEGOsT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 10:48:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40429 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726069AbgEGOsT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 May 2020 10:48:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588862897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oiC38W377BJ3/IgJ1e9+tb4MGos7IPwQLTiwdsd9aq8=;
        b=g8E+k+DJEXv+zruuSPnZRPICdzfe9MiSHG9DoUqnJ+AePNIrMZvTJxHWBvP4/tlzeRNQd+
        g7l/80aWwNOi5Xg3TufAm/LQgXRNm/rGyQXM7uF0unLhVP2kgxA76lwyNQmHqS6gfCE3BA
        0ER53sJ8sfoU4DgXNY0utm8oipE/tG4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-QSuR_yOiPx-iclNvGuhLpw-1; Thu, 07 May 2020 10:48:15 -0400
X-MC-Unique: QSuR_yOiPx-iclNvGuhLpw-1
Received: by mail-lf1-f69.google.com with SMTP id p9so2492629lfh.6
        for <bpf@vger.kernel.org>; Thu, 07 May 2020 07:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=oiC38W377BJ3/IgJ1e9+tb4MGos7IPwQLTiwdsd9aq8=;
        b=WkL3AHeO3XaCWt70O5F0+yyv+H67G109ClOegyByh8Jv0eOPRftwZ7LKqMoEl30Y6f
         1tEg7gerfPNu882TGyuhOcXQyRn1E2h8Ei0m+O27u4eiM3R/ldv8StMs1hV1tm3KXYfV
         xyVNKr+kpQYkLss0qv/0hkyTgQXpkcCr29ZnIIB/x3b9Ak7luPpzdqwmMbv9AdSTpfsR
         i9SFHLbtAH7O6NGWneElSaQQt3qMaFW79nFLWw/dljK2Mp8h3PzIZora1pp9pDH3xi6/
         cE4OWOefpyPmaklHBhAzSh1isc6vNNPwAsVoNTvFvZyy4Mtr+fAR/NqeSg1lwxp+Af5X
         OVTQ==
X-Gm-Message-State: AGi0PuYHE/DSpKcJRdhQW0hDgmGR2F/QjDnOsP29pRZ9sSXRapKEuxq+
        jCwDmiaWJ+gmp6IXWQvNxkN+pIStgoSgk/wKrBeaRu1ppSaoBXHpnT+AVlqCQ54L1GGj6tmP7d8
        QmYlhPOx9LxAh
X-Received: by 2002:a05:6512:10cd:: with SMTP id k13mr9197825lfg.173.1588862893742;
        Thu, 07 May 2020 07:48:13 -0700 (PDT)
X-Google-Smtp-Source: APiQypLDfCPyr/YBVc5U9U7yRTn2pKGYi0MG1x5YSQ0mpmOQPZpc1L8JhT8HdncOqH2gdRzOdsG45w==
X-Received: by 2002:a05:6512:10cd:: with SMTP id k13mr9197807lfg.173.1588862893416;
        Thu, 07 May 2020 07:48:13 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id p8sm3411440ljn.93.2020.05.07.07.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 07:48:12 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id EBB711804E9; Thu,  7 May 2020 16:48:11 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: XDP bpf_tail_call_redirect(): yea or nay?
In-Reply-To: <CAJ+HfNhvzZ4JKLRS5=esxCd7o39-OCuDSmdkxCuxR9Y6g5DC0A@mail.gmail.com>
References: <CAJ+HfNidbgwtLinLQohwocUmoYyRcAG454ggGkCbseQPSA1cpw@mail.gmail.com> <877dxnkggf.fsf@toke.dk> <CAJ+HfNhvzZ4JKLRS5=esxCd7o39-OCuDSmdkxCuxR9Y6g5DC0A@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 07 May 2020 16:48:11 +0200
Message-ID: <871rnvkdhw.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:

> On Thu, 7 May 2020 at 15:44, Toke H=C3=B8iland-J=C3=B8rgensen <toke@redha=
t.com> wrote:
>>
>> Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:
>>
>> > Before I start hacking on this, I might as well check with the XDP
>> > folks if this considered a crappy idea or not. :-)
>> >
>> > The XDP redirect flow for a packet is typical a dance of
>> > bpf_redirect_map() that updates the bpf_redirect_info structure with
>> > maps type/items, which is then followed by an xdp_do_redirect(). That
>> > function takes an action based on the bpf_redirect_info content.
>> >
>> > I'd like to get rid of the xdp_do_redirect() call, and the
>> > bpf_redirect_info (per-cpu) lookup. The idea is to introduce a new
>> > (oh-no!) XDP action, say, XDP_CONSUMED and a built-in helper with
>> > tail-call semantics.
>> >
>> > Something across the lines of:
>> >
>> > --8<--
>> >
>> > struct {
>> >         __uint(type, BPF_MAP_TYPE_XSKMAP);
>> >         __uint(max_entries, MAX_SOCKS);
>> >         __uint(key_size, sizeof(int));
>> >         __uint(value_size, sizeof(int));
>> > } xsks_map SEC(".maps");
>> >
>> > SEC("xdp1")
>> > int xdp_prog1(struct xdp_md *ctx)
>> > {
>> >         bpf_tail_call_redirect(ctx, &xsks_map, 0);
>> >         // Redirect the packet to an AF_XDP socket at entry 0 of the
>> >         // map.
>> >         //
>> >         // After a successful call, ctx is said to be
>> >         // consumed. XDP_CONSUMED will be returned by the program.
>> >         // Note that if the call is not successful, the buffer is
>> >         // still valid.
>> >         //
>> >         // XDP_CONSUMED in the driver means that the driver should not
>> >         // issue an xdp_do_direct() call, but only xdp_flush().
>> >         //
>> >         // The verifier need to be taught that XDP_CONSUMED can only
>> >         // be returned "indirectly", meaning a bpf_tail_call_XXX()
>> >         // call. An explicit "return XDP_CONSUMED" should be
>> >         // rejected. Can that be implemented?
>> >         return XDP_PASS; // or any other valid action.
>> > }
>> >
>> > -->8--
>> >
>> > The bpf_tail_call_redirect() would work with all redirectable maps.
>> >
>> > Thoughts? Tomatoes? Pitchforks?
>>
>> The above answers the 'what'. Might be easier to evaluate if you also
>> included the 'why'? :)
>>
>
> Ah! Sorry! Performance, performance, performance. Getting rid of a
> bunch of calls/instructions per packet, which helps my (AF_XDP) case.
> This would be faster than the regular REDIRECT path. Today, in
> bpf_redirect_map(), instead of actually performing the action, we
> populate the bpf_redirect_info structure, just to look up the action
> again in xdp_do_redirect().
>
> I'm pretty certain this would be a gain for AF_XDP (quite easy to do a
> quick hack, and measure). It would also shave off the same amount of
> instructions for "vanilla" XDP_REDIRECT cases. The bigger issue; Is
> this new semantic something people would be comfortable being added to
> XDP.

Well, my immediate thought would be that the added complexity would not
be worth it, because:

- A new action would mean either you'd need to patch all drivers or
  (more likely) we'd end up with yet another difference between drivers'
  XDP support.

- BPF developers would suddenly have to choose - do this new faster
  thing, or be compatible? And manage the choice based on drivers they
  expect to run on, etc. This was already confusing with
  bpf_redirect()/bpf_redirect_map(), and this would introduce a third
  option!

So in light of this, I'd say the performance benefit would have to be
quite substantial for this to be worth it. Which we won't know until you
try it, I guess :)

Thinking of alternatives - couldn't you shoe-horn this into the existing
helper and return code? Say, introduce an IMMEDIATE_RETURN flag to the
existing helpers, which would change the behaviour to the tail call
semantics. When used, xdp_do_redirect() would then return immediately
(or you could even turn xdp_do_redirect() into an inlined wrapper that
checks the flag before issuing a CALL to the existing function). Any
reason why that wouldn't work?

-Toke

