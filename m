Return-Path: <bpf+bounces-27557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 600AA8AE9FE
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 17:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107EB1F234B0
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 15:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA6D13B5BD;
	Tue, 23 Apr 2024 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeUE1xXp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1357C13B5B7
	for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713884395; cv=none; b=Zmeyg/MZ4S0X3ux3IwVX7XadSCBkLfpbw+QJmhkCuwsK/ZHfRmxC3BzDgnMzBzI91lkm3RsRJchzUUaG106SoNtKd/EIJzccFk8iNzFoEIi8zbMBq8h7gYZ/CJlrP30MFt4i353amnCl9mzuiqe9N3zQWGHxNPkC2WHCMirU0go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713884395; c=relaxed/simple;
	bh=HASkP4fJluQpzkpByDpJebSaWqiPaZ9nycyYk75SYDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A3iaglP3ZcLvJYVsSvmGjApD4hR1gj5GbnsAGC8LIfRmjvuqEylAWSmVmBFpEPPAh7jmrEheX1cDDUFUI02O0ezViXj3ltl5TuG8ssfjGZeN7soVbMQsATwJwnUf/K4oGRRHM4gT2cw3irjth1Wb1SqyTu2PL4BFeZuI7/VK9ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZeUE1xXp; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41a72f3a1edso16957985e9.2
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 07:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713884392; x=1714489192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ChbHvemAdRXJrUFniwXSRa8FQTwtFh09RX119rOBusk=;
        b=ZeUE1xXpACDA7YWswhM5iC2w5IhJ4zJNcLo6Wh9o3HMJ6wbhkPW/ddD87sDJEwuAfC
         Ipi3QBtN/6/z2t7JjivQ5kvBRD2exRbI5Q1nDZm+F8s3Rf7B3lZiw30p4Z0blJ1Zsjfv
         QdF7A3rJcYDgwd+fCxhpROaKvkA+vNMgLOF69OSdKp/6rJw3CjOQXYNv3icHbrLiRzwD
         jMnwi1NIibIK0MEWxEXgSljg+wvkZTh2k/2GvxLmCF9v4y1jK/kcnL2FPSIE4qUYQytg
         DmzkAuv+X3YS0UFBNHc1E8I67Y6YcC8Ie5qPBQ3HiF5R/Pvl3HwxsVczAveOaqa0WgTk
         xFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713884392; x=1714489192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ChbHvemAdRXJrUFniwXSRa8FQTwtFh09RX119rOBusk=;
        b=qnCXpqvoKVmkciAB4YKZCw5V9Uk3zkHICSIoiBAyP0gkuUfmryJ7Q3HlQYRxHLP3UA
         mg80nctad5PONN0j4nPhguOSnIVRmCcshDUwFK40Gg7eP04ET5zUrgLPlLCiwqYmPnDt
         HlAXAcac7kKecIDa/Vb+1K+16mXLr9CGf2Pn8zJR6kU2T9W2ypzld7CSoZG0hMyasjjR
         l8jTviuLMaGuN+gwGaR7i6bT6fuSlOMiD7fngdYGV9UPHmlmkZy0cH4fdJw2+hOfn/cP
         lQuwW/5M0eHg8wsLCer85k7icvkdoC7giQrrA6f/AsF8qcli+N7DemF5qzPvdI+Ad6d+
         D9cQ==
X-Gm-Message-State: AOJu0YwQl/xit0dyKjPPOivPMQniotdNSwEDIs6QYBdA31Kld9+Eu/W4
	brcP4F60jnQyiu6Ikg/axAMN/mX2p6vt5yLf6E+KxA07xCRyT/hTeBNTw+swHGv9XAegZSy5cqW
	gZHtAYNwG5hzbN5LHTgw7OfFEx08=
X-Google-Smtp-Source: AGHT+IG9vQDjI2Qrc6Ps5eDl3X0p8+zdECS0Brdo+WKSoOlJQ8kuLDwcxh0179I5pgF1u8JomiQ0JqN7PFHcVvkUwiU=
X-Received: by 2002:a05:600c:3111:b0:41a:b30f:233a with SMTP id
 g17-20020a05600c311100b0041ab30f233amr1323443wmo.40.1713884392148; Tue, 23
 Apr 2024 07:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423061922.2295517-1-memxor@gmail.com> <20240423061922.2295517-2-memxor@gmail.com>
In-Reply-To: <20240423061922.2295517-2-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 23 Apr 2024 07:59:41 -0700
Message-ID: <CAADnVQLh1edkqBwenLNRkY8sLOS=QeXwhxDtD0TQQ+d-O31Z2g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Introduce bpf_preempt_[disable,enable]
 kfuncs
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Barret Rhoden <brho@google.com>, David Vernet <void@manifault.com>, 
	Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 11:19=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
> @@ -10987,6 +11006,8 @@ enum special_kfunc_type {
>         KF_bpf_percpu_obj_drop_impl,
>         KF_bpf_throw,
>         KF_bpf_iter_css_task_new,
> +       KF_bpf_preempt_disable,
> +       KF_bpf_preempt_enable,
>  };
>
>  BTF_SET_START(special_kfunc_set)
> @@ -11043,6 +11064,8 @@ BTF_ID(func, bpf_iter_css_task_new)
>  #else
>  BTF_ID_UNUSED
>  #endif
> +BTF_ID(func, bpf_preempt_disable)
> +BTF_ID(func, bpf_preempt_enable)

I suspect this is broken on !CONFIG_CGROUPS,
since KF_bpf_preempt_disable number won't match the ID in the list.
The simplest fix is to move these two up before bpf_iter_css_task_new.

