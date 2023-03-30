Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D688E6D0D7A
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 20:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjC3SND (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 14:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjC3SNC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 14:13:02 -0400
Received: from out-47.mta1.migadu.com (out-47.mta1.migadu.com [IPv6:2001:41d0:203:375::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF5BB74F
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 11:13:01 -0700 (PDT)
Message-ID: <4512b372-048d-d433-ca4c-4b4f34dfb646@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680199979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gkl+BQInnGj4oVoMRepKOyH23KklN4hM4of+SyvIEbA=;
        b=QT0GrWOAznSW6lEfkkBHzwJZrXOeYWQCGNvbpAek7+gmHFx3pTpnzm+tm21+xYjpw9XLg4
        A/pmGQ1eaIh5Sk+wKCikTrP7cG8XdSZG81wo37En82+2QjhlTovVvPI6QFAoaQkBUqEbmJ
        oU2UBS0Y0onKX/FKJX2SzvZzPygC9xY=
Date:   Thu, 30 Mar 2023 11:12:56 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v3 bpf-next 5/5] selftests/bpf: Add bench for task storage
 creation
Content-Language: en-US
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        David Faust <david.faust@oracle.com>
References: <20230322215246.1675516-1-martin.lau@linux.dev>
 <20230322215246.1675516-6-martin.lau@linux.dev>
 <CADvTj4rP3kPODxARVTEs2HsNFOof-BZtr8OsEKdjgcGVOTqKaA@mail.gmail.com>
 <456bcd47-efa2-7e3d-78c0-5f41ecba477c@linux.dev>
 <CADvTj4ouGHvPHEgZobUewY2ZjHZhTzJ96oCBAV8VO2xT2bPC0Q@mail.gmail.com>
 <2b5b56bb-7160-41ac-1fb8-4dbc6ad67d9f@linux.dev>
 <CADvTj4pctyvU+9wQ3T+jq49NAxMV89eOFfj3bp3_GfFuJ99opA@mail.gmail.com>
 <a34687f7-e2eb-3e4d-a123-f47fef6444b0@linux.dev>
 <CADvTj4o1xCovE1dhd2yNgHZZthbEhWFtdKM8TGUe+z+LVV3pqQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CADvTj4o1xCovE1dhd2yNgHZZthbEhWFtdKM8TGUe+z+LVV3pqQ@mail.gmail.com>
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

On 3/30/23 12:51 AM, James Hilliard wrote:
> On Wed, Mar 29, 2023 at 2:07 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 3/29/23 1:03 PM, James Hilliard wrote:
>>>>> So it looks like fork is translated to __gcov_fork when -std=gnu* is set which
>>>>> is why we get this error.
>>>>>
>>>>> As this appears to be intended behavior for gcc I think the best option is
>>>>> to just rename the function so that we don't run into issues when building
>>>>> with gnu extensions like -std=gnu11.
>>>> Is it sure 'fork' is the only culprit? If not, it is better to address it
>>>> properly because this unnecessary name change is annoying when switching bpf
>>>> prog from clang to gcc. Like changing the name in this .c here has to make
>>>> another change to the .c in the prog_tests/ directory.
>>> We've fixed a similar issue in the past by renaming to avoid a
>>> conflict with the builtin:
>>> https://github.com/torvalds/linux/commit/ab0350c743d5c93fd88742f02b3dff12168ab435
>>>
>>
>> Fair enough. Please post a patch for the name change.
> 
> Any suggestions/preferences on what name I should use instead?

May be 'sched_process_fork'?
that will make it the same as the tracepoint's name.
