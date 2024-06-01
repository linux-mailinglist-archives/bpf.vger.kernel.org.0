Return-Path: <bpf+bounces-31082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2518D6D6F
	for <lists+bpf@lfdr.de>; Sat,  1 Jun 2024 03:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4028B241EE
	for <lists+bpf@lfdr.de>; Sat,  1 Jun 2024 01:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B455C6FB9;
	Sat,  1 Jun 2024 01:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZswFm/b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E7315CE
	for <bpf@vger.kernel.org>; Sat,  1 Jun 2024 01:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717207169; cv=none; b=HPV81FLQWOGJpMUu3dLOxXqF2MjR3GimiJTEpg0nL5kazv5ETTsxo8xTE6Yt8CA7v/oT4TQ7KYUvr1mAcwfUsErfESqKl4ERhHbi5pleCSdtaXmGpKQOsQWFNjNwbjm6qK5oJONO+90b5sJhUHMBKPIbRspoM6Mhhs9ZeRysKLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717207169; c=relaxed/simple;
	bh=ztEA5nn7xI+TL3BQPN69tvQZUfOlJ7O3PfcB0g2++4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BZXVdsjKPdVLR2CEzUgnzvKrg22yQANzQDMt+wsx+a7vBd6KgkvpUGyOcR8d9lub4MDnfaAlwtgJZEbEznQVIsu/6LW82L6XTXOTADSopVAgZs7EWewldrQgRXSur3ztwAfivZYxPv6Uc83uK+CVuabOXqqNPf/brlx/WzUby6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZswFm/b; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-681953ad4f2so1911856a12.2
        for <bpf@vger.kernel.org>; Fri, 31 May 2024 18:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717207167; x=1717811967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NX6rsHmGDlcP3zI7nFcSJyEBqBJJePs9cWexWtIx9GY=;
        b=aZswFm/b4oFsKk/BK6j1Lz8FjzWn+zwCggo1skQ9KC4bqDoyRqdZ1ZGFaSKHG5lgwv
         Jdi5iEVeEXuFcnCN6eeJkRB66a4aEHyczhAYuHUviBDrGDlIHQzTV/L02cXiiCZMVGwI
         QjnYel9QN6Q77IieXn3XTg5IfPiNDU/fWMX/H47qwuzbH02NnAZElG0PNCCmMz11dVIr
         +IsqeF9VTf3a+5cnpks4xW9V/KedBSlsCc01nd9txaUE5r4alZA9dFy6AQaD9S5PJ9jM
         08E62M/O2IwNXj4KcdSnJiw6wVDJbPxroYIPvyY0yGrIc19+qAOGxbAB4Kz5tSzn9iAZ
         AoEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717207167; x=1717811967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NX6rsHmGDlcP3zI7nFcSJyEBqBJJePs9cWexWtIx9GY=;
        b=ERMJPhcSFjXMYkxC9Cyrd2bowIioda21ybi9IY4FxcidllIOntIj3Ymr27tppRjmtF
         kwZ879iaLIezkTbKgCZWb74amDxgFJ6Mey+uhxHQkMpIE7VVSm3SsSPoRuxC0DMfy9q/
         3Yz5DjnWabFUaWd+yPjSpOGsOOs6RHrbCC8DwoC/ZYgJGvdhKCy0mB5eONUbRNPWG3XN
         OYA77bUxZSu2h7tn8sdrPPZWnz11J1YeJzLMiZYNcEq0IZqoV5efuwNqbMkJtWmcWl3C
         Al3Qfl4eC0jibZO4sZDChz04jIJyUQ8rlx0Fdgu3bFa4eBpkVBX4ojRiLRchIbbV3iWk
         F1Lw==
X-Forwarded-Encrypted: i=1; AJvYcCWOoqWzPWivFRR8+5x7jkXwlE73iaquJx9mRVsO+W8GaVq6/q0zwkFvmZEM/KZC9brumDs0xbqVMgD+0zIE1xuu/gGW
X-Gm-Message-State: AOJu0Ywz6lGLk3nAKvvuyGK542j73UBq9ehmDWLeOAPk62b00IRUOaEi
	zElr6nQDyIn/L3iHhmEj2QqpbIKbJuE1cmtvOJtN8U2Xljitv/EqNcl1wOdoqlRNUDigy2ExhMH
	JKXT4lRrTxfydJ2+EGWMKn5HsWu4=
X-Google-Smtp-Source: AGHT+IFHhyfBXFVKRb/qBiWQYwOmwJqe6jSQr8UZ0OzfyjBcH07Z/vhiN+P9w2JU3oDCBd1IBfAE6JrqvYl0lbs0kkU=
X-Received: by 2002:a17:90b:d89:b0:2bd:b43f:4b with SMTP id
 98e67ed59e1d1-2c1dc5cad3amr3460710a91.31.1717207167003; Fri, 31 May 2024
 18:59:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528122408.3154936-1-alan.maguire@oracle.com>
 <20240528122408.3154936-9-alan.maguire@oracle.com> <CAEf4BzaJQAyHmSOTyQaLCx29zFQZEZnHR+gaTNt-Ae5nvi7G6g@mail.gmail.com>
In-Reply-To: <CAEf4BzaJQAyHmSOTyQaLCx29zFQZEZnHR+gaTNt-Ae5nvi7G6g@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 31 May 2024 18:59:14 -0700
Message-ID: <CAEf4BzZ4Z38GspkSi8QjdGTfwFvNZ3aVPjGjU-6XQte+dKwWVQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 8/9] libbpf,bpf: share BTF relocate-related
 code with kernel
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com, 
	quentin@isovalent.com, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org, 
	masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 12:04=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, May 28, 2024 at 5:25=E2=80=AFAM Alan Maguire <alan.maguire@oracle=
.com> wrote:
> >
> > Share relocation implementation with the kernel.  As part of this,
> > we also need the type/string visitation functions so add them to a
> > btf_common.c file that also gets shared with the kernel. Relocation
> > code in kernel and userspace is identical save for the impementation
> > of the reparenting of split BTF to the relocated base BTF and
> > retrieval of BTF header from "struct btf"; these small functions
> > need separate user-space and kernel implementations.
> >
> > One other wrinkle on the kernel side is we have to map .BTF.ids in
> > modules as they were generated with the type ids used at BTF encoding
> > time. btf_relocate() optionally returns an array mapping from old BTF
> > ids to relocated ids, so we use that to fix up these references where
> > needed for kfuncs.
> >
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > ---
> >  include/linux/btf.h          |  45 ++++++++++
> >  kernel/bpf/Makefile          |  10 ++-
> >  kernel/bpf/btf.c             | 168 +++++++++++++++++++++++++----------
> >  tools/lib/bpf/Build          |   2 +-
> >  tools/lib/bpf/btf.c          | 130 ---------------------------
> >  tools/lib/bpf/btf_iter.c     | 143 +++++++++++++++++++++++++++++
> >  tools/lib/bpf/btf_relocate.c |  23 +++++
> >  7 files changed, 344 insertions(+), 177 deletions(-)
> >  create mode 100644 tools/lib/bpf/btf_iter.c
> >
>
> [...]
>
> > +static inline struct btf_decl_tag *btf_decl_tag(const struct btf_type =
*t)
> > +{
> > +       return (struct btf_decl_tag *)(t + 1);
> > +}
> > +
> >  static inline int btf_id_cmp_func(const void *a, const void *b)
> >  {
> >         const int *pa =3D a, *pb =3D b;
> > @@ -515,9 +528,17 @@ static inline const struct bpf_struct_ops_desc *bp=
f_struct_ops_find(struct btf *
> >  }
> >  #endif
> >
> > +typedef int (*type_id_visit_fn)(__u32 *type_id, void *ctx);
> > +typedef int (*str_off_visit_fn)(__u32 *str_off, void *ctx);
> > +
>
> let me take a quick stab at implementing type/str field iterator in
> libbpf. If I don't get stuck anywhere, maybe you can just rebase on
> that and avoid the callback hell and the need for this
> callback-vs-iter churn in the kernel code as well
>

Sent it out as one RFC patch (which unfortunately makes it harder to
see iterator logic, sorry; but I ran out of time to split it
properly), see [0].
It is especially nice when per-field logic is very simple (like
bpftool's gen.c logic, where we just remap ID). Please take a look and
let me know what you think.

  [0] https://patchwork.kernel.org/project/netdevbpf/patch/20240601014505.3=
443241-1-andrii@kernel.org/

> >  #ifdef CONFIG_BPF_SYSCALL
> >  const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_=
id);
> > +void btf_set_base_btf(struct btf *btf, const struct btf *base_btf);
> > +int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **=
map_ids);
> > +int btf_type_visit_type_ids(struct btf_type *t, type_id_visit_fn visit=
, void *ctx);
> > +int btf_type_visit_str_offs(struct btf_type *t, str_off_visit_fn visit=
, void *ctx);
> >  const char *btf_name_by_offset(const struct btf *btf, u32 offset);
> > +const char *btf_str_by_offset(const struct btf *btf, u32 offset);
> >  struct btf *btf_parse_vmlinux(void);
> >  struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog);
> >  u32 *btf_kfunc_id_set_contains(const struct btf *btf, u32 kfunc_btf_id=
,
>
> [...]

