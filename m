Return-Path: <bpf+bounces-15066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB677EB559
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 18:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4678EB20BE1
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 17:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64884123C;
	Tue, 14 Nov 2023 17:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fY1kuLgI"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7E0405F5
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 17:07:03 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578C5F1
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 09:07:02 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4083dbc43cfso42500895e9.3
        for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 09:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699981621; x=1700586421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctsQGx+NKL61Z3AbdAyAry9AWOL48MNe+4etQVJkWck=;
        b=fY1kuLgIjWmBXfZoCBQ6HMxS4d12yntOB8ZHXSDNNB+getNp2+h3GVOdof5DoHNgip
         6K52KCaOSwmVylbZ828WZXZrDaoKALUjLsWSgxdyj4+mWYgvyUXEs8oRiDzRCOdHyCvJ
         WHlTIN357Z7hfb5bqo0hBCyQ/DZcGjUDN+bu8iSLag635TntR80r/ivNiMYjiBrRM/W7
         yfg9bGKv1S0AnSIt98mmC6gdVQD8HxDjvYN1QJcWphNbopamcLhMzSYnvvzm2USx3tSX
         OeSsi9+WfGBeYhNYoXy7bdl2uMMSyxVMsLWPlXMIxKmK69Okgy6/QwnrkyZ72UJKLvh8
         kymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699981621; x=1700586421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctsQGx+NKL61Z3AbdAyAry9AWOL48MNe+4etQVJkWck=;
        b=n4AQC7MWMDOt61+AQnNCsDURYs/CjCY03JLpyNwjuvDX/5N9mUEHIQHwp/CzqZ8VyX
         DOGgLnCatM0ybUrug7nwy8tmk5r775IF9gDpgCdJcNcwVuCpExOtGsog5arq7CSbSFWr
         pdixcjHRAErMU5Vc2LV9JEHLo36CnqzrBxaOsr9F+Wz+CSOjQtWdcqacZfM7D7cGvWxX
         rR8LXpHhsIjpTMiIPN+3bkWrKxCXTjdOVX5SVpGKmu7D4JzmKwKP8txS6OZ5e+caBy+C
         7E9YFE7lD/Q0isFu+qoYxeuUbccyRLf1HwZIs3RBIvqF54pEA7Zbg14XudBOvKjIAeR9
         U5ww==
X-Gm-Message-State: AOJu0Yyf8C2bU43TLUzAOdK0KpNbUixNsMZOQCGl+FTR8vxHkmmv8x39
	z3t1wqOIkSkwawB+0gel4pxOsUcNwmaCc8dJwFUqeoPL
X-Google-Smtp-Source: AGHT+IE0EIf7nE0PqpmzSlSOpPe+XMBpplWvTsgWkvboZ+3g77PAwk8WnkgpO5yOjzPDcQLDfEz6q0bF9lpcjTvf33M=
X-Received: by 2002:a05:6000:184f:b0:329:6e92:8d77 with SMTP id
 c15-20020a056000184f00b003296e928d77mr7564164wri.51.1699981620514; Tue, 14
 Nov 2023 09:07:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231111090034.4248-1-laoar.shao@gmail.com> <20231111090034.4248-7-laoar.shao@gmail.com>
In-Reply-To: <20231111090034.4248-7-laoar.shao@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 14 Nov 2023 09:06:49 -0800
Message-ID: <CAADnVQKoK6ROsiTpS5AkxaZW_MBUK_aSpUAfG=tQZKnSetqyNg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 6/6] selftests/bpf: Add selftests for cgroup1 hierarchy
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Tejun Heo <tj@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 1:00=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> diff --git a/tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c b=
/tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c
> new file mode 100644
> index 0000000..979ff4e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//#endif

Removed while applying.

> +/* Copyright (C) 2023 Yafang Shao <laoar.shao@gmail.com> */

