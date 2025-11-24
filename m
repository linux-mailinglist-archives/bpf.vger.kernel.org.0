Return-Path: <bpf+bounces-75376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05094C81E7E
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 18:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 777123AAEA4
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 17:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EF83168F7;
	Mon, 24 Nov 2025 17:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1YbBki0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E762D2D2384
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 17:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764005364; cv=none; b=WgAl3L8Pa2QoW6PUKt3admNa1Up6sVkJLn+l/zXnHWyOKxbvlAhSsPN7WMHUgi9FDRSk8KNi6cZOFW7O3Wt7/4FvL+akMUGLBTV+aVGj8LtcLdH9ThEFwjojD5W1RtQ6iQLiW4EY+lQejM47HCmIi3Rt3pXGnbTcfWXW/FattTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764005364; c=relaxed/simple;
	bh=nVbldNJIQ09d8BWqmwNpLDNQPIgzycozmOoHkvLQXrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZIKdfdLxP4uT8Wg0W+Hf/rUror74ML7T+fcR3vzVVx7LZXXJjHfcNnjmG0fBdv1kCv0VooDRLq+OT2qCNqVAyWt6/jWdL07+dqwZaM/SRn8AkUrZ1MStZaQO1VcNezwRJXbvDiojFj9kjE/HtskS0t1GfD3Yi2NrjXks1LXsIU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1YbBki0; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29806bd47b5so27798875ad.3
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 09:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764005362; x=1764610162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSWpoeUFars1+SkbzKU64xiyOam01ZvK/v+gwE4gmek=;
        b=e1YbBki09MDYUdL3edeYb3i78jleQehEnMfxcxmSayrBcOLgz9HMDsX/V+zfBhqsYW
         Acum2CoCxYUeSMP4LGe03xCXhHvJZDIyxiMWoXz2NawidtF+VTBhjHU7rKlUEmPWQ19L
         MpEEIecg7nQ2YoHkcTNQNKHUMcb/dhif9afiIR9PqhWRmwcldWZEraPSGul7g93zllUT
         yKgPRH+4Ht2wTqSkMhHQ8oD2XZCMVA2J8mJjRxhILExn8coELyYBEMfV5yE0g7lbFYjh
         FpSEZOKVJdCiT/9CxjVsYbg+3VjIDPLv89jRfSCd8+om4+dfV6qaqwBo2g7eHxtdpX2/
         xFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764005362; x=1764610162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QSWpoeUFars1+SkbzKU64xiyOam01ZvK/v+gwE4gmek=;
        b=fNeDfQnab4ex4LB5x4Tan4YdalmD3SY79nwjnTEh8hd6TNBnC7sNv5jGfqk0wuguZK
         paY1MS6kWmsry/Sk+EKTI4IGBiE5JFdQP8LaYspoM8WeRoaq58uVVCnjKo3tOX2Uuhyd
         0W7tk7cD0QJP0CbO1L1qGAWEWtI88juTkCepgGTOwd1iAy0TNY0I7UQ/SCgZHmatqNDT
         2LaMnPq35G1ehugK8ALv2SyfHVtBqw2/0fF1QKdEgrsi8GpXglU4p4gltXYLHDACCSvT
         1H6ILoVdLcU9JOKhyQATizOiahFCoWtAw430m0xBshukj2kK3AIoxQ/k3QR7dyyxxL4G
         3zZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7M2MNYLWO1sMbwbjaaFWhuIUG2zYu3jkuaLrXYGDZnwr65hszwIW+k3Bf39JaRtXSM+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwa+0BRHOU8Cr2Hw1nXqlgJ80RZBxZqXKiBd2Cg5ajn4ejEkjF
	Z5l9dmVW6BsH0MWXbSzG0326QL8Nlui+td/gj/sZyp3chbyjx0jY77w4SXn7E8zQMRxCAGooGAB
	UEDRkUqV8ykTRz1A78CLPrSMKpLcMotQ=
X-Gm-Gg: ASbGnct/4f6Z+UyJ7GNwIsAH//jO4mt/KQEuKIToxCGWrgWkwwpqTLIuCw7hLwhmus4
	PgPf4FXqOZOAIjYef8N++0gi58ClT8A9D6irzzdOVzyFu4YFLULD//OCqOqszOkRGHUJGIjfsAy
	N/2/f4HEK1S4reIMKqaMN12Dp23CFgapXDq4TM4bZMzrtMWmAdh0eDrz4mHS1ewQj8+12qBsSWj
	lFPO8FxwyleAsYSRj+kxHXQbfySNXRN44NcoWpieUoCeY16BpBbhx3xw0lgEuXaxlhIbOXHkBNT
	D8uEddAchQ==
X-Google-Smtp-Source: AGHT+IEHvMGBbvNushYbpqjDlTmTaymEXLXZv59DcbkFPWC7ihP+ZKeRA7im4gTUZpSaLbfezCpAUwRQT/CkLr2wS64=
X-Received: by 2002:a17:903:1211:b0:297:dabf:9900 with SMTP id
 d9443c01a7336-29b6c0aec00mr154079885ad.0.1764005362165; Mon, 24 Nov 2025
 09:29:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117083551.517393-1-jolsa@kernel.org> <20251117083551.517393-4-jolsa@kernel.org>
In-Reply-To: <20251117083551.517393-4-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 24 Nov 2025 09:29:09 -0800
X-Gm-Features: AWmQ_blbLkLvKy3yW9qI-Ms6HOOjTGr3_yF-qJnWAg6MOmvX9UEUfplgzhZZpX0
Message-ID: <CAEf4BzZg3sWvD7TwP-V=qw78TF5O6SEt=qJB05b0yOs-27fkEw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] libbpf: Add support to parse extra info in
 usdt note record
To: Jiri Olsa <jolsa@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 12:36=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote=
:
>
> Adding support to parse extra info in usdt note record that
> indicates there's nop,nop5 emitted for probe.
>
> We detect this by checking extra zero byte placed in between
> args zero termination byte and desc data end. Please see [1]
> for more details.
>
> Together with uprobe syscall feature detection we can decide
> if we want to place the probe on top of nop or nop5.
>
> [1] https://github.com/libbpf/usdt
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/usdt.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> index c174b4086673..5730295e69d3 100644
> --- a/tools/lib/bpf/usdt.c
> +++ b/tools/lib/bpf/usdt.c
> @@ -241,6 +241,7 @@ struct usdt_note {
>         long loc_addr;
>         long base_addr;
>         long sema_addr;
> +       bool nop_combo;
>  };
>
>  struct usdt_target {
> @@ -262,6 +263,7 @@ struct usdt_manager {
>         bool has_bpf_cookie;
>         bool has_sema_refcnt;
>         bool has_uprobe_multi;
> +       bool has_uprobe_syscall;
>  };
>
>  struct usdt_manager *usdt_manager_new(struct bpf_object *obj)
> @@ -301,6 +303,11 @@ struct usdt_manager *usdt_manager_new(struct bpf_obj=
ect *obj)
>          * usdt probes.
>          */
>         man->has_uprobe_multi =3D kernel_supports(obj, FEAT_UPROBE_MULTI_=
LINK);
> +
> +       /*
> +        * Detect kernel support for uprobe syscall to be used to pick us=
dt attach point.
> +        */

nit: single line comment

but I find the wording confusing, we don't really use uprobe() syscall
to pick USDT attach point (which is what comment implies in my mind).
Just say that we detect uprobe() syscall support. It's presence means
we can take advantage of faster nop5 uprobe handling. Also, please add
reference commit hash + message, just like for other feature detectors
here.

> +       man->has_uprobe_syscall =3D kernel_supports(obj, FEAT_UPROBE_SYSC=
ALL);
>         return man;
>  }
>
> @@ -784,6 +791,15 @@ static int collect_usdt_targets(struct usdt_manager =
*man, Elf *elf, const char *
>                 target =3D &targets[target_cnt];
>                 memset(target, 0, sizeof(*target));
>
> +               /*
> +                * We have usdt with nop,nop5 instruction and we detected=
 uprobe syscall,
> +                * so we can place the uprobe directly on nop5 (+1) to ge=
t it optimized.
> +                */
> +               if (note.nop_combo && man->has_uprobe_syscall) {
> +                       usdt_abs_ip++;
> +                       usdt_rel_ip++;
> +               }

how hard would it be to check nop5 instruction in ELF file to be extra
safe? I'm just not sure if I'm 100% comfortable just trusting that
extra zero byte :)

> +
>                 target->abs_ip =3D usdt_abs_ip;
>                 target->rel_ip =3D usdt_rel_ip;
>                 target->sema_off =3D usdt_sema_off;
> @@ -1144,7 +1160,7 @@ struct bpf_link *usdt_manager_attach_usdt(struct us=
dt_manager *man, const struct
>  static int parse_usdt_note(GElf_Nhdr *nhdr, const char *data, size_t nam=
e_off, size_t desc_off,
>                            struct usdt_note *note)
>  {
> -       const char *provider, *name, *args;
> +       const char *provider, *name, *args, *end, *extra;
>         long addrs[3];
>         size_t len;
>
> @@ -1182,6 +1198,15 @@ static int parse_usdt_note(GElf_Nhdr *nhdr, const =
char *data, size_t name_off, s
>         if (args >=3D data + len) /* missing arguments spec */
>                 return -EINVAL;
>
> +       extra =3D memchr(args, '\0', data + len - args);
> +       if (!extra) /* non-zero-terminated args */
> +               return -EINVAL;
> +       ++extra;
> +       end =3D data + len;

end variable just to use it once in the comparison below? Also, how
about just this:

extra++;
if (extra < data + len & *extra =3D=3D '\0')
    note->nop_combo =3D true;

?

(why assuming extra is the very last byte, maybe we'll have more
"extensions" in the future :) )


> +
> +       /* check if we have one extra byte and if it's zero */
> +       note->nop_combo =3D (extra + 1) =3D=3D end && *extra =3D=3D 0;
> +
>         note->provider =3D provider;
>         note->name =3D name;
>         if (*args =3D=3D '\0' || *args =3D=3D ':')
> --
> 2.51.1
>

