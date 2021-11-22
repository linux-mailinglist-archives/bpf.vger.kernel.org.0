Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1B645961A
	for <lists+bpf@lfdr.de>; Mon, 22 Nov 2021 21:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbhKVUgT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 15:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233717AbhKVUgS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 15:36:18 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAB9C061714
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 12:33:12 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2E2366E3;
        Mon, 22 Nov 2021 20:33:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2E2366E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1637613191; bh=qBEmJndL88dvDXg002stQ64DAww/T/d4rpP21SqVrHg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=H426KWL8q1NcssD5EOIR1dxXdO9wDO+4kATr8YkZZ1Il0Lbdkletts/tgtr4qZIjQ
         hRA9CybJ7BwyGDqtuR0DMASxDlb3JS5jhmnmExXESmSv2C0GVCaZRqIKrsS8B6s4bU
         ujgHTNDQTMwk0cw9TKRjGhkmEYcmd+fgExMzRf9kiZBDyGFo7YaQMMcvyQkAPZtOGT
         Gx2PZCBpPZREjfRTKx9iZF2kRoyHd/zNqAOoGI6noPyjGrmClN7VFZHRHlRp56rQ5I
         Bns6WBHvWnxxrtN3qU6N+P1/gPg1IwSd/4FiZerL/v0JL67Q0cnwFod4iPqyAT9jee
         6KD9g9M4PHLvQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Dave Tucker <dave@dtucker.co.uk>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/2] bpf, docs: document BPF_MAP_TYPE_ARRAY
In-Reply-To: <d1ab737c-5e00-4781-90d4-495400d90b0f@www.fastmail.com>
References: <cover.1637601045.git.dave@dtucker.co.uk>
 <5da383bc01c66e6c1342cdb2b3dc53196214e003.1637601045.git.dave@dtucker.co.uk>
 <87ee78vw76.fsf@meer.lwn.net>
 <d1ab737c-5e00-4781-90d4-495400d90b0f@www.fastmail.com>
Date:   Mon, 22 Nov 2021 13:33:10 -0700
Message-ID: <871r38vsl5.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

"Dave Tucker" <dave@dtucker.co.uk> writes:

> On Mon, 22 Nov 2021, at 19:15, Jonathan Corbet wrote:
>> Dave Tucker <dave@dtucker.co.uk> writes:
>>
>> When you add a new BPF file, you need to add it to the corresponding
>> index.rst file as well.  Otherwise it won't be part of the docs build
>> and will, instead, generate the warning you surely saw when you tested
>> the build...:)
>
> I did test the build and I don't think I introduced any new warnings :)
>
> This file is included in the docs build via the glob pattern that I added to 
> the toctree in Documentation/bpf/maps.rst, which was recently applied to
> bpf-next [1].

Interesting, I didn't know about :glob: - thanks for teaching me
something and apologies for the noise :)

Thanks,

jon
