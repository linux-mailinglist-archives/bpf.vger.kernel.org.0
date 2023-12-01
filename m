Return-Path: <bpf+bounces-16401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFDA800F97
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 17:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D561B214F9
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 16:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632C94C608;
	Fri,  1 Dec 2023 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZ6Fg5nw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4ADFB2;
	Fri,  1 Dec 2023 08:13:26 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54c11430624so3354083a12.1;
        Fri, 01 Dec 2023 08:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701447205; x=1702052005; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wIiVfGjOqLbqrFMUXwsWqhKvCLy0+YRMCVG4285ndOk=;
        b=eZ6Fg5nwC6wL1t03K/dv5dwlbMG2M+u55VESUlN37M5FGY/rpGPSS+bwYyi6qkdNt3
         fAykxQjHxnTcn2vDP9JPuq5Cx/jyx3HAZE12LC2vSe43JkAiGlEmQ2tcLgeM4jQmgh6x
         pMnWiHa174x1onP3leoFrIbWpyxHL0D+AbQkuVuyY+5tL2RW2LKV8VRNHydTqdWqTbNY
         XeX2NFsAh2cnZmE8Lhnjqj7m6oMaWJlboDl6KPR1SP9XBHoyX42/bYyMS4TmNQLTqeEp
         n0jq5ohEPLaGtMbgmCFL2gWeF78EOcxlQlgTADu6tYTSMzOurI7j8fMxaj9aiHuu64Ug
         GUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701447205; x=1702052005;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wIiVfGjOqLbqrFMUXwsWqhKvCLy0+YRMCVG4285ndOk=;
        b=RCVDKmHz/PKUVGp9puXdQ0Id6TWvE0Y7ZuoBPi7S27pnE0NL7/dE5oNlAgp0QQX+Ft
         NHo3dt4dA+VWwwwlpSMBr8nqDNp+CeHl6wvt0VeysFYMrz2rpM23+kpmj2iLOMuucGld
         p9yfNKHbIOFmo8C4V/EJm0QHjSSeiif8LjONTkJbmlL67B8XkmHT+GM4bYTqW1ILydIk
         sc/MpTrFsRXnbshniWr5tU6mojJ7XJIERMbYa1ORpQndIsN7AXMARK9UaGLX+smdLhTh
         oHE3Stb67iPSls8Fr7WoNAsmKIwewupiFfQ9RqDiCHiIKbbmBLl0PWGluPZR+LSkV3UF
         nNSg==
X-Gm-Message-State: AOJu0YxrGqvjcrr4nZbQIiK45J/4+e9NrxF0iXzmDEfK7ccVxgg4hgUn
	ImLFw6IJnhbpADGsXtD//BY=
X-Google-Smtp-Source: AGHT+IGk3WBJ86FEE6LGFsbCpoX1T7woOAbx/+XZ2RJZcdaqx4RDMLAiNXn0qRfATUxZ9Ok2nqr6OA==
X-Received: by 2002:a17:906:9b44:b0:a19:a409:37de with SMTP id ep4-20020a1709069b4400b00a19a40937demr1403155ejc.55.1701447205044;
        Fri, 01 Dec 2023 08:13:25 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id c6-20020a170906694600b00a0aca4d2b25sm2043603ejs.180.2023.12.01.08.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 08:13:24 -0800 (PST)
Message-ID: <18808a1815e76a3c3fb661ff6a588a50389b1475.camel@gmail.com>
Subject: Re: [PATCH ipsec-next v2 3/6] libbpf: Add BPF_CORE_WRITE_BITFIELD()
 macro
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: ndesaulniers@google.com, andrii@kernel.org, nathan@kernel.org, 
 daniel@iogearbox.net, ast@kernel.org, steffen.klassert@secunet.com, 
 antony.antony@secunet.com, alexei.starovoitov@gmail.com,
 yonghong.song@linux.dev,  martin.lau@linux.dev, song@kernel.org,
 john.fastabend@gmail.com,  kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org,  trix@redhat.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org,  llvm@lists.linux.dev, devel@linux-ipsec.org,
 netdev@vger.kernel.org
Date: Fri, 01 Dec 2023 18:13:22 +0200
In-Reply-To: <ib27gbqj6c6ilblugm5kalwyfty6h4zujhvykw4a562uorqzjn@6wxeino6q7vk>
References: <cover.1701193577.git.dxu@dxuuu.xyz>
	 <ed7920365daf5eff1c82892b57e918d3db786ac7.1701193577.git.dxu@dxuuu.xyz>
	 <20c593b6f31720a3d24d75e5e5cc3245b67249d1.camel@gmail.com>
	 <ib27gbqj6c6ilblugm5kalwyfty6h4zujhvykw4a562uorqzjn@6wxeino6q7vk>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-11-30 at 18:33 -0700, Daniel Xu wrote:
[...]
> Good call about adding tests -- I found a few bugs with the code from
> the other thread. But boy did they take a lot of brain cells to figure
> out.
>=20
> There was some 6th grade algebra involved too -- I'll do my best to
> explain it in the commit msg for v3.
>=20
> Here are the fixes in case you are curious:

Ouch, I knew my code from 3am can't be trusted, sorry for that.
Your math seem to make sense, thank you.

[...]

