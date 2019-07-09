Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B14D63054
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2019 08:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfGIGNW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Jul 2019 02:13:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33272 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfGIGNW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Jul 2019 02:13:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id g2so3969848pfq.0
        for <bpf@vger.kernel.org>; Mon, 08 Jul 2019 23:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Xv+DnWZMWtZr7mzCvLLaBhGR3wtkw21etVzQmoVxT4I=;
        b=YqLytmd8BU+rpZTayU3iMic5Dosb399kpxoJDpXF+RiVDzQDQiQHkr4x/7jW60fB3E
         Mar9XqCxlvyRKs0DW/cMdY8CjLPzoTXqMhxyhLnV9P5C2RHgyHfuwrHymNlGlFsL2WSr
         5PkgT2puWRieAtEccqmqVxOpv178bAM7D07GV0ds0JB9v50u+xMJyYtERvoqgivcax8x
         5VvplNtmwDoXeYAaRJTtaaPFuDfTPjPDhI8//EVjUcraMFb3TIo8Qh0uW9cUIFkqp6B7
         rUIpLilZcsnZDRlIOqnWZ6S/Okhoo2MMUzQpThERQqWIvLRhuahm4xbzZaUHMH3BvKoJ
         +GYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Xv+DnWZMWtZr7mzCvLLaBhGR3wtkw21etVzQmoVxT4I=;
        b=l5LE93imaxFrfBz1P1Xd1vayELXsJbySk+CsMkgIxa+eRYZIJs7Hmt2/ss0Kznlc99
         +zM1rLMxN4Ezg7jPz01o/cEzEL3oXBZx47eegyWIk4qwqQuGKYc61o+blMNVg/wgxdbV
         FSOh425LKD9UKCRH3YSVEhHtPPmyfuMzGob4s7MapfldZBxmigLz7wUtO5dngORuQUZP
         utKUlxBiLf0p6irKkX7AnYY/1qjesqYjejHStAZQRUUZQEoFesbXLqvcMYeTgl5RUYm+
         2DT3IMfZMu12u5uZPm1LqVxP2Hp6XtR0VKs+AP7N8G0gPhRZa7sHHV0Nc7X9xo4hOJOg
         PA7Q==
X-Gm-Message-State: APjAAAXHOAqvn9q89fIGW64y74tTxE+fgk91r+cuDNfgQVLuKh9390ax
        F9hGudv0r2hMcxGrfDGjPcFY0g==
X-Google-Smtp-Source: APXvYqzZraf2IrGue//z+udLX3HSg7Otx7AweddVLWjgXHV//+lEXMW0hcqOyt9G5AuNq5rqVbAq8Q==
X-Received: by 2002:a63:e70f:: with SMTP id b15mr24097863pgi.152.1562652801707;
        Mon, 08 Jul 2019 23:13:21 -0700 (PDT)
Received: from cakuba.netronome.com (c-71-204-185-212.hsd1.ca.comcast.net. [71.204.185.212])
        by smtp.gmail.com with ESMTPSA id 125sm23841023pfg.23.2019.07.08.23.13.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 23:13:21 -0700 (PDT)
Date:   Mon, 8 Jul 2019 23:13:18 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        edumazet@google.com, bpf@vger.kernel.org
Subject: Re: [bpf PATCH v2 0/6] bpf: sockmap/tls fixes
Message-ID: <20190708231318.1a721ce8@cakuba.netronome.com>
In-Reply-To: <156261310104.31108.4569969631798277807.stgit@ubuntu3-kvm1>
References: <156261310104.31108.4569969631798277807.stgit@ubuntu3-kvm1>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 08 Jul 2019 19:13:29 +0000, John Fastabend wrote:
> Resolve a series of splats discovered by syzbot and an unhash
> TLS issue noted by Eric Dumazet.
> 
> The main issues revolved around interaction between TLS and
> sockmap tear down. TLS and sockmap could both reset sk->prot
> ops creating a condition where a close or unhash op could be
> called forever. A rare race condition resulting from a missing
> rcu sync operation was causing a use after free. Then on the
> TLS side dropping the sock lock and re-acquiring it during the
> close op could hang. Finally, sockmap must be deployed before
> tls for current stack assumptions to be met. This is enforced
> now. A feature series can enable it.
> 
> To fix this first refactor TLS code so the lock is held for the
> entire teardown operation. Then add an unhash callback to ensure
> TLS can not transition from ESTABLISHED to LISTEN state. This
> transition is a similar bug to the one found and fixed previously
> in sockmap. Then apply three fixes to sockmap to fix up races
> on tear down around map free and close. Finally, if sockmap
> is destroyed before TLS we add a new ULP op update to inform
> the TLS stack it should not call sockmap ops. This last one
> appears to be the most commonly found issue from syzbot.

Looks like strparser is not done'd for offload?

About patch 6 - I was recently wondering about the "impossible" syzbot
report where context is not freed and my conclusion was that there
can be someone sitting at lock_sock() in tcp_close() already by the
time we start installing the ULP, so TLS's close will never get called.
The entire replacing of callbacks business is really shaky :(

Perhaps I'm rumbling, I will take a close look after I get some sleep :)
