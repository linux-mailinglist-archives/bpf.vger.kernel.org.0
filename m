Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5325D1E83F1
	for <lists+bpf@lfdr.de>; Fri, 29 May 2020 18:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbgE2Qp4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 May 2020 12:45:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59240 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726616AbgE2Qpz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 May 2020 12:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590770753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yE8l6C2K45Oxr0sOHCOBb823XM1ml++647bWXMKlUuM=;
        b=QHcymke7+09J+37JeqLix6jzYR32/JHLFeibe+uLysxDc35zc6dOcvFOu6PJ51/Jaaw0gp
        rY6TqqS4/yRzC1XepgI0unmqZ5OfC2JWxdI6pXiiFXctay/kzwkLB00E+mB0+Gxxqfi4jJ
        21Tla2olRtykqerFKu4ErwUGyxehTVU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-GLWgLwhAPwSujtXNKY_05Q-1; Fri, 29 May 2020 12:45:41 -0400
X-MC-Unique: GLWgLwhAPwSujtXNKY_05Q-1
Received: by mail-ed1-f70.google.com with SMTP id dk23so1422397edb.15
        for <bpf@vger.kernel.org>; Fri, 29 May 2020 09:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=yE8l6C2K45Oxr0sOHCOBb823XM1ml++647bWXMKlUuM=;
        b=C7ClVsgPG8mnImx5KmgEZHj8jwhTWEKBgENn1kzeSQrZXUdibruATQ8x+nttCIxSMi
         KBNxgxcNVwKzcZ9/PSiyx93FW9BfVqZiBcPgGHBE/oAI44EfB6+h88R3mjFyr9+1sFnP
         UaAbxaZzxYlzDNd2sS9ziMKXsWeDx3uXEqDgGzoxP+koLtrKLYEF+pzNZaBXiont5RlR
         OXFpZjxw09mK/6AbE78Q7u6XO+yvIopj9KLIloS+GhwU080ZbwRDvyUhkkwBVh/UumRU
         Dk89fu0mDZGnSMiaNn+OaTyf1tb54+CacOyScdIZH8TKO1Xq9plcnapYUJcOOII15Ofj
         ZUfw==
X-Gm-Message-State: AOAM533Ip/BtzZzNL73+Zz+s752IsWnHas7jOkHlgERlOLVRjiQTGlsu
        vffuZO7ZbxKs2qR6XjPb3pk1xqxi4UPKC37+njM5wWBxwcAg8DXVZjWzDPTVtNAEd3wxisEU3lb
        RLmyum+pppJYp
X-Received: by 2002:a50:fe94:: with SMTP id d20mr8864791edt.254.1590770740085;
        Fri, 29 May 2020 09:45:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy29o1SyK1kQ/VtUputSZEkjA211i1wWO8oFhQyEzI436uRzWFnvZ9AcHjOFvCnS3VXYJFpwA==
X-Received: by 2002:a50:fe94:: with SMTP id d20mr8864766edt.254.1590770739873;
        Fri, 29 May 2020 09:45:39 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id z10sm7019193ejb.9.2020.05.29.09.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 09:45:39 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 723AC182019; Fri, 29 May 2020 18:45:37 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        brouer@redhat.com, lorenzo@kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, ast@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        dsahern@gmail.com, David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH v3 bpf-next 5/5] selftest: Add tests for XDP programs in devmap entries
In-Reply-To: <20200529052057.69378-6-dsahern@kernel.org>
References: <20200529052057.69378-1-dsahern@kernel.org> <20200529052057.69378-6-dsahern@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 29 May 2020 18:45:37 +0200
Message-ID: <87r1v2zo3y.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

David Ahern <dsahern@kernel.org> writes:

> Add tests to verify ability to add an XDP program to a
> entry in a DEVMAP.
>
> Add negative tests to show DEVMAP programs can not be
> attached to devices as a normal XDP program, and accesses
> to egress_ifindex require BPF_XDP_DEVMAP attach type.
>
> Signed-off-by: David Ahern <dsahern@kernel.org>
> ---
>  .../bpf/prog_tests/xdp_devmap_attach.c        | 89 +++++++++++++++++++
>  .../bpf/progs/test_xdp_devmap_helpers.c       | 22 +++++
>  .../bpf/progs/test_xdp_with_devmap_helpers.c  | 43 +++++++++
>  3 files changed, 154 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_devmap_helpers.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_with_devmap_helpers.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
> new file mode 100644
> index 000000000000..caeea19f2772
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <uapi/linux/bpf.h>
> +#include <linux/if_link.h>
> +#include <test_progs.h>
> +
> +#include "test_xdp_devmap_helpers.skel.h"
> +#include "test_xdp_with_devmap_helpers.skel.h"
> +
> +#define IFINDEX_LO 1
> +
> +void test_xdp_with_devmap_helpers(void)
> +{
> +	struct test_xdp_with_devmap_helpers *skel;
> +	struct bpf_prog_info info = {};
> +	struct bpf_devmap_val val = {
> +		.ifindex = IFINDEX_LO,
> +	};
> +	__u32 id, len = sizeof(info);
> +	__u32 duration, idx = 0;
> +	int err, dm_fd, map_fd;
> +
> +
> +	skel = test_xdp_with_devmap_helpers__open_and_load();
> +	if (CHECK_FAIL(!skel)) {
> +		perror("test_xdp_with_devmap_helpers__open_and_load");
> +		return;
> +	}
> +
> +	/* can not attach program with DEVMAPs that allow programs
> +	 * as xdp generic
> +	 */
> +	dm_fd = bpf_program__fd(skel->progs.xdp_redir_prog);
> +	err = bpf_set_link_xdp_fd(IFINDEX_LO, dm_fd, XDP_FLAGS_SKB_MODE);
> +	CHECK(err == 0, "Generic attach of program with 8-byte devmap",
> +	      "should have failed\n");
> +
> +	dm_fd = bpf_program__fd(skel->progs.xdp_dummy_dm);
> +	map_fd = bpf_map__fd(skel->maps.dm_ports);
> +	err = bpf_obj_get_info_by_fd(dm_fd, &info, &len);
> +	if (CHECK_FAIL(err))
> +		goto out_close;
> +
> +	val.bpf_prog_fd = dm_fd;
> +	err = bpf_map_update_elem(map_fd, &idx, &val, 0);
> +	CHECK(err, "Add program to devmap entry",
> +	      "err %d errno %d\n", err, errno);
> +
> +	err = bpf_map_lookup_elem(map_fd, &id, &val);
> +	CHECK(err, "Read devmap entry", "err %d errno %d\n", err, errno);
> +	CHECK(info.id != val.bpf_prog_id, "Expected program id in devmap entry",
> +	      "expected %u read %u\n", info.id, val.bpf_prog_id);
> +
> +	/* can not attach BPF_XDP_DEVMAP program to a device */
> +	err = bpf_set_link_xdp_fd(IFINDEX_LO, dm_fd, XDP_FLAGS_SKB_MODE);
> +	CHECK(err == 0, "Attach of BPF_XDP_DEVMAP program",
> +	      "should have failed\n");
> +
> +	val.ifindex = 1;
> +	val.bpf_prog_fd = bpf_program__fd(skel->progs.xdp_dummy_prog);
> +	err = bpf_map_update_elem(map_fd, &idx, &val, 0);
> +	CHECK(err == 0, "Add non-BPF_XDP_DEVMAP program to devmap entry",
> +	      "should have failed\n");
> +
> +out_close:
> +	test_xdp_with_devmap_helpers__destroy(skel);
> +}
> +
> +void test_neg_xdp_devmap_helpers(void)
> +{
> +	struct test_xdp_devmap_helpers *skel;
> +	__u32 duration;
> +
> +	skel = test_xdp_devmap_helpers__open_and_load();
> +	if (CHECK(skel,
> +		  "Load of XDP program accessing egress ifindex without attach type",
> +		  "should have failed\n")) {
> +		test_xdp_devmap_helpers__destroy(skel);
> +	}
> +}
> +
> +
> +void test_xdp_devmap_attach(void)
> +{
> +	if (test__start_subtest("DEVMAP with programs in entries"))
> +		test_xdp_with_devmap_helpers();
> +
> +	if (test__start_subtest("Verifier check of DEVMAP programs"))
> +		test_neg_xdp_devmap_helpers();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_xdp_devmap_helpers.c b/tools/testing/selftests/bpf/progs/test_xdp_devmap_helpers.c
> new file mode 100644
> index 000000000000..b360ba2bd441
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_xdp_devmap_helpers.c
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* fails to load without expected_attach_type = BPF_XDP_DEVMAP
> + * because of access to egress_ifindex
> + */
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +SEC("xdp_dm_log")

Guess this should be xdp_devmap_log now?

-Toke

