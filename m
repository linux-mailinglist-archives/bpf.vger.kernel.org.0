Return-Path: <bpf+bounces-45365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C65B9D4C30
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 12:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1328228311A
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 11:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9761D1F6B;
	Thu, 21 Nov 2024 11:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtR0xX+6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ACD1CB322;
	Thu, 21 Nov 2024 11:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732189607; cv=none; b=oW8SAZ5+DSQ6Utq48SPJefBOT9QXav52lfVHAgeJLALStrm1TV8IE9KDuRmOCBwosNEc3+v7Mx4bbVlC1yfrJJim0go9a4/SJJ/ud+cIre+YBwX5f36vvkX37YlkMDZcN1HFrwYrbUj6F4LkmW1Nws7I1ROF8Kdis3cv+xO+W9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732189607; c=relaxed/simple;
	bh=8xmUZT+nAyNtnMQYSHFfQWw4/XKrbcKKuwhBoaPXWj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kERmAok1eaNV5iA9OfJFcOEP73ShcpQsxbw517JGKNHcs2TmgVPeXZHoppo5RXCUhtmHW2Qy/zCyWeQ7N3InKgL6B41QKvGuxcSm4mIpGQ5Xgusl3Ea4HapDGNNBgWQLbBjZJ9RdYgJcMtRfg7MxT3c56/0LlAEF5xK0Ed2qvLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtR0xX+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE78C4CECC;
	Thu, 21 Nov 2024 11:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732189606;
	bh=8xmUZT+nAyNtnMQYSHFfQWw4/XKrbcKKuwhBoaPXWj8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gtR0xX+6sko9pV6+8jwyKS4npOgBpmiK2ce8hhUG9F5XNzdw7bjLvuUfkqVQcyC9c
	 FtF7URUfG4Tkjo9Kag8qyiNdiYct3m42hx0O6uaNfV9HANaP7VQyG7zTu56u0jYWTF
	 GGVbyW1nttwUvCHFNAMwVjhoT/pAAVrA2VMXOWWKhIHg1W6xnm2HlUuMvsFqaREbhI
	 LIMRULJ5di/zGSLs4BUBfhK9sYTGMj3tfeQyGAzsHE9QsAFerx24ojMJkbYCr/dwkr
	 r7SzliUg5GGmtemErM7njazacOjhi/ENYWC0zoEI58KI09vZuBmM46XFbtb1oJm3qx
	 j8DBp4UFV5UNA==
Message-ID: <2bb08736-bcbd-4d74-a878-2598301e0182@kernel.org>
Date: Thu, 21 Nov 2024 11:46:42 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpftool: Fix the wrong format specifier
To: liujing <liujing@cmss.chinamobile.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241121085518.3738-1-liujing@cmss.chinamobile.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20241121085518.3738-1-liujing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-11-21 16:55 UTC+0800 ~ liujing <liujing@cmss.chinamobile.com>
> The type of lines is unsigned int, so the correct format specifier should be
> %u instead of %d.
> 
> Signed-off-by: liujing <liujing@cmss.chinamobile.com>
> 
> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> index 08d0ac543c67..030556ce4d61 100644
> --- a/tools/bpf/bpftool/main.c
> +++ b/tools/bpf/bpftool/main.c
> @@ -423,7 +423,7 @@ static int do_batch(int argc, char **argv)
>  		err = -1;
>  	} else {
>  		if (!json_output)
> -			printf("processed %d commands\n", lines);
> +			printf("processed %u commands\n", lines);
>  	}
>  err_close:
>  	if (fp != stdin)


Thank you for the fix. While at it can you also fix the format specifier
for the other two prints of "lines" in the function (via "p_err()"),
please? I guess they're not raised by your static checker, but they
should be addressed just the same.

Quentin

