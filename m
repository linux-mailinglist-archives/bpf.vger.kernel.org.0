Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4AC38F38D
	for <lists+bpf@lfdr.de>; Mon, 24 May 2021 21:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbhEXTUi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 May 2021 15:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbhEXTUi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 May 2021 15:20:38 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E51C061574;
        Mon, 24 May 2021 12:19:06 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id z38so9978473ybh.5;
        Mon, 24 May 2021 12:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xd/yXDHNb6D7Ukwwn0vW+rBzOCwfwBDPDWyCSOxnYTA=;
        b=ie58DikHaTNENzqD+k+xLfF/LvQMNMDDfYdGcLOiq1UIjKisqA2n5MgEjS4yFc293V
         +y0mKngP1ZQsxmsk2wjtr33E+hqEw1yhn3RWzVlZgeONxNOZCGYGVVMsKCONRIJTcNzm
         TpJVXU6TwqHcA4NqQgqIquJlHHSoshbvnk0oG/YhNfJGahRNRhfvR/vwGXGnS67v/pBd
         kJIOgXLRtm7ToKDt66LMjQtMwJohI95bN7LTjQDKEFWA3xs1ChSqO0dKbnUJ8pxc2iA/
         QlG+eyumqSGsizgyWyE7ckAmLnQWzKGvGp+K366yirtI2vInciuqj1QtGydJYCqcpLfZ
         WrxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xd/yXDHNb6D7Ukwwn0vW+rBzOCwfwBDPDWyCSOxnYTA=;
        b=AZBWMVz+HTggyABGrxT6wrnTPWJSCH4ryzFIoKFTp1bvt8bdLZlYxpKxXoSv2eDtQ1
         d5FZIhAMoNvDqzLfjdI8a6wsZaXaP63QYcdhMtTn3imlueH3HvJJdtPHKfJgICDd+NC2
         pcnR4k0hNgQvAVhOSUtcBbdALx17V5TyxYeJqNC2uT7lLujQtA0hgYzLms5S9Yf6pwc2
         Aze2cTOQ87y5/B1todOkFa2AEWp16tc9da0I/0DL1veDB5+AHERMpSpKSkZr5Y3WWYeu
         hxjxNlwnDtJe3f7+bTzMdngWupUkJhn02faIXNt+4ps+XZXRTFCnGgrqIyIe4allFyMl
         J2rQ==
X-Gm-Message-State: AOAM533VT6cXEel0ymZkRkPZu5ztoJ7qKxuVoAr6fOmnOTZVH015EA9z
        rclS1mN3pCYSIdWG3UEKjlVuFnYN/yDQpjSxtL4=
X-Google-Smtp-Source: ABdhPJznjMvBitRxqf/gI/GgOAY/m9LQX2n1Xb6b+WADgBi7WwFmtqHgIN8cladjkyFPzn00Hvwc3CCqL4bVhANLQtE=
X-Received: by 2002:a5b:286:: with SMTP id x6mr38984800ybl.347.1621883945785;
 Mon, 24 May 2021 12:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210521234203.1283033-1-andrii@kernel.org> <60ab496e3e211_2a2cf208d2@john-XPS-13-9370.notmuch>
In-Reply-To: <60ab496e3e211_2a2cf208d2@john-XPS-13-9370.notmuch>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 24 May 2021 12:18:54 -0700
Message-ID: <CAEf4BzY0=J1KP4txDSVJdS93YVLxO8LLQTn0UCJ0RKDL_XzpYw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] libbpf: error reporting changes for v1.0
To:     John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, May 23, 2021 at 11:36 PM John Fastabend
<john.fastabend@gmail.com> wrote:
>
> Andrii Nakryiko wrote:
> > Implement error reporting changes discussed in "Libbpf: the road to v1.0"
> > ([0]) document.
> >
> > Libbpf gets a new API, libbpf_set_strict_mode() which accepts a set of flags
> > that turn on a set of libbpf 1.0 changes, that might be potentially breaking.
> > It's possible to opt-in into all current and future 1.0 features by specifying
> > LIBBPF_STRICT_ALL flag.
> >
> > When some of the 1.0 "features" are requested, libbpf APIs might behave
> > differently. In this patch set a first set of changes are implemented, all
> > related to the way libbpf returns errors. See individual patches for details.
> >
> > Patch #1 adds a no-op libbpf_set_strict_mode() functionality to enable
> > updating selftests.
> >
> > Patch #2 gets rid of all the bad code patterns that will break in libbpf 1.0
> > (exact -1 comparison for low-level APIs, direct IS_ERR() macro usage to check
> > pointer-returning APIs for error, etc). These changes make selftest work in
> > both legacy and 1.0 libbpf modes. Selftests also opt-in into 100% libbpf 1.0
> > mode to automatically gain all the subsequent changes, which will come in
> > follow up patches.
> >
> > Patch #3 streamlines error reporting for low-level APIs wrapping bpf() syscall.
> >
> > Patch #4 streamlines errors for all the rest APIs.
> >
> > Patch #5 ensures that BPF skeletons propagate errors properly as well, as
> > currently on error some APIs will return NULL with no way of checking exact
> > error code.
> >
> >   [0] https://docs.google.com/document/d/1UyjTZuPFWiPFyKk1tV5an11_iaRuec6U-ZESZ54nNTY
> >
> > Andrii Nakryiko (5):
> >   libbpf: add libbpf_set_strict_mode() API to turn on libbpf 1.0
> >     behaviors
> >   selftests/bpf: turn on libbpf 1.0 mode and fix all IS_ERR checks
> >   libbpf: streamline error reporting for low-level APIs
> >   libbpf: streamline error reporting for high-level APIs
> >   bpftool: set errno on skeleton failures and propagate errors
> >
>
> LGTM for the series,
>
> Acked-by: John Fastabend <john.fastabend@gmail.com>

Thanks, John!

Toke, Stanislav, you cared about these aspects of libbpf 1.0 (by
commenting on the doc itself), do you mind also taking a brief look
and letting me know if this works for your use cases? Thanks!
