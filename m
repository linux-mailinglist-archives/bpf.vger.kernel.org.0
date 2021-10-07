Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F9C42570B
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 17:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241756AbhJGPwM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 11:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241698AbhJGPwH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Oct 2021 11:52:07 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F308FC061746
        for <bpf@vger.kernel.org>; Thu,  7 Oct 2021 08:50:13 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id y17so6862448ilb.9
        for <bpf@vger.kernel.org>; Thu, 07 Oct 2021 08:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RITICfm+7VYo1WW7xYDzpKcdCcOOA5uOvj4tCcim4Ak=;
        b=gu0pT/qYUzONLbPr9vB0YiA85WJDIddbdUyoOKSuRDutS0uHTMYLpCREwZafMUO9f9
         8X8mCDi3RtPheYuF4ZTB6EwolpOJIjc2Q9RpHmmEne0NfwgROQJ+OMwov65V58ueho0s
         dG9i9lT4RlEMsUOIPdU4sWpI8T7uGRsM6FwOrBGfjEgDRIKgmypZFAXhbiLk+Hg09Iw5
         wtBCwlEcqoPWGmWhcNiU4U4bvGXvTLY0g75h7jmYDy/TBosr3Rf4feYiNY+K74gVv+Lk
         fjC60wmJ+/Xthm2ykWguRXKkjW9XJ3KzMO+eHvxdVRCqY203XVUnLenyG6F1P24sYFxG
         oTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RITICfm+7VYo1WW7xYDzpKcdCcOOA5uOvj4tCcim4Ak=;
        b=q10n21vtnmkLk4bU5wX4fY+VX4wp79lvfjCWTZWeu/0i464AXkjKcQW5H1mghY8smL
         T50xGi1i7BxsCWDrWBzE6aTsHIOFIE8HYgqSI/6stovujxX2MfNBNAcze4HP83HKuRhG
         d8O9eJO0ff1Of7fk720dn+LPMFCTaJCH7huW8XsvJUOa7olp9ij6ZTpJE3z3xT70xFQ2
         eeguVpgmcjodUqlg59Y2R1hEUbLmUT6aBVaUasWiTrCfOcFjeHWokCECk9rjMTLNZE4j
         SwqF/2Rnw7N79wKwQ9MQYiiemg9rNmJFmuyYYsjunPvUSTRb92CwJdlxOtScuiMGfNiG
         Eeyw==
X-Gm-Message-State: AOAM532lS2vlWtMrZEcphbJ+Dpt4zYhdY6kI8++BVllHBywdKmbSZuoe
        ohLXOrc+gkANSUQDqK1WRQk6RQU+bedytFHBX58=
X-Google-Smtp-Source: ABdhPJwb4fVsbpDwt+DFKerTQztEhR1azA6TWSbTZNML7iUF1Mv+Ztq3oyfJY/ksEuSSgTHhA/3SKQ==
X-Received: by 2002:a05:6e02:1909:: with SMTP id w9mr4101515ilu.34.1633621813203;
        Thu, 07 Oct 2021 08:50:13 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id r19sm13699259iot.0.2021.10.07.08.50.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 08:50:12 -0700 (PDT)
Subject: Re: [PATCH] mm: don't call should_failslab() for !CONFIG_FAILSLAB
To:     Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Howard McLauchlan <hmclauchlan@fb.com>
Cc:     bpf@vger.kernel.org
References: <e01e5e40-692a-519c-4cba-e3331f173c82@kernel.dk>
 <2dfc6273-6cdd-f4f5-bed9-400873ac9152@suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <082f30c7-9a7c-b2de-6d30-99fa38150d48@kernel.dk>
Date:   Thu, 7 Oct 2021 09:50:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2dfc6273-6cdd-f4f5-bed9-400873ac9152@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/7/21 9:32 AM, Vlastimil Babka wrote:
> On 10/5/21 17:31, Jens Axboe wrote:
>> Allocations can be a very hot path, and this out-of-line function
>> call is noticeable.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> It used to be inline b4 (hi, Konstantin!) and then was converted to be like
> this intentionally :/
> 
> See 4f6923fbb352 ("mm: make should_failslab always available for fault
> injection")
> 
> And now also kernel/bpf/verifier.c contains:
> BTF_ID(func, should_failslab)
> 
> I think either your or Andrew's version will break this BTF_ID thing, at the
> very least.
> 
> But I do strongly agree that putting unconditionally a non-inline call into
> slab allocator fastpath sucks. Can we make it so that bpf can only do these
> overrides when CONFIG_FAILSLAB is enabled?
> I don't know, perhaps putting this BTF_ID() in #ifdef as well, or providing
> a dummy that is always available (so that nothing breaks), but doesn't
> actually affect slab_pre_alloc_hook() unless CONFIG_FAILSLAB has been enabled?

That seems to be the right approach, limiting it on it actually being enabled
and a function call.

-- 
Jens Axboe

