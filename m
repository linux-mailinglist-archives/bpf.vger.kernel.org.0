Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C16122A6E1
	for <lists+bpf@lfdr.de>; Thu, 23 Jul 2020 07:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgGWFWy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jul 2020 01:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgGWFWy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jul 2020 01:22:54 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71A9C0619DC
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2020 22:22:53 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id u25so2609774lfm.1
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2020 22:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hdtbpditTvz+VIJN2DrP7jRWgh4z8YFmdz4e5NKoq+g=;
        b=iX+JVSWL1KGU5gWvCn7kRhKPvJxG63qg3MYBb75Gttu9wndw1kKwglGY4vj2hr47Vc
         JHE1qOhT47cLfeCYIvEI9qBOk9gPmrOfrUuFgPEgpZ1Ry7To48oVcB4n4H9dvz5YkuN3
         +XxDu6vEK6iE6ItHczc/qu+qt94X34DDqH+s2uTk00yRSTM2cXXi3/nqqXUvfdTUaeeV
         +yQB++ssWVUwLzfjwTvRoELfGaHBMcBdQO+vS7VgHpTmodyzXGzbmD7GQqKouGIwzFjo
         1aTEpHvfSqD9lzDwFKmkd6bAA4iRQX373w1e1WogJk4LTnNNjJIkSCfGg0Pojonu4JZx
         MNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hdtbpditTvz+VIJN2DrP7jRWgh4z8YFmdz4e5NKoq+g=;
        b=NOdfLKna0RWW5j5+AmUKursVIM+Pgn1m3IdSLuLQo6othO5e/K/jvSMFJsRJ/s1qCo
         qOc9COc6G7/SmSlKqbjtpJTvLTn6IhtkbL+lZI8qenESvi6mbFItSy9BngCefCeihYCE
         GVoy5iZPChI2FRA5Q7H3FZxtMrKwYDIfZ1bbdu7IknwKf2yCmOfiOxwQYONPS7M+hvzw
         a8zjgF0adTIKIsmcSMVtJk6B5hNboDe0BHcSsSqYpNU9EPe4CYyP5CwS78sGwNzDZ9U5
         H7KAXIdwuoh3vsT3CtbPOIG3tmP2AWTFSSQHKQ8+D6Oj0zv0GVKIGGxH8lKxVSyevRc5
         Konw==
X-Gm-Message-State: AOAM531wnF+Fr3KKiE30x3pLHFzBC2CnNShzb4faScQJ1NNM7SARQW9v
        dxjRKbTevoi8fodScruGoENdRc/lTbyhH0bA2Co=
X-Google-Smtp-Source: ABdhPJzF9Hpl8dY/1n+fZnlxQsS/CEX9esmSjDD0oYA0pDwl5kEWN+CgCezFi/4RdkBGpzFDYRKX9Yhs1NKJhDaVsUs=
X-Received: by 2002:a19:a95:: with SMTP id 143mr1348459lfk.174.1595481772293;
 Wed, 22 Jul 2020 22:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200722195156.4029817-1-yhs@fb.com>
In-Reply-To: <20200722195156.4029817-1-yhs@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 22 Jul 2020 22:22:41 -0700
Message-ID: <CAADnVQ+qGuj1reaFfxG+gm6PgKECFk5+F=qny4oLqpb27=e8mA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: fix pos computation for bpf_iter seq_ops->start()
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 22, 2020 at 12:52 PM Yonghong Song <yhs@fb.com> wrote:
>
> Currently, the pos pointer in bpf iterator map/task/task_file
> seq_ops->start() is always incremented.
> This is incorrect. It should be increased only if
> *pos is 0 (for SEQ_START_TOKEN) since these start()
> function actually returns the first real object.
> If *pos is not 0, it merely found the object
> based on the state in seq->private, and not really
> advancing the *pos. This patch fixed this issue
> by only incrementing *pos if it is 0.
>
> Note that the old *pos calculation, although not
> correct, does not affect correctness of bpf_iter
> as bpf_iter seq_file->read() does not support llseek.
>
> This patch also renamed "mid" in bpf_map iterator
> seq_file private data to "map_id" for better clarity.
>
> Fixes: 6086d29def80 ("bpf: Add bpf_map iterator")
> Fixes: eaaacd23910f ("bpf: Add task and task/file iterator targets")
> Signed-off-by: Yonghong Song <yhs@fb.com>

Applied. Thanks
