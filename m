Return-Path: <bpf+bounces-4243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA423749DC3
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 15:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BAA9280D31
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 13:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C529442;
	Thu,  6 Jul 2023 13:31:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF9E8F6A
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 13:31:56 +0000 (UTC)
Received: from mout.web.de (mout.web.de [217.72.192.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E6D1FE6;
	Thu,  6 Jul 2023 06:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1688650263; x=1689255063; i=markus.elfring@web.de;
 bh=zU1+ngJqAXmM8EMrdKQSXHeJ0R/3OXaMxXgWEQx8xiA=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=dRrI9NCZpyFUXPPoXapCdZlS7ikRUA0LUP7KUPqTn86i6CeVaWSFqzMl4m3VGjOu9zQxS2L
 MnLiI/bN4JsEU6ha2OPOBTgz8f44i8Mv1PCTDpfYCZb1/D9uSN/2HL4CSEjyXqsAgty8Pa4HY
 IbPukRralXCqyq7lMQ/0hhjmjen3uZWhYnp2ASvBjU5s/G/TcprVingRPlPjL50/oXDc0sKno
 cfIxXKFO6ZpoX+4WRRG4dpjO2JtjQ+d9F0bYuVXn6pkIRkc8BzbAxZfm9apjOaOyU+cu3b0qO
 b4iFR7asgCYa3Mx4i4ctzubKqV24lxxdHdh3thS2TMmkmPHygRSg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M3Eut-1qInBS23np-003kOi; Thu, 06
 Jul 2023 15:31:03 +0200
Message-ID: <19486cb7-354f-a66d-a5cf-2dab6621eb4a@web.de>
Date: Thu, 6 Jul 2023 15:31:02 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Minjie Du <duminjie@vivo.com>, linux-um@lists.infradead.org,
 bpf@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: opensource.kernel@vivo.com, LKML <linux-kernel@vger.kernel.org>,
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
X-Provags-ID: V03:K1:Q8UYAR2dWW/gVhnhLUdBD7PKRHC8lgJuVkBojDHR5oGBAoH9pHp
 yaWX/eYhSwCQVv/gp70wOY8Qdopp5LJrkV73t8fVS1pKOHTWfkZJO8hwypU+9bDO/0ua/ca
 qKZq0UpZEJLXdb5zjULlZplv+TYvzXoeqGdBgon/rV3Bv+gZTXasH84ocKNHLs4vQ0AmXYq
 UJPUMjQ+B7xqNpn4tj1Sw==
UI-OutboundReport: notjunk:1;M01:P0:2wuXs4dTJP4=;B38QPAXbjFvX2Rq2hVMbB1VNLV6
 wcgw27AmT2xtfa1/sDmyKhO3hBK5EpfxI02rzuaIHUEbbXE+Px27rAnCV8OIif/Z1kp9bgpOS
 v2Zd3M9IpjvXRRzMVYnNNRrMxhweE21L6n7iQma95VsatlOeBsG3nVVOzo6cJYnQ6zg4kcx/x
 9ALh0Kt6oCDd2bqx+LvvpQpwLjiK6OIUhCP3PqSIucDrMItYzEPshp5OomjylOMDHJRHM2EpD
 oIU+bxxABsPWCTrrfytwP3TCyr97EjbAK3VNLjrcH863Aq6glO5QmiAYaD/xw1hdeCKITuYPE
 3hmjb8RMYqy7BEONiHVtm0Q0nNoFwyWtV3JyL02BuXSf+4CvCkNbYPKX0254b1bJmMogytlbE
 A+UYwjKaDhNxNveLyQEhJnblfFtYAccxzTiGCOaXbbrQXSNOS7u0ci0HDSUbfF8MLKahSvd6l
 zblfgETFtumhU/JwQsL3sDfj6ZDfYqr//aP4rE3ogd1VgWnv8yyzaURoGghiCC8rz2JvbdnIR
 40qUuvDqwV+iJ4qTkBFQFt1bG/tX3fYnB4XhzJW4W+Eypj6rvrcYl7U4NRv2+NsIgMCBIcPcL
 FRT+xJdyxxSLBuiY+JhRQIpg7aq5gdnyA/qpRndzTxWgyMgxG63L/uu4zxUIH9USQqHkoniX3
 4i3SLoMtgD+7lYCh8SXcDh9nrfaxrBRabA1CUdUHz8m1DHTze5YUDmgmneJ1JhgDjc36y7Dg9
 xtDGlmIZ5bBLbildFcyR/b2I//+i5c5S1d+aeK177/URgwJqeVUW78J7jG/+pXuNtLI/cK3pB
 Vkzf2KWcHfWWtLTv078osN82XdCCdOabdIfiwyF5t3ImZA5mE7Q61bb8VVw6BOIjdk97zDLBy
 bYU1fsshT3pNGFsGuwhV7fj25C7f/DuU4Wbeup5arBF93RuCbqHenStmoG/tMXzdkUSrcPVTJ
 6sxGEQ7u4baYrWVt5MhfKYPifXY=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> The resource cleanup was incomplete in the implementation
> of the function "vector_eth_configure".
=E2=80=A6
> PATCH v1-v3: Modify the patch format.
=E2=80=A6

Such a version description should usually be put into a comment area
(patch changelog) after a marker line.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.4#n686


Would you like to add the tag =E2=80=9CFixes=E2=80=9D?

Regards,
Markus

