Return-Path: <bpf+bounces-39176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEF196FDB3
	for <lists+bpf@lfdr.de>; Sat,  7 Sep 2024 00:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 338DD1C21814
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 22:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5881586F6;
	Fri,  6 Sep 2024 22:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhUBEgAe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7931B85DB
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 22:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725660043; cv=none; b=Jja9QWaYvkb+6ek8AP///j2wXu72PImo2a4n3Um/IiUldpPyyVd90Of35GBqVLsfGjEwBKG08Adpd0vUP4keoRJI4zCvMuK5e+Ny11cZUV5rMpb75xRRMGg/3eZqEi1kDEKjKI2AawF8mqVhmg7p2MC6xF5AWqKMP/qOl4SITSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725660043; c=relaxed/simple;
	bh=retfQTEQCGcwGn5ySnKvm4k2wl+wAnDX06NSWm8HlRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U7gdGtychuzarzP04kvfbqDnpIdo9cpzs0MRgrhr6DpDnDZm5F3GxuKUzMaTkH/FXUCPblIBn0/7CN8F68ckBW7vtAfVw7Y+Axg5MVU7lzPpz4paMlKqR44+eOkfgX/HQltYuUCspyi1imHOTTuZE0bi42rTGCAfh6sRRJOpNkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhUBEgAe; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c3ca32974fso2991261a12.3
        for <bpf@vger.kernel.org>; Fri, 06 Sep 2024 15:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725660040; x=1726264840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CSHEq2AMVAP5BTGyDLcP+YXHuJbFVoaks0phUx9iHt0=;
        b=VhUBEgAemdGMZ9vnkNK4HE089ScdJqy6R5p3FsT8fW42DpOgbJV+5eGadTnC1KMxI7
         rbQC6OUd0nNHPsNadIjoO0aU6s2sHTZRVVzESsDE/jK5l2vuo5RXJGPsRAGgtZ3sRuip
         Yk0RbpjseWlx32Uga6F51vsshJNBiREuEHs9EnTuMybmJmSmgkS9JX+C4Fe2IZBntMVU
         +E82/TIYrVqFZ6Dl8VnKiCR7ylhNRWW10G7+pf0H8+r3E3ABNuFHh0HMIEIU7VtHV8vQ
         3S5Op7cJxnR2bQvAGUSh7m+p+PrsBF2MmkKZXGIHE1G8Ll1K3LhhMFMBRpm3Y/7MNS+q
         9MWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725660040; x=1726264840;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CSHEq2AMVAP5BTGyDLcP+YXHuJbFVoaks0phUx9iHt0=;
        b=k3EgZpThfv3++c2vaPLb2JfCw0UdwuWWMu3XNLbUMbxg4eShHwT41nj/TgE4zmErYG
         xLQv6rEAyj5YRIZxQfJM8zZUrLjy4RJEfOz/IKQHiidhTVChp39+kq1z6f5VrKjy3f3a
         uXamH/vA3hxoYHlXOyxxqoRPebOKJj6AGoJYabxiGzzvlDHh/Yj2rLiLiIcAFCTwmdP1
         RetEBAclLz1s5f4uLWYPrewhM2Q/hjVdZRzizOQC2fRmW+DZoKgJctIoY6g6Emjztunb
         J3QRyj0DZvHoKtA2JklbSZKfX91CdSh3MgwC+YCN7ekdPW4XYDiCiw/ISWO4DxVcX+MA
         MxOw==
X-Forwarded-Encrypted: i=1; AJvYcCVrfoe5N3rpjHhd347iNnNRFmiZAOYOzJmHk6nb6D1WqVonogfqhd6W+r21hVUgoVNWJT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcnsDeTZFEOqOZE+xpRL4JF0BRQW6Lhh7hJkGW1kHzhN9HVt0B
	ho5zmB0gKkno4prT05YjZTeJJ1CVXIKqpAJH4QBaZiZ/8Mk35U5SOIoDyNMb
X-Google-Smtp-Source: AGHT+IGsh6WGRYT/D+l9nNkXjy5NeUmU/BryF9JZS/VlBh4c7U2jSO95deDl8BInR/vsNfHvI6jqmg==
X-Received: by 2002:a05:6402:4306:b0:5c2:5c36:f838 with SMTP id 4fb4d7f45d1cf-5c3dc797eadmr2538098a12.16.1725660039649;
        Fri, 06 Sep 2024 15:00:39 -0700 (PDT)
Received: from [192.168.0.24] (walt-20-b2-v4wan-167837-cust573.vm13.cable.virginm.net. [80.2.18.62])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3cc544a3esm2832778a12.29.2024.09.06.15.00.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 15:00:39 -0700 (PDT)
Message-ID: <bb9546ad-2b64-4e43-bbf1-fd9efbacafb6@gmail.com>
Date: Fri, 6 Sep 2024 23:00:38 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpftool: improve btf c dump sorting stability
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20240906132453.146085-1-mykyta.yatsenko5@gmail.com>
 <6e88208543c2bf9d75d9418f304d624f542503c6.camel@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <6e88208543c2bf9d75d9418f304d624f542503c6.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/09/2024 20:56, Eduard Zingerman wrote:
> On Fri, 2024-09-06 at 14:24 +0100, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Existing algorithm for BTF C dump sorting uses only types and names of
>> the structs and unions for ordering. As dump contains structs with the
>> same names but different contents, relative to each other ordering of
>> those structs will be accidental.
>> This patch addresses this problem by introducing a new sorting field
>> that contains hash of the struct/union field names and types to
>> disambiguate comparison of the non-unique named structs.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
> Note, this is still not fully stable, e.g.:
>
> $ for i in $(seq 1 10); \
>    do touch ./kernel/bpf/verifier.c && \
>       ccache-kernel-make.sh -j23 && \
>       ./tools/bpf/bpftool/bpftool btf dump file vmlinux format c > ~/work/tmp/vmlinux.h.$i; \
>    done
>    ...
> $ md5sum ~/work/tmp/vmlinux.h.* | sort -k1
> 76c9b22274c4aa6253ffaafa33ceffd3  /home/eddy/work/tmp/vmlinux.h.2
> 76c9b22274c4aa6253ffaafa33ceffd3  /home/eddy/work/tmp/vmlinux.h.4
> a1c90a62e6cca59869a9cdffbaa3c4de  /home/eddy/work/tmp/vmlinux.h.1
> a1c90a62e6cca59869a9cdffbaa3c4de  /home/eddy/work/tmp/vmlinux.h.10
> a1c90a62e6cca59869a9cdffbaa3c4de  /home/eddy/work/tmp/vmlinux.h.3
> a1c90a62e6cca59869a9cdffbaa3c4de  /home/eddy/work/tmp/vmlinux.h.5
> a1c90a62e6cca59869a9cdffbaa3c4de  /home/eddy/work/tmp/vmlinux.h.6
> a1c90a62e6cca59869a9cdffbaa3c4de  /home/eddy/work/tmp/vmlinux.h.7
> a1c90a62e6cca59869a9cdffbaa3c4de  /home/eddy/work/tmp/vmlinux.h.8
> a1c90a62e6cca59869a9cdffbaa3c4de  /home/eddy/work/tmp/vmlinux.h.9
>
> [...]
>
Interesting, thanks for showing this, I'll try to replicate this test.



