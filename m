Return-Path: <bpf+bounces-21699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 347B7850352
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 08:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 692EAB23EA2
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 07:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1725F288DB;
	Sat, 10 Feb 2024 07:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnXZU6Dr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1036136113
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 07:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707550914; cv=none; b=pLmSGTRHWDDIPpp9u1TkTEUbgWsMatz7ZHfXpLEyuhW8N8y7vrrhSORj8CNVKjl45yVcuj8j0w7Q7C3GY9ASjb7beDjLjNytldXruD38CsQfNEQYRmII/PGNB8D6W45gZ98CB+Sng18yR0TGU/tMCtDt1M0w0F/GFAcya1Yly5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707550914; c=relaxed/simple;
	bh=1NY0beZGu8D4qTvPVYxMzBZE63nAk4DaEoMYfNqYjgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aAIziKPRVqYVnGto1RVcJwaVbTAugQdjwRyaBav2ZZA12+jALNNRf8KZuyjDr4d0hrCPNABPikU3NCI8WUU/S5MxXEcZFZ5l64RPqF7vzsYX0zMQ0X77OTi4XJXwd94zJ1LLFMcrYzJ6Kb23yGrQxDrq3xRhVrkjBtQ845k83kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnXZU6Dr; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-a36126ee41eso219583866b.2
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 23:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707550911; x=1708155711; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1NY0beZGu8D4qTvPVYxMzBZE63nAk4DaEoMYfNqYjgM=;
        b=YnXZU6DrvEY97/yKTg3X/N39MEEy8G9tqbA/SnSmgQBJTQEoOoFOYt5VfkA9P8nH/p
         Go+WSZDtryfGXsQl1zqhwcqD/1I7wrqWaWeOc5vswPEY0EORJq7U0b6z07aXFhRBGLFG
         9MVlRCh5XkCIQtJktIfEG1hBCJUJODkGQIxloSj+HosOkZY5jHuVWwCpzWOtu8Aw6Pdz
         1Rgn21i5W7irobfkIGmXFERrd6VqY8WQ9HiIGTNzNLaTZmUZH4k8X9R7vhd0nK83lrET
         D/kljp/DojMyEFF45QQblbCx5u76WNJ6v19BJvYXMh5+5/IVRo52MJBV3DNXP018pVgm
         /Bww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707550911; x=1708155711;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1NY0beZGu8D4qTvPVYxMzBZE63nAk4DaEoMYfNqYjgM=;
        b=hvtW5MBJGIlwROYsWQRBKrsyrngy5vMpwZtFZMQJeM+iJWS2ic1PDMdO3GCC0nAwgP
         E+UsFDdIZq630VySXYuyx8A/OO4Wj0atJf6NGlWj5r2Sj0WF8rxi6zx/h6Cq+sdrR2E6
         M7d/TmngduA/BnIDyOkN/PzhS5flRBltZY1FmpVmEKX2U3vkvI9NkOeNhoph6b+UE+v6
         UcjgX7y8CNL6wVMqdzT5rNzjPU32mU6tFEAb2tz1LZxZP/XpUPleONavRTjmdpfN+oYn
         fq4V/0wfIe5T5Z6PCsUEm0YXDMFJ0Boc81VbIWY5RDBOgJNb5uhYwKvbHR381KiEPR1U
         g1Iw==
X-Gm-Message-State: AOJu0YwblQr4znKV3zeI7YM2jwStcLIXJUM0oGsRSBH7GKahV7y35Kju
	d0DA3DhqUn8FSVqskb3VvtkvbmnGseYp8fEZv0YMmAJJ4TXlM31wgBQzV9YDGOgusM6kSL3Kzy9
	YwAXLdwigNQABSun2dMkjlWzejLw=
X-Google-Smtp-Source: AGHT+IFRCZVvXeiVf3pBK+ADDeVny/vVR2bnNk9kWId2L0AmaNjvmvY/N7JQeASGgsoe11TxL//TClnpS32UIE8KbEk=
X-Received: by 2002:a17:906:3617:b0:a3c:40a2:ce19 with SMTP id
 q23-20020a170906361700b00a3c40a2ce19mr210332ejb.66.1707550911065; Fri, 09 Feb
 2024 23:41:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com> <20240209040608.98927-7-alexei.starovoitov@gmail.com>
In-Reply-To: <20240209040608.98927-7-alexei.starovoitov@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 10 Feb 2024 08:41:15 +0100
Message-ID: <CAP01T75-dA4S9zCcXz0jTQ=1bU-U_Kx+LHH_-sKRtBDOPgDDXQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 06/20] bpf: Disasm support for cast_kern/user instructions.
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
> LLVM generates rX = bpf_cast_kern/_user(rY, address_space) instructions
> when pointers in non-zero address space are used by the bpf program.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

