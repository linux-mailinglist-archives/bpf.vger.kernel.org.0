Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7BC8D94E
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2019 19:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbfHNRHS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Aug 2019 13:07:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37264 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729841AbfHNRHR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Aug 2019 13:07:17 -0400
Received: by mail-pf1-f196.google.com with SMTP id 129so7027881pfa.4
        for <bpf@vger.kernel.org>; Wed, 14 Aug 2019 10:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F6sZvDt8GfsqSL6+yaOVxmYir21u5qs+0FrDZAMGm+U=;
        b=P/zi5BsaaIlJFS27qbrRPHG19C5OHY9/C4zVdy7Cb6Jpf7LuJ+Up0Fht6/3cwDMPIj
         28qwwRlC6h2CihsxxQsJljtiN1VMl20e9sW5lez1zg09H+GuRy+mnObc1RNGO3qpqLLU
         8gTWRmY1XIwHOBi/KGKHPsJcAwLliaTgu2TCMO1DdSwoIVnJNMv66lyDzxPx+vuS5huV
         +RyTFeTeR8ilnIYQ9ReQXgeO66HU7Mqh15dB2oB09ya5+j2f1jgC8FLJj+65ARVnSfDC
         ej2Y2WDibJam82j5FL4I5swZRiBMJ6tNWEI9R9Nykh1ujrAAygao0vZYulwZXVlaOl0y
         4ipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F6sZvDt8GfsqSL6+yaOVxmYir21u5qs+0FrDZAMGm+U=;
        b=M0AlCREqbo1PBjJZC3s4CRc7RGlV9drGzhvNIyCSr3ETEk8Rn+gzWid+UiNHNHzpJD
         nZ21hd0E8o5MnNO4Rdz/dHUa8Um6eUS7NavOfvOegI+yrWJ8Fwl924PFaJfwV6EQ15iV
         2d+hgenSsS0pvnVJmi3V9G1SdzfFyIupz/dI5E5PFvVE5Pa9+Ho2CwHjXAfSCdoxADvT
         oqeNcAsk0Rvfj9+L1csUXEBPZNO/534Nn5Jd6PwQk6iah0W2HHKWTUeeDZaIVZaYWZaA
         slhjVWiTYLMSUH9yHLkX/wGU1uNA3/uHecWKrMRtmdAKPKWzSqGNV5NLULmlAGVQoOVj
         kcnQ==
X-Gm-Message-State: APjAAAX8rNY7lUqWUELpNzUgjWbX0yTCiwDWHH9/63E4+NMsWAz02gJQ
        hsyIwfEABO4hV+0dRqewDbI07A==
X-Google-Smtp-Source: APXvYqwg07VY8os024RQPur1zjETv2lW8luJPu4P30Aw7c7WkUQFbc1mwMUhePSJ8MX5oM07n3Q0Ng==
X-Received: by 2002:a17:90a:c24e:: with SMTP id d14mr699458pjx.129.1565802437056;
        Wed, 14 Aug 2019 10:07:17 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id q24sm428759pjp.14.2019.08.14.10.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 10:07:16 -0700 (PDT)
Date:   Wed, 14 Aug 2019 10:07:15 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Toshiaki Makita <toshiaki.makita1@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, William Tu <u9012063@gmail.com>
Subject: Re: [RFC PATCH bpf-next 00/14] xdp_flow: Flow offload to XDP
Message-ID: <20190814170715.GJ2820@mini-arch>
References: <20190813120558.6151-1-toshiaki.makita1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813120558.6151-1-toshiaki.makita1@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 08/13, Toshiaki Makita wrote:
> * Implementation
> 
> xdp_flow makes use of UMH to load an eBPF program for XDP, similar to
> bpfilter. The difference is that xdp_flow does not generate the eBPF
> program dynamically but a prebuilt program is embedded in UMH. This is
> mainly because flow insertion is considerably frequent. If we generate
> and load an eBPF program on each insertion of a flow, the latency of the
> first packet of ping in above test will incease, which I want to avoid.
Can this be instead implemented with a new hook that will be called
for TC events? This hook can write to perf event buffer and control
plane will insert/remove/modify flow tables in the BPF maps (contol
plane will also install xdp program).

Why do we need UMH? What am I missing?
