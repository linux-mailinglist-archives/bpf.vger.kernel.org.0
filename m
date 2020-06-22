Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05EE8203D92
	for <lists+bpf@lfdr.de>; Mon, 22 Jun 2020 19:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbgFVRP5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Jun 2020 13:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbgFVRP5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Jun 2020 13:15:57 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C4AC061573
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 10:15:57 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id i8so5870738uak.9
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 10:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V9Jn7FDX1bVY3dZRjhT4npYuvwy5gz37aG6ZYO3xp0k=;
        b=T36lkF4XF7OMmqkOTJAgDI4I4Gzt2KuH/S0seRLxVepBsYgzUUCkpe1qwsCu+wzzHf
         nHMXkL84msUyKEH/AYnoCW7WATct5XihWAAYA531dqGdJDKyMEGr/KSx4dyWNanE1+Yf
         KmIrT8f175Z/aB/1scns9ynAdHBy334NQMin2eztidXSbpPC3cyH/t3LmSqS8g/kh12/
         KrFtZT6suOracXdbklpwKhopzggk6irs1Kqja1qeMiffvPhGtFU0m4AIZQbeUidjJYOJ
         l5/8DdIOjz4DbPgatyBSsgaIdg08fbxqjqzyE7b0r9vYZOr9ewexd0lZxcYBYH4aszEw
         Uo2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V9Jn7FDX1bVY3dZRjhT4npYuvwy5gz37aG6ZYO3xp0k=;
        b=tsdvSrzwCxvzpH5NXoA/+QMlAzbvliCN6dIQXuP3pg0IXSAK8Nlp0mTaltmPjNVR3d
         PAZRqmWQjgIAc2U/aJ84lLQT8pnuB3g0BC2Ogl4srubtwSaZYw69Lq8T8xqel04ii8PW
         Jf3k37V6unYp2QA/54puxT+Vr30b7qA2b8vTMiypx19b9hAB7gQp1sT80REwvSZoUlU6
         xnHoaPRRAIG9EBYLFKMpj0IQwxrDs0oddJV2yqNHNlfSbWT2AsYWGtWexb/e7NPB+QbG
         kKp0SMRdGc4R64F6pHArBhFw+X9jAo49rQ1QljKFgSNJOou6POVQZ1x6cRdoZ6aLid4j
         dbMQ==
X-Gm-Message-State: AOAM533lwW1Qhkqg9ymF1bO7mFtiM/fuFhnMgFKzHf1btRfeA4fWd38R
        +wq4kvvvbefpcWPGQ5o9ycrugRE9jvRHWeXrVoE=
X-Google-Smtp-Source: ABdhPJyL2LQj2CUA8uRZ0ebeCDy9ianBC5zowg8v3PgtVMU8+0HVA2OmbUxk02U4cTGGIr6Kautm9qLdJ04vcMhX3hw=
X-Received: by 2002:ab0:7032:: with SMTP id u18mr12541236ual.37.1592846156759;
 Mon, 22 Jun 2020 10:15:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAHhV9ES1aUO-Zfpz6uCnFhY3Rgi3ZS1pn4ztz2iXYFO-KX75BQ@mail.gmail.com>
 <CAHhV9EShCxg=W2Yhsehx6KQGYPQ9KjF7jmteoxiNO-8ma-WmLw@mail.gmail.com>
In-Reply-To: <CAHhV9EShCxg=W2Yhsehx6KQGYPQ9KjF7jmteoxiNO-8ma-WmLw@mail.gmail.com>
From:   Anton Protopopov <aspsk2@gmail.com>
Date:   Mon, 22 Jun 2020 13:15:45 -0400
Message-ID: <CAGn_itxdtnNTukVGdb94Qg==RU7_F=8jabgSDd8kzH-73Gg28Q@mail.gmail.com>
Subject: Re: Checkpoint/Restore of BPF Map Data
To:     Abhishek Vijeev <abhishek.vijeev@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, criu@openvz.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

=D0=BF=D0=BD, 22 =D0=B8=D1=8E=D0=BD. 2020 =D0=B3. =D0=B2 13:01, Abhishek Vi=
jeev <abhishek.vijeev@gmail.com>:
>
> + CRIU Mailing List
>
>
> On Mon, Jun 22, 2020 at 10:29 PM Abhishek Vijeev
> <abhishek.vijeev@gmail.com> wrote:
> >
> > Hi,
> >
> > I've been working with the CRIU project to enable CRIU to checkpoint
> > and restore BPF map files.
> > (https://github.com/checkpoint-restore/criu/issues/777).
> >
> > A key component of the solution involves dumping the data contained in
> > BPF maps. However, I have
> > been unable to do this due to the following reason - as far as I'm
> > aware, Linux does not provide an
> > interface to directly retrieve the key-value pairs stored in a BPF map
> > without prior knowledge about
> > the nature of data stored in it.

Try BPF_MAP_LOOKUP_BATCH, here is an example:
https://github.com/iovisor/bcc/blob/master/libbpf-tools/syscount.c#L193
(the bpf_map_lookup_and_delete_batch is used there, but
bpf_map_lookup_batch case should be the same).
