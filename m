Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780A0648811
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 18:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiLIR6s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Dec 2022 12:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiLIR6r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Dec 2022 12:58:47 -0500
Received: from out-77.mta0.migadu.com (out-77.mta0.migadu.com [IPv6:2001:41d0:1004:224b::4d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2224213CED
        for <bpf@vger.kernel.org>; Fri,  9 Dec 2022 09:58:46 -0800 (PST)
Message-ID: <189b3ec2-1aaf-1935-0f93-4a2036fba440@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1670608724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AUU3VuhwJEqSqmjJhuVHZUaFv9m2N8IV06++evUr/Gg=;
        b=DiHCvfL895YQaRpttruQUr1HFK+/OvyPhOY24qDqzu6fnsiyMiOv1yPb64w1P1Qvm1eokc
        gKEuAaJea5BpDCMdGeh34Op3hgy1eY/y4TZ9gviTeeNsK6U4nc9KyiPp+YsBKrMnisXX6M
        t+qH2CJlxlyMH8bHo4noHt+e2RoqCdE=
Date:   Fri, 9 Dec 2022 09:58:40 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4] docs/bpf: Add documentation for
 BPF_MAP_TYPE_SK_STORAGE
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Donald Hunter <donald.hunter@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Yonghong Song <yhs@meta.com>,
        David Vernet <void@manifault.com>, bpf <bpf@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20221209112401.69319-1-donald.hunter@gmail.com>
 <516f48a6-cd8d-4e35-a4e5-69a2c462a7b1@linux.dev>
 <CAADnVQ+E-fONc6BhT_HxErG43tHu32KE5uWtJTXu95HFb8EvLg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAADnVQ+E-fONc6BhT_HxErG43tHu32KE5uWtJTXu95HFb8EvLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/9/22 9:54 AM, Alexei Starovoitov wrote:
> On Fri, Dec 9, 2022 at 9:52 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 12/9/22 3:24 AM, Donald Hunter wrote:
>>> Add documentation for the BPF_MAP_TYPE_SK_STORAGE including
>>> kernel version introduced, usage and examples.
>>
>> Thanks for writing the doc for sk_storage!
>>
>>> +User space
>>> +----------
>>> +
>>> +bpf_map_update_elem()
>>> +~~~~~~~~~~~~~~~~~~~~~
>>> +
>>> +.. code-block:: c
>>> +
>>> +   int bpf_map_update_elem(int map_fd, const void *key, const void *value, __u64 flags)
>>> +
>>> +Socket-local storage for the socket identified by ``key`` belonging to
>>> +``map_fd`` can be added or updated using the ``bpf_map_update_elem()`` libbpf > +function. ``key`` must be a pointer to a valid ``fd`` in the user space
>>> +program. The ``flags`` parameter can be used to control the update behaviour:
>>
>> The "``key`` belonging to ``map_fd``" seems confusing.  Also, it is useful to
>> highlight the ``key`` is a _socket_ ``fd``.
>>
>> May be something like:
>>
>> A socket-local storage can be added/updated locally to a socket identified by a
>> _socket_ ``fd`` stored in the pointer ``key``.  The pointer ``value`` has the
>> data to be added/updated to the socket ``fd``.  The type and size of ``value``
>> should be the same as the value type of the map definition.
>>
>> Feel free to rephrase the above in a better way.
>>
>>> +
>>> +- ``BPF_ANY`` will create storage for ``fd`` or update existing storage.
>>> +- ``BPF_NOEXIST`` will create storage for ``fd`` only if it did not already
>>> +  exist, otherwise the call will fail with ``-EEXIST``.
>>> +- ``BPF_EXIST`` will update existing storage for ``fd`` if it already exists,
>>> +  otherwise the call will fail with ``-ENOENT``.
>>> +
>>> +Returns ``0`` on success, or negative error in case of failure.
>>> +
>>> +bpf_map_lookup_elem()
>>> +~~~~~~~~~~~~~~~~~~~~~
>>> +
>>> +.. code-block:: c
>>> +
>>> +   int bpf_map_lookup_elem(int map_fd, const void *key, void *value)
>>> +
>>> +Socket-local storage for the socket identified by ``key`` belonging to
>>> +``map_fd`` can be retrieved using the ``bpf_map_lookup_elem()`` libbpf
>>> +function. ``key`` must be a pointer to a valid ``fd`` in the user space
>>
>> Same here.
>>
>>> +program. Returns ``0`` on success, or negative error in case of failure.
>>> +
>>> +bpf_map_delete_elem()
>>> +~~~~~~~~~~~~~~~~~~~~~
>>> +
>>> +.. code-block:: c
>>> +
>>> +   int bpf_map_delete_elem(int map_fd, const void *key)
>>> +
>>> +Socket-local storage for the socket identified by ``key`` belonging to
>>> +``map_fd`` can be deleted using the ``bpf_map_delete_elem()`` libbpf
>>> +function. Returns ``0`` on success, or negative error in case of failure.
>>
>> Same here.
> 
> 
> Sorry Martin. I just applied it without seeing your comments.
> Should I revert or this can be done in the follow up?
Ah, just noticed that also.  My bad that only catching up till v4.  It can 
definitely be a followup.
