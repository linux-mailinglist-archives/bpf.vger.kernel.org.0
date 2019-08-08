Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A72886082
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2019 13:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731278AbfHHK7x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Aug 2019 06:59:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:12277 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbfHHK7x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Aug 2019 06:59:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 40FB430BA06F;
        Thu,  8 Aug 2019 10:59:53 +0000 (UTC)
Received: from krava (unknown [10.43.17.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6D0BC605A6;
        Thu,  8 Aug 2019 10:59:43 +0000 (UTC)
Date:   Thu, 8 Aug 2019 12:59:42 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@fb.com,
        daniel@iogearbox.net, yhs@fb.com, andrii.nakryiko@gmail.com,
        kernel-team@fb.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH bpf-next] btf: expose BTF info through sysfs
Message-ID: <20190808105942.GD31775@krava>
References: <20190807183821.138728-1-andriin@fb.com>
 <20190808105558.GB31775@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808105558.GB31775@krava>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 08 Aug 2019 10:59:53 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 08, 2019 at 12:56:01PM +0200, Jiri Olsa wrote:
> On Wed, Aug 07, 2019 at 11:38:21AM -0700, Andrii Nakryiko wrote:
> > Make .BTF section allocated and expose its contents through sysfs.
> > 
> > /sys/kernel/btf directory is created to contain all the BTFs present
> > inside kernel. Currently there is only kernel's main BTF, represented as
> > /sys/kernel/btf/kernel file. Once kernel modules' BTFs are supported,
> > each module will expose its BTF as /sys/kernel/btf/<module-name> file.
> > 
> > Current approach relies on a few pieces coming together:
> > 1. pahole is used to take almost final vmlinux image (modulo .BTF and
> >    kallsyms) and generate .BTF section by converting DWARF info into
> >    BTF. This section is not allocated and not mapped to any segment,
> >    though, so is not yet accessible from inside kernel at runtime.
> > 2. objcopy dumps .BTF contents into binary file and subsequently
> >    convert binary file into linkable object file with automatically
> >    generated symbols _binary__btf_kernel_bin_start and
> >    _binary__btf_kernel_bin_end, pointing to start and end, respectively,
> >    of BTF raw data.
> > 3. final vmlinux image is generated by linking this object file (and
> >    kallsyms, if necessary). sysfs_btf.c then creates
> >    /sys/kernel/btf/kernel file and exposes embedded BTF contents through
> >    it. This allows, e.g., libbpf and bpftool access BTF info at
> >    well-known location, without resorting to searching for vmlinux image
> >    on disk (location of which is not standardized and vmlinux image
> >    might not be even available in some scenarios, e.g., inside qemu
> >    during testing).
> > 
> > Alternative approach using .incbin assembler directive to embed BTF
> > contents directly was attempted but didn't work, because sysfs_proc.o is
> > not re-compiled during link-vmlinux.sh stage. This is required, though,
> > to update embedded BTF data (initially empty data is embedded, then
> > pahole generates BTF info and we need to regenerate sysfs_btf.o with
> > updated contents, but it's too late at that point).
> > 
> > If BTF couldn't be generated due to missing or too old pahole,
> > sysfs_btf.c handles that gracefully by detecting that
> > _binary__btf_kernel_bin_start (weak symbol) is 0 and not creating
> > /sys/kernel/btf at all.
> > 
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> > ---
> >  kernel/bpf/Makefile     |  3 +++
> >  kernel/bpf/sysfs_btf.c  | 52 ++++++++++++++++++++++++++++++++++++++++
> >  scripts/link-vmlinux.sh | 53 ++++++++++++++++++++++++++---------------
> >  3 files changed, 89 insertions(+), 19 deletions(-)
> >  create mode 100644 kernel/bpf/sysfs_btf.c
> > 
> > diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> > index 29d781061cd5..e1d9adb212f9 100644
> > --- a/kernel/bpf/Makefile
> > +++ b/kernel/bpf/Makefile
> > @@ -22,3 +22,6 @@ obj-$(CONFIG_CGROUP_BPF) += cgroup.o
> >  ifeq ($(CONFIG_INET),y)
> >  obj-$(CONFIG_BPF_SYSCALL) += reuseport_array.o
> >  endif
> > +ifeq ($(CONFIG_SYSFS),y)
> > +obj-$(CONFIG_DEBUG_INFO_BTF) += sysfs_btf.o
> > +endif
> > diff --git a/kernel/bpf/sysfs_btf.c b/kernel/bpf/sysfs_btf.c
> > new file mode 100644
> > index 000000000000..ac06ce1d62e8
> > --- /dev/null
> > +++ b/kernel/bpf/sysfs_btf.c
> > @@ -0,0 +1,52 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Provide kernel BTF information for introspection and use by eBPF tools.
> > + */
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/kobject.h>
> > +#include <linux/init.h>
> > +
> > +/* See scripts/link-vmlinux.sh, gen_btf() func for details */
> > +extern char __weak _binary__btf_kernel_bin_start[];
> > +extern char __weak _binary__btf_kernel_bin_end[];
> > +
> > +static ssize_t
> > +btf_kernel_read(struct file *file, struct kobject *kobj,
> > +		struct bin_attribute *bin_attr,
> > +		char *buf, loff_t off, size_t len)
> > +{
> > +	memcpy(buf, _binary__btf_kernel_bin_start + off, len);
> 
> hum, should you check the end of the btf data?
> maybe use the memory_read_from_buffer function instead

nah, looks like that size settings will do that for you
in sysfs_kf_bin_read, nice.. nevermind then ;-)

jirka
