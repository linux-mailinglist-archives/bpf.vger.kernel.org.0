Return-Path: <bpf+bounces-47251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5239F6A10
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 16:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03ED31887949
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 15:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9560B1F0E40;
	Wed, 18 Dec 2024 15:31:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420D0481B3;
	Wed, 18 Dec 2024 15:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734535902; cv=none; b=oXSf3NXPW+Xz/tCExtk2LszZ1wIKrPJT4V7s3Q+8HcTfJ5gbRBQUTIgClxbu9N4scxSCLZhrawGSPw314FkVRNG0ua2pSWBtWUKsjmv3DAyPEl9veFs3H5f/AQbU5A1I3fiH3vOwYj6syRcBU8BtTqEgu0iM+jF5t1yCbgDumAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734535902; c=relaxed/simple;
	bh=uxoW3dZR+pAQw4zfTbsB1zo6/gQDW9tYH4aVUTgWSU0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fkcfhcSKgMjS2l/9gqZ0vHeCLVsgKnSwNyaqqgZ1wA4k6gcEz7Hsusv081KDIL6IkLlXxN9l+zYvD6V2WCtBjiMYvP7CDkhd6eeH03yaKdax5DrSM/IRHtM8Lgua9tHsM/TcVOi66prFREzqF4VDFTtKOy2iI8/pH9xpe37QKok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C51C4CECD;
	Wed, 18 Dec 2024 15:31:40 +0000 (UTC)
Date: Wed, 18 Dec 2024 10:32:18 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Florent Revest <revest@google.com>, LKML
 <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH] vsprintf: simplify number handling
Message-ID: <20241218103218.7dc82306@gandalf.local.home>
In-Reply-To: <20241218013620.1679088-1-torvalds@linux-foundation.org>
References: <CAHk-=whOM+D1D4wb5M_SGQeiDSQbmUTrpjghy2+ivo6s1aXwFQ@mail.gmail.com>
	<20241218013620.1679088-1-torvalds@linux-foundation.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Dec 2024 17:32:09 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> @@ -2747,6 +2737,17 @@ set_precision(struct printf_spec *spec, int prec)
>  	}
>  }
>  
> +/* Turn a 1/2/4-byte value into a 64-bit one with sign handling */
> +static unsigned long long get_num(unsigned int val, struct printf_spec spec)
> +{
> +	unsigned int shift = 32 - spec.type*8;
> +
> +	val <<= shift;
> +	if (!(spec.flags & SIGN))
> +		return val >> shift;
> +	return (int)val >> shift;
> +}

I was about to make the same comment that Rasmus said about not bothering
with the shift if it is not signed, but I won't repeat that.

> +
>  /**
>   * vsnprintf - Format a string and place it in a buffer
>   * @buf: The buffer to place the result into
> @@ -2873,43 +2874,10 @@ int vsnprintf(char *buf, size_t size, const char *fmt, va_list args)
>  			goto out;
>  
>  		default:
> -			switch (spec.type) {
> -			case FORMAT_TYPE_LONG_LONG:
> +			if (spec.type == FORMAT_TYPE_8BYTE)
>  				num = va_arg(args, long long);
> -				break;
> -			case FORMAT_TYPE_ULONG:
> -				num = va_arg(args, unsigned long);
> -				break;
> -			case FORMAT_TYPE_LONG:
> -				num = va_arg(args, long);
> -				break;
> -			case FORMAT_TYPE_SIZE_T:
> -				if (spec.flags & SIGN)
> -					num = va_arg(args, ssize_t);
> -				else
> -					num = va_arg(args, size_t);
> -				break;
> -			case FORMAT_TYPE_PTRDIFF:
> -				num = va_arg(args, ptrdiff_t);
> -				break;
> -			case FORMAT_TYPE_UBYTE:
> -				num = (unsigned char) va_arg(args, int);
> -				break;
> -			case FORMAT_TYPE_BYTE:
> -				num = (signed char) va_arg(args, int);
> -				break;
> -			case FORMAT_TYPE_USHORT:
> -				num = (unsigned short) va_arg(args, int);
> -				break;
> -			case FORMAT_TYPE_SHORT:
> -				num = (short) va_arg(args, int);
> -				break;
> -			case FORMAT_TYPE_INT:
> -				num = (int) va_arg(args, int);
> -				break;
> -			default:
> -				num = va_arg(args, unsigned int);
> -			}
> +			else
> +				num = get_num(va_arg(args, int), spec);

The function name should likely be called:

    make_num_long_long(va_arg(args, int), spec);

Because after even reading the get_num() function, when I came down here I
had to go back up to make sure that was the function I was looking at, as
"get_num()" doesn't mean anything to me.


>  
>  			str = number(str, end, num, spec);
>  		}
> @@ -3183,26 +3151,13 @@ int vbin_printf(u32 *bin_buf, size_t size, const char *fmt, va_list args)
>  
>  		default:
>  			switch (spec.type) {
> -
> -			case FORMAT_TYPE_LONG_LONG:
> +			case FORMAT_TYPE_8BYTE:
>  				save_arg(long long);
>  				break;
> -			case FORMAT_TYPE_ULONG:
> -			case FORMAT_TYPE_LONG:
> -				save_arg(unsigned long);
> -				break;
> -			case FORMAT_TYPE_SIZE_T:
> -				save_arg(size_t);
> -				break;
> -			case FORMAT_TYPE_PTRDIFF:
> -				save_arg(ptrdiff_t);
> -				break;
> -			case FORMAT_TYPE_UBYTE:
> -			case FORMAT_TYPE_BYTE:
> +			case FORMAT_TYPE_1BYTE:
>  				save_arg(char);
>  				break;
> -			case FORMAT_TYPE_USHORT:
> -			case FORMAT_TYPE_SHORT:
> +			case FORMAT_TYPE_2BYTE:
>  				save_arg(short);
>  				break;
>  			default:
> @@ -3375,37 +3330,17 @@ int bstr_printf(char *buf, size_t size, const char *fmt, const u32 *bin_buf)
>  			unsigned long long num;
>  
>  			switch (spec.type) {
> -
> -			case FORMAT_TYPE_LONG_LONG:
> +			case FORMAT_TYPE_8BYTE:
>  				num = get_arg(long long);
>  				break;
> -			case FORMAT_TYPE_ULONG:
> -			case FORMAT_TYPE_LONG:
> -				num = get_arg(unsigned long);
> +			case FORMAT_TYPE_2BYTE:
> +				num = get_num(get_arg(short), spec);
>  				break;
> -			case FORMAT_TYPE_SIZE_T:
> -				num = get_arg(size_t);
> -				break;
> -			case FORMAT_TYPE_PTRDIFF:
> -				num = get_arg(ptrdiff_t);
> -				break;
> -			case FORMAT_TYPE_UBYTE:
> -				num = get_arg(unsigned char);
> -				break;
> -			case FORMAT_TYPE_BYTE:
> -				num = get_arg(signed char);
> -				break;
> -			case FORMAT_TYPE_USHORT:
> -				num = get_arg(unsigned short);
> -				break;
> -			case FORMAT_TYPE_SHORT:
> -				num = get_arg(short);
> -				break;
> -			case FORMAT_TYPE_UINT:
> -				num = get_arg(unsigned int);
> +			case FORMAT_TYPE_1BYTE:
> +				num = get_num(get_arg(char), spec);
>  				break;
>  			default:
> -				num = get_arg(int);
> +				num = get_num(get_arg(int), spec);
>  			}
>  
>  			str = number(str, end, num, spec);
> -- 

I went to test this by adding the following:

diff --git a/samples/trace_printk/trace-printk.c b/samples/trace_printk/trace-printk.c
index cfc159580263..1ff688637404 100644
--- a/samples/trace_printk/trace-printk.c
+++ b/samples/trace_printk/trace-printk.c
@@ -43,6 +43,17 @@ static int __init trace_printk_init(void)
 
 	trace_printk(trace_printk_test_global_str_fmt, "", "dynamic string");
 
+	trace_printk("Print unsigned long long %llu\n", -1LL);
+	trace_printk("Print long long %lld\n", -1LL);
+	trace_printk("Print unsigned long %llu\n", -1L);
+	trace_printk("Print long  %ld\n", -1L);
+	trace_printk("Print unsigned int %u\n", -1);
+	trace_printk("Print int %d\n", -1);
+	trace_printk("Print unsigned short %hu\n", (short)-1);
+	trace_printk("Print short %hd\n", (short)-1);
+	trace_printk("Print unsigned char %hhu\n", (char)-1);
+	trace_printk("Print char %hhd\n", (char)-1);
+
 	return 0;
 }
 
And the trace file looks fine:

 # modprobe trace-printk
 # cat /sys/kernel/tracing/trace

        modprobe-905     [003] .....   113.624838: init_module: Print unsigned long long 18446744073709551615
        modprobe-905     [003] .....   113.624838: init_module: Print long long -1
        modprobe-905     [003] .....   113.624839: init_module: Print unsigned long 18446744073709551615
        modprobe-905     [003] .....   113.624839: init_module: Print long  -1
        modprobe-905     [003] .....   113.624840: init_module: Print unsigned int 4294967295
        modprobe-905     [003] .....   113.624841: init_module: Print int -1
        modprobe-905     [003] .....   113.624841: init_module: Print unsigned short 65535
        modprobe-905     [003] .....   113.624842: init_module: Print short -1
        modprobe-905     [003] .....   113.624843: init_module: Print unsigned char 255
        modprobe-905     [003] .....   113.624843: init_module: Print char -1

But when I did the following:

 # trace-cmd extract
 # trace-cmd report

It showed:

        modprobe-905   [003] .....   113.624838: bprint:               init_module: Print unsigned long long 18446744073709551615
        modprobe-905   [003] .....   113.624838: bprint:               init_module: Print long long -1
        modprobe-905   [003] .....   113.624839: bprint:               init_module: Print unsigned long 18446744073709551615
        modprobe-905   [003] .....   113.624839: bprint:               init_module: Print long  -1
        modprobe-905   [003] .....   113.624840: bprint:               init_module: Print unsigned int 4294967295
        modprobe-905   [003] .....   113.624841: bprint:               init_module: Print int -1
        modprobe-905   [003] .....   113.624841: bprint:               init_module: Print unsigned short u
        modprobe-905   [003] .....   113.624842: bprint:               [FAILED TO PARSE] ip=0xffffffffc060e045 fmt=0xffff8c05c338e760 buf=ARRAY[]
        modprobe-905   [003] .....   113.624843: bprint:               [FAILED TO PARSE] ip=0xffffffffc060e045 fmt=0xffff8c05c338ec40 buf=ARRAY[]
        modprobe-905   [003] .....   113.624843: bprint:               [FAILED TO PARSE] ip=0xffffffffc060e045 fmt=0xffff8c05c338e280 buf=ARRAY[]

Those "[FAILED TO PARSE]" messages have nothing to do with your code, but
it means that it doesn't handle 'h' at all. Even the "unsigned short"
printed but still failed to parse properly.

This is because libtraceevent appears to not support "%h" in print formats.
That at least means there would be no breakage if they are modified in any
way.

-- Steve

