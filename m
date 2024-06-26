Return-Path: <bpf+bounces-33145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A82CF917CF7
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 11:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 353401F23682
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 09:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BC616EB7B;
	Wed, 26 Jun 2024 09:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8DqpEDg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65A8EEDD;
	Wed, 26 Jun 2024 09:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719395531; cv=none; b=lBjjwSDHn8Om0LRvLkaIkETqXGEhQoNsJpZN4u40MPZJ8PnjZBSerlNoZekyaT0pgS05gy1u+VBIQQIRsv9YtHu0aW9ae9VePf+h9MSGHzMqNYQ1oVdsFGSexKhjIYPWC9PdukSO9rwpaweb8tHAikLaH2kUFa0bQr3LQ36RObM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719395531; c=relaxed/simple;
	bh=64sqvM6cHak9VcAxMqMwO/iZtuk2Mp9TwYxxVKgDipI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvjpcI1ZwOCUwMKEc6bm0RsrpuZQZbwrJR/L7IFL2dmcLtiIceCePl/pin5nYfZlz+yj5NuE1HLBAFX4HU05GstfGzhkaHm1H+QXeuCxCHbUi7IGB4neQtTW9uKXckFZ/yj6PWGRKChfqDZHhzj1IMxe2XjsC/xEWZsew9pvZHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8DqpEDg; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57d15b85a34so6933130a12.3;
        Wed, 26 Jun 2024 02:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719395528; x=1720000328; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hB1+Zfsc6xLUAk8Z6W/zq9nDL9N7bG1dnJ78D4kolzU=;
        b=R8DqpEDgpBs4QfWzRlckimoyQgrZzGIzsNHD3pYIwHzs7dyGPXFfCb2ASFJOFekhF8
         0rS7JU1PpmCfmuoAjIakBooeBt28zgFf7gSypHNV5A152iOo5vCZHzoPDEeFzf1AwBZa
         ODStVLz2HOE1xaW9h+Ic2jy5uihmVLp1wTAFaGLKH3eCO2P+bdNaP2NSEmlYqLs4yI4E
         dB11YrDM+Kafu20QmogUDloKkDh0AqZHYZioECNMIHW1VfNuFOq678+vKfR9GAUMe6sV
         S9wMrehpqXwfQXCa8fUCVG7KSPOp5mXGo+QlsWJ7IoUtm2YkmUVQxVU5dgi2f5bghf6c
         xC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719395528; x=1720000328;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hB1+Zfsc6xLUAk8Z6W/zq9nDL9N7bG1dnJ78D4kolzU=;
        b=H+xhXvtKywp0UYrdHlr45Ke2hfdZUapQOLfUL7VV6zLKknfL9M9+Vih1Y9yl5N1SQS
         Qp5k90GevPjwr4P/25awguGMAIqDN5aK5/6TMlyUtTc7PTZxNJ89Cf7KBLwvczCDUKod
         jTG/b3ZN7BsDrhIBeb5N67z448fQ4+ytt3CVqiHvClBSeaxtJzKJEm6HWEt7lqvDBhxs
         knDsF5CmEJxrLxNwoAscemwg/Y1ZX0TA7940Q/yOqsGu+CRmypIOpph/90XBT7HPG2I+
         cC/X3asSZCuijem6EfLfr5bj69tOENmMHFd7N+V8ksFero2iS5jR7/FX4ic3wKbTPM/I
         j0HA==
X-Forwarded-Encrypted: i=1; AJvYcCVRHGw4pNhZGcGLsJWSmOiXiyKux32aOv0kXtrah+YfaD19u+xqL4mf4/UploF1JrD+dFKkX/86FqfbH05KYzrT4VKHaFyHGQR48i+pT3AsfEJR/W+g1rB5y0HLcBGLx8kcdV3ZErl6oQNCfzBrkCummIgYyGcalVjz
X-Gm-Message-State: AOJu0YzgzS7MouKVg5ZdX41LVEZdOMRq36sS7t/jzvf545QdB17JMxMG
	Ft0zmEyGPioJp0CoPDJCd7iqZAGuJc4hv8TB3yOxbgB1IRRTDFr1
X-Google-Smtp-Source: AGHT+IGeJmOvzKGD7MwvxklVD5oFOsGtM1oGY0pdKRxtkMOv4QwIhpru59EL0euYAspAxuFBNMTIMw==
X-Received: by 2002:a50:c31e:0:b0:57d:1756:6bb1 with SMTP id 4fb4d7f45d1cf-57d457f622amr7548577a12.31.1719395527727;
        Wed, 26 Jun 2024 02:52:07 -0700 (PDT)
Received: from krava (net-93-147-243-244.cust.vodafonedsl.it. [93.147.243.244])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d303dad36sm6881769a12.19.2024.06.26.02.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 02:52:07 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 26 Jun 2024 11:52:04 +0200
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Tony Ambardar <tony.ambardar@gmail.com>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	kernel test robot <lkp@intel.com>, stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf v2 2/2] bpf: Harden __bpf_kfunc tag against linker
 kfunc removal
Message-ID: <ZnvkxLQBideJH4MB@krava>
References: <cover.1717413886.git.Tony.Ambardar@gmail.com>
 <cover.1717477560.git.Tony.Ambardar@gmail.com>
 <e9c64e9b5c073dabd457ff45128aabcab7630098.1717477560.git.Tony.Ambardar@gmail.com>
 <51bc27e-f073-f6f7-df63-f9bbf96e2024@linux-m68k.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51bc27e-f073-f6f7-df63-f9bbf96e2024@linux-m68k.org>

On Tue, Jun 25, 2024 at 12:46:48PM +0200, Geert Uytterhoeven wrote:
> 	Hi Tony,
> 
> On Mon, 3 Jun 2024, Tony Ambardar wrote:
> > BPF kfuncs are often not directly referenced and may be inadvertently
> > removed by optimization steps during kernel builds, thus the __bpf_kfunc
> > tag mitigates against this removal by including the __used macro. However,
> > this macro alone does not prevent removal during linking, and may still
> > yield build warnings (e.g. on mips64el):
> > 
> >    LD      vmlinux
> >    BTFIDS  vmlinux
> >  WARN: resolve_btfids: unresolved symbol bpf_verify_pkcs7_signature
> >  WARN: resolve_btfids: unresolved symbol bpf_lookup_user_key
> >  WARN: resolve_btfids: unresolved symbol bpf_lookup_system_key
> >  WARN: resolve_btfids: unresolved symbol bpf_key_put
> >  WARN: resolve_btfids: unresolved symbol bpf_iter_task_next
> >  WARN: resolve_btfids: unresolved symbol bpf_iter_css_task_new
> >  WARN: resolve_btfids: unresolved symbol bpf_get_file_xattr
> >  WARN: resolve_btfids: unresolved symbol bpf_ct_insert_entry
> >  WARN: resolve_btfids: unresolved symbol bpf_cgroup_release
> >  WARN: resolve_btfids: unresolved symbol bpf_cgroup_from_id
> >  WARN: resolve_btfids: unresolved symbol bpf_cgroup_acquire
> >  WARN: resolve_btfids: unresolved symbol bpf_arena_free_pages
> >    NM      System.map
> >    SORTTAB vmlinux
> >    OBJCOPY vmlinux.32
> > 
> > Update the __bpf_kfunc tag to better guard against linker optimization by
> > including the new __retain compiler macro, which fixes the warnings above.
> > 
> > Verify the __retain macro with readelf by checking object flags for 'R':
> > 
> >  $ readelf -Wa kernel/trace/bpf_trace.o
> >  Section Headers:
> >    [Nr]  Name              Type     Address  Off  Size ES Flg Lk Inf Al
> >  ...
> >    [178] .text.bpf_key_put PROGBITS 00000000 6420 0050 00 AXR  0   0  8
> >  ...
> >  Key to Flags:
> >  ...
> >    R (retain), D (mbind), p (processor specific)
> > 
> > Link: https://lore.kernel.org/bpf/ZlmGoT9KiYLZd91S@krava/T/
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/r/202401211357.OCX9yllM-lkp@intel.com/
> > Fixes: 57e7c169cd6a ("bpf: Add __bpf_kfunc tag for marking kernel functions as kfuncs")
> > Cc: stable@vger.kernel.org # v6.6+
> > Signed-off-by: Tony Ambardar <Tony.Ambardar@gmail.com>
> 
> Thanks for your patch, which is now commit 7bdcedd5c8fb88e7
> ("bpf: Harden __bpf_kfunc tag against linker kfunc removal") in
> v6.10-rc5.
> 
> This is causing build failures on ARM with
> CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y:
> 
>     net/core/filter.c:11859:1: error: ‘retain’ attribute ignored [-Werror=attributes]
>     11859 | {
>           | ^
>     net/core/filter.c:11872:1: error: ‘retain’ attribute ignored [-Werror=attributes]
>     11872 | {
>           | ^
>     net/core/filter.c:11885:1: error: ‘retain’ attribute ignored [-Werror=attributes]
>     11885 | {
>           | ^
>     net/core/filter.c:11906:1: error: ‘retain’ attribute ignored [-Werror=attributes]
>     11906 | {
>           | ^
>     net/core/filter.c:12092:1: error: ‘retain’ attribute ignored [-Werror=attributes]
>     12092 | {
>           | ^
>     net/core/xdp.c:713:1: error: ‘retain’ attribute ignored [-Werror=attributes]
>       713 | {
>           | ^
>     net/core/xdp.c:736:1: error: ‘retain’ attribute ignored [-Werror=attributes]
>       736 | {
>           | ^
>     net/core/xdp.c:769:1: error: ‘retain’ attribute ignored [-Werror=attributes]
>       769 | {
>           | ^
>     [...]
> 
> My compiler is arm-linux-gnueabihf-gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04).

hum, so it'd mean __has_attribute(__retain__) returns true while gcc still
ignores the retain attribute.. like in this bug which seems similar:
  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99587
but not sure how it got fixed.. any chance you can upgrade gcc and retest?

jirka

> 
> > --- a/include/linux/btf.h
> > +++ b/include/linux/btf.h
> > @@ -82,7 +82,7 @@
> >  * as to avoid issues such as the compiler inlining or eliding either a static
> >  * kfunc, or a global kfunc in an LTO build.
> >  */
> > -#define __bpf_kfunc __used noinline
> > +#define __bpf_kfunc __used __retain noinline
> > 
> > #define __bpf_kfunc_start_defs()					       \
> > 	__diag_push();							       \
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds


