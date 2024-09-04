Return-Path: <bpf+bounces-38929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 674CF96C84A
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 22:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12721F21674
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 20:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063961482E3;
	Wed,  4 Sep 2024 20:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEWBDVF4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6461EBFEC;
	Wed,  4 Sep 2024 20:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481296; cv=none; b=f6uGZkPxf35gs2n1L1AqmsJ9X5ev+Dkn07DxsAoo95yEsniQ1FXvc1/Nr6rpnJEFut/+T2MIFKFk5jJllm/InaFapRp3fttna136TNwJCKO/PwzrzQ/mEpsyQedXVM7HEfoxYdYxvP4rFKdv4LP20FP2KQOVbbH5vlFRXH1LzMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481296; c=relaxed/simple;
	bh=UysNCBZGl0zzPiEWPP6/BDsK4g8q6dDpCM+mbE5v3EE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dKEAfbIMVomEigiCm4kU4bfJh7kRhBQ1SIk3OSbWB3NdmCdcWy+RuBGE+Dpsz4NVGJVssklWvHTo0k3ABUnufpO5QgltUF1gYNMKX+/tqvTtF47N0jbGlW8/rAbkhI+CLokGr0hm4Ykx/nCfxI0vmgLMOTb27depmtCYrdA0E2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEWBDVF4; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d87f34a650so18207a91.1;
        Wed, 04 Sep 2024 13:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725481294; x=1726086094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAMoPk7C0DH2NXF8P5L8PAlBeNNIJDV5ksHuFpUK2Zw=;
        b=VEWBDVF4237FlXH2GgM48WY1NC0bkE3kWLGOeeqOPXOgrvkLB1qb6bdUH5/3rzaGaM
         dakce1K/ykBtGKMmrnYogGpTghqsc4LxyCxIR1cRoU5AZLBdoAmfWunLRmkPiAVgDUNw
         Qd6GtOnO+va8NQWzKnt4slEto/EM30Bfsap+qiq+gaQVpx4KkpSAwdaEk5e+uWawcjPE
         5VtTpo/FFk8Q3ITb01LeNumvB4Kdg/kveXcXOEBtQBMncm+kh13HNtteWUf33qsfw5YZ
         WvULNV/ptkP09l+92Cb6xlSwKvhVu/ZVWa7aZteay9XJ8MX1OsNsPuaLO61vfSRbPxPh
         SUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725481294; x=1726086094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAMoPk7C0DH2NXF8P5L8PAlBeNNIJDV5ksHuFpUK2Zw=;
        b=o2S+/j8Uz8rfyjSViSNQc2048TwaW0YaFz7KPm8B+jeih6FDFzS888KJZ8Tl2BGWqT
         np1s6EYq+jM2CQ4w9cWs4ddxG7rRZyyWP2LVvmYz1xKVwF682gn2fJSG1eb0sRXc1Mh/
         oIabA90UUefTCSg1G8NNTWX73D0duCTeK9C4oIepR2ZRQwhAWWI7XNTFRuPB6DR6qtun
         4QgBKhWIT6JatCsN53BrGZj8m5hDEuASTDrd/WhMD7SpxSAkLzAAX3RgEzZTRFq52GAv
         83UmnAkcmX0EfcQVTP7UGwK5cLrliwbFmgpgUsAoq9K2gsTpN3JnxLDN5M+XpMEljl9h
         PX1w==
X-Forwarded-Encrypted: i=1; AJvYcCWkUXBiF4hOPfZsoU5j4j+IP/s1mxJPlrRUmix+OgSJyyeHTU2cWPynuTpaUN8OEgVl2qjZjNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjSZenE7e0Egs/aXPou22Z1b1wnS35hALRTfrOTn/Ws0VpthBD
	bSVMoGCMPnM2e7P9kds543N3kDtNUAew7GTofQvNohOVoTgk/Gh51ef7J+rLt2PtHo5aXUlb4o8
	8XGvEteRMSMDz7s1UM5ntuSXL9Qs=
X-Google-Smtp-Source: AGHT+IFGWtqUAtuDasPjB0tcP05uQa2rp9boXM1aqKCzVoM5wST6zCNZ+dkBQcG/iUCkve7kSACiWtJlfihV64zuSgQ=
X-Received: by 2002:a17:90b:30cb:b0:2c9:36bf:ba6f with SMTP id
 98e67ed59e1d1-2da8e9d7788mr5387259a91.3.1725481294230; Wed, 04 Sep 2024
 13:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240831041934.1629216-1-pulehui@huaweicloud.com> <20240831041934.1629216-3-pulehui@huaweicloud.com>
In-Reply-To: <20240831041934.1629216-3-pulehui@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 4 Sep 2024 13:21:21 -0700
Message-ID: <CAEf4BzYQx95PzRyivNgGWwL_ytB1=Z8eVGe_ejYHvdiCyjMJzA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/4] libbpf: Access first syscall argument
 with CO-RE direct read on arm64
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org, 
	netdev@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Puranjay Mohan <puranjay@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Pu Lehui <pulehui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 9:17=E2=80=AFPM Pu Lehui <pulehui@huaweicloud.com> =
wrote:
>
> From: Pu Lehui <pulehui@huawei.com>
>
> Currently PT_REGS_PARM1 SYSCALL(x) is consistent with PT_REGS_PARM1_CORE
> SYSCALL(x), which will introduce the overhead of BPF_CORE_READ(), taking
> into account the read pt_regs comes directly from the context, let's use
> CO-RE direct read to access the first system call argument.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>  tools/lib/bpf/bpf_tracing.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index e7d9382efeb3..051c408e6aed 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -222,7 +222,7 @@ struct pt_regs___s390 {
>
>  struct pt_regs___arm64 {
>         unsigned long orig_x0;
> -};
> +} __attribute__((preserve_access_index));
>
>  /* arm64 provides struct user_pt_regs instead of struct pt_regs to users=
pace */
>  #define __PT_REGS_CAST(x) ((const struct user_pt_regs *)(x))
> @@ -241,7 +241,7 @@ struct pt_regs___arm64 {
>  #define __PT_PARM4_SYSCALL_REG __PT_PARM4_REG
>  #define __PT_PARM5_SYSCALL_REG __PT_PARM5_REG
>  #define __PT_PARM6_SYSCALL_REG __PT_PARM6_REG
> -#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1_CORE_SYSCALL(x)
> +#define PT_REGS_PARM1_SYSCALL(x) (((const struct pt_regs___arm64 *)(x))-=
>orig_x0)

It would probably be best (for consistency) to stick to using
__PTR_PARM1_SYSCALL_REG instead of hard-coding orig_x0 here, no? I'll
fix it up while applying. Same for patch #1 and #4.

It would be great if you can double-check that final patches in
bpf-next/master compile and work well for arm64, s390x, and RV64 (as I
can't really test that much locally).



>  #define PT_REGS_PARM1_CORE_SYSCALL(x) \
>         BPF_CORE_READ((const struct pt_regs___arm64 *)(x), __PT_PARM1_SYS=
CALL_REG)
>
> --
> 2.34.1
>

