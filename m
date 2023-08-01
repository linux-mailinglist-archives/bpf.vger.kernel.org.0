Return-Path: <bpf+bounces-6584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA40B76B911
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 17:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A546B281ADD
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 15:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261141ADEC;
	Tue,  1 Aug 2023 15:50:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE72B1ADCA;
	Tue,  1 Aug 2023 15:50:31 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB01171C;
	Tue,  1 Aug 2023 08:50:30 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b703a0453fso88619941fa.3;
        Tue, 01 Aug 2023 08:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690905028; x=1691509828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bg4+KvMlhZ34B4eMJftZ2Ixr3pXT/19a5y3fl6JXNlw=;
        b=RDsYzD5oIlIdxeucfKLa/N8ab3HHWeWH3c9SMtwOoHql+T2xfEeJzh03Uy18HMAmyY
         AMbgAEvKNjbgtp5nSfK0Jfx+VP5PDYs/WemSICZBGrGD6qf4fM3qrkQVCXO3b1MjE++J
         bMx/mE0EOtQKy4Zd26oxRyqpEN94pOgftPVeZiGmrgUw3U0xxdCTtR8NhXBlSpGJS5mm
         KGT0+nt7StIP2VpiiAGPb7ezYSZiX1l9drDS0hocMx79FFFVO5JjHsZ2M/R2FHrWRzx6
         CssjjiyzzTQxCdUyh2r0qyAsSO/3+ZheTJ8DzgdAxjcJF9G+QfrCgRFGwYGyBFJn5YrL
         yKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690905028; x=1691509828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bg4+KvMlhZ34B4eMJftZ2Ixr3pXT/19a5y3fl6JXNlw=;
        b=gHjkQc9nd1bEK3QrWYaR+jS2yEGHGT3RbZxnby+VJiihcjXGcrCycnuKOd2wwhlQTT
         KbUKbKXdOjGPr5qK/vXS7DxEdkDlqHYxVLk+moC2utte+IbfEWsEqtjRxTUDdw5bFGoc
         Zg40ITz9iAN+q0rrKiGp9xKmEqPapGd0yw4zE533IG0/pgEkD8RajvjTW++iwynKuk6H
         OY1aUxtND9UhocK5Svzi8uIFNdOyxEXnSZlaEd+Axk5TrPLNvF3dShzHZnzOcXtJhX/A
         dH7vBqR1Kc5KxYqDtZ8tZPGfP28gsJnx6MagcaA3xAUJOkI65hwIkIeDjlOyuNkn4G5J
         aiVA==
X-Gm-Message-State: ABy/qLanYyBDI7108Plr4gPck6sCU4Jt63yL33I0JXlfWY1uSMXGMC92
	sTVw4Sy9zufObngYghvUcPJ4yF69UNroemLnwY8=
X-Google-Smtp-Source: APBJJlEqqV4FtxSIj3IHGgAxaSVhP32LN2jwvjZaqWXkm2w86ahkQJutxSobKgVWLVq+pLm9fhdqqalluWlwSdBtRLM=
X-Received: by 2002:a2e:980c:0:b0:2b9:b41a:aa66 with SMTP id
 a12-20020a2e980c000000b002b9b41aaa66mr3117683ljj.20.1690905028142; Tue, 01
 Aug 2023 08:50:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230728064411.305576-1-tglozar@redhat.com> <87ila0fn01.fsf@cloudflare.com>
 <64c882fd8c200_a427920843@john.notmuch> <19a3a2be3c2389e97cacd7e7ab93b317b016ef94.camel@redhat.com>
In-Reply-To: <19a3a2be3c2389e97cacd7e7ab93b317b016ef94.camel@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 1 Aug 2023 08:50:16 -0700
Message-ID: <CAADnVQ+VNWTfE7cn4rDkfqdwLqLv22ZEe_HD0vAhKE=8U15mdQ@mail.gmail.com>
Subject: Re: [PATCH net] bpf: sockmap: Remove preempt_disable in sock_map_sk_acquire
To: Paolo Abeni <pabeni@redhat.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	LKML <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, tglozar@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 1, 2023 at 12:44=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Mon, 2023-07-31 at 20:58 -0700, John Fastabend wrote:
> > Jakub Sitnicki wrote:
> > >
> > > On Fri, Jul 28, 2023 at 08:44 AM +02, tglozar@redhat.com wrote:
> > > > From: Tomas Glozar <tglozar@redhat.com>
> > > >
> > > > Disabling preemption in sock_map_sk_acquire conflicts with GFP_ATOM=
IC
> > > > allocation later in sk_psock_init_link on PREEMPT_RT kernels, since
> > > > GFP_ATOMIC might sleep on RT (see bpf: Make BPF and PREEMPT_RT co-e=
xist
> > > > patchset notes for details).
> > > >
> > > > This causes calling bpf_map_update_elem on BPF_MAP_TYPE_SOCKMAP map=
s to
> > > > BUG (sleeping function called from invalid context) on RT kernels.
> > > >
> > > > preempt_disable was introduced together with lock_sk and rcu_read_l=
ock
> > > > in commit 99ba2b5aba24e ("bpf: sockhash, disallow bpf_tcp_close and=
 update
> > > > in parallel"), probably to match disabled migration of BPF programs=
, and
> > > > is no longer necessary.
> > > >
> > > > Remove preempt_disable to fix BUG in sock_map_update_common on RT.
> > > >
> > > > Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> > > > ---
> > >
> > > We disable softirq and hold a spin lock when modifying the map/hash i=
n
> > > sock_{map,hash}_update_common so this LGTM:
> > >
> >
> > Agree.
> >
> > > Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
> >
> > Reviewed-by: John Fastabend <john.fastabend@gmail.com>
> >
> > >
> > > You might want some extra tags:
> > >
> > > Link: https://lore.kernel.org/all/20200224140131.461979697@linutronix=
.de/
> > > Fixes: 99ba2b5aba24 ("bpf: sockhash, disallow bpf_tcp_close and updat=
e in parallel")
>
> ENOCOFFEE here (which is never an excuse, but at least today is really
> true), but I considered you may want this patch via the ebpf tree only
> after applying it to net.
>
> Hopefully should not be tragic, but please let me know if you prefer
> the change reverted from net and going via the other path.

It's fine. Probably it shouldn't conflict with other sockmap fixes.

