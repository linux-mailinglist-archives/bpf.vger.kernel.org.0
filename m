Return-Path: <bpf+bounces-69808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B65C7BA2DFA
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 10:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1569E4A3877
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 08:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE6228C84F;
	Fri, 26 Sep 2025 08:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehZazaXU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D009028750A
	for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 08:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758873634; cv=none; b=nTUkCjPewuKfo9hQ0689AATOFl1DhyyYfGLVVA5trRg/QY53QsPs6apAvOM51u0fa0gXW7GLY1dkBAkHDEe1KL4pfVDBeBDrAGzMt18/RbIqsVEK0WUej2R8e7dLTg/MGfVBFiajnoGS5Ju468Gqf9mEcvR/5Cq4o53ydPruVkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758873634; c=relaxed/simple;
	bh=uKv781t5pHxGX9XHdWBHGON9HVERC0KRbzcEdEyQXDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChF08LTLmN0Vm4KoORc4HwDWXtLZpw/6eTxoYF+QGjgSbDbK8EIVBGfUD0nR31mT+TaYPdcTlIHCtz3CftsqUJpoSB9HEE+UQBOl8v6/X2lGwkWH0qnFN7d5Tih7p9PB1BprAWg4fmx1JxlcT4dr4fCux/6h/qSKTv0GORd/1O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehZazaXU; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e32139ef7so2695945e9.1
        for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 01:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758873631; x=1759478431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Iu0F1mpJxkFZwruVTis8t8NuagO8uvem8I8R547GH8=;
        b=ehZazaXUgdfxqtOEp3DjAUVmzKXPtmMOGUFz/v9Wx0T6rquzHgEFJ+YSqHmT8ExDSL
         Mu0b62zd0iKycRSDgh+ew3ZQ4tsqcYlG4IoMkyaUNVpSbyAyR7z2ZEQFZ4Us0vzpApnO
         jlo+Zq9azq6fKqpJ1WdiqtezFOawJVJaqU8d8nWPGihIwITmTG4OyMU2FPs84ynMre/J
         J/Ba0y6hHN9hsBnZHAzWUtcIPXrwrMpLz0L1lKcRUVcunNQ4GpOKv1j8FMbVn3VCGdrK
         sSiA144hNBEYukfeFKY0k+TggNXaurZENH/7unCeEwndVXUPPjf5ldiyl82GDLpMRIDF
         l6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758873631; x=1759478431;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Iu0F1mpJxkFZwruVTis8t8NuagO8uvem8I8R547GH8=;
        b=cbmbLn6maOvzjGK5ldWkG/wHYcLRcQfsdbjq3SJ+lI5VATJjv9YDX6M1o6HE+E8ZM6
         3WcQrgcUnFq8kCyZ8E9g1HoqOpcI0GKep9OEwxqXvE7nJgr7u7ug0AdK2U9MrXY6fU4p
         Fw/BzEPUyoIQ1E/FERp2Uq5lNiTkWlpbgYVksICStU4mKqg0wtqNV4k8+NIJ8vmFXC0O
         DucU4Yqr7UO1ebjRAfPqIceqCbfSR7x1BkntLJ6yHypV5O+pUvXDjE+OAIdnyA0vUEeC
         S6Fu6ekcqjE5IpAW9+2En5ULa4G8OL+hWKeipkbyS1ivcfLjNZq6k8J3+rc/qYLzAboJ
         R3oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjxzOxD2Fyy1BeUQkLbVr0aa5+lgEzYTJK7O5FXRj1NT4NWKmkpWX11i2ax9SVwJB6BsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl4X8d6oa2KBfgAWLyD3rqqUJaLsCoALaTBZmnouAm8oprsLZ3
	sD6MCh1Ba8YWAqtnFp9Gln9MEspLgjjp8n+b20Makf0WAw2IckHTVFb6
X-Gm-Gg: ASbGnctHycfBofW4zgJpTrfgsaD1sTtPsbuclkKsUG6AD61HiziJYXBYqqxea9KUYgQ
	g4pMJ9gvwkiTqZCou5yJUzuQgfVv3ZJYnbxnKBHfp6LqLKAt2NFm9GWYzWAsAq3oJx6M6fFln20
	bM0v17EOZlLKZLOGonRODoaeXkdAJNZfPHBvRkaB4HaEPdqzlE+uL1HKM0QD5HL/dmLBSUCGGXl
	iCeFtk8I6xJr5JGYQyw5CQHMSejrAJcKP0O5zA1qMoJefpO+3fNdBmbA7hsJg81vWewLIPsmQVM
	6QE5Sa2B5C/HZs2qTQCMHQAwQ1dMUko0+B5nq1wi1Js6MHLhrmE4AeWMqwLfGmrOeEjY51UzNVb
	SxmA5UY2Dfh23UMerkhgsFd7oUv5Ng/FvgZegJSlH
X-Google-Smtp-Source: AGHT+IHNpFF3srU1saXcXVO6zTDT4O5u6j9Vyxp4h+sviEeunSEZcOR+GiZEhHwsuD8UAwncJOuzoQ==
X-Received: by 2002:a05:6000:310d:b0:3fc:854:8b84 with SMTP id ffacd0b85a97d-40e455ca678mr3054531f8f.3.1758873630709;
        Fri, 26 Sep 2025 01:00:30 -0700 (PDT)
Received: from [172.16.20.151] ([41.229.125.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb9e1bd14sm6212872f8f.28.2025.09.26.01.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 01:00:30 -0700 (PDT)
Message-ID: <fcbdfd79-3996-47cb-9d91-ad049147d352@gmail.com>
Date: Fri, 26 Sep 2025 09:00:32 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] selftests/bpf: Prepare to add -Wsign-compare for
 bpf selftests
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, daniel@iogearbox.net
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org, linux@jordanrome.com,
 ameryhung@gmail.com, toke@redhat.com, houtao1@huawei.com,
 emil@etsalapatis.com, yatsenko@meta.com, isolodrai@meta.com,
 a.s.protopopov@gmail.com, dxu@dxuuu.xyz, memxor@gmail.com,
 vmalik@redhat.com, bigeasy@linutronix.de, tj@kernel.org,
 gregkh@linuxfoundation.org, paul@paul-moore.com,
 bboscaccy@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
 mrpre@163.com, jakub@cloudflare.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com
References: <20250925103559.14876-1-mehdi.benhadjkhelifa@gmail.com>
 <CAEf4Bzaf81OYLTzpN6E4ths_mN2gP29rMYBmbp7P2GqSMj8FbA@mail.gmail.com>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <CAEf4Bzaf81OYLTzpN6E4ths_mN2gP29rMYBmbp7P2GqSMj8FbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> I see little value in these transformations. Did we catch any real
> issue here? All this type casting and replacement is just churn.
> 
> I certainly don't want such churn in libbpf, and I'd leave BPF
> selftests as is as well. int vs u64 can have subtle and non-obvious
> implications for BPF code generation (for no-alu32 variants
> especially), and I think BPF CI already exposed some of those already.
> 
> I think we can live without -Wsign-compare just fine.
> 

I was convinced by [1] that this needed to be done not just for current 
version of the code but for future code being more robust initially.I 
have already done all the work and I can follow daniel's suggestion for 
the next version.Otherwise,This means then that the TODO comment to add 
that compiler warning in the makefile needs to be removed.

Also I wanted to ask since the CI bot had success with my patch.What 
does this [2] mean exactly.

Thank you for your time reviewing and helping.

Regards,
Mehdi

[1]:https://github.com/kernel-patches/bpf/commit/495d2d8133fd1407519170a5238f455abbd9ec9b
[2]:https://github.com/kernel-patches/bpf/actions/runs/18006172526



