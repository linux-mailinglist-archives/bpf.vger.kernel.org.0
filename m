Return-Path: <bpf+bounces-56572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC14A99F47
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 05:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1140C4422ED
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 03:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8249A1B4141;
	Thu, 24 Apr 2025 03:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Yn6tkvCY"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1B81A0BFD
	for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 03:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745464056; cv=none; b=QH19ggTRZZ8dRMTifAVwzSs94YqA55YQDKRsvrWCZRa7hg3D1SXyMibTS+fL0GJsQO99zUlB1ME9ZCXO+3fKaNnTgYGEsEDgdC5afrNYTGjL/K/7rdPMmya1T4y3GXGe27rRbPqR51KgKTgxanphezcZiv6b9QW0XZgWyym0mAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745464056; c=relaxed/simple;
	bh=6yz9SDRx3eNUERDUWclK/fQ/tgNsEuCKqYIUBAdNxM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bWKan/axRuzuDn+Y4kTJ3jlc3mQc2XK6p2EEirtyYW67Bd7hvqL4W6gm5dT4uNYk7vAGmYIh5eJoYeNTjCPSQE7FyQsxDmmJCyT8CaMUXwTrBv/ZXmL5JdTcCJxm+m84SvmjIZUbwHMyAq+wCejT/bVlW1rTPb8AlCnkfwgiyF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Yn6tkvCY; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f5ac4ab8-bd1a-4009-bf09-1ac34eb47ec1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745464042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eH5A1aKc65oiuiH9DMP/7aJj2gAA7/rhAd8AecnDlpM=;
	b=Yn6tkvCYBbrQLuPGV6B4VLcmEvj9S1gWzxpkwa+IYgATjTfRsqsqII6Y7ugn+gH3PuAc4G
	/lvxY9rR2AWng9YoxOd1pumsREGK1DPP9MKpi21RHMI1tj4r5E5zRAGYoKsjNGlKwqxgUf
	80g2Yom1hR/s1M8kfI8KMJvdU6EOGNE=
Date: Thu, 24 Apr 2025 11:06:59 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf, docs: iterator: Rectify non-standard line break
To: WangYuli <wangyuli@uniontech.com>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, corbet@lwn.net
Cc: bpf@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, void@manifault.com, psreep@gmail.com,
 yhs@fb.com, zhanjun@uniontech.com, niecheng1@uniontech.com,
 guanwentao@uniontech.com, Chen Linxuan <chenlinxuan@uniontech.com>
References: <DB66473733449DB0+20250423030632.17626-1-wangyuli@uniontech.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <DB66473733449DB0+20250423030632.17626-1-wangyuli@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 4/23/25 11:06 AM, WangYuli 写道:
> Even though the kernel's coding-style document does not explicitly
> state this, we generally put a newline after the semicolon of every
> C language statement to enhance code readability.
>
> Adjust the placement of newlines to adhere to this convention.
>
> Reported-by: Chen Linxuan <chenlinxuan@uniontech.com>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>

Reviewed-by: Yanteng Si <si.yanteng@linux.dev>


Thanks,

Yanteng

> ---
>   Documentation/bpf/bpf_iterators.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/bpf/bpf_iterators.rst b/Documentation/bpf/bpf_iterators.rst
> index 7f514cb6b052..385cd05aabf5 100644
> --- a/Documentation/bpf/bpf_iterators.rst
> +++ b/Documentation/bpf/bpf_iterators.rst
> @@ -323,8 +323,8 @@ Now, in the userspace program, pass the pointer of struct to the
>   
>   ::
>   
> -  link = bpf_program__attach_iter(prog, &opts); iter_fd =
> -  bpf_iter_create(bpf_link__fd(link));
> +  link = bpf_program__attach_iter(prog, &opts);
> +  iter_fd = bpf_iter_create(bpf_link__fd(link));
>   
>   If both *tid* and *pid* are zero, an iterator created from this struct
>   ``bpf_iter_attach_opts`` will include every opened file of every task in the

