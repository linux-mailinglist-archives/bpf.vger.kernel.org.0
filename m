Return-Path: <bpf+bounces-17898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5AA813E40
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 00:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B5E628356F
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 23:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812856C6EA;
	Thu, 14 Dec 2023 23:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8fb2Ucz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731186C6C8
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 23:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40c3f68b69aso972805e9.1
        for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 15:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702596630; x=1703201430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dM7orxymmhC00cY97vonyrsJwbGRj6K3h87puM8HtEw=;
        b=E8fb2UcznQiQL6oc7r6t4/ZP+sevda3Okm9+mnkn8iUH9tTnbgWogOmNomA3hpBaAJ
         NuDs6R0IxIdCurf3w2cg7Su4SHLEdyFoRDmXoRT/7QvVj/9lkztVLiBVkueSLjFJFN+J
         u4qbD3nrY0sIZxce08A0NzMphF2Io2sImSoj7ur4/rblMujV9PllWOgCoIV7xfDBJMGS
         b5gbhQqFBz8oyl4VPVATd8czHgvo5Zgy+AHFqbnozFnZHHDpHusTx1l7XQX3M/oy00lr
         Y70/knBSj5vlRefuyv5ELFh2NhwF6VJbDmkeVZxLnSsMaH02NCGL3BsVP9QnYH1Vg3TD
         tA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702596630; x=1703201430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dM7orxymmhC00cY97vonyrsJwbGRj6K3h87puM8HtEw=;
        b=UROPSNubaPH/tEmiHx0EjWbmWfGlUkNWYux+fSvoKpfYIxLmOtG/C7Yl3O71ffXV7Y
         eKZey78YGMiro2GRVW5xEbR+aKR4goIZU7SSXJnB/Nt8wh+wHN2BAI/8ytckGgoGcK0O
         4m24qSao2w//+Z8zH2lK70VTeuyWfU8LWQLJLLIGS+/Ulz7LUHX0vPdQNZbM4CeOR/yI
         gK6MwovQxw1KernpFWJXwoqT1rFJmQrHg1a75rhfqa9K6rXLiSuJXV3FbdkwSSPofhhi
         jo4Tk6zVSto+VgkU+/OA0KNcPdw0c6AzCDV7mvMemVgMrvgVnjrAGtYBfRKotPz9XEOY
         ySGA==
X-Gm-Message-State: AOJu0YzmOGJOhdvIjtXXV/EooYZmgDwCWgec5T3Y86+rfjSDVwVcMqSs
	vS/nZlnxDdFP9fG+xit0iDyredmUJjl+CLA7E/w=
X-Google-Smtp-Source: AGHT+IF2fRj8s4IqtGs+dV/lgBpYD7DE5sniUAgN18oTFTJz//NpGcXEk5yOXT18tLfTzmAtogsvMnkeHeL4X/13zuY=
X-Received: by 2002:a05:6000:1e96:b0:336:4e1e:35e4 with SMTP id
 dd22-20020a0560001e9600b003364e1e35e4mr181269wrb.83.1702596630588; Thu, 14
 Dec 2023 15:30:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214120716.591528-1-dave@dtucker.co.uk>
In-Reply-To: <20231214120716.591528-1-dave@dtucker.co.uk>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Dec 2023 15:30:18 -0800
Message-ID: <CAEf4BzaA9zzKrdybBxnpe=ErPx4=JNHYkozu_kKbYWjCQBS5ag@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: Include pid, uid and comm in audit output
To: Dave Tucker <dave@dtucker.co.uk>
Cc: bpf@vger.kernel.org, Dave Tucker <datucker@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 4:07=E2=80=AFAM Dave Tucker <dave@dtucker.co.uk> wr=
ote:
>
> Current output from auditd is as follows:
>
> time->Wed Dec 13 21:39:24 2023
> type=3DBPF msg=3Daudit(1702503564.519:11241): prog-id=3D439 op=3DLOAD
>
> This only tells you that a BPF program was loaded, but without
> any context. If we include the pid, uid and comm we get output as
> follows:
>
> time->Wed Dec 13 21:59:59 2023
> type=3DBPF msg=3Daudit(1702504799.156:99528): pid=3D27279 uid=3D0
>         comm=3D"new_name" prog-id=3D50092 op=3DUNLOAD

would emitting program name be useful as well?

>
> With pid, uid a system administrator has much better context
> over which processes and user loaded which eBPF programs.
> comm is useful since processes may be short-lived.
>
> Signed-off-by: Dave Tucker <dave@dtucker.co.uk>
> ---
>  kernel/bpf/syscall.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 06320d9abf33..71f418edc014 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -35,6 +35,7 @@
>  #include <linux/rcupdate_trace.h>
>  #include <linux/memcontrol.h>
>  #include <linux/trace_events.h>
> +#include <linux/uidgid.h>
>
>  #include <net/netfilter/nf_bpf_link.h>
>  #include <net/netkit.h>
> @@ -2110,6 +2111,8 @@ static void bpf_audit_prog(const struct bpf_prog *p=
rog, unsigned int op)
>  {
>         struct audit_context *ctx =3D NULL;
>         struct audit_buffer *ab;
> +       const struct cred *cred;
> +       char comm[sizeof(current->comm)];
>
>         if (WARN_ON_ONCE(op >=3D BPF_AUDIT_MAX))
>                 return;
> @@ -2120,7 +2123,14 @@ static void bpf_audit_prog(const struct bpf_prog *=
prog, unsigned int op)
>         ab =3D audit_log_start(ctx, GFP_ATOMIC, AUDIT_BPF);
>         if (unlikely(!ab))
>                 return;
> -       audit_log_format(ab, "prog-id=3D%u op=3D%s",
> +       cred =3D current_cred();
> +
> +       audit_log_format(ab, "pid=3D%u uid=3D%u",
> +                        task_pid_nr(current),
> +                        from_kuid(&init_user_ns, cred->uid));
> +       audit_log_format(ab, " comm=3D");
> +       audit_log_untrustedstring(ab, get_task_comm(comm, current));
> +       audit_log_format(ab, " prog-id=3D%u op=3D%s",
>                          prog->aux->id, bpf_audit_str[op]);
>         audit_log_end(ab);
>  }
> --
> 2.43.0
>

