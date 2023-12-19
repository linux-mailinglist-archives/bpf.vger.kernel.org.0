Return-Path: <bpf+bounces-18344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C65D8192C1
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 23:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7C45288459
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 22:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776153C46F;
	Tue, 19 Dec 2023 22:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="En52GGV/"
X-Original-To: bpf@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C278A3D0A2;
	Tue, 19 Dec 2023 22:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=9fg+mSaYZimcw8y/Rf+e+q5+qIfmlkXuesAXEDPfX40=; b=En52GGV/ikcV6Y3pg2C96xts26
	4JqFe2vNHEyY1jHjjOcxMJlWs7zPiiu/AXt+VDe422hQuRFpju1YhYLpC4H4OelaWUKS6KIvIDdY6
	COGm0sGAnBEJssBqFh87cVdsSMSaYlss9F1fTMQlo7Dk/a5lanzLAzV7LclxqwEw9VRzd2FtLe6fe
	ywFFqT+XXsrUmcB8p3FvYa54yxV7jk3Jlud41zRtVJ4qnup+ZyZKUV2bFbneu9dLuTQCYRFQw0TuU
	zQ//Jpo7iLbNW7fU4Hs/qdSEnyjGQT61PcHfzwwjvslqmSP4rlEuiNUqBMcC27F3cQsdTLtC7/rFz
	IAjlzbWw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFiAU-00FYL9-05;
	Tue, 19 Dec 2023 22:02:26 +0000
Message-ID: <a3fbe3a7-738a-438b-b8ff-2d0f812033d3@infradead.org>
Date: Tue, 19 Dec 2023 14:02:25 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] samples/bpf: use %lu format specifier for unsigned long
 values
Content-Language: en-US
To: Colin Ian King <colin.i.king@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231219152307.368921-1-colin.i.king@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231219152307.368921-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/19/23 07:23, Colin Ian King wrote:
> Currently %ld format specifiers are being used for unsigned long
> values. Fix this by using %lu instead. Cleans up cppcheck warnings:
> 
> warning: %ld in format string (no. 1) requires 'long' but the argument
> type is 'unsigned long'. [invalidPrintfArgType_sint]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  samples/bpf/cpustat_user.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/samples/bpf/cpustat_user.c b/samples/bpf/cpustat_user.c
> index ab90bb08a2b4..356f756cba0d 100644
> --- a/samples/bpf/cpustat_user.c
> +++ b/samples/bpf/cpustat_user.c
> @@ -66,10 +66,10 @@ static void cpu_stat_print(void)
>  
>  		printf("CPU-%-6d ", j);
>  		for (i = 0; i < MAX_CSTATE_ENTRIES; i++)
> -			printf("%-11ld ", data->cstate[i] / 1000000);
> +			printf("%-11lu ", data->cstate[i] / 1000000);
>  
>  		for (i = 0; i < MAX_PSTATE_ENTRIES; i++)
> -			printf("%-11ld ", data->pstate[i] / 1000000);
> +			printf("%-11lu ", data->pstate[i] / 1000000);
>  
>  		printf("\n");
>  	}

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

