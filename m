Return-Path: <bpf+bounces-292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B096FE02E
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 16:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCB7E1C20DBB
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 14:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A59B14AB4;
	Wed, 10 May 2023 14:28:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1465D12B74
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 14:28:04 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6E13A9D
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 07:28:02 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1aaea3909d1so68541665ad.2
        for <bpf@vger.kernel.org>; Wed, 10 May 2023 07:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683728882; x=1686320882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKPCR13dkcofkQ7oSqkGkqMzyp32FmPZ9TG8+tLzHV0=;
        b=gsEnjcUdtzqaRodlqfjVZLdWN8hkKsduouYAvYiCc5mdy/uCQWdSUR0EO0461EaQxI
         NZ/uuq3IlWAh9yruB1ZWR89o1Fz/mW/3m0D7m3vOL9fcT1+imDQPR+4XB4seQvZlgaFi
         VJYeCApHrWu81Rwu+MyxX1Pc7oKMdMgQ2ihM/0gyMZHvSsreZnoY2vDvdQv7CRBkFUYr
         zlWf0C3Oqv5nkOEpmZ7gk58WCSeKztgl0WmxQsHb/q82yopdvIq82iCECO21hg8U0un5
         7rYZDsD04EMxO61fDoqk1QuqmLQfFXmkARyaojLH5llmVoP8f/7PWsg8d5OCe0F777SB
         tsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683728882; x=1686320882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKPCR13dkcofkQ7oSqkGkqMzyp32FmPZ9TG8+tLzHV0=;
        b=I5qxjr6GGrkJKZiYwfA6Xt7vHfAZYMOD3xGSq9Ax1Yqk7E85vUxUno14mkcQRZCp0x
         77WAUrHsI1QlZecqNMv3BeGvsJcGq62cpX4Msfi27acz2aYlfaatBOTw26us6kYm4krK
         BexEpJF3uMr7kfN60lR5fyoTnK161ux85YokkYOekQLt+p5r67sXjtOxBtZgfcYgo2m2
         +pF5mYMsckvyXNlFYJt+Uj0k788zvHqfHBcUfRu/65AqFoLgyqWIxjRu9lici6aSlDTj
         jUdRJ4/sFqlf/sDBlauGptZqOJYg5fLIqgV/8kEjOFmJPnN3iePEV+FhG5VlbpBwC6Ix
         teTQ==
X-Gm-Message-State: AC+VfDyyHr6++8QibvQKTo/TPsE8Ti+FU7rLHReLb1khZgQUT0q3Z4H/
	UNDiAyECAnRnaFPY5JSi92mWeCESL147PMS5F3akxA==
X-Google-Smtp-Source: ACHHUZ72EeOsIM9HTEvmBro030gmzUFyayFdl4z2hm1v5JGUrv9TRcjAjw2H6oZIz3NKOgYoAeJWNGx7c0QTBHy4lhY=
X-Received: by 2002:a17:902:db01:b0:1a6:fe25:4138 with SMTP id
 m1-20020a170902db0100b001a6fe254138mr20657197plx.59.1683728881888; Wed, 10
 May 2023 07:28:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230509114146.20962-1-linyunsheng@huawei.com>
 <20230509114146.20962-2-linyunsheng@huawei.com> <ZFtYkmvQ01YxHf9s@corigine.com>
 <e78bf687-8b3f-f40f-ac52-8c3ecf7ef40f@huawei.com> <ZFuV2MEvcggfeRQS@corigine.com>
In-Reply-To: <ZFuV2MEvcggfeRQS@corigine.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Wed, 10 May 2023 07:27:50 -0700
Message-ID: <CAKH8qBt1OUZchURzkOqA=XsHD5iagL9TSN2+UzEVKCT-Sj5Ecw@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/2] net: introduce and use skb_frag_fill_page_desc()
To: Simon Horman <simon.horman@corigine.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, Lorenzo Bianconi <lorenzo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 10, 2023 at 6:02=E2=80=AFAM Simon Horman <simon.horman@corigine=
.com> wrote:
>
> On Wed, May 10, 2023 at 08:07:36PM +0800, Yunsheng Lin wrote:
> > On 2023/5/10 16:40, Simon Horman wrote:
> > > + XDP people and ML
> > >
> > > On Tue, May 09, 2023 at 07:41:45PM +0800, Yunsheng Lin wrote:
> > >> Most users use __skb_frag_set_page()/skb_frag_off_set()/
> > >> skb_frag_size_set() to fill the page desc for a skb frag.
> > >>
> > >> Introduce skb_frag_fill_page_desc() to do that.
> > >>
> > >> net/bpf/test_run.c does not call skb_frag_off_set() to
> > >> set the offset, "copy_from_user(page_address(page), ...)"
> > >> suggest that it is assuming offset to be initialized as
> > >> zero, so call skb_frag_fill_page_desc() with offset being
> > >> zero for this case.
> > >
> > > I think the question is, what is the value of bv_offset before this p=
atch.
> >
> > sinfo seems to be part of the 'data' kzalloced in
> > bpf_test_init(), so bv_offset should be zero too.
>
> Thanks, that sounds logical to me.

+1, doesn't look like we do anything special. We just allocate the
page and assume zero offset.

> > > Lorenzo and Stanislav, do you have any insight here?
> > >
> > >>
> > >> Also, skb_frag_set_page() is not used anymore, so remove
> > >> it.
> > >>
> > >> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> > >
> > > ...
> > >
> > >> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > >> index 738776ab8838..30be21c7d05f 100644
> > >> --- a/include/linux/skbuff.h
> > >> +++ b/include/linux/skbuff.h
> > >> @@ -2411,6 +2411,15 @@ static inline unsigned int skb_pagelen(const =
struct sk_buff *skb)
> > >>    return skb_headlen(skb) + __skb_pagelen(skb);
> > >>  }
> > >>
> > >> +static inline void skb_frag_fill_page_desc(skb_frag_t *frag,
> > >> +                                     struct page *page,
> > >> +                                     int off, int size)
> > >> +{
> > >> +  frag->bv_page =3D page;
> > >> +  frag->bv_offset =3D off;
> > >
> > > Maybe it is slightly nicer to use skb_frag_off_set() here.
> >
> > Yes, that is good idea.
> > But we need to move the definition of skb_frag_off_set() before
> > skb_frag_fill_page_desc in order to use it, I try to keep the
> > patch simple for reviewing for now, so I perfer to not do it
> > now if that is ok for you.
>
> Sure, that is fine by me.

