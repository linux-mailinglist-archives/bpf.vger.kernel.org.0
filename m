Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCBA6CF405
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 22:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjC2UHT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Mar 2023 16:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjC2UHS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Mar 2023 16:07:18 -0400
Received: from out-20.mta0.migadu.com (out-20.mta0.migadu.com [91.218.175.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D3F1FDA
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 13:07:17 -0700 (PDT)
Message-ID: <a34687f7-e2eb-3e4d-a123-f47fef6444b0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680120435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V88upOL5uB/zBX+8ETdfVoRpvOXNSd17Gj0OIK8P+Zo=;
        b=Zuy5z31Nzx6mUtBtGmkN5NpSmLuS0lPCPAIhm0cRkdKtyhXFy3Qvms7RF2sn+qcyjGszw7
        Q6lp3PLdk/1UGhLpuLdUtPO9LkuY+e9cb531BO/lWxBrqViZczL/oeZFw8BuwUTCXt+rCh
        OsXKiL0XuHfhuH7/a41wIlydVr2SQtA=
Date:   Wed, 29 Mar 2023 13:07:11 -0700
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CADvTj4pctyvU+9wQ3T+jq49NAxMV89eOFfj3bp3_GfFuJ99opA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/29/23 1:03 PM, James Hilliard wrote:
>>> So it looks like fork is translated to __gcov_fork when -std=gnu* is set which
>>> is why we get this error.
>>>
>>> As this appears to be intended behavior for gcc I think the best option is
>>> to just rename the function so that we don't run into issues when building
>>> with gnu extensions like -std=gnu11.
>> Is it sure 'fork' is the only culprit? If not, it is better to address it
>> properly because this unnecessary name change is annoying when switching bpf
>> prog from clang to gcc. Like changing the name in this .c here has to make
>> another change to the .c in the prog_tests/ directory.
> We've fixed a similar issue in the past by renaming to avoid a
> conflict with the builtin:
> https://github.com/torvalds/linux/commit/ab0350c743d5c93fd88742f02b3dff12168ab435
> 

Fair enough. Please post a patch for the name change.
