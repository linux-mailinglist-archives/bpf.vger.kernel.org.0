Return-Path: <bpf+bounces-42575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDCB9A5A3B
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 08:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9A731F217F3
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 06:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C9B194C6C;
	Mon, 21 Oct 2024 06:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHdDTBZY"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B99BA27
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 06:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729491653; cv=none; b=UYrdUu2YR8Q/4OCI7CtugPJjfKc2fFhqYooKLOZNunzDZPDsujvAMsKe4WiePDmSWtJHP7jXg3rJU1Nhbd/2DwjId3ky2klZW/fq7X2K3jmDE/7rpWorBZp2raVRQBJNxzCnaVsSy15B7J/tzbAtku9ph/GXTVnKQc9JPiJZtK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729491653; c=relaxed/simple;
	bh=4TNHhsIEtAACYwTOOkht3KM/DAG/Xuo9kqLr/BnfvXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fp1wps9nobp3WU9Qx+zlKHBcA/xVolGCZPYGuK3kRsrAMyURgJTTQQ3zZlUAIE9N06ba+sISlSTBrRebvoQmPb0d5ywGMRbxJy3pMjiXQZ2EaNAZXtQGr1anOaWTKri/mBKnv6zgPLO4DBONqgueNqiZVveKhhX+O/rCEb4+kO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NHdDTBZY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729491650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uHJRiKMI4dr3V6nqOEQrnHgqeQSUwGziYyV9iDC+6MI=;
	b=NHdDTBZYoGXZZAZH5Qa572oo8paCdVqJXcNUrK8S0YFA7FfBOwDaa7hOqBM788EgfRlDF+
	TCtNTGgQN+GHQhK2F052sYi45nCiRS9RzOUh+KDgm45ka+Tfr0uTzBZq88PwcK6CX9b6di
	8UU2Sqvcc7VyqIBXDz2FCExSb+zRRsU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244--DHM5QwRPvCyYpcf6qMt6g-1; Mon, 21 Oct 2024 02:20:49 -0400
X-MC-Unique: -DHM5QwRPvCyYpcf6qMt6g-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a9a273e4251so264738366b.1
        for <bpf@vger.kernel.org>; Sun, 20 Oct 2024 23:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729491647; x=1730096447;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uHJRiKMI4dr3V6nqOEQrnHgqeQSUwGziYyV9iDC+6MI=;
        b=LAmCoS46z1ZniU4/O9FvbxXQIhTcgxLqEURupZv2K0VbTcyfY85dt82LDlEJn0PQ9E
         9jrullw5u3ZZylKQqZAS34UNa/InbwHuOsoq+1PS0vAZw0TbvRH8Erj3InX9PUNmA/Sl
         cE75DH+zkU616cadrIPBl5uV4GFeM45mimOC8myRsZUIrmiSkVQ6iMxH0yOA+BMaigsQ
         8yfVxvl8fnUbqks/QC7NAgB10UZava/G2BX3+QmuXwT0WZN97w7vJ6ooq7xAvpYtvSjN
         C36cmwJHhouD2fuMD6GzfPO4UyDK4QE/DdfsS1AQ0rT120bXuqgn9RIeHubmvQpdCv/L
         8IFA==
X-Gm-Message-State: AOJu0YzJ1mc8x1PIzR67P7Lm71Zv5x9dRGQ0sh8uI9BOBK1nYgSsgYEr
	DgMj4afSkRVieCLWk6VtnrQhUiBH9Y7pZYXX5in38A2e5kkQcbB7+dTqyp1/ShgMkfioXn1q5Kd
	YJPxZzRgT0xr15+/6kZCqu/jR7l+/dbG1j5OI10/YTDd45357pIdHsImJ360=
X-Received: by 2002:a17:907:705:b0:a9a:37fe:e7d0 with SMTP id a640c23a62f3a-a9a69de9833mr1007166666b.64.1729491647534;
        Sun, 20 Oct 2024 23:20:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXxzqJyPcj2K0U+Xhq849ojTgmJqWa+ACU0BrIj38ryXadMOQ1GlCyyaMVtLozAgwavWrLRQ==
X-Received: by 2002:a17:907:705:b0:a9a:37fe:e7d0 with SMTP id a640c23a62f3a-a9a69de9833mr1007163366b.64.1729491647137;
        Sun, 20 Oct 2024 23:20:47 -0700 (PDT)
Received: from [192.168.0.113] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91572abdsm165879166b.171.2024.10.20.23.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 23:20:46 -0700 (PDT)
Message-ID: <a05967e6-851f-4db8-9ec4-b910acaaf70f@redhat.com>
Date: Mon, 21 Oct 2024 08:20:39 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Disable warnings on unused
 flags for Clang builds
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
References: <cover.1729233447.git.vmalik@redhat.com>
 <370c84ee3a0e8627a09d89fff12f7a285565fb46.1729233447.git.vmalik@redhat.com>
 <ZxU86eN6kMrgmuaV@krava>
Content-Language: en-US
From: Viktor Malik <vmalik@redhat.com>
In-Reply-To: <ZxU86eN6kMrgmuaV@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/24 19:24, Jiri Olsa wrote:
> On Fri, Oct 18, 2024 at 08:49:01AM +0200, Viktor Malik wrote:
>> There exist compiler flags supported by GCC but not supported by Clang
>> (e.g. -specs=...). Currently, these cannot be passed to BPF selftests
>> builds, even when building with GCC, as some binaries (urandom_read and
>> liburandom_read.so) are always built with Clang and the unsupported
>> flags make the compilation fail (as -Werror is turned on).
>>
>> Add -Wno-unused-command-line-argument to these rules to suppress such
>> errors.
>>
>> This allows to do things like:
>>
>>     $ CFLAGS="-specs=/usr/lib/rpm/redhat/redhat-hardened-cc1" \
>>       make -C tools/testing/selftests/bpf
> 
> hi,
> might be my fedora setup, but this example gives me compile error below
> even with the patch applied:
> 
>   EXT-OBJ  [test_progs] testing_helpers.o
> In file included from testing_helpers.c:10:
> disasm.h:11:10: fatal error: linux/stringify.h: No such file or directory
>    11 | #include <linux/stringify.h>
>       |          ^~~~~~~~~~~~~~~~~~~

Aren't you doing `make CFLAGS="..."` instead of `CFLAGS="..." make`? The
difference is that the former overrides CFLAGS defined in selftests
Makefile and therefore the include dirs are not correctly added.

> 
> jirka
> 
>>
>> Without this patch, the compilation would fail with:
>>
>>     [...]
>>     clang: error: argument unused during compilation: '-specs=/usr/lib/rpm/redhat/redhat-hardened-cc1' [-Werror,-Wunused-command-line-argument]
>>     make: *** [Makefile:273: /bpf-next/tools/testing/selftests/bpf/liburandom_read.so] Error 1
>>     [...]
>>
>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>> ---
>>  tools/testing/selftests/bpf/Makefile | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>> index 1fc7c38e56b5..3da1a61968b7 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -273,6 +273,7 @@ $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c liburandom
>>  	$(Q)$(CLANG) $(CLANG_TARGET_ARCH) \
>>  		     $(filter-out -static,$(CFLAGS) $(LDFLAGS)) \
>>  		     $(filter %.c,$^) $(filter-out -static,$(LDLIBS)) \
>> +		     -Wno-unused-command-line-argument \
>>  		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
>>  		     -Wl,--version-script=liburandom_read.map \
>>  		     -fPIC -shared -o $@
>> @@ -281,6 +282,7 @@ $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_r
>>  	$(call msg,BINARY,,$@)
>>  	$(Q)$(CLANG) $(CLANG_TARGET_ARCH) \
>>  		     $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $(filter %.c,$^) \
>> +		     -Wno-unused-command-line-argument \
>>  		     -lurandom_read $(filter-out -static,$(LDLIBS)) -L$(OUTPUT) \
>>  		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
>>  		     -Wl,-rpath=. -o $@
>> -- 
>> 2.47.0
>>
> 


