Return-Path: <bpf+bounces-3809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC737744036
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 18:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDC291C20C1C
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 16:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF88F168C5;
	Fri, 30 Jun 2023 16:57:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987B8168C0
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 16:57:06 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2333593;
	Fri, 30 Jun 2023 09:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1688144206; x=1688749006; i=markus.elfring@web.de;
 bh=wptbgWOWk72WHJKZOANVJa742d4m2koezZHSc6xcJ70=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=vApsSEliROxnqJnes8AXSzTKK6zTChZX0T4Qx8r8maCO9QL2UUFKWuq5wBPGNhsl6NRnI7a
 M+iGH8c4trHoYdcK9xUzlag463nt4OAk5f8NPHegcJbC9Ap1NJURs48TFEY3dnNBEr+95WGmM
 tiH5wwBLQNQliOOp6WHWaB8snqi/uj6h0H6xp0o/45uNmbOC1usG719kB+R16ViD2LdrX2O2l
 r5HeK0/eX5AnwLzrSte/OsCgDiHUUg7T7Gud/3aEe8YV6NDmE2yJqWdC/ftmUFG6osjY9Z6MO
 chrHXlFbvJyTVKgQ3qoLLc79V/4Wz45GM9yjGVmiodd2N9/K/tfw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7gbW-1q1n7k3EBe-014cvk; Fri, 30
 Jun 2023 18:56:46 +0200
Message-ID: <ea39aaf0-0314-1780-c1cd-7c3661fa3e7c@web.de>
Date: Fri, 30 Jun 2023 18:56:45 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
 bpf@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
 Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20230627181030.95608-14-irogers@google.com>
Subject: Re: [PATCH v2 13/13] perf parse-events: Remove ABORT_ON
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230627181030.95608-14-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Gbs/jyDZZTYYRMmvXbP2iIfOaIUfHVLZ1SL1b+066ES+PXWUCUw
 ZY8ULdcdP4OkGFtZi5i8zvSpRbPmzF0N9jD+vI4M1lFvk2JXBiFeqqVC5Irp7xN8B7ovQvo
 bPDrjvwskOBK54nqK6U/Xj+IR/YJAdBzTOWbkMWYU1d20Bqu4nbvJur6DXfW8BXEe1bp20E
 YVmdQZYB5Wc4P0D5r1o6Q==
UI-OutboundReport: notjunk:1;M01:P0:NjoV0R0S6TA=;dGFom3LgnRrbCa9twVhpS70FlMu
 WfbkjWwPdJx1dqfn/7v+adi+VFgCbx5InL3CiPNbvR0Nk4ffiok+CBH8KuJJxlHLGU8HxWwDO
 h0w5iAgOCAoY06LM9mGPAvctQmsVyO5pZpqCbky+j67ECGk+ZsgHql4yU+mRPAiqt60FQ7M+B
 SoZy7wVdQfgF6MxQbHyqpNjQnhZtKB6NEZ8AnfJYjGBpeYIwCsxDis40CCM/JwjTMKDzS6R+z
 h+6yJH2GJkuU254P1omi28cgdYWJg8RX0bUUxuqzg8nuwj84cknboejOLSl9VpKKBESfG/4GR
 lHVuarOBehXRCoxx51bJYMfwzdP51pr9VOMJEoJ+f9tEY4wljM9evFj59FmmCQdnucZEreIkr
 bgi6zkbq+3mc/VClOxvpiwkP3WXLO4htUU/BqKwWJOjBJGQahoTXahdQvX9Uy7ZnsYVWpRKVs
 uSgc6lHzsS+wIsyemojLjQnTZi58KP1v/B6Od7/5IDneBaL1ADv9QLunTDJNx28PGS5Kq+j5W
 n8NO13q9fSyGo7gyqrWoSioO5Z77HXDGfrZCaLD4qQho7sF63fyNbTe9jzzwxSmq+QJt9zxob
 Zb/Uc/BxAX7s7lbXkd7YdcGD1MVy5yL/vCWy2hhSpu7Nwm0gUumJfCG5tLBZTMluukrMtCaQf
 LQXw6er5JBlN1SipO+xe6oFm9+cOK11q6vwUt0E/BUGMX9UyRWHvaifk0Md2nC6KrIWHOHBsV
 km99xeW8svnf4tMIPyqa/uAj3U4FtZNlBo5l0a/sD8+0sMes2lzB4+umStptGTmYZT3p13W8s
 fGkhGNgJc9q7nPBuSY295Qn4HnvtwC6E6XDLSMpy3cbFV0JawgkdyQ9gzwU1oCeQLtIFUT6+S
 I8alXxZRoUqMcR6VLZA1rQY+QRDKdq1dQUl55NiyHtuw4In40/4YhcoyvpsUMHsYwWwUPtK0H
 fEsec+i5mlQaTrhUpIpkQq6LsXw=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Prefer informative messages rather than none with ABORT_ON. Document
> one failure mode and add an error message for another.

Does such a wording really fit to the known requirement =E2=80=9CSolve onl=
y one problem per patch.=E2=80=9D?

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.4#n81


Regards,
Markus

