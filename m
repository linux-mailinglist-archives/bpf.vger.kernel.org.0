Return-Path: <bpf+bounces-37673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBC19594DC
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 08:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B43091C225FC
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 06:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ACF16DC32;
	Wed, 21 Aug 2024 06:40:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE79716DC2D;
	Wed, 21 Aug 2024 06:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724222433; cv=none; b=j9Dg6gan5yDfQ1v0nAyzWfBpplwoK08JRQvMpgeMT05gHKtzvpz+3IJhaZiv+Hh4VO8VAwY91NAO9qbYnx/SPqlgYSwiqT8BvEy8mgRnsDyFivURmhCZ+i2SRR+cmeY4m3gA6WOi6mLOb87hNOiFtG37O3dyDnEShXZscj3GM/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724222433; c=relaxed/simple;
	bh=TMWcWDIi6SZnoKAu3hrDuGB/O1amJpxMgn7ZZuJ+/Q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RBRwuINajZPizXVnkQk11SBSm6kCMxNP/a3AdF0mBt90YhDKdKnW5YgmxAFgr96egB8B099tSgelu/CFNgoivUooTsAP+of0R0QhNA6jpvCU3bvVUtfU+tqhPS4ANL+t3mrbbXA2NvqitQOkC8imh5yvhoQoj+Q9r2rPkj3f4Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37182eee02dso242213f8f.1;
        Tue, 20 Aug 2024 23:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724222430; x=1724827230;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnIWY5NKrbXOX6RV9OSDR6ywjrbW+j/o7WIsnEBQrm8=;
        b=Qz40fLZPIL+kI+eTW+VjNcQZYXAAezU4Bdc47rKBFXV5SMahCGsefcUUgshlcYfuo6
         AThXQnAFCiAh3RJmjKvyLZmRICM6EyFcKuU8sB0aqRTsUS7wmv4QMitM0S/r7KerDkHJ
         uPAe9FG3UY8fzPpMZi6DHe966wwpHzpjmiJJ9BQCCR+MzGo/6s8EWKjnTDunh3St29WC
         3HAB95it939Bp4iqZoaWHwKcXhu/yQYY3BCsnRAhqHbJQ9aXbBvUa6N05nnRADGQJVVK
         mePGt8BtWajsdzQxDPCuUnw04qw40C4qGf/H9GPBALpiPqPT+cj620TSbwLoxQCjX71x
         IjRw==
X-Forwarded-Encrypted: i=1; AJvYcCUlC9Ba1YjKS6cZE4WIg1CRzM3uKaViPvhHVEbFo4q6i5eNsF1hxYVduA8F4yKPyt43NrhV7SRBiIshT9X8@vger.kernel.org, AJvYcCVycQPHQz+FT7ZdK975rqvWcuLqm9SGG29xN/YVZ5h+w42mlx6zKvyMl7FCzHPx2jvj3hY=@vger.kernel.org, AJvYcCWPf6BiWgJc+QsmKjwc140wND0viMhLDdK7jbqleDCX/WmPdTSkyk5kJjhQI/FRuBuypEHMUBVewhdt9I+8@vger.kernel.org
X-Gm-Message-State: AOJu0YzVSZMJ8V4MMBv4drfRC/XcTV3KN1Y57Lzk1xZR0nbTHnMz/0N0
	7ykeyyWrce3KxNNohJho7HmzhYEKeD5kk4orNCdP15xniE3Mw+E/
X-Google-Smtp-Source: AGHT+IFQCuvIqlVi8bED/FOCjl15UVf4VXeOgbUyw19f1ZN/hCRmuC6aawUkvPknOKBzvv2UUeETTw==
X-Received: by 2002:a5d:64c1:0:b0:371:8685:84c with SMTP id ffacd0b85a97d-372fdd9281fmr688527f8f.15.1724222429872;
        Tue, 20 Aug 2024 23:40:29 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189859d4esm14817919f8f.49.2024.08.20.23.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 23:40:29 -0700 (PDT)
Message-ID: <c2086083-4378-4503-b3e2-08fb14f8ff37@kernel.org>
Date: Wed, 21 Aug 2024 08:40:27 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] kbuild: bpf: Do not run pahole with -j on 32bit userspace
To: Jiri Olsa <olsajiri@gmail.com>
Cc: masahiroy@kernel.org, linux-kernel@vger.kernel.org,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, shung-hsi.yu@suse.com,
 msuchanek@suse.com
References: <20240820085950.200358-1-jirislaby@kernel.org>
 <ZsSpU5DqT3sRDzZy@krava> <523c1afa-ed9d-4c76-baea-1c43b1b0c682@kernel.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <523c1afa-ed9d-4c76-baea-1c43b1b0c682@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21. 08. 24, 7:32, Jiri Slaby wrote:
> On 20. 08. 24, 16:33, Jiri Olsa wrote:
>> On Tue, Aug 20, 2024 at 10:59:50AM +0200, Jiri Slaby (SUSE) wrote:
>>> From: Jiri Slaby <jslaby@suse.cz>
>>>
>>> == WARNING ==
>>> This is only a PoC. There are deficiencies like CROSS_COMPILE or LLVM
>>> are completely unhandled.
>>>
>>> The simple version is just do there:
>>>    ifeq ($(CONFIG_64BIT,y)
>>> but it has its own deficiencies, of course.
>>>
>>> So any ideas, inputs?
>>> == WARNING ==
>>>
>>> When pahole is run with -j on 32bit userspace (32bit pahole in
>>> particular), it randomly fails with OOM:
>>>> btf_encoder__tag_kfuncs: Failed to get ELF section(62) data: out of 
>>>> memory.
>>>> btf_encoder__encode: failed to tag kfuncs!
>>>
>>> or simply SIGSEGV (failed to allocate the btf encoder).
>>>
>>> It very depends on how many threads are created.
>>>
>>> So do not invoke pahole with -j on 32bit.
>>
>> could you share more details about your setup?
>>
>> does it need to run on pure 32bit to reproduce?
> 
> armv7l builds are 32bit only.
> 
>> I can't reproduce when
>> doing cross build and running 32 bit pahole on x86_64..
> 
> i586 is built using 64bit kernel. It is enough to have 32bit userspace.
> As written in the linked bug:
> https://bugzilla.suse.com/show_bug.cgi?id=1229450#c6
> 
> FWIW, steps to reproduce locally:
> docker pull jirislaby/pahole_crash
> docker run -it jirislaby/pahole_crash
> 
> The VM space of pahole is exhausted:
> process map: https://bugzilla.suse.com/attachment.cgi?id=876821
> strace of mmaps: https://bugzilla.suse.com/attachment.cgi?id=876822
> 
> You need to run with large enough -j on a fast machine. Note that this 
> happens on build hosts even with -j4, but they are under heavy load, so 
> parallelism of held memory is high.

 From https://bugzilla.suse.com/show_bug.cgi?id=1229450#c20:
Run on 64bit:
pahole -j32 -> 4.102 GB
pahole -j16 -> 3.895 GB
pahole -j1 -> 3.706 GB

On 32bit (the same vmlinux):
pahole -j32 -> 2.870 GB (crash)
pahole -j16 -> 2.810 GB
pahole -j1 -> 2.444 GB

Look there for full massif report.

So now I think we should disable BTF generation with 32bit pahole 
completely. Or someone debugs it and improves debug info loading to not 
eat that much.

thanks,
-- 
js
suse labs


