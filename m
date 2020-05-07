Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332C61C8CD0
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 15:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgEGNoW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 09:44:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33137 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725939AbgEGNoW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 May 2020 09:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588859061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xMDidoiSpF3yBy71WJiRi9KM9AZl6Zs2VDOQSok9wzw=;
        b=aiTduDD5Dj6/rSm4Yh0H/Izd+q9DEdeJNleBkBnEKbjY8pxc+UGKf08XXWpQchXzH/M3DO
        OOIsARSu2eSJM9JQtOWvOtjrFX8E5g0iry0hqVa7mEhYrRZRKDDhpCpV+V2jqw/96YqI/X
        AhpOag0T32FXKAtUMjryK9C8JmlHc4g=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-l97voTAJNNO8NP6MWl0-og-1; Thu, 07 May 2020 09:44:19 -0400
X-MC-Unique: l97voTAJNNO8NP6MWl0-og-1
Received: by mail-lj1-f198.google.com with SMTP id m4so945368lji.23
        for <bpf@vger.kernel.org>; Thu, 07 May 2020 06:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=xMDidoiSpF3yBy71WJiRi9KM9AZl6Zs2VDOQSok9wzw=;
        b=WRF0ypuULghDomZ/KX4zJA2sbVkRpZHN0MAz/R/HiuNeRQT8yM+SpYvWmyRvwW9yW3
         kOEvHH88Fpj+LsFNh5rQ9Nj04xMSAZ+ngmf94r4JRwAVJF5fSn+RMAu0grRNdhuXPDr0
         b4/0FY320lRzq9Y+80VZLSVbV7EQDvr/Uh7grPgGZTr4auwV/7csZsMlCmgjKupNMN9x
         8YhZLa/mP7eGcbv29BYEfKvGQ0l1tLod5YAspiQ6gxVsgpjNhMz2ESMqFlVenp5AfYTo
         Ua82cd1s6ffu4UNoQpFwmCvZn9yIrn23fpSM1Z13FCZwuEV7KDPw6NDwUfRyteKVpHcl
         oLMQ==
X-Gm-Message-State: AGi0PubszEPqh2TJimEFMJhzekRfkQuf8TTw6HFqlLYQZO8zYj4K3yiu
        QGabJ07k1+G+x9y9APvgbLfflov/0L2ksjVQ9U9bhvVA0SRLPIBSL9iR0jAzzXjo8MywfEp62r4
        VADGBpnX5LYuD
X-Received: by 2002:a2e:b177:: with SMTP id a23mr8413774ljm.140.1588859057740;
        Thu, 07 May 2020 06:44:17 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ8d7CoPiVGuwswhDdmKH02D+pNdUm1EJ3UN432rZNRFoCMkGyhurJkzK5Tz6pqKL2oycMA2A==
X-Received: by 2002:a2e:b177:: with SMTP id a23mr8413766ljm.140.1588859057494;
        Thu, 07 May 2020 06:44:17 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id t5sm3802559lfc.69.2020.05.07.06.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 06:44:16 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 328AD1804E9; Thu,  7 May 2020 15:44:16 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        bpf <bpf@vger.kernel.org>
Cc:     Netdev <netdev@vger.kernel.org>
Subject: Re: XDP bpf_tail_call_redirect(): yea or nay?
In-Reply-To: <CAJ+HfNidbgwtLinLQohwocUmoYyRcAG454ggGkCbseQPSA1cpw@mail.gmail.com>
References: <CAJ+HfNidbgwtLinLQohwocUmoYyRcAG454ggGkCbseQPSA1cpw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 07 May 2020 15:44:16 +0200
Message-ID: <877dxnkggf.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:

> Before I start hacking on this, I might as well check with the XDP
> folks if this considered a crappy idea or not. :-)
>
> The XDP redirect flow for a packet is typical a dance of
> bpf_redirect_map() that updates the bpf_redirect_info structure with
> maps type/items, which is then followed by an xdp_do_redirect(). That
> function takes an action based on the bpf_redirect_info content.
>
> I'd like to get rid of the xdp_do_redirect() call, and the
> bpf_redirect_info (per-cpu) lookup. The idea is to introduce a new
> (oh-no!) XDP action, say, XDP_CONSUMED and a built-in helper with
> tail-call semantics.
>
> Something across the lines of:
>
> --8<--
>
> struct {
>         __uint(type, BPF_MAP_TYPE_XSKMAP);
>         __uint(max_entries, MAX_SOCKS);
>         __uint(key_size, sizeof(int));
>         __uint(value_size, sizeof(int));
> } xsks_map SEC(".maps");
>
> SEC("xdp1")
> int xdp_prog1(struct xdp_md *ctx)
> {
>         bpf_tail_call_redirect(ctx, &xsks_map, 0);
>         // Redirect the packet to an AF_XDP socket at entry 0 of the
>         // map.
>         //
>         // After a successful call, ctx is said to be
>         // consumed. XDP_CONSUMED will be returned by the program.
>         // Note that if the call is not successful, the buffer is
>         // still valid.
>         //
>         // XDP_CONSUMED in the driver means that the driver should not
>         // issue an xdp_do_direct() call, but only xdp_flush().
>         //
>         // The verifier need to be taught that XDP_CONSUMED can only
>         // be returned "indirectly", meaning a bpf_tail_call_XXX()
>         // call. An explicit "return XDP_CONSUMED" should be
>         // rejected. Can that be implemented?
>         return XDP_PASS; // or any other valid action.
> }
>
> -->8--
>
> The bpf_tail_call_redirect() would work with all redirectable maps.
>
> Thoughts? Tomatoes? Pitchforks?

The above answers the 'what'. Might be easier to evaluate if you also
included the 'why'? :)

-Toke

