Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1D146BF50
	for <lists+bpf@lfdr.de>; Tue,  7 Dec 2021 16:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238728AbhLGPdM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Dec 2021 10:33:12 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:48501 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238634AbhLGPdL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 7 Dec 2021 10:33:11 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id AADDC5C020F;
        Tue,  7 Dec 2021 10:29:40 -0500 (EST)
Received: from imap42 ([10.202.2.92])
  by compute3.internal (MEProxy); Tue, 07 Dec 2021 10:29:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dtucker.co.uk;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=lJWnPOc8DcX8u95VsPCQp07iNiri
        JYza7K+ShU6QKTM=; b=WL6ksPHxuh0NgQZ0UsE5Dcniq96WusjHT8PrcccoFsQq
        MXu3tl7xe8M8wC0kj3iM4V3iy7nPSGSibwmq2UeXMqa9nCFYvIXx1mH9a21kISjD
        zmaUXOe5sf9r2XZ6bCx06D0D/G9C6Vxy4hivPrM4LgA7X2eGY+2dLlosgYCMq6Tj
        z5bZv7XMmyEF1OM/v9mCnuISM5dLCu8aMX2zoMFkcdc5JUNwFIeU7bTak8JYVPEV
        HthnZOjDyrThjm3TWVnomNt0pFFqI2yPf7KX116dE51kSkGnrDhem0EX06CYoqil
        H1ZUOSERK2/kDYetcnmRiRpmGpG6pgB5WNZuN8hL6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=lJWnPO
        c8DcX8u95VsPCQp07iNiriJYza7K+ShU6QKTM=; b=ErbIKf/EJotepMOvSFWTgl
        s6rKajH3BOQArSOi548z2e387Ar1IfaHwIAl9crAmslcJByDIgoZjT0bgkj0KiHE
        DQL4s6ntQ3G2poZvDeZKT82C8E1/jhH2/U8oKD2dLyHbGJxBtt6vkHdUKTcNfPTP
        Mv/8HYwL93vUAMSRPdgKEwS4EjGM7PcitzfZMbOKHo8aurq9aPT5+JRrEoefu/UO
        zefzyv80co8sDwkZQgTYTMW+bzdGrd8dFlPYpfKoF+UVF/jakAc/spLKDLdoQoWA
        h7nB29QxGoPrbwFHx7yESjXtNWtXOHCaKwtAJCAyR+V0rQzbu2ZznBtB/buOAQ9w
        ==
X-ME-Sender: <xms:5H2vYVF8mfSmH6V9Y1mua87f7ek3vXqQZlSJ67Rw0uM6kb1Ez91C7A>
    <xme:5H2vYaXQrCv-7joWsHAY_k2-TUhQ0t3P4GFApr_Mx0I2H9mQ5XD5e9Dlkfr9BYV6g
    dq5lSBbOYyd539y1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrjeehgdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfffgrvhgv
    ucfvuhgtkhgvrhdfuceouggrvhgvseguthhutghkvghrrdgtohdruhhkqeenucggtffrrg
    htthgvrhhnpeejffevhfdvfeetuddvtdfgkefgudejheeujeeujeevffehffffheegkedu
    ffejgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gurghvvgesughtuhgtkhgvrhdrtghordhukh
X-ME-Proxy: <xmx:5H2vYXJshUHBm5T610vzMNe0rKsLD2rOCCXT8neg1HV9b8yX1D5UWA>
    <xmx:5H2vYbEEOd84cGqI3upjHdqUIYnjlqPyPt8KatolncsPyZ-r3oY9iw>
    <xmx:5H2vYbXJ7VK8vbuN4GCvnwGmvfhtQ239mhEESzBJ5jdhZJozZH4_TA>
    <xmx:5H2vYSHOr83ShklUmAI-pOkLLYkdLjVDcOe_-A7KEZMe0oybMyXroA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2CAAC2180078; Tue,  7 Dec 2021 10:29:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4492-g121c2470aa-fm-20211206.001-g121c2470
Mime-Version: 1.0
Message-Id: <fcab2596-104e-42fe-97b7-15dbfca64ea4@www.fastmail.com>
In-Reply-To: <87ilw01n6a.fsf@meer.lwn.net>
References: <cover.1638883067.git.dave@dtucker.co.uk>
 <9010b4d5fa1b25410a34f2954f272cce7dca0c99.1638883067.git.dave@dtucker.co.uk>
 <87ilw01n6a.fsf@meer.lwn.net>
Date:   Tue, 07 Dec 2021 15:29:19 +0000
From:   "Dave Tucker" <dave@dtucker.co.uk>
To:     "Jonathan Corbet" <corbet@lwn.net>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 bpf-next 2/2] bpf, docs: document BPF_MAP_TYPE_ARRAY
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 7 Dec 2021, at 14:53, Jonathan Corbet wrote:
> Dave Tucker <dave@dtucker.co.uk> writes:
>
>> This commit adds documentation for the BPF_MAP_TYPE_ARRAY including
>> kernel version introduced, usage and examples.
>> It also documents BPF_MAP_TYPE_PERCPU_ARRAY since this is similar.
>>
>> Signed-off-by: Dave Tucker <dave@dtucker.co.uk>
>> ---
>>  Documentation/bpf/map_array.rst | 182 ++++++++++++++++++++++++++++++++
>>  1 file changed, 182 insertions(+)
>>  create mode 100644 Documentation/bpf/map_array.rst
>
> When you add a new file, you need to add it to index.rst as well to
> bring it into the docs build.

I believe I responded to this comment in an earlier version of this patch set.
The glob pattern in Documentaion/bpf/maps.rst includes this in the docs build.

>> diff --git a/Documentation/bpf/map_array.rst b/Documentation/bpf/map_array.rst
>> new file mode 100644
>> index 000000000000..7ed5f7654ee8
>> --- /dev/null
>> +++ b/Documentation/bpf/map_array.rst
>> @@ -0,0 +1,182 @@
>> +.. SPDX-License-Identifier: GPL-2.0-only
>> +.. Copyright (C) 2021 Red Hat, Inc.
>> +
>> +================================================
>> +BPF_MAP_TYPE_ARRAY and BPF_MAP_TYPE_PERCPU_ARRAY
>> +================================================
>> +
>> +.. note:: ``BPF_MAP_TYPE_ARRAY`` was introduced in Kernel version 3.19 and
>> +   ``BPF_MAP_TYPE_PERCPU_ARRAY`` in version 4.6
>> +
>> +``BPF_MAP_TYPE_ARRAY`` and ``BPF_MAP_TYPE_PERCPU_ARRAY`` provide generic array
>> +storage.  The key type is an unsigned 32-bit integer (4 bytes) and the map is of
>> +constant size. All array elements are pre-allocated and zero initialized when
>> +created. ``BPF_MAP_TYPE_PERCPU_ARRAY`` uses a different memory region for each
>> +CPU whereas ``BPF_MAP_TYPE_ARRAY`` uses the same memory region. The maximum
>> +size of an array, defined in max_entries, is limited to 2^32. The value stored
>> +can be of any size, however, small values will be rounded up to 8 bytes.
>> +
>> +Since Kernel 5.4, memory mapping may be enabled for ``BPF_MAP_TYPE_ARRAY`` by
>> +setting the flag ``BPF_F_MMAPABLE``.  The map definition is page-aligned and
>> +starts on the first page.  Sufficient page-sized and page-aligned blocks of
>> +memory are allocated to store all array values, starting on the second page,
>> +which in some cases will result in over-allocation of memory. The benefit of
>> +using this is increased performance and ease of use since userspace programs
>> +would not be required to use helper functions to access and mutate data.
>> +
>> +Usage
>> +=====
>> +
>> +Array elements can be retrieved using the ``bpf_map_lookup_elem()`` helper.
>
> It's really better not to use ``literal markup`` for function names.
> Just write function() and the right thing will happen, including
> cross-reference links to the kerneldoc for that function if it exists.

I've just tested this out, and for some reason it's not working as expected.
It's not formatted as ``literal markup`` nor is it linked to kerneldoc.
Perhaps because the issue is because these are part of tools/lib/bpf/bpf_helpers.h?

I also noticed I introduced a warning due to missing a newline after a code block :(
I'll fix that and push a v4, but will wait for confirmation on the use of `` for the helper
functions.

- Dave

> Thanks,
>
> jon
