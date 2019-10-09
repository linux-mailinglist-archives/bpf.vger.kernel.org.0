Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 878F4D090A
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2019 10:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725440AbfJIIDs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Oct 2019 04:03:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33868 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfJIIDs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Oct 2019 04:03:48 -0400
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A2E69C08EC02
        for <bpf@vger.kernel.org>; Wed,  9 Oct 2019 08:03:47 +0000 (UTC)
Received: by mail-lj1-f197.google.com with SMTP id w26so166700ljh.9
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2019 01:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=e6PDWY+jCDc15XxVDO6PNOmfYxpRrFsL3Dg/nclfQ5Q=;
        b=C8rIFG7aEV6S41l2AenndLuO7H+e86rzJrsmHK45ZFsYBIOL4CCltegmS41ywnFcx0
         iwgCGklxmuj77jGqldIAHDF6o1KYh796IpnI++GDGLTu5t/2VwJI6O0tnxiHND0gbJ+V
         yW2hnRXQljJGQ5aQ8Qsxz+6OcN9Na+hOZPLnbEv2Uz3XLRVzn73vVPZwS8PaT5DSxUeQ
         t1mxc+O8slMMAeq4EpSE2SGmG3OBqIjB2h59C5a+Tqg5fwIdkM0r6N4IpD45RK5UOjc6
         8JPVPshakDh62CXJQ/mdj5vFGbeanTrMeKJALhcRK6xY1SZiFXRRRcyqyEOfEd/99jhs
         pODg==
X-Gm-Message-State: APjAAAXdSjhdLrqJAADbaaUeKWbcYk7J7Ot6r7wD16F7X9CQoQfCQ/0R
        uaNz3Llnb7foayYzAqwAaB3KpfxT/qb73Q5ngcfN9uE4t6z2e8WnTbm9KzT82gp6AwY5z9gjGb6
        qxQ9RE1ZXzdwM
X-Received: by 2002:a19:4849:: with SMTP id v70mr1266869lfa.40.1570608226002;
        Wed, 09 Oct 2019 01:03:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw8KUkRcnDDp+F0kxjHINAA1UwC3GB9awdIdon0aDan85L+Ki3CJuQUEi/AcdLBoEiIYovPxA==
X-Received: by 2002:a19:4849:: with SMTP id v70mr1266855lfa.40.1570608225842;
        Wed, 09 Oct 2019 01:03:45 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id v7sm291317lfd.55.2019.10.09.01.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 01:03:45 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E105318063D; Wed,  9 Oct 2019 10:03:43 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Marek Majkowski <marek@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/5] bpf: Support chain calling multiple BPF programs after each other
In-Reply-To: <20191009015117.pldowv6n3k5p3ghr@ast-mbp.dhcp.thefacebook.com>
References: <157046883502.2092443.146052429591277809.stgit@alrua-x1> <157046883614.2092443.9861796174814370924.stgit@alrua-x1> <20191007204234.p2bh6sul2uakpmnp@ast-mbp.dhcp.thefacebook.com> <87sgo3lkx9.fsf@toke.dk> <20191009015117.pldowv6n3k5p3ghr@ast-mbp.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 09 Oct 2019 10:03:43 +0200
Message-ID: <87o8yqjqg0.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> Please implement proper indirect calls and jumps.

I am still not convinced this will actually solve our problem; but OK, I
can give it a shot.

However, I don't actually have a clear picture of what exactly is
missing to add this support. Could you please provide a pointer or two?

-Toke
