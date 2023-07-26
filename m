Return-Path: <bpf+bounces-5916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4388762F5A
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 10:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20FB21C21126
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 08:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805DEAD24;
	Wed, 26 Jul 2023 08:10:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF349460;
	Wed, 26 Jul 2023 08:10:51 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AEF72A0;
	Wed, 26 Jul 2023 01:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1690359023; x=1690963823; i=markus.elfring@web.de;
 bh=9zeE47CQClpui9T96duoFJfvV0RYj/exVKII3SPbVpo=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=FOM7O6VtdATtLsHLzQ5cnHqo3xAzliQUS2SLJrrHeTAZaPYeMFieL6QSoUewhyUo5lusmJs
 gsVDzlQpWa2CuU4bloE4XZS2y3Vxxpm1nRF8NxtpM06Dy1tqaaGsKSYWX3ygbtzcizyRiCY44
 seLsWgRvoJFtjOlhte0ONk+uDbqH8ALSIsYUMEfHNspiy2hh5s+twWte0dS45GrccLMHMC2V6
 XRa5oQNNmwPRxOIkCBdgnFI0PIQ08CFj+93RAu9n6mcxJfAIsmFfgEIYhRtqZ0Wbz+8eBK6zn
 IK4wGnucDwg3vb6teqku0cOBG0dmLzxbDUHljxktrGUJdBk91fjg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MdfCH-1ppVte06Ub-00ZeoF; Wed, 26
 Jul 2023 10:10:23 +0200
Message-ID: <3ec61192-c65c-62cc-d073-d6111b08e690@web.de>
Date: Wed, 26 Jul 2023 10:10:21 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v4 bpf 2/2] bpf: selftests: add lwt redirect regression
 test cases
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
 <9c4896b109a39c3fa088844addaa1737a84bbbb5.1690332693.git.yan@cloudflare.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <9c4896b109a39c3fa088844addaa1737a84bbbb5.1690332693.git.yan@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:pj8bYFrr+T3faUy5NZlWjXv2NPDIRmUQWtxL9xKwPOvKs99pbcs
 D2uUurD+uXBNNqKLieZCh3Ufu+ghC02Ln4zsX8YBms7oBPb83ESI7jSU8nc3yauayZ15/aU
 q5VTdfeoDt/B/AJubkAD8pIE25nlpKtkWoz4hImvkMDX30uXr920NuWB/Wa3YpfGvsU6Px0
 Gq2Z+wvHkNeiNd51z82gA==
UI-OutboundReport: notjunk:1;M01:P0:VxgsZFPivOo=;haeOKWsM2w5fG9ZAAjd3/riqtaS
 /kPDKUXa1Q+MHGrNHe4uq+ClY4QEAeGOywvPdPC1wcAHeFxjsQFX/VDbYRllAeygB8YpAxahj
 Dvb7/4mZ429+J08JcnjhLRsJHA2cDyiz78daXiDLRuHnEjusHUa/Py/bj12r9CgE8WfZ8ox3O
 4U/Av47sCMqwauh6q93aZAhzxbPN4+wLh7KWi9/4wyy5RiARW3QoQwil7v8LK6hoiq6siN2l0
 s8IT5+xpYsU9dhLAba8dFD5zbtDzAkdX8ULvAs6MF72QczqY6OQfO9Ilzguyd0VYePobc7MWN
 NNcYXab5bU3zpbaEfilCVM7hkzCobCGpwl0LL2k7+bZ8bxuqWZ8n/5m6/QYAJAoAXmiLlCJHD
 mUn9PQJaQogrh2yNcDWT80VmyNHChd1T7RuIzc3xVGV6/yagrRsh0y3Ql+98SHBqLFr6VG3EK
 oQWBQAsib7UGxxh8ljjJZoV0ytmU+SbhsiLMjQIFr/Z1VopIqT1jsUJUzwpI+4JLBaCkUk6QT
 n6CuvhQAMWGdT6c18Gy9+JPTL9a2kBy9n1MeBWs/Mdj5srF0cYL1hxHuCLFbqGtc+7R5HqReI
 4zu3PBmn38yjnrhpNd02q+y6EmIAG1/46J1Rq/fvJehUTh5uKuBVBEDkh0iLBDLhbzmtSDkLJ
 YFyJzqA+l053M/bXPyS0iP55dHa2A3OusJcQt/H2GDmbVBN31DyOPaquqncqXq0cFBiXzBM0R
 /bMt+EjDKBWYA0/JEgleJ1b/DB7h0nbu2gHKq/LkHUmlA4JejfNqD2lCVRmkcCkQRQLOv2I+B
 jXWT7SDCBtg9P6UmhNwMJewDhktMNZWE+3PUVKPIcZCbT8GQHNbj9jDn63sjUM+Atljo3WX53
 AAun7gznPkqfUcsZgnRBlIwoayedwt4OkvhKvFUyG3WoFdL5Llp1WcJfbOI7CDOh7A4VcFVsd
 uRtv2Pg717rex+V6R+zBkS3Np/o=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Tests BPF redirect at the lwt xmit hook to ensure error handling are
> safe, i.e. won't panic the kernel.

Are imperative change descriptions still preferred?

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.5-rc3#n94


Can remaining wording weaknesses be adjusted accordingly?

Regards,
Markus

