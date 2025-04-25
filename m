Return-Path: <bpf+bounces-56724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 460B3A9D2F2
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 22:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 825F117FFB3
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 20:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9721E221DB7;
	Fri, 25 Apr 2025 20:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jcz0NOyn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9C6221D90;
	Fri, 25 Apr 2025 20:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745612713; cv=none; b=COiGTlobh+6tqowKlhKA1dPrZrE5+nWeyZZJdoK7HcgTUreK+//8sZSRsjnGKRJiv/OHDsFtnPggLYWTs2YUJyUPFM/8CUgQcE2cWQfiNQyO77PlOD0yk1H7+rnyiiW0Hbb2+BNjJo2eM4WUttvjgaMNfqyGgz4Y6UVQ2LBHQcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745612713; c=relaxed/simple;
	bh=WI56wBCFrgCNGt+Jofg8SqnoiQgGyo6Y4uPQoA0/X/c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BV9u7iTf310SrStv9LMldEbQrSxPDSriqOBZ6JEt7uyTi+KyzbdEhhWhypekqzEnxFDtsR887REDzcVHFf1s39cwATMvE6IAVObocv2AjmY9Lli3jJu2gpCEkHldZZIGtWtowhPsBi7gbw3iAYxNg5fQuX7G2XLGho8KLWuiXg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jcz0NOyn; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7376dd56f8fso3713745b3a.2;
        Fri, 25 Apr 2025 13:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745612711; x=1746217511; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hfWsYG1r6NlxzswwkuuUIMt8W7t8e00tL741A9SbqYg=;
        b=Jcz0NOynRcHJ0kLbxNaMYi3y8LaJq5IvePOn0e2DM1sD5w/YKNb8FbrGCKXurk8ijJ
         fV4dO27F8xt5YxKyAWTyqnpY4E0KqQxDfpiLl9++yq7owV1T02fvitU5NrYsF3s1ofME
         lxhopY8atb4cBoLwXgABuXngLijqKMtCfpMz7KtlB0cOtqmBv9yHjrTjUtmt3Q8w+RwD
         6Xd01NDq7cOJ6SdxFFLIP1KBXsHsPVHmPs98KtCdTc+GY97t7pVeKjrs97chqjqvWylz
         CkPJ4Ui+MpOH/WP17JgIhf8I2zNDviscSuaLWjw+xl3NhQOWmd2WyJ4sAdq6VnVGmwiS
         Nmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745612711; x=1746217511;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfWsYG1r6NlxzswwkuuUIMt8W7t8e00tL741A9SbqYg=;
        b=hOcjXGObDdpwNxHATK0HSia1+hk2Y4i6MjcpxJjD7y12ORTfcmG0kuIkfve5jJ01Y3
         6QR8nRUsIxx5/LYH/FAMHD3j1EZwjyOdVw3Q9mThbzusK6Bsliq7AlPLlYk2VW42f9Qv
         qJPreVG2UI3I8MOYuCtsXCWm9Yww8K8aretzK7DNr6dDjBZ+ppDfg7myetDkvN1escWZ
         DHOtZkvWFWUHjz1WVr1h2+00SBwpvPZbo8VddekEsnucaK8wYFAtNGlS6fqMJ2p+Xmf5
         YTG18f6A1ubdtGAamVKgGyyQNpdY0WvOnGXyq1W3D01ls997ZbiBsQ21mbnkIZ3478lz
         Z39g==
X-Forwarded-Encrypted: i=1; AJvYcCWTvByWPUskTUNX9gAqgJ2cyMdHiz5tf6mQFW0S5tzpQ4XGPn7OJcdkgx3AmfckIxVsSoVhslRlKA==@vger.kernel.org, AJvYcCXlNe1LThzECKxWitM1AP8TAHf2vOQamK0k4Rgok131Tm6vQKkpkB2bw9s/sNDmPEFAE54=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFFbsPmgiJPERKWGpBIZnPZ1ymgR1TYjtVUpwRgINFiA6jrawS
	ZQC8igdz39QGO1lB6cnoBLAFeubD6MfvnmWEEhGaNWq+fOplheKT
X-Gm-Gg: ASbGnctQC1LbC5uSiBHc79cQXnzlA2fuXxFzINjr5D775dYro3SNNZRAphCoaUndHsE
	CKzeM+z/NG7SvRklrLqFd+M+0DkD8qsqdligJWsG3FphOk8XqtZ0dRAfPlGfp+dl0TFk3JabZDf
	AkkLjFURtpocgcvckf0wsHT7toVhadjAsZuj0jDQOPamy94MjGlNzukD6pQ1Sj0PSFLj9v38kQz
	W59nfx/ZykWlzDwC70rV48bwERRMLBaL9rXCXQX4q8uRsfiQ9YVpFYFgtHbbGKmwI7UjXtqytJ8
	Vtabny739xTiAeVbgwY2EFJW/cCDpn3o8QSHfVPmHPDEKRvtKQ==
X-Google-Smtp-Source: AGHT+IGvUjYWEqIo6gsDIkY1u8K6e15Hao48YNLmiveZMyTHp6jjp9Afvtq7AXTt6Uux7FM07KupMg==
X-Received: by 2002:a05:6a00:a8b:b0:73d:b1ff:c758 with SMTP id d2e1a72fcca58-73fd89776a2mr4767972b3a.18.1745612710916;
        Fri, 25 Apr 2025 13:25:10 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::5:5728])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25967aedsm3586334b3a.83.2025.04.25.13.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 13:25:10 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,  Arnaldo Carvalho de Melo
 <acme@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>,  Ihor Solodrai
 <ihor.solodrai@linux.dev>,  bpf <bpf@vger.kernel.org>,
  dwarves@vger.kernel.org,  Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: pahole and gcc-14 issues
In-Reply-To: <CAADnVQJQuAkmE_D_ATp-hZeTtUK4Tn=BOOOx+wPtUB1QpzeQuA@mail.gmail.com>
	(Alexei Starovoitov's message of "Fri, 25 Apr 2025 13:16:10 -0700")
References: <CAADnVQL+-LiJGXwxD3jEUrOonO-fX0SZC8496dVzUXvfkB7gYQ@mail.gmail.com>
	<m2v7qsglbx.fsf@gmail.com> <m2h62cgh7y.fsf@gmail.com>
	<CAADnVQJQuAkmE_D_ATp-hZeTtUK4Tn=BOOOx+wPtUB1QpzeQuA@mail.gmail.com>
Date: Fri, 25 Apr 2025 13:25:08 -0700
Message-ID: <m2r01gf0pn.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

[...]

>> $ diff -pruN ~/tmp/task_struct.ko.c ~/tmp/task_struct.vmlinux.c
>> --- /home/ezingerman/tmp/task_struct.ko.c       2025-04-25 12:37:48.312480603 -0700
>> +++ /home/ezingerman/tmp/task_struct.vmlinux.c  2025-04-25 12:38:03.096644654 -0700
>> @@ -18,7 +18,6 @@ struct task_struct {
>>         int static_prio;
>>         int normal_prio;
>>         unsigned int rt_priority;
>> -       long: 0;
>>         struct sched_entity se;
>
> I reproed this issue with default .ko build that includes:
> --btf_features=distilled_base
>
> Once I disabled it and did
> bpftool btf dump file ./bpf_testmod.ko --base-btf .../vmlinux format c
> the task_struct from vmlinux.h and from testmod.h became exactly the same.
> So it sounds like the 3rd issue :)
> bpftool dump of distilled btf needs work.

Mystery upon mystery.
Here is a continuation of the last one.
This is raw BTF for .ko:

  [509] STRUCT 'task_struct' size=10496 vlen=268
          ...
          'rt_priority' type_id=3 bits_offset=960
          ...

And this is raw BTF for vmlinux:

  [1] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
  [2] CONST '(anon)' type_id=1
  [3] VOLATILE '(anon)' type_id=2
  ...
  [9] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)
  ...
  [111] STRUCT 'task_struct' size=10496 vlen=268
          ...
          'rt_priority' type_id=9 bits_offset=960
          ...

Note type conflict 'volatile const long' vs 'unsigned int'.
Either something is very broken or I completely messed up the build.

