Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683CF46FF78
	for <lists+bpf@lfdr.de>; Fri, 10 Dec 2021 12:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbhLJLMG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Dec 2021 06:12:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54244 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231180AbhLJLMF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Dec 2021 06:12:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639134510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4xbGbNgGCdDqEZwodyUP9CTgYwoBfaLX1Sq05rCZIB4=;
        b=XXqJOKxNwrmTlYlbQV4IRLbm2kx41jSDzLBh1xN0gu+oj0XXr8Ik0ki1KNjkgipIZeh7xG
        B7R2NlZrmbdYiShPZqMiFJH800j7FIpVcmcuXb3CNifcqsAaLYMOQZKLCBerrFr6XJlfHO
        OyU021gPU9Phv+g1YlJERCkv1Q6nj6o=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-146-cxWDIns5OfiAmDRiA8Gofg-1; Fri, 10 Dec 2021 06:08:29 -0500
X-MC-Unique: cxWDIns5OfiAmDRiA8Gofg-1
Received: by mail-ed1-f69.google.com with SMTP id y9-20020aa7c249000000b003e7bf7a1579so7916398edo.5
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 03:08:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=4xbGbNgGCdDqEZwodyUP9CTgYwoBfaLX1Sq05rCZIB4=;
        b=BK7zvrPc5yY0yGL/cRQwXgEWVkUONeCCoMX8ROSulLJq2aLXl3di+VrIokTwSgkCtz
         Y4pwo6jAQJpHPzEFKl5OcZll/sRRLiVv1CztoPMOxX2e9/dKyg5XJCR2U8JP/0hwZfBb
         5wzfmv+DyXwE5fEm8z6aK4xulM3fNmifqT+JkDTjDEiChQhTcPbRPJWEKVGPDEJURkX8
         cXHucMl3bJ+S+tuqIyzfq05PeNHf6Xm+CitGbhM+GoqEKbVoxEZaT4hNhboyKSL0Rhyj
         eXpFa2zRCGIQQFFJl9DQv2uJ6udhNMvN4z8igDktCtaUkJTOlhN5uRnqoobYnX4Pqs6n
         V2UA==
X-Gm-Message-State: AOAM530oEdX6RrTEZF2nYSr6cUg+Za+X1B0mewtYvpoIBlK17FagoS4S
        ZTwqy9Da3HHdrFaj8JLv6VDqHP4SgfgMXGyvmdB+z0ieB65JIDaQQNdNRLgnnIUJcqYzhrA+IPd
        niRcUJduplXwm
X-Received: by 2002:a17:907:7d8f:: with SMTP id oz15mr22405920ejc.245.1639134507414;
        Fri, 10 Dec 2021 03:08:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyJjxABhtsQAvl8GZuK1JBbRRVG/Ewh29EnhSc7qwcg4yMmfNeapGiJD97W5LF4zDjTK+IFEw==
X-Received: by 2002:a17:907:7d8f:: with SMTP id oz15mr22405708ejc.245.1639134505291;
        Fri, 10 Dec 2021 03:08:25 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id nc29sm1290907ejc.3.2021.12.10.03.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 03:08:24 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 16959180450; Fri, 10 Dec 2021 12:08:24 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     andrii@kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 1/2] libbpf: auto-bump RLIMIT_MEMLOCK if kernel
 needs it for BPF
In-Reply-To: <20211210061517.642835-1-andrii@kernel.org>
References: <20211210061517.642835-1-andrii@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 10 Dec 2021 12:08:24 +0100
Message-ID: <87fsr0wwd3.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii@kernel.org> writes:

> The need to increase RLIMIT_MEMLOCK to do anything useful with BPF is
> one of the first extremely frustrating gotchas that all new BPF users go
> through and in some cases have to learn it a very hard way.
>
> Luckily, starting with upstream Linux kernel version 5.11, BPF subsystem
> dropped the dependency on memlock and uses memcg-based memory accounting
> instead. Unfortunately, detecting memcg-based BPF memory accounting is
> far from trivial (as can be evidenced by this patch), so in practice
> most BPF applications still do unconditional RLIMIT_MEMLOCK increase.
>
> As we move towards libbpf 1.0, it would be good to allow users to forget
> about RLIMIT_MEMLOCK vs memcg and let libbpf do the sensible adjustment
> automatically. This patch paves the way forward in this matter. Libbpf
> will do feature detection of memcg-based accounting, and if detected,
> will do nothing. But if the kernel is too old, just like BCC, libbpf
> will automatically increase RLIMIT_MEMLOCK on behalf of user
> application ([0]).
>
> As this is technically a breaking change, during the transition period
> applications have to opt into libbpf 1.0 mode by setting
> LIBBPF_STRICT_AUTO_RLIMIT_MEMLOCK bit when calling
> libbpf_set_strict_mode().
>
> Libbpf allows to control the exact amount of set RLIMIT_MEMLOCK limit
> with libbpf_set_memlock_rlim_max() API. Passing 0 will make libbpf do
> nothing with RLIMIT_MEMLOCK. libbpf_set_memlock_rlim_max() has to be
> called before the first bpf_prog_load(), bpf_btf_load(), or
> bpf_object__load() call, otherwise it has no effect and will return
> -EBUSY.
>
>   [0] Closes: https://github.com/libbpf/libbpf/issues/369
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/bpf.c             | 122 ++++++++++++++++++++++++++++++++
>  tools/lib/bpf/bpf.h             |   2 +
>  tools/lib/bpf/libbpf.c          |  47 +++---------
>  tools/lib/bpf/libbpf.map        |   1 +
>  tools/lib/bpf/libbpf_internal.h |  39 ++++++++++
>  tools/lib/bpf/libbpf_legacy.h   |  12 +++-
>  6 files changed, 184 insertions(+), 39 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 4e7836e1a7b5..5b14111b80dd 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -29,6 +29,7 @@
>  #include <errno.h>
>  #include <linux/bpf.h>
>  #include <limits.h>
> +#include <sys/resource.h>
>  #include "bpf.h"
>  #include "libbpf.h"
>  #include "libbpf_internal.h"
> @@ -94,6 +95,119 @@ static inline int sys_bpf_prog_load(union bpf_attr *attr, unsigned int size, int
>  	return fd;
>  }
>  
> +/* Probe whether kernel switched from memlock-based (RLIMIT_MEMLOCK) to
> + * memcg-based memory accounting for BPF maps and progs. This was done in [0],
> + * but it's not straightforward to detect those changes from the user-space.
> + * So instead we'll try to detect whether [1] is in the kernel, which follows
> + * [0] almost immediately and made it into the upstream kernel in the same
> + * release.
> + *
> + * For this, we'll upload a trivial BTF into the kernel and will try to load
> + * a trivial BPF program with attach_btf_obj_fd pointing to our BTF. If it
> + * returns anything but -EOPNOTSUPP, we'll assume we still need
> + * RLIMIT_MEMLOCK.
> + *
> + *   [0] https://lore.kernel.org/bpf/20201201215900.3569844-1-guro@fb.com/
> + *   [1] Fixes: 8bdd8e275ede ("bpf: Return -ENOTSUPP when attaching to non-kernel BTF")
> + */
> +int probe_memcg_account(void)
> +{
> +	const size_t bpf_load_attr_sz = offsetofend(union bpf_attr, attach_btf_obj_fd);
> +	const size_t btf_load_attr_sz = offsetofend(union bpf_attr, btf_log_level);
> +	int prog_fd = -1, btf_fd = -1, err;
> +	struct bpf_insn insns[1] = {}; /* instructions don't matter */
> +	const void *btf_data;
> +	union bpf_attr attr;
> +	__u32 btf_data_sz;
> +	struct btf *btf;
> +
> +	/* create the simplest BTF object and upload it into the kernel */
> +	btf = btf__new_empty();
> +	err = libbpf_get_error(btf);
> +	if (err)
> +		return err;
> +	err = btf__add_int(btf, "int", 4, 0);
> +	btf_data = btf__raw_data(btf, &btf_data_sz);
> +	if (!btf_data) {
> +		err = -ENOMEM;
> +		goto cleanup;
> +	}
> +
> +	/* we won't use bpf_btf_load() or bpf_prog_load() because they will
> +	 * be trying to detect this feature and will cause an infinite loop
> +	 */
> +	memset(&attr, 0, btf_load_attr_sz);
> +	attr.btf = ptr_to_u64(btf_data);
> +	attr.btf_size = btf_data_sz;
> +	btf_fd = sys_bpf_fd(BPF_BTF_LOAD, &attr, btf_load_attr_sz);
> +	if (btf_fd < 0) {
> +		err = -errno;
> +		goto cleanup;
> +	}
> +
> +	/* attempt loading freplace trying to use custom BTF */
> +	memset(&attr, 0, bpf_load_attr_sz);
> +	attr.prog_type = BPF_PROG_TYPE_TRACING;
> +	attr.expected_attach_type = BPF_TRACE_FENTRY;
> +	attr.insns = ptr_to_u64(insns);
> +	attr.insn_cnt = sizeof(insns) / sizeof(insns[0]);
> +	attr.license = ptr_to_u64("GPL");
> +	attr.attach_btf_obj_fd = btf_fd;
> +
> +	prog_fd = sys_bpf_fd(BPF_PROG_LOAD, &attr, bpf_load_attr_sz);
> +	if (prog_fd >= 0)
> +		/* bug? we shouldn't be able to successfully load program */
> +		err = -EFAULT;
> +	else
> +		/* assume memcg accounting is supported if we get -EOPNOTSUPP */
> +		err = errno == 524 /* ENOTSUPP */ ? 1 : 0;

Nit: comment and code seems to be in disagreement over the name of the
error code here.

(side note, since we've ended up using ENOTSUPP everywhere in BPF, any
reason we can't export it in a UAPI header somewhere?)

-Toke

