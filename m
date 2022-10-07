Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C485F7A02
	for <lists+bpf@lfdr.de>; Fri,  7 Oct 2022 16:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiJGOyd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Oct 2022 10:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiJGOyc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Oct 2022 10:54:32 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8959F66847;
        Fri,  7 Oct 2022 07:54:31 -0700 (PDT)
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1ogok9-0004Ls-Vb; Fri, 07 Oct 2022 16:54:30 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1ogok9-000BJh-PC; Fri, 07 Oct 2022 16:54:29 +0200
Subject: Re: [PATCH bpf-next v6 1/1] bpf, docs: document BPF_MAP_TYPE_ARRAY
To:     Jiri Olsa <olsajiri@gmail.com>,
        Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org, dave@dtucker.co.uk,
        Alexei Starovoitov <ast@kernel.org>
References: <20221005104634.66406-1-donald.hunter@gmail.com>
 <20221005104634.66406-2-donald.hunter@gmail.com> <Yz69qfI7ZkJPrUt7@krava>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4b2cc38f-7ea8-56ad-30b3-af91553028ec@iogearbox.net>
Date:   Fri, 7 Oct 2022 16:54:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <Yz69qfI7ZkJPrUt7@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26682/Fri Oct  7 09:58:07 2022)
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/6/22 1:36 PM, Jiri Olsa wrote:
> On Wed, Oct 05, 2022 at 11:46:34AM +0100, Donald Hunter wrote:
>> From: Dave Tucker <dave@dtucker.co.uk>
>>
>> Add documentation for the BPF_MAP_TYPE_ARRAY including kernel version
>> introduced, usage and examples. Also document BPF_MAP_TYPE_PERCPU_ARRAY
>> which is similar.
>>
>> Signed-off-by: Dave Tucker <dave@dtucker.co.uk>
>> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
>> ---
>>   Documentation/bpf/map_array.rst | 231 ++++++++++++++++++++++++++++++++
>>   1 file changed, 231 insertions(+)
>>   create mode 100644 Documentation/bpf/map_array.rst
>>
>> diff --git a/Documentation/bpf/map_array.rst b/Documentation/bpf/map_array.rst
>> new file mode 100644
>> index 000000000000..9d2da884c41e
>> --- /dev/null
>> +++ b/Documentation/bpf/map_array.rst
>> @@ -0,0 +1,231 @@
>> +.. SPDX-License-Identifier: GPL-2.0-only
>> +.. Copyright (C) 2022 Red Hat, Inc.
>> +
>> +================================================
>> +BPF_MAP_TYPE_ARRAY and BPF_MAP_TYPE_PERCPU_ARRAY
>> +================================================
>> +
>> +.. note::
>> +   - ``BPF_MAP_TYPE_ARRAY`` was introduced in kernel version 3.19
>> +   - ``BPF_MAP_TYPE_PERCPU_ARRAY`` was introduced in version 4.6
>> +
>> +``BPF_MAP_TYPE_ARRAY`` and ``BPF_MAP_TYPE_PERCPU_ARRAY`` provide generic array
>> +storage. The key type is an unsigned 32-bit integer (4 bytes) and the map is of
>> +constant size. All array elements are pre-allocated and zero initialized when
>> +created. ``BPF_MAP_TYPE_PERCPU_ARRAY`` uses a different memory region for each
>> +CPU whereas ``BPF_MAP_TYPE_ARRAY`` uses the same memory region. The maximum
>> +size of an array, defined in max_entries, is limited to 2^32. The value stored
>> +can be of any size, however, small values will be rounded up to 8 bytes.
> 
> I recently hit 32k size limit for per-cpu map value.. it seems to be
> size limit for generic per cpu allocation, but would be great to have
> it confirmed by somebody who knows mm better ;-)

Yes, for percpu the max is PCPU_MIN_UNIT_SIZE which is 32k, see mm/percpu.c +1756.
In many cases it's implementation specific, so it probably does not make too much
sense to state limits like 2^32, or at least it should say that its theoretical/uapi
limit and actual limits may be implementation/config specific.
