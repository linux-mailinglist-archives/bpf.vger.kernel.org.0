Return-Path: <bpf+bounces-12707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C478C7CFF40
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 18:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87E8A280F7E
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 16:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975E3321B7;
	Thu, 19 Oct 2023 16:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1nx5AxP"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E25D314
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 16:15:59 +0000 (UTC)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E9312A
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 09:15:55 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5a81ab75f21so83905777b3.2
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 09:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697732155; x=1698336955; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WickOHGIbCGz6e502lihHUdkW5GL92qu3ABe1M6ia8c=;
        b=K1nx5AxP6X1c5ZmmhMJbVcyi0LJbP1/VKPy520l3qp47bYnhm01+f0dBlrwq4Thdgx
         lC4HUfpRB+DyogdYVIiAqMqC0QALjTN1UXaOdxSgu1P5zg8+0niD24S8zeNCruvG4d9v
         B8QoDpaiz+jr21ER/HFWx5VlPA7jMw7rSK8T7hIJCsktLatVQ2WQ7RZTRjtTJwxDHx6/
         kVzyvqdOb+kMKChO8l8AigkkjLpEP1VRYny8Z3DHfX0kC7UJy3aEaQfjJa2q8V7wUEj+
         HO+2DlBpB24nmt2ebzU0l7VAmr9e9JmST2G5roAQ4s7Mc9ZM/ex/N85SSNdzzhwE24M3
         eQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697732155; x=1698336955;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WickOHGIbCGz6e502lihHUdkW5GL92qu3ABe1M6ia8c=;
        b=hLxPpsj6q2MgRz+mBSxAFV4ss0Zt1WXBogEx+RjhCM/wTWdTBAtrJ7BtS7XkcvrDUf
         U0RhrOEPJfqTJIT25ovhboSj5qXWqBBnzVx196lTC6h/6hhQPINfX4C1AdHpL89l57W1
         HPwo0qcKvq0cc0W3QMLFQVrTiLr3P9V64rKd24ZGCEvuv68oeR1lM86ONBfIM8mUJBrd
         7vcYz6qPwx/xGmFwsMdjsntvHp6O/GxYibfpwqUgVm+dZl3YsOdn4CuU3npCo2NdcCan
         p/eKL38W2yZoyq5pz3S8RneihASz/iW08/eIco1kbqgCl4Sk3NJR4bvWUrdp8weSzfhh
         yr8w==
X-Gm-Message-State: AOJu0YyOj7B/sR2ILJYbBnxPKCdNhRh0xIBdeTkA9SInw0j6D0LqWfcK
	yr5dBWO2nPY4GqtyFtLQR0E=
X-Google-Smtp-Source: AGHT+IHtnve1S4HPBpqoJLrT/io5HwoKow7o/dFVybEmzHSo5sbwRPwAAqiobZkjzsQgnfRnw+8s9A==
X-Received: by 2002:a0d:eb4b:0:b0:592:ffc:c787 with SMTP id u72-20020a0deb4b000000b005920ffcc787mr2976187ywe.30.1697732155044;
        Thu, 19 Oct 2023 09:15:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:6ce6:ec83:39e7:c47c? ([2600:1700:6cf8:1240:6ce6:ec83:39e7:c47c])
        by smtp.gmail.com with ESMTPSA id l190-20020a8194c7000000b0058e37788bf7sm2533423ywg.72.2023.10.19.09.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 09:15:54 -0700 (PDT)
Message-ID: <4d5fb1e0-face-45ec-88fd-0da8db392efb@gmail.com>
Date: Thu, 19 Oct 2023 09:15:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 2/9] bpf: add struct_ops_tab to btf.
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
References: <20231017162306.176586-1-thinker.li@gmail.com>
 <20231017162306.176586-3-thinker.li@gmail.com>
 <44b8676b-fe0e-5f32-508e-7c223fd63213@linux.dev>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <44b8676b-fe0e-5f32-508e-7c223fd63213@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/18/23 19:28, Martin KaFai Lau wrote:
> On 10/17/23 9:22 AM, thinker.li@gmail.com wrote:
>> +const struct bpf_struct_ops **btf_get_struct_ops(struct btf *btf, u32 
>> *ret_cnt)
>> +{
>> +    if (!btf)
>> +        return NULL;
>> +    if (!btf->struct_ops_tab)
>> +        return NULL;
>> +
>> +    *ret_cnt = btf->struct_ops_tab->cnt;
>> +    return (const struct bpf_struct_ops **)btf->struct_ops_tab->ops;
> 
> Is it possible that the module is already gone here? If that is the 
> case, the st_ops pointer probably cannot be used?
The callers should call bpf_try_get_module() before calling this 
function.  I will check the code to ensure all callers do that in
the next version.

