Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F7524080E
	for <lists+bpf@lfdr.de>; Mon, 10 Aug 2020 17:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgHJPBe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Aug 2020 11:01:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47547 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726482AbgHJPBd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Aug 2020 11:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597071691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h40qd2TnVpFmPFX/VP+5qYr4BYDGp0Yih60F15Jz+VQ=;
        b=JQmu0rA1zcOCS8hGjzCMlliNTOwDctdxF0+ZzNBKgwT0PWky+lAZXCwM909vRbHE1uydoC
        E263CkWhK0KJTU6fDzeogcCTdVQaCxBFw3YzEJCDF4e8ZYjpbStxKhT/t3fCLY2DJrC0l5
        0XKEg384qHkcyeD5K2F8qyoqNodzDgY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-ZdaCPbpNO0mOzKc2GFkvLw-1; Mon, 10 Aug 2020 11:01:30 -0400
X-MC-Unique: ZdaCPbpNO0mOzKc2GFkvLw-1
Received: by mail-wm1-f69.google.com with SMTP id u144so2962943wmu.3
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2020 08:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=h40qd2TnVpFmPFX/VP+5qYr4BYDGp0Yih60F15Jz+VQ=;
        b=KPMChumgEJUOmzhhS4XWGBLl1HEuEL6JYmXOY3sP9nLzCC7aQg7ZqpmwEmLW4PnmrT
         J5luvG+RDHSjBVpy/FU090/vhhftoMdHT+T+h8VDo1c7guQjSCPsRRa+sHJHfHQBzwfc
         nBf8ymP8J1FU15zuggl9WPDz1cCYsfKgQFw8nZXdQYj3AqEiHx30qQP9jMqMdbGVZFZu
         UhNxaKEoaRChsdJMoK8M2VbdBe5VLamr2wKEUvHjVqjlzGDSqzN3nYNKHWba54Gxi9qw
         NIxsy+efJsAB42awFFASbj8dnlz6A6XOJaQQjlvjynuU3eFHKgsM0WtLhG5zRKIYryXm
         TRUw==
X-Gm-Message-State: AOAM5315bSYVZrmgUL4W0wdB7fOq0UjDjGfO9HY08Z+PSfHknmDyA8lC
        0Cg0/7xfm5Eyv+WZw7jUp5uvWgtn0VeXgt/iSlvwBR59NyEX+dP5OHiucpTIuRsPVRaEY/hGuZU
        3HHLVy6G8QjzV
X-Received: by 2002:a1c:f30f:: with SMTP id q15mr25438774wmq.60.1597071688876;
        Mon, 10 Aug 2020 08:01:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuS991p/0wGdAtnKqoZRDMvUuklyt9AENd/eOxL2ub0cmCDZZgXp1qhQhVd42WFaop1/PzBA==
X-Received: by 2002:a1c:f30f:: with SMTP id q15mr25438749wmq.60.1597071688583;
        Mon, 10 Aug 2020 08:01:28 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id r22sm22597538wmh.45.2020.08.10.08.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 08:01:27 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7C32418282F; Mon, 10 Aug 2020 17:01:27 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@fb.com, daniel@iogearbox.net
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH bpf-next 0/5] BPF link force-detach support
In-Reply-To: <20200729230520.693207-1-andriin@fb.com>
References: <20200729230520.693207-1-andriin@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 10 Aug 2020 17:01:27 +0200
Message-ID: <874kpa4kag.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andriin@fb.com> writes:

> This patch set adds new BPF link operation, LINK_DETACH, allowing process=
es
> with BPF link FD to force-detach it from respective BPF hook, similarly h=
ow
> BPF link is auto-detached when such BPF hook (e.g., cgroup, net_device, n=
etns,
> etc) is removed. This facility allows admin to forcefully undo BPF link
> attachment, while process that created BPF link in the first place is left
> intact.
>
> Once force-detached, BPF link stays valid in the kernel as long as there =
is at
> least one FD open against it. It goes into defunct state, just like
> auto-detached BPF link.
>
> bpftool also got `link detach` command to allow triggering this in
> non-programmatic fashion.

I know this was already merged, but just wanted to add a belated 'thanks
for adding this'!

> Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

BTW, I've noticed that you tend to drop Ccs on later versions of your
patch series (had to go and lookup v2 of this to check that it was in
fact merged). Is that intentional? :)

-Toke

