Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CD04CC408
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 18:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiCCRgK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Mar 2022 12:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiCCRgJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 12:36:09 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D835031922
        for <bpf@vger.kernel.org>; Thu,  3 Mar 2022 09:35:22 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id i11so9801257lfu.3
        for <bpf@vger.kernel.org>; Thu, 03 Mar 2022 09:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=gJO9t+nw81mCakkJU4rcitth7kTwFygbrgST2tWJ3Vo=;
        b=qyoVlFBomloAoUn1xlqx5IqE4FsUTuCVy8zHzcuJ6wcDz2/Xvarcsb0GQF5O5/xLF5
         LZArGmIjj93gpo5DX6O45bTPYBcCKTFF+h220RDpA7/hkvvRNC32IKf1csyrUlo4wQ0X
         HhwF+6j4xdD4Z2FiJRipv6i5ijnAbRFBsmQsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=gJO9t+nw81mCakkJU4rcitth7kTwFygbrgST2tWJ3Vo=;
        b=WnK/4tF/gvbCteZRv85Gc8HaFY5iKsQwHMktv/HNJzAp67yL/hUSccSHvz5sHgfQwv
         IM9N/jGVOrJPXxOJQlZ9a1AYHJ/BhM/83J4OTr3KZIzXD66XL+nk5z7YmBUjOLLRYeJG
         PFjATpF2pEtgYdbK37s9rVdHgs5o6woZG8WEg4th6xZ6tPwqSCXOEUrpS/S4Miea+sjj
         LcqszOYm+Odcbx3qM68gC5oU6SGbTcXjuKnJ7SrQcxExLIVTQLypeJPA0fuw1av5QdnG
         NK9cyKUso6PlGJGb3chJA0x93eisusM/dUFfv81x5hIUF+k1395DIzydOBrLjA/2gize
         X8mA==
X-Gm-Message-State: AOAM531IQGcj+SQczplAyqo9Zq+Zug84AXcR2u+HBeVSjemrTy49hrJw
        vVxPKy8qa8UX9Aihml6P52pcdQ==
X-Google-Smtp-Source: ABdhPJzZI8wTAhP+syWE9VPh8Qg10UjeSdqOap0TYm4UFweiyRiNQpiwd1zO6gZNGkzqAu4agWfSxw==
X-Received: by 2002:ac2:4d29:0:b0:445:b80c:1130 with SMTP id h9-20020ac24d29000000b00445b80c1130mr6625873lfk.21.1646328919443;
        Thu, 03 Mar 2022 09:35:19 -0800 (PST)
Received: from cloudflare.com (2a01-110f-4809-d800-0000-0000-0000-0f9c.aa.ipv6.supernova.orange.pl. [2a01:110f:4809:d800::f9c])
        by smtp.gmail.com with ESMTPSA id c12-20020a056512074c00b004458cd423f7sm542354lfs.68.2022.03.03.09.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 09:35:19 -0800 (PST)
References: <20220227202757.519015-1-jakub@cloudflare.com>
 <20220227202757.519015-3-jakub@cloudflare.com>
 <20220301062536.zs6z6q56exu3hgvv@kafai-mbp.dhcp.thefacebook.com>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@cloudflare.com, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH bpf-next v2 2/3] selftests/bpf: Check dst_port only on
 the client socket
Date:   Thu, 03 Mar 2022 18:34:38 +0100
In-reply-to: <20220301062536.zs6z6q56exu3hgvv@kafai-mbp.dhcp.thefacebook.com>
Message-ID: <87zgm7gcrt.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 28, 2022 at 10:25 PM -08, Martin KaFai Lau wrote:
> On Sun, Feb 27, 2022 at 09:27:56PM +0100, Jakub Sitnicki wrote:
>> cgroup_skb/egress programs which sock_fields test installs process packets
>> flying in both directions, from the client to the server, and in reverse
>> direction.
>> 
>> Recently added dst_port check relies on the fact that destination
>> port (remote peer port) of the socket which sends the packet is known ahead
>> of time. This holds true only for the client socket, which connects to the
>> known server port.
>> 
>> Filter out any traffic that is not bound to be egressing from the client
>> socket in the test program for reading the dst_port.
>> 
>> Fixes: 8f50f16ff39d ("selftests/bpf: Extend verifier and bpf_sock tests for dst_port loads")
>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> ---
>>  .../testing/selftests/bpf/progs/test_sock_fields.c  | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/bpf/progs/test_sock_fields.c b/tools/testing/selftests/bpf/progs/test_sock_fields.c
>> index 3e2e3ee51cc9..186fed1deaab 100644
>> --- a/tools/testing/selftests/bpf/progs/test_sock_fields.c
>> +++ b/tools/testing/selftests/bpf/progs/test_sock_fields.c
>> @@ -42,6 +42,11 @@ struct {
>>  	__type(value, struct bpf_spinlock_cnt);
>>  } sk_pkt_out_cnt10 SEC(".maps");
>>  
>> +enum {
>> +	TCP_SYN_SENT = 2,
>> +	TCP_LISTEN = 10,
> Thanks for the clean up.
>
> A nit. directly use BPF_TCP_SYN_SENT and BPF_TCP_LISTEN.

Thanks. Completely forgot about those.
