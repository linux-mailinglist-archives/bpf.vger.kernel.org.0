Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08822397A59
	for <lists+bpf@lfdr.de>; Tue,  1 Jun 2021 21:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbhFATDG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Jun 2021 15:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbhFATDG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Jun 2021 15:03:06 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992E5C061574
        for <bpf@vger.kernel.org>; Tue,  1 Jun 2021 12:01:24 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 466AA734;
        Tue,  1 Jun 2021 19:01:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 466AA734
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1622574084; bh=V6Ywxo7ljHY0Jff0dvfSQkiIg7aXRKrI0Nn2ugvLUFM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=DbkOqvbI0ClFVc2fFuylc6hVbZXORK3X8X3l46p/+Q8+dzVfqBoVc0wScTSG6RYX9
         GsvTWn0BgQyWZhGmn+2EWCWm6OF9fPPk5EwS9ghr7v2kiJQHbubXH6DFTi/dJJwP0c
         RLLklMqhjAilMEJQ5JMYxZS28bP3gLf74Sjt/wVcmctLUwKjLbasH6YA4JCmOMdrY1
         i7nuhZfQpsMZdtXzQdluqM/wo+cwBC4EMMUSunsCvHq2fIg5YWwipy9lXrQ82xekQE
         VIVuc8u6aHmoK3J/lNhIgSFGVIcf7fO9VIEja0nTQp22Z8LqLAkHuWLnNU5qMDJjBS
         2OXwfRi/EDHhg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Grant Seltzer Richman <grantseltzer@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 0/3] Autogenerating API documentation
In-Reply-To: <CAO658oUH3u8yWV3Ft-96OCrgkzLacv_saecv4e1u4a_X0nF0eg@mail.gmail.com>
References: <20210429054734.53264-1-grantseltzer@gmail.com>
 <877dkkd7gp.fsf@meer.lwn.net>
 <CAO658oV2vJ0O=D3HWXyCUztsHD5GzDY_5p3jaAicEqqj+2-i+Q@mail.gmail.com>
 <87tunnc0oj.fsf@meer.lwn.net>
 <CAO658oUMkxR7VO1i3wCYHp7hMC3exP3ccHqeA-2BGnL4bPwfPA@mail.gmail.com>
 <CAEf4BzZJUtPiGn+8mkzNd2k+-3EEE85_xezab3RYy9ZW4zqANQ@mail.gmail.com>
 <CAO658oWPrEDBE8FUBuDUnrBVM91Mgu-svXfXgAXawAUp1MmWZA@mail.gmail.com>
 <CAEf4BzZJDqR7mRSKbOCWfZV-dqwin+PGYxBTTYMVVYwriD33JQ@mail.gmail.com>
 <CAO658oUAg02tN4Gr9r5PJvb93HhN_yj3BzpvC2oVc6oaSn0FUw@mail.gmail.com>
 <CAEf4BzY=JQiHquwoUypU2fD4Xe5rr+DuQA2Xw=n6OXvH7hXbew@mail.gmail.com>
 <CAO658oUH3u8yWV3Ft-96OCrgkzLacv_saecv4e1u4a_X0nF0eg@mail.gmail.com>
Date:   Tue, 01 Jun 2021 13:01:23 -0600
Message-ID: <87wnrd9zp8.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Grant Seltzer Richman <grantseltzer@gmail.com> writes:

> Jonathan - am I missing something about how we can version libbpf
> separately from the actual kernel docs?

Sorry, I missed this before.  I guess I still don't understand the
question, though; could you explain what the problem is here?  Apologies
for being so slow...

Thanks,

jon
