Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927B8436D62
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 00:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhJUWZI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 18:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhJUWZI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Oct 2021 18:25:08 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D25FC061764
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 15:22:51 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id x192so386011lff.12
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 15:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eQ+SoGfXabgSN77+Zy3KYqQG6cXz+cDMUANA7iTQQh0=;
        b=VCUOIUEdqji37hCtxxssGDM2dPBtjsjip6BAojkGF1Ecn5ivWiVOcJKH16M8DUmfpk
         CbqiI+3IA9AT4RY5q3Gt+N9w9BPXTS7i35LAq9pZb29r1RCifcSUnEotRtkvlRVf2rSl
         bnQ5HdCoRDvvbzQTF9TgBv0FyflyEP1nKfAU7hEcpzRQcGsrYhdpA7X1ZrUO9+g5TJ9E
         /WFKmeYiuAMJeSF8wjMKaNJKIuQ1l3UU4+SqhzCsHhQYCkTErF3E5GaXXcFo42nKGcXz
         AnPNIVFLf/VQd4tJ9XUJNNICO677qzWlk30nafTQDCT77mHBrAgd+wiSh2jdEXeAP4Jq
         4zjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eQ+SoGfXabgSN77+Zy3KYqQG6cXz+cDMUANA7iTQQh0=;
        b=ScJxepMISZYs6/SBl3yTrJm+mefEgUJSSTdlX4wFqWABxCjKVim80nYnKVkcVO3kW+
         wrbg8LPSCFzJtGg3W8vJjGANakTI6bo4Rps2m/h08pOzwnSwqDel59nzSF5FFj8tkQrO
         WS7hCgo5DaS2m6K3h1qG+1aI0cJEzxce1pSmlCrEGq0e7rgarauV/VMSopIz9SS6+q+S
         Jv3mWzAx/jRoPfj5ytHRUachIHUp4jf+3NQ28Ctc3fT6zi0MPMEFolblYYhuge14orEp
         IfdcpVnoOdldBz+jXiqV7Z6rmKYp4ukS4JTGrN/FMgyfzjj3tJpdZ1ugDTC/KKY6wlM2
         pq9Q==
X-Gm-Message-State: AOAM531IWAhq11qFLZkT47r2HWSjH1UuzSbuyrj+XqeVkkFSqfBhXc6l
        QzPSmMEkpmQejmt5PKxRE08ue/5ISymOwBM94jxixwmW4AY=
X-Google-Smtp-Source: ABdhPJzfdLIQU6pwgv9t5Nb1o5MxV7UPOhz4B8iDBObrotRj8MVja1u6hBDvLWTaDyhQw0WGE6QJlYMcttyEWSLhLP4=
X-Received: by 2002:a19:ac4a:: with SMTP id r10mr7753852lfc.393.1634854969546;
 Thu, 21 Oct 2021 15:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20211019032934.1210517-1-xukuohai@huawei.com> <CAADnVQLm_z5cdXOgUpt0e+YGzMcFUkgE-0c7xYsCERzScDOKuw@mail.gmail.com>
In-Reply-To: <CAADnVQLm_z5cdXOgUpt0e+YGzMcFUkgE-0c7xYsCERzScDOKuw@mail.gmail.com>
From:   Brian Vazquez <brianvv@google.com>
Date:   Thu, 21 Oct 2021 15:22:38 -0700
Message-ID: <CAMzD94TZiHRfSWR8-FkzcGwsvcdsoKLvaZ_y3KnkzB8vHmgAOA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix error usage of map_fd and fdget() in generic_map_update_batch()
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Xu Kuohai <xukuohai@huawei.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Oh I completely missed the first email. Sorry about that!

Thanks for the patch Xu.


On Thu, Oct 21, 2021 at 3:05 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Oct 18, 2021 at 8:24 PM Xu Kuohai <xukuohai@huawei.com> wrote:
> >
> > 1. The ufd in generic_map_update_batch() should be read from batch.map_fd;
> > 2. A call to fdget() should be followed by a symmetric call to fdput().
> >
> > Fixes: aa2e93b8e58e ("bpf: Add generic support for update and delete batch ops")
> > Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>
> Ouch. Thanks for the fix. Applied.
>
> Brian,
> when your bugs are fixed please pay attention in the future and
> review the fix with Reviewed-by or Acked-by.
