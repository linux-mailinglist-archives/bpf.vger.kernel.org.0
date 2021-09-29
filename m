Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE36841C4CE
	for <lists+bpf@lfdr.de>; Wed, 29 Sep 2021 14:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343784AbhI2Mez (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Sep 2021 08:34:55 -0400
Received: from linux.microsoft.com ([13.77.154.182]:49076 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343827AbhI2Mez (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Sep 2021 08:34:55 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by linux.microsoft.com (Postfix) with ESMTPSA id E9FFA20B87E7
        for <bpf@vger.kernel.org>; Wed, 29 Sep 2021 05:33:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E9FFA20B87E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1632918793;
        bh=p0tD+3/7lp5hqBehyNvfvjWJu6L+1QRqmCKMMhT5qvU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IFkoozB6ttY1/i1VnkZ8UO/Ofnsn3oDE7wHiDfCcIf6rGf8Ba/tyCLzd13djij698
         YeYtWdYChQpya9sge/rgM1qXaB7L8XdZJgDT9y93TwGPNSEe5rDgPoGQWJAoz67cgm
         C9TrMrTwdXm5MDD13AeDNqFcGh16hNY5MNP/iR9g=
Received: by mail-pl1-f173.google.com with SMTP id j14so1410886plx.4
        for <bpf@vger.kernel.org>; Wed, 29 Sep 2021 05:33:13 -0700 (PDT)
X-Gm-Message-State: AOAM531nwx3vYOxet6C4HdN2VECdZD4vNCs5nCbtYWL7hbL9GGAlfMXi
        A3pGE1WsYAEJyxhG/ypAAudfg2M17NUl1DALgAE=
X-Google-Smtp-Source: ABdhPJzoHS5a9QPX4Raq9RB+10mLXS3hb6bWz+Abh5Nl6EKQ7t+PiPNCy6TGXwm6PNUcrAPrU8qQCWl9OKq6mx5rTp8=
X-Received: by 2002:a17:90b:1883:: with SMTP id mn3mr6050988pjb.112.1632918793444;
 Wed, 29 Sep 2021 05:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210917215721.43491-1-alexei.starovoitov@gmail.com>
 <20210917215721.43491-2-alexei.starovoitov@gmail.com> <20210928164515.46fad888@linux.microsoft.com>
 <20210928163730.7v7ovjhk7kxputny@ast-mbp.dhcp.thefacebook.com>
 <20210928191103.193a9c62@linux.microsoft.com> <CAADnVQ+ajFPKfP+Q5WQFztfZ+05uGgbuQk3H8_9OTny=0vku=g@mail.gmail.com>
In-Reply-To: <CAADnVQ+ajFPKfP+Q5WQFztfZ+05uGgbuQk3H8_9OTny=0vku=g@mail.gmail.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Wed, 29 Sep 2021 14:32:37 +0200
X-Gmail-Original-Message-ID: <CAFnufp3hx0CaF=ukCXY3UJj0omVX+5WWk0=-QuENvTPGye_sKA@mail.gmail.com>
Message-ID: <CAFnufp3hx0CaF=ukCXY3UJj0omVX+5WWk0=-QuENvTPGye_sKA@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 01/10] bpf: Prepare relo_core.c for kernel duty.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Matteo Croce <mcroce@microsoft.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 28, 2021 at 10:35 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Sep 28, 2021 at 10:11 AM Matteo Croce
> <mcroce@linux.microsoft.com> wrote:
> >
> > On Tue, 28 Sep 2021 09:37:30 -0700
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> >
> > > On Tue, Sep 28, 2021 at 04:45:15PM +0200, Matteo Croce wrote:
> > > > On Fri, 17 Sep 2021 14:57:12 -0700
> > > > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > > From: Alexei Starovoitov <ast@kernel.org>
> > > > >
> > > > > Make relo_core.c to be compiled with kernel and with libbpf.
> > > > >
> > > > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > > > ---
> > > >
> > > > I give it a try with a sample co-re program.
> > >
> > > Thanks for testing!
> > >
> >
> > I just found an error during the relocations.
> > It was hiding because of bpf_core_apply_relo() always returning
> > success[1].
> >
> > I have a BPF with the following programs:
> >
> > #if 0
> > SEC("tp_btf/xdp_devmap_xmit")
> > int BPF_PROG(tp_xdp_devmap_xmit_multi, const struct net_device *from_dev,
> >              const struct net_device *to_dev, int sent, int drops, int err)
> >
> > {
> >         randmap(from_dev->ifindex);
> >         return 0;
> > }
> > #endif
> >
> > SEC("fentry/eth_type_trans")
> > int BPF_PROG(fentry_eth_type_trans, struct sk_buff *skb,
> >              struct net_device *dev, unsigned short protocol)
> > {
> >         randmap(dev->ifindex + skb->len);
> >         return 0;
> > }
> >
> > SEC("fexit/eth_type_trans")
> > int BPF_PROG(fexit_eth_type_trans, struct sk_buff *skb,
> >              struct net_device *dev, unsigned short protocol)
> > {
> >         randmap(dev->ifindex + skb->len);
> >         return 0;
> > }
> >
> >
> > randmap() just writes the value into a random map. If I keep #if 0
> > everything works, if I remove it so to build tp_btf/xdp_devmap_xmit
> > too, I get this:
> >
> > [ 3619.229378] libbpf: prog 'prog_name': relo #0: kind <byte_off> (0), spec is [24] STRUCT net_device.ifindex (0:17 @ offset 208)
> > [ 3619.229384] libbpf: prog 'prog_name': relo #0: matching candidate #0 [2617] STRUCT net_device.ifindex (0:17 @ offset 208)
> > [ 3619.229538] libbpf: prog 'prog_name': relo #0: patched insn #0 (LDX/ST/STX) off 208 -> 208
> > [ 3619.230278] libbpf: prog 'prog_name': relo #0: kind <byte_off> (0), spec is [87] STRUCT sk_buff.len (0:5 @ offset 104)
> > [ 3619.230282] libbpf: prog 'prog_name': relo #0: matching candidate #0 [2660] STRUCT sk_buff.len (0:5 @ offset 104)
> > [ 3619.230393] libbpf: prog 'prog_name': relo #0: trying to relocate unrecognized insn #0, code:0x85, src:0x0, dst:0x0, off:0x0, imm:0x7
> > [ 3619.230562] libbpf: prog 'prog_name': relo #0: failed to patch insn #0: -22
> >
> > The program in tp_btf/xdp_devmap_xmit makes the relocations into
> > another section fail, note that sk_buff.len is used in the fentry
> > program.
> >
> > Ideas?
>
> I'll take a look. Could you provide the full .c file?

Sure. I put everything in this repo:

https://gist.github.com/teknoraver/2855e0f8770d1363b57d683fa32bccc3

tp_btf/xdp_devmap_xmit is the program which lets the other fail.

-- 
per aspera ad upstream
