Return-Path: <bpf+bounces-3940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC141746B97
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 10:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5BCF280D8C
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 08:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070011C08;
	Tue,  4 Jul 2023 08:11:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D002E20E0
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 08:11:06 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC1FE6D;
	Tue,  4 Jul 2023 01:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1688458240; x=1689063040; i=markus.elfring@web.de;
 bh=MbgMZUtDc5LOymBuVB4BFHT9KcCaMcbbhxDpCilF3pk=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=oBfsflY89gRUJ3BtJcb7ccqLlONqosNPjJQe8W0w/uGt/P/nrVfNUHns5jmZc7+hxejmEdu
 +kCPrCo4NQhqreoS0ZyZX1xG0AdWd9+Q173kEq9ygDZSTNl9qlS0/TpTOJkmanviva74W+9K6
 QLtFaqGzmViihZNyo+bf4Exgym4MW/qM7hAQPZMnHwJ35+onldScTt0B4wpZN/5QFgWXf0ET8
 TCu06fgdbFhIGc3wNOCHCorZLn5QTyqho9PTchHZ7uQzhc54QHakJINMnzX6Wdq+BW5vwjVVi
 DEJlojyR79aWm1RIrzWWuowVJX7YDNdnBIe9S+os8HTgiW6Eh0dA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6091-1qMMot2jxj-007Wrm; Tue, 04
 Jul 2023 10:10:40 +0200
Message-ID: <a30aec3c-fb81-4e5d-c131-e59de87a3aed@web.de>
Date: Tue, 4 Jul 2023 10:10:38 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3] um: vector: Replace undo_user_init in old code with
 out_free_netdev
Content-Language: en-GB
To: Minjie Du <duminjie@vivo.com>, linux-um@lists.infradead.org,
 kernel-janitors@vger.kernel.org, bpf@vger.kernel.org
Cc: opensource.kernel@vivo.com, LKML <linux-kernel@vger.kernel.org>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Richard Weinberger <richard@nod.at>, Stephen Rothwell <sfr@canb.auug.org.au>
References: <20230704042942.3984-1-duminjie@vivo.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230704042942.3984-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Gr4ZCxwnyhoYOnwb21965EOD9UzhKJD7CwSw+3kSpNxyjoCCozS
 r+uOxpLUhREiRakKn3e1XP3WVp/FhdY8Sh36t0V6FOS/welkJE4TlMLmEOiD9+/t1Q4nJRn
 L95IifQkAMFRfpHIQlrun9zEqEFFGRNSl/nSLbRbI6BYFGmaS7QdKAKJlIfevqL/RudIIvA
 I+EQvB0dXmGEa4JJi7m8Q==
UI-OutboundReport: notjunk:1;M01:P0:kYSE/kgDd3k=;pm6qATdE/9V8SP38mZT26tP/0dZ
 dJMu9xkJ4MFXCXBMnZ5avnUteo1KOygJVaSzp3vfhkJwbxoPNZs94xpkcnDkKdhWCQ2/stb4u
 1VqNpbc0yuLR+GwspKM/quSFqQ9z6MJYyMNtAqvSVkjO4UxS47CYB6R8r+3yx12BcXf2xdf1/
 4l7rHDX6ck8ZVhzTHaDEqSSGgSsbjnJCIEOk+WfAhcck8isxSZQfeYFN0ApeZZZhCYvifBUbo
 jXq6Esj0tKzT0RJWQC6mQuYRF3mMZOo3Lafu2LPocDgtPX3OmQHrt5G2rC/NCTYoTMNN8C0cs
 hRkKt7SKQZ4J538axWIKqyOGrNx+4NW4zksXiIj5bULWAMHyrKTZ4N/7hYXOO768rdn+INWct
 LOchIkSHw5CWXl6wADBLXID2zy9xZiEbZZmLAr3SbqV4Mo4zKlmhkEiC+L5iZ7ychZO1qEB1V
 Ovf51G9VgG9z9YnyLL2E/TYokyu4ArsvAXMMfQK41Ce3tIQ+nmWHiA+J3xLM/v5bFr9wY5QXv
 R20I99Cg4nqWA0X2lUE1zg27dE0cvnwiJvp2Yu45ARAFae4yNiiibqoO10KyIN1GmZRbE55hI
 83tQ1qBMIPnnYe+SJ+1LAL/Gjd9E7yVZZR6gqvBTXYCzKyB7aeYc9flLwrTVZbYiiCigyyHfM
 nLwKlZ1uYZ9llBEPfKPtQPMkCWbaAZyHoxenxuV7c4wxCCQoQ76DndxuHNjEfcy+WbaHHf8h+
 i0YsOvkv6nJ6vJ09jU62h1gcohGJ6AEgc5aqCokQoxsxjM3smxTsqNSjDyDCACzbYbMho5Qpf
 +x4EwRZUN6AoQTgEIn1vkTnIMl59h3CcA5dTUhGwJC0vu3NJ05f2zM/jdk7NuvE/7uxR4owW3
 QPxyFVGC9IvqCUn5nWAPtxkbkjTQ97HMhh9sWTBhrl21WL+2XyQ2At/0enrvWGNMngA2vhk7A
 27PFWQ==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Thanks for your response and suggestions,
> I made some mistakes. This is a resubmitted patch.

You present a need for further improvements.


> I got some errors with my local repository,
> so I lost the commit SHA-1 ID.

I wonder about such information here.


> Fixes: ("drivers: use free_netdev before return in vector_eth_configure(=
)")

Please provide a missing detail.


> Please check this link to see previous replies.
> Link: https://lore.kernel.org/all/8854675f-99e7-314e-c986-8dc954ee4a27@w=
eb.de/

Would a subject like =E2=80=9C[PATCH v4] um: vector: Fix exception handlin=
g in vector_eth_configure()=E2=80=9D
be more appropriate?


> This patch make out_free_netdev replace undo_user_init,
> fix etherdev leak in error return path.

The resource cleanup was incomplete in the implementation of the function =
=E2=80=9Cvector_eth_configure=E2=80=9D.
Thus replace the jump target =E2=80=9Cout_undo_user_init=E2=80=9D by =E2=
=80=9Cout_free_netdev=E2=80=9D.


=E2=80=A6
> ---
>  arch/um/drivers/vector_kern.c | 4 +---
=E2=80=A6

I would appreciate further version descriptions here.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.4#n698

Regards,
Markus

