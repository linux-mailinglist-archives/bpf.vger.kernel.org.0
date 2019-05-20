Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B70A23F4F
	for <lists+bpf@lfdr.de>; Mon, 20 May 2019 19:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393035AbfETRoS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 20 May 2019 13:44:18 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42331 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392996AbfETRoP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 May 2019 13:44:15 -0400
Received: by mail-lf1-f67.google.com with SMTP id y13so10946863lfh.9
        for <bpf@vger.kernel.org>; Mon, 20 May 2019 10:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YCwqCrxUh2bH8XiEOdKZb9nS1aVmthT0KjuGZ5SGeWg=;
        b=Te4tABbroAThF+vCzoik4COjybNwWTAAAS7Y11ITKA3//TLkVziR9uM8n+NIiN5tm5
         3uOxJmqg6U4zqda6EuM+ZfB2pVF63UoB5Ncfg3U8TxVh+JSr0y6gY98LA/Gw3Svsoq82
         i0i46f75CLTRHkOsO8x/VRI/ahOmvXjWiX42QAWj2kF2jR4PJ/0BGOQhR1NngMqxNEeC
         d+xgd1JWHl7tpZOvy6zu76Vare+c+Xnd022QirhrkjtRi4lTo94Uy3XGVlerRnIRRSWq
         Y2kmSRSNiueutDdVMDlzYsAgcTNM4Z2ufhIm+MKRiNMyPJOAn/xZwPdx2C9NL7joYd1B
         wwGg==
X-Gm-Message-State: APjAAAV+cG2aYjVPidstM/hI3JiNPgHrc+hPWmpEoZFZEIc5xVoAQzva
        6bZ0j313Wm/Hncg0zwIx84tN3Vy+o2SP2G3PoPbLtQ==
X-Google-Smtp-Source: APXvYqxard7MWA/VNY2/t3WSS/ZAIm1KiPrRmTxGnTYRhlf2mlBOygWYKOFtWov73xjWrfasfr7Un7lha75I7XvLYCg=
X-Received: by 2002:a19:d612:: with SMTP id n18mr24957983lfg.162.1558374253977;
 Mon, 20 May 2019 10:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190518004639.20648-1-mcroce@redhat.com> <20190518004639.20648-2-mcroce@redhat.com>
 <20190520165322.GH10244@mini-arch>
In-Reply-To: <20190520165322.GH10244@mini-arch>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Mon, 20 May 2019 19:43:37 +0200
Message-ID: <CAGnkfhzEZokRWMtTdbHzy1JZVVEzEPuY2oWL-9LzjRVgG0Y05Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] libbpf: add missing typedef
To:     Stanislav Fomichev <sdf@fomichev.me>
Cc:     xdp-newbies@vger.kernel.org, bpf@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 20, 2019 at 6:53 PM Stanislav Fomichev <sdf@fomichev.me> wrote:
>
> On 05/18, Matteo Croce wrote:
> > Sync tools/include/linux/types.h with the UAPI one to fix this build error:
> >
> > make -C samples/bpf/../../tools/lib/bpf/ RM='rm -rf' LDFLAGS= srctree=samples/bpf/../../ O=
> >   HOSTCC  samples/bpf/sock_example
> > In file included from samples/bpf/sock_example.c:27:
> > /usr/include/linux/ip.h:102:2: error: unknown type name ‘__sum16’
> >   102 |  __sum16 check;
> >       |  ^~~~~~~
> > make[2]: *** [scripts/Makefile.host:92: samples/bpf/sock_example] Error 1
> > make[1]: *** [Makefile:1763: samples/bpf/] Error 2
> >
> > Signed-off-by: Matteo Croce <mcroce@redhat.com>
> > ---
> >  tools/include/linux/types.h | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/tools/include/linux/types.h b/tools/include/linux/types.h
> > index 154eb4e3ca7c..5266dbfee945 100644
> > --- a/tools/include/linux/types.h
> > +++ b/tools/include/linux/types.h
> > @@ -58,6 +58,9 @@ typedef __u32 __bitwise __be32;
> >  typedef __u64 __bitwise __le64;
> >  typedef __u64 __bitwise __be64;
> >
> > +typedef __u16 __bitwise __sum16;
> > +typedef __u32 __bitwise __wsum;
> If you do that, you should probably remove 'typedef __u16 __sum16;'
> from test_progs.h:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/tools/testing/selftests/bpf/test_progs.h#n13
>
> > +
> >  typedef struct {
> >       int counter;
> >  } atomic_t;
> > --
> > 2.21.0
> >

Hi,

I see test_progs.h only included in tools/testing/selftests/bpf/prog_tests/*,
so maybe it's unreladed to my change in samples/bpf/.
Maybe in a different patchset.

Bye,
-- 
Matteo Croce
per aspera ad upstream
