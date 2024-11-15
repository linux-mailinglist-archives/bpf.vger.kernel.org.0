Return-Path: <bpf+bounces-44902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595169CCFAD
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 01:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 202FA2828E8
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 00:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F4426AFA;
	Fri, 15 Nov 2024 00:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLum5lYb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D9E1362
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 00:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731630842; cv=none; b=MG14t8BRgGONpOvMNCmavYlslw+eEQiDZihq/nEvCVOU+dk8+yvX07jI3cgovEe+wxu3YzlQGiPBNQi5PbeWcWjtcLXRzXxk+rmED8RtiYgiPAXpsdhkImNUizbKPyJ6Eqsc0kOT3Ic6MZBhZoRTT0ItmN2QmKQhU3T6s8bd2KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731630842; c=relaxed/simple;
	bh=hqu4hcZ2I+PjqA0OabepU/J3F4YjsWQA4Sjts2mbUU0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EEF2Fn0xwVFelkQSgyPTjQ0s4JCSGnzIj5b6xf9m4hXO5AjSsQMU6WZ6XabFg2gGkq1ZYkqWUwV/ocJJDbXZ2azaFxKuFlyImrTQhpMw8m1cq6N/jBY8xMamayt0O2S7BaGcb4At/nPBrcbV9+t4e6oAB//6JzRDE8cIgsBbdUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLum5lYb; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e4e481692so987072b3a.1
        for <bpf@vger.kernel.org>; Thu, 14 Nov 2024 16:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731630840; x=1732235640; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6imCGeBnSiZzA+gH8TbsK5/5/C83ulgCBSdkG8b32HM=;
        b=gLum5lYbqKdUnVWLFCYWqhEjG/jmlPJl1lWrIrxfzZVZEt96IxBM2Dyd4EPY7Q4iIF
         NcR3AZbOTaA6OlL4+zIb7qTct5U920l57Ub6ENxw0RCAGtjhzxt86GLkudkTUHbCyaHu
         2E+eFn1zEJXPklcyKnPUFgPNr99gPcBqpoKfz9zMg50sWmhNhrbGLTTEMMdcZf0Hd3KZ
         BUljYb5Qdh/ZQ3frR3vdQXpaD9UTxFYMNbtLXu1gYPoG0vi4CCe5aYntJj+IZYy0aPcv
         dM8LPvy1BzAYeK5F98aYHvxFDtL9y/j0JN3rF6l6tn7buWGKn/+6a/fnMhs/BF2AGvfZ
         GFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731630840; x=1732235640;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6imCGeBnSiZzA+gH8TbsK5/5/C83ulgCBSdkG8b32HM=;
        b=OtL9AI+fCrX3bFjVXl7l179GOPySoOyBRzMMsLDUBE3S1V4DWX4KYLsDYg0Zv/9R/W
         g7UIMqWxglhmF5YDybgRUnDLFl//tm3AeTotL28zdKapQNWkSFR7fQtJj0UwSGYTxmE4
         DbUoJ/7A62z4OKFyUJlcpFOPhXs/J/LXgj6eq9WbdhhU/N3U6XJmwRUZYkWO6zg5bEVt
         IoGpTZHPNZMIkxwKRI4EDMqVlMbyvOGXITg1UhSA1H6e+j1mjoxQUfH2WDpXd2FUMGKw
         HJyPwGzKdCzcEh2DHW6cm2e4/2yYuqGtVdHqCctMxLa0CjEph7uVCSm1Q4sImH3V6Yuf
         4GXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi/2G11g0qj/1avOn/4j56BAXlD49eovgNWTJ3xP8uCOylkqLnrr7WKqBD6/TZ1twvAKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlOhpSR8Wg7G84vICTWhw+NCbyZXDS8+jyfXvsi3o9PfYhBNl8
	skL18PSv7w12TTwuAdT3la44USxTobKHvIhSPgHhoqcCpGFDvnvL
X-Google-Smtp-Source: AGHT+IHHb1s/5JSX/Xd/V1EEs+iB0VLxn0BhjL6vmnuKQMXeJQEAtnnIuhe65aai8NW+J9VEsZCdOQ==
X-Received: by 2002:a05:6a00:1902:b0:724:6bac:1003 with SMTP id d2e1a72fcca58-7247709df42mr1391065b3a.24.1731630840482;
        Thu, 14 Nov 2024 16:34:00 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1c16d0esm231589a12.6.2024.11.14.16.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 16:33:59 -0800 (PST)
Message-ID: <595a43d159bec96fd774c63024038006e8be2722.camel@gmail.com>
Subject: Re: [RFC bpf-next 01/11] bpf: use branch predictions in
 opt_hard_wire_dead_code_branches()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, Yonghong Song
 <yonghong.song@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 14 Nov 2024 16:33:55 -0800
In-Reply-To: <CAADnVQJoRiZXRgzJt6pMFKqsCh93caARjA0hGQ_-V-B0VZ-+-w@mail.gmail.com>
References: <20241107175040.1659341-1-eddyz87@gmail.com>
	 <20241107175040.1659341-2-eddyz87@gmail.com>
	 <0f0cf220fa711f0bd376bdb167c035e53dd409f9.camel@gmail.com>
	 <CAEf4BzYUMMOdfwsWovDqQMgDnd8eGQVEyJLVRvqzmSwsZoW-wA@mail.gmail.com>
	 <d34cbd7bf86d01ecccd70220078a7279756c8ec6.camel@gmail.com>
	 <CAADnVQJoRiZXRgzJt6pMFKqsCh93caARjA0hGQ_-V-B0VZ-+-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-14 at 16:27 -0800, Alexei Starovoitov wrote:

[...]

> Well, I asked whether it makes a difference.
> And looks like your numbers show that this optimization adds 101m to 116m=
 ?

No, it does not make a difference for dynptr_slice:

> > - The patches #1,2 with opt_hard_wire_dead_code_branches() changes are
> >   not necessary for dynptr_slice kfunc inlining / branch removal.
> >  I will drop these patches and adjust test cases.

The 101m -> 116m is for inlining w/o known branch removal -> inlining with =
branch removal.
(With 76m being no inlining at all).

> If so, it's worth doing. I still don't like two bool flags though.

The peaces of information to encode here are:
- whether the branch is always predicted;
- if so, which branch.

I don't think this could be narrowed down to a single bit.


