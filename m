Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDE379051E
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2019 17:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfHPP7O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Aug 2019 11:59:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46215 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfHPP7N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Aug 2019 11:59:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id q139so3309005pfc.13
        for <bpf@vger.kernel.org>; Fri, 16 Aug 2019 08:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TQNTKSrwbTOmioBUBWTo9NADf1gDtrRnG9YNSpiPFM0=;
        b=j78QV8fAikdi57toSBskutc8uhtLf/mE+aXXQTC62Mz3qEBtScgmeXZkxl7XGFIOb2
         KnTqLfk2N2hytAfyl8tWj3td1dO8qjEM7vcP7mAFOCtuEiyKGq+JFZwlOsGMqpdyqLJV
         P17iD1/28rMSlPyjFW6FSY51nRfynJdqtkRw/HYXRImBeLwEgMx2yPf2dH2XeSPE6OOa
         041RBf3KzY778zRISsr2XF3IKzb6zDAH3TvYY3ySmAmFMCpMGJ9wtKrWWnAUy+TnZWjn
         oOS6PjwbqB+G79cT/122Np5kymrGjYw1PD4xpKPcD2dwuEfPel6UV+fuy+bwBk7qSad+
         GoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TQNTKSrwbTOmioBUBWTo9NADf1gDtrRnG9YNSpiPFM0=;
        b=VLjqKhgRLDjkXlTXbq2uioRPGipxn9xV1p6iDniab5MF1zuE+FelkvJH9YM85/L9t0
         mfWZ+Yl11d4ZmKX+cWcmKwYdCAq8YYW4UwkUJ6I86QjJ/Yl043TynLkRYs6NuZ2FvYYZ
         kswZkQW+dItKL9juLNhLusIvTOoD9HeilZk7oq4axrN9diNeHpSFm57k9ngjrlmVSNaT
         +DL0jEAKVspaHwFRAFuipFdRKpuVhNVRE6Uyu3+g9B+eFLOsa6TofSMcFzd8MskZlTWu
         RHUl1cW4o7cfXpgJLrJCL+8Kc9vgO4PJ5dG/zonqS4wINc3M0YuQht1IBfNuvuYzdd3Q
         JANg==
X-Gm-Message-State: APjAAAVFCoF2aKRUoANenNLeyv6QmNQK6e+QrUfBUT/oauxOa2ax+u1E
        vApDFTAWczkAICEfWCQ0bGOIdw==
X-Google-Smtp-Source: APXvYqyV8QLWZG8gAPyTfVRJiYrELMT9MlTccr85MegdRgT3cyi7ebo8T73R3BPFYLPzJw9HViubDA==
X-Received: by 2002:a17:90a:148:: with SMTP id z8mr469216pje.96.1565971152710;
        Fri, 16 Aug 2019 08:59:12 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id s16sm4075821pjp.10.2019.08.16.08.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 08:59:12 -0700 (PDT)
Date:   Fri, 16 Aug 2019 08:59:11 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Toshiaki Makita <toshiaki.makita1@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, William Tu <u9012063@gmail.com>
Subject: Re: [RFC PATCH bpf-next 00/14] xdp_flow: Flow offload to XDP
Message-ID: <20190816155911.GP2820@mini-arch>
References: <20190813120558.6151-1-toshiaki.makita1@gmail.com>
 <20190814170715.GJ2820@mini-arch>
 <14c4a876-6f5d-4750-cbe4-19622f64975b@gmail.com>
 <20190815152100.GN2820@mini-arch>
 <20190815122232.4b1fa01c@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815122232.4b1fa01c@cakuba.netronome.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 08/15, Jakub Kicinski wrote:
> On Thu, 15 Aug 2019 08:21:00 -0700, Stanislav Fomichev wrote:
> > On 08/15, Toshiaki Makita wrote:
> > > On 2019/08/15 2:07, Stanislav Fomichev wrote:  
> > > > On 08/13, Toshiaki Makita wrote:  
> > > > > * Implementation
> > > > > 
> > > > > xdp_flow makes use of UMH to load an eBPF program for XDP, similar to
> > > > > bpfilter. The difference is that xdp_flow does not generate the eBPF
> > > > > program dynamically but a prebuilt program is embedded in UMH. This is
> > > > > mainly because flow insertion is considerably frequent. If we generate
> > > > > and load an eBPF program on each insertion of a flow, the latency of the
> > > > > first packet of ping in above test will incease, which I want to avoid.  
> > > > Can this be instead implemented with a new hook that will be called
> > > > for TC events? This hook can write to perf event buffer and control
> > > > plane will insert/remove/modify flow tables in the BPF maps (contol
> > > > plane will also install xdp program).
> > > > 
> > > > Why do we need UMH? What am I missing?  
> > > 
> > > So you suggest doing everything in xdp_flow kmod?  
> > You probably don't even need xdp_flow kmod. Add new tc "offload" mode
> > (bypass) that dumps every command via netlink (or calls the BPF hook
> > where you can dump it into perf event buffer) and then read that info
> > from userspace and install xdp programs and modify flow tables.
> > I don't think you need any kernel changes besides that stream
> > of data from the kernel about qdisc/tc flow creation/removal/etc.
> 
> There's a certain allure in bringing the in-kernel BPF translation
> infrastructure forward. OTOH from system architecture perspective IMHO
> it does seem like a task best handed in user space. bpfilter can replace
> iptables completely, here we're looking at an acceleration relatively
> loosely coupled with flower.
Even for bpfilter I would've solved it using something similar:
iptables bypass + redirect iptables netlink requests to some
userspace helper that was registered to be iptables compatibility
manager. And then, again, it becomes a purely userspace problem.

The issue with UMH is that the helper has to be statically compiled
from the kernel tree, which means we can't bring in any dependencies
(stuff like libkefir you mentioned below).

But I digress :-)

> FWIW Quentin spent some time working on a universal flow rule to BPF
> translation library:
> 
> https://github.com/Netronome/libkefir
> 
> A lot remains to be done there, but flower front end is one of the
> targets. A library can be tuned for any application, without a
> dependency on flower uAPI.
> 
> > But, I haven't looked at the series deeply, so I might be missing
> > something :-)
> 
> I don't think you are :)
