Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 792011954B8
	for <lists+bpf@lfdr.de>; Fri, 27 Mar 2020 11:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgC0KDK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Mar 2020 06:03:10 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:41771 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgC0KDJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Mar 2020 06:03:09 -0400
Received: by mail-oi1-f170.google.com with SMTP id k9so8263221oia.8
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2020 03:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Z6DiYcAhBZf/nevFbYm9Xop0DNLHOT9IeSyDtGfyEU=;
        b=mJkm6xUAm+FFpg3i+w7HSS9mIvckax758oLu9zBiu0V3WN4HdbXbcWcHce2O95hexy
         aobUFd4PjjV77H9N7VYhubFH69YcWdFXlPKds8Ry8r0j2A7FhKESLMRP41DtGGWrGqsx
         9TfUr3C/S0fvSaWi1sGoNR+mo3hqpN7nn3fvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Z6DiYcAhBZf/nevFbYm9Xop0DNLHOT9IeSyDtGfyEU=;
        b=QC/x0y9j5qecCg6F3HxrvQrFqzXcWQEaqqt+XbR5foHrDR46xP5R/pAWER3pAy/RVi
         hZwx+RXZA8ZDW93QgOmiXwj5m8WpGTDPQCZUl7O1jK9n0qLM3WUJ/sp7Pk/1RfWlNE66
         j6Vbq+fHEbM2EeeOLwJjVzqV1nMOorbIcR/s4SlRDXa1eh2Mnn07L/4vpEh74SbhGm7y
         k5teN4aDH7XVB7IL2R7bGc/fU4QYKHsb+vQFzrGdFaPn+EERyJjFsRXBP2sjsoJT1om/
         YWVNknoCyeQkBtD1SeGgMrpRKOHIaytxRX3qtsiagp2c22HAHPtrb48YasstoqiLBVVS
         k1Gw==
X-Gm-Message-State: ANhLgQ2FwIIjc4fCxJd6wYjo5CDDqMNQEGlV7XnpQqBCUdM/vgn65PSu
        8BOLulBfbaa82sdapHuKNWISogRTX4R6/YEEu5MBYg==
X-Google-Smtp-Source: ADFU+vtEXpmXWXE625A9DpAxXZ0XHW0DYZGxMuRTSt6f9szWc+jYAMRnGEtygM8I5C1nB40q8Urg2gb2WcdVaZ7b64w=
X-Received: by 2002:a54:410c:: with SMTP id l12mr3427916oic.13.1585303386802;
 Fri, 27 Mar 2020 03:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200325055745.10710-1-joe@wand.net.nz> <20200325055745.10710-6-joe@wand.net.nz>
 <82e8d147-b334-3d29-0312-7b087ac908f3@fb.com> <CACAyw99Eeu+=yD8UKazRJcknZi3D5zMJ4n=FVsxXi63DwhdxYA@mail.gmail.com>
 <20200326210719.den5isqxntnoqhmv@ast-mbp>
In-Reply-To: <20200326210719.den5isqxntnoqhmv@ast-mbp>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Fri, 27 Mar 2020 10:02:55 +0000
Message-ID: <CACAyw9_jv3eJz8eRRBOvWEc4=BM0_tRuQCz_fLKsVLTid7tCDA@mail.gmail.com>
Subject: Re: call for bpf progs. Re: [PATCHv2 bpf-next 5/5] selftests: bpf:
 add test for sk_assign
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, Joe Stringer <joe@wand.net.nz>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Martin Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 26 Mar 2020 at 21:07, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Mar 26, 2020 at 10:13:31AM +0000, Lorenz Bauer wrote:
> > > > +
> > > > +     if (ipv4) {
> > > > +             if (tuple->ipv4.dport != bpf_htons(4321))
> > > > +                     return TC_ACT_OK;
> > > > +
> > > > +             ln.ipv4.daddr = bpf_htonl(0x7f000001);
> > > > +             ln.ipv4.dport = bpf_htons(1234);
> > > > +
> > > > +             sk = bpf_skc_lookup_tcp(skb, &ln, sizeof(ln.ipv4),
> > > > +                                     BPF_F_CURRENT_NETNS, 0);
> > > > +     } else {
> > > > +             if (tuple->ipv6.dport != bpf_htons(4321))
> > > > +                     return TC_ACT_OK;
> > > > +
> > > > +             /* Upper parts of daddr are already zero. */
> > > > +             ln.ipv6.daddr[3] = bpf_htonl(0x1);
> > > > +             ln.ipv6.dport = bpf_htons(1234);
> > > > +
> > > > +             sk = bpf_skc_lookup_tcp(skb, &ln, sizeof(ln.ipv6),
> > > > +                                     BPF_F_CURRENT_NETNS, 0);
> > > > +     }
> > > > +
> > > > +     /* We can't do a single skc_lookup_tcp here, because then the compiler
> > > > +      * will likely spill tuple_len to the stack. This makes it lose all
> > > > +      * bounds information in the verifier, which then rejects the call as
> > > > +      * unsafe.
> > > > +      */
> > >
> > > This is a known issue. For scalars, only constant is restored properly
> > > in verifier at this moment. I did some hacking before to enable any
> > > scalars. The fear is this will make pruning performs worse. More
> > > study is needed here.
> >
> > Of topic, but: this is actually one of the most challenging issues for
> > us when writing
> > BPF. It forces us to have very deep call graphs to hopefully avoid clang
> > spilling the constants. Please let me know if I can help in any way.
>
> Thanks for bringing this up.
> Yonghong, please correct me if I'm wrong.
> I think you've experimented with tracking spilled constants. The first issue
> came with spilling of 4 byte constant. The verifier tracks 8 byte slots and
> lots of places assume that slot granularity. It's not clear yet how to refactor
> the verifier. Ideas, help are greatly appreciated.
> The second concern was pruning, but iirc the experiments were inconclusive.
> selftests/bpf only has old fb progs. Hence, I think, the step zero is for
> everyone to contribute their bpf programs written in C. If we have both
> cilium and cloudflare progs as selftests it will help a lot to guide such long
> lasting verifier decisions.

Ok, I'll try to get something sorted out. We have a TC classifier that
would be suitable,
and I've been meaning to get it open sourced. Does the integration into the
test suite have to involve running packets through it, or is compile
and load enough?

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
