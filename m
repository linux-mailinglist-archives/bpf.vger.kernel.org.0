Return-Path: <bpf+bounces-4242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C332F749D2C
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 15:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3CE71C20D8C
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 13:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D989440;
	Thu,  6 Jul 2023 13:17:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C918F77
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 13:17:12 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.17.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E731725;
	Thu,  6 Jul 2023 06:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1688649411; x=1689254211; i=markus.elfring@web.de;
 bh=fJlXmmzrOj95xU1VQlbv9j2MSr7jZ+WZV76JS7dAp9E=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=mBmBI9kMnPmztdWkReSjAjEq8uIsKlvRoFvR1xMXfyHoJ+/YfClYHh/bvk6BYH8QuJXAsRI
 ZzfwwUht+M9+HLKhIDhV18JV3uhmyD4mB7ny61daRYojw3NJkeuUIWOmjaU5Lg6hUP6h1nZmK
 4epvTlGJ5U4Xy7T8cvXBi+WdI7ZjNRQNTu0bugDEJdwftgfLYOAsnWM6WZzUj7d5HuJG4g0jp
 bC/M7pr4T98kTN2pxHq8p9VIxXkFe6Zet0Uj4TyiPaLfA3qiDymua2ruhuNwwufvtdlRs+gS1
 gS2uD6jEGMNruNKcBEBiIII//18Zqvg5X292EL/TtGQ6OUoh867w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MumJF-1pzSIC0hGt-00rjd2; Thu, 06
 Jul 2023 15:16:51 +0200
Message-ID: <b8e14b6c-da2d-ac6e-7cdb-077b2c2a6390@web.de>
Date: Thu, 6 Jul 2023 15:16:49 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Minjie Du <duminjie@vivo.com>, opensource.kernel@vivo.com,
 linux-um@lists.infradead.org, bpf@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Richard Weinberger <richard@nod.at>, Stephen Rothwell <sfr@canb.auug.org.au>
References: <20230706013911.695-1-duminjie@vivo.com>
Subject: Re: [PATCH v4] um: vector: Fix exception handling in
 vector_eth_configure()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230706013911.695-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+zxh/YLDLGmRjkJRUeka2Do+HFkJNyd5nBqotS+CMLGEpowdfC2
 56FEq4o+q4TLsXDVv1XrEMDYLJhD9TLyAEkNtbffpq+70+8mwAXlLqUG7gt9r3pmbP1644s
 huAnrnlVUtHX5FxfkctCw2ovdd6q6+PRr4D7RmW1ric/p45x2pWNhv85m8WWI3VOrJGlRDF
 oALM1U/TmnDGBil+69g2w==
UI-OutboundReport: notjunk:1;M01:P0:Q+EI21sMTfA=;f05Co5tj4tm7I8SeThT3KRNhKGv
 Vf5zAwzRjl40ZxScPalPI609jsgO+idpeH0rozpCRTT6ZBTbv/Ssx9jcf+zJ2KWQCGZZsrBNZ
 pOBsozHbz1oBWr4PDj0Hm5CEwy5vYFXz6PMIo1ouv0Pv70wJqyLTVdNzXqB4nswsKbwd3JVTl
 GfGWt1mvebsy5dt01i1+6U+uL0EAM89WFoEOvXezWUW+i9/sJFAsXawgOKG9OOajedxaU2v2F
 xKO2K0CeLEFYfuT3slqVnqS2prr3dXGMazuZIGCo1M9sbqyYvFBeLDnCeT/keisJw5sdRtGex
 6KDjwy+upLtRIrQ7W4UGhpikG4+Z35yhagRrXlM3dfrWsUuH28iX2XNSM3IUzycgWLIRP1q9T
 Xz8xrhNh+9YWusKqSM6FoF4W9YB61kR7AjvgCO3eEDB/GVx8K6cyIl4okSHC1w/cN4xwAG8ar
 E5/eoFaNK64v96FrOZoHqyYKrn9tQHyxUtVlkFsCrjyY/+jaD+QZKD7oP8llgj6xsumY5xhWz
 2UMQ9ixlp0C3qUtj8WgvLQ2JCeVE2RNaaHBX65sN+YUJyaF6N8gLMhgr48PRFzZxFDoFiQOsY
 3kKDmdGjeAowd20xKAAD+BfouvTD2VXvXytxEw3rxDhCCPakG8szD/3Hxn0K0jNg3a02qURsx
 KYpt25y7UX15IkN8jc9LvBqrigp7mIqQoNiK9Fyr1xSXsITIkwMWQK66sE1f/k/ABHc+lduHX
 SVfV/pae4b0sptXtkFbP7J+Tqzii9ceKZcCl929LflS01yUHRosnQReYa6UN6W7odN9rmrVVe
 HDwSA038EfKZ3jLsrp2EFnzvah+15kEl9FUwrrW6WKFVxXLlI9hACsaVu3XyB9/E1+q2DjrBW
 fqOv+AIVQGW/H7Ay9lPqOnOJMlAdTRhlcAyJsZr/CY3PcOV1pzYrbij7sAaxVp2Y6AyoT41GQ
 OxAh7A==
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Thus replace the jump target
> "out_undo_user_init" by "out_free_netdev".

Such text should be combined into a single line.
(71 characters fit still into known wording constraints.)


> Delate the orphan function "out_undo_user_init"

Please avoid typos in such a sentence.

* How helpful is the attempt to mention a deletion?

* Would you eventually like to refer to a label instead of a =E2=80=9Cfunc=
tion=E2=80=9D?


Regards,
Markus

