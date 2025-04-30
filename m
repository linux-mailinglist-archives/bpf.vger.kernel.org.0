Return-Path: <bpf+bounces-57100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64691AA5870
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 01:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8B8D7BA3C5
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 22:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFA6227EA8;
	Wed, 30 Apr 2025 23:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBA78vKv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF00219EA5
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 23:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746054015; cv=none; b=Ti0Kry6rSCTpnlptQVMEkIw1Vy8bOHPa+RYkHpPsua6z6uyvEs6Nf7ZPyND5TGUwvf6iTpugcMetd/7pqPbxrEddIS35kDLo/ixdxLDpXS2byZot96OSIe7NyGNFPnh4QyMA90rwAlAApncppEdhU4baWxxxLZ3FOzifSGAQBMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746054015; c=relaxed/simple;
	bh=OzkT6LY6B/y1F976qo3q4Ou2yQeYAKUjBw1LzcMFgZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mUz0FXWmoWW+i7L3HBxDupEiTQyKCtO/yk8Pol4A8tfHGNA5sNbl+n3mA55NXLFAaHb5OCcx+HIeRN50Qp2Uw612BxC9pJZN6JU+l5fvXEIf7D70H0e6kPfIFRQVUvMddR6YSlqVbiRA72vq58ChhI0bQ//6A+ubj0EW2A7v0yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBA78vKv; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43690d4605dso2689375e9.0
        for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 16:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746054012; x=1746658812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjXpZnnINzV1ph5z7IDKHaM28HM1sv5+Pa/L6zHaPpE=;
        b=UBA78vKvcVmttmOEI/dBp7+hVenZIfW9+OuHC2bqDUaQAn5D6H3KJY0llgwxWodD0O
         UdnSIMy0Q/0vAaHmreSWj+gn3cGyzLiFREaL3TklgPT99A9fw1XgWat/cXaTlag/AqBA
         /y/kS7JMja5IgAhVnDWss62MoLNyTf6JYKy/LWdyA12vFJ0BMkVOn3I5Fuu2rCRfoadI
         3EFA1WrqQ3zP8EERhNA7YoXg3mFY1ifrLMhkXpwB0EDYq5s8aP8mXgrVOro5ai5PrrZa
         sLTf0AfRNDjIrnwYIcDIZvlN3JDLsSyQsJZVRVg9B/7DQrnv7Ym5eMFJKTw1UCO1B1KJ
         2K8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746054012; x=1746658812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjXpZnnINzV1ph5z7IDKHaM28HM1sv5+Pa/L6zHaPpE=;
        b=SUilIwX9D96QnwxnjGARREgfHUqebxAeHE9Qt0nbL2pm4/W2lG0J8N9bY6kcPdUHD3
         mdemtnk+IkU7Dphl3mZGDZoJLJWRlaJGGGAzTAM3cNNzpn5+u/+h+VelSI69CmdOrnUm
         ccvoYeyLPauBp6hf0/5rRWLPDexrKqZi/XJ+XMXZW+Y2jffLELVBHXBq1NsxX+Kc07cx
         kA11qeptF1OP7ZdI3KAZ2gbP56QW6VScEu0O94d1hd7Fu5ttL3Hn/k/Opw5lIH9Utiry
         LGX4B0EQWA/uzwx/rndntlALYwRMEdM8bBqQYtsZ01/r267lf2l0o8ZKg+GchSTfCahF
         8dbg==
X-Gm-Message-State: AOJu0YyMRCJISzlzKu2O3sd794h6ezTerggd70FDi2z78CvvGf6YFAvR
	h/9wSj7nocyn8/02vEQnTwNB3aGB7mFVo/oF/Kz3CrXHmTH4MW6WCUADXwS5mLsJuYJ4sBLMrtU
	9vvdgqcQtF2fn+ZEZVCigmdS20z4=
X-Gm-Gg: ASbGncv9wz7Iv6NXk0B0phIX7BtgX7HFsONnN21sLHvgcKw8sm9C5BwLNlB30oSev6T
	hApEZepTih+kPAKAFMnqLm4VVb/tt9SGVKLooBbDC5ITzbgeA291e3lxnpbYQ2CgIdN8kNL2d9p
	XWXZi3dzP5zwEtABUj9VEoNqNrfOgxa6hCb37QJw==
X-Google-Smtp-Source: AGHT+IEdYll7XCQtw2TrCmK69PWM8/GY8f3f2c+jzsjMhozaBfuEaDUPp61LpWjPTnSqsOwj1fQBGgR93cn4TlUweWA=
X-Received: by 2002:a05:6000:1847:b0:39e:cbca:7161 with SMTP id
 ffacd0b85a97d-3a09303069bmr702335f8f.10.1746054011714; Wed, 30 Apr 2025
 16:00:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PH7PR11MB652381F4B833B4B5CE2AEABAA9832@PH7PR11MB6523.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB652381F4B833B4B5CE2AEABAA9832@PH7PR11MB6523.namprd11.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 30 Apr 2025 16:00:00 -0700
X-Gm-Features: ATxdqUEvgAqrnMJkhyeX2kn2pz1yjaQYC8Ijy2nYIFN27WRSM0khYrGWqf5RctE
Message-ID: <CAADnVQJ0aRud=VeQ7dWhFqEqVQQCozKqtP9mHwuHOj5ua+5J4A@mail.gmail.com>
Subject: Re: Looking for feedback on kfuncs for dentry_path_raw, get_dentry_from_kiocb
To: "Preble, Adam C" <adam.c.preble@intel.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 10:39=E2=80=AFAM Preble, Adam C <adam.c.preble@inte=
l.com> wrote:
>
> I was trying to use an eBPF script to dump all paths being created, opene=
d, modified, or deleted. I hit a wall when I couldn't figure out how to ext=
ract the actual path from anything and figured exposing dentry_path_raw as =
a BPF-accessible function would do it. I was thinking of sending this code =
upstream, and I've included a patch, but I figure I should ask some questio=
ns first:
>
> 1. Is this even the right place to be asking all this? I assume the d_pat=
h.c maintainers would also have a word or two (probably linux-fsdevel), but=
 I'm focusing on if these kfuncs are even sensible.
> 2. Actually, could I have gotten the path from something without writing =
any new code in the first place? I was kprobing various vfs_* functions tha=
t would give me a dentry*.
> 3. What's the etiquette on ignored pointers? I'm designating the dentry* =
as an ignored type.
> 4. Should functions like this hide behind a build configuration constant?
> 5. What would be the proper workflow for formally submitting it as a patc=
h? Is this mailing list the best entryway? I expect actual file maintainers=
 have final say, but I wonder if other people get brought in for BPF stuff.
>
> This patch is based off my work on 6.13, but applies and on 6.15 (based o=
n 8bac8898fe398ffa3e09075ecea2be511725fb0b). An allyesconfig build pukes at=
 the vmlinux.o creation because 6.15 is really big for some reason, and it =
does that for me regardless.
>
> From 2c8b5d111ad7c75f41b4c1ff330b1c856e535632 Mon Sep 17 00:00:00 2001
> From: Adam Preble <adam.c.preble@intel.com>
> Date: Tue, 1 Apr 2025 18:15:31 -0500
> Subject: [PATCH] d_path: BPF kfuncs for dentry_path_raw, get_dentry_from_=
kiocb
>
> We were trying to extract paths from dentry records when using a kprobe
> eBPF program against the following functions:
>
> vfs_create
> vfs_rmdir
> vfs_mknod
> vfs_symlink
> vfs_link
> vfs_unlink
> vfs_mkdir
> do_mkdirat
> generic_write_checks
> notify_change
>
> Most of these functions take in a dentry pointer, with
> generic_write_checks taking in a kiocb pointer instead. We expose
> dentry_path_raw and bpf_get_dentry_from_kiocb to extract these paths.
> ---
>  fs/d_path.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/fs/d_path.c b/fs/d_path.c
> index 5f4da5c8d5db..6487eac09596 100644
> --- a/fs/d_path.c
> +++ b/fs/d_path.c
> @@ -1,5 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> +#include <linux/bpf.h>
>  #include <linux/syscalls.h>
> +#include <linux/dcache.h>
>  #include <linux/export.h>
>  #include <linux/uaccess.h>
>  #include <linux/fs_struct.h>
> @@ -368,6 +370,58 @@ char *dentry_path_raw(const struct dentry *dentry, c=
har *buf, int buflen)
>  }
>  EXPORT_SYMBOL(dentry_path_raw);
>
> +__bpf_kfunc_start_defs();
> +// The dentry argument needs to be ignored because the verifier can't ve=
rify
> +// the integrity of the pointer coming in from kprobes.

Exactly.
It's probably obvious that we're not going to allow
unsafe kfuncs that can easily crash the kernel.

> +__bpf_kfunc char *bpf_dentry_path_raw(struct dentry *dentry__ign,

We can consider something like this (without __ign, of course),
but if you insist on using kprobes we cannot help.

You can walk dentry with probe_read-s instead,
but don't expect correct paths all the time.

> +                                     char *buf, int buf__sz)
> +{
> +       char *retvar =3D NULL;
> +
> +       dget(dentry__ign);
> +       if (!dentry__ign)
> +               return NULL;
> +
> +       retvar =3D dentry_path_raw(dentry__ign, buf, buf__sz);
> +       dput(dentry__ign);
> +
> +       if (IS_ERR(retvar) || retvar < buf || retvar >=3D buf + buf__sz) =
{
> +               if (buf__sz > 0)
> +                       buf[0] =3D '\0';
> +       } else {
> +               // dentry_path_raw starts at the end of the buffer and wo=
rks
> +               // back to the beginning. We need to bump it back to the =
start.
> +               memcpy(buf, retvar, buf + buf__sz - retvar);
> +       }
> +
> +       return retvar;
> +}
> +
> +__bpf_kfunc struct dentry *bpf_get_dentry_from_kiocb(struct kiocb *iocb_=
_ign)
> +{
> +       struct file *file =3D iocb__ign->ki_filp;
> +       struct dentry *d =3D file->f_path.dentry;
> +       return d;
> +}
> +
> +__bpf_kfunc_end_defs();
> +BTF_KFUNCS_START(bpf_file_kfunc_set_ids)
> +BTF_ID_FLAGS(func, bpf_dentry_path_raw, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_get_dentry_from_kiocb, KF_TRUSTED_ARGS)
> +BTF_KFUNCS_END(bpf_file_kfunc_set_ids)
> +
> +static const struct btf_kfunc_id_set bpf_dentry_task_kfunc_set =3D {
> +       .owner =3D THIS_MODULE,
> +       .set   =3D &bpf_file_kfunc_set_ids,
> +};
> +
> +static int init_subsystem(void)
> +{
> +       int ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &bpf_=
dentry_task_kfunc_set);
> +       return ret;
> +}
> +late_initcall(init_subsystem);
> +
>  char *dentry_path(const struct dentry *dentry, char *buf, int buflen)
>  {
>         DECLARE_BUFFER(b, buf, buflen);
> --
> 2.34.1
>
>

