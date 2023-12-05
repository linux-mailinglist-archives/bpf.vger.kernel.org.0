Return-Path: <bpf+bounces-16779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46169805E32
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 19:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E300D1F216C0
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 18:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED3A68B7C;
	Tue,  5 Dec 2023 18:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuSsvO7N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DDDCA
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 10:57:38 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50bf2d9b3fdso3859749e87.3
        for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 10:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701802656; x=1702407456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FsjS2AfVun50o7CR/HMHck5tbwkgS3QiimVWvhSYh0=;
        b=EuSsvO7NGa+akrQayEg99eJs6pvxKXAhb3pmvEYVpM9kgrqP61NYijXJi2q5rbY68N
         bRNbgIwUohdEz8yyRg/rPJlZyF+RMtZ05ZtA3TJ0gu09tjBn2PMH42zy8jGXXK+p/QZH
         9jBPDhF3QTHPMTA54p8VuyNSohKDvvzGK+Ut1gfO1IdrAB2wzd78rT4ZtHQ+B7D46o/3
         +0ugK53j150JXqeX/sLjSSjOjP/mxg1liQTnI+hQow/NNzOyU3MZo68rLu9M0caQ53IO
         T34rBnLqQ1Nr7GnDhjPEndGt08pj1CA0y/La8XkyCkqg+R5i+gbkmC+fgrLpQDd7gijF
         Uy8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701802656; x=1702407456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9FsjS2AfVun50o7CR/HMHck5tbwkgS3QiimVWvhSYh0=;
        b=XrjfqLhny9IND3OqijkBSFkOR4JbT8mjuml+zsEAxuS8ovgkdQLYlqJjsc5CAUDagi
         969V9xOG/aXxr8TMaKOsxc5nxmOp0jHeih3SefbayuQD69cyok347X7U+LOfmW+LBSS3
         7TSphK0OblTax4kV92Or955Gv9TL5uDuNiZLHMNOjQ9UVduhZEcH2cxwezn0+XD3HxAk
         StDR2lXoSK7jIfAOdFCuYqK1p0+JCh3omKFC3oU11qRef5nEL8R/GUvjYhfMawjpUKIy
         dQVIl499bYCjThRBSnmYq4x83MuO7qViJt542Gi3LLRfXdcg4drzJl4jHIlT0c7GcV1u
         AWpw==
X-Gm-Message-State: AOJu0Yw+ahOPRDkHBeQo7bu4eEsCekpH9KiWpUVyaH+fJFcu6k9p77wy
	qfEJhN4sk6+eeJ9NwNvRVICMKgeyTBx/OKUhpemQYhHn
X-Google-Smtp-Source: AGHT+IGtouz8IGF0IEtn0I2iWFxs9gbGn/Kw92doHz6aZAYVURgyaQQoL4RtND+xZXjGAe+wShZEPuS9GuJh6VwRaD8=
X-Received: by 2002:ac2:55bb:0:b0:50b:ffb9:7a4e with SMTP id
 y27-20020ac255bb000000b0050bffb97a4emr1340536lfg.46.1701802656165; Tue, 05
 Dec 2023 10:57:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204233931.49758-9-andrii@kernel.org> <202312051530.hEAmx5zj-lkp@intel.com>
In-Reply-To: <202312051530.hEAmx5zj-lkp@intel.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 5 Dec 2023 10:57:23 -0800
Message-ID: <CAEf4BzZfkWisHcJaTodoCK58GPZOfgMRXDUEqc1rY9aATM2hWw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 08/13] bpf: move subprog call logic back to verifier.c
To: kernel test robot <lkp@intel.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, oe-kbuild-all@lists.linux.dev, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 12:02=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Andrii,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on bpf-next/master]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/bp=
f-log-PTR_TO_MEM-memory-size-in-verifier-log/20231205-074451
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git =
master
> patch link:    https://lore.kernel.org/r/20231204233931.49758-9-andrii%40=
kernel.org
> patch subject: [PATCH bpf-next 08/13] bpf: move subprog call logic back t=
o verifier.c
> config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20231=
205/202312051530.hEAmx5zj-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20231205/202312051530.hEAmx5zj-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312051530.hEAmx5zj-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
> >> kernel/bpf/verifier.c:5083:5: warning: no previous prototype for 'chec=
k_ptr_off_reg' [-Wmissing-prototypes]
>     5083 | int check_ptr_off_reg(struct bpf_verifier_env *env,
>          |     ^~~~~~~~~~~~~~~~~
> >> kernel/bpf/verifier.c:7268:5: warning: no previous prototype for 'chec=
k_mem_reg' [-Wmissing-prototypes]
>     7268 | int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg=
_state *reg,
>          |     ^~~~~~~~~~~~~
> >> kernel/bpf/verifier.c:8254:5: warning: no previous prototype for 'chec=
k_func_arg_reg_off' [-Wmissing-prototypes]
>     8254 | int check_func_arg_reg_off(struct bpf_verifier_env *env,
>          |     ^~~~~~~~~~~~~~~~~~~~~~
>

doh, they now should be marked back as static, of course

>
> vim +/check_ptr_off_reg +5083 kernel/bpf/verifier.c
>
> e9147b4422e1f3 Kumar Kartikeya Dwivedi 2022-04-15  5082
> e9147b4422e1f3 Kumar Kartikeya Dwivedi 2022-04-15 @5083  int check_ptr_of=
f_reg(struct bpf_verifier_env *env,
> e9147b4422e1f3 Kumar Kartikeya Dwivedi 2022-04-15  5084                  =
     const struct bpf_reg_state *reg, int regno)
> e9147b4422e1f3 Kumar Kartikeya Dwivedi 2022-04-15  5085  {
> e9147b4422e1f3 Kumar Kartikeya Dwivedi 2022-04-15  5086         return __=
check_ptr_off_reg(env, reg, regno, false);
> e9147b4422e1f3 Kumar Kartikeya Dwivedi 2022-04-15  5087  }
> e9147b4422e1f3 Kumar Kartikeya Dwivedi 2022-04-15  5088
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

