Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0982041C4DC
	for <lists+bpf@lfdr.de>; Wed, 29 Sep 2021 14:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343875AbhI2MkW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Sep 2021 08:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343735AbhI2MkR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Sep 2021 08:40:17 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2090DC061755
        for <bpf@vger.kernel.org>; Wed, 29 Sep 2021 05:38:36 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id i19so7239528lfu.0
        for <bpf@vger.kernel.org>; Wed, 29 Sep 2021 05:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4Jp5XoBBUCIZkRtaaHS4Hx7w5OlDxhGQ573Ohq4Qjg8=;
        b=YwvON9FFdiCbTL1FudwMQEQkmFUeEcH+0yeRG6hr+pn6Y3MKEtYWu/fg3bZAKQo0ay
         5gUpbQCmEeFt+oAmAJ+OqIxZranYwfpURX8NuvbzcgN1XW2cF+yVtRgyYjr71CF/eFTq
         ULvWyMdJD5UxP8Iunsu/A3ne36hCW+ZMaaDrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4Jp5XoBBUCIZkRtaaHS4Hx7w5OlDxhGQ573Ohq4Qjg8=;
        b=wxUUTrRJU5kVtipfcvFai8mqWuXRFb85I4UiwfaMRsvHlgSMutdFLhxOebcc97QTuk
         wAsl83TzU5SmRROkH4NRmmok5hGGnWvB3EQPfYd9hted/ALAUL+ArQTm4azqi0RevVJ4
         l8XPJUXiGIYVj521/6uSCcKhu0hPlDxJUMGRVRLuAfA0ByRYZf2AzXwXsBcli3AMDyc/
         mN1D807GyZNUAEM4+GUyTS3BTxtHZ5s+l3uwnfDmjExnu3qvbwAVcUo/JHhnd61Vf9co
         /amoiOnUjRocfiVaBxoRcm9TMlacU5khKX+Lv//nuq0XY3GHqemT/sU0nJoKbsmOtHpE
         iMEw==
X-Gm-Message-State: AOAM533d5Gff5XWev9mUMCWZyG0WkRRbRuS8kbooNOGbJ5/e/8jb07eA
        4peh2rloQHUddeCtektm6R117LM8VtlrKY082a/n1g==
X-Google-Smtp-Source: ABdhPJyn902cnsEhqqIHepHYzpfMG5dnpSQy5RJ33/5nrBn+7Rh9OiC6Q+VZI20hXl+YCPEWXOq+F9xh3+vaa9g6DDk=
X-Received: by 2002:a2e:5344:: with SMTP id t4mr5606292ljd.212.1632919114412;
 Wed, 29 Sep 2021 05:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631289870.git.lorenzo@kernel.org> <20210916095539.4696ae27@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CACAyw9-8t8RpJgJUTd7u6bOLnJ1xQsgK7z37QrL9T1FUaJ7WNQ@mail.gmail.com> <87v92jinv7.fsf@toke.dk>
In-Reply-To: <87v92jinv7.fsf@toke.dk>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 29 Sep 2021 13:38:23 +0100
Message-ID: <CACAyw99S9v658UyiKz3ad4kja7rDNfYv+9VOXZHCUOtam_C8Wg@mail.gmail.com>
Subject: Re: [PATCH v14 bpf-next 00/18] mvneta: introduce XDP multi-buffer support
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, shayagr@amazon.com,
        John Fastabend <john.fastabend@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Saeed Mahameed <saeed@kernel.org>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        tirthendu.sarkar@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 29 Sept 2021 at 13:10, Toke H=C3=B8iland-J=C3=B8rgensen <toke@redha=
t.com> wrote:
>
> Lorenz Bauer <lmb@cloudflare.com> writes:
>
> > On Thu, 16 Sept 2021 at 18:47, Jakub Kicinski <kuba@kernel.org> wrote:
> >>
> >> Won't applications end up building something like skb_header_pointer()
> >> based on bpf_xdp_adjust_data(), anyway? In which case why don't we
> >> provide them what they need?
> >>
> >> say:
> >>
> >> void *xdp_mb_pointer(struct xdp_buff *xdp_md, u32 flags,
> >>                      u32 offset, u32 len, void *stack_buf)
> >>
> >> flags and offset can be squashed into one u64 as needed. Helper return=
s
> >> pointer to packet data, either real one or stack_buf. Verifier has to
> >> be taught that the return value is NULL or a pointer which is safe wit=
h
> >> offsets up to @len.
> >>
> >> If the reason for access is write we'd also need:
> >>
> >> void *xdp_mb_pointer_flush(struct xdp_buff *xdp_md, u32 flags,
> >>                            u32 offset, u32 len, void *stack_buf)
> >
> > Yes! This would be so much better than bpf_skb_load/store_bytes(),
> > especially if we can use it for both XDP and skb contexts as stated
> > elsewhere in this thread.
>
> Alright. Let's see if we can go this route, then :)

Something I forgot to mention: you could infer that an XDP program is
mb-aware if it only does packet access via the helpers. Put another
way, it might be nice if ctx->data wasn't accessible in mb XDP. That
way I know that all packet access has to handle mb-aware ctx (think
pulling in functions via headers or even pre-compiled bpf libraries).

--=20
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
