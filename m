Return-Path: <bpf+bounces-34218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6027A92B459
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 11:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10A7F284504
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 09:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7493715623B;
	Tue,  9 Jul 2024 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="fLhRrTag"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5A4155753
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 09:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720518524; cv=none; b=aX4aSK196gss05rMVtmcyZ4SwdFmNvOU5xrc1u7ZEOJX+aE4CE8UsMhzmxhX5PGfZ9cfRq4rwSRALfp0IyFC6C3JTJBUK9CN4vFhUBiYWXXtTjNm7gq/bgSTDfnzqTEF5eF1KSKOMfDYQ2ldm0lio1o0sRtikp83zN+K6Rm7xp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720518524; c=relaxed/simple;
	bh=Y/XBv0dj0yaw8j4TaNYEP9A7Ddp+e7sTRck2NCfQRJg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sTp5uNPPbI291p3/kc/dRuWE+9mNIaadaiEFbLNiFELOEKJfthSNM8Qt68WOlrbu6Gypv3Ot5mRU+1iiaXJEpJaehjpNl/jPdAee/o+y8FV4IIe8Tp7mxsW++QQ+Agp44FkvEkwBd4fv2Q5Mcnz3sxoBNpgMykgdrwUa5B74WFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=fLhRrTag; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a77d9217e6fso400268866b.2
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 02:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1720518521; x=1721123321; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/XBv0dj0yaw8j4TaNYEP9A7Ddp+e7sTRck2NCfQRJg=;
        b=fLhRrTag83tm3yCfuYEGZD7lnaNp2hbIRV2nWwLDSHSsAWjI+9IhXnVYkaIwv+529a
         ryA5Hg5RS8HafWCv9r/Zg3AbN1Cnk0jIHuKulGx4RTyaQT+pJxmFAoxoWPANEo14VTy7
         kzBFysFytMfRlIO8culCakWotSA28sg+psJJSAIlANI35X1XHZJTT3lwNGLOcjHmbELG
         py4mwZrzn14tYxmGohGR25boXpeQMZqtC62gUN1OFvNSAE4W20F0B2sV6z8wO6CDC/gE
         bSEcxcNIAL+ySMZnelKjVmcW3w3zNv8WiKqcHi2bwRyAWc95eP+A0uJkoykioUd5kFuO
         9w4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720518521; x=1721123321;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/XBv0dj0yaw8j4TaNYEP9A7Ddp+e7sTRck2NCfQRJg=;
        b=dGZB6LpNmGJwJx0l3cKW8hl+z9daNp3TO48pIceoxrBuGvM+wJBjWTMk7cccQwQpf4
         qeyva3NIlAHtZI+w0hr7T1LjKnMFzSgg/OYRh5z/sCU3ckCMvTSabKOscjjFH2GrvGsV
         lG4bd3W4P5NfVSaotZydtqhis/MDnqyfflD/3A5uO8B68K53DKidcdNcP0xYyDd7hbZe
         PE7xOkmEzYFz0WrBaO/1Gvi0QKGeCYPhpIXgHNaGzbk2UXNKVFtTRr/z/iOr8uj9tDdt
         SrmM9uae8BM8SYzk5+zxXXi5OirCEGEhOF/TJjUoIXXgMwkmsgg8ZMYra/3pyIWfknTv
         DwFg==
X-Forwarded-Encrypted: i=1; AJvYcCXFcklfkZL6N9WcPaM0yYoVJEIcKihfQR2L1XY0NJZS+dvB89N68Kt8Kbqm3Yy8h+/mUGBCq1VSRA+kKJ7+FAWSdrIv
X-Gm-Message-State: AOJu0YwM+hI77Od5U61Y0M1XgpoIk5ShxAHmBr1U5IB9Tul15HhS2dys
	X0gTx+ADLElFdwxqmhDOBLRwVPZKEmfFnnAtiWgutqGYjF6EDufLbmsCeMhLbHs=
X-Google-Smtp-Source: AGHT+IFa7TjPN5lLimFPbNL0GxxV5HjS/WosDVCQgAAFjft33oGxiL6FlKbOeWJKQbKNjUuLnSqBaA==
X-Received: by 2002:a17:906:f756:b0:a77:cbe5:413f with SMTP id a640c23a62f3a-a780b68a3fbmr138258366b.4.1720518520664;
        Tue, 09 Jul 2024 02:48:40 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a72ff52sm63874766b.97.2024.07.09.02.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 02:48:40 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  john.fastabend@gmail.com,  kuniyu@amazon.com,  Rao.Shoaib@oracle.com,
  cong.wang@bytedance.com
Subject: Re: [PATCH bpf v3 2/4] selftest/bpf: Support SOCK_STREAM in
 unix_inet_redir_to_connected()
In-Reply-To: <20240707222842.4119416-3-mhal@rbox.co> (Michal Luczaj's message
	of "Sun, 7 Jul 2024 23:28:23 +0200")
References: <20240707222842.4119416-1-mhal@rbox.co>
	<20240707222842.4119416-3-mhal@rbox.co>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Tue, 09 Jul 2024 11:48:38 +0200
Message-ID: <87zfqqnbex.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Jul 07, 2024 at 11:28 PM +02, Michal Luczaj wrote:
> Function ignores the AF_INET socket type argument, SOCK_DGRAM is hardcoded.
> Fix to respect the argument provided.
>
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

Thanks for the fixup.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

