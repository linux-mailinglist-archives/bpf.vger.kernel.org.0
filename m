Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41E3429C33
	for <lists+bpf@lfdr.de>; Tue, 12 Oct 2021 06:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbhJLERa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Oct 2021 00:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhJLER3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Oct 2021 00:17:29 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A948C061570
        for <bpf@vger.kernel.org>; Mon, 11 Oct 2021 21:15:28 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k23-20020a17090a591700b001976d2db364so1551522pji.2
        for <bpf@vger.kernel.org>; Mon, 11 Oct 2021 21:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oblNZxxjz2n3XYhiqm9+qJ7yfSIxEkt4DwvylmYsmaM=;
        b=olOC0QaKMRgTPr7e7zgKy10Kx3UbL5x5d3SY73iXiqbPKURf0Ao9NTKcM5nt0OlHEO
         YOlcVo672jdtUf9JHRQHu/x/Ysc5SS50o14fuZXCj+IJMJlaWuR9w5Yc18D5/sITqnp3
         RdTHh0d4wVMA2WwFegJf8gd/b8SYn9qjZKCrX0UyOQNFynjpCN4n3vABpv0z32Fpzepa
         63P8uBmgganxa/tRQqrUht0CW9+owuyDDRexeEEeLUNXPbhXl6jpOnfltFGitZJJ18wB
         DoWCX7IWIL3AoqKMl1WwWeHshqX7Lswbiyb+d7ADTvW3hBs2TdRxCDmF64od5Hfy2mdj
         /X8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oblNZxxjz2n3XYhiqm9+qJ7yfSIxEkt4DwvylmYsmaM=;
        b=HwyiHuIcens81dLuM1M0euQnLVNYABvkusVLuIBmJhOy5gNHHmVpfqG81rHM6+dcPg
         +OyrB+pS2OGS08e31idHrLrCxrX3Z/iTU4waHEJvDmAVRPrViJOwLR71R/mauPW2m1wg
         0X7b3pfQBjQzS5MjNrDMwdmwO02R0xQUEHRqrnvRcCj6XotYFLkEZTmw7Jn9+SBea2Bz
         lqrIQBcm+EvAuHunpC66gc/h9Sr67V1SIjxXxfb2xuRx+9BKq3oG8IenIKzAC6BahvG3
         n1vgKUlwHLl8eaNw+8yzPqosA+zuaPGS4wuWETtI3+yh/A/J1AVm7dtv+2R78aAfc1V4
         AEOQ==
X-Gm-Message-State: AOAM531XRTMXVjfovFQTZJPZfhS3TzmFbbBBPTlU4E69psrAwYulVKbu
        TCYzbmHWfAXTaFbFiGx8C2k=
X-Google-Smtp-Source: ABdhPJxU96xq8TDOn/+3rtKwKeBAxEX87kk9/l+ve+3kiLFFq1QToE4D5CWkHl/xjQwUcEXze8JPvA==
X-Received: by 2002:a17:90a:db51:: with SMTP id u17mr3387686pjx.171.1634012127693;
        Mon, 11 Oct 2021 21:15:27 -0700 (PDT)
Received: from localhost ([2405:201:6014:d058:a28d:3909:6ed5:29e7])
        by smtp.gmail.com with ESMTPSA id i123sm9563535pfg.157.2021.10.11.21.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 21:15:27 -0700 (PDT)
Date:   Tue, 12 Oct 2021 09:45:24 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     andrii.nakryiko@gmail.com
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 00/10] libbpf: support custom .rodata.*/.data.*
 sections
Message-ID: <20211012041524.udytbr2xs5wid6x2@apollo.localdomain>
References: <20211008000309.43274-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211008000309.43274-1-andrii@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 08, 2021 at 05:32:59AM IST, andrii.nakryiko@gmail.com wrote:
> From: Andrii Nakryiko <andrii@kernel.org>
>
> [...]
> One interesting possibility that is now open by these changes is that it's
> possible to do:
>
>     bpf_trace_printk("My fmt %s", sizeof("My fmt %s"), "blah");
>
> and it will work as expected. I haven't updated libbpf-provided helpers in
> bpf_helpers.h for snprintf, seq_printf, and printk, because using
> `static const char ___fmt[] = fmt;` trick is still efficient and doesn't fill
> out the buffer at runtime (no copying), but it also enforces that format
> string is compile-time string literal:
>
>     const char *s = NULL;
>
>     bpf_printk("hi"); /* works */
>     bpf_printk(s); /* compilation error */
>
> By passing fmt directly to bpf_trace_printk() would actually compile
> bpf_printk(s) above with no warnings and will not work at runtime, which is
> worse user experience, IMO.
>

You could try the following (_Static_assert would probably be preferable, but
IDK if libbpf can use it).

#define IS_ARRAY(x) ({ sizeof(int[-__builtin_types_compatible_p(typeof(x), typeof(&*(x)))]); 1; })

In action: https://godbolt.org/z/4d4W61YPf

--
Kartikeya
