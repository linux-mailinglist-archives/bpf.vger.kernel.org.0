Return-Path: <bpf+bounces-68647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042E4B7D458
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDDB21718E7
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 08:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D7630BBAC;
	Wed, 17 Sep 2025 08:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwNRpwp9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611212741C6
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 08:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098614; cv=none; b=TO1xp87PhEuuJ1XHMvGnIVHg8M1Wq9I60ROt2VCJ1XwYLEj9E6pi0YyW2MfokjQ6Nv3csIficAT1tlp0TmMtfrc9Je5hXMprECctxOlPODVuJygHpnYLbGtdgAaSZu6XpOLlrGEZyfrwG0t2WfPhOt4VaPjRp0v8vBcQHgjAuOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098614; c=relaxed/simple;
	bh=eflYWQJP4bsjoSRqaWAcXBwStyHD9Lpq1OdZ7APbfcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jpC+Qj9Jj0PNjEJV3OwPLI6O+XU5stDE3NU9xgoKLoFwWO6xU+j5WU5aZy+tGKwWzHRLz75IloEpdj4ozklreOyUIfHFlAYdw1FNu213FjcsaJoSMQO+veos+SY3/37eJb+q8A0x3d+9bNFLXBB9boUXAkRy5YEMze4gs5GCU+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwNRpwp9; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-62f92a83e7fso378937a12.1
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 01:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758098611; x=1758703411; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3UW9YuMas+HKZxmhflIumNQMYdR1emNGXdYPnd5CmCs=;
        b=AwNRpwp9Xl7yzgC/KKlgPjTGuhM5/LYRC0NeYV4fBes9oqvThAp0qz3BEkn2HHLnSv
         JZhZo16jR5mK0EVTWBNzU6fpM9gw7Znwtqj5sSaxC1ymD7nu466+wZlKaqvQsbDfcm7b
         BM9V2DOVX+8gsNeI78tCLb9qnNtdO7bDsHT+C/2h95Q9iH/qg39+PhbUTdDgkAIvGLiS
         5cCgpPE5prR3nt+nSvf3FewQGbBiX5MVolHcPfOKC0GfiT9gAlT+PDKqM1nY41o0XlzA
         mZJxG8TNuTlIL5CCdgZcYcMqabvZA5VPsMoXrWkNB8MEAGOxBSWWY+jij/ZOY9ulxR07
         eUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758098611; x=1758703411;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3UW9YuMas+HKZxmhflIumNQMYdR1emNGXdYPnd5CmCs=;
        b=TgJtKNa7+hilh/HLO1f+MTXitLYpWofFv+fgSjVHDRYbtsJGvaTAeODniwyS9xvrF5
         44w9R4gYlCmSy6W8aRTCUsSgUXVvfZmpe20dQDrHW2IqkytwU1NLwELjn6ENdae41v9w
         vx7/UHYo+7hrY4k32Piig2TT6FYwJ7Lgy6pK2/J5rJW9CCdYe4LsaBRD3OdkEn6CeP2w
         E3SXU+vOUPoBM4YfrAnr61DREcZyqfTqTksELtIwUJC4DrzsZ2hY9YftCutJ36oO+pCv
         AFsUNbOzeAl9HBDwhDxBLUb9WND3WiHQc6JCOjwS8V+5VeYGHHZ2rP2kTdmGYzq8vnhi
         jO3w==
X-Gm-Message-State: AOJu0YzfzMxmq81KDZpKVEgOL/9qsyYtJoYMZR/0om5BvmAT/zrZF6dj
	qzBKMBqtWl8441ddCpOUwHTLvY0hkJBP8NOEjvaD9BEygE6Eevm+hDN+N99rfFVF+DghujFk4+8
	Alo65AQXGJ6PGffBCkM9XC10lD7tgXnM=
X-Gm-Gg: ASbGncvt5d0BCFnhZlyLKXq3PncYVlMLPwpQnkOtWTtNTflBnhL0/CqSvytESxSaAre
	RHevNbC5M11CqJlOinKDtxdeiJJiXxgkvAZP1DFpHa+z8+1UPF/PCK/sWw3eJqk2TRD6JB0Al+7
	JMjsRpEm9K/UX3IwIPJPy6FaKrtKV/JJxJFHaH1Xxu93grZFKUpFG9Cxny/Yb960F1MmLpWH2Gm
	JSItHUZIKk8Ip7kyD36HrHq5G9c0r6LxiPnQzjv
X-Google-Smtp-Source: AGHT+IFyFn/nEEznsAFAcAZ5J+D4p5/NrGeADxLW2ILaX8tfNJjY7DahL1RCD15/0zDwnvVBPTsxuQ/avt1xvZdm8RU=
X-Received: by 2002:a05:6402:1eca:b0:62d:6601:a6cf with SMTP id
 4fb4d7f45d1cf-62f88dacc95mr1400325a12.9.1758098610412; Wed, 17 Sep 2025
 01:43:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917032755.4068726-1-memxor@gmail.com> <aMpw-yi-dmhox3h4@gpd4>
In-Reply-To: <aMpw-yi-dmhox3h4@gpd4>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 17 Sep 2025 10:42:53 +0200
X-Gm-Features: AS18NWCfY38yYosCUogGWlMuWc0r7v5kdl-8OO8ssnvHDuwrtdMccFRViDDwfoc
Message-ID: <CAP01T76QChfd_vsDgf=q6BvvKXyRg=HfaQehBsGutxtq8KNPSg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/2] Update KF_RCU_PROTECTED
To: Andrea Righi <arighi@nvidia.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Sept 2025 at 10:27, Andrea Righi <arighi@nvidia.com> wrote:
>
> On Wed, Sep 17, 2025 at 03:27:53AM +0000, Kumar Kartikeya Dwivedi wrote:
> > Currently, KF_RCU_PROTECTED only applies to iterator APIs and that too
> > in a convoluted fashion: the presence of this flag on the kfunc is used
> > to set MEM_RCU in iterator type, and the lack of RCU protection results
> > in an error only later, once next() or destroy() methods are invoked on
> > the iterator. While there is no bug, this is certainly a bit unintuitive,
> > and makes the enforcement of the flag iterator specific.
> >
> > In the interest of making this flag useful for other upcoming kfuncs,
> > e.g. scx_bpf_cpu_curr() [0][1], add enforcement for invoking the kfunc
> > in an RCU critical section in general.
> >
> > In addition to this, the aforementioned kfunc also needs to return an
> > RCU protected pointer, which currently has no generic kfunc flag or
> > annotation. Add such a flag as well while we are at it.
> >
> >   [0]: https://lore.kernel.org/all/20250903212311.369697-3-christian.loehle@arm.com
> >   [1]: https://lore.kernel.org/all/20250909195709.92669-1-arighi@nvidia.com
>
> Everything looks good from a sched_ext perspective.
>
> I've also tested this with the new scx_bpf_cpu_curr() kfunc, marked as
> KF_RCU_PROTECTED, and everything seems to work as expected.
>
> Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks for quickly trying it out, Andrea!

>
> [...]

