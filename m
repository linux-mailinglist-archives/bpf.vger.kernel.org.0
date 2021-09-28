Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9273341B868
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 22:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242712AbhI1Ugt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 16:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242443AbhI1Ugs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Sep 2021 16:36:48 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EE7C06161C
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 13:35:08 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 133so346650pgb.1
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 13:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ot1fClub1XcfID1Zr5iahTFnc74rW+h39srPwXD1les=;
        b=Q+3VIm+11MTfaoYeboFa8C9GdjWlErhPn8RIPvU56LkSrvgDjoTZxMmyTmBX5hHGPh
         r7+ESlGgjwZlBtkkUtt/rdSzIvCc61imNU4S3D26Sheahvt303oy4abJlaKqszOx0AAw
         YYR5rs4Co82qQnKHQEQjCZoeADYJXC3pkpNj3ukrpNI9zvdudwujjgO+qYUMePFYBtJm
         axYX0JjxxZ6ZD4ladbPq7bgLsCE4bymSFFLSBNzdYElL12wz+y8ZWwzHJtoawopy5tSA
         jNPiezGPMh2lUMCYFrLOwhMzBC8hX6NU/6TdEUF3KHBRzLW+ejwc4KAH2CaCT3d9oeNX
         uEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ot1fClub1XcfID1Zr5iahTFnc74rW+h39srPwXD1les=;
        b=Bn2wWk8YOSPp8fOOxeB8uky5lttSFov7/WBmPxZssQrLbdvsBr1zuYCwK2g9ayGDWj
         lTl9yowSEj4INjBQAoErUIXHVYnz1FbdzTMSIAZLhPsq1f8gCW8dZQ0pkOb396eU2JPr
         MdvJtV53B88UnbGl4p3Fb+5cs1s/Gfu1zeDcdq4nrOauskWkEdP4O0tg3GWeThZdiLgx
         MZ1rQTepHdr95TfcZJtgvkGeXO26/gFRE2p9rYjP3YiKm0nYnOVqznJZOWNfX0RLxlRx
         3L6EvsKQr3CeE/ba/5dA6Jm+vt8vVA0U5kQ2V81RoOMJPV5i4uRD/7u3rwr90VLvyZg5
         9eiA==
X-Gm-Message-State: AOAM533l8V1WcJNCZ93TyUzOwiAZXt33XktHFiAhWTRqdqFtx0LsDxuu
        dFYRFL4yB6DIDjBxqtEOSFYvRvdWsnSUF8G0hCI=
X-Google-Smtp-Source: ABdhPJxHTtwh5scI+U4WsWrXhs0ECwnLqyMKm1dAWHt3zVDvBYqgdElzvAzUKV1uGxVpigK0trkiwxIWJ+qhst9rCOU=
X-Received: by 2002:a65:4008:: with SMTP id f8mr6232866pgp.310.1632861308251;
 Tue, 28 Sep 2021 13:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210917215721.43491-1-alexei.starovoitov@gmail.com>
 <20210917215721.43491-2-alexei.starovoitov@gmail.com> <20210928164515.46fad888@linux.microsoft.com>
 <20210928163730.7v7ovjhk7kxputny@ast-mbp.dhcp.thefacebook.com> <20210928191103.193a9c62@linux.microsoft.com>
In-Reply-To: <20210928191103.193a9c62@linux.microsoft.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 28 Sep 2021 13:34:56 -0700
Message-ID: <CAADnVQ+ajFPKfP+Q5WQFztfZ+05uGgbuQk3H8_9OTny=0vku=g@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 01/10] bpf: Prepare relo_core.c for kernel duty.
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>, mcroce@microsoft.com,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 28, 2021 at 10:11 AM Matteo Croce
<mcroce@linux.microsoft.com> wrote:
>
> On Tue, 28 Sep 2021 09:37:30 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > On Tue, Sep 28, 2021 at 04:45:15PM +0200, Matteo Croce wrote:
> > > On Fri, 17 Sep 2021 14:57:12 -0700
> > > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > >
> > > > From: Alexei Starovoitov <ast@kernel.org>
> > > >
> > > > Make relo_core.c to be compiled with kernel and with libbpf.
> > > >
> > > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > > ---
> > >
> > > I give it a try with a sample co-re program.
> >
> > Thanks for testing!
> >
>
> I just found an error during the relocations.
> It was hiding because of bpf_core_apply_relo() always returning
> success[1].
>
> I have a BPF with the following programs:
>
> #if 0
> SEC("tp_btf/xdp_devmap_xmit")
> int BPF_PROG(tp_xdp_devmap_xmit_multi, const struct net_device *from_dev,
>              const struct net_device *to_dev, int sent, int drops, int err)
>
> {
>         randmap(from_dev->ifindex);
>         return 0;
> }
> #endif
>
> SEC("fentry/eth_type_trans")
> int BPF_PROG(fentry_eth_type_trans, struct sk_buff *skb,
>              struct net_device *dev, unsigned short protocol)
> {
>         randmap(dev->ifindex + skb->len);
>         return 0;
> }
>
> SEC("fexit/eth_type_trans")
> int BPF_PROG(fexit_eth_type_trans, struct sk_buff *skb,
>              struct net_device *dev, unsigned short protocol)
> {
>         randmap(dev->ifindex + skb->len);
>         return 0;
> }
>
>
> randmap() just writes the value into a random map. If I keep #if 0
> everything works, if I remove it so to build tp_btf/xdp_devmap_xmit
> too, I get this:
>
> [ 3619.229378] libbpf: prog 'prog_name': relo #0: kind <byte_off> (0), spec is [24] STRUCT net_device.ifindex (0:17 @ offset 208)
> [ 3619.229384] libbpf: prog 'prog_name': relo #0: matching candidate #0 [2617] STRUCT net_device.ifindex (0:17 @ offset 208)
> [ 3619.229538] libbpf: prog 'prog_name': relo #0: patched insn #0 (LDX/ST/STX) off 208 -> 208
> [ 3619.230278] libbpf: prog 'prog_name': relo #0: kind <byte_off> (0), spec is [87] STRUCT sk_buff.len (0:5 @ offset 104)
> [ 3619.230282] libbpf: prog 'prog_name': relo #0: matching candidate #0 [2660] STRUCT sk_buff.len (0:5 @ offset 104)
> [ 3619.230393] libbpf: prog 'prog_name': relo #0: trying to relocate unrecognized insn #0, code:0x85, src:0x0, dst:0x0, off:0x0, imm:0x7
> [ 3619.230562] libbpf: prog 'prog_name': relo #0: failed to patch insn #0: -22
>
> The program in tp_btf/xdp_devmap_xmit makes the relocations into
> another section fail, note that sk_buff.len is used in the fentry
> program.
>
> Ideas?

I'll take a look. Could you provide the full .c file?
