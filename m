Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4386A804C
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2019 12:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfIDKZ0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Sep 2019 06:25:26 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39845 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfIDKZZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Sep 2019 06:25:25 -0400
Received: by mail-ot1-f65.google.com with SMTP id n7so12658663otk.6;
        Wed, 04 Sep 2019 03:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nG3/Gl4yEYJWotofdnx8KNNKr+MoKl/PK0J2xDPrapc=;
        b=Pgy1s443ZVa7y6xWQDOsFagYzMjNYXRRAG5UmX8zZ27DDZbMfD3igph7bFghLS8ygA
         HZbNWzrjWSPG6QTGZbMLMIqiNGg5qzt5zIIMv07CMpdQhrE0Kukcz7qsfbgBAKe8hSEZ
         d9OfR+D9HspB/xICarnnjj7qJ7RzM/Rpbx0nbfhh4m+isPDVAgivNK3nxp690x19VHjO
         enZAMYE25ZPNfU7ywq9l2O6kj23iEwvk8k021qju1FvXD6QZ05FwA7f3XPVPzYcEC6Gp
         tCXUE5bDBEMZclflaUEKAzlAHsiGnABEc1LawhgE79MGjMcpzar7ur0ock8n0iUI1I/t
         B0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nG3/Gl4yEYJWotofdnx8KNNKr+MoKl/PK0J2xDPrapc=;
        b=lZclZUzlAuDqI4VDJRAd6uW27FzLyfMP5WVcZzenui4DbE21KG6wA7gmeqIJV/AvFC
         KLmEMLwrOQCdQMrTm+GnXsRldNYJzDm+8jhwUKMo0TnyoaCN9rx4tKx3R7yF5mlhiGdk
         9fZMVwvlFEvTBMUoZxDjht+H7igqTjLtxiPqzD4j1OBZ7Qr61fFAaEHA0vADfi9yo30P
         pJSFd4jY/IFAvg3POywuEN+L54R8bskB+H1rCEfwZF3jTHc6eWZ6rxQb1JrrtnJoA+5V
         ASKbihuzAY8FjLJ4ZG1GsKS0Kb9BYOCFINRQQK5VlFyOoVsfARrgKKs0p6uxDCr7HTSm
         JthA==
X-Gm-Message-State: APjAAAWuygTQYSM0Lkq0prU+53JuiOWMnLnQZ/KsTIDs0Ck5ECbZNw/S
        LftB0bHDoQsAaPhK/jLBtpyLYQHA9vu4YFXPIRk=
X-Google-Smtp-Source: APXvYqwlGEQrzdMKlcF6z8QugBr53fTpNVI8uF9B/jqBlOB1JTu6Z4UX3jHuKs2HTuWp5RuhzeUAdsR7A1vsI8yWSC0=
X-Received: by 2002:a9d:6256:: with SMTP id i22mr4758536otk.139.1567592724601;
 Wed, 04 Sep 2019 03:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <1554792253-27081-1-git-send-email-magnus.karlsson@intel.com>
 <1554792253-27081-3-git-send-email-magnus.karlsson@intel.com>
 <xunyo9007hk9.fsf@redhat.com> <CAJ8uoz2LEun-bjUYQKZdx9NbLBOSRGsZZTWAp10=vhiP7Dms9g@mail.gmail.com>
 <xunyftlc7dn8.fsf@redhat.com>
In-Reply-To: <xunyftlc7dn8.fsf@redhat.com>
From:   Magnus Karlsson <magnus.karlsson@gmail.com>
Date:   Wed, 4 Sep 2019 12:25:13 +0200
Message-ID: <CAJ8uoz3jhr+VUmtjotW07mnDkYLgOYYO2HpV9hOv3i8B4=Z_CQ@mail.gmail.com>
Subject: Re: [PATCH bpf 2/2] libbpf: remove dependency on barrier.h in xsk.h
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     Magnus Karlsson <magnus.karlsson@intel.com>,
        bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 4, 2019 at 8:56 AM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> Hi, Magnus!
>
> >>>>> On Wed, 4 Sep 2019 08:39:24 +0200, Magnus Karlsson  wrote:
>
>  > On Wed, Sep 4, 2019 at 7:32 AM Yauheni Kaliuta
>  > <yauheni.kaliuta@redhat.com> wrote:
>  >>
>  >> Hi, Magnus!
>  >>
>  >> >>>>> On Tue,  9 Apr 2019 08:44:13 +0200, Magnus Karlsson  wrote:
>  >>
>  >> > The use of smp_rmb() and smp_wmb() creates a Linux header dependency
>  >> > on barrier.h that is uneccessary in most parts. This patch implements
>  >> > the two small defines that are needed from barrier.h. As a bonus, the
>  >> > new implementations are faster than the default ones as they default
>  >> > to sfence and lfence for x86, while we only need a compiler barrier in
>  >> > our case. Just as it is when the same ring access code is compiled in
>  >> > the kernel.
>  >>
>  >> > Fixes: 1cad07884239 ("libbpf: add support for using AF_XDP sockets")
>  >> > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
>  >> > ---
>  >> >  tools/lib/bpf/xsk.h | 19 +++++++++++++++++--
>  >> >  1 file changed, 17 insertions(+), 2 deletions(-)
>  >>
>  >> > diff --git a/tools/lib/bpf/xsk.h b/tools/lib/bpf/xsk.h
>  >> > index 3638147..317b44f 100644
>  >> > --- a/tools/lib/bpf/xsk.h
>  >> > +++ b/tools/lib/bpf/xsk.h
>  >> > @@ -39,6 +39,21 @@ DEFINE_XSK_RING(xsk_ring_cons);
>  >> >  struct xsk_umem;
>  >> >  struct xsk_socket;
>  >>
>  >> > +#if !defined bpf_smp_rmb && !defined bpf_smp_wmb
>  >> > +# if defined(__i386__) || defined(__x86_64__)
>  >> > +#  define bpf_smp_rmb() asm volatile("" : : : "memory")
>  >> > +#  define bpf_smp_wmb() asm volatile("" : : : "memory")
>  >> > +# elif defined(__aarch64__)
>  >> > +#  define bpf_smp_rmb() asm volatile("dmb ishld" : : : "memory")
>  >> > +#  define bpf_smp_wmb() asm volatile("dmb ishst" : : : "memory")
>  >> > +# elif defined(__arm__)
>  >> > +#  define bpf_smp_rmb() asm volatile("dmb ish" : : : "memory")
>  >> > +#  define bpf_smp_wmb() asm volatile("dmb ishst" : : : "memory")
>  >> > +# else
>  >> > +#  error Architecture not supported by the XDP socket code in libbpf.
>  >> > +# endif
>  >> > +#endif
>  >> > +
>  >>
>  >> What about other architectures then?
>
>  > AF_XDP has not been tested on anything else, as far as I
>  > know. But contributions that extend it to more archs are very
>  > welcome.
>
> Well, I'll may be try to fetch something from barrier.h's (since
> I cannot consider myself as a specialist in the area), but at the
> moment the patch breaks the build on that arches.

Do you have a specific architecture in mind and do you have some
board/server (of that architecture) you could test AF_XDP on?

>  > /Magnus
>
>  >>
>  >> >  static inline __u64 *xsk_ring_prod__fill_addr(struct xsk_ring_prod *fill,
>  >> >                                            __u32 idx)
>  >> >  {
>  >> > @@ -119,7 +134,7 @@ static inline void xsk_ring_prod__submit(struct xsk_ring_prod *prod, size_t nb)
>  >> >      /* Make sure everything has been written to the ring before signalling
>  >> >       * this to the kernel.
>  >> >       */
>  >> > -    smp_wmb();
>  >> > +    bpf_smp_wmb();
>  >>
>  >> >      *prod->producer += nb;
>  >> >  }
>  >> > @@ -133,7 +148,7 @@ static inline size_t xsk_ring_cons__peek(struct xsk_ring_cons *cons,
>  >> >              /* Make sure we do not speculatively read the data before
>  >> >               * we have received the packet buffers from the ring.
>  >> >               */
>  >> > -            smp_rmb();
>  >> > +            bpf_smp_rmb();
>  >>
>  >> >              *idx = cons->cached_cons;
>  cons-> cached_cons += entries;
>  >> > --
>  >> > 2.7.4
>  >>
>  >>
>  >> --
>  >> WBR,
>  >> Yauheni Kaliuta
>
> --
> WBR,
> Yauheni Kaliuta
