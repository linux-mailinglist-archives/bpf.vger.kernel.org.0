Return-Path: <bpf+bounces-69719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 438AAB9FDD3
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 16:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB9671C2504F
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 14:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7E228BAB1;
	Thu, 25 Sep 2025 14:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iqysoy8E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060B227A12D
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 14:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758809138; cv=none; b=d8Axs4MQTU1ma8bNshV/EpLBvSmdp9TYSL0x62czHKCfqCehj3+f7YRc7bjKVHF9e9hFyAy/M4u3+nz0/hu1bTl6m1tO/SPM1YtFXKxVZNGkN02MOf/4eO0TwtT7FitQ8IX8aS5MBIcEDx4kkcxivOvwRfzdsKgQakd8SIYWqf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758809138; c=relaxed/simple;
	bh=5WLt4e8G8qYs4QI4bxMII7pdtyAa60deF07NK2Rwah8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=La+l4p4mTfxAG4nFPVyBrjZ1hVs1ZMJPetd3jRaiItbT1obSOhGSxwNau30sDk/kpR03zMoHa6AHkS68ubAbXM0UYbnAnqLBlNPoEPMwlczG/kRK1mLfPmkL/9ZyIsTc/o63TO03OwvivqqAG9IuoYOPpvJCOGwKLLvAjAcF600=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iqysoy8E; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-41174604d88so341003f8f.2
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 07:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758809135; x=1759413935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RBu380y0ThMkvKMZAdflPO4ayhtFxUm++NTY5wBMv1o=;
        b=Iqysoy8E8epzqBj7hwTL3QEwMoKu7NWU3+wedcMHnt67pt2c7EJPo9PT6lrSe3y6j0
         4ArLX651AA9u6l5HTfw9kfbYVx399GaslnwE/Kvz8oJwfFSKlJ3PPuoEO1T8yukxIsQa
         FPKckNfMhe20S8PRLNBlygBl/Sl8mOshSF+iveiqD057VkaW6EwvQf1UD75wKmkXRPzB
         nxazuZQw8kKfHFDC+eaKW7nO1tYtqA62blcN2597iZrQ8l9Wg0MqOc7FmwG/aV+78o70
         3P3tELG6gXtx8ZSAZwIoFFcTgUUnWIPyAIi3Zf0l13EgFpg7rGFKwpGJWGp9D/LNpjut
         TUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758809135; x=1759413935;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RBu380y0ThMkvKMZAdflPO4ayhtFxUm++NTY5wBMv1o=;
        b=AzLvHrgM2Br5bM4CayreZfP4hpmydNmJ22FTpbw/wQOOZDd4F6ZQxJrKAwxU8cWun6
         mRa96WxxU5jZ9YUD9bmjpRxeoqRlaS9/EW5L505Tdz595Ld+BClHTwZ2P9PkK3vLuxPu
         EATiZ6tKnFNdRlBPS+hfHI6TGT3CujuR/tIaFNR9V5xXdn13sM2XcZpcqbRQL2AiCecG
         49oZJnKFIJWNbZ560vThQTMm5CY0VRAsva5lxlhMUo1NM4tt8JClokHj61QTXB8/Ixz9
         UdiYJuHoIWtNphQtGDUEBYIbWsPksyme2gN1wScUWU43KexjYHoq0Le190IumHBLE0lA
         MPQA==
X-Forwarded-Encrypted: i=1; AJvYcCU08GwNsGPyHpfFvfO+I6GFA9JtS32bqgxHHtcwEQWVJ6YzGppo2STBzg7nAw2Tr4Z35mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJrBdwvCz0F0+XqKD0DOzA8npqkrJjA95fTp5Pb1NHL5N3RhX6
	XzGhDp/lewelKYlyE/fbrsE6oj57lGmZoZmkM7gRLfA5FkbnsGhI7LRu
X-Gm-Gg: ASbGncuu98/mBund6eF3EP4xbqXQloE5NX0DK2nVECXLntt27iYjdXi9Bxr7pYdQeOX
	mBeV2aX7mBeSdXiegk3rtTe5Y8E9y2CQr4u8uRoAz1IrpOV/csEijwLf84yp3Mu3LaMd91wUcht
	CEFvxXfoqPVW5e8G7xyUE2E0nRRtvA1dRp1lAi0f5BBZ5rae0OZaQtEg0rMhrQCAgUVXjRORSEg
	00lWhf6SRb/pP7CRKGEZbtnfOJ/JFLAqHeFTS7LSg8/nh7bh+gmFMSJVzOX9e9o9e2/+butG5yB
	UxAbMqAEizU/kPTavHwEsPbOL96kwfcZMPAzW6wDZrRJL5qf8wGI3PeWAx8A6C7hRSWbyaC0J+T
	3im/vtWtCHFiMpF5ggPs7ap8z8zV4eMmM2LupPrBt1EGcdOAwYwHXOcy5QpudxlitSB2HTrz+PI
	vgA674v8U=
X-Google-Smtp-Source: AGHT+IFrUhzu/cOQyopFFO11YhjTli4GP6WS+UV5MIedbRMvpVIJciiibvQmgs//C0aivZTw+MPJ4g==
X-Received: by 2002:a05:6000:18a5:b0:3f4:5bda:271a with SMTP id ffacd0b85a97d-40e44777081mr3459717f8f.6.1758809135093;
        Thu, 25 Sep 2025 07:05:35 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7? ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb9d26ef7sm3338215f8f.26.2025.09.25.07.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 07:05:34 -0700 (PDT)
Message-ID: <e8450c79-88cf-4b8f-ba2d-2a9e4194f820@gmail.com>
Date: Thu, 25 Sep 2025 15:05:33 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 6/6] bpf: mark bpf_task_work_* kfuncs with
 KF_IMPLICIT_PROG_AUX_ARG
To: Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org,
 andrii@kernel.org, ast@kernel.org
Cc: dwarves@vger.kernel.org, alan.maguire@oracle.com, acme@kernel.org,
 eddyz87@gmail.com, tj@kernel.org, kernel-team@meta.com
References: <20250924211716.1287715-1-ihor.solodrai@linux.dev>
 <20250924211716.1287715-7-ihor.solodrai@linux.dev>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250924211716.1287715-7-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/25 22:17, Ihor Solodrai wrote:
> Two kfuncs that use aux__prog argument were recently added [1]:
>    * bpf_task_work_schedule_resume
>    * bpf_task_work_schedule_signal
>
> Update them to use the new kfunc flag and fix usages in the selftests.
>
> [1] https://lore.kernel.org/bpf/20250923112404.668720-1-mykyta.yatsenko5@gmail.com/
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>   kernel/bpf/helpers.c                             | 16 ++++++++--------
>   tools/testing/selftests/bpf/progs/task_work.c    |  6 +++---
>   .../testing/selftests/bpf/progs/task_work_fail.c |  8 ++++----
>   .../selftests/bpf/progs/task_work_stress.c       |  2 +-
>   4 files changed, 16 insertions(+), 16 deletions(-)
Acked-by: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>

