Return-Path: <bpf+bounces-3819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B297441A0
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 19:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32EF2281191
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 17:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02444174DA;
	Fri, 30 Jun 2023 17:52:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A806A174C2
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 17:52:23 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.17.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C25358A;
	Fri, 30 Jun 2023 10:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1688147521; x=1688752321; i=markus.elfring@web.de;
 bh=7fMQgTejJQrtyw0lRthiHunfaisFvXW2eACXGaXi+2A=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=vu1Y2GI+m5wjl0jfEX/2y+KIYyV8s75aok2IQO8xGvUDOHKBCRYlc0xRqBls12hgUZZ0dmp
 nlTyL7zf7muSE7FBNZSfLbphJtwkO+VnvrXLP2WYGhttkGT2gr/uFmkNbO27neLptExzon+Pf
 OncBeLTbJ6B89EHTikrcyHdBHvIWqpzqTcQYcgDgGC4ibrYyKZesfWMU7RjUIwUs4Q6E6J9zB
 jR2J3D+HgB5OIK42gKUmYeOgpKl4W5SagRagnZOm3NTyEruDDv8LddWZcpzQJN+zF/3DVF46J
 7FW2JSynG+GVctzRcHOGsvmjJ7SmXEiKmdEIESXQA0UE2a1spOfQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRW2R-1qRANI30E9-00NGVr; Fri, 30
 Jun 2023 19:52:01 +0200
Message-ID: <dbf08741-0b3d-f61f-bb06-05ca3f445202@web.de>
Date: Fri, 30 Jun 2023 19:52:00 +0200
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
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
 Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20230627181030.95608-2-irogers@google.com>
 <8dab7522-31de-2137-7474-991885932308@web.de>
 <CAP-5=fVxTYpiXgxDKX1q7ELoAPnAisajWcNOhAp19TZDwnA0oA@mail.gmail.com>
 <59e92b31-cd78-5c0c-ef87-f0d824cd20f7@web.de>
 <CAP-5=fX8-2USHn8M4KPfwLz3=AG9kc8=9KdjayMsRexZ87R_EA@mail.gmail.com>
 <44d77ec3-9a19-cfd5-4bba-4a23d0cd526b@web.de>
 <CAP-5=fXjXBSFVDYXw6fXUf35hLDMqS-C4DRC4LWXUcsMNP6gdw@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAP-5=fXjXBSFVDYXw6fXUf35hLDMqS-C4DRC4LWXUcsMNP6gdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iCN341exA5bXbzQaMmVHs4YI3jSObjArugLbMkrdHAJGSSQqDt4
 qqQPKVTbknO4ZP3VhIiqbr9EKF5BsTGhQ0T5hIC3w7G2jDcTwJtCgPIC9GIQ6yiw3L9ZnpD
 CiZdQQ1yXCDcVY1FtWgj7Xr0t8duLvsKkUAdtKIHB/HgjzcSfYcxmqL4I5Sa9c/J0AC38KC
 gr6h7qJ3kksMrzjRImFYw==
UI-OutboundReport: notjunk:1;M01:P0:EAloMHjNawI=;wlPsJrKlJd1Vil2zYGi2YeLsJaj
 ktJbCP2tE8DSO+0xemhS0Cu1Bk3mqYaSbW6zU8YhkJhYCjjxcdi9uzSNSG6N4HTjYxczdu7ez
 EZFEzd3gXCq/9yAdoyyaJ2P6higX+GdLmM14VA1V1goGY3RDmCh9rxfFB5C+4pyXsSz1G3c0P
 7pnkYElHDQMA/ROr+VMD4n5bqyiv8TiXCgxaPFgkiCERRXtZPzDWhOtYwwTrbT2pKPSmr9gq3
 QIbWqB3Vg23hgxW+llLf13vdps1ZUDMQ8jeb7JAqeB2p9OUpR6MDVFgwNtv29ASwnZzpx1GSU
 3/jTaNX1aa8ZBxqyRCYERQpwVF+uGmGYvv6dZdJWnZMW0zeaXZiJdTtuJodCOJXeJeJRUTyiI
 eMFgHsfdk0Qqp40kNV3R3uws56vaHubX6JLP6vqIaYpPBYCFBO4nJbw/cjpjU+T+oEB604BSv
 FMF/rsYcmjN+cSHHOu/tv9mz6jqo4V9EIN4KeqMPP5WO2X5AByUlUP3UoAuLG4NgbPwNiENkq
 SwDhw96SVo5WNJh91GM8FS0sM7yVsiDtjdZnRQildypVgb9dVOTedk6UiygWBdX4jr0OcgVVn
 cy/CxeH6bKiJZYu8elx8rpzCFwhGswhJSwDgRQDwH/sh64DRutolQNaT+cNK845WkxMZ/KAxn
 gJYYTetm7KB4jGIbKLgkP5TQSiKE195+pMm3Sd7HmNHv7bQDqqnS1CeN1D8IV2Tz3dfXERq1p
 TIDuESk0EwDTFFOGgg1tIOA/Rby28JIF+b+dd5NBY9D51qzSPWtf1uwZy6cOplbkOs6yGPCo7
 FbTtMj8E1WKoSYanjC7CzkttvDgGAowkW99l/w+an1D87ZiHnWckbF5UmTbxi5vcxh3hjjjbO
 dLYSXlE6xBqiY6hr7lPOhvzFduAkqbeLbSEBxJMyu14fgW4+xJy1kXhV32+z8RQiHd3MBsJ01
 88yahQ==
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>> Can the mentioned patch review concern be adjusted with wording alterna=
tives
>> for improved commit messages?
>
> Sorry, checked with a colleague and kernel contributor,

Interesting =E2=80=A6


> we don't know what is being requested here,

Another bit of attention for a known information source:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.4#n94


> "imperative mood" makes no sense,

How does such an opinion fit to the Linux development documentation?


> as such I don't have a fix for what you're requesting.

I got the impression that further possibilities can be taken better into a=
ccount
also for improved change descriptions.

Regards,
Markus

