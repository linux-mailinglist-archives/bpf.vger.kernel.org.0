Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3355ED03
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2019 21:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfGCTyk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Jul 2019 15:54:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38441 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfGCTyk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Jul 2019 15:54:40 -0400
Received: by mail-pl1-f196.google.com with SMTP id 9so1790808ple.5
        for <bpf@vger.kernel.org>; Wed, 03 Jul 2019 12:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K9b45FRKzrUcD1ARvm02L/3QoVbWczPOEnA4S5/BQE0=;
        b=qtg6d6jk1lDaCzQ+HSTsI3e09Aj5zJ1lvioZQoceoBcNFMP/m/DrG7NkDNXI3Be23t
         oslb3H08nPY+pGj2+HHCxLe/jz49d0wW1fpd3k5fBoKVeP290J45WPV0MXBLSbhlS9se
         gry8vnETYsloSyNcOMIqWG0aGPinqeutggOxFuTnY0PpByWzu+/pDt/wrGItCpUmOvXj
         SpxTjBtoUcWvQx4gHtpVBC4gXrvlmNvMJgdp6x/pma3QJfnrRnJxrFtioitlZROThMtS
         95xzPAZwK3UpaM8LvS50FijWE42QVVf3unBlzERXR2x/UgNR52c+xlCtPRkSP8WYicqr
         t9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K9b45FRKzrUcD1ARvm02L/3QoVbWczPOEnA4S5/BQE0=;
        b=kQGv25QLvOwlxue7W1ZesJCDRHD729jVmuqVH6dUV06xqlxc5lj9aWvFwWQ9MvWwGs
         x3Hf1T4Xmz6XguNllqZ4vSsyhvh4mLEf63DBBPgnHVTI37l+JXV0mlRZbC2UT/Pb3Pkp
         4vqxxg49R0kEVTjNjSQGrE8m+Ej/qaMs4XRJWTTnum+7AIXDncaE+uTvWHrlkvBQzxLz
         rZKoVpQB8cj+wJMwO0TtmI7NnkKWzhgNwdh3RPOmoEJau3XknnaZRpJbgDSNGOHe5hhL
         9iQI4/DEl41BG+411GuHejYhU90Ezk4boHYqSTO+FX8dDtQVaLJ1IWGS/Cgz1jycqj7M
         3GFw==
X-Gm-Message-State: APjAAAWlqgt5wV0YIpBsVlosnwWd5QmMhl4fNr5vgTpOoDSUYP0S6ya3
        WV8hQexLA1LFc5eAfxcSZyFX1A==
X-Google-Smtp-Source: APXvYqzK77v5bhd2zVi69lR9/dc2eztpoHo/Aojc1eeyJ+9KnwUeCppE9m7iAu3YoPcZ5pryL3Qn2g==
X-Received: by 2002:a17:902:9a85:: with SMTP id w5mr42793300plp.221.1562183679819;
        Wed, 03 Jul 2019 12:54:39 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id 191sm3503421pfu.177.2019.07.03.12.54.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 12:54:39 -0700 (PDT)
Date:   Wed, 3 Jul 2019 12:54:38 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Dumazet <edumazet@google.com>,
        Priyaranjan Jha <priyarjha@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>
Subject: Re: [PATCH bpf-next v2 6/8] selftests/bpf: test BPF_SOCK_OPS_RTT_CB
Message-ID: <20190703195438.GA29524@mini-arch>
References: <20190702161403.191066-1-sdf@google.com>
 <20190702161403.191066-7-sdf@google.com>
 <CAEf4Bzak755ixqVetwaPOi96-aNbGwshO3anrP_i_dvPG_quQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzak755ixqVetwaPOi96-aNbGwshO3anrP_i_dvPG_quQw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/03, Andrii Nakryiko wrote:
> On Tue, Jul 2, 2019 at 9:14 AM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > Make sure the callback is invoked for syn-ack and data packet.
> >
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Priyaranjan Jha <priyarjha@google.com>
> > Cc: Yuchung Cheng <ycheng@google.com>
> > Cc: Soheil Hassas Yeganeh <soheil@google.com>
> > Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
> > Acked-by: Yuchung Cheng <ycheng@google.com>
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  tools/testing/selftests/bpf/Makefile        |   3 +-
> >  tools/testing/selftests/bpf/progs/tcp_rtt.c |  61 +++++
> >  tools/testing/selftests/bpf/test_tcp_rtt.c  | 254 ++++++++++++++++++++
> >  3 files changed, 317 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/testing/selftests/bpf/progs/tcp_rtt.c
> >  create mode 100644 tools/testing/selftests/bpf/test_tcp_rtt.c
> 
> Can you please post a follow-up patch to add test_tcp_rtt to .gitignore?
Sure, will do, thanks for a report!
