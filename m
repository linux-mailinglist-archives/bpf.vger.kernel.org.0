Return-Path: <bpf+bounces-35493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A2193AFAC
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 12:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C226B1F22D30
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 10:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AAA155A53;
	Wed, 24 Jul 2024 10:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKyreKz8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176D9154455;
	Wed, 24 Jul 2024 10:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721815993; cv=none; b=C2KsfBQ+HMKEh/PKpcrnyzkhvohvYyc/3eJUdIQLWZsz0FlcOWiV2vFPVlFOP1WdZBenY00YLsEWlcyOnzlgmV4POY8KmmAvGeNbq5DxKTXLrb9oNceUwyfDSvNCfISJV/zce1PY8/J4tFgVTk3cj4nXWNVF930FJtgdHHW9Tzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721815993; c=relaxed/simple;
	bh=FYqUrSaIT8OdBt8E6JL0KHPF4TMJdp0tFadHN+raSH8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bwEvRrtgufhpAUxvHafDFIWF2SVGKO3aIKrjF2l9OlFu4gh7YAp+wAbgcGY6rtnOrVMkO1HUCIfK3fMSiyye4ni+dMd8pjISGogVFR8j//abogohbtYTocJkjxL/8OyjR3C2+ThZ+imBtkBIf/Npe50nps1pZzvBcdtpFt1tGyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKyreKz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4179C32782;
	Wed, 24 Jul 2024 10:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721815992;
	bh=FYqUrSaIT8OdBt8E6JL0KHPF4TMJdp0tFadHN+raSH8=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=MKyreKz8lZu+zkfywrsGcRtRqH8gs9qCXcwuhA9Z4fj3/mla0FQrBaNGqGFk/cEc1
	 0TZbpTtF9x2tNva3HVlerlniDoL4gW8I6gF/R75x6B2Zqj5wlfpQqukdcvgq3tgcwI
	 hI0Luz38kLcPCw17Odob4N3QcXYlNCUFS1hv+/TQmn8cLS9a61RPtJOhnzoabAErGf
	 xtmv9cJIhwnVfFnlCrrrwOJCS9tts2hIA4FxGwVFDRHx9vgD+gXW09U5EnovI5PPUS
	 WVL8US4HzvsLpBtVscPanRu+qA8jSWOnQuipG7+PfJpEP1J/+Hz9nvIp/Kiv0SIAcI
	 +4c9RS9MGawoA==
Message-ID: <2d6875dd-6050-4f57-9a6d-9168634aa6c4@kernel.org>
Date: Wed, 24 Jul 2024 11:13:07 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH v3] tools/bpf:Fix the wrong format specifier
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240724100022.10850-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-GB
In-Reply-To: <20240724100022.10850-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-07-24 03:00 UTC-0700 ~ Zhu Jun <zhujun2@cmss.chinamobile.com>
> The format specifier of "unsigned int" in printf() should be "%u", not
> "%d".
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
> Changes:
> v2:modify commit info
> v3:fix compile warninf
> 
>  tools/bpf/bpftool/xlated_dumper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
> index 567f56dfd9f1..d9c198e0a875 100644
> --- a/tools/bpf/bpftool/xlated_dumper.c
> +++ b/tools/bpf/bpftool/xlated_dumper.c
> @@ -316,7 +316,7 @@ void dump_xlated_plain(struct dump_data *dd, void *buf, unsigned int len,
>  	unsigned int nr_skip = 0;
>  	bool double_insn = false;
>  	char func_sig[1024];
> -	unsigned int i;
> +	int i;


Thanks! But unsigned seems relevant here, and it doesn't make much sense
to change the type of the int just because we don't have the right
specifier in the printf(), does it? Sorry, I should have been more
explicit: the warning on v1 and v2 can be addressed by simply removing
the "space flag" from the format string, in other words:

	printf("%4u: ", i);

Instead of what you had:

	printf("% 4u: ", i);

Quentin

