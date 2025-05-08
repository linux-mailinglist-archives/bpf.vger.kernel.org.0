Return-Path: <bpf+bounces-57818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D33CAB0680
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 01:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7D1C986581
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 23:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4A02153ED;
	Thu,  8 May 2025 23:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8z5mlYB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918FBAD5E
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 23:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746747109; cv=none; b=OTRlkWBa7LySN8aZ3hXIZN5w/irV0Ezh0EuxeGx1/DMjk2mgfTp+aceYElZkI3T/D5OTPV75gpbnb5bq0/6wVtRXYhcP9NHyoMJQ/rzBdQeFyfsl/xqYyiP9+SbPw5HooXINYStjW02MNy0I/TEivGNt41pW2BKeUzp5qPTAxeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746747109; c=relaxed/simple;
	bh=cTpX5wfk4EMCzbp/6kWBQ7ooeJNtG4BVGij3qwKrq+g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d3HTO7PaEDwQ3u8lAy2SdWNcH4FyEujj4poPhYIAVdnGENcw6MJlTjkx1WLUd8Vu2dvdlZyziOhgvjCNBX4SQUKiAY/7X2MQvED8bTjAme24z4P3X9QtjOeYwWUJp12T38XbvjinWytZg6YeOTIaU1W5GoV2SvWi+z8trRU8BzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8z5mlYB; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-739525d4e12so1561944b3a.3
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 16:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746747107; x=1747351907; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ovRf7sqYZxsYNDGt/UGJsAaExmRaOMqq/ovdPYUSnVA=;
        b=a8z5mlYBAJqjOUmqz3yyzeOg5jtdNX1wJ9Fah7EwfXTmO+d2DFyCUmqVLFK2t9bC8v
         g6fvZiKmy3ptKYENRbsEU55OAE/1mCtRVFpK+a9zP7ENFBPC8qu7Uk6ssFlXZvQ4vika
         PFpg1oMwC2E/zopqqQwbqT6nltjfD2muSvL1/E5abXrqE2D3OkxsbSXu0NBdvLfwgdiO
         Tc0R1rmiZeWQ1ud5lnk8W1b3QWCz+IZ4KGVdWkQqe4KL0wTozir8UzrwNWRG1AH+Dr1a
         H6FMbqH49PwvqMtiBurxL4DSFcaIGmJ5uQlRVpHkySGSQOHefPGcntLc09nyvHbzVU90
         AkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746747107; x=1747351907;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ovRf7sqYZxsYNDGt/UGJsAaExmRaOMqq/ovdPYUSnVA=;
        b=PrIshzTrH7tay1f7YxSzJ0VUXvHSnx01po2wTzuHc4o2h2hSCQ8oa+KlD9z4BYVkD6
         JTb54VrpBN7unSJHmDtM05+I9wCfP8w3jH0RswOFvO4MQEENvI6h6wOX9Uamk3Xf5nt4
         3YY04ArB01MMgO+v6dxeScplhWCcNLLaxnXC8r24lf+jqcO+obV0uymZnJqMCEM7m+ir
         9DohMMGaSgPVuu7Ryp/WpbsQNutVGVMWnUbVKwwATMILf/V5+GFWAglcaNp1xEYkwLuA
         epnZatzFyiXa3Snz7aqlAI/Iki2oeU0UMzmvmJTyyX4x02k2yUzriRAMjgcEHjwBmgAr
         T0QA==
X-Forwarded-Encrypted: i=1; AJvYcCW3EdfMmbXxGFmMxPFDWtPWpQ8SlE8ecVBCBcuIx2zD4vQsVJcqrpr0xiU0mQFAkN/q56Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZsNjtOsQW8GgEmhCS5PGhXHG2wy9dzxZ4nrQ8Q2kxqaitvVua
	Ecb3YGWsgdf6hr4AABuUSX4aKUrtwpKy4RyUAD7Jiyiiaop4XZ0d
X-Gm-Gg: ASbGncsKctTFAjOg/60cDb3q5rZ5Fnq2nGbqKDvVeMXsshQP/6A1Sq9vDO/YFmEb6zE
	FOqh1S6u2qXaKyH6yLKEr0OywPRa7JO0sgCFbFtJX8Z1J9P3xmRzwVF4S6hw66e+PGtToZmuFTc
	5l09RAvkIbQVgwAsWZXXxeQ0nR/TbtVPFy0MV5RMCTbSLGRWll/e5sEK+dIA1qgN/RbLbErvkW2
	OYkUbByi8kZg8+gVxDj21GyBMpCmjZOq2JJYS7oWqLLYX47UzBzJAc5mvhVWTtkrd6FKqGbRkLE
	tS4K09ocmg3zx3wj55w2ymHyj/cdmn2AH2THP0rmOXtoMg8=
X-Google-Smtp-Source: AGHT+IGcA6aBiv7jVtWqN5Y+SkRLch70nLqkDKmFP6LT8QZjwhlmbHyxtHi4czucUKe+80R9EetWaA==
X-Received: by 2002:a05:6a00:198b:b0:736:5e28:cfba with SMTP id d2e1a72fcca58-7423c056d66mr1675248b3a.18.1746747106782;
        Thu, 08 May 2025 16:31:46 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a40589sm616241b3a.145.2025.05.08.16.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 16:31:46 -0700 (PDT)
Message-ID: <82fa97637f995a1a004221b8d4e869e775a5f008.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 09/11] libbpf: Add bpf_stream_printk() macro
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, Emil Tsalapatis	 <emil@etsalapatis.com>,
 Barret Rhoden <brho@google.com>, Matt Bobrowski	
 <mattbobrowski@google.com>, kkd@meta.com, kernel-team@meta.com
Date: Thu, 08 May 2025 16:31:43 -0700
In-Reply-To: <20250507171720.1958296-10-memxor@gmail.com>
References: <20250507171720.1958296-1-memxor@gmail.com>
	 <20250507171720.1958296-10-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-05-07 at 10:17 -0700, Kumar Kartikeya Dwivedi wrote:

[...]

> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index a50773d4616e..1a748c21e358 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h

[...]

>  /* Use __bpf_printk when bpf_printk call has 3 or fewer fmt args
> - * Otherwise use __bpf_vprintk
> + * Otherwise use __bpf_vprintk. Virtualize choices so stream printk
> + * can override it to bpf_stream_vprintk.
>   */
> -#define ___bpf_pick_printk(...) \
> -	___bpf_nth(_, ##__VA_ARGS__, __bpf_vprintk, __bpf_vprintk, __bpf_vprint=
k,	\
> -		   __bpf_vprintk, __bpf_vprintk, __bpf_vprintk, __bpf_vprintk,		\
> -		   __bpf_vprintk, __bpf_vprintk, __bpf_printk /*3*/, __bpf_printk /*2*=
/,\
> -		   __bpf_printk /*1*/, __bpf_printk /*0*/)
> +#define ___bpf_pick_printk(choice, choice_3, ...)			\
> +	___bpf_nth(_, ##__VA_ARGS__, choice, choice, choice,		\
> +		   choice, choice, choice, choice,			\
> +		   choice, choice, choice_3 /*3*/, choice_3 /*2*/,	\
> +		   choice_3 /*1*/, choice_3 /*0*/)
> =20
>  /* Helper macro to print out debug messages */
> -#define bpf_printk(fmt, args...) ___bpf_pick_printk(args)(fmt, ##args)
> +#define __bpf_trace_printk(fmt, args...) \
> +	___bpf_pick_printk(__bpf_vprintk, __bpf_printk, args)(fmt, ##args)
> +#define __bpf_stream_printk(stream, fmt, args...) \
> +	___bpf_pick_printk(__bpf_stream_vprintk, __bpf_stream_vprintk, args)(st=
ream, fmt, ##args)
                           ^^^^^^^^^^^^^^^^^^^^  ^^^^^^^^^^^^^^^^^^^^
                           These two parameters are identical,
                           why is ___bpf_pick_printk is necessary in such c=
ase?
> +
> +#define bpf_stream_printk(stream, fmt, args...) __bpf_stream_printk(stre=
am, fmt, ##args)
> +
> +#define bpf_printk(arg, args...) __bpf_trace_printk(arg, ##args)
> =20
>  struct bpf_iter_num;
> =20



