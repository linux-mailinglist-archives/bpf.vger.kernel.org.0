Return-Path: <bpf+bounces-21247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E47884A2DA
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 19:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEEB328A975
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 18:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A46481AE;
	Mon,  5 Feb 2024 18:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRdI9u14"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68D34B5A7
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 18:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159397; cv=none; b=CiSg3vQj3K1pCM+kId7ZUYmfGa77tBh0e4/t/gKYhrkY3ykXJqRvzFS9PUUEXTVMBJHVYwhZQg5E+E5gaTd1k7qGLZ4yq8vWUyEkhaOdMWvxSb1nrApcPdlW7MCGNAJ4+gUnZqzpCvM6sTjHW41par0hbOJFIDeYKTlYvCH6jhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159397; c=relaxed/simple;
	bh=tFogLAju+axhDPYDDa5tbnZn5vpq4vPKk/nESP8dVY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPe4ugOhXmoMxJIJ2UXAgPPfF46lUPhuOVhfrPQWF295xtIgDzbdwv2rF3lsICZ7bc78Z0vNxaSGBX0a8AuQgUx7YuQoJx9b/Yadg+7dX92THE4Cb3IDGa+83aC9cWCjVmKB8lRV2iwpDtvhHlgTM+EtM3IJk5I24AI7ydZNtZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRdI9u14; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5cddfe0cb64so3788895a12.0
        for <bpf@vger.kernel.org>; Mon, 05 Feb 2024 10:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707159395; x=1707764195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygKVCSonAaH48LfrTL/3k9Rs3m+QBfESvOLhT7tIgPU=;
        b=JRdI9u14EPk6j3WtdQtk3w83/WEa52dZfx/5KxMf/9vDxnbPuArQR5vowtDUfH7+mk
         FEu282VXymLtWcz1gmjEeWYynL7Uk1ok8M4BtwT1HrLIMdfLFC/lPCK7KvbYhWS8R0b6
         jQkxt51IhpssMzkDr2pMNod/HNItPpB3V7iV4BnEzhb6+VpkSneQveripkyUtTSBxiXZ
         4DOsbhLJ/V3YT0s4rAUEz6bH4GjjR7WMS3fxqnrjR++hfOhR+M5Toam0B7QlqKz6YQDG
         migbclUEMo7QGzFaYll07MFn2F1uouzBbir5ucZUtU9CLInW7vMooFe6l7wTnXCk9gUv
         zSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707159395; x=1707764195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygKVCSonAaH48LfrTL/3k9Rs3m+QBfESvOLhT7tIgPU=;
        b=cAfMYbmtJ4HbxK9a/ALmIJW+fwSyevSy4t4GZbrp84xSV+jW8XahT9W2ZS4aZQa3E/
         A60FmJIdAvACrJSy8hfCzeO9cOlzsrdu2Td8/WiElL9UVnKY2klftRYzUDjroNkDS05x
         souKkWv97vRtbG7yFpy7GWxM0T3vCvmp9AgblQFcpAKiuaYVlbB3oiG2fJUzfwOYAxQW
         B7IfKxtUzYYjw9vRWPpvNrc4liIGMpYhzvoP4xtsKq1ucr/iSUhixuWWuiGvw6CWSxKM
         eb51ZTL5ia05Y9DDg3kgGIDAZ0wQpPz+mQ0u8bJDXABaRIR27II/LpsEif5U/Svo73ff
         14iQ==
X-Gm-Message-State: AOJu0YweM9ZDIvUqjvGaCmkQmwrYnBPSBYIOVbO2rKyBXZPqSgVV7m5J
	Q99/6f0gnWy+hBM4yzbvNh1qYFC7bydUW3p8x97IeEP9JPEFN5laTwqPIkkSZSbfUjHY5Iv1rLN
	VfNfETFl6rVMWtwnqefC5hAy4chc=
X-Google-Smtp-Source: AGHT+IGsi/qRxZSawshGrdrD7/8KizUo4ktul6AZ1O2HFhphfKJjyxPE7xgdnzBPAxGp4APAmdPBeippRjCrSpORQdg=
X-Received: by 2002:a05:6a00:938d:b0:6df:f634:4f83 with SMTP id
 ka13-20020a056a00938d00b006dff6344f83mr570452pfb.2.1707159394767; Mon, 05 Feb
 2024 10:56:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204194452.2785936-1-yonghong.song@linux.dev>
In-Reply-To: <20240204194452.2785936-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 5 Feb 2024 10:56:22 -0800
Message-ID: <CAEf4BzZhg13E=-z1yUKwtiXOeNwaA8m5N_jaTW_DRGV7ZdFE9A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix flaky test ptr_untrusted
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 4, 2024 at 11:45=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> Somehow recently I frequently hit the following test failure
> with either ./test_progs or ./test_progs-cpuv4:
>   serial_test_ptr_untrusted:PASS:skel_open 0 nsec
>   serial_test_ptr_untrusted:PASS:lsm_attach 0 nsec
>   serial_test_ptr_untrusted:PASS:raw_tp_attach 0 nsec
>   serial_test_ptr_untrusted:FAIL:cmp_tp_name unexpected cmp_tp_name: actu=
al -115 !=3D expected 0
>   #182     ptr_untrusted:FAIL
>
> Further investigation found the failure is due to
>   bpf_probe_read_user_str()
> where reading user-level string attr->raw_tracepoint.name
> is not successfully, most likely due to the
> string itself still in disk and not populated into memory yet.
>
> One solution is do a printf() call of the string before doing bpf
> syscall which will force the raw_tracepoint.name into memory.
> But I think a more robust solution is to use bpf_copy_from_user()
> which is used in sleepable program and can tolerate page fault,
> and the fix here used the latter approach.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/testing/selftests/bpf/progs/test_ptr_untrusted.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/test_ptr_untrusted.c b/too=
ls/testing/selftests/bpf/progs/test_ptr_untrusted.c
> index 4bdd65b5aa2d..2fdc44e76624 100644
> --- a/tools/testing/selftests/bpf/progs/test_ptr_untrusted.c
> +++ b/tools/testing/selftests/bpf/progs/test_ptr_untrusted.c
> @@ -6,13 +6,13 @@
>
>  char tp_name[128];
>
> -SEC("lsm/bpf")
> +SEC("lsm.s/bpf")
>  int BPF_PROG(lsm_run, int cmd, union bpf_attr *attr, unsigned int size)
>  {
>         switch (cmd) {
>         case BPF_RAW_TRACEPOINT_OPEN:
> -               bpf_probe_read_user_str(tp_name, sizeof(tp_name) - 1,
> -                                       (void *)attr->raw_tracepoint.name=
);
> +               bpf_copy_from_user(tp_name, sizeof(tp_name) - 1,
> +                                  (void *)attr->raw_tracepoint.name);

Should we also add bpf_copy_from_user_str (and
bpf_copy_from_user_str_task) kfuncs to complete bpf_copy_from_user?
This change is not strictly equivalent (though for tests it's fine,
but in real-world apps it would be problematic).

>                 break;
>         default:
>                 break;
> --
> 2.34.1
>

