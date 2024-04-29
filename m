Return-Path: <bpf+bounces-28150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF1C8B6339
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 22:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48A72B2214F
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 20:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BB21411C9;
	Mon, 29 Apr 2024 20:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpHOpVqW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9DD81728
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 20:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714421279; cv=none; b=dse3DmcAFEdC0Di6NFzgB7TnbLCNAV2dNUxMKQEjHFtRouaJycyOKu6JEN2uPn9z24PwDk3RKEhj4jz/n3ocQh4t82qAg6070dTsbpJadVEODSziWUoecPMfdFIECiAQQgIzN0Rwpesc3OnOYZQ+f4sn9nwqo2N3X8atM2P9ATs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714421279; c=relaxed/simple;
	bh=Mc6/aUkUdQsTMM+C8LvP2gEfmDhy7VB9RXbIg5Hojuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A+w+VlMu9e+G31xQlPr660C0DYebrc659YNWZ8BR8LECdVaq4J5Si8MEXrvUA9mRb2m/LeRGDX72KU6NSmPfZZHfOl9ZJtPoDXOoDS+/Z9/iuFK2Ov+dgaz9tJyptNqehO6FFM9ie85BeWGXRqNv9DezdJXB2KLoP4irshiQzTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpHOpVqW; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f074520c8cso4810560b3a.0
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 13:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714421277; x=1715026077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQ0l2lFXCO/Uz4lW/ZH9d+mKU1y1y2R/0YzR5i1m/RE=;
        b=OpHOpVqWPQsrpuTzi3kOpLtq1xbq3LR4HRUryTewb9UE/8A2eCG0maBU/17KvezOwE
         4viQw4aJOK7un2RRxcdy+h8MDGfdEu4LXGV0WqPtIS9cNS+/s8DONKZP1esWZhxwMi7e
         Mr7SqTVMdkpzCo1moN5864mwAJQZ89h7CsEQbxSd/8PQ0hr+JHrnihCrIYEMUMWQ86y/
         3YoogehA5LkaR2W6yEQeGxrS5KzncAqAU5FPke1S4b44WZe9OdU+xuZ/Egrj6e50UpnL
         Xghm/6S4Ox5K1I2OEALa7qzplkf9X8omu/AadYx8qRIp4XVaMwEBMomkkebnSALehTwT
         UYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714421277; x=1715026077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQ0l2lFXCO/Uz4lW/ZH9d+mKU1y1y2R/0YzR5i1m/RE=;
        b=gzZ2iboSLkkO0j4te5hsEmYAM+xhqvnpuP5siRFaVSB4HuPgUfdtf3+t/erpshdLX5
         pv2RZT80/3m1w8HjKg7WlUira7q+zcmvssuqn7ESDtNTxi2ACwZLhxCseMtlrQ1qkVFo
         Cp0K0bpXpsBfW9aPriow3neOdlIdJ9pc+ns3RnryKn36q0sljv199xPasrLmpTm5YbPd
         Rm89PbjAh/JFoCX4uGZcpQ4meVd6CDWdyR5eztx+JhJCoLVK2SNCbCcHJCQlrh1a9E5C
         jt4L5GNx5p1Ky00wb6nqtX8Bp3PkyXif0Md+95ClLGRQLm/mGdC5zSQMftMZ1ngS/2e9
         GdEQ==
X-Gm-Message-State: AOJu0YzKUG9gqn4fDA5sH5GoR7vSVJTpyIjlFJeDAktG+a8SPS85KfYk
	9qOsyBAucZLHH33BJgZZbUXEoGL7kZYS66+3RuCU4vFdVbVNyhSmZOH98CFgsNljysD9udr53y0
	PKTHdXipWaqtSsUch/r4Hq86r6XJDmg==
X-Google-Smtp-Source: AGHT+IHhz74lz873KuUp01rUnPjsihlsotpBg9lEBmW2MDJEl23AHuBMMPn9oHNC1SY60Yg+kmWviDaG4K2bbkz/vck=
X-Received: by 2002:a05:6a20:101a:b0:1ad:802f:9349 with SMTP id
 gs26-20020a056a20101a00b001ad802f9349mr11367859pzc.25.1714421277337; Mon, 29
 Apr 2024 13:07:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714133551.git.vmalik@redhat.com> <CAEf4BzZ8ckB0f7g86XCYxsMgLZFRQ_3eYswZzZNokbrC8Z=qHQ@mail.gmail.com>
 <51af75df-6909-451e-9d83-8c1bbfb3deba@redhat.com>
In-Reply-To: <51af75df-6909-451e-9d83-8c1bbfb3deba@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Apr 2024 13:07:45 -0700
Message-ID: <CAEf4BzYZOxvygvX6Qt9+QaxgAgUC3Af4gJmR-pXsf3tNte2FQw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] libbpf: support "module:function" syntax for
 tracing programs
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 5:32=E2=80=AFAM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
> On 4/26/24 18:54, Andrii Nakryiko wrote:
> > On Fri, Apr 26, 2024 at 5:17=E2=80=AFAM Viktor Malik <vmalik@redhat.com=
> wrote:
> >>
> >> In some situations, it is useful to explicitly specify a kernel module
> >> to search for a tracing program target (e.g. when a function of the sa=
me
> >> name exists in multiple modules or in vmlinux).
> >>
> >> This change enables that by allowing the "module:function" syntax for
> >> the find_kernel_btf_id function. Thanks to this, the syntax can be use=
d
> >> both from a SEC macro (i.e. `SEC(fentry/module:function)`) and via the
> >> bpf_program__set_attach_target API call.
> >>
> >
> > how about function[module] syntax. This follows how modules are
> > reported in kallsyms and a bunch of other kernel-generated files. I've
> > been using this syntax in retsnoop for a while, and it feels very
> > natural. It's also distinctive enough to be recognizable and parseable
> > without any possible confusions.
> >
> > Can you please also check if we can/should support this for kprobes as =
well?
>
> For kprobes, it's a bit more complicated. The legacy kprobe attachment
> (via tracefs) supports the "module:function" syntax [1] (which is the
> reason I chose that syntax in the first place). On the other hand,
> kprobe attachment via the perf_event_open syscall eventually calls
> kallsyms_lookup_name for the passed function name which doesn't support
> specifying the module at all.
>
> So, to properly support this for kprobes, we'd have to extend
> kallsyms_lookup_name to handle the "function[module]" or
> "module:function" syntax (here, the former makes more sense).
>
> Since kallsyms_lookup_name is used in many places, I would prefer adding
> the kprobe support separately. In any case, the "function[module]"
> syntax feels more natural for non-legacy kprobes, so I'm ok with using
> it. libbpf will just have to do the transformation to "module:function"
> for legacy kprobe attachment.
>
> Let me know if that makes sense and I'll post v2.

Thinking some more, I think we should stick to "<module>:<function>"
for a) simplicity (it's slightly easier to parse) and b) consistency
with uprobe, where we have "<path>:<function>", where path is pointing
to ELF binary. Let me take a look at patches again.

But yes, I think it would be useful to add support to
kprobes/multi-kprobes as well for completeness, but it of course would
be a separate work thread.

>
> Thanks!
> Viktor
>
> [1] https://www.kernel.org/doc/Documentation/trace/kprobetrace.rst
>
> >
> >> Viktor Malik (2):
> >>   libbpf: support "module:function" syntax for tracing programs
> >>   selftests/bpf: add tests for the "module:function" syntax
> >>
> >>  tools/lib/bpf/libbpf.c                        | 33 ++++++++++++++----=
-
> >>  .../selftests/bpf/prog_tests/module_attach.c  |  6 ++++
> >>  .../selftests/bpf/progs/test_module_attach.c  | 23 +++++++++++++
> >>  3 files changed, 53 insertions(+), 9 deletions(-)
> >>
> >> --
> >> 2.44.0
> >>
> >
>

