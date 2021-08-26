Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B043F8FFE
	for <lists+bpf@lfdr.de>; Thu, 26 Aug 2021 23:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243578AbhHZVI7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Aug 2021 17:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243577AbhHZVI7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Aug 2021 17:08:59 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E116C061757
        for <bpf@vger.kernel.org>; Thu, 26 Aug 2021 14:08:11 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id f2so7612629ljn.1
        for <bpf@vger.kernel.org>; Thu, 26 Aug 2021 14:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I6GByZspfCdWJ6Gwzmp4v+h7d0GeJ9lZJ16I1L6Q0mY=;
        b=Fp7fEksRW3evqkLGzRDwBH5eReGxbFv2Au2FTr81TA5HU5WPJLZkcI1FKIis12vsPI
         Ha97Chd5urSJ85Bq0yRAbMhRl4bEQ5wey9Po+a8PwFrylTL3YW4Or5owZSHadtK9tmJA
         uZvhgxNPEdB6qDHbG9u795yDlbDKuCrfz/oVyOLFsl9N2bRVnjD2tY99ueGIfm/rNv+f
         79AzRlSJAFtchSlCCv8ApEC1Byf4DdqZ32qS+WGft8eKxA20F03HbgqertQ127CXOA01
         qJYtWvrae52bvdDxMtxGl7zSmnvRo4ahaOecEo70Rlb56E7Z9opEDHqGLWoDJipe9PV6
         Bmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I6GByZspfCdWJ6Gwzmp4v+h7d0GeJ9lZJ16I1L6Q0mY=;
        b=BIHdvLf9SDukfhhEimB5Whe1Z+FJHtn1WW13ssZ/hT4zHFnA0sfIsPddfc8b2WNrOu
         1jop2r+wnUlfJj9Q7NBbXGw2t+PQPVqkqxXoTQ2+I+PLACaWEp5SAZxXg9PlH232neYi
         e4hI6nqc64E2HF/bIVHHs3Rg62Osszf4kBTLDMC/xdLl0s4a1KBU/hGuQD2fHbmK4CR9
         bSDrAhLsh5YWwKAf7XML7oY7HF8Umu/nRGCmI4an99zTml0701w+4iRyfo2O+wNDfSK/
         jCpfgf0OKPv+4BiFKrFlc/ozVti+xG873vE5HiB0TWVDlg7p6mYvzsDiv2i18erhGDkk
         Q5CQ==
X-Gm-Message-State: AOAM532zg0/1o3tOWY03p+rOZEXlouwqL8Lbvw6CMc1uPvoKHKW5/tut
        WqPt4A8UIW7+t0+zVaAPEqkRl0E1Xjn7z4I6lEo=
X-Google-Smtp-Source: ABdhPJzWi1KyCWnqVLoiXE28uQ9siGN5LrGwln72SmsFhTGs8zdULHf6g9zSkQ2sQl7V/IDThU1vxGDqbhGfLhPYzUc=
X-Received: by 2002:a2e:a4d1:: with SMTP id p17mr4798315ljm.82.1630012089465;
 Thu, 26 Aug 2021 14:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210825184745.2680830-1-fallentree@fb.com> <CAADnVQJz8LUTsm_azd4JE0n5Q4Me0Lze6hmsqNYfAKMeA44_fQ@mail.gmail.com>
 <CAJygYd24KySBLCL2rRofGqdPkQzonxBfihRxLQ=O8Xg=AWAowA@mail.gmail.com>
 <CAJygYd3M1E3N9C02WCmPD6_i9miXaCe=OP-M32QTnOXOajBPZA@mail.gmail.com>
 <CAADnVQJB3GKKr1hMWHNKYhoo8CzrDQ83LEnO8c+ntOBtEkjApA@mail.gmail.com>
 <CAJygYd2aK_s6x4KO71G0KQLdMr5z07hAPqu5fsj+cQpxUw+7tw@mail.gmail.com> <CAADnVQ+u_vzMmftV4YoTs42HSia4L6DjDc++wP9Bd03n8PVtKw@mail.gmail.com>
In-Reply-To: <CAADnVQ+u_vzMmftV4YoTs42HSia4L6DjDc++wP9Bd03n8PVtKw@mail.gmail.com>
From:   "sunyucong@gmail.com" <sunyucong@gmail.com>
Date:   Thu, 26 Aug 2021 14:07:43 -0700
Message-ID: <CAJygYd3VEiYsju92FMoqA=kY6tVtN=TDRzws4Te4w=A1ELpkUA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: reduce more flakyness in sockmap_listen
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiang Wang <jiang.wang@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Yucong Sun <fallentree@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 26, 2021 at 2:05 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Aug 26, 2021 at 12:24 PM sunyucong@gmail.com
> <sunyucong@gmail.com> wrote:
> >
> > I don't think it's AF_UNIX alone, I'm getting select() timeout for all family:
> >
> > ./test_progs:udp_redir_to_connected:1775: ingress: read: Timer expired
> > udp_redir_to_connected:FAIL:1775
> > #120/36 sockmap_listen/sockmap IPv4 test_udp_redir:FAIL
> > ./test_progs:inet_unix_redir_to_connected:1865: ingress: read: Timer expired
> > inet_unix_redir_to_connected:FAIL:1865
>
> That's something different. It's ETIME and not EAGAIN.
> Do you see IO_TIMEOUT_SEC==30 seconds elapsed between these lines?
> No matter how slow the qemu setup is, the test shouldn't wait that long.

Yes, I do see 30s passes before failure, failure code is ETIME because
 it was set in poll_read() function.
