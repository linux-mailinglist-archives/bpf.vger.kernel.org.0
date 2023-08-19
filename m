Return-Path: <bpf+bounces-8126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8B7781B74
	for <lists+bpf@lfdr.de>; Sun, 20 Aug 2023 02:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49144281113
	for <lists+bpf@lfdr.de>; Sun, 20 Aug 2023 00:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B592629;
	Sun, 20 Aug 2023 00:13:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4263173
	for <bpf@vger.kernel.org>; Sun, 20 Aug 2023 00:12:59 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E9EC48D7;
	Sat, 19 Aug 2023 14:01:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 81DC4616B2CF;
	Sat, 19 Aug 2023 23:01:28 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id R-xTUNX53BfU; Sat, 19 Aug 2023 23:01:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id DC29761989EF;
	Sat, 19 Aug 2023 23:01:27 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XlOXJxBLBgRp; Sat, 19 Aug 2023 23:01:27 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id B585963DB7EA;
	Sat, 19 Aug 2023 23:01:27 +0200 (CEST)
Date: Sat, 19 Aug 2023 23:01:27 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Minjie Du <duminjie@vivo.com>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	opensource kernel <opensource.kernel@vivo.com>
Message-ID: <888265629.6490567.1692478887611.JavaMail.zimbra@nod.at>
In-Reply-To: <20230706013911.695-1-duminjie@vivo.com>
References: <20230706013911.695-1-duminjie@vivo.com>
Subject: Re: [PATCH v4] um: vector: Fix exception handling in
 vector_eth_configure()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: vector: Fix exception handling in vector_eth_configure()
Thread-Index: 4vytQNC34nzS2LWCFohj3c7c7cYvzA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

----- Urspr=C3=BCngliche Mail -----
> The resource cleanup was incomplete in the implementation
> of the function "vector_eth_configure".
> Thus replace the jump target
> "out_undo_user_init" by "out_free_netdev".
> Delate the orphan function "out_undo_user_init"
>=20
> PATCH v1-v3: Modify the patch format.
>=20
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
> arch/um/drivers/vector_kern.c | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.=
c
> index 131b7cb29..7ae6ab8df 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -1646,7 +1646,7 @@ static void vector_eth_configure(
> =09err =3D register_netdevice(dev);
> =09rtnl_unlock();
> =09if (err)
> -=09=09goto out_undo_user_init;
> +=09=09goto out_free_netdev;
>=20
> =09spin_lock(&vector_devices_lock);
> =09list_add(&device->list, &vector_devices);
> @@ -1654,8 +1654,6 @@ static void vector_eth_configure(
>=20
> =09return;
>=20
> -out_undo_user_init:
> -=09return;

I don't think this is correct.
vector_eth_configure() cannot communicate the failure since it is of type v=
oid.
So, vector_remove() will run and will call unregister_netdev(). That can ca=
use a double-free.

Thanks,
//richard

