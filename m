Return-Path: <bpf+bounces-78724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7476D19CD8
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 16:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31F5A30B557A
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 15:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4471387364;
	Tue, 13 Jan 2026 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3QVxiKp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91B02EA743
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768317202; cv=none; b=oowrwcV9EwnE8ZfaAPaBisggK97nR3LHsyruLCK4hV4ZKR53WJt8xo+QO59v/qbRsZS/xUBcFKL+DNgfTVnzEjgrZ5bxgVBPaBoZzcOjqhwSjsRen2nV1v7dbAAb+SM+ZXjbt8NOGguUJbfDlVnkh+l1WFjgH+bCrGS2Mb9F5UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768317202; c=relaxed/simple;
	bh=4msERRb4ov+p+dObAJfU04poEvfCfhzV+GnmMFQgyLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FvwLGsFBE6sNDWkCYGXkbuBsBlRqKk11991U965JppU/IwdQfPID2VqJwu+Z9Qec3IcFm6er94tPbh5Wc0E/aKFX+DCZ5kbzgqCsKRQK903JBcBWUmb8W30gChqUXsJYag9TlZTDkWcEYiDTskN0BWRbN583eWhFRL1wwLCr7/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3QVxiKp; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42fbc305914so5446426f8f.0
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 07:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768317199; x=1768921999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z7ad4VhkI066yaZ/zcesPJEqPYUWyqIq0m/jqdVxq4g=;
        b=I3QVxiKpmiRDH5+EQCRrWLPngDoeI4Qj6MBCaTV3E1QvH/Made2YbYoM2bW371mjmx
         /27xx2H6jTpJkB1k67v/9KA7f7vXSeHb5aBJfW7r+v2Q2z1V/VQqbMX6Q0lUE6wV49NN
         k3pzr2oxlTrwPGBiN7jmYzVfXd6+7LzBBWmL8t/xTM5zYrlAWUisz6X9iQZ7XBimF28w
         33zsD5be0laPgjVZmNLH2hYdKUrFJ1kp5RgK4PQBMLnBLYoavoE0t6ll944uf3t4Krd2
         1cQEv0OKYk03Vw1Ckv3Nbe2S3nrxxHPQ1GRlI5QBTXkDJQ5y2JIXFOjfHC9uPtMznzGI
         VsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768317199; x=1768921999;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z7ad4VhkI066yaZ/zcesPJEqPYUWyqIq0m/jqdVxq4g=;
        b=fP+iKiRy9Q/3Go/DxW+pC1Dhzrqo6OUQbUW7NnQFKK9b0huRrCRtC3JME9weXi7sZw
         IcU8SR+N58G2cncsVYAhoFF9utfGaFEzTMsi8ox+XFBg8djKjienFHzsjUzUuxZaNk1G
         ym19LBtI+ujW+pjjUu5jARS653azud6PWpjmt335y6hkC1YARZiTkxssaTZIxfPZrrQ5
         6mREByGKCS6BkySimTJrGUJTKZ6Yrum0iBq4Y/iQtwfj92tD9DVBSzH1X/Sis/L8gWbf
         E640ZB+2UVZTe5qA+oq1gnIfSinv42RFibu8KWBxvxbohamxPBPrpoNJc71wADLIpWHg
         WHbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjAUh1p1nGuFOGfjtk0LneJx8mCIxqc6yzXPjPfvtlQPfNgavEozUMWmhu8X6cQOH8TN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys4KudBayV83s8+jFurVqW5KgxKlH8LtryRPjcWv+wfaWqVvbY
	KeAcjzk9CL/zLovfMbeh5NlkwK11q4rgVQ5fAth0w3VbWmtxUecDOM0/
X-Gm-Gg: AY/fxX4+dkrcf6VIXQGBUnof69tL0+QOx/6EGtHF0VXFmFtMEApy5do7DBOsnGR/jyt
	MXXPbCSpOKwd4HNmoF403ktvyGZLVuux9SlAzY2baFymc8BpNcy6KgWJ4w8kxivHz89v0sikI7I
	pISYlzZojwDl5o++GKZUDE4IEfajjrKp3J4UKCTxSqqf5pcUUGlp1QOWlr4DpQNBx91OYqmFYW0
	jDMtNJEHz5o0Nm9vMflZDc/m+3MI8jveC7pgYVK4agfVNqOrTu5PGwOngtYUBKgf7RP7uZKR+fJ
	JLkQF5UgyAwrQn4k1SFTaxGxBNyzlFMBsaeMmfoxBhtqbV7FMSRg9rUHxPPYFgVOHwnLvRQQ/lq
	fSOnp4KgDlLIEZklf5IczGwrhZOtViuu1Xs6ci8IEbH2sQQK6G5fHgt0KqjlyAnPwRYuiXEaw5w
	DF43VxSdgLUb1Phl5r31bQ5AFMiJOxZp4=
X-Google-Smtp-Source: AGHT+IGnNPdYjOukQwTmFjPQTX7ruowUhVfI6veoXSdJZsJ9/Y8OvdPXmROOaKvuc9kUO4QV4QID6g==
X-Received: by 2002:a5d:5f47:0:b0:430:f463:b6ac with SMTP id ffacd0b85a97d-432c379f3a5mr26607488f8f.44.1768317199133;
        Tue, 13 Jan 2026 07:13:19 -0800 (PST)
Received: from ?IPV6:2620:10d:c0c3:1131::1042? ([2620:10d:c092:400::5:51be])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5feaf8sm45175352f8f.39.2026.01.13.07.13.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 07:13:18 -0800 (PST)
Message-ID: <c8632c97-71df-4b42-97a6-d1aafb7669d3@gmail.com>
Date: Tue, 13 Jan 2026 15:13:12 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/bpf: wq: fix skel leak in serial_test_wq()
To: Kery Qi <qikeyu2017@gmail.com>, andrii@kernel.org
Cc: martin.lau@linux.dev, bpf@vger.kernel.org
References: <20260111175813.2252-2-qikeyu2017@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260111175813.2252-2-qikeyu2017@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/11/26 17:58, Kery Qi wrote:
> serial_test_wq() returns early when ASSERT_OK_PTR(wq_skel, "wq_skel_load")
> fails. In that case wq__open_and_load() may still have returned a non-NULL
> skeleton, and the early return skips wq__destroy(), leaking resources and
> triggering ASAN leak reports in selftests runs.
>
> Jump to the common clean_up label instead, so wq__destroy() is executed on
> all exit paths. Also fix the missing semicolon after 'goto clean_up'.
>
> Fixes: 8290dba51910 ("selftests/bpf: wq: add bpf_wq_start() checks")
> Signed-off-by: Kery Qi <qikeyu2017@gmail.com>
> ---
>   tools/testing/selftests/bpf/prog_tests/wq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/wq.c b/tools/testing/selftests/bpf/prog_tests/wq.c
> index 1dcdeda84853..328c393e7167 100644
> --- a/tools/testing/selftests/bpf/prog_tests/wq.c
> +++ b/tools/testing/selftests/bpf/prog_tests/wq.c
> @@ -17,7 +17,7 @@ void serial_test_wq(void)
>   
>   	wq_skel = wq__open_and_load();
>   	if (!ASSERT_OK_PTR(wq_skel, "wq_skel_load"))
> -		return;
> +		goto clean_up;
>   
>   	err = wq__attach(wq_skel);
>   	if (!ASSERT_OK(err, "wq_attach"))
I think the code is correct as is, open_and_load() either
returns NULL or valid loaded skeleton.
There is nothing to cleanup if NULL is returned.
You can check generated wq.skel.h to see that on load error
path wq__destory() is called.

