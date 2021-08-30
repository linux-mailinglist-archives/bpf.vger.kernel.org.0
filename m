Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36B53FBF85
	for <lists+bpf@lfdr.de>; Tue, 31 Aug 2021 01:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239069AbhH3XqO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Aug 2021 19:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238942AbhH3XqN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Aug 2021 19:46:13 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03F0C061575;
        Mon, 30 Aug 2021 16:45:19 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 2so13476329pfo.8;
        Mon, 30 Aug 2021 16:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Re3gLeBwRRmX24qUL4EVhAgHhmV7cQmrH8Bx6j8kmLc=;
        b=NiRgDFwr2Kh9DI01Qm/COtylyO38wSbFMmIW6JB4w338bFIhZSjQj9Qd7PFmS3FqP2
         X5VoLChPy15DvUmWQBUt5gLj/ngVEWIatuvQFcKGTu4KKg+bxU0haFBwEifBA2UV4pEG
         /8vd8DWbwmcyjP9k7MTrdVtYYjHjPDWLQOo8uY9+VRfAnEa/ytGL4JHEJpisWWCaB9+j
         hLuMt9FqwJljhD3lOCfz2Jlv7I7cFJacPQJ5mmnXk1vt3g1CZFS6d9jZk3o6DjOyYfDi
         3xbKagFF2C9J41cjsJfREHdca8cVuo34ayppOrtu9LF1fqbIbEwGoL6t8C6pkqqDwymm
         JNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Re3gLeBwRRmX24qUL4EVhAgHhmV7cQmrH8Bx6j8kmLc=;
        b=f7Wd7SOZaG6mq5UqBskMqDF9n8dL2s1ZKAKSyj/+QlGqRWeSJR2MAwILjCBcsuGiNx
         JYW3PqCDVjWhwNmkNt+7m4jOfKarDNE0w5eUGuIS3LZphCkccxwnuqgehxEUyR2vpw3O
         vRAkDieBzW2Flyk/d8rJ/6Qp3BiXN0HbHLCGf5/xEtyUzBLSYqE97kC5V57u8wUDRFyU
         1suGW8xcNqSRiDICbcuvco7GQd+r1GBluLOnRfRe09D+Yh1Ie0ot8pLWgSYZUM5guEsB
         ooywaLP4L2vVEqXMN9WPfTciqoCmpQ30ACA1ZYVihmI/VMxsaebo+LsF1pb3UWG7bfUa
         M+dQ==
X-Gm-Message-State: AOAM531Zn4V1uFFmeVbPO2vnxbfnzmkwA1VLSPIaAV7WiqSl7RbablJF
        xAOgQjKbjb9o6ryYHKxMKiQ=
X-Google-Smtp-Source: ABdhPJzh2aL6BvmA9zDXU2sY1zgZYcjTlbtlewt9B18GdUAExmqB3Bj6GVQBwGurg+qY1YB9fupXeg==
X-Received: by 2002:a65:47c6:: with SMTP id f6mr24068702pgs.450.1630367119080;
        Mon, 30 Aug 2021 16:45:19 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:4106])
        by smtp.gmail.com with ESMTPSA id f18sm5558203pfc.161.2021.08.30.16.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 16:45:18 -0700 (PDT)
Date:   Mon, 30 Aug 2021 16:45:15 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dmitrii Banshchikov <me@ubique.spb.ru>
Cc:     bpf@vger.kernel.org, ast@kernel.org, davem@davemloft.net,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, netdev@vger.kernel.org, rdna@fb.com
Subject: Re: [PATCH bpf-next v2 12/13] bpfilter: Add filter table
Message-ID: <20210830234515.ncvsdswj4lalgpo3@ast-mbp.dhcp.thefacebook.com>
References: <20210829183608.2297877-1-me@ubique.spb.ru>
 <20210829183608.2297877-13-me@ubique.spb.ru>
 <20210830194545.rgwg3ks3alikeyzx@ast-mbp.dhcp.thefacebook.com>
 <20210830205443.wx3n2bhw44pji2hn@amnesia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210830205443.wx3n2bhw44pji2hn@amnesia>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 31, 2021 at 12:54:43AM +0400, Dmitrii Banshchikov wrote:
> On Mon, Aug 30, 2021 at 12:45:45PM -0700, Alexei Starovoitov wrote:
> > On Sun, Aug 29, 2021 at 10:36:07PM +0400, Dmitrii Banshchikov wrote:
> > >  /*
> > > - * # Generated by iptables-save v1.8.2 on Sat May  8 05:22:41 2021
> > > + *  Generated by iptables-save v1.8.2 on Sat May  8 05:22:41 2021
> > >   * *filter
> > ...
> > > - * -A LOCAL -s 10.32.0.0/11 -j FROMDC
> > > - * -A LOCAL -s 10.144.0.0/12 -j FROMDC
> > > - * -A LOCAL -s 10.160.0.0/12 -j FROMDC
> > > - * -A LOCAL -s 10.0.0.0/12 -j FROMDC
> > > - * -A LOCAL -s 10.248.0.0/24 -j FROMDC
> > > - * -A LOCAL -s 10.232.0.0/16 -j FROMDC
> > > - * -A LOCAL -s 10.1.146.131/32 -p udp -m udp --dport 161 -j ACCEPT
> > > - * -A LOCAL -s 10.149.118.14/32 -p udp -m udp --dport 161 -j ACCEPT
> > > - * -A LOCAL -p icmp -j ACCEPT
> > > + * :INPUT ACCEPT [0:0]
> > > + * :FORWARD ACCEPT [0:0]
> > > + * :OUTPUT ACCEPT [0:0]
> > > + * -A INPUT -s 1.1.1.1/32 -d 2.2.2.2/32 -j DROP
> > > + * -A INPUT -s 2.2.0.0/16 -d 3.0.0.0/8 -j DROP
> > > + * -A INPUT -p udp -m udp --sport 100 --dport 500 -j DROP
> > >   * COMMIT
> > >   */
> > 
> > Patch 10 adds this test, but then patch 12 removes most of it?
> > Keep both?
> 
> Sorry, I missed it.
> I decided that the large blob looks really ugly and switched to
> the smaller one and forgot to cleanup the patchset.
> 
> > 
> > Also hit this on my system with older glibc:
> > 
> > ../net/bpfilter/codegen.c: In function ‘codegen_push_subprog’:
> > ../net/bpfilter/codegen.c:67:4: warning: implicit declaration of function ‘reallocarray’ [-Wimplicit-function-declaration]
> >    67 |    reallocarray(codegen->subprogs, subprogs_max, sizeof(codegen->subprogs[0]));
> >       |    ^~~~~~~~~~~~
> > ../net/bpfilter/codegen.c:66:12: warning: assignment to ‘struct codegen_subprog_desc **’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
> >    66 |   subprogs =
> >       |            ^
> > 
> > In libbpf we have libbpf_reallocarray() for this reason.
> > 
> > Could you provide an example of generated bpf program?
> > And maybe add Documentation/bpf/bpfilter_design.rst ?
> 
> I will add documentation in the next iteration when
> bpf_map_for_each() subprog will be introduced.
> 
> > 
> > The tests don't build for me:
> > $ cd selftests/bpf/bpfilter; make
> > make: *** No rule to make target '-lelf', needed by '.../selftests/bpf/bpfilter/test_match'.  Stop.
> 
> libelf was added because libbpf depends on it.
> Are you able to build libbpf?

make proceeds to build libbpf just fine, but then it stops with above message.
I manually removed -lelf from Makefile. Then run make to see it fail linking
and then manually copy pasted gcc command to build it with additional -lelf
command line.
fwiw make -v
GNU Make 4.2.1

> > 
> > The unit tests are great, btw. test_codegen is not end-to-end, right?
> > Could you add a full test with iptable command line?
> > or netns support is a prerequisite for it?
> 
> Yeah, as net namespaces aren't supported using iptables binary
> will modify the root namespace. That is the reason why codegen
> tests aren't implemented in the end-to-end fashion and rules are
> represented by blobs.

I think when ifindex is no longer hardcoded the netns support
doesn't have to be gating. The generic xdp attached to veth in netns
should work to do end-to-end test. bpftiler would need to do a bit of magic
to figure out the right ifindex. Or we can extend kernel with ifindex-less
generic XDP.
