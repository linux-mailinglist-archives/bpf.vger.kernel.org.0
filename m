Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C12C459ACA
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 04:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhKWD5H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 22:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhKWD5H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 22:57:07 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8A2C061574;
        Mon, 22 Nov 2021 19:53:59 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id v138so55812852ybb.8;
        Mon, 22 Nov 2021 19:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m58MbGaKoYr9PEivJVyq/ojllCseYO0HzHz7X5Tr9K0=;
        b=DCrBhTXm/zUawfZI3/yK2rBsQAS30dJhB5UNJ1850WuTkYlnrt0X6wH6mHvUT9jEY1
         E/jB96g9KG0ovzQfNRYpz3rQb0fNNOLw8vSbnq+A2ASuTcA9Sg+3kkkY3EE35hLlT+rX
         YvudamMWvSVZLYi3CmX5yJ4HRhG0Tj1z0fRxC2uJRaXE6FbCBPWgtZc7UmfG7UDwUUTl
         6jVRvCuGebZTCWvin2z2blrjQo06fR3Z9uyGuVo3iA1PJNEZWTvKDnjEs+59Kl0AEnl3
         kQUANj9/3eZNWQpxztWV1/xpNMWWb5jwN5UynH6LYYBT6+MaTt65X3JgzuPZjKZ8XLRj
         23kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m58MbGaKoYr9PEivJVyq/ojllCseYO0HzHz7X5Tr9K0=;
        b=27pdpooMY+LeMhiPIYVPrhca3exfjKNTRvpnUh1tv8egLBE01QoQesLkJ2o0Wj/pBU
         OPW2KHWrfKusF/UNLwyBCzHp3sbwKwNwWSMm9dXNVM7iIaGalgzH+Z0QHcIsLJ1Z37xY
         MINV9Dq09Iyz6SvQrLO3DLQXgHFsdTsGTFRqMGj0Y6yoJkJJgIsDUshOJtlSR9Y+yLq1
         feG36J0nMJNI0c+TdykpbV7kBGzLiYPrTnyLQnuDOH4/kGOttC6GTCIU47w7cNAMf4Mp
         fVdt9rEGkzri6ntTdlVLR7jupQXpKVueOWXcY3GGSmumuod7RMR0GnQGAShWz6T3/vFH
         Z2MQ==
X-Gm-Message-State: AOAM530b9Rl1ad6GEQIKGbvj8ayO5fVQHCwemhJT+n/SmDxUcRTaUAko
        5HXc7RPpXTbiglopoSXlDnDocDrLbIRfBG/0ZwJrTpOsJ0YZ2g==
X-Google-Smtp-Source: ABdhPJyHV3ww2k8xcwvWb/5wIpgZUKzXYUbJHzAWgBCaTytnOD6cfcAdpMF4cdr3toJHmT3TcQLFYoIV7xAVczc1nf8=
X-Received: by 2002:a25:42c1:: with SMTP id p184mr2354758yba.433.1637639638800;
 Mon, 22 Nov 2021 19:53:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1637601045.git.dave@dtucker.co.uk> <5da383bc01c66e6c1342cdb2b3dc53196214e003.1637601045.git.dave@dtucker.co.uk>
In-Reply-To: <5da383bc01c66e6c1342cdb2b3dc53196214e003.1637601045.git.dave@dtucker.co.uk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 22 Nov 2021 19:53:47 -0800
Message-ID: <CAEf4BzYXR4hDZg_7DF9RcswM6vJ0G1xVuGLRhQjDyJWEKeYSHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf, docs: document BPF_MAP_TYPE_ARRAY
To:     Dave Tucker <dave@dtucker.co.uk>
Cc:     bpf <bpf@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 22, 2021 at 9:19 AM Dave Tucker <dave@dtucker.co.uk> wrote:
>
> This commit adds documentation for the BPF_MAP_TYPE_ARRAY including
> kernel version introduced, usage and examples.
> It also documents BPF_MAP_TYPE_PERCPU_ARRAY since this is similar.
>
> Signed-off-by: Dave Tucker <dave@dtucker.co.uk>
> ---
>  Documentation/bpf/map_array.rst | 150 ++++++++++++++++++++++++++++++++
>  1 file changed, 150 insertions(+)
>  create mode 100644 Documentation/bpf/map_array.rst
>
> diff --git a/Documentation/bpf/map_array.rst b/Documentation/bpf/map_array.rst
> new file mode 100644
> index 000000000000..f9eb5473a240
> --- /dev/null
> +++ b/Documentation/bpf/map_array.rst
> @@ -0,0 +1,150 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +.. Copyright (C) 2021 Red Hat, Inc.
> +
> +================================================
> +BPF_MAP_TYPE_ARRAY and BPF_MAP_TYPE_PERCPU_ARRAY
> +================================================
> +
> +.. note:: ``BPF_MAP_TYPE_ARRAY`` was introduced in Kernel version 3.19 and ``BPF_MAP_TYPE_PERCPU_ARRAY`` in version 4.6
> +
> +``BPF_MAP_TYPE_ARRAY`` and ``BPF_MAP_TYPE_PERCPU_ARRAY`` provide generic array storage.
> +The key type is an unsigned 32-bit integer (4 bytes) and the map is of constant size.
> +All array elements are pre-allocated and zero initialized when created.
> +``BPF_MAP_TYPE_PERCPU_ARRAY`` uses a different memory region for each CPU whereas
> +``BPF_MAP_TYPE_ARRAY`` uses the same memory region.
> +The maximum size of an array, defined in max_entries, is limited to 2^32.
> +The value stored can be of any size, however, small values will be rounded up to 8 bytes.
> +
> +Usage
> +=====
> +
> +Array elements can be retrieved using the ``bpf_map_lookup_elem()`` helper.
> +This helper returns a pointer into the array element, so to avoid data races with userspace reading the value,
> +the user must use primitives like ``__sync_fetch_and_add()`` when updating the value in-place.
> +Access from userspace uses the libbpf API of the same name.
> +
> +Array elements can also be added using the ``bpf_map_update_elem()`` helper or libbpf API.
> +
> +Since the array is of constant size, ``bpf_map_delete_elem()`` is not supported.
> +To clear an array element, you may use ``bpf_map_update_eleme()`` to insert a zero value to that index.
> +
> +Values stored in ``BPF_MAP_TYPE_ARRAY`` can be accessed by multiple programs across different CPUs.
> +To restrict storage to a single CPU, you may use a ``BPF_MAP_TYPE_PERCPU_ARRAY``.
> +Since Kernel version 5.1, the BPF infrastructure provides ``struct bpf_spin_lock`` to synchronize access.
> +

It would be good to also mention BPF_F_MMAPABLE flag and ability to
mmap() contents of BPF_MAP_TYPE_ARRAY created with such a flag. We
need to double-check, but there might be also a restriction to have
value_size be a multiple of page size in such case, we need to consult
the code.


> +```bpf_map_get_next_key()`` can be used to iterate over array values.
> +
> +Examples
> +========
> +
> +Please see the `bpf/samples`_ directory for functional examples.

Let's point to tools/testing/selftests/bpf for functional examples.
It's much more complete and more actively maintained and tested.

> +This sample code simply demonstrates the API.
> +
> +.. section links
> +.. _bpf/samples:
> +    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/samples/bpf/
> +
> +Kernel
> +------
> +
> +.. code-block:: c
> +
> +    struct {
> +        __uint(type, BPF_MAP_TYPE_ARRAY);
> +        __type(key, u32);
> +        __type(value, long);
> +        __uint(max_entries, 256);
> +    } my_map SEC(".maps");
> +
> +    int bpf_prog(struct __sk_buff *skb)
> +    {
> +        int index = load_byte(skb, ETH_HLEN + offsetof(struct iphdr, protocol));
> +        long *value;
> +
> +        if (skb->pkt_type != PACKET_OUTGOING)
> +            return 0;
> +
> +        value = bpf_map_lookup_elem(&my_map, &index);
> +        if (value)
> +            __sync_fetch_and_add(value, skb->len);
> +
> +        return 0;
> +    }
> +
> +Userspace
> +---------
> +
> +BPF_MAP_TYPE_ARRAY
> +~~~~~~~~~~~~~~~~~~
> +
> +.. code-block:: c
> +
> +    #include <assert.h>
> +    #include <bpf/libbpf.h>
> +    #include <bpf/bpf.h>
> +
> +    int main(int argc, char **argv)
> +        {

something is off with this curly brace

> +
> +            int fd = bpf_create_map(BPF_MAP_TYPE_ARRAY, sizeof(__u32), sizeof(long), 256, 0);
> +            if (fd < 0)
> +            return -1;

return not indented

and the example itself doesn't follow kernel style guide with
C89-style variable block separate from the rest of the code. Would be
good to stick to that in kernel documentation.

> +
> +            // fill the map with values from 0-255
> +            for(__u32 i=0; i < 256 ; i++) {

__u32 inside the for isn't C89-compatible either. Also C++-style
comment above isn't allowed.

> +                long v = i;
> +                bpf_map_update_elem(fd, &i, &v, BPF_ANY);

makes sense to do error checking for update and lookup

> +            }
> +
> +            __u32 index = 42;
> +            long value;
> +            bpf_map_lookup_elem(fd, &index, &value);
> +            assert(value == 42);
> +            return 0;
> +    }
> +
> +

[...]
