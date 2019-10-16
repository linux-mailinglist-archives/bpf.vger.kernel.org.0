Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80E73D8DFD
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2019 12:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392463AbfJPKet (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Oct 2019 06:34:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45758 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbfJPKes (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Oct 2019 06:34:48 -0400
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AF9CA8535C
        for <bpf@vger.kernel.org>; Wed, 16 Oct 2019 10:34:48 +0000 (UTC)
Received: by mail-lf1-f72.google.com with SMTP id w22so4656039lfe.2
        for <bpf@vger.kernel.org>; Wed, 16 Oct 2019 03:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=SgWpfY5Xz4zDxp0MpMcVzJx2JBdy4PlhQXGqbdLqW1c=;
        b=XiRYhvxapMAMEru/m/+uLdv3PA/+eAZQ/JPKia0g40Dc6nTP1d0eX2h40PLuXDV6E0
         7uTNQL2E3X0lOWw448I4dHQTQVS3kond8oIniy6Y2MXU5mJsC+F3ji76RlK0fdHw//4K
         ELJeKSlvnKWeEGqDn14TsNwud/FJZxncCXRIEFvlPy+sEbRJOe37zmc8IEmUepIU43Rp
         4BHQJ/iL5PjCP1MTQpdMilhjX+4f65nJUHHfIr5QvXSBrAwcFLfFnMQEdlk5Bc+oOFp4
         pZ5/f6irKL10CHUjlYiLTgt3MpK2RqrMtpd5AKszoe6Psi9ELeJx/Q/k0TvNhqRLY9CS
         L+fw==
X-Gm-Message-State: APjAAAWP6FEnMTILDkTabtTcpTwQ/HPOOc0mVY9+H7T+SwGkfXOu8fgC
        dcjVsYPZ9RWAi3XAK3FBBc0+m+FsYrYCcVVS3/Ezi23FznkkZwHAW3bdyvj4pMUKXFkWPmzZIfe
        hFE4d35rgZ78T
X-Received: by 2002:a2e:8908:: with SMTP id d8mr25165970lji.197.1571222087204;
        Wed, 16 Oct 2019 03:34:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx4XYHDPAfrBOTyCsdEH7wCjKz6XyRUDaC+zt/SS3g8SNH7/oIXHGkUSk//39pfT1paBIYsMQ==
X-Received: by 2002:a2e:8908:: with SMTP id d8mr25165952lji.197.1571222086968;
        Wed, 16 Oct 2019 03:34:46 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id v1sm6234517lfq.89.2019.10.16.03.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 03:34:45 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 174401800F4; Wed, 16 Oct 2019 12:34:45 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        syzbot <syzbot+30209ea299c09d8785c9@syzkaller.appspotmail.com>,
        ddstreet@ieee.org, Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: unregister_netdevice: waiting for DEV to become free (2)
In-Reply-To: <CAADnVQJ7BZMVSt9on4updWrWsFWq6b5J1qEGwTdGYV+BLqH7tg@mail.gmail.com>
References: <00000000000056268e05737dcb95@google.com> <0000000000007d22100573d66078@google.com> <063a57ba-7723-6513-043e-ee99c5797271@I-love.SAKURA.ne.jp> <CAADnVQJ7BZMVSt9on4updWrWsFWq6b5J1qEGwTdGYV+BLqH7tg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 16 Oct 2019 12:34:45 +0200
Message-ID: <87imopgere.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Fri, Oct 11, 2019 at 3:15 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> Hello.
>>
>> I noticed that syzbot is reporting that refcount incremented by bpf(BPF_MAP_UPDATE_ELEM)
>> syscall is not decremented when unregister_netdevice() is called. Is this a BPF bug?
>
> Jesper, Toke,
> please take a look.

Yeah, that unregister notification handler definitely looks broken for
hashmaps; I'll send a patch :)

-Toke
