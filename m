Return-Path: <bpf+bounces-55537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA74A82B2F
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 17:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2551C1B630F9
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 15:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5767E26A1B5;
	Wed,  9 Apr 2025 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pgZ7u04J"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43C526A0FA
	for <bpf@vger.kernel.org>; Wed,  9 Apr 2025 15:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213488; cv=none; b=C1b54Z7ZUVSfYIXteqHumyfQRfTq5Dgo8CarNMbAZE5kDROeI+zjpUDwDlzAFnZAOVahVJ53ELRyZTH8G4c5e0zRv6VuI1KtNMPd1nNCVSg0oSApJXMheJELheaFk+Z6W7PfNSeF0NncXqssxmZSSBtXS78nQMfgsNqKBH/l6YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213488; c=relaxed/simple;
	bh=bzdijGcuCHqKm6progKmT8FYiOLkpOLepPiXdeJzZ6A=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=gXme2jaEN3J+EXuir+zGgjElnBMzIe1j66rq5N5d5X87X4xuYmHIMa16KxgRoIBNHWkOw//c8sSmqjUm3qM7lgn16uy0nX6ATCObljCMHwBBcfMlzg9HV3lUsJRh4Gn+bCdP3Lp4f0L69Oldi6I6vz5kcpULEsVatVc/rfiEqT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pgZ7u04J; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744213483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wkGQqjNs/Y0+ITw4ey08U9vBPsaFsGADG4YWHzmPsD0=;
	b=pgZ7u04J57qQ2e7aM8zGsBdzah47PC2LjaPO0IdBsOf1pOBK0bNQM0axoKdGVxXemiYDQe
	ikfyRC0hzMPNeDXLfJkWXIjRDrbZ/77uDb7mMVj7n69o0Kc/rEst0ydtB8mrzSHQ9xoopW
	NiVQFG58NbUksT5hnBO5pUtk9jOfNGY=
Date: Wed, 09 Apr 2025 15:44:41 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <93d7f092eedbd7ec5618d0eb399528979013f1b0@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] libbpf: check for empty BTF data section in
 btf_parse_elf
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, andrii@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com
Cc: bpf@vger.kernel.org, mykolal@fb.com, kernel-team@meta.com
In-Reply-To: <743d6d28-b3b3-4e55-b9e7-3655bd25ad70@gmail.com>
References: <20250408184104.3962949-1-ihor.solodrai@linux.dev>
 <743d6d28-b3b3-4e55-b9e7-3655bd25ad70@gmail.com>
X-Migadu-Flow: FLOW_OUT

On 4/9/25 5:09 AM, Mykyta Yatsenko wrote:
> On 08/04/2025 19:41, Ihor Solodrai wrote:
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
>>   tools/lib/bpf/btf.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>> index 38bc6b14b066..90599f0311bd 100644
>> --- a/tools/lib/bpf/btf.c
>> +++ b/tools/lib/bpf/btf.c
>> @@ -1201,6 +1201,12 @@ static struct btf *btf_parse_elf(const char *pa=
th, struct btf *base_btf,
>>           goto done;
>>       }
>>   +    if (!secs.btf_data->d_buf) {
>> +        pr_warn("BTF data is empty in %s\n", path);
>> +        err =3D -ENODATA;
>> +        goto done;
>> +    }
>> +
>>       if (secs.btf_base_data) {
>>           dist_base_btf =3D btf_new(secs.btf_base_data->d_buf, secs.bt=
f_base_data->d_size,
>>                       NULL);=20
>
>=20is `secs.btf_data->d_size` non-zero in this case, making it access `s=
ecs.btf_data->d_buf`?

Yes, as it turns out.

This is also described in the spec in relation to Elf32_Shdr [1]:

    sh_size This member gives the section's size in bytes. Unless the sec=
tion type is
    SHT_NOBITS, the section occupies sh_size bytes in the file. A section
    of type SHT_NOBITS may have a non-zero size, but it occupies no space
    in the file.

[1] https://refspecs.linuxfoundation.org/elf/elf.pdf

>
> Acked-by: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>

