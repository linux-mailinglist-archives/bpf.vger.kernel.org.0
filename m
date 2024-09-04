Return-Path: <bpf+bounces-38913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E36796C6C1
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 20:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 295B8280FAD
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 18:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE521E491A;
	Wed,  4 Sep 2024 18:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCN0Cfu8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FE61D2225;
	Wed,  4 Sep 2024 18:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725475771; cv=none; b=MN+CxqcPYuMEj4tDKkSt7cZuu61MIwFlQ65oi/xJW3aQHXd6i1Ey4mn097F6WxDwC1IoVM5HssbBALvi4b8dxJqOl+WP0cpaP/af3LSnH4dKHXjln+6hMAfofUztSVsEPcpUPwYe+gfm4DhYM0d8wREcpBmbuCap/4IsOTvmgZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725475771; c=relaxed/simple;
	bh=n/gFRcrezqdMtQ318/NvX+xECfxx/j4YimFGCehUDB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g9en2FRdX1try6AyrEKxCFAadA3vG7D3MYMIMtQvLywJPKq2jh6wkd558IzjLKsl0J8pcmGgjmGqjr8/WesKsrM2oa7PoYLkPyXKHRc1XKTJNVJk/QLPFZ0S5MZisoujr+sUknSq6XvcLsqE6dgA/M+c6qcpuV0rlg23IDd4BU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCN0Cfu8; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d88c5d76eeso3202848a91.2;
        Wed, 04 Sep 2024 11:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725475769; x=1726080569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PPxKCIgg8NU2pZMqCaHzzO10WCLKFNPnNk2iyFDphQ=;
        b=RCN0Cfu877q4nSz4CcJIOLlcFC+CaBK6HXLregBQqp+1NQ2oYHpD6P3ufWOEoglXbA
         hlRBn+tZU09zq3aaXOGu4wW7CzpFxEovlYU07bBgaRCmbL3fFGRETeqyemaHE89fRQLG
         EnPDxI6MSWS5MkcInGF4jT1JZs642IrW04L9mcseoK8nZebaDBkHYh+3h/YjzdILRwNO
         b22yOmz4iCfUSdF3TgbGPWxl8Vae52L77ixEPXH1bAh9Sb+DGsHMdSGdhbqXsV2uzAd1
         3Hui8zDbH358Nj+W4g0FegYXqCHaGTQSsKvEn4njUodOCPBqU2hsg8oKhXQUlL9kEnNC
         b0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725475769; x=1726080569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8PPxKCIgg8NU2pZMqCaHzzO10WCLKFNPnNk2iyFDphQ=;
        b=QkqKfHy/+/ylSWfmV4POezAm+ujYbS/NwLf5b44XprEKTr3ZlMHG5yb6Wspa/VTfs/
         6IpVrXBiuYHAIAzjH3+fBqB7xNpy5PMFhv/wFmxkRTF024ADpHLswNa0UxWH948a5CjQ
         xpg9KIUj4WSpAqoJ6GwiH0O78w6UDcaIxBKHKK7oPNESpxV1waj9e3I4uyxbHnkxtBLs
         W2pCgsm2+zrPfv/Q+TwpqHV3C47dcfgIjBVISuGc7eGWdrudvaPGmpzAy21/EgCNKVxX
         qlBRaZanEK/pe6/7bXKtomC9Bv0bU01GHFuolhMrXNqlpQHC+ywJmagB4U3yBPnuRq/R
         l6yw==
X-Forwarded-Encrypted: i=1; AJvYcCWEWg7UUinBnJlXgRAjeNAsFQexMIls8EGqHlHsz0M3tKbj04qpVJWjSSFKWo2AFTJdhQ9guGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYQcyT+eow8zemiCJUz14aQv76PS+ru3CLPiJXL6X7fGAZRrIe
	w42Z6bZeYBft/K9oWqaNhjnvnXFEmn+xv/haO4qQC5HLqMsIdjFPS30kEcR9HpsC452rtb/IwDf
	DC0jXuYGNNq8+OR00kQkkPm8zaUc=
X-Google-Smtp-Source: AGHT+IHAyCABA6IyD3KDvbfAF9hLyov6gtHJk/gTVL+5Jg1mfrvGZcCnzOvvzO7mxLGrZpSZAdMU5iljo3efFSohAZM=
X-Received: by 2002:a17:90b:4b02:b0:2d3:bb9b:ce64 with SMTP id
 98e67ed59e1d1-2da55a44a8cmr8489121a91.30.1725475768933; Wed, 04 Sep 2024
 11:49:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904141951.1139090-1-pulehui@huaweicloud.com> <20240904141951.1139090-2-pulehui@huaweicloud.com>
In-Reply-To: <20240904141951.1139090-2-pulehui@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 4 Sep 2024 11:49:15 -0700
Message-ID: <CAEf4BzaW6UfJGFK5hy5JQYsf3qwiqQ81h4Awtkj3XtKv-HKRrA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 01/10] selftests/bpf: Adapt OUTPUT appending
 logic to lower versions of Make
To: Pu Lehui <pulehui@huaweicloud.com>, Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org, 
	netdev@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Pu Lehui <pulehui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 7:17=E2=80=AFAM Pu Lehui <pulehui@huaweicloud.com> w=
rote:
>
> From: Pu Lehui <pulehui@huawei.com>
>
> The $(let ...) function is only supported by GNU Make version 4.4 [0]

Eduard, seems like the mystery is finally solved.

We were actually considering removing the FEATURE-DUMP functionality
from BPF selftests, but it's good to have a fix nevertheless, thanks!

> and above, otherwise the following exception file or directory will be
> generated:
>
>         tools/testing/selftests/bpfFEATURE-DUMP.selftests
>         tools/testing/selftests/bpffeature/
>
> Considering that the GNU Make version of most Linux distributions is
> lower than 4.4, let us adapt the corresponding logic to it.
>
> Link: https://lists.gnu.org/archive/html/info-gnu/2022-10/msg00008.html [=
0]
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 7660d19b66c2..9905e3739dd0 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -187,8 +187,14 @@ FEATURE_TESTS :=3D llvm
>  FEATURE_DISPLAY :=3D $(FEATURE_TESTS)
>
>  # Makefile.feature expects OUTPUT to end with a slash
> +ifeq ($(shell expr $(MAKE_VERSION) \>=3D 4.4), 1)
>  $(let OUTPUT,$(OUTPUT)/,\
>         $(eval include ../../../build/Makefile.feature))
> +else
> +OUTPUT :=3D $(OUTPUT)/
> +$(eval include ../../../build/Makefile.feature)
> +OUTPUT :=3D $(patsubst %/,%,$(OUTPUT))
> +endif
>  endif
>
>  ifeq ($(feature-llvm),1)
> --
> 2.34.1
>

