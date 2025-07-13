Return-Path: <bpf+bounces-63129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9701EB02EE1
	for <lists+bpf@lfdr.de>; Sun, 13 Jul 2025 08:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BE6F167491
	for <lists+bpf@lfdr.de>; Sun, 13 Jul 2025 06:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2B81A256E;
	Sun, 13 Jul 2025 06:23:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B5014F121;
	Sun, 13 Jul 2025 06:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752387839; cv=none; b=g67MAGVsUzLEuMd1nMj96UdRaS8oDQaE9U8BoSQVcRuogqVKQ5aiQj8YfDwb6lTrpNByTbANdOMf+Vx52TskkFjrWd1eGDPiJgQAQNw1X3XMuI80qmlSxUUmiy6wSDppwsd8SghKlEcfVgZ+//kSR21tvd4Z27+waSUb94g3mVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752387839; c=relaxed/simple;
	bh=7MudDRbo9i344nsnDtXu0dJhIjRH8jZnjETrAUwa6xY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CmZ0HzSDZd+SojfcNiaeSsZN/8NK3o4S83naPZguoeouRdhZwDbGDefsyFjZVplMX8DUZl1KfDJI1iqFPm5ECH62j7cHTAv3PmQgmghU1mFZFsAsebpRvWNglLh1wiDcJCr9bgPsXZ7BtqGE8MFiHUrxLK3Z0abcwwOTgnVZ2Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (unknown [82.8.138.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id C5E43341F20;
	Sun, 13 Jul 2025 06:23:54 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org,  Andrii Nakryiko <andrii@kernel.org>,  Eduard
 Zingerman <eddyz87@gmail.com>,  Alexei Starovoitov <ast@kernel.org>,
  Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,
  Yonghong Song <yonghong.song@linux.dev>,  John Fastabend
 <john.fastabend@gmail.com>,  KP Singh <kpsingh@kernel.org>,  Stanislav
 Fomichev <sdf@fomichev.me>,  Hao Luo <haoluo@google.com>,  Jiri Olsa
 <jolsa@kernel.org>,  Quentin Monnet <qmo@kernel.org>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/libbpf: add WERROR option
In-Reply-To: <c883e328-9d08-4a6c-b02a-f33e0e287555@iogearbox.net>
Organization: Gentoo
References: <7e6c41e47c6a8ab73945e6aac319e0dd53337e1b.1751712192.git.sam@gentoo.org>
	<c883e328-9d08-4a6c-b02a-f33e0e287555@iogearbox.net>
User-Agent: mu4e 1.12.11; emacs 31.0.50
Date: Sun, 13 Jul 2025 07:23:52 +0100
Message-ID: <87a558obgn.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 7/5/25 12:43 PM, Sam James wrote:
>> Check the 'WERROR' variable and suppress adding '-Werror' if WERROR=0.
>> This mirrors what tools/perf and other directories in tools do to
>> handle
>> -Werror rather than adding it unconditionally.
>
> Could you also add to the commit desc why you need it? Are there particular
> warnings you specifically need to suppress when building under gentoo?

Sure. In this case, it was https://bugs.gentoo.org/959293 where I think
it's fixed by
https://github.com/libbpf/libbpf/commit/715808d3e2d8c54f3001ce3d7fcda0844f765969
(and the corresponding commit in the kernel tree proper). Backporting
that was a bit too big for our tastes.

The real issue is just that -Werror when we have users who might be
testing with in-development compilers or with alternative options
results in a build failure when you didn't expect one.

>
>> Signed-off-by: Sam James <sam@gentoo.org>
>> ---
>>   tools/lib/bpf/Makefile | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
>> index 168140f8e646..9563d37265da 100644
>> --- a/tools/lib/bpf/Makefile
>> +++ b/tools/lib/bpf/Makefile
>> @@ -77,10 +77,15 @@ else
>>     CFLAGS := -g -O2
>>   endif
>>   +# Treat warnings as errors unless directed not to
>> +ifneq ($(WERROR),0)
>> +  CFLAGS += -Werror
>> +endif
>
> Should we also add sth similar to tools/bpf/bpftool/Makefile and by default
> enforce with -Werror with the option to disable?

Yes, that sounds good to me, though I was nervous of stumbling onto a
philosophical debate about -Werror and wasn't sure what y'all preferred
:)

I can send v2 with an updated commit message and this change. I'll wait
a bit for further comments based on my two replies here.

>
>>   # Append required CFLAGS
>>   override CFLAGS += -std=gnu89
>>   override CFLAGS += $(EXTRA_WARNINGS) -Wno-switch-enum
>> -override CFLAGS += -Werror -Wall
>> +override CFLAGS += -Wall
>>   override CFLAGS += $(INCLUDES)
>>   override CFLAGS += -fvisibility=hidden
>>   override CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64

sam

