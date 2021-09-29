Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA5741CB22
	for <lists+bpf@lfdr.de>; Wed, 29 Sep 2021 19:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhI2Rkq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Sep 2021 13:40:46 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:55185 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244589AbhI2Rkq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Sep 2021 13:40:46 -0400
Received: by mail-wm1-f49.google.com with SMTP id s24so2456698wmh.4
        for <bpf@vger.kernel.org>; Wed, 29 Sep 2021 10:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=dbZJSfbPVtzcFkNsQWP1bAkSj3V496+aj/OYFIW1qFU=;
        b=YhR5/s4iPzo+klSl/8UDTy5sCXuqvcEinodI7pr/BV64yfHYBuh+RIDKOu4HSzAYbS
         0ksDtBWDvvTYqj1mRfUg3+VTvmMzrFOJHObe2Y+KfEwewIqd4dUR2We0XzCDEfu7XT0c
         YgeNhCb0084M8KxqcmBS0Mz6LAHmjEBTJI5QpafQOJYF5rIXQ+TxTFh8KxOR7GijPLK0
         QrkYaKUa37i7W3ImUmj8WtPym7tvKcjeIC4D8P/LpjOd+03PtQGBTohCj9wsY8a2Zm+Q
         I/7RE7BdAJjT0S1U8zZAH5dXz/Wxc49036cFo307RoQ6edRZb5ceZIMDQniizGcWJa+C
         F5tA==
X-Gm-Message-State: AOAM530laQrInM0sqbASpp/7drrOXZWmgdFMMl66NqKZQmHD3gM+cpEG
        id/qMqAaHg3Bnnz2VUIfeGU=
X-Google-Smtp-Source: ABdhPJxQ3d6DhKTk/gqmP3XbeecRb/k0saeZerFLjcUMNs2UCXW3VFX2DIJrA/Xo/I9Xp3YmgZphmg==
X-Received: by 2002:a1c:7fd0:: with SMTP id a199mr1370375wmd.20.1632937143879;
        Wed, 29 Sep 2021 10:39:03 -0700 (PDT)
Received: from localhost (mob-31-159-120-132.net.vodafone.it. [31.159.120.132])
        by smtp.gmail.com with ESMTPSA id d24sm449876wmb.35.2021.09.29.10.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 10:39:03 -0700 (PDT)
Date:   Wed, 29 Sep 2021 19:38:58 +0200
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Matteo Croce <mcroce@microsoft.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH RFC bpf-next 01/10] bpf: Prepare relo_core.c for kernel
 duty.
Message-ID: <20210929193858.57ba3cd1@linux.microsoft.com>
In-Reply-To: <CAFnufp3hx0CaF=ukCXY3UJj0omVX+5WWk0=-QuENvTPGye_sKA@mail.gmail.com>
References: <20210917215721.43491-1-alexei.starovoitov@gmail.com>
        <20210917215721.43491-2-alexei.starovoitov@gmail.com>
        <20210928164515.46fad888@linux.microsoft.com>
        <20210928163730.7v7ovjhk7kxputny@ast-mbp.dhcp.thefacebook.com>
        <20210928191103.193a9c62@linux.microsoft.com>
        <CAADnVQ+ajFPKfP+Q5WQFztfZ+05uGgbuQk3H8_9OTny=0vku=g@mail.gmail.com>
        <CAFnufp3hx0CaF=ukCXY3UJj0omVX+5WWk0=-QuENvTPGye_sKA@mail.gmail.com>
Organization: Microsoft
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 29 Sep 2021 14:32:37 +0200
Matteo Croce <mcroce@linux.microsoft.com> wrote:

> On Tue, Sep 28, 2021 at 10:35 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Sep 28, 2021 at 10:11 AM Matteo Croce
> > <mcroce@linux.microsoft.com> wrote:
> > >
> > > On Tue, 28 Sep 2021 09:37:30 -0700
> > > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > >
> > > > On Tue, Sep 28, 2021 at 04:45:15PM +0200, Matteo Croce wrote:
> > > > > On Fri, 17 Sep 2021 14:57:12 -0700
> > > > > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > > From: Alexei Starovoitov <ast@kernel.org>
> > > > > >
> > > > > > Make relo_core.c to be compiled with kernel and with libbpf.
> > > > > >
> > > > > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > > > > ---
> > > > >
> > > > > I give it a try with a sample co-re program.
> > > >
> > > > Thanks for testing!
> > > >
> > >
> > > I just found an error during the relocations.
> > > It was hiding because of bpf_core_apply_relo() always returning
> > > success[1].
> > >
> > > I have a BPF with the following programs:
> > >
> > > #if 0
> > > SEC("tp_btf/xdp_devmap_xmit")
> > > int BPF_PROG(tp_xdp_devmap_xmit_multi, const struct net_device
> > > *from_dev, const struct net_device *to_dev, int sent, int drops,
> > > int err)
> > >
> > > {
> > >         randmap(from_dev->ifindex);
> > >         return 0;
> > > }
> > > #endif
> > >
> > > SEC("fentry/eth_type_trans")
> > > int BPF_PROG(fentry_eth_type_trans, struct sk_buff *skb,
> > >              struct net_device *dev, unsigned short protocol)
> > > {
> > >         randmap(dev->ifindex + skb->len);
> > >         return 0;
> > > }
> > >
> > > SEC("fexit/eth_type_trans")
> > > int BPF_PROG(fexit_eth_type_trans, struct sk_buff *skb,
> > >              struct net_device *dev, unsigned short protocol)
> > > {
> > >         randmap(dev->ifindex + skb->len);
> > >         return 0;
> > > }
> > >
> > >
> > > randmap() just writes the value into a random map. If I keep #if 0
> > > everything works, if I remove it so to build
> > > tp_btf/xdp_devmap_xmit too, I get this:
> > >
> > > [ 3619.229378] libbpf: prog 'prog_name': relo #0: kind <byte_off>
> > > (0), spec is [24] STRUCT net_device.ifindex (0:17 @ offset 208) [
> > > 3619.229384] libbpf: prog 'prog_name': relo #0: matching
> > > candidate #0 [2617] STRUCT net_device.ifindex (0:17 @ offset 208)
> > > [ 3619.229538] libbpf: prog 'prog_name': relo #0: patched insn #0
> > > (LDX/ST/STX) off 208 -> 208 [ 3619.230278] libbpf: prog
> > > 'prog_name': relo #0: kind <byte_off> (0), spec is [87] STRUCT
> > > sk_buff.len (0:5 @ offset 104) [ 3619.230282] libbpf: prog
> > > 'prog_name': relo #0: matching candidate #0 [2660] STRUCT
> > > sk_buff.len (0:5 @ offset 104) [ 3619.230393] libbpf: prog
> > > 'prog_name': relo #0: trying to relocate unrecognized insn #0,
> > > code:0x85, src:0x0, dst:0x0, off:0x0, imm:0x7 [ 3619.230562]
> > > libbpf: prog 'prog_name': relo #0: failed to patch insn #0: -22
> > >
> > > The program in tp_btf/xdp_devmap_xmit makes the relocations into
> > > another section fail, note that sk_buff.len is used in the fentry
> > > program.
> > >
> > > Ideas?
> >
> > I'll take a look. Could you provide the full .c file?
> 
> Sure. I put everything in this repo:
> 
> https://gist.github.com/teknoraver/2855e0f8770d1363b57d683fa32bccc3
> 
> tp_btf/xdp_devmap_xmit is the program which lets the other fail.
> 

I enabled debugging in userspace libbpf to compare the two outputs.

Userspace libbpf:

libbpf: CO-RE relocating [0] struct net_device: found target candidate [2617] struct net_device in [vmlinux]
libbpf: prog 'tp_xdp_devmap_xmit_multi': relo #0: kind <byte_off> (0), spec is [24] struct net_device.ifindex (0:17 @ offset 208)
libbpf: prog 'tp_xdp_devmap_xmit_multi': relo #0: matching candidate #0 [2617] struct net_device.ifindex (0:17 @ offset 208)
libbpf: prog 'tp_xdp_devmap_xmit_multi': relo #0: patched insn #2 (LDX/ST/STX) off 208 -> 208
libbpf: prog 'tp_xdp_devmap_xmit_multi': relo #1: kind <byte_off> (0), spec is [24] struct net_device.ifindex (0:17 @ offset 208)
libbpf: prog 'tp_xdp_devmap_xmit_multi': relo #1: matching candidate #0 [2617] struct net_device.ifindex (0:17 @ offset 208)
libbpf: prog 'tp_xdp_devmap_xmit_multi': relo #1: patched insn #3 (LDX/ST/STX) off 208 -> 208
libbpf: sec 'fentry/eth_type_trans': found 2 CO-RE relocations
libbpf: CO-RE relocating [0] struct sk_buff: found target candidate [2660] struct sk_buff in [vmlinux]
libbpf: prog 'fentry_eth_type_trans': relo #0: kind <byte_off> (0), spec is [87] struct sk_buff.len (0:5 @ offset 104)
libbpf: prog 'fentry_eth_type_trans': relo #0: matching candidate #0 [2660] struct sk_buff.len (0:5 @ offset 104)
libbpf: prog 'fentry_eth_type_trans': relo #0: patched insn #2 (LDX/ST/STX) off 104 -> 104
libbpf: prog 'fentry_eth_type_trans': relo #1: kind <byte_off> (0), spec is [24] struct net_device.ifindex (0:17 @ offset 208)
libbpf: prog 'fentry_eth_type_trans': relo #1: matching candidate #0 [2617] struct net_device.ifindex (0:17 @ offset 208)
libbpf: prog 'fentry_eth_type_trans': relo #1: patched insn #3 (LDX/ST/STX) off 208 -> 208
libbpf: sec 'fexit/eth_type_trans': found 2 CO-RE relocations
libbpf: prog 'fexit_eth_type_trans': relo #0: kind <byte_off> (0), spec is [87] struct sk_buff.len (0:5 @ offset 104)
libbpf: prog 'fexit_eth_type_trans': relo #0: matching candidate #0 [2660] struct sk_buff.len (0:5 @ offset 104)
libbpf: prog 'fexit_eth_type_trans': relo #0: patched insn #2 (LDX/ST/STX) off 104 -> 104
libbpf: prog 'fexit_eth_type_trans': relo #1: kind <byte_off> (0), spec is [24] struct net_device.ifindex (0:17 @ offset 208)
libbpf: prog 'fexit_eth_type_trans': relo #1: matching candidate #0 [2617] struct net_device.ifindex (0:17 @ offset 208)
libbpf: prog 'fexit_eth_type_trans': relo #1: patched insn #3 (LDX/ST/STX) off 208 -> 208

Kernel implementation

[13234.650397] libbpf: prog 'prog_name': relo #0: kind <byte_off> (0), spec is [24] STRUCT net_device.ifindex (0:17 @ offset 208)
[13234.650406] libbpf: prog 'prog_name': relo #0: matching candidate #0 [2617] STRUCT net_device.ifindex (0:17 @ offset 208)
[13234.650558] libbpf: prog 'prog_name': relo #0: patched insn #0 (LDX/ST/STX) off 208 -> 208
[13234.651251] libbpf: prog 'prog_name': relo #0: kind <byte_off> (0), spec is [24] STRUCT net_device.ifindex (0:17 @ offset 208)
[13234.651255] libbpf: prog 'prog_name': relo #0: matching candidate #0 [2617] STRUCT net_device.ifindex (0:17 @ offset 208)
[13234.651349] libbpf: prog 'prog_name': relo #0: patched insn #0 (LDX/ST/STX) off 208 -> 208
[13234.651935] libbpf: prog 'prog_name': relo #0: kind <byte_off> (0), spec is [87] STRUCT sk_buff.len (0:5 @ offset 104)
[13234.651939] libbpf: prog 'prog_name': relo #0: matching candidate #0 [2660] STRUCT sk_buff.len (0:5 @ offset 104)
[13234.652001] libbpf: prog 'prog_name': relo #0: unexpected insn #0 (LDX/ST/STX) value: got 208, exp 104 -> 104
[13234.652105] libbpf: prog 'prog_name': relo #0: failed to patch insn #0: -22

The sk_buff.len has a wrong offset, 208 instead of 104. Can it be a
leftover value from the previous relocation?

Regards,
-- 
per aspera ad upstream
