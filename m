Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF5941B4C1
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 19:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241896AbhI1RMw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 13:12:52 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:40766 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241894AbhI1RMv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Sep 2021 13:12:51 -0400
Received: by mail-ed1-f48.google.com with SMTP id g8so86142349edt.7
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 10:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=p1wNAM4+f+aaRBd6mJPLY1uvEqZBEySfb01zcTj8LOA=;
        b=srNrsZRjTho8ZLvsYEhwiyXBJAJTqA6lEUcOIT8D3JGhxvf2bJW+4N+matJ5U/9th3
         5Az7jrFOttqmiAtY5T4sRYtPL55VL0OBlmdhNarJxCFO62y4at5IfI60xiTTGk4ghalC
         gva0SbBkdlCMCKFCEWJSUxzzq82bpeJTIkPxUi/weNa/mRkPL9+DzExNaSbgwvKDwm5C
         MmC7cINqKYaKJUJhfMch6yg6p4OqCT+to4x6VTytIk94EDPGoCiIo/82GRt5ipS55/LH
         7am4no4ptUqknM+/oWxYAj94Y9G73u3nT5J8Tlkuk0/LKB40kYy2MswLBM0obza25lH4
         5+Vg==
X-Gm-Message-State: AOAM533S4J2WcTBDMC5/mmt6MA9vkyRLg4R0UpSqCGIc1MyNgQp9lJ3w
        xWiwhzlt+3o+TRmNE6VLBVo=
X-Google-Smtp-Source: ABdhPJwYzaiGoeFsS1LGt1NJVvFH8TgtZKcLd27CB2uebOdJOdUie4iV/pGqrl0SmzKv0uFULHZwjw==
X-Received: by 2002:a05:6402:1c8f:: with SMTP id cy15mr8684238edb.41.1632849070351;
        Tue, 28 Sep 2021 10:11:10 -0700 (PDT)
Received: from localhost (mob-31-159-58-194.net.vodafone.it. [31.159.58.194])
        by smtp.gmail.com with ESMTPSA id f10sm4320497edu.70.2021.09.28.10.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 10:11:09 -0700 (PDT)
Date:   Tue, 28 Sep 2021 19:11:03 +0200
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        john.fastabend@gmail.com, lmb@cloudflare.com, mcroce@microsoft.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH RFC bpf-next 01/10] bpf: Prepare relo_core.c for kernel
 duty.
Message-ID: <20210928191103.193a9c62@linux.microsoft.com>
In-Reply-To: <20210928163730.7v7ovjhk7kxputny@ast-mbp.dhcp.thefacebook.com>
References: <20210917215721.43491-1-alexei.starovoitov@gmail.com>
        <20210917215721.43491-2-alexei.starovoitov@gmail.com>
        <20210928164515.46fad888@linux.microsoft.com>
        <20210928163730.7v7ovjhk7kxputny@ast-mbp.dhcp.thefacebook.com>
Organization: Microsoft
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 28 Sep 2021 09:37:30 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Tue, Sep 28, 2021 at 04:45:15PM +0200, Matteo Croce wrote:
> > On Fri, 17 Sep 2021 14:57:12 -0700
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > 
> > > From: Alexei Starovoitov <ast@kernel.org>
> > > 
> > > Make relo_core.c to be compiled with kernel and with libbpf.
> > > 
> > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > ---
> > 
> > I give it a try with a sample co-re program.
> 
> Thanks for testing!
> 

I just found an error during the relocations.
It was hiding because of bpf_core_apply_relo() always returning
success[1].

I have a BPF with the following programs:

#if 0
SEC("tp_btf/xdp_devmap_xmit")
int BPF_PROG(tp_xdp_devmap_xmit_multi, const struct net_device *from_dev,
             const struct net_device *to_dev, int sent, int drops, int err)

{
        randmap(from_dev->ifindex);
        return 0;
}
#endif

SEC("fentry/eth_type_trans")
int BPF_PROG(fentry_eth_type_trans, struct sk_buff *skb,
             struct net_device *dev, unsigned short protocol)
{
        randmap(dev->ifindex + skb->len);
        return 0;
}

SEC("fexit/eth_type_trans")
int BPF_PROG(fexit_eth_type_trans, struct sk_buff *skb,
             struct net_device *dev, unsigned short protocol)
{
        randmap(dev->ifindex + skb->len);
        return 0;
}


randmap() just writes the value into a random map. If I keep #if 0
everything works, if I remove it so to build tp_btf/xdp_devmap_xmit
too, I get this:

[ 3619.229378] libbpf: prog 'prog_name': relo #0: kind <byte_off> (0), spec is [24] STRUCT net_device.ifindex (0:17 @ offset 208)
[ 3619.229384] libbpf: prog 'prog_name': relo #0: matching candidate #0 [2617] STRUCT net_device.ifindex (0:17 @ offset 208)
[ 3619.229538] libbpf: prog 'prog_name': relo #0: patched insn #0 (LDX/ST/STX) off 208 -> 208
[ 3619.230278] libbpf: prog 'prog_name': relo #0: kind <byte_off> (0), spec is [87] STRUCT sk_buff.len (0:5 @ offset 104)
[ 3619.230282] libbpf: prog 'prog_name': relo #0: matching candidate #0 [2660] STRUCT sk_buff.len (0:5 @ offset 104)
[ 3619.230393] libbpf: prog 'prog_name': relo #0: trying to relocate unrecognized insn #0, code:0x85, src:0x0, dst:0x0, off:0x0, imm:0x7
[ 3619.230562] libbpf: prog 'prog_name': relo #0: failed to patch insn #0: -22

The program in tp_btf/xdp_devmap_xmit makes the relocations into
another section fail, note that sk_buff.len is used in the fentry
program.

Ideas?

[1] https://lore.kernel.org/bpf/20210927200410.460e014f@linux.microsoft.com/

Regards,
-- 
per aspera ad upstream
