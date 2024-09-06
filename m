Return-Path: <bpf+bounces-39170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FED996FD47
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 23:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC6AA1C23907
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 21:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08661586CF;
	Fri,  6 Sep 2024 21:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtM9RWGz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47AB13E03E;
	Fri,  6 Sep 2024 21:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725657915; cv=none; b=KLoFTwFQmW2USQdtOHEhVdzob+hoIzqjHYqHSiGV/SVTl+Ve0onFnUgQF8V88oMlkLlgo2uvqbxSlS9xlDC3/5bjPNTV92S6q/W02MBxQ9757sgd/MLbbC2Ral4X15/rHz6WNkUZI8BHvG0cyeIWwsZt/phl8pXgsSHumeiBKOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725657915; c=relaxed/simple;
	bh=xkMofZody4tGm6dhu9cY/bqfgjOqNIgQX6J8vRn4lsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RKRFUC59U8l2Wnbt2mkxJpb35w5zrDpaFEEJC/OoZSDIp6mfaCt4uwmAAjZmtKaH5HVyqR417SVEOXmsMzylDSPxaob8ZqGnir2v3CWauf7gIScGxoZ9gcMbeJ4/ztF02E2jogCX1XH4cLHrm4/n8Ht7HVIQ/OotjKcbr6gtT6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtM9RWGz; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d89dbb60bdso1802365a91.1;
        Fri, 06 Sep 2024 14:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725657913; x=1726262713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9vqWRKC7VSZDMm7C7/NsCR+oHJ/Sr0ZUpoeBC/vTVs=;
        b=WtM9RWGzKda8lWSF2soUBHNfYftEgOmHaWLe0xVaVzRXhg2XHX40QgclsnarOXIvGL
         0ldRTvZiwO32JkUfFgkawS5WIKQBGePlCTnAfO8JcJMDhem9xMAQpKg/93aZoHKtThHp
         I2/8xQSe1EseO20d85enFE76cmdjdYILFvmQ0erIOaO9YQCiNz4u3gF9rd69hfTcdS2t
         jlBOOC9+DeFz+iUVTAaC2eL5j6l3FKIxUqUZpHaIt7Kqrcy15OFqGVqWepd5f3gDbM8E
         +0UrV9na7LIPwTmFyzhlcQw3xxi3MlcH7T3GU1cNA66SHdK3D1pQ8ZXtLE82I+a9U8me
         957A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725657913; x=1726262713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D9vqWRKC7VSZDMm7C7/NsCR+oHJ/Sr0ZUpoeBC/vTVs=;
        b=mUcbHxRHUKmIzqGF4f+aspHfRr9kr7gcZDT0pSUDn9eTRoHpFwHPZ2lS2b+ZHBKXRH
         231xpfYQOg4ur8wiYH7XbCI0LKsHYP68KuQZnBl7h8uWQxVST2b9zsc4bODUfSonMXyC
         inVMfVbI/F9hfz7djZHRR8WaUmm5ZXr67DD5aSkWnMwF/yZ/M9mzwXBdQhj7wrsgtd3W
         YTtKHgxd1jCULrYWqbU/gmZt/4NEO23rqzJ77AtNuK8l6f2JyzlGYTwwqJ5U2maGxUCy
         +5ehYWZNQslt54h3AwDi6JpgK9c/ZH9R8fFgRmKfVTi+rL+sE5FzWiEzSCGDQQFakDJC
         WhTg==
X-Forwarded-Encrypted: i=1; AJvYcCU62h1O1UwWqaoeeXAusMc28ax4t70RIFVOBOCKtH+rPvGhRT4D3UUy8pdBqA5RKNDPy1rjoqs5OVgb/yF6DkIBAps=@vger.kernel.org, AJvYcCUL4tSmvWpGWj1PA0wMdo/hSncHjOSGL1AHEoiVFOaM6EDMv+gbTqbq52nt2SK6/VxNkzWwL4cU@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhi4i1hvcuFJ1qm0SWasHSec+sSeBffzlrxyFW9FjXsKNFH2Gh
	bJH5Rjl1D1KCAFj6I+HESOt0h+PGwxt40rR9f84jobWH1PDfaDpSgqWtvw5MHCXde67ZeYJPkOb
	rXEZ3moweDWsMYjWiiA4+qakgdPs=
X-Google-Smtp-Source: AGHT+IE1shvsV28zRxcoBbFXnJKkcyGbF1C+clliWMVn3QT3zdYLKG6XWyBrDEAiZKw14W78mvPfhpHfvNYaHKKtYuk=
X-Received: by 2002:a17:90b:4c4d:b0:2d8:adea:9940 with SMTP id
 98e67ed59e1d1-2daffa7d692mr485138a91.16.1725657913112; Fri, 06 Sep 2024
 14:25:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905075622.66819-1-lulie@linux.alibaba.com> <20240905075622.66819-2-lulie@linux.alibaba.com>
In-Reply-To: <20240905075622.66819-2-lulie@linux.alibaba.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Sep 2024 14:25:00 -0700
Message-ID: <CAEf4BzYjGaJGzw+dXCOhUwJS-QhyZ-_sWL6Oo8yUXOoeWWA1=w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/5] bpf: Support __nullable argument suffix
 for tp_btf
To: Philo Lu <lulie@linux.alibaba.com>
Cc: bpf@vger.kernel.org, edumazet@google.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, martin.lau@linux.dev, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, mykolal@fb.com, 
	shuah@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	thinker.li@gmail.com, juntong.deng@outlook.com, jrife@google.com, 
	alan.maguire@oracle.com, davemarchevsky@fb.com, dxu@dxuuu.xyz, 
	vmalik@redhat.com, cupertino.miranda@oracle.com, mattbobrowski@google.com, 
	xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 12:56=E2=80=AFAM Philo Lu <lulie@linux.alibaba.com> =
wrote:
>
> Pointers passed to tp_btf were trusted to be valid, but some tracepoints
> do take NULL pointer as input, such as trace_tcp_send_reset(). Then the
> invalid memory access cannot be detected by verifier.
>
> This patch fix it by add a suffix "__nullable" to the unreliable
> argument. The suffix is shown in btf, and PTR_MAYBE_NULL will be added
> to nullable arguments. Then users must check the pointer before use it.
>
> A problem here is that we use "btf_trace_##call" to search func_proto.
> As it is a typedef, argument names as well as the suffix are not
> recorded. To solve this, I use bpf_raw_event_map to find
> "__bpf_trace##template" from "btf_trace_##call", and then we can see the
> suffix.
>
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> ---
>  kernel/bpf/btf.c      | 13 +++++++++++++
>  kernel/bpf/verifier.c | 36 +++++++++++++++++++++++++++++++++---
>  2 files changed, 46 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 1e29281653c62..157f5e1247c81 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6385,6 +6385,16 @@ static bool prog_args_trusted(const struct bpf_pro=
g *prog)
>         }
>  }
>
> +static bool prog_arg_maybe_null(const struct bpf_prog *prog, const struc=
t btf *btf,
> +                               const struct btf_param *arg)
> +{
> +       if (prog->type !=3D BPF_PROG_TYPE_TRACING ||
> +           prog->expected_attach_type !=3D BPF_TRACE_RAW_TP)
> +               return false;
> +
> +       return btf_param_match_suffix(btf, arg, "__nullable");

why does this need to be BPF_TRACE_RAW_TP-specific logic? Are we
afraid that there might be "some_arg__nullable" argument name?..

> +}
> +
>  int btf_ctx_arg_offset(const struct btf *btf, const struct btf_type *fun=
c_proto,
>                        u32 arg_no)
>  {

[...]

> @@ -21923,10 +21929,34 @@ int bpf_check_attach_target(struct bpf_verifier=
_log *log,
>                         return -EINVAL;
>                 }
>                 tname +=3D sizeof(prefix) - 1;
> -               t =3D btf_type_by_id(btf, t->type);
> -               if (!btf_type_is_ptr(t))
> -                       /* should never happen in valid vmlinux build */
> +
> +               /* The func_proto of "btf_trace_##tname" is generated fro=
m typedef without argument
> +                * names. Thus using bpf_raw_event_map to get argument na=
mes. For module, the module
> +                * name is printed in "%ps" after the template function n=
ame, so use strsep to cut
> +                * it off.
> +                */
> +               btp =3D bpf_get_raw_tracepoint(tname);
> +               if (!btp)
>                         return -EINVAL;

there has to be bpf_put_raw_tracepoint() somewhere below

pw-bot: cr

> +               sprintf(trace_symbol, "%ps", btp->bpf_func);

snprintf, but this is really a very round-about way of doing kallsym
lookup, no? Why not call kallsyms_lookup() directly?


> +               fname =3D trace_symbol;
> +               fname =3D strsep(&fname, " ");
> +
> +               ret =3D btf_find_by_name_kind(btf, fname, BTF_KIND_FUNC);
> +               if (ret < 0) {
> +                       bpf_log(log, "Cannot find btf of template %s, fal=
l back to %s%s.\n",
> +                               fname, prefix, tname);
> +                       t =3D btf_type_by_id(btf, t->type);
> +                       if (!btf_type_is_ptr(t))
> +                               /* should never happen in valid vmlinux b=
uild */
> +                               return -EINVAL;
> +               } else {
> +                       t =3D btf_type_by_id(btf, ret);
> +                       if (!btf_type_is_func(t))
> +                               /* should never happen in valid vmlinux b=
uild */
> +                               return -EINVAL;
> +               }
> +
>                 t =3D btf_type_by_id(btf, t->type);
>                 if (!btf_type_is_func_proto(t))
>                         /* should never happen in valid vmlinux build */
> --
> 2.32.0.3.g01195cf9f
>

