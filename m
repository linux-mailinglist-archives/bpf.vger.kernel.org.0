Return-Path: <bpf+bounces-3876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A28745CDC
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 15:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A8911C209A4
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 13:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8E1F9CA;
	Mon,  3 Jul 2023 13:08:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB7EDF4C
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 13:08:26 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.17.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE60DD;
	Mon,  3 Jul 2023 06:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1688389685; x=1688994485; i=markus.elfring@web.de;
 bh=b8VaJayavraY++Dnc8yW/nztDyTtb9hW+sDiuafL1q8=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=egB5swPJbvFwqXcSom0A4QSZyomk3B9DdBd3kPKylLG4ylRw81wKUxA4lfQ7bSNtjMLxHCG
 RVS/1/W0d61/FlKmIyN8wPMRsbvV0QZ1jOZd54swAg4FWXPgepa574WE/78RX7/fG11banMAa
 mfCmUDTQ3UuBp6aOypFz7m5UIOCaMJsngJtfq1BE6azuWdqsnVEreDR2X1gbyDyqTW0+stgtD
 bn62JFqDR/KAR+kfEiBIpt4hBxmTrn0x0e8wr0pM05wLWzvlDiVG/Ccxrh/oahdSFMQOmpMLt
 7ZNCj+hxmBxdbJz12SZvvnxKeBY9dLlCm9336BzA62Qi22GIRe5w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N79N8-1pxS8n0rwS-017fxB; Mon, 03
 Jul 2023 15:08:05 +0200
Message-ID: <cdfd9fd4-da3c-dc0e-460f-97558222d69f@web.de>
Date: Mon, 3 Jul 2023 15:08:03 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [v2 01/13] perf parse-events: Remove unused PE_PMU_EVENT_FAKE
 token
Content-Language: en-GB
To: Dan Carpenter <dan.carpenter@linaro.org>, Ian Rogers
 <irogers@google.com>, linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
 Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20230627181030.95608-2-irogers@google.com>
 <8dab7522-31de-2137-7474-991885932308@web.de>
 <CAP-5=fVxTYpiXgxDKX1q7ELoAPnAisajWcNOhAp19TZDwnA0oA@mail.gmail.com>
 <4eba81ec-14e8-4204-8429-4b686881a9df@kadam.mountain>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <4eba81ec-14e8-4204-8429-4b686881a9df@kadam.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RDG7sEMK0hjj1KKoLzt9G4aVQBv5bedLPwEZz+dV8y4SU+Z5Zht
 RQUMPEvMFbsZXHQUZ529wXDWsQplldtbhZHXlAWgsf5xwuEFVcheNqn2ibj3jN12rM/12Gq
 8aalE8JPCqG6LSssaPMVE2GncbXJw5Ucd/NqQm3pFfvqQPgTORji+aZe7L5doAwfqzV4UR3
 WNX5QDwYe+K1OdxhLC+OQ==
UI-OutboundReport: notjunk:1;M01:P0:k+mTvX5TCkI=;lHKohJOKzLgQKR+Bs3GpzM69U/b
 Zo3DGv8O0mlF5ouIFlxkcZ63Lv6BWHhTPZvmTM77/5t5BB9639DFi2WeQXY6PNLA76nbHAMTF
 j8cO1gz9G+XwVisVe6REJSx8qjWn+Pj6fN7kesyfmcJdQ7jDII96LwYluVXPNjcTc2AHjSAG1
 1Tz3FB4RIOnxRqQb9zjeqf/VIA75fNIlTYobGYx8QM9oSDs9vkuWO0K6SNnQGx2FUQ9Afw7an
 aR9RH7amf51SRI6DEYe3HNDMFCX+E46iCVQWTo3le4MaUZvcm+Y24cHzQmMtn4exNYngRd4o3
 jR1AwLcyWg3gcdWMxabLzGWKkr8ei+GaTzLu5pGmjSxtaixb2eHX6cQfj2ppWXSu7cUhAYzGR
 au/w3KDkImrbqVaGYyu5HqCWdT/ZeefGXOvXiE0FyMvuq2lQxgUPPnWM/K+mw3V7lIZjgwZOC
 I/0cWLWw3JpeFFiFXylSzcKfoSr3TQYx8GQuyYCs/TVSh9IIOnwapQY/0upuHgs7zSUZKIgbu
 WWyOhCeowVldLebFTzv3oBt8/QrKV331eKaTNLEBwaPqHegEu6E91S/OR3UXPOJrJsxj6NpMm
 WAKaEKKBYS4F3Purz9pASLHr9Ii0gPQKbZWageUFYQxMbRMfYKleufkZsV07o3PJfB71OeIpJ
 TDWUzoK8ufB2lQ6zZ1PqQhWZmRiCZsGbnzjpCXMXqx1X3d3AslKnxn4OJGkhZVFeyajYSPgSV
 0gxBnja71Ynq749SDb6HtcKVFpJkQO6FHlo5T0XrgBcqGoLYrK67OS626176OfrRqLbWZWED4
 auk1wggwCuk1zv77NhIBGaV/wjY1NTV8onrp9jIwdAOU0+rMKr5kIzuBR3mi8gTTLcYb8ZIP3
 4EUosW13cCzoyaA0vORh11ZJoXr9tlIrCvKbEKNIu4/el6qVLKHdnlgl2VZJeUiEmvszoyykA
 uhOMBvNIDyH+QgLw+C9feDW1h/Y=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>>> See also:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.4#n94
>>
>> Sorry, I can't parse this.
>
> Markus is banned from vger.  Just ignore him.

I hope that further chances will picked up for desirable improvements
despite of questionable communication difficulties.

Regards,
Markus

