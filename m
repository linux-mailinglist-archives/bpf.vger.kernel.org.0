Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B92D668567
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 22:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240611AbjALVbP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Jan 2023 16:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240770AbjALVaR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Jan 2023 16:30:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78B817581
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 13:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673557769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qRZmqvXhb2nF8oyfgDRdsPHD4BOhp1E6vlAaM7IvjKQ=;
        b=B0FH9MA2r3hg2lcxMqWXGEHSXrzXWpG70jKgAL3hR8myK+2AWcseBtJr1emISKexKkUgck
        1VkdwXHpgMBtMgK0/cDFObOXNfqQumUQRxF9hkJt4U44FCUc25hqWQ99g9Gpfha1YJF/nR
        dlYaP9RIHoZNc8fmG4xFW8fEgJKDBTo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-211-BkjKyqeWNW-20zb3R1AlUA-1; Thu, 12 Jan 2023 16:09:20 -0500
X-MC-Unique: BkjKyqeWNW-20zb3R1AlUA-1
Received: by mail-ed1-f69.google.com with SMTP id x13-20020a05640226cd00b0047ac11c9774so13129729edd.17
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 13:09:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRZmqvXhb2nF8oyfgDRdsPHD4BOhp1E6vlAaM7IvjKQ=;
        b=4aGwNFEa87yvAJtRbJDHuGHE4lZ8RAwICIYPnKLFCGmhZ/7B3lZpEulv2s00puM1Be
         aKhpV4qgOHlhebJLKYDPDFoq9nnApz6j44guayBk57K2AweEPzYn5CXZQ4c5/4bFHVng
         g3wG2ELPkzHayXiWSX63v9k+YunfDQXoyjl+/H/HvDLkLocTmODJTCcKLd0WP1iryHrY
         F3BY3ll3dGMZcNQYysoAhHDCI+EE639FP3TfOwA3cnde5WZdDutzxVOXQ+/f3HCKPLJ/
         Mma86iyvj3OPETVlgvS3V2DPNHHxxsf4Yu1qqqLMhDNEVcCL7BLPreuHPTGxTTrBa19G
         O0AQ==
X-Gm-Message-State: AFqh2kr3JJRKlGTo5dFEoKG9bUwbvJbudVKRJG1Gq/gi8gHhXsSCe+9K
        xGHO8zCeWIGPnPgorh0BQaSWLyFkBhuvCkk4kCvQjalOtTgs/B9R9oVhzfFYFkjfq8Of5juGPjY
        K2RxsYr8fRw9i
X-Received: by 2002:a17:907:a788:b0:7fd:ec83:b8b8 with SMTP id vx8-20020a170907a78800b007fdec83b8b8mr68328472ejc.19.1673557759240;
        Thu, 12 Jan 2023 13:09:19 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvnI2Xp7NQNgDDqPzkdNmTMwZjxoSIACaNZJ4Kh+MujVfoi7pKt8VZYEZWPa/tk3CaBBUxymw==
X-Received: by 2002:a17:907:a788:b0:7fd:ec83:b8b8 with SMTP id vx8-20020a170907a78800b007fdec83b8b8mr68328433ejc.19.1673557758922;
        Thu, 12 Jan 2023 13:09:18 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id s17-20020a1709060c1100b0084d21db0691sm7846755ejf.179.2023.01.12.13.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 13:09:18 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 940CE90071B; Thu, 12 Jan 2023 22:09:17 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Stanislav Fomichev <sdf@google.com>,
        Tariq Toukan <ttoukan.linux@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        Tariq Toukan <tariqt@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
Subject: Re: [xdp-hints] Re: [PATCH bpf-next v7 15/17] net/mlx5e: Introduce
 wrapper for xdp_buff
In-Reply-To: <CAKH8qBsUOdRax0m5XM8guudSX_VYpJuMz_mzdMJegDsq4_ezwA@mail.gmail.com>
References: <20230112003230.3779451-1-sdf@google.com>
 <20230112003230.3779451-16-sdf@google.com>
 <a0bac9bd-6772-64d4-8fd5-756ff4d8c2ad@gmail.com>
 <CAKH8qBsUOdRax0m5XM8guudSX_VYpJuMz_mzdMJegDsq4_ezwA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 12 Jan 2023 22:09:17 +0100
Message-ID: <87k01rfojm.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Stanislav Fomichev <sdf@google.com> writes:

> On Thu, Jan 12, 2023 at 12:07 AM Tariq Toukan <ttoukan.linux@gmail.com> w=
rote:
>>
>>
>>
>> On 12/01/2023 2:32, Stanislav Fomichev wrote:
>> > From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> >
>> > Preparation for implementing HW metadata kfuncs. No functional change.
>> >
>> > Cc: Tariq Toukan <tariqt@nvidia.com>
>> > Cc: Saeed Mahameed <saeedm@nvidia.com>
>> > Cc: John Fastabend <john.fastabend@gmail.com>
>> > Cc: David Ahern <dsahern@gmail.com>
>> > Cc: Martin KaFai Lau <martin.lau@linux.dev>
>> > Cc: Jakub Kicinski <kuba@kernel.org>
>> > Cc: Willem de Bruijn <willemb@google.com>
>> > Cc: Jesper Dangaard Brouer <brouer@redhat.com>
>> > Cc: Anatoly Burakov <anatoly.burakov@intel.com>
>> > Cc: Alexander Lobakin <alexandr.lobakin@intel.com>
>> > Cc: Magnus Karlsson <magnus.karlsson@gmail.com>
>> > Cc: Maryam Tahhan <mtahhan@redhat.com>
>> > Cc: xdp-hints@xdp-project.net
>> > Cc: netdev@vger.kernel.org
>> > Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
>> > ---
>> >   drivers/net/ethernet/mellanox/mlx5/core/en.h  |  1 +
>> >   .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  3 +-
>> >   .../net/ethernet/mellanox/mlx5/core/en/xdp.h  |  6 +-
>> >   .../ethernet/mellanox/mlx5/core/en/xsk/rx.c   | 25 ++++----
>> >   .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 58 +++++++++--------=
--
>> >   5 files changed, 50 insertions(+), 43 deletions(-)
>> >
>> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/ne=
t/ethernet/mellanox/mlx5/core/en.h
>> > index 2d77fb8a8a01..af663978d1b4 100644
>> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
>> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
>> > @@ -469,6 +469,7 @@ struct mlx5e_txqsq {
>> >   union mlx5e_alloc_unit {
>> >       struct page *page;
>> >       struct xdp_buff *xsk;
>> > +     struct mlx5e_xdp_buff *mxbuf;
>>
>> In XSK files below you mix usage of both alloc_units[page_idx].mxbuf and
>> alloc_units[page_idx].xsk, while both fields share the memory of a union.
>>
>> As struct mlx5e_xdp_buff wraps struct xdp_buff, I think that you just
>> need to change the existing xsk field type from struct xdp_buff *xsk
>> into struct mlx5e_xdp_buff *xsk and align the usage.
>
> Hmmm, good point. I'm actually not sure how it works currently.
> mlx5e_alloc_unit.mxbuf doesn't seem to be initialized anywhere? Toke,
> am I missing something?

It's initialised piecemeal in different places; but yeah, we're mixing
things a bit...

> I'm thinking about something like this:
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h
> b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> index af663978d1b4..2d77fb8a8a01 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> @@ -469,7 +469,6 @@ struct mlx5e_txqsq {
>  union mlx5e_alloc_unit {
>         struct page *page;
>         struct xdp_buff *xsk;
> -       struct mlx5e_xdp_buff *mxbuf;
>  };

Hmm, for consistency with the non-XSK path we should rather go the other
direction and lose the xsk member, moving everything to mxbuf? Let me
give that a shot...

-Toke

