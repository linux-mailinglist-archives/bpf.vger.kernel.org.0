Return-Path: <bpf+bounces-49809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EC3A1C3E5
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 16:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08E2218892BD
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 15:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B3635973;
	Sat, 25 Jan 2025 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkRazVX5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C47F182B4;
	Sat, 25 Jan 2025 15:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737817531; cv=none; b=eQHOzpNaNQlL6ewuLX9EzIVRvk7llXuFCRCnHygE6ziT3aMhD1x11ckbbj1rbUjg/uSXS+F9elIu2GHYtwB/pItmrWkKaszzEDfpv/TcBQStuWbu/o4Y1BJ2okC5RJ4ujk301rJbf2m0e6JzVSJyGkyotQfjvbhwoK2sMo2DtDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737817531; c=relaxed/simple;
	bh=sn85kaHWASCngHKQypPoomM6gcaUDbLPvg5Tm2/yHFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QCQ6g+biVVBM6Npl2UNOp32RR0HfoLPfPuJkoo3QZfTJcu/oRDw3oeMyM/0a7jSH/XC7sSmUCWKS0OAU0qzWlQuCD5bX5s8or9/n92kUx2KcW4nndUmnmfc5CQYSjOtLyyDI2Ko3wzXCvpVL7aE7ve59H5ECc5QbZZSc6Mg6nhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkRazVX5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2164b662090so59491115ad.1;
        Sat, 25 Jan 2025 07:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737817529; x=1738422329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmHCqcKVSe2u+vMhq04BScVx0bDuDwkVdXnUsq7wyog=;
        b=SkRazVX5CD3wNrF/lzlk8ozGtanWidE+9ubUguT3a1q5CBDthQQ8hppJlVuVdBr69j
         tSMFPZkFteTJ2QM1GkTM3xdwPL9+LTIFqBYNmnVE3Qb1bNJG5UaiItXXP0EDdv8jNCTS
         bdyEHyAMKUenYPZabvyD7ZNSvf6az/ZXuC63e/Bn1Y5a9aopLAKp6q+3kTgMELhmGFSF
         YUv4p1YyWK9cTyZRQ/Eqtgg3v/kBnPdDvvmBBtPgL9dSCExpPr2VIT6QQjEtWTVuQ13n
         wfsQal9eD/4eg0yRoNM+bY1KewJGt06bRrota3Zzlb6QCJzaXyhvGujyTUYpVoJcMgVk
         NGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737817529; x=1738422329;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tmHCqcKVSe2u+vMhq04BScVx0bDuDwkVdXnUsq7wyog=;
        b=OUBa/MdDkdf5iCSC7LNjMUNGdkWyhICnQkWNPrVMNarAOopEvsZLRdLXouelUMPU2N
         iOXHCag0QSXidV/mkAnMpnX1rItYDucfd8Bj/B9CFQcokYUrcZhvrAnRwdkgva8nVouc
         nNC2Y+KHDvTU/r3kI0KXoURAI5dIeGngh+Q3nYFjFFvbCapWkJwf0fxCwG9GiDhigT7F
         J3F154cX8MuHOnSMjCWdWZ2Z2wJ9exquaJYMeY5Njqkg5pfgBNvqdrHBZAdIxSFpvF/o
         Wu8h1VUKyv1DeExzqGIVrlvdj1l0NRX/Z2tlOK24crC3J1w2QdGcVvOBJUMWYThLvf7P
         jfxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdpx27JKKNKguXEDSqN7n4f+xKYDVvx79sDxz9NcswrGI90vqOAMqjH17gdZPP49IZncqUI76+3DUJnLnt@vger.kernel.org, AJvYcCXD+O1lfHtI3nJo21bgBi7QM56mzNn/m20/DtE5jdsQNwQBZK+CF6rNw0Fc2kKL6FTIP2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyjk/h3OzurVO8uuRSPGYU9JeVyB63I2XVnytA/oybFHFwN8a8
	ZjXC09Ph6lxnwHQSohCj/w1pPA5rCB7SErZKT+Fz2fhrOfhBAjpkOQH1Qg==
X-Gm-Gg: ASbGncvsaXrsz8JkmjFiUqK7b5yBB4L4vgN02bJ3DPF5RbnA3DPkQTa02QbK0e0v17A
	I+gOkH+HqHcZo8ZuRTrAJglq/jj/pgwLpSRYqizKmA276OP48o65O/Vt9tY83mANwxhOnrkpd5A
	1RMB7LiCQz93o1Z7z872mFEUG8+Q9eyK+/CskWOP2wS7bWYP8PRUyCI4nJVM+ZhNZqOmDbXm/p9
	uHWOJ+eznJvsQOIvtAL3HlP1iIVD/D6vor3F6Y0RUT3vD4BWtAzY4fGnaMfXlh8CAoYAdkkdIjm
	NQ==
X-Google-Smtp-Source: AGHT+IHJilBH8FuGxRPkzMfUJUMteOPU/B/UjUDNLxKHhYHAePnMUvEuHD8RlZG37wUkmVHRxeBDrw==
X-Received: by 2002:a05:6a20:258c:b0:1e1:a6a6:848 with SMTP id adf61e73a8af0-1eb214c7a75mr57407219637.25.1737817528785;
        Sat, 25 Jan 2025 07:05:28 -0800 (PST)
Received: from [0.0.0.0] ([5.34.218.166])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a78e3c2sm3778902b3a.169.2025.01.25.07.05.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2025 07:05:28 -0800 (PST)
Message-ID: <aedece31-5531-4ffe-9967-5906ec971cec@gmail.com>
Date: Sat, 25 Jan 2025 23:05:23 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/3] libbpf: Refactor libbpf_probe_bpf_helper
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250124144411.13468-1-chen.dylane@gmail.com>
 <20250124144411.13468-2-chen.dylane@gmail.com>
 <CAEf4BzYTGiAedD8zEmw16NQ6JWAtkwDU2rhGLGZjXL0H1iKO+g@mail.gmail.com>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <CAEf4BzYTGiAedD8zEmw16NQ6JWAtkwDU2rhGLGZjXL0H1iKO+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/1/25 02:44, Andrii Nakryiko 写道:
> On Fri, Jan 24, 2025 at 6:44 AM Tao Chen <chen.dylane@gmail.com> wrote:
>>
>> Extract the common part as probe_func_comm, which will be used in
>> both libbpf_probe_bpf_{helper, kfunc}
>>
>> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
>> ---
>>   tools/lib/bpf/libbpf_probes.c | 38 ++++++++++++++++++++++++-----------
>>   1 file changed, 26 insertions(+), 12 deletions(-)
>>
>> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
>> index 9dfbe7750f56..b73345977b4e 100644
>> --- a/tools/lib/bpf/libbpf_probes.c
>> +++ b/tools/lib/bpf/libbpf_probes.c
>> @@ -413,22 +413,20 @@ int libbpf_probe_bpf_map_type(enum bpf_map_type map_type, const void *opts)
>>          return libbpf_err(ret);
>>   }
>>
>> -int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helper_id,
>> -                           const void *opts)
>> +static int probe_func_comm(enum bpf_prog_type prog_type, struct bpf_insn insn,
>> +                          char *accepted_msgs, size_t msgs_size)
>>   {
>>          struct bpf_insn insns[] = {
>> -               BPF_EMIT_CALL((__u32)helper_id),
>> +               BPF_EXIT_INSN(),
>>                  BPF_EXIT_INSN(),
>>          };
>>          const size_t insn_cnt = ARRAY_SIZE(insns);
>> -       char buf[4096];
>> -       int ret;
>> +       int err;
>>
>> -       if (opts)
>> -               return libbpf_err(-EINVAL);
>> +       insns[0] = insn;
>>
>>          /* we can't successfully load all prog types to check for BPF helper
>> -        * support, so bail out with -EOPNOTSUPP error
>> +        * and kfunc support, so bail out with -EOPNOTSUPP error
>>           */
>>          switch (prog_type) {
>>          case BPF_PROG_TYPE_TRACING:
> 
> there isn't much logic that you will extract here besides this check
> whether program type can even be successfully loaded, so I wouldn't
> extract probe_func_comm(), but rather extract just the check:
> 
> static bool can_probe_prog_type(enum bpf_prog_type prog_type)
> {
>          /* we can't successfully load all prog types to check for BPF
> helper/kfunc
>           * support, so check this early and bail
>           */
>          switch (prog_type) {
>              ...: return false
>          default:
>              return true;
> }
> 
> 
> And just check that can_probe_prog_type() inside
> libbpf_probe_bpf_helper and libbpf_probe_bpf_kfunc
> 
> pw-bot: cr
> 

Hi Andrii,
Thank you for your review, jiri also suggested putting the insn part 
back into libbpf_bpf_probe_{helper, kfunc}, so I'll make the 
modifications as you suggested in v4.

>> @@ -440,10 +438,26 @@ int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helpe
>>                  break;
>>          }
>>
>> -       buf[0] = '\0';
>> -       ret = probe_prog_load(prog_type, insns, insn_cnt, buf, sizeof(buf));
>> -       if (ret < 0)
>> -               return libbpf_err(ret);
>> +       accepted_msgs[0] = '\0';
>> +       err = probe_prog_load(prog_type, insns, insn_cnt, accepted_msgs, msgs_size);
>> +       if (err < 0)
>> +               return libbpf_err(err);
>> +
>> +       return 0;
>> +}
>> +
>> +int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helper_id,
>> +                           const void *opts)
>> +{
>> +       char buf[4096];
>> +       int ret;
>> +
>> +       if (opts)
>> +               return libbpf_err(-EINVAL);
>> +
>> +       ret = probe_func_comm(prog_type, BPF_EMIT_CALL((__u32)helper_id), buf, sizeof(buf));
>> +       if (ret)
>> +               return ret;
>>
>>          /* If BPF verifier doesn't recognize BPF helper ID (enum bpf_func_id)
>>           * at all, it will emit something like "invalid func unknown#181".
>> --
>> 2.43.0
>>


-- 
Best Regards
Dylane Chen

