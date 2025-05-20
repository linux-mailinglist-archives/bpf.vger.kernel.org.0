Return-Path: <bpf+bounces-58598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C33ABE46A
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 22:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E38B14C3D6C
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 20:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECEE28BA8E;
	Tue, 20 May 2025 20:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXbNcgnm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E16C28B7E2;
	Tue, 20 May 2025 20:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747771411; cv=none; b=ExaWSTrbPJ7aW7Jukk86N7Sc4eQE4DNIxx7t0xm6Z7ydMrlQLxV1GAbR1vPB0NihgP9SY+Cmn2M9aYN9MociFHisEzese3+VyapyGhzN8cFUdjpV2V9+Gzrb5W95Ulp15nFAmyYP4CGDr9ZOULCAT+KhNMWnArrG9loHJcBi/8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747771411; c=relaxed/simple;
	bh=2HYhbiHb2XoWoAfDUtEGjn3tNCnYruH5jj+WyV0G8Gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HlrPRpinzBkUY3ftDFP0y+tczQQ52KWL+o2omSmrNvb/Az41pmiX3xCGPrD7waoYEOj5cJMgzCw2TUH224Xf1fuy39CZURBLDBOahjg3dyEgOon4yIpf9FI06Mzq4LLj5gQT1RKRbUCkz5sJ4w03eSs7KixA8COc3N57OmAuBKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXbNcgnm; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a35919fa8bso2388118f8f.0;
        Tue, 20 May 2025 13:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747771408; x=1748376208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efW8uysczGex6hW+spLMTyQsWR2cZo21SL4v7Rmzuu8=;
        b=OXbNcgnmqbb2Omfk2KmEzk4XJyoOkNsc+RfAByuNwkZSC1LfoWySbGUTpaqJhN35BE
         ldykTrViudPstqz1eTqPNnzuOooy5oeH2lRV2ZtyyZPO5KpJnsVExauUSlRspibqaAy+
         2xmejmDFTBueec8KmlqxQsm7v8pQD4/Vrw7gMxZEhGJVp9x3wO2zx0xl9iZ29mznb9RL
         +RnrWsUBfi1IP+GFTtgAMlWLluTNqwHcYIUQ5t/5s9edBMtjQStj/9Xzem0cOpBLogr5
         W7N1hdavxzgiWHADggQp/P4sGkmHYYbM3rAhVgKhrsxamY2YmsPPPTeFAnYqUAjA5pPU
         5OIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747771408; x=1748376208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efW8uysczGex6hW+spLMTyQsWR2cZo21SL4v7Rmzuu8=;
        b=H9UIzA8f3m4Q/9DoyqZVot4jo6p9YYvraVrvGzIyhq5oVJz8MV/t/Tt05skFe2YWMi
         qTbFcm3F5AbUetypb/b04PG98nYZvz1C2UVMx//uqjS+roOjlWvgnZgbePxDPotKkeqm
         Wgzzjl13swZekACWmMxVV/SdmJ3wLprwC7e0rTtghkp857z7wsPcQTmXJd6UBvxUMuCh
         1M3kMyGh1tt03w4tR9N2Le6Y9+SfNoS+rbCJrYYD3DnJ5auLiGPDvPZDTEJOOIJEPUeB
         ks3FGkfI5rul9k7urIEwlxOmkS0+GhcZiD4ZW9kRJHIanuVtuLNuGpcCzsegeR+tzY9t
         +3ww==
X-Forwarded-Encrypted: i=1; AJvYcCW3w1pAd8OSBkUtg5+WX5V34u7qN7MmlbbQudNtS/he62FdppTFt/Gcsonv/ctRWZoU/gSKB0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMT/2oRRWRkGzIXTsTvcSY6wps3pcb36Gx8NfuiV68ma43jS+V
	wMHVWx7hR4cAk3ZJu/+LKSBnbOssmsACthxEZZqXa6AzGsPsMi3YjWGv4WlCLK3F3BfUggQkwd3
	z05VRxXx8q2NXQshZ973c8zNLDuMip4k=
X-Gm-Gg: ASbGncuDA13G4cJHrcRtMIHqS6lSmWuDgHHsmYs6OGOl6FRObhpTIJPeZZvBOO9ARr5
	9TP/Ag5awbM+6UXLCE+AeHBMeOp8wukMzDeW0J8zzvMH/di7/3aS6cckLZm8BLiQBeRWZuV7LHa
	Kr71CE7ZRNwXovUBbfo73njWNx5U7t5eLv2ESblC2ycdFBB9nu
X-Google-Smtp-Source: AGHT+IEoTEdgo/VZ7BexTeV1e7wJP8zj0jV6Nx6pv44QYGhoFhYCaYo1BU4xB4UXOLMIwp0ZIDLxFGN/6UQxeRA9KP8=
X-Received: by 2002:a05:6000:4284:b0:390:df75:ddc4 with SMTP id
 ffacd0b85a97d-3a35ffd2864mr16194568f8f.44.1747771407412; Tue, 20 May 2025
 13:03:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515211606.2697271-1-ameryhung@gmail.com> <20250515211606.2697271-2-ameryhung@gmail.com>
 <CAADnVQLPyHnqEbPowpN+JuMwH+iMX4=dZZu2chMaiexwAVxxJA@mail.gmail.com>
 <CAMB2axPpAdhkc0wvHY6VEKjRKti_85MMPo2eJ07T2w+kgV3YjQ@mail.gmail.com>
 <CAADnVQK30M9+eJz8OjFpteGXfpF6DoQqNxXJa3p5YGmxyG7xJw@mail.gmail.com> <CAMB2axOdJPakK3=vNXYXoUUji3wfO-HT5j1j3ox3Z=QKK6=X3Q@mail.gmail.com>
In-Reply-To: <CAMB2axOdJPakK3=vNXYXoUUji3wfO-HT5j1j3ox3Z=QKK6=X3Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 20 May 2025 13:03:16 -0700
X-Gm-Features: AX0GCFtEjtGsIsO9DeKRO-2TFKQiupeFZ8tSnXA2dprcGDehsJmzv7c2-Yje5ww
Message-ID: <CAADnVQ+JzFM0D9aknYqPYL7TSvVPQ7cV9iYF7pYyf75hRokLmw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/3] selftests/bpf: Introduce task local data
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Tejun Heo <tj@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 12:37=E2=80=AFAM Amery Hung <ameryhung@gmail.com> w=
rote:
>
> > Then something like:
> > #define tld_get_data(tld_obj, key) \
> >  ({
> >     void * data =3D tld_obj->data_map->data;
> >     if (data)
> >          data +=3D tld_obj->key_map->key.off & (PAGE_SIZE - 1);
> >     data;
> >   })
> >
> > size is really not needed. The verifier sees it as one page.
> > Bad bpf prog can write into the wrong key and the verifier cannot stop =
it.
> >
>
> key.off is a variable offset, so the verifier may assume key.off =3D=3D
> PAGE_SIZE - 1. If a bpf program tries to dereference a pointer
> returned by the proposed tld_get_data() as an int * without bound
> check, the verifier will still consider this a potential out-of-bound
> access:
>
> invalid access to memory, mem_size=3D4096 off=3D4095 size=3D4
>
> I think if there needs to be a bound check anyways, hiding it
> tld_get_data() makes the user written part less complex.

I see. Yeah off < TLD_DATA_SIZE - size check cannot be removed.
I was hoping to save an extra branch. oh well.

