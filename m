Return-Path: <bpf+bounces-18908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6168982361A
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 21:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFE901F212C8
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 20:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3921F1D53E;
	Wed,  3 Jan 2024 20:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tWoNggRk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893351D528
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 20:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4279f38b5a3so77022411cf.2
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 12:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704312413; x=1704917213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HB9ce/ZYj/o4q+a999lFcCPcvK9JlN2H69sVtgUKvWI=;
        b=tWoNggRkLg77FZmoYe7r/lfrBBHM3Ymak81nFdFy8rtdL6E4Ido1HJSszoTzC2b7lH
         e47KteAuJO/nH7iDubjnutqlApc1wpiM+BbZrW43EX8iFiXOEKOlLrczDfFF1dWA6wa5
         JK2beLjRMxoiZkYNOwvvgIq0RNLcLpRebpueQSCT5X/24qNme6M3CUWawxNLUi/sZ2as
         cbWBxglHsB46r5T8WtItdXiegj/cLIh+ieAxSa/0tfTdSfigfdTr8aCWBcHZqwyJrJ27
         VTU4b0ENZWIkWawVYRZtm31UM4v1kZWf7s/RoKLbGS7695mXHm892DrGOnKNd5lus5/n
         T74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704312413; x=1704917213;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HB9ce/ZYj/o4q+a999lFcCPcvK9JlN2H69sVtgUKvWI=;
        b=aAs6m7V0EA906RoyNPjgX7BwjF/ul0TE17q5uY5ORbza4T0+wcyoo2EOZ5kC7fpLo+
         3LCG0KRJs0tBnT1szXkmgnglz/KRwkGE/jMffObwPMj9FhtAuqX87Rmp+RArAsP9qcI7
         dLxYgCQk/KK4ulaHJWZU5NMvTKBKcDgZrfCevjMxC4x8+ij1YK0DAz0WRSfXEL4QO95P
         rJZ4VqXhpP7q5zD3/mP4sH4dC9x4NQWmpfyMjZY/V0jb4ZvIKkTSww63Ud+H6rRsBNJd
         7y50i9/yM0dbqGg9wZpBgGRhzN7JymvzEbLmf/XC62vOhu2sJ5y2tbBF7g/o+eyfVKKQ
         086w==
X-Gm-Message-State: AOJu0YxcHhzF5DRQDAyHGu7J+gA++VK2HQG1kXv8/qKc5B6br4u6PAGA
	h6Egvq3hQDW+61VPPlhoOFUb40Xcb8lp
X-Google-Smtp-Source: AGHT+IHBMSV1+MBkLmy7Z1dA3S1YsmNAWyf0LA6NmReZNlLiJ20oDpmaPkJVVjqaZsxjwDHM1wehZQ==
X-Received: by 2002:ac8:5782:0:b0:425:85b7:a784 with SMTP id v2-20020ac85782000000b0042585b7a784mr30392949qta.53.1704312413418;
        Wed, 03 Jan 2024 12:06:53 -0800 (PST)
Received: from [192.168.1.31] (d-65-175-157-166.nh.cpe.atlanticbb.net. [65.175.157.166])
        by smtp.gmail.com with ESMTPSA id j4-20020ac806c4000000b00427f02d072bsm7618575qth.95.2024.01.03.12.06.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 12:06:53 -0800 (PST)
Message-ID: <bedf07d1-2cd5-4bc8-9e59-a96479a7ff14@google.com>
Date: Wed, 3 Jan 2024 15:06:52 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: add inline assembly helpers
 to access array elements
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, mattbobrowski@google.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240103153307.553838-1-brho@google.com>
 <20240103153307.553838-3-brho@google.com>
 <CAEf4BzbKT3LbHQSFwpAfoJuhyGy2NpHk7A6ivkFiutN_jnKHYg@mail.gmail.com>
From: Barret Rhoden <brho@google.com>
In-Reply-To: <CAEf4BzbKT3LbHQSFwpAfoJuhyGy2NpHk7A6ivkFiutN_jnKHYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/3/24 14:51, Andrii Nakryiko wrote:
> I'm curious how bpf_cmp_likely/bpf_cmp_unlikely (just applied to
> bpf-next) compares to this?

these work great!

e.g.

         if (bpf_cmp_likely(idx, <, NR_MAP_ELEMS))
                 map_elems[idx] = i;

works fine.  since that's essentially the code that bpf_array_elem() was 
trying to replace, i'd rather just use the new bpf_cmp helpers than have 
the special array_elem helpers.

thanks,

barret



