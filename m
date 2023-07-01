Return-Path: <bpf+bounces-3844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758D074481A
	for <lists+bpf@lfdr.de>; Sat,  1 Jul 2023 11:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E77E81C2089C
	for <lists+bpf@lfdr.de>; Sat,  1 Jul 2023 09:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C541525C;
	Sat,  1 Jul 2023 09:00:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8C93C1E
	for <bpf@vger.kernel.org>; Sat,  1 Jul 2023 09:00:42 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.17.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D54BC;
	Sat,  1 Jul 2023 02:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1688202017; x=1688806817; i=markus.elfring@web.de;
 bh=TMlrSwNdnj6PaHx4vzRKmjIy5ifTLNTNmocPORSI76Y=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=NDhqpZn4P28yNG+T6TyyoNlBsDuWjFehGkJ4499ZQ4w9amR8nd98WIUTTErX2xTekjMoxui
 ODD8KBfkWe1eAo3o0u5leHR+KZ882VCLzmpEDS+0UGin2E1iGodNHoYqNYW0VZbzwe9tRcLjb
 Jb7hFu18NcxxTDe7/rMw9cLtPEthQT0wrpMXiNrpUhl9A/eeEijqVORxLNbwoFO21KvfC7SOn
 ZvQGVYBa3FmsX18ge/7RbM/LKwByDIe4Fg6x7z6Hu7emav/jUDuBabueSejM1fMUsafWsYwdE
 kLWvnwaEA/abgg2RD2Rbz2KiPaliIvo+Ymk7e9jhxYYnyS3oi5kw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgzeZ-1pYE282veP-00gthC; Sat, 01
 Jul 2023 11:00:17 +0200
Message-ID: <4672c6f8-ef0d-6a36-49be-145629c2eade@web.de>
Date: Sat, 1 Jul 2023 11:00:15 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [v2 13/13] perf parse-events: Remove ABORT_ON
Content-Language: en-GB
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
 Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20230627181030.95608-14-irogers@google.com>
 <ea39aaf0-0314-1780-c1cd-7c3661fa3e7c@web.de>
 <CAP-5=fX+kdRujgNAq8SVkkNwgnB383r38+AEmvon1k01R4X=kg@mail.gmail.com>
 <a3517306-7804-f5cf-6182-ef63b6054647@web.de>
 <CAP-5=fUEa150DYWte2u6M8sejxXXqec_L8GEhVbppJHHq8N5PA@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAP-5=fUEa150DYWte2u6M8sejxXXqec_L8GEhVbppJHHq8N5PA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OJTCO/TCP0OPUUVtoi4kDbQckkjIHK67FMN8dkF2eHAhgrAy7If
 3zhxPQky6hBA0hbDk4/qVEt+lv14ljfvdHik1deL+u5zpoO3UefMZdkRY2Jr4hs0wa9SvK/
 O6IWB7SH5lIjcsUmP3di5fvMAWV2YVo/GX4jgXGenGbvzBNNVm/FoNL1hKHC+F/uEHyPKJ7
 BOXDnq7E49+x58dCGRLuw==
UI-OutboundReport: notjunk:1;M01:P0:mbKYW7jeGM8=;IDA0TJO+tbtw0vaSakdSW2gSY2s
 YXUMr3YqKZeiCYXcluH8ZMtQ/tF5+VFYm6IFeY6STV1BLG6cncAdPhcAqp8nW+RwaIEu4TcfF
 Y2o0izdgGjk1ksmbZuDf2+C6M9em+7/CpNOkxPXT3y4Ep5mjTOEd2raCuWtQfPbV+s6U9vTUQ
 JXSj3Yb+MKfCnRZ5TeZkjRrayXtWBKHGhrbI7yo7WsQ9gK9EgJBHvdqWj2SyUOxnu7Z9Znhtt
 b2O95rWGXzQQWAYWbu9l78wC+Y1B3DEZWYiKIH29eTsxN5Vz5TI/bWJt0oLOogInwH8rQqrdf
 jZ73ahfSHIcYl2awHMcDA+hhanvaoxAuRrqZjDqZWsP38ejPzaeYEE/qyN6zN1fSnVrmXCZL4
 Y8z77folhmoup6K7M7OlwsOtnt7vKzV8CxYWFboYRP6CLghTucG7T2qLzkOGMkJ6HUOiCRl49
 kCN+vv+1ZoaNQHhvQuT7GrqIKnmRKGyX65qBFyVlXG9nAq7cFllXC9gZUw07zCNhOhupZTXnI
 k0EAdtPMmVmaBoBUmIMvFiz/LfLPffMfUcqkUL7OtDNVFNgQWk24dGBYYAHt5tvj8cjIV93oZ
 rP5L5+qgAu4euHtezZpdg54Cihb7ivxPS1EAmUFCwmWG3tGv22wFmjPlXelb98/VRHhk60AVk
 HJIslvsTV65a6jIgbWzkD2nTJjtGtgLqo9oo1usEG73uJzzOQFqTrxrQHAmU30fJavala079H
 NvL7gX63xWkb6bTYzGSpm2JVFgSG0lde7XPeCjWe7kDot51DiF1rZTiStPj2buezX4d5e/DfW
 ZXBteMwcrkNkW6SBdAiqtPBddqa49LLHiFy7nYy9WhhmszQJf2j72KQLZGZbpeUe2lN8z7Zny
 KQf5/NK6Gxsej5vfzLO2yRewe/BRgnwttLKdoochM/sBBeUIJLB5XU31jMPkMXrVKXTjazllA
 qUfoIg==
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>> Will it become helpful to split the proposed patch into smaller update =
steps?
>
> This is kind of why the series is 13 patches long, I'm not seeing why
> you think the following stats qualify as "long":

It seems that we came along different expectations for a desirable change =
granularity.
Intentions influence how known =E2=80=9Ccode problems=E2=80=9D can be adju=
sted (also for this update step).

How should following change ideas be handled then?

1. Deletion of the macro =E2=80=9CABORT_ON=E2=80=9D

2. Addition of a comment for a special check

3. Introduction of another error message for one failure mode


Would you like to adjust the change description another bit?


Regards,
Markus

