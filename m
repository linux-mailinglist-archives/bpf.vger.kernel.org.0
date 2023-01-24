Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37925679C80
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 15:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbjAXOus (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 09:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbjAXOur (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 09:50:47 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB9C3525E;
        Tue, 24 Jan 2023 06:50:33 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B93B9739;
        Tue, 24 Jan 2023 14:50:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B93B9739
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1674571832; bh=Vc8JLwfkqE6JpWbRA4bZ5p52aLyKNTmWMGzA0n92mrc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dzBJXW0/Pt2raVBwQybl2aJsiX+5JDe3geBXdhO7sN3jsY3banEVK8XT2YoCT0kvN
         t3z7t8IVQGPv9Cf0axwPm9yNrrDF4FQ1hRVDqBErpIa1gml6fa0Wdg+iqTKhvl57hm
         f9AAH75POEr1odR4c7OxIB45g7tkI4LeYUQXSmzqr/rjGfnjZoPNIjbGNmzfG8brZ/
         reIckTTatUHha5t8q0waXU5XYuH+hchZoVPg+kUxgZGIEhwKvDm0JaBfBt8y9n0c9V
         JEdy3NfsnFZNbKWIKArydOZk5v2ZmNc++1mGwuRG617Xj5NX34rf4i88UzVhuMfHrK
         6vQkJtAX49iHg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     David Vernet <void@manifault.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, memxor@gmail.com
Subject: Re: [PATCH bpf-next v2 3/3] bpf: Use BPF_KFUNC macro at all kfunc
 definitions
In-Reply-To: <Y88sMlmrq0wCFSRP@maniforge.lan>
References: <20230123171506.71995-1-void@manifault.com>
 <20230123171506.71995-4-void@manifault.com>
 <20230123183305.2mgoxgw4ca3sfk24@macbook-pro-6.dhcp.thefacebook.com>
 <Y87We/92xiv5/+g+@maniforge.lan>
 <20230123185434.ybfhrmbootcnjuoj@macbook-pro-6.dhcp.thefacebook.com>
 <ebff2166-8a70-af62-b859-6b5c6b008b36@iogearbox.net>
 <87o7qphspq.fsf@meer.lwn.net> <Y88sMlmrq0wCFSRP@maniforge.lan>
Date:   Tue, 24 Jan 2023 07:50:31 -0700
Message-ID: <87lelsgf60.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

David Vernet <void@manifault.com> writes:

> I was perhaps a bit naive to think we could just throw a __bpf_kfunc
> macro onto the function signatures and call it a day :-) I think it's
> probably best to table this for now, and either I or someone else can
> come back to it when we have bandwidth to solve the problem more
> appropriately.

Now I feel bad ... I was just tossing out a thought, not wanting to
bikeshed this work into oblivion.  If what you have solves a real
problem and is the best that can be done now, perhaps it should just go
in and a "more appropriate" solution can be adopted later, should
somebody manage to come up with it?

Thanks,

jon
