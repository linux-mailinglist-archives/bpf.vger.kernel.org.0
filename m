Return-Path: <bpf+bounces-5795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F94A760911
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 07:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E9A528175A
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 05:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A151F846F;
	Tue, 25 Jul 2023 05:11:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BF7538F;
	Tue, 25 Jul 2023 05:11:39 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.17.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397CF10FD;
	Mon, 24 Jul 2023 22:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1690261865; x=1690866665; i=markus.elfring@web.de;
 bh=gpBzUwIoiVql1RWBRdKwOILlP0A/rHIXkDvD86LDThc=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=L3bK1NkZeOhr530L5md1xY4fyiqjK2b6WCMpeksTQiS9KpXW9KoyAEJ4jnNcMuALYE6bk9O
 W+Leo0qfEdHQURUZF1VQOZLsu/YMyLHtgZLU4o3iwBMfGcun2zyGeB92DukFONl0WmXwl6iSP
 DtU4WxZDTXj3UTjGPTCd/jHOW4ExgntkC5kqYYLfzyHkS5Bveojlf5Nphq16tb210RkvqMfrf
 oHVBE0GKBrxMoZChOOFgCD0ZUXyU1XbL59h+C+0Aw3O3vcDpUI2T3+Lkw4dB5yQF+A3RFFaPd
 hG8kmh71L/I6TVB2eE5rnDosugx3S8RiFC1q/CCSizI3+WshWzVA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLRYf-1qes5y1vE3-00IfnI; Tue, 25
 Jul 2023 07:11:05 +0200
Message-ID: <9a5c27e4-a1a3-1fe5-a179-bfd0072e7c59@web.de>
Date: Tue, 25 Jul 2023 07:10:52 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To: Yan Zhai <yan@cloudflare.com>, kernel-team@cloudflare.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Hao Luo <haoluo@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Mykola Lysenko <mykolal@fb.com>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Jordan Griege <jgriege@cloudflare.com>, Stanislav Fomichev <sdf@google.com>
References: <cdbbc9df16044b568448ed9cd828d406f0851bfb.1690255889.git.yan@cloudflare.com>
Subject: Re: [PATCH v3 bpf 1/2] bpf: fix skb_do_redirect return values
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <cdbbc9df16044b568448ed9cd828d406f0851bfb.1690255889.git.yan@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NBSUsPXsXdwQK2KKtkSbw6CSaYoML4W5xJuP6HG6yzhK9jjeKqG
 h6RU9U0X/5W8gzycOtXF1foUQN2jWRX2sWIJuHH1z3vNcB9eSN819ogY1r6ByrDAzh68e6e
 g2fh/h9LIw0v9+qMqJXpViVvzPDIttn8352Ur8rigbo+eAu6cALhOkc8iKqRxm8zF7P54Jq
 jI0T4kGQ2ZgdjbwX3jHHA==
UI-OutboundReport: notjunk:1;M01:P0:vAO7g8aD+4o=;VO6wgI2e0TV0fOScNGayaloXrPU
 GULxFViRQGG/sqm0FZqdTGvQcpxRWtLBQEauV/IhZOWJxf/g3TaWz7+wmhIkMDKHv8XZ/oQ2g
 I0wEW2pXkGIVS/CxL2/m9Qs+HdwnEHBsJE5qrLCC0dE5KUtZXCS0CUVyHNYC8QlECskbiS4un
 99+2ZgJdfrtv0LzQqX6eugpChk762VoMcd2o4CkrXLqvQku66iqc74X2/e/qPKYcRCyPZFokp
 PXEALY9fjQYs29cziKWs0w3Ron8ksSkvrgzZgVknP4x8tI0AdcfKra4rhBt8nMpRkx6FYRoKp
 x2D9NYOCVmv+qRT6RIg+8LHVlEKY37+Aeb1kTmdLASZvvRoiavlNh1tNW9FDwJM2JIAftAV1z
 +m3AcPkWsF6yhr0Xdr9BG29DVuY1xAc2ZfEpLzJ0sKdszld6B3mcXbynjyOajbAmfRdgc91MA
 DOUGcXG96rpJPdE8DleF4UPVeOZNEV7US+fGFhRoBT39F/XsB5SCCIBFe/l5QPsbjiwvSGdF8
 MibbjK5t/eDB/EFWakgs+KdHjvgqkhLvF9aCy9ITnz9fCsq55Pemc9Jnu74H53YEL9uH/ZHBN
 QIFowuX5s5Si/RVejJLoZsMoQXBhjnwJ9yspMp/pXLi4QUqVPrAPO5kV0b3woo4RBF/CefVco
 ibzmSDo2+AQtZUsvsa9cMugvMVSqgGcGQ/BZnI7pD8KtOsF2kvrjVZOtJ4rEXrkVC8FSYPgiJ
 Ubrfyr25Hh/BY5p/wnjG/z3iVrESYgth7I+8+3Bhw7kyMP7XBitjjqusidbdB3mKN6cgqG1jo
 EnwAwhFt8/i2FsjLbWY80uCRF0IKyNbyHms8F3ojNwa8tOvbYmMGSm8ZW+CQ035PkrUNIuuek
 t+7+5PoNfMu6m5aD+aJRRMPlCQOJO656KEYktuEsONFVrUFk4xR928fbFgW0i/xCLe9oUl9ZR
 ik3KQg==
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>                                      =E2=80=A6 unexpected problems. This=
 change
> converts the positive status code to proper error code.

Please choose a corresponding imperative change suggestion.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.5-rc3#n94


Did you provide sufficient justification for a possible addition of the ta=
g =E2=80=9CFixes=E2=80=9D?


=E2=80=A6
> v2: code style change suggested by Stanislav Fomichev
> ---
>  net/core/filter.c | 12 +++++++++++-
=E2=80=A6

How do you think about to replace this marker by a line break?

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.5-rc3#n711

Regards,
Markus

