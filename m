Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D513FE72E
	for <lists+bpf@lfdr.de>; Thu,  2 Sep 2021 03:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbhIBBeR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Sep 2021 21:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbhIBBeQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Sep 2021 21:34:16 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4258DC061760
        for <bpf@vger.kernel.org>; Wed,  1 Sep 2021 18:33:18 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id f11-20020a17090aa78b00b0018e98a7cddaso324700pjq.4
        for <bpf@vger.kernel.org>; Wed, 01 Sep 2021 18:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nWX/ioTNQ2QOF0ESBfXzZRM4T2D3d+eIYmLvmVwtWK8=;
        b=oSpyGu8SiNFqAVoJV1eyNCxhwIJ0NqBJo8CCA+bV0iWITQYrB3j23R/kAggyfAm714
         Wv2/YRCurzOIpSVfWhNOvXnibN1iJRkk04KViGL2XpUnyYvrxaBidRE55suW3sIvk+Rq
         ZRP19dYG8B91jarWQ2bsGz65T5nP4s3MhZAoNaXPrqJ20YoyfRsCDXJHYO77vnTRF4fW
         vuLnEd67Z/P16FOVCmb8mQQcvXU+fC5CwPGLnD4boXBRSWg8JkLx4PYdw6j2Qw7Yp2RI
         8LguivzXnJTKeMYoOjvW8qw/aHvOFCID9eDuY2KRnyu9zRwjbcULtAm6abkZZ7tMgLo0
         6YWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nWX/ioTNQ2QOF0ESBfXzZRM4T2D3d+eIYmLvmVwtWK8=;
        b=VRSNqOxl9wI4RVjsEMGmgePUV5rzGee4QdcEZo1LUMX1vlEdSIUy0k/w5x0MNQE9OX
         RHJ8xR57vzNK7BKe6NQp78fa4iyrEM2MPvSME74g4qS6sNe9EDcYLT/kUITbonjyL086
         CN4RjIx5AragYtXAMdbwpRm4wzh5noyG0tnDP25c5sGDaiYmneVDVv0VL3vSNltZDT5u
         7kfdJK7nOhAI+IHd9fJ31BZ08d5BvVe3GunQsbUCa8IGslbGnTFGZHygDDKzLSe4RjbV
         dV3C2tHnY0MxGdnwxavf1q3LJw7yuEl78wgj/xjMnLP1i9vBWm3ZK6p3UMN9wCynTcK0
         0mqg==
X-Gm-Message-State: AOAM532Tr1Jn3uZz0v6fRqktJjxsBJEW4/G5Pq0GHGdjjWHC4KDE+AL7
        jhpwhdEtonp3M2RipXkZ1FIAfqJ1VXZaC1FcTwc=
X-Google-Smtp-Source: ABdhPJwpnJ6HQ5CCoSUrR5X/BZh9+15CfAKynQAeA0/4dbaaiPOwdTQc/u+1yeZjD49Y+83HMjAHdga0aYiBl0DNp6s=
X-Received: by 2002:a17:902:e790:b0:12c:c0f3:605c with SMTP id
 cp16-20020a170902e79000b0012cc0f3605cmr640299plb.70.1630546397821; Wed, 01
 Sep 2021 18:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210825184745.2680830-1-fallentree@fb.com> <CAADnVQJz8LUTsm_azd4JE0n5Q4Me0Lze6hmsqNYfAKMeA44_fQ@mail.gmail.com>
 <CAJygYd24KySBLCL2rRofGqdPkQzonxBfihRxLQ=O8Xg=AWAowA@mail.gmail.com>
 <CAJygYd3M1E3N9C02WCmPD6_i9miXaCe=OP-M32QTnOXOajBPZA@mail.gmail.com>
 <CAADnVQJB3GKKr1hMWHNKYhoo8CzrDQ83LEnO8c+ntOBtEkjApA@mail.gmail.com> <CAM_iQpVw-5dG8Na9e851bQy2_BcpZQ5QK+r554NZsP0_dbzwNw@mail.gmail.com>
In-Reply-To: <CAM_iQpVw-5dG8Na9e851bQy2_BcpZQ5QK+r554NZsP0_dbzwNw@mail.gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Wed, 1 Sep 2021 18:33:07 -0700
Message-ID: <CAM_iQpUG30QL03Uh9D_ACy_29TLWG+YfDO9_GvcqzW2f0TbpYw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: reduce more flakyness in sockmap_listen
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "sunyucong@gmail.com" <sunyucong@gmail.com>,
        Jiang Wang <jiang.wang@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Yucong Sun <fallentree@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 31, 2021 at 12:33 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> Like I mentioned before, I suspect there is some delay in one of
> the queues on the way or there is a worker wakeup latency.
> I will try adding some tracepoints to see if I can capture it.
>

I tried to revert this patch locally to reproduce the EAGAIN
failure, but even after repeating the sockmap_listen test hundreds
of times, I didn't see any failure here.

If you are still interested in this issue, I'd suggest you adding some
tracepoints to see what happens to kworker or the packet queues.

It does not look like a sockmap bug, otherwise I would be able to
reproduce it here.

Thanks.
