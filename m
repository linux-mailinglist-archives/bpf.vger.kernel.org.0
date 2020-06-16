Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61631FBC5C
	for <lists+bpf@lfdr.de>; Tue, 16 Jun 2020 19:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgFPRGr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Jun 2020 13:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729544AbgFPRGq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Jun 2020 13:06:46 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5DBC061573
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2020 10:06:46 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id k22so16033327qtm.6
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2020 10:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D1EXFaN4D9LPvkuajV4+uRfdMkcNMTCUUMgdpf+QBd4=;
        b=Mx8o2BPH8bka17EKKkXcill0eXZVMrCE14qbt1m26jLnP/wmZ6CNdgGsCS6w0CG7d/
         zNb3QnZyvtFv/YJ4G8RNDJTZgl15i7EpkZAPQOMBpAR/wKBDz4KrUWh7HC6DJS1+697n
         JbNuVbbXQQ7cTsDUFKLoHGYumga6XnZIodxMafue1o9x7qFmSBkAv88MYeRcjZxO4PpI
         pnUl9fb7Q7+K7Vvbh4t0iBtZoB2S6cSRRyzTjFHG4jcyp8vN/yxFiQNZVAfZyCYXatF3
         RneRqznj6avS3PCcX28rEqZq5pUKtsHTg61bigCgi8j+MIO29VqWJaRGjvTYfWn6ET2W
         IDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D1EXFaN4D9LPvkuajV4+uRfdMkcNMTCUUMgdpf+QBd4=;
        b=srtFKejx8CS0fRz0y/kwY5lrfuTCx6zcArpgKv6I11rlo8QFmHI7w5yLUJVIgxu3CG
         bLCVAZuCuGOY/1ulEbRBTxqcZE9R7kfMT6ZzDlT79lP6QJsxJG8JMc1QIQmqSuH5Wc+y
         sFbwRJzzjj4MNDiGh/4K1ADUMEFwdGu0rwfYg3eRQtvSSCJVMe3QI/QOTLi3AkoQkJ5k
         dsr4ArcLS8Eu3Tx4+FnUWP+5mGT2fL6SH60dt/nVOttT05EAyRw8XpX+B0oXKv7ihIAN
         wSYdL7JZ3jWOJVJjmCkF++SzG7v8LfdzDysNT+N0LTvm2SmgwxdyqwmnFn5JTQJzufuo
         calA==
X-Gm-Message-State: AOAM5322WOPcOWU/630LpCTtu3jcxAvtHgWEyvD9SH3SHtBSX+a03hMH
        ey1yy9c3rwwbhMJytsvbjKfQ32zxqTuUIxH93BQ=
X-Google-Smtp-Source: ABdhPJzpTMKQuwnQgKKZn4p4kGyQE5LbBY6rFuCfl4NyYCublDMlYHXVOfeQGt5pmO660VNlaj/NZekehtdG2B7JeJo=
X-Received: by 2002:ac8:2dc3:: with SMTP id q3mr21714329qta.141.1592327205803;
 Tue, 16 Jun 2020 10:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200616113303.8123-1-tklauser@distanz.ch>
In-Reply-To: <20200616113303.8123-1-tklauser@distanz.ch>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 16 Jun 2020 10:06:34 -0700
Message-ID: <CAEf4BzaHy9t473htHUv5znxZRMieN3ECk5Jx4O9ZX3A47ONA-Q@mail.gmail.com>
Subject: Re: [PATCH bpf] tools, bpftool: Add ringbuf map type to map command docs
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 16, 2020 at 4:34 AM Tobias Klauser <tklauser@distanz.ch> wrote:
>
> Commit c34a06c56df7 ("tools/bpftool: Add ringbuf map to a list of known
> map types") added the symbolic "ringbuf" name. Document it in the bpftool
> map command docs and usage as well.
>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---

Thanks!

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/bpf/bpftool/Documentation/bpftool-map.rst | 2 +-
>  tools/bpf/bpftool/map.c                         | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>

[...]
