Return-Path: <bpf+bounces-60322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5B0AD571C
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 15:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EEA6168AE9
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 13:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC9628A1F0;
	Wed, 11 Jun 2025 13:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvOfYCOy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECEC28F1
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 13:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749648780; cv=none; b=UNWell+aP2j8KRXaJabZgzDS9yXqic/isZrKOHxjblbxrb6YdATXp8MxPMkexypMsl1AFewY99LgntwamBklwtLv5+DnC2ghWjsqBbgusoIAB9ejkUEm5Y+CZcosoz53ROSt/xadf65DRkbyYKwizv2gXJWqavQEDYHzMd+hvo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749648780; c=relaxed/simple;
	bh=RlvSUTGYIbeSTiqY4MtMBVB+6+V4KPHCUeg0jXRyQ3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rl5RzWi4PUdeIpp7Lget9zkHZflIUw2uG2J2vPb60G0XXjj7raeRdsEdHPpgcMRSdXDem3VxBA8k6Bxx7f7UPHIyE0qph67adEnY38c0WNek/FJxt2dtNFOI4HRhe/8QRcTDM6zv+4bkJqPR847q2Tl9BFXnoMqI2L7ywTLi/TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvOfYCOy; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so56731955e9.0
        for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 06:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749648777; x=1750253577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vuL4NjPFVmODP/l92ar/+jHwJj49w2M9zdvr1k+d3Io=;
        b=KvOfYCOy8mpwznWYkhgrUNTYuMJNwQCZy+RXnoP3JqL0/VZoo3O2oSWtf4hjkBDldK
         IyI7XHmGxABLjJkSAwva64nhHC8tcSsEfxQBbVY9YYNFWPaF5xByyBGAoJ4XqXPh4oA9
         FSIFIlSDHt0bPnHZXemZwBarMaj/rgej5yHahbgJHUB2Z1M3WP17oWiDOi7MkQaqM5Rc
         pBj5ePPUK+0dnb6ZGsstHS9LtQOFyAPACn65fRxxprp3Qfe5836DtoICFlsyZEwyZdo4
         Wgc6lPTqfrNSzO9nduXedrUovxBsmg73XENhDtc3sGClJ3122l4JeuJK8+D2u6vpYmJN
         uGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749648777; x=1750253577;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vuL4NjPFVmODP/l92ar/+jHwJj49w2M9zdvr1k+d3Io=;
        b=wE00O2rkZtpxzamH12/yhAmzyPWSUgACa1O1eI2WtAx5Oh6XHqM9GYDd1KRoS2n1+4
         +Mr1oA6cc50Xntd0V9exDwSmYUrNxzEnPJ9i7D2luMOcFmX9/cr0irMN1Zr+zRgvPRWF
         JfFvRCsA0LTeROxIczFd4hasTfXAeol+k1mB2GWSjKUD9B8wDxqMEsltgrpJ2OLnYeo/
         iwO0KD3q9QnnoVz2hHmrvYHkmzW3MyENuxhJkTWfp7R7AkxL2OMCXB7kEasIMqHxWN0Z
         iyNQWF70FCNwZ+r+cVfAkjiSDq32/8FAebeF275QJy2qrGfdlR9Ys9P471tFIT3l02wO
         CdAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAXDxpLHAPGjXTMYr/kV5ilJlmQVApZCPDANN1fA1uKwpVcCzTdCOxNQPvgXsZ3luuGyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC7a3k4x/7Rpnl+f5yr153EH919SiDZ/HEj4t+x+k4p8fA9KwL
	tfOeV/oABNovZvL95rd1G0Jfx6dz+WPNZgh5krvMC2ShmmpHm0TQFbQt
X-Gm-Gg: ASbGncs9HzywubZNVvOoCsThAm9csILKFlN6BHgghapsGjKTOLpgx7kuapuDbBH7K5x
	+Zp/+4KSoEUIHxWX0dqtdeFBXwR2UKtL4hEBkJVLplUHHD8d48YDtDbttnk/GT3+hdOnm8RnypU
	2TqoatZum/qKjOFDf/tICWw66f9CvZy/ziyHj+iBDJV63kdZLVtXlJqA45I48JM7D5iSFHcwZD6
	P9qSZ9RHGhvBXDgJbXJFJyJu72PIRIb3EKqTuLkYg67I9qZtcz9pS1G/L2vE+CuY5JPgTsZkiUp
	9jWM/tlx7WwzB4FbS7ouoSjDI5poItjdNb9FUKF1oaRikUXx8eH4FkZpE2oYXqC01j4QuW8tE6P
	vYCPZXgN8jH+G7h/ke+80koAUrSCd6Bls0OSZlTmwYwzhMA==
X-Google-Smtp-Source: AGHT+IF4Bzv5pUg7BOJl1QoiQ/+HpT4AZe7ViGci2KCTIXtyzsQUmVZg8+Q6Igb9COpP6/hQQ/Nukw==
X-Received: by 2002:a05:6000:2dc3:b0:3a4:f902:3872 with SMTP id ffacd0b85a97d-3a558aad921mr2270163f8f.19.1749648776751;
        Wed, 11 Jun 2025 06:32:56 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bf28:2e00:106b:a16d:4d49:8ce9? ([2a01:4b00:bf28:2e00:106b:a16d:4d49:8ce9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5323b67ccsm15345333f8f.40.2025.06.11.06.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 06:32:56 -0700 (PDT)
Message-ID: <7914de29-4510-4eb2-8baf-31f131565877@gmail.com>
Date: Wed, 11 Jun 2025 14:32:55 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: support array presets in
 veristat
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20250610190840.1758122-1-mykyta.yatsenko5@gmail.com>
 <20250610190840.1758122-3-mykyta.yatsenko5@gmail.com>
 <4ff2fafb99131f599901580eac96dca34ca20cc0.camel@gmail.com>
 <c1cb9bd3-c99d-4af3-bbcc-2ff3c2250ca1@gmail.com>
 <8134154a25af0153411c263df923acd350253c25.camel@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <8134154a25af0153411c263df923acd350253c25.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/11/25 13:21, Eduard Zingerman wrote:
> What do you think about a more recursive representation for presets?
> E.g. as follows:
>
>    struct rvalue {
>      long long i; /* use find_enum_value() at parse time to avoid union */
>    };
>    
>    struct lvalue {
>      enum { VAR, FIELD, ARRAY } type;
>      union {
>        struct {
>          char *name;
>        } var;
>        struct {
>          struct lvalue *base;
>          char *name;
>        } field;
>        struct {
>          struct lvalue *base;
>          struct rvalue index;
>        } array;
>      };
>    };
>    
>    struct preset {
>      struct lvalue *lv;
>      struct rvalue rv;
>    };
>
> It can handle matrices ("a[2][3]") and offset/type computation would
> be a simple recursive function.
>
Yes, this looks cleaner, if we want to support multi-dimensional arrays,
recursive representation works well. A minor problem is that we don't 
have BTF at parsing time,
so resolving enums early won't be possible.

