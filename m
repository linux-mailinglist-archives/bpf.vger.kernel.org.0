Return-Path: <bpf+bounces-57138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B498AAA6287
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 19:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F20E3A98EF
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 17:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83643219307;
	Thu,  1 May 2025 17:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bo5HInxl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA6420C006
	for <bpf@vger.kernel.org>; Thu,  1 May 2025 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746122078; cv=none; b=kOdEqzRIyfyzPPeMmoMR/IkRssJm3T7DO9L7CfWVrWXuCCWBZz7NgxpnFAQbkfBJl/jiP2SVzSfLtfWiAFR2m+G02FEBsMZJ3fRgZMV19ek2n2KEgwypK7ClxbRpUReFVKqPp3Umd6hndemKOZFZIMBfyIbFSNFK0x/pjQ9bCrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746122078; c=relaxed/simple;
	bh=rEImKoA0+1isNlRp9DyfRJ0GgXo7FPmXbk1NZdrzvTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bxDK+cfm9OnVh4xCZ8ce2lAH2Lukd2S+FK+HCDLV7YJkTEjk5RJ1aYvLNCWkrfGTABhkKtUQj+97euR4onyuq7dU40ocnpSJ7CqToyd9Bsflm8rSCAqnm/ed+c2jXq8AyAgOI3cWF7BGOt5h2MpzHd8KHCT1EOq0zWfXyd70wfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bo5HInxl; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-af50f56b862so912069a12.1
        for <bpf@vger.kernel.org>; Thu, 01 May 2025 10:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746122076; x=1746726876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylbcDnUxX7H5FNMcAE+gUHBv+0ktb9drnGdNPe06scQ=;
        b=Bo5HInxl0A1zqIGPNXUMyOrJM0qMO/rN+zJbd+kA5dyWmGByHq1A6dSpj5zKmUtLVh
         OqnQOV+EM8echHJdOJA6u969poNkn8exZRJCMN7rovI8IRIKp//3TAZLdHwwEVJEUpaI
         vnh7Ow2U/UPQMRD+vHv1OsQk+p++hjasncXiw8MrVmJ8Or1QbEdwd5SZdjcXk3nv7PJ+
         jmwU9Mf50LDtpfKd3kvqThnWlE936Ivuq7RmS9Zry95gbMoYtU2n1MxpY0RvFVXJ6Ep+
         klKjQN90y3P9RzfhxAl1pUTm8QTSt413eoT35m2CV28q6l14dDMYt89C8TTQvsD5HNub
         rp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746122076; x=1746726876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylbcDnUxX7H5FNMcAE+gUHBv+0ktb9drnGdNPe06scQ=;
        b=o/8szJjdCLR3WcTvX4I9q3CAkfd/rkvQXw7YWH5fz6DcOGQsX8GKcZymEoJI/4Akro
         O/zqfZ9+lFZ3WysT1ceZPHsi1VYydhQK4WdNREhruf1FEttThasm1PAHNFyuuIdWOWja
         2PnnIWBxX5ym/vzb4a+dnssJW9h3JYF5+WNz+vIA51aRfaF3AdNE9Lc9His2WVYYXwcL
         A4BaFRTEjwMWALJGXjsd3k2LA/djSOJWg5opmI5UkuGV1EHOWls5/2Bk5GTyHGJglyzL
         OZSG90y6v8Dj7CKP7hzaw1zO0lEcnD/vz8v3bfhnXRlovkTxstK0iBwJwJQxvOI17ET2
         RQEw==
X-Gm-Message-State: AOJu0Yy7Xh1KQTToANm0NGMv/11zbCdrFYQQ4aoCtJkTIUXHMXXt/xed
	RkF+0scmJ1wETkXHJt7khJcIenFl81D/LxpSURD182NGJmc05Tk9LFCQVpxKzmMOsvwObAWk0rE
	gBAFOJoYh7WBYsySp1ei+iBIRJD+zyMkPpaA=
X-Gm-Gg: ASbGncuBR4njNYHI3xOMddGrMYjNTp42v6HY7L7a1+UJSLzqfcpBwRblUblmNWMhBqk
	Rb7osf9JmUg5TLtjTD7Bq7P6dtroBpk+RyyUITpZnr6kn6angtmsrEtqADcBB0CZRuZuq4SOzVI
	DJzWkhKmCBKfN5/A60dn/OXahsbZxzqn7g9aaJuw==
X-Google-Smtp-Source: AGHT+IHdchcvrASh+Xdax3klI2O4eCkNDNeR4BbAQ9CTiZdaiMuZvytA5FLVHcqGPGeja3JV4yyxnasrAVt8WZbH/5s=
X-Received: by 2002:a17:90b:58d0:b0:2fa:13d9:39c with SMTP id
 98e67ed59e1d1-30a4e5a50d3mr102375a91.14.1746122075822; Thu, 01 May 2025
 10:54:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428211536.1651456-1-zhuyifei@google.com>
In-Reply-To: <20250428211536.1651456-1-zhuyifei@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 1 May 2025 10:54:23 -0700
X-Gm-Features: ATxdqUEA43XQokPeqBnp44tV8Pcu1jTbNjVrXZ9PjgudN_jVSlWRbes-rWz7VfA
Message-ID: <CAEf4BzZXpWC8nWb4zF37PpDX0Y+Bk9=vw8iL5Ehqcjr-Bw=dNQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpftool: Fix regression of "bpftool cgroup tree"
 EINVAL on older kernels
To: YiFei Zhu <zhuyifei@google.com>
Cc: bpf@vger.kernel.org, Quentin Monnet <qmo@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Kenta Tada <tadakentaso@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Ian Rogers <irogers@google.com>, Greg Thelen <gthelen@google.com>, 
	Mahesh Bandewar <maheshb@google.com>, Minh-Anh Nguyen <minhanhdn@google.com>, 
	Sagarika Sharma <sharmasagarika@google.com>, XuanYao Zhang <xuanyao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 2:15=E2=80=AFPM YiFei Zhu <zhuyifei@google.com> wro=
te:
>
> If cgroup_has_attached_progs queries an attach type not supported
> by the running kernel, due to the kernel being older than the bpftool
> build, it would encounter an -EINVAL from BPF_PROG_QUERY syscall.
>
> Prior to commit 98b303c9bf05 ("bpftool: Query only cgroup-related
> attach types"), this EINVAL would be ignored by the function, allowing
> the function to only consider supported attach types. The commit
> changed so that, instead of querying all attach types, only attach
> types from the array `cgroup_attach_types` is queried. The assumption
> is that because these are only cgroup attach types, they should all
> be supported. Unfortunately this assumption may be false when the
> kernel is older than the bpftool build, where the attach types queried
> by bpftool is not yet implemented in the kernel. This would result in
> errors such as:
>
>   $ bpftool cgroup tree
>   CgroupPath
>   ID       AttachType      AttachFlags     Name
>   Error: can't query bpf programs attached to /sys/fs/cgroup: Invalid arg=
ument
>
> This patch restores the logic of ignoring EINVAL from prior to that patch=
.
>
> Fixes: 98b303c9bf05 ("bpftool: Query only cgroup-related attach types")
> Reported-by: Sagarika Sharma <sharmasagarika@google.com>
> Reported-by: Minh-Anh Nguyen <minhanhdn@google.com>
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> ---
>  tools/bpf/bpftool/cgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
> index 93b139bfb9880..3f1d6be512151 100644
> --- a/tools/bpf/bpftool/cgroup.c
> +++ b/tools/bpf/bpftool/cgroup.c
> @@ -221,7 +221,7 @@ static int cgroup_has_attached_progs(int cgroup_fd)
>         for (i =3D 0; i < ARRAY_SIZE(cgroup_attach_types); i++) {
>                 int count =3D count_attached_bpf_progs(cgroup_fd, cgroup_=
attach_types[i]);
>
> -               if (count < 0)
> +               if (count < 0 && errno !=3D EINVAL)
>                         return -1;

let's maybe change count_attached_bpf_progs() to return error directly
as returned by bpf_prog_query(), instead of translating that to -1 and
then requiring relying on errno?

so just

if (ret)
    return ret;

and then just

if (count < 0 && count !=3D -EINVAL)
    return /* well whatever, I'd return error probably instead of -1 again =
*/

Thoughts?


pw-bot: cr


>
>                 if (count > 0) {
> --
> 2.49.0.901.g37484f566f-goog
>

