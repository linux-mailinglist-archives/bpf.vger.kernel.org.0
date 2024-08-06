Return-Path: <bpf+bounces-36486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2048D9497B5
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 20:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F6628496E
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 18:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976592772A;
	Tue,  6 Aug 2024 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MryIgUM5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656CC33086;
	Tue,  6 Aug 2024 18:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722969907; cv=none; b=JjvJEDzKZC+3aK0vL7CK1Eh1OKR5LnEJhmit+mau5MqVjz/H2Ii+m09hc4qNL9p2mzyNs7msQnjap5Y3cV/P2EUWRb+gzNXx2E3GvSCM05QYo8B3Es0/YPukNA/gvJdsR2DJb6upxckCoXOLepl4LmiRtxwhGNU2tLF4ZAmaPYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722969907; c=relaxed/simple;
	bh=MksspJt2OKMM69Yrantzwk9v9PcjMC/A1WzVqiZAm8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EAr/X6IVouObWza/pyFUWpfZqDpAbd1fvQJv0I3eT4PSqNA3mee0deMI4MqJO+3mLjAcLx/J1e1U4ppsUyLemmg6ZpCfJCvYFv5+1PK+Kr7XfHl+vLpq9X8XhMz7ThV1nP7YG53VK3Xkgwc9JG9qxtC3LSawF4ySoEv8r0ezaow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MryIgUM5; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3687fd09251so553125f8f.0;
        Tue, 06 Aug 2024 11:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722969903; x=1723574703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+u1OFVQHObJoguvXtjDzPNwznZJF1zF62hr/WPNRsY=;
        b=MryIgUM5YQH0i2xCuLmjjEsRKaOe2TZVfqz+fRi8Su4cyp3vR0009tGcW4VAjInR0a
         4JToD6MoaXkHqDY+akVy1n+IX1gIT4VDg/r0A0UQl2USU7H2avyb9ELzMgm683KQuXnU
         0nyP+pJHP9xZmXIZBtFMZpiXOhVBC5hGUeiqlQIwoy59CmnqLqZVL7deyakiYFzarBGA
         bD2SL9PeSmNfBG62Kh6qbSFECZW1EkNiEQDMz961YIMAmiUlxx+zt3lOdaWGO2UwdsKr
         S7FZo86akJNXdqaChKmE8YHa48it1ee8dYXV3d0KhboWVnyNKY7EJqpJboaOWhtUW1T/
         0ZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722969903; x=1723574703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+u1OFVQHObJoguvXtjDzPNwznZJF1zF62hr/WPNRsY=;
        b=a7o7jDBmUprs4P4cRDZwV/RY30rxk6u1fUZh5g/hcfpLIX5sUzgDeM2nZTfIsLYPEZ
         5YrtmxpPPU/7QTq1VMgmmkHwDNaiorPBhPyKRX/xUA4F2H7BSWnxfdUgTIOnW5WB9lq9
         vyfZrENpgYTFVdPa3WU9UFOs2awNuuX0jsOvHQNX8eZxBdNor8evsGKYFo8bkzblMDKp
         u2zGfAdvc7OsFGGp+UO4Mx2hiYcw2ngpsbCXSFqa333cDEHLpl7/rGkNyQ4yW1wkgzum
         QN74vFF/I6HzflvNGwh9lSyV5oLazDIetiCDPtBBCiRCInDhgPMm+q1koZJuZaT8pvUs
         4u4w==
X-Forwarded-Encrypted: i=1; AJvYcCUchkITY5wgVAVUtXP4b/NmHeq4NYbs+Oa03/xATSbrB4Q64K1JRVuf01ew7IUfIffAteesJRV7PMU12S5wUa/67xwGhW7SCqXZ4Wg5TuZbJG9nslUKLbQJmN25SYNumrBg
X-Gm-Message-State: AOJu0YwjIIdta697rm0x8d5haRClcIB1pIq1hsPhfM5GpbHd2WOYercQ
	XZ4PkisFugGt93L/EAlM6nRNU92BsFfmihxII1nqbyNNFJONgbAVl1NtrPdayvUnVZv1UOxaJgJ
	Dkm3aKXku4wYVYi48ZQRQXAuGE2qE/aon
X-Google-Smtp-Source: AGHT+IHQbiLxLHtymrNy+OahMY6SNPajRcpz2Vds9fPFsNIQjOamRr9F1Xpj/oyyzoEJEOXfutTs5YgZylQnerU4doQ=
X-Received: by 2002:a5d:4c82:0:b0:36b:b24b:d14f with SMTP id
 ffacd0b85a97d-36bbc0fca5dmr10199002f8f.36.1722969903285; Tue, 06 Aug 2024
 11:45:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZrCZS6nisraEqehw@jlelli-thinkpadt14gen4.remote.csb>
 <ZrECsnSJWDS7jFUu@krava> <CAADnVQLMPPavJQR6JFsi3dtaaLHB816JN4HCV_TFWohJ61D+wQ@mail.gmail.com>
 <ZrIj9jkXqpKXRuS7@krava>
In-Reply-To: <ZrIj9jkXqpKXRuS7@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 6 Aug 2024 11:44:52 -0700
Message-ID: <CAADnVQ+NpPtFOrvD0o2F8npCpZwPrLf4dX8h8Rt96uwM+crQcQ@mail.gmail.com>
Subject: Re: NULL pointer deref when running BPF monitor program (6.11.0-rc1)
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Artem Savkov <asavkov@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 6:24=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> > Jiri,
> >
> > the verifier removes the check because it assumes that pointers
> > passed by the kernel into tracepoint are valid and trusted.
> > In this case:
> >         trace_sched_pi_setprio(p, pi_task);
> >
> > pi_task can be NULL.
> >
> > We cannot make all tracepoint pointers to be PTR_TRUSTED | PTR_MAYBE_NU=
LL
> > by default, since it will break a bunch of progs.
> > Instead we can annotate this tracepoint arg as __nullable and
> > teach the verifier to recognize such special arguments of tracepoints.
>
> ok, so you mean to be able to mark it in event header like:
>
>   TRACE_EVENT(sched_pi_setprio,
>         TP_PROTO(struct task_struct *tsk, struct task_struct *pi_task __n=
ullable),
>
> I guess we could make pahole to emit DECL_TAG for that argument,
> but I'm not sure how to propagate that __nullable info to pahole
>
> while wondering about that, I tried the direct fix below ;-)

We don't need to rush such a hack below.
No need to add decl_tag and change pahole either.
The arg name is already vmlinux BTF:
[51371] FUNC_PROTO '(anon)' ret_type_id=3D0 vlen=3D3
        '__data' type_id=3D61
        'tsk' type_id=3D77
        'pi_task' type_id=3D77
[51372] FUNC '__bpf_trace_sched_pi_setprio' type_id=3D51371 linkage=3Dstati=
c

just need to rename "pi_task" to "pi_task__nullable"
and teach the verifier.


> jirka
>
>
> ---
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 95426d5b634e..1a20bbdead64 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6377,6 +6377,25 @@ int btf_ctx_arg_offset(const struct btf *btf, cons=
t struct btf_type *func_proto,
>         return off;
>  }
>
> +static bool is_tracing_prog_raw_tp(const struct bpf_prog *prog, const ch=
ar *name)
> +{
> +       struct btf *btf =3D prog->aux->attach_btf;
> +       const struct btf_type *t;
> +       const char *tname;
> +
> +       if (prog->expected_attach_type !=3D BPF_TRACE_RAW_TP)
> +               return false;
> +
> +       t =3D btf_type_by_id(btf, prog->aux->attach_btf_id);
> +       if (!t)
> +               return false;
> +
> +       tname =3D btf_name_by_offset(btf, t->name_off);
> +       if (!tname)
> +               return false;
> +       return !strcmp(tname, name);
> +}
> +
>  bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>                     const struct bpf_prog *prog,
>                     struct bpf_insn_access_aux *info)
> @@ -6544,6 +6563,10 @@ bool btf_ctx_access(int off, int size, enum bpf_ac=
cess_type type,
>                 }
>         }
>
> +       /* Second argument of sched_pi_setprio tracepoint can be null */
> +       if (is_tracing_prog_raw_tp(prog, "btf_trace_sched_pi_setprio") &&=
 arg =3D=3D 1)
> +               info->reg_type |=3D PTR_MAYBE_NULL;
> +
>         info->btf =3D btf;
>         info->btf_id =3D t->type;
>         t =3D btf_type_by_id(btf, t->type);

