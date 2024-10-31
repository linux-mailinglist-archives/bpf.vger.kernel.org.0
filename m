Return-Path: <bpf+bounces-43677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A16C9B871B
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 00:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C7BE1C21A12
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 23:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA841BD9DC;
	Thu, 31 Oct 2024 23:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSex4Hbb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BB51E1A37
	for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 23:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730417066; cv=none; b=Y+3d/9V2ElbB6BV4gjSc/lr7B44yiVcApAaBP5vymFfNkBJw7c2u8tkC8p0AtgJXZ5YWisnwlUf0Rr6G6qITWiiMVAyxdQgdNXrU+U3eJsqxI0SJsGnuQr+Yd71SWKiWu/IbJdlK4AOEQbQfgJzNIeFkqvB4kfMdZOGXiFQas5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730417066; c=relaxed/simple;
	bh=0tV5EefxuJprHrTN9zjruFQNy5uQdf9msEbdSa7nch8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OirFm0JfSZNWd2SxRr1K8V+z7/AOgJ966DiJpdjH2xS7XNus9RPhKbVvPpzGAz0baYMPasoC30Ib3qqklg5dND5MwIK0G7jc/A7Pw2TMtTF8XM52YK2JzpdCLBpFrsENUfU4FZYCb01SdWdyxuNhzbv7GcQclY+daJGQi3Bl43w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSex4Hbb; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c9150f9ed4so1978893a12.0
        for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 16:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730417058; x=1731021858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdTQ0EYM5uLsZOn1z9LHYv4NJ0PTQrIZwvIJHW5Fyq0=;
        b=TSex4HbblZQmCO6nfzG+tHms2IOQNgWCqrq6FmMtj5z7HaKQcdYapHd9XX2X0AK0UB
         Y+HObsRnGyOw25/r8F3XM7gMEFdkjfnyE9DvAmUblFU1WRpyZ8LHO0uCN4dtp7v9sS2Y
         tZo0j6D982CFubPIRC0vNZHQz2mN/XjqO7xDrJ51tjND4lvyEOjsQiXdhhYboHIxJPyC
         EeWhfryB1NiXK7suaeFHHkZ545CuSZuluHZy+foCpryi/Q6FHisbZ2+N/zqwaTMl/V/B
         6gvtHDmGQalA2q2EhwleeiDqrdvSUZXjayaCSL2GbRs++J3Dadw0owkc/VT2ifizL/oO
         XW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730417058; x=1731021858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UdTQ0EYM5uLsZOn1z9LHYv4NJ0PTQrIZwvIJHW5Fyq0=;
        b=O/zgtFozdJpVzOXwTJzRijT+UnB3HcfsQev2FpJ2abZDa40NE3/T7Gu4FIanBOLvKp
         FWGFX1Y5WohVq/EW0/1QhJdmaJIX8piZTKB6zxmwPxOxR8r7A8TIgZU30ydZMcxiTMOy
         G1IOJSVI54hzHbMFT8xgtNb3+pyHAtw45gnQII5sh1rR1B3v9nIzNQ028TKioQuBhYKS
         ObB50eXSjSLwFOb4aQjVqm1JdXNJYiVEEdu5M41fjy6RRIMJ3AmMze7UE88X2ZbSwalN
         gH1p/5AwP11S2wj/l4jv801zJOh6BStcxu95dQB7IE5Br8yiVrj7aKI7t0MpmAyoQQGT
         c2cQ==
X-Gm-Message-State: AOJu0Yyps+jra6gDfC8XNnigF0naT+F7TgpVfC24uKom1dDauGqvuR/S
	gNPB4j1jJR093G3iaLTGSEts/7hsCisSivUqOdM10Qp6BMbaJLfyL0gfX/wiIoh95mPYPy1H4fs
	yUNLxKqUlwOOlEvWSZa78jeMJRb4cCDW8
X-Google-Smtp-Source: AGHT+IG2FeBzAdxldFTmelxwJbiZT2B+CVWDtoSeEf2zWF/vgUqptzN/54pCnttDHGN02dLo8L9YUixB4gi/5Q/jzJo=
X-Received: by 2002:a17:907:1c22:b0:a99:ee4e:266d with SMTP id
 a640c23a62f3a-a9de5c91a9cmr2008066366b.1.1730417057575; Thu, 31 Oct 2024
 16:24:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031220001.436552-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20241031220001.436552-1-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 31 Oct 2024 16:24:03 -0700
Message-ID: <CAEf4Bzb5SXORCOUHcCw52+B1XqCL7nBA9cPW9+SjnBa+kA9Mgw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: stringify error codes in warning messages
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 3:00=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Libbpf may report error in 2 ways:
>  1. Numeric errno
>  2. Errno's text representation, returned by strerror
> Both ways may be confusing for users: numeric code requires people to
> know how to find its meaning and strerror may be too generic and
> unclear.
>
> This patch modifies libbpf error reporting by swapping numeric codes and
> strerror with the standard short error name, for example:
> "failed to attach: -22" becomes "failed to attach: EINVAL".
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/lib/bpf/libbpf.c | 401 +++++++++++++++++++++--------------------
>  1 file changed, 205 insertions(+), 196 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 711173acbcef..fac6b744302b 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -226,6 +226,42 @@ static const char * const prog_type_name[] =3D {
>         [BPF_PROG_TYPE_NETFILTER]               =3D "netfilter",
>  };
>
> +static const char * const errno_text[] =3D {
> +       [1] =3D "EPERM", [2] =3D "ENOENT", [3] =3D "ESRCH",
> +       [4] =3D "EINTR", [5] =3D "EIO", [6] =3D "ENXIO", [7] =3D "E2BIG",
> +       [8] =3D "ENOEXEC", [9] =3D "EBADF", [10] =3D "ECHILD", [11] =3D "=
EAGAIN",
> +       [12] =3D "ENOMEM", [13] =3D "EACCES", [14] =3D "EFAULT", [15] =3D=
 "ENOTBLK",
> +       [16] =3D "EBUSY", [17] =3D "EEXIST", [18] =3D "EXDEV", [19] =3D "=
ENODEV",
> +       [20] =3D "ENOTDIR", [21] =3D "EISDIR", [22] =3D "EINVAL", [23] =
=3D "ENFILE",
> +       [24] =3D "EMFILE", [25] =3D "ENOTTY", [26] =3D "ETXTBSY", [27] =
=3D "EFBIG",
> +       [28] =3D "ENOSPC", [29] =3D "ESPIPE", [30] =3D "EROFS", [31] =3D =
"EMLINK",
> +       [32] =3D "EPIPE", [33] =3D "EDOM", [34] =3D "ERANGE", [35] =3D "E=
DEADLK",
> +       [36] =3D "ENAMETOOLONG", [37] =3D "ENOLCK", [38] =3D "ENOSYS", [3=
9] =3D "ENOTEMPTY",
> +       [40] =3D "ELOOP", [42] =3D "ENOMSG", [43] =3D "EIDRM", [44] =3D "=
ECHRNG",
> +       [45] =3D "EL2NSYNC", [46] =3D "EL3HLT", [47] =3D "EL3RST", [48] =
=3D "ELNRNG",
> +       [49] =3D "EUNATCH", [50] =3D "ENOCSI", [51] =3D "EL2HLT", [52] =
=3D "EBADE",
> +       [53] =3D "EBADR", [54] =3D "EXFULL", [55] =3D "ENOANO", [56] =3D =
"EBADRQC",
> +       [57] =3D "EBADSLT", [59] =3D "EBFONT", [60] =3D "ENOSTR", [61] =
=3D "ENODATA",
> +       [62] =3D "ETIME", [63] =3D "ENOSR", [64] =3D "ENONET", [65] =3D "=
ENOPKG",
> +       [66] =3D "EREMOTE", [67] =3D "ENOLINK", [68] =3D "EADV", [69] =3D=
 "ESRMNT",
> +       [70] =3D "ECOMM", [71] =3D "EPROTO", [72] =3D "EMULTIHOP", [73] =
=3D "EDOTDOT",
> +       [74] =3D "EBADMSG", [75] =3D "EOVERFLOW", [76] =3D "ENOTUNIQ", [7=
7] =3D "EBADFD",
> +       [78] =3D "EREMCHG", [79] =3D "ELIBACC", [80] =3D "ELIBBAD", [81] =
=3D "ELIBSCN",
> +       [82] =3D "ELIBMAX", [83] =3D "ELIBEXEC", [84] =3D "EILSEQ", [85] =
=3D "ERESTART",
> +       [86] =3D "ESTRPIPE", [87] =3D "EUSERS", [88] =3D "ENOTSOCK", [89]=
 =3D "EDESTADDRREQ",
> +       [90] =3D "EMSGSIZE", [91] =3D "EPROTOTYPE", [92] =3D "ENOPROTOOPT=
", [93] =3D "EPROTONOSUPPORT",
> +       [94] =3D "ESOCKTNOSUPPORT", [95] =3D "EOPNOTSUPP", [96] =3D "EPFN=
OSUPPORT", [97] =3D "EAFNOSUPPORT",
> +       [98] =3D "EADDRINUSE", [99] =3D "EADDRNOTAVAIL", [100] =3D "ENETD=
OWN", [101] =3D "ENETUNREACH",
> +       [102] =3D "ENETRESET", [103] =3D "ECONNABORTED", [104] =3D "ECONN=
RESET", [105] =3D "ENOBUFS",
> +       [106] =3D "EISCONN", [107] =3D "ENOTCONN", [108] =3D "ESHUTDOWN",=
 [109] =3D "ETOOMANYREFS",
> +       [110] =3D "ETIMEDOUT", [111] =3D "ECONNREFUSED", [112] =3D "EHOST=
DOWN", [113] =3D "EHOSTUNREACH",
> +       [114] =3D "EALREADY", [115] =3D "EINPROGRESS", [116] =3D "ESTALE"=
, [117] =3D "EUCLEAN",
> +       [118] =3D "ENOTNAM", [119] =3D "ENAVAIL", [120] =3D "EISNAM", [12=
1] =3D "EREMOTEIO",
> +       [122] =3D "EDQUOT", [123] =3D "ENOMEDIUM", [124] =3D "EMEDIUMTYPE=
", [125] =3D "ECANCELED",
> +       [126] =3D "ENOKEY", [127] =3D "EKEYEXPIRED", [128] =3D "EKEYREVOK=
ED", [129] =3D "EKEYREJECTED",
> +       [130] =3D "EOWNERDEAD", [131] =3D "ENOTRECOVERABLE", [132] =3D "E=
RFKILL", [133] =3D "EHWPOISON",
> +};
> +

some error codes are architecture-specific, so lookup table is not
ideal. I think it will be better to just have a simple switch()
statement in errstr() function

also, I don't think, practically speaking, that we need to have all
possible error codes translated. There are 10-20 of errors that might
happen, and I'd be fine having error number for other rare case (plus
we can always update the list)

one important thing that seems to be missing here is:

#define ENOTSUPP     524

It's not part of Linux UAPI (so there won't be ENOTSUPP identifier),
but we should make sure to understand it, as it happens very often
with bpf() subsystem

>  static int __base_pr(enum libbpf_print_level level, const char *format,
>                      va_list args)
>  {
> @@ -336,6 +372,20 @@ static inline __u64 ptr_to_u64(const void *ptr)
>         return (__u64) (unsigned long) ptr;
>  }
>

let's add a comment reminding that string returned from this helper is
invalidated upon next errstr() call

> +static const char *errstr(int err)
> +{
> +       static __thread char buf[11];
> +
> +       if (err < 0)
> +               err =3D -err;
> +
> +       if (err < ARRAY_SIZE(errno_text) && errno_text[err])
> +               return errno_text[err];

nit: we should preserve original minus sign

> +
> +       snprintf(buf, ARRAY_SIZE(buf), "%d", err);

nit: sizeof(buf), ARRAY_SIZE() is useful when element type is not a byte

and also please restore original minus sign here as well

> +       return buf;
> +}
> +
>  int libbpf_set_strict_mode(enum libbpf_strict_mode mode)
>  {
>         /* as of v1.0 libbpf_set_strict_mode() is a no-op */
> @@ -1550,11 +1600,7 @@ static int bpf_object__elf_init(struct bpf_object =
*obj)
>         } else {
>                 obj->efile.fd =3D open(obj->path, O_RDONLY | O_CLOEXEC);
>                 if (obj->efile.fd < 0) {
> -                       char errmsg[STRERR_BUFSIZE], *cp;
> -
> -                       err =3D -errno;
> -                       cp =3D libbpf_strerror_r(err, errmsg, sizeof(errm=
sg));
> -                       pr_warn("elf: failed to open %s: %s\n", obj->path=
, cp);
> +                       pr_warn("elf: failed to open %s: %s\n", obj->path=
, errstr(err));
>                         return err;
>                 }
>
> @@ -1960,8 +2006,8 @@ bpf_object__init_internal_map(struct bpf_object *ob=
j, enum libbpf_map_type type,
>         if (map->mmaped =3D=3D MAP_FAILED) {
>                 err =3D -errno;
>                 map->mmaped =3D NULL;
> -               pr_warn("failed to alloc map '%s' content buffer: %d\n",
> -                       map->name, err);
> +               pr_warn("failed to alloc map '%s' content buffer: %s\n",
> +                       map->name, errstr(err));

if it fits in under 100 characters, let's make such pr_*() statements
single-line

>                 zfree(&map->real_name);
>                 zfree(&map->name);
>                 return err;
> @@ -2125,7 +2171,7 @@ static int parse_u64(const char *value, __u64 *res)
>         *res =3D strtoull(value, &value_end, 0);
>         if (errno) {
>                 err =3D -errno;
> -               pr_warn("failed to parse '%s' as integer: %d\n", value, e=
rr);
> +               pr_warn("failed to parse '%s': %s\n", value, errstr(err))=
;
>                 return err;
>         }
>         if (*value_end) {

[...]

> @@ -5026,11 +5074,10 @@ bpf_object__probe_loading(struct bpf_object *obj)
>                 ret =3D bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GP=
L", insns, insn_cnt, &opts);
>         if (ret < 0) {
>                 ret =3D errno;
> -               cp =3D libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
> -               pr_warn("Error in %s():%s(%d). Couldn't load trivial BPF =
"
> +               pr_warn("Error in %s():%s. Couldn't load trivial BPF "

nit: ':<space> %s'

>                         "program. Make sure your kernel supports BPF "
>                         "(CONFIG_BPF_SYSCALL=3Dy) and/or that RLIMIT_MEML=
OCK is "

while you are at it, please make the message a single-line string to
improve grepping

> -                       "set to big enough value.\n", __func__, cp, ret);
> +                       "set to big enough value.\n", __func__, errstr(re=
t));
>                 return -ret;
>         }
>         close(ret);

[...]

> @@ -5287,12 +5326,9 @@ static int bpf_object__create_map(struct bpf_objec=
t *obj, struct bpf_map *map, b
>                                         def->max_entries, &create_attr);
>         }
>         if (map_fd < 0 && (create_attr.btf_key_type_id || create_attr.btf=
_value_type_id)) {
> -               char *cp, errmsg[STRERR_BUFSIZE];
> -
>                 err =3D -errno;
> -               cp =3D libbpf_strerror_r(err, errmsg, sizeof(errmsg));
> -               pr_warn("Error in bpf_create_map_xattr(%s):%s(%d). Retryi=
ng without BTF.\n",
> -                       map->name, cp, err);
> +               pr_warn("Error in bpf_create_map_xattr(%s):%s. Retrying w=
ithout BTF.\n",

please add space (I know it didn't have it before, but let's make all
this as consistent as possible)

> +                       map->name, errstr(err));
>                 create_attr.btf_fd =3D 0;
>                 create_attr.btf_key_type_id =3D 0;
>                 create_attr.btf_value_type_id =3D 0;

I didn't really look through the rest of conversions, but please make
sure the styling is consistent (if there are any deviations)

[...]

pw-bot: cr

