Return-Path: <bpf+bounces-19897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7C28329F9
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 14:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED1CDB2127A
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 13:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EEE51C36;
	Fri, 19 Jan 2024 13:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="JvldABKi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E674F21F
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 13:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705669296; cv=none; b=A8VnUk5lsxi7IKRi9yDB8ZZTH1F6jkHScwmCbPORkqDrA/Ym8XGgj5JR2FzLdchuxXxyJBw4WIVMe/GDqNfn+KUaFxnKTG5+OAh6Nxyr5lZK4WpVGQNAa7lP4hpOcBODOBOylpf1zK4Qfhb554NxMXgbcX2CIQRShimgaofDFvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705669296; c=relaxed/simple;
	bh=O5qgYyGa9Aow6RwdtQIr3fULbRDJThi6b43dwm6gxu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZQUl3noXqYoUTUKMm7TyCMr2R8Ypvp5Ig2nBj9oxGtCY2wKBVH53P7R2gpWbYILgydPHsnGxX8HS+6/5wmLKqoCc+8J1Nh/+PYPefK77cJd1uc5rdSZ4DgEwnyUD3MBCeJgE8jsWLYAp8LbdnfV1kzK6yRKXG/ePYCO3jtlVx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=JvldABKi; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-336c8ab0b20so662181f8f.1
        for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 05:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1705669293; x=1706274093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uxt5Gv+XfLMr3gRr8lhq6FWGPaY6t85VMjlzsrTMWz4=;
        b=JvldABKijeqej8DzEajSeRkrySz1QIdydAW0AJxxspobIJmvIHJ0LHnQwwAJ9SKyvB
         UguryPpliP4Tcy5+Gj2JsOYNcfGcobZGdwXVgHh0oiw3Ji6Xes9sThDZqVqb40O8roff
         TivMqKEjZzeOFuizxcMLm9tk0lNAipBUxC5x+/E1Qqi2fU7wtZgPxPgf60fF40HxMxu9
         2fuAJMpeAoyMxEjWHJ38WbkiF4eJ4rt8A+7LPcEjLmcALccaozTVqgOMdD9Hi5x+Dh41
         VpX59FyJqmUYJXFpHDxuUCmP/6RzAV/QTJ8kx1T6w1V958yCkVysEa40073M4xTutGWY
         Mx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705669293; x=1706274093;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uxt5Gv+XfLMr3gRr8lhq6FWGPaY6t85VMjlzsrTMWz4=;
        b=gDiPYrGcjoHiay2myicGlDDgKtf4HDFm8E5Yj2++y2Y1EbO/vTizLQ9TK6+hu07gHl
         AvBNi01ieTV3AAJY5TjAPuaQ4QaLwMs5pjdt0J7UJwHKlBSLbgl/MkzrnxAviRKAuLJ9
         dH4h+nY3tP4pFHQayk4VR8GcaBz6nFxA5gemikkjZhnC6zDQiODj4kBRMl/Ke4k25I/t
         a9mPwWsQgiiP8iaNDJ+X06yMiFMpoCtw/Gozswn6CghxGkoi6TWLKcWOKOmkSBVhInXg
         I8IpQKc2+ipONyhDG2jyabTDHrUy5yf+FcdEN3UKw/VOi/SC9YNAN5eyatasAiAARH8p
         EsiA==
X-Gm-Message-State: AOJu0YzpZUSsC36NXKwZBlAJiVc8Ut7iBXi17lussbeZ3T3DA+6MIKAe
	3Z2T5RZ45ue1U/5LzzJTgD7q2EHhVZdMNnDFoeqxD/he8z/zjMVvtDiZxNRVcX0=
X-Google-Smtp-Source: AGHT+IHzLRkpqHKWttu/VZBTp17nSuWaepcUQBo/WNspwqm6ULRuABRG94vuVeMBu5XcyNZEphBBmg==
X-Received: by 2002:a5d:678c:0:b0:337:c702:98f7 with SMTP id v12-20020a5d678c000000b00337c70298f7mr1536146wru.95.1705669293213;
        Fri, 19 Jan 2024 05:01:33 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:9d42:31a1:22ee:55ff? ([2a02:8011:e80c:0:9d42:31a1:22ee:55ff])
        by smtp.gmail.com with ESMTPSA id l4-20020a5d6684000000b003379d5d2f1csm6434397wru.28.2024.01.19.05.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 05:01:32 -0800 (PST)
Message-ID: <358262f0-6047-4a2a-b9b2-bcf7b250112c@isovalent.com>
Date: Fri, 19 Jan 2024 13:01:30 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 bpf-next 0/8] bpf: Add cookies retrieval for perf/kprobe
 multi links
Content-Language: en-GB
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Yafang Shao <laoar.shao@gmail.com>
References: <20240119110505.400573-1-jolsa@kernel.org>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20240119110505.400573-1-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-01-19 11:05 UTC+0000 ~ Jiri Olsa <jolsa@kernel.org>
> hi,
> this patchset adds support to retrieve cookies from existing tracing
> links that still did not support it plus changes to bpftool to display
> them. It's leftover we discussed some time ago [1].
> 
> thanks,
> jirka
> 
> v2 changes:
>  - added review/ack tags
>  - fixed memory leak [Quentin]
>  - align the uapi fields properly [Yafang Shao]
> 
> 
> [1] https://lore.kernel.org/bpf/CALOAHbAZ6=A9j3VFCLoAC_WhgQKU7injMf06=cM2sU4Hi4Sx+Q@mail.gmail.com/
> ---
> Jiri Olsa (8):
>       bpf: Add cookie to perf_event bpf_link_info records
>       bpf: Store cookies in kprobe_multi bpf_link_info data
>       bpftool: Fix wrong free call in do_show_link
>       selftests/bpf: Add cookies check for kprobe_multi fill_link_info test
>       selftests/bpf: Add cookies check for perf_event fill_link_info test
>       selftests/bpf: Add fill_link_info test for perf event
>       bpftool: Display cookie for perf event link probes
>       bpftool: Display cookie for kprobe multi link
> 
>  include/uapi/linux/bpf.h                                |   7 ++++++
>  kernel/bpf/syscall.c                                    |   4 ++++
>  kernel/trace/bpf_trace.c                                |  15 +++++++++++++
>  tools/bpf/bpftool/link.c                                |  94 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------
>  tools/include/uapi/linux/bpf.h                          |   7 ++++++
>  tools/testing/selftests/bpf/prog_tests/fill_link_info.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------
>  tools/testing/selftests/bpf/progs/test_fill_link_info.c |   6 +++++
>  7 files changed, 214 insertions(+), 33 deletions(-)


Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thank you!

