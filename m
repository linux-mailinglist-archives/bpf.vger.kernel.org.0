Return-Path: <bpf+bounces-70963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F318BDC149
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 03:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5DDB4FB7A4
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 01:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66D83090E0;
	Wed, 15 Oct 2025 01:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czvnqr0N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63922308F24
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 01:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760493298; cv=none; b=pOYO8dcQwIkKvlltC1BADZ6ej5o0xgOX3MjMOhpDvtFL77pCsCt0/KnNSVlJMVyz0Q5CchihMyKNsUTQSpuTs/5yfH3JZ0Rqql7GfsX4m6FbNA+CDgDYMpN71wqzP6hsoVF1NxXY3r+mxGuXfvtHdSVc3JxvIukK6maUTuEIIeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760493298; c=relaxed/simple;
	bh=XurOG7TpFv0gfvogsJdszOTmGbj6A3F6k9kfoi2F3GA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qgv++HytTexxwoyJfkG4nvw/7xa8GOMnNjwu9hipqH8mzh4+PMBMxK1wdeajHqw87yeHw+ZtAvMcd71LeNNihS2prQm/g9ZwJgYi3nYDruJu/ctByhtr4EvTWR6iOe4CLzt4lIMbuskxEecEMgCXL++8JcmPw+3iuwxzAdHjKPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czvnqr0N; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e504975dbso35713975e9.1
        for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 18:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760493292; x=1761098092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26KQWOidOOOMncfnnCBb0/0PyMIloM67l5dPnBfFpNI=;
        b=czvnqr0N+eerJQJje/D9zgReXoCqNulL2VXNWGCfXQVudLbXRhpBBF7YmuXQPPZsX/
         gwqPz+dRamW8b0IrM7qXvag9sTtTB2Kinrl5LVOlkK0Pd410p1o083PYQyoRp7Hyik5Y
         6IzUg42K36rOajl5Mo72GBm0excCb2CflRNcpQVCAxGzfeId4zFPyKW9uJG7w5ktjiEl
         UTBQyVVaNNzheeSZe7o7Z+7c5JNRTT8cT0FEptwWGE/WsANYHPdXXxbuy9IM7NAMw6cX
         Oy8MR0Snt33xXmbduFw6CcYDhWw5eO2VPXkGnZL0zTdrkDrv6hUWxeXQsmLhBf3RDocf
         bfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760493292; x=1761098092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26KQWOidOOOMncfnnCBb0/0PyMIloM67l5dPnBfFpNI=;
        b=ASonx1y5Wpr889lm6ucj7wT4hT3++E/pGjpV274gZTcrdBiMSWKqKmZynf2PJY5jso
         hklvYOnkpCGHJzxla/88X57B0wl1f3j0mCtD+TaZ2JgW2ff7x9RVimyawdZNZTfefj11
         WXMIvJcgz8ATKh85DHqX8/2Wc5i2bd5ywkrIGACG07bRZBrVLo1jw33DgE0m0V+j3MxV
         ESrBbRDF/4oGEPxqWHe8wQNtZzF6IsG/1wigj2zIQ+66JsP+cS5z9QOcB3d+9V1RlmAL
         X2QOpJm0FDXFaQdraOGkIV1HLKx2Frjb7Vn+NyMo1LM4+HdkaEDEHvTGsMy6jz4M/wdm
         pEjw==
X-Forwarded-Encrypted: i=1; AJvYcCWxCqPtZz6wf0ezb0LSzRIgjmbbJDihRgMQf83HNjBAX0zCOgpzqNaRNZATpDvht1Wwe54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq6VYuWeMDw4lSEOUm2jTm9pBA3XQjP2iyZF32JZdkVqYbnwqf
	LAKT6j+8+9Suz6Rdu1W6G0mWmdajV6fAGjOVJeulT9DyaFHGilsWNkdXrSY7f3QG4tiSTTUyqEd
	GeyNsZ+vXbtIPUUh9WcZyxXWuvB1cZjw=
X-Gm-Gg: ASbGncuoGBqkkgJysORTI9t/P9cVp6AWzxZ+vwjx6SoNzOC0SML50HseJGQT4++wIBr
	hHbdK3ytTv23J+XY4EZW6KPCuFk7gaxcpyyzGslf5ltjmOXFaVMunM/5lVruXHwIIISyrV3+rsQ
	/Ac3txytTUxfnBlz9pcrcAtPZkSNnM3HABtuLk03VtHmsiK2+BMzMtJR5Qpe1hhGxj8HVNbpzl5
	+BzygJ0hj8LhSp6/TYHqpXndOvyfiEO1m6ehb6n32BpgJagKFqe5ls2Pdyhd7Dh+cKb81Ru0fvb
	jOHC
X-Google-Smtp-Source: AGHT+IFwtktUuLWBY0+rVfzsz1di7iWK0c6AtHOqKHIJNThUvRz/7fvIWwgTANA7fSwebNkxx9UvlZXTBs5LRF3356I=
X-Received: by 2002:a05:600c:529a:b0:46e:4912:d02a with SMTP id
 5b1f17b1804b1-46fa9aef4cbmr167355365e9.23.1760493291529; Tue, 14 Oct 2025
 18:54:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013131537.1927035-1-dolinux.peng@gmail.com>
 <CAEf4BzbABZPNJL6_rtpEhMmHFdO5pNbFTGzL7sXudqb5qkmjpg@mail.gmail.com>
 <CAADnVQJN7TA-HNSOV3LLEtHTHTNeqWyBWb+-Gwnj0+MLeF73TQ@mail.gmail.com>
 <CAEf4BzaZ=UC9Hx_8gUPmJm-TuYOouK7M9i=5nTxA_3+=H5nEiQ@mail.gmail.com>
 <CAADnVQLC22-RQmjH3F+m3bQKcbEH_i_ukRULnu_dWvtN+2=E-Q@mail.gmail.com>
 <CAErzpmtCxPvWU03fn1+1abeCXf8KfGA+=O+7ZkMpQd-RtpM6UA@mail.gmail.com>
 <CAADnVQ+2JSxb7Uca4hOm7UQjfP48RDTXf=g1a4syLpRjWRx9qg@mail.gmail.com> <CAErzpmu0Zjo0+_r-iBWoAOUiqbC9=sJmJDtLtAANVRU9P-pytg@mail.gmail.com>
In-Reply-To: <CAErzpmu0Zjo0+_r-iBWoAOUiqbC9=sJmJDtLtAANVRU9P-pytg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 14 Oct 2025 18:54:40 -0700
X-Gm-Features: AS18NWCKhuwcHSlUElwUIAzX8T7zdY15gvsdXmPJO09MLBADQKHWSXQwuUBXyho
Message-ID: <CAADnVQLr0iSzV24Cyis0pconxyhZJKAuw-YQVoahxy-AvdNTvQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1] btf: Sort BTF types by name and kind to optimize
 btf_find_by_name_kind lookup
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 9:53=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> I=E2=80=99d like to suggest a dual-mechanism approach:
> 1. If BTF is generated by a newer pahole (with pre-sorting support), the
>     kernel would use the pre-sorted data directly.
> 2. For BTF from older pahole versions, the kernel would handle sorting
>     at load time or later.

The problem with 2 is extra memory consumption for narrow
use case. The "time cat trace" example shows that search
is in critical path, but I suspect ftrace can do it differently.
I don't know why it's doing the search so much.
Everyelse in bpf we don't call it that often.
So optimizing the search is nice, but not at the expense
of so much extra memory.
Hence I don't think 2 is worth doing.

> Regarding the pahole changes: this is now my highest priority. I=E2=80=99=
ve
> already incorporated it into my development plan and will begin
> working on the patches shortly.

let's land pahole changes first.

