Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E128D8534B
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2019 20:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388766AbfHGS54 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Aug 2019 14:57:56 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42710 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388703AbfHGS54 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Aug 2019 14:57:56 -0400
Received: by mail-qk1-f195.google.com with SMTP id 201so66633155qkm.9
        for <bpf@vger.kernel.org>; Wed, 07 Aug 2019 11:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6en4LMEj61ddHU0xSwcWXkZgGtJJnQgZlwhSseT3dQ8=;
        b=fv9i4YLA7ATeJm5K6ltARBABxUI55pRnBZ2Uy303PlfCm02Zs+Wv6FPs/h4Lx3Xg6r
         yLXAUxM7u9nwEOtAiTerHl6DvISMvS1Q31j09O2EYc6kKMJRk1fMX8EZ/doPXr87Rxkm
         dMUK/iHvHpvoI0WFehAG2xG1rzcQ3LRkrjEzu49YRoQAlldb3Kgv5G34j4oah7+5F5pk
         soOh8weRV0Fa7VQh6JcKhWxWHYcdyw8FWmnuGVIu+cTX1D+o+kOnuRrjgffqszH98kBZ
         hcHkMNgSWaXnpKDDRF4rEs+rMwsBSo/3iPpKiPb+PC7GhSCNy5t/ojtVosKnESYZOW4c
         cjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6en4LMEj61ddHU0xSwcWXkZgGtJJnQgZlwhSseT3dQ8=;
        b=gcFauXyhYg4nahcYOAMVNOuBHhnaD4A4NRfYioiDeILdfhpBnriS9VqWpTO20lYl9x
         4vPSMPFq6KJ6UG25guKBUISfVpAaTGgnzSrUVbSo+ZBNgZMbY+BoOnDXCf4utlBngDKc
         8UjXm4+nm3syiNAtDAk2/SSQjbQjUUMWpO5RbHX29xE87UQ5jfQXvXd6ZJiLE7PvT09x
         JJheFU1hLHOifaQgVmcFXHY3rVTfqffabIdsS4jm9VjGA8KYE047bW5OmrkP2xd1TBHa
         Ci3jzczXIc4AFZ78WV0U4U7sU/j5EoCTVjIP4TYNK0fwApQ0XqwGULjQChmOO1iJbAo7
         Kiow==
X-Gm-Message-State: APjAAAVdPkeqhzDPzlJq1qdVzYNocC5BRXPpyBFwMlqL22WQaERqNQq8
        zYkcMKUgbE5NeUKZuS1RNqy5Cmyc8e/eAo4EcqaCvqgCMBpvmw==
X-Google-Smtp-Source: APXvYqwV2xiDYI/RXzzmB7Wn7xKh5mjmnY/MmhHmZ42lLqaSUXPV4OIwwz8Sk08NHpBBmt25jWeuJV6tmdPj69K1bY8=
X-Received: by 2002:a37:bf42:: with SMTP id p63mr9938702qkf.437.1565204275071;
 Wed, 07 Aug 2019 11:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190806234201.6296-1-dxu@dxuuu.xyz>
In-Reply-To: <20190806234201.6296-1-dxu@dxuuu.xyz>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 7 Aug 2019 11:57:44 -0700
Message-ID: <CAEf4BzaQZrEuqqGhFrf1cDiWiUXYDy6x8zAMXayry6H2ow78Og@mail.gmail.com>
Subject: Re: [PATCH 2/3] libbpf: Add helper to extract perf fd from bpf_link
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 6, 2019 at 4:42 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> It is sometimes necessary to perform ioctl's on the underlying perf fd.
> There is not currently a way to extract the fd given a bpf_link, so add a
> helper for it.
> ---

So I've been going back and forth with this approach and the
alternative one, and I think I'm leaning towards the alternative one
still.

I think it's better to have a broad "categories" of bpf_links, e.g.:

- FD-based bpf_link (which is the only one we have right now):
bpf_link_fd. It's not just for perf FD-based ones, raw tracepoint is
not, but it's still FD-based;
- for cgroup-related links (once they are added), it will be
bpf_link_cg (or something along the lines);
- there probably should be separate XDP-related bpf_link with device
ID/name inside;
- etc, whatever we'll need.

Then we can have a set of casting APIs and getter APIs that extract
useful information from specific type of bpf_link. We can also add
direct bpf_link creation API (e.g., from known FD), for cases where it
makes sense.

So something like (in libbpf.h):

struct bpf_link_fd;
struct bpf_link_cg;

/* casting APIs */
const struct bpf_link_fd *bpf_link__as_fd(const struct bpf_link *link);
const struct bpf_link_cg *bpf_link__as_cg(const struct bpf_link *link);

/* getters APIs */
int bpf_link_fd__fd(const struct bpf_link_fd *link);
int bpf_link_cg__cgroup_fd(const struct bpf_link_cg *link);

/* link factories (in addition to attach APIs) */
const struct bpf_link_fd *bpf_link__from_fd(int fd);
const struct bpf_link_cg *bpf_link__from_cg(int cg_fd, /* whatever
else necessary */);

I think this way it becomes obvious what you can expect to get of each
possible type of bpf_link and you'll have to explicitly cast to the
right type. Yet we still hide implementation details, allow no-brainer
bpf_link__destroy regardless of specific type of link (which probably
will be a common case).

Thoughts?

>  tools/lib/bpf/libbpf.c   | 13 +++++++++++++
>  tools/lib/bpf/libbpf.h   |  1 +
>  tools/lib/bpf/libbpf.map |  5 +++++
>  3 files changed, 19 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index ead915aec349..8469d69448ae 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -4004,6 +4004,19 @@ static int bpf_link__destroy_perf_event(struct bpf_link *link)
>         return err;
>  }
>
> +int bpf_link__get_perf_fd(struct bpf_link *link)

this seems like a bit too specific name (and we should avoid "get"
words, as we do in a bunch of other libbpf APIs for getters). Maybe
just `bpf_link__fd`? This especially makes sense with a "file-based
bpf_link" abstraction I proposed above.

> +{
> +       struct bpf_link_fd *l = (void *)link;
> +
> +       if (!link)
> +               return -1;
> +
> +       if (link->destroy != &bpf_link__destroy_perf_event)
> +               return -1;
> +
> +       return l->fd;
> +}
> +
>  struct bpf_link *bpf_program__attach_perf_event(struct bpf_program *prog,
>                                                 int pfd)
>  {
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 8a9d462a6f6d..5391ac95e4fa 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -168,6 +168,7 @@ LIBBPF_API void bpf_program__unload(struct bpf_program *prog);
>  struct bpf_link;
>
>  LIBBPF_API int bpf_link__destroy(struct bpf_link *link);
> +LIBBPF_API int bpf_link__get_perf_fd(struct bpf_link *link);
>
>  LIBBPF_API struct bpf_link *
>  bpf_program__attach_perf_event(struct bpf_program *prog, int pfd);
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index f9d316e873d8..0f844ce29b04 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -184,3 +184,8 @@ LIBBPF_0.0.4 {
>                 perf_buffer__new_raw;
>                 perf_buffer__poll;
>  } LIBBPF_0.0.3;
> +
> +LIBBPF_0.0.5 {
> +       global:
> +               bpf_link__get_perf_fd;
> +} LIBBPF_0.0.4;
> --
> 2.20.1
>
