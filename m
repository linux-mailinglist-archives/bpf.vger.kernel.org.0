Return-Path: <bpf+bounces-58209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD55AB71BA
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 18:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97CA38C7FF4
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 16:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B8327E7DE;
	Wed, 14 May 2025 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fABKhUDG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676A227A455;
	Wed, 14 May 2025 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747240761; cv=none; b=ARPWYSk4BxZhH5+eqVVnw4OKPX9PFdMGXReaGERb2yN72SEuEgngAwOG76PHO7hR/arHyfV1flzA7gPFVk0z/D5FgefH1Akfma6Qg0yjymJyLrNCRydLlEvXBTSIsr92iF/0OnBpo3kLdGtagiWImvw5za+ZnNxO4piV51MyA0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747240761; c=relaxed/simple;
	bh=p5viIBVvjlwrAnWfCjIwvHWJv8sSaMN44nMg71GuewQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m0t2KmSlS12hWz29jsWqRp+g1/vzxz5kf17+/u/KVS5Ea3wl96rk3oyGt9Q8eP/P3cTIVdeL/RBgpxC1IbHGTgX5Iyw5qEkU1id2Y0m9JdaBWMMOifbiPT+6HaSxjJ2T37Vz0fJ/8frpbmY0RuLe/cfqKBJDwh2+XbX4Oitz6Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fABKhUDG; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-30c54b40112so43225a91.2;
        Wed, 14 May 2025 09:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747240758; x=1747845558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGE6CkQLlIR21zzBElTsCFwtw1zLGIlMSnQHwkT+hU0=;
        b=fABKhUDGhH0ytaBvXGMqgB8b2YZ+Mm9EARx7FQ7rVOYtr58qC9Q1ti8Odmt4TeH187
         eN1F9NMCwlrdSjz7S6ZqI0Ih6oDDWs0AIoawlDylR+kdtBhmKy/CBrwrsXuC6YeQdDOU
         HetbV43biEgNHUbGnyNkyUvl3csPhQpNQuoRUTVUR9ePCYewlB/z58hbysHM7mc7YJB1
         0Gw+mRUG0SMEnfwTX/xy/ugxK5yUueo0z+ncMuv521RUr626RIUO/wQMHBXLspuSWHD9
         hb5ApslhGi6rm6yiBfrDUtQ7c7YgvfUxBpOZZCpm8NY/O0uqPzQpMZIOcR6gW9Ghddox
         nXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747240759; x=1747845559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZGE6CkQLlIR21zzBElTsCFwtw1zLGIlMSnQHwkT+hU0=;
        b=DMjz99ixDDYymnmnpTD6eNRfiGC7XTAlwITJpfKiOl5MU0v/+xVr+4X/vCzAhuQ7eA
         AAEUyHojPutEnYdho2kjMdyHXsctngtzRnjwZlE1iOm2dKv2cQaNanvUcgcfNn2tPBMN
         MMoCuWUPHHMt+6/Gj9uaz+77KpKRQ3MJnEmqr/jkNqSaauX7e/TgHa4LPsJIAhQx5GrR
         31/eVe2R9K621Lsl5gkLkTqov1r2lxNeWQMsoMCOev/lKv17eB+gnNaD3jDy6ZnM2FV0
         Y46ri52YEq+nQ+41PIeY0w3y2ct1eejo3jwbDTz3DHPkM1GwmaFvWNLK1Ac9DCaK0BJP
         407A==
X-Forwarded-Encrypted: i=1; AJvYcCViYd151cqNKxSe8c0EKNLeSX68MyJgp9eksC+jwibM2rNmps/ww1QQTsbJMwQu+vBgGlibzJj/SHClyv7G@vger.kernel.org, AJvYcCX0b5aVHpugc6AvmEuYZz6z4bPHVeXXb0S52jc5NkbdMTh7PhK0ULFWYQ5m+ROx4v6N4H4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw26ll7IjZZuiQk/dBcy+L4bAikNtEP26+NCYMdbcZM5jqpeBmd
	ndd7Bp9MY2guHykg/hXR/x29Ou97ybQgnBtlBZcGeLQuZV99dwgiKCycSPtIL3V/YpTF0M3xF/3
	Pm9+NHPP5B3j+djaxSd8tg5qdOCk=
X-Gm-Gg: ASbGncuDk+xtdPFWuBqBlgwqWBEy0t4C9bYdVa0O5Vgjk8MTsP0YntDLsWCGn/H8Ci2
	rphnOUsqc2dfr7W3RuVZ3W0l5AMZyTg+NX5TMCb4b1ROoiqnXaJRCiJC3fKOi49QYybnbT+68jv
	Pm2fsN8gcNf0cCu2Ys91MOSrp/3tlis5/wNA0MJ0gTvTTRkpP+Q0ktX51PVmM=
X-Google-Smtp-Source: AGHT+IHHtKDDivlTMiX58+vm5vnXdKeV/iJfUEmGmGeSD8ZwBZVQ+lzAzAaFyJTeRL0m7sKVn2JzATV+P6VG3YwqZ8Y=
X-Received: by 2002:a17:90a:d005:b0:30a:29be:8fe1 with SMTP id
 98e67ed59e1d1-30e2e5e5a57mr7673113a91.9.1747240758568; Wed, 14 May 2025
 09:39:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513035853.75820-1-jiayuan.chen@linux.dev>
 <CAADnVQJJ7pLsm0UTzPOj1H+rdaaY7Lv0As0Te-b+7zieQbntkw@mail.gmail.com> <4741dfb9fa4cf32cef28d9f2b7e7c2e788430800@linux.dev>
In-Reply-To: <4741dfb9fa4cf32cef28d9f2b7e7c2e788430800@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 14 May 2025 09:39:06 -0700
X-Gm-Features: AX0GCFv5zQZmwj3rMgHWwjCh-Y5RekU2Z97uGRJBFskDLUYPSr3APfI0Lbvo68k
Message-ID: <CAEf4BzZdAft9HUc2MOoQqC_SwkiBQgRTPZHB8MJmwVTY8N=sWQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpftool: Add support for custom BTF path in
 prog load/loadall
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 6:51=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> 2025/5/14 05:19, "Alexei Starovoitov" <alexei.starovoitov@gmail.com> wrot=
e:
>
> >
> > On Mon, May 12, 2025 at 8:59 PM Jiayuan Chen <jiayuan.chen@linux.dev> w=
rote:
> >
> > >
> > > This patch exposes the btf_custom_path feature to bpftool, allowing u=
sers
> > >
> > >  to specify a custom BTF file when loading BPF programs using prog lo=
ad or
> > >
> > >  prog loadall commands. This feature is already supported by libbpf, =
and
> > >
> > >  this patch makes it accessible through the bpftool command-line inte=
rface.
> > >
> > >  Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> > >
> > >  ---
> > >
> > >  tools/bpf/bpftool/prog.c | 11 ++++++++++-
> > >
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > >
> > >  diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> > >
> > >  index f010295350be..63f84e765b34 100644
> > >
> > >  --- a/tools/bpf/bpftool/prog.c
> > >
> > >  +++ b/tools/bpf/bpftool/prog.c
> > >
> > >  @@ -1681,8 +1681,17 @@ static int load_with_options(int argc, char *=
*argv, bool first_prog_only)
> > >
> > >  } else if (is_prefix(*argv, "autoattach")) {
> > >
> > >  auto_attach =3D true;
> > >
> > >  NEXT_ARG();
> > >
> > >  + } else if (is_prefix(*argv, "custom_btf")) {
> > >
> > >  + NEXT_ARG();
> > >
> > >  +
> > >
> > >  + if (!REQ_ARGS(1))
> > >
> > >  + goto err_free_reuse_maps;
> > >
> > >  +
> > >
> > >  + open_opts.btf_custom_path =3D GET_ARG();
> > >
> >
> > I don't see a use case yet.
> >
> > What exactly is the scenario where it's useful ?
> >
>
> This patch just exposes the btf_custom_path feature of libbpf to bpftool.
> The argument 'btf_custom_path' in libbpf is used for those kernes that
> don't have CONFIG_DEBUG_INFO_BTF enabled but still want to perform CO-RE
> relocations. Specifically for older kernels, separate BTF files are alrea=
dy
> provided: https://github.com/aquasecurity/btfhub-archive/.
> If we want load prog using bpftool on those systems, we have to hack
> btf__load_vmlinux_btf() before or write custom loader with libbpf and spe=
cify
> 'btf_custom_path'.
>
> I also found a the similar topic:
> https://lore.kernel.org/bpf/20220215225856.671072-1-mauricio@kinvolk.io/
>
> Additionally, pwru supports "--kernel-btf" which serves the same purpose =
as
> this patch.
>
> Therefore, using an external BTF file is a common practice.

I think it's fine to expose this to bpftool. But maybe call the option
"kernel_btf" to make it more obvious that this is BTF representing
kernel types, as opposed to program BTF itself.

