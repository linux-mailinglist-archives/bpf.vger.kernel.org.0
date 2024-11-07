Return-Path: <bpf+bounces-44240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF42C9C07C0
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 14:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D390A1C23B42
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 13:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3288420FAAD;
	Thu,  7 Nov 2024 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ugp6/HBY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0A42076A5
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986846; cv=none; b=QVphrR4vY2bBbjldnZfEEmdZLTU5I7S+AKWQwfyIUfUWI/Fvt/3aUSbY9tHSXGf9y3TgSDu2XjsZNWxYBNMTxtLlctSBcXzylFP3EiF+DqDwYqXNMo97YyzwefmRVWVO6Xq0XsjYvecS+SOEqLxOk26f+OXczfkLx01GbrnMJ2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986846; c=relaxed/simple;
	bh=yOGGiMTgLJHa8CotK5ZqbHv4fq3LlsO+bZ6yg0aqdsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h2Yi9V+PxSNeerm1BsWIBPOMJp1GAlACCBm0YF2YMEHE7bIopQ5xgkpY/8v0ZqzUAMKF3tgrUvjnPUtUQYkn5KDcpxa0N4O2LaA08gwy9nKaxdjnG5P+tA4e+XkZosDmjw0/kQfCQkArCLDk/WjbrJql57SefTnFXPfkdWBeSWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ugp6/HBY; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a16b310f5so153835166b.0
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2024 05:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730986843; x=1731591643; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jIg5R9BrUrY3PY0JVOFbnxLIIGDyPNDlrluDXiXk7T0=;
        b=Ugp6/HBYDaawcMMv0PMQydt6aR0YAgmwoTSVQYdNDqKLA2fi408SXBeqJqdQZB6vxy
         ZrL8draov5A8VkuAc51m86P3cKVGQ6jKYOlOY3iBgLirZNL0qSEstV2ELWWo5aeT1s2I
         6ayJLx6nXv6GglpFombptCXMblZOUAhrDCKKFD74V3N5CsqnBHBTbH9WfVVOZD1ALirP
         HYLqr5pp6xBNpmSPSuL9goRg6B4EnYNLxRqXmsFoMNyMRBp280oJGAh0yPgEHy4oX13X
         GicGS4SJVKdGP0ZW5+TF9JYedQnaSN4BLTaRv/abbaiVI/Nmedfz2hLZ2naimFDu1ggs
         J8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730986843; x=1731591643;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jIg5R9BrUrY3PY0JVOFbnxLIIGDyPNDlrluDXiXk7T0=;
        b=sNaVCja133LFkDKjg5WsiNndtHi4Uvl9YHlRsmbwi58MyQprKTOdyDkKZ2Mniq+N3l
         I63YLPaAWStmIMN7BDgUFec4yQKw/S8ud30zAFULGsuIpP7i6wqQ3iKp2nWBvfN0GONe
         CQ2lTJOn4io24LWrsz1y6WF245Rs/fcZlorQnpmo0JuiuALvyjZGOeFZCuq6ncsCEeqN
         H/Q/Jw3hgoUrU/KeEU9088IxN+zyxl7g9UQcsIV14vtS3UZhmZw8Fhz//jC2WMJP/+ox
         bz6n5RA3Qt6ek9sySnXEwYgTBaMJQEmBDnQR6VDCEPjZTM0KF8iO0hxGtGxRlU40NKHG
         PYKg==
X-Gm-Message-State: AOJu0YxBlQk64r6eWjkxeUMZ+Mn1L2KFS2XlFv7mth2bIe3KL5S55SxU
	8QUbt+qJNM2+R+gJYRdFjQVEVJuWZtCzYoNN/gg9Yo7ge/KKRxd4cq8EFQ==
X-Google-Smtp-Source: AGHT+IHuG6cWAPRsGjGuOQJeMMHKJxDDOKkaefch81HPRea7u9u1PSw+bRTB36BJbZCqPX84hTs/Zg==
X-Received: by 2002:a17:907:3e9e:b0:a9a:3cf:cdb8 with SMTP id a640c23a62f3a-a9ee74d62fbmr111301666b.36.1730986842970;
        Thu, 07 Nov 2024 05:40:42 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:3:e82d:23a4:3ba3:36a3? ([2620:10d:c092:500::4:7613])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0e2f49bsm93728266b.202.2024.11.07.05.40.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 05:40:42 -0800 (PST)
Message-ID: <0e4dd72d-ac35-4c26-9ed9-9da32046eac9@gmail.com>
Date: Thu, 7 Nov 2024 13:40:41 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] libbpf: stringify error codes in warning
 messages
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 Mykyta Yatsenko <yatsenko@meta.com>
References: <20241104170048.1158254-1-mykyta.yatsenko5@gmail.com>
 <CAEf4BzbB_PuJOKq-QuuS8ztBcAaMEZT3bte0QavXze2HT=2epA@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4BzbB_PuJOKq-QuuS8ztBcAaMEZT3bte0QavXze2HT=2epA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/11/2024 00:39, Andrii Nakryiko wrote:
> On Mon, Nov 4, 2024 at 9:01 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Libbpf may report error in 2 ways:
>>   1. Numeric errno
>>   2. Errno's text representation, returned by strerror
>> Both ways may be confusing for users: numeric code requires people to
>> know how to find its meaning and strerror may be too generic and
>> unclear.
>>
>> This patch modifies libbpf error reporting by swapping numeric codes and
>> strerror with the standard short error name, for example:
>> "failed to attach: -22" becomes "failed to attach: EINVAL".
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   tools/lib/bpf/libbpf.c | 429 ++++++++++++++++++++++-------------------
> We have use cases for strerr() in all of libbpf .c files, let's do the
> conversion there as well. But I'd probably split adding strerr()
> helper into first separate patch, and then would do the rest of
> conversions in either one gigantic patch or split into some logical
> groups of a few .c files (like, linker.c separate from libbpf.c,
> separate from bpf.c, if we have any strerr() uses there). We have tons
> of error message prints :)
>
> pw-bot: cr
>
>>   1 file changed, 231 insertions(+), 198 deletions(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 711173acbcef..26608d8585ec 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -336,6 +336,83 @@ static inline __u64 ptr_to_u64(const void *ptr)
>>          return (__u64) (unsigned long) ptr;
>>   }
>>
>> +/*
>> + ** string returned from errstr() is invalidated upon the next call
>> + */
> keep it as single-line comment, but if you needed multi-line, it
> should be formatted like so:
>
> /*
>   * blah blah blah lorem ipsum
>   */
>
>> +static const char *errstr(int err)
> let's move this function into str_error.c, it doesn't have to live in
> already huge libbpf.c (and you'll need to "expose" it in str_error.h
> to use from not just libbpf.c anyways)
>
>> +{
>> +       static __thread char buf[11];
> nit: make it buf[12] to technically handle "-2000000000" ?
>
>> +       const char *str;
>> +       bool neg;
>> +
>> +       if (err < 0) {
>> +               err = -err;
>> +               neg = true;
>> +       }
> honestly, thinking about this a bit more, I think it's ok to always
> emit negative error in the buffer (because that's what it should
> always be, at least when this is used internally in libbpf).
>
> So let's have, just:
>
> if (err > 0)
>      err = -err;
>
> to make it explicit that negative error is the common/expected way
>
>
>> +
>> +       switch (err) {
>> +       case EINVAL:
>> +               str = "-EINVAL"; break;
> then for all of these we can have a nice and compact style:
>
> case -EINVAL: return "-EINVAL";
> case -EPERM: return "-PERM";
>
>> +       case EPERM:
>> +               str = "-EPERM"; break;
>> +       case ENOMEM:
>> +               str = "-ENOMEM"; break;
>> +       case ENOENT:
>> +               str = "-ENOENT"; break;
>> +       case E2BIG:
>> +               str = "-E2BIG"; break;
>> +       case EEXIST:
>> +               str = "-EEXIST"; break;
>> +       case EFAULT:
>> +               str = "-EFAULT"; break;
>> +       case ENOSPC:
>> +               str = "-ENOSPC"; break;
>> +       case EACCES:
>> +               str = "-EACCES"; break;
>> +       case EAGAIN:
>> +               str = "-EAGAIN"; break;
>> +       case EBADF:
>> +               str = "-EBADF"; break;
>> +       case ENAMETOOLONG:
>> +               str = "-ENAMETOOLONG"; break;
>> +       case ESRCH:
>> +               str = "-ESRCH"; break;
>> +       case EBUSY:
>> +               str = "-EBUSY"; break;
>> +       case ENOTSUP:
> Is this one coming from public UAPI header? I don't think so.
> include/linux/errno.h is not exported to user-space. This means that
> Github version of libbpf will have trouble with compiling this. This
> works ok inside kernel repo, but we should be careful about relying on
> internal headers.
Got it.
>
>
> Please check all the other ones. BTW, how did you end up with this
> exact set of errors?
First I took all errors that bpf syscall sets, then just grepped for 
uppercase strings
starting with E in tools/lib/bpf.
The number of items very roughly matches what you suggested it to be 
(10-20), I have around 26.
>
>> +               str = "-ENOTSUP"; break;
>> +       case EPROTO:
>> +               str = "-EPROTO"; break;
>> +       case ERANGE:
>> +               str = "-ERANGE"; break;
>> +       case EMSGSIZE:
>> +               str = "-EMSGSIZE"; break;
>> +       case EINTR:
>> +               str = "-EINTR"; break;
>> +       case ENODATA:
>> +               str = "-ENODATA"; break;
>> +       case EIO:
>> +               str = "-EIO"; break;
>> +       case EUCLEAN:
>> +               str = "-EUCLEAN"; break;
>> +       case EDOM:
>> +               str = "-EDOM"; break;
>> +       case EPROTONOSUPPORT:
>> +               str = "-EPROTONOSUPPORT"; break;
>> +       case EDEADLK:
>> +               str = "-EDEADLK"; break;
>> +       case EOVERFLOW:
>> +               str = "-EOVERFLOW"; break;
>> +       default:
>> +               snprintf(buf, sizeof(buf), "%d", err);
>> +               return buf;
> and then here we'll just
>
> snprintf(buf, sizeof(buf), "%d", err);
> return buf;
>
>> +       }
>> +       if (!neg)
>> +               ++str;
>> +
>> +       return str;
>> +}
>> +
> [...]



