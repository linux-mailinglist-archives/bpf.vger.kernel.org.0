Return-Path: <bpf+bounces-29846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A10918C74FE
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 13:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F06F91F24335
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 11:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933E7145353;
	Thu, 16 May 2024 11:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8orAaoe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E18143747
	for <bpf@vger.kernel.org>; Thu, 16 May 2024 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715857908; cv=none; b=W5zeGV3i3CbPSs9Y+x+y7sFRdfu7b1qPtY+BDlnOXlCiRkRZ5YBlazrBLthL8sYEXmL/8Y1/8G0RyqOd6GHLNk2tydmZ1ITIUzG+xDPyWWWyEoj4UJfleIosBRA34vmw1OtTD8sK+erGfLEULIJ7oURN1I/PvoNFcHAvvFZLYaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715857908; c=relaxed/simple;
	bh=nPho1laorl+T++aIuAWy9Tg1Swupi1tp1ak7kgPwid4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n11STb934LOhuMeY6Ts+3hJ8cwPhTaFG41bB9g3POBUB1yrr+U4vNJzacztQUowv12TUB4RvtIsEBf73dRQOKayxJbrcfGjjDWuYYEGV9Ne8/eQzwx/VO2GsY3SN+GtIXufTpXePe55FrfabeKI6mOT7ZgnL1o1Wt+AFU1LtD/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8orAaoe; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5b2a2ef4e4cso28477eaf.0
        for <bpf@vger.kernel.org>; Thu, 16 May 2024 04:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715857906; x=1716462706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/RbLC/bSVS/cMOam6GioeOsvjLG9BniREFIGISsu8c=;
        b=c8orAaoeVGHeGttOUqqmIxJlBFlzXhN3AkPkyKevlSl/koPNAk3XJZlhPv2l7h2fuN
         fJZjsK89oHTwuPzWIn+UZv1A0WgVgrV7W+90Ca7CvQv0lEW14LE/Usvg4xfmuraG0oQa
         Gsg9njGCJjzdrpFYMUpQhIvlyHBKtmwMkRSMUrrbCt2FZaPGgfNqhNmZGDPu3cweYz7N
         FXSRLinVvd0l8YTIn/Y+7NSm/3gDAZDViSzHgA1WDdWpXSUOMb6amiulL5bA8qb3Y2H9
         Qq0RV5Phg0nQE3/X65G/tNPCIchhaxMY+bN6JhSSac/gInAcgDvhf5ll7pjwupIRn6sn
         vVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715857906; x=1716462706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/RbLC/bSVS/cMOam6GioeOsvjLG9BniREFIGISsu8c=;
        b=g6011xlXKun8ha/6TVRgL3reM9chJRGEt3UZ9fd/RrxRaWnzBW8OfmCfJlWLxWXulr
         tnvs++kVjvXOWH5R8kgpskGqxviS0fglcctxJx7NUuuiKojb2PMOolavkRpyoWI4izgu
         XrKxshvhcYtZOU0CbIhmSuHsRrYR7/bzXFYI620BwWh1rMn15etxcL2lGtL7I/kSRnOV
         ue0Cuvk8hOPYA/yqUVO62bMYu/p2bNyfIgTRRyTXobHVleDwwEzuF3R3tKRPFGH1uJJh
         IFhHC1YZfgfHpC3RG7sSnRHM3eaAv+fgOv99thJHHfvX5RhfV81X1rT0EiZimi33fAVR
         +5Fw==
X-Gm-Message-State: AOJu0YznN9/WKSvMLaTNqkciYYv4BcNtuRKcW1V0ReEP45OLulA9uZ1u
	xu/QhIQhjJhA5lAV3D9ZRNcnG2cBbxivaQ5AL8F3GaEslu77srr5wy/F5zvVXZFMx3Dac1fuef9
	oDkaUpyz8+9akE01yJDyNZD2O7Co=
X-Google-Smtp-Source: AGHT+IH+AcEpN8XNsEKXmGBnxkaYTiSlvvwAEPBK+54Y6uM2ONb5y2mRyQhaT3meK/JvmlCZCfSMsHnsSoKi1lxPjQ0=
X-Received: by 2002:a05:6870:730d:b0:22e:b299:6512 with SMTP id
 586e51a60fabf-24172bab10bmr22718531fac.32.1715857905700; Thu, 16 May 2024
 04:11:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516020928.156125-1-xukuohai@huaweicloud.com>
In-Reply-To: <20240516020928.156125-1-xukuohai@huaweicloud.com>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Thu, 16 May 2024 19:11:34 +0800
Message-ID: <CAEyhmHR616sEaZhCCXj9pa2U5C7jzk+svbYT+xLf2ArL0WZy7g@mail.gmail.com>
Subject: Re: [PATCH bpf] MAINTAINERS: Add myself as reviewer of ARM64 BPF JIT
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Puranjay Mohan <puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 10:02=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.co=
m> wrote:
>
> I am working on ARM64 BPF JIT for a while, hence add myself
> as reviewer.
>
> Signed-off-by: Xu Kuohai <xukuohai@huaweicloud.com>
> ---

Learned a lot from your arm64 bpf trampoline work.

Acked-by: Hengqi Chen <hengqi.chen@gmail.com>

>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index be7f72766dc6..c626df550480 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3778,6 +3778,7 @@ BPF JIT for ARM64
>  M:     Daniel Borkmann <daniel@iogearbox.net>
>  M:     Alexei Starovoitov <ast@kernel.org>
>  M:     Puranjay Mohan <puranjay@kernel.org>
> +R:     Xu Kuohai <xukuohai@huaweicloud.com>
>  L:     bpf@vger.kernel.org
>  S:     Supported
>  F:     arch/arm64/net/
> --
> 2.30.2
>
>

