Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF70923C060
	for <lists+bpf@lfdr.de>; Tue,  4 Aug 2020 22:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgHDUCZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Aug 2020 16:02:25 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59055 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725922AbgHDUCY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 4 Aug 2020 16:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596571343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TBGYBTefvDF/EV7XyaKQoqy126e+fsX2WYDMeF/iWc0=;
        b=PAQ58z5UqPRAJ0sS7ZgUUHJeTb1NRdCkV/HYWK4udDv20IlGf//gc5T74LxmRci9rXJ5e5
        jgsZv1/VdKBcwyF5Gar60TNU2BKWnfwag+TwEkRD3FELfLAnvrep33ogS8BToE/C7RhKD0
        QED/Xe1hWcMuujlD7t2RPgVwZWXMIio=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-hXmaKyOYNAS6jAdENxKXQA-1; Tue, 04 Aug 2020 16:02:20 -0400
X-MC-Unique: hXmaKyOYNAS6jAdENxKXQA-1
Received: by mail-wm1-f69.google.com with SMTP id u14so1223532wml.0
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2020 13:02:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TBGYBTefvDF/EV7XyaKQoqy126e+fsX2WYDMeF/iWc0=;
        b=CptznTSNTbfzV87yxJ8tbb3A75pkBWhanZ56Lw+osPftfQTbv4d6wuuKN34nB4ez3t
         tgS3KC9c95FyWhFHeMGFcDDJ7PfmdPBsuUYjLZhSNtEuv8QIxH3HQpi8MWA2LPmJPOM2
         +39kDTlsSsDELvi0G7wjI+6iuJ6f8uqBBLCCXVEXLyiawhbVJ0b1FpTfbbRj4JlO0nBn
         mIR/19/A3dlaJdFmP0CDADCysqPfZ+QFB1O3L4xtbYjM+8mthA6/UzaXlABjx4iYyfNn
         MKuBxDisliejAwmeW6CKjGGTobNaOUDVlSmP2n1Kf0AWs0jEJBEg+5k7oTKXWmSUTnaj
         gJbw==
X-Gm-Message-State: AOAM533yJwvsg/GOn7wvx+RpCC3uPVJjAtfczhsm3UVCrnSIP1gVi8b4
        3f1/A/LTBy+cDCjw1HWFoA+sw360DMHs6CgQoL4AHSDwtjkr5Hu6o10P7OdX73GBJra950Q51jK
        KqyhVW0aN3iF85EVQawH8mAkWQLIr
X-Received: by 2002:a7b:cc0b:: with SMTP id f11mr83255wmh.79.1596571338918;
        Tue, 04 Aug 2020 13:02:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKIvyCUNpj9/8NrB0zS6IzgM1ygGo5HGFwMtFt3moyhOLn1bnkvSV6pT7FlItzSXgJl+VCEYjdcgA7lN0qyF8=
X-Received: by 2002:a7b:cc0b:: with SMTP id f11mr83176wmh.79.1596571337741;
 Tue, 04 Aug 2020 13:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <CANoWsw=4H1bHNmDP1GDo+wROCyZiZwFr-LPwoeZcWss2tJ-MNQ@mail.gmail.com>
 <7fb300731582d6c9a61e5de952c94720c5a62c3b.camel@linux.ibm.com>
In-Reply-To: <7fb300731582d6c9a61e5de952c94720c5a62c3b.camel@linux.ibm.com>
From:   Yauheni Kaliuta <ykaliuta@redhat.com>
Date:   Tue, 4 Aug 2020 23:02:01 +0300
Message-ID: <CANoWsw=Fz_MmOinvFmPo+=vQ-dNEku-FLY=AEN4sn3HFNkGN-g@mail.gmail.com>
Subject: Re: s390 test_bpf: #284 BPF_MAXINSNS: Maximum possible literals failure
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>, Jiri Olsa <jolsa@redhat.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi!

On Tue, Aug 4, 2020 at 10:44 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Tue, 2020-08-04 at 20:40 +0300, Yauheni Kaliuta wrote:
> > Hi!
> >
> > I have a failure (crash) of selftests/bpf/test_kmod.sh on s390.
> >
> > The problem comes with loading with
> >
> > sysctl -w net.core.bpf_jit_harden=2
> >
> > In that case the program (lib/test_bpf.c):
> >
> > static int bpf_fill_maxinsns1(struct bpf_test *self)
> > {
> >     unsigned int len = BPF_MAXINSNS;
> >     struct sock_filter *insn;
> >     __u32 k = ~0;
> >     int i;
> >
> >     insn = kmalloc_array(len, sizeof(*insn), GFP_KERNEL);
> >     if (!insn)
> >         return -ENOMEM;
> >
> >     for (i = 0; i < len; i++, k--)
> >         insn[i] = __BPF_STMT(BPF_RET | BPF_K, k);
> >
> >     self->u.ptr.insns = insn;
> >     self->u.ptr.len = len;
> >
> >     return 0;
> > }
> >
> > after blinding and jiting is 98362 bytes for me and it does not fit
> > 16bit offset for BRC 15,.. command where BPF_EXIT | BPF_JMP is
> > translated.
> >
> > What is the easiest way to use BRCL for large offset here?
> >
> > Thanks!
>
> Hi Yauheni!
>
> Did you try bpf-next, specifically with commit 5fa6974471c5 ("s390/bpf:
> Use brcl for jumping to exit_ip if necessary")? This was supposed to
> fix this problem.

Ah, thanks a lot! I missed it.

-- 
WBR, Yauheni

