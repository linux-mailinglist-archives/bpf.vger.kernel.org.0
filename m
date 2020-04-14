Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDFE1A8667
	for <lists+bpf@lfdr.de>; Tue, 14 Apr 2020 18:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407324AbgDNQ6J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Apr 2020 12:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407465AbgDNQ6D (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Apr 2020 12:58:03 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0AEC061A0C
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2020 09:58:02 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id r24so568733ljd.4
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2020 09:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0viW9YB2dtX1WFqr7/sv/V0TJY5h+rs1sQFV1oQL6a4=;
        b=r58yveeuQAUdnh0yL94oGE4VBBI+d+OmySg7qmWsSY614k9iQuU+jDxc3ZLBWJR3XW
         9rycIrSgJnSIZ7V5TmxhHoSBBeDMN7AefXUPh9Z4peDkpq99hZdvAQTXzqA0SHT4qjIr
         8eb+xH+qJqjtAxzIbT5nLRkdFrwpKkDK8Y/FGqICntC7gjUyYG4URWKFC/h15UsvPYv/
         qKhwhri1riV4AK1wEXxL0ij3Vpos1hjs4Pr3JDrPxGG/gmav9jZkHDgsMPN9q7whg0e5
         y5dtF3ZsiJVoxww7lF3dDsx2IGK92rJflLt+fAn043kXFvfpNMcyjhA7CTM6GVzBLViw
         jrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0viW9YB2dtX1WFqr7/sv/V0TJY5h+rs1sQFV1oQL6a4=;
        b=Y4Uir4i0/vAfYv3kezj4t40/ICAsMjo7YqUmrPlXTHwDhoM86NwtHJAHNTAg5asSG0
         pe0izEpc2mtJSjyZtJUbKln7sHeP21kuxeVAKaGXZAG2fKSVt7DqUBvWlegTme676tLt
         E9MyHIJEbUxHy5z0mhqTdelsC9KiSXNMFXporRrb39Hbb8yBc3aeJwjlREGv4Xy4M76T
         2MDy3YGGQsnV1UNvwN3yN4yU0nK1Imo7U9aOEn0ZY3suUzRsFOoXLb2QXrqYylqVhCTr
         OMz3dr98HzOTG6m7YTAfb+HqGruwat1+bCY4aUrHoddLxsaNkzYtOjSOWHAxcoqoSLqA
         GuVA==
X-Gm-Message-State: AGi0PubdHqYQUKoc22O9+scVvrpk5ENNYZ0sRnBs8S+jLucMrZs69J3P
        jL0gu7ZAoQcqBXVYEXLeoKd1XWy0uk5YIMQZqkBi5g==
X-Google-Smtp-Source: APiQypK8VEKvTggWzkcETqh+Elb0bDoihC6cVEAN7SeWb/ReCEJnaRO5gfxADkKa4tYkq0YjPaK8fMym2Be/qeUweNI=
X-Received: by 2002:a2e:8999:: with SMTP id c25mr671557lji.73.1586883480555;
 Tue, 14 Apr 2020 09:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200410202613.3679837-1-andriin@fb.com>
In-Reply-To: <20200410202613.3679837-1-andriin@fb.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 14 Apr 2020 18:57:34 +0200
Message-ID: <CAG48ez1xuZyOLVkxsjburqjf3Tm4TR8X6pnavUf=pm_woAxLkw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf 1/2] bpf: prevent re-mmap()'ing BPF map as writable
 for initially r/o mapping
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 10, 2020 at 10:26 PM Andrii Nakryiko <andriin@fb.com> wrote:
> VM_MAYWRITE flag during initial memory mapping determines if already mmap()'ed
> pages can be later remapped as writable ones through mprotect() call. To
> prevent user application to rewrite contents of memory-mapped as read-only and
> subsequently frozen BPF map, remove VM_MAYWRITE flag completely on initially
> read-only mapping.
>
> Alternatively, we could treat any memory-mapping on unfrozen map as writable
> and bump writecnt instead. But there is little legitimate reason to map
> BPF map as read-only and then re-mmap() it as writable through mprotect(),
> instead of just mmap()'ing it as read/write from the very beginning.
>
> Also, at the suggestion of Jann Horn, drop unnecessary refcounting in mmap
> operations. We can just rely on VMA holding reference to BPF map's file
> properly.
>
> Fixes: fc9702273e2e ("bpf: Add mmap() support for BPF_MAP_TYPE_ARRAY")
> Reported-by: Jann Horn <jannh@google.com>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Reviewed-by: Jann Horn <jannh@google.com>

(in the sense that I think this patch is good and correct, but does
not fix the entire problem in the bigger picture)
