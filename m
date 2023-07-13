Return-Path: <bpf+bounces-4893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B68F675161B
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 04:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 249782813D3
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 02:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689C4650;
	Thu, 13 Jul 2023 02:15:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE6F7C
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 02:15:36 +0000 (UTC)
Received: from out-1.mta1.migadu.com (out-1.mta1.migadu.com [95.215.58.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163DF1FF7
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 19:15:34 -0700 (PDT)
Message-ID: <686c4836-dc67-a272-3c21-aecf821e799c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1689214532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aIMtN5gaDP+mnj+2rNGuNIIZz51tMTiqAC/DKwXneLw=;
	b=cA8rwOSEOnUZPp2dtLDyQXqk9jDjAoq5+xob2o0gqOMtjiLEqEqJXbtlM/JruxfLxp8wZb
	M6sizxGEwQ1qPVNZq8ZQQduDl7aW5fkAGVgrDRRoqAptQL5daXLcoW/1mqM8LCqIInIjVg
	iDXiZdwPAMl6VJzFrX7uKZGsSlPW4B0=
Date: Thu, 13 Jul 2023 10:15:22 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] libbpf: Support POSIX regular expressions for multi
 kprobe
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 bpf <bpf@vger.kernel.org>, liuyun01@kylinos.cn
References: <20230712010504.818008-1-liu.yun@linux.dev>
 <CAEf4Bzay5QC_pbH-Km-oqL8MzzyUCtKU3Xc2Jie5bbRc=PBi5A@mail.gmail.com>
 <CAADnVQ+KwbRo0QsNOZPVW2Xpn1x5=N6pNL1MwKGrNnbbtTX3Lg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jackie Liu <liu.yun@linux.dev>
In-Reply-To: <CAADnVQ+KwbRo0QsNOZPVW2Xpn1x5=N6pNL1MwKGrNnbbtTX3Lg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



在 2023/7/12 23:04, Alexei Starovoitov 写道:
> On Tue, Jul 11, 2023 at 10:42 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Tue, Jul 11, 2023 at 6:05 PM Jackie Liu <liu.yun@linux.dev> wrote:
>>>
>>> From: Jackie Liu <liuyun01@kylinos.cn>
>>>
>>> Now multi kprobe uses glob_match for function matching, it's not enough,
>>> and sometimes we need more powerful regular expressions to support fuzzy
>>> matching, and now provides a use_regex in bpf_kprobe_multi_opts to support
>>> POSIX regular expressions.
>>>
>>> This is useful, similar to `funccount.py -r '^vfs.*'` in BCC, and can also
>>> be implemented with libbpf.
>>>
>>> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
>>> ---
>>>   tools/lib/bpf/libbpf.c | 52 ++++++++++++++++++++++++++++++++++++++----
>>>   tools/lib/bpf/libbpf.h |  4 +++-
>>>   2 files changed, 51 insertions(+), 5 deletions(-)
>>>
>>
>> Let's hold off on adding regex support assumptions into libbpf API.
>> Globs are pretty flexible already for most cases, and for some more
>> advanced use cases users can provide an exact list of function names
>> through opts argument.
>>
>> We can revisit this decision down the road, but right now it seems
>> premature to sign up for such relatively heavy-weight API dependency.
> 
> regexec() is part of glibc and we cannot link it statically,
> so no change in libbpf.a/so size.
> Are you worried about ulibc-like environment?

uclibc has regexec too.

https://elixir.bootlin.com/uclibc-ng/latest/source/libc/misc/regex/regex.c

-- 
Jackie


