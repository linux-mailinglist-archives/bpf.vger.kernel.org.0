Return-Path: <bpf+bounces-48034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41ED3A033EC
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 01:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AABAB3A1744
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 00:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590A28821;
	Tue,  7 Jan 2025 00:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDjb4oZc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F71182B4
	for <bpf@vger.kernel.org>; Tue,  7 Jan 2025 00:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736209470; cv=none; b=Lt93PCm14V6plLz/5rpzhxZkU14q74Pgqlr+S6ua24ufDfY9hPUW67YjI/iYwqkKxRICiEMVtFZhqqcQCIRcRv/eeFevuEI3CrDqmhniHuCFbgRQ394fJpJQcyYZezFmbPsXoQCAbxI3uPeDSkf+kkheOaNm1/Iz9/q0jb6k5mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736209470; c=relaxed/simple;
	bh=kEkPK9h0Lel+2pcFTObgz5K0sly9q9wJJqeTvcjre5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/+A9O7l3HRhkW4E4ONvh2FLgROmZFNmoLGYUX54HfN3N8RUKnXNhCvn1iryThzs1xOAqFqP+c8q0dY1XjsnDDXbCKhBwoOsihMHfLuE/H9yNZ2oy2uAIJ5pyPhQaJVaOdcoM11ZOPSmDsyO9rYGcrVE9jEAXsgQj6kehvU4kOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDjb4oZc; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-215770613dbso161192355ad.2
        for <bpf@vger.kernel.org>; Mon, 06 Jan 2025 16:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736209469; x=1736814269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mc01VxjTSFKRiAD0OZGTIr4lve6hZA6NiyQhnrkLIjs=;
        b=YDjb4oZcw5gPKuPqXTg+LkoqzlDtgdzlekAVB6Ik58ErDRntxvBHhBNAKZV5oMfwSt
         e3Rx6rg9igo9Ta8+gLsd64HU5AXXk0dRLvMnlfvgWjWCGhYK3dELlvKi9feEpbEj04Wu
         ZhbqMw3tnj52P+6HnaysXqddRJ5eDanxduFRl1sSbllM9NRYBb+alAU9sitFcyDbUhMu
         jIbg5xVX0zjBoA1vIhJDCw+8Z4ct08hrCknjif6Dr1K8mftYOo8ghdKVcSl2/25So61j
         QXfhcIxhN3XSN4+PpcGgFYbmp/pKxUGSmFDW2GUxWSlyoGL9V23gnYL6mEYCH7QH5C6W
         elpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736209469; x=1736814269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mc01VxjTSFKRiAD0OZGTIr4lve6hZA6NiyQhnrkLIjs=;
        b=W3oHiuFym/AZKfIKN+DDLy11uPQwqqO6j8zMAIBfnki/1ODv0wgwl13AN5gIQJg/37
         R4n3U4mAvnMayJWn8Bi+A59k+F6hLsOkE/nAonOWDYW/0MrZC3y0b40Vv9EelwqCNUX3
         n41vG0iwMEEPmMpDESAJR0Zs/SyR3MMBNddy9HpM+yr0i3sfrSE8v+ZvuRTJEjeZCR+A
         73Sbg122pvLwp2+T5feEQAJsWbd7/XMN5K2EWlQot1uSvFu1LW7cstSmzol4J6wvPHBt
         TvqL1snaxGXvRvqheksT2cFfw9CkSwFkz4fJoHewe3/N9qoVRsE5bxiy5BfqYslghxLZ
         fk+A==
X-Gm-Message-State: AOJu0Yy1ubw3skFUFd2RC0LjiPEqTuTfXOcxETPgqKzhOZIFz7LwEhGn
	c5hCmHUUF5vP5wDfua14QhC9IguSm2fAYf+xVnZtgfHSxAI+wIJ1b4/4WxgYfKkpdE6PsUhK6bO
	ZdDBgzU5G2vvhYA38eZSu1my5Sa8=
X-Gm-Gg: ASbGncsCsuXzuzwZ/LPC6lNS5dqSwl5QwxS3AwBBSdftRZHx+VxN9dNXqYshSyQR2+8
	iaeBhf55TMRId4m0PRQ9WL09ZZ3l5YNDgMnQbr40TAIcLIY/FqmdUAA==
X-Google-Smtp-Source: AGHT+IEBpHTtydVlj/PiggLmyigaGxKu3+J3tyni+6d+tKy6N03gvutfc3XPztq2JfO1RfJ1MnSeBotIQytsck3zjZ4=
X-Received: by 2002:a05:6a00:240c:b0:725:9f02:489f with SMTP id
 d2e1a72fcca58-72abdee7688mr95084786b3a.26.1736209468631; Mon, 06 Jan 2025
 16:24:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218225246.3170300-1-yonghong.song@linux.dev>
In-Reply-To: <20241218225246.3170300-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 6 Jan 2025 16:24:14 -0800
X-Gm-Features: AbW1kvaSAtRMzG0ky4EJofVsdI7wy7CioYR38K4ZMZ8xIBXeQGxL2LCKQj0IPYI
Message-ID: <CAEf4BzaJ3cF+StkPoANKDY3q-5Y-vuvEpcWVTq0zvom1mmFbaw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Add unique_match option for multi kprobe
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Jordan Rome <linux@jordanrome.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 2:53=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> Jordan reported an issue in Meta production environment where func
> try_to_wake_up() is renamed to try_to_wake_up.llvm.<hash>() by clang
> compiler at lto mode. The original 'kprobe/try_to_wake_up' does not
> work any more since try_to_wake_up() does not match the actual func
> name in /proc/kallsyms.
>
> There are a couple of ways to resolve this issue. For example, in
> attach_kprobe(), we could do lookup in /proc/kallsyms so try_to_wake_up()
> can be replaced by try_to_wake_up.llvm.<hach>(). Or we can force users
> to use bpf_program__attach_kprobe() where they need to lookup
> /proc/kallsyms to find out try_to_wake_up.llvm.<hach>(). But these two
> approaches requires extra work by either libbpf or user.
>
> Luckily, suggested by Andrii, multi kprobe already supports wildcard ('*'=
)
> for symbol matching. In the above example, 'try_to_wake_up*' can match
> to try_to_wake_up() or try_to_wake_up.llvm.<hash>() and this allows
> bpf prog works for different kernels as some kernels may have
> try_to_wake_up() and some others may have try_to_wake_up.llvm.<hash>().
>
> The original intention is to kprobe try_to_wake_up() only, so an optional
> field unique_match is added to struct bpf_kprobe_multi_opts. If the
> field is set to true, the number of matched functions must be one.
> Otherwise, the attachment will fail. In the above case, multi kprobe
> with 'try_to_wake_up*' and unique_match preserves user functionality.
>
> Reported-by: Jordan Rome <linux@jordanrome.com>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/lib/bpf/libbpf.c | 10 +++++++++-
>  tools/lib/bpf/libbpf.h |  4 +++-
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 66173ddb5a2d..649c6e92972a 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11522,7 +11522,7 @@ bpf_program__attach_kprobe_multi_opts(const struc=
t bpf_program *prog,
>         struct bpf_link *link =3D NULL;
>         const unsigned long *addrs;
>         int err, link_fd, prog_fd;
> -       bool retprobe, session;
> +       bool retprobe, session, unique_match;
>         const __u64 *cookies;
>         const char **syms;
>         size_t cnt;
> @@ -11558,6 +11558,14 @@ bpf_program__attach_kprobe_multi_opts(const stru=
ct bpf_program *prog,
>                         err =3D libbpf_available_kallsyms_parse(&res);
>                 if (err)
>                         goto error;
> +
> +               unique_match =3D OPTS_GET(opts, unique_match, false);
> +               if (unique_match && res.cnt !=3D 1) {
> +                       pr_warn("prog '%s': failed to find unique match: =
cnt %lu\n",
> +                               prog->name, res.cnt);
> +                       return libbpf_err_ptr(-EINVAL);

goto error, leaking resources here


we should also think about interaction of unique_match interaction for
!pattern case, and either reject it (if it makes no sense), or enforce
it (if it does, I haven't really thought about which case do we have)

pw-bot: cr

> +               }
> +
>                 addrs =3D res.addrs;
>                 cnt =3D res.cnt;
>         }
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index d45807103565..3020ee45303a 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -552,10 +552,12 @@ struct bpf_kprobe_multi_opts {
>         bool retprobe;
>         /* create session kprobes */
>         bool session;
> +       /* enforce unique match */
> +       bool unique_match;
>         size_t :0;
>  };
>
> -#define bpf_kprobe_multi_opts__last_field session
> +#define bpf_kprobe_multi_opts__last_field unique_match
>
>  LIBBPF_API struct bpf_link *
>  bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
> --
> 2.43.5
>

