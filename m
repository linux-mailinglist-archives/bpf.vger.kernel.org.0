Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C48465DA6
	for <lists+bpf@lfdr.de>; Thu,  2 Dec 2021 06:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbhLBFKf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Dec 2021 00:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhLBFKe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Dec 2021 00:10:34 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86607C061574
        for <bpf@vger.kernel.org>; Wed,  1 Dec 2021 21:07:10 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso1546503pji.0
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 21:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Zgs94la7lJFUJ8gAUEK8KqXjqS/nt2l+LWfZ5NiPlk0=;
        b=KyrzJjT0sDPN9/DyJ04S/74FVCW7TEYHGyVSTI82VBgWMtlsQKaM/RyLgI7p++bCbF
         /b3B2wk185U3pOOipsecZvIOon5+/g0s19eIZYCuryLHO9q1uMO8KsWCw9s41pup1K2H
         IJvP75j/GUitlP5tIWs+NGPbqmZyk9iIqwTJDrW4D+3pyiwMdCmeTtiuR8idGMXayokM
         kG/Rr3lhIW56BP3d/4WY63mNQrBHudFVPHYl28iRacCTxSJujMjwrdNeFLL7xHYyNa+Z
         3LVXRjbFhettuTZ0CwJZoFBeBxUP72VgV4RG5FNYwDnxFJ1kEYpDgHT5B4O1xffW35+p
         sPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=Zgs94la7lJFUJ8gAUEK8KqXjqS/nt2l+LWfZ5NiPlk0=;
        b=FGTIQHGXY3EbaQfv/HX5MuThUsRyhS+nctB1I4fKkCj48ST9lJxDfyZK7X1ujx7ruM
         z5qm5l3qVFZGbiYpklLZgBqfyEv/1MsYn/QrZVKF7+tAfexHr67kjW73qJIT2lDVeYoQ
         BPtOA+bezONXURiLqx+Bguan8lm03Dxv/qnrTYlqnon6iB7CDQMfzV3ty85m+S5ruJfH
         rXXUSDnX9TneQ1Ina8ZinLqKfiXiyL6jn8T+w9TPKhqZzYyvs7+zohBVXjvmWtvOjn8R
         HdTnVzShIaPdBujUzXa233CMU6J3nBkV8y1mOET5Mbjkvz75TXa/nGK3wgahjooT9MSB
         JByg==
X-Gm-Message-State: AOAM532t5FUkocKcw4G6qHGWWOebr+xuxWIr51ZuW/v+N3gM/M8MdJBK
        n+wJoDdpwmHeUB+cdXXGUkdH5PGrC5DPvdRfpRfC3VRT
X-Google-Smtp-Source: ABdhPJyamH/59QyjEIeC6jxGR/UiUIKQ5mtr9MrveV9DyzWNEmZJi9bcjKu3YC1Ug9ORsTrGhA5q2+dh0UtseoTztyQ=
X-Received: by 2002:a17:903:2306:b0:141:e52e:457d with SMTP id
 d6-20020a170903230600b00141e52e457dmr12891239plh.3.1638421629789; Wed, 01 Dec
 2021 21:07:09 -0800 (PST)
MIME-Version: 1.0
References: <CAGCsPRbRTN9qxKNJBYXCGNs5YefqEEv3=G5wj=99n97ZNKVW-Q@mail.gmail.com>
In-Reply-To: <CAGCsPRbRTN9qxKNJBYXCGNs5YefqEEv3=G5wj=99n97ZNKVW-Q@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 1 Dec 2021 21:06:58 -0800
Message-ID: <CAADnVQ+TB2_5yOocjo5txw+kbz9ihuwu9kJ1QNTAzaoX9V9mwg@mail.gmail.com>
Subject: Re: Questions Regarding eBPF Programming
To:     Nadav Czerninski <nadavcze@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Nov 14, 2021 at 2:44 AM Nadav Czerninski <nadavcze@gmail.com> wrote=
:
>
>
>
>
> I am looking for a way to monitor syscalls of specific libraries inside m=
y program by intercepting and logging them, but only if their origin is fro=
m a specific set of python/java libraries.
>
> I think I=E2=80=99ve figured out a way to do this, but it seems to me tha=
t there must be a more elegant way.
>
> My current (theoretical) solution is:
>
> 1.    At the process initialization, load an ebpf program that can monito=
r syscalls
>
> 2.    At the beginning of each function which I want to monitor, attach t=
he ebpf program to enable the monitoring state.
>
> 3.    At the end of each function which I want to monitor, detach the ebp=
f program to disable the monitoring state.
>
>
>
> Does this solution make sense?
>
> Is there a better way you recommend doing it? I've also tried using secco=
mp but unfortunately I could not find a way to use it for only a specific l=
ibrary.
>
>
> I=E2=80=99ve understood that eBPF sometimes doesn=E2=80=99t work well in =
docker containers, do you think this solution will have any problems runnin=
g inside a container?
>

Hi Nadav,

Sorry for the delay.
The best is to ask such questions on bpf@vger mailing list.

I suspect "attach at the beginning" won't really work, since it
will be missing events.
Probably better to attach once and then filter python/java by pid/tid
inside bpf program.
Similar filtering can be done based on cgroup_id =3D=3D container.
