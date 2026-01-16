Return-Path: <bpf+bounces-79348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF69D38943
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 23:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 748E23019497
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 22:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E02D31329B;
	Fri, 16 Jan 2026 22:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvgtbezV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A431C84B8
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 22:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768602804; cv=pass; b=Z62uAA/MuwylDXZP4+heEfM+767I/sZDAjk0DuAGZ9qvDRGRZZovxQ/X2vCsMRtyon+XGbL4yPwW6qi9fGTR5AvN1WE+od2UNFK3uPzTnRXb+TCrE/PLZs1mtHYpMeBJ2VTpUDHIfPd0vhPHn2eZKFsC2iiCWgHcwjYv9N0kJo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768602804; c=relaxed/simple;
	bh=r2Ojrj82J3XVjXm3G7LTsWFZ5Lta8bV48jzrvi4whCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OsXIJhonSxVQ+gQ4QnaC/WItNJfdko3cCChYpvnF2IOFzn0rqZUm1i/rWA/gbXo9dmt0JfXOKrh/htOfG5zVKOtnxSp8qzjfLOQjjXDKewoygrSKXyMbki5xhC5nPK1B8grZZAIr6XM9WReaUE17oJPPl4pj7onHVGgBR+7jl/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvgtbezV; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34e730f5fefso1647530a91.0
        for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 14:33:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768602802; cv=none;
        d=google.com; s=arc-20240605;
        b=Y70jTRlahEBH9HLKN04Q173zxw71YDy26PjusxzwiKJ2D62ZEts1qVmZyMXuxBA4vL
         d7QB71gbblSqmATkd4fk4+D1RZN0bYOpET3yjSltCz+Z/1V55wCbQCsXOEhcXKgO2/kN
         tGN7lDItzXfbMX7a6lWXG1Kh8/TojpKt8KUVd5n0BJaugQvCU5JiCZWBPKGHoEZhUJsB
         +XyFmNdrdL1J6djwNluX7v7i43Cw62cBx4AKrnqxaEM4BocEDB2IJe+vhKqZ9BipZ1Jj
         q0cFzsDZLNTNgjNDHyx4rkbbCf+VNCkV3tr68N+MCelnkiW717h8V1b97zrdKlY5mzmU
         8R1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iJboOYL8nb5HKiKwIawaFZDgZ5gKyvu1KidzfHjD1h0=;
        fh=iyIh3tiaN/pTCZHwzDN2Emw2Zfr0RZtTUCw7DgIPD2U=;
        b=hCnXgNgIx8/6LcbbrxPsKRqEK6r9crL6sDpHuPrpfCYZn9huDY2IGGRQCgoDvNepo+
         cHz+LcgoZiTjoqYxNrZW6RXQihU+O80H4zGB8vtZTiGuw9UNBzY3lnbObRLYpybyFgBD
         SSEBM9v5pv3tpt5ukpWIWuTniBWIUU+oWYGKAzbux8e8/C9pp2ZJdPKlH92BaPLZNm1s
         C+oFdqSY4PuKG5gRtakKNjz+XQSQyhfWEtvkFjTNM/sGk6fp1obDPu3aHGmhsIGDxEI+
         nbXNM4/UKj89QGCp8PuUJIWUL1JiDG21A9w8B2yodM8fgXPyTLAcq3tzqwXScG2WGW1Q
         xQbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768602802; x=1769207602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJboOYL8nb5HKiKwIawaFZDgZ5gKyvu1KidzfHjD1h0=;
        b=hvgtbezVtlQA0URQHDFyOg+qTQu7OU6JUWASAux5rOegh1nYYf1b4IYdyRvaR3Ho0Y
         cqKAyCzll4p2x7HsZl0T++r3v/wsuF8snGY6508L892u+w5T+hfrIfJMjHmlCTBQlVRQ
         CulD527pKPi2+zceUGP5c7KnIfxDFCGkD7aEKpQY4aoZKoHMX+o39zZ1S9famOCcQqVE
         4QRxScx57EjErQcxo2Qlhs3c2S0p9BqQCUZ4iMNkTy2TKCG59keCErT/y+lgvi0u9ET2
         TGSuJWamoMB5/hI0fwSjkB/Bx0Q0sG1yYn/QWhZX5ZVHmIG7GJQN5O4i7UrAjXh2GJCi
         E8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768602802; x=1769207602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iJboOYL8nb5HKiKwIawaFZDgZ5gKyvu1KidzfHjD1h0=;
        b=Gj1tVbnVMuC0huknHHSH8rATG5WtOWzSWPFdtN9qkKqU5HaHCERsm/pDCft/m4qWWS
         4c7F7oWqe5cyN4rHmUrp46E8zyvYGZMYFrowrdu0UyyJLykGiBeiTv/i/qjJi44dclF9
         c9pCG2wsZSjKXHWQi3vmI2ZTFcKS6+Y4Xq7RFQQ0UC7YJj4zYhlwgX7sq2uYxxaEU8B3
         u6tS33sivz84ivoVPIekVo8I0eosILSPnQN+fk6QeG8AKJOw7CAdRLbJDJcS3sP0d4dd
         w2qgcolPn/H/DdclQppPGEywFFgpWqnTGgront/BP8pUA0MFQIlqz1WgZ2qrC2tUyWLm
         7Waw==
X-Gm-Message-State: AOJu0Yz3S06DjNvKEUBRqwcxDQJcgzYepou3kZCDur66tdCJkhKPXM8F
	K0cCn2UN8A6jPKECg/RaVfRwW1IEL79Jr8f4N6Qbl/LZCFQK6vDpMak9wyhCbwWUQPQutDrPTGk
	K0u1rn/RZRBD3WhXukoN5IMLEjPVRrHs=
X-Gm-Gg: AY/fxX5se35q0aR2LFKvuYOFUy0KnNgfBK7S7ewcH1Tm5MrD/nGcMx0PNVAH+fdwdNw
	gEo1VvWETnN2+v1WdMSnC0DZQ53U5sSxCwAF2FEGnIk+D3Q/5MLEw+h5Fc+ijCsHzJZ9G5ikDco
	3OyJe6KYb8cYdUGPHcbyxtPvOVkVdwaQE9dQxHtHG2lcLRAYdBSRaVliFv6+QVxJsuwQmNwBXVE
	b8bQrXMlZY++Ak+ilcE1/49vysY8lfcgEOzU7nVN1nNAvRY+yuLO64h0MsGeIHZuPYaNuKIB1/x
	RYM+9r+DnxI=
X-Received: by 2002:a17:90a:d00b:b0:34f:62e7:4cfd with SMTP id
 98e67ed59e1d1-35272f8800emr3821863a91.24.1768602802018; Fri, 16 Jan 2026
 14:33:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112145616.44195-1-leon.hwang@linux.dev> <20260112145616.44195-9-leon.hwang@linux.dev>
 <CAEf4BzarSrW1aTRcjrheLWqxFCh1FFd7vwJ4OQup1dbT13EapQ@mail.gmail.com> <22e0de9a-8963-454b-8b35-f8c9be15dee3@linux.dev>
In-Reply-To: <22e0de9a-8963-454b-8b35-f8c9be15dee3@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 16 Jan 2026 14:33:09 -0800
X-Gm-Features: AZwV_Qj5-qhQEeblkq6zDE7vf09okjNAQE4EuJYtKd-cqp--OSf-P39pgeg23DY
Message-ID: <CAEf4Bza7d8sdo2Y-D0U5BQos6Z2C6i-4f4B4oe8sApfua0uNAg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 8/9] libbpf: Add common attr support for map_create
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Seth Forshee <sforshee@kernel.org>, Yuichiro Tsuji <yuichtsu@amazon.com>, 
	Andrey Albershteyn <aalbersh@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Tao Chen <chen.dylane@linux.dev>, 
	Mykyta Yatsenko <yatsenko@meta.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Anton Protopopov <a.s.protopopov@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Rong Tao <rongtao@cestc.cn>, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 6:17=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 2026/1/16 09:03, Andrii Nakryiko wrote:
> > On Mon, Jan 12, 2026 at 6:59=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >> With the previous commit adding common attribute support for
> >> BPF_MAP_CREATE, users can now retrieve detailed error messages when ma=
p
> >> creation fails via the log_buf field.
> >>
> >> Introduce struct bpf_syscall_common_attr_opts with the following field=
s:
> >> log_buf, log_size, log_level, and log_true_size.
> >>
> >> Extend bpf_map_create_opts with a new field common_attr_opts, allowing
> >> users to capture and inspect log messages on map creation failures.
> >>
> >> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> >> ---
> >>  tools/lib/bpf/bpf.c | 15 ++++++++++++++-
> >>  tools/lib/bpf/bpf.h | 17 ++++++++++++++++-
> >>  2 files changed, 30 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> >> index d44e667aaf02..d65df1b7b2be 100644
> >> --- a/tools/lib/bpf/bpf.c
> >> +++ b/tools/lib/bpf/bpf.c
> >> @@ -207,6 +207,9 @@ int bpf_map_create(enum bpf_map_type map_type,
> >>                    const struct bpf_map_create_opts *opts)
> >>  {
> >>         const size_t attr_sz =3D offsetofend(union bpf_attr, excl_prog=
_hash_size);
> >> +       const size_t common_attr_sz =3D sizeof(struct bpf_common_attr)=
;
> >> +       struct bpf_syscall_common_attr_opts *common_attr_opts;
> >> +       struct bpf_common_attr common_attr;
> >>         union bpf_attr attr;
> >>         int fd;
> >>
> >> @@ -240,7 +243,17 @@ int bpf_map_create(enum bpf_map_type map_type,
> >>         attr.excl_prog_hash =3D ptr_to_u64(OPTS_GET(opts, excl_prog_ha=
sh, NULL));
> >>         attr.excl_prog_hash_size =3D OPTS_GET(opts, excl_prog_hash_siz=
e, 0);
> >>
> >> -       fd =3D sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
> >> +       common_attr_opts =3D OPTS_GET(opts, common_attr_opts, NULL);
> >> +       if (common_attr_opts && feat_supported(NULL, FEAT_EXTENDED_SYS=
CALL)) {
> >> +               memset(&common_attr, 0, common_attr_sz);
> >> +               common_attr.log_buf =3D ptr_to_u64(OPTS_GET(common_att=
r_opts, log_buf, NULL));
> >> +               common_attr.log_size =3D OPTS_GET(common_attr_opts, lo=
g_size, 0);
> >> +               common_attr.log_level =3D OPTS_GET(common_attr_opts, l=
og_level, 0);
> >> +               fd =3D sys_bpf_ext_fd(BPF_MAP_CREATE, &attr, attr_sz, =
&common_attr, common_attr_sz);
> >> +               OPTS_SET(common_attr_opts, log_true_size, common_attr.=
log_true_size);
> >> +       } else {
> >> +               fd =3D sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
> >
> > OPTS_SET(log_true_size) to zero here, maybe?
> >
>
> Unnecessary, but ok to do it.
>
> >> +       }
> >>         return libbpf_err_errno(fd);
> >>  }
> >>
> >> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> >> index 2c8e88ddb674..c4a26e6b71ea 100644
> >> --- a/tools/lib/bpf/bpf.h
> >> +++ b/tools/lib/bpf/bpf.h
> >> @@ -37,6 +37,18 @@ extern "C" {
> >>
> >>  LIBBPF_API int libbpf_set_memlock_rlim(size_t memlock_bytes);
> >>
> >> +struct bpf_syscall_common_attr_opts {
> >> +       size_t sz; /* size of this struct for forward/backward compati=
bility */
> >> +
> >> +       char *log_buf;
> >> +       __u32 log_size;
> >> +       __u32 log_level;
> >> +       __u32 log_true_size;
> >> +
> >> +       size_t :0;
> >> +};
> >> +#define bpf_syscall_common_attr_opts__last_field log_true_size
> >
> > see below, let's drop this struct and just add these 4 fields directly
> > to bpf_map_create_opts
> >
> >> +
> >>  struct bpf_map_create_opts {
> >>         size_t sz; /* size of this struct for forward/backward compati=
bility */
> >>
> >> @@ -57,9 +69,12 @@ struct bpf_map_create_opts {
> >>
> >>         const void *excl_prog_hash;
> >>         __u32 excl_prog_hash_size;
> >> +
> >> +       struct bpf_syscall_common_attr_opts *common_attr_opts;
> >
> > maybe let's just add those log_xxx fields here directly? This whole
> > extra bpf_syscall_common_attr_opts pointer and struct seems like a
> > cumbersome API.
> >
>
> Oops... This struct was suggested by the v3 discussion [1].
>
> This struct was used to report 'log_true_size' without changing
> 'bpf_map_create()' API.
>

Ah, I already forgot. log_true_size being an output parameter here...
Sigh. I don't like the verboseness of bpf_syscall_common_attr_opts and
"common_attr_opts" and all that stuff...

What if we make it struct bpf_log_opts {} and keep it log-specific?

> Links
> [1]
> https://lore.kernel.org/bpf/CAEf4Bzaw9cboFSf1OXmD84S7pKaeyj=3DbcQg_diUzGw=
AkFsjUgg@mail.gmail.com/
>
> Thanks,
> Leon
>
> >> +
> >>         size_t :0;
> >>  };
> >> -#define bpf_map_create_opts__last_field excl_prog_hash_size
> >> +#define bpf_map_create_opts__last_field common_attr_opts
> >>
> >>  LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
> >>                               const char *map_name,
> >> --
> >> 2.52.0
> >>
>

