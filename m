Return-Path: <bpf+bounces-22984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED48686BDD5
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 02:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1EA12861BB
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 01:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2527B433DA;
	Thu, 29 Feb 2024 00:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/CJ3cI5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4149344376
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 00:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168390; cv=none; b=C94hvQ4M/X3YMSXfvBQQiLi7ep8onWFMpGhEXoG8hZBzLvcXv9Pc+jCwQELS7dFVevhWEJLo0bq5BGKsStCGoUsFx4OeJqzpVhbQsF18hg7yNIrQ1nRKhsR4Qci7a64Mltfac52dYxp99XphGwzzihh7tA2KTYe5b5mZ84uBwyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168390; c=relaxed/simple;
	bh=KIEkMDbIlRWILwDIkP4JH0PnbiXcAM1GT9tuN9Y69so=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENr4oTFeJZAfIiAIavgulNj1eGkPB9Re1hqzvg/juk3myXi4fZOYVbiiMAeXDaccqzvfiJU5gucaWrTvv8EYCF2p5JLeXHLztMTosFSeUJVef7hzZexvjxP5k9tJfm+3rrUzMqLqkOyeMM8WNO1X3i+oTpWtX+71swfqC+3Rn3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/CJ3cI5; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d8b276979aso247895a12.2
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 16:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709168388; x=1709773188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIEkMDbIlRWILwDIkP4JH0PnbiXcAM1GT9tuN9Y69so=;
        b=j/CJ3cI5BF+FR+K9wDAq3NsEHjFas0D1hz192Tv2ngNj99/Euee37RGh2ujcU94Qv9
         EGJNjXpq+v3UMv9YeFkqJt5U45UHNkJ9zRbIgloMG9tmayE/rrJbNwfn1VJEsPgdjMXw
         wRzBhkFLf3aYNbdoMqHWNEX+YpZ5KLWyem74+ZBGXborI0IDCha88XEw9dvNMevob9nA
         mWqYPl/l/rzQbefvI/T6bFEfC9NXtAUQY2bgyzPhiVSycQx5pW7hDqPK2KK7s2Ae5Y9Y
         f4xllqUxlrJLWhF4kuEt32i0Dl9G0ueLNha7m6n0o5cVcWyeWwuOFeFuw6VkjWCLeGYM
         65kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709168388; x=1709773188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIEkMDbIlRWILwDIkP4JH0PnbiXcAM1GT9tuN9Y69so=;
        b=KPW6gWbKeYXMEbOC9BwdmXXXudGUoL4cdQdh/NTNVHQvXOZMdywjVCJaM9RwZajYVD
         oXd6jZKf1A2bGQ9gCzEmT0HJ+AjWlmsWtiUX95UdnXMin5vYRVZVTrFut2krCZVmAPDc
         VGoJPLPPqET5HppvbrMNWkbrnT1r5Hij8BC/cPh5SR8Jclfj1NPpYAGfZEOevzdm1RQt
         wloHlH55JzSZVUEDOv6rzOcQh13RbFsUM0FQHwE9co/NHZMNJkZXUS61XxQ+A12fIgSJ
         ZnoMrC39QGCt8/PIjphA2sCWCdee7n814wsXq4rb16XU0TuylFHv5hgIc+vnWM21Dj0t
         XMfw==
X-Forwarded-Encrypted: i=1; AJvYcCVnigqo4UlKtmUiChLP2vcgp2BPa7vA/tqp34sJrR8gD70iMZROrPT4P9VTKuhkCCRiRzDfltM8lvlKZQ1+bKpCqfMK
X-Gm-Message-State: AOJu0Yyv/dWoKA2OW72T4UAZoogK1u76VPGyWvTSkOzWFD7/2U2aElqd
	jBa/nEm1ZxxRWe/P8OEZE5fle9LlYaYbFqw9HZ9G+MM6XqcccL+AiLHt1e3A25IvumRXCygNS1o
	EYDJg/E7EOqHNUdJAnNCs7SZEfmuDWFHr
X-Google-Smtp-Source: AGHT+IEUEWGlVHPGYN7uiu3UNvEQ7qMp0t+iy1tz8Y0zaZGh93corL8McpWshTBpGbwbK6o4dQqwblBP1PJo3P0ws0U=
X-Received: by 2002:a17:90b:4b41:b0:299:1777:134c with SMTP id
 mi1-20020a17090b4b4100b002991777134cmr811826pjb.33.1709168388479; Wed, 28 Feb
 2024 16:59:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130230510.791-1-git@brycekahle.com> <9b054832-3469-4659-9484-00bcfef87563@isovalent.com>
 <CALvGib8u_owyjKCWcD3ZrFTkUw6dwE2Aev6nG2AD+D++b+R77A@mail.gmail.com>
 <CAEf4Bza=mroJ6+zhK-fCKLutuH_1z9ESeJs+BHbNbCrATrwRdA@mail.gmail.com>
 <dfcd6c3b-dbaa-4e72-acc5-89aed8a836f9@app.fastmail.com> <CAEf4BzZMmbV4H2vLeYO0tm50VV9evLDnUTM69=P7z41v1jY7gw@mail.gmail.com>
 <CALvGib9iaYRkvy0YHpwv3yqx9tNuDbbLNAoeeOpfo_Fnw1bxdA@mail.gmail.com>
In-Reply-To: <CALvGib9iaYRkvy0YHpwv3yqx9tNuDbbLNAoeeOpfo_Fnw1bxdA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Feb 2024 16:59:36 -0800
Message-ID: <CAEf4BzZBGW5V2bv5LsUyBOS0500xeMwxVvtVpsuDk5uUCQZPVw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] bpftool: add support for split BTF to gen min_core_btf
To: Bryce Kahle <bryce.kahle@datadoghq.com>
Cc: Bryce Kahle <git@brycekahle.com>, Quentin Monnet <quentin@isovalent.com>, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 1:48=E2=80=AFPM Bryce Kahle <bryce.kahle@datadoghq.=
com> wrote:
>
> On Fri, Feb 2, 2024, at 2:10 PM, Andrii Nakryiko wrote:
> > But yes, you'd have to specify both vmlinux and all the module
> > BTFs at the same time (which bpftool allows you to do easily with its
> > CLI interface, so not really a problem)
>
> I didn't see a way to specify a directory for vmlinux and all the
> modules BTFs. Are you suggesting I specify the path to each
> individually? I didn't see a way to do that with the current CLI api.
> It assumes that the input is only a single path.

so right now we have

bpftool min_core_btf <input-btf> <output-btf> <input1.bpf.o> ... <inputN.bp=
f.o>

so we'd have to either add a flag and do

bpftool min_core_btf <input-btf> -E <extra-btf1> -E <extra-btf2>
<output-btf> ...

or define special key/value pair (we do that for other commands to
specify extra options):

bpftool min_core_btf <input-btf> extra <extra-btf-1> extra
<extra-btf-2> <output-btf> ....

This has a tiny chance that user used "extra" as a name of one of
input object file (we can probably disregard).

Yet another option is to introduce new command, something like
`bpftool min_core_btf_multi ...` and define new convention.


OR. We can pivot and say that we do what you want as two steps:

1) generate one large combined BTF from multiple BTFs, something along
the lines of `bpftool btf merge <btf1> ... <btfN>`. We'd need to
specify how split BTF should be handled.

2) then use existing min_core_btf command with this merged BTF

I don't know what's best.

>
> On Mon, Feb 5, 2024 at 10:21=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > 2) append each module BTF to that instance (we have btf__add_btf() API
> > already for that). This will rewrite type IDs for each module
> > (shifting them by some constant number)
>
> It looks like btf__add_btf() doesn't support split BTF, which the
> module BTF has to be in order for it to parse correctly. Any
> suggestions for how to proceed? Do I need to add support for split BTF
> to btf__add_btf() to libbpf? If so, any thoughts on how that should
> work would be appreciated.

Yep, seems like it is explicitly not supported. I think one of the
problems with split BTF is that you don't want to append shared types
from base BTF, because that would be a waste. So you need a variant of
btf__add_btf() that allows you to specify a range of types to append.
But at that point what to do if some of the added types reference
types that were not appended? A bunch of unpleasant issues to be dealt
with.

So perhaps instead of using btf__add_btf(), bpftool can just do
btf__add_type() API, which remaps strings properly, but doesn't touch
type IDs. Libbpf has internal btf_type_visit_type_ids() function that
calls provided callback for each field that contains type ID. bpftool
can do its own remapping.

If we assume that we are merging vmlinux BTF and a bunch of module
BTFs, then this remapping is actually pretty straightforward: if type
ID belongs to base BTF, don't touch it. Otherwise shift it by some
amount, common for each type within the module's BTF.

