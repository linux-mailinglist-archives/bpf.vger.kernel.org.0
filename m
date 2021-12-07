Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFE746BF77
	for <lists+bpf@lfdr.de>; Tue,  7 Dec 2021 16:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238912AbhLGPjs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Dec 2021 10:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238908AbhLGPjr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Dec 2021 10:39:47 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8170DC061574;
        Tue,  7 Dec 2021 07:36:17 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 16785378;
        Tue,  7 Dec 2021 15:36:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 16785378
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1638891377; bh=sP9S3Fnd8nYunvl1Fv7edni5dhfA5Y06AS3+AML4QJQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Ok9KYPK6ygTBnFLRsb5jFean/Lfca+Fjs7hYokVlFpEbt7xqcdvJDPQneZWgFW2Tv
         ajrzsr1PJ1Hi+vcJzH/KfGysihcv9K00vAxd8yNpkznCy7LeX93SPvuGX4dHVS+MtP
         rYmVKjlmlDuea/4onM0P+lIoZI8f/VQqdP7WEexhT9ihhTQV9C2HaWXL1CM0DEtD6L
         674xp9kmoGQ0qV4/26yNHfiXatMzcfbRcqGW1Y1TQvDhJszag+dDt5W6GLbhPJNdwU
         Lw7zHrVdMA29OWb3NGRGWKjvFQR4wkgukav7bGBRMZ69t7SztqBCtG9ju4p513aehN
         5FS8ze79oi76Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Dave Tucker <dave@dtucker.co.uk>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 bpf-next 2/2] bpf, docs: document BPF_MAP_TYPE_ARRAY
In-Reply-To: <fcab2596-104e-42fe-97b7-15dbfca64ea4@www.fastmail.com>
References: <cover.1638883067.git.dave@dtucker.co.uk>
 <9010b4d5fa1b25410a34f2954f272cce7dca0c99.1638883067.git.dave@dtucker.co.uk>
 <87ilw01n6a.fsf@meer.lwn.net>
 <fcab2596-104e-42fe-97b7-15dbfca64ea4@www.fastmail.com>
Date:   Tue, 07 Dec 2021 08:36:16 -0700
Message-ID: <87a6hc1l73.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

"Dave Tucker" <dave@dtucker.co.uk> writes:

> On Tue, 7 Dec 2021, at 14:53, Jonathan Corbet wrote:
>> Dave Tucker <dave@dtucker.co.uk> writes:
>>
>>> This commit adds documentation for the BPF_MAP_TYPE_ARRAY including
>>> kernel version introduced, usage and examples.
>>> It also documents BPF_MAP_TYPE_PERCPU_ARRAY since this is similar.
>>>
>>> Signed-off-by: Dave Tucker <dave@dtucker.co.uk>
>>> ---
>>>  Documentation/bpf/map_array.rst | 182 ++++++++++++++++++++++++++++++++
>>>  1 file changed, 182 insertions(+)
>>>  create mode 100644 Documentation/bpf/map_array.rst
>>
>> When you add a new file, you need to add it to index.rst as well to
>> bring it into the docs build.
>
> I believe I responded to this comment in an earlier version of this patch set.
> The glob pattern in Documentaion/bpf/maps.rst includes this in the docs build.

Sorry...I even looked for :glob:, believe it or not, but not in
linux-next, sorry.  Caffeine is taking effect now...

>> It's really better not to use ``literal markup`` for function names.
>> Just write function() and the right thing will happen, including
>> cross-reference links to the kerneldoc for that function if it exists.
>
> I've just tested this out, and for some reason it's not working as expected.
> It's not formatted as ``literal markup`` nor is it linked to kerneldoc.
> Perhaps because the issue is because these are part of tools/lib/bpf/bpf_helpers.h?

It can only link to kerneldoc that's actually pulled into the built
documentation.  If there isn't a ".. kernel-doc::" directive for that
file (and it appears there is not) then Sphinx doesn't know about it.

Thanks,

jon
