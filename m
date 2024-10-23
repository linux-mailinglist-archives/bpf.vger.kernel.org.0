Return-Path: <bpf+bounces-42878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CB19AC250
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 10:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3869F281827
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 08:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73BB165F0C;
	Wed, 23 Oct 2024 08:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moF8uOkq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DCE15C15A;
	Wed, 23 Oct 2024 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729673656; cv=none; b=ckKPVFXzAkgbzEZo0VP+LMT6wdJHNJYi1JQ1tkXM7ieYdmRPJ1NT+Vqfyq31qUQXe4f937X2B/GG8KyjWI5erE+endU+WiAvfN6CTEZnLSzG5ZvogWhuvC0cP+m5QLkch++2UxPyNQ2pb0JCKzxICadV5Qg5S28rJVHw2Q5ahcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729673656; c=relaxed/simple;
	bh=q0eV8PeZCT18pahZgRhtX8A1YE92PGG7fi2vMBGGsSU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=poc0gx2UeS9hywUfntMUHpIO3L/p44Ka9voF9n1Y0lmFqE5kBvDG3HpWNYvdEIXjPEqVrT0UwXjqVZJ29O38UfkhWni/YCXezNpNmAk6Ch04ce4Anfrjr4v7nGt4JWYfeix3pPwtItl/TAyI56KyuEPiuDmGiRxM8aBktn6HHyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moF8uOkq; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9a156513a1so893373966b.0;
        Wed, 23 Oct 2024 01:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729673653; x=1730278453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ON6OZuNx4fqchfNgrWP933rjQDfAkzEfshyv8H/ww1I=;
        b=moF8uOkqjz084fw/zTMLZxO1/odUq4rr7KmTtPjlnvAoowcwphTKR1SNxJp+fgpw5Y
         SH8E2A8/YR4dHm09y7k+G1iMrAvzJYpxLtujMVa+JHeH8Df6bL99wXPbZFwv/X67ZYqz
         IWAZD2cDagsvIvUSj15DqIwajxxo3Aq7U9yazsFPB2WTrQD+uAx3uQQUtXPxsS73Wcfn
         /BYhnm2IrLIQH9g46Nl4vDRn6to9ODvhG6Q0061X7zQBXK2VkPkflXDBgZxHbaV+ddi9
         ZcrdykXwuVWuhmzxvRaxzTvYPsQnO9/eJujT9FvsrLCiUWNMkt/bBp2B6mrB52j9bKPb
         +H/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729673653; x=1730278453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ON6OZuNx4fqchfNgrWP933rjQDfAkzEfshyv8H/ww1I=;
        b=nIeyl4i+VSQR9UrTUespbNQ5dQPkNc8jXFyCWw3aZLIO/JqAnmfPCw3EAr7FHf4Jnb
         tZ7UsNPUgfcssNGg4KeJZRsQH9fRkysWXQU/drS+IfeWxu6MlKRWdd6QSFT3ysr+26WS
         T8pxEmx9N9FbFzQDTV78d1BBlk95wNc/dDb+zzSSd40Ind1Mvp0OClaYRMRxrnEUrxFk
         WTHn0HGQCjKm/Wxb4RD7TwNvuXKlNZW8mcFs2ViPus3e6//NUN9JNTRiSQRb9Oh8hrZv
         /MdbnppLRgesqrjmP8cFtYsQmepWzYS/qNNU3LsixqRog612V5JlpuqW4vbXKL5Ukh/r
         gqFg==
X-Forwarded-Encrypted: i=1; AJvYcCXRBSoz/du1l7sLV1SVWZZEuU9R7noVQt3zpnfdC0oxrh3iEMRXdWTUFc8f8wK/o1IHoc7U5Wr15SBrSa8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+7ahE8zXyfYMXP5SUlcyzR10WDYZy00PbKvM3DPtpMZOPSyhN
	hZmAE15MKiQB7F9h6NZzRtWWFlwsvmx+E3vmygW1hD442Vm5GYov
X-Google-Smtp-Source: AGHT+IEAqhqRya4+mPI2plqO4+HLOhmrmro8SCwkX5agExI4k8rTmopqtTJOZeXe70AAkM0Uj5QAjg==
X-Received: by 2002:a17:907:7b97:b0:a9a:26a1:1963 with SMTP id a640c23a62f3a-a9abf8491aemr178324166b.7.1729673652994;
        Wed, 23 Oct 2024 01:54:12 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91370e6asm444534766b.126.2024.10.23.01.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 01:54:12 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 23 Oct 2024 10:54:10 +0200
To: Eder Zulian <ezulian@redhat.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, acme@redhat.com, vmalik@redhat.com,
	williams@redhat.com
Subject: Re: [PATCH v2 0/3] Fix -Wmaybe-uninitialized warnings/errors
Message-ID: <Zxi5stO4mWWdKqF9@krava>
References: <20241022172329.3871958-1-ezulian@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022172329.3871958-1-ezulian@redhat.com>

On Tue, Oct 22, 2024 at 07:23:26PM +0200, Eder Zulian wrote:

SNIP

> The above warnings and/or errors are fixed. However, they are observed with
> current default compilation options.
> 
> Updates since v1:
> 
> - Incorporate feedback from reviewers. Add a comment about an alternative
>   patch for parse-options.c sent before (based on comments from Sam James.)
>   Split in multiple patches creating this series and a typo was fixed
>   "Initiazlide" -> "Initialize" (suggested by Viktor Malik). State more
>   clearly that the -Wmaybe-uninitialized issues only happen when compiling
>   with non-default compilation options (based on comments from Yonghong
>   Song.)
> 
> Thanks,
> 
> Eder Zulian (3):
>   resolve_btfids: Fix compiler warnings
>   libbpf: Prevent compiler warnings/errors
>   libsubcmd: Silence compiler warning

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
>  tools/bpf/resolve_btfids/main.c  | 4 ++--
>  tools/lib/bpf/btf_dump.c         | 4 ++--
>  tools/lib/subcmd/parse-options.c | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> -- 
> 2.46.2
> 

