Return-Path: <bpf+bounces-17731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0114E8122E0
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 00:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4F91F218CD
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 23:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA3D77B45;
	Wed, 13 Dec 2023 23:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BC2sci7v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9060EE4
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 15:33:03 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40c39e936b4so51158575e9.1
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 15:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702510382; x=1703115182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRdouZXuvj3yUef6YCoPzZTQMtQidEaDPDk2iy4U1Dc=;
        b=BC2sci7vKUYqd3I5WUVmk2FDbDg0E+1/lhZ/p79jE/MBbCb7r2T22bRCT6FHw5IVxD
         jAh6icrcFH2pn2y8raK+siMsFL0riuhtnSN+XPD3Xtwamm4oEf0Zr3tSjbfqv7OQSHEV
         z9cA55qDuao7X4iGrcUHq+3a92R0+mGHH8THsFSPdruztWD/UFD3PAfdQAk++eIBl9v6
         q8xTALDKxa0IOTvvvdRGIC7bZMRK65pwdDH+zMbxrnc59YpxqFSX2pXlKOwngEyEzICs
         ckivCpu7z8QskRoJb5uBuL1P8+HkS4SXrunivmcJ8hH5myFa0W1mpLhZBKQ0A919Yt9+
         CnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702510382; x=1703115182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRdouZXuvj3yUef6YCoPzZTQMtQidEaDPDk2iy4U1Dc=;
        b=neYSTHyGA0qezXcakDiAPPOY4pcwqaiqkXimzCZqWDBHHWqeGYoFuJthEkTZwUtGaE
         u49FyzGbZPminnGLwAMoKfOu1UB2WHoDUbRURg4tRjr1J8QzvZScinmQpAebkVYnlLuo
         tz7G/Ga52VCXswcSV7vGYpVxf/XyDivmprooHRO4p3LJnZTmIt9wvB70y9cUr019VmN3
         eIhb+gv2IB/OfHiCY+ZLeDYXIAidZ5+kAD/yEfu74pJLwTiOrjR0cu5EMBaMd3pfxlV0
         kR2hc6ANqZni+pjtJwMrL0B/aYr/j4pyfQwu20HvvHTlvhH7fKCGs2QQol/PX7JH5FU1
         oq2A==
X-Gm-Message-State: AOJu0YwjSCABAPFR8h2BWlUWWFoqArXX6L48aE+s9S9G5nbuFLDx+BXh
	b1rnh9zNUWTZPvVDtOuv7G7uMF3VlHGB/2k+265AIive
X-Google-Smtp-Source: AGHT+IFGDYmFGtgkaZvzeaQlA92AkPEUte8PQRMbvvUcoiaC8p5l7ilLse70VeJYpUMCSJkokkr1E1IyP2JykvQRtYg=
X-Received: by 2002:a05:600c:4655:b0:40b:3937:d2b1 with SMTP id
 n21-20020a05600c465500b0040b3937d2b1mr2268564wmo.6.1702510381813; Wed, 13 Dec
 2023 15:33:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213112531.3775079-1-houtao@huaweicloud.com> <20231213112531.3775079-3-houtao@huaweicloud.com>
In-Reply-To: <20231213112531.3775079-3-houtao@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 13 Dec 2023 15:32:49 -0800
Message-ID: <CAEf4BzZerWpU-GW8iqZYHue5qbTrdWXZp1WKvrkxLkDj1y2Lww@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] bpf: Limit the number of kprobes when
 attaching program to multiple kprobes
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, xingwei lee <xrivendell7@gmail.com>, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 3:24=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> An abnormally big cnt may also be assigned to kprobe_multi.cnt when
> attaching multiple kprobes. It will trigger the following warning in
> kvmalloc_node():
>
>         if (unlikely(size > INT_MAX)) {
>             WARN_ON_ONCE(!(flags & __GFP_NOWARN));
>             return NULL;
>         }
>
> Fix the warning by limiting the maximal number of kprobes in
> bpf_kprobe_multi_link_attach().
>
> Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/trace/bpf_trace.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 2d1201f7b554..944678529f5c 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -43,6 +43,7 @@
>         rcu_dereference_protected(p, lockdep_is_held(&bpf_event_mutex))
>
>  #define MAX_UPROBE_MULTI_CNT (1U << 20)
> +#define MAX_KPROBE_MULTI_CNT (1U << 20)
>
>  #ifdef CONFIG_MODULES
>  struct bpf_trace_module {
> @@ -2970,7 +2971,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_at=
tr *attr, struct bpf_prog *pr
>                 return -EINVAL;
>
>         cnt =3D attr->link_create.kprobe_multi.cnt;
> -       if (!cnt)
> +       if (!cnt || cnt > MAX_KPROBE_MULTI_CNT)
>                 return -EINVAL;

let's return -E2BIG for `cnt > MAX` cases? Same in another patch
>
>         size =3D cnt * sizeof(*addrs);
> --
> 2.29.2
>

