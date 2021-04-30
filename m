Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183FC36FC44
	for <lists+bpf@lfdr.de>; Fri, 30 Apr 2021 16:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbhD3OXC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Apr 2021 10:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbhD3OWx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Apr 2021 10:22:53 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A753C061344
        for <bpf@vger.kernel.org>; Fri, 30 Apr 2021 07:22:05 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1BF11732;
        Fri, 30 Apr 2021 14:22:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1BF11732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1619792525; bh=OiBmiYQsY+n3zEDK3khWn/1/gQqNN0QNy+Gp4mq/Z2Y=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=UrO8aa85R5LNDbhCcSI49VeNXGL2rUFQUJdfRc/APE2MzMUv3dn6oMgr7e2YU2LHF
         0PeqcsjqALH7g/E/eDH8C6PMWou5FfIY3hqYKnAgSJSovqZxFPODrIpEQ2ecBLbJED
         Nr0HqTZ/ukoQqYe9PKzngSity+SfZu3RmGvliSp4EbHPjHij1h7qWw9HmQTSmM+fA+
         QpxjP5qzkYuvkqrl4jmqt7tKrbgRRWstvJ8rABkhvWB8NWF/3BhaCa9JG4USRgQoyg
         K5qvRTiaKIhvh8cYDVE6C+ioDWhomqPr2aKK4xFzjIQWo6a5WkvQdJzgJdKb/ph9mp
         ZDcvwmUrV5J0Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Grant Seltzer Richman <grantseltzer@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 0/3] Autogenerating API documentation
In-Reply-To: <CAO658oV2vJ0O=D3HWXyCUztsHD5GzDY_5p3jaAicEqqj+2-i+Q@mail.gmail.com>
References: <20210429054734.53264-1-grantseltzer@gmail.com>
 <877dkkd7gp.fsf@meer.lwn.net>
 <CAO658oV2vJ0O=D3HWXyCUztsHD5GzDY_5p3jaAicEqqj+2-i+Q@mail.gmail.com>
Date:   Fri, 30 Apr 2021 08:22:04 -0600
Message-ID: <87tunnc0oj.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Grant Seltzer Richman <grantseltzer@gmail.com> writes:

> Hm, yes I do agree that it'd be nice to use existing tooling but I
> just have a couple concerns for this but please point me in the right
> direction because i'm sure i'm missing something. I was told to ask on
> the linux-doc mailing list because you'd have valuable input anway.
> This is based on reading
> https://www.kernel.org/doc/html/v4.9/kernel-documentation.html#including-kernel-doc-comments
>
> 1. We'd want the ability to pull documentation from the code itself to
> make it so documentation never falls out of date with code. Based on
> the docs on kernel.org/doc it seems that we'd have to be explicit with
> specifying which functions/types are included in an .rst file and
> submit a patch to update the documentation everytime the libbpf api
> changes. Perhaps if this isn't a thing already I can figure out how to
> contribute it.

No, you can tell it to pull out docs for all of the functions in a given
file.  You only need to name things if you want to narrow things down.

> 2. Would it be possible (or necessary) to separate libbpf
> documentation from the kernel readthedocs page since libbpf isn't part
> of the kernel?

It could certainly be built as a separate "book", as are many of the
kernel books now.  I could see it as something that gets pulled into the
user-space API book, but there could also perhaps be an argument made
for creating a new "libraries" book instead.

Thanks,

jon
