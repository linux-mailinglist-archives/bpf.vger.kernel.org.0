Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5F22C48F4
	for <lists+bpf@lfdr.de>; Wed, 25 Nov 2020 21:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgKYUVv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Nov 2020 15:21:51 -0500
Received: from mx.der-flo.net ([193.160.39.236]:60856 "EHLO mx.der-flo.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729016AbgKYUVv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Nov 2020 15:21:51 -0500
Received: by mx.der-flo.net (Postfix, from userid 110)
        id CE98D444D0; Wed, 25 Nov 2020 21:21:33 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mx.der-flo.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=4.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.2
Received: from localhost (unknown [IPv6:2a02:1203:ecb0:3930:1751:4157:4d75:a5e2])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.der-flo.net (Postfix) with ESMTPSA id 3A57A439CF;
        Wed, 25 Nov 2020 21:20:43 +0100 (CET)
Date:   Wed, 25 Nov 2020 21:20:32 +0100
From:   Florian Lehner <dev@der-flo.net>
To:     Andrei Matei <andreimatei1@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org
Subject: Re: [PATCH bpf-next] selftest/bpf: fix compilation on clang 11
Message-ID: <20201125202032.GA17524@der-flo.net>
References: <20201125035255.17970-1-andreimatei1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201125035255.17970-1-andreimatei1@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 24, 2020 at 10:52:55PM -0500, Andrei Matei wrote:
> Before this patch, profiler.inc.h wouldn't compile with clang-11 (before
> the __builtin_preserve_enum_value LLVM builtin was introduced in
> https://reviews.llvm.org/D83242).
> Another test that uses this builtin (test_core_enumval) is conditionally
> skipped if the compiler is too old. In that spirit, this patch inhibits
> part of populate_cgroup_info(), which needs this CO-RE builtin. The
> selftests build again on clang-11.  The affected test (the profiler
> test) doesn't pass on clang-11 because it's missing
> https://reviews.llvm.org/D85570, but at least the test suite as a whole
> compiles. The test's expected failure is already called out in the
> README.
> 
> Signed-off-by: Andrei Matei <andreimatei1@gmail.com>

Tested-by: Florian Lehner <dev@der-flo.net>

Thanks for the fix!

> ---
>  tools/testing/selftests/bpf/progs/profiler.inc.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/progs/profiler.inc.h b/tools/testing/selftests/bpf/progs/profiler.inc.h
> index 30982a7e4d0f..b79d7f688655 100644
> --- a/tools/testing/selftests/bpf/progs/profiler.inc.h
> +++ b/tools/testing/selftests/bpf/progs/profiler.inc.h
> @@ -256,6 +256,8 @@ static INLINE void* populate_cgroup_info(struct cgroup_data_t* cgroup_data,
>  		BPF_CORE_READ(task, nsproxy, cgroup_ns, root_cset, dfl_cgrp, kn);
>  	struct kernfs_node* proc_kernfs = BPF_CORE_READ(task, cgroups, dfl_cgrp, kn);
>  
> +
> +#if __has_builtin(__builtin_preserve_enum_value)
>  	if (ENABLE_CGROUP_V1_RESOLVER && CONFIG_CGROUP_PIDS) {
>  		int cgrp_id = bpf_core_enum_value(enum cgroup_subsys_id___local,
>  						  pids_cgrp_id___local);
> @@ -275,6 +277,7 @@ static INLINE void* populate_cgroup_info(struct cgroup_data_t* cgroup_data,
>  			}
>  		}
>  	}
> +#endif
>  
>  	cgroup_data->cgroup_root_inode = get_inode_from_kernfs(root_kernfs);
>  	cgroup_data->cgroup_proc_inode = get_inode_from_kernfs(proc_kernfs);
> -- 
> 2.27.0
> 
