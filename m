Return-Path: <bpf+bounces-19831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D27831FE1
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 20:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 803B7282AF1
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 19:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD2F2E62B;
	Thu, 18 Jan 2024 19:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsVKlfqm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C1E2D610
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 19:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705607433; cv=none; b=EkD+UK+EjjM8gWPZRikflcDWvOofapKQMkHKUkn8eNKY0j+TnvdZiwdpnqNmjw0oQHFpSbbu+GGy6DoWuT0uHXo9wcsm/XomF6/29XKsqZbshfex+3fzlyaHBq6K/reqOFaAG+InRMxUD6Spg7j/Mdlkn0+s5DWXYajQPQgv8q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705607433; c=relaxed/simple;
	bh=R3dJXry8iAVjzRKkfWm+efCkwY9E4gszArweVXrj3dA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LmnyYvSCiQUbepYiPzFtXhhWeQZLP9xR+A4hZJLDB4w97O21rpC+ejRynY5y6NLr8dcQ7BZc6j/gVv7uN/7a83p/UI7rg5d8NP0WBlKIA8H1X5qyKy96gtmFMkuK/PlzQO3DiJrrWf+jB3qCfwT54Eg1f6oCByKb7+IX+H6z+TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsVKlfqm; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e80046246so345905e9.1
        for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 11:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705607430; x=1706212230; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jk9pPa37z/sHfZDxMeNmEG/UPdOF85S7d0liDPIJ1oQ=;
        b=JsVKlfqmaO6eaTi/LBtmydKBxWi5vFjmAVN0ArSRf/866X1Zk9ffDhgg/UQhTWrDoL
         rN4lSL4P05UgJKzmaFX2J6Ra+Wh03VQ9ELUwR2iNT1RQs2BcMNgJmUjlgPfCx7YehNjY
         WpRnX1IHUumLemuXtnZimNeV2CT5Tw/PD/NadWqYNPJvUvUZN9iyZ491e+TYX7eniCs9
         AGuARxwYLBnj8vsANX/rE3tXvH9U09068lfYWOtNr/oUPJVU/CeTqhXFpLYmWl6G5QN2
         4iTNvHkLY3ST+sEFFvLXxfPbSSu+9MrWag2MflXYcGiCf0t1v1kVqDajUvkUMHeRlhXz
         YzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705607430; x=1706212230;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jk9pPa37z/sHfZDxMeNmEG/UPdOF85S7d0liDPIJ1oQ=;
        b=CWVYAaTk+jgzR3a/cKXZV09NjRdlQjLx4vCiz2XhNZe9tNHYZc8s4PkuSEhHgmQvMK
         fhUZuLVzTiGqKhytKU6oz8PELfokA8stY7Pp/CTcgu+p8i3ODJErl6/Ol6+Ljz04yac5
         CDUlriFMOR0T13T/OHVuZ5MNNN7fyg9RfBcd9ioSuouIxpI880+PNfnamgEpt4B4qtnp
         J3kA6ozwXsc3dPiy7TGSTy93x5PJnen0OoAaB3FLNAq3pRi7361oJcMNbpcf5Df6eOoA
         v4QoTbj1HDLCPnkRSbNMNyYsQfl3OhaDZJvP+Ume8P8zKfS0chSyibeGw9rv/XGRi23V
         FnIw==
X-Gm-Message-State: AOJu0YycGJC9fXNkv2k+g2fAxUVSRDvoYU2cfKQSOpKLlijocGcC+HtK
	iisHtCVRgb+KmC9EwTcjoFstXccjNSH6Ec9CXR3yj8gv2q+75Hk0
X-Google-Smtp-Source: AGHT+IG+bIeWG0h5YVhnTHQbZHVhJpHM4G37trVwRjtMpcLCAZ9yXy46Hoq0qJbTzwsoQK78mY4i9g==
X-Received: by 2002:a05:600c:4f46:b0:40e:89a4:27db with SMTP id m6-20020a05600c4f4600b0040e89a427dbmr1779007wmq.16.1705607429835;
        Thu, 18 Jan 2024 11:50:29 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id q10-20020adf9dca000000b0033342338a24sm4744151wre.6.2024.01.18.11.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 11:50:29 -0800 (PST)
Message-ID: <a49d5548efd5766a3b66ef3e6f18bbbc4b1bf677.camel@gmail.com>
Subject: Re: [PATCH v2 bpf 3/5] bpf: enforce types for __arg_ctx-tagged
 arguments in global subprogs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Thu, 18 Jan 2024 21:50:28 +0200
In-Reply-To: <20240117223340.1733595-4-andrii@kernel.org>
References: <20240117223340.1733595-1-andrii@kernel.org>
	 <20240117223340.1733595-4-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-17 at 14:33 -0800, Andrii Nakryiko wrote:
[...]

>   - for kprobes, we always accept `struct pt_regs *`, as that's what
>     actually is passed as a context to any kprobe program;
>   - for perf_event, we resolve typedefs down to actual struct type and
>     accept `struct {pt_regs,user_pt_regs,user_regs_struct} *` if kernel
>     architecture actually defines `bpf_user_pt_regs_t` as an alias for
>     the corresponding struct;
>     otherwise, canonical `struct bpf_perf_event_data *` is expected;
>   - for raw_tp/raw_tp.w programs, `u64/long *` are accepted, as that's
>     what's expected with BPF_PROG() usage; otherwise, canonical
>     `struct bpf_raw_tracepoint_args *` is expected;
>   - tp_btf supports both `struct bpf_raw_tracepoint_args *` and `u64 *`
>     formats, both are coded as expections as tp_btf is actually a TRACING
>     program type, which has no canonical context type;
>   - iterator programs accept `struct bpf_iter__xxx *` structs, currently
>     with no further iterator-type specific enforcement;
>   - fentry/fexit/fmod_ret/lsm/struct_ops all accept `u64 *`;
>   - classic tracepoint programs, as well as syscall and freplace
>     programs allow any user-provided type.

The "arg:..." rules become quite complex, do you plan to document
these either in kernel rst's or as doc-strings for relevant macros?

[...]



