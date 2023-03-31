Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681236D2B55
	for <lists+bpf@lfdr.de>; Sat,  1 Apr 2023 00:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjCaWcQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Mar 2023 18:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjCaWcQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 18:32:16 -0400
Received: from out-12.mta0.migadu.com (out-12.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AF41F79A
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 15:32:14 -0700 (PDT)
Message-ID: <869f0a0f-0f43-73fb-a361-76009a21b81d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680301933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bGIv1h1lHRg22JUEeKs/pxFGCLDumi71RGmJRLoloP0=;
        b=WcBVrhNICazTJms7aZk/4IHknLyR1HntrZabI7Pqk+U0WGrMX0QNTDnsjTZWAaVh3TTsXd
        I1fLjfPKfmeD+/X21ED2XZRknqBYRxkoiQF54kiU92K3dOHjgGN7knG6mBhAdxdlHE40+r
        wZ1cczIZBv8Vzfyld42aBmf0pBHkmDo=
Date:   Fri, 31 Mar 2023 15:32:10 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v5 bpf-next 7/7] selftests/bpf: Test bpf_sock_destroy
Content-Language: en-US
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     bpf@vger.kernel.org, kafai@fb.com, edumazet@google.com,
        Stanislav Fomichev <sdf@google.com>
References: <20230330151758.531170-1-aditi.ghag@isovalent.com>
 <20230330151758.531170-8-aditi.ghag@isovalent.com>
 <ZCXY6mOY8pPLhdBF@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <ZCXY6mOY8pPLhdBF@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/30/23 11:46 AM, Stanislav Fomichev wrote:
>> +void test_sock_destroy(void)
>> +{
>> +    struct sock_destroy_prog *skel;
>> +    int cgroup_fd = 0;
>> +
>> +    skel = sock_destroy_prog__open_and_load();
>> +    if (!ASSERT_OK_PTR(skel, "skel_open"))
>> +        return;
>> +
>> +    cgroup_fd = test__join_cgroup("/sock_destroy");

Please run this test in its own netns also to avoid affecting other tests as 
much as possible.

>> +    if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
>> +        goto close_cgroup_fd;
>> +
>> +    skel->links.sock_connect = bpf_program__attach_cgroup(
>> +        skel->progs.sock_connect, cgroup_fd);
>> +    if (!ASSERT_OK_PTR(skel->links.sock_connect, "prog_attach"))
>> +        goto close_cgroup_fd;
>> +
>> +    if (test__start_subtest("tcp_client"))
>> +        test_tcp_client(skel);
>> +    if (test__start_subtest("tcp_server"))
>> +        test_tcp_server(skel);
>> +    if (test__start_subtest("udp_client"))
>> +        test_udp_client(skel);
>> +    if (test__start_subtest("udp_server"))
>> +        test_udp_server(skel);
>> +
>> +
>> +close_cgroup_fd:
>> +    close(cgroup_fd);
>> +    sock_destroy_prog__destroy(skel);
>> +}

