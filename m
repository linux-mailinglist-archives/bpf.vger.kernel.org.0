Return-Path: <bpf+bounces-71484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24473BF431D
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 02:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E621B405CF9
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 00:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C7A257848;
	Tue, 21 Oct 2025 00:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFrytNTJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DAF2192F4
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 00:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761007841; cv=none; b=umyMURdEpuHvJ9dZfD49O8Ck6DKxDCBLP+x0XvB1UcUVWtuSprPUnTyGLgKJpWzHZ9nrFQ5dYhZQti6i4bJpaHvgJWOE6GfScjeM+43oaOkFdlY9Py1JKH0cifyBeIJ2SQK3pcFLCkH2/trf9Gl5uBV3uYmr04wPfIQSEvAtiMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761007841; c=relaxed/simple;
	bh=LiSMJjvl5jo7T9ZHtXYQgM3pgDGZENbXLXRwrLZB5bM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uqob+A1aQuN5HEHO4JX0sn8w/P5hun0MtEpmH98Nd6X34GwTiesEO4DhcfR2L5x1F6Md17X8TDpuAN6+8xbc9q7aKGKxrj4pDGXWSb5DyCbLv0X+NZGtAm+rWDmVB3MOZOU4d/TE9LHjrGYKtqSeu4xabpPyanaK6EAZQUj56vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFrytNTJ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7a213c3c3f5so6405236b3a.3
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 17:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761007840; x=1761612640; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/AwBHEuiIF/vVerErPvl1X5GkSsh/z+FWgAmDfnocX8=;
        b=LFrytNTJSLZrw7TEmvVd/a0KIf+EQ0I6SERhOUwYm46Z4WaGFXW6KZsZ5KT1vIuQ/i
         f7dWsV3Pk4rbQMKBK3YaHGskts/M7IdVI946IRt1IDM47XkFmbsSLOWhITXEobuZBW8k
         H4ac6vhICjTXMG5AeLq8Xoi8i52iycGcqinGFeRd7aY450cSyskVv7bAgbX2w14aLTe3
         yDHr3bqeYyK9SlsjH5fLP+qXDZTKNj53YchleMe3R4yYKO+/goAuGg6cYHFEzMfBdM6v
         PwKSgIqYBTKvfLsCy3gWWSYMmQPoWD9lxizTzDbumkAvR/dHgHDp2Q+R//I+XlJOtMW9
         sjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761007840; x=1761612640;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/AwBHEuiIF/vVerErPvl1X5GkSsh/z+FWgAmDfnocX8=;
        b=ec8TXuRGoU2BznsrSb8OxJcoahGJnfng7kXBn7b9BDCZVKC+e7vDCjlRIoZWzeW8hi
         /vFVb/giHayrHetlrV+QO0t3JJulJRw+LhtJ5Y0eRoxf5sseKb1BTtax4tyJ2HCG694L
         jz6sA9Jxzk+7yKiryhZ1VZxe0KII9ZPtZqXA7YB7xmgxeVjwe+TSDveodz1On12v2To3
         vo8BLw4vCn5XxpE/6JbHA6P9muoOHJbayRDesb3z3i72eq7wCulQsWp4zdWO0jnTIKb8
         kN2vdTDMLdYq4LgLHiThtVOkdHlPkYrc7zWo04wSJeFonSkHaYg9JdeB80/Zl4tLOwnG
         iy/A==
X-Forwarded-Encrypted: i=1; AJvYcCUtcDsOrRVxpIZqTJNZzHIHsuS/YDTP5wdP+irIdrA7n/7aUAR3R5JMU7g/xZhfhOJGmhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeHZOeXHZnm/V0ya/e6Afw2KGJ75IsXh88GkkhEFZzqZ6xPzVa
	59myrECDKf0Y6+v68SBBM/OCmHcb6R+kcjF0tDf/S7ZLie+psMjR/hnJ
X-Gm-Gg: ASbGncv2cu8Pmx/ziXdA31vShR0j6blOeZH5ZcxaleOzz4+ePhYMHBGNSUCjrVt/CNJ
	7Ewq/qHFREIi4AHfF6oWcdhyD0Bq8+Ho4VNSQ7ibh/je8Rn45HaymWbdyJqWF3XacjCDwfxz9Iy
	kVxybi6+9r1sX70lClIu46qqJcoOhEqPSPUJXqQtNgMjv8h4m/b2EDgjh51Q/2oxBpCR/pANOLQ
	eg4KyAdIOCz3Ryf0VCY4X47Sut5DuPbq+pWPS0GDZRvsKj5mwx54ODlDTXV38Ojv1TpxQn2IIib
	dEPBvMjyGFovT+YGvnVoLnioGw7I69FHl5Lav0LiHuUOUrFiFlfRQrqsizUQv0cn2FwrbUDKAtV
	/EXE6QEHGkyQhTHZIhmbIz13D6j0TBp1tkpSxk3XG3264SYv4HgH+/liD8HBIPhZE1165JbRDBu
	08H94JDLr5qk/UlACD4I+FgFXutg==
X-Google-Smtp-Source: AGHT+IHYKVM9Wx8GOSPuqIF83Hb6eKY3hy04OhRs1+D0AiReNFfKAOTUse0p3aL4q3fuZ6sU3GCGMQ==
X-Received: by 2002:a05:6a00:1398:b0:781:27a7:dd00 with SMTP id d2e1a72fcca58-7a220a92441mr18548293b3a.2.1761007839788;
        Mon, 20 Oct 2025 17:50:39 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:badb:b2de:62b2:f20c? ([2620:10d:c090:500::4:1637])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff1599dsm9629028b3a.4.2025.10.20.17.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 17:50:39 -0700 (PDT)
Message-ID: <f7024fc31ccc9c8b8bdfe2865cdf3604079e0039.camel@gmail.com>
Subject: Re: [RFC PATCH v2 5/5] btf: add CONFIG_BPF_SORT_BTF_BY_KIND_NAME
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Andrii Nakryiko	
 <andrii.nakryiko@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Song
 Liu	 <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Date: Mon, 20 Oct 2025 17:50:38 -0700
In-Reply-To: <20251020093941.548058-6-dolinux.peng@gmail.com>
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
	 <20251020093941.548058-6-dolinux.peng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-20 at 17:39 +0800, Donglin Peng wrote:

[...]

> diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> index eb3de35734f0..08251a250f06 100644
> --- a/kernel/bpf/Kconfig
> +++ b/kernel/bpf/Kconfig
> @@ -101,4 +101,12 @@ config BPF_LSM
> =20
>  	  If you are unsure how to answer this question, answer N.
> =20
> +config BPF_SORT_BTF_BY_KIND_NAME
> +	bool "Sort BTF types by kind and name"
> +	depends on BPF_SYSCALL
> +	help
> +	  This option sorts BTF types in vmlinux and kernel modules by their
> +	  kind and name, enabling binary search for btf_find_by_name_kind()
> +	  and significantly improving its lookup performance.
> +

Why having this as an option?
There are no downsides to always enabling, right?
The cost of sorting btf at build time should be negligible.

[...]

