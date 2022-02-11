Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BED14B1E00
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 06:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237079AbiBKFyh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 00:54:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbiBKFyg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 00:54:36 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957AA10BA
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 21:54:36 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id t184so9015431vst.13
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 21:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EbSg9QvGTEG7MjQvzrDkvoNELNPgB+85sOLBqpa4AUA=;
        b=SS0XHSKcCaEsbQ4Wwn5QnKULou7/nRrOZDqvOOMFchl7PA2YkNlTMluAlF78eL3OYQ
         aqnX2q2M8LhDU64/bBNClIsemboTs0HTNUd+0of+BhXy1fFSemYC+igZDiJz/ZESPzRd
         beXCsmmRUkop/mDS4598qhe4S6adC9cqK24amqV0AX+xQxm2Mwg/jIz1LZa22h3Y/nZx
         wgvEK8FFChU2l3ty8WWlxGBgcENp62qqVG56A+1mnDMi+ofrJ/XYlh3CuSczlfeWJFoG
         Jv84tEFBEvjLuwUJl9lTtwqS6hE3/MtPnZeYync0MbqbWslvenfPrOH2XkqynFA+fi9V
         QpTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EbSg9QvGTEG7MjQvzrDkvoNELNPgB+85sOLBqpa4AUA=;
        b=f6GbQCH5Qb3F+kfUDuofWomzOrciduNYr4BB6aDXgpE04il4sxn9Pgr3onZG57FkvX
         f4vq0axcKxAJCYJye8CADNWoL5vur0f1UMwr5GnVceZNSvbmwNMvOYEKP6SAYHJ0VCSS
         wwfoHf+mDjYEIZxNzO9jldawHjVoegyxLhaftd7KUqSJ9ZDuQcOTv+VxpmyzkJPdmD2h
         Y3Hlt1H0G3t1QeMdHL4JlOG4btmi6Z+LAPI4T3wS3fLMof8gVAVE3Jkf2G6tSIZOXcpL
         N7Ao0nxYBxMVvwe0aJVaRoBQOK2mi+99FEQBRrjNRX5n5MXuScbQ0H70HBTGykGJ3uB+
         o+Dw==
X-Gm-Message-State: AOAM531uAItJYWgGGy96OuBPmcev23ocSpWJ2YUrKpalVQIFcoaXtxVU
        cFQn+TF+CD0GlUfxZ3RfGPg88/RBVU9Nnfq9XWzP+A==
X-Google-Smtp-Source: ABdhPJwgbeKVaaw6rh1wRuo14QINWzu6Y2BM87c7I7UpANzVeKUT6VCRWB95+kN7ykQHSH4158pU9USeGcLsab5G/4I=
X-Received: by 2002:a67:ea8f:: with SMTP id f15mr45351vso.46.1644558875472;
 Thu, 10 Feb 2022 21:54:35 -0800 (PST)
MIME-Version: 1.0
References: <d5dd3f10c144f7150ec508fa8e6d7a78ceabfc10.camel@redhat.com> <20220211040629.23703-1-lina.wang@mediatek.com>
In-Reply-To: <20220211040629.23703-1-lina.wang@mediatek.com>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date:   Thu, 10 Feb 2022 21:54:23 -0800
Message-ID: <CANP3RGc42sobVoq8LCs=9dAgRZmerV7ev_EMi8Qjb+1ZKeO4jQ@mail.gmail.com>
Subject: Re: [PATCH] net: fix wrong network header length
To:     Lina Wang <lina.wang@mediatek.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Linux NetDev <netdev@vger.kernel.org>,
        Kernel hackers <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Willem Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>,
        zhuoliang.zhang@mediatek.com, chao.song@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 10, 2022 at 8:12 PM Lina Wang <lina.wang@mediatek.com> wrote:
>
> On Thu, 2022-02-10 at 17:02 +0100, Paolo Abeni wrote:
>
> > > @@ -3682,6 +3682,7 @@ struct sk_buff *skb_segment_list(struct
> > > sk_buff *skb,
> > >     struct sk_buff *tail =3D NULL;
> > >     struct sk_buff *nskb, *tmp;
> > >     int err;
> > > +   unsigned int len_diff =3D 0;
> >
> > Mintor nit: please respect the reverse x-mas tree order.
> >
>
> Yes,v2 has change unsigned int to int

Reverse christmas tree, means from longest to shortest, like so:

     struct sk_buff *tail =3D NULL;
     struct sk_buff *nskb, *tmp;
+   int len_diff =3D 0;
     int err;

That said, I think the =3D 0 is not needed, so this can be just

+ int len_diff, err;

>
> > >
> > >     skb_push(skb, -skb_network_offset(skb) + offset);
> > > @@ -3721,9 +3722,11 @@ struct sk_buff *skb_segment_list(struct
> > > sk_buff *skb,
> > >             skb_push(nskb, -skb_network_offset(nskb) + offset);
> > >
> > >             skb_release_head_state(nskb);
> > > +           len_diff =3D skb_network_header_len(nskb) -
> > > skb_network_header_len(skb);
> > >              __copy_skb_header(nskb, skb);
> > >
> > >             skb_headers_offset_update(nskb, skb_headroom(nskb) -
> > > skb_headroom(skb));
> > > +           nskb->transport_header +=3D len_diff;
> >
> > This does not look correct ?!? the network hdr position for nskb will
> > still be uncorrect?!? and even the mac hdr likely?!? possibly you
> > need
> > to change the offset in skb_headers_offset_update().
> >
>
> Network hdr position and mac hdr are both right, because bpf processing &
> skb_headers_offset_update have updated them to right position. After bpf
> loading, the first skb's network header&mac_header became 44, transport
> header still is 64. After skb_headers_offset_update, fraglist skb's mac
> header and network header are still 24, the same with original packet.
> Just fraglist skb's transport header became 44, as original is 64.
> Only transport header cannot be easily updated the same offset, because
> 6to4 has different network header.
>
> Actually,at the beginning, I want to change skb_headers_offset_update, bu=
t
> it has been called also in other place, maybe a new function should be
> needed here.
>
> Skb_headers_offset_update has other wrong part in my scenary,
> inner_transport_header\inner_network_header\inner_mac_header shouldnot be
> changed, but they are been updated because of different headroom. They ar=
e
> not used later, so wrong value didnot affect anything.
>
> > Paolo
> >
>
> Thanks!Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google
