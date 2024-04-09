Return-Path: <bpf+bounces-26313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 265BD89E161
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 19:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06E11F21883
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 17:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A644155A22;
	Tue,  9 Apr 2024 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bl60pRRN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8560815359E;
	Tue,  9 Apr 2024 17:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712683030; cv=none; b=dzQd5HFNg6ojK7JsWa9dANK+gRMbEgjhaDQf6/O8doMDk9eB+0BVJ8Tj5RpHTgvVyIIcaZbyPoRrIYSvBrPKzIdCbdUXwAXkJtLr2AiK3+NhxXtHN5Xc5o7OJO200RsHdhvPvRqa5BljaLoNfiBmkc7Uuu+x+E64MTI3B5XCiGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712683030; c=relaxed/simple;
	bh=yPLx0WlPcqbYP7PztskjJ6gP7k8HuYhFWSUP1+GpN6U=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=onJZ5nMf1XI6r2oNpzsx+7flemqukb6jBg//iVZQyZ4RvFeYJBemzyQr4JLgKcdxTShNi2+vUpVe+rGf9Iebfg3jQXFkjscREJyaZoZxawsarHQt0X7C8KWrMsrKdhl8TZEBDtXCFYN6mjcowSegRvud+qU1O2YDEIDTG9JvqAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bl60pRRN; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d4a8bddc21so82894731fa.0;
        Tue, 09 Apr 2024 10:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712683027; x=1713287827; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GcyQviJT/ZKll5Y+ZKktvq3eLlaWHgRX/7+F6P9kW0A=;
        b=Bl60pRRNiLWIUAVIEFZv4IS8swHBa9qWkqf1b8Y6m680/9HPbT/Dvp874evkBUgynH
         1sdpIzl7kxd07pKt0HNpebGrg5n/ONOWR8sh97RbhtJWtQJqcQTO2/WlH+ciEeRg2uuh
         oXVO3fsAu6aHbA51ORZOR3Sqw6Zh5vIRbe01+QAj7KdnT0Wu8bmVv5eGmuXx9M1sIQoB
         T/ssuBjebg0gxxqMfM+fG17W5gveKdMT7yOtrJ0GIXzx7DXI5TjQpLJe04zR5CcSRVc/
         CebfXKR1xasx5kN7QV63Gs6gvVQEbYP/Sa415yLWiRvqLj5EWmWiCJFFVVAJZzcZEfEn
         z2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712683027; x=1713287827;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GcyQviJT/ZKll5Y+ZKktvq3eLlaWHgRX/7+F6P9kW0A=;
        b=QmaWShPN0wNpXmF6mp9Sh2TRTR5cbpBmMnzCG3x6t7hvW8tivsxm3ri2Qmi7NTDbEE
         NiAqOHn7A4ozLfFjAWyJMMx93Mn0eGxlI6Q2Jh01xP4cdeOwd0ib+xuS2DvYm6yPLkmA
         APoLlzhmLgba85WDzTQMPidbiKiTuTKwDiGWDpe2WA6rh8Tcu44Z/rwg9gvFK6FcLV1u
         eI2Ne3I0O9nqHrwO1OoOBmL/h+ZtPhkSfyHVjuV76Q/IO33oPFwfwASAAmrwUzc3HiX9
         URahBAsYbCwvF57c9ccGTtb/fZL5Bes+0QF7ryO7mNTZ4wokZrhLcwZ3BOFyXiv8ySID
         1aKQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9UTZ2mpKlEU+r62+tRudfnHnYMGquj7TPciIRaaKKZp1eW2+yiqVm0X6ymdcJ54BiVg1xUR0D4C6BtQzeJfUZbJvF6D74vfGJRb7TjLbZqi2UwCWCfLaMHNVrc2WgPTBo
X-Gm-Message-State: AOJu0Yxk2DseqzcGMKwD1u/T08hHvKPY9y4TNRXIQ5lQ31lHPzNu02e7
	pCqubYTGfejllx/0qgeG1/7D76v+kvEokFEc5K1OwPUXg5LoVmKbjXmL8FKNILU=
X-Google-Smtp-Source: AGHT+IEcHUTdr1f9hHpKHYtrK7jxVjg6oestPlAx2GF5WZap0QGjMk3qaqPIXKwPVck52B/KPGh8og==
X-Received: by 2002:a05:651c:1a28:b0:2d8:34ad:7f4e with SMTP id by40-20020a05651c1a2800b002d834ad7f4emr434658ljb.4.1712683026485;
        Tue, 09 Apr 2024 10:17:06 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id p14-20020a05600c358e00b0041674bf7d4csm7945486wmq.48.2024.04.09.10.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 10:17:06 -0700 (PDT)
Subject: Re: [PATCH v2 bpf-next] bpf: Fix latent unsoundness in and/or/xor
 value tracking
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
 Edward Cree <ecree@amd.com>
Cc: ast@kernel.org, harishankar.vishwanathan@rutgers.edu, paul@isovalent.com,
 Matan Shachnai <m.shachnai@rutgers.edu>,
 Srinivas Narayana <srinivas.narayana@rutgers.edu>,
 Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240402212039.51815-1-harishankar.vishwanathan@gmail.com>
 <77f5c5ed-881e-c9a8-cfdb-200c322fb55d@amd.com>
 <CAM=Ch04xd5u75UFeQwVrzP7=A5KPAw3x7_drqQHK3C-43T4T2w@mail.gmail.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <9d149d61-239c-67ac-0647-b59a12264299@gmail.com>
Date: Tue, 9 Apr 2024 18:17:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAM=Ch04xd5u75UFeQwVrzP7=A5KPAw3x7_drqQHK3C-43T4T2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 04/04/2024 03:40, Harishankar Vishwanathan wrote:
> [...]
> Given the above, please advise if we should backport this patch to older
> kernels (and whether I should use the fixes tag).

I don't feel too strongly about it, and if you or Shung-Hsi still
 think, on reflection, that backporting is desirable, then go ahead
 and keep the Fixes: tag.
But maybe tweak the description so someone doesn't see "latent
 unsoundness" and think they need to CVE and rush this patch out as
 a security thing; it's more like hardening.  *shrug*

>> Commit message could also make clearer that the new code considers whether
>>  the *output* ubounds cross sign, rather than looking at the input bounds
>>  as the previous code did.  At first I was confused as to why XOR didn't
>>  need special handling (since -ve xor -ve is +ve).
> 
> Sounds good regarding making it clearer within the context of what the
> existing code does. However, I wanted to clarify that XOR does indeed use
> the same handling as all the other operations. Could you elaborate on what
> you mean?

Just that if you XOR two negative numbers you get a positive number,
 which isn't true for AND or OR; and my confused little brain thought
 that fact was relevant, which it isn't.

-e

