Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08886368B6
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 19:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237759AbiKWS1X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 13:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239708AbiKWS0x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 13:26:53 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76B37A345
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 10:26:52 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id g51-20020a9d12b6000000b0066dbea0d203so11732320otg.6
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 10:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxZjY6uw2Em3G53xRNjX7Yz5BdGbdDp2xXgPi2K5u5I=;
        b=BqQX3hXI6U7DtzeBOpFFIfBSHY9lS4Uqg4Xunm/HpEJV9/wnSAXNp2p+K7cD6e2wkC
         1i3emLFOQY+6sLFLSrR6hHW/iru3zOE3HGi64ZW6VLFsT5MvajRUn79Vo7ova6r/MVZ+
         If0iGz3+Cif+Od3X8j1lJ4C15eDJmogdYOJxzQ9wi6ctrmkkicgyIR9WX25v6+Buo/TB
         KsdV18Yq8pfuSMi9/aavmdk4ft50bX79z/vlpHovzcgjvk+hXwxq2AmDerQw+nuOGEZ3
         R+uN25QTGBNS2Nsaq7y9KB+A1sPXDhCraPImpUwIcpfT2e40dHlyHi/5soRS6NgrIbpb
         fE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxZjY6uw2Em3G53xRNjX7Yz5BdGbdDp2xXgPi2K5u5I=;
        b=TRWFyF8zKa7vy+rOUChsYGP/htPHA0O5TMYrS5nEyDftmju9GdDaUAvGMLDpfWT2i6
         O/5kECocw3Wh/f+XfNHTx33yWunMW2eJkzrax5rkQ9W1AES5eLOuqhFWx3UPPR+KLsuU
         Kv7DStD6SjBJOU81fLB0z8W7a+gEtgXlyqaT+a6OBCZREGURfxbfZw76p4j3TI8oNt6p
         t5eob509ErGDjRW79aCQjnu3YblK1sKFkIRm+0F44zHb+x7x1HvXOqhtoCISlfXxv+Fz
         pXaynUPRIfw9nU4R72i9FbDp3fEl3Sq0HvIhCulUi82mTybpNpZsu7nOOdUde52q9pNt
         ULAA==
X-Gm-Message-State: ANoB5pmLftmEt0WR/O3xobeiQUZvMt6iAYnISAqg/VBSTkF8j8aVviWB
        zYa1meOinnJ8SJboHt1AkEpRU7wjrokZd7JUXYtQqA==
X-Google-Smtp-Source: AA0mqf4t1u7CbP4t6YEydv4SOZrmpX7bzb9Yb0ZC52xR1t9Zl1+EAmsnKImYBxyr5Gu1bqCLRd5rg6uuBsyvFA0OFvU=
X-Received: by 2002:a05:6830:18d3:b0:66c:dd29:813d with SMTP id
 v19-20020a05683018d300b0066cdd29813dmr6427677ote.312.1669228011980; Wed, 23
 Nov 2022 10:26:51 -0800 (PST)
MIME-Version: 1.0
References: <20221121182552.2152891-1-sdf@google.com> <20221121182552.2152891-7-sdf@google.com>
 <874jupviyc.fsf@toke.dk>
In-Reply-To: <874jupviyc.fsf@toke.dk>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 23 Nov 2022 10:26:41 -0800
Message-ID: <CAKH8qBuF_1UoUPzh_X6FMrJ61zCNDroqSuc-Pp2uH7Q4azmN8Q@mail.gmail.com>
Subject: Re: [xdp-hints] [PATCH bpf-next v2 6/8] mlx4: Introduce mlx4_xdp_buff
 wrapper for xdp_buff
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        Tariq Toukan <tariqt@nvidia.com>,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 23, 2022 at 6:33 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Stanislav Fomichev <sdf@google.com> writes:
>
> > No functional changes. Boilerplate to allow stuffing more data after xd=
p_buff.
> >
> > Cc: Tariq Toukan <tariqt@nvidia.com>
> > Cc: John Fastabend <john.fastabend@gmail.com>
> > Cc: David Ahern <dsahern@gmail.com>
> > Cc: Martin KaFai Lau <martin.lau@linux.dev>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Willem de Bruijn <willemb@google.com>
> > Cc: Jesper Dangaard Brouer <brouer@redhat.com>
> > Cc: Anatoly Burakov <anatoly.burakov@intel.com>
> > Cc: Alexander Lobakin <alexandr.lobakin@intel.com>
> > Cc: Magnus Karlsson <magnus.karlsson@gmail.com>
> > Cc: Maryam Tahhan <mtahhan@redhat.com>
> > Cc: xdp-hints@xdp-project.net
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  drivers/net/ethernet/mellanox/mlx4/en_rx.c | 26 +++++++++++++---------
> >  1 file changed, 15 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/e=
thernet/mellanox/mlx4/en_rx.c
> > index 8f762fc170b3..467356633172 100644
> > --- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> > +++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> > @@ -661,17 +661,21 @@ static int check_csum(struct mlx4_cqe *cqe, struc=
t sk_buff *skb, void *va,
> >  #define MLX4_CQE_STATUS_IP_ANY (MLX4_CQE_STATUS_IPV4)
> >  #endif
> >
> > +struct mlx4_xdp_buff {
> > +     struct xdp_buff xdp;
> > +};
>
> This embedding trick works for drivers that put xdp_buff on the stack,
> but mlx5 supports XSK zerocopy, which uses the xsk_buff_pool for
> allocating them. This makes it a bit awkward to do the same thing there;
> and since it's probably going to be fairly common to do something like
> this, how about we just add a 'void *drv_priv' pointer to struct
> xdp_buff that the drivers can use? The xdp_buff already takes up a full
> cache line anyway, so any data stuffed after it will spill over to a new
> one; so I don't think there's much difference performance-wise.

I guess the alternative is to extend xsk_buff_pool with some new
argument for xdp_buff tailroom? (so it can kmalloc(sizeof(xdp_buff) +
xdp_buff_tailroom))
But it seems messy because there is no way of knowing what the target
device's tailroom is, so it has to be a user setting :-/
I've started with a priv pointer in xdp_buff initially, it seems fine
to go back. I'll probably convert veth/mlx4 to the same mode as well
to avoid having different approaches in different places..

> I'll send my patch to add support to mlx5 (using the drv_priv pointer
> approach) separately.

Saw them, thanks! Will include them in v3+.
