Return-Path: <bpf+bounces-46181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E279E6048
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 22:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0E2F169E30
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 21:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3641CD1E1;
	Thu,  5 Dec 2024 21:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuGGf8+N"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546D919DF66
	for <bpf@vger.kernel.org>; Thu,  5 Dec 2024 21:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733435824; cv=none; b=ofzSErglAkjxPVQOOZxGdJTv0Hs1A6fJYsOdqWTTfP9JcrAG1RYDWO5cVVoU3RRcAnWqBJuxBpsl85z/tjmRV3fQKBUs5SsZbII2f1rEtfw+aCZGRsU/sfcnLOzPero5geLrcFdWtmT7z4hPJPafdGBO8N2gNYb1TiTm71RiyHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733435824; c=relaxed/simple;
	bh=UC3f3Uo2McWA/Cs0E9DJEtAM557ORigkXu8tbmZSV9A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tu2bjW1jGOiPrCR8wFzmX0lYfBM5x7FiloRJxsHsuHplRzD+neV+FKlfvQhNatNNgp18hjk7rRfmTus9KIUhu6lH491+hQXcXegL+6JmLlvIscquZSjKmDGBDvZrgptGpyLYaLhG+2Gtl/US6m2r5CXBJxwf0zHiI7YKMsTjcvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuGGf8+N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED67C4CED1;
	Thu,  5 Dec 2024 21:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733435823;
	bh=UC3f3Uo2McWA/Cs0E9DJEtAM557ORigkXu8tbmZSV9A=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=fuGGf8+NBzZkB1vyN2gLIsffNEGN3OfmTPpYVZ+B69LHbbteJExCgbjaCJSg4a1Ci
	 yQMDvA+2L826pHIJPPlld3n2lM3BHd6CgzY8OoXWfn84HP+ai8meQS0evgHYrJ5Oqo
	 D04mUwxBR6EOoQZUiR99Jtfcx1fJSLZ4SiaawQV64hwZGk0BnVNb8hcO6HlsPlaHNS
	 kGWdrvglq07U1q5025W/1lbRgWV8JbO46y6cvwDiiaKTqkZnGri6bV6KUw7Dg5TQ9i
	 eXEWk7xhBZ8ThiKtm7zkcucUeBZolTBKbVh7hm2O06M+cdTTxgIekY0f5UXIxNSq2i
	 zHu7QYPIUsyzQ==
Message-ID: <e82fc551-752d-4596-9ab4-135a3720ecbd@kernel.org>
Date: Thu, 5 Dec 2024 21:56:58 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH bpf-next] libbpf: Fix segfault due to libelf functions not
 setting errno
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 Rong Tao <rtoax@foxmail.com>
References: <20241205135942.65262-1-qmo@kernel.org>
 <CAEf4BzazrH+QrzJP+honiLWACSheQVuJpj7asdKFvx-rcQB+1w@mail.gmail.com>
Content-Language: en-GB
In-Reply-To: <CAEf4BzazrH+QrzJP+honiLWACSheQVuJpj7asdKFvx-rcQB+1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2024-12-05 13:46 UTC-0800 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> On Thu, Dec 5, 2024 at 5:59 AM Quentin Monnet <qmo@kernel.org> wrote:
>>
>> Libelf functions do not set errno on failure. Instead, it relies on its
>> internal _elf_errno value, that can be retrieved via elf_errno (or the
>> corresponding message via elf_errmsg()). From "man libelf":
>>
>>     If a libelf function encounters an error it will set an internal
>>     error code that can be retrieved with elf_errno. Each thread
>>     maintains its own separate error code. The meaning of each error
>>     code can be determined with elf_errmsg, which returns a string
>>     describing the error.
>>
>> As a consequence, libbpf should not return -errno when a function from
>> libelf fails, because an empty value will not be interpreted as an error
>> and won't prevent the program to stop. This is visible in
>> bpf_linker__add_file(), for example, where we call a succession of
>> functions that rely on libelf:
>>
>>     err = err ?: linker_load_obj_file(linker, filename, opts, &obj);
>>     err = err ?: linker_append_sec_data(linker, &obj);
>>     err = err ?: linker_append_elf_syms(linker, &obj);
>>     err = err ?: linker_append_elf_relos(linker, &obj);
>>     err = err ?: linker_append_btf(linker, &obj);
>>     err = err ?: linker_append_btf_ext(linker, &obj);
>>
>> If the object file that we try to process is not, in fact, a correct
>> object file, linker_load_obj_file() may fail with errno not being set,
>> and return 0. In this case we attempt to run linker_append_elf_sysms()
>> and may segfault.
>>
>> This can happen (and was discovered) with bpftool:
>>
>>     $ bpftool gen object output.o sample_ret0.bpf.c
>>     libbpf: failed to get ELF header for sample_ret0.bpf.c: invalid `Elf' handle
>>     zsh: segmentation fault (core dumped)  bpftool gen object output.o sample_ret0.bpf.c
>>
>> Fix the issue by returning a non-null error code (-EINVAL) when libelf
>> functions fail.
>>
>> Fixes: faf6ed321cf6 ("libbpf: Add BPF static linker APIs")
>> Signed-off-by: Quentin Monnet <qmo@kernel.org>
>> ---
>>  tools/lib/bpf/linker.c | 22 ++++++++--------------
>>  1 file changed, 8 insertions(+), 14 deletions(-)
>>
> 
> Ok, so *this* is the real issue with SIGSEGV that we were trying to
> "prevent" by file path comparison in that bpftool-specific patch,
> right? LGTM, I'll apply to bpf-next.


Correct, I wanted to find where that segfault was coming from, too :).
Thanks!

