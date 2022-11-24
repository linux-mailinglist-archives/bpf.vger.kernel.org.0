Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A274637B8E
	for <lists+bpf@lfdr.de>; Thu, 24 Nov 2022 15:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiKXOkW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Nov 2022 09:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKXOkU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Nov 2022 09:40:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B26C5623
        for <bpf@vger.kernel.org>; Thu, 24 Nov 2022 06:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669300765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8mJnFbVs40A7D4ZzDs8Lc+Kdvts8cL8H9xlqZ07soV0=;
        b=QCW9Ld48vhFwgpLQ9XOjQJHhkxatOIo0cYIxUumo0dXYyrVkcgInIXczEEncVrBJVBpoH0
        +o5OaSJ6gfKeJXNT0yWR6QVfz39YBtFY/dYzWio0HTYgXLyNykF1e00e15c/7OtlU9f7CZ
        xYwYOlxbsSm+WUOO5QBaFafkhRtMXVk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-333-6VyIPb4eOgm38bke-zCrMQ-1; Thu, 24 Nov 2022 09:39:23 -0500
X-MC-Unique: 6VyIPb4eOgm38bke-zCrMQ-1
Received: by mail-ed1-f70.google.com with SMTP id f17-20020a056402355100b00466481256f6so1026580edd.19
        for <bpf@vger.kernel.org>; Thu, 24 Nov 2022 06:39:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8mJnFbVs40A7D4ZzDs8Lc+Kdvts8cL8H9xlqZ07soV0=;
        b=Q/rSS3AQMXPiYsEUT2H/q4IeN5os1Z+Up0fG7szKwyoCERcWvfErtOnYMgRSiWWDfl
         UJuNPmo2DW5lkGvpPIpSZwitr5d0u5cRJdpAiAJPWrNlov4lq5imafz01blhZWwpjPRk
         fLjmChxVV6U1+o3Hke/bpcCJfbS8k5Zf9M+Vb8ox55/Kh+VlMESNxcYzBgA0iQ/qvnZq
         7daMyLppoCHSfTegltZQ7vRKwzAtgOyvvMCSqkDp2a6lPNl62m8caDtD/EDps3yBVHij
         ylctxk7a8fvTV0reHvx1JT4gJh+/qdTZSihWjq/qdww4+ZG/eDD7F0+m/avApVti3ieS
         ZmRw==
X-Gm-Message-State: ANoB5pm63HIQ5BbI7JATsgXPaXSSVu1/S404GnkG5+/m4rmq2xHooRE6
        MBNAnriGe8moWgmYsrQR4QYQLtlYv6HDt1rWMjry1bbEzJFDRSfLYaP9OjKCMpvPJfTb0E7G1bl
        ZcvHpl51SJFai
X-Received: by 2002:a17:906:c56:b0:78d:b8ab:9a5a with SMTP id t22-20020a1709060c5600b0078db8ab9a5amr28088774ejf.454.1669300762372;
        Thu, 24 Nov 2022 06:39:22 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6fZ5Oxr0fBQt/B7kIaDLbn9fUvoou028z3SN62lTwDvqwBr2BEhV/Zkmc3Y7kmH1EV/wI24Q==
X-Received: by 2002:a17:906:c56:b0:78d:b8ab:9a5a with SMTP id t22-20020a1709060c5600b0078db8ab9a5amr28088733ejf.454.1669300762035;
        Thu, 24 Nov 2022 06:39:22 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 11-20020a170906300b00b00781e7d364ebsm483760ejz.144.2022.11.24.06.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 06:39:21 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C14317EB634; Thu, 24 Nov 2022 15:39:20 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     sdf@google.com, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        Tariq Toukan <tariqt@nvidia.com>,
        David Ahern <dsahern@gmail.com>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
Subject: Re: [xdp-hints] Re: [PATCH bpf-next v2 6/8] mlx4: Introduce
 mlx4_xdp_buff wrapper for xdp_buff
In-Reply-To: <20221123174746.418920e5@kernel.org>
References: <20221121182552.2152891-1-sdf@google.com>
 <20221121182552.2152891-7-sdf@google.com> <874jupviyc.fsf@toke.dk>
 <CAKH8qBuF_1UoUPzh_X6FMrJ61zCNDroqSuc-Pp2uH7Q4azmN8Q@mail.gmail.com>
 <20221123111431.7b54668e@kernel.org> <Y3557Ecr80Y9ZD2z@google.com>
 <871qptuyie.fsf@toke.dk> <20221123174746.418920e5@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 24 Nov 2022 15:39:20 +0100
Message-ID: <87edts2z8n.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 23 Nov 2022 22:55:21 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> > Good idea, prototyped below, lmk if it that's not what you had in mind.
>> >
>> > struct xdp_buff_xsk {
>> > 	struct xdp_buff            xdp;                  /*     0    56 */
>> > 	u8                         cb[16];               /*    56    16 */
>> > 	/* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */=20=20
>>=20
>> As pahole helpfully says here, xdp_buff is actually only 8 bytes from
>> being a full cache line. I thought about adding a 'cb' field like this
>> to xdp_buff itself, but figured that since there's only room for a
>> single pointer, why not just add that and let the driver point it to
>> where it wants to store the extra context data?
>
> What if the driver wants to store multiple pointers or an integer or
> whatever else? The single pointer seems quite arbitrary and not
> strictly necessary.

Well, then you allocate a separate struct and point to that? Like I did
in mlx5:


+	struct mlx5_xdp_ctx mlctx =3D { .cqe =3D cqe, .rq =3D rq };
+	struct xdp_buff xdp =3D { .drv_priv =3D &mlctx };

but yeah, this does give an extra pointer deref on access. I'm not
really opposed to the cb field either, I just think it's a bit odd to
put it in struct xdp_buff_xsk; that basically requires the driver to
keep the layouts in sync.

Instead, why not but a cb field into xdp_buff itself so it can be used
for both the XSK and the non-XSK paths? Then the driver can just
typecast the xdp_buff into its own struct that has whatever data it
wants in place of the cb field?

-Toke

