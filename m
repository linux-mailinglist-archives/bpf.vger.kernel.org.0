Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA742AEF73
	for <lists+bpf@lfdr.de>; Wed, 11 Nov 2020 12:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgKKLTW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Nov 2020 06:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgKKLTV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Nov 2020 06:19:21 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A01C0613D6
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2020 03:19:21 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id r7so1275073qkf.3
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2020 03:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NdlWGa9W9j2/2idrafRO8NF9kHbSgdMNIKF8WBfZVnE=;
        b=Zf90S74xeQ2LgIINAlHaNh3n+wxSPSw6MWf8Xd3cGwGlR2g4zYQEqzjNbV21x/Yzvh
         w99oPltcMDq0BMMuF8orFw0dHU3XwsniZhq1vP/gBoW+LXFtcA9aDwE3WxoOtSFQ+XSQ
         XkFwCOJH+VHug5Jp8RT+iRUi8EmRsQ9UduJe6AIDOi2FqARmUIiQT6FZ0NCB0PHpYyci
         JML2ElQrHBcmnXQDrF+FGwR4I9pVBWBdc8QJczC/eTQ38o9Z5E227CFQnsT6tjHvS9U9
         4cGdauMHOE2ZHa3PEvI0/wsbPFaAgsY4xUizR53ibKhCJdvQPiN+poSppN9475DJMNgF
         DBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NdlWGa9W9j2/2idrafRO8NF9kHbSgdMNIKF8WBfZVnE=;
        b=I/Dsxuhq4qATELokm+WA22rI0xt7GRoiO31dKDrg6WaJF9Q2BPrvxvHbsqbGT8ulpR
         I7d4XWbfy9w4Pa+Yr73/4hggYMDPB0j0LaFAHMOAMZOLNWKFHmvlfz7R3wHdrZ0TDIu5
         ZoMOLT6bXASla3OmdtHHdxYzzWbqpmhrQ3TApyW0djCgJLw+VtW+CU8APf06AxyTh6qP
         aUDPh9HnvqNKL1axRumqUW3rCPw9Qe5b9+lZa8/G60bh7da+Jeffe5Z+88Kpg0+7sMSs
         rCyQmFaFzHN6sUV72pb7oKR4rxo05O0L0EESRwcHsEMa6FUn1FD5j4duRNxo9jnUzBx5
         v68Q==
X-Gm-Message-State: AOAM533Iuhw6jS+jay034y9obpqXBqoOuOzgbkxZ9O9sfI5+lb5vGBSX
        HKWu16T/gZvGopjNR0ePuFKA9iGaGDKs9DbmfAevjg==
X-Google-Smtp-Source: ABdhPJyYlG8RGNjUZKn1NEXiU475Oqt1Wa5/f335MCR9/btvvCw3lKf1NDB71nTIM92AcHxiyDRqaQx4DK6yxSs7XQw=
X-Received: by 2002:a37:9747:: with SMTP id z68mr23444181qkd.424.1605093560351;
 Wed, 11 Nov 2020 03:19:20 -0800 (PST)
MIME-Version: 1.0
References: <0000000000009383f505adc8c5a0@google.com> <0000000000000b380805b09dbf40@google.com>
In-Reply-To: <0000000000000b380805b09dbf40@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 11 Nov 2020 12:19:09 +0100
Message-ID: <CACT4Y+ZM6kjJjaiocArfb2EEhJKqqA3=S2Y_7GeTx2SXz-xVAQ@mail.gmail.com>
Subject: Re: general protection fault in nexthop_is_blackhole
To:     syzbot <syzbot+b2c08a2f5cfef635cc3a@syzkaller.appspotmail.com>
Cc:     a@unstable.cc, Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>, anmol.karan123@gmail.com,
        Alexei Starovoitov <ast@kernel.org>,
        b.a.t.m.a.n@lists.open-mesh.org, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        David Ahern <dsahern@gmail.com>, hariprasad.kelam@gmail.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@chromium.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>, mareklindner@neomailbox.ch,
        netdev <netdev@vger.kernel.org>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Song Liu <songliubraving@fb.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        sw@simonwunderlich.de,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Yonghong Song <yhs@fb.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 1, 2020 at 5:34 PM syzbot
<syzbot+b2c08a2f5cfef635cc3a@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit eeaac3634ee0e3f35548be35275efeca888e9b23
> Author: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> Date:   Sat Aug 22 12:06:36 2020 +0000
>
>     net: nexthop: don't allow empty NHA_GROUP
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=116177a7900000
> start commit:   c3d8f220 Merge tag 'kbuild-fixes-v5.9' of git://git.kernel..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bb68b9e8a8cc842f
> dashboard link: https://syzkaller.appspot.com/bug?extid=b2c08a2f5cfef635cc3a
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d75e39900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12aea519900000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: net: nexthop: don't allow empty NHA_GROUP
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection


#syz fix: net: nexthop: don't allow empty NHA_GROUP
