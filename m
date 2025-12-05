Return-Path: <bpf+bounces-76099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E99ACA6168
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 05:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EBBFE30648D2
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 04:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812C82D130B;
	Fri,  5 Dec 2025 04:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOhgHku+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D952AD2C
	for <bpf@vger.kernel.org>; Fri,  5 Dec 2025 04:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764908212; cv=none; b=Zyf9k+cI8/9uScm+njH5IbVnw0Pe0YxuYdpsOjMxWc/cymltSzY9LJYxDAM4fMeIGr1KOt7Bcj2ITb864+RxGdfro9XOxM9AMHEC/zch3EDTWPdwEdMr3PLRAo3CA9Wc5RBXedcIAPSwG0nhgtV12nK8RjabKfj70aZp7QUZ2vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764908212; c=relaxed/simple;
	bh=dxw02qcsWeoZgD1xFo+JtEl1GOxPVpGiPAPAeQW4TsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5e2Y78t1QpYwdjgsFIobJaCRLf3/wVdVL+g1rDtIWstD0ZxZ8w0FnMDr8BFtECM7300yep9/mY70loHPePmVIJIhdM7idYPVq38xV8ugY8mLAow80grk4i4sebXZY2JFUN8g+TbhwRsvF1Vp/PQcnZ1e4g49FzX3bmfo7dUTT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOhgHku+; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34374febdefso1753130a91.0
        for <bpf@vger.kernel.org>; Thu, 04 Dec 2025 20:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764908210; x=1765513010; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gBW4yg5h+y5NyBTEUuEzw2xT+B6nf8gmsqhkGkk4wrw=;
        b=NOhgHku+RZC//0KMej6BeCTj4zPow1M1PGbMGhdoJ4WpbWoKBKLqgiXzi6Edu5WBxi
         tUWG+34GrGfqpsonlKCIipcOvz+IS5yV9eXmhCLMn35ovooy9wNp6RO3wQUAHVBspXQL
         s/oITyhU/r4yDkJCOUnmDWuIMwYsRfGjlU7T5bss1R3m5JHke+S1Kw1HX+hOd07qczRW
         6xm8CgLhUhLdmKxhPaAtaqOpZeoCTVBhoaR9+MoxskMyeyKfQppQ4Vei6onoO3hHBiqO
         gWj3sjKH+ro+yn99Odgs8ppsudmHT2ueWy2RrK3qXagKpRNFgkVUkK2xRF4Vq2GmZhkN
         klXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764908210; x=1765513010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gBW4yg5h+y5NyBTEUuEzw2xT+B6nf8gmsqhkGkk4wrw=;
        b=CxcFmDep9ACOBPJlTNIRG3c1BX/AIn5Z4A9o7F+iaCkuj9XujwckTkutu0FyScbNYE
         HNAFs/4jvpM8E08/rxO+CatXQvjtBLptnFI4nTUQXAw6wukDcB598KQO0qdV8ltckckn
         WUjd7MJMAVKP1bDlUuqzwEnk462TyE1oe+Preuu5SIR4vhVZEZEoT3omMtvky+qKmkKE
         e60LmYCL1c0fVVxDPc5w1j0j8t5U5vDyPS+rtZrw6dzbrpBtiNC+WxPe2xAdhPreJsNi
         ZcHh8Ys99JmyY6FHmXPLNFtunMCKQcd1N3H2d/1TXhSDsjCLENZJ3TgPDKCr//pCH/1e
         FxpA==
X-Forwarded-Encrypted: i=1; AJvYcCVqpfZXSEaLXgutkqKN4fT3n6geFoknEA5n6V3dgCIRa4myFkjU0U3BkYqy/PKP/4JSFI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBXx1x4aA/A3ESinLdQs0SSsSdJeDLrPHLjAYsZ+bUM7wB6GQd
	KhJSPmFuSN9bi4/YG1CJp3JgOP6l2eNzxqfXiCURX9idnhoIJ7hIFcUL
X-Gm-Gg: ASbGncss3WeTWT4pfua+1Lbj+cebGK8WP36frsJt8I+Ri3wMaCwYgcP1qdKXeCf7dNL
	qTmlNEWISfdQrRH6Xu6pceVmWF1WtZUkWfZdubV4Vym1+GHdsElbK5KugvXKhxGiVG05/F5+y6o
	WpmwSaFCkuLLU8HOH9rsTP2qficwCS/dX+E4Y7gvdLenVw6NBsk28s6I8EwDflhft4m27k2DMRV
	bXqSiooUqQwG1zKsL2lyH6jond8swSngcU8t4hJ8mjHNeGNXYsILWwTjlRrjfIJLpO6sJHmlNMl
	N0HVcYoK6PgjGYJd2GQ3i0zGi8FLysRPxDSkL76hBd+Vigu7yZ7mCMyZqHarK2E5D6te7J8FahW
	7a9NhhQLroMWfOjZhi8fFwhE0zJLHM/Ep3IUXLgshkSYF/se3VE9v+OPetX+BY6ST/nV7VpJf0e
	5a17nIMcaSYC0E+VVf2XZS4hC3XhGq5V51ww==
X-Google-Smtp-Source: AGHT+IFPM4tJWEJo1KtUYT7trSAyUM/sJov0oTxTpBLUgPdWMcAI1975L261q4edEQkelnqT7yTjbQ==
X-Received: by 2002:a17:90b:48c4:b0:341:8ac7:39b7 with SMTP id 98e67ed59e1d1-349127fd714mr7851540a91.25.1764908209939;
        Thu, 04 Dec 2025 20:16:49 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-349128be266sm3818595a91.0.2025.12.04.20.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 20:16:49 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 4 Dec 2025 20:16:46 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org,
	sdf@google.com, haoluo@google.com, yhs@fb.com, edumazet@google.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
	mjambigi@linux.ibm.com, wenjia@linux.ibm.com, wintera@linux.ibm.com,
	dust.li@linux.alibaba.com, tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com, bpf@vger.kernel.org, davem@davemloft.net,
	kuba@kernel.org, netdev@vger.kernel.org, sidraya@linux.ibm.com,
	jaka@linux.ibm.com
Subject: Re: [PATCH bpf-next v5 2/3] net/smc: bpf: Introduce generic hook for
 handshake flow
Message-ID: <3a0d2f44-6f1c-4f79-b8cb-f57387933a5a@roeck-us.net>
References: <20251107035632.115950-1-alibuda@linux.alibaba.com>
 <20251107035632.115950-3-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107035632.115950-3-alibuda@linux.alibaba.com>

On Fri, Nov 07, 2025 at 11:56:31AM +0800, D. Wythe wrote:
> The introduction of IPPROTO_SMC enables eBPF programs to determine
> whether to use SMC based on the context of socket creation, such as
> network namespaces, PID and comm name, etc.
> 
> As a subsequent enhancement, to introduce a new generic hook that
> allows decisions on whether to use SMC or not at runtime, including
> but not limited to local/remote IP address or ports.
> 
> User can write their own implememtion via bpf_struct_ops now to choose
> whether to use SMC or not before TCP 3rd handshake to be comleted.
> 
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> ---
...
> +static struct bpf_struct_ops bpf_smc_hs_ctrl_ops = {
> +	.name		= "smc_hs_ctrl",
> +	.init		= smc_bpf_hs_ctrl_init,
> +	.reg		= smc_bpf_hs_ctrl_reg,
> +	.unreg		= smc_bpf_hs_ctrl_unreg,
> +	.cfi_stubs	= &__smc_bpf_hs_ctrl,
> +	.verifier_ops	= &smc_bpf_verifier_ops,
> +	.init_member	= smc_bpf_hs_ctrl_init_member,
> +	.owner		= THIS_MODULE,
> +};
> +
> +int bpf_smc_hs_ctrl_init(void)
> +{
> +	return register_bpf_struct_ops(&bpf_smc_hs_ctrl_ops, smc_hs_ctrl);
> +}

Building csky:allmodconfig ... failed
--------------
Error log:
In file included from include/linux/bpf_verifier.h:7,
                 from net/smc/smc_hs_bpf.c:13:
net/smc/smc_hs_bpf.c: In function 'bpf_smc_hs_ctrl_init':
include/linux/bpf.h:2068:50: error: statement with no effect [-Werror=unused-value]
 2068 | #define register_bpf_struct_ops(st_ops, type) ({ (void *)(st_ops); 0; })
      |                                                  ^~~~~~~~~~~~~~~~
net/smc/smc_hs_bpf.c:139:16: note: in expansion of macro 'register_bpf_struct_ops'
  139 |         return register_bpf_struct_ops(&bpf_smc_hs_ctrl_ops, smc_hs_ctrl);

Should this have been

	return register_bpf_struct_ops(&bpf_smc_hs_ctrl_ops, smc_hs_ctrl_ops);
									^^^^
?

Guenter

