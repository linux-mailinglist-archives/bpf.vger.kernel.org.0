Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9897967AFBB
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 11:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjAYKcn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 05:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234873AbjAYKcn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 05:32:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0922646D41
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 02:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674642706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mJltFoGI9s6num9RbN58QBIE5PAujW0hunBQvAsl920=;
        b=bXNJ3AAFZeWQdTsHuQxtzqLOKnVXzYXrNebZM8DQ1EEJtxGdhWxDpnwHzEacO3na0aXmah
        pjJA443PIXy1FRDTmY1AbGhw67uHwiR1xevMgjRuTp8Exb0PEtn+9vlj4ubin68slFi4Ma
        PNF5X4gUSBrsugxCQcHVhU2P1P7PWWs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-svIb9T4jMzy7JX5MSFka0Q-1; Wed, 25 Jan 2023 05:31:35 -0500
X-MC-Unique: svIb9T4jMzy7JX5MSFka0Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A5E53858F0E;
        Wed, 25 Jan 2023 10:31:34 +0000 (UTC)
Received: from samus.usersys.redhat.com (unknown [10.43.17.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E95E251FF;
        Wed, 25 Jan 2023 10:31:32 +0000 (UTC)
Date:   Wed, 25 Jan 2023 11:31:30 +0100
From:   Artem Savkov <asavkov@redhat.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next 1/5] selftests/bpf: Move kfunc exports to
 bpf_testmod/bpf_testmod_kfunc.h
Message-ID: <Y9EFAqdLED3TT43M@samus.usersys.redhat.com>
Mail-Followup-To: Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
References: <20230124143626.250719-1-jolsa@kernel.org>
 <20230124143626.250719-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230124143626.250719-2-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 24, 2023 at 03:36:22PM +0100, Jiri Olsa wrote:
> Move all kfunc exports into separate header file and include it
> in tests that need it.
> 
> We will move all test kfuncs into bpf_testmod in following change,
> so it's convenient to have declarations in single place.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../bpf/bpf_testmod/bpf_testmod_kfunc.h       | 89 +++++++++++++++++++
>  tools/testing/selftests/bpf/progs/cb_refs.c   |  1 +
>  .../selftests/bpf/progs/jit_probe_mem.c       |  3 +-
>  .../bpf/progs/kfunc_call_destructive.c        |  3 +-
>  .../selftests/bpf/progs/kfunc_call_fail.c     |  9 +-
>  .../selftests/bpf/progs/kfunc_call_race.c     |  3 +-
>  .../selftests/bpf/progs/kfunc_call_test.c     | 15 +---
>  .../bpf/progs/kfunc_call_test_subprog.c       | 17 +++-
>  tools/testing/selftests/bpf/progs/map_kptr.c  |  1 +
>  .../selftests/bpf/progs/map_kptr_fail.c       |  1 +
>  10 files changed, 111 insertions(+), 31 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
> 
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
> new file mode 100644
> index 000000000000..41d4f8543a25
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
> @@ -0,0 +1,89 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _BPF_TESTMOD_KFUNC_H
> +#define _BPF_TESTMOD_KFUNC_H
> +
> +#ifndef __ksym
> +#define __ksym __attribute__((section(".ksyms")))
> +#endif

...

> +extern void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb) __ksym;
> +extern void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p) __ksym;
> +extern void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p) __ksym;
> +extern void bpf_kfunc_call_test_mem_len_fail2(__u64 *mem, int len) __ksym;
> +
> +extern void bpf_kfunc_call_test_destructive(void) __ksym;
> +
> +#endif /* _BPF_TESTMOD_KFUNC_H */

This is missing bpf_kfunc_call_test_kptr_get() prototype, the function is
moved with the rest in the 5th patch.

> diff --git a/tools/testing/selftests/bpf/progs/cb_refs.c b/tools/testing/selftests/bpf/progs/cb_refs.c
> index 7653df1bc787..b905833dc9d3 100644
> --- a/tools/testing/selftests/bpf/progs/cb_refs.c
> +++ b/tools/testing/selftests/bpf/progs/cb_refs.c
> @@ -2,6 +2,7 @@
>  #include <vmlinux.h>
>  #include <bpf/bpf_tracing.h>
>  #include <bpf/bpf_helpers.h>
> +#include "bpf_testmod/bpf_testmod_kfunc.h"
>  
>  struct map_value {
>  	struct prog_test_ref_kfunc __kptr_ref *ptr;
> diff --git a/tools/testing/selftests/bpf/progs/map_kptr.c b/tools/testing/selftests/bpf/progs/map_kptr.c
> index eb8217803493..753305c22c2f 100644
> --- a/tools/testing/selftests/bpf/progs/map_kptr.c
> +++ b/tools/testing/selftests/bpf/progs/map_kptr.c
> @@ -2,6 +2,7 @@
>  #include <vmlinux.h>
>  #include <bpf/bpf_tracing.h>
>  #include <bpf/bpf_helpers.h>
> +#include "bpf_testmod/bpf_testmod_kfunc.h"
>  
>  struct map_value {
>  	struct prog_test_ref_kfunc __kptr *unref_ptr;
> diff --git a/tools/testing/selftests/bpf/progs/map_kptr_fail.c b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
> index 760e41e1a632..3b5076d951df 100644
> --- a/tools/testing/selftests/bpf/progs/map_kptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
> @@ -4,6 +4,7 @@
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_core_read.h>
>  #include "bpf_misc.h"
> +#include "bpf_testmod/bpf_testmod_kfunc.h"
>  
>  struct map_value {
>  	char buf[8];

These three are missing old prototype removal.

-- 
 Artem

