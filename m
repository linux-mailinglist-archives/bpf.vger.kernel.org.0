Return-Path: <bpf+bounces-5912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 712AF762E31
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 09:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D36F281CDD
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 07:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1239473;
	Wed, 26 Jul 2023 07:43:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118729456;
	Wed, 26 Jul 2023 07:43:13 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCB01FCB;
	Wed, 26 Jul 2023 00:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1690357359; x=1690962159; i=markus.elfring@web.de;
 bh=/Cba7IENj/1PiZrrNfL6I9qy31acwecgijBrnKGStl0=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Tq2dfqQk5fZMnGR3QKI2c7p3hYAhBd6CnyAT1O0VeuZjJ4XqjDulczaXwdtvLK8iXHF5PKS
 Ol5BWIwfFwVIUH3x5e2xkTSRqxr5E0merXwifwYFuWeNlxUqBIAAZ7X/V6FLzH6KoWX61Iapz
 2iIt3TYXhdUpYdrVT1uCnN4op8RDeVHBzNvu49dI0/KhyvGl51d9kONbotxV3UuPZiqy1hmlU
 VxZwFSvZaLJN5vr8nVete0gSVisqscFw3VbjCoVBdihSAGBfMaQU6ShfKx0twu01UXN6nqbfZ
 w8PHMG8onWnNA3BVvMV7DJ0ns/OjiO2rZkqFw4SszNcU/zCmbgSw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MNOVK-1qE3Qj0ITC-00P0gn; Wed, 26
 Jul 2023 09:42:39 +0200
Message-ID: <484551aa-8336-fded-cc0c-0611c29aa4f8@web.de>
Date: Wed, 26 Jul 2023 09:42:28 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v4 bpf 1/2] bpf: fix skb_do_redirect return values
Content-Language: en-GB
To: Yan Zhai <yan@cloudflare.com>, bpf@vger.kernel.org,
 kernel-janitors@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@cloudflare.com
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 Jordan Griege <jgriege@cloudflare.com>, Jakub Sitnicki
 <jakub@cloudflare.com>, LKML <linux-kernel@vger.kernel.org>
References: <cover.1690332693.git.yan@cloudflare.com>
 <e5d05e56bf41de82f10d33229b8a8f6b49290e98.1690332693.git.yan@cloudflare.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <e5d05e56bf41de82f10d33229b8a8f6b49290e98.1690332693.git.yan@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KPHvQziJWcP9XK4+FXuSjQUE0NW9jwQbMWhFKVMyXUB+48F7KnF
 Dz0bhEwRf0Ozl40OoWGwggab23uiP5vwAICYoLd8GhSsP3bae0Dben6dc8suoyQ8V6ofa0L
 XkemI/VVeQWweHKC9/HKTumdeUzcqw4loJChhvYOA5+oLyi2Uqwy6FlvlbdYUPWZOVV/UF1
 EhMPqEVrXo+9y/CkkFAOw==
UI-OutboundReport: notjunk:1;M01:P0:bnQolJ42oqo=;ySfKGMmo+h02GjM49Sxv6G1NKPq
 ZS/PqY2Xhuk5fiAhwW9uMixb2QQqIWlQAegXlQd/8njRLZrH7JC2dxMV7kOB1auu5Px+EtcfJ
 rakdgR+w0RN7DeucYRG1yKx5+07VHd88m1q2jpe1DwOI6Z53OUsHMrfDBJplZLOsYNQrpUG3T
 2xEZpnYvHhwNNhiy/ExNCLysftZXgAOhcdaJ/bABCM3caLAn1qghslj6erIP5gMYKlZuIP9Pi
 x9HPoeCbZQsQF69SOOC3nR0/9iKlRKnk3B/CXPoL0RtesNjddwx0wQIlzP07s+qjkqglyBJlV
 kYynNPnKGKsSPiBs2YrSWFO10KdkownxkmpTg5ub+5q0jACho8kbObK/DrXJtsYGpx9PdefwD
 Fv76vcYsM83AJlV8hj3SNvDfhA7FVhFoCn0wDntb66voKSrhKgeISx9f7V09rbdOdu07OoArM
 cWOKSyN6zeloDnZLdMqOwjdi3PVzLsSXTHs33ZonZqJ9NKHi48BMMiiUSbVGapF8i1xA92Lhx
 Y6lyG/WR8tEXj1ykNGGuBpCcjHbD+mpCnx7jG8dn8ChMZFXpeumKqVqALN8AS9J1sN/KkHTV4
 NuuG5QVjUc47IFEnmI8+U3qZSBl8F7YfvcaVXH8gAQwyGjdZLeGadZkee/C7dab8c7zyn5npI
 QepHD9TqjrB/WZrQdPfQIeYg8kNshaMNj1+Z5peIH5XM9kTGl4HjSC03sr8BU6PYEHaX15u8H
 JADHoJtjQOWFzwSQ5rmokMLNT1dQgVPWlbLStOLP/D5Vj/w20ohYDkdM3BlP/i2qKtgognDsX
 Z1xFKtV26WQcxpre0IkthPhxxHCeFV5p1wR7c0PL2PPzex2Yv+mhJN4/6d0v+/Axxy5wHzYHm
 0BFxzB7nnciwskWpjfhR7yqt2PIU2/V+FemShhp4YTtXOnvda1zNwaxxTydx9LWr46enSzJou
 F6oHb6ivxU79LprHGBYe0YdvF0k=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> skb_do_redirect returns various of values: error code (negative),
> 0 (success), and some positive status code, e.g. NET_XMIT_CN,

How do you think about to use a wording variant (like the following)?

  skb_do_redirect() returns different value kinds so far:


Can it be nicer to use a multi-line enumeration here?


> NET_RX_DROP. Commit 3a0af8fd61f9 ("bpf: BPF for lightweight tunnel

I suggest to start this sentence on a separate line.
Can the commit specification fit into the same line then?


=E2=80=A6
> https://gist.github.com/zhaiyan920/8fbac245b261fe316a7ef04c9b1eba48

Can it help to mention here that you would like to refer to
a complete KASAN report (which contains 89 text lines then)?


> Convert positive statuses from skb_do_redirect eliminates this issue.

Would you like to avoid another wording weakness in this sentence?
How do you think about to use the following wording variant?

  Thus convert positive status values from the execution of
  the function =E2=80=9Cskb_do_redirect=E2=80=9D into special error codes.


=E2=80=A6
> Suggested-by: Markus Elfring
=E2=80=A6

I dare to point review concerns out for various software components.
But I did not get the impression that I suggested the patch idea.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.5-rc3#n584

Thus I find this tag inappropriate here.
Would any information become more relevant for related version description=
s?

Regards,
Markus

