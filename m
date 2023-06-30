Return-Path: <bpf+bounces-3812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 528CE7440F6
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 19:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 832481C20BFF
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 17:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8C9171CD;
	Fri, 30 Jun 2023 17:15:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58D4171B2
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 17:15:45 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.17.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97A4DF;
	Fri, 30 Jun 2023 10:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1688145324; x=1688750124; i=markus.elfring@web.de;
 bh=PKpF/q39qZ8X5P8yT/hT8FxDlllp8ZI/3686FgAlssA=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=haAHwE1kyvMwaRs3zxRRknnljKY7lbuCyrSwxuZhZa43A5lFP0fRZPxWXRYZyVnyTo4c0qD
 zyvmd6DpsqBO//Dx5wKfL32RXtgAUJgFtYUKE2uI0PoDXTaoH+M3Lmq7YTPX6M4kxOFbhtjjM
 ilozZOBAK2C9Mu7E64GLzJd8Hj+sSaUMqmwA1rMuEMyBcGd3MGAHt7PxXnxlT0YX+8YJdloYV
 LieyeGGk8x7E9qUET3cIQXFou7L57/K3R01StZPz8phmiFkoLmEBqcMhNHZ2dAlkOlY9kM3J9
 385FzsS1ZW+BuzjFvfR7YcBVAISTXv6Q8qMIL9xsXHsx/j+noP5A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgzeZ-1pYFjF0pzB-00gtoz; Fri, 30
 Jun 2023 19:15:24 +0200
Message-ID: <59e92b31-cd78-5c0c-ef87-f0d824cd20f7@web.de>
Date: Fri, 30 Jun 2023 19:15:22 +0200
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
To: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
 bpf@vger.kernel.org, kernel-janitors@vger.kernel.org
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
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAP-5=fVxTYpiXgxDKX1q7ELoAPnAisajWcNOhAp19TZDwnA0oA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OhrL6eDq5fFKOUSyDJJc9BBc26DoOlO9fDd5F5Og+fu9/ctyVmp
 n6gEaKahftKuU7KgUtb5WrNQMGLrQ5ZGaVxhXONnqhjpZmnPgOXOezD7SInB/3KeanWgo6h
 V3B29M8zxM9NtVoOf8inyenxDhAkbUSOBMBte3Agq/Yl6cNnpx2SZVU1z/MJbQFi3/ekAcA
 RuGDbGBvEm49Qt+0B4XXw==
UI-OutboundReport: notjunk:1;M01:P0:F8pMrRMFz68=;+fKi16BxIteSY/RaFOk4AWYNRwQ
 3tlWaZ9hHuLN67VUxPzmE3N+iQV88XxfvjLvR/F2Pq4SKflzjsYgCQT6Cr1nw00BKR1IXSOB9
 Y9SYnDt5k14C0aex1pVIinYhGdH+/Jvqk4OH2gptgThLY4BJwA5T3MCaAGntlgDiShe62GXhC
 C89AV6ht447uXs/8hCyHGRM+fGtTPuRVlhfIJZQMoC3NXMDq0EpUbVBeHarXBhUyMsLp3yu78
 BQKJI6EmOnYjHa9ZHwccG+GBx8Dc1zB2vfEMeAcc8qftdbT+lKs0McV4BJJWaCuIKOQR6qpl9
 TA7WVe7Bf8uAwSMxpRv60DCpQgheLs1l6mcdD6dKNqC54kzxRlvFHheaH+Inj9w1R7HRiFNJt
 nh/nQ/eMT0tc0OP3BJls4tMhUl9/+NYeUT1T/0QtPfkeTYHw1URe+lIzjP3DO3yT98kJo0WLP
 KDSHjGw4yu/jCFK/8UrHHbSK8dRrO4PFJuG+exR8gs0uPBpFgYwMp9ROe+rORjuALZPJ18AuP
 eIeezOZAxC3YdgUo7+czwAF8maC11M2HumC1hB8xbjXUhoX0R1CUAXQAQyjviJfzULoEZpDGe
 yADgy4zzJVjgr8i5ElopeGeEziBhdCEoKZf3DUbqmHVKlEler2kbvdzT/ncar8m8uxleT+21h
 Wdr2CuDhnIXyan1QzZvySBArT8D2jICLA24w3Nfp70OVsUrSxg145m+fBRdQBXuglbqi7Jx3d
 fVhV6Tb0y7kXxA8pLJqNL4pE4ajzXRcnLAAoJvimuU2zAX3xfwpIvCp4cbfJuzGWIsEHkKMJb
 /TyrIYco8APayPqGUfKmA9w2iYCzBj+P7gSrVwXBBatU7EJ7/kcMMPosBo7Zi+gvp3915PtTF
 4/ZFTRLvAKKiH8HojU4Gm2+QGoT80Q2SasoRaBNSxb4qlBrxKDA8Xb1WHS5Oi7klOsPhWMV39
 GweVkA==
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>>> Removed by commit 70c90e4a6b2f ("perf parse-events: Avoid scanning
>>> PMUs before parsing").
>>
>> Will the chances ever grow to add another imperative change suggestion?
>>
>> See also:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.4#n94
>
>
> Sorry, I can't parse this.

Can you take the requirement =E2=80=9CDescribe your changes in imperative =
mood=E2=80=9D
into account for any more descriptions?

Regards,
Markus

