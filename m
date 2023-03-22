Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829A66C5478
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 20:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjCVTC1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 15:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjCVTCI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 15:02:08 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A9226C2A
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 12:00:54 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id l14so11728328pfc.11
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 12:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679511652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjDTPkSaQqj31I/z+HvI789TpMhG2SxR9s75ueel5GI=;
        b=JlL6QJwmm4n9k6MhGIAPDh3m+nKrNBYcW+5PfY4XwjHvreYRlYugSKMcbX2nToJcVG
         gjiQfagZa6E4HOKWgeofV9xcLVWuiH7pTM73VCjsaS045VRAsbCdf7tWKDV8eiKZWYKV
         4INMTke5kTI586i6wfE4VybYhS4iQPtYArVL9FG3v0M49aFcPyVF4RTWG7BAAWDnzWKW
         m49L9wbHaOh8PD+kbc4qXRXLv3/84aQS3HOd9a6RKnCGlSR0J5VD/nkzjUkF9CosKtfr
         erwcs+57HBfpfLT+45Oiw54o+C1T9vJU7ecxgNrhZiy4DBoRW8Ja/dm9C+GB6ZmDKQUN
         vk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679511652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GjDTPkSaQqj31I/z+HvI789TpMhG2SxR9s75ueel5GI=;
        b=MZKi1urZAQbPE1a1m1WwffsWual/YXOXinpnhYTUexWDpyYARONrAEyUg9ycSDqtWz
         Dr8ahkVafdHi11qAQishgEjLv6lK9bd2u+NwrSmgIqTHngMMPIjSJMU9WJ6Ja4coEe+S
         w1vLK7+c9lL58+4G9G498Ul39iw3w/CBCA/F5ZL5cttbMlWSIrvISvcO705o+oR23ZVe
         sQoLXc9Q9Qh1p37SYH9NzidJ4Synml5xQCs1QazYtP////LN/u29OtyJ90jtF+SdKtFZ
         hVxvWTpM+YOyZxpv336IZqjdVOTerwGJEChOKp5RB+8FvQ3U74Q7ssZKkRTm85ctsyoL
         ho0A==
X-Gm-Message-State: AO0yUKWV8B5P8Lno+h3NxK8bxBYpdQCB21lw6khzHIaOzaJcJ9EekR8x
        yrUiqv2Gie/m45CL1uHljpKZgD24x7CJjtzvZ4MoaQ==
X-Google-Smtp-Source: AK7set+1HbWv73aDwWV4mLjxIHFWB4Iy/lNo7wzRMlUmKTAxKpq3IEOamI1JirRB9Au5KHcZoar0gGb5tc/faf86//k=
X-Received: by 2002:a65:4346:0:b0:50b:dca1:b6f9 with SMTP id
 k6-20020a654346000000b0050bdca1b6f9mr1128719pgq.1.1679511651715; Wed, 22 Mar
 2023 12:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <167950085059.2796265.16405349421776056766.stgit@firesoul>
 <167950088752.2796265.16037961017301094426.stgit@firesoul> <CAADnVQJz+E9s1wcR-0t7AeuZMaCKBHezQc54mFCqqQ=7KK1D+Q@mail.gmail.com>
In-Reply-To: <CAADnVQJz+E9s1wcR-0t7AeuZMaCKBHezQc54mFCqqQ=7KK1D+Q@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 22 Mar 2023 12:00:40 -0700
Message-ID: <CAKH8qBtmpr_44kq9dOr4Kdz8t9xNFp4ow6J0_6EEyJhNgA=sTg@mail.gmail.com>
Subject: Re: [PATCH bpf-next V3 3/6] selftests/bpf: xdp_hw_metadata RX hash
 return code info
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        xdp-hints@xdp-project.net, anthony.l.nguyen@intel.com,
        "Song, Yoong Siang" <yoong.siang.song@intel.com>,
        "Ong, Boon Leong" <boon.leong.ong@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 22, 2023 at 9:09=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Mar 22, 2023 at 9:01=E2=80=AFAM Jesper Dangaard Brouer
> <brouer@redhat.com> wrote:
> >
> > When driver developers add XDP-hints kfuncs for RX hash it is
> > practical to print the return code in bpf_printk trace pipe log.
> >
> > Print hash value as a hex value, both AF_XDP userspace and bpf_prog,
> > as this makes it easier to spot poor quality hashes.
> >
> > Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> > Acked-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  .../testing/selftests/bpf/progs/xdp_hw_metadata.c  |    9 ++++++---
> >  tools/testing/selftests/bpf/xdp_hw_metadata.c      |    5 ++++-
> >  2 files changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tool=
s/testing/selftests/bpf/progs/xdp_hw_metadata.c
> > index 40c17adbf483..ce07010e4d48 100644
> > --- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> > +++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> > @@ -77,10 +77,13 @@ int rx(struct xdp_md *ctx)
> >                 meta->rx_timestamp =3D 0; /* Used by AF_XDP as not avai=
l signal */
> >         }
> >
> > -       if (!bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash))
> > -               bpf_printk("populated rx_hash with %u", meta->rx_hash);
> > -       else
> > +       ret =3D bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash);
> > +       if (ret >=3D 0) {
> > +               bpf_printk("populated rx_hash with 0x%08X", meta->rx_ha=
sh);
> > +       } else {
> > +               bpf_printk("rx_hash not-avail errno:%d", ret);
> >                 meta->rx_hash =3D 0; /* Used by AF_XDP as not avail sig=
nal */
> > +       }
>
> Just noticed this mess of printks.
> Please remove them all. selftests should not have them.

See my reply in the v2.
