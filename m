Return-Path: <bpf+bounces-18031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC9B814F69
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 19:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D89E1C228D3
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 18:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4402C3010D;
	Fri, 15 Dec 2023 18:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G01dx4Wg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4417D4184B
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 18:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40c1e3ea2f2so8982085e9.2
        for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 10:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702663236; x=1703268036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bFCJJJXZTezEMH3lsXjSLaqneEhN+KTgrCvcci65oM=;
        b=G01dx4WgFyB09lBnXDv0kHyFWihzHsV7Q4l+ARPk5BSXO6JEdSccrUS8fjzOcAQka4
         aPFtfpIhxuSqckZo8fyD7VvFUoOpjJTIaCd5i8O4LUnqnAiMD1ROMiRWLxZo+NzZE8iI
         nXOxID3YoZAvmy0c/r5kGaP7u/8OFvZtJdut94O1a1m4uiRf6gkjTQeZHGCsDG0VzNZm
         CQKEPmDDDLVEF1CsquBTr/LVbvm94oLjrOVxAlMS3Tcs1c97+5GbQo60vkzTqY4PTnDC
         s5nxG6yj6s3hWoxPciYo24Eiklzec7PypEQRFmQ5gpnWCW43JY5X8ilMBT4oA0lOgtXg
         jVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702663236; x=1703268036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8bFCJJJXZTezEMH3lsXjSLaqneEhN+KTgrCvcci65oM=;
        b=szSovDAxLlo8Kl4aHiFvSOZxvGb+frYE8N5KvAcdzQ9AAbUxAZBnxE4V7hNYAbD39/
         KxpdjpA3Sy0bCIN5RYkZlYjv37F5x2el7KuJDRxKhCp1Uj5Hd4XH6//1W5aIlWLktTlp
         IwZtpD9LTIljIBwj1WB/mDGZim0V+NGr9dfKlgdmheYdhEXazMkttTRfxroqOteDFIsB
         FvdvAHk4u6WjKSTtyTAxDItuqeU6LWeLr2DivLilQXUNrunfcZhCP+5LpA5+pPQG+AGD
         6XjDACwpq0r1wwtfyGGtZNBO/mpLu9Jgcsk8rridcvVOX3hMQaV1keYZEnY3EB7er/rp
         iLGw==
X-Gm-Message-State: AOJu0Yw03FeBTVU2LnkiC5gD6LlyzmLaDn9wI1o5hcf/4CtKD1CX5blI
	pzKMub88kWMwY30Q7tho1euenxj9T0hgbNGfYLU=
X-Google-Smtp-Source: AGHT+IGUDrSKRGi06sv2eeA6bdB9wR4tc2/WkGCvbcV0mHJQaKXtnkGhAjouy89Iw+FcVgj670eqM3haeiq9yb1DaS4=
X-Received: by 2002:a5d:6747:0:b0:336:4649:53ad with SMTP id
 l7-20020a5d6747000000b00336464953admr2040617wrw.112.1702663236059; Fri, 15
 Dec 2023 10:00:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3636f52d-f343-45e5-88c6-3c7e28e87a45@linux.dev> <20231215174639.1034164-1-dave@dtucker.co.uk>
In-Reply-To: <20231215174639.1034164-1-dave@dtucker.co.uk>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 15 Dec 2023 10:00:24 -0800
Message-ID: <CAADnVQ+4AYvFnrjsdtwOArA9Mj+6nfg5sgkugLKHNRR_LCB7fg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: Include pid, uid and comm in audit output
To: Dave Tucker <dave@dtucker.co.uk>, Paul Moore <paul@paul-moore.com>
Cc: bpf <bpf@vger.kernel.org>, Dave Tucker <datucker@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 9:47=E2=80=AFAM Dave Tucker <dave@dtucker.co.uk> wr=
ote:
>
> Current output from auditd is as follows:
>
> time->Wed Dec 13 21:39:24 2023
> type=3DBPF msg=3Daudit(1702503564.519:11241): prog-id=3D439 op=3DLOAD
>
> This only tells you that a BPF program was loaded, but without
> any context. If we include the prog-name, pid, uid and comm we get
> output as follows:
>
> time->Wed Dec 13 21:59:59 2023
> type=3DBPF msg=3Daudit(1702504799.156:99528): op=3DUNLOAD prog-id=3D50092
>         prog-name=3D"test" pid=3D27279 uid=3D0 comm=3D"new_name"
>
> With pid, uid a system administrator has much better context
> over which processes and user loaded which eBPF programs.
> comm is useful since processes may be short-lived.
>
> Signed-off-by: Dave Tucker <dave@dtucker.co.uk>
> ---
>
> Changes:
>
> v2->v3:
>   - Revert replacing in_irq() with in_hardirq()
>   - Revert removal of in_irq() check from bpf_audit_prog since it may
>     also be called in the sofirq or nmi contexts
>
> v1->v2:
>   - Move 'op' to the front of the audit messages
>   - Add 'prog-name' to the audit messages
>   - Replace deprecated in_irq() with in_hardirq()
>   - Remove in_irq() check from bpf_audit_prog since it's always called
>     from the task context
>   - Only populate pid, uid and comm if not in a kthread
>
>  kernel/bpf/syscall.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 06320d9abf33..86600ca1f106 100644
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
> @@ -2120,8 +2123,22 @@ static void bpf_audit_prog(const struct bpf_prog *=
prog, unsigned int op)
>         ab =3D audit_log_start(ctx, GFP_ATOMIC, AUDIT_BPF);
>         if (unlikely(!ab))
>                 return;
> -       audit_log_format(ab, "prog-id=3D%u op=3D%s",
> -                        prog->aux->id, bpf_audit_str[op]);
> +
> +       audit_log_format(ab, "op=3D%s prog-id=3D%u",
> +                        bpf_audit_str[op], prog->aux->id);
> +       audit_log_format(ab, " prog-name=3D");
> +       audit_log_untrustedstring(ab, prog->aux->name ?: "(none)");
> +
> +       if (current->mm) {
> +               cred =3D current_cred();

Is this how you're trying to detect whether it's running
out of workqueue?
You probably need:
if (!current->mm || (current->flags & PF_KTHREAD))

But even with that it looks wrong, since
BPF_AUDIT_UNLOAD message will be _randomly_ unbalanced
with LOAD message.
Last __bpf_prog_put() can happen in either context.

You also need to cc Paul.
He needs to ack it before we can take it.
As it stands I think this change makes the audit worse.

