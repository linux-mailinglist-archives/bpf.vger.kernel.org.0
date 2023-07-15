Return-Path: <bpf+bounces-5058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFCC754792
	for <lists+bpf@lfdr.de>; Sat, 15 Jul 2023 10:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 707DB1C20A98
	for <lists+bpf@lfdr.de>; Sat, 15 Jul 2023 08:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AB71848;
	Sat, 15 Jul 2023 08:57:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF1C7FA;
	Sat, 15 Jul 2023 08:57:57 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.17.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BB62D66;
	Sat, 15 Jul 2023 01:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689411439; x=1690016239; i=markus.elfring@web.de;
 bh=+sOiwBbw8n2XX5b30W6O8rVVhZs/3noaZW9jkV0s7Ls=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=qzCKQjoU7WaHh95jCOcjeiorX+1MY1D5IVyHso1ZMS00+ogDfAEAOQgmxH/kPXQDvXjkXot
 clvWW8bsr7DodmZvFXuxRJxNSy7P4CNTPRrQ+U2osMFFLs6ZfPYd7lHbHK8d5jpJzJwQsWKnh
 SwM0GyyD5sSLRrlEfHNwlBaJYYnwbealVUt+aeWyeujA/9EZiMqNtNrUxt1ewQPwFsdV/84eX
 AMZQa9OPdxmsNhWTOzYeQglgVrwMnU6ucSP+g1NzadbtcRA8X08qiRpp3Dc1bepGprX0N24gn
 dur5zdRalMMAP5HgRc///cSF4N6Hi/b7K7pxEtrZOmGy7qrpZ1KA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MT7aP-1qWN2820IZ-00UQPn; Sat, 15
 Jul 2023 10:57:19 +0200
Message-ID: <c659c7e5-f9ba-ca77-5ec4-10b6d664f4a5@web.de>
Date: Sat, 15 Jul 2023 10:57:15 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To: Leesoo Ahn <lsahn@ooseel.net>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jakub Kicinski
 <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Jose Abreu
 <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <simon.horman@corigine.com>
References: <e75d2a42-4154-e469-bbd7-9409471ab724@ooseel.net>
Subject: Re: [PATCH net-next] net: stmmac: call stmmac_finalize_xdp_rx() on a
 condition
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <e75d2a42-4154-e469-bbd7-9409471ab724@ooseel.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:9pSdoaxreuVjT+rwlLPsZns9ytK0sUm3up92tGth8Lcyq7v5kdc
 kWAJQ9hyl/QzvrHYg0T9waC3ecSHXdkCZsRahgP7j110qIu6f2H67SReOdH3zTxM6YD9yfE
 vPIZIQYHELW3VrAM83LWm1ZUSSsCKdbaCBFvKljgcvmU/Dutp1zpOszTQUmHEoJWs89Xx3F
 znnEzixhvLuCILwIm0pFQ==
UI-OutboundReport: notjunk:1;M01:P0:5hkCjdxvU20=;h2m4glRhfzCGl/yIjYXTOu7hb/6
 os5wwMBwFC7mvlMsX46Z9tEIcLLQrh8kKs5iAgfwjvrVx7iWBydyf6/N1AZYATqOo8o6BQW3S
 RyQprZT5hb3hDVNp/JjHDySdiggi/mPaztB217zc1i8nP4AbW4FsFXP/jSBN7F0SOv/yYpODN
 NChzvlfz5ZGHdVuAt8Cpmi7/HNWksITIybFSDzvS2rVKh/EGVZj7s5hM8FkL6NXzfkxZV8Gz1
 3n2thLeC1cUmMsjVPSPcVQ546k2Ot44GKRX25fQxZupk42ZcGPkszWTnKolKLKhIMgLV2Wn9P
 gWoJvrPXyCffeR9W3Wb8Chly7CVBnjvRlETvMaih1+5ctW1LH+PIlEPpDS3lsbtSfgSXPCQ3K
 z10JGrSKD4c8xdF0Ksmakb3Iar6GD+jQQUK4m/bhaGscq0uUj6Kq1jJ6rG810FYNjDu4l/6ab
 levrguqTP9THD6ixDR8TQRApWwT8YjVPXq8ill0coUtHlWcAJqdqPuBXvmbDvWMnUMCVADeo3
 xteJUt46kL6etHNZGslkVV+SmTNO02uGTlttSR7/DAPrm/VnndkRFmZz8j0w5nc2sveZmbim9
 3t4a0PixZ4SCIcJ4ajxgqQ+Ws3ukBvdRwwDtZqCzlOmMQnShEortaeKfkoC308HtekwA5NofO
 4SVtGqgdNNL1GUs1DU3nBmihovnW4ToZiqubN7V5yP2jXajWzN0GWK6N3DLq+qAeKE6deOpiz
 X47FeSEUuckYFJIfLtFFC+kDy6YSrowgMPh/YQ4R6EwE3Tbgcy35r0u0QI0OikCTVes2TvWC8
 EmHmJbdrCoYEbD8hrTIXs5qeBSPJ9gYJ5OxcW/qQYEo1wioq4HzjRtIzp6mzutBvjQJsc/bzp
 aTPBKxoZplwUbtgdLQM6pAe/un+WsVPftGnmbUefSJcRLETYqJAJRVJr8LAcw7hO4e18EtBzp
 w7nI+w==
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> The function must be called for only XDP_TX or XDP_REDIRECT cases.

Which constraints should be taken better into account for the discussed function call?


> I will edit the message and post v2 soon.

Did the improvement idea evolve further in the meantime?

Regards,
Markus

