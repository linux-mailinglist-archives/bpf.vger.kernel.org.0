Return-Path: <bpf+bounces-3815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A15744122
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 19:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A4C4280D8E
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 17:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A2A171D6;
	Fri, 30 Jun 2023 17:23:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53760171CD
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 17:23:59 +0000 (UTC)
Received: from mout.web.de (mout.web.de [217.72.192.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A5144A9;
	Fri, 30 Jun 2023 10:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1688145781; x=1688750581; i=markus.elfring@web.de;
 bh=NADSKWIRklWdketOzZfeE6b/U6ZlibXqAvibCfFirEI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=v9fkd//hURWDbXa+SVA76duPbi262svHtsfqDnv2jZKg4NxCBhPO0Cd6cQfdVJd0Ak9ZVZi
 AdWt6lcLHZAQ5pd9lMj5nKrcVuOZPGbpr3czU4uTryiZunBFJ2yThLaQ+KK1Y8hCJ6wbtG3a3
 bsUaib2Pjr78Rmx9AOlvAx1BVJwZH1OAgU+cdSASARvNLIzls+YHi2kKyH/h4+izKRgQkzvNA
 lEdulwdQopbsXhbJFShybI3yB20SLA2FRTBIYFOYOC4kPVa05hvvge6pHz4/tyAb8KkGwxTZ5
 w1IXtyv9n0perOo9xz8QooYFIkq1kwlePwCGBr2HRcEC6QeYBdbw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M6YJ1-1q8Q4i2AjR-006pDe; Fri, 30
 Jun 2023 19:23:01 +0200
Message-ID: <44d77ec3-9a19-cfd5-4bba-4a23d0cd526b@web.de>
Date: Fri, 30 Jun 2023 19:23:00 +0200
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
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAP-5=fX8-2USHn8M4KPfwLz3=AG9kc8=9KdjayMsRexZ87R_EA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZG1kB/OpARyZvapift5fqjZGFv6j8XRpABGEBjm9wt9QlLp07pK
 3nxMnWaNOMdVqGPfgyOCBZbFi5NYV8wxcAHuZ+xgxRhEwitvj36p3UfH8LWWeHAa3O2BSsv
 aaY4ogNqB0fsWFFt15avf/CbWEYkFxYuTmV6zezAwXQSNb+Rx8HWamctfEaWfmObxdnrs44
 srkY6b66AU5O5zDJ20cTQ==
UI-OutboundReport: notjunk:1;M01:P0:opb7WeFpWwI=;+qet0Efv1UGIy6Oi8k836BipYc9
 bqT8ad4FNTextthha7R1J5Yx4w19cTBpqmEmHS8ZGENwSA3hjvx1Fkc19lsorV0pAD2SqCMhm
 bUuZzjflYkl94fuazmAjKgzEVm1hldfqroEJg1/55d0c8MU5QuWSleC6es8ZFKY6GLAGHOqkb
 64KCZsNOZim8gU47JXUJh9TQxg/OUJ3GIiHIf7QLjiC3DBhzpjXSqrfsPEzHLqhBCJB0iAGZp
 z0XaVmo52H29Kr690+raYWv3x6FHzz7eUMq1GMyJENW7WXCWzrsIdfgwYrRunWUl3ahRPTjjx
 /u4RsNhiKIjugYoAdFA15oVmyQ5U80hU18yFiDNoWLZYFdVyomd4ZEPyEUtdB5jDj0LlWZQo4
 PPsBoXTZBuSRY7Nj08Rq9rHcokhrxLWE4YbGAzuG3zpjFnTwYKox9UQvciTjpoCAwxkh2qgDs
 e9QjYi7r+gk8Z8JC77nGwPf0EIc+G5l5ZSPj3kH7PHLShnKnYzulott0lThHqzBxsbRHqlx5J
 hC8V8CjYD+bW70L8cuQ63q9CQk42OmBLN5sGL2ft+8MI+7wSDWAUTzf2KKikIGkTae331ZIfU
 JY5F8dP+iE2Jj7XQuK9cpldkMrs5t/DHUQsFACCB9ih+IoYHjmh4AkfNemJQ9QkzJjnAaVEYE
 dTzTRkKHV94r0VvaTEUNTSKDmIH0DWNJYtyMCRnfOGVM8CLg0PdLvgSq/K3mir+DqbC1pRMxB
 +lvDzVD6vZlap72uSrDRxHE+c5SkDP0RVahrw7aQeJIrErDo7s76Pqtv6gOuUC78+gGfwQ1zw
 FOQGVtnycJ4Q9m/QAT7NGi7zaB9WPMdYOjGFG1kunD1W15QtkrRYbYWz56At8Tihkb0oQsU0t
 4GUvQkBWWZ1X8B5e8+WqmDUbd4p3izuQdEHNaOekYy4PH1ASiJxGpaZUfTaKwdNM0h0x+fYOd
 lXonvw==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>>>>> Removed by commit 70c90e4a6b2f ("perf parse-events: Avoid scanning
>>>>> PMUs before parsing").
>>>>
>>>> Will the chances ever grow to add another imperative change suggestio=
n?
>>>>
>>>> See also:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/Documentation/process/submitting-patches.rst?h=3Dv6.4#n94
>>>
>>>
>>> Sorry, I can't parse this.
>>
>> Can you take the requirement =E2=80=9CDescribe your changes in imperati=
ve mood=E2=80=9D
>> into account for any more descriptions?
>
> Yep, still doesn't parse.

Does this feedback really indicate that you stumble still on understanding=
 difficulties
for the linked development documentation?

Can the mentioned patch review concern be adjusted with wording alternativ=
es
for improved commit messages?

Regards,
Markus

