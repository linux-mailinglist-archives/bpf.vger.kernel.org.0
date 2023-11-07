Return-Path: <bpf+bounces-14399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E15FF7E3FA2
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 14:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C192810D0
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 13:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3165F2DF9F;
	Tue,  7 Nov 2023 13:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzUcVPse"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A1829414
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 13:07:45 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CA02713
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 05:07:43 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso883005666b.1
        for <bpf@vger.kernel.org>; Tue, 07 Nov 2023 05:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699362462; x=1699967262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8faCSD9R1TC2f+EpNI/nrykscjBaOlGP6zJq8U5y5OY=;
        b=JzUcVPseKbHXRQX0Xdt0idxW/XTdiGS+YeX7yUY7yc+QasIPefuKZzTFMCg6dxgapC
         zQJkH+6BzC0yIs613IVWPBndF+N7g/kGet2eDU7v/eboKyK1jQ40sAch6cCGmnq+eP0u
         pRWWe5i3sHIg7Pp9DgBJhhBGlVP7rdAABj9lG17ImqLNDxGYxphzgJ6aEtAhDj+poKJ7
         mFVzUxL9s/El4P2+BLdFwnK2idf2wQJHmt6HDGIVtsNbvxKvzxiGVu3hoksRQRntd0D7
         mJJcUi3uLxiTe+V2jXzvvKga5vKXSgEXv2Xeth/+HrlpPA1whUEO5hz6dObpI/1DLbH2
         nxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699362462; x=1699967262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8faCSD9R1TC2f+EpNI/nrykscjBaOlGP6zJq8U5y5OY=;
        b=s0wGhRmsoldyRzesCTge+h2/X8j8IGuByQCvEGxFPJrVUYy9M1OcUA+Oqj4cYAfuiY
         M+JocddYkKFsHfQUlzO61zbWmj5AAend43Y9BPXtMBLVFErT+A8F8+sEfL5gappqvZK4
         MTKjsW8a1y2RTIazDo/JS+S7r9h3oEkm3ZxxclzH/4uwIr89pcWXelUDZ/DEFDzTVuUz
         2og0jpGogZ53CawodvDj6Vf2Xxs0iaUfTXvJ9MNNi2YJt7Uglh/Buf9usyfNZZaTxKoF
         aMK99mUmk5w29aXG2evF2Xk0z5kQxnWYtYcCXjluiqsWK8FxMElgWY026CSLY0tLJkVi
         HvZQ==
X-Gm-Message-State: AOJu0Yzs+G+xytnszXWKge4gc6cVqQZzm0r8ng1FDFkWG8J31JPX/3kT
	9Dr0wdwlGmKOx6mITHSWFTMsK5QZt1U=
X-Google-Smtp-Source: AGHT+IE28xW/wteRpHv7B0wBv5ygiXoYsto5OiXuPknlHlp/kVLJPqihaR86wrl+1il7LUgYuDSH8w==
X-Received: by 2002:a17:907:ea1:b0:9dd:6664:1a3a with SMTP id ho33-20020a1709070ea100b009dd66641a3amr10302525ejc.51.1699362461324;
        Tue, 07 Nov 2023 05:07:41 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id g26-20020a1709064e5a00b009b9a1714524sm1047079ejw.12.2023.11.07.05.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 05:07:40 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 7 Nov 2023 14:07:39 +0100
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v2] libbpf: Fix potential uninitialized tail
 padding with LIBBPF_OPTS_RESET
Message-ID: <ZUo2mw46o6WAylUc@krava>
References: <20231107062936.2537338-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107062936.2537338-1-yonghong.song@linux.dev>

On Mon, Nov 06, 2023 at 10:29:36PM -0800, Yonghong Song wrote:
> Martin reported that there is a libbpf complaining of non-zero-value tail
> padding with LIBBPF_OPTS_RESET macro if struct bpf_netkit_opts is modified
> to have a 4-byte tail padding. This only happens to clang compiler.
> The commend line is: ./test_progs -t tc_netkit_multi_links
> Martin and I did some investigation and found this indeed the case and
> the following are the investigation details.
> 
> Clang 18:
>   clang version 18.0.0
>   <I tried clang15/16/17 and they all have similar results>
> 
> tools/lib/bpf/libbpf_common.h:
>   #define LIBBPF_OPTS_RESET(NAME, ...)                                      \
>         do {                                                                \
>                 memset(&NAME, 0, sizeof(NAME));                             \
>                 NAME = (typeof(NAME)) {                                     \
>                         .sz = sizeof(NAME),                                 \
>                         __VA_ARGS__                                         \
>                 };                                                          \
>         } while (0)
> 
>   #endif
> 
> tools/lib/bpf/libbpf.h:
>   struct bpf_netkit_opts {
>         /* size of this struct, for forward/backward compatibility */
>         size_t sz;
>         __u32 flags;
>         __u32 relative_fd;
>         __u32 relative_id;
>         __u64 expected_revision;
>         size_t :0;
>   };
>   #define bpf_netkit_opts__last_field expected_revision
> In the above struct bpf_netkit_opts, there is no tail padding.
> 
> prog_tests/tc_netkit.c:
>   static void serial_test_tc_netkit_multi_links_target(int mode, int target)
>   {
>         ...
>         LIBBPF_OPTS(bpf_netkit_opts, optl);
>         ...
>         LIBBPF_OPTS_RESET(optl,
>                 .flags = BPF_F_BEFORE,
>                 .relative_fd = bpf_program__fd(skel->progs.tc1),
>         );
>         ...
>   }
> 
> Let us make the following source change, note that we have a 4-byte
> tailing padding now.
>   diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>   index 6cd9c501624f..0dd83910ae9a 100644
>   --- a/tools/lib/bpf/libbpf.h
>   +++ b/tools/lib/bpf/libbpf.h
>   @@ -803,13 +803,13 @@ bpf_program__attach_tcx(const struct bpf_program *prog, int ifindex,
>    struct bpf_netkit_opts {
>         /* size of this struct, for forward/backward compatibility */
>         size_t sz;
>   -       __u32 flags;
>         __u32 relative_fd;
>         __u32 relative_id;
>         __u64 expected_revision;
>   +       __u32 flags;
>         size_t :0;
>    };
>   -#define bpf_netkit_opts__last_field expected_revision
>   +#define bpf_netkit_opts__last_field flags
> 
> The clang 18 generated asm code looks like below:
>     ;       LIBBPF_OPTS_RESET(optl,
>     55e3: 48 8d 7d 98                   leaq    -0x68(%rbp), %rdi
>     55e7: 31 f6                         xorl    %esi, %esi
>     55e9: ba 20 00 00 00                movl    $0x20, %edx
>     55ee: e8 00 00 00 00                callq   0x55f3 <serial_test_tc_netkit_multi_links_target+0x18d3>
>     55f3: 48 c7 85 10 fd ff ff 20 00 00 00      movq    $0x20, -0x2f0(%rbp)
>     55fe: 48 8b 85 68 ff ff ff          movq    -0x98(%rbp), %rax
>     5605: 48 8b 78 18                   movq    0x18(%rax), %rdi
>     5609: e8 00 00 00 00                callq   0x560e <serial_test_tc_netkit_multi_links_target+0x18ee>
>     560e: 89 85 18 fd ff ff             movl    %eax, -0x2e8(%rbp)
>     5614: c7 85 1c fd ff ff 00 00 00 00 movl    $0x0, -0x2e4(%rbp)
>     561e: 48 c7 85 20 fd ff ff 00 00 00 00      movq    $0x0, -0x2e0(%rbp)
>     5629: c7 85 28 fd ff ff 08 00 00 00 movl    $0x8, -0x2d8(%rbp)
>     5633: 48 8b 85 10 fd ff ff          movq    -0x2f0(%rbp), %rax
>     563a: 48 89 45 98                   movq    %rax, -0x68(%rbp)
>     563e: 48 8b 85 18 fd ff ff          movq    -0x2e8(%rbp), %rax
>     5645: 48 89 45 a0                   movq    %rax, -0x60(%rbp)
>     5649: 48 8b 85 20 fd ff ff          movq    -0x2e0(%rbp), %rax
>     5650: 48 89 45 a8                   movq    %rax, -0x58(%rbp)
>     5654: 48 8b 85 28 fd ff ff          movq    -0x2d8(%rbp), %rax
>     565b: 48 89 45 b0                   movq    %rax, -0x50(%rbp)
>     ;       link = bpf_program__attach_netkit(skel->progs.tc2, ifindex, &optl);
> 
> At -O0 level, the clang compiler creates an intermediate copy.
> We have below to store 'flags' with 4-byte store and leave another 4 byte
> in the same 8-byte-aligned storage undefined,
>     5629: c7 85 28 fd ff ff 08 00 00 00 movl    $0x8, -0x2d8(%rbp)
> and later we store 8-byte to the original zero'ed buffer
>     5654: 48 8b 85 28 fd ff ff          movq    -0x2d8(%rbp), %rax
>     565b: 48 89 45 b0                   movq    %rax, -0x50(%rbp)
> 
> This caused a problem as the 4-byte value at [%rbp-0x2dc, %rbp-0x2e0)
> may be garbage.
> 
> gcc (gcc 11.4) does not have this issue as it does zeroing struct first before
> doing assignments:
>   ;       LIBBPF_OPTS_RESET(optl,
>     50fd: 48 8d 85 40 fc ff ff          leaq    -0x3c0(%rbp), %rax
>     5104: ba 20 00 00 00                movl    $0x20, %edx
>     5109: be 00 00 00 00                movl    $0x0, %esi
>     510e: 48 89 c7                      movq    %rax, %rdi
>     5111: e8 00 00 00 00                callq   0x5116 <serial_test_tc_netkit_multi_links_target+0x1522>
>     5116: 48 8b 45 f0                   movq    -0x10(%rbp), %rax
>     511a: 48 8b 40 18                   movq    0x18(%rax), %rax
>     511e: 48 89 c7                      movq    %rax, %rdi
>     5121: e8 00 00 00 00                callq   0x5126 <serial_test_tc_netkit_multi_links_target+0x1532>
>     5126: 48 c7 85 40 fc ff ff 00 00 00 00      movq    $0x0, -0x3c0(%rbp)
>     5131: 48 c7 85 48 fc ff ff 00 00 00 00      movq    $0x0, -0x3b8(%rbp)
>     513c: 48 c7 85 50 fc ff ff 00 00 00 00      movq    $0x0, -0x3b0(%rbp)
>     5147: 48 c7 85 58 fc ff ff 00 00 00 00      movq    $0x0, -0x3a8(%rbp)
>     5152: 48 c7 85 40 fc ff ff 20 00 00 00      movq    $0x20, -0x3c0(%rbp)
>     515d: 89 85 48 fc ff ff             movl    %eax, -0x3b8(%rbp)
>     5163: c7 85 58 fc ff ff 08 00 00 00 movl    $0x8, -0x3a8(%rbp)
>   ;       link = bpf_program__attach_netkit(skel->progs.tc2, ifindex, &optl);
> 
> It is not clear how to resolve the compiler code generation as the compiler
> generates correct code w.r.t. how to handle unnamed padding in C standard.
> So this patch changed LIBBPF_OPTS_RESET macro to avoid uninitialized tail
> padding. We already knows LIBBPF_OPTS macro works on both gcc and clang,
> even with tail padding. So LIBBPF_OPTS_RESET is changed to be a
> LIBBPF_OPTS followed by a memcpy(), thus avoiding uninitialized tail padding.

if that's the case, could we just do (untested):

diff --git a/tools/lib/bpf/libbpf_common.h b/tools/lib/bpf/libbpf_common.h
index b7060f254486..c89d4dbbebd8 100644
--- a/tools/lib/bpf/libbpf_common.h
+++ b/tools/lib/bpf/libbpf_common.h
@@ -79,11 +79,8 @@
  */
 #define LIBBPF_OPTS_RESET(NAME, ...)					    \
 	do {								    \
-		memset(&NAME, 0, sizeof(NAME));				    \
-		NAME = (typeof(NAME)) {					    \
-			.sz = sizeof(NAME),				    \
-			__VA_ARGS__					    \
-		};							    \
+		LIBBPF_OPTS(___##NAME, __VA_ARGS__);			    \
+		memcpy(&NAME, &___##NAME, sizeof(typeof(NAME)));	    \
 	} while (0)
 
 #endif /* __LIBBPF_LIBBPF_COMMON_H */


jirka

> 
> The below is asm code generated with this patch and with clang compiler:
>     ;       LIBBPF_OPTS_RESET(optl,
>     55e3: 48 8d bd 10 fd ff ff          leaq    -0x2f0(%rbp), %rdi
>     55ea: 31 f6                         xorl    %esi, %esi
>     55ec: ba 20 00 00 00                movl    $0x20, %edx
>     55f1: e8 00 00 00 00                callq   0x55f6 <serial_test_tc_netkit_multi_links_target+0x18d6>
>     55f6: 48 c7 85 10 fd ff ff 20 00 00 00      movq    $0x20, -0x2f0(%rbp)
>     5601: 48 8b 85 68 ff ff ff          movq    -0x98(%rbp), %rax
>     5608: 48 8b 78 18                   movq    0x18(%rax), %rdi
>     560c: e8 00 00 00 00                callq   0x5611 <serial_test_tc_netkit_multi_links_target+0x18f1>
>     5611: 89 85 18 fd ff ff             movl    %eax, -0x2e8(%rbp)
>     5617: c7 85 1c fd ff ff 00 00 00 00 movl    $0x0, -0x2e4(%rbp)
>     5621: 48 c7 85 20 fd ff ff 00 00 00 00      movq    $0x0, -0x2e0(%rbp)
>     562c: c7 85 28 fd ff ff 08 00 00 00 movl    $0x8, -0x2d8(%rbp)
>     5636: 48 8b 85 10 fd ff ff          movq    -0x2f0(%rbp), %rax
>     563d: 48 89 45 98                   movq    %rax, -0x68(%rbp)
>     5641: 48 8b 85 18 fd ff ff          movq    -0x2e8(%rbp), %rax
>     5648: 48 89 45 a0                   movq    %rax, -0x60(%rbp)
>     564c: 48 8b 85 20 fd ff ff          movq    -0x2e0(%rbp), %rax
>     5653: 48 89 45 a8                   movq    %rax, -0x58(%rbp)
>     5657: 48 8b 85 28 fd ff ff          movq    -0x2d8(%rbp), %rax
>     565e: 48 89 45 b0                   movq    %rax, -0x50(%rbp)
>     ;       link = bpf_program__attach_netkit(skel->progs.tc2, ifindex, &optl);
> 
> In the above code, a temporary buffer is zeroed and then has proper value assigned.
> Finally, values in temporary buffer are copied to the original variable buffer,
> hence tail padding is guaranteed to be 0.
> 
> Cc: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/lib/bpf/libbpf_common.h | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> Changelog:
>   v1 -> v2:
>     - Do not change the LIBBPF_OPTS_RESET macro definition, rather
>       re-implement to avoid potential uninitialized tail padding.
> 
>   v1 link: https://lore.kernel.org/bpf/20231105185358.1036619-1-yonghong.song@linux.dev/
> 
> diff --git a/tools/lib/bpf/libbpf_common.h b/tools/lib/bpf/libbpf_common.h
> index b7060f254486..ef14e99bc952 100644
> --- a/tools/lib/bpf/libbpf_common.h
> +++ b/tools/lib/bpf/libbpf_common.h
> @@ -79,11 +79,14 @@
>   */
>  #define LIBBPF_OPTS_RESET(NAME, ...)					    \
>  	do {								    \
> -		memset(&NAME, 0, sizeof(NAME));				    \
> -		NAME = (typeof(NAME)) {					    \
> -			.sz = sizeof(NAME),				    \
> -			__VA_ARGS__					    \
> -		};							    \
> +		typeof(NAME) ___##NAME = ({ 				    \
> +			memset(&___##NAME, 0, sizeof(typeof(NAME)));	    \
> +			(typeof(NAME)) {				    \
> +				.sz = sizeof(typeof(NAME)),		    \
> +				__VA_ARGS__				    \
> +			};						    \
> +		});							    \
> +		memcpy(&NAME, &___##NAME, sizeof(typeof(NAME)));	    \
>  	} while (0)
>  
>  #endif /* __LIBBPF_LIBBPF_COMMON_H */
> -- 
> 2.34.1
> 
> 

