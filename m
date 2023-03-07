Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD39D6AE3D3
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 16:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjCGPEk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 10:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjCGPEN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 10:04:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C086189
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 06:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678200925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ElbU57L/U3PTF5WXOvXc6DY97zGTuf4IheYllUu9cI=;
        b=CwRNtEd++bpDzq+wxUzfwOmbiDaHq/55anO5zl58zf+tuEkW+9n1EZjHBMefjeNSGO96DM
        1govn7K6xQSGo+IGp0cux0MnqokC1u1z74xSrX2f37a55Jy/wHyP1eopfB3F9n8ivrBQO/
        5l854bRtHzF+iTfSh94rtoRUVhIxy3E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-aVY36gw_MoKVh0TBtqWHhA-1; Tue, 07 Mar 2023 09:55:24 -0500
X-MC-Unique: aVY36gw_MoKVh0TBtqWHhA-1
Received: by mail-wr1-f70.google.com with SMTP id l14-20020a5d526e000000b002cd851d79b2so2238517wrc.5
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 06:55:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678200923;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ElbU57L/U3PTF5WXOvXc6DY97zGTuf4IheYllUu9cI=;
        b=W/lmA5W0NOw8JVtQDLD3hn7cvBWwh2e0Bz6SA7ac42RFxyNak1NNAbS3Nimstahhae
         CEMT0ZjBweZgj6602p6QdKpU6OyKhrdGcn2OyvhgpOuLzaHx5SzV+Wt6Rw+1OQUaCaVi
         1p7Mh0QSsQmCth7C8vU+VlV6ux0o1gAc4cmo6w4DGQMbLzE/CzPiOIJvOc2UdqxSmmpL
         IAvr+CB3A3PT5+s85yh0wRJAFYVlX+M+RoKswpodx9evXtUjReWWtIToGfM8UQiFdyQR
         rOHHE5wk8k6YDARQi3bVP0NdgkbW3z78+rbrcqP/HfXaukIy05il2I3PucKlnVxU/NMP
         mHKw==
X-Gm-Message-State: AO0yUKX0d5AAZpq/gP2DG3scrs/GSX4yUz+rj3tnIxB+7J0hcGXQvtYt
        H8PzXRx2pDXHH926+PbDbLJ9qXaV7HS5fCdQcyx3a7aAKFbtF+qyvh3L7SkHt1OJwraH7civ7je
        i9mA1IKeY8WVz
X-Received: by 2002:adf:ef45:0:b0:2c7:155c:7dc6 with SMTP id c5-20020adfef45000000b002c7155c7dc6mr9340229wrp.6.1678200923439;
        Tue, 07 Mar 2023 06:55:23 -0800 (PST)
X-Google-Smtp-Source: AK7set8VKxGhgV3M7NpJltZYr2QnvRf/SH346H4TD+CQnL+LgDMcTeGrwFNM91dAuPVzhbzBAypRdQ==
X-Received: by 2002:adf:ef45:0:b0:2c7:155c:7dc6 with SMTP id c5-20020adfef45000000b002c7155c7dc6mr9340217wrp.6.1678200923178;
        Tue, 07 Mar 2023 06:55:23 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-28.dyn.eolo.it. [146.241.121.28])
        by smtp.gmail.com with ESMTPSA id d18-20020a5d6452000000b002c71dd1109fsm12567568wrw.47.2023.03.07.06.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 06:55:22 -0800 (PST)
Message-ID: <2ad119bd1f24f408921b16eb0ebdf67935d1d880.camel@redhat.com>
Subject: Re: [PATCH v3 net-next] udp: introduce __sk_mem_schedule() usage
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jason Xing <kerneljasonxing@gmail.com>, simon.horman@corigine.com,
        willemdebruijn.kernel@gmail.com, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com, kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Date:   Tue, 07 Mar 2023 15:55:20 +0100
In-Reply-To: <20230307015620.18301-1-kerneljasonxing@gmail.com>
References: <20230307015620.18301-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2023-03-07 at 09:56 +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
>=20
> Keep the accounting schema consistent across different protocols
> with __sk_mem_schedule(). Besides, it adjusts a little bit on how
> to calculate forward allocated memory compared to before. After
> applied this patch, we could avoid receive path scheduling extra
> amount of memory.
>=20
> Link: https://lore.kernel.org/lkml/20230221110344.82818-1-kerneljasonxing=
@gmail.com/
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> v3:
> 1) get rid of inline suggested by Simon Horman
>=20
> v2:
> 1) change the title and body message
> 2) use __sk_mem_schedule() instead suggested by Paolo Abeni
> ---
>  net/ipv4/udp.c | 31 ++++++++++++++++++-------------
>  1 file changed, 18 insertions(+), 13 deletions(-)
>=20
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index c605d171eb2d..60473781933c 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1531,10 +1531,23 @@ static void busylock_release(spinlock_t *busy)
>  		spin_unlock(busy);
>  }
> =20
> +static int udp_rmem_schedule(struct sock *sk, int size)
> +{
> +	int delta;
> +
> +	delta =3D size - sk->sk_forward_alloc;
> +	if (delta > 0 && !__sk_mem_schedule(sk, delta, SK_MEM_RECV))
> +		return -ENOBUFS;
> +
> +	sk->sk_forward_alloc -=3D size;

I think it's better if you maintain the above statement outside of this
helper: it's a bit confusing that rmem_schedule() actually consumes fwd
memory.

Side note

Cheers,

Paolo

