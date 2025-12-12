Return-Path: <bpf+bounces-76516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF2ECB8134
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 08:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FF3C3045A7D
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 07:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5B23090D7;
	Fri, 12 Dec 2025 07:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3bJVq+D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F14287263
	for <bpf@vger.kernel.org>; Fri, 12 Dec 2025 07:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765523410; cv=none; b=fC45M4zriY2+IKrzzPfd1JRoGRpeA2Gep3QDjdQ0jDKBIXgzMof6t3c/oes5H9eBQz1lb9ViM3QbVdujqb3Fwr+ZasWbKgGoKPrrK3FcsPDL4Oz4DWTEA6FDDvz1gA07WHVRU6or1dMTrJ6Rl4rkKHvS7wwnovwyXVNvlG98bAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765523410; c=relaxed/simple;
	bh=ski7sMyp+O2WAeYvfHItoMLgXRCcG6iQZx02RmEom4o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fxWZxDFC9pH0eD2IaxmoBffjpRctshAPAMeDA1Ca+h+4CpA+k+ahns+6sq3YbaIoSP1E9zCs4ARlCooD9ufpdIyAQvWPy0C/Ghk1iaS1oyJilkIqnk+loRvNoXpa4dStEQFymYd+mPcAmnxUjFQtvsSMtpxmZ7NfM0iN4ZeWoVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3bJVq+D; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7aab7623f42so1136483b3a.2
        for <bpf@vger.kernel.org>; Thu, 11 Dec 2025 23:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765523409; x=1766128209; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ski7sMyp+O2WAeYvfHItoMLgXRCcG6iQZx02RmEom4o=;
        b=V3bJVq+DEwo/GVW+NAWm4LQypQVAK0ZbbJSFzxkR+/cOMYahE0pid8b4tyGzx4zVh1
         jSF10nahz1dUd7EVqYwMV5WRqIT0x0vOX9ztutwGdxlrplNkP/jXeGhtOLjJkt6OZUEP
         wljBMY9dE0OFroYxk5/qU7I4urZf7gSgkPltQuasoo9cu6djCkT+GLHBOBa1WZr+q83x
         MKiLXiqoqOQDdmZTmTstydtqccGTqZWKC6xy69Q56NCUhgytAiVbPuzspHAcrXcZfRbr
         XiDxcw+C6Hl+ziX3FNI5r7UzOHyQV1x5iK0o5x0fbztoX3LaTuhqSIHJH8L12GdMdvH9
         P/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765523409; x=1766128209;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ski7sMyp+O2WAeYvfHItoMLgXRCcG6iQZx02RmEom4o=;
        b=g8bWhQd+bgShvZg2FEzv1NUyq7YJqgWgwFcyiyNKmvwmXNL+7UILC47oLScwNeqVb4
         eXTYHPDaXYG86pSGPSurYoGM3abT+boH/zpKHX7bjrbNw3193HeIygn5/tQUTYgA1DlH
         LO7GYqYMTyghCLQuQOpcho4aOzUMVnNXDEqJZQuWiYPrmzZWDshioKKIV6dmLOuRFt7Z
         Z58N193SHG1G/1GIGPmGKwz/ygUoxDyu3+UJw/qO2jT4nMrYMYCC5eUygcv5y1P2G/TN
         61X3+C0eqp+FuP7hLeTGy4HNw1H02zy5OaLoC8Z3y9FVDkINp58s7uAqSe2DYskMMba6
         kqgw==
X-Gm-Message-State: AOJu0YzgdKrbpL5h8oqP+axFCiahUWSN64zVqV3j22S/GCvExjxHZQ5l
	bQJVxPCtK81aPkVdJhhHh0jRmN8YCxSBNvKEGKnbn3fDKGqA1xnEYbIP
X-Gm-Gg: AY/fxX6vc3z7BSciZhG9+ZFMo7d7z6TUHmffnZfVg9nIADRFTmWyIQmd+dN2bePimLI
	eQIrGT0Wu8Al3OlXKBg2qAiicBSF/Ue/4SwGceFGPu9md1EMPUKgK+sSiqcHvXaJXR9RKYItMFc
	yp7PW3dxSE2Q07sVmAJNDJiTcgWLsm/NZwX9HJrgrU7cNv+wwHIa6a/9JSWYRk/Lqr4yPcHb1qp
	85Cgjef1A8eFUWD4QSI8Jr8aoDm3i3Z0mogh8fWrYo3APyEMlNAY8mEEeENPWUtDFd9VD92Id9Z
	z2TToJcXRix8QoGGGMPAO/+6Pg+e6OrLLQ9NJvSP87Fe0afc3SvxdxnMZfhc9kE/LRm3RbkU2+s
	dFuxjlG/NkhAjcN5HTlp3HaqNtcQsYTla/7m6J7IUXxpj8OBGxl4sAxjX8kvGdyi1i1d1IM4RSh
	wH603qisFJ69jR+kZBuIajz1wEBNcJtgPEwm/Z7YqgpwE=
X-Google-Smtp-Source: AGHT+IEZgH8C3X2hKHFaGk8m/sj+wXbz4vPJ51iPhQv7rcnwmjwBtTIy55XTg/nxIWcxrRVf5+4t4Q==
X-Received: by 2002:a05:6a00:a381:b0:7e8:4433:8f99 with SMTP id d2e1a72fcca58-7f6694aa45bmr1178150b3a.33.1765523408660;
        Thu, 11 Dec 2025 23:10:08 -0800 (PST)
Received: from [10.200.2.32] (fs98a57d9c.tkyc007.ap.nuro.jp. [152.165.125.156])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c4aa9b56sm4327224b3a.39.2025.12.11.23.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 23:10:08 -0800 (PST)
Message-ID: <f8c5f2a6c05c5a24076aa39fba7a45d30eb5334c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/6] resolve_btfids: Rename object btf field
 to btf_path
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>, Nathan
 Chancellor <nathan@kernel.org>, Nicolas Schier	 <nsc@kernel.org>, Tejun Heo
 <tj@kernel.org>, David Vernet <void@manifault.com>,  Andrea Righi
 <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Shuah Khan
 <shuah@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt	 <justinstitt@google.com>,
 Alan Maguire <alan.maguire@oracle.com>, Donglin Peng	
 <dolinux.peng@gmail.com>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-kbuild@vger.kernel.org
Date: Fri, 12 Dec 2025 16:10:00 +0900
In-Reply-To: <20251205223046.4155870-2-ihor.solodrai@linux.dev>
References: <20251205223046.4155870-1-ihor.solodrai@linux.dev>
		 <20251205223046.4155870-2-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-12-05 at 14:30 -0800, Ihor Solodrai wrote:
> Rename the member of `struct object` holding the path to BTF data if
> provided via --btf arg. `btf_path` is less ambiguous.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>


