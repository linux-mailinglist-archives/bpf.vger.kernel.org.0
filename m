Return-Path: <bpf+bounces-2928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE892737155
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 18:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 176D01C20CD2
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 16:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02F817AA6;
	Tue, 20 Jun 2023 16:19:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7223E101FB;
	Tue, 20 Jun 2023 16:19:43 +0000 (UTC)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB28F4;
	Tue, 20 Jun 2023 09:19:41 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-54fac329a71so2568340a12.1;
        Tue, 20 Jun 2023 09:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687277981; x=1689869981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxeRKqZloEV05cBOWmo0jqMiX1LFFLYwZEnNITp6IQQ=;
        b=RsFgKJIz6dEbL9T/u+OdGLsZkW+w40m/B5JsO6fhgVd8Yn/1tMuxVJ6zQpPxINhMPK
         gFG7JfjEmEmjBHumUpy3Po9LSXnI4kNZIWiOPyQ1/Jvu15UbhdVPqKHj5RrDkjpG1nnb
         cwRACe93rFACWTRBfEV1edY0sDgzaphWQHwZDAfNGifBJj/lvw9IUA5Py6m08fHNIar6
         lBAGm64DY/42NEyYvkWH3Pjjx3XJhfsZlmvWPQSfg0NlcU7vYDkp8YYVxmTVAua8Q+BH
         e8VsbdTerUBY+OpFzgZocGu+gybSTMzwqLfgZyRy3WiHf11rZDy2kqN/tZIvlT8eDN/b
         mUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687277981; x=1689869981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxeRKqZloEV05cBOWmo0jqMiX1LFFLYwZEnNITp6IQQ=;
        b=kJ1kQMdbIEvOwMmBGUXB4fCKbwUcvxOoRMcwogwKqls39sIi/YI0ITS2dUB0wR5kU8
         JsR7Ih0iWyZtm0DF3yhbzY0kafPZRhREriEDKed56J7Wk8FxUL21QEiL0/GvohdUklgZ
         kFEbgXYQSkN1HtxuaOCrVZdv8Mdszsmnkbt2cqs4p5ISBiFJCrRTvQhsKBMleHrYLxaN
         M0Rc7swto8mckIYE1rXM+oKg03bMuQO2q6btXRkAR24B0EkeRVH2J3mb3YlAPDFYc1BE
         LNz09pcR3ewZZc7mv2kOIl9rP14MzF6hyT+vSN9dzMnA1coMtAwIDflxvYLe7gNINnDF
         Vhgg==
X-Gm-Message-State: AC+VfDyUrN35n29ZceXlGeQ9K5iXZ3Ht7nbPxmfJVb8Cvt9+88kJk4AR
	0hOTdzAUCxgCPnG5uOrfDo2A4CTGeOlM792VZHE=
X-Google-Smtp-Source: ACHHUZ5Qpl2yWkqLcvHzi767hXr7PQw2Wy4VZjWP41NQ9B9p4GncFLSM63HTEzz65AXPTDssVVwRaE1v85qMycq9a1A=
X-Received: by 2002:a05:6a20:394a:b0:121:b1fc:1a48 with SMTP id
 r10-20020a056a20394a00b00121b1fc1a48mr5233275pzg.3.1687277980691; Tue, 20 Jun
 2023 09:19:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <36366741-8df2-1137-0dd9-d498d0f770e4@huawei.com>
 <CAKgT0UdXTSv1fDHBX4UC6Ok9NXKMJ_9F88CEv5TK+mpzy0N21g@mail.gmail.com>
 <c06f6f59-6c35-4944-8f7a-7f6f0e076649@huawei.com> <CAKgT0UccmDe+CE6=zDYQHi1=3vXf5MptzDo+BsPrKdmP5j9kgQ@mail.gmail.com>
 <0ba1bf9c-2e45-cd44-60d3-66feeb3268f3@redhat.com> <dcc9db4c-207b-e118-3d84-641677cd3d80@huawei.com>
 <f8ce176f-f975-af11-641c-b56c53a8066a@redhat.com> <CAKgT0UfzP30OiBQu+YKefLD+=32t+oA6KGzkvsW6k7CMTXU8KA@mail.gmail.com>
 <699563f5-c4fa-0246-5e79-61a29e1a8db3@redhat.com> <CAKgT0UcNOYwxRP_zkaBaZh-VBL-CriL8dFG-VY7-FUyzxfHDWw@mail.gmail.com>
 <ZI8dP5+guKdR7IFE@lore-desk>
In-Reply-To: <ZI8dP5+guKdR7IFE@lore-desk>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 20 Jun 2023 09:19:03 -0700
Message-ID: <CAKgT0UfFVFa4zT2DnPZEGaHp0uh5V1u1aGymgdL4Vu8Q1VV8hQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/4] page_pool: introduce page_pool_alloc() API
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Jesper Dangaard Brouer <jbrouer@redhat.com>, brouer@redhat.com, 
	Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Eric Dumazet <edumazet@google.com>, Maryam Tahhan <mtahhan@redhat.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jun 18, 2023 at 8:05=E2=80=AFAM Lorenzo Bianconi <lorenzo@kernel.or=
g> wrote:
>
> [...]
> > >
> > > Yes, precisely.
> > > I distinctly remember what I tried to poke you and Eric on this appro=
ach
> > > earlier, but I cannot find a link to that email.
> > >
> > > I would really appreciate, if you Alex, could give the approach in
> > > veth_convert_skb_to_xdp_buff() some review, as I believe that is a hu=
ge
> > > potential for improvements that will lead to large performance
> > > improvements. (I'm sure Maryam will be eager to help re-test performa=
nce
> > > for her use-cases).
> >
> > Well just looking at it the quick and dirty answer would be to look at
> > making use of something like page_frag_cache. I won't go into details
> > since it isn't too different from the frag allocator, but it is much
> > simpler since it is just doing reference count hacks instead of having
> > to do the extra overhead to keep the DMA mapping in place. The veth
> > would then just be sitting on at most an order 3 page while it is
> > waiting to fully consume it rather than waiting on a full pool of
> > pages.
>
> Hi,
>
> I did some experiments using page_frag_cache/page_frag_alloc() instead of
> page_pools in a simple environment I used to test XDP for veth driver.
> In particular, I allocate a new buffer in veth_convert_skb_to_xdp_buff() =
from
> the page_frag_cache in order to copy the full skb in the new one, actuall=
y
> "linearizing" the packet (since we know the original skb length).
> I run an iperf TCP connection over a veth pair where the
> remote device runs the xdp_rxq_info sample (available in the kernel sourc=
e
> tree, with action XDP_PASS):
>
> TCP clietn -- v0 =3D=3D=3D v1 (xdp_rxq_info) -- TCP server
>
> net-next (page_pool):
> - MTU 1500B: ~  7.5 Gbps
> - MTU 8000B: ~ 15.3 Gbps
>
> net-next + page_frag_alloc:
> - MTU 1500B: ~  8.4 Gbps
> - MTU 8000B: ~ 14.7 Gbps
>
> It seems there is no a clear "win" situation here (at least in this envir=
onment
> and we this simple approach). Moreover:

For the 1500B packets it is a win, but for 8000B it looks like there
is a regression. Any idea what is causing it?

> - can the linearization introduce any issue whenever we perform XDP_REDIR=
ECT
>   into a destination device?

It shouldn't. If it does it would probably point to an issue w/ the
destination driver rather than an issue with the code doing this.

> - can the page_frag_cache introduce more memory fragmentation (IIRC we we=
re
>   experiencing this issue in mt76 before switching to page_pools).

I think it largely depends on where the packets are ending up. I know
this is the approach we are using for sockets, see
skb_page_frag_refill(). If nothing else, if you took a similar
approach to it you might be able to bypass the need for the
page_frag_cache itself, although you would likely still end up
allocating similar structures.

