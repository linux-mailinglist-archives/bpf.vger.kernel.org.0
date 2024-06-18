Return-Path: <bpf+bounces-32474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C641A90DF74
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 00:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A764B21728
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 22:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F26F17D89F;
	Tue, 18 Jun 2024 22:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhMbUV+R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA3316D9A0
	for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 22:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718751211; cv=none; b=QLzfTl7JnJBC8N0gDeemdFaj3CkjeRDlE2CIQkkNZ7eXs2Ic+yZY2GPVstAIrC91ILCH36K7LbTPMvAfh77hd3/CMS7K13e0mEo+LvmM7XAv419InpEcHHNwOGaHVXLnOmyH28Rk6SSZtB41bNR0+edVJlxpGDUN68vbDtXjs/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718751211; c=relaxed/simple;
	bh=TPF4ybM18gst73nerrf40r5IxfEVPYsQq0ipsfQyh2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IhD0ciIJeHf0fMePkUkMGogGbi3pB2pjqVUkU+x6udoEJvaaz5b6XOmKe9alklrfYepESnFhi9OW+0sUxLAtUR6OJomgAuRlurHCE+Zq1iEwFuDVxkj91kVk9WRTwF4FDO4Myht1wmKunuBdbMDTECpVCo94n+RTA5eryeL+srU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhMbUV+R; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c2eb98a64fso4949990a91.2
        for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 15:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718751209; x=1719356009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gYFvLwFvbQFifv4Dm3NuhxcE/+TlmAuqppREJHL6x4=;
        b=RhMbUV+RNjJeKklSsaKUL+atder8qOTB+2t19uSql9UfBb/VE6P8f5Rg+GJN2hjMAa
         Zyn/ZH4EP14910/R7xcfkJ3URLpIyd0/MBY1EGmIVhDXYBFMkdyC2oYl/NeWh6syGdhb
         6o1pUfI6QOg7DYDlf5wjH/o4IHQpCvehxsQpt3lhDiUqD75UOMB+IMThwhyjvrNkEyDY
         Njj+TSxT8CSL88zYDUbxb3S36b9nj3c7WCPguf9qI+hMXuR/XxLPNaN5BeZG8vcOJcLy
         q2rpud0b94qHrnXRMtJHghWnnBJz3LHgGXiwAnjB3imufB4fYx/0smyzCen4V0M3s9C+
         YCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718751209; x=1719356009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2gYFvLwFvbQFifv4Dm3NuhxcE/+TlmAuqppREJHL6x4=;
        b=st4KOIo825s48dxT+gJtxmJ5pr/BVlZ6pZy/ADDrtCLlsZnGBfrZZ/GBt0FLCMNg93
         Xzc7X2xBbblYWvUztVJ60XhS6+HtLuqW3dEPtq1Pfgy39wAmnqRiH/Y128U4JaEbXxyb
         QRtq7bMXF9wJPrkuOCiQZWbKHzjORR+5iANyMCwSQSF0wKUaprGLPRpjrEQEdHxW5s5T
         4hKsxqasrrCfHLcz5CpWd51/iIJoE+Uq8rH3mDU7SrFQUuMBOmTuDnd068s47epegVD9
         ZtXB62xVWWgqHo0zomsqtbPiA7WOlKr0f2lg7gzbEDq3pMaJUWmIJc/gvZXk4v9FE8Pz
         XXAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUJ9+B8VoEh3nAOjNzp+dW9ag1Eml8zLJfcG7mryDBk9XwFnYyB6G/ZosORZbodjHhkdbMCH4kZpkBBgX4yh3hyrq1
X-Gm-Message-State: AOJu0YwBELn4VVmJSUj5RTu7FzXLmGOoZFQqxYJGHu03STiKgm7uiwMB
	/Z8UXoQBgbHuusgMN0AQANjlVR4m98u4Ry2nBRfxT/qq5Epu70BsAPq35/cZVypnPijIfkDAtS4
	Wzv8N9RAlSspgGfELujoyHPrbJWM=
X-Google-Smtp-Source: AGHT+IGVJShvkAXAeOdckg24corWNNM8jy8CGDdDix06BbLum1TfbQ5E0glvRvUq7oBSmzZPpwjVLnnkhMaTUptn3tM=
X-Received: by 2002:a17:90a:e648:b0:2c3:a8b:7098 with SMTP id
 98e67ed59e1d1-2c7b5dcbb8amr1042252a91.45.1718751208998; Tue, 18 Jun 2024
 15:53:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618162449.809994-1-alan.maguire@oracle.com> <20240618162449.809994-4-alan.maguire@oracle.com>
In-Reply-To: <20240618162449.809994-4-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 18 Jun 2024 15:53:17 -0700
Message-ID: <CAEf4BzZbn9-=7w8A99hkVFT1wKZ6LicBYSu-Z54Tb-eG7r1ffQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/5] libbpf,bpf: share BTF relocate-related code
 with kernel
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, acme@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, jolsa@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, mykolal@fb.com, thinker.li@gmail.com, bentiss@kernel.org, 
	tanggeliang@kylinos.cn, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 9:25=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> Share relocation implementation with the kernel.  As part of this,
> we also need the type/string iteration functions so add them to a
> btf_iter.c file that also gets shared with the kernel. Relocation
> code in kernel and userspace is identical save for the impementation
> of the reparenting of split BTF to the relocated base BTF and
> retrieval of BTF header from "struct btf"; these small functions
> need separate user-space and kernel implementations.
>
> One other wrinkle on the kernel side is we have to map .BTF.ids in
> modules as they were generated with the type ids used at BTF encoding
> time. btf_relocate() optionally returns an array mapping from old BTF
> ids to relocated ids, so we use that to fix up these references where
> needed for kfuncs.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  include/linux/btf.h          |  64 +++++++++++++
>  kernel/bpf/Makefile          |  10 +-
>  kernel/bpf/btf.c             | 176 ++++++++++++++++++++++++----------
>  tools/lib/bpf/Build          |   2 +-
>  tools/lib/bpf/btf.c          | 162 --------------------------------
>  tools/lib/bpf/btf_iter.c     | 177 +++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/btf_relocate.c |  23 +++++
>  7 files changed, 398 insertions(+), 216 deletions(-)
>  create mode 100644 tools/lib/bpf/btf_iter.c
>

I'd do btf_iter.c addition in a separate patch, but other than that
looks good. See a nit below.

> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 7eb9ad3a3ae6..d9d148992fbf 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -50,5 +50,13 @@ endif
>  obj-$(CONFIG_BPF_PRELOAD) +=3D preload/
>
>  obj-$(CONFIG_BPF_SYSCALL) +=3D relo_core.o
> -$(obj)/relo_core.o: $(srctree)/tools/lib/bpf/relo_core.c FORCE
> +
> +obj-$(CONFIG_BPF_SYSCALL) +=3D btf_iter.o
> +
> +obj-$(CONFIG_BPF_SYSCALL) +=3D btf_relocate.o

nit: do we need those empty lines above? let's keep all the shared
kernel/libbpf object files in one group without empty lines

> +
> +# Some source files are common to libbpf.
> +vpath %.c $(srctree)/kernel/bpf:$(srctree)/tools/lib/bpf

this is something new, what does vpath do? (sorry if this was
discussed before and I missed it)


> +
> +$(obj)/%.o: %.c FORCE
>         $(call if_changed_rule,cc_o_c)
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index ce4707968217..8e12cb80ba73 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -274,6 +274,7 @@ struct btf {
>         u32 start_str_off; /* first string offset (0 for base BTF) */
>         char name[MODULE_NAME_LEN];
>         bool kernel_btf;
> +       __u32 *base_id_map; /* map from distilled base BTF -> vmlinux BTF=
 ids */
>  };
>

[...]

