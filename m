Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B2037EE1D
	for <lists+bpf@lfdr.de>; Thu, 13 May 2021 00:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237515AbhELVJy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 17:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243458AbhELTAE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 May 2021 15:00:04 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0DAC06137F
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 11:55:49 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id i4so31994580ybe.2
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 11:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ni2rDVSZd62hK7RvjUtltYrU0nSL/K6ogWoKRE8gpTY=;
        b=N6yGaS9Dt4Ax5NhLLkE5H6LisOyI0QxLO2wHljBA90UbWn4a2awjiNV8CPUWyFdSu4
         Qszm0lyW71szdK7zntd/etqXahT8a+gcnaAN/vsBTcKfujoIgvMCDrEWQe0JYpcHgbhQ
         aYxLGEi0ky5ZJbCeOiLUH6pdibUeh4eTvhKrWd52+Px2d+2t6Eif+TPHD2To9eZyMNVZ
         PgPGDtUKphvSgUzgkT2fNmTWF/Xbz1LFVWRGLSSC/x3islSDH2H3iRfbr95Z409BWrUf
         6hTySYC6iiCtMwq5TLe+W6IvfThwHiwMaeQKpoP+LzX1joNQYMpBmKOPWCvfO7j1UlKg
         zORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ni2rDVSZd62hK7RvjUtltYrU0nSL/K6ogWoKRE8gpTY=;
        b=perFtowfZQiH8cK/803LMs0F4NITF38WLgTDvUJzA0DYIeUPcb150wG3C+OMRu7KyB
         JoMtpWB0l5HCBumDEAjD9RDI/VnDh5M53eS07/o54RuBfBF65qO9cF2HJxCHxv0y65Qb
         jTjbCWVp/15YjrzhiFRpZdJs+YG1wRBRD9fLZhzRL/NlCSftkwtf2Vk5t3mFqv25OPSf
         1myMSr3HL6DlXCSFSqAaOw1P/aAWBAxJpKFRu9KOlcGj+arNuwZqUADHGS24Q3k40IZ3
         jtdkxmHQ03gAdqxa8Akt2vrI85QnguMDW0LdyjAIZ+2IC+u5ltvATJKvQxSv9PhrvNpf
         w/XA==
X-Gm-Message-State: AOAM533mHy+4oC4FqCwRq0Ha9H7ddxpCBk9qpME8HSy7pFsYHsfauH49
        H+rvyZnJ0wObLZzZpjPnUWuDI2SF1/RAsR3NCuY=
X-Google-Smtp-Source: ABdhPJwNQDyWLBL3WPUs93lEHokr08bHH8poqdkHpQeh+anyFft+UkD9ascZMuNIP9oj3ThaavDuh3XdAxopM9Pp0wQ=
X-Received: by 2002:a25:3357:: with SMTP id z84mr49435640ybz.260.1620845749047;
 Wed, 12 May 2021 11:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com>
 <20210508034837.64585-19-alexei.starovoitov@gmail.com> <CAEf4BzZYZ9i+pJ_aBzkhCLX9fVjUbOF_1=xvykk93TL5yQZieA@mail.gmail.com>
 <fc8d6e6b-cd31-5fcb-ff22-e3030b3f68a8@fb.com>
In-Reply-To: <fc8d6e6b-cd31-5fcb-ff22-e3030b3f68a8@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 12 May 2021 11:55:38 -0700
Message-ID: <CAEf4BzbMR21TH_qhGBs8Qb_uY82wK5AacOMkg1jfmO4aantYAw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 18/22] bpftool: Use syscall/loader program in
 "prog load" and "gen skeleton" command.
To:     Alexei Starovoitov <ast@fb.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 12, 2021 at 11:44 AM Alexei Starovoitov <ast@fb.com> wrote:
>
> On 5/11/21 9:17 PM, Andrii Nakryiko wrote:
> >> +       bpf_object__for_each_program(prog, obj) {
> >> +               printf("\tif (skel->links.%1$s_fd > 0) close(skel->links.%1$s_fd);\n",
> >> +                      bpf_program__name(prog));
> >
> > you use bpf_program__name(prog) in so many place that it will be much
> > simpler if you have a dedicated variable for it
>
> Every time it's in the different loop over all progs.

ok, it's no big deal, using variable is always an option to shorten
printf if necessary

>
> >> +       obj = bpf_object__open_file(file, &open_opts);
> >> +       if (IS_ERR_OR_NULL(obj)) {
> >
> > please use libbpf_get_error() instead of IS_ERR_OR_NULL()
>
> That was copy-pasted from another place in the same file.
> Fixed both and the rest of comments.

The reason to use libbpf_get_error() is because we'll be changing how
error is reported for APIs like bpf_object__open_file and
libbpf_get_error() will handle that transition automatically, so not
having IS_ERR or IS_ERR_OR_NULL reduces amount of clean up we'll need
to do.
