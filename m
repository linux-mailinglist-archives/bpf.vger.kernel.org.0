Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE531465E8
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 11:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgAWKlj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 05:41:39 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42296 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgAWKlj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jan 2020 05:41:39 -0500
Received: by mail-wr1-f66.google.com with SMTP id q6so2473964wro.9
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2020 02:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=PCF4Ub7exwZ2F4VQkOoMVUGSJpY9e7zHhZ/DswOikH0=;
        b=zF8bcZxXCVeqCsjx9Osb08zuuFzMDrSNCOo34vPNCnfGbIYSRi2yqAQBqYYrZo98DZ
         1C0rjIk6I7LefkMgrbR7AVAtVOoYaEXB5TuVS7h1cf1X6FwBbVsHee/HpOk3Lq5+ZY5z
         gptyf3FluRVzG6km5SXaLqdIPDMcgHD8ZTuhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=PCF4Ub7exwZ2F4VQkOoMVUGSJpY9e7zHhZ/DswOikH0=;
        b=bf3RQWPe7XfzhkiiCAMNeJgrpvH0oQDlYGdCnCMslmjk53k7G9AMK2XhEu3syPMt+5
         d1T5xMLDtiUmG+cwpA6DuDLiup9Jrj0/OuHbdV9bOpWOqw21ufGrhrUc8HLdb/olufap
         ro081O3cLyGZTMISWhGJa+N2yHAR8Vcw1f701it8UVmueBKtFPdw1Sm+21d8/JRcD9oi
         /KD3IcPcFIVmXkqLGaIVkSwtrCiUyM0uBhboeAx4M9de8dzxLNa0c3Ss/OO8mS6mOuve
         bH/8R3F9sga+xwfacKpTmgcoylPeGCxMUj5T2qzoVtY9j7ZQe/w+oLwqsINGv8F9xkby
         Iqjw==
X-Gm-Message-State: APjAAAUNxZRo/5SRDDxt8lOjGCSOypK/jJ9EmwLguQuQ1s2gzPSEyoiJ
        D27/hGV38UD3jR5mFxw7yOgKqw==
X-Google-Smtp-Source: APXvYqyLUB6STuJK4xcei+2wB3vfmhWn5Bjei0w4teATXp+ke7w3+vFT80bx833CA/gqVvbv8Btuqw==
X-Received: by 2002:adf:c54e:: with SMTP id s14mr16202347wrf.385.1579776097381;
        Thu, 23 Jan 2020 02:41:37 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id w17sm2414153wrt.89.2020.01.23.02.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 02:41:36 -0800 (PST)
References: <20200122130549.832236-1-jakub@cloudflare.com> <20200122130549.832236-6-jakub@cloudflare.com> <20200122205157.b7ljnymrumplfahk@kafai-mbp.dhcp.thefacebook.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Martin Lau <kafai@fb.com>
Cc:     "bpf\@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "kernel-team\@cloudflare.com" <kernel-team@cloudflare.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "John Fastabend" <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: Re: [PATCH bpf-next v3 05/12] bpf, sockmap: Allow inserting listening TCP sockets into sockmap
In-reply-to: <20200122205157.b7ljnymrumplfahk@kafai-mbp.dhcp.thefacebook.com>
Date:   Thu, 23 Jan 2020 11:41:36 +0100
Message-ID: <877e1i315r.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 22, 2020 at 09:52 PM CET, Martin Lau wrote:
> On Wed, Jan 22, 2020 at 02:05:42PM +0100, Jakub Sitnicki wrote:
>> In order for sockmap type to become a generic collection for storing TCP
>> sockets we need to loosen the checks during map update, while tightening
>> the checks in redirect helpers.
>>
>> Currently sockmap requires the TCP socket to be in established state (or
>> transitioning out of SYN_RECV into established state when done from BPF),
> If I read the SYN_RECV changes correctly,
> does it mean BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB currently not work?

It works because before this series we didn't have sk_state checks in
bpf_sock_{hash,map}_update helpers.

It was a surprise to find out that BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB
happens when socket is still in SYN_RECV state, though.

Fortunately selftests/bpf/test_sockmap tests cover it.

-jkbs
