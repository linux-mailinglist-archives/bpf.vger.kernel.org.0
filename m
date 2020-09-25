Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56272277DB0
	for <lists+bpf@lfdr.de>; Fri, 25 Sep 2020 03:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgIYBgH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 21:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgIYBgH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 21:36:07 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8AEC0613CE;
        Thu, 24 Sep 2020 18:36:07 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id o20so1576598pfp.11;
        Thu, 24 Sep 2020 18:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fgmv1ZdL7UUXwEEal/l25It5GrSTWQVpHodie+cr1w0=;
        b=JRYOS6/EWijo06SB1EWdfUNPiLTpKE4BWfZ0U4z5NiWUiGwaLLEqBs82QOWSq7GHC/
         Lg0nuso6br2icKGo48MjaGPbXt5XfW+FuOep9LZ2ZL0UgBjAiyXvLvw+nU+81bi+nlID
         UiABi7ZcXRSWMSOkl541UuJvrGPaFFf8TcNRndTcWBo71DcNu87UqP4PY0icMqLb/S4N
         vtzUMuvt3t3P8x6O73AmiMAueQDgU0z+uV7hj+1vegevWLFaqER5uz+8cjRUOqXWyv27
         14y6BlTCkF2D9NOMS0AdWMvO3p//u2+Qf4Tcni0GdmPnH7KSeAVIUvMMT2acozLbmbiR
         lUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fgmv1ZdL7UUXwEEal/l25It5GrSTWQVpHodie+cr1w0=;
        b=nyxdUYn3y4jQ7cPWFnZyBNZDiCoMnd1zC/f7moFGHX9UIWCnKsEKrmvB87oGXK3Xpv
         5EE4y3MtnPLXqIUISHEtr2DbhROtOHA59Ud8XXhFZ0SQrseXHhf8mxd8KmePSfcBasqP
         D7Amor6XLsEFNzdh6TAD3h4H1QMHQuJVuNPuaWTgq8ysupib82oHu70xCaTbigj9/FVN
         5T44Pvb4cT5rNZyRosYhdld8F4qjstYAP/A3OzLAboOOJvZKEKy7PKed18SByY7z8IZx
         sPvicbIiM2dNZFC0nMZQGIc+z/IqnSoPYxo9547B+BjnoOkRva9vA5Vooe1bdkfpS8G3
         y0UA==
X-Gm-Message-State: AOAM532RaQ0J5v+lVgvnnYnUNRfgfxAUKhxPq+UdTIlea8Ue4X/IWzVr
        zFUSxM6WgH8MRSgjNZMp0nIqCVReBna1K0Pq6+Q=
X-Google-Smtp-Source: ABdhPJxyv0KcwQtrdMtQkTLyrl57OgqJRSWjXZ4r4Z8vu+1JbH/U88tfk1cIxqTiWE1k97krRxR311A3MkeH2l3hX0c=
X-Received: by 2002:a17:902:7445:b029:d1:dea3:a3ca with SMTP id
 e5-20020a1709027445b02900d1dea3a3camr1876986plt.19.1600997766672; Thu, 24 Sep
 2020 18:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600951211.git.yifeifz2@illinois.edu> <eedf3323eed8615a4be150b39a717de1a68f0c12.1600951211.git.yifeifz2@illinois.edu>
 <202009241646.5739BE3@keescook>
In-Reply-To: <202009241646.5739BE3@keescook>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Thu, 24 Sep 2020 20:35:55 -0500
Message-ID: <CABqSeAR8j=ALk5=Y=D4ivVU8m3DC8XgZp74FyAaeErS_TL4FRQ@mail.gmail.com>
Subject: Re: [PATCH v2 seccomp 5/6] selftests/seccomp: Compare bitmap vs
 filter overhead
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 24, 2020 at 6:47 PM Kees Cook <keescook@chromium.org> wrote:
> BTW, did this benchmark tool's results match your expectations from what
> you saw with your RFC? (I assume it helped since you've included in
> here.)

Yes, I updated the commit message with the benchmarks of this patch
series. Though, given that I'm running in a qemu-kvm on my laptop that
has a lot of stuffs running on it (and with the cursed ThinkPad T480
CPU throttling), I had to throw much more syscalls at it to pass the
"approximately equals" expectation... though no idea about what's
going on with 732 vs 737.

Or if you mean if I expected these results, yes.

YiFei Zhu
