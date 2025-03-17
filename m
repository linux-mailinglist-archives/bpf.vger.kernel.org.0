Return-Path: <bpf+bounces-54241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32976A66054
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 22:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20B383AA02E
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 21:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4194C20299D;
	Mon, 17 Mar 2025 21:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgUgXRwV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D4A54670;
	Mon, 17 Mar 2025 21:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742246366; cv=none; b=YXpBbjvpV2xVRHCCOAfsmKXA1ZNHOjmuDg/U5a0gJbdtgXvPmngBWm8CQ2X3Ok2bFlW61TIQDPQRcrUX67jHaV6QOHKI0lkEdTOJEx6DC8cyrsfYyw6d4Kzjb9z93n7hfOCxZ+f4bcWYxSsYsrYAPcV/NjLNtjufN2JKn+Dd8Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742246366; c=relaxed/simple;
	bh=yxOJ65p4SAnE0Ir7dTqcv9g7ATU7SmbWT29NkJuH8BA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F6igaulZHn5/LwdfhL4NTZlbfb9HFgQcmmjj9YiOVouiDiisX7ZVhvDR6Nfc76G7nulF/fkUEKoWD9qLJs25DpYu4HvVzEa7atW3a+hsN3k9K0YByO/q8k3TqtcGlIvf/b81gthg/KQdj8Hkvc6kWjJAKpAjpe+PP+fueClzkqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgUgXRwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DDFFC4CEE3;
	Mon, 17 Mar 2025 21:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742246366;
	bh=yxOJ65p4SAnE0Ir7dTqcv9g7ATU7SmbWT29NkJuH8BA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qgUgXRwV69Nt7k3tS39yXyXMdldqU28UP+PtwBMatgfeffOfA5/oHb56jjgdcyxm/
	 JSGRh83BxwutSnS40H41FN22i3wiENJS/dURZ3QjAjRHXeQG1UMqDT2HVcc79oBvMw
	 vET5PfeOtb2f+b5dq+iwwdVPOK5J+pDe1JXaD9jjDP8DwVr5tpS0ev5oM5mzqDbZnv
	 ai2u9v9ej5kzSJD99oA46h0kZ3R1oPFMxv8UODWo/IX8tL8mkrTsCX3RKrQYklEMUu
	 YO6BRjjTOzO5YIGpehdDeTsx7RuknHnK/zXPyN9Y0IP9bCUcV1+H7bMrAIfj+kVJi4
	 Oe1CcOBuXZfsg==
Message-ID: <c4f4a1d0-aed8-4b09-a3d2-067fdd04bed3@kernel.org>
Date: Mon, 17 Mar 2025 21:19:22 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1 next] tools build: Remove the libunwind feature tests
 from the ones detected when test-all.o builds
To: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
 linux-trace-devel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
References: <Z1mzpfAUi8zeiFOp@x1>
 <CAP-5=fWqpcwc021enM8uMChSgCRB+UW_6z7+=pdsQG9msLJsbw@mail.gmail.com>
 <Z9hWqwvNQO0GqH09@google.com>
 <CAP-5=fWCWD5Rq5RR7NSMxrxmc1SUkK=8gg+D-JxGOgaHA7_WBA@mail.gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <CAP-5=fWCWD5Rq5RR7NSMxrxmc1SUkK=8gg+D-JxGOgaHA7_WBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2025-03-17 10:16 UTC-0700 ~ Ian Rogers <irogers@google.com>
> On Mon, Mar 17, 2025 at 10:06 AM Namhyung Kim <namhyung@kernel.org> wrote:
>>
>> Hello,
>>
>> On Mon, Mar 17, 2025 at 09:10:29AM -0700, Ian Rogers wrote:
>>> On Wed, Dec 11, 2024 at 7:45 AM Arnaldo Carvalho de Melo
>>> <acme@kernel.org> wrote:
>>>>
>>>> We have a tools/build/feature/test-all.c that has the most common set of
>>>> features that perf uses and are expected to have its development files
>>>> available when building perf.
>>>>
>>>> When we made libwunwind opt-in we forgot to remove them from the list of
>>>> features that are assumed to be available when test-all.c builds, remove
>>>> them.
>>>>
>>>> Before this patch:
>>>>
>>>>   $ rm -rf /tmp/b ; mkdir /tmp/b ; make -C tools/perf O=/tmp/b feature-dump ; grep feature-libunwind-aarch64= /tmp/b/FEATURE-DUMP
>>>>   feature-libunwind-aarch64=1
>>>>   $
>>>>
>>>> Even tho this not being test built and those header files being
>>>> available:
>>>>
>>>>   $ head -5 tools/build/feature/test-libunwind-aarch64.c
>>>>   // SPDX-License-Identifier: GPL-2.0
>>>>   #include <libunwind-aarch64.h>
>>>>   #include <stdlib.h>
>>>>
>>>>   extern int UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
>>>>   $
>>>>
>>>> After this patch:
>>>>
>>>>   $ grep feature-libunwind- /tmp/b/FEATURE-DUMP
>>>>   $
>>>>
>>>> Now an audit on what is being enabled when test-all.c builds will be
>>>> performed.
>>>>
>>>> Fixes: 176c9d1e6a06f2fa ("tools features: Don't check for libunwind devel files by default")
>>>> Cc: Adrian Hunter <adrian.hunter@intel.com>
>>>> Cc: Ian Rogers <irogers@google.com>
>>>> Cc: James Clark <james.clark@linaro.org>
>>>> Cc: Jiri Olsa <jolsa@kernel.org>
>>>> Cc: Kan Liang <kan.liang@linux.intel.com>
>>>> Cc: Namhyung Kim <namhyung@kernel.org>
>>>> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>>>
>>> Sorry for the delay on this.
>>>
>>> Reviewed-by: Ian Rogers <irogers@google.com>
>>
>> Thanks for the review, but I think this part is used by other tools like
>> BPF and tracing.  It'd be nice to get reviews from them.
> 
> Sgtm. The patch hasn't had attention for 3 months. A quick grep for
> "unwind" and "UNW_" shows only use in perf and the feature tests.
> 
> Thanks,
> Ian


Indeed, bpftool does not rely on libunwind, and I don't remember other
BPF components doing so, either.

Quentin

