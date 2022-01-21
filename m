Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31FDE4967AC
	for <lists+bpf@lfdr.de>; Fri, 21 Jan 2022 23:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiAUWEE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jan 2022 17:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiAUWEE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Jan 2022 17:04:04 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0B8C06173B
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 14:04:04 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id v17so8783567ilg.4
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 14:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YEbP1Q7m0Wpr2wyOY+oxX51YpWXs2fINRdSdwjj8C6U=;
        b=pLACaiAbxBE8LKUKbb8dAfGwIQw1kb5M8iulEFTXBeK71rwJZKgCSbwIZyGeZiSUOz
         QUH++j/HSU2cxoMbDpwl9osYxS7aw8ZupDGF9k407MInXH/1T2N8XIcQ8Byj0FtprMyG
         sJEib9vlMtP8tQPJZaw7EeJXTCHWvRCZ5YEJ/Hsm6uJ/a0Ys7f5+uJbEDiSvFLT1Ky9J
         hSpxhu6gTGMm8kWYPg3QKPa83H3L9RfUICszRHqkLqEcdFURhwxxA7uXy9DdIo5oO8lo
         ZhtYTQ4ND7O40F4Eeuyg5UokM463j+qKTW/i0AUf9vrwKWl2tUNZiX1fdZz7FGo+DXmZ
         Nc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YEbP1Q7m0Wpr2wyOY+oxX51YpWXs2fINRdSdwjj8C6U=;
        b=mJtYzRvZHKYH2c5YwMZaRPSSN07n+Sp8N51wOSty+U8qAZaCwD6fIQBQvgs/O9oIpd
         rcefUTyBrQ4ZDfXawZi6hVZ5eGK7PooncEH6mTZVP+ZDorZqrVhnH39tTDZhL0WBHjQJ
         8rqE6PtdxWzFJ2Tv+x8iuIlZhCePNYOSLyFxy0qKd8OQmxNRoIuCFrnEO54w3MYnsfTX
         SX1eCdfyb5URPZhOyKBXPTGfqesu28wdgbKnPrQL+4/DSXS2jR0tVTxT8OPLPFTMcfjL
         UxQx3FBqLcGcbd8/njmTyoMIMMQrOdtaUNmbiszARnGNDPAeguL0Zlmc9nP5Ikj0nbBH
         25gA==
X-Gm-Message-State: AOAM531hMAi3tCAcyzjrYfzxEuPvIwmchkHXJ2AGYbWPXDKZztQlqeAo
        SBsWYAQMjEQAUR/8WEogq4g=
X-Google-Smtp-Source: ABdhPJz+hg5PxM3zcMEp5lWWUXNgFeHxOnZyXFHvnOJuGOtU5/o3X7cMWCFLZ1pLA+f0krGYg36fdA==
X-Received: by 2002:a05:6e02:19cc:: with SMTP id r12mr3564923ill.246.1642802643677;
        Fri, 21 Jan 2022 14:04:03 -0800 (PST)
Received: from ?IPV6:2601:282:800:dc80:9047:2ab1:b7a9:36f2? ([2601:282:800:dc80:9047:2ab1:b7a9:36f2])
        by smtp.googlemail.com with ESMTPSA id t7sm1325983ilu.37.2022.01.21.14.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 14:04:03 -0800 (PST)
Message-ID: <e58aabf9-af55-8eac-1047-b18801141d80@gmail.com>
Date:   Fri, 21 Jan 2022 15:04:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH v2 bpf-next 3/4] libbpf: deprecate legacy BPF map
 definitions
Content-Language: en-US
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        David Ahern <dsahern@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>
References: <20220120060529.1890907-1-andrii@kernel.org>
 <20220120060529.1890907-4-andrii@kernel.org> <87wniu7hss.fsf@toke.dk>
 <CAEf4BzYpwK+iPPSx7G2-fTSc8dO-4+ObVP72cmu46z+gzFT0Cg@mail.gmail.com>
 <87lez87rbm.fsf@toke.dk>
From:   David Ahern <dsahern@gmail.com>
In-Reply-To: <87lez87rbm.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/21/22 1:43 PM, Toke Høiland-Jørgensen wrote:
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> 
>> On Thu, Jan 20, 2022 at 3:44 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>>
>>> Andrii Nakryiko <andrii@kernel.org> writes:
>>>
>>>> Enact deprecation of legacy BPF map definition in SEC("maps") ([0]). For
>>>> the definitions themselves introduce LIBBPF_STRICT_MAP_DEFINITIONS flag
>>>> for libbpf strict mode. If it is set, error out on any struct
>>>> bpf_map_def-based map definition. If not set, libbpf will print out
>>>> a warning for each legacy BPF map to raise awareness that it goes
>>>> away.
>>>
>>> We've touched upon this subject before, but I (still) don't think it's a
>>> good idea to remove this support entirely: It makes it impossible to
>>> write a loader that can handle both new and old BPF objects.
>>>
>>> So discourage the use of the old map definitions, sure, but please don't
>>> make it completely impossible to load such objects.
>>
>> BTF-defined maps have been around for quite a long time now and only
>> have benefits on top of the bpf_map_def way. The source code
>> translation is also very straightforward. If someone didn't get around
>> to update their BPF program in 2 years, I don't think we can do much
>> about that.
>>
>> Maybe instead of trying to please everyone (especially those that
>> refuse to do anything to their BPF programs), let's work together to
>> nudge laggards to actually modernize their source code a little bit
>> and gain some benefits from that along the way?
> 
> I'm completely fine with nudging people towards the newer features, and
> I think the compile-time deprecation warning when someone is using the
> old-style map definitions in their BPF programs is an excellent way to
> do that. 
> 
> I'm also fine with libbpf *by default* refusing to load programs that
> use the old-style map definitions, but if the code is removed completely
> it becomes impossible to write general-purpose loaders that can handle
> both old and new programs. The obvious example of such a loader is
> iproute2, the loader in xdp-tools is another.
> 

I agree with Toke's response.

2 years is a very small amount of time when it comes to OS and kernel
versions. Many companies base products on enterprise distributions and
run them for 10+ years. During that time there will be needs to update
some components - like kernel version or some tool but that is done with
the least amount of churn possible. Every update has the potential to
bring in unknown behavior changes. Requiring updates to entire tool
chains, multiple tool sets and libraries to accommodate some deprecation
will only hinder being able to update anything.

Further, programs (e.g., debugging as just one example) can and will
need to be used across many OS and kernel versions.
