Return-Path: <bpf+bounces-75519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A039C878EF
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 01:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC4614E0F39
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 00:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F14D8F4A;
	Wed, 26 Nov 2025 00:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiPU4F/8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F3036B
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 00:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764116045; cv=none; b=JWbML1SIAxi83MP2/FFuM/xaoBZaH/XQPjEZJHiW5IY/I+tNlczJ5xvlJ3Ner+vYkPCmNuYJS+2C6G4gFnuwiKI+iCqTzJaj5jN3FHoMcs9QK+BopstM164iUg7GYVl2Cssr3VliuLkU9bQ97h2G7eZm/wvRXEbNtrntwtTgO6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764116045; c=relaxed/simple;
	bh=kWCRRQTEaZU6WxlK3MUwK+2yGBzKdMCQVc5EIhBZiLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZTHI474NNbBMLkw4GNfz686bB/laYnCBMlx7OTGr3XHHdUKhNNQ1HTlDfEHAHx573YVHoXk5Td9Qld+N4WpLseyNCc2rcoyqzKCejCBatIKeztfNLiZGVMV0qxc/XKJI38Jell0cRIvbhiK/ZW8g15xxp28woIPeCg3h/8+OAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiPU4F/8; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-343dfb673a8so6009158a91.0
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 16:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764116043; x=1764720843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Y5BnbMRUPkIWgOQRXlfqICk/Wz700YQXtgsPfDT9Z0=;
        b=kiPU4F/8dgF0mEQgv2WqCbFrIQrFrKnhZA9v8A+MBiKymy62XiMwou6VXBsrBxEMuA
         wHyFbvYawxDr/SMF2dD9VOmVzsi160OMIk/FVSLZaDQipP9rndBnxYK2FuctM9H2Cird
         TcIXuMRlztnPIf4iVA9ZKTlJk9YDwK5PkGXWz6M1QZxYm1CAhheQMh7hJKNAD/zw2auR
         0KwWxCmDgZwNUZ8HUiP7mg8qIZQY44rYYLxuAOYPCMhlOPFZKOp8FfYGuM8DOLvxm2qd
         T/ZCxUQseOvK/FsVlaluNPR5rS8/BCc/B8EXmywQvn1ffXGTLLua343DgbTQz3WVJp6/
         xTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764116043; x=1764720843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Y5BnbMRUPkIWgOQRXlfqICk/Wz700YQXtgsPfDT9Z0=;
        b=B/Q46+XtGz4VY63q5chsIQuAJpuX+PVClRXf5hjCgdc2sDb3UxO2mk3+mbwP6QKWfC
         +sQKwNyYNQTcDLAr6ySCHJNcczz1kTJIG5xKnXcnRI4N9jlmr2qILtiRvZPwL1gGw5FH
         l9VuB40vE8LRWm3kRA5skVle/Ejn4EoGSsWzX1Rj/kVgbu1+fJG89ScUHnLxZEt9IILX
         RfOb6tWYAzVXF5jw9jZ7iBddd0BQfdo8pbN4ZlUAb6O7kqZMp4/eVtGEQCOniPZZ4Enh
         HjDzVpc7w0e6+M3/T6RkUtR4YCThkk41UyYGrHPOheRrfgDsjbdow7Mtm4CjpWvajTYD
         POdg==
X-Forwarded-Encrypted: i=1; AJvYcCXeecyiHv6BoT9v2nUvBNOTJO2zZ2nITTMUZhfTjuzhpjv+gBm44PlvIvqBqUC9zXGbq5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj//tIu6EkB6F/ukVVDffR4iqf6Jxf+H5RF6EnMmc9CxGWtw+m
	KNI/5EKb38GqlYfFA/3Gl0yE/XDq9alnBrHkTRr1F95FRUVwe2QW4DQgJZ7FotUWv1hEw3SKlQf
	qfgPsQekcdpH6fOjJBrKfPlJkRbri2Go=
X-Gm-Gg: ASbGnctSlJk5pw4xYAOdxWHvKBYYOLb9Ptrh/hWP5zQ3+yndqkHeK7YCKNUS3keAi1N
	o7/yizLiV7Y9h4kgue+mg+LdmkKx8L1CaeLvGBeJ5owDMfOK6h0mFyHUy0BQPpn0DfsmiU98yOG
	7IzD2xQ6LVKHAiQqrCRgnhKWDi2DCcZZTrbpG5S8NGHZK0dsGGEJu8+UplPGH1sMRmHjZSIty6Y
	k16Fr+G7NMEX+RsFaS3SKV9sOtTMm2SIl8xTaJsXRnNRjAhOi/6zocqkJ99tF9bBf4AbQSsLr1V
	dnttCOlx4xkQviRT+Zjs/Q==
X-Google-Smtp-Source: AGHT+IHx3rknQb71zAr9KAq/DMcw6zGzf7PPA/SvuP16OAZ8rflD+8ITT5+GBl2JNBPEqZjVZzz2Y0n4Cbmg9lyJass=
X-Received: by 2002:a17:90b:38c7:b0:340:ec6f:5ac5 with SMTP id
 98e67ed59e1d1-34733e55021mr12871993a91.2.1764116043117; Tue, 25 Nov 2025
 16:14:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118033025.11804-1-jianyungao89@gmail.com>
In-Reply-To: <20251118033025.11804-1-jianyungao89@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 25 Nov 2025 16:13:50 -0800
X-Gm-Features: AWmQ_bk53qL4HtGHz8tQ5jKRxVXJd3XfKvU7Fl2sFlLXvac9YuInUKdax8aqiTQ
Message-ID: <CAEf4BzYevTS3_BRutFF=AcNtXROQn4d95jg6seQCMpxqpzqdMw@mail.gmail.com>
Subject: Re: [PATCH] libbpf: fix some incorrect @param descriptions in the
 comment of libbpf.h
To: Jianyun Gao <jianyungao89@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, 
	"open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 7:30=E2=80=AFPM Jianyun Gao <jianyungao89@gmail.com=
> wrote:
>
> There are some incorrect @param descriptions in the comment of libbpf.h
> file. The following is a case:
>
>   /**
>   * @brief **bpf_link__unpin()** unpins the BPF link from a file
>   * in the BPFFS specified by a path. This decrements the links
>   * reference count.
>   *
>   * The file pinning the BPF link can also be unlinked by a different
>   * process in which case this function will return an error.
>   *
>   * @param prog BPF program to unpin
>   * @param path file path to the pin in a BPF file system
>   * @return 0, on success; negative error code, otherwise
>   */
>   LIBBPF_API int bpf_link__unpin(struct bpf_link *link);
>
> In the parameters of the bpf_link__unpin() function, there are no 'prog'
> and 'path' parameters.
>
> This patch fixes this kind of issues present in the comments of the
> libbpf.h file.
>
> Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
> ---
>  tools/lib/bpf/libbpf.h | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>

applied to bpf-next with some minor adjustments (which is why
patchworks bot didn't send notification)

[...]

