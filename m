Return-Path: <bpf+bounces-15721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D704A7F551C
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 01:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DDE528165D
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 00:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A77D646;
	Thu, 23 Nov 2023 00:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9U+dv4P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A2111F
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 16:01:00 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5cd2f1a198cso1686157b3.0
        for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 16:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700697659; x=1701302459; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jwhHrNx2Gf/AYIN9qHxb4WvH2MmH7wHGQIqSrD496ok=;
        b=C9U+dv4PfuH3y4TfQqSVQgTwbgGIhNlg+3Orw+HRhk8uKOmMjdoZ0i/Fon8zQBB3zK
         dg2Q0RCZH/fLphkCvpz2g++OiuIpQvViG5ygtRCGt3pL8pa39cBGgJcfBMWtQuDizCcQ
         cGylIujFJ87JnfFZxjmpJfq4JKGdGbIKT1LzTkFRKnGr/V850cDUlU4tpltbSN7hHZua
         en4RsH0MyEZYRkc7rephg+9hi2rfUmHdCXcDO1fGYedJ5J3tpx0Xs2RxEO8sOa9cb9P5
         6Oy+MZ1a/flvkWF7yJ1GCtc9Cp3Bhwj2pACjEKqOa6wjSXi+Nkp7w0gKPVE9L79OSqo9
         rdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700697659; x=1701302459;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jwhHrNx2Gf/AYIN9qHxb4WvH2MmH7wHGQIqSrD496ok=;
        b=eVyAfMJK6E8BvaS9hnIhUnC47Wb9OS8v3IlfKJ+llPAGp70jI6uWEK1V1SOQtmiSZC
         6ETlERDvfhTXF2AGPjo/7N73XAbpqTpnDMe5m8XGpVIFEfye+8mGeL46OZTgJt2iNxvc
         g1xB6ftA8uK6Oxa/uTPKF0EgwdY/6Vpns0+YiIS2fkwU9bFv8LS+dAVSoc8WlDdW+Kt7
         d2zkRZAOQaAdGbGR8Drag/uNfT4oV+FZzr3pW+r66lOmZlf0LYf9i3Wh+am8GkGeCyDd
         K3nA9z2rn2iI1FJqs2ZElS4fg4rVv6otyeTYJ4eF9wKRvaa9Y/ut9p7t9ZBeN6Km7lo5
         KcSQ==
X-Gm-Message-State: AOJu0YzETFHcRuzDvjgUUwagiZM53VVhev+Q3P6k7ccMZLf8EgTecaig
	f38gr6TnfUYubUo1xxbCxmk=
X-Google-Smtp-Source: AGHT+IEvkRk1vgyzVfA+w+jfHtjzS4ef/pmb8hc2Wv75tMGiAadwRxVR6SFQZOEkPgn2MGE18YFm4w==
X-Received: by 2002:a0d:fb42:0:b0:5ca:a8b6:3319 with SMTP id l63-20020a0dfb42000000b005caa8b63319mr3079128ywf.52.1700697659470;
        Wed, 22 Nov 2023 16:00:59 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:5a79:4034:522e:2b90? ([2600:1700:6cf8:1240:5a79:4034:522e:2b90])
        by smtp.gmail.com with ESMTPSA id y134-20020a81a18c000000b0057a918d6644sm51480ywg.128.2023.11.22.16.00.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 16:00:59 -0800 (PST)
Message-ID: <0fc820bb-48c3-4dd8-8aa2-8d206801ab62@gmail.com>
Date: Wed, 22 Nov 2023 16:00:58 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v11 13/13] selftests/bpf: test case for
 register_bpf_struct_ops().
Content-Language: en-US
To: Hou Tao <houtao@huaweicloud.com>, thinker.li@gmail.com,
 bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
Cc: kuifeng@meta.com
References: <20231106201252.1568931-1-thinker.li@gmail.com>
 <20231106201252.1568931-14-thinker.li@gmail.com>
 <e9360742-57db-9f40-6227-d15db29ee25f@huaweicloud.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <e9360742-57db-9f40-6227-d15db29ee25f@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/17/23 02:45, Hou Tao wrote:
> Hi,
> 
> On 11/7/2023 4:12 AM, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> Create a new struct_ops type called bpf_testmod_ops within the bpf_testmod
>> module. When a struct_ops object is registered, the bpf_testmod module will
>> invoke test_2 from the module.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> SNIP
>> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
>> new file mode 100644
>> index 000000000000..49f4a4460642
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
>> @@ -0,0 +1,144 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
>> +#include <test_progs.h>
>> +#include <time.h>
>> +
>> +#include "rcu_tasks_trace_gp.skel.h"
> 
> It is no needed anymore. It seems it is a leftover from last revision.
> 
You are right! I will clean it up.

