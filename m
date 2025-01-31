Return-Path: <bpf+bounces-50241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B648A243BE
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 21:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0D7E1886897
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 20:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5B4158862;
	Fri, 31 Jan 2025 20:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUEA3B3m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1108482EB;
	Fri, 31 Jan 2025 20:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738354738; cv=none; b=OtSLl8BVziWt8ijYOc9QmBn8TKzjJ/AuSXnckgoQ7hvEEdQzKIjSs6UoDqnjsuwGvP5jPSgfol9iii4LTISTRJITQTPbpx7D1Gh1ZfZSh5Ds8A7kdB7CA9uummT4RJOw6ynbtDpO7nETkppCYGDoKOoPZS9RUTva2VQ1POwIuvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738354738; c=relaxed/simple;
	bh=9iyCxa6T53JFSusqOepaP2jo/AqvjSE+6oMhgF7dcsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iz3Qi6+CNa7X6QYaTwddlNlFPrW+1TSxgFWGG4DlUwKKMg3vxRzjiJlSJR00u4my8aUSORdYQBQTlcx3HRny5NspcSV1t6+7t8zmSriYfnn7hAHxD9hNDspQ1UO6o1X+2+Npy8ZrOnTx1q7Wk3rgpNHQ7plf7S648IkrmWaroAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUEA3B3m; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-51eb1823a8eso562448e0c.3;
        Fri, 31 Jan 2025 12:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738354735; x=1738959535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpRiv6R8lU1uWElWUJOCifYXqYBPsYBy0gETLZ4uHsk=;
        b=OUEA3B3mxBZ9twr0u4Hpjk96XNi/eksir0FRl5eTLLmPLELg7MtB1BJUue4fSx/FXe
         oltK74Ye6kZM92MmQaqYeNCuR6p019g3ueChUkU3rKv1gdp6yZNUhrV4MKfi1Jyo3HLC
         60VY2XdqQqHtVp4FULQJxds37Cw+Z+pnykjff36gdXtF0OZcHEyEgJ/lLMJJzzufQPXU
         BGzHDo/L6TEsXqf2gU39UZEDqakbVhaCK8QvGmxYEjh/wDy+LccA+4xk7uxJTO2qEpbG
         ukJ1BlpGaduhHtyF0+if/IYQqcyr5i2LrLl3ap8+fiAFUQi6xUP3utDlaT8TCCNtkO0T
         i+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738354735; x=1738959535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WpRiv6R8lU1uWElWUJOCifYXqYBPsYBy0gETLZ4uHsk=;
        b=NSadlsufuWOjo7BxH/tNN4UQ1DGAVtH8BpKB35u4JqQh857v9XNZoSytIe8dIgH0jq
         d/Xcm0rkiMtDNqL1C41j/cAoGiF3fzlO3hO0JGPLcDXHnuJXLxzetQ05Z5t2K2f/iLCy
         MMrN1Vx727BnN3OFQysqmunqCWPBfEMwmOD9FII+c7eWpLOnUSycv0hpAd9VbcsFsia8
         vR5Cd6N7mTydsW41AlbOYhWiu2COqizobCNf4cBe1vqDmg1T/GhzunWZZXT0bOFpHhox
         LMMnCSMeDDh0Tmc5QQ+vw7+hdf+oqVRhAojkvAUHFY2Eh0YNNMFF0jGbzzYLgFbFKFfD
         xWLg==
X-Forwarded-Encrypted: i=1; AJvYcCV2ggyJhQVD/p28w4i4pPjiMuf3WTHE0aweCq6cY/wklFW+4EYaucJoAllv/YqjCDSA1wG2jdkVyA==@vger.kernel.org, AJvYcCVuoeuIEaYMRXRJivf3gLLoMbgq7B/3MOthUjHXV5vYaYZt06uQkGcpLHV6T5K4n6DDsE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxQPZDb3yDWMnKGexISempiT6Za47bHnH6a1AgwrYx/jH0kGiW
	s8YCWj0+KFlxWBd4W8/F49zu0mgmK9M1Tkl1+E5m3TwPKVpUc8wIanGIICziyNO/nw3DWbrf7bc
	K6gXdawgM6LlyCww3BQrAoSYe5vU=
X-Gm-Gg: ASbGncsANy8ds4qoiO9SOlmmK8A86cKdsJzAM+vKQ6zZRL7SNOP/44R2nGVCwP+Gmxz
	d3olP3Ma8Nnnu6pBDKY0aKXPo6ziv2pHJ+1vJRXDnaz+9iUmOnaM7ag7j2Q2AHkGFQ0DkKfvWZK
	oCbMGOZT+pxOh8fieeW6lVie9fyau0MA==
X-Google-Smtp-Source: AGHT+IF60xD8+TRvnIjF+jNxXFU3emak0GzTRBeuOiC3FNUOTAmabFCfSNxyG7dGYsG09pNnu08yXGIuQ0vYC14fAIs=
X-Received: by 2002:a05:6122:400d:b0:515:ed1b:e6dd with SMTP id
 71dfb90a1353d-51e9e288660mr10395413e0c.0.1738354735483; Fri, 31 Jan 2025
 12:18:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217103629.2383809-1-alan.maguire@oracle.com>
 <CAM_iQpXGzy5ESZ3ZE0Wo_p_pkXYbgMe3L8stbBcBCo+oJuWimw@mail.gmail.com>
 <CAM_iQpU8jQ9yEs_rAf2gdyt5yie7BwkiU4vpa-efF6ccVo5ADg@mail.gmail.com> <54ff082d-5409-4fe6-b711-b80fdedd751e@oracle.com>
In-Reply-To: <54ff082d-5409-4fe6-b711-b80fdedd751e@oracle.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Fri, 31 Jan 2025 12:18:43 -0800
X-Gm-Features: AWEUYZlUiKytPiEuHMBhw4PEp--GsEz5z99q5Y3fWSNnKEE_T_W8xvzUsR6T7I4
Message-ID: <CAM_iQpXg71K-t4sOYYF47qsPRrgTU45p1faLHBNhBWjXUAZgOA@mail.gmail.com>
Subject: Re: [PATCH dwarves] btf_encoder: verify 0 address DWARF variables are
 really in ELF section
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, yonghong.song@linux.dev, dwarves@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	song@kernel.org, eddyz87@gmail.com, olsajiri@gmail.com, 
	stephen.s.brennan@oracle.com, laura.nao@collabora.com, ubizjak@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 3:17=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 26/01/2025 20:04, Cong Wang wrote:
> > On Sat, Jan 25, 2025 at 8:55=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail=
.com> wrote:
> >>
> >> Hi Alan,
> >>
> >> On Tue, Dec 17, 2024 at 2:36=E2=80=AFAM Alan Maguire <alan.maguire@ora=
cle.com> wrote:
> >>>
> >>> We use the DWARF location information to match a variable with its
> >>> associated ELF section.  In the case of per-CPU variables their
> >>> ELF section address range starts at 0, so any 0 address variables wil=
l
> >>> appear to belong in that ELF section.  However, for "discard" section=
s
> >>> DWARF encodes the associated variables with address location 0 so
> >>> we need to double-check that address 0 variables really are in the
> >>> associated section by checking the ELF symbol table.
> >>>
> >>> This resolves an issue exposed by CONFIG_DEBUG_FORCE_WEAK_PER_CPU=3Dy
> >>> kernel builds where __pcpu_* dummary variables in a .discard section
> >>> get misclassified as belonging in the per-CPU variable section since
> >>> they specify location address 0.
> >>
> >> It is _not_ your patch's fault, but I got this segfault which prevents=
 me from
> >> testing this patch. (It also happens after reverting your patch.)
> >
> > Never mind, I managed to workaround this issue by a clean build.
> >
> > And I tested your patch, it works for me with CONFIG_DEBUG_FORCE_WEAK_P=
ER_CPU=3Dy.
> >
> > Tested-by: Cong Wang <cong.wang@bytedance.com>
> >
> > Thanks a lot!
>
> Thanks for verifying the fix! You didn't happen to get a coredump or
> backtrace for the earlier segmentation fault by any chance? Just want to
> make sure there aren't other issues lurking here. Thanks again!

I didn't. I guess there was some mess in my build env, since a clean
build just worked.

Thanks!

