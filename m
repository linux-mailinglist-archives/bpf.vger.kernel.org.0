Return-Path: <bpf+bounces-17471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 606C180E034
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 01:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10CA51F21C59
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 00:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29FE375;
	Tue, 12 Dec 2023 00:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fh1oic1P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC27F2D42
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 16:24:19 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40c4846847eso14547205e9.1
        for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 16:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702340657; x=1702945457; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0umM5nn+8UPAnY0feGnkgVc9KGKMnt6OLh6lknl3WE=;
        b=Fh1oic1PcoP4ZmtwWYsnQLZNiRuqmUHx+R/hNtUdMFCBXH0MSiAQhfIlRjesRwIfab
         HMDDlfn8UH2OnVCkGU7CXaDr52684uGhBXHrYMS+QYsyqnZRGDlJ6S4eY4wiZ2eGsNB0
         apOumOl09KBc/XwnERA42xhe96VovwCzcoEczNPWvkWflG2y2saSFUbj/t59vNjuBgGh
         FfjZfzI7xQecgsmOquHxBt2GutBi9BuKTbPaphjNEO8kp29vMnFaXIQHTIlom/mjw3z+
         28jl6h3ZZ0ovFaochxxYVwUaxf/BBw7NWPzCDutXQutHbgYAkuuzWlXW+jXrGyjFMVkT
         vmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702340657; x=1702945457;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0umM5nn+8UPAnY0feGnkgVc9KGKMnt6OLh6lknl3WE=;
        b=WAU9/Ab/W2u9HFYpNu2sKhs+Rz2T97meTlOlNLGD1IPHlKdHkHnNpQrGuaVoXWIuHl
         K6MpHUuFFm6OtAaaEQGiulJbgbQrSBoa3eLySBAYDqbgH7okHybUx5Iu5Y6uMuljWHCM
         PVQDPjrQtBeMm1mmIEZzZKZM2OhUeX+hU/lI1D5rIzk7ETTxswc2nEnvdvx9jr5k759x
         Ol4J5LuNG3aYlryu3NqCYvbuP9HX76ARMejOoM+49e+i0b+USWxNzusbkmCCcCiUpthS
         fdIfjjSiL+0oG6w/NdiE4L1MRgtbKdWOvG7Dd+jG64Q7hH6XIqO77m49Tlke2raOoTnf
         kxnA==
X-Gm-Message-State: AOJu0Yxc9TdUcD+/cpX6IaierRvGkrywC7agCKBZQOJbgzJVPc2oRssA
	4xjrJOz5vSrouuHxdytqggAhPI8VOgAok91z2K/gJbWfgWM=
X-Google-Smtp-Source: AGHT+IECPd8mE0G0PAQsVWP8W2xCAyR67WDvEMHXqbnaKVDJeyAMMsRc4Xnfu8dQjS5YjBWCuh7PzdyOEv88TPSmYrI=
X-Received: by 2002:a7b:c857:0:b0:40b:5e21:e280 with SMTP id
 c23-20020a7bc857000000b0040b5e21e280mr2839537wml.109.1702340657390; Mon, 11
 Dec 2023 16:24:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZXeYweVsl9BOvfyZ@alunos.uminho.pt>
In-Reply-To: <ZXeYweVsl9BOvfyZ@alunos.uminho.pt>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 Dec 2023 16:24:05 -0800
Message-ID: <CAEf4BzYeSjEU63Lsp2T4pZzVjd=dd6UQvz=d5rAhoxKdi5GaGA@mail.gmail.com>
Subject: Re: libbpf/BPF-CORE kprobe arguments
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 3:18=E2=80=AFPM Bruno Dias da Gi=C3=A3o
<a96544@alunos.uminho.pt> wrote:
>
> Hello,
> I read in one of Andrii Nakryiko's blogs that this was the best place to
> ask questions, sorry if not up to all standards.
>
> I have been working on some bcc -> libbpf conversions and have halted
> entirely when I reached working with kprobes.
>
> In the following code I attempt to pass to user space the parameters
> passed to the system call.
>
> SEC("kprobe/__x64_sys_openat")
> int BPF_KPROBE(kprobe__x64_sys_openat, int dfd, const char * path,
>                int flags, unsigned short mode)
> {
>         struct event *ev;
>         ev =3D bpf_ringbuf_reserve(&rb, sizeof(*ev), 0);
>         if (!ev) {
>                 return 1;
>         }
>         ev->pid =3D bpf_get_current_pid_tgid() >> 32;
>         bpf_get_current_comm(&ev->comm, sizeof(ev->comm));
>         ev->ts =3D bpf_ktime_get_ns();
>         ev->dfd =3D dfd;
>         ev->flags =3D flags;
>         ev->mode =3D mode;
>         bpf_probe_read_user_str(&ev->buffer,
>                            sizeof(ev->buffer),
>                            (void *)path);
>         //bpf_printk("%d %d %s", ev->pid, ev->df, ev->buffer);
>         bpf_ringbuf_submit(ev, 0);
>         return 0;
> }
>
> However the output of this function (both printk and ringbuf) returns
> values that are either close to 2^32, for ev->df, or downright 0, for
> ev->buffer.
>
> Note that this works very cleanly when attaching instead with
> tracepoints but simply using tracepoints and not touching kprobes is not
> really an alternative for what I want.
>
> The result is also the same when using PT_REGS_PARM* or even explicit
> ctx->di/ctx->si (etc etc);
>
> So I wonder if the pt regs are actually being filled with wrong informati=
on,
> if I have an incorrect way of accessing the values of the registers.
> I did search online for information on these kinds of outputs but did
> not find any solutions.

Depending on kernel version and host architecture, parameters could be
stored in another pt_regs that is pointed to by the first argument.
You might want to google/grep for ARCH_HAS_SYSCALL_WRAPPER, if you are
interested.

But I'd recommend to just use BPF_KSYSCALL() macro in combination with
SEC("ksyscall/openat") program type, which abstracts all that away.
See [0] for a simple example.

Also, I heard that it might be best to use a per-syscall tracepoint
instead of kprobe, so you might want to experiment with that as well.
Tracepoints might be faster than kprobe, but I'd benchmark this first.


  [0] https://github.com/libbpf/libbpf-bootstrap/blob/master/examples/c/ksy=
scall.bpf.c


>
> Again, sorry if there's clutter or if this message should not be sent
> here.
> --
> Regards,
> bdg
>

