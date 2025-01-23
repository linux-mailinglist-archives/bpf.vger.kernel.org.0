Return-Path: <bpf+bounces-49572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5F4A1A156
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 10:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3393E7A2D3F
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 09:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF3720D514;
	Thu, 23 Jan 2025 09:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SH08KGr/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B89F20D4E8;
	Thu, 23 Jan 2025 09:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737626297; cv=none; b=IqZ98ACgmsqVSmqr3DdWTkIf8YAKfhW5aEXyzjaN9n9Fa3n9GE9mh7fVQ4KEwvmT77xpnLmefhigQ172G48UX+6pPcZnaKOfSl1Ovo0qwd2x2X3MQSfvmwz5b4ABt+pR1Pxy7jKi1nmHKUVAdHQP4xmSv7x0mQh3l7bHCvyWkqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737626297; c=relaxed/simple;
	bh=48/WAXQxl3Ff4TG7sXdI+8kViWQ6eEm678vBkrR0QUI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M2wHcXPoTwlB34XmdopFk8rnxLZmSCl7OlcnkSNr+b2lmJHPLw2icfP5ir0bODDivLTo2fb9LaWFRN1lUtUYsrzI0eUuKg7iXlBVn2QPM9Rh2ZGod5C+WVCdZQjMmaP0VcX5voXtdE4ZuBDbozMddCuCPbg5o2N/hLoQen13TjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SH08KGr/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-216426b0865so10150245ad.0;
        Thu, 23 Jan 2025 01:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737626294; x=1738231094; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sMixnzrCeUhH0J93VrrAb50HrLeJ512qgAxsc1Vxqf4=;
        b=SH08KGr/xzrZw+AB1RVggTpckTH7KTteMe+3ZRIvn466l+0XmUEykOryZ/tIbSaH8s
         TYul6jp2YVIJdlRAqwBmSwoi3ZZUQXnG4rmTdpzGk0wEcI0rVJNR6fY7wEbBgGLqiOKY
         igWKQYF+pFj6SMZU00rYuvByCAmT1qn+uIAa5tdHvkwcR/Ete4yxX5jbSTviA2YhCNuO
         bEa6gprkjoixJuDq9owZ7dUQNBzmtLDFWwfvKOqV2Zl1YmIGFY6dw//TRLati6GYQPGe
         pPy3MQYcBrkYPyF+8byIP63BYRHzRiWCUIhGXtuzxEnU2LzIT999r4ek7KYxKqH57UMJ
         i2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737626294; x=1738231094;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sMixnzrCeUhH0J93VrrAb50HrLeJ512qgAxsc1Vxqf4=;
        b=P5v08gBpTN4CHNTW6Eqvo5F9jVI9y9QRQWyIV/J4seytBMRSx25fhGcKHWibXgwYtX
         A3ihrLKygBeI21fTdDDMZlHqdhVFvCkIo3pjdhBOTu0JLr04p1SwveRcKbmfwUhVXAeH
         c2IukxkxeESIYyKO55c0FM64/FSxDdQPqjrArEUWwQQOcXReD99IIgLzfwrNPs8BhXgU
         iB62uWaqGy/l389CaUCgCTEE8DN2W/Ay5BaDIZakVKfsrqtA0UEvSbFSxla0pxNuOKeG
         ByafddJFvA6E9Wa3VHqtNC3FKQrwTeuwlV7H4xZ5DqScDA+QO/H/7IOUSu9Eq1cVH9ez
         OT/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWef40XPa/VeFrRmI4AohKFVFEjW1DRITUALEPmE6+FoH2lSK/IPrYVEhlQPaPW3dssi/PJYsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YylghZ2FG14ZkLNTOE3fmYQeg1hfRNifnrceUSBjnjGUCW/ZRmN
	1DVB3A0GWufPQIJbRCJF4wFRZSisVVBpmHsDytTLvCkCGMWlFwsx
X-Gm-Gg: ASbGnctaEqRdK+k2hR9k5WyO0KJAFlG+CKvRO98y6cw152nC3WCOqsT9gjAOWxjVaeD
	Q1Oeq1MK0sR/nrlwmoVIZOJJpHfYkEiE9EI0T5pfaWBzJ5Euz5nsjhAYIbI78Qy9Wcihi+pKTW1
	ka80Ot3xkehVBVTjVPdeR4vhqXUhKKzoozqyCnyHQTrKk2oe7kaHtb6/8KfbhmVdnxyLr3iEUdC
	b0FSh3JH4Ljs0RWZwDs5l+jIp9H9dhwAfpYI203rPW6g+8utJHvpRh3SZ1UGDHDlMx1D/eAtwlM
	eQ==
X-Google-Smtp-Source: AGHT+IH6C91rNsLLDPdqIObKr6CDBFjfOZVoyyD6ArJTULRsKtFGhS4xvwnBKY3uMrHgPJ9T35AUyQ==
X-Received: by 2002:a17:902:e802:b0:215:827e:3a6 with SMTP id d9443c01a7336-21c355ba38amr418284225ad.40.1737626294446;
        Thu, 23 Jan 2025 01:58:14 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d43252bsm108630795ad.258.2025.01.23.01.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 01:58:14 -0800 (PST)
Message-ID: <63ef4167a39a33cdc72fa8e920d39a1a66e158f6.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 04/14] selftests/bpf: Test returning
 referenced kptr from struct_ops programs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	alexei.starovoitov@gmail.com, martin.lau@kernel.org, sinquersw@gmail.com, 
	toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, stfomichev@gmail.com, 
	ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn, 
	xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com, amery.hung@bytedance.com
Date: Thu, 23 Jan 2025 01:58:09 -0800
In-Reply-To: <20241220195619.2022866-5-amery.hung@gmail.com>
References: <20241220195619.2022866-1-amery.hung@gmail.com>
		 <20241220195619.2022866-5-amery.hung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-12-20 at 11:55 -0800, Amery Hung wrote:

[...]

> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fai=
l__local_kptr.c b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_=
fail__local_kptr.c
> new file mode 100644
> index 000000000000..b8b4f05c3d7f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__loca=
l_kptr.c
> @@ -0,0 +1,34 @@
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +#include "../test_kmods/bpf_testmod.h"
> +#include "bpf_experimental.h"
> +#include "bpf_misc.h"
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +struct cgroup *bpf_cgroup_acquire(struct cgroup *p) __ksym;
> +void bpf_task_release(struct task_struct *p) __ksym;
> +
> +/* This test struct_ops BPF programs returning referenced kptr. The veri=
fier should
> + * reject programs returning a local kptr.
> + */
> +SEC("struct_ops/test_return_ref_kptr")
> +__failure __msg("At program exit the register R0 is not a known value (p=
tr_or_null_)")
> +struct task_struct *BPF_PROG(kptr_return_fail__local_kptr, int dummy,
> +			     struct task_struct *task, struct cgroup *cgrp)
> +{
> +	struct task_struct *t;
> +
> +	bpf_task_release(task);
> +
> +	t =3D bpf_obj_new(typeof(*task));

The return type (and btf id) of the bpf_obj_new is 'void *',
but here a function with return type (and btf id) of
'struct task_struct *' is necessary.
For example:

-       t =3D bpf_obj_new(typeof(*task));
+       t =3D bpf_task_from_pid(32);

However, if this replacement is done the test does
not signal verification error because of insufficient
checks in the verifier.c:check_return_code().

> +	if (!t)
> +		return NULL;
> +
> +	return t;
> +}
> +
> +SEC(".struct_ops.link")
> +struct bpf_testmod_ops testmod_kptr_return =3D {
> +	.test_return_ref_kptr =3D (void *)kptr_return_fail__local_kptr,
> +};

[...]


