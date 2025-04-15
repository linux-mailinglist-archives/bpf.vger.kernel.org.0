Return-Path: <bpf+bounces-56011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F0AA8ABCF
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 01:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60F4319037A8
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 23:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855762D8DB6;
	Tue, 15 Apr 2025 23:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6+4l/OM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7C71DF985;
	Tue, 15 Apr 2025 23:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744758340; cv=none; b=mSuuZkzMdIABgssR9aoaIyNoykddEF/UEcNBMgyphHGZLIc2bQC8sD6CDPF3WN2hXlvpz5DyUznFRmDbS+skISND1dJEfuETop9hIoW00uGgUfYUs1vBSonpw9cJQS9TuTvXYM0yqcevTLIW8xWRk7bgY52wEqjaZeRnjPvUSa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744758340; c=relaxed/simple;
	bh=XcKD01C68ObV3ez11XQVvc7vLd13ELQd57RySShHc4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5A9CRsNxEHRHYdEdZ9U1qozgEXdYNe5xvakrmZc/HNB6TUTu0F/d7EkVy9Jjt0JAHynM6lVQ5/ZSD4JBReWnlDoQlf4vLlvK0TlWUWN7kBkU0IG/h8E65jSHgApSHzLu31win92qq/ZJIYJp2l41TuByac2nKUD1+IwCVRvjdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6+4l/OM; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b03bc416962so4300198a12.0;
        Tue, 15 Apr 2025 16:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744758338; x=1745363138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCpMPdp7y2nWx3rZXcw3fGP+V5jDfNkgbODCctZpMXI=;
        b=l6+4l/OMF8qegScUet/it93XLMwUv94oXDFk49szQWMm8Dr7Bs0wCiz92ZTofj7t+4
         uOfuS5tB7c23SExsufMdkiIXbnYmyE2U4xQ+EoN+AUzHKElwDLzd/S6aj4imoAZdlfHb
         42ZfHRXjpuaViYK9pK6LBbhrRMsxYAs4l33E6q1G3FUx/lK0rMUHEY+2bCTCr6gcUwTq
         uunuViAtrpzpV61D7+87IlGlfzv/xJ6/5y34RWp2bkmsYJo5GPpgYCoFEe+6f8Ubum/+
         OZTygx6++w9nDM6LkQCWAU54T8nThC7YYLNSWWehF3qL9uUkSubFIz3UehXJc4LpmqB8
         fs5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744758338; x=1745363138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCpMPdp7y2nWx3rZXcw3fGP+V5jDfNkgbODCctZpMXI=;
        b=NVSk4GVdfMZImXk97hYQO/TTSoChHV44dgcqFgZFcIpKncRZkgHdeK4hE/lZYZIxcz
         fkYf9la1SAEjaHbklT5sg6kdGeEyw9uK/Ogt1tqdokwznVFmJQcVoHs12HqoUG53e8Xi
         D9mWjv81psdru1thXU/+Dt3kwJxCyVe7whsd3GsfYg2tD04SEKlMWEPKvi87byL63car
         ppSt0WSn2qAHz/vCZEDG7gJq1XsN1Lox1xBjpGd6yqO+sI0msb03zEmJshgaKDMRLQ8g
         DStU8tCeUX4VPJZu4Xx6aYjh59gx0Cne1I6n3+PPbvfajp0m20cYqN27OsMvC1FXi43W
         C0qw==
X-Forwarded-Encrypted: i=1; AJvYcCV6tSam5raYvZfGZ2VxsZ3Igoeu1/xH0n1YfpjRIRef0sniXOSHsBVixXjgIGYwJsbu/3Q=@vger.kernel.org, AJvYcCXQ2L75q323c5KPK/FIC4xDyOTLrqcsR8TrBx0bWUy3bP/KEyDgHVMvCNnyZIsuwF4opDrMglh+9fBnhs42@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpz4mfmI4gFE1WaHECA0oNPnz+AqCQpQzjCJvOUW4wbGBFOnC+
	PrtzDwFVjQ/at0lteHLmPhwiAIFzLDfRZt4b9Dbh2cI7bBvdZX8wfzLnEJGP8w6iix76SZtPJ9d
	/lbIra+jYDSl8mzMvOGjWorBp+8Y=
X-Gm-Gg: ASbGncstvgR46TrGeHDwTuAbENNAavHaH+P3W9zRaBtSZLxLt2GCxgSbzAf+3BztKQg
	uLXBtzv1rU4X7KoSCm0ng8a0Vnj/XzjYCll64KHKAceBHDzF+VgFMvZSun/MfAbgy50l3Bk8bWH
	piQdcTPcFW12mxgpL9Om0h/8Jhwm1b2zO+b88vFQ==
X-Google-Smtp-Source: AGHT+IF5hNjKXVAot8qJuF9z0Hirg50L9i9z81g1IAhbJeGvtxojuu9rPx95kPfWePodthoJ+5xUwApq5Q4jRSAEmRo=
X-Received: by 2002:a17:90b:3c11:b0:2fa:1a23:c01d with SMTP id
 98e67ed59e1d1-3085ef39339mr1401910a91.21.1744758337602; Tue, 15 Apr 2025
 16:05:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415093907.280501-1-yangfeng59949@163.com> <20250415093907.280501-2-yangfeng59949@163.com>
In-Reply-To: <20250415093907.280501-2-yangfeng59949@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 15 Apr 2025 16:05:24 -0700
X-Gm-Features: ATxdqUEPMhtV07vfYQ14e-x-PRH9zV5vYulmjtmnH8Y1n1o_qqKHuP09M2TG5eY
Message-ID: <CAEf4BzYZpLOOV5MVxaB4+WPZiO3SjSkNCPrNkd67jZ49kUYDZA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/3] libbpf: Fix event name too long error
To: Feng Yang <yangfeng59949@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, hengqi.chen@gmail.com, 
	olsajiri@gmail.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 2:40=E2=80=AFAM Feng Yang <yangfeng59949@163.com> w=
rote:
>
> From: Feng Yang <yangfeng@kylinos.cn>
>
> When the binary path is excessively long, the generated probe_name in lib=
bpf
> exceeds the kernel's MAX_EVENT_NAME_LEN limit (64 bytes).
> This causes legacy uprobe event attachment to fail with error code -22.
>
> The fix reorders the fields to place the unique ID before the name.
> This ensures that even if truncation occurs via snprintf, the unique ID
> remains intact, preserving event name uniqueness. Additionally, explicit
> checks with MAX_EVENT_NAME_LEN are added to enforce length constraints.
>
> Before Fix:
>         ./test_progs -t attach_probe/kprobe-long_name
>         ......
>         libbpf: failed to add legacy kprobe event for 'bpf_testmod_looooo=
oooooooooooooooooooooooooong_name+0x0': -EINVAL
>         libbpf: prog 'handle_kprobe': failed to create kprobe 'bpf_testmo=
d_looooooooooooooooooooooooooooooong_name+0x0' perf event: -EINVAL
>         test_attach_kprobe_long_event_name:FAIL:attach_kprobe_long_event_=
name unexpected error: -22
>         test_attach_probe:PASS:uprobe_ref_ctr_cleanup 0 nsec
>         #13/11   attach_probe/kprobe-long_name:FAIL
>         #13      attach_probe:FAIL
>
>         ./test_progs -t attach_probe/uprobe-long_name
>         ......
>         libbpf: failed to add legacy uprobe event for /root/linux-bpf/bpf=
-next/tools/testing/selftests/bpf/test_progs:0x13efd9: -EINVAL
>         libbpf: prog 'handle_uprobe': failed to create uprobe '/root/linu=
x-bpf/bpf-next/tools/testing/selftests/bpf/test_progs:0x13efd9' perf event:=
 -EINVAL
>         test_attach_uprobe_long_event_name:FAIL:attach_uprobe_long_event_=
name unexpected error: -22
>         #13/10   attach_probe/uprobe-long_name:FAIL
>         #13      attach_probe:FAIL
> After Fix:
>         ./test_progs -t attach_probe/uprobe-long_name
>         #13/10   attach_probe/uprobe-long_name:OK
>         #13      attach_probe:OK
>         Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>
>         ./test_progs -t attach_probe/kprobe-long_name
>         #13/11   attach_probe/kprobe-long_name:OK
>         #13      attach_probe:OK
>         Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>
> Fixes: 46ed5fc33db9 ("libbpf: Refactor and simplify legacy kprobe code")
> Fixes: cc10623c6810 ("libbpf: Add legacy uprobe attaching support")
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> ---
>  tools/lib/bpf/libbpf.c | 41 +++++++++++++++--------------------------
>  1 file changed, 15 insertions(+), 26 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b2591f5cab65..b7fc57ac16a6 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -60,6 +60,8 @@
>  #define BPF_FS_MAGIC           0xcafe4a11
>  #endif
>
> +#define MAX_EVENT_NAME_LEN     64
> +
>  #define BPF_FS_DEFAULT_PATH "/sys/fs/bpf"
>
>  #define BPF_INSN_SZ (sizeof(struct bpf_insn))
> @@ -11136,16 +11138,16 @@ static const char *tracefs_available_filter_fun=
ctions_addrs(void)
>                              : TRACEFS"/available_filter_functions_addrs"=
;
>  }
>
> -static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
> -                                        const char *kfunc_name, size_t o=
ffset)
> +static void gen_probe_legacy_event_name(char *buf, size_t buf_sz,
> +                                       const char *name, size_t offset)
>  {
>         static int index =3D 0;
>         int i;
>
> -       snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx_%d", getpid(), kfunc_na=
me, offset,
> -                __sync_fetch_and_add(&index, 1));
> +       snprintf(buf, buf_sz, "libbpf_%u_%d_%s_0x%zx", getpid(),
> +                __sync_fetch_and_add(&index, 1), name, offset);
>
> -       /* sanitize binary_path in the probe name */
> +       /* sanitize name in the probe name */
>         for (i =3D 0; buf[i]; i++) {
>                 if (!isalnum(buf[i]))
>                         buf[i] =3D '_';
> @@ -11270,9 +11272,9 @@ int probe_kern_syscall_wrapper(int token_fd)
>
>                 return pfd >=3D 0 ? 1 : 0;
>         } else { /* legacy mode */
> -               char probe_name[128];
> +               char probe_name[MAX_EVENT_NAME_LEN];
>
> -               gen_kprobe_legacy_event_name(probe_name, sizeof(probe_nam=
e), syscall_name, 0);
> +               gen_probe_legacy_event_name(probe_name, sizeof(probe_name=
), syscall_name, 0);
>                 if (add_kprobe_event_legacy(probe_name, false, syscall_na=
me, 0) < 0)
>                         return 0;
>
> @@ -11328,9 +11330,9 @@ bpf_program__attach_kprobe_opts(const struct bpf_=
program *prog,
>                                             func_name, offset,
>                                             -1 /* pid */, 0 /* ref_ctr_of=
f */);
>         } else {
> -               char probe_name[256];
> +               char probe_name[MAX_EVENT_NAME_LEN];
>
> -               gen_kprobe_legacy_event_name(probe_name, sizeof(probe_nam=
e),
> +               gen_probe_legacy_event_name(probe_name, sizeof(probe_name=
),
>                                              func_name, offset);
>
>                 legacy_probe =3D strdup(probe_name);
> @@ -11875,20 +11877,6 @@ static int attach_uprobe_multi(const struct bpf_=
program *prog, long cookie, stru
>         return ret;
>  }
>
> -static void gen_uprobe_legacy_event_name(char *buf, size_t buf_sz,
> -                                        const char *binary_path, uint64_=
t offset)
> -{
> -       int i;
> -
> -       snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx", getpid(), binary_path=
, (size_t)offset);
> -
> -       /* sanitize binary_path in the probe name */
> -       for (i =3D 0; buf[i]; i++) {
> -               if (!isalnum(buf[i]))
> -                       buf[i] =3D '_';
> -       }
> -}
> -
>  static inline int add_uprobe_event_legacy(const char *probe_name, bool r=
etprobe,
>                                           const char *binary_path, size_t=
 offset)
>  {
> @@ -12312,13 +12300,14 @@ bpf_program__attach_uprobe_opts(const struct bp=
f_program *prog, pid_t pid,
>                 pfd =3D perf_event_open_probe(true /* uprobe */, retprobe=
, binary_path,
>                                             func_offset, pid, ref_ctr_off=
);
>         } else {
> -               char probe_name[PATH_MAX + 64];
> +               char probe_name[MAX_EVENT_NAME_LEN];
>
>                 if (ref_ctr_off)
>                         return libbpf_err_ptr(-EINVAL);
>
> -               gen_uprobe_legacy_event_name(probe_name, sizeof(probe_nam=
e),
> -                                            binary_path, func_offset);
> +               gen_probe_legacy_event_name(probe_name, sizeof(probe_name=
),
> +                                           basename((void *)binary_path)=
,

This patch is a nice refactoring overall and I like it. But this (void
*) cast on binary_path I'm not so fond of. Yes, if you read
smallprint, you'll see that with _GNU_SOURCE basename won't *really*
modify input argument, but meh.

Let's instead do a simple `strrchr(binary_path, '/') ?: binary_path`?

pw-bot: cr


> +                                           func_offset);
>
>                 legacy_probe =3D strdup(probe_name);
>                 if (!legacy_probe)
> --
> 2.43.0
>

