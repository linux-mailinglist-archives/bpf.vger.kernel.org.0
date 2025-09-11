Return-Path: <bpf+bounces-68190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D519B53DB9
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 23:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DADDD1752E6
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 21:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE8B2DF129;
	Thu, 11 Sep 2025 21:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghMfx6fj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233EC2DEA7B
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 21:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757625990; cv=none; b=fwPtSSkkpAchZDSjjDulATGvTla4th2T4AEo3SkwPAPj+okxx8WgtSRsujyMwcUM7bwZDEPSKqwTe4yvjh2qZkML9XoFgjHS+hHt42+z8J/kuyJIngGxfrBAiDqa5rmgVWxTsJfV8vZrl8S5poaiPQ5FYpVq37Khq1Pwm7ZarFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757625990; c=relaxed/simple;
	bh=sFo11LJDFbgdEzVFkudN41eUwSXYsUo78kBXh07zsiw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tR+Tt4osn6gttpipQR5clfGN/KTiumBGbo58YI70h1kiBOiPOVFw490bbRu3o0W1A8MZOTowjS4PMob1opjAxAhzR0c90bIyKphA/sKzBn1kjDsJRvt2mgPNay573WfR4orDkpIJiODpzU+G+tQCLQGiTdb2BGJhvnxDhDCQL4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghMfx6fj; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2570bf6058aso16421675ad.0
        for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 14:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757625988; x=1758230788; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EjquTq5MAgSVrD6End1v2/eMfRkFt39jWpb1aBSSPxk=;
        b=ghMfx6fj9WO+Nv5BBqn+X88j4U89UFiAydPo75OgjEkfnZgvZ1XSjFdkjODZKTLJnu
         HYKtvr7liK90JhEcM+02jvaeGQlkTr7+kGofCuvl0z1Q/KId171E8/5MA+PDQb/vtFLG
         wxPaPW5ASqZKFRUFT67o8DuaDhGK6zWejgnadKzsfZtu//TN/wO4N8NtReVG8iY6PMtr
         MSsTwhBi5cR9wqihhKm5xeXRiFQWuWNdUvHZJSXRMLaWGd1cyA9Ih/gPux+l6Vho8PVn
         Lxj4ufId6KHJPMcrvnfcNNTKrvRVagJY/BCN7+nYvB+e1s/spc9PZEyaIg9ko80pk/zB
         FvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757625988; x=1758230788;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EjquTq5MAgSVrD6End1v2/eMfRkFt39jWpb1aBSSPxk=;
        b=LUr7Ev7QIN6jvhre1qql+QrM7kkur25iK6MEguGYJ1E9SKEWj7bKCBdBMtzcoBEr93
         eUVfAYKpsM4UkoENzX0ovjKmQucbOSAYe1cz+8Ls1jyT6F+5d5H7bZtFOoW5orldrkeL
         M+wQ5gNHFiflvLA0av2qSjXs+KFSzDU/cXLS7LHKSmZGyZs1saILmayK2wJbBidF7GvA
         ogYiLFZG0u/hv2qvM7i+DOgg0Rfz4NeLxRPwS+IT+LE2oGYxKv+8wCJMFuX/L3QmYTwd
         Q+W8Ajd3iORCknNNq46r95m0uC9gXsipbDulxjC1QxH4u1YKs2TJCdXvSO+3zhGj7G+d
         DdGw==
X-Forwarded-Encrypted: i=1; AJvYcCUzm7bwWBQxXBQWAJkTtf5P+wI4hHnknsrKJnJmgpvlT0UO4DAUR8LLTU+CurfSY8QSegM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCzEnikQSbq4WAE9citdbNMPd1Ep76GeeHaxTcrZUFf3MrgZ/+
	bxFmUp/74Lazz7eTyWsTZoxgsLOW5DtS8civpqiqfv2+fJHRlwToZBVO
X-Gm-Gg: ASbGncuC2FjaMFkpUCQT4DEc3LDf8Lug7ThIK97rHy2Wbt0kF9ZwSZIu0hLNwNjBxuo
	Oag/jAUd1mUzpK4dLx8Sokz0O7KutDgmkczZoZY5R1jhGkidBsZXGWPIEYMBoS6WGfvMqAPhD6l
	YukAmfyHPb0CVH5mnEQAuUi49wp487SBt2FB6AacxJxYt140IZNtscfgguwlYJAdXosymqcRiP7
	Ks0cGR5a6kANsSZ32IqgE7v7K5QN2LuAayn04k4qbAw73uvtTCkFILlB1vGdj3pmcRxFf1k49rf
	/FcUG1nUKRWXrXpWw4yAj2N1gw3GD9ven6/15Ew5Dj9LYu87rexyT64xmS3MWgVFy3vI4eLI8yM
	mya/+y2v7SLFaiLF2IPrhke/YqxMfjw==
X-Google-Smtp-Source: AGHT+IEjwfOvzZk84xflzxjLm5xONbXJLauvwJlikYGw0U/j6U74AKTutnNrVqldFjubLYTuTs0HYg==
X-Received: by 2002:a17:903:1b08:b0:25c:9688:bdca with SMTP id d9443c01a7336-25d26e43a33mr7095795ad.50.1757625988238;
        Thu, 11 Sep 2025 14:26:28 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c37295f4fsm28513255ad.42.2025.09.11.14.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 14:26:27 -0700 (PDT)
Message-ID: <c846a153010e40a52e98b8abe9db69f7d4cadd58.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 09/10] bpf: disable and remove registers
 chain based liveness
From: Eduard Zingerman <eddyz87@gmail.com>
To: kernel test robot <lkp@intel.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 daniel@iogearbox.net, 	martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev
Date: Thu, 11 Sep 2025 14:26:24 -0700
In-Reply-To: <202509112112.wkWw6wJW-lkp@intel.com>
References: <20250911010437.2779173-10-eddyz87@gmail.com>
	 <202509112112.wkWw6wJW-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-11 at 22:19 +0800, kernel test robot wrote:
> Hi Eduard,
>=20
> kernel test robot noticed the following build warnings:
>=20
> [auto build test WARNING on bpf-next/master]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Eduard-Zingerman/b=
pf-bpf_verifier_state-cleaned-flag-instead-of-REG_LIVE_DONE/20250911-090604
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git =
master
> patch link:    https://lore.kernel.org/r/20250911010437.2779173-10-eddyz8=
7%40gmail.com
> patch subject: [PATCH bpf-next v1 09/10] bpf: disable and remove register=
s chain based liveness
> config: x86_64-buildonly-randconfig-003-20250911 (https://download.01.org=
/0day-ci/archive/20250911/202509112112.wkWw6wJW-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0=
227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250911/202509112112.wkWw6wJW-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202509112112.wkWw6wJW-lkp=
@intel.com/
>=20
> All warnings (new ones prefixed by >>):
>=20
> > > kernel/bpf/verifier.c:19305:11: warning: variable 'err' is uninitiali=
zed when used here [-Wuninitialized]
>     19305 |                                 err =3D err ? : push_jmp_hist=
ory(env, cur, 0, 0);
>           |                                       ^~~
>    kernel/bpf/verifier.c:19140:12: note: initialize the variable 'err' to=
 silence this warning
>     19140 |         int n, err, states_cnt =3D 0;
>           |                   ^
>           |                    =3D 0
>    1 warning generated.
>=20
>=20
> vim +/err +19305 kernel/bpf/verifier.c

This was sloppy on my side, should look as follows:

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19297,9 +19297,12 @@ static int is_state_visited(struct bpf_verifier_en=
v *env, int insn_idx)
                         * the precision needs to be propagated back in
                         * the current state.
                         */
-                       if (is_jmp_point(env, env->insn_idx))
-                               err =3D err ? : push_jmp_history(env, cur, =
0, 0);
-                       err =3D err ? : propagate_precision(env, &sl->state=
, cur, NULL);
+                       if (is_jmp_point(env, env->insn_idx)) {
+                               err =3D push_jmp_history(env, cur, 0, 0);
+                               if (err)
+                                       return err;
+                       }
+                       err =3D propagate_precision(env, &sl->state, cur, N=
ULL);
                        if (err)
                                return err;
                        /* When processing iterator based loops above propa=
gate_liveness and


[...]

