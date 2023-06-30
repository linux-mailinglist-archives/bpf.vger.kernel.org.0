Return-Path: <bpf+bounces-3808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED9F743FE5
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 18:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26FE31C20C32
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 16:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37B1154BA;
	Fri, 30 Jun 2023 16:35:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2E42F46
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 16:35:58 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694CA10D8;
	Fri, 30 Jun 2023 09:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1688142937; x=1688747737; i=markus.elfring@web.de;
 bh=BelvHlE2IketBMTaRXIP4ihfTg9lYEMhg0w2RSTNyp8=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=U94XITzJY/Pfhl/XaHd2K563Ux/YTeTJirCPzYlXGixOVQBbP6DkoayBEPpnyEhqnj2hp9V
 zMaIer8kwyJhk0SOGZAZMiFqZERGHS+d5u/Y7Ks9Tg0loUX5oFK5crS4ypE+X+QHIiNYv9u3c
 khIGC/DvyzTO38iEgxNjCpoI0cv9RB0TDIiaLzsEMm1EUK02L+WstBAKACWvPHaA6rPb8efxT
 YH1t3gE8QpqaCzncJilphwyfA8fa1WwBnZbkTu4Jx6xBayznhg9giDxvFP3a/dZNx8SZIKSfe
 KfQiMh9pgeqfN03SpZjLUPpv+BztUNkBY+9AYsp+sOf/5Mnb5H3Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MWQud-1qYNe60Xb1-00Y2H1; Fri, 30
 Jun 2023 18:35:37 +0200
Message-ID: <8dab7522-31de-2137-7474-991885932308@web.de>
Date: Fri, 30 Jun 2023 18:35:25 +0200
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
References: <20230627181030.95608-2-irogers@google.com>
Subject: Re: [PATCH v2 01/13] perf parse-events: Remove unused
 PE_PMU_EVENT_FAKE token
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230627181030.95608-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:JOAPECTLhKnBYwfhLQOYVzQftbzuFSF80cYfHLD2b8va/pUkYx3
 8OtGiI5odDvWxeznrvGyxKV7HJk2Yf4EVHtdUHUEQZfyUmuVuoKDQ03naOMkxd78pp0GR4e
 qjHZxPqUn8+Lf5Qa4mYMUHxGklqBFQElWTqAi4KSt2Fkab/4T6TRvj2iNtKDKx8YuVqa0C8
 BlXXALexQ8tG9sqf8sO/Q==
UI-OutboundReport: notjunk:1;M01:P0:z6+GpUuQUJU=;VJV88i5zebDTeQ75jXKR2X2Os+n
 mDITObm/4P6y48atvElWq6Hdymf6C7u3Z1kxL2K+CGtXfA/bpom9fG2AFtGyRrHVYELmbB/n4
 41f4aDoB5ohfghWJafJJU/bH1Yf0+ma0CgXdnPE/HC+xxjQDBX13RTvA16GwyjIfHScOI+t84
 qM3Ueo5iTPBfW8RTkdoSfyztPhdvNnf7WUzo1dV8ls/S+PC5gZZ3gzKWmrT5ZD0odhH9MvL3U
 dTXAgpNNfZrFvEG41O0ym8OBOByjA2AT5OJ+GARx3cWtkAKMRhkB5D+O+TXJXOy/J1dprF+27
 HFsndpHkIN2hfzd7clOuMOLduxmV86G3jC+U9t0bv8Q2So6UspTsB3AFoZrlTH/pwUHMhw5pZ
 d60yM+XTR8s9ihis/yNk5I56y3guFGuj9WmZigcqzFg5R1BcmLsvLMjYWrpQi5m/7KepOvaZz
 j7tR5o1UdcjMOUV9zLiI1nVaIyOJYpgQUaXnseqmg9Cao4/jbBJdrH1mkoqj/oxexo+OHzAG4
 G5ZnvGkI3PGOLEoY99/jBoOGHw4rYUYxzl2GZw6N3ybJHPbqPzi+s+W983HtluJ3cwAoiNTza
 l2Sz0Gc7rkHw8KYSpKAMJ8gtQtmuJUDfqiON/9b0EE8lzc/95J8h9r/7PoZXd6PIu10nIbQU8
 u+NpyiqgUB9Oj7BHYd7YhFGn/o/wGI8IV1CEJf2SP8o43sJMY5wg6cjV4HYnxxdcL5j7Da+bb
 Dg8zMq11OZUYfBCo0lCjFl9FZZoZ+TpkTlXGhv4bbo4b2yMvOD6dWvWDSOdH20jlt+8n5ctQm
 sjyvMnsVUjgV2vaoKn7N8RoprdZVcESmQm6owNgAl8pDOrfFz/BDLUR9ksl513aQICmXSDm+t
 t8r16DrmvLxU6QJUvIU5nFQX02LukkWVBGPv8dMUAnXUnxBQhYpsXI04wwjzC2k5AtOB+455z
 ZSzwPfu8mYtm+Hi6QEWGabKhPpw=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Removed by commit 70c90e4a6b2f ("perf parse-events: Avoid scanning
> PMUs before parsing").

Will the chances ever grow to add another imperative change suggestion?

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.4#n94

Regards,
Markus

