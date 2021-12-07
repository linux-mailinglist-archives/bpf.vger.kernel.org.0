Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0024746BE33
	for <lists+bpf@lfdr.de>; Tue,  7 Dec 2021 15:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237510AbhLGO5F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Dec 2021 09:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhLGO5F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Dec 2021 09:57:05 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA21C061574;
        Tue,  7 Dec 2021 06:53:35 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 67432378;
        Tue,  7 Dec 2021 14:53:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 67432378
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1638888814; bh=wayKIOlvZG2QBsp3ZRtkCrYw504nU7EjmonG3mZVOTc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VeEEssypgMUGoGPG8l1XEXFOJj4WXIYk0W92h1TgjQgQCtfS93wizLFDP5pfQWqOM
         uVpnLhAYnEFVJZmGBd6rTiiMRhw8emxJvNlYU1kkyKPTzWzQzvKPQ7jgl62Jpc/G+b
         chkfbWDJ7hWu91nMZeh8FCpcP0wtSpoDXiBNeyDLZmCr6dsE50UQn5Ej34fnw+ZdyX
         dsFqI9SrhT4AmwA8oPnGCX0B52gG66Z5c2BCj+LigyHdXIr9MPwxEQUXuU244qjqkX
         mZUGG0ej0+YrFIBOjvy6zOosS7FMeAWUnC3jjtnSQIRKZDHCQi7jVhRAD3QTC2qyjT
         DuT/NXLdAjFXw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Dave Tucker <dave@dtucker.co.uk>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, linux-doc@vger.kernel.org,
        Dave Tucker <dave@dtucker.co.uk>
Subject: Re: [PATCH v3 bpf-next 2/2] bpf, docs: document BPF_MAP_TYPE_ARRAY
In-Reply-To: <9010b4d5fa1b25410a34f2954f272cce7dca0c99.1638883067.git.dave@dtucker.co.uk>
References: <cover.1638883067.git.dave@dtucker.co.uk>
 <9010b4d5fa1b25410a34f2954f272cce7dca0c99.1638883067.git.dave@dtucker.co.uk>
Date:   Tue, 07 Dec 2021 07:53:33 -0700
Message-ID: <87ilw01n6a.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Dave Tucker <dave@dtucker.co.uk> writes:

> This commit adds documentation for the BPF_MAP_TYPE_ARRAY including
> kernel version introduced, usage and examples.
> It also documents BPF_MAP_TYPE_PERCPU_ARRAY since this is similar.
>
> Signed-off-by: Dave Tucker <dave@dtucker.co.uk>
> ---
>  Documentation/bpf/map_array.rst | 182 ++++++++++++++++++++++++++++++++
>  1 file changed, 182 insertions(+)
>  create mode 100644 Documentation/bpf/map_array.rst

When you add a new file, you need to add it to index.rst as well to
bring it into the docs build.

> diff --git a/Documentation/bpf/map_array.rst b/Documentation/bpf/map_array.rst
> new file mode 100644
> index 000000000000..7ed5f7654ee8
> --- /dev/null
> +++ b/Documentation/bpf/map_array.rst
> @@ -0,0 +1,182 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +.. Copyright (C) 2021 Red Hat, Inc.
> +
> +================================================
> +BPF_MAP_TYPE_ARRAY and BPF_MAP_TYPE_PERCPU_ARRAY
> +================================================
> +
> +.. note:: ``BPF_MAP_TYPE_ARRAY`` was introduced in Kernel version 3.19 and
> +   ``BPF_MAP_TYPE_PERCPU_ARRAY`` in version 4.6
> +
> +``BPF_MAP_TYPE_ARRAY`` and ``BPF_MAP_TYPE_PERCPU_ARRAY`` provide generic array
> +storage.  The key type is an unsigned 32-bit integer (4 bytes) and the map is of
> +constant size. All array elements are pre-allocated and zero initialized when
> +created. ``BPF_MAP_TYPE_PERCPU_ARRAY`` uses a different memory region for each
> +CPU whereas ``BPF_MAP_TYPE_ARRAY`` uses the same memory region. The maximum
> +size of an array, defined in max_entries, is limited to 2^32. The value stored
> +can be of any size, however, small values will be rounded up to 8 bytes.
> +
> +Since Kernel 5.4, memory mapping may be enabled for ``BPF_MAP_TYPE_ARRAY`` by
> +setting the flag ``BPF_F_MMAPABLE``.  The map definition is page-aligned and
> +starts on the first page.  Sufficient page-sized and page-aligned blocks of
> +memory are allocated to store all array values, starting on the second page,
> +which in some cases will result in over-allocation of memory. The benefit of
> +using this is increased performance and ease of use since userspace programs
> +would not be required to use helper functions to access and mutate data.
> +
> +Usage
> +=====
> +
> +Array elements can be retrieved using the ``bpf_map_lookup_elem()`` helper.

It's really better not to use ``literal markup`` for function names.
Just write function() and the right thing will happen, including
cross-reference links to the kerneldoc for that function if it exists.

Thanks,

jon
