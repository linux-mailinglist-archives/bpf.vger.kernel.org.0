Return-Path: <bpf+bounces-27934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 092668B3C14
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 17:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B91EF2836DB
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 15:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F7214A4E9;
	Fri, 26 Apr 2024 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ZkIkNbVd"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91ED1DFFC;
	Fri, 26 Apr 2024 15:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714146882; cv=none; b=fv1GRo7p9qGnClkR+wKy+QO03AGenjEsRNBrCW+Umy43NczdYipssBLSha8hzPw8/d8V311PICjyl1IbNUTi3MawCK60F/JBjmaSXYO3ggXfAiY0lMLyte3JM+1G9MkyeKwWBd8StoP3WoELfbmXfbva0J7yQB5V+VuuW9EGrAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714146882; c=relaxed/simple;
	bh=/pT6qmm86/1dcB/Ev+EycfykmNlxY3DJMFoMITVHi9c=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=I1kT0XOoKySdfI924r4tPISi+Hz/bdHbHsG4mRk+WMBVzBYPgm5IlwYyzEJAEGR8oqfqKyx+LrIQan8KWezBsUefUL0fY4K5VsgTfLRZDpypEGPlBydlKBazVYAUGPS9ir0nkL1PGTVHSmYqV1b9H9OHedf7YXUvZRYHSuyQO18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=ZkIkNbVd; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=xHnvLf7Wr6viAvKpwEcbiqJa9JjHx2np031W4DhJ6oE=; b=ZkIkNbVdnmCqLHtNBDrPqBzOnn
	JCrup+nnr/p5SdAepZuWIZlanKeOF3Eh1RTf0K1BVnJ+E35HNo/66SIx10WDzeg6JRT/lYxF25X6f
	ZC7uO+HUmrexwZzHzMKNyTi75486ZoHpEe6n9dzpxaoCskliu4mkj4u60jqkSo0rLpqRJ7Z+dUPXO
	Q3TNtJ4DiuonOwR1PcFVrn908Zre7LAwtn+Z6bwFegSI699Fdna1YJmAS6dDgrms1L+Xio+z9P2FI
	yBqnViPwRMmDPKyWdr3fJhPLa8ugyfD21wkBfBIk9TTu/himbzBQrYtCIKrD0MG+aZtQA8Tw6Q+88
	i8fajPyw==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1s0NuA-000Bek-HI; Fri, 26 Apr 2024 17:54:30 +0200
Received: from [178.197.249.19] (helo=linux.home)
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1s0Nu9-0009yq-1F;
	Fri, 26 Apr 2024 17:54:29 +0200
Subject: Re: [PATCH bpf-next v3] bpf: btf: include linux/types.h for u32
To: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>, olsajiri@gmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, dxu@dxuuu.xyz,
 eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com,
 khazhy@chromium.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, ncopa@alpinelinux.org, ndesaulniers@google.com,
 sdf@google.com, song@kernel.org, vmalik@redhat.com, yonghong.song@linux.dev
References: <Zh93hKfHgsw5wQAw@krava>
 <20240420042457.3198883-1-dmitrii.bundin.a@gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <9ca4b5dd-20be-79ac-52eb-a19c0c82280f@iogearbox.net>
Date: Fri, 26 Apr 2024 17:54:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240420042457.3198883-1-dmitrii.bundin.a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27257/Fri Apr 26 10:25:03 2024)

On 4/20/24 6:24 AM, Dmitrii Bundin wrote:
> Inclusion of the header linux/btf_ids.h relies on indirect inclusion of
> the header linux/types.h. Including it directly on the top level helps
> to avoid potential problems if linux/types.h hasn't been included
> before.
> 
> The main motiviation to introduce this it is to avoid similar problems that

nit: spelling

> was shown up in the bpf tool where GNU libc indirectly pulls
> linux/types.h causing compile error of the form:
> 
>     error: unknown type name 'u32'
>                               u32 cnt;
>                               ^~~
> 
> The bpf tool compile error was fixed at 62248b22d01e96a4d669cde0d7005bd51ebf9e76
> 
> Fixes: 9707ac4fe2f5 ("tools/resolve_btfids: Refactor set sorting with types from btf_ids.h")
> 
> Signed-off-by: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
> ---
> 
> Changes in v2: Add bpf-next to the subject
> Changes in v3: Add Fixes tag and bpf tool commit reference
> 
>   include/linux/btf_ids.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> index e24aabfe8ecc..c0e3e1426a82 100644
> --- a/include/linux/btf_ids.h
> +++ b/include/linux/btf_ids.h
> @@ -3,6 +3,8 @@
>   #ifndef _LINUX_BTF_IDS_H
>   #define _LINUX_BTF_IDS_H
>   
> +#include <linux/types.h> /* for u32 */
> +
>   struct btf_id_set {
>   	u32 cnt;
>   	u32 ids[];
> 

Lgtm, not sure if its worth it but also doesn't hurt and aligns the header
from tooling a bit closer to the kernel one. Just to clarify, this does not
fix a concrete issue today, so small 'cleanup' rather than 'fix'.

Thanks,
Daniel

