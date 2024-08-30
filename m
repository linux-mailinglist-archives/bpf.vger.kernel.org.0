Return-Path: <bpf+bounces-38507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9C29654D5
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 03:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17721C21DA9
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 01:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC4844C77;
	Fri, 30 Aug 2024 01:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCYQ3qV7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883ED26ADD
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 01:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724982387; cv=none; b=SYTr67yfUnrQTsZ7+6CfLNpszAXNhBVfDy++XZb28FqtOkRtC612exRwL7kn5Z4+CKZHv9FJdxn60AzendDj4mY7li0ajk8YCv7X/eEE9iLmCEiFRMOoo76u95j9YR3G5nnIDGQxNe60wHmoGKs4f/Kewoc8EDHol/F1AVk01U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724982387; c=relaxed/simple;
	bh=YrYUGFlno2ik0ozNNGqLBxXHiufNcHonP7KgfRF7CkM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZFcGdrQFd3uy+Ch1iXYvE9tVi6rHQDv8EPmtcAxkk+wKsKkjw7ggaCFInu5vvYSh5QtC/Te6S9pqsS70DUx911WncsJeoNOmvyMDLBCtcoqyhKgzXhZut03yZmS7co5GujQnzBQHEWVSe4c3O0UolcytUBvOip6eJuzhQoFoo2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCYQ3qV7; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71456acebe8so1041399b3a.3
        for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 18:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724982386; x=1725587186; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YrYUGFlno2ik0ozNNGqLBxXHiufNcHonP7KgfRF7CkM=;
        b=ZCYQ3qV7Epd5ZYvxXH+MX/reFOsaBh6BrKzecDhszt4S+d9YtrOYlf+k2Um0QsC9wl
         kbsR96pzH8TtyVdMtqfZep068A7VkXML6kAjzEuA9HCSO49u+JJuvRewWalrpQFFd+EO
         2Mqz4qL2AWIqMVxPUnIKK6iy+zBn04/J0UQxPrDCkH5gU7d0DAenzQNiJjpO34aLy8B4
         3kxY1xViCABGFKL9tUMJwgznfi4Nbun7d+Zt222ZuicCB1/9Z4P3gbrRlE7pS4yws7gT
         olBn+6AMsgQVe5UIx1IIjzn3C94HI+5gXT52RyElbKuEyAg6+RaF63XormOon+43rz2S
         6Iig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724982386; x=1725587186;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YrYUGFlno2ik0ozNNGqLBxXHiufNcHonP7KgfRF7CkM=;
        b=XirfT9M3sRX9GEN/shOwzdrd46R/jLijCbaJ5DwB6yo0Gc5CuPUcXmNyIWo/1j/uTC
         z/dxhHpNhZVukZ78C5RYVXfqjVI9QG2tqktLJ2vYjHcOFOrLEdms5J4ONC/Y/gaqPIfI
         OR/LdEdssukFrS/CLyqkFHf/RGCrCWn6GPBdgxJjyioz8/nGU/VuAD3yGzz4gyiHjuQ7
         ADTRvLWn35kR01KEpMaoMlWfgzFUngpJPX4Q6eBe4C3kPdtArcA57njhLRfkKh3mxPh6
         1cs0L2r/GBXxOiEDUbl1K05DtcOwum7JuUeGV/mYTzgAhaywLaaaiEN4aVtK8npR8AOd
         T5gg==
X-Forwarded-Encrypted: i=1; AJvYcCVcXjn3KlfLTtRzttDlox/NO8B71miH/Dorqot9PBzizv8lVajUcjL/Zojtp1begLoxBS8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqmt6bpocJWE6E1oV5YcGIHdCivPjv1Zn4nT7KMStQqp6nZv97
	uJmKeIgWBvTWlVtUsqEatumgJb4E2OiqnK6JLsajlFZahgI5xI8Y
X-Google-Smtp-Source: AGHT+IGhMEEb0jD3d08M03ljphFgcMWwzH9aLupqkaTjFCKS1btGU7P+OHu/HMY0TkBa5JH85/J+tA==
X-Received: by 2002:a05:6a21:3981:b0:1c4:7a11:9ef1 with SMTP id adf61e73a8af0-1cce100ebccmr4888599637.15.1724982385640;
        Thu, 29 Aug 2024 18:46:25 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205155539f0sm17305435ad.255.2024.08.29.18.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 18:46:25 -0700 (PDT)
Message-ID: <146c0de8feeb8788a716f5ceb3a41a309ede2917.camel@gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix a crash when btf_parse_base() returns an
 error pointer
From: Eduard Zingerman <eddyz87@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@meta.com, Alan Maguire <alan.maguire@oracle.com>
Date: Thu, 29 Aug 2024 18:46:20 -0700
In-Reply-To: <20240830012214.1646005-1-martin.lau@linux.dev>
References: <20240830012214.1646005-1-martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-29 at 18:22 -0700, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>=20
> The pointer returned by btf_parse_base could be an error pointer.
> IS_ERR() check is needed before calling btf_free(base_btf).
>=20
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Fixes: 8646db238997 ("libbpf,bpf: Share BTF relocate-related code with ke=
rnel")
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


