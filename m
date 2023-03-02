Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC746A8A0A
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 21:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjCBUMk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 15:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBUMk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 15:12:40 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332EF46171
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 12:12:39 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id ff4so363376qvb.2
        for <bpf@vger.kernel.org>; Thu, 02 Mar 2023 12:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677787958;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UT7bYS9LeYnvei9lQx/8DiZbZF4iOrWWKAaVDjq89wc=;
        b=ss0UuQVMV56lLlS2rD/204v6n6RgM/NgIY41TXJx9GT0A5eUpfZ1PSbJBBWxVf9rbW
         v0CYNNmwR1io2s5w8Vk0dY3oub0EHXGqm0aIpxnkKea/ak/sTcfNW3jjrF/EvwfDjD4K
         0enGNlUmmrDMolcGeVZo21KxS9TGj9l6Xqidrs9X3r5OVzCikvBN8Lsz5ALcGt6cS0LS
         7vzHctvby4Aubb0fGmpZT1nRbmWGLpbKKzLmLg3GlD8eBfKyVOic3tmRJqWF+yM32GH5
         FosfjNQXWuky3z502cDsHBa9qjCBA61na7u7M0svCEcdVw3nwS+RV6IuImELDdE2x2zN
         ktOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677787958;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UT7bYS9LeYnvei9lQx/8DiZbZF4iOrWWKAaVDjq89wc=;
        b=61EL5NdMg3d3DKvwdKmL4HopBMKfHeauFs5V2y1aUs72hoJQ3P3yRle5vdyLtc89XE
         ohKtN1R9HHS6LZ014ZGi6/tQwjL6AEw1/JGVTBeNBrvCTXPlycZcN+SuPNaLsmE+nkmj
         BFINCvpoS2zDpQFi8Se9cJrATZehiOZDBj1f3kl3jBuLT6GYPE8H0KsvThC83QG1FZik
         3Flh7WQABhGC3i38lcjDvuU/t7jwZiRFQAcN9OsdKH+bFTrITi3PJLtEcDfCzLx27dmZ
         fVTfxPsvD0hsoprh3/1oi6BS6TAkCOp1L2wWFqqosnXFCZV7KYhNLh6KVSLwPrc6Fc2h
         svhQ==
X-Gm-Message-State: AO0yUKW427EjQU8SQasUOxZxPk2kX0j15FStOmr5HnYKAFaaEjnBG4if
        EhM6SRpkQ5udLkkUUAUSYFaxJILMVFgxpOhEdzk=
X-Google-Smtp-Source: AK7set9n07gkn3yeAlwSNyCGlPXMw88dnx1x7Bd7EjvK0DRVpRM0osLcvSAS8eC7WZmmyq8imt8W7Q==
X-Received: by 2002:a05:6214:2028:b0:56c:20c:f2f4 with SMTP id 8-20020a056214202800b0056c020cf2f4mr24770221qvf.45.1677787957687;
        Thu, 02 Mar 2023 12:12:37 -0800 (PST)
Received: from [192.168.1.9] (c-73-238-17-243.hsd1.ma.comcast.net. [73.238.17.243])
        by smtp.gmail.com with ESMTPSA id t62-20020ae9df41000000b0073b7f2a0bcbsm326191qkf.36.2023.03.02.12.12.37
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 12:12:37 -0800 (PST)
Message-ID: <faa3ab66-73e5-0532-27ff-dc2c4cfa8dcd@google.com>
Date:   Thu, 2 Mar 2023 15:12:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Content-Language: en-US
From:   Barret Rhoden <brho@google.com>
To:     bpf@vger.kernel.org
Subject: dereference of modified ctx ptr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi -

Depending on how complicated my BPF programs are, the compiler may 
modify a context pointer before accessing the context.

The specific context is our struct bpf_ghost_msg:

https://github.com/google/ghost-userspace/blob/main/kernel/ghost_uapi.h#L385


But in general, it's something like this:

struct bar {
	unsigned int x;
	unsigned int y;
};
struct foo {
	union {
		struct bar bar;
		struct baz baz;
	};
};

Given a struct foo *p, where I try to read p->bar.y, the compiler 
usually emits something like:

	r1 = p
	r2 = *(u32 *)(r1 +4)

which is fine.

but it could also emit something like:

	r1 = p
	r1 += 4			// uh oh!
	r2 = *(u32 *)(r1 +0)

I tried getting around it though various uses of "noinline" on functions 
that take context pointers (or the union structs), e.g. here:

https://github.com/google/ghost-userspace/blob/main/third_party/bpf/biff.bpf.c#L405

But that's extremely brittle, and the compiler can legally modify 
pointers to get to internal fields.

Recently, I've taken to just copying my context payload onto the stack 
and copying it back, which keeps the amount of times I run into this to 
a minimum, but is not ideal.

Can we change the verifier to allow a ctx pointer to be modified?  Or is 
there some other trick I can do to prevent the compiler from modifying 
the pointer?

Thanks,

Barret

