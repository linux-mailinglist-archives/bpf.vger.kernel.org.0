Return-Path: <bpf+bounces-34598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A7192F0B7
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 23:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77ADBB2305A
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 21:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9234D19EEDB;
	Thu, 11 Jul 2024 21:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgWINTWC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F522836A
	for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 21:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732215; cv=none; b=Rg+wOsoWl1CmLNu3OT/trq7NDovzuSmSdBveCWBiRWwLQGqyTbIdmSgkmjMtPLFu5c/2V8tWaVU5fT61x3TKx425V51sAeiEjFbOlUBMBPICpuz4x6+P3bSb1XhxFMyOYjyPXcgfsC/Iu/GYMYXVUGSrScC0XINimZEzEm37FCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732215; c=relaxed/simple;
	bh=d4Ou1mIXxDdzA2FHhn7L18KagDSPudAyqBr+koWg0Os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KEq63DmTFAoCVosryGFaoJOqODDH5wj0omSKHaKhO9rDpuU4jAAfcmzTv/c10Oxnulp7O+zbjOkp+jxnXwRCUXXBRD1rMJmxlT9PqcxDnDwmxriGw6uAxoRez+7nDKLhub/ikdnUaZ404mjD0h3RIyo+q0Mzo8pYVYhIK2e0aDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgWINTWC; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-58c947a6692so1817729a12.0
        for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 14:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720732212; x=1721337012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wDQuqhsy4RmnO0GfTUtKrqvGDGIlQMtqLo1YEGhLdrY=;
        b=bgWINTWCfdzCCrkcLPe68NFq5r6BWDmzyKpDGa2tCS6PI6ZeHKeqYSR6EoOgQCg1cJ
         KVBoGAZBk6eucmAK1d4AJ5uvHafHApMMu8UpTHfOBQ40xB2zn4hAfoGpWGewDAYk9z9e
         2GeR5Eg+58G2rEJpnhwhTOefehAVhMgfbCW5ImMUOCaWwVW9Bx2Mqi6aF1koJiPPj9tI
         T0mm2sGd4r6TnKXGznUGgkaZxbRDxafNXm/CwZRU7vHuMxVOMZazKW2H4TkvL3+3Z4ij
         8r1EOKgbG4AOFNmeTY+HFMW4LXPVjdy4e+xbZJagcPxzyXu0bp+LxuwGZeMInKV+N2cM
         QOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720732212; x=1721337012;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDQuqhsy4RmnO0GfTUtKrqvGDGIlQMtqLo1YEGhLdrY=;
        b=ps/iDIDvmiuShCj3/iJCq/71oTwndXUlF0BVAq7f+Tn2roEOKGRDFRBAG4XvQ4zT8T
         UcJvo212AC679Xrbc9JYXQcjcqCd86J3yOzp17OLMFH7XiCMyNKhEgk+l4L+gztuE6W5
         T3yB/CZkmU3ijLQ97nhL5ft4lEaKNlulB/Bm5c8VXZFoChk1LHkAG+1QqNVqmTly8U6P
         64kMpPl6AdaDxG9LTbCzJKAjZpnbSnpJpp0mMFuy5bU33DOAdKZp06u4rHRpMYQE+Nd7
         SIn9CgANE2qc9CJiS1RUUugbGjpjFuZHo49+nooUMd1Ba5PVNgKESfzlASwED3z1rZHJ
         +5XA==
X-Forwarded-Encrypted: i=1; AJvYcCXwXa5cFgfcqToU28OYf7MMqExnqfIJQSomuUY0fGYpk3ScooaU/EkwBZULmyA6BNKXWrMZRlKX/QemNaGWU4Iva6qX
X-Gm-Message-State: AOJu0YxxdJjrBHs2z6AE4u2UMZhwRi8PfNrrzjdwxXXxiLUDsFutdDhm
	FsvFl/qDZvCHdC/VuC0/LAdkZ1yAqS6ATFcQ4eP4i0XbQzOv0zB0
X-Google-Smtp-Source: AGHT+IExU+RDluHgGWRPUkNcLuYJAIBOZ+jNqsfqKi+NnPjeQCVzjC1sQU6HCftN5dE+05hrHk0xVg==
X-Received: by 2002:a05:6402:1801:b0:57c:6188:875a with SMTP id 4fb4d7f45d1cf-594bb869e4dmr5842534a12.26.1720732211563;
        Thu, 11 Jul 2024 14:10:11 -0700 (PDT)
Received: from [192.168.178.20] (dh207-43-148.xnet.hr. [88.207.43.148])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bba54b07sm3814651a12.14.2024.07.11.14.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 14:10:11 -0700 (PDT)
Message-ID: <e5fb2073-82a2-4054-84ec-611880ad755d@gmail.com>
Date: Thu, 11 Jul 2024 23:10:09 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: annotate BTF show functions with __printf
To: Alan Maguire <alan.maguire@oracle.com>, martin.lau@linux.dev
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
References: <20240711182321.963667-1-alan.maguire@oracle.com>
Content-Language: en-US
From: Mirsad Todorovac <mtodorovac69@gmail.com>
In-Reply-To: <20240711182321.963667-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/11/24 20:23, Alan Maguire wrote:
> -Werror=suggest-attribute=format warns about two functions
> in kernel/bpf/btf.c [1]; add __printf() annotations to silence
> these warnings since for CONFIG_WERROR=y they will trigger
> build failures.
> 
> [1] https://lore.kernel.org/bpf/a8b20c72-6631-4404-9e1f-0410642d7d20@gmail.com/
> 
> Fixes: 31d0bc81637d ("bpf: Move to generic BTF show support, apply it to seq files/strings")
> Reported-by: Mirsad Todorovac <mtodorovac69@gmail.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  kernel/bpf/btf.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 4ff11779699e..d5019c4454d6 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7538,8 +7538,8 @@ static void btf_type_show(const struct btf *btf, u32 type_id, void *obj,
>  	btf_type_ops(t)->show(btf, t, type_id, obj, 0, show);
>  }
>  
> -static void btf_seq_show(struct btf_show *show, const char *fmt,
> -			 va_list args)
> +__printf(2, 0) static void btf_seq_show(struct btf_show *show, const char *fmt,
> +					va_list args)
>  {
>  	seq_vprintf((struct seq_file *)show->target, fmt, args);
>  }
> @@ -7572,8 +7572,8 @@ struct btf_show_snprintf {
>  	int len;		/* length we would have written */
>  };
>  
> -static void btf_snprintf_show(struct btf_show *show, const char *fmt,
> -			      va_list args)
> +__printf(2, 0) static void btf_snprintf_show(struct btf_show *show, const char *fmt,
> +					     va_list args)
>  {
>  	struct btf_show_snprintf *ssnprintf = (struct btf_show_snprintf *)show;
>  	int len;

Hi,

The module compiled without warnings/errors in the same testing environment:

  CC      kernel/bpf/btf.o

Tested-by: Mirsad Todorovac <mtodorovac69@yahoo.com>

Best regards,
Mirsad Todorovac

