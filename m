Return-Path: <bpf+bounces-3818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA24744171
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 19:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A25FE1C208F0
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 17:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DF0174D1;
	Fri, 30 Jun 2023 17:41:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268E6174C9
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 17:41:20 +0000 (UTC)
Received: from mout.web.de (mout.web.de [217.72.192.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836161BC2;
	Fri, 30 Jun 2023 10:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1688146832; x=1688751632; i=markus.elfring@web.de;
 bh=FAnvwTSUZAuDPRfpNhiM9u/uFKG68Fh4vSOxJQyffyc=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=lK7dusW9onrm3ZEs+Zuki2dIJ08lBAc/ixI5vtV2F044RsoJL6SNvzNYYvQ/V2bvOZ4gTIM
 vZBPSdF9denqc/GlF/zge1+Pk+lK1A+uNjbpxYvOyGoEbWXeYISzpDoGScMVx5EZmcDy8wL2u
 tE5k/MjVTMbkfyZ1P3ozVlRwy5ltTH+DiNwKlv3bkgk8vO5mnjjhHfIHGbu6cE/2VJFX/WcHQ
 6210inqs8G0iF0TzmDNpMyWOj18aFXpUBvEUIul3tl1hziKxSs2NlHqmmzd8KLZSloHKVTjcq
 7Cpi9xmy6Kcnf9MBxseUFynSIvciIvkkSyRKVWol97XOzfpmAHOw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MoecF-1piBDd1fs9-00odZs; Fri, 30
 Jun 2023 19:40:32 +0200
Message-ID: <a3517306-7804-f5cf-6182-ef63b6054647@web.de>
Date: Fri, 30 Jun 2023 19:40:30 +0200
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
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAP-5=fX+kdRujgNAq8SVkkNwgnB383r38+AEmvon1k01R4X=kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nUh5WnulL3jVQlK+pa8SWWryQngovVZZXunkvhg29yd4Cta6s4K
 WjMDV2aM1wpJVwM8bNX4ubM2ZVVjIer7vG3K7jdtVYLr4ulzmP8dMax/NG3xqLcfkediFZ+
 Cpc4dKs6mDTy2rM5lReFW6m9B7AdM1jegDjqL0qQnf0ntO+KnEM8j+Jlrnp5hfiCm7jvOvo
 EJgs7/L0VfpVHcO0r6vew==
UI-OutboundReport: notjunk:1;M01:P0:OQu19h9LtwE=;j8sCM7zFUPDYdyV2eK1es6doA2r
 IYRHeM7M8yJ5+JN97X6pMU+kQWUIQJ7tK+94E0vI7mx9MPBiGodotNP+u7vNTopXGY2yyEGo3
 7zmoYoTIJnTVYC67EZiAn+ohnWdKchcmqSiwoR39LfrYQK4maKRizRgZnYXISb+Ga4sfw5bOg
 SYsp10nYiVYpevC+A+ZvrLVqBGQYNDX77Oe7e0MTr00g7Yrj0M6JqYxMY1Q5knxAIz8NC/2A+
 JQFB/Gamtx67zRQFYHu+UsFZPMzqSQcG3S4SjVGCKV2XIxJuKU6ajTccXrVtsg6NaLZJR/aMu
 nF18AXOjT+3pLGe+U3yH8CVnzx+ixt+HYlK4aEfdxK1HOQfsGFHiteGvxkD4gBVoigaMpx9EO
 Xpat8YwMEQE6M342WASjqy9PB+pgBCaQgNXDufnmR+syr74d9thjulopRTRk7qawrpQVqRMhs
 jXaGsx+czvVfiFyK4cLS2YCGDU2x37tTkmWjoiSMDTs5Dqg7HAUALLrPkTjfaAc4xyL+dk8Pu
 up/XULHPMS22XqATHV9zHI2MxN4y+5GHqILvo0qdybxaMTZtXP+ZQQM03mVQShYS7DUYKAb+z
 hyu5Pqh6tiiIEF4f3TS3Iav02G2mHF3apeUmaCxqm7cYAelLnTekKF6Z4oTABaH21Khfsahem
 1lVj4rT7+Gfbr0Olq07q+68msMbiFTkn0xVqUVnC7Y+F/dfSByTqQ4ycbX9k0pvmF9Z6PgAgY
 3++t049q01bIaHWDA+Q/BhDr9oVbW/ljCZrLD5Wsfia1iR8JJvLgCNICjfeiCunwgYaNdssHD
 w/7YL8C4DrIBnYFmUVUZhdxjLgxBj2t0cJZIt8y+R8atwOdWYfbYmpULShvBMucrQitGJi2II
 QQRSaonHOmlR0QEoRrzeWd5rRgP7zTJNw9i+rAnFd3i1pXuJvphGcCS0oEeSxPUiXvM1UAVYk
 A6IrYw==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>>> Prefer informative messages rather than none with ABORT_ON. Document
>>> one failure mode and add an error message for another.
>>
>> Does such a wording really fit to the known requirement =E2=80=9CSolve =
only one problem per patch.=E2=80=9D?
>>
>> See also:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.4#n81
>
> Sorry your explanation isn't clear.

Do you really find the application of the linked development documentation=
 unclear
in this case?


> Sorry your explanation isn't clear. Please can you elaborate.

Will it become helpful to split the proposed patch into smaller update ste=
ps?

Regards,
Markus

