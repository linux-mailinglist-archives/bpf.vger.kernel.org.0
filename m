Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6479C647467
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 17:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiLHQfj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 11:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiLHQfi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 11:35:38 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A6161533;
        Thu,  8 Dec 2022 08:35:37 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id u12so2247726wrr.11;
        Thu, 08 Dec 2022 08:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jMvTJpwD2DfF9b3qQIeOBpddMqouD6FclP0a62AEJDk=;
        b=OC1xYnxEXybL21GOzrXmpGpOrKbCnZFGKZlDDHDjrtF7XPa1hOQWVakVTpGK4a2PXg
         PcRU+ugcE9L72xr7FpXfJWZTcbToUFnpJ0EIkbHubYAof9GtOVfm6PCMBv/KTebPZjDJ
         pI5acHfwEu7/g8/Azzas6k+/fRUZghMEZrjfIhn63rPkQllqkLG0QpFeHaH/NJomPXb5
         W/CCg9N8nOBe0n3RYPZux5pwyzkQ6wJw+72b3l14ePR3rslDKDLoRP6pXAiz2wVrJpgE
         liVxtx3uHGSYzwlyXiJu32JX352HYEB9EUEJX44XciiAiq1hobMKfUJdMqi7XIKve6MX
         gK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMvTJpwD2DfF9b3qQIeOBpddMqouD6FclP0a62AEJDk=;
        b=GWeuEQ3eDeNI9Vxs1gTax1+nRUGAAezKFzSZpPy7zWSzj2D709dVWF6qKudaARs3G8
         fnzOYlqX9JMazA3LTXxItE2CLr4y3tze3o1+BhMavo0AANF8ItXaV2cbQEInFLRlNpDp
         a4c18z38M6E2IEexH4S06rOL8a+5gpFhqyes/57CK5eUeeQIdOzJhtBgtHVLnN9BCCti
         X1VJ6Ypz82R9IJMhIgHYHxdrY/dS078++/wlFEet8/3t8CoF5SriugWCqiWxFdCHwgwU
         I5I4/FCg2L5arUkqAEg3+nCcC1yLUoTFdyEYkE9CHAZQNR3+P4C7eUjJglIDJJPCj2ze
         i0WA==
X-Gm-Message-State: ANoB5pkgqAqMQ2PPwOAfE7raD0gPCqoN5FAXx2vhldIF7xFb5odwsItb
        099Zc3+7RNvWZMN9aqLyWDiS87qM//eEig==
X-Google-Smtp-Source: AA0mqf5kf4TXdeZRdFYHpZPm+4lTlScdI8vZaxuN6qxS/+LAGAR3kOL8RmV3HOQSmKWSILKaBOHTEg==
X-Received: by 2002:a5d:69c9:0:b0:242:4cf5:f385 with SMTP id s9-20020a5d69c9000000b002424cf5f385mr1856779wrw.34.1670517335467;
        Thu, 08 Dec 2022 08:35:35 -0800 (PST)
Received: from imac ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id s5-20020adfeb05000000b002423dc3b1a9sm18908513wrn.52.2022.12.08.08.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 08:35:34 -0800 (PST)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Yonghong Song <yhs@meta.com>
Subject: Re: [PATCH bpf-next v3] docs/bpf: Add documentation for
 BPF_MAP_TYPE_SK_STORAGE
In-Reply-To: <m2r0xagkwp.fsf@gmail.com> (Donald Hunter's message of "Thu, 08
        Dec 2022 12:05:58 +0000")
Date:   Thu, 08 Dec 2022 16:35:14 +0000
Message-ID: <m2wn71yhtp.fsf@gmail.com>
References: <20221207102721.33378-1-donald.hunter@gmail.com>
        <Y5EB5E5NgtN/ihG/@maniforge.lan> <m2r0xagkwp.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (darwin)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Donald Hunter <donald.hunter@gmail.com> writes:

> David Vernet <void@manifault.com> writes:
>
>> On Wed, Dec 07, 2022 at 10:27:21AM +0000, Donald Hunter wrote:
>>> +
>>> +This snippet shows how to retrieve socket-local storage in a BPF program:
>>> +
>>> +.. code-block:: c
>>> +
>>> +    SEC("sockops")
>>> +    int _sockops(struct bpf_sock_ops *ctx)
>>> +    {
>>> +            struct my_storage *storage;
>>> +            struct bpf_sock *sk;
>>> +
>>> +            sk = ctx->sk;
>>> +            if (!sk)
>>> +                    return 1;
>>
>> Don't feel strongly about this one, but IMO it's nice for examples to
>> illustrate code that's as close to real and pristine as possible. To
>> that point, should this example perhaps be updated to return -ENOENT
>> here, and -ENOMEM below?
>
> Will do.
>

After digging into this a bit more I notice that the sockops programs in
tools/testing/selftests/bpf/progs mostly return 1 in all cases.

I'm assuming that sockops programs should return valid values for
some op types such as BPF_SOCK_OPS_TIMEOUT_INIT. Other than that I can't
find a definitive list. Do you know if valid return values are
enumerated anywhere, or do I need to dig some more?

>>> +
>>> +            storage = bpf_sk_storage_get(&socket_storage, sk, 0,
>>> +                                         BPF_LOCAL_STORAGE_GET_F_CREATE);
>>> +            if (!storage)
>>> +                    return 1;
>>> +
>>> +            /* Use 'storage' here */
>>
>> Let's return 0 at the end to make the example program technically
>> correct.
>
> Will do.
>
>>> +    }
>>
>> Thanks,
>> David
