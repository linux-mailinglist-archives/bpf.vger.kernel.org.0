Return-Path: <bpf+bounces-57865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F2FAB1974
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 17:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E55CBA26D7E
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 15:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68192238157;
	Fri,  9 May 2025 15:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esan7kPu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F7E2367D1;
	Fri,  9 May 2025 15:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746806068; cv=none; b=Oe9pOGcstVV9whMnuezVGWgbFAp4JtmaaGucK2IjTOBuGQIy7u1xFQZOaC2R+cVmSvdoXfy2nQQi/CdrIOg+1rTlWKZFh0XiicSzH06FleKnfhzEQIPKcdxCVLteLUoXOCAj25xzZeqybrcqajrjSg+Qpg9eJ8pgW/TIOKgbkWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746806068; c=relaxed/simple;
	bh=Sui2EcUfyEFEiiBj9npahfEdi8XviSyQkLNYyZHPRJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b6tdMTlnbvssumS7ODGnAsLGTXi9YASrebq/EjJbiMz3BwiFFLY3p8Kymdtk3ZBc7skRISwG+1FL5tC3nuJlt/NsqE2bUAsS+oXGBHg2lw24XjdiyR2GvKujuuMxl5vQCz/lViDTFiSCUGEpvkkeLkbV0SQsZU0pQi9F3ED46hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esan7kPu; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-30ab344a1d8so2312091a91.3;
        Fri, 09 May 2025 08:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746806066; x=1747410866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yz6pDe71ckfZADdpZgYyIVOXkOuqeIhTAPzRX03e+oA=;
        b=esan7kPuuA1ndJOX2hDMSMa3SNfaDuiLCMRoUApKqf+aaVphFaSrjj8x6iKOlcc4tw
         LgkYupQ1cV9MgMO9Ja4cqZQhczqOfZAqo3we0sKIpz6TlznuRd7uVApSJZaLaHCSpmD4
         HYzH0aAMqT0jtRqZqg15B35EC9RePhfjEhLfF4ddIkHlapd1q9t2/ztlYcd5shiAL4ff
         BWpESXxP4FzqivnvUrWtyuyr8I4zAhjgHaieKpJeDqNlJJTGDW2EPu2GaVFpeC6ftR4p
         Rp+Am3j/NkXu2ec70HFrOGJuJ860qt5bFfZNx/z0xzpFOUBQZHHs7jVhStFwB1ZYzvjK
         j08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746806066; x=1747410866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yz6pDe71ckfZADdpZgYyIVOXkOuqeIhTAPzRX03e+oA=;
        b=wwp/z8LzRtjPFn4HBDo8s6xSjmgpfCWsWygbiBO99HdXds7qD2e6ubWA2ApurEANJW
         Qq8BgzkILO2EH4EDMH6UfqzGB+Se+/+mG/ZemZ9WMHMaKlnFrP9vCPcq63NvbhTQ9+We
         7WKjbn2vIMEWhkUwj3PlxFompze9yRKNMZo4iEy3QzmbFfDpO9+/0Ua4uQfVMRfclWxn
         tgIstPolgC0t3sUih4l5oYJpARxnGcHpiTY6zEamqLkHXVF63Syhv3vl1r73GT9ruKtF
         owAx7zYa4/jTlBlZmxDUYgTaXb/fh38n/PTg8pBKko4SjeMQTrwXSnaBJtBlNwmtQP1z
         5yrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkB84FIE6u4X7WhitDW/Zcxi+qfUtzaLIrN07X8NWaQvLTvjlPTIpQzmeIU/nMG+gOWjOZ9hrfIcYqi5kbgopyQQ==@vger.kernel.org, AJvYcCW5uEYrDhIQj0qhnYIl5HnjHKcPWrF2ns2oeAS9R8/1WIeDC3WDXQ58vfuWl0AMGrnPB8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJdGBZ6fGtREC6Yc/ZSjEr1zJliMsoDs5jBgYQpARzqqM9+lBY
	rdCqKcMt8QOwg6rKeORTHa3+og9r0KNyEm5Q1MYy/s8/4c1otyvqkXToJahoW9CLnHm4hTLFqGD
	Ea+btjShvwSUf25lQoYhXD4ZXFSJQiuux
X-Gm-Gg: ASbGncvlpcS4nduemIayzOn9Qtt0g3G1si3vWvN0F+Kwc5aBd9IePtImVv7H2P9D4cX
	PV2ZFOgflu0TXP0FkhTgt9cML8C6EKxj+yafTMU7r8K4FrjzLMxEJC5MR+XLLuqnzgT0GF9vMgg
	vBhXJAC+9yhnsnGbIvSRpZ8Mh/5q3jya6r57ic3A==
X-Google-Smtp-Source: AGHT+IFs9bvuO1HL/nFDkN10tn2aX8i2fj1KaEl/BofeuLq37eMzGJjUKwIzA727WP8jVdou6+mByNXD80MtOgeP268=
X-Received: by 2002:a17:90b:1fcc:b0:2ee:dd9b:e402 with SMTP id
 98e67ed59e1d1-30c3cff2babmr8312426a91.12.1746806066125; Fri, 09 May 2025
 08:54:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506135727.3977467-1-jolsa@kernel.org> <20250506135727.3977467-4-jolsa@kernel.org>
 <CAEf4Bzbpn8kQV8ORoBv7iDR1VxT0uUf=qqjanFQFtFx1fSjrQQ@mail.gmail.com>
 <aBsgQw1kzJsRzM5p@krava> <aB4fpAlfNhshy5DA@krava>
In-Reply-To: <aB4fpAlfNhshy5DA@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 May 2025 08:54:13 -0700
X-Gm-Features: ATxdqUGEacgOCN2wIh9C0kOvfo_aS5tl4Yi2jLhAkQLxswtKX1ggx2808mOWWFI
Message-ID: <CAEf4Bzbsj2xAxhpH1zkT+EWVntOq9+tevN+SS=tRm-uwLMjxCw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] bpftool: Display ref_ctr_offset for uprobe
 link info
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Yafang Shao <laoar.shao@gmail.com>, Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 8:30=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Wed, May 07, 2025 at 10:56:35AM +0200, Jiri Olsa wrote:
> > On Tue, May 06, 2025 at 03:33:33PM -0700, Andrii Nakryiko wrote:
> > > On Tue, May 6, 2025 at 6:58=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> w=
rote:
> > > >
> > > > Adding support to display ref_ctr_offset in link output, like:
> > > >
> > > >   # bpftool link
> > > >   ...
> > > >   42: perf_event  prog 174
> > > >           uprobe /proc/self/exe+0x102f13  cookie 3735928559  ref_ct=
r_offset 50500538
> > >
> > > let's use hex for ref_ctr_offset?
> >
> > I had that, then I saw cookie was dec ;-) either way is fine for me
> >
> > >
> > > and also, why do we have bpf_cookie and cookie emitted? Are they diff=
erent?
> >
> > hum, right.. so there's bpf_cookie retrieval from perf_link through the
> > task_file iterator:
> >
> >   cbdaf71f7e65 bpftool: Add bpf_cookie to link output
> >
> > I guess it was added before we decided to have bpf_link_info.perf_event
> > interface, which seems easier to me
>
> we could drop the bpf_cookie with attached patch, but should we worry
> about loosing 'bpf_cookie' tag from json output (there will be just
> 'cookie' tag now with the same value)
>

I don't have strong feelings about this, but note that bpf_cookie is
available on more kernel versions than the more recently added
uprobe-specific cookie. If it's not too cumbersome, maybe we can just
not display bpf_cookie *if* kernel provides uprobe-specific cookie
information? Not sure, don't really care all that much, just noticed
duplication earlier and thought to point this out.

> jirka
>
>
> ---
> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
> index 9eb764fe4cc8..ca8923425637 100644
> --- a/tools/bpf/bpftool/main.h
> +++ b/tools/bpf/bpftool/main.h
> @@ -104,9 +104,7 @@ struct obj_ref {
>
>  struct obj_refs {
>         int ref_cnt;
> -       bool has_bpf_cookie;
>         struct obj_ref *refs;
> -       __u64 bpf_cookie;
>  };
>
>  struct btf;
> diff --git a/tools/bpf/bpftool/pids.c b/tools/bpf/bpftool/pids.c
> index 23f488cf1740..e81518dfc835 100644
> --- a/tools/bpf/bpftool/pids.c
> +++ b/tools/bpf/bpftool/pids.c
> @@ -80,8 +80,6 @@ static void add_ref(struct hashmap *map, struct pid_ite=
r_entry *e)
>         memcpy(ref->comm, e->comm, sizeof(ref->comm));
>         ref->comm[sizeof(ref->comm) - 1] =3D '\0';
>         refs->ref_cnt =3D 1;
> -       refs->has_bpf_cookie =3D e->has_bpf_cookie;
> -       refs->bpf_cookie =3D e->bpf_cookie;
>
>         err =3D hashmap__append(map, e->id, refs);
>         if (err)
> @@ -214,9 +212,6 @@ void emit_obj_refs_json(struct hashmap *map, __u32 id=
,
>                 if (refs->ref_cnt =3D=3D 0)
>                         break;
>
> -               if (refs->has_bpf_cookie)
> -                       jsonw_lluint_field(json_writer, "bpf_cookie", ref=
s->bpf_cookie);
> -
>                 jsonw_name(json_writer, "pids");
>                 jsonw_start_array(json_writer);
>                 for (i =3D 0; i < refs->ref_cnt; i++) {
> @@ -246,9 +241,6 @@ void emit_obj_refs_plain(struct hashmap *map, __u32 i=
d, const char *prefix)
>                 if (refs->ref_cnt =3D=3D 0)
>                         break;
>
> -               if (refs->has_bpf_cookie)
> -                       printf("\n\tbpf_cookie %llu", (unsigned long long=
) refs->bpf_cookie);
> -
>                 printf("%s", prefix);
>                 for (i =3D 0; i < refs->ref_cnt; i++) {
>                         struct obj_ref *ref =3D &refs->refs[i];
> diff --git a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c b/tools/bpf/bpftoo=
l/skeleton/pid_iter.bpf.c
> index 948dde25034e..ea6d54f43425 100644
> --- a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
> +++ b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
> @@ -15,19 +15,6 @@ enum bpf_obj_type {
>         BPF_OBJ_BTF,
>  };
>
> -struct bpf_perf_link___local {
> -       struct bpf_link link;
> -       struct file *perf_file;
> -} __attribute__((preserve_access_index));
> -
> -struct perf_event___local {
> -       u64 bpf_cookie;
> -} __attribute__((preserve_access_index));
> -
> -enum bpf_link_type___local {
> -       BPF_LINK_TYPE_PERF_EVENT___local =3D 7,
> -};
> -
>  extern const void bpf_link_fops __ksym;
>  extern const void bpf_link_fops_poll __ksym __weak;
>  extern const void bpf_map_fops __ksym;
> @@ -52,17 +39,6 @@ static __always_inline __u32 get_obj_id(void *ent, enu=
m bpf_obj_type type)
>         }
>  }
>
> -/* could be used only with BPF_LINK_TYPE_PERF_EVENT links */
> -static __u64 get_bpf_cookie(struct bpf_link *link)
> -{
> -       struct bpf_perf_link___local *perf_link;
> -       struct perf_event___local *event;
> -
> -       perf_link =3D container_of(link, struct bpf_perf_link___local, li=
nk);
> -       event =3D BPF_CORE_READ(perf_link, perf_file, private_data);
> -       return BPF_CORE_READ(event, bpf_cookie);
> -}
> -
>  SEC("iter/task_file")
>  int iter(struct bpf_iter__task_file *ctx)
>  {
> @@ -102,18 +78,6 @@ int iter(struct bpf_iter__task_file *ctx)
>         e.pid =3D task->tgid;
>         e.id =3D get_obj_id(file->private_data, obj_type);
>
> -       if (obj_type =3D=3D BPF_OBJ_LINK &&
> -           bpf_core_enum_value_exists(enum bpf_link_type___local,
> -                                      BPF_LINK_TYPE_PERF_EVENT___local))=
 {
> -               struct bpf_link *link =3D (struct bpf_link *) file->priva=
te_data;
> -
> -               if (BPF_CORE_READ(link, type) =3D=3D bpf_core_enum_value(=
enum bpf_link_type___local,
> -                                                                    BPF_=
LINK_TYPE_PERF_EVENT___local)) {
> -                       e.has_bpf_cookie =3D true;
> -                       e.bpf_cookie =3D get_bpf_cookie(link);
> -               }
> -       }
> -
>         bpf_probe_read_kernel_str(&e.comm, sizeof(e.comm),
>                                   task->group_leader->comm);
>         bpf_seq_write(ctx->meta->seq, &e, sizeof(e));
> diff --git a/tools/bpf/bpftool/skeleton/pid_iter.h b/tools/bpf/bpftool/sk=
eleton/pid_iter.h
> index bbb570d4cca6..5692cf257adb 100644
> --- a/tools/bpf/bpftool/skeleton/pid_iter.h
> +++ b/tools/bpf/bpftool/skeleton/pid_iter.h
> @@ -6,8 +6,6 @@
>  struct pid_iter_entry {
>         __u32 id;
>         int pid;
> -       __u64 bpf_cookie;
> -       bool has_bpf_cookie;
>         char comm[16];
>  };
>

