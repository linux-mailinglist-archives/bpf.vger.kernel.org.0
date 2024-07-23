Return-Path: <bpf+bounces-35451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F325093A962
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 00:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF35A283CA9
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 22:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7568814884B;
	Tue, 23 Jul 2024 22:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XbiOFfWD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D21B143C77
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 22:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721774137; cv=none; b=PbcRProlXhL8HPSilp4qaC9sFWSm2wHyX3ZO2i34hVFDAsjbpr+t61v/Ou+RQ+vG1wrpHSREtCnobDky0jbdJI4nqCWnr0S2GPc/fGIf0ZiGdOT8Vn8VpaSzahc13NgNFn5BsJOGxB2VtBF24ryTmuV7sb878Glly119CNtTe10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721774137; c=relaxed/simple;
	bh=Bq0LGm7kqltWE6RamFRrFTZETEQtLNr0hZ4SmD0HhkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=thURGtsl/Vgwh7s8xfwmeZ98E3SvDcEGQKbYfbPTBVZ4+1vKLfKTyHdHuXbctVI3ndoNZk2KI+A9ilmPUafc2Q8uHdKxU9ph+LPOOrEM6qYtuU7e9Fh3eiD17vXpY1aKmOu98lE9Bl8WQj2grqMc1eHRvu2vr36iUrMcJBYUrp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XbiOFfWD; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a1337cfbb5so6260983a12.3
        for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 15:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721774134; x=1722378934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBh9jmyTekte+QvpGQRbc5vXty4hPQS11N7+FKceOaU=;
        b=XbiOFfWDhd8N9YoJ4BiqaQIqEKcrFDJBFpWKpnFrYy0X11x5uBFpm3P5aF9553yo+6
         BWEc3zZFj1/3L+2D1nYD2j7CwL+lmBr/P5RVQs1A84PkeLbMAa296feFBu2G2LrtxTGX
         Hh39rDngo0kMdZ02f+rlk5qgq7b4fM8gO443nBWn6swxiJqyL12mcIRf4A4Y2i44vJSI
         srpeauyMSfxrz8IuW/qh30qwJ+7majDt190/kuNGSzxfPWcdgv/iiMO1H6z00qoK03/n
         faryINpgIFNGij7rxIvrpH6UAaPtTh+WpK1akecE3Bw5rinYptziaJtVG7+QNgPA1roq
         S6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721774134; x=1722378934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kBh9jmyTekte+QvpGQRbc5vXty4hPQS11N7+FKceOaU=;
        b=flUazuus6IeQNUutnq2JlNbuKAw+9wyqRD6+japUxMfq6YEizFikTK6dymm7CsJVoa
         mep2S6xxI2aE7rp6Oc8N1Aa3Fa3GyqBRl8yV7lZVj3vRM2BvgvMUBoOr4BwBziGr0KwF
         J3IU7yyq9+sHyVm91FclP46VQm0AICjWk38S+Kj5Jd7MK5QTLGe8BZEtLcWwPe3sHHwO
         qzHsrPoyFtIznYrqOi5KVcrdIWfyf2yr2mDbJkchWfcmlwyEuJSr6o9MZeWPQbX96bQR
         A7oHSG6YgaFeS037CkW1/rf0cp4cZ1rd2UjJW1gUiYPxPDv7JKoThJzOC6oYCNfj3xiF
         nxLA==
X-Gm-Message-State: AOJu0YxcFuI6g9yEdeIO5inUbED+Y5Ie5PHfUPG2hDY+Q/3aqOJS9peB
	pe2VFiKVyHMCMicfq6bs+7c6/F4bhu8ywYyF7FeKYzH22z86RaIY2ebJdoJRAeyHAFowO7xJF80
	scGOAYlf+X83OC+Uba7hpGX06I0JLxAnsUPu2
X-Google-Smtp-Source: AGHT+IEyVqJvzIuhy6mXH0U45aIDac2Ff/JCBsu+9NCJenoAxeGYarTIMpIDyvdx6qQU6CRnPJV2KaPioxWd2WC+PpI=
X-Received: by 2002:a17:907:3e21:b0:a77:b052:877e with SMTP id
 a640c23a62f3a-a7ab0d91274mr19715066b.19.1721774133116; Tue, 23 Jul 2024
 15:35:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1721713597.git.tony.ambardar@gmail.com> <4f4702e9f6115b7f84fea01b2326ca24c6df7ba8.1721713597.git.tony.ambardar@gmail.com>
In-Reply-To: <4f4702e9f6115b7f84fea01b2326ca24c6df7ba8.1721713597.git.tony.ambardar@gmail.com>
From: YiFei Zhu <zhuyifei@google.com>
Date: Tue, 23 Jul 2024 15:35:22 -0700
Message-ID: <CAA-VZPm-tBOD_vfYeLs57gPkoJmbZTw-4odO05H_UxTvZLvPTg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 19/19] selftests/bpf: Fix errors compiling
 cg_storage_multi.h with musl libc
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Yucong Sun <sunyucong@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.co.jp>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Dave Marchevsky <davemarchevsky@fb.com>, David Vernet <void@manifault.com>, 
	Carlos Neira <cneirabustos@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Petar Penkov <ppenkov@google.com>, Willem de Bruijn <willemb@google.com>, Yan Zhai <yan@cloudflare.com>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 10:56=E2=80=AFPM Tony Ambardar <tony.ambardar@gmail=
.com> wrote:
>
> Remove a redundant include of '<asm/types.h>', whose needed definitions a=
re
> already included (via '<linux/types.h>') in cg_storage_multi_egress_only.=
c,
> cg_storage_multi_isolated.c, and cg_storage_multi_shared.c. This avoids
> redefinition errors seen compiling for mips64el/musl-libc like:
>
>   In file included from progs/cg_storage_multi_egress_only.c:13:
>   In file included from progs/cg_storage_multi.h:6:
>   In file included from /usr/mips64el-linux-gnuabi64/include/asm/types.h:=
23:
>   /usr/include/asm-generic/int-l64.h:29:25: error: typedef redefinition w=
ith different types ('long' vs 'long long')
>      29 | typedef __signed__ long __s64;
>         |                         ^
>   /usr/include/asm-generic/int-ll64.h:30:44: note: previous definition is=
 here
>      30 | __extension__ typedef __signed__ long long __s64;
>         |                                            ^
>
> Fixes: 9e5bd1f7633b ("selftests/bpf: Test CGROUP_STORAGE map can't be use=
d by multiple progs")
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> ---
>  tools/testing/selftests/bpf/progs/cg_storage_multi.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/cg_storage_multi.h b/tools=
/testing/selftests/bpf/progs/cg_storage_multi.h
> index a0778fe7857a..41d59f0ee606 100644
> --- a/tools/testing/selftests/bpf/progs/cg_storage_multi.h
> +++ b/tools/testing/selftests/bpf/progs/cg_storage_multi.h
> @@ -3,8 +3,6 @@
>  #ifndef __PROGS_CG_STORAGE_MULTI_H
>  #define __PROGS_CG_STORAGE_MULTI_H
>
> -#include <asm/types.h>
> -
>  struct cgroup_value {
>         __u32 egress_pkts;
>         __u32 ingress_pkts;
> --
> 2.34.1
>

Hmm, some linter checks prefer headers themselves include everything
they use. This header uses __u32 and after this patch it would include
no headers. Would it be okay to include <linux/types.h> or we don't
care?

YiFei Zhu

