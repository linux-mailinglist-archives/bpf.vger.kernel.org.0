Return-Path: <bpf+bounces-77548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C93FBCEAF3F
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 01:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1DC0300A36A
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 00:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92806224FA;
	Wed, 31 Dec 2025 00:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnOfjg64"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AB14A23
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 00:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767139700; cv=none; b=NJ69OdKhXDfQ/g2zihwGVvziv5hfXu7MQrVn0OOf6NUzP095G8fmlIBiuudVWIt1u3mOzKM/hNltuUWYOk7OO8vqtE4XZZh0rIueNPGuiu2WDtzKANHfbZR2+BJB7coygN9M1pYSDIMUIfv9F0QY5+E2k2G3dVeF7zufpSDKeSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767139700; c=relaxed/simple;
	bh=h6W6KcWto0OsziEiwx0e5O7SJqt6L1hY7LfTx05DkkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=usWPA5Ef1f24L6tlcym4Lxga2uNYagzHMQPXYre3CrsYOPWdshGTuxZan+WwXXLC6g2KFwmzoYH1x0aTwVYRehylNmDKZuaAGmt3IT9JkcQXEIM46wgCbVlSc4lEUkaCDvtge0cG67DEMHpKMJei98OUcno6DdfU38Zc3QQZgZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnOfjg64; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD17C116D0
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 00:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767139699;
	bh=h6W6KcWto0OsziEiwx0e5O7SJqt6L1hY7LfTx05DkkI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GnOfjg64w+gXFilD+thFgs40kjmkVkIxwYoCMivN7NgCx5QA34TkBYuPg5bZAFVU8
	 blPqVtes2kPmWRkB5Ra9BD/GBq1bYvurRUze6TN5WLEQOPcK1lsV8uOlPnVIZcTiGB
	 rfI4yMY6yTwtybQrKScPKip9kB29p1S4OZh14ktx9QfafzXppoXd8HRcIo09UfABGg
	 Bi3eF96Pbetzp2QQQ725+hRyLRGkqtnR5NuZKGlEpoTmsTf/MoI8r4sBqueG2UBDXA
	 k3m9WmJSdZ4Hdqe6JncNVec9RbtsT6I2P9nNHOFzJ9JpGJ+s2nzeM242CZ26uj0aqn
	 hQLEeTptZTCbA==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b79e7112398so1837517066b.3
        for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 16:08:19 -0800 (PST)
X-Gm-Message-State: AOJu0Yx7CZoixvjK3UOnA6WWDJu4qwWlVLZbpioK0+3B9V8R30DR4RMQ
	ujmmsd36nNhDXfFP9Wnu9JmXkxaDx6GwJUG3qu3E6AEvtky4bNHJeq/6c4gl8/WMVvaO3S/SoRl
	TzY7CCjnXby9HjKt+tuF/XClV1IZjmZI=
X-Google-Smtp-Source: AGHT+IFHigZXpb/RvWw587CL+a61dnL7KIgvpuUQ31rpU+HiDaHgnKfWDdgNLJRsPrCHHiV6L1cxovZl8wLKe0tAfzY=
X-Received: by 2002:a17:907:b18:b0:b83:95c8:15d0 with SMTP id
 a640c23a62f3a-b8395c818e1mr317021466b.52.1767139697891; Tue, 30 Dec 2025
 16:08:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224192448.3176531-1-puranjay@kernel.org> <20251224192448.3176531-2-puranjay@kernel.org>
 <4cb72b4808c333156552374c5f3912260097af43.camel@gmail.com>
In-Reply-To: <4cb72b4808c333156552374c5f3912260097af43.camel@gmail.com>
From: Puranjay Mohan <puranjay@kernel.org>
Date: Wed, 31 Dec 2025 00:08:06 +0000
X-Gmail-Original-Message-ID: <CANk7y0g6s5C-mLTPUpGyvJC=ZA=v9WawYzbeVgocbsf4dcXJHw@mail.gmail.com>
X-Gm-Features: AQt7F2r1i19UHY8VZdDv4VGx3r3CXOwaZWUZAkPUw7EqmHE5iREEJ8jcJ5hluzU
Message-ID: <CANk7y0g6s5C-mLTPUpGyvJC=ZA=v9WawYzbeVgocbsf4dcXJHw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/7] bpf: Make KF_TRUSTED_ARGS the default for
 all kfuncs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 11:49=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Wed, 2025-12-24 at 11:24 -0800, Puranjay Mohan wrote:
> > Change the verifier to make trusted args the default requirement for
> > all kfuncs by removing is_kfunc_trusted_args() assuming it be to always
> > return true.
> >
> > This works because:
> > 1. Context pointers (xdp_md, __sk_buff, etc.) are handled through their
> >    own KF_ARG_PTR_TO_CTX case label and bypass the trusted check
> > 2. Struct_ops callback arguments are already marked as PTR_TRUSTED duri=
ng
> >    initialization and pass is_trusted_reg()
> > 3. KF_RCU kfuncs are handled separately via is_kfunc_rcu() checks at
> >    call sites (always checked with || alongside is_kfunc_trusted_args)
> >
> > This simple change makes all kfuncs require trusted args by default
> > while maintaining correct behavior for all existing special cases.
>
> While I like the idea behind this patch, I don't think this is 100%
> backwards compatible change. Not unless you check definition of every
> kfunc in the kernel and add appropriate __nullable annotations,
> like you do for some in patch #2.

Yes, I tried to add __nullable to places where I could find using
breaking selftests,
and if a kfunc expects some parameter to be NULL then we will have to
add it to every place.

>
> For example, consider the following kfunc from drivers/hid/bpf/hid_bpf_di=
spatch.c:
>
>   __bpf_kfunc int
>   hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz,
>                      enum hid_report_type rtype, enum hid_class_request r=
eqtype)
>           ... __hid_bpf_hw_check_params(ctx, buf, &size, rtype); ...
>
>
>   static int
>   __hid_bpf_hw_check_params(struct hid_bpf_ctx *ctx, __u8 *buf, size_t *b=
uf__sz,
>                             enum hid_report_type rtype)
>           ...
>           if (... !buf)
>                   return -EINVAL;
>
>   BTF_ID_FLAGS(func, hid_bpf_hw_request, KF_SLEEPABLE)
>
> Currently, it is possible to pass 'buf' parameter as NULL.
> In this particular case it would lead to an error code returned from
> the function, but is it the case for all kfuncs in the kernel?
> For some kfuncs NULL parameter might be expected as a part of a
> non-error scenario.

Yes, if the kfunc expects a parameter to be NULL for both error and
valid cases, it should mark the parameter as __nullable and then the
kfunc needs to take care of handling the NULL value, and the verifier
will allow it.

> Also, there is a question about kfuncs declared in out of tree modules.
>
> So, I think there are two questions to be answered:
> - a review of all kfuncs in the kernel checking if there are
>   sufficient __nullable annotations;
> - are we ready to potentially break BPF programs working with kfuncs
>   defined in out-of-tree modules?
>
> Wdyt?


As Alexei said, the out-of-tree modules are not relevant to the
upstream kernel. I wish to do a full review of all kfuncs and make
sure either they are tagged with correct __nullable, __opt annotation
or fixed to make sure they are doing the right thing. But currently I
just made sure all selftests pass, some of the kfuncs might not have
self tests and would need manual analysis and I will have to do that.

Some kfuncs will have breaking changes, I am not sure how to work
around that case, for example css_rstat_updated() could be
successfully called from fentry programs like the selftest fixed in
Patch 7, it worked because css_rstat_updated() doesn't mark the
parameters with KF_TRUSTED_ARGS, but now KF_TRUSTED_ARGS is the
default so this kfunc can't be called from fentry programs as fentry's
parameters are not marked as trusted.


Looking at the code of css_rstat_updated() it seems that it assumes
the parameters to be trusted and therefore not allowing it to be
called from fentry would be the right thing to do, but it could break
perfectly working BPF programs.

