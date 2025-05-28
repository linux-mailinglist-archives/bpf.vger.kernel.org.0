Return-Path: <bpf+bounces-59181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFDAAC6E30
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 18:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE0513AA5F5
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 16:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9738F28D8CF;
	Wed, 28 May 2025 16:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SP+PPD/J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA80A286D60;
	Wed, 28 May 2025 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748450515; cv=none; b=VvUZMKNyiRHR6fhyktrcr4YXwy9ynF9yBJzAfLzGxQPeoS6pfhdPKp76n1zKnf0fSREiV7bwz0V8s3TlbJAMOYH8E0QbRcnZwVPlEc2VW9ShBmzvyCoT727lbefPLm454X+XXafolV8yNixZOS9tcvSCR/44CCvCWnrjZjMz1v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748450515; c=relaxed/simple;
	bh=fPIux9WOEBG9ux7bKkGibeqwkEVhOEjLTDfZj4WnLVM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oX1j7eZInja+lMb2blfqjxHbrfwoufHHaC2VGoSWJq74N8WkjPGTaNaKeza4SqzxpE3yBsGO+ZTmAbdltN+zy2z7zNnGrLvoiKCHnQIJUqtiN9gHUmnt4LOO1FLZDWy+OWXfYTLlB87Szb5Tjkov3tFTwN2Ynu/lMibEJFN9yeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SP+PPD/J; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-742c5eb7d1cso5271767b3a.3;
        Wed, 28 May 2025 09:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748450513; x=1749055313; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fPIux9WOEBG9ux7bKkGibeqwkEVhOEjLTDfZj4WnLVM=;
        b=SP+PPD/JXQQKRlA108rQNAd433ks1lkZZ0RTUJAmDBfKd4YGoOyVo3P+E31bSHjWAj
         tksXFbjE5XkWjgiSzwDubHWHtvncGvLdgA19tLx+z8OPvZr//fhHY085/DWEBi8qDDy6
         XfHotdvu3Zb/pf8RwHZO3YlBOnZk7xvQyN4EazJegNWj2kLkM/PZNJEO5UuvnXT318jf
         vDXzx+SO0IgQqn/hlRwdqBdN5RtmBQ4OLU327abombReyNhw5nxEPZ9G9Na2Ar558oST
         l0NjsqH6t1uxtBLbYiVbGG5rqTnjJUo5ZUe+14yDcm0AlkL1l1T2vuZmJ2UHPmSDKN9D
         rWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748450513; x=1749055313;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPIux9WOEBG9ux7bKkGibeqwkEVhOEjLTDfZj4WnLVM=;
        b=VKxgfTf9++VgfBNPmMc/rzEvf1/WXJpVpA2ity0HSspxuqaZqo1uSCoIOH4GbZ6REV
         02eh/C+a9IXM0QzI9w+C9y7Fpb9vT+CNtsSRu4vdAXqlsrnlCgvoVJ/lEhXaMMiaRFce
         WCBEne3x3N15N+J48R/mG8jXY2PmCsFxbhznVMZer/CxB3rsCwIO2SJ8R2Fn2LcuVtac
         SwDNOhbSaBhugRM6u8GdyZQkvrXFFo6xXR7YllGracDfkae1GtQQM1m3BLmJW97McwCY
         1I9hiVXuGtUSu9uA6Duj7f+aRE82PUZFzIZkKRZIS3eATesuzTC+dEGCDgF9ppXd7syb
         MQgA==
X-Forwarded-Encrypted: i=1; AJvYcCVefTVBRxygMUiyN4YsRi9z4bC5eAhdjWXmrCOZmeA7ov3gF7QKkLrGiav/WVC3NFCqLibIet+uGcVJrDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM9yFuuuadbfktLfMM3Y/jhjDBO4P5lLhRoDt9Z83ScJyHZYdU
	xB9O+4Khzxsf1U/8H4bjBdCAPdX4giLDZNUEW+G7/BnSLYR45JDGz8Ap
X-Gm-Gg: ASbGncuUDJ7pFfpjIzxDIbWY7frfgCgrZ0HojzvoIKvffFGZ3AqfF0uKmIrSTNFXN3g
	48J7H36jx1/6/ciGaAF/WSJogF8oYQq/MBge+4mUPlUuzbmvmLzCKvX6Cp/z2cCfPdW7U7EnpLh
	oHT0nG5G0zs2LYAG2PZlDpCZq07sXvVpLMmLgPf43UBCDGhzm8GmoSKj/xTjXrfzKz7bgJsSkhW
	AVjtrhycvP8NQA+GuamK5+UMoVCFgVXrR+NQzAASihPghzTsetpo7TJdk3yppECDvGimenmwS0P
	3yz9yD7iwOtwc4hEZbhAfoYiBiTDjSnDg/em+Gfm+NzNMJKzT4/KvsE=
X-Google-Smtp-Source: AGHT+IGoTkvFIh6FMeowmAAsOJeKRgyok9Jr0UFJuFkqrmh91H4Zh8o83Vxeb6z0lomQVOwBZEfktQ==
X-Received: by 2002:a05:6a00:2d16:b0:747:aa5e:7252 with SMTP id d2e1a72fcca58-747aa5e75b2mr1859541b3a.23.1748450512943;
        Wed, 28 May 2025 09:41:52 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::4:d651])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-746e340f854sm1437373b3a.115.2025.05.28.09.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 09:41:52 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jerome Marchand <jmarchan@redhat.com>
Cc: bpf@vger.kernel.org,  Martin KaFai Lau <martin.lau@linux.dev>,  Alexei
 Starovoitov <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Andrii Nakryiko <andrii@kernel.org>,  linux-kernel@vger.kernel.org,
  Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH] bpf: Specify access type of bpf_sysctl_get_name args
In-Reply-To: <2b5f6cd0-2b5f-4687-ad43-73a7be8fbfd0@redhat.com> (Jerome
	Marchand's message of "Wed, 28 May 2025 14:47:56 +0200")
References: <20250527165412.533335-1-jmarchan@redhat.com>
	<m2ecw97mxn.fsf@gmail.com>
	<2b5f6cd0-2b5f-4687-ad43-73a7be8fbfd0@redhat.com>
Date: Wed, 28 May 2025 09:41:50 -0700
Message-ID: <m24ix43cxd.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jerome Marchand <jmarchan@redhat.com> writes:

[...]

>> Looks like we don't run bpf_sysctl_get_name tests on the CI.
>> CI executes the following binaries:
>> - test_progs{,-no_alu32,-cpuv4}
>> - test_verifier
>> - test_maps
>> test_progs is what is actively developed.
>> I agree with the reasoning behind this patch, however, could you
>> please
>> add a selftest demonstrating unsafe behaviour?
>
> Do you mean to write a selftest that demonstrate the current unsafe
> behavior of the bpf_sysctl_get_name helper? I could write something
> similar as the failing test_sysctl cases.

Yes, something like that, taking an unsafe action based on content of
the buffer after the helper call.

> I'm thinking that a more general test that would check that helpers
> don't access memory in a different way than advertised in their
> prototype would be more useful. But that's quite a different endeavor.

That would be interesting, I think.
Depends on how much time you need to write such a test.

[...]

