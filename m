Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 465033796B
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2019 18:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbfFFQXZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jun 2019 12:23:25 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40186 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729137AbfFFQXZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jun 2019 12:23:25 -0400
Received: by mail-qt1-f194.google.com with SMTP id a15so3338790qtn.7
        for <bpf@vger.kernel.org>; Thu, 06 Jun 2019 09:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mA3T3ar/2wGZM6P7sWOujVG2DdFPOrCJCwXe507sLW8=;
        b=Dyfflg/yGMJ8dmTpg8JsInNihbkMB3vWB+2kiH0XAduKF5b0JNlla+Yv4i+a1tWzfW
         H+g2Z2PUcFIAdoCoHjWYSGKoa04QX3yQemOCLaxeJdOjl3cXN4l2aw7vXLZUgAA0AhHY
         aSmXmzhKMPMVFwkxrWRl5Hqo+Dhm1ETcoD8mJipIVIxFo2q1QIplalq8vcuvMo6rkwPt
         05fo7/beuqsdKkRCI/OFERGVP9f7oiSKlUoo/sq9u9pND6bmBX0kUZlsZXNVUOtNxTsD
         2Pvwjce0DfGia8BSflPXJTkHli2NW+4duvCsy+kozvxMjjjcSzbZ1fNAVEmwdhwZEu4H
         avvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mA3T3ar/2wGZM6P7sWOujVG2DdFPOrCJCwXe507sLW8=;
        b=kk0UTa3Dr2jzm5g1E06TYQJlzhIXsZtkoj1V4Z5oWQYVxp25L+7k96T+VfQLw7faEr
         RfpIbvIMhe3WoQe70xweeY5sSswSLabLwyhX4KKUIHUKjhISygG1DeS9ZS1JtGf7KoEl
         xCtKwf6kCgklynTjFeBLho8X6lzB8x1/JtG//3rxkgx7nji9tVqiYTweg0V2i5ak+9Pg
         H/PGwA02rLkhGdkKv8TLGU2qF8qQwvOnH/Aa1JULz1oRzmUAc21m0GUDDGFxUvaY2Yaw
         wTV4L2svqFSkeuP/DRePFQUwqYpKV4re8YugUP6Zc/D3mPEoB2717p3EuF8YW9W4F6KO
         9z5Q==
X-Gm-Message-State: APjAAAXxr72d4ZTtIxVaBimHU9PPCp7upLbkFu470uhsBAMErLm8MzB6
        jmcvUdN0adlX2Ne0T3AKBn2v9SsilwYfq58aCoQ0bvUd
X-Google-Smtp-Source: APXvYqz0BuBxeHxaiPRzEs3/nqeZNe+5XMFGQyB/vjD+2g3oRsKYCsotctj8E1jVDPxppW8hBSvQTcsdXyxsuf/c7HQ=
X-Received: by 2002:ac8:21b7:: with SMTP id 52mr23877049qty.59.1559838203841;
 Thu, 06 Jun 2019 09:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190605231506.2983988-1-hechaol@fb.com> <20190605231506.2983988-2-hechaol@fb.com>
 <7A5FA7F0-AD1C-401B-A1F6-EB46BF9E93B7@fb.com>
In-Reply-To: <7A5FA7F0-AD1C-401B-A1F6-EB46BF9E93B7@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 6 Jun 2019 09:23:12 -0700
Message-ID: <CAEf4BzaY9oZxERBpq4xxYYZt=Dtn-9QafhO-DVOija+1BRCZig@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpf: add a new API libbpf_num_possible_cpus()
To:     Song Liu <songliubraving@fb.com>
Cc:     Hechao Li <hechaol@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 5, 2019 at 10:46 PM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On Jun 5, 2019, at 4:15 PM, Hechao Li <hechaol@fb.com> wrote:
> >
> > Adding a new API libbpf_num_possible_cpus() that helps user with
> > per-CPU map operations.
> >
> > Signed-off-by: Hechao Li <hechaol@fb.com>

Your patches didn't get into mailing list. I had this problem before,
for me the issue was fixed by trimming the CC list to a minimum, maybe
try that? You should also probably include netdev@vger.kernel.org,
btw.

> > ---
> > tools/lib/bpf/libbpf.c   | 49 ++++++++++++++++++++++++++++++++++++++++
> > tools/lib/bpf/libbpf.h   | 16 +++++++++++++
> > tools/lib/bpf/libbpf.map |  1 +
> > 3 files changed, 66 insertions(+)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index ba89d9727137..580b14307237 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -3827,3 +3827,52 @@ void bpf_program__bpil_offs_to_addr(struct bpf_prog_info_linear *info_linear)
> >                                            desc->array_offset, addr);
> >       }
> > }
> > +
> > +int libbpf_num_possible_cpus(void)
> > +{
> > +     static const char *fcpu = "/sys/devices/system/cpu/possible";
> > +     static int cpus;
> > +     char buf[128];
> > +     int len = 0, n = 0, il = 0, ir = 0;
> > +     int fd = -1;
> > +     unsigned int start = 0, end = 0;

Please sort from longest line length to shortest (so-called "reverse
Christmas tree").

> > +
> > +     if (cpus > 0)
> > +             return cpus;
> > +
> > +     fd = open(fcpu, O_RDONLY);
> > +     if (fd < 0) {
> > +             pr_warning("Failed to open file %s\n", fcpu);
> > +             return -errno;

pr_warning can call into user-specified callback function, which can
perform some actions that will clobber errno variable. So you should
save errno before pr_warning. Also, it's useful to include errno in
error message itself.

> > +     }
> > +     len = read(fd, buf, sizeof(buf));
> > +     close(fd);
> > +     if (len <= 0) {
> > +             pr_warning("Failed to read number of possible cpus from %s\n",
> > +                        fcpu);
> > +             return -errno;

Same about errno saving.

> > +     }
> > +     if (len == sizeof(buf)) {
> > +             pr_warning("File: %s size overflow\n", fcpu);
> > +             return -EOVERFLOW;
> > +     }
> > +     buf[len] = '\0';
> > +
> > +     for (ir = 0, cpus = 0; ir <= len; ir++) {
> > +             /* Each sub string separated by ',' has format \d+-\d+ or \d+ */
> > +             if (buf[ir] == ',' || buf[ir] == '\0') {
> > +                     buf[ir] = '\0';
> > +                     n = sscanf(&buf[il], "%u-%u", &start, &end);
> > +                     if (n <= 0) {
> > +                             pr_warning("Failed to get # CPUs from %s\n",
> > +                                        &buf[il]);
> > +                             return -EINVAL;
> > +                     } else if (n == 1) {
> > +                             end = start;
> > +                     }
> > +                     cpus += end - start + 1;
> > +                     il = ir + 1;
> > +             }
> > +     }
> > +     return cpus;
> > +}
> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > index 1af0d48178c8..f5e82eb2e5d4 100644
> > --- a/tools/lib/bpf/libbpf.h
> > +++ b/tools/lib/bpf/libbpf.h
> > @@ -454,6 +454,22 @@ bpf_program__bpil_addr_to_offs(struct bpf_prog_info_linear *info_linear);
> > LIBBPF_API void
> > bpf_program__bpil_offs_to_addr(struct bpf_prog_info_linear *info_linear);
> >
> > +/*
> > + * A helper function to get the number of possible CPUs before looking up
> > + * per-CPU maps. Negative errno is returned on failure.
> > + *
> > + * Example usage:
> > + *
> > + *     int ncpus = libbpf_num_possible_cpus();
> > + *     if (ncpus <= 0) {
> > + *          // error handling
> > + *     }
> > + *     long values[ncpus];
> > + *     bpf_map_lookup_elem(per_cpu_map_fd, key, values);
> > + *
> > + */
> > +LIBBPF_API int libbpf_num_possible_cpus(void);
> > +
> > #ifdef __cplusplus
> > } /* extern "C" */
> > #endif
> > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > index 46dcda89df21..7f76d19cb02b 100644
> > --- a/tools/lib/bpf/libbpf.map
> > +++ b/tools/lib/bpf/libbpf.map
> > @@ -172,4 +172,5 @@ LIBBPF_0.0.4 {
> >               btf_dump__new;
> >               btf__parse_elf;
> >               bpf_object__load_xattr;
> > +    libbpf_num_possible_cpus;
>
> Please indent with tab instead of space.
>
> Thanks,
> Song
>
> > } LIBBPF_0.0.3;
> > --
> > 2.17.1
> >
>
