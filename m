Return-Path: <bpf+bounces-50685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B783CA2B14E
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 19:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F62716A5BA
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 18:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8D91B4132;
	Thu,  6 Feb 2025 18:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SaYVx7D3"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4390419DF81
	for <bpf@vger.kernel.org>; Thu,  6 Feb 2025 18:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738866865; cv=none; b=Mb3QoCBP/XTNxDfuNlHL5bQ9z+q0N2yOHOK1rRUfB4SeFGqK4Va8FR/mhVMl87Tk84mTQWvN9cSfXkcm7xPhUUonpul3Qzew+6TpH2IcJiDMu87buSR1apKLDrzYxogURUF7tsF/PVrb8v6lfvZ7/Al74tqYOYGNhiDCRdebXns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738866865; c=relaxed/simple;
	bh=iM0xBAJhCz6UKAI7YzjkWnlZ1RI2ZxtfcpOc6dHRnqU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bpcLJF6eRJ3ENrxNiBcZCNn6oLx9NkVrSp238hJPG/YFRMogbkh+yY6HWaLFGnPVpZLTh82V7FT3kBQSedgk9XGd62HAvELqlabYMBHbl8spfmaXFctGZNAEjVEN5eHXQ249v8YMDmJM39hKnQoD541/hZK6C8ekNiOOzrI23JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SaYVx7D3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id 706B3203F5B1;
	Thu,  6 Feb 2025 10:34:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 706B3203F5B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738866858;
	bh=GIyXv8Vo7C+qC0PTqBIMmgrMyMdpCItKw4oghu9xrtI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SaYVx7D36ucSGU57kV4Kp34J5KM8Ep9BR5PnTEZfro+jqVjFVWqyCmaPJLr0qkjka
	 MUZicsDvX+CKr9y1mlpcJOWhHgT+QgBTu4U2uYgZHxJA0jLwhKzMZvls2gegl3ZJXt
	 pnSaQhKWe0rwGtqD7CJk/BNNK6ssqAbOtPKEodig=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, nkapron@google.com, teknoraver@meta.com,
 roberto.sassu@huawei.com, paul@paul-moore.com, code@tyhicks.com,
 xiyou.wangcong@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Subject: Re: [PATCH 1/1] libbpf: Convert ELF notes into read-only maps
In-Reply-To: <CAEf4BzZQUPfA8UcW1Ed9jM0J8z+yGHe=kOM5BwEBuDzJL3B1HA@mail.gmail.com>
References: <20250205190918.2288389-1-bboscaccy@linux.microsoft.com>
 <20250205190918.2288389-2-bboscaccy@linux.microsoft.com>
 <CAEf4BzZQUPfA8UcW1Ed9jM0J8z+yGHe=kOM5BwEBuDzJL3B1HA@mail.gmail.com>
Date: Thu, 06 Feb 2025 10:34:08 -0800
Message-ID: <874j169b33.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Wed, Feb 5, 2025 at 11:09=E2=80=AFAM Blaise Boscaccy
> <bboscaccy@linux.microsoft.com> wrote:
>>
>> Add a flexible mechanism, using existing ELF constructs, to attach
>> additional metadata to BPF programs for possible use by BPF
>> gatekeepers and skeletons.
>>
>> During object file parsing, note sections are no longer skipped and
>> now treated as read-only data. During libbpf-based loading or skeleton
>> generation, those sections are then transformed into read-only maps
>> which are subsequently passed into the kernel.
>
> We already have this mechanism, it's .rodata (and
> .rodata.<customname>) section(s). Adding .note sections as BPF maps
> make no sense to me. Just piggy-back on .rodata for storing any
> necessary metadata.
>
> pw-bot: cr
>

The ELF specification clearly states:
"Sometimes a vendor or system builder needs to mark an object file with
special information that other programs will check for conformance,
compatibility, etc. Sections of type SHT_NOTE and program header
elements of type PT_NOTE can be used for this purpose."

Which is exactly what we are trying to do. They make no mention of
piggy-backing off of .rodata.

Further, one can generally strip away .note sections and be left with an
object that's still functioning. The same cannot be said about .rodata.=20



>>
>> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
>> ---
>>  tools/bpf/bpftool/gen.c | 4 ++--
>>  tools/lib/bpf/libbpf.c  | 6 ++++++
>>  2 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
>> index 5a4d3240689ed..311d6a3f1c4bb 100644
>> --- a/tools/bpf/bpftool/gen.c
>> +++ b/tools/bpf/bpftool/gen.c
>> @@ -92,7 +92,7 @@ static void get_header_guard(char *guard, const char *=
obj_name, const char *suff
>>
>>  static bool get_map_ident(const struct bpf_map *map, char *buf, size_t =
buf_sz)
>>  {
>> -       static const char *sfxs[] =3D { ".data", ".rodata", ".bss", ".kc=
onfig" };
>> +       static const char *sfxs[] =3D { ".data", ".rodata", ".bss", ".kc=
onfig", ".note" };
>>         const char *name =3D bpf_map__name(map);
>>         int i, n;
>>
>> @@ -117,7 +117,7 @@ static bool get_map_ident(const struct bpf_map *map,=
 char *buf, size_t buf_sz)
>>
>>  static bool get_datasec_ident(const char *sec_name, char *buf, size_t b=
uf_sz)
>>  {
>> -       static const char *pfxs[] =3D { ".data", ".rodata", ".bss", ".kc=
onfig" };
>> +       static const char *pfxs[] =3D { ".data", ".rodata", ".bss", ".kc=
onfig", ".note" };
>>         int i, n;
>>
>>         /* recognize hard coded LLVM section name */
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 194809da51725..be6af0fece040 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -523,6 +523,7 @@ struct bpf_struct_ops {
>>  #define STRUCT_OPS_SEC ".struct_ops"
>>  #define STRUCT_OPS_LINK_SEC ".struct_ops.link"
>>  #define ARENA_SEC ".addr_space.1"
>> +#define NOTE_SEC ".note"
>>
>>  enum libbpf_map_type {
>>         LIBBPF_MAP_UNSPEC,
>> @@ -3977,6 +3978,11 @@ static int bpf_object__elf_collect(struct bpf_obj=
ect *obj)
>>                         sec_desc->sec_type =3D SEC_BSS;
>>                         sec_desc->shdr =3D sh;
>>                         sec_desc->data =3D data;
>> +               } else if (sh->sh_type =3D=3D SHT_NOTE && (strcmp(name, =
NOTE_SEC) =3D=3D 0 ||
>> +                                                      str_has_pfx(name,=
 NOTE_SEC "."))) {
>> +                       sec_desc->sec_type =3D SEC_RODATA;
>> +                       sec_desc->shdr =3D sh;
>> +                       sec_desc->data =3D data;
>>                 } else {
>>                         pr_info("elf: skipping section(%d) %s (size %zu)=
\n", idx, name,
>>                                 (size_t)sh->sh_size);
>> --
>> 2.48.1
>>

