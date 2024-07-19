Return-Path: <bpf+bounces-35096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 986FD937ADF
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 18:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4143A1F22895
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 16:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6135A2E414;
	Fri, 19 Jul 2024 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="SMFukC23"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5512AF12;
	Fri, 19 Jul 2024 16:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721406141; cv=none; b=prOlPnQN6rFI0E6qn0Qmhr5egqkvhq83ckEPV4rry34gsJuZVuTqeEKZsn49FRbn1B+cI6MswSZPGtTVD+7mta68Ueu/yVxJQA4nbepsYXwYoVlDZ1l8pNKtLc5mb2jf3nAQbIiFzHhGddlhkXFsJHIuXbPuaI7E7D3yasqYqxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721406141; c=relaxed/simple;
	bh=aT5sC62zOUa8CchU2DTeRrP6UkTNO10YC2LRs8H2JfA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Mrzt4gHe1EdDxlXOChZeuQ1F2/aXmDASgXvq2uQ6KbzQdDlD2MTSX14UEWKPs09/M04rFeTDN2eZVaJmHFJ0zdxZ6jJ2NBPczVxVY5q4YDKTLVVwrNuPRHYzqWSvYH6AanI7CtNDeRZDcmSJjDR8T8F02s4y7gbYTxcofArEIdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=SMFukC23; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=dIhcCCgzkhsmOy1Fwp27RTR+lHIhKUz2r2t1LUg1sN0=; b=SMFukC23BzdcMygGv5e1PSBf1R
	9dedP1KknS6mii/aTuqHUKaZdanV4xunwIk/M6Tant+z9IYw2EIzhChYt+kYUWF/ou9BVmNveKE/l
	0zCWFfqCb9HSyUA88Nm7CJvhrakjKAhePTNyO5coGH1G4VnrytLTVDol7PCp1U31nBPCWT/MMzR/S
	MUylyiBEnrsgJWSbkymyTiS8RJyiopYsZ/CVK8csH+TOvwITlutTpLuwah9Vus1kCK6SEFWyHTFEy
	fjvMbaiMV2w8LWPG4Y5KLjtRRI4vq+HM7tlKm55hFRzcxkW5HF3kMQJV7rioF6AFHnZnEK+iItc1K
	HTr9bvaA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sUqN0-000DS5-Am; Fri, 19 Jul 2024 18:22:10 +0200
Received: from [178.197.248.43] (helo=linux-2.home)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sUqMz-0001Kx-2Q;
	Fri, 19 Jul 2024 18:22:09 +0200
Subject: Re: [PATCH] bpf: fix excessively checking for elem_flags in batch
 update mode
To: Lin Feng <linf@wangsu.com>, ast@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 yonghong.song@linux.dev, Hou Tao <houtao1@huawei.com>,
 Brian Vazquez <brianvv@google.com>
References: <cde62a6c-384a-5bdd-fe64-3f3d999c3825@wangsu.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7d351341-fefe-a40f-f62a-d9505432d056@iogearbox.net>
Date: Fri, 19 Jul 2024 18:22:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cde62a6c-384a-5bdd-fe64-3f3d999c3825@wangsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27341/Fri Jul 19 10:28:50 2024)

On 7/17/24 1:15 PM, Lin Feng wrote:
> Currently generic_map_update_batch will reject all valid command flags for
> BPF_MAP_UPDATE_ELEM other than BPF_F_LOCK, which is overkill, map updating
> semantic does allow specify BPF_NOEXIST or BPF_EXIST even for batching
> update.
> 
> Signed-off-by: Lin Feng <linf@wangsu.com>

[ +Hou/Brian ]

Please also add a BPF selftest along with this extension which exercises the
batch update and validates the behavior for the various flags which are now enabled.

Also, please discuss the semantics in the commit msg.. errors due to BPF_EXIST and
BPF_NOEXIST will cause bpf_map_update_value() to fail and then break the loop. It's
probably fine given batch.count (cp) will be propagated back to user space to tell
how many elements could actually get updated.

> ---
>   kernel/bpf/syscall.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 869265852d51..d85361f9a9b8 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1852,7 +1852,7 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
>   	void *key, *value;
>   	int err = 0;
>   
> -	if (attr->batch.elem_flags & ~BPF_F_LOCK)
> +	if ((attr->batch.elem_flags & ~BPF_F_LOCK) > BPF_EXIST)
>   		return -EINVAL;
>   
>   	if ((attr->batch.elem_flags & BPF_F_LOCK) &&
> 


