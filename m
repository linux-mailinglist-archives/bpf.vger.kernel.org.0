Return-Path: <bpf+bounces-14438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657AD7E48D7
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 19:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C227BB20FD0
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 18:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1CF358B6;
	Tue,  7 Nov 2023 18:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xy7FHFDg"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FF7358AA
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 18:54:56 +0000 (UTC)
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF6699
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 10:54:55 -0800 (PST)
Message-ID: <9bd0b6b7-6a11-7727-e469-2e0c9cd9cb56@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699383293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c0muET+tr7RqsI1tpITpP7bnpWT6w/sUcM75n8NZkAE=;
	b=Xy7FHFDg+MyvztabxoWWDb8xARoZEGdIXUj3y9APhSw+790/ot3nhAlIBZ7Wp77tDGPuOh
	Rh+BCkIAXi7hUWjxT1FqPmtU61y7zIy326gRAc/bsh6fwguyHTar+7ceKudg7ScIJQp8zk
	up6ySiMPgl2dzLFrpVVjBnBm3LJO27U=
Date: Tue, 7 Nov 2023 10:54:47 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] libbpf: Fix potential uninitialized tail
 padding with LIBBPF_OPTS_RESET
Content-Language: en-US
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20231107062936.2537338-1-yonghong.song@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231107062936.2537338-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/6/23 10:29 PM, Yonghong Song wrote:
> Martin reported that there is a libbpf complaining of non-zero-value tail
> padding with LIBBPF_OPTS_RESET macro if struct bpf_netkit_opts is modified
> to have a 4-byte tail padding. This only happens to clang compiler.
> The commend line is: ./test_progs -t tc_netkit_multi_links
> Martin and I did some investigation and found this indeed the case and
> the following are the investigation details.
> 
> Clang 18:
>    clang version 18.0.0
>    <I tried clang15/16/17 and they all have similar results>
> 
> tools/lib/bpf/libbpf_common.h:
>    #define LIBBPF_OPTS_RESET(NAME, ...)                                      \
>          do {                                                                \
>                  memset(&NAME, 0, sizeof(NAME));                             \
>                  NAME = (typeof(NAME)) {                                     \
>                          .sz = sizeof(NAME),                                 \
>                          __VA_ARGS__                                         \
>                  };                                                          \
>          } while (0)
> 
>    #endif
> 
> tools/lib/bpf/libbpf.h:
>    struct bpf_netkit_opts {
>          /* size of this struct, for forward/backward compatibility */
>          size_t sz;
>          __u32 flags;
>          __u32 relative_fd;
>          __u32 relative_id;
>          __u64 expected_revision;
>          size_t :0;
>    };
>    #define bpf_netkit_opts__last_field expected_revision
> In the above struct bpf_netkit_opts, there is no tail padding.
> 
> prog_tests/tc_netkit.c:
>    static void serial_test_tc_netkit_multi_links_target(int mode, int target)
>    {
>          ...
>          LIBBPF_OPTS(bpf_netkit_opts, optl);
>          ...
>          LIBBPF_OPTS_RESET(optl,
>                  .flags = BPF_F_BEFORE,
>                  .relative_fd = bpf_program__fd(skel->progs.tc1),
>          );
>          ...
>    }
> 
> Let us make the following source change, note that we have a 4-byte
> tailing padding now.
>    diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>    index 6cd9c501624f..0dd83910ae9a 100644
>    --- a/tools/lib/bpf/libbpf.h
>    +++ b/tools/lib/bpf/libbpf.h
>    @@ -803,13 +803,13 @@ bpf_program__attach_tcx(const struct bpf_program *prog, int ifindex,
>     struct bpf_netkit_opts {
>          /* size of this struct, for forward/backward compatibility */
>          size_t sz;
>    -       __u32 flags;
>          __u32 relative_fd;
>          __u32 relative_id;
>          __u64 expected_revision;
>    +       __u32 flags;
>          size_t :0;
>     };
>    -#define bpf_netkit_opts__last_field expected_revision
>    +#define bpf_netkit_opts__last_field flags

The bpf_netkit_ops is in the bpf tree. If avoiding a hole in bpf_netkit_opts 
like above is preferred, probably the fix in this patch and the bpf_netkit_ops 
change should be in the same libbpf version?

Ran the test in a loop. It resolved the issue.

Tested-by: Martin KaFai Lau <martin.lau@kernel.org>


