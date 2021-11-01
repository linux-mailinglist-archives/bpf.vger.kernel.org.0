Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E84F4423EF
	for <lists+bpf@lfdr.de>; Tue,  2 Nov 2021 00:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhKAX1G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Nov 2021 19:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbhKAX1F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Nov 2021 19:27:05 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCEAC061764
        for <bpf@vger.kernel.org>; Mon,  1 Nov 2021 16:24:31 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id v138so43005478ybb.8
        for <bpf@vger.kernel.org>; Mon, 01 Nov 2021 16:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ggSHlCrQCs2wUhPdxNDjlfERNOIgIZzyh2NOuaU1Ts=;
        b=OVxuY9fOTGg+qApCC+TaxzcU/jD0JJznLcwzcqNusPBGBQcZ9N0aKrjvaL/QzA3pN1
         Z7q9OMazMHjyFZIvmwcFgIcpVRko9qK6tsG9cVx8OTNpX/hcqAtq0SgdgSjz934OYugC
         Vhw2930ZzjI/SOScVyi7ZebwxJH00JioPS0yN4HPuaE4EAN3USj+zCVUoGQaGV2mKPUF
         g5sP5qVLrOOv/SHdrE3CC9x78yqLymRUy1fUSHDUR8r7YNbijoj/eVDot8L5r1rxoCNo
         /pBR7DWm7WQ7ZzO5n7FyWZNH6DbSyHAcU0F86t+BPN3enMSjGkflTSX2skN6KJxBp/9H
         t+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ggSHlCrQCs2wUhPdxNDjlfERNOIgIZzyh2NOuaU1Ts=;
        b=H781F19dy+NYjoy4aXzrR5UR/jmz5+yejbi/85fxUZEp0zNf/YpIr+vMdgzEQ2EGou
         gIezJrDhOpHHvgVCw7CbUoWZ2RQzD29hz2F2LQLB436wclUJKRLNyqHLnQLQo6baqs6p
         Voky9ktr/t2EdsxwTsSOF6rL61aQ2qHTSB7NOlGSx1OaOP+Ma1lSgRjpEXbb5IylE/8h
         KJqQrAhHfKFOFmOdlV9BXa4yz4PQiDa/3uq9sYuvB0hBErIXGQfC07Evxw+VHjbfGqGb
         aVoWD4SqZOn8XG8Pqjyx0tLAuINhrr1wC9fGwTREJpec2cwtOKqKJn7FGwrBSoYiDCB8
         h69Q==
X-Gm-Message-State: AOAM533En+TC8segqkqJNZJlSIGEovOi/tgmd0o+qcmvMAxFBPqQQgsh
        RDPvYoG6C+eCJ6/tSrg9d2Iy76S99pZSpmZkmKu7NQ==
X-Google-Smtp-Source: ABdhPJzHaU9ML/TNh2KjnLTgymkY8gzN7MLN862Kj7BqMuXraXhyR2CD6s4ku+s0007894pG1QHsDlAtpH2e0IhR2fI=
X-Received: by 2002:a25:d010:: with SMTP id h16mr25468218ybg.225.1635809069055;
 Mon, 01 Nov 2021 16:24:29 -0700 (PDT)
MIME-Version: 1.0
References: <20211031171353.4092388-1-eric.dumazet@gmail.com>
 <c735d5a9-cf60-13ba-83eb-86cbcd25685e@fb.com> <CANn89iLY7etQxhQa06ea2FThr6FyR=CNnQcig65H4NhE3fu0FQ@mail.gmail.com>
 <CAADnVQLLKF_44QabyEZ0xbj+LxSssT9_gd3ydjL036E4+erG9Q@mail.gmail.com>
In-Reply-To: <CAADnVQLLKF_44QabyEZ0xbj+LxSssT9_gd3ydjL036E4+erG9Q@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 1 Nov 2021 16:24:17 -0700
Message-ID: <CANn89iLhta9E+cucGOTDNLtqXF=Mrxem=Y6wthh2ODhnALrqoA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: add missing map_delete_elem method to bloom
 filter map
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, Eric Dumazet <eric.dumazet@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Joanne Koong <joannekoong@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 1, 2021 at 2:25 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:

> I rebased and patched it manually while applying.
> Thanks!

Excellent, thank you Alexei.
