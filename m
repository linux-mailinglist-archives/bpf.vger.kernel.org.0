Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036D9273615
	for <lists+bpf@lfdr.de>; Tue, 22 Sep 2020 00:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgIUW5y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Sep 2020 18:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728662AbgIUW5y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Sep 2020 18:57:54 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE9AC061755;
        Mon, 21 Sep 2020 15:57:54 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id n14so10610892pff.6;
        Mon, 21 Sep 2020 15:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mcI5ReI6UwbL3Y9VJsKxXjGv/OVvfXvskB57PaK2fIg=;
        b=W4l5lutecwZ6k8fboRiFxU1Hxvcgtrnw4cWWOU59OcbmJ7FVpQASAgTiMg+NRQBf4/
         tbazCRYfVl6lEvWObHic3/v4bewoM3wo+QpDDwiCrFzI+K3hTSklL74Tza9nCmiz8ycw
         TRFTMwG8wrTzbGND2vTuSPj8hFZnyp2y/w2tnvfMbnbWpm8KdkdCWDp1ws+KJQaDvDyM
         4LTgwDzrwy+DX5SAFuLftsDAQxlkV5e0XM99+Z/qbnmwt7W77anx7EPdzBTWYLqUsy/Q
         SQatbhz1BXbbf7xsBwgcG0nimBTsIEdOJfkFrOu8c0gvQN5LY1XtgD43Xz+qF9sPe7HP
         Zmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mcI5ReI6UwbL3Y9VJsKxXjGv/OVvfXvskB57PaK2fIg=;
        b=AafV75x61GI706GhGi9uTxO5Gc7xAkXTPxOTHDa3hQn1OHcjLw6MWFekg7z53NcX+j
         9Ct2o9QLV4JthGU5F4hTVw4cT28YX44ezVGWAHOgqheq3FMHrrZejtEh4/Y0PNex+w5k
         Faz9lYido9mfYuYjBEk8GJCo2ghGNICgp6MVPdxxuj2axyngWDoxUDi3WxWgPi8IywBT
         sdrKS6YhOmaThaETyGgC49mXUNZiOSg/pRvgJMFSqDMTlrqrGza5bKsjTdh5HGjCkHvH
         hgVJ6EWdyW+V8t8ZS8usrin0jpLvjzTtdDd9eWUSJ0ttEAoCsugHw7O1RdUA5B2R5vNY
         rClA==
X-Gm-Message-State: AOAM5322MSc3iVwtYHll4YY20+S76iEwBgLncfCyL60Yt/MdAOw+c7Ql
        E9Gz7J/PiH+3iFFP/EBUW+PFlLigHaLFT3bl8C8=
X-Google-Smtp-Source: ABdhPJxmNmNeUhF6KGE9L0xFvJuiYivilDKG16tiyTwkR0KEi87a+EGJhK6cBjkll4oKTyv/9auskXQqWXDxyuQxzvM=
X-Received: by 2002:a63:5043:: with SMTP id q3mr1315846pgl.293.1600729074167;
 Mon, 21 Sep 2020 15:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600661418.git.yifeifz2@illinois.edu> <20200921135115.GC3794348@cisco>
 <CABqSeASEw=Qr2CroKEpTyWMRXQkamKVUzXiEe2UsoQTCcv_99A@mail.gmail.com> <20200921163916.GE3794348@cisco>
In-Reply-To: <20200921163916.GE3794348@cisco>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Mon, 21 Sep 2020 17:57:43 -0500
Message-ID: <CABqSeAT1p10ZCDcFtdFvd80cqcgw6HOHKf6602jJ14n5fDe4HQ@mail.gmail.com>
Subject: Re: [RFC PATCH seccomp 0/2] seccomp: Add bitmap cache of
 arg-independent filter results that allow syscalls
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Valentin Rothberg <vrothber@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        bpf <bpf@vger.kernel.org>, Tianyin Xu <tyxu@illinois.edu>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Jann Horn <jannh@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 21, 2020 at 11:39 AM Tycho Andersen <tycho@tycho.pizza> wrote:
> I see, I missed this somehow. So is there a reason to hide this behind
> a config option? Isn't it just always better?
>
> Tycho

You have a good point, though, I think keeping a config would allow
people to "test the differences" in the unlikely case that some issue
occurs. Jann pointed that it should be on by default so I'll do that.

YiFei Zhu
