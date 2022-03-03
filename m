Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F4B4CC402
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 18:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbiCCRfE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Mar 2022 12:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiCCRfD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 12:35:03 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166051CB35
        for <bpf@vger.kernel.org>; Thu,  3 Mar 2022 09:34:17 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id g39so9744959lfv.10
        for <bpf@vger.kernel.org>; Thu, 03 Mar 2022 09:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=8tLtmJ2RQFruIKSmv2RAzaXnytpg1mHx5r3lRuwz4SQ=;
        b=zD2wIIJPiate0cNq+14kRUpBPEQKPz4nJmw/qZb1Cc1udB5KKscwtAiuBsXabpKKiC
         p5mhU/Cdh8VmuQGrydAyRmOgCge2+ikTpzCB+X2G0gban1MXSi3egxolNqRl8pvlY3eB
         vw16tZNL/60GYX4GOtIx3A9L8/maCflZM/lvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=8tLtmJ2RQFruIKSmv2RAzaXnytpg1mHx5r3lRuwz4SQ=;
        b=Qgwdxu3hQP9aU/4B7VEeZMYGvmGvfByae850uDYKKL2XGdli+0BJs8/mR5UiMuqFWQ
         MiB7fdtNA3rMNWrNno+EY0Loa/rVvlbpMeGdYO9/cKJjiOiIKTJk/CEPKq0nDU51dCbU
         xzytRl3vIf5Jc8IfTkGO17udbR04JQnqs7m3wqHbGCxnKXXeMfUuwvGL01vlwQHLfgfi
         nFcfTO7gao02jtSJCPKxgOy4YVRdbpI7NRZG6gBR+aV33yBUMQwCDuXRgvjNT0xFn81I
         Pbmm3jX1rBcx3aAZaFmoXhV6kiyFaX0iSRwfrQRek48gXX4qsqbuWJrjo6900/3gtndk
         IrbA==
X-Gm-Message-State: AOAM5307UQqCskgeJvuFGZqubfL/7JBQKZb85PIfkUJcQLtIaU4somAz
        piIX9OYtncIhWcCfIg1rHZKwVQ==
X-Google-Smtp-Source: ABdhPJwPOTr+bP13XZ5/Qj03An+Q/A1lifT9TJVElUkL83XHBcTHdMFYiJcHPLV/iVXA+KDxM9HCxw==
X-Received: by 2002:ac2:418c:0:b0:43e:8f98:98f0 with SMTP id z12-20020ac2418c000000b0043e8f9898f0mr22944499lfh.604.1646328853292;
        Thu, 03 Mar 2022 09:34:13 -0800 (PST)
Received: from cloudflare.com (2a01-110f-4809-d800-0000-0000-0000-0f9c.aa.ipv6.supernova.orange.pl. [2a01:110f:4809:d800::f9c])
        by smtp.gmail.com with ESMTPSA id k6-20020a0565123d8600b00443967200c0sm537598lfv.143.2022.03.03.09.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 09:34:12 -0800 (PST)
References: <20220227202757.519015-1-jakub@cloudflare.com>
 <20220227202757.519015-4-jakub@cloudflare.com>
 <20220301062207.d3aqge5qg623asr6@kafai-mbp.dhcp.thefacebook.com>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@cloudflare.com, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Fix test for 4-byte load
 from dst_port on big-endian
Date:   Thu, 03 Mar 2022 18:12:02 +0100
In-reply-to: <20220301062207.d3aqge5qg623asr6@kafai-mbp.dhcp.thefacebook.com>
Message-ID: <874k4fhre3.fsf@cloudflare.com>
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

On Mon, Feb 28, 2022 at 10:22 PM -08, Martin KaFai Lau wrote:
> On Sun, Feb 27, 2022 at 09:27:57PM +0100, Jakub Sitnicki wrote:

[...]

>> --- a/tools/testing/selftests/bpf/progs/test_sock_fields.c
>> +++ b/tools/testing/selftests/bpf/progs/test_sock_fields.c
>> @@ -256,10 +256,23 @@ int ingress_read_sock_fields(struct __sk_buff *skb)
>>  	return CG_OK;
>>  }
>>  
>> +/*
>> + * NOTE: 4-byte load from bpf_sock at dst_port offset is quirky. The
>> + * result is left shifted on little-endian architectures because the
>> + * access is converted to a 2-byte load. The quirky behavior is kept
>> + * for backward compatibility.
>> + */
>>  static __noinline bool sk_dst_port__load_word(struct bpf_sock *sk)
>>  {
>> +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
>> +	const __u8 SHIFT = 16;
>> +#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
>> +	const __u8 SHIFT = 0;
>> +#else
>> +#error "Unrecognized __BYTE_ORDER__"
>> +#endif
>>  	__u32 *word = (__u32 *)&sk->dst_port;
>> -	return word[0] == bpf_htonl(0xcafe0000);
>> +	return word[0] == bpf_htonl(0xcafe << SHIFT);
> I believe it should be fine.  It is the behavior even before
> commit 4421a582718a ("bpf: Make dst_port field in struct bpf_sock 16-bit wide") ?

Yes, exactly. AFAICT there was no change in behavior in commit
4421a582718a, that is:

  1. 4-byte load behaves like it did, in its quirky way,
  2. 2-byte load at offset dst_port works the same
  3. 2-byte load at offset dst_port+2 continues to be rejected.

> btw, is it the same as testing "return word[0] == bpf_hton's'(0xcafe);"

Right. Clever observation. I got the impression from the original
problem report [1] that the users were failing when trying to do:

  bpf_htonl(sk->dst_port) == 0xcafe

Hence I the bpf_htonl() use here.

But perhaps it's better to promote this cleaner pattern in tests.

I will respin it once we hash out the details of what the access should
look like on big-endian with Ilya.

[1] https://lore.kernel.org/bpf/20220113070245.791577-1-imagedong@tencent.com/

[...]
