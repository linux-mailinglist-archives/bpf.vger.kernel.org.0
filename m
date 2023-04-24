Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9A46ED3FD
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 19:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjDXR6S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 13:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDXR6R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 13:58:17 -0400
Received: from out-13.mta1.migadu.com (out-13.mta1.migadu.com [95.215.58.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2405E5FE4
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 10:58:15 -0700 (PDT)
Message-ID: <118c84c2-bb4e-72ac-5b0d-b23100867b3e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682359093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d3+5XGbUE770uw9jB3mKTHUu/GzssGXewM29kYrY7aw=;
        b=Sc1bxLwZ2+GrPYALjMGx9HZSOLoKtbI4mtvUnDKQSIXfCnvMsRRKeb4Gpg13bBa0hVSOar
        ChOLSVH3/Dn3dkNh/q63ZSIINSuGGqvRSlWPTTuGPb/efNEcDhGoISwQVfmSj2VoOOM4xU
        AQBB8AwmQVwD/PI9tX8sLhCWjnwd5hI=
Date:   Mon, 24 Apr 2023 10:58:10 -0700
MIME-Version: 1.0
Subject: Re: [PATCH 6/7] selftests/bpf: Add helper to get port using
 getsockname
Content-Language: en-US
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     bpf@vger.kernel.org, kafai@fb.com, edumazet@google.com,
        Stanislav Fomichev <sdf@google.com>
References: <20230418153148.2231644-1-aditi.ghag@isovalent.com>
 <20230418153148.2231644-7-aditi.ghag@isovalent.com>
 <ZD7lRqlxGfgzggAu@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <ZD7lRqlxGfgzggAu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/18/23 11:45 AM, Stanislav Fomichev wrote:
>> +
>> +int get_socket_local_port(int family, int sock_fd, __u16 *out_port)
>> +{
>> +	socklen_t addr_len;
>> +	int err;
> 
> Sorry for keeping bikeshedding this part, but if you're going to do
> another respin, we can also drop the family argument:
> 
> int get_socket_local_port(int sock_fd, __be16 *out_port)
> /*                                       ^^ maybe also do be16? */

I would also just return the port as the return value instead of having another 
arg for this. The int is more than enough.

> {
> 	struct sockaddr_storage addr;
> 	socklen_t addrlen;
> 
> 	addrlen = sizeof(addr);
> 	getsockname(sock_fd, (struct sockaddr *)&addr, &addrlen);
> 
> 	if (addr.ss_family == AF_INET) {
> 	} else if () {
> 	}
> }
> 
>> +
>> +	if (family == AF_INET) {
>> +		struct sockaddr_in addr = {};
>> +
>> +		addr_len = sizeof(addr);
>> +		err = getsockname(sock_fd, (struct sockaddr *)&addr, &addr_len);
>> +		if (err < 0)
>> +			return err;
>> +		*out_port = addr.sin_port;
>> +		return 0;
>> +	} else if (family == AF_INET6) {
>> +		struct sockaddr_in6 addr = {};
>> +
>> +		addr_len = sizeof(addr);
>> +		err = getsockname(sock_fd, (struct sockaddr *)&addr, &addr_len);
>> +		if (err < 0)
>> +			return err;
>> +		*out_port = addr.sin6_port;
>> +		return 0;
>> +	}
>> +
>> +	return -1;
>> +}

