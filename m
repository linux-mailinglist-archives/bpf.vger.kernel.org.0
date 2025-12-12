Return-Path: <bpf+bounces-76503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 856AACB7A6A
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 03:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B5A130303B5
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 02:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAED7299AA9;
	Fri, 12 Dec 2025 02:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxQRWSMi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48487285CB2
	for <bpf@vger.kernel.org>; Fri, 12 Dec 2025 02:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765505705; cv=none; b=X3dSiklIl1/wvFScPKL08+EmaQwCs78vDgYv5XLkY7QOD+jZtedefCP64FrKMrxNB/lZinWS861lUo5+UPmjQPZLR4MlDL9mHi+ua2/O5hqy0mPp6BIac/OLENDrBT7daVXyAIaCY6ZbCini7imfJGkjO6eIJ/s3pTyGvukiEwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765505705; c=relaxed/simple;
	bh=NgUM7aUL53vWNz7WHajf0MM0Z41X1RaW7qHFuEbiPvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChBD/aYrNabhonSWckVFGDFvymvbw/VqeFSioTsSrax4w/bJyv7h7wfW3Pr9eg09IP2RHfgokRFYvtXtb8a8RErVOOjBdxmqn2ryBJOAl7rfq3qMGK1HED1tnz9CXt3AuzNilW+qR2u7AlV7i/owTYS84k681qd6myQ7gABmSJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxQRWSMi; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b7355f6ef12so134318366b.3
        for <bpf@vger.kernel.org>; Thu, 11 Dec 2025 18:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765505701; x=1766110501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jILMO67J70f6QfvYn7/aUo6kYXXEvH0iYZzNH3i3Ki8=;
        b=dxQRWSMiuEO7gQWM9uKjoDEDwaDq9tmScqZtS/xmB8YtN1Z4wGQiKHwsb3wJSN6nFG
         vbAyRQyMFVq8fzCkb3w+3FiZhxKEDv6N0+lf/pK2V4esxME5ajFZUOTYgSZOn1XnV40U
         rHWZyb8Hu5+2rJ+AUhQYzfFd8AOclCfSN3VWSr6QlrMi249Okqavoz2umJ6ESvOfXyXz
         p5dap0yylcnvrgrysrGHn1tHIFVG0vhqcV2xtvxfDv2UD8SMTU0imyeSzyaOgrzLdRIi
         9+oShR8QkRi2Ues9U4I6MJbbX2IztIQz067q4/nlmN8T8o5NKSfUxReuqbINBDmXWXiY
         YjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765505701; x=1766110501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jILMO67J70f6QfvYn7/aUo6kYXXEvH0iYZzNH3i3Ki8=;
        b=OByf0IR/UsCnJ9g6xmgPlWwGpr3LEUpeuX6bBMyBszkJqyV9MyKXABUWE5OtZ2FhQC
         2aSUrjvLQZFuBPzAAfTfLOtbIJ8XOfmImPAapdBvGjOiWDYsfowJZ67K3ev5e1h8z9nf
         tpakmtGkEDvP2xAlFeRD3fLTSXw28miL/+PiDtnrzJKmf9ZNCgoXK9NdigaycsS5y8JQ
         VgdSMiGIkhErh9Dy21JD1HCPEmJekc4zuhlay13fZcKuAHJ0MfirdkA9W8EH4nr1x8DA
         VACRKos+lSW0MqgKhJQxgQ1CcDGF4KSIYgmtWb0CAXY7Yo9CbLF3b0Vk8XjWaI7bhoti
         SIKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXA4YvaO2Q8E8iLQsFppmd1Gs8lNlnlWFhqOIgZJTA+HoPhZgNjlYu2lZU8Roa6UlFEO7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfLZ4eSK1dnZCP+9VWkcIbYdA2L1PQBq3V+gBvQ39Nmb8l7Jgh
	WeMqF49eOaBc1wyTPqXX48pWJiXnHVO204u62luPfevzuAps+2h9/A87EeWO+n3h2oXVWcIicm8
	mU8IRW8P1yf+l+m+EV9pCMpOQKnFRP5j31sVmZrn84g==
X-Gm-Gg: AY/fxX5UHL+pf1SSxGxxyYdmnlqtiuPTVNMmfX2fvhNFR/2YrQUSdIq2Ec8oQovG9sE
	8jYCOABts/z0XDW6pxMFjyYOFMY3rDiY12T5Iq83iReUAgKSCozEJ1hSbMganD0LsB0579aHoZ3
	XZrDl/VUyEjTXLnhaCAxhmIcs+Y3MIqTJnvoAmuwxIY6aA0XAvqAPE5ueCCas+Dj8w63AGLC4XL
	73AYTxRDg2E+jqWTfUTLADid3u9JDkeJD2r1qiE+/2TTZwOHL/JV60ZHGLm3KeX3T1zILJr
X-Google-Smtp-Source: AGHT+IF3KrwmJyi+HSGGfvgFeecEYMXvJ0CLnWlzZJQVAK20zGOIt0iGIK528x74ScjATJY85UNp7s0TG6wMvgPIERk=
X-Received: by 2002:a17:906:4fc8:b0:b79:f8f7:38ea with SMTP id
 a640c23a62f3a-b7d23c5bccfmr22798866b.45.1765505700461; Thu, 11 Dec 2025
 18:15:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251209121349.525641-1-dolinux.peng@gmail.com> <20251209121349.525641-3-dolinux.peng@gmail.com>
In-Reply-To: <20251209121349.525641-3-dolinux.peng@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 12 Dec 2025 10:14:48 +0800
X-Gm-Features: AQt7F2oN7ai-ywwCTeofI2LxJYFaNlo_0sZ-Pwu5pKaO68ietmaecOnWf3-fGCY
Message-ID: <CAErzpmv4U5_VMq3nBeLduKaVMdDRL0d8MQoH9Rafpy4hmbmnsg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] tracing: Update funcgraph-retval documentation
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 8:14=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.com=
> wrote:
>
> From: pengdonglin <pengdonglin@xiaomi.com>
>
> The existing documentation for funcgraph-retval is outdated and partially
> incorrect, as it describes limitations that have now been resolved.
>
> Recent changes (e.g., using BTF to obtain function return types) have
> addressed key issues:
> 1. Return values are now printed only for non-void functions.
> 2. Values are trimmed to the correct width of the return type, avoiding
>    garbage data from high bits.
>
> Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> ---
>  Documentation/trace/ftrace.rst | 78 ++++++++++++++++++++--------------
>  1 file changed, 45 insertions(+), 33 deletions(-)
>
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.=
rst
> index d1f313a5f4ad..03c8c433c803 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -1454,6 +1454,10 @@ Options for function_graph tracer:
>         printed in hexadecimal format. By default, this option
>         is off.
>
> +  funcgraph-retaddr
> +       When set, the return address will always be printed.
> +       By default, this option is off.
> +
>    sleep-time
>         When running function graph tracer, to include
>         the time a task schedules out in its function.
> @@ -2800,7 +2804,7 @@ It is default disabled.
>      0)   2.861 us    |      } /* putname() */
>
>  The return value of each traced function can be displayed after
> -an equal sign "=3D". When encountering system call failures, it
> +an equal sign "ret =3D". When encountering system call failures, it
>  can be very helpful to quickly locate the function that first
>  returns an error code.
>
> @@ -2810,16 +2814,16 @@ returns an error code.
>    Example with funcgraph-retval::
>
>      1)               |    cgroup_migrate() {
> -    1)   0.651 us    |      cgroup_migrate_add_task(); /* =3D 0xffff93fc=
fd346c00 */
> +    1)   0.651 us    |      cgroup_migrate_add_task(); /* ret=3D0xffff93=
fcfd346c00 */
>      1)               |      cgroup_migrate_execute() {
>      1)               |        cpu_cgroup_can_attach() {
>      1)               |          cgroup_taskset_first() {
> -    1)   0.732 us    |            cgroup_taskset_next(); /* =3D 0xffff93=
fc8fb20000 */
> -    1)   1.232 us    |          } /* cgroup_taskset_first =3D 0xffff93fc=
8fb20000 */
> -    1)   0.380 us    |          sched_rt_can_attach(); /* =3D 0x0 */
> -    1)   2.335 us    |        } /* cpu_cgroup_can_attach =3D -22 */
> -    1)   4.369 us    |      } /* cgroup_migrate_execute =3D -22 */
> -    1)   7.143 us    |    } /* cgroup_migrate =3D -22 */
> +    1)   0.732 us    |            cgroup_taskset_next(); /* ret=3D0xffff=
93fc8fb20000 */
> +    1)   1.232 us    |          } /* cgroup_taskset_first ret=3D0xffff93=
fc8fb20000 */
> +    1)   0.380 us    |          sched_rt_can_attach(); /* ret=3D0x0 */
> +    1)   2.335 us    |        } /* cpu_cgroup_can_attach ret=3D-22 */
> +    1)   4.369 us    |      } /* cgroup_migrate_execute ret=3D-22 */
> +    1)   7.143 us    |    } /* cgroup_migrate ret=3D-22 */
>
>  The above example shows that the function cpu_cgroup_can_attach
>  returned the error code -22 firstly, then we can read the code
> @@ -2836,37 +2840,41 @@ printed in hexadecimal format.
>    Example with funcgraph-retval-hex::
>
>      1)               |      cgroup_migrate() {
> -    1)   0.651 us    |        cgroup_migrate_add_task(); /* =3D 0xffff93=
fcfd346c00 */
> +    1)   0.651 us    |        cgroup_migrate_add_task(); /* ret=3D0xffff=
93fcfd346c00 */
>      1)               |        cgroup_migrate_execute() {
>      1)               |          cpu_cgroup_can_attach() {
>      1)               |            cgroup_taskset_first() {
> -    1)   0.732 us    |              cgroup_taskset_next(); /* =3D 0xffff=
93fc8fb20000 */
> -    1)   1.232 us    |            } /* cgroup_taskset_first =3D 0xffff93=
fc8fb20000 */
> -    1)   0.380 us    |            sched_rt_can_attach(); /* =3D 0x0 */
> -    1)   2.335 us    |          } /* cpu_cgroup_can_attach =3D 0xffffffe=
a */
> -    1)   4.369 us    |        } /* cgroup_migrate_execute =3D 0xffffffea=
 */
> +    1)   0.732 us    |              cgroup_taskset_next(); /* ret=3D0xff=
ff93fc8fb20000 */
> +    1)   1.232 us    |            } /* cgroup_taskset_first ret=3D0xffff=
93fc8fb20000 */
> +    1)   0.380 us    |            sched_rt_can_attach(); /* ret=3D0x0 */
> +    1)   2.335 us    |          } /* cpu_cgroup_can_attach ret=3D0xfffff=
fea */
> +    1)   4.369 us    |        } /* cgroup_migrate_execute ret=3D0xffffff=
ea */
>      1)   7.143 us    |      } /* cgroup_migrate =3D 0xffffffea */

My bad for forgetting to update the above line and will fix it in the
next version.

>
> -At present, there are some limitations when using the funcgraph-retval
> -option, and these limitations will be eliminated in the future:
> +Note that there are some limitations when using the funcgraph-retval
> +option:
> +
> +- If CONFIG_DEBUG_INFO_BTF is disabled (n), a return value is printed ev=
en for
> +  functions with a void return type. When CONFIG_DEBUG_INFO_BTF is enabl=
ed (y),
> +  the return value is printed only for non-void functions.
>
> -- Even if the function return type is void, a return value will still
> -  be printed, and you can just ignore it.
> +- If a return value occupies multiple registers, only the value in the f=
irst
> +  register is recorded and printed. For example, on the x86 architecture=
, a
> +  64-bit return value is stored across eax (lower 32 bits) and edx (uppe=
r 32 bits),
> +  but only the contents of eax are captured. If CONFIG_DEBUG_INFO_BTF is=
 enabled,
> +  the suffix "(trunc)" is appended to the printed value to indicate that=
 the
> +  output may be truncated because high-order register contents are omitt=
ed.
>
> -- Even if return values are stored in multiple registers, only the
> -  value contained in the first register will be recorded and printed.
> -  To illustrate, in the x86 architecture, eax and edx are used to store
> -  a 64-bit return value, with the lower 32 bits saved in eax and the
> -  upper 32 bits saved in edx. However, only the value stored in eax
> -  will be recorded and printed.
> +- Under certain procedure-call standards (e.g., arm64's AAPCS64), when t=
he return
> +  type is smaller than a general-purpose register (GPR), the caller is r=
esponsible
> +  for narrowing the value; the upper bits of the register may contain un=
defined data.
> +  For instance, when a u8 is returned in 64-bit GPR, bits [63:8] can hol=
d arbitrary
> +  values, especially when larger types are truncated (explicitly or impl=
icitly). It
> +  is therefore advisable to inspect the code in such cases. If CONFIG_DE=
BUG_INFO_BTF
> +  is enabled (y), the return value is automatically trimmed to the width=
 of the return
> +  type.
>
> -- In certain procedure call standards, such as arm64's AAPCS64, when a
> -  type is smaller than a GPR, it is the responsibility of the consumer
> -  to perform the narrowing, and the upper bits may contain UNKNOWN value=
s.
> -  Therefore, it is advisable to check the code for such cases. For insta=
nce,
> -  when using a u8 in a 64-bit GPR, bits [63:8] may contain arbitrary val=
ues,
> -  especially when larger types are truncated, whether explicitly or impl=
icitly.
> -  Here are some specific cases to illustrate this point:
> +  The following examples illustrate the behavior:
>
>    **Case One**:
>
> @@ -2885,7 +2893,9 @@ option, and these limitations will be eliminated in=
 the future:
>                 RET
>
>    If you pass 0x123456789abcdef to this function and want to narrow it,
> -  it may be recorded as 0x123456789abcdef instead of 0xef.
> +  it may be recorded as 0x123456789abcdef instead of 0xef. When
> +  CONFIG_DEBUG_INFO_BTF is enabled, the value will be correctly truncate=
d
> +  to 0xef based on the size constraints of the u8 type.
>
>    **Case Two**:
>
> @@ -2910,7 +2920,9 @@ option, and these limitations will be eliminated in=
 the future:
>                 RET
>
>    When passing 0x2_0000_0000 to it, the return value may be recorded as
> -  0x2_0000_0000 instead of 0.
> +  0x2_0000_0000 instead of 0. When CONFIG_DEBUG_INFO_BTF is enabled, the
> +  value will be correctly truncated to 0 based on the size constraints o=
f
> +  the int type.
>
>  You can put some comments on specific functions by using
>  trace_printk() For example, if you want to put a comment inside
> --
> 2.34.1
>

