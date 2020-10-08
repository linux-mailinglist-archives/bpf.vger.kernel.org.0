Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91E128744C
	for <lists+bpf@lfdr.de>; Thu,  8 Oct 2020 14:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbgJHMdn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Oct 2020 08:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729722AbgJHMdn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Oct 2020 08:33:43 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C80C061755
        for <bpf@vger.kernel.org>; Thu,  8 Oct 2020 05:33:43 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id u74so2942077vsc.2
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2020 05:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1HqEIIx59zT2Fnp8KY1EDEY0FsrsNtvZJ6XAa9WgS64=;
        b=S1EPyOUFMh+fXq9/+U8w+8dukDP4t1WwGJxcso8XxUkWK7xLi9L5Sckj2d0Kl0RjHG
         KyHAu4yPWqyv/gokB6pwiFi1WsCtUkeRRrYAsQZAvnAdNrRK2zQehaNDP7+zllqJ1LGQ
         iz3kUAOtwtlhbB8FQfww6CChK+LPVttdO5GV5ePnRYaZb9tSogXdnoNDGDS7oCJ4V90E
         0Y99i3aKulNG541JCbNvU3kSUP36MncfXJySkXCBzO69hH5lVQBXp/j0T3BKVl2mjwTG
         pzad1R1qT5ovOniKDfItx8Yfr0gJ4YbIFF5TnhumltVxrw9YmsxTuQ3XH8xXe8I6+sNp
         is7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1HqEIIx59zT2Fnp8KY1EDEY0FsrsNtvZJ6XAa9WgS64=;
        b=XkJ/4q4+p+v9y3m+s2CykKNjR1+yg54ZuDTk1WtkocmAQ2o05fBaY5nDxbvC5CH0vG
         fOdPzh3ciothFyhtyqE8JRFESJOgHV3EcXrptezn5ZgFflaZI2cqwikrq0qKW3dfmhP1
         MZBZWari8w0RmIQ/KaHuLCWn79FzXlXZbNbzw4BVFoaCNZDLaKe207qZRTzUva5FFBj9
         c+3qRj6Gl7J6wYt6EhG1og3fY1gKDi+HWN3swjgWNQ2tCgkyie4kPWdkmI5cyZaAOxfA
         ub05qMcfTWvNIQlIzJC+BxRN4bu0iALn9wHgV943RNmvwgMBF9bdTwVO97Syb8As5xUg
         QKGQ==
X-Gm-Message-State: AOAM533CtpiJGZ2jJDHMSpUHu4D5qsR1etdEOtZhFUKF4v+VhfhbAy/r
        OWfYfDBZ4Mb81npfvPqBf3flWO9fefY=
X-Google-Smtp-Source: ABdhPJyVvxYZGdS954g/2uPZYsa+AwaiD0nFC5LP6hCGIpRqMymQCIRIOwTS0beEq/yFadyhfpp2dg==
X-Received: by 2002:a67:7dcb:: with SMTP id y194mr4748537vsc.26.1602160422410;
        Thu, 08 Oct 2020 05:33:42 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id z7sm612712vsn.14.2020.10.08.05.33.41
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 05:33:41 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id r21so1815189uaw.10
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2020 05:33:41 -0700 (PDT)
X-Received: by 2002:ab0:7718:: with SMTP id z24mr4290139uaq.92.1602160420784;
 Thu, 08 Oct 2020 05:33:40 -0700 (PDT)
MIME-Version: 1.0
References: <160208770557.798237.11181325462593441941.stgit@firesoul>
 <160208776033.798237.4028465222836713720.stgit@firesoul> <CANP3RGeU4sMjgAjXHVRc0ES9as0tG2kBUw6jRZhz6vLTTtVEVA@mail.gmail.com>
 <20201008130632.0c407bad@carbon>
In-Reply-To: <20201008130632.0c407bad@carbon>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 8 Oct 2020 08:33:04 -0400
X-Gmail-Original-Message-ID: <CA+FuTSfXt3_OZD3DoO46ndkBs6y7FCQk3QwaeLkh0QYyLhLhZA@mail.gmail.com>
Message-ID: <CA+FuTSfXt3_OZD3DoO46ndkBs6y7FCQk3QwaeLkh0QYyLhLhZA@mail.gmail.com>
Subject: Re: [PATCH bpf-next V2 1/6] bpf: Remove MTU check in __bpf_skb_max_len
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
        bpf <bpf@vger.kernel.org>, Linux NetDev <netdev@vger.kernel.org>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Shaun Crampton <shaun@tigera.io>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Marek Majkowski <marek@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eyal Birger <eyal.birger@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 8, 2020 at 7:06 AM Jesper Dangaard Brouer <brouer@redhat.com> w=
rote:
>
> On Wed, 7 Oct 2020 16:46:10 -0700
> Maciej =C5=BBenczykowski <maze@google.com> wrote:
>
> > >  static u32 __bpf_skb_max_len(const struct sk_buff *skb)
> > >  {
> > > -       return skb->dev ? skb->dev->mtu + skb->dev->hard_header_len :
> > > -                         SKB_MAX_ALLOC;
> > > +       return IP_MAX_MTU;
> > >  }
> >
> > Shouldn't we just delete this helper instead and replace call sites?
>
> It does seem wrong to pass argument skb into this function, as it is
> no-longer used...
>
> Guess I can simply replace __bpf_skb_max_len with IP_MAX_MTU.

Should that be IP6_MAX_MTU, which is larger than IP_MAX_MTU?
