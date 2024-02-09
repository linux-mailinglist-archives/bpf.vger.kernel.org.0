Return-Path: <bpf+bounces-21648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E49C84FD43
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 20:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAED31F2749A
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 19:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F7884A55;
	Fri,  9 Feb 2024 19:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMlW7fFw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4D74E1A2
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 19:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707508704; cv=none; b=mznfNdPbuuf5uDw5RW4jS+OuMVw36/uscp37/VzTTkCNDRfJ+U1bp4kYmKhLbXFzEWbPiP9+eb9EqcCDLyuXmsOhqtROkObteO0tMjf7JS2HrKLUPP/0FrXMEAj4SEe1a3ioa8pxhaHbKKGcc1Ncy9qpjEB0OtfZsRUCdidi8vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707508704; c=relaxed/simple;
	bh=SviQ3QxJMJNZD1VWf+M1RJ6Sb29YRfnYEoCHXd48ciE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XlCWZKGTUdP0xerkPR8inxI1JjN5W/8c8NBIg1DBSvQiy6b+n17AFR8jsWXlgrug3cxPenvvqbX1vOn/hwGGeSjDNWhyNSW/EXakYSDAfGwGndFwhakIz81rOYfa5BiCVEi2f6eTyZlyK9gJJWx2GCV5hWZ3jOhTLeE81jjYMjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMlW7fFw; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e09aada5fdso422165b3a.2
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 11:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707508702; x=1708113502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WG1lm66VOFKTJLtoIsi2AHthaL5WIWfwGA8kvRnuOg=;
        b=NMlW7fFwEA6bBuqOqT6quh+HL0VaGXKkT2snlu3dfEDTL/52t/S18BH0dWPwFPIJfk
         DMSG0qS7/0HyN7Gdt8hSPSluxzDc/3BHbc2cLZhhG4oAT2X1Y1TQT+GijXWcPz46nWto
         rfvubqXh18E9nZBN8b0fCcsfT0Q3HgIdjRD8CRvR1W9JDhP2GhQZgSZMJ0JGn9rjONfm
         kgtlX97/FVg+CaJL3/VkJQPNAR3c+d2GTpguWOwc8wgspi1CkZcLPv0UH8fsHkJz2rp9
         8WdMqzH7cqIOK/XC4FP4gC7XsEmDvfYRZpAuOUxzgFt/PdTnNw9/dfXdRLKBmRVw1/2t
         qtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707508702; x=1708113502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WG1lm66VOFKTJLtoIsi2AHthaL5WIWfwGA8kvRnuOg=;
        b=I/AytptdFknVLPfc1k4vCsR+KhZka4Fy06ir3QPEGFs6qdfPO3fiZ9j4bmbD+PIflT
         YpJ42eXd90oYJwpmi6m/ZlPeMqLzgnXpQTpZ53WUkjWVyY03GWtzRkSJ53ANQeiLRx/e
         7HtguuYIoFLHxiYJ9jPnXabjSyzT2xseqOfe2zg/JRdF7OUy2/PglNQUXTsQujDssaps
         qX7NEFmkNGcBOdIizG64RKLf4Xe5Pjw8BanGDltN6beHpZyJBXNy+lBrfZaY7DvTxT6p
         hDjYVEzaNvan+3b/+RhTy8GeVvwVS+a/5LD7dXhJZUMCh6lol8Ew4uv8J9OisDGPlHT1
         RVMg==
X-Gm-Message-State: AOJu0Ywn2hS6fK7Umb0d5tde0CHJ7y0a+r3+f1s4jkubKvJ0noRN9nmE
	A6+k6cV9PtguCy7f/6AG6avKVjgNhUaiy98XahQrhkM+XwuUUqg/rpMuv2KL+EFiQ+vvrpXVyW4
	yLbOUMS3zSgNzjg3QHhDaq0G0eo0=
X-Google-Smtp-Source: AGHT+IGn/IyHDxd8HGPzmReblBtHpHyDCwgukrqys6Pj4ahyBv5P0XMRYsxx9P8cSRwhQ6xlG6/k1ryfuXzQKuVij2Q=
X-Received: by 2002:a17:90a:fc90:b0:296:d339:eea9 with SMTP id
 ci16-20020a17090afc9000b00296d339eea9mr51442pjb.16.1707508701854; Fri, 09 Feb
 2024 11:58:21 -0800 (PST)
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
 <CALvGib8LtTY8qBN+tvZTzb_GKNOX4R9YEUxkOL0ghuQmjG8Yqg@mail.gmail.com>
 <c4624866-894f-4340-ac97-41bbb683c149@linux.dev> <CAEf4BzZ94O0=PGczhtCMc+-T1DoNUV1rG5TsfFq1qFahbMptyg@mail.gmail.com>
 <7f4b6a8d-a4ea-48ff-b195-d00ce2f2fe52@linux.dev> <5c186046-77c7-4e5a-bdbe-ea699a18ec70@oracle.com>
In-Reply-To: <5c186046-77c7-4e5a-bdbe-ea699a18ec70@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Feb 2024 11:58:09 -0800
Message-ID: <CAEf4BzbmQXw5FyNyi4g9Hx-0yJxPAmjUPA2-T+-bnq95+Cw8XQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] bpftool: add support for split BTF to gen min_core_btf
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Bryce Kahle <bryce.kahle@datadoghq.com>, 
	Bryce Kahle <git@brycekahle.com>, Quentin Monnet <quentin@isovalent.com>, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 3:01=E2=80=AFPM Alan Maguire <alan.maguire@oracle.co=
m> wrote:
>
> On 08/02/2024 01:56, Yonghong Song wrote:
> >
> > On 2/7/24 4:30 PM, Andrii Nakryiko wrote:
> >> On Wed, Feb 7, 2024 at 2:38=E2=80=AFPM Yonghong Song <yonghong.song@li=
nux.dev>
> >> wrote:
> >>>
> >>> On 2/7/24 10:51 AM, Bryce Kahle wrote:
> >>>> On Mon, Feb 5, 2024 at 10:21=E2=80=AFAM Andrii Nakryiko
> >>>> <andrii.nakryiko@gmail.com> wrote:
> >>>>> 3) btf__dedup() will deduplicate everything, so that only unique ty=
pe
> >>>>> definitions remain.
> >>>>>
> >>> A random thought about another way.
> >>> At module side, we keep
> >>>     - module btf
> >>>     - another section (e.g. .BTF.extra) to keep minimum kernel-side
> >>>       types which directly used by module btf
> >>>
>
> Yep, that's exactly the approach I was pursuing; an extra section
> containing those types (I was calling it .BTF.base_minimal).
>
> >>>     for example, module btf has
> >>>       struct foo {
> >>>         struct task_struct *t;
> >>>       }
> >>>       module btf encoding will have id, say 20,
> >>>       for 'struct task_struct' which is at that time
> >>>       the id in linux kernel.
> >>>     Then the module .BTF.extra contains
> >>>       id 20: struct task_struct type encoding
> >>>       there is no need to encode more types beyond pointers.
> >>>       this can be simpler or more complex depending
> >>>       on what to do during module load.
> >>>
>
> Right, or in BTF you can use a FWD declaration for task_struct. The
> approach I'm using explicitly identifies types that are only
> pointer-referenced and uses FWDS for them, and this helps keep the
> representation as small as possible.
>
> >>> When a module load:
> >>>     For each .BTF.extra entry, trying to match
> >>>     the corresponding types in the current kernel.
> >>>     The type in the current type should have same
> >>>     size as the one in .BTF.extra if otherwise
> >>>     layout in the module btf may change.
> >>>
> >>>     If new kernel type can be used for module BTF,
> >>>     simply replace the old id with new id in module BTF.
> >>>
> >>>     Otherwise, type mismatch may happen and the corresponding
> >>>     module btf type should be invalidated.
>
> Yep, this is the process I describe as reconciliation; where we make
> sure base BTF at encoding time and current vmlinux BTF are compatible,
> and if so we renumber base BTF references in the module using the
> current vmlinux BTF ids. So if compatible, after reconciliation the
> module BTF looks just like any other module BTF built against that exact
> vmlinux.
>
> >> Yes, I agree, see my reply to Alan. I'm just unsure how strict we want
> >> to be and whether we need to record fields of expected vmlinux BTF
> >> types. Or if just recording expected size would be enough (to ensure
> >> correct memory layout if base BTF type is embedded into module BTF
> >> type).
> >>
> >> Perhaps, if BTF type is referenced from some "trusted" BTF type (used
> >> by kfunc, or in BTF ID set) we might want to enforce strict
> >> compatibility, but for any other type just make sure that size is
> >> correct (if it matters at all; i.e., if base BTF type is referenced by
> >> pointer only, we don't even need to check size).
> >
> > Agree. The above is a good start. I guess some real-world investigation=
s
> > can help shape the actual design about what is the minimum change to
> > make it work.
> >
>
> I'll try and send a pointer to the work-in-progress code prior to the
> BPF office hours next week. In investigating how much info is required,
> for most in-tree modules (which I force-built with minimal BTF) we ended
> up with information about 4000 types or so. So it's a significant
> minimization compared to vmlinux BTF.

4000 is still quite a lot and is a significant fraction of vmlinux BTF
types. I'm curious if you measured the size increase from recording
these types?

>
> In this context, perhaps my describing the information we collect about
> base BTF as minimization is misleading; the intent is really focused not
> on making base BTF small (although of course that's important from a
> practical perspective), but collecting the info about base BTF needed to
> later reconcile it with the running kernel at load time. Maybe
> .BTF.base_expects or something like that might make this clearer? Thanks!
>
> Alan
> >>
> >> WDYT?
> >>
> >>>> Since minimization only keeps used struct and union members, couldn'=
t
> >>>> you have two internal types from different modules which conflict an=
d
> >>>> end up using the wrong offset?
> >>>>
> >>>> Example:
> >>>> in module M:
> >>>> struct S {
> >>>> ... // other unused members
> >>>> int x; // offset 12 (for example)
> >>>> }
> >>>>
> >>>> in module N:
> >>>> struct S {
> >>>> ... // other unused members
> >>>> int x; // offset 20 (something different from S.x in module M)
> >>>> }
> >>>>
> >

