Return-Path: <bpf+bounces-17403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D06180CA6F
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 14:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC1AB281C70
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 13:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3663D3BD;
	Mon, 11 Dec 2023 13:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgie8C/f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655A0D6;
	Mon, 11 Dec 2023 05:01:47 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40c38de1ee4so25150425e9.0;
        Mon, 11 Dec 2023 05:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702299706; x=1702904506; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JNQm7s7g+d3XsjrBpIIxNcsMxJriHJmGupSKhGUX004=;
        b=bgie8C/f4rYdCXEZ2VEzJvw6hR8ck/TDPMvaf5sTGzI9zQwb5r8sZhLo1rHh+th87w
         NLtdU4D1c9U+Gb2G4crLMwOAEg6XOklMwrVu7X3JA9lQb972Dp+OHDT3Rv0gkwFQXhr0
         A/nEV8vW0la38Y44Hb7Y3UqENT2HT6ZlH/x4EGjqpnGpaiiOAXERkAUulf8j3aO57S2H
         ZB1wJxCSo/gslUUqaEhwOkUBkqTBqarPnr2X8JAz5jF4m7Qn3nsZMavNwqSJc1X6dSH2
         lbWJ9UEopr+oH3OOC0S8ZBPmj8vzgGpGlIt/t6ovvyuziYFrOkuyGYthF/p/iB+kv+d6
         MVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702299706; x=1702904506;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JNQm7s7g+d3XsjrBpIIxNcsMxJriHJmGupSKhGUX004=;
        b=rtci17TF9I/yqpmhQQdTg9OLg02/3VfEoU7IbPIAkmnGB9AXl7xdK5jt6qHog5iVRg
         wOpJ2QZVACBHYay3NPHNdao+gOijHohyRoLXAkMPpBFYS7fKUhR14bpnxW9AZp4PduPY
         ys55UVD70UQ76vJ/NBKb5Rb89SS2wEwDwX4X4e9d0F/1r479WcmHlZpR7OLMwk8cvEjB
         BupidrIKlff5MN9EmOr2zJrgY/VngxlAWOA47/6iOW2ti85V006T2vnZHp6Kppyn3/He
         +xH1mY8paOdrNd9rJtXoEgMvSfwWqyNWL6HlF/6ydHtfCrLEEEeq4E8jcurBG7xbOq+a
         sITQ==
X-Gm-Message-State: AOJu0YxekNGBpVCFxQIVIVvPWF931MiJrgXiqI7tJf5Eji9DfvbVdCDx
	ss4fbJVHOPusdFlCVdvBR4E=
X-Google-Smtp-Source: AGHT+IHjKWmDs3sZutxGzBuNiu10ay7qVurMNNIwk/X7cleo8EvKj5YyFDjjZgy2yMPRiBqnyjrV+g==
X-Received: by 2002:a05:600c:20d:b0:40c:3915:be5a with SMTP id 13-20020a05600c020d00b0040c3915be5amr2511796wmi.118.1702299705590;
        Mon, 11 Dec 2023 05:01:45 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id t14-20020a5d42ce000000b003333b0d603bsm8497641wrr.42.2023.12.11.05.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 05:01:45 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 11 Dec 2023 14:01:43 +0100
To: Hou Tao <houtao@huaweicloud.com>, mhiramat@kernel.org
Cc: xingwei lee <xrivendell7@gmail.com>, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: WARNING: kmalloc bug in bpf_uprobe_multi_link_attach
Message-ID: <ZXcIN-odFOCWX8Ox@krava>
References: <CABOYnLwwJY=yFAGie59LFsUsBAgHfroVqbzZ5edAXbFE3YiNVA@mail.gmail.com>
 <689db41e-90f5-c5ba-b690-00586f22d616@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <689db41e-90f5-c5ba-b690-00586f22d616@huaweicloud.com>

On Mon, Dec 11, 2023 at 07:29:40PM +0800, Hou Tao wrote:

SNIP

> 
> It seems a big attr->link_create.uprobe_multi.cnt is passed to
> bpf_uprobe_multi_link_attach(). Could you please try the first patch in
> the following patch set ?
> 
> https://lore.kernel.org/bpf/20231211112843.4147157-1-houtao@huaweicloud.com/T/#t
> > [   68.389633][ T8223]  ? __might_fault+0x13f/0x1a0
> > [   68.390129][ T8223]  ? bpf_kprobe_multi_link_attach+0x10/0x10
> 
> SNIP
> >   res = syscall(__NR_bpf, /*cmd=*/5ul, /*arg=*/0x20000140ul, /*size=*/0x90ul);
> >   if (res != -1) r[0] = res;
> >   memcpy((void*)0x20000000, "./file0\000", 8);
> >   syscall(__NR_creat, /*file=*/0x20000000ul, /*mode=*/0ul);
> >   *(uint32_t*)0x20000340 = r[0];
> >   *(uint32_t*)0x20000344 = 0;
> >   *(uint32_t*)0x20000348 = 0x30;
> >   *(uint32_t*)0x2000034c = 0;
> >   *(uint64_t*)0x20000350 = 0x20000080;
> >   memcpy((void*)0x20000080, "./file0\000", 8);
> 
> 0x20000350 is the address of attr->link_create.uprobe_multi.path.
> >   *(uint64_t*)0x20000358 = 0x200000c0;
> >   *(uint64_t*)0x200000c0 = 0;
> >   *(uint64_t*)0x20000360 = 0;
> >   *(uint64_t*)0x20000368 = 0;
> >   *(uint32_t*)0x20000370 = 0xffffff1f;
> 
> The value of attr->link_create.uprobe_multi.cnt is 0xffffff1f, so 
> 0xffffff1f * sizeof(bpf_uprobe) will be greater than INT_MAX, and
> triggers the warning in mm/util.c:
> 
>         /* Don't even allow crazy sizes */
>         if (unlikely(size > INT_MAX)) {
>                 WARN_ON_ONCE(!(flags & __GFP_NOWARN));
>                 return NULL;
>         }
> 
> Adding __GFP_NOWARN when doing kvcalloc() can fix the warning.

hi,
looks like that's the case.. thanks for fixing that

btw while checking on that I found kprobe_multi bench attach test
takes forever on latest bpf-next/master

	test_kprobe_multi_bench_attach:PASS:bpf_program__attach_kprobe_multi_opts 0 nsec
	test_kprobe_multi_bench_attach: found 56140 functions
	test_kprobe_multi_bench_attach: attached in  89.174s
	test_kprobe_multi_bench_attach: detached in  13.245s
	#113/1   kprobe_multi_bench_attach/kernel:OK

Masami,
any idea of any change on fprobe/ftrace side recently? I'm going to check ;-)

thanks,
jirka

