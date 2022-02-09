Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980D94AFDF7
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 21:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbiBIUDs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 15:03:48 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiBIUDr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 15:03:47 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF67E050B8B
        for <bpf@vger.kernel.org>; Wed,  9 Feb 2022 12:03:41 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id 10so3203996plj.1
        for <bpf@vger.kernel.org>; Wed, 09 Feb 2022 12:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/mtLZta9FSJH85SQQ3odzphHV/Ii2u26wZXe7hdC2Yg=;
        b=naJsnfJM3pWRlpwRVLs9wBrC+fU6w2hQoU/NDX6/OtkG8zWBN84eoSaVmz5muNeAqu
         Cuka6raHmFQeGMJuRQWIvI8cJ03J7jDtD5Pt3ncD9j1UOAPhieViHkwV071nFsUK7tpD
         orIQ+LhKlyZOLrjBVt/2qk1IqQR4Z+38S0HWeLoAbmmyBFcovRoWThb0U3k7EZOkyUJU
         DOTT+63r+zkjwAtuV75dlb7FECLvRD1ptoeCTJrQPVJ6OsnMQ9pfUjVTaNe8FwNPUcJr
         xWw4Chh2Mq/AFzRxtfd/GJA/ftwW0TyOrdz52ctYVwisnP80psqaSr77DLbwzina26Do
         h88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/mtLZta9FSJH85SQQ3odzphHV/Ii2u26wZXe7hdC2Yg=;
        b=e75AyyfceiEnGUGjzLAgHVUqBFIpiO625EginejdB7KT/YbWxRmybI07mqkKmmOmk6
         BPiOfKJqB+GQm2FeMc989b+xB79aFuNbLrypiY+C8WFUetUx9Vte/nXQLjCTUjDLRdib
         4y15QGDatP3MrSgcUnsptNnzahhKPhbQcE2JXwZ/VSK4qP1MBknaR2hMvPj1YoAbdprg
         kmx6KQIw3PGCaTGlNvQHK4k+OIsdNVHwDHJFrsCTYP5sKe6llPRkq/EVNUu3XtpDcyQ+
         Sd8ITPgZTQLBzqUiuUX/BHG+QalyAJFfgjyLq45+SFrEjTp25bc/NidSsgK2XKYLajR+
         9JnA==
X-Gm-Message-State: AOAM531zUht18S90nJoCEK+AVIz1S5n+trsjqZGwdKdrnungIfeNveuN
        WoX+ID7Twl/ZSqWbzvQ/iIRT7jsoZgaxNw==
X-Google-Smtp-Source: ABdhPJyijNfcN2KNCVVNSlScxt9TmjZj+W7cKQ4EztlF/G48rm0fNcA9VYPkhALeFm/XC2nNBZARMQ==
X-Received: by 2002:a17:90b:3e8e:: with SMTP id rj14mr5197903pjb.19.1644437008649;
        Wed, 09 Feb 2022 12:03:28 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:3d4e:6265:800c:dc84])
        by smtp.gmail.com with ESMTPSA id 1sm6940003pji.40.2022.02.09.12.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 12:03:28 -0800 (PST)
Date:   Thu, 10 Feb 2022 01:33:25 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Add test for bpf_timer
 overwriting crash
Message-ID: <20220209200325.ipydl7jsrwiugujn@apollo.legion>
References: <20220209070324.1093182-1-memxor@gmail.com>
 <20220209070324.1093182-3-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209070324.1093182-3-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 09, 2022 at 12:33:24PM IST, Kumar Kartikeya Dwivedi wrote:
> Add a test that validates that timer value is not overwritten when doing
> a copy_map_value call in the kernel. Without the prior fix, this test
> triggers a crash.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/timer_crash.c    | 32 +++++++++++
>  .../testing/selftests/bpf/progs/timer_crash.c | 54 +++++++++++++++++++
>  2 files changed, 86 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/timer_crash.c
>  create mode 100644 tools/testing/selftests/bpf/progs/timer_crash.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/timer_crash.c b/tools/testing/selftests/bpf/prog_tests/timer_crash.c
> new file mode 100644
> index 000000000000..f74b82305da8
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/timer_crash.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include "timer_crash.skel.h"
> +
> +enum {
> +	MODE_ARRAY,
> +	MODE_HASH,
> +};
> +
> +static void test_timer_crash_mode(int mode)
> +{
> +	struct timer_crash *skel;
> +
> +	skel = timer_crash__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "timer_crash__open_and_load"))
> +		return;
> +	skel->bss->pid = getpid();
> +	skel->bss->crash_map = mode;
> +	if (!ASSERT_OK(timer_crash__attach(skel), "timer_crash__attach"))
> +		goto end;
> +	usleep(1);
> +end:
> +	timer_crash__destroy(skel);
> +}
> +
> +void test_timer_crash(void)
> +{
> +	if (test__start_subtest("array"))
> +		test_timer_crash_mode(MODE_ARRAY);
> +	if (test__start_subtest("hash"))
> +		test_timer_crash_mode(MODE_HASH);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/timer_crash.c b/tools/testing/selftests/bpf/progs/timer_crash.c
> new file mode 100644
> index 000000000000..f8f7944e70da
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/timer_crash.c
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_helpers.h>
> +
> +struct map_elem {
> +	struct bpf_timer timer;
> +	struct bpf_spin_lock lock;
> +};
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(max_entries, 1);
> +	__type(key, int);
> +	__type(value, struct map_elem);
> +} amap SEC(".maps");
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(max_entries, 1);
> +	__type(key, int);
> +	__type(value, struct map_elem);
> +} hmap SEC(".maps");
> +
> +int pid = 0;
> +int crash_map = 0; /* 0 for amap, 1 for hmap */
> +
> +SEC("fentry/do_nanosleep")
> +int sys_enter(void *ctx)
> +{
> +	struct map_elem *e, value = {};
> +	void *map = crash_map ? (void *)&hmap : (void *)&amap;
> +
> +	if (bpf_get_current_task_btf()->tgid != pid)
> +		return 0;
> +
> +	*(void **)&value = (void *)0xdeadcaf3;
> +
> +	bpf_map_update_elem(map, &(int){0}, &value, 0);
> +	/* For array map, doing bpf_map_update_elem will do a
> +	 * check_and_free_timer_in_array, which will trigger the crash if timer
> +	 * pointer was overwritten, for hmap we need to use bpf_timer_cancel.
> +	 */

Also, in this case, there seems to be a difference of behavior. When we do
bpf_map_update_elem for array map, it seems to invoke
check_and_free_timer_in_array and free any timers that were part of the value.
In case of hash/lru_hash, that doesn't seem to happen, hence why the test has
two 'modes', to then trigger a dereference of the overwritten pointer using
bpf_timer_cancel.

So in case of array map it crashes right when doing bpf_map_update_elem, and in
case of hash it crashes inside bpf_timer_cancel.

This seems inconsistent to me, is there a specific reason behind doing it for
array map differently than hash map? If not, is it now too late to change this?

> +	if (crash_map == 1) {
> +		e = bpf_map_lookup_elem(map, &(int){0});
> +		if (!e)
> +			return 0;
> +		bpf_timer_cancel(&e->timer);
> +	}
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> --
> 2.35.1
>

--
Kartikeya
