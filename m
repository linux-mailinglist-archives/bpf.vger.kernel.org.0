Return-Path: <bpf+bounces-50699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E04A2B4BF
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 23:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85399168134
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 22:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C8723909B;
	Thu,  6 Feb 2025 22:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVcxLZXe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0406C239094
	for <bpf@vger.kernel.org>; Thu,  6 Feb 2025 22:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738879501; cv=none; b=di3cj8arkmsqPNt3dJBSPrXmj9QyNLCp7gl7cZiy44Z4pY/LgF8CPIRNCpPgmguRsh+WbkY9A+fOPqfWiLhWpYfoJaTgtq5c/wbe4brw0CE4DgQERy8233lERXUAIbbUBbx6AHIg8/lreKWznej/QxdyuythozJqTA8DsJKSYaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738879501; c=relaxed/simple;
	bh=uHt1jwmQaIOQ0fKqsUoMrcW5H1CPV6TLU0w0/FTxyEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LfHgU7mKTm5UzvF33AgaOC5EsEDgtf0xL/n0zgFxETe73/aTm6FGWHZA9s5Jbsc2W8sdSLsuuyA1ITi4rB97j5WfxK0T1qkNiH8ZF35VevL4HY9vi4Q61d7Pdq8mazKD3x2f1tMrEszVACJ7dkQJ3onoPB8LlYWf0qNj4a2H3bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVcxLZXe; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2f833af7a09so2030615a91.2
        for <bpf@vger.kernel.org>; Thu, 06 Feb 2025 14:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738879499; x=1739484299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKlJV8GxBx4hXYC70UR3aFPMbCGgLeWjf9fzFEimSps=;
        b=cVcxLZXevdjnsFQN4AF03LrK8XLzwhtfit4pb3syhEvHIfWWM8NcV8qjNIqn2gnkZ+
         INy5PsbbK+MhNRYJuAhoZuf8BCI90A28f49jaW0iMGXDpvXAbYjL1nd8TmV9zlewW4Tj
         wBTeExixC8KjkvF1ESHK6KywaIdHb3hWlgU9Fj6bAaQFohRO3V1gEvc8A+gphO4pe9Ra
         W3KjrqR9wxK0gqkir1MyImi2tFqTAsewsv9HLb0ow+G3jdi7zXnR1gUqVx4RSwEdRuoC
         HrFf9zYbfwnt2id4KrXl2kZEHhUfKT92kKKSCqbB0jjKHEdZNh4y+CsGSOwgJYZ9/wyu
         Lg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738879499; x=1739484299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKlJV8GxBx4hXYC70UR3aFPMbCGgLeWjf9fzFEimSps=;
        b=RvuchtfSu4VPUvYWep7PGV1iY9PqCBosF+LitCqm30ap87Gq6MmxIXx18bV0u0UuqN
         yiTfOYcKvDHUqwOK5fkT2pzx/mcCEpP9NU1pvujdEEra4B3oG9U0mhLlBlAb5LVNAzwJ
         N5/VLWZFmVhXoH6t6ZSY9lOROIsAceMQC89rK88ev4vvQtSUEq/4gd9RsR8kCkJzbXeq
         n+C9qIGxOhiW6zvZeR/0TamfTPqjEEn/+YgqtXVZ298N6DuHwpC3lVo8qLw5rOw7h6c1
         0VV2oqX7J89+lCfo4AtuS1fXn0ES7scPMtVR7UuItyeNICtFyAwdSjG6IiCgva3jLZvf
         Dx0A==
X-Gm-Message-State: AOJu0YweQ4EskwtKpsGyndtQ6nHv9Y9qAr32Y6+n605N4uMM3K5CaYLr
	XKdkNqmZsiUsQcScyvripnrAT2CKYMKrkN53pGnDNIvOHgzTUBhEN742Bp+uzV0tKVrN26N+dE6
	mFqGZM+8AfyaHqh1cBscw3t/IUxw=
X-Gm-Gg: ASbGncsqQpn2oEoq3/1tzKfByN/JeKN/mMrt7H4kzTfvkImYTeTNJ6CuBR8jes2lQmi
	Ms0M5fCrKDomlrS/cVyAoZuZuUWMVXlnoQnh8a9ZKcUlaiOmIUZTrD424F3HWruwV8HxZL+Prgb
	/nmMG799PS5baw
X-Google-Smtp-Source: AGHT+IGlBbKbj3Lcj2Sf70KDvMKXQ2AXDlLpVfMBeFwp0kWuJmQ8wK+hfnBGKM8OTn3MaclwDRHt434mtc8zCfqgBD0=
X-Received: by 2002:a17:90b:4c02:b0:2ee:a4f2:b311 with SMTP id
 98e67ed59e1d1-2fa2406471emr1073873a91.8.1738879498843; Thu, 06 Feb 2025
 14:04:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205190918.2288389-1-bboscaccy@linux.microsoft.com>
 <20250205190918.2288389-2-bboscaccy@linux.microsoft.com> <CAEf4BzZQUPfA8UcW1Ed9jM0J8z+yGHe=kOM5BwEBuDzJL3B1HA@mail.gmail.com>
 <874j169b33.fsf@microsoft.com>
In-Reply-To: <874j169b33.fsf@microsoft.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Feb 2025 14:04:45 -0800
X-Gm-Features: AWEUYZl0RLkcmgNp2ppfhI_YVrOVVw9iGuNQzHhsyvGRmXInwhxymBeCgRkr9mk
Message-ID: <CAEf4Bzb-RfRU=a3U4XPDpQEFoKnT=NYD_C=k42vw1nyh1xJE0g@mail.gmail.com>
Subject: Re: [PATCH 1/1] libbpf: Convert ELF notes into read-only maps
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org, nkapron@google.com, teknoraver@meta.com, 
	roberto.sassu@huawei.com, paul@paul-moore.com, code@tyhicks.com, 
	xiyou.wangcong@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 10:34=E2=80=AFAM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Wed, Feb 5, 2025 at 11:09=E2=80=AFAM Blaise Boscaccy
> > <bboscaccy@linux.microsoft.com> wrote:
> >>
> >> Add a flexible mechanism, using existing ELF constructs, to attach
> >> additional metadata to BPF programs for possible use by BPF
> >> gatekeepers and skeletons.
> >>
> >> During object file parsing, note sections are no longer skipped and
> >> now treated as read-only data. During libbpf-based loading or skeleton
> >> generation, those sections are then transformed into read-only maps
> >> which are subsequently passed into the kernel.
> >
> > We already have this mechanism, it's .rodata (and
> > .rodata.<customname>) section(s). Adding .note sections as BPF maps
> > make no sense to me. Just piggy-back on .rodata for storing any
> > necessary metadata.
> >
> > pw-bot: cr
> >
>
> The ELF specification clearly states:
> "Sometimes a vendor or system builder needs to mark an object file with
> special information that other programs will check for conformance,
> compatibility, etc. Sections of type SHT_NOTE and program header
> elements of type PT_NOTE can be used for this purpose."

Does ELF specification say anything about "and libbpf should create a
BPF map for those SHT_NOTE sections"?

>
> Which is exactly what we are trying to do. They make no mention of
> piggy-backing off of .rodata.

You are trying to redefine non-loadable SHT_NOTE data into loadable
data backed by a BPF map. I'm not sure how your arguments are
supporting the hack you are trying to do. We are not going to start
creating new BPF maps for any random SHT_NOTE section in the BPF
object file. Use .rodata if you want to get some read-only data into
the kernel.

>
> Further, one can generally strip away .note sections and be left with an
> object that's still functioning. The same cannot be said about .rodata.
>
>
>
> >>
> >> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> >> ---
> >>  tools/bpf/bpftool/gen.c | 4 ++--
> >>  tools/lib/bpf/libbpf.c  | 6 ++++++
> >>  2 files changed, 8 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> >> index 5a4d3240689ed..311d6a3f1c4bb 100644
> >> --- a/tools/bpf/bpftool/gen.c
> >> +++ b/tools/bpf/bpftool/gen.c
> >> @@ -92,7 +92,7 @@ static void get_header_guard(char *guard, const char=
 *obj_name, const char *suff
> >>
> >>  static bool get_map_ident(const struct bpf_map *map, char *buf, size_=
t buf_sz)
> >>  {
> >> -       static const char *sfxs[] =3D { ".data", ".rodata", ".bss", ".=
kconfig" };
> >> +       static const char *sfxs[] =3D { ".data", ".rodata", ".bss", ".=
kconfig", ".note" };
> >>         const char *name =3D bpf_map__name(map);
> >>         int i, n;
> >>
> >> @@ -117,7 +117,7 @@ static bool get_map_ident(const struct bpf_map *ma=
p, char *buf, size_t buf_sz)
> >>
> >>  static bool get_datasec_ident(const char *sec_name, char *buf, size_t=
 buf_sz)
> >>  {
> >> -       static const char *pfxs[] =3D { ".data", ".rodata", ".bss", ".=
kconfig" };
> >> +       static const char *pfxs[] =3D { ".data", ".rodata", ".bss", ".=
kconfig", ".note" };
> >>         int i, n;
> >>
> >>         /* recognize hard coded LLVM section name */
> >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >> index 194809da51725..be6af0fece040 100644
> >> --- a/tools/lib/bpf/libbpf.c
> >> +++ b/tools/lib/bpf/libbpf.c
> >> @@ -523,6 +523,7 @@ struct bpf_struct_ops {
> >>  #define STRUCT_OPS_SEC ".struct_ops"
> >>  #define STRUCT_OPS_LINK_SEC ".struct_ops.link"
> >>  #define ARENA_SEC ".addr_space.1"
> >> +#define NOTE_SEC ".note"
> >>
> >>  enum libbpf_map_type {
> >>         LIBBPF_MAP_UNSPEC,
> >> @@ -3977,6 +3978,11 @@ static int bpf_object__elf_collect(struct bpf_o=
bject *obj)
> >>                         sec_desc->sec_type =3D SEC_BSS;
> >>                         sec_desc->shdr =3D sh;
> >>                         sec_desc->data =3D data;
> >> +               } else if (sh->sh_type =3D=3D SHT_NOTE && (strcmp(name=
, NOTE_SEC) =3D=3D 0 ||
> >> +                                                      str_has_pfx(nam=
e, NOTE_SEC "."))) {
> >> +                       sec_desc->sec_type =3D SEC_RODATA;
> >> +                       sec_desc->shdr =3D sh;
> >> +                       sec_desc->data =3D data;
> >>                 } else {
> >>                         pr_info("elf: skipping section(%d) %s (size %z=
u)\n", idx, name,
> >>                                 (size_t)sh->sh_size);
> >> --
> >> 2.48.1
> >>

