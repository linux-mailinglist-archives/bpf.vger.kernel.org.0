Return-Path: <bpf+bounces-73175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2116C26360
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 17:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A5DF567459
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 16:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49582EC561;
	Fri, 31 Oct 2025 16:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+Vfn4b3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4112B29B8E8
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761928698; cv=none; b=qvSdF/8/1V+eNxRoeCyqsYYn2Xb7BHqlRjKm8mNzT6WbR7eA5NgHb1wfyHktNgsHldklDPbrX9sC2smxgP4nHCF6HBYNNweReOwtMID9z3xU/Mi9rJXfAWv5X3xxpxx/ljCfwYUHoXjNX7yQoskYHWLA+3w+O1HEuFz1qGhd7BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761928698; c=relaxed/simple;
	bh=p7vdofTGqu3x6DvvTHZIENYATo0Ig2XlNqgLI2N93SI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V7V6UbDhY5Gm/ZGZ3IFeAt3qXGuzNTTtCNNmNtOx4ZXH/jLF4eMAsAzl+ny9+pfHVsOyJLG097/PEnfjdyrFeqxnROvCfqfHWyVo6yf7qELmMbY6liYPGu9sFOzwLtDFL4zlJqnNXvjcLR/lkzqmkqT90UsxC4cUw9pENi/lulg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+Vfn4b3; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4283be7df63so1280451f8f.1
        for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 09:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761928687; x=1762533487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=or8GDDYatTrrl85V6YGHNAw/hbsTDPW4OGinPVZC6ss=;
        b=E+Vfn4b3ekT+IChBYxiXQHMPwpLOuBGOv43snic5wpcnaepJcV3A0Z3UJMd3CPb/iz
         juvVlYTGbQ0DepWpWBC0MYFxrVlkJPWwd1VUk/cRScBjW7VauxE3F9ON41BitzWudmRC
         2sPeYIAf0hK+Y5SOTy3TDk5oXj6sbO06c+UYRROL55fZOLz4U3tDGXI8vckvtraBafFc
         6/sbzqrU+ntKkf/zRPlm1WL4q82RkMfvCer7OpsDzjcGfOtITZhmFiLgruUaFXAOKRCo
         mBORYin9v/1N+dTTAECjm+hkTOPDTBXpRSChMht9HbtbnDVmdGOWeVZarumiwB/n0+37
         R3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761928687; x=1762533487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=or8GDDYatTrrl85V6YGHNAw/hbsTDPW4OGinPVZC6ss=;
        b=fIm0d5ldQ5X4j953RccquO/LWGlApFqjJMNT2WVo4ZXz7w3liS0YwmXYAzkvSlQRU5
         kP4nv3gbPzV6PCWdNh8frNnnaMDvRI+A916RWGRU9n36fmkdtR5kycSGyh17/hNN7McF
         Mdnuwvxwhs2++tbSs2aXfGRHIDcRjXMVJJ6wqOZmo1UOMWb+rp4WcQ/TehhCXpxcrit5
         6ZG67pfVXdgQ41DRjqSa9/zuAARPSMg+CKFH8ssfGXRocVkJSGCFV2/n7cHgYr6PMeeH
         /Aoieu/VxrOh0OHCV6ReERr3uQdRuQ2LvAvTX8L+g/rJtsSnZMHZS9TesYA+AOpy9etm
         FrhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/q72xY/qw6UlfybIgCUbozXERckrFVQmdlh4XD4RmSvRWVuVXA3N1QuILTBE1mCsI1NU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBZmsWwDvzkUhOJT3UYttre3zrsbnuhXmfL+eKdUJwZHa6rVlh
	9YxrQDcAzNS+fs36AarlYfrZuS8JUjjtpomF0H6Eyv/vDXMrRWD4IQsc3M+2N/xaj7VAOzLM2nT
	x1Vs2QdnShGSLejhttSnIm6qBsbS0wHM=
X-Gm-Gg: ASbGncvtfJSrNj6n/y63QWfu00Ij89+0GM/E8qohmeAtIGx8dg0osMGy88TNgrLzbYj
	i8Wa0HEpDc6ZI3TmnSPLDCXqSlPEw0G0M7LvonDGuRFeUAeBlHTrIELjYMGxybxvb35TE0ZQpzf
	aUIaMwvNtk+3tYcs5S+bSKWEu+auUUNJpaEekAXQakkvghr4MyzNgzPC3deoPw+WOLXEj6A+JCk
	PJHD3ZfEMMwD9e4HEJXeDSPZIA5I1v3rPQB2LCetSTUWRlofZP46ZPv0q7sTTtDbixXktmoJTE5
	zGUeHtxEe5n+jwto5ZBbmcwycbXT
X-Google-Smtp-Source: AGHT+IFBHh5rk74gwLSZ2LKe1jBxHjLUksqYeKCEGxnQHUNuc86p9MCP6sT8KBMTg23E0aT5bpyGxxtlW+e826OBh3M=
X-Received: by 2002:a05:6000:178f:b0:429:ba6a:3a86 with SMTP id
 ffacd0b85a97d-429bd6b2196mr3452799f8f.57.1761928687090; Fri, 31 Oct 2025
 09:38:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031154107.403054-1-kafai.wan@linux.dev> <20251031154107.403054-2-kafai.wan@linux.dev>
In-Reply-To: <20251031154107.403054-2-kafai.wan@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 31 Oct 2025 09:37:54 -0700
X-Gm-Features: AWmQ_bl06Po1W4MOoS1jpCHAUNH8kXBIMxWHPf8qXw0QaexrF09WsuZ1bhbcqWc
Message-ID: <CAADnVQ+4QoCU4gYEfTR6Ok122zkfG32s8AxRx-irMcCA1jEhvQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Skip bounds adjustment for
 conditional jumps on same scalar register
To: KaFai Wan <kafai.wan@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Paul Chaignon <paul.chaignon@gmail.com>, 
	Matan Shachnai <m.shachnai@gmail.com>, Henriette Herzog <henriette.herzog@rub.de>, 
	Luis Gerhorst <luis.gerhorst@fau.de>, 
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, colin.i.king@gmail.com, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Kaiyan Mei <M202472210@hust.edu.cn>, 
	Yinhao Hu <dddddd@hust.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 8:44=E2=80=AFAM KaFai Wan <kafai.wan@linux.dev> wro=
te:
>
> When conditional jumps are performed on the same scalar register
> (e.g., r0 <=3D r0, r0 > r0, r0 < r0), the BPF verifier incorrectly
> attempts to adjust the register's min/max bounds. This leads to
> invalid range bounds and triggers a BUG warning.
>
> The problematic BPF program:
>    0: call bpf_get_prandom_u32
>    1: w8 =3D 0x80000000
>    2: r0 &=3D r8
>    3: if r0 > r0 goto <exit>
>
> The instruction 3 triggers kernel warning:
>    3: if r0 > r0 goto <exit>
>    true_reg1: range bounds violation u64=3D[0x1, 0x0] s64=3D[0x1, 0x0] u3=
2=3D[0x1, 0x0] s32=3D[0x1, 0x0] var_off=3D(0x0, 0x0)
>    true_reg2: const tnum out of sync with range bounds u64=3D[0x0, 0xffff=
ffffffffffff] s64=3D[0x8000000000000000, 0x7fffffffffffffff] var_off=3D(0x0=
, 0x0)
>
> Comparing a register with itself should not change its bounds and
> for most comparison operations, comparing a register with itself has
> a known result (e.g., r0 =3D=3D r0 is always true, r0 < r0 is always fals=
e).
>
> Fix this by:
> 1. Enhance is_scalar_branch_taken() to properly handle branch direction
>    computation for same register comparisons across all BPF jump operatio=
ns
> 2. Adds early return in reg_set_min_max() to avoid bounds adjustment
>    for unknown branch directions (e.g., BPF_JSET) on the same register
>
> The fix ensures that unnecessary bounds adjustments are skipped, preventi=
ng
> the verifier bug while maintaining correct branch direction analysis.
>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Closes: https://lore.kernel.org/all/1881f0f5.300df.199f2576a01.Coremail.k=
aiyanm@hust.edu.cn/
> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> ---
>  kernel/bpf/verifier.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 542e23fb19c7..a571263f4ebe 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -15995,6 +15995,8 @@ static int is_scalar_branch_taken(struct bpf_reg_=
state *reg1, struct bpf_reg_sta
>
>         switch (opcode) {
>         case BPF_JEQ:
> +               if (reg1 =3D=3D reg2)
> +                       return 1;
>                 /* constants, umin/umax and smin/smax checks would be
>                  * redundant in this case because they all should match
>                  */
> @@ -16021,6 +16023,8 @@ static int is_scalar_branch_taken(struct bpf_reg_=
state *reg1, struct bpf_reg_sta
>                 }
>                 break;
>         case BPF_JNE:
> +               if (reg1 =3D=3D reg2)
> +                       return 0;
>                 /* constants, umin/umax and smin/smax checks would be
>                  * redundant in this case because they all should match
>                  */
> @@ -16047,6 +16051,12 @@ static int is_scalar_branch_taken(struct bpf_reg=
_state *reg1, struct bpf_reg_sta
>                 }
>                 break;
>         case BPF_JSET:
> +               if (reg1 =3D=3D reg2) {
> +                       if (tnum_is_const(t1))
> +                               return t1.value !=3D 0;
> +                       else
> +                               return (smin1 <=3D 0 && smax1 >=3D 0) ? -=
1 : 1;
> +               }
>                 if (!is_reg_const(reg2, is_jmp32)) {
>                         swap(reg1, reg2);
>                         swap(t1, t2);
> @@ -16059,48 +16069,64 @@ static int is_scalar_branch_taken(struct bpf_re=
g_state *reg1, struct bpf_reg_sta
>                         return 0;
>                 break;
>         case BPF_JGT:
> +               if (reg1 =3D=3D reg2)
> +                       return 0;
>                 if (umin1 > umax2)
>                         return 1;
>                 else if (umax1 <=3D umin2)
>                         return 0;
>                 break;
>         case BPF_JSGT:
> +               if (reg1 =3D=3D reg2)
> +                       return 0;

This is uglier than the previous version.
reg1 =3D=3D reg2 is a syzbot territory.
We shouldn't uglify the code everywhere because of it.

pw-bot: cr

