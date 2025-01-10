Return-Path: <bpf+bounces-48498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FADA08480
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 02:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D26E63A36F3
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 01:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F143674E09;
	Fri, 10 Jan 2025 01:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rM4rBWUz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8AB16415;
	Fri, 10 Jan 2025 01:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736471329; cv=none; b=UjbkED96+XYd4cxZ6EjZvJ6wL/+wyQExdWYEcg9IqDPfiiqw9isl0TKh94rqG0WXYsR2i/2LNZWECWvc9nsSzXTSF+ttNwivh//uPUKDsl+gMHx2K3ljk8nGiVrd8DanpqnW0gZ6w1WeZxlFk6MD6x8gptfp8r/aWMbIb5JDFMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736471329; c=relaxed/simple;
	bh=RDlqjCiRkkhK/e38jPlhC2wBfRvBVv4rxLWm2ebzzH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vd4OqY4JAaMa8BV4ccM4fZcfM+y2At2DBiehSu0JAD2wXGXcZm8vs9Q6zw12ppdezJ5h4U6tTkl3t8uFvGNidcuHAO3Ct0/r4e3hd645rPgRqoKIZpyFygGBdd6rfrX1kXDs7r+EiwzIw2LxaLAE2FrdQxMoaKtuOYBzMqmcJnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rM4rBWUz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF72C4CEE8;
	Fri, 10 Jan 2025 01:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736471329;
	bh=RDlqjCiRkkhK/e38jPlhC2wBfRvBVv4rxLWm2ebzzH0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rM4rBWUziqdHxo6S85jbJLSwtn2qimrDA/ey8WD+OMhNRDiI2jnI1msxgh6sH7gXG
	 z39uHuQM96kKrtv1GIvnXp6kmTnVDEoKvBp7W5vigLkqspWfU21e0oPutT3s/LmkdU
	 oLxiyaEGp4R3CVXKraVJab3U5yuuR4SeCYNAMS1vRw7mMhUj9/rHZCuZCM0tXRrZvM
	 4go5+7zt+j3aPcAIr7D0xvK3l3cyd/iX4juFmpEN1PCHUdTVtRrijpW+qQ4HBBbdbu
	 LShFdSeWZb324ni5p1NjEhsrKrnl1psDkddQ05tLfgZKAUGPTqtohBQUjzVdlNvp9e
	 w4n4VYREVL0BQ==
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-844bff5ba1dso102077439f.1;
        Thu, 09 Jan 2025 17:08:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV/4nHMtwWDibXT3D5I10P4DHpqqe/7+uAb6oS8fwPHh+zT5KRhbuMFg7t8pkviAisAfs227PXlQzHwMCXbdqECZuNXkCGB@vger.kernel.org, AJvYcCV2+vPo33ytvj/vP7wEgyukINGfjDEaoGItlIlzNjAUrCvCuBe0hTfQPF59kjj6J9iIpaYhBzhFbjgyW64=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ66zkTxBLvCOLD1ArnRXMZPHHQHzdsHpEWpzXGrBkuZ55Ph3R
	6qqDr/3cBArkP0ESCzfk9/5eqzDC/FKiXCu4Wgnj/q4pA0ncc/1kQKfEse7kSGqVD+UQYoUX6DG
	bCuPA5XlV0EFQ3ItmZxbU9OeODk0=
X-Google-Smtp-Source: AGHT+IHwCjHrEBvPJ9mfelms1VvOaRKWT9lW3aZg+HHZ2TzuKAAbCpZy0/k6TLVbPjOLJXhYF16+oVDszL1iQp+hORI=
X-Received: by 2002:a05:6e02:1f02:b0:3a7:c5b1:a55e with SMTP id
 e9e14a558f8ab-3ce3a7a8aa1mr73496695ab.0.1736471328212; Thu, 09 Jan 2025
 17:08:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108225140.3467654-6-song@kernel.org> <202501100757.HDb5slrv-lkp@intel.com>
In-Reply-To: <202501100757.HDb5slrv-lkp@intel.com>
From: Song Liu <song@kernel.org>
Date: Thu, 9 Jan 2025 17:08:37 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4xKCeZ9GoeVHx47GiTbwCU=b7G3orkcULOq7aH5TKo9Q@mail.gmail.com>
X-Gm-Features: AbW1kvZcu9TPeqs5A-WIrB4rbn26UVknvaDOrBfZ5EuYERQQUajjnAMrLj_wVw0
Message-ID: <CAPhsuW4xKCeZ9GoeVHx47GiTbwCU=b7G3orkcULOq7aH5TKo9Q@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 5/7] bpf: Use btf_kfunc_id_set.remap logic for bpf_dynptr_from_skb
To: kernel test robot <lkp@intel.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, oe-kbuild-all@lists.linux.dev, 
	kernel-team@meta.com, andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, kpsingh@kernel.org, mattbobrowski@google.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 3:56=E2=80=AFPM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi Song,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on bpf-next/master]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Song-Liu/fs-xattr-=
bpf-Introduce-security-bpf-xattr-name-prefix/20250109-065503
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git =
master
> patch link:    https://lore.kernel.org/r/20250108225140.3467654-6-song%40=
kernel.org
> patch subject: [PATCH v8 bpf-next 5/7] bpf: Use btf_kfunc_id_set.remap lo=
gic for bpf_dynptr_from_skb
> config: i386-buildonly-randconfig-005-20250110 (https://download.01.org/0=
day-ci/archive/20250110/202501100757.HDb5slrv-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250110/202501100757.HDb5slrv-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202501100757.HDb5slrv-lkp=
@intel.com/
>
> All error/warnings (new ones prefixed by >>):
>
> >> net/core/filter.c:12071:1: error: return type defaults to 'int' [-Werr=
or=3Dimplicit-int]
>    12071 | BTF_HIDDEN_KFUNCS_START(bpf_kfunc_check_hidden_set_skb)
>          | ^~~~~~~~~~~~~~~~~~~~~~~

Good catch.. Fixing this in v9.

Thanks,
Song

