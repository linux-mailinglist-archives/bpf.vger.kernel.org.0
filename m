Return-Path: <bpf+bounces-37676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5A795961B
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 09:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE790285506
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 07:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2C9193432;
	Wed, 21 Aug 2024 07:30:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711311B81A8;
	Wed, 21 Aug 2024 07:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724225403; cv=none; b=iev+wxcdIopGImwkIqNEtSN1+URbEpwL/uk74rkMAKEXUv6IJ75U03LuUSs4F7s4e3i9msjiYTf9zwqOaxqFiwqlxyR4ycHkaAvbPjpw3fRX+mOob0Pwi8UnP1R7ZDA4hdzrom/dj+FR2NSor+klEO7e3vVeZjxllAjGnZhAt7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724225403; c=relaxed/simple;
	bh=JGUM4145ARScO0xL+jaBGQ6uCMV6mJhbzI2XvXOpn1c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uZVTtoICfuHpspWag4JMqvi1uhkfu8c7YitE5YSWeguEjdwY5fL03YAvDhPnZmxkzlbqe9SkiTobAXRPqpWiMRAGKuePpYEXzTXPaeRLbdaI9kpRu0IYSzI3qyMGAy5p8k3mkOAb4juMmdwM2DIA1CZTBF2rBbUSSTnEA8bS3yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso69291455e9.3;
        Wed, 21 Aug 2024 00:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724225399; x=1724830199;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=90i4sWyCp/PnJY2UL3m3pOl5kV4vrpiZ3HrEW1i1ZWY=;
        b=Ntu6KEfSC7+h7KgW9cPKN5bUQxjZP1CKvBNGFG42AGBIaDJ9pWK0zQbzio5zT/eIGK
         GqblK11+VPuvlxx8epSbEA8CTrYC46KUIgp/zYjtfsKmdund9D5O8YcUNfqV4WG1ZLZB
         +L9F6nHVlcqnK6I6zZNecrgFHbLgNaYdkil/zz6rvvs0FOxbd8fKVCm0ctv26cuhtxjh
         KLXN+FT3yNquqT/QQRFSBupH7JuWP97voObdF4/2bKvmIa5TOVBNSZaOIDgGtw0Ot61y
         HASz7RQ5SFiO6BM/895ES5lVsaYYxvDdbg8q3beTkW+IuxcPMpB6MF7/KnwmcE549geC
         ZIJg==
X-Forwarded-Encrypted: i=1; AJvYcCUUGZPNF7VUhAsvsP/w5BJstb/pjFrz0OkftKLgm+u9qZrn9+kYuLWtDMYnm5EVqFQVSHw=@vger.kernel.org, AJvYcCV7yg7qvG5jUmDqZ1UfmCNMSzDyaepOGdE/gTL6b/+DkF00a0iy671bSLFOT4YIxwWnQLKbY53VFo3hYKCb@vger.kernel.org, AJvYcCVuEPqsoOCJBBGEcrGN1Vi88+XJMyW2Qz2xCQYkoyg1Za0Pj7Lhog/foNdouyyGgXp431POR6Ji08R0mYcg@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl+FkMOqehOylFwMqpvxCvvrrKDqENvhffy4UFumJot1o5wBIX
	xUqOaTCo8Sl2cJRCft0NykAXXlXre/2X4v0iFIse2v11S5O9hMLn
X-Google-Smtp-Source: AGHT+IGgWEz+bEae0ZVWNthQV+b1VnXipmXRMoH/laa8l+l8w1wJOU2B21wf6na5hjv4uCDRxVagLg==
X-Received: by 2002:a05:600c:4f06:b0:429:a3e:c786 with SMTP id 5b1f17b1804b1-42abd246792mr15009235e9.24.1724225399083;
        Wed, 21 Aug 2024 00:29:59 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abef9847asm15240975e9.24.2024.08.21.00.29.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 00:29:58 -0700 (PDT)
Message-ID: <7ebee21d-058f-4f83-8959-bd7aaa4e7719@kernel.org>
Date: Wed, 21 Aug 2024 09:29:57 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] kbuild: bpf: Do not run pahole with -j on 32bit userspace
From: Jiri Slaby <jirislaby@kernel.org>
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
 <c2086083-4378-4503-b3e2-08fb14f8ff37@kernel.org>
Content-Language: en-US
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <c2086083-4378-4503-b3e2-08fb14f8ff37@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21. 08. 24, 8:40, Jiri Slaby wrote:
>  From https://bugzilla.suse.com/show_bug.cgi?id=1229450#c20:
> Run on 64bit:
> pahole -j32 -> 4.102 GB
> pahole -j16 -> 3.895 GB
> pahole -j1 -> 3.706 GB
> 
> On 32bit (the same vmlinux):
> pahole -j32 -> 2.870 GB (crash)
> pahole -j16 -> 2.810 GB
> pahole -j1 -> 2.444 GB
> 
> Look there for full massif report.

 From https://bugzilla.suse.com/show_bug.cgi?id=1229450#c21:
(In reply to Jiri Slaby from comment #20)
 > | |   |   ->24.01% (954,816,480B) 0x489B4AB: UnknownInlinedFun 
(dwarf_loader.c:959)

So given this struct class_member is the largest consumer, running 
pahole on pahole. The below results in 4.102 GB -> 3.585 GB savings.

--- a/dwarves.h
+++ b/dwarves.h
@@ -487,14 +487,14 @@ int cu__for_all_tags(struct cu *cu,
   */
  struct tag {
         struct list_head node;
+       const char       *attribute;
+       void             *priv;
         type_id_t        type;
         uint16_t         tag;
+       uint16_t         recursivity_level;
         bool             visited;
         bool             top_level;
         bool             has_btf_type_tag;
-       uint16_t         recursivity_level;
-       const char       *attribute;
-       void             *priv;
  };

  // To use with things like type->type_enum == 
perf_event_type+perf_user_event_type
@@ -1086,17 +1086,17 @@ static inline int function__inlined(const struct 
function *func)
  struct class_member {
         struct tag       tag;
         const char       *name;
+       uint64_t         const_value;
         uint32_t         bit_offset;
         uint32_t         bit_size;
         uint32_t         byte_offset;
         int              hole;
         size_t           byte_size;
+       uint32_t         alignment;
         int8_t           bitfield_offset;
         uint8_t          bitfield_size;
         uint8_t          bit_hole;
         uint8_t          bitfield_end:1;
-       uint64_t         const_value;
-       uint32_t         alignment;
         uint8_t          visited:1;
         uint8_t          is_static:1;
         uint8_t          has_bit_offset:1;

-- 
js
suse labs


