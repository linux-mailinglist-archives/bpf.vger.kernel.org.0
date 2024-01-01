Return-Path: <bpf+bounces-18758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C319E821362
	for <lists+bpf@lfdr.de>; Mon,  1 Jan 2024 10:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D74FB219E7
	for <lists+bpf@lfdr.de>; Mon,  1 Jan 2024 09:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D45420FD;
	Mon,  1 Jan 2024 09:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="KBTKypbx"
X-Original-To: bpf@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B9417C9;
	Mon,  1 Jan 2024 09:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704100211; x=1704705011; i=markus.elfring@web.de;
	bh=HLXRLltHUfyafr70c4W+KbfbTYAxtORaeKRu1+nfa4s=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=KBTKypbxeRI11ODKaZc/WtjDaclzDqLRQlWMw1X6jts/rU+tL7fTFAqNX5a5UEX1
	 k7TZWuDgrL7uVJMHaoweGYN5O+ajuIGSe28M/WcOg02Or/UqVsgi3LIlJJ31u+VEX
	 928quQA37dZsHnITuMroVbIESKtoQdZpSKL7M0wuYsnEQY7Cs7SLPKZpyz79OuXfi
	 4nvjn0w91a7ArbGPQjV1e4h7n5/BBTC+DIvF6UqBX6+wNjseltQ4VhCYWGkxoYjSf
	 tMhHXDEDjWpkAzMcX69Y9YhqhCt0XCC2T6oAHXmVaM9KYpvLd6bdrsNTfP107hkt6
	 5w6yEUvlLoVyWwJb0g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Meler-1qmH0I22Mv-00aNBr; Mon, 01
 Jan 2024 10:10:11 +0100
Message-ID: <dc0a1c9d-ceca-473d-9ad5-89b59e6af2e7@web.de>
Date: Mon, 1 Jan 2024 10:10:09 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] bpf: Adjustments for four function implementations
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Yonghong Song <yonghong.song@linux.dev>, LKML <linux-kernel@vger.kernel.org>
References: <7011cdcc-4287-4e63-8bfa-f08710f670b1@web.de>
 <CAADnVQLq7RKV+RBJm02HwfXujaUwFXsD77BqJK6ZpLQ-BObCdA@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAADnVQLq7RKV+RBJm02HwfXujaUwFXsD77BqJK6ZpLQ-BObCdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:su+B1C5CGpMaob4ZRA6yo2u6yjKAcFN7lO1g2bOyxgWIWNdFFfL
 WURRaUgW4wiLT7WqBpXMVpJW4hJ4ezzhBnRQJPKhuFGoKFQ/O4aq297ByxMASkNPRSXvNLQ
 IwKpAQnA/CZQiPuw4FC0zJBtHvZlz65PJfRIAJiWdt2CwmFbana6q4T9BrSzgzQBpqCfn1X
 RP9SR3sageKAEnqzvj00w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ojwleqwWfQ4=;hBbTcOQ7Qnj/GwECcfGj226lcKA
 qUJkD7N4+uGhRMPwGfSzxNk/HwqciJT6UO1i+HqQ2Bxh6qdn9/8RLdMNs7mrGhzAwA+0VP2h3
 dUx6zdP4jVmsizV9mx3iTexwouRwe52/2nLxE7eET0sUTcqAccvPkWf5DpeFu63BzgX9LcD/p
 /k1RbIVqrv7sEWMaE/jNKKw0/nIcGEEDWdhlr3n6Pw/Zk6l+APcSPzgMG1IO19T7vdul3qFMF
 MVaoKJEhwCnakhPyE0hiDzlaDaFTIJ1Py/6Qfex09dobeF5YJY/4DVihzv5uFo5cJ4gEjXnAs
 NuZyXfU56yaYLCcvPszCUHKPXiUp72BITuBl+irEvGfK9DLM2GAua08FvmKhvclFiChUUb8aS
 qlaCXgYsKCAZEgkmR5dfo6WDeUzmSbLGTZkXaUrOJ1T7fqfohnMppYt95D3tDqEtC120eYlqA
 koVtvAcU8wnR5s2sZ2gid2P7ZmbzTa8JcQ0sPFU6CIT++3PiaQG5V6rbE9CYpBPScvoqCiIWP
 DFud369y8NYyQv3u46gBNegRiVQ1O2NRNEGcwLNW88PTsZjQM12rG2a0KF/Ccafv9J/4mdbK9
 /34mStG1Oa5PCR+qDj1bhdQpbESOBh+bPuVn8b61jfi/kzrmeDxJXFP+ijz1QLBJ705zNeLgo
 csIH+6+0zL2bbZA8v3919jUrm4iFNab0gxWkMoSZHJqwAjb1Qu4+yh8qH7KdEMpBFwZuOAzkJ
 a+mK1yRHqdqi12x7I1ibNwVHdU0TzvpyQLrMHFbX0FuEPHn7XJ8XP59FpNTqlgAVOFRyhnJDz
 3d3nPVyF7wRfTgslXXnM7yHRAL2UXq2ec9KU6HDkVAwIhhb0By3PLcIgjqR0LH+cV7X1hqk7w
 rqmpEEYdhi6Ga7x5VRIB6NIx2oFGuYrqc09JNcTfEOGc67CYzRZIeKBS/gxxaS7qoN6Xah6QI
 HcgF/w==

>> A few update suggestions were taken into account
>> from static source code analysis.
>
> Auto Nack.
> Pls don't send such patches. You were told multiple
> times that such kfree usage is fine.

Some implementation details are improvable.
Can you find an update step (like the following) helpful?

[PATCH 2/5] bpf: Move an assignment for the variable =E2=80=9Cst_map=E2=80=
=9D in bpf_struct_ops_link_create()
https://lore.kernel.org/bpf/ed2f5323-390f-4c9d-919d-df43ba1cad2b@web.de/

Regards,
Markus

