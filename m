Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F371436F2C0
	for <lists+bpf@lfdr.de>; Fri, 30 Apr 2021 01:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbhD2W6t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Apr 2021 18:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhD2W6q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Apr 2021 18:58:46 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B229C06138B
        for <bpf@vger.kernel.org>; Thu, 29 Apr 2021 15:57:59 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C13D12E0;
        Thu, 29 Apr 2021 22:57:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C13D12E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1619737078; bh=NlkRT6N/zfE3WWhg32L8Mq5BNm8ddiqYpndUhYobr4A=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=TcMCyb2C0tJoev2sfyPvH9Oi3Hjf1+nUSx0v/A8t0bbSMEgF37C3mqJ+jbV8O/2O0
         zH2bTyi3Wnz/mB59lNCGAXkI/FgSEmpxgqU/B8dbr3Y7ZuafpxkBp3aMmIXbpEJcoG
         14yoOfn8pjUoiEeeo+HgQwGlrVmOyGkBbaHxQ7QvGZ6g+qmiKSibncuzcr4GlbJ63M
         eKZivhLE1sCbNUg9Ey9OEvK4ZWYIb4RC2D8vfOf8Kib7La2+cY1MjVqSCq7dKA39TZ
         MLXcsazvG5rJoAv2piVQRrmKVKVUTtX1AsHFGOb9eI5500OzKgRowrDR9D4UoGPD2S
         HppjVEvxgctGg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     grantseltzer <grantseltzer@gmail.com>, andrii@kernel.org,
        daniel@iogearbox.net
Cc:     grantseltzer@gmail.com, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/3] Autogenerating API documentation
In-Reply-To: <20210429054734.53264-1-grantseltzer@gmail.com>
References: <20210429054734.53264-1-grantseltzer@gmail.com>
Date:   Thu, 29 Apr 2021 16:57:58 -0600
Message-ID: <877dkkd7gp.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

grantseltzer <grantseltzer@gmail.com> writes:

> This series of patches is meant to start the initiative to document libbpf.
> It includes .rst files which are text documentation describing building, 
> API naming convention, as well as an index to generated API documentation.

So I'm totally in favor of documenting libbpf...

> The generated API documentation is enabled by Doxygen, which actually 
> parses the code for documentation comment strings and generates XML.
> A tool called Sphinx then reads this XML with the help of the breathe
> plugin, as well as the above mentioned .rst files and generates beautiful
> HTML output.
>
> The goal of this is for readthedocs.io to be able to pick up that generated
> documentation which will be made possible with the help of readthedoc's 
> github integration and libbpf's official github mirror. Minor setup 
> is required in that mirror once this patch series is merged.

...but I do have to wonder why you are doing something outside of the
kernel's documentation system, which just happens to be based on a tool
called Sphinx.  It would be Really Nice to have this documentation part
of our doc tree; it would also be good to not bring in yet another tool
for building kernel docs.

Do you really need to do your own thing here?

Thanks,

jon
