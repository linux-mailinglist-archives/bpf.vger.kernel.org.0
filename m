Return-Path: <bpf+bounces-70366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE09BB86C1
	for <lists+bpf@lfdr.de>; Sat, 04 Oct 2025 01:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B043F4A2738
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 23:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873A6265296;
	Fri,  3 Oct 2025 23:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CP+IkT7y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DF1258EF0
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 23:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759534657; cv=none; b=nS2FxjEUngcoOdvzDVmZC7uCymLxpuer0HTJof/F2Osd3Gv4r/QpJ9el3cA4DllByaXOB4giQCCFuwkl3ZIW0IIRC86xvwTHPSOuGccpAgerK3n/LhX8ctik4Tv5E2NKyFudt943WatLSxHSYuI0DyNC4MrJ6CXjpJ9KnC0zEw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759534657; c=relaxed/simple;
	bh=GNFmT2VxEaPkh32hnm7rrBTVz4auBq5soR9sb5kDJTs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RCWX8XXDP1FejQQhJ+CoBPJD4tPzPWsiX0capt9Cp+YKLw7Fb61EClcCnSjw2fcoRyE+gsB8kI933wdBWDhcJCIHAaUmeC5EELeP9htq7NgYE5u+rireZhYiryy/141TSuP2otiX++IxSyHnWVP6NPW2WtnNFKWvvL3H726SeVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CP+IkT7y; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7833765433cso3744313b3a.0
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 16:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759534655; x=1760139455; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8opnbw/m2Z8T5yDXIhCeyupu0RmNSEU/h2Gk1+QmiW8=;
        b=CP+IkT7yqUoHZoT7zCW/Gm9XneFhutzrzUrIVZiWwcnMJcBSJ3p1hDaj3yK2mQUl02
         KPW+98yOockhCm2MqcqDsFfSpOmX0Pb6HuI+xgECZSurqSCcQKNqgDn4YF07vAZhgiRj
         f/WephWzE1sBwEM25yu9BuGHOQAJqv1AVT7B3Q44rXFF8QFFCZOtFegmhBCehfn5EC0Z
         j3exu3bw4/ogRD/ICwExcXeJRsr9HnWI4C2cI7MfCEpN60IYwCm7xaEDan1ArbgOdo6p
         cT2xWKnJfsDbvmyDJDOEZbIZrlAEoMhVV/PWA7LrgHy+L3IKpxd4CJkvwJ9TbeQNlVvz
         E4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759534655; x=1760139455;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8opnbw/m2Z8T5yDXIhCeyupu0RmNSEU/h2Gk1+QmiW8=;
        b=EmxzCm5d40J6i6+ON72Iy/on8F5fqNt7W/3tlIz/muoYpoLClclxnuYX4AteT3kegU
         gHpCIszmfT8bKu4mRmPVYtmaesSKLrboVVL6KxfuA0UxIeqIvXari7DClCWC2KVd9AsG
         VDPyp0W/NC/vghX/fPTQoP+zYK2P/vHjxyqGyY28seouU8QMh/YEEurzoN7PxiujbB1z
         h2BxtDaeORhzhzRbeycZN70zGV6XXOQg2Tcecc8UgguM3U7isl4n3U//VfskZxClo2xW
         OFeTBbJmOObf3SBnIyET43lPsjv7JDIGf+HbAd6KWuSqxWB9REoiqKm17FRbap4krdii
         cmoQ==
X-Gm-Message-State: AOJu0YwYu6HqcRdSMDMN6zb5XRxUiFnhpfaX9Dift+lSPYwRCqNABROy
	lxWwOw90CggxA6gpKjh7v4z9vKMPSN1zTtvmQ1El7H3D4SmvhZMXlrXI
X-Gm-Gg: ASbGncuVk8dSWgE/nnWtc87LvQ9JkvvYnLOEIxiwhDYwYagflPSvhOFwESVhprArqhZ
	pVbKLdp23OsCMDmWXW1MuJY4zzmRzH/9VGXrj71Qu5x4Bg3Oj4n5dXYNozJopCEO0EygRuzQDGg
	ShOv2s/bFq0yRzC79q+mqm9+TZDnikGKelgKJ3stDQ0L2HkuvgMbixHJ+QslsJ1mVfccyYxfM4I
	y0G5EB0b8vE9OdFveVwirc8zese7u838vzFRt/LWmhKDdIu8cQgqnKO7i1dtDx1dVgHQ5KBhX14
	0/JD8GS7JxMCiP+Z7StRdw0zB5/ltDRdt9VUgHEcTYwmOfvw2RoKEHRSOP6nPb1aqSwMpYlzsYS
	Q31KIxU1Q200+sVgaBOPF8v7XbefrYlcvUNO3rLb3OY+nZrAU/fn2UkhXriZPzfHW9xaEsYbw
X-Google-Smtp-Source: AGHT+IHwNn3pqjoWotecuXY2Bk382T7KlekPldLWjd7xtyWnaXq++HkfhSeL9JeF/XIh23fgTqEc8A==
X-Received: by 2002:a05:6a00:22c4:b0:781:1b4c:75fb with SMTP id d2e1a72fcca58-78c98dd945emr5793503b3a.18.1759534654703;
        Fri, 03 Oct 2025 16:37:34 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2a3b:74c8:31da:d808? ([2620:10d:c090:500::4:e149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9ac7esm6083494b3a.7.2025.10.03.16.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 16:37:34 -0700 (PDT)
Message-ID: <d108d59be611a63c73303347d07fe0ba5f2b74b7.camel@gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: fix implicit-function-declaration
 errors
From: Eduard Zingerman <eddyz87@gmail.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, ihor.solodrai@linux.dev, 
	alan.maguire@oracle.com
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, Andrii Nakryiko	
 <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann	
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu	
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Shuah Khan <shuah@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers	 <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Date: Fri, 03 Oct 2025 16:37:32 -0700
In-Reply-To: <20251003-bpf-sft-fix-build-err-6-18-v1-1-2a71170861ef@kernel.org>
References: 
	<20251003-bpf-sft-fix-build-err-6-18-v1-1-2a71170861ef@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-03 at 17:24 +0200, Matthieu Baerts (NGI0) wrote:
> When trying to build the latest BPF selftests, with a debug kernel
> config, Pahole 1.30 and CLang 20.1.8 (and GCC 15.2), I got these errors:
>=20
>   progs/dynptr_success.c:579:9: error: call to undeclared function 'bpf_d=
ynptr_slice'; ISO C99 and later do not support implicit function declaratio=
ns [-Wimplicit-function-declaration]
>     579 |         data =3D bpf_dynptr_slice(&ptr, 0, NULL, 1);
>         |                ^
>   progs/dynptr_success.c:579:9: note: did you mean 'bpf_dynptr_size'?
>   .virtme/build-debug-btf//tools/include/vmlinux.h:120280:14: note: 'bpf_=
dynptr_size' declared here
>    120280 | extern __u32 bpf_dynptr_size(const struct bpf_dynptr *p) __we=
ak __ksym;
>           |              ^
>   progs/dynptr_success.c:579:7: error: incompatible integer to pointer co=
nversion assigning to '__u64 *' (aka 'unsigned long long *') from 'int' [-W=
int-conversion]
>     579 |         data =3D bpf_dynptr_slice(&ptr, 0, NULL, 1);
>         |              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   progs/dynptr_success.c:596:9: error: call to undeclared function 'bpf_d=
ynptr_slice'; ISO C99 and later do not support implicit function declaratio=
ns [-Wimplicit-function-declaration]
>     596 |         data =3D bpf_dynptr_slice(&ptr, 0, NULL, 10);
>         |                ^
>   progs/dynptr_success.c:596:7: error: incompatible integer to pointer co=
nversion assigning to 'char *' from 'int' [-Wint-conversion]
>     596 |         data =3D bpf_dynptr_slice(&ptr, 0, NULL, 10);
>         |              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> I don't have these errors without the debug kernel config from
> kernel/configs/debug.config. With the debug kernel, bpf_dynptr_slice()
> is not declared in vmlinux.h. It is declared there without debug.config.
>=20
> The fix is similar to what is done in dynptr_fail.c which is also using
> bpf_dynptr_slice(): bpf_kfuncs.h is now included.
>=20
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---

I can reproduce similar issue when including
kernel/configs/debug.config with my regular dev config, but for
different functions: bpf_rcu_read_{un,}lock().

However, this is not a way to fix this.
Kfuncs are not supposed to just disappear from DWARF.

Running pahole in verbose mode I see the following output:

  $ pahole -V \
      --btf_features=3Dencode_force,var,float,enum64,decl_tag,type_tag,opti=
mized_func,consistent_func,decl_tag_kfuncs \
      --btf_features=3Dattributes \
      --lang_exclude=3Drust \
      --btf_encode_detached=3D/dev/null vmlinux
  ...
  matched function 'bpf_rcu_read_lock' with 'bpf_rcu_read_lock.cold'
  ...

Alan, Ihor, does this sound familiar?

