Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C86A4DB47E
	for <lists+bpf@lfdr.de>; Wed, 16 Mar 2022 16:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357183AbiCPPLv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Mar 2022 11:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357094AbiCPPLN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Mar 2022 11:11:13 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5FD69481
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 08:09:22 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id j5so1999415qvs.13
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 08:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mIB5oA28+mdJt//WPIP0/rKaAtJF8R0hwGv6A9XPIF0=;
        b=ZZ9sVAmcuMXneZ2TOrhARt09vqdRtfQt2AAVN3meodkTUPNYaTETkC8xo1SnuRomZY
         rJi3KY1MptlIddJz61BdH/Cc+I9kQM63aWTyQje6ZMG7NEBKeED2ugRH0i4Gt8TL4wqG
         xCg+QEt+KvZYzuOCKs0NaspjxYKYAR6JU/1R5neKJwlza1e4Esg3wqd/JoJtr2HwFrIG
         xKnO1ByYI87syCEnQHAdsghm9vRwKJG+BsX+Ann0Adydq5azhSlg0JWbbSXpLaOSdfy2
         3jDWk6iJDdi7+rUHKON6NyxCU5lueUp0CSTehqn4jeXdMW1fNECvNgiMzdR5Xds3vysO
         QgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mIB5oA28+mdJt//WPIP0/rKaAtJF8R0hwGv6A9XPIF0=;
        b=MH9wA7bXkKxC+zhVcphoVb+Ub/YWuh70qV9B0vH6P/hj+OGJn+hOM54tZKFLDmFJoa
         6cSCU7MRQmw02xGCEk5swlHzxNOG4jpTPf99LT84a0AdH+Rbr03HmfWpNGCj0QmVOLes
         fV8MyeZ0nQ/XNMyBtb3P2a4d1lhuBNHDDHY0NpaOvvWvk7WHxz2hGOxsfAlzYnQsZ6yr
         atWK2Hbf36aJitJDp1ChXKZCnIpxQQZqmdOtI+l4u2JOlGejCGbf4YqdSJQgouAaG6j5
         FYHeATMpUsmdhrHn6YijVtkOAAxYDIN5Ggp7t4VZjUgUKgKC404f8Gfta3fCGMrrxiYn
         TLuw==
X-Gm-Message-State: AOAM533vtO8hyCKX9XIfiVXi7lcpuyy/Vxh69lM67HqdKgphNPgy67Gt
        7dsRzRZ9NweGYY+Xw4W+9zmpc+n/1wBEuwJPQim6dw==
X-Google-Smtp-Source: ABdhPJzziGoR/WLqsuk0m0WIJ3DG4jCEq8Kak1OC4PtmPF4mBzRffN72LMDD67iCVCvg8Od1LPXpkf0jRlr5EmQYMFM=
X-Received: by 2002:ad4:5c8b:0:b0:440:cc89:d57d with SMTP id
 o11-20020ad45c8b000000b00440cc89d57dmr263780qvh.80.1647443361272; Wed, 16 Mar
 2022 08:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220315123916.110409-1-liujian56@huawei.com> <20220315195822.sonic5avyizrufsv@kafai-mbp.dhcp.thefacebook.com>
 <4f937ace70a3458580c6242fa68ea549@huawei.com> <623160c966680_94df20819@john.notmuch>
 <5cee2fb729624f168415d303cff4ee8f@huawei.com>
In-Reply-To: <5cee2fb729624f168415d303cff4ee8f@huawei.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 16 Mar 2022 08:09:10 -0700
Message-ID: <CAKH8qBuBoyJqSEBX+2iG4b7C7tXPZUtVX6qZysrwddT3LE9ieg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] net: Use skb->len to check the validity of the
 parameters in bpf_skb_load_bytes
To:     "liujian (CE)" <liujian56@huawei.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "yhs@fb.com" <yhs@fb.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 16, 2022 at 6:08 AM liujian (CE) <liujian56@huawei.com> wrote:
>
>
>
> > -----Original Message-----
> > From: John Fastabend [mailto:john.fastabend@gmail.com]
> > Sent: Wednesday, March 16, 2022 12:00 PM
> > To: liujian (CE) <liujian56@huawei.com>; Martin KaFai Lau <kafai@fb.com>
> > Cc: ast@kernel.org; daniel@iogearbox.net; andrii@kernel.org;
> > songliubraving@fb.com; yhs@fb.com; john.fastabend@gmail.com;
> > kpsingh@kernel.org; davem@davemloft.net; kuba@kernel.org;
> > sdf@google.com; netdev@vger.kernel.org; bpf@vger.kernel.org
> > Subject: RE: [PATCH bpf-next] net: Use skb->len to check the validity of the
> > parameters in bpf_skb_load_bytes
> >
> > liujian (CE) wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Martin KaFai Lau [mailto:kafai@fb.com]
> > > > Sent: Wednesday, March 16, 2022 3:58 AM
> > > > To: liujian (CE) <liujian56@huawei.com>
> > > > Cc: ast@kernel.org; daniel@iogearbox.net; andrii@kernel.org;
> > > > songliubraving@fb.com; yhs@fb.com; john.fastabend@gmail.com;
> > > > kpsingh@kernel.org; davem@davemloft.net; kuba@kernel.org;
> > > > sdf@google.com; netdev@vger.kernel.org; bpf@vger.kernel.org
> > > > Subject: Re: [PATCH bpf-next] net: Use skb->len to check the
> > > > validity of the parameters in bpf_skb_load_bytes
> > > >
> > > > On Tue, Mar 15, 2022 at 08:39:16PM +0800, Liu Jian wrote:
> > > > > The data length of skb frags + frag_list may be greater than
> > > > > 0xffff, so here use skb->len to check the validity of the parameters.
> > > > What is the use case that needs to look beyond 0xffff ?
> >
> > > I use sockmap with strparser, the stm->strp.offset (the begin of one
> > > application layer protocol message) maybe beyond 0xffff, but i need
> > > load the message head to do something.
> >
> > This would explain skb_load_bytes but not the other two right? Also if we
> Yes, I just see that these two functions have the same judgment.
> > are doing this why not just remove those two checks in
> > flow_dissector_load() I think skb_header_pointer() does duplicate checks.
> > Please check.
> Yes, skb_header_pointer() have checked as below, and I will send v2 to remove 0xffff check.
> ----skb_header_pointer
> -------- __skb_header_pointer
> ------------skb_copy_bits
> ---------------- if (offset > (int)skb->len - len)
> --------------------goto fault;
>
> Thank you~

Do we need to have at least "offset <= 0x7fffffff" check? IOW, do we
need to enforce the unsignedness of the offset? Or does
skb_header_pointer et all properly work with the negative offsets?
