Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38AD241C1D
	for <lists+bpf@lfdr.de>; Tue, 11 Aug 2020 16:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbgHKOKm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Aug 2020 10:10:42 -0400
Received: from www62.your-server.de ([213.133.104.62]:41240 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbgHKOKi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Aug 2020 10:10:38 -0400
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1k5Uz1-0000N6-QL; Tue, 11 Aug 2020 16:10:31 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1k5Uz1-000JTh-Ij; Tue, 11 Aug 2020 16:10:31 +0200
Subject: Re: [PATCH bpf] libbpf: Handle GCC built-in types for Arm NEON
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>, ast@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jakov Petrina <jakov.petrina@sartura.hr>
References: <20200810122835.2309026-1-jean-philippe@linaro.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <65afcc0c-5468-1654-83d6-dade2c848745@iogearbox.net>
Date:   Tue, 11 Aug 2020 16:10:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200810122835.2309026-1-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25900/Mon Aug 10 14:44:29 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/10/20 2:28 PM, Jean-Philippe Brucker wrote:
> When building Arm NEON (SIMD) code, GCC emits built-in types __PolyXX_t,
> which are not recognized by Clang. This causes build failures when
> including vmlinux.h generated from a kernel built with CONFIG_RAID6_PQ=y
> and CONFIG_KERNEL_MODE_NEON. Emit typedefs for these built-in types,
> based on the Clang definitions. poly64_t is unsigned long because it's
> only defined for 64-bit Arm.
> 
> Including linux/kernel.h to use ARRAY_SIZE() incidentally redefined
> max(), causing a build bug due to different types, hence the seemingly
> unrelated change.
> 
> Reported-by: Jakov Petrina <jakov.petrina@sartura.hr>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Looks like this was fixed here [0], but not available on older clang/LLVM
versions, right?

   [0] https://reviews.llvm.org/D79711

[...]
>   
> +static const char *builtin_types[][2] = {
> +	/*
> +	 * GCC emits typedefs to its internal __PolyXX_t types when compiling
> +	 * Arm SIMD intrinsics. Alias them to the same standard types as Clang.
> +	 */
> +	{ "__Poly8_t",		"unsigned char" },
> +	{ "__Poly16_t",		"unsigned short" },
> +	{ "__Poly64_t",		"unsigned long" },
> +	{ "__Poly128_t",	"unsigned __int128" },

In that above LLVM link [0], they typefdef this to signed types ... which one
is correct now?

   // For now, signedness of polynomial types depends on target
   OS << "#ifdef __aarch64__\n";
   OS << "typedef uint8_t poly8_t;\n";
   OS << "typedef uint16_t poly16_t;\n";
   OS << "typedef uint64_t poly64_t;\n";
   OS << "typedef __uint128_t poly128_t;\n";
   OS << "#else\n";
   OS << "typedef int8_t poly8_t;\n";
   OS << "typedef int16_t poly16_t;\n";
   OS << "typedef int64_t poly64_t;\n";
   OS << "#endif\n";

> +};
> +
> +static void btf_dump_emit_int_def(struct btf_dump *d, __u32 id,
> +				  const struct btf_type *t)
> +{
> +	const char *name = btf_dump_type_name(d, id);
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(builtin_types); i++) {
> +		if (strcmp(name, builtin_types[i][0]) == 0) {
> +			btf_dump_printf(d, "typedef %s %s;\n\n",
> +					builtin_types[i][1], name);
> +			break;
> +		}
> +	}
> +}
> +
>   static void btf_dump_emit_enum_fwd(struct btf_dump *d, __u32 id,
>   				   const struct btf_type *t)
>   {
> 

