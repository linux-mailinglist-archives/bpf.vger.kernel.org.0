Return-Path: <bpf+bounces-21492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE18B84DD29
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 10:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 038C81C234D7
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 09:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C231F6BB20;
	Thu,  8 Feb 2024 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jNwOMfIO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36DE6A03A
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 09:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707385320; cv=none; b=qr/ab9P+aw+TbeBRsGwgQ9ziflAFxwPw7bGq65ahXkmSTiepocZkMpc4Bm8FNxqzOukBlPWLSmcJQN0VULvR+rTAgtavsCfal5Q9iWYOzbgStwFtNJs/4qBksxCijUL8Lmd5ZUA+n00vYub5qDJgHaqtKpB4wwWwJkubUrko/gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707385320; c=relaxed/simple;
	bh=k2nIcfFI03GXbW7qEsqPSwrELDcKz9m/T/puW0afApU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jTcubmFsxirG3ix78h/w7eWHZsKrbgx40Yer7JzDm5AyB/fMpAyk2ue4KWXH2Kqwzq3Mw8FtG7pHrLYVhsmUh8ewTSGVcxEw8bEW4BQ3Nmp6+oP7fgDjQOWuQ2zlTLJlLXvlQJg3yyo3OnWxvIyPBtpqrzg3v0T2K/5AeKD9Xns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jNwOMfIO; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-290fb65531eso1143661a91.2
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 01:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1707385318; x=1707990118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90OWDkDFdGBER3xrAeFw4VKW/8UTTK7hIUvO4Cj+W5A=;
        b=jNwOMfIO5kl6cmxw1PgYWQ7QXK5jIekr2tD8RrScZD14VrAwoudFOSUl3MN0ysqYep
         b3agz2Dj9zTXGX9JtjlowsCDuPpAaA4zUDzoZoUNCuCjTKkm5Y9noQR1DldwF6eG8089
         q7SllmYCLXiSV7sSmdQcCs9UFfzI7tvTqT0wUWWS4dE08oph0ff3j9JCMoVGssQyX6H0
         v6Hx/5zeTEDeUbE+g+PjZV4TGamYxGl0ntKfYdw8CKEay1zZSKK3SD7iBEwP4T76wDSP
         KxHncgTwER7/JlNj/uQ130vHhOSiu6LdqcLdCfNj89NtHuq+eUKr0BaKoBDhQP9VDfox
         ptYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707385318; x=1707990118;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=90OWDkDFdGBER3xrAeFw4VKW/8UTTK7hIUvO4Cj+W5A=;
        b=qMLjl2B0BVPXjQ1KKQkthqsqjDH1M3pvsflu68AwyjMziF+wY4Wu3AnX41eFTBysGg
         yqcuMAJ3prkTg/ovPQe9vVMPBBrdU4Du0dFUn+2Sgj4htCyghBgLh0POaS4+YUPZKGfD
         HZwo2oQLZCvv5IXATrThU3IiG8EQ8+dRQX1zF8hvRzIDW5Z/CqUz++vIve/ir3IxP4ax
         zeReB85Fo2mKFovEoY8kFjCqIY0a2bJXWSBtbTCOjvDgGtJPu17BIY9ays7NNJ6vNk0F
         2pnIp5ieGlrOSiWGR9dOBc/7v3fz/e0DQJht8Zh2nsh/aC2mP3PX2pEZeAEZg8kete/j
         53uQ==
X-Gm-Message-State: AOJu0YyyQEWSLWBSQZbFQvNA/Z2yBkctje5bc5hUzD5zGjyTeu2hG52x
	q4P2MPkKzFRG7Ua92PVZL3pPEyFh36u1fbd1HxnkXXpm1OEQ6gYVX49giLcFA08=
X-Google-Smtp-Source: AGHT+IHmDlVnC9vusqTO8HHZ+xWTy14F8jHX2hhDf14PcvjiYjnjXsC6KGa3XCJOkIAg6QvDPpKheQ==
X-Received: by 2002:a17:90b:80a:b0:295:d782:95df with SMTP id bk10-20020a17090b080a00b00295d78295dfmr4997712pjb.34.1707385317897;
        Thu, 08 Feb 2024 01:41:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUxmxsHx701sCBAYHOl1T2McjcoGwFJoAJwcVZASEGP31ahAiQAQwfEDbTx0HsKjAvDcu8elcpWFVMYwqsofpAVPALAjWxxbbdbcJroii4lV+2F/9VnymE04tN5AI0dAAVvDvq3YAQm5SPjPjk1vLvK+eKz+iynsPEBRcv2u+UnYH3FA1FwgZYuKoI7fBjaByMJ4RFGs5ZrR3zP/+MwXzzzIuSfBtZkUHlULmxmnfEcId3U5ekSSFUJxrQDEN+GAQyWmxAX6RUvL+YDtmZs0draLm52EM1YZeP9giR1TjSzFFm5FIn2UqDpcttu/tkkxCZvtBkR7ZFDehza0ezZdg/S3ETeRcp9z9r0T1IEKW/aGVgPUK2x0SYdqBxrgvc=
Received: from [10.254.178.194] ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id v7-20020a170902b7c700b001d91b608a9csm2904166plz.279.2024.02.08.01.41.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 01:41:57 -0800 (PST)
Message-ID: <bbe097d6-b9be-46d1-bc66-630c23d0f9a8@bytedance.com>
Date: Thu, 8 Feb 2024 17:41:48 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/3] bpf: Fix an issue due to uninitialized
 bpf_iter_task
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org
References: <20240208090906.56337-1-laoar.shao@gmail.com>
 <20240208090906.56337-2-laoar.shao@gmail.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <20240208090906.56337-2-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

在 2024/2/8 17:09, Yafang Shao 写道:
> Failure to initialize it->pos, coupled with the presence of an invalid
> value in the flags variable, can lead to it->pos referencing an invalid
> task, potentially resulting in a kernel panic. To mitigate this risk, it's
> crucial to ensure proper initialization of it->pos to 0.
> 
> Fixes: c68a78ffe2cb ("bpf: Introduce task open coded iterator kfuncs")
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>   kernel/bpf/task_iter.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index e5c3500443c6..ec4e97c61eef 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -978,6 +978,8 @@ __bpf_kfunc int bpf_iter_task_new(struct bpf_iter_task *it,
>   	BUILD_BUG_ON(__alignof__(struct bpf_iter_task_kern) !=
>   					__alignof__(struct bpf_iter_task));
>   
> +	kit->pos = NULL;
> +
>   	switch (flags) {
>   	case BPF_TASK_ITER_ALL_THREADS:
>   	case BPF_TASK_ITER_ALL_PROCS:

LGTM.

Actually commit c68a78ffe2c ("bpf: Introduce task open coded iterator 
kfuncs") initialize it->pos to NULL. But it seems the following commit
ac8148d957f5043 ("bpf: bpf_iter_task_next: use next_task(kit->task) 
rather than next_task(kit->pos)") drops this initialization.

Thanks.

