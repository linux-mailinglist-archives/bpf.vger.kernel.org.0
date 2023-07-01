Return-Path: <bpf+bounces-3839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F327447DA
	for <lists+bpf@lfdr.de>; Sat,  1 Jul 2023 10:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFBE21C20C78
	for <lists+bpf@lfdr.de>; Sat,  1 Jul 2023 08:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A89441B;
	Sat,  1 Jul 2023 08:01:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E051A523B
	for <bpf@vger.kernel.org>; Sat,  1 Jul 2023 08:01:37 +0000 (UTC)
Received: from mout.web.de (mout.web.de [217.72.192.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BCC1BF3;
	Sat,  1 Jul 2023 01:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1688198456; x=1688803256; i=markus.elfring@web.de;
 bh=od+tv+33dx12fClGo0PBt6qsRgsuK4R+69ZFi5ndcUs=;
 h=X-UI-Sender-Class:Date:From:Subject:To:Cc:References:In-Reply-To;
 b=CC+gIQZJSOHHIepIwCzO2h/fDgqcglkSo+fEScmKzc2aXIFtkHQveodi00NpKQYhA8qAaJh
 snuV/E6jsF+6Qir+qSO3h4p0xx+hY/p94wi31/sPcAx9agMBdDWmxynbrZinxHv5tFXHgnJMs
 1Rz/evpZ+zHv0VtpCOUN+rprZkliV/tqvrA03myn3luSBbM15j1w1ncwUt+dkmMW8P5niXpud
 E12jwooJZMi/MiwiSjuaj6iEyYm0vCQTj9Y3ff5VjdKiN71PHOLdOBX321ptxPabHvJ1wPiYG
 ena9sBZs8t47mDzBx/wtfJLYIZ9LOy6aVLejR7kVkFF7LaT8yVCQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M9qd5-1q9i6c3LzJ-005jgl; Sat, 01
 Jul 2023 10:00:55 +0200
Message-ID: <e1ed15cc-9cf0-16fd-c94c-1b88a402d8b0@web.de>
Date: Sat, 1 Jul 2023 10:00:45 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [v2 01/13] perf parse-events: Remove unused PE_PMU_EVENT_FAKE
 token
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
 <dbf08741-0b3d-f61f-bb06-05ca3f445202@web.de>
 <CAP-5=fXK9dcyycfOfD+a8_qHw+g3vmkd52ZLgwBNfhBFXELLhA@mail.gmail.com>
Content-Language: en-GB
In-Reply-To: <CAP-5=fXK9dcyycfOfD+a8_qHw+g3vmkd52ZLgwBNfhBFXELLhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tqSZAJG4xACZpZWaYqdtG4pX0JUHAHVfEeQVAUSpzzys5pNTp2s
 j5+obWfgyOG949Dea83oBVJUprfbLJTzbEfEspRPXEPPEGnQBX78+GnC8149og9CljkHRFF
 FZMG2yKi6IrMxGzlJzWYHsgBqTa5iJJH32bfxDRhM4YMXu1YuZkeXh4K0VixbuCrSodn91C
 YPgnKrppcxjOGap7V4vJw==
UI-OutboundReport: notjunk:1;M01:P0:7s9ChDg4yzk=;WqKWumzg5VuHBOIjq65ryPBhthZ
 L6Zhv2Y1OSqm+x2OuV/fGNmcG75wyG13bYUO0crdjDD2DCUV9tCJAJKNO0AshC1uV0JvBHvW5
 dD9LA7Vgcst7GNVjYMXvhbXQY7ofoaX0Ih09qZW80v1v8UDNEJ7ub1moJ9isOwzrz1gr+vW/n
 Arbx0QBMazYuAJ4f1LyOdt4fBermjtq87xHfuDsMRD/yPb4LTEvdsksI25EoE7xkEHRcZG/aF
 EhV3x6t+8PTwusDTR93peng566S9d41qBa2JucK7HKimqv7p7eAwZnGIgWsPUyIrhh3+0bEBF
 9Q2VeF0Hm8jwIiHMPomO/zKnONGWACsejOLDXVYrSb7dnCoZyRZUNDRmOLBTFqRhh8xnsvmFO
 enADagud9Bw88Naol2XN1M3oA57JqQBQAskhLNkUchZ6MtvWCkM41LMesuvixsdJEwrwIagcR
 dj7CKaG1eSGDm6muuFvavdNaLh5rktpzGWhEuVDlUcr6UkuRFU/1rlPGkcIzXb/fnXVYN1RCi
 M/6mvgPhQ331v0n2kq322sIVqWVEcfUo5qd9gOkRD83W6Kv9gEfylFegZ7zTAQWKjYI2qRj+x
 g7S+uSKyKpZ0Iare1CsMQ6Fr0JFNQG7WtPxcsDEMpVJovvcxG4JBFhJalBrttf29Jo3eg8BFQ
 0tSInvXN3rX45/hfNsQMA6pes5nt0UFV0Whbxfyf38tP/2R3+1chHAAdOhpzLlR8CwCIpPNbI
 PXwENAMsoVn9VyGsfv4ZhWZnpEH7eJ6SgHfh+FF/0bLh2rej97XNqA7d3okFATtmtWMc7Jzxm
 lkWCHEiVh4TVWxwTGp4QVbur/RBxtJwC1LokoGqX5T//dVPXcBXcZTYgu+QdDqQsLKONWFIlb
 KLmQOGXcuLAsEg95GwZeNY1Xqsmh6R1HZK66USGGuo8q10XvI/bJsxGEFNvaS3tNZegOyd6ls
 GnwDRQ==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>> I got the impression that further possibilities can be taken better int=
o account
>> also for improved change descriptions.
>
> Thanks Markus, I appreciate you feel you have a real point here,
> I'm just not getting it.

I hope that remaining communication difficulties can be resolved somehow.


> Perhaps you can write a commit message that fulfils requirements

Let us take another look.


> like being in the correct "imperative mood"

You chose some imperative wordings already for other changes
while the description for this update step is still improvable.


> and I will learn and improve.

I hope also that further contributors and patch reviewers will =E2=80=9Cge=
t into the mood=E2=80=9D
to share any additional ideas for more desirable change descriptions.

How do you think about a wording approach like the following?


Token specifications were adjusted by the commit 70c90e4a6b2fbe775b662eafe=
fae51f64d627790
("perf parse-events: Avoid scanning PMUs before parsing").
It was noticed that the token =E2=80=9CPE_PMU_EVENT_FAKE=E2=80=9D was not =
so useful any more.
Thus delete its usage here.


Regards,
Markus


