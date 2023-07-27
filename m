Return-Path: <bpf+bounces-6095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22615765A73
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 19:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0455282443
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 17:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55012715B;
	Thu, 27 Jul 2023 17:36:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DDF27149
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 17:36:13 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C2430E1
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 10:36:10 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-316feb137a7so1266157f8f.1
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 10:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1690479369; x=1691084169;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nZEdmXcGRVAYlxfEgnvOAfccfUnHNgUdBg+5krTA/eo=;
        b=140/ZYZn5bDqKWf+wtgvTuFeQqiCVUSA/6Q5OO7O0WeKyYsRVQMbnTuopDsK2fxe2p
         KLlyVMs5Zmtc/7UktSC3SpLCTEW/vdXLPvuFm5rxdQWHlUPJHFGUA+7+xXdsKl6AGPdj
         q4OJM/afLGrRgpOns2Z/bywNyao9qTe3Zm2kedU5th8Vzt5qv9z24IG8JI6LARbKoSy8
         Z7/LpOQafS6os04kr+lECyuqzVDEzbnEFVJAe9gqo9niWc6n57MhGFUkvDlErwhQLKCH
         1ZkrfgVwdaxa851gtWNyCHRnGJ/xZNu462YAT+niCH1guBT2WAIPvzkldt6z8Xt3eEnB
         pLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690479369; x=1691084169;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nZEdmXcGRVAYlxfEgnvOAfccfUnHNgUdBg+5krTA/eo=;
        b=BWiqdZvOpkdDYEbmDticCa8LbkMKe7trI2tp/dcbPewKnexNUxTUQunvjT/ARZysT1
         CoNq9MALGbRmj2SHH8MwToR4MeY/ltm0Va/DwAuMLJhUtNrWrlNDoQgNxOgf6ZkjdZsj
         BSMiEA68y8ALkd97quz+smrIn60GKXrCJciWrZ5WHktBjticZOcqDP/7b3xZ0zAD5cI2
         XgNyy8Q0fbb8uWbU8l1fv41EiLaXocK+Oqm25MV7hzrZgZpOD+YYLjbImeqQBv/HtV81
         w3uxSHxal2uwDZyfARZt+OzH9sTdT1nE10D20l9sNqtdnrv97uA6DHxjSFYAGMF6JCCX
         y/YA==
X-Gm-Message-State: ABy/qLYP3t0HN2EtHzv5YtNsEy9zxwKxwhyS0elA7vKCUSdSOkQkMC7G
	afM8rm/vEwr/rpFqH7wPAMfPHrlCveTMqxowkVD0wQ==
X-Google-Smtp-Source: APBJJlGMk1Xbashk7NwJvWkofxfajDTbQ+0ipK5s7hbscVG6QYWNuqzGkgAhhPffQxv2ODQ5lOiWAw==
X-Received: by 2002:a5d:45d2:0:b0:313:fe1b:f441 with SMTP id b18-20020a5d45d2000000b00313fe1bf441mr2253468wrs.29.1690479368727;
        Thu, 27 Jul 2023 10:36:08 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:e411:185b:7f55:ef18? ([2a02:578:8593:1200:e411:185b:7f55:ef18])
        by smtp.gmail.com with ESMTPSA id b10-20020a5d4b8a000000b003175f00e555sm2560128wrt.97.2023.07.27.10.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 10:36:08 -0700 (PDT)
Message-ID: <b41babb1-f0f2-dc2f-c2e3-1870107fbd9f@tessares.net>
Date: Thu, 27 Jul 2023 19:36:06 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC bpf-next v5] bpf: Force to MPTCP
Content-Language: en-GB
To: Paul Moore <paul@paul-moore.com>, Geliang Tang <geliang.tang@suse.com>,
 Stanislav Fomichev <sdf@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <3076188eb88cca9151a2d12b50ba1e870b11ce09.1689693294.git.geliang.tang@suse.com>
 <CAHC9VhS_LKdkEmm5_J5y34RpaRcTbg8==fpz8pMThDCjF6nYtQ@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CAHC9VhS_LKdkEmm5_J5y34RpaRcTbg8==fpz8pMThDCjF6nYtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Paul, Stanislav,

On 18/07/2023 18:14, Paul Moore wrote:
> On Tue, Jul 18, 2023 at 11:21 AM Geliang Tang <geliang.tang@suse.com> wrote:
>>
>> As is described in the "How to use MPTCP?" section in MPTCP wiki [1]:
>>
>> "Your app can create sockets with IPPROTO_MPTCP as the proto:
>> ( socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP); ). Legacy apps can be
>> forced to create and use MPTCP sockets instead of TCP ones via the
>> mptcpize command bundled with the mptcpd daemon."
>>
>> But the mptcpize (LD_PRELOAD technique) command has some limitations
>> [2]:
>>
>>  - it doesn't work if the application is not using libc (e.g. GoLang
>> apps)
>>  - in some envs, it might not be easy to set env vars / change the way
>> apps are launched, e.g. on Android
>>  - mptcpize needs to be launched with all apps that want MPTCP: we could
>> have more control from BPF to enable MPTCP only for some apps or all the
>> ones of a netns or a cgroup, etc.
>>  - it is not in BPF, we cannot talk about it at netdev conf.
>>
>> So this patchset attempts to use BPF to implement functions similer to
>> mptcpize.
>>
>> The main idea is add a hook in sys_socket() to change the protocol id
>> from IPPROTO_TCP (or 0) to IPPROTO_MPTCP.
>>
>> [1]
>> https://github.com/multipath-tcp/mptcp_net-next/wiki
>> [2]
>> https://github.com/multipath-tcp/mptcp_net-next/issues/79
>>
>> v5:
>>  - add bpf_mptcpify helper.
>>
>> v4:
>>  - use lsm_cgroup/socket_create
>>
>> v3:
>>  - patch 8: char cmd[128]; -> char cmd[256];
>>
>> v2:
>>  - Fix build selftests errors reported by CI
>>
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/79
>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>> ---
>>  include/linux/bpf.h                           |   1 +
>>  include/linux/lsm_hook_defs.h                 |   2 +-
>>  include/linux/security.h                      |   6 +-
>>  include/uapi/linux/bpf.h                      |   7 +
>>  kernel/bpf/bpf_lsm.c                          |   2 +
>>  net/mptcp/bpf.c                               |  20 +++
>>  net/socket.c                                  |   4 +-
>>  security/apparmor/lsm.c                       |   8 +-
>>  security/security.c                           |   2 +-
>>  security/selinux/hooks.c                      |   6 +-
>>  tools/include/uapi/linux/bpf.h                |   7 +
>>  .../testing/selftests/bpf/prog_tests/mptcp.c  | 128 ++++++++++++++++--
>>  tools/testing/selftests/bpf/progs/mptcpify.c  |  17 +++
>>  13 files changed, 187 insertions(+), 23 deletions(-)
>>  create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c
> 
> ...
> 
>> diff --git a/security/security.c b/security/security.c
>> index b720424ca37d..bbebcddce420 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -4078,7 +4078,7 @@ EXPORT_SYMBOL(security_unix_may_send);
>>   *
>>   * Return: Returns 0 if permission is granted.
>>   */
>> -int security_socket_create(int family, int type, int protocol, int kern)
>> +int security_socket_create(int *family, int *type, int *protocol, int kern)
>>  {
>>         return call_int_hook(socket_create, 0, family, type, protocol, kern);
>>  }
> 
> Using the LSM to change the protocol family is not something we want
> to allow.  I'm sorry, but you will need to take a different approach.

@Paul: Thank you for your feedback. It makes sense and I understand.

@Stanislav: Despite the fact the implementation was smaller and reusing
more code, it looks like we cannot go in the direction you suggested. Do
you think what Geliang suggested before in his v3 [1] can be accepted?

(Note that the v3 is the same as the v1, only some fixes in the selftests.)

Cheers,
Matt

[1] https://lore.kernel.org/r/cover.1688631200.git.geliang.tang@suse.com
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

