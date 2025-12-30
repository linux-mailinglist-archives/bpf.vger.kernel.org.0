Return-Path: <bpf+bounces-77507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A10C8CE9320
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 10:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4615C302F6B6
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 09:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F84428C84A;
	Tue, 30 Dec 2025 09:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WEhTu2fs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF12296BA5
	for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 09:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767086060; cv=none; b=plV7It+bCaXIjszcY+c6UBZaAImcIf145SCSGfdwBtv2T6w34EjqV4RviK1rRvZhKY1zF81o1Mu4ymTHXJG/4/swotazR4va3yoGNpGByEMW37pzTWsxQL9VK7hFJflsnGXj/4Xo7wLLokP9kGJthInAk/TtMCZ8ttJCUo3X1uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767086060; c=relaxed/simple;
	bh=kMYS4nDZW+xqFk8WFjUw9cG0U0R3IAGkPMZX0g8pS98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QJD9rV0qImqT2NqpXj7XgFMa9j8O56WlTz455sLNMt7+mil4zbR5s/1j+EZ3aVnLNoNdVinAOSTEJqIMmXyJ5jonyUkwIXgRJBiaXm7Pfhn73zuHGM+tJE0YlHzVDSXP0rxdOzaEpPl1HdGUL+8a2tTqBtfNxuURFyNfmviRgno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=fail smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WEhTu2fs; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47774d3536dso77912135e9.0
        for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 01:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767086056; x=1767690856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V6HQy+93eKiQBXRGPg3IyKK5TzImasqN2aR2WZLtqxk=;
        b=WEhTu2fsAIgu6DnvFwF/GqOKZev7dLH4f3Asap4bWY5kgFud9tUD6X2wRgjlo11UHR
         ZqCCaBuN32tspEn2MbyOB7rlRo2Ne6CBLNtJO3tQj7MXE5L7yg59M27VgVTUlPbfMz6j
         H9002fd3pMQ8PXnYGTxbQRhtdU7HxEkNbVw8qLAg4G6wUOEewU9H25xib/+H9nJmu7hm
         RgDSzyirjQcC/88ATOMrgtVY0ndCfceX/5lms+T7j4CVfAUGUY0fMqq/KcvKFkumGBrk
         ZzTqg8ISWUgLMG7amkFvnp89ccsCe27DvsF3MyBpdHFxWukC2inYngj8DuXOWRTiRjbr
         nlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767086056; x=1767690856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V6HQy+93eKiQBXRGPg3IyKK5TzImasqN2aR2WZLtqxk=;
        b=WmL47LCmfQNg5MOOUc51jKBZiBs/WCTaaCAPN6dW9RnSLioMw+r+8Hc9LN0dr2mX3R
         CyDX22hgFrbcY+VII5I3vX67vcM9WX4Qpk+XuAsziZjbClOSzGYejH/rKYx4TfHWKS7P
         4s2hi5FmnTVJdxuiS5tRIn+eyerz8OA99nDIux2MoB6vDDlDZxgLlTAdMHVM2NXa74z4
         qJvJL1P8peZDeUg3XpL4WkFYXNF5ISwYBJ+JOCAsZ5dn822s1dY5WeGOF49ZuLw+OjPm
         jbireZ0jexoN5BJw9zbMnSGkM0DSLwTC/UoL0YU+75n8XMwJ/zFxcRGMwbVWBqF/fEjJ
         KBSA==
X-Forwarded-Encrypted: i=1; AJvYcCXRrKyZpZe16PGKpto1Fi+aJ1Di/prcOqwmRdKbpqrkZ6IC89c25dYOrhreBW8SPSF2c50=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZo+VXS1A1V7Oz/CqQ4DXp2+ktxX67FLzG/52JrG9XC01Vui5k
	W5j9YhCAVE6B8rlEyTnMrzxgR9+fyNcFgfHbgnTs3kja4mK0Cuwt14C4IHqTcyAyErU=
X-Gm-Gg: AY/fxX5u/EoBI8kZx9ISGvWu0+OXouzfIFQt9tyJic57oL8CseTAnBoubcpQpJfDSXm
	Oz3pRQVDUDSIdtCmXDBacvqnBdg7pXydl3lmTw79fsDFM27cVbfZYehs1zFstSsdprAFpG5qyKs
	dY9B8m6fptK+KhDLsvYf0L75cIl+NebslMqMXpXY53ctnEvd77eVpMagJNphQApVR+pgiE4rAw+
	+EIHmZFYeiN/59XyKNS/vJo+2GVw7D/hYwyOA/rdUjIujDsELuRZPswOOjsFsk7c3bVGhkzr5ah
	CssFUN9ULI8FyoPVHPp9MoKytU8mXE7e4pm+Q7P7zk0YTMsI9mu0jMBuVT51+agTcJz8VJ1uXFM
	DO8fmN+V2KvPhUCM6uMU3RX1EzsFcHq41x/T3n3fiTANi/8m9sGeMfoQsriu/uRMuiGQMlpBkS2
	DdjWlIPTv1tl4FWWrGuktdDyrbrqXV3w==
X-Google-Smtp-Source: AGHT+IFKv3lNIvVVFE/AcEy5+lpmg1H1P5fZOOF4vDE/CodIsqYQs0HP6/eTBXDVP5Nqswfi6ttRjA==
X-Received: by 2002:a05:600c:8b82:b0:47b:deb9:163d with SMTP id 5b1f17b1804b1-47d18b99b99mr353825415e9.7.1767086056038;
        Tue, 30 Dec 2025 01:14:16 -0800 (PST)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a5486dsm254520345e9.9.2025.12.30.01.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 01:14:15 -0800 (PST)
Message-ID: <0d82084c-e633-40ff-b9fe-ce1532f28fdc@suse.com>
Date: Tue, 30 Dec 2025 10:14:13 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1] module: Fix kernel panic when a symbol st_shndx is
 out of bounds
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>,
 Nathan Chancellor <nathan@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, bpf@vger.kernel.org,
 linux-kbuild@vger.kernel.org, llvm@lists.linux.dev
References: <20251224005752.201911-1-ihor.solodrai@linux.dev>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20251224005752.201911-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/24/25 1:57 AM, Ihor Solodrai wrote:
> [...]
> ---
>  kernel/module/main.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 710ee30b3bea..5bf456fad63e 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -1568,6 +1568,13 @@ static int simplify_symbols(struct module *mod, const struct load_info *info)
>  			break;
>  
>  		default:
> +			if (sym[i].st_shndx >= info->hdr->e_shnum) {
> +				pr_err("%s: Symbol %s has an invalid section index %u (max %u)\n",
> +				       mod->name, name, sym[i].st_shndx, info->hdr->e_shnum - 1);
> +				ret = -ENOEXEC;
> +				break;
> +			}
> +
>  			/* Divert to percpu allocation if a percpu var. */
>  			if (sym[i].st_shndx == info->index.pcpu)
>  				secbase = (unsigned long)mod_percpu(mod);

The module loader should always at least get through the signature and
blacklist checks without crashing due to a corrupted ELF file. After
that point, the module content is to be trusted, but we try to error out
for most issues that would cause problems later on.

In this specific case, I think it is useful to add this check because
the code potentially crashes on a valid module that uses SHN_XINDEX. The
loader already rejects sh_link and sh_info values that are above e_shnum
in several places, so the patch is consistent with that behavior.

I suggest adding a proper commit description and sending a non-RFC
version.

-- 
Thanks,
Petr

