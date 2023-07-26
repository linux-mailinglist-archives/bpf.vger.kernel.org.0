Return-Path: <bpf+bounces-5937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F06AE763599
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 13:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB839281E12
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 11:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3667BE4B;
	Wed, 26 Jul 2023 11:50:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CAC8473;
	Wed, 26 Jul 2023 11:50:08 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57F02D45;
	Wed, 26 Jul 2023 04:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1690372117; x=1690976917; i=markus.elfring@web.de;
 bh=nD+FWTsZoadzpiL8KCRemhvWVh0Pv3+2lvcgthKZ1P0=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=fY2pR94wgve+nmBOGeL46NIMbJfGLntN1U7BWMJbeOQDD7UL9w+bARsz5WaO/Hg6uwbai3f
 JQ0lYnmiEhsqyi4aU7qJFNmqAbhrAs/CyWVtoFvBUkt7Gj1eL4rXl5PmLroKHuGCkveVuCK8K
 fmZr/fMWYn+XC0ADCKOt/10Vn0JkTyOgv75hRMVzI+STdDpLoIgFHeOTWxupSCW8cHgK9h4XL
 PwYCkgDTys5+15OjU51+aGSqI5ZF8ep4/nIDdw313CWJ65e6EIeVTR+eSSh2VetdgV52GaPyF
 u5zCq1Oh33iPXSOx8BKyuEbQRJ4YBr8alw5SoJ9XuAH3NtHMeW0Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9cLR-1pm7Tl3U6X-015bQs; Wed, 26
 Jul 2023 13:48:36 +0200
Message-ID: <e1bb0c93-3b4b-3b25-f1e1-7833600a61f6@web.de>
Date: Wed, 26 Jul 2023 13:48:35 +0200
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
 linux-kselftest@vger.kernel.org, kernel-team@cloudflare.com,
 Stanislav Fomichev <sdf@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Jordan Griege <jgriege@cloudflare.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, LKML <linux-kernel@vger.kernel.org>
References: <cover.1690332693.git.yan@cloudflare.com>
 <e5d05e56bf41de82f10d33229b8a8f6b49290e98.1690332693.git.yan@cloudflare.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <e5d05e56bf41de82f10d33229b8a8f6b49290e98.1690332693.git.yan@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zaAnZafnGKstBzDpEVIMVGadLxDDZJj8afwvKYRcYMHiVQQjRz4
 yKjA5FyYlKlnw2fhMeXN97/0F8gTnM/jbBzpo8ZLJB9eVx26AUjdmYCfvLHuT765H6v7Vmr
 55v1FYjpWQ6sWjVMTnfWsDzpZIC4ys/HNDzUHQt9GjtSwYLBhPpKD2L4Hvp1jrI/AqjLT6I
 J8uaphp/1Je+YoKeXPMsw==
UI-OutboundReport: notjunk:1;M01:P0:I90BWSs0ihM=;OIBww1F0d+ItFMNLrB7Iod4lEWM
 eX5sqqj87qd1JrFgkvzNP7Lfr7NPWe90QLew1EsvKGn3SpyW1cLCR/r+yAfJMj/3ZJIYgQLwL
 w3DN6rdLDkPt6us4pncA/Bm8JAmzm4YHyY89P0VOg6297K0F6zrD10ACPaFKuX+X8bWY3Dva+
 6xwg5OtDJUy/zsvy2sd2STUcQdQJ5UeVBckfQJXTMEmn1rSsrFk0RhMrj0clN3R7wI00K8J1d
 wXZFKW1XC9E/tiW8OLMZpqRXdfhU5w8uSPI3ckcSEnnXwKawxwSS2MvwXlA5NUq7Egx3JG0qX
 SMPthS3ahWjWw8bqAEg9MKMj0JiI7axmuliBK8+QnC89K6Pfi/c5OXDuIVcxK6kMSPESaZbE7
 5oA53AhCxX/kGV3txY9pO7yWDBN5lcnImZkc4KAbgUH10p/oPCOpFPH3Zr+vJX15j81kgUaGB
 df+YXiFkDSwFRHIpCoBO6rBMtlzy04MTt1cZUFAPIal2++OqbwwdTpowtdhjqq0tWv6aFX768
 gH2G6ZTyFEyaXUTsZlECsQSd5bZ02TqZr4BXXPowvIs7eYCjrQjUBT6f0VxlDxoZhvR0EIsZY
 /bBG4OLHS3fmA+8midSuH7JCW/vqxhL9z18lDpFcqBAhr2BIzfYBDPbafXF13FoObnPTepr82
 M611QJ9xZu0779UiBEHfAXacVOkQoxVSb8HvH5K2hoKzpSzdG3KbE/fFXXGYAoj1hsuY32Kgt
 5TkKBdyFrl7rWb1S2lnp1yF4LlZ/dmu+dpcdu9MpJLO5QsmofemJ9PXCmiftl3T7dkWBhur9Q
 fYzooXKWp+93WGvogTSLtooibwKAZtviWMrgM6syMPEkoZLA06EOsYPfjjCOFmxK5fnhJ930T
 opc1ptdqjrbUfMJ6+gBs1HKDow6LXRGQ63dwxr50H3rpYkSvB8kFXZVA7LBG5dBHHgRz/yJSV
 +H7fFA==
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

=E2=80=A6
> +++ b/include/linux/netdevice.h
> @@ -87,6 +87,8 @@ void netdev_sw_irq_coalesce_default_on(struct net_devi=
ce *dev);
>  #define NET_RX_SUCCESS		0	/* keep 'em coming, baby */
>  #define NET_RX_DROP		1	/* packet dropped */
>
> +#define net_rx_errno(e)		((e) =3D=3D NET_RX_DROP ? -ENOBUFS : (e))
=E2=80=A6

Can it become safer to use an inline function
instead of the proposed macro addition?

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.5-rc3#n814

Regards,
Markus

