Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00D330570D
	for <lists+bpf@lfdr.de>; Wed, 27 Jan 2021 10:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbhA0Jfx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jan 2021 04:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbhA0JdX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jan 2021 04:33:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC36C061574
        for <bpf@vger.kernel.org>; Wed, 27 Jan 2021 01:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SUm2HAGysFJyWnSbpmZwz71sMojqJxmfRXopien2kC4=; b=ahoBnzuLf+xH3Q5RMB+JKeuQLi
        VJqwW4Fjbv1KiuvyF9dm9n7z7m49WvtL2mCBILxI9hg9tgv2hNIQGevs4TcmSTShqZB1wsXc5Xge3
        xjfw5+4jJezsq5SNxyfF9CPXyy9Inn251cTHhLdJ/XjiHsBNvuntD1awlTigakGc+96qdV8uJ3EOh
        F7bclgs9nTw3VFue9GW2CgGcuRAi4fZusKHjWAeeKKRksvALCfadBGKA+V9byqPBABhhIIRqdERbj
        mY/e8hXOmp1M8PmOKdZr18cLKq8HfNzav2apH/lo3O0LGdONi4FV2MhjzGrevoXjpbbmyjWjmC4Tn
        +IkRnCaA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l4hA9-006s8P-TV; Wed, 27 Jan 2021 09:31:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 22141301CC4;
        Wed, 27 Jan 2021 10:30:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F26DF2C538ED1; Wed, 27 Jan 2021 10:30:56 +0100 (CET)
Date:   Wed, 27 Jan 2021 10:30:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        x86@kernel.org, KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH bpf] x86/bpf: handle bpf-program-triggered exceptions
 properly
Message-ID: <YBEy0OfeVgOwdHaT@hirez.programming.kicks-ass.net>
References: <20210126001219.845816-1-yhs@fb.com>
 <YA/dqup/752hHBI4@hirez.programming.kicks-ass.net>
 <66f46df5-8d47-8e4f-a6ab-ab794e57332d@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66f46df5-8d47-8e4f-a6ab-ab794e57332d@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 26, 2021 at 11:21:01AM -0800, Yonghong Song wrote:
> Do we have any x64 cpus which does not support X86_FEATURE_SMAP?

x64 is not an achitecture I know of. If you typoed x86_64 then sure, I
think SMAP is fairly recent, Wikipedia seems to suggest Broadwell and
later. AMD seems to sport it since Zen.
