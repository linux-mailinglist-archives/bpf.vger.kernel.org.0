Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7FE734AA4F
	for <lists+bpf@lfdr.de>; Fri, 26 Mar 2021 15:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhCZOlf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 10:41:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230187AbhCZOle (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Mar 2021 10:41:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64C9D619F2;
        Fri, 26 Mar 2021 14:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616769694;
        bh=RtJp82mOQfaI8F2zxBwzj2aA63wqRXjyq+vxHLWaKvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ruZUvhMRp6cAssNoc81bTIHLX92Wtv9WaVTwEfI/TqtY37WFOJCUHM+gC9VXrv4AZ
         sDSleT3G0eNjaiyRIs4sxpS+uVVWdexGDFX4ZkpwudohMSIEyKHVgF770STX43JSPM
         6jEHkFq8FiEqYgB7dv69+WoAvCSOm3L5S2zop1uakhgkb+peeehxdv7YLij84n83jS
         qcbhFClA7ZM0NupvsbTR8gjapBbn9MYd+Vfb3aMRtfM5UQcrZ1CT/o+vDnZ0O3dobn
         yndnDRW0gfKZBeTFJ/pB2JniZHeQwVlLOuZLY1LAF3KNvz81CK06MCvyFRw++GWl2V
         ba2DcYxYTcvPA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 53A3240647; Fri, 26 Mar 2021 11:41:32 -0300 (-03)
Date:   Fri, 26 Mar 2021 11:41:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH dwarves 3/3] dwarf_loader: add option to merge more dwarf
 cu's into one pahole cu
Message-ID: <YF3ynAKXDCE0kDpp@kernel.org>
References: <20210325065316.3121287-1-yhs@fb.com>
 <20210325065332.3122473-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325065332.3122473-1-yhs@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Mar 24, 2021 at 11:53:32PM -0700, Yonghong Song escreveu:
> This patch added an option "merge_cus", which will permit
> to merge all debug info cu's into one pahole cu.
> For vmlinux built with clang thin-lto or lto, there exist
> cross cu type references. For example, you could have
>   compile unit 1:
>      tag 10:  type A
>   compile unit 2:
>      ...
>        refer to type A (tag 10 in compile unit 1)
> I only checked a few but have seen type A may be a simple type
> like "unsigned char" or a complex type like an array of base types.
> 
> There are two different ways to resolve this issue:
> (1). merge all compile units as one pahole cu so tags/types
>      can be resolved easily, or
> (2). try to do on-demand type traversal in other debuginfo cu's
>      when we do die_process().
> The method (2) is much more complicated so I picked method (1).
> An option "merge_cus" is added to permit such an operation.
> 
> Merging cu's will create a single cu with lots of types, tags
> and functions. For example with clang thin-lto built vmlinux,
> I saw 9M entries in types table, 5.2M in tags table. The
> below are pahole wallclock time for different hashbits:
> command line: time pahole -J --merge_cus vmlinux
>       # of hashbits            wallclock time in seconds
>           15                       460
>           16                       255
>           17                       131
>           18                       97
>           19                       75
>           20                       69
>           21                       64
>           22                       62
>           23                       58
>           24                       64
> 
> Note that the number of hashbits 24 makes performance worse
> than 23. The reason could be that 23 hashbits can cover 8M
> buckets (close to 9M for the number of entries in types table).
> Higher number of hash bits allocates more memory and becomes
> less cache efficient compared to 23 hashbits.
> 
> This patch picks # of hashbits 21 as the starting value
> and will try to allocate memory based on that, if memory
> allocation fails, we will go with less hashbits until
> we reach hashbits 15 which is the default for
> non merge-cu case.

I'll probably add a way to specify the starting max_hashbits to be able
to use 'perf stat' to show what causes the performance difference.

I'm also adding the man page patch below, now to build the kernel with
your bpf-next patch to test it.

- Arnaldo

[acme@five pahole]$ git diff
diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index cbbefbf22556412c..1be2a293ad4bcc50 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -208,6 +208,12 @@ information has float types.
 .B \-\-btf_gen_all
 Allow using all the BTF features supported by pahole.

+.TP
+.B \-\-merge_cus
+Merge all cus (except possible types_cu) when loading DWARF, this is needed
+when processing files that have inter-CU references, this happens, for instance
+when building the Linux kernel with clang using thin-LTO or LTO.
+
 .TP
 .B \-l, \-\-show_first_biggest_size_base_type_member
 Show first biggest size base_type member.
[acme@five pahole]$
