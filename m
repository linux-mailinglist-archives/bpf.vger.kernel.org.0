Return-Path: <bpf+bounces-43883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C02F9BB389
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 12:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEBE51C2242F
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 11:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09F41B9835;
	Mon,  4 Nov 2024 11:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JPBH2LBX"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9691AF0B9
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 11:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730720069; cv=none; b=RTXC0oILx7r8ZtWtWboyoMa2J/UBRFXh5LhrkexZltx5mTA39PkA6Azmwq0xIel3/b92bOt0WwPtKbesgsuqL6JLN5Q3szqz4i0zK+Q7uSDy2iVWPEjRMHhqvpWMKl3WhgqMFfC9nkIx2qBb+NF7dm4O9p40EnTdlFCwjDmV+t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730720069; c=relaxed/simple;
	bh=HYfG3w1W3gzUTyL7UpDxCxizcAhDkK1pC9Cx+5BpmeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KpRnr5TAPxMOyC2Y1fyjBgTpfHUjisJQpsXoMRUgqUPKAqNyWEDGirOMqOsrY5nDdcmnpIm7f4FHR6Rs4Axk6QzZYP1on2W4nFN6cDKrECAkzvs8C0gkyS/zU3j/yCd4azWyAfWButJDytuAReVoIX8KjkdthNM2CLxnUJx09JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JPBH2LBX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730720066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hema03gqpGW69d3LEXg12k/mI6h64oVZNm0JvmKY30g=;
	b=JPBH2LBXdg5qPCHnEs73rIu8/cd8gspFudfgJV44scEqrnmq3FU7Pj4iaYcG8bOn+9ImIu
	hbxUZKlEgiG08BaoH1g5anJQio2szrd8IHi+RQHThqEIo/1TaMA2NeQ4b4zddpzz4eUZAt
	iqr4DeAa56cns7I7cuQT3RapvV5Obwo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-PtImxvmyPuuxXW-szgjFiw-1; Mon, 04 Nov 2024 06:34:25 -0500
X-MC-Unique: PtImxvmyPuuxXW-szgjFiw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d49887a2cso2100501f8f.0
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 03:34:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730720064; x=1731324864;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hema03gqpGW69d3LEXg12k/mI6h64oVZNm0JvmKY30g=;
        b=ekFv9yUqGtebWgmi9SItzUOSouj95BY6mgV6/rEAvzeoANdooQQqpNuYazWVELFr14
         M0mBSJ47UCmungFhfwonY52XSxu+7Evtyq5bmXDLDIKjK+d2K8corU3VmOj9VOpGd8h1
         PbT/ARe3T2NSqKNWngfyN5qWzc1OqsAhs3n9ZZyQrDDuHScl7Nr2JTWB+x8JeZlOyyko
         P5tQHlNf3EVT3+B8s7GTMfx5cyU3EPOa7BMIUEcF18tdKFVP7/imZqF7Gc6HvGN66PIx
         5ToR0bDQkff9RoTLbYderWP/kMXUMQmBhBIk0OaMApPYi8M+FAuoGvIXyGJjXN4rGBpX
         nDlg==
X-Gm-Message-State: AOJu0YxMeq4zsmcmdjmIsxv2pfpfk80acpES5uobIEnAmOPoiaMBuSX7
	3/+O9C5LjGrUIMqcOIDxTXVaVhInoPGoAwPz8tAakXBhD4DoXoit41y+FJoiIDHFyME4F+stXrP
	Q2K/+NBB65t39Mp8Cy8bMtoxDbCMBuydQnfpMmaoYJu+riOos
X-Received: by 2002:a05:6000:1a8e:b0:37d:2d6f:3284 with SMTP id ffacd0b85a97d-381c145bd78mr11357014f8f.9.1730720064179;
        Mon, 04 Nov 2024 03:34:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkP4Zbd+9O6CMZwchW3l8vpv6OLKTP/ETsJRZGnTPsM278AqsT3F8LujX9BHKdfUa74Q/oQg==
X-Received: by 2002:a05:6000:1a8e:b0:37d:2d6f:3284 with SMTP id ffacd0b85a97d-381c145bd78mr11356983f8f.9.1730720063701;
        Mon, 04 Nov 2024 03:34:23 -0800 (PST)
Received: from [192.168.0.101] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d4d1fsm12925750f8f.38.2024.11.04.03.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 03:34:23 -0800 (PST)
Message-ID: <62867a31-3e29-442f-b21d-13e16d95f998@redhat.com>
Date: Mon, 4 Nov 2024 12:34:21 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 0/3] selftests/bpf: Improve building with
 extra
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
References: <cover.1730449390.git.vmalik@redhat.com>
 <CAEf4Bzaf4SpcL6cV+VNxfiqifhM=7e_sY5YyBCZKVJqdvxqqQA@mail.gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <CAEf4Bzaf4SpcL6cV+VNxfiqifhM=7e_sY5YyBCZKVJqdvxqqQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/1/24 20:46, Andrii Nakryiko wrote:
> On Fri, Nov 1, 2024 at 1:38 AM Viktor Malik <vmalik@redhat.com> wrote:
>>
>> When trying to build BPF selftests with additional compiler and linker
>> flags, we're running into multiple problems. This series addresses all
>> of them:
>>
>> - CFLAGS are not passed to sub-makes of bpftool and libbpf. This is a
>>   problem when compiling with PIE as libbpf.a ends up being non-PIE and
>>   cannot be linked with other binaries (patch #1).
>>
>> - bpftool Makefile runs `llvm-config --cflags` and appends the result to
>>   CFLAGS. The result typically contains `-D_GNU_SOURCE` which may be
>>   already set in CFLAGS. That causes a compilation error (patch #2).
>>
>> - Some GCC flags are not supported by Clang but there are binaries which
>>   are always built with Clang but reuse user-defined CFLAGS. When CFLAGS
>>   contain such flags, compilation fails (patch #3).
>>
>> Changelog:
>> ----------
>> v2 -> v3:
>> - resolve conflicts between patch #1 and 4192bb294f80 ("selftests/bpf:
>>   Provide a generic [un]load_module helper")
>> - add Quentin's and Jiri's acks for patches #2 and #3
>>
>> v1 -> v2:
>> - cover forgotten case in patch#1 (noted by Eduard)
>> - remove -D_GNU_SOURCE unconditionally in patch#2 (suggested by Andrii)
>> - rewrite patch#3 to just add -Wno-unused-command-line-argument
>>   (suggested by Andrii)
>>
>> Viktor Malik (3):
>>   selftests/bpf: Allow building with extra flags
>>   bpftool: Prevent setting duplicate _GNU_SOURCE in Makefile
>>   selftests/bpf: Disable warnings on unused flags for Clang builds
>>
> 
> I've applied the last two patches, they seem to be independent from
> the first, right?

Yes, they are independent, thanks. I'll sync with Toke on the first one.

Viktor

> 
> 
>>  tools/bpf/bpftool/Makefile           |  6 ++++-
>>  tools/testing/selftests/bpf/Makefile | 36 +++++++++++++++++++---------
>>  2 files changed, 30 insertions(+), 12 deletions(-)
>>
>> --
>> 2.47.0
>>
>>
> 


