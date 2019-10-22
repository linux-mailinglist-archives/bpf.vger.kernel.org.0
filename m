Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA3B5E0C2C
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2019 21:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732436AbfJVTEU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 22 Oct 2019 15:04:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51434 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732564AbfJVTEU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Oct 2019 15:04:20 -0400
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C1778C057EC6
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2019 19:04:18 +0000 (UTC)
Received: by mail-lj1-f198.google.com with SMTP id m81so3155093lje.4
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2019 12:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=XifPNrADzGzfAz6u7lDnhoxqW1rIo8G+xaF/aFSdbN8=;
        b=uABndY9dDNylQ1ysJ0dUF/21uZWYjofAK3EbwBfRMh5ojoAx3C/qTyHeMM2MIA9MIB
         RSL4kiTHi7rAN1jb6diFM7Nm6uRKZVxuNPvnme40olLq20CktlumjVXMuk+Sol7/dGRC
         cwL/8NQ+vN/jDYzn8t0EEh9IPkDGG5hjrNbslYq4mc7s2J0VjBqDsz0QxJo9BdWwRaf4
         wHF5I2dILmelwFFpoKRS+mcm/rSMklHNG5QZnOzf4xnmWTHjPRKrhhn3YUtf4RfVeIzo
         1Hd49+g171LI/6Eokra8h1CDa3RcuzgaqB28dqJGFm2MlTYzE3lnuTMm2QybmhBp6QEJ
         ZJgQ==
X-Gm-Message-State: APjAAAV0kFTZuY32wM5v9NBe7UJY2/6ip7pzSCGlJ2tc9BwjdEi7Cs4q
        NnokBdcbHjQ2SCyU08Ccn8IXzPaeK38pSbbfsDlkmzZQKr7fRe4HzX6ow5OTzeNgufQBbE5FbOS
        phIbmduN6Mv/6
X-Received: by 2002:a2e:700f:: with SMTP id l15mr2618251ljc.69.1571771057167;
        Tue, 22 Oct 2019 12:04:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwhBg5np+tTxbSkgYz9zKDtSqFUmBDIkRA0+IO+NSsKy/8BO3RG7lg7KyrGdBnSsBAYX43Kuw==
X-Received: by 2002:a2e:700f:: with SMTP id l15mr2618235ljc.69.1571771056960;
        Tue, 22 Oct 2019 12:04:16 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id o196sm6936558lff.59.2019.10.22.12.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 12:04:16 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 969DC1804B1; Tue, 22 Oct 2019 21:04:15 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 3/3] libbpf: Add pin option to automount BPF filesystem before pinning
In-Reply-To: <CAEf4BzbfV5vrFnkNyG35Db2iPmM2ubtFh6OTvLiaetAx6eFHHw@mail.gmail.com>
References: <157175668770.112621.17344362302386223623.stgit@toke.dk> <157175669103.112621.7847833678119315310.stgit@toke.dk> <CAEf4BzbfV5vrFnkNyG35Db2iPmM2ubtFh6OTvLiaetAx6eFHHw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 22 Oct 2019 21:04:15 +0200
Message-ID: <8736fkob4g.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Tue, Oct 22, 2019 at 9:08 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>
>> From: Toke Høiland-Jørgensen <toke@redhat.com>
>>
>> While the current map pinning functions will check whether the pin path is
>> contained on a BPF filesystem, it does not offer any options to mount the
>> file system if it doesn't exist. Since we now have pinning options, add a
>> new one to automount a BPF filesystem at the pinning path if that is not
>
> Next thing we'll be adding extra options to mount BPF FS... Can we
> leave the task of auto-mounting BPF FS to tools/applications?

Well, there was a reason I put this into a separate patch: I wasn't sure
it really fit here. My reasoning is the following: If we end up with a
default auto-pinning that works really well, people are going to just
use that. And end up really confused when bpffs is not mounted. And it
seems kinda silly to make every application re-implement the same mount
check and logic.

Or to put it another way: If we agree that the reasonable default thing
is to just pin things in /sys/fs/bpf, let's make it as easy as possible
for applications to do that right.

>> already pointing at a bpffs.
>>
>> The mounting logic itself is copied from the iproute2 BPF helper functions.
>>
>> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
>> ---
>>  tools/lib/bpf/libbpf.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
>>  tools/lib/bpf/libbpf.h |    5 ++++-
>>  2 files changed, 51 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index aea3916de341..f527224bb211 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -37,6 +37,7 @@
>>  #include <sys/epoll.h>
>>  #include <sys/ioctl.h>
>>  #include <sys/mman.h>
>> +#include <sys/mount.h>
>>  #include <sys/stat.h>
>>  #include <sys/types.h>
>>  #include <sys/vfs.h>
>> @@ -4072,6 +4073,35 @@ int bpf_map__unpin(struct bpf_map *map, const char *path)
>>         return 0;
>>  }
>>
>> +static int mount_bpf_fs(const char *target)
>> +{
>> +       bool bind_done = false;
>> +
>> +       while (mount("", target, "none", MS_PRIVATE | MS_REC, NULL)) {
>
> what does this loop do? we need some comments explaining what's going
> on here

Well, as it says in the commit message I stole this from iproute2. I
think the "--make-private, --bind" dance is there to make sure we don't
mess up some other mount points at this path. Which seems like a good
idea, and one of those things that most people probably won't think
about when just writing an application that wants to mount the fs; which
is another reason to put this into libbpf :)

>> +               if (errno != EINVAL || bind_done) {
>> +                       pr_warning("mount --make-private %s failed: %s\n",
>> +                                  target, strerror(errno));
>> +                       return -1;
>> +               }
>> +
>> +               if (mount(target, target, "none", MS_BIND, NULL)) {
>> +                       pr_warning("mount --bind %s %s failed: %s\n",
>> +                                  target, target, strerror(errno));
>> +                       return -1;
>> +               }
>> +
>> +               bind_done = true;
>> +       }
>> +
>> +       if (mount("bpf", target, "bpf", 0, "mode=0700")) {
>> +               fprintf(stderr, "mount -t bpf bpf %s failed: %s\n",
>> +                       target, strerror(errno));
>> +               return -1;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>  static int get_pin_path(char *buf, size_t buf_len,
>>                         struct bpf_map *map, struct bpf_object_pin_opts *opts,
>>                         bool mkdir)
>> @@ -4102,6 +4132,23 @@ static int get_pin_path(char *buf, size_t buf_len,
>
> Nothing in `get_pin_path` indicates that it's going to do an entire FS
> mount, please split this out of get_pin_path.

Regardless of the arguments above, that is certainly a fair point ;)

-Toke
