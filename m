Return-Path: <bpf+bounces-37153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BB69514F4
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 09:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F3C289324
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 07:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C99B1386B4;
	Wed, 14 Aug 2024 07:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGfPSa/U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699C7383BF;
	Wed, 14 Aug 2024 07:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723619110; cv=none; b=OVMZK0uB1I80mJ84+0w+LDGmXeYvyOOwmlZyXIVo8nBpaUYoa5IX3bORPwf9qbh8A4R09F9DP/RuYBVrRdFz9mwGWjd97Eca0h8WBGGfKxaF8U+4cTDptlHRpgC2Cz/WNutSxVI15/LxxQTqNu4o5l8N2NblIHbyTghzxRxkTWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723619110; c=relaxed/simple;
	bh=9K62g/fAMOZYZRUzbhhLbcDCW6zMgOqDd0tIyLWLMFk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QESs7N6isoLyVn1UorIfJgwOeKH3FA/S7JDvzYH1JL4zfPbSO3eN1aTWGjLz1LKl1oYVn0sQrza64qR7UegFUk+A1YFCj2DON8Ci6ijgaFHOZ2PztrzMyi97oKIEbqOE9h3x148ApsVfiRDubLcmGWinhedoupmLYQJaooYUVWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGfPSa/U; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7a843bef98so170041366b.2;
        Wed, 14 Aug 2024 00:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723619106; x=1724223906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GAKXHB/DvjVAYOyQty9Q2+d5ZYQSS0WjB3qNjCm3wiY=;
        b=iGfPSa/Ujx7083QsEGe1LpPw1IqFCZy+lzV0kHJWrgbqJjLt2ne1BuKCdZxppF8lcT
         tJQ3lx3Zl2gQiW623m9PKmeN7T8cTXPzbvOHDH9jG0OYTdhfsqbxg+jtIVMuSwJun8KH
         MHW8/cqNtWKN+qXtn+77jNIzSUO7iWmMTUO9FioT78Cy5M25FX9LeAz4n7sxAFcNLwzl
         JyxGmaKtaZSP79l8HrCz8SuNs3Zdrxcp0vs6KVoaNnUa4g/gThqYsb6F6jjLgJjPC2CU
         js7XWemRHYBTYMmYRxZIa7ErWXShv8Vnfr8A3X0BY/VOXo5GZPbh0gk7VxLnG/NuQrvt
         ioVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723619106; x=1724223906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAKXHB/DvjVAYOyQty9Q2+d5ZYQSS0WjB3qNjCm3wiY=;
        b=MHgp35bUk0p7ird3fbZtgeMbJiIvcOKL+pGwiYpkmm96UEYAAohRt0zkrg6p/S+wAJ
         MFnncIRmlWW73m2UeM+Zm8154uMhEkGKpZdt5CL5QeydwOJa3+DcW2z/21KN2JOvQbBt
         9mB5STmKFH95ew8NZd0WJLGniH84xmNJdMxqg/7akxJaUzgxGn+tburvtxYtqUpMdjaH
         ylBIWPtPBKpsPQKPEkdH/aObB7uvW6xO6csSx2Mc0kBXFIIGEN5GHXg1ge3OeQA2MQld
         kY/F3Y9WQr0v8Usv0ETcc2itplSe1YBWuKY5JWqY8q3v3yOZHZwicCkBtFMG+LG0Kfuy
         d7ng==
X-Forwarded-Encrypted: i=1; AJvYcCUwZyftk9dYTtZIqTm6J9+lEKF+RE9EO14YNsBj1oDVsz9K/6Q09PhCCKOenuv4DtrFxPrXHYX6B8T90MJXXH1Xidok/F/f8Uy8QLeA7NCburX3v28GrJazDNz7GOFYQlZH2micwfNS47YKdHP6qvh9fXxK7LGqV+lkBSbPqey1iSW4vsY5
X-Gm-Message-State: AOJu0Yw3L4OWRQWxdWTVU8Y4A0PbWfibG/hOVkG/pBa/wCPj6O0JJY83
	WxRJ2KPuAReuvTt+aYmzxARpD9lYXBgsLLLZHl/jM9uK70pvt7XV
X-Google-Smtp-Source: AGHT+IFfYp9ewu/cRRD7Mqd31oWxJ1qZtNjaR7Bzcm2WC3DZw1mM+qUaiF19c1b7qdzy1KStTPCuSg==
X-Received: by 2002:a17:906:7953:b0:a77:dbf0:d22 with SMTP id a640c23a62f3a-a83670c1527mr98121066b.65.1723619106165;
        Wed, 14 Aug 2024 00:05:06 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f414e069sm138126466b.178.2024.08.14.00.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 00:05:05 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 14 Aug 2024 09:05:03 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH tip/perf/core] bpf: fix use-after-free in
 bpf_uprobe_multi_link_attach()
Message-ID: <ZrxXH5BX5bn3cVBB@krava>
References: <20240813152524.GA7292@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813152524.GA7292@redhat.com>

On Tue, Aug 13, 2024 at 05:25:24PM +0200, Oleg Nesterov wrote:
> If bpf_link_prime() fails, bpf_uprobe_multi_link_attach() goes to the
> error_free label and frees the array of bpf_uprobe's without calling
> bpf_uprobe_unregister().
> 
> This leaks bpf_uprobe->uprobe and worse, this frees bpf_uprobe->consumer
> without removing it from the uprobe->consumers list.
> 
> Cc: stable@vger.kernel.org
> Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
> Reported-by: syzbot+f7a1c2c2711e4a780f19@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/000000000000382d39061f59f2dd@google.com/
> Tested-by: syzbot+f7a1c2c2711e4a780f19@syzkaller.appspotmail.com
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

thanks for fixing this

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  kernel/trace/bpf_trace.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 4e391daafa64..90cd30e9723e 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3484,17 +3484,20 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>  						    &uprobes[i].consumer);
>  		if (IS_ERR(uprobes[i].uprobe)) {
>  			err = PTR_ERR(uprobes[i].uprobe);
> -			bpf_uprobe_unregister(uprobes, i);
> -			goto error_free;
> +			link->cnt = i;
> +			goto error_unregister;
>  		}
>  	}
>  
>  	err = bpf_link_prime(&link->link, &link_primer);
>  	if (err)
> -		goto error_free;
> +		goto error_unregister;
>  
>  	return bpf_link_settle(&link_primer);
>  
> +error_unregister:
> +	bpf_uprobe_unregister(uprobes, link->cnt);
> +
>  error_free:
>  	kvfree(uprobes);
>  	kfree(link);
> -- 
> 2.25.1.362.g51ebf55
> 
> 

