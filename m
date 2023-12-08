Return-Path: <bpf+bounces-17086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C5D80992F
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 03:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2C181F213A6
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 02:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6112B1FC4;
	Fri,  8 Dec 2023 02:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZZQArNUj"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [IPv6:2001:41d0:203:375::b0])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2981709
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 18:28:15 -0800 (PST)
Message-ID: <012efc61-e067-4c21-8cab-47dec9bbaf0c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702002493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wuHkWy8I1lI+lrVrcgZoC/SBsb3WNxA1HleX5TCv51A=;
	b=ZZQArNUjfH2B0VPRToyL4j+DVoxvvR/5J+wP1wD5GqOZoH7i7zqdwu8fYxjW369QPpWujo
	z6B5hspwLN1TJIwLBisvfeUuWTR6zOSaBuShDWsndtAQ8P5fhMQ/HPowpbjOQ5Fc0xOipT
	FVKdOFB6Or6W0fsQbSKK4caNXkTuUno=
Date: Thu, 7 Dec 2023 18:28:06 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 0/1] use preserve_static_offset in bpf uapi
 headers
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, jose.marchesi@oracle.com
References: <20231208000531.19179-1-eddyz87@gmail.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231208000531.19179-1-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/7/23 4:05 PM, Eduard Zingerman wrote:
> For certain program context types, the verifier applies the
> verifier.c:convert_ctx_access() transformation.
> It modifies ST/STX/LDX instructions that access program context.
> convert_ctx_access() updates the offset field of these instructions
> changing "virtual" offset by offset corresponding to data
> representation in the running kernel.
>
> For this transformation to be applicable access to the context field
> shouldn't use pointer arithmetics. For example, consider the read of
> __sk_buff->pkt_type field.
> If translated as a single ST instruction:
>
>      r0 = *(u32 *)(r1 + 4);
>
> The verifier would accept such code and patch the offset in the
> instruction, however, if translated as a pair of instructions:
>
>      r1 += 4;
>      r0 = *(u32 *)(r1 + 0);
>
> The verifier would reject such code.
>
> Occasionally clang shuffling code during compilation might break
> verifier expectations and cause verification errors, e.g. as in [0].
> Technically, this happens because each field read/write represented in
> LLVM IR as two operations: address lookup + memory access,
> and the compiler is free to move and substitute those independently.
> For example, LLVM can rewrite C code below:
>
>      __u32 v;
>      if (...)
>        v = sk_buff->pkt_type;
>      else
>        v = sk_buff->mark;
>
> As if it was written as so:
>
>      __u32 v, *p;
>      if (...)
>        p = &sk_buff->pkt_type;  // r0 = 4; (offset of pkt_type)
>      else
>        p = &sk_buff->mark;      // r0 = 8; (offset of mark)
>      v = *p;                    // r1 += r0;
>                                 // r0 = *(u32 *)(r1 + 0)
>
> Which is a valid rewrite from the point of view of C semantics but won't
> pass verification, because convert_ctx_access() can no longer replace
> offset in 'r0 = *(u32 *)(r1 + 0)' with a constant.
>
> Recently, attribute preserve_static_offset was added to
> clang [1] to tackle this problem. From its documentation:
>
>    Clang supports the ``__attribute__((preserve_static_offset))``
>    attribute for the BPF target. This attribute may be attached to a
>    struct or union declaration. Reading or writing fields of types having
>    such annotation is guaranteed to generate LDX/ST/STX instruction with
>    an offset corresponding to the field.
>
> The convert_ctx_access() transformation is applied when the context
> parameter has one of the following types:
> - __sk_buff
> - bpf_cgroup_dev_ctx
> - bpf_perf_event_data
> - bpf_sk_lookup
> - bpf_sock
> - bpf_sock_addr
> - bpf_sock_ops
> - bpf_sockopt
> - bpf_sysctl
> - sk_msg_md
> - sk_reuseport_md
> - xdp_md

All context types are defined in include/linux/bpf_types.h.
The context type bpf_nf_ctx is missing.

>
>  From my understanding, BPF programs typically access definitions of
> these types in two ways:
> - via uapi headers linux/bpf.h and linux/bpf_perf_event.h;

and bpf_nf_ctx is defined in include/net/netfilter/nf_bpf_link.h
and rely on vmlinux.h to provide the ctx struct definition.

> - via vmlinux.h.
>
> This RFC seeks to mark with preserve_static_offset the definitions of
> the relevant context types within uapi headers.
>
> The attribute is abstracted by '__bpf_ctx' macro.
> As bpf.h and bpf_perf_event.h do not share any common include files,
> this RFC opts to copy the same definition of '__bpf_ctx' in both
> headers to avoid adding a new uapi header.
> (Another tempting location for '__bpf_ctx' is compiler_types.h /
>   compiler-clang.h, but these headers are not exported as uapi).

Previously I think we might use similar mechanism like vmlinux.h
with push/pop preserve_static_offset attributes. But looks like
there are many other structures in uapi bpf.h do not need
preserve_static_offset. So I think your approach sounds okay.

>
> How to add the same definitions in vmlinux.h is an open question,
> and most likely requires bpftool modification:
> - Hard code generation of __bpf_ctx based on type names?
> - Mark context types with some special
>    __attribute__((btf_decl_tag("preserve_static_offset")))
>    and convert it to __attribute__((preserve_static_offset))?

The number of context types is limited, I would just go through
the first approach with hard coding the list of ctx types and
mark them with preserve_static_offset attribute in vmlinux.h.

>
> Please suggest if any of the options above sound reasonable.
>
> [0] https://lore.kernel.org/bpf/CAA-VZPmxh8o8EBcJ=m-DH4ytcxDFmo0JKsm1p1gf40kS0CE3NQ@mail.gmail.com/T/#m4b9ce2ce73b34f34172328f975235fc6f19841b6
> [1] 030b8cb1561d ("[BPF] Attribute preserve_static_offset for structs")
>      git@github.com:llvm/llvm-project.git
>
> Eduard Zingerman (1):
>    bpf: Mark virtual BPF context structures as preserve_static_offset
>
>   include/uapi/linux/bpf.h                  | 28 ++++++++++++++---------
>   include/uapi/linux/bpf_perf_event.h       |  8 ++++++-
>   tools/include/uapi/linux/bpf.h            | 28 ++++++++++++++---------
>   tools/include/uapi/linux/bpf_perf_event.h |  8 ++++++-
>   4 files changed, 48 insertions(+), 24 deletions(-)
>

