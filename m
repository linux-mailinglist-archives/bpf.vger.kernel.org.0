Return-Path: <bpf+bounces-42167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C4F9A0438
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 10:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0819D1C25246
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 08:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142961D8DE0;
	Wed, 16 Oct 2024 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Z1RhusA6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E03F1D8E09
	for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067321; cv=none; b=H+xMx1zh/hirPKqAQE9TlNvYk+vIBqZ2+1blzK+nU9h/rhoHJgU6MdZXRSaOy31yCJRBw/jz7BECMr2yb9BiEFCRVp8bnYcmxTjm6hih41HvNJy7HvjY3OmEAGt5oszF4+LQ2reZEU11U79hqrN+tnsFwW1nkAqZQdDvkmC+0qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067321; c=relaxed/simple;
	bh=iIIpJpeakjeQ6MiJ397fq0GNk4HO6z5XH6bDjYColuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T31FwQSPcZlK+AnSueY+cjwzkXZRclx9lVI/LKW0VUOvLO08Yz4Ij75OaHTbIBfyy7JNowo6jFt9O7Ca/2FoWJ4e3Jbgq2YfpE1is2OUc9yFTs8qAee3YI5ft3JsdwFlFPp2uSPCqfrSQSaBWMiil3XIVNUrJTLMNcJkkqbsQUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Z1RhusA6; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e30db524c2so3112767a91.1
        for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 01:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729067319; x=1729672119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oK3r7JDohs2krUXNPNKZVE3HoJ9iGwZ4bW7axF6Bd2E=;
        b=Z1RhusA6yMd4Cf/CNCgHL8c1rwUhirYGP8mylTXd6V4w4JVbKLdbD4sIm1ZzYijL/L
         9AZ39ZpST2dzhPwczO/bvIJYMnmp0sdg1gLUWcspKXFRDiy3g/dPjageFg9332ndOJXT
         q4UT9Ln7Km2ggwvSbNwZ6DgN/W/Sb15RjT0JwpTA8q35sbUFxv9EetgT0noAjrPz72qx
         zL9xziL1rAlwWk7VJjn+KcqU9FyMnxW3dp9QELs8JwczYtGiC+J6e17Gvblufw9Pojm6
         vI4ZqbGRSjSmOUp1rkmbHHgKpnOkhHscjjldo55SEZ5HOFzZ9welxBbI+ThJzJriyVvg
         3H8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729067319; x=1729672119;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oK3r7JDohs2krUXNPNKZVE3HoJ9iGwZ4bW7axF6Bd2E=;
        b=m354HrwAZSclg2fRaGK2KrMhfbI+3OLr5/RmPTYf7OH/3g3QRvbou5QMaOJwTbU4XI
         KC4WPV897MNJH7eEA1hMDtE8O3BKzc+b0HIR2F/wk2jK6OPNkvY2kbdSHsmwgzfUlSAx
         Owwkv9zEvIsQVPSBeoFQyQ/In9FNVmY+0rbhuXQgPEYRsGDQVMzYJpzYStvKybOx96y9
         wrhhAv3whuyysuGucNeBQcvnPIwTMw54E49WmMq7XbZgCAGJa2lYfxoAji8/NKSYSjD7
         eAyiuqPpUeFIqKZbedbQ1O24qzRJlAEmoe+n7LC0J8vBRcEzRXpPflgqsTsgrB8NtcZY
         QoAw==
X-Forwarded-Encrypted: i=1; AJvYcCUZomYGOhHQ0XKkya6oCcSRcgLYAUHfyNuQ1v85MZsgEV7lxxuq1cf31dFO+pvAebcI8XQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyATVhoyS+J4sSr8oPNdKlWIjzfmtv/5D3jQovnEUoUdqyt4TEq
	puGzk+ejDu+XKdCMslnPbL/NY4gb4JMFcmg7jF9u3eucLf+PCrNTsMYBYjpoaxg=
X-Google-Smtp-Source: AGHT+IGEYNpbSXS9A+lWMLTCRUXwyBdU2dEOqJc7naNeVS68q5VEhcTwcma4YJ+YWUY64K/Zzj3UfQ==
X-Received: by 2002:a17:90a:b398:b0:2e2:eac6:6c05 with SMTP id 98e67ed59e1d1-2e3151b4176mr18983487a91.4.1729067318995;
        Wed, 16 Oct 2024 01:28:38 -0700 (PDT)
Received: from [10.68.122.241] ([203.208.167.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e392ed3b28sm3516764a91.19.2024.10.16.01.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 01:28:38 -0700 (PDT)
Message-ID: <5969d1ca-688b-4a27-9e39-dc9f89381d40@bytedance.com>
Date: Wed, 16 Oct 2024 16:28:27 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH bpf-next v2 2/2] bpf, selftests: Add test
 case for cgroup skb to get net_cls classid helpers
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, ast@kernel.org,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mykolal@fb.com,
 shuah@kernel.org, geliang@kernel.org, laoar.shao@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
References: <20240918074516.5697-1-zhoufeng.zf@bytedance.com>
 <20240918074516.5697-3-zhoufeng.zf@bytedance.com>
 <075e314c-3aa5-4f7b-81f7-3bc0e055334a@linux.dev>
From: Feng Zhou <zhoufeng.zf@bytedance.com>
In-Reply-To: <075e314c-3aa5-4f7b-81f7-3bc0e055334a@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2024/10/1 09:58, Martin KaFai Lau 写道:
> On 9/18/24 12:45 AM, Feng zhou wrote:
>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>>
>> This patch adds a test for cgroup skb to get classid.
>>
>> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
>> ---
>>   .../bpf/prog_tests/cg_skb_get_classid.c       | 87 +++++++++++++++++++
>>   .../selftests/bpf/progs/cg_skb_get_classid.c  | 19 ++++
>>   2 files changed, 106 insertions(+)
>>   create mode 100644 
>> tools/testing/selftests/bpf/prog_tests/cg_skb_get_classid.c
>>   create mode 100644 
>> tools/testing/selftests/bpf/progs/cg_skb_get_classid.c
>>
>> diff --git 
>> a/tools/testing/selftests/bpf/prog_tests/cg_skb_get_classid.c 
>> b/tools/testing/selftests/bpf/prog_tests/cg_skb_get_classid.c
>> new file mode 100644
>> index 000000000000..13a5943c387d
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/cg_skb_get_classid.c
>> @@ -0,0 +1,87 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +
>> +/*
>> + * Copyright 2024 Bytedance.
>> + */
>> +
>> +#include <test_progs.h>
>> +
>> +#include "cg_skb_get_classid.skel.h"
>> +
>> +#include "cgroup_helpers.h"
>> +#include "network_helpers.h"
>> +
>> +static int run_test(int cgroup_fd, int server_fd)
>> +{
>> +    struct cg_skb_get_classid *skel;
>> +    int fd, err = 0;
>> +
>> +    skel = cg_skb_get_classid__open_and_load();
>> +    if (!ASSERT_OK_PTR(skel, "skel_open"))
>> +        return -1;
>> +
>> +    skel->links.cg_skb_classid =
>> +        bpf_program__attach_cgroup(skel->progs.cg_skb_classid,
>> +                       cgroup_fd);
>> +    if (!ASSERT_OK_PTR(skel->links.cg_skb_classid, "prog_attach")) {
>> +        err = -1;
>> +        goto out;
>> +    }
>> +
>> +    if (!ASSERT_OK(join_classid(), "join_classid")) {
>> +        err = -1;
>> +        goto out;
>> +    }
>> +
>> +    errno = 0;
>> +    fd = connect_to_fd_opts(server_fd, NULL);
>> +    if (fd >= 0) {
>> +        if (skel->bss->classid != getpid()) {
>> +            log_err("Get unexpected classid");
>> +            err = -1;
>> +        }
>> +
>> +        close(fd);
>> +    } else {
>> +        log_err("Unexpected errno from connect to server");
>> +        err = -1;
>> +    }
>> +out:
>> +    cg_skb_get_classid__destroy(skel);
>> +    return err;
>> +}
>> +
>> +void test_cg_skb_get_classid(void)
>> +{
>> +    struct network_helper_opts opts = {};
>> +    int server_fd, client_fd, cgroup_fd;
>> +    static const int port = 60120;
> 
> Running a test with a specific port without netns could fail when 
> test_progs is run in parallel (-j). e.g. cgroup_v1v2 is using the same 
> port.
> 
>> +
>> +    /* Step 1: Check base connectivity works without any BPF. */
>> +    server_fd = start_server(AF_INET, SOCK_STREAM, NULL, port, 0);
>> +    if (!ASSERT_GE(server_fd, 0, "server_fd"))
>> +        return;
>> +    client_fd = connect_to_fd_opts(server_fd, &opts);
>> +    if (!ASSERT_GE(client_fd, 0, "client_fd")) {
>> +        close(server_fd);
>> +        return;
>> +    }
>> +    close(client_fd);
>> +    close(server_fd);
> 
> imo, this connection pre-test is unnecessary. I would remove it.
> 
>> +
>> +    /* Step 2: Check BPF prog attached to cgroups. */
>> +    cgroup_fd = test__join_cgroup("/cg_skb_get_classid");
>> +    if (!ASSERT_GE(cgroup_fd, 0, "cgroup_fd"))
>> +        return;
>> +    server_fd = start_server(AF_INET, SOCK_STREAM, NULL, port, 0);
>> +    if (!ASSERT_GE(server_fd, 0, "server_fd")) {
>> +        close(cgroup_fd);
>> +        return;
>> +    }
>> +    setup_classid_environment();
>> +    set_classid();
>> +    ASSERT_OK(run_test(cgroup_fd, server_fd), "cg_skb_get_classid");
> 
> Please run this test under a netns and without specifying a particular 
> port. connect_to_fd_opts will figure out the port used in server_fd.
> 
> Patch 1 lgtm.
> 
> Please add a few words to the cover letter also.
> 
> pw-bot: cr

Sorry for taking so long to reply.

Will do, thanks.



