Return-Path: <bpf+bounces-55746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC16A8634F
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 18:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47A071BA76DA
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 16:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9642521CC51;
	Fri, 11 Apr 2025 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HT/pLSkT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9611326AD9;
	Fri, 11 Apr 2025 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744389150; cv=none; b=tM5GBRCig3JsPru4Sq+Mqib8C4HkENRUjeOnUF/9xQuDqmvdapU5CzgipR9qAJWGlzcSvWQ20kGf3IFCojFvp8QsKg+UOfFJr6YKP1RbL3ir7aGTB63FYf6yToOVGcfWqCESuPTtyw1U7ObU5plEVNRbxxPKGfOxb4Nz8kD5oEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744389150; c=relaxed/simple;
	bh=wHac6W2NgppYgVoyLWVJivgCtoAx3DGKYTpMWQcOhyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a53oxsldYDAzNbJjVPRdwcA7iJueq2/aJ4ybrd6BFt5IuGW9Haqz20lwm2MYsxVywteP44r+bthjcEoiuwavlk5fq+7fJwAWB4Pw87V+9KRM5QAhua6Dahn5JCciI8aabY7TJLz8vN29s3WoVtyiVmnNG6a3TYPzTlWYf3xe6ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HT/pLSkT; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-73972a54919so2116007b3a.3;
        Fri, 11 Apr 2025 09:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744389148; x=1744993948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GF3J6Lndx8cb8ODBZJmGjbPMmgsw0v3H56tZJV1cy8=;
        b=HT/pLSkT0faOl4LtRWUA7MbRvemjgD2/SVFLbO48TuW5TYB6QqhvAonHoyGRT/SGuP
         BUc5TJN2vrKfKtbCSsLRiuTznHrm1fixF4SO1zprDnJEMPe8Dqk7yCMzeFXTORudUxQ/
         xnoH8azKTOawNK7NqYbEUenor4yzmY70jY/H9r5JFVS8qOM+6MuBRHLZxPi8K/i69HeA
         XOQAkOR1fNzwQHwd99SFYrgziPfRwRp4b5D9IjbtErfPcNeXlJ+hpU0eVP3ugnpmuxCz
         LNxiZXA4g+ydKD1IiX5Ohcy3d0gy6bHDvoynyT9x/AjHkexKvoLLzzpj8X+UqVej8UmM
         liGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744389148; x=1744993948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GF3J6Lndx8cb8ODBZJmGjbPMmgsw0v3H56tZJV1cy8=;
        b=VoN0qNJH7xzSsXOPidKUHT0cOWszxTsqtkA/vK6H54GfBI564JbzdoY4ViDy0umzgf
         8Gx0JXAVh9c/gA+JYdcyDgUTu+Z6+bOmf0GvaJ5oue7sTf3ATVj7/FaGp8AgqHPUV8lg
         +Cz+3+Eyn7vMknuhTiGoTip6nFAjsBABSd8x9s/JSdAg3CrcmjK+RbOlrFz0vDOOo9W+
         lLlWv5MaZ0xPhnzuWhPEKDIUwLaR/0HoaQashWejmwoAFcW/dIucm4YqY5j3fv0Ap3XE
         M9nH6RWrzJ4RS8PlJpWFARqSiEb7EYl//TTGj8h60GB7IBJcHA6ciSAAOeQaNG652BtU
         yjNA==
X-Forwarded-Encrypted: i=1; AJvYcCWqvrgX4+TED3SAIAbYEodDc5LVx5rE3AYw4mQzUwecXASDRjoVsD8A30Mh9P+Uq4vSS9TiAicCqfOq7gsh@vger.kernel.org, AJvYcCXomatzDH3731SrDVYIhvT/ba98cCJCfHk/8vd2PJThCcptDueQ3PDtUmIidZda9sYR2Lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKJC4m2nKrdUxCH2hUz7tpFiW4P4ZF9HtickS3QXVYuU5zK6gn
	qcpJxTQEtCTzul6rCx8E1e5lnWFIxIWCeXKMI0BV9vonLiflI7S81Htn/AZEu5E7JVXucHEY+ai
	tjyWcgqa++n7f5OAbhvMOOhazrfMfBshk
X-Gm-Gg: ASbGnctD7hQL7iWSPZ4CZqqhCdhEo3Y8oIUy5AK3fCSgpTl9Pal43uB+Hv/sew9t+QB
	iUC+YJPodWAONenPDZPSanqArsC9PYzIoMBjQyAMXjBNcbwSoFUgJZiwV1dPXJ8uIHXewC7ImBC
	++6gKddA6lYbDp1pn2oMSY42IW9bfzpZRaJ8nm
X-Google-Smtp-Source: AGHT+IFwsEaUJBjhq3whMZfOWk8HUpO+a7m+FFlYHZcVzJOtHiRY1wX2tM8zi8HsPcZuAT1PT8mLmkgcvWyeINQeBa0=
X-Received: by 2002:a05:6a00:14c6:b0:736:41ec:aaad with SMTP id
 d2e1a72fcca58-73bd1202d91mr4552264b3a.14.1744389147660; Fri, 11 Apr 2025
 09:32:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411080545.319865-1-yangfeng59949@163.com>
In-Reply-To: <20250411080545.319865-1-yangfeng59949@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 11 Apr 2025 09:32:15 -0700
X-Gm-Features: ATxdqUG5W5eIRBd-yEOQgalk9EWcqjOsk_dKd992HEp_M1aa9qxKmAYlGT9OrMU
Message-ID: <CAEf4BzZaFzLZLEDhuGjLdp0sbjOHpE0zA7FURBexQo3=2uk1zA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] libbpf: Fix event name too long error
To: Feng Yang <yangfeng59949@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, hengqi.chen@gmail.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 1:06=E2=80=AFAM Feng Yang <yangfeng59949@163.com> w=
rote:
>
> From: Feng Yang <yangfeng@kylinos.cn>
>
> When the binary path is excessively long, the generated probe_name in lib=
bpf
> exceeds the kernel's MAX_EVENT_NAME_LEN limit (64 bytes).
> This causes legacy uprobe event attachment to fail with error code -22.
>
> Use basename() to extract the base filename from the full binary path, re=
moving directory prefixes.
> Example: /root/loooooooooooooooooooooooooooooooooooong_name -> looooooooo=
ooooooooooooooooooooooooooong_name.
>
> String Length Limitation: Apply %.32s in snprintf to truncate the base fi=
lename to 32 characters.
> Example: loooooooooooooooooooooooooooooooooooong_name -> looooooooooooooo=
oooooooooooooooo.
>
> Before Fix:
>         libbpf: binary_path: /root/loooooooooooooooooooooooooooooooooooon=
g_name
>         libbpf: probe_name: libbpf_32296__root_looooooooooooooooooooooooo=
ooooooooooong_name_0x1106
>         libbpf: failed to add legacy uprobe event for /root/loooooooooooo=
oooooooooooooooooooooooong_name:0x1106: -22
>
> After Fix:
>         libbpf: binary_path: /root/loooooooooooooooooooooooooooooooooooon=
g_name
>         libbpf: probe_name: libbpf_36178_looooooooooooooooooooooooooooooo=
_0x1106
>
> Fixes: 46ed5fc33db9 ("libbpf: Refactor and simplify legacy kprobe code")
> Fixes: cc10623c6810 ("libbpf: Add legacy uprobe attaching support")
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> ---
> Changes in v2:
> - Use basename() and %.32s to fix. Thanks, Hengqi Chen!
> - Link to v1: https://lore.kernel.org/all/20250410052712.206785-1-yangfen=
g59949@163.com/
> ---
>  tools/lib/bpf/libbpf.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>

Please add a selftest demonstrating a problem in the next revision.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b2591f5cab65..7e10c7c66819 100644
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
> @@ -11142,10 +11144,10 @@ static void gen_kprobe_legacy_event_name(char *=
buf, size_t buf_sz,
>         static int index =3D 0;
>         int i;
>
> -       snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx_%d", getpid(), kfunc_na=
me, offset,
> -                __sync_fetch_and_add(&index, 1));
> +       snprintf(buf, buf_sz, "libbpf_%u_%.32s_0x%zx_%d", getpid(), kfunc=
_name,
> +                offset, __sync_fetch_and_add(&index, 1));

libbpf_%u_%.32s_0x%zx_%d -> we have 12 fixed characters, offset's %zx
can be up to 16, pid is easily 6-7 characters, and then index probably
1-2 digits... so 63 - 12 - 6 - 16 - 2 =3D 27, so if kfunc_name length is
32, we'll be stripping out that index meant to make event name unique
(with high probability).

Let's swap around the order, and put index before %.32s_%zx, shall we?

And I'd just get rid of .32, and let snprintf() do the trimming, if necessa=
ry.


pw-bot: cr

>
> -       /* sanitize binary_path in the probe name */
> +       /* sanitize kfunc_name in the probe name */
>         for (i =3D 0; buf[i]; i++) {
>                 if (!isalnum(buf[i]))
>                         buf[i] =3D '_';
> @@ -11270,7 +11272,7 @@ int probe_kern_syscall_wrapper(int token_fd)
>
>                 return pfd >=3D 0 ? 1 : 0;
>         } else { /* legacy mode */
> -               char probe_name[128];
> +               char probe_name[MAX_EVENT_NAME_LEN];
>
>                 gen_kprobe_legacy_event_name(probe_name, sizeof(probe_nam=
e), syscall_name, 0);
>                 if (add_kprobe_event_legacy(probe_name, false, syscall_na=
me, 0) < 0)
> @@ -11328,7 +11330,7 @@ bpf_program__attach_kprobe_opts(const struct bpf_=
program *prog,
>                                             func_name, offset,
>                                             -1 /* pid */, 0 /* ref_ctr_of=
f */);
>         } else {
> -               char probe_name[256];
> +               char probe_name[MAX_EVENT_NAME_LEN];
>
>                 gen_kprobe_legacy_event_name(probe_name, sizeof(probe_nam=
e),
>                                              func_name, offset);
> @@ -11880,7 +11882,8 @@ static void gen_uprobe_legacy_event_name(char *bu=
f, size_t buf_sz,
>  {
>         int i;
>
> -       snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx", getpid(), binary_path=
, (size_t)offset);
> +       snprintf(buf, buf_sz, "libbpf_%u_%.32s_0x%zx", getpid(),
> +                basename((void *)binary_path), (size_t)offset);
>

let's add that __sync_fetch_and_add(&index) here as well?

>         /* sanitize binary_path in the probe name */
>         for (i =3D 0; buf[i]; i++) {
> @@ -12312,7 +12315,7 @@ bpf_program__attach_uprobe_opts(const struct bpf_=
program *prog, pid_t pid,
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
> --
> 2.43.0
>

