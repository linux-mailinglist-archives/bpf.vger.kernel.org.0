Return-Path: <bpf+bounces-5931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8366B76347D
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 13:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE1451C21237
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 11:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4DD8838;
	Wed, 26 Jul 2023 11:05:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF3CCA52;
	Wed, 26 Jul 2023 11:05:10 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8D513D;
	Wed, 26 Jul 2023 04:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1690369480; x=1690974280; i=markus.elfring@web.de;
 bh=FLCeSIuxz94CSbVg9CwPLvDFjixSssv39aj7K6sWUjg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=uJClg2yUBFwML5+OY8m8MEaW8fQJBcNVJ0J9t+9N45N/wE9Z0YZ9NWgSiSWBY6MLShT8Am6
 0kzjJhB5x+A4xyNjZgkIGBFK0Qsr4PghJyhSuhQ2aB+hqY1ydjbURlLIaKYZioDazjVzEAEHk
 G+hpuxghIKgEc5EdAsLy3yVJTwN8y0KdJc7VyMjdZUl68zhZHiUi4HTuEvpHJY4f1smT+7iOS
 7R+KtzTa+LvINgb+eAPzM2qlxAQVZpyxGU8jO/FJzIVwAF6ek4VGz3PjxDqm+Va76oODrIEL1
 XuH7kVuEUjkuq0RRW3dWHlrUvEeZCcHtmHdnPBA81f3L6cXSAzIA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mrww5-1q3nZi45iP-00nwBP; Wed, 26
 Jul 2023 13:04:40 +0200
Message-ID: <8f1b5a70-5b13-4ea9-023b-a5565c07b949@web.de>
Date: Wed, 26 Jul 2023 13:04:38 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [v4 bpf 2/2] bpf: selftests: add lwt redirect regression test
 cases
Content-Language: en-GB
To: Yan Zhai <yan@cloudflare.com>, bpf@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, kernel-team@cloudflare.com
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Hao Luo <haoluo@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jakub Sitnicki <jakub@cloudflare.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Jordan Griege <jgriege@cloudflare.com>, KP Singh <kpsingh@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Mykola Lysenko <mykolal@fb.com>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Yonghong Song <yhs@fb.com>, LKML <linux-kernel@vger.kernel.org>
References: <cover.1690332693.git.yan@cloudflare.com>
 <9c4896b109a39c3fa088844addaa1737a84bbbb5.1690332693.git.yan@cloudflare.com>
 <3ec61192-c65c-62cc-d073-d6111b08e690@web.de>
 <CAO3-PbraNcfQnqHUG_992vssuA795RxtexYsMdEo=k9zp-XHog@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAO3-PbraNcfQnqHUG_992vssuA795RxtexYsMdEo=k9zp-XHog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6NPYqAB0ONHhvb6DUWLW72T0Ny9GfDe+679EJkWtJZG/Pyw966N
 /MH339WQO5FgcTevfq8LOm+qbOhKwV22ZPrW6vAM6qzyn7QxSElP31ZfCc6pi7/sVGMm0Qv
 3kiRUW9y8TFI6IMA3tYtaEgQxK3DkJuL7AHwuHY+Aj6KQVaNQX8XPC4sFwoEhNI9LvgPHgH
 R7efgDsnmA5txlBmFzb5w==
UI-OutboundReport: notjunk:1;M01:P0:MjrQCl57hrs=;Xu/wtT5ruj5/6YTVmreuEN+txaE
 9z6FMg82tC5Lj6zbI8BVp4qnOWgSniN8c1VaBsQivtd9+PH/ZxEdu64pU5+7faGTvP6vy8Fr9
 DDXE5CJzSlnkOPpiNAID0pK0CdgDbe0WkO1sixyx+8gfZFT4Fw3T8+0gcFYmxiE/frE6xqWaH
 t9uXExD0MN/ZCSEJUizse/VLlSzh2OMycPX3+OCyW0KUXXFQ8KEJiCfhNQ8co9qsj9/cBTaLl
 3JFj2v4BIVTIcg7gBXgzlI5dEGuWQBvXI4iq4acXwEzVlMWDsoOirj8HbcUure7CC72iCpi4Z
 rPJ7et42jEW8Vo1b7Jq+JDPeJnJ4Om3qApUlqyMGZvon2e26HgvHvAPSBklMQbXjzodVkDas5
 stB85UAnkhdnIOKOeKOshoSlaDv9giQbsq7padKJjPaedl28baH58YyQbawXnTaiD9Z/62dEE
 inB4m/Mj+UBsV5xXMx1TxT+WrZFLzj5OH+ZD03pkkiNetHP/rOpRJ5cAbh4fMfOskq/+1gcXR
 +gm5pYlkcL7q6FlYr+13hQVy2i5hluid2uw+paTSUHBEfD4zAsscHp02uNkb1Nvv1hLU0SVMU
 0Ss5Enh3U7zgNCmvBKNfuT0nx4CSsgeqth+Z9HFX/XpPUPmPwHg0z4DWuRRy9gdpc24mnTwNB
 ImRigCe1zPQkSqQZJUJRUXsFeBgmOqXZb11hVWp2VmqWgaNTIUdzirlhWEA62qdKfwgcimQru
 2i3C61aA5xWz36ZJ07yDr9KZlTKCu3+q54h6V0Fs7M8MsIocJZMEQnn3C+yqplUVcp2OEv1Cm
 uLpZONSeyiBxIMItSAm89QMTYUre7aJp9zwonATNu5iFDx1Cc36pHJLR/Uzcs9ublAN5jK8Td
 9FDz5RG33on1MvgailquuCoDpZVNOujZiCd/QB6ug5Xt1w0vuSwukgOdGCVYnndJ318H6X7HC
 Lac9+kEuDSK7u5Pg19N1IyrSvcs=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>     See also:
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/Documentation/process/submitting-patches.rst?h=3Dv6.5-rc3#n94
>
> I don=E2=80=99t follow the purpose of this reference.

You picked a corresponding advice up for the first update step
of this patch series.


> This points to user impact but this is a selftest,

The linked document contains descriptions for general Linux development re=
quirements,
doesn't it?


> so I don=E2=80=99t see any user impact here.

Please reconsider such a view.


> Or is there anything I missed?

Yes.

Can you adhere to published guidelines at any more places?


>     Can remaining wording weaknesses be adjusted accordingly?
>
> I am not following this question . Can you be more specific or provide a=
n example?

I interpret word combinations (like the following) also as update candidat=
es.

* lwt redirect regression

* handling are


Regards,
Markus

