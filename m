Return-Path: <bpf+bounces-21458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACE684D710
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 01:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 665D6B239F1
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 00:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD033DDBC;
	Thu,  8 Feb 2024 00:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpBSkiAI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1556D502
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 00:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707351535; cv=none; b=NxP2b4+qbqT6rGg0iKAx4qGbq6csO09Z3AMjxnjJXnBU+KDI0YQ63XVxtf947rwDsJNLfMNyw5HBe/tATbfq7SSPaz/fr/rdKuZ4P7YF1ZJ/I9zHA5SPX6gn0mzSE5vOi2JehQficwgZmuR17+++67ki2zLQjNJATw5KZ4+kSvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707351535; c=relaxed/simple;
	bh=i1B/wgohMKaZn5wER/AJEZU6nSH+LpgUYj3xu7rhsT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MaqLhARelMz7R9xpoAYJgkmnQETFIbg7O2oWQysZ4+qDxUyTRWteBrQtsQOovw1IBccmGHMWCR8ji11/ADdBoGDvwyb2aDf0g7BSOBHGLj8igzpXCGo1aMKPNiuSNOt/H0TyGEpfnC3XtDZGCKsydKd4DtHx6BDwW8kXb/Kgdyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpBSkiAI; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e065abd351so700878b3a.3
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 16:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707351533; x=1707956333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRNwMSGsU3CKkU7i8V6rEULPalFRDSo8mb8cbgU2C0Q=;
        b=TpBSkiAIEWoFRwKBvVjM7YYo3JKxa0lE+jsIj8ig6MwHyP3gn6fw/jZhsUMh53Inle
         w1NI1480+xkDKCGkgAOpOqpT6YI/4xGQlQlnAH9y8gJ7rsJu+FtrLQWOPXU+UPH1EYBX
         lfcNnxdL4MNdneRD3J7obFk59VN4p2Ngv8LIx2tNZQ2CMeIjhrgLHo7/4hP1gkGOuxly
         uc3UtpzurYtQfqsvza6B5VzpniN7uhvcJfi0eaprDQL4CW7XtUTsvJkwyatiSnzVRDn6
         WutpwLQobtK7if2txk46l6kc0zSRnvpoJcz4q8C1FWieGvLujwOuB5jqwkZ9JvfgGwhQ
         6FwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707351533; x=1707956333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRNwMSGsU3CKkU7i8V6rEULPalFRDSo8mb8cbgU2C0Q=;
        b=K8tsbA1cI7lm/IYO/boKY3jeEpSYctV9DixQ84JH/ycR/APF2PTv3U+EK2IpDhTM0c
         aIKcT2R3/f/8Mm3SiXTkmGWslHRb8rSbIwu87DJianogM2+LLjngxHAfl8L8HMzJyQFT
         63k5Q67A2U1cjdjlusjNZN01MTIS7bVpNrOHneOFv5NT2W+a1pncbWrndgTegh/EK07a
         o8BC9Xk9DiIj9xYlCusJrODSdBHd85XClr9GDVuwqU2rh0Au7s60IXaj/Mp2MtxCqEM6
         3PlwckgcguI1CxMl9EvyfX6HeFrbUUMn7yv0VgYGPfuQ9pxUu3RkoXftRjV9+4go5MV5
         ABNw==
X-Gm-Message-State: AOJu0YzpaIiH8MEgpF9lBNSRmedgtwLx8cGCvk+QYwaJaEPZ3fLGULbP
	VUCeokAI3lNvCzXhPCbFJvb36SVBLspdV1vF8LJ8k8oEnv3EysdjPhR0enmOZ7qS4C59aNWOggD
	Hj6WSJV5K1H1RAcROnO5mtfSfwPY=
X-Google-Smtp-Source: AGHT+IFegUNKRrOG6xHJCfStloqEorc5HncYh2dWIi+k1ygc4URlssu0yiVxC+OvizjU6h9x+4G1s/tIx+bap4Ja9UI=
X-Received: by 2002:a05:6a21:398c:b0:19e:99fd:2946 with SMTP id
 ad12-20020a056a21398c00b0019e99fd2946mr7564157pzc.2.1707351532936; Wed, 07
 Feb 2024 16:18:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206081416.26242-1-laoar.shao@gmail.com>
In-Reply-To: <20240206081416.26242-1-laoar.shao@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 7 Feb 2024 16:18:41 -0800
Message-ID: <CAEf4Bzanbs0dO1jvisuw4X1zk-6P0YRZO2sLAtXaCLuaZKpnxw@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 0/5] bpf: Add bpf_iter_cpumask
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, tj@kernel.org, void@manifault.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 12:14=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> Three new kfuncs, namely bpf_iter_cpumask_{new,next,destroy}, have been
> added for the new bpf_iter_cpumask functionality. These kfuncs enable the
> iteration of percpu data, such as runqueues, system_group_pcpu, and more.
>
> In our specific use case, we leverage the cgroup iterator to traverse
> percpu data, subsequently exposing it to userspace through a seq file.
> Refer to example in patch #2 for the usage.
>
> Changes:
> - v5 -> v6:
>   - Various improvements on the comments (Andrii)
>   - Use a static function instead as Kumar's patch[0] has been merged.
>     (Anrii, Yonghong)
>
> [0]. https://lore.kernel.org/bpf/170719262630.31872.2248639771567354367.g=
it-patchwork-notify@kernel.org
>
> - v4 -> v5:
>   - Use cpumask_size() instead of sizeof(struct cpumask) (David)
>   - Refactor the selftests as suggsted by David
>   - Improve the doc as suggested by David
> - v3 -> v4:
>   - Use a copy of cpumask to avoid potential use-after-free (Yonghong)
>   - Various code improvement in selftests (Yonghong)
> - v2 -> v3:
>   - Define KF_RCU_PROTECTED for bpf_iter_cpumask_new (Alexei)
>   - Code improvement in selftests
>   - Fix build error in selftest due to CONFIG_PSI=3Dn
>     reported by kernel test robot <lkp@intel.com>
> - v1 -> v2:
>   - Avoid changing cgroup subsystem (Tejun)
>   - Remove bpf_cpumask_set_from_pid(), and use bpf_cpumask_copy()
>     instead (Tejun)
>   - Use `int cpu;` field in bpf_iter_cpumask_kern (Andrii)
>
> Yafang Shao (5):
>   bpf: Add bpf_iter_cpumask kfuncs
>   bpf, docs: Add document for cpumask iter
>   selftests/bpf: Fix error checking for cpumask_success__load()
>   selftests/bpf: Mark cpumask kfunc declarations as __weak

I've applied patches 3 and 4, as they are general clean ups and
improvements independent from the actual iterator implementation.
Thanks!

>   selftests/bpf: Add selftests for cpumask iter
>
>  Documentation/bpf/cpumasks.rst                |  60 +++++++
>  kernel/bpf/cpumask.c                          |  79 +++++++++
>  tools/testing/selftests/bpf/config            |   1 +
>  .../selftests/bpf/prog_tests/cpumask.c        | 158 +++++++++++++++++-
>  .../selftests/bpf/progs/cpumask_common.h      |  60 +++----
>  .../bpf/progs/cpumask_iter_failure.c          |  99 +++++++++++
>  .../bpf/progs/cpumask_iter_success.c          | 126 ++++++++++++++
>  7 files changed, 552 insertions(+), 31 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/cpumask_iter_failur=
e.c
>  create mode 100644 tools/testing/selftests/bpf/progs/cpumask_iter_succes=
s.c
>
> --
> 2.39.1
>

