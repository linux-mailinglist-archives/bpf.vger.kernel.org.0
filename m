Return-Path: <bpf+bounces-41281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AB599569F
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 20:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D780F287133
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 18:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886712139C7;
	Tue,  8 Oct 2024 18:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzfMVsAb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC90212D38
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 18:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412399; cv=none; b=Sf6Q+wA65xnFw3Q7ooAc/AKV53rr4nd9qkvd4f/l02dxhZkOsPNE3LJnowxo/kOPjhs4cSa6o1hWKqjx6uk71MveEERbSGR16zHUYNaKxUtt0nsPxiQOuBlcrvABhqwf808W+dNDbexjfBswkr1VpkC7JRrBgLKIpHcBnLkHP18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412399; c=relaxed/simple;
	bh=wb5ARox4Uj1WHJzSDUXQX/bIq+Z+9d0OfLCIxPGG0ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PiGLhfshbv9J+zwwRCNAZZF39GemM9/20UTAzyb7PNZBw1Hqnar+Z3yHW4EUtNmgPhfq4UswgtR+1QAxcjPAi3tJlCiat2v1BxKnqml4zK0WFGNGkRB7VxVuAamnIsxB/EmjNttIu8sc2x0YDtQyxGXlF+p0JJrwYBV7pjwaFPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzfMVsAb; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e0af6e5da9so4387591a91.2
        for <bpf@vger.kernel.org>; Tue, 08 Oct 2024 11:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728412397; x=1729017197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tv0OGRaHvQnzNrXEKxrlUIECqSg/8hAInpOyjAeujaw=;
        b=OzfMVsAbwvtrmVyGYMR+4a7tc7Al9MOh9m7b2gRs20I4NMlbGJq7KyEq2OGpS2cOnL
         stM5NuY6GJxUHOXEn0zmd7ZNi2d2w0R7EC6ZSlXB/OQmJ8/Gdt9BjUcV2OoO3IQy+oYT
         zl1XEvXDHTnOV40RLI2wVdEIMbW59SwPfBGGmbAdssWHqF1tQ48MHJNtMZQMzSpDPRcT
         OiBA6cwaEeEgX4L8g+jsGw42FuHNWiAz2jPrd7MtZ7niVtnhixp3QOhmIseMBxtIuC4x
         XJ437y4XbzJ+tMl1SZxhqmgch1on9GBjgBtH6gbv8Sf5pdee3riTJP5V8QpfI82v6M3l
         GVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728412397; x=1729017197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tv0OGRaHvQnzNrXEKxrlUIECqSg/8hAInpOyjAeujaw=;
        b=R//P2MNmhDVdSJhk17tKdJ5gMB+VFnR50wyhXD8XNr+95aidbMxbQ3u+WfzvjBkoUW
         Vx6Rlo1ifoD70xicU3C9FvRELMGuwJjqbfI1lieR7MUJvVByzwKScGdj/mtjF2jwtPrQ
         bxVmP1tePe2w+CH1t0EYG0IjMC2Em/ek9IPeZk4rdRStOc2k2FpDn7a2siOktt//u15f
         9JPCi3rCyMSqPtWQqnLffq4XCJzNIsnGrpic/G4zqvWYqkr1EInHhwmnVLmtrn+OTVpH
         UCBma73Ulq2SDddi+eHlEEQb18PDPVYgCm38NWHWktCnf6s6la2HXXJz8RpZQbZMJBFZ
         D/Mg==
X-Gm-Message-State: AOJu0YydY8on50YNRe4al8DMpi3jF8f50LuTy731Oy5iBj/UXIOAEFMq
	F7kazoweoqjuCa7hazLCqs+cEZ376fvySHsqfVDf45oeOmZElQKw/X10ccadQGRbXh1PWFOGQJR
	9J1QYuGcQyXYNYQ7mocM18NI3LxQ=
X-Google-Smtp-Source: AGHT+IECY8SpQlIWViRZJ4ZDxHm5A3jaKiR84wETAgGQWGiMOXR7PFlCJ4ETS5tlfnkpHCZxedQ+iMKLumf4ZQbodvo=
X-Received: by 2002:a17:90b:8c1:b0:2e2:877c:4a4e with SMTP id
 98e67ed59e1d1-2e2877c52a2mr4174598a91.37.1728412397003; Tue, 08 Oct 2024
 11:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008091718.3797027-1-houtao@huaweicloud.com> <20241008091718.3797027-2-houtao@huaweicloud.com>
In-Reply-To: <20241008091718.3797027-2-houtao@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 8 Oct 2024 11:33:04 -0700
Message-ID: <CAEf4BzZOo37TZM_tcEq_FV4v3LWXYmrUGAtOr+7ctGLF-w26wg@mail.gmail.com>
Subject: Re: [PATCH bpf 1/7] bpf: Add the missing BPF_LINK_TYPE invocation for sockmap
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Yafang Shao <laoar.shao@gmail.com>, houtao1@huawei.com, 
	xukuohai@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 2:05=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> From: Hou Tao <houtao1@huawei.com>
>
> There is an out-of-bounds read in bpf_link_show_fdinfo() for the sockmap
> link fd. Fix it by adding the missing BPF_LINK_TYPE invocation for
> sockmap link
>
> Also add comments for bpf_link_type to prevent missing updates in the
> future.
>
> Fixes: 699c23f02c65 ("bpf: Add bpf_link support for sk_msg and sk_skb pro=
gs")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  include/linux/bpf_types.h | 1 +
>  include/uapi/linux/bpf.h  | 3 +++
>  2 files changed, 4 insertions(+)
>
> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> index 9f2a6b83b49e..fa78f49d4a9a 100644
> --- a/include/linux/bpf_types.h
> +++ b/include/linux/bpf_types.h
> @@ -146,6 +146,7 @@ BPF_LINK_TYPE(BPF_LINK_TYPE_XDP, xdp)
>  BPF_LINK_TYPE(BPF_LINK_TYPE_NETFILTER, netfilter)
>  BPF_LINK_TYPE(BPF_LINK_TYPE_TCX, tcx)
>  BPF_LINK_TYPE(BPF_LINK_TYPE_NETKIT, netkit)
> +BPF_LINK_TYPE(BPF_LINK_TYPE_SOCKMAP, sockmap)
>  #endif
>  #ifdef CONFIG_PERF_EVENTS
>  BPF_LINK_TYPE(BPF_LINK_TYPE_PERF_EVENT, perf)
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index e8241b320c6d..4a939c90dc2e 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1121,6 +1121,9 @@ enum bpf_attach_type {
>
>  #define MAX_BPF_ATTACH_TYPE __MAX_BPF_ATTACH_TYPE
>
> +/* Add BPF_LINK_TYPE(type, name) in bpf_types.h to keep bpf_link_type_st=
rs[]
> + * in sync with the definitions below.
> + */


Let's also add some static assert making sure that bpf_link_type_strs
(and probably same for other types) size is equal to
__MAX_BPF_LINK_TYPE? Comment is good to remind us, but compilation
error is better.

>  enum bpf_link_type {
>         BPF_LINK_TYPE_UNSPEC =3D 0,
>         BPF_LINK_TYPE_RAW_TRACEPOINT =3D 1,
> --
> 2.29.2
>

