Return-Path: <bpf+bounces-55671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BC4A84B16
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 19:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B69E9A0403
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 17:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6999E1EEA28;
	Thu, 10 Apr 2025 17:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h/3OWjoy"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D481DFE0B
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 17:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306494; cv=none; b=Y3z4rhgBSnXiFELUSRjy83Tsuee7J5Cdp/NBuzwybW4Pw9AP4L4+xg2/+qmUAsf2nFkIjQvHFHShkPMOmh+wqmHouCrot2gtUkzWolRXye68lWk2YDAqMS8HZb1hZ3utDeS1v3R+MBRsFHmPllD+kwpRxZ786z1x8Fkmmeozs5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306494; c=relaxed/simple;
	bh=jNIkt5ayBZRSMl8NvXTMS6z1kii1iRKi2/voWspzj0Q=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=i+zLeszQS8QPRBHPsa5ptgPs8LDf55arBe3OC5ZtKysFZ7sdI3eVhmzftj7F1JEPCspHHdYrzH46gjlFxL6At+7Z0LqfLBWgpc+C/5D7VCFusv9ZVZhuEXdE2GNvv7kXXMKYl8/piSSBq/YnfON5Z6BuATrZcVBT58o9eo3wEDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h/3OWjoy; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744306490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gaZqOUM0wQ79bS2KW0/pWTztnvHGgxN8nCNp5V93epg=;
	b=h/3OWjoyC80XSVt3YAyYHDoPui+2YEeaTC+Y/JYb1yMUsTxgYKss48vXG8T+BB/srVIbT+
	oevzO8HlnVCfcrrkTjXs1KKWoQjWjr6iuNWciN+k8ZS/JzGCy0b8DAEU0r7LRncYRhnv/2
	5VDq4kzGHXGMtyJstt0Y+NiA0LvPXdw=
Date: Thu, 10 Apr 2025 17:34:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <9cc4191bf68d1943c49b68d8fefe89db8a114d2f@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] libbpf: check for empty BTF data section in
 btf_parse_elf
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, bpf@vger.kernel.org, mykolal@fb.com,
 kernel-team@meta.com
In-Reply-To: <CAEf4BzYwLHDMgWW8m2_exZvGmU7otODRueJx3CvbUPoMGEPNuA@mail.gmail.com>
References: <20250408184104.3962949-1-ihor.solodrai@linux.dev>
 <CAEf4BzYwLHDMgWW8m2_exZvGmU7otODRueJx3CvbUPoMGEPNuA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On 4/9/25 4:14 PM, Andrii Nakryiko wrote:
> On Tue, Apr 8, 2025 at 11:41=E2=80=AFAM Ihor Solodrai <ihor.solodrai@li=
nux.dev> wrote:
>>
>> A valid ELF file may contain a SHT_NOBITS .BTF section. This case is
>> not handled correctly in btf_parse_elf, which leads to a segfault.
>>
>> Add a null check for a buffer returned by elf_getdata() before
>> proceeding with its processing.
>>
>> Bug report: https://github.com/libbpf/libbpf/issues/894
>>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
>>  tools/lib/bpf/btf.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>> index 38bc6b14b066..90599f0311bd 100644
>> --- a/tools/lib/bpf/btf.c
>> +++ b/tools/lib/bpf/btf.c
>> @@ -1201,6 +1201,12 @@ static struct btf *btf_parse_elf(const char *pa=
th, struct btf *base_btf,
>>                 goto done;
>>         }
>>
>> +       if (!secs.btf_data->d_buf) {
>> +               pr_warn("BTF data is empty in %s\n", path);
>> +               err =3D -ENODATA;
>> +               goto done;
>> +       }
>> +
>
> let's handle this more generally for all BTF data sections in
> btf_find_elf_sections()?

Sure. I think it makes sense to check for the section type before
attempting to load a buffer like this:

@@ -1148,6 +1148,12 @@ static int btf_find_elf_sections(Elf *elf, const c=
har *path, struct btf_elf_secs
                else
                        continue;
=20
+=20              if (sh.sh_type =3D=3D SHT_NOBITS) {
+                       pr_warn("failed to get section(%d, %s) data from =
%s\n",
+                               idx, name, path);
+                       goto err;
+               }
+

But then we might as well test for the expected section type, which is
supposed to be SHT_PROGBITS, if I understand correctly.

What I don't know is whether this is *the only* possible expected type
(for ".BTF", ".BTF.ext" and ".BTF.base"), or are there others?

Andrii, do you know if that's the case?

>
> let's also use similar style of warning messaging to others, maybe
> something like
>
> "failed to get section(%s, %d) data from %s\n" ?
>
>
> pw-bot: cr
>
>>         if (secs.btf_base_data) {
>>                 dist_base_btf =3D btf_new(secs.btf_base_data->d_buf, s=
ecs.btf_base_data->d_size,
>>                                         NULL);
>> --
>> 2.49.0
>>
>>

