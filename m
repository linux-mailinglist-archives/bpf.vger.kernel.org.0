Return-Path: <bpf+bounces-52423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C998A42DED
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 21:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD882189809A
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 20:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1AE243398;
	Mon, 24 Feb 2025 20:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lLy4iBwf"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2808F242911
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 20:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740429180; cv=none; b=n0cD0ZODaSX8Eh6fxnst38ILKH/vj/P9zUZKzf117RmotIm42271C7aAmIf45+PArK+VGRIDJcbeME7IaFzJ3BWhVpkvBj0nLzkE6TttVaTdo0QG5K/D+HKo1UxZ+EX4DfZNDm2/dTBw7fwSK0DqFhxMXSJf+pU0MIw5dSIBbMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740429180; c=relaxed/simple;
	bh=etP+jzyAqpPEG3Vf6eXnty+6IGotKPVghFs9zlvql68=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=L6j78NWrRwrhhg1hEPHJ8ExZX1UKP8EdYfRIG3GFIj4pBS29BaLoDyKlDoK4D5PedcO3l6PJz+nrD1ljdVO+ZCCTdGl4RVyDfW3BqDWbsqBZ3/ayo0eyBMUTo6HtL5bhApwWiQcv5GexTmRjB6kFDTkvXmcWAnGlLp5E9bvu68Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lLy4iBwf; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740429176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lcitdbk5nXbKmSN2/Gnvz1PsxeBLnhooDHJLa5fB4/8=;
	b=lLy4iBwf6L4MURHnozUqfGQK7fV1XrvGbRpeNYGyDee9G0Vt6g8OJDLL07Lny/SjTn0egC
	dGTgxLnKWuyCaIFHtAwNCn0rRZVm9vfY5B2Z7jo16LEJzZ9r2dhDRtUjXsgqAOHS6m2315
	YqydIcA+zKrQ7aPjxujxJsiCBcLvZB8=
Date: Mon, 24 Feb 2025 20:32:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <f3b456f90256379d583f58e0d6fe2492d46eb866@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v3 0/4] btf_encoder: emit type tags for
 bpf_arena pointers
To: "Alan Maguire" <alan.maguire@oracle.com>, andrii@kernel.org
Cc: acme@kernel.org, ast@kernel.org, eddyz87@gmail.com, mykolal@fb.com,
 kernel-team@meta.com, bpf@vger.kernel.org, dwarves@vger.kernel.org
In-Reply-To: <221ce8b6-fab9-4f63-813b-6bd83dddf1a6@oracle.com>
References: <20250219210520.2245369-1-ihor.solodrai@linux.dev>
 <221ce8b6-fab9-4f63-813b-6bd83dddf1a6@oracle.com>
X-Migadu-Flow: FLOW_OUT

On 2/21/25 6:47 AM, Alan Maguire wrote:
> On 19/02/2025 21:05, Ihor Solodrai wrote:
>> This patch series implements emitting appropriate BTF type tags for
>> argument and return types of kfuncs marked with KF_ARENA_* flags.
>>
>> For additional context see the description of BPF patch
>> "bpf: define KF_ARENA_* flags for bpf_arena kfuncs" [1].
>>
>> The feature depends on recent changes in libbpf [2].
>>
>> [1] https://lore.kernel.org/bpf/20250206003148.2308659-1-ihor.solodrai=
@linux.dev/
>> [2] https://lore.kernel.org/bpf/20250130201239.1429648-1-ihor.solodrai=
@linux.dev/
>>
>
> hi Ihor, just realized that given that this change depends on recent
> libbpf changes, we should look at updating the series to include a patc=
h
> updating our libbpf subproject checkpoint commit for libbpf to get thos=
e
> changes for the case where the libbpf submodule is built (the default
> these days). We should probably have a patch (pahole: sync with
> libbpf-1.6) to cover this. An example of a subproject commit patch can
> be found at
>
> https://lore.kernel.org/dwarves/20240729111317.140816-2-alan.maguire@or=
acle.com/
>
> However I don't think those bpf-next libbpf changes have been synced
> with the github libbpf repo yet. If the next libbf sync won't be for a
> while, I don't think this has to block this work - we could just note
> that it needs to explicitly be built with latest v1.6 via shared librar=
y
> for testing purposes in the interim - but if there's a sync planned soo=
n
> it'd be great to roll that in too.

Hi Alan. I've just submitted a PR to sync libbpf with upstream.
https://github.com/libbpf/libbpf/pull/886

Will add a subproject commit patch.

Andrii suggested pahole could use __weak declarations of libbpf API
and detect if they are linked at runtime. This way it's not necessary
to check for libbpf version. There are just a few places where we
currently do that.

What do you think if I add patches for that too?

Thanks.

>
> Thanks!
>
> Alan
>
>  > v2->v3:
>>   * Nits in patch #1
>>
>> v1->v2:
>>   * Rewrite patch #1 refactoring btf_encoder__tag_kfuncs(): now the
>>     post-processing step is removed entirely, and kfuncs are tagged in
>>     btf_encoder__add_func().
>>   * Nits and renames in patch #2
>>   * Add patch #4 editing man pages
>>
>> v2: https://lore.kernel.org/dwarves/20250212201552.1431219-1-ihor.solo=
drai@linux.dev/
>> v1: https://lore.kernel.org/dwarves/20250207021442.155703-1-ihor.solod=
rai@linux.dev/
>>
>> Ihor Solodrai (4):
>>   btf_encoder: refactor btf_encoder__tag_kfuncs()
>>   btf_encoder: emit type tags for bpf_arena pointers
>>   pahole: introduce --btf_feature=3Dattributes
>>   man-pages: describe attributes and remove reproducible_build
>>
>>  btf_encoder.c      | 279 +++++++++++++++++++++++---------------------=
-
>>  dwarves.h          |   1 +
>>  man-pages/pahole.1 |   7 +-
>>  pahole.c           |  11 ++
>>  4 files changed, 158 insertions(+), 140 deletions(-)
>>
>

