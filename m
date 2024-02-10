Return-Path: <bpf+bounces-21695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0968502E5
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 08:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED9991C215EA
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 07:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2ACC20DEA;
	Sat, 10 Feb 2024 07:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceeRV+8t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF32D6FC2
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 07:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707548725; cv=none; b=GOYhwgYaLO2Hc0JstoucqgwU8/YOs31JSdyMzAkECqSHE1oDPpjS4/9aKNN72mXpnhiJifV+ghajvYfwkf94IRy0hKlasnZ2uH9DzU5NOw04oku9eNyNa7Bii6DiFaTPfPcKkZmgJ0JBrjsknBlpY5RFr7SVscH09OCNNHaigoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707548725; c=relaxed/simple;
	bh=+/ONW8eCu+xAmaEZNue8qKFrPRn6JV7rHwA+NZHX8Jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O1fm8FhA1PMOggQdp+a5cwRvzkHK2FFhMben/kS86RU3y9JPBmfimly+Lt1XJvb7hEZzi6G/Rz5ehgBJKt869oEOZ+MGi25ecQUg2NdDk++M2WAg6xMZ2s0O03fLuEr+4KAiLsV9AXVbr2CRjRm4+LfnWPdD/1pH6NPShfL2NI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ceeRV+8t; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-a3832ef7726so197816666b.0
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 23:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707548722; x=1708153522; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+/ONW8eCu+xAmaEZNue8qKFrPRn6JV7rHwA+NZHX8Jo=;
        b=ceeRV+8ttjWQXH2JdQ2y6LlozY61Pwyky3b92pwm0QB1plZLwxj9dUxw9MXbbPgmoX
         VMk3PnP4DJtlB5JbwGKnQd1XltS0WsIUQBkyUBSOhyvt7ZXXSdZRv4u+sO43Y8C44f3U
         /7K6zLUbUdLLSxVDfrntuyzJq03bDHELmqFV0Ga/eh5KP1lxqD7Mc5RTv0KsO59jU9VP
         ggt4Bk5Q6rJxUWQDoM27HdFASBPvfR+KrorurVlzX3GCKpiJtQK2VuMcllcFH/1Ny16K
         0G6qHICbyzoqn5TpmZe4HLT4gmhJHuFm8/9Fz89ImUjZ/zt3RXMYr1sLMDUanm7IOXPt
         RLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707548722; x=1708153522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+/ONW8eCu+xAmaEZNue8qKFrPRn6JV7rHwA+NZHX8Jo=;
        b=MNw5hE0keF0pZiqngFHDyrFRwZH7apC3JX3OexaWfv0cRjcAmY/CUzV3s/gBTjz2VD
         Q0SdZ0grpo9de3GEx/rSfIH+dlJUFGpRNXrEUSDlmi3snvvSYDjckyRtdCoEk3IwDjR2
         4ZbVM9nfkP2UkhUFxJG3o++xPn/1i/iIlUkIadthWkOcu+T6aGo809xiZPsI2g7l3fGs
         yLQja8iKGIVewxQbT6+wdlNQSCJWD0VqRID4PSXymU7Bt2WxaB3DJ6KmP+48Qfw2PYeN
         k6d3qYHk+By0AWbkMSPQLW42M8GT2RgsfdAuS0wPTmsvscwkUwxPZoDAaikh7t3b5Ihy
         yOkg==
X-Gm-Message-State: AOJu0YxlB91c50AvI6H8R1N7os9EFfjmQl6l7kCeBtD15dTGVOxqUwqP
	ZSyp/PCaT/YMRpvhCRpl9cPnINlzwU2YwVYtB0aFENe45Vg+n49ovfZDSYlsejzEeaAcHfgNsGH
	D+Y8Px0blZipd0UYb+XFfoCARYlg=
X-Google-Smtp-Source: AGHT+IGQ3txRdAu6XaQGrJ6udshyJ/SW0xGazo12ko5B9gnjJXSWPTI/qw2h7fMb2/1Xnju5lvJIqtkVqfaY+aCNeNE=
X-Received: by 2002:a17:906:78f:b0:a38:7ba0:de20 with SMTP id
 l15-20020a170906078f00b00a387ba0de20mr761089ejc.26.1707548721912; Fri, 09 Feb
 2024 23:05:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com> <20240209040608.98927-5-alexei.starovoitov@gmail.com>
In-Reply-To: <20240209040608.98927-5-alexei.starovoitov@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 10 Feb 2024 08:04:45 +0100
Message-ID: <CAP01T74_=odqymbHOAmCouo4yHk17CvuvMHKSqg11F_gjyV4Sg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 04/20] mm: Expose vmap_pages_range() to the
 rest of the kernel.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, tj@kernel.org, brho@google.com, hannes@cmpxchg.org, 
	lstoakes@gmail.com, akpm@linux-foundation.org, urezki@gmail.com, 
	hch@infradead.org, linux-mm@kvack.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Feb 2024 at 05:06, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> BPF would like to use the vmap API to implement a lazily-populated
> memory space which can be shared by multiple userspace threads.
>
> The vmap API is generally public and has functions to request and
> release areas of kernel address space, as well as functions to map
> various types of backing memory into that space.
>
> For example, there is the public ioremap_page_range(), which is used
> to map device memory into addressable kernel space.
>
> The new BPF code needs the functionality of vmap_pages_range() in
> order to incrementally map privately managed arrays of pages into its
> vmap area. Indeed this function used to be public, but became private
> when usecases other than vmalloc happened to disappear.
>
> Make it public again for the new external user.
>
> The next commits will introduce bpf_arena which is a sparsely populated shared
> memory region between bpf program and user space process. It will map
> privately-managed pages into an existing vm area. It's the same pattern and
> layer of abstraction as ioremap_pages_range().
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

