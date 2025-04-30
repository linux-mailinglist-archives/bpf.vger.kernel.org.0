Return-Path: <bpf+bounces-57098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A61AA577D
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 23:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA9767BC65B
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 21:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6F12BD93C;
	Wed, 30 Apr 2025 21:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5mboyPq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18AC21D3DD
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 21:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048625; cv=none; b=AJLVE/zebT6lvyADMcbbCOnN2IKbt9zQhgMaUKy8fli6SLrWkquYqhvfNeKeJsT/+wkMb1op0c5oWY8CMkonSg5jWY9GOVDB2dQSnkl5m0ZGOu/9LbaGT2QGJ2SUOilG2ZTgVV4f/4XpfXJ1r40ffVzyTFXRmdd5rBP4SiZhSKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048625; c=relaxed/simple;
	bh=RkwYVYcMO+yXrp5jMBy6VteDJKMOuKexvKfsN8SFLyo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T6tZWh4lVBXyYx9a5pJ0BV8ZQ6sn7LNsq/PgB1AQ3LyMgddyczFKwNAQnwnukDn5Ksh9faKwqKS0/RQN9gkqcc9CjuaY9X4Q17v5yzE/xs58AbOX1LN6h1Vilg9JtfNL8pNX2Rmpn93JliG9/uhY/yf3JPjFhar1JOAfbTgkx2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5mboyPq; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2255003f4c6so3977255ad.0
        for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 14:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746048623; x=1746653423; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5Qw/d8aWIJQfpYcL/gJDvq1nrLVDeffl7hz0H+ZEFU=;
        b=Z5mboyPq+R3/Gz2fgVaBiQrMByluHwgUoLsUUNjHjxSkb619qt1TwoA7ZHfAlfdk1X
         V8YDhR/AsKUeyI4WU21P84eiwDqGXgyQQKdw+rb3XZDK3D49P3bI8BgJ8IAEzFVTk3i5
         JGqg8ePqTSIiKyQxmT8Cj93q3zpxOxEiJTb/wM+khk7xviecOzJDcUlwO1/Nu+QW18sC
         KywCJHqQoofpPQc0FdUI0WM+3IHuzFv7osEaFzwIBkgWLaDRryekx9zXzkuZDV/N69eK
         wEp1Wuq9q2cd17hmA0kX1mgih+ouovOxQTBCCsaZSTsFQZ7GHHsy4PiEQ8KDwcZHq3Gc
         sJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746048623; x=1746653423;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5Qw/d8aWIJQfpYcL/gJDvq1nrLVDeffl7hz0H+ZEFU=;
        b=JEn2YSBHdeZt+1iBhoO3tWzqsQuCv2VoVYVV9Pc5lVm5/thYSpL35JBlhsoIYzaHt6
         3dFXXH5XI9lIXwons+1BiDiy/nzKW/KhtS3Pc1nxG43njYkdpLrBjApJL+osMhqr9JuN
         B7kfeR5MJNIXkVGr7CsN9FQt5DOFOKSRFgZPPzyzG1OQdmwYJnaEaqd8A4hrTF2MHM7r
         M5THtVnx+qVwVGMcyxnlxx9n+fzOLRVr/Tc84zGSdHjoIqBsM2Vsu2+tJl1I4b1LP6c9
         +UUeShpBk/cQmvIVTj7ezNf4yCVKhE1d3Wphr3ip5FUXB4QIuoCQyKvujhTtssi0OKjf
         C3Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUQPepESPftjUt7o0STM5kL9CLqlTnDWOWzD4ztbda3Y1rXsUKMrt3pGPLB9KI9P6uE44M=@vger.kernel.org
X-Gm-Message-State: AOJu0YysKjc+5WyzPXKtsWI2XgM7cGw8psVbbX7hvtgjGKa3+uFhohTG
	bOEk0jvGEAM02jGVYP4HpaRk+HohwlOZrk5Z9kOVqFXw4qH8nDIlUZBZ2NVr
X-Gm-Gg: ASbGncv90JtzS1xfvaXYQ/GEMiSz8Cpum9epYlcbvg7O7VGyx109v8/pIw3lkcYZA4G
	x5Eh+SRD+19NYJjaXOwmKEy9UxbXNzqDanUXqXCfqF8IGerNvkP/tqAJMr25S48y/hHKEsAkOtN
	GDaMwIv/saARdOIcPToGGyL5SrqJsZQmQj9gsFInKVdL9tyP/M0TScmgyTJ3yiHgTWEPWxDOLcm
	bnV3Buuh7LSVfNX+6sqMGK3vJEQamjdtajWzJOs3ilBkxRTLvE+r9YWxoi9lusH3v62dgzz1Q7H
	2EPjjaik9QdmW1ejjkDdQds3y+BbhosvbwZnhPO1Knak
X-Google-Smtp-Source: AGHT+IHPY3r7M5Dd9V2r2P5GuYlApxPSGHu2CRK3wrd63CckAdyW1Fp5AWEPp5glnEvnKU6zZkzycg==
X-Received: by 2002:a17:902:dacb:b0:224:910:23f6 with SMTP id d9443c01a7336-22e086484e1mr397175ad.45.1746048622771;
        Wed, 30 Apr 2025 14:30:22 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::6:5b9b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15f7ec0bb2sm11113040a12.18.2025.04.30.14.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 14:30:22 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org,  andrii@kernel.org,  daniel@iogearbox.net,
  martin.lau@linux.dev,  song@kernel.org,  yonghong.song@linux.dev,
  john.fastabend@gmail.com,  kpsingh@kernel.org,  sdf@fomichev.me,
  haoluo@google.com,  jolsa@kernel.org,  mykolal@fb.com,
  bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: add btf dedup test covering
 module BTF dedup
In-Reply-To: <20250430134249.2451066-1-alan.maguire@oracle.com> (Alan
	Maguire's message of "Wed, 30 Apr 2025 14:42:49 +0100")
References: <20250430134249.2451066-1-alan.maguire@oracle.com>
Date: Wed, 30 Apr 2025 14:30:19 -0700
Message-ID: <m2y0vhfic4.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alan Maguire <alan.maguire@oracle.com> writes:

> Recently issues were observed with module BTF deduplication failures
> [1].  Add a dedup selftest that ensures that core kernel types are
> referenced from split BTF as base BTF types.  To do this use bpf_testmod
> functions which utilize core kernel types, specifically
>
> ssize_t
> bpf_testmod_test_write(struct file *file, struct kobject *kobj,
>                        struct bin_attribute *bin_attr,
>                        char *buf, loff_t off, size_t len);
>
> __bpf_kfunc struct sock *bpf_kfunc_call_test3(struct sock *sk);
>
> __bpf_kfunc void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb);
>
> For each of these ensure that the types they reference -
> struct file, struct kobject, struct bin_attr etc - are in base BTF.
> Note that because bpf_testmod.ko is built with distilled base BTF
> the associated reference types - i.e. the PTR that points at a
> "struct file" - will be in split BTF.  As a result the test resolves
> typedef and pointer references and verifies the pointed-at or
> typedef'ed type is in base BTF.  Because we use BTF from
> /sys/kernel/btf/bpf_testmod relocation has occurred for the
> referenced types and they will be base - not distilled base - types.
>
> For large-scale dedup issues, we see such types appear in split BTF and
> as a result this test fails.  Hence it is proposed as a test which will
> fail when large-scale dedup issues have occurred.
>
> [1] https://lore.kernel.org/dwarves/CAADnVQL+-LiJGXwxD3jEUrOonO-fX0SZC8496dVzUXvfkB7gYQ@mail.gmail.com/
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---

The test passes for LLVM and fails for gcc 14, when using pahole w/o
fixes discussed in [1].

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

