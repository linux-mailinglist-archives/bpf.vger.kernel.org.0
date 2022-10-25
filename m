Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC9E60D824
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 01:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbiJYXqf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 19:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbiJYXqe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 19:46:34 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C16B7F6D
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 16:46:33 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s196so13156528pgs.3
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 16:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d69+TyqEWwV6d/vSmFpBq5VvanBtBPKevtfakGv5lQw=;
        b=HKg0MAMae/sQHSAEBxVo+qHC8yrl3df+p7YO9ClVR5lv6wIfjb5TjRZNs/pGIxDllv
         rn0EX2Da8aZQXC5g80aaOHVUNPVwtqroy/GN0V//RS8Yj6VLomGJZyGxTB9ODB5BAX5x
         S+eHN6u9emTDaE+pRTKX26WMxwO/YTxVk0S19gVTr6WYKprTOlagWa7DC7m72rjwuKSW
         WW+91j4TJqAPg6DckUPIVFYr724CiAgSadIYTaDES/Dqevjjmlc2JeY9NNU0sdWI1GSP
         FJ2zyyf93lt+AE9m412vN4Bfu1rYP680plPi1NHz8MvODYPRrhuR7pPDaQOfs/YJaAtx
         h1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d69+TyqEWwV6d/vSmFpBq5VvanBtBPKevtfakGv5lQw=;
        b=YEjSrxWCW+cB6ZHQW+xNd236ft47/x9FPgDYkIGHhRUxOPZJiljeo1iVq0+jVrYfjZ
         v7xDfVhsbLnGRTOHvS1WDeE+EBOSm8n1pn9LqiV157zmxjizX8XtZv/7BEwcsnzr0EU5
         ZdWa7VHCQZy33ieHI8He6dSYPxfNM8cXMfB385zWvXTWAfpCtwPXAe+mL6Q38LdLgxrO
         FkSXvTkbtwv0sPHEkb6Xlg0itY1C9SA0Utdm5tHnemAhtu5RmTAfdx4+0nSzDRwxS5tu
         as5xhYdDaxQJPoBb3ztQwJ5320sIJpiP8yAN0nM7WPOoxcAyZRR6QR3BQ+dMJdeogiYm
         XjCw==
X-Gm-Message-State: ACrzQf1w8IUXerTUKe8Aphg9NkmGn5U0F7ArroWCo3NUGhuXRSUpLPas
        ZnNnP2ueJ2antlD4TVnInJPQYHht8F8=
X-Google-Smtp-Source: AMsMyM5nsSeb0indFTyz4yR8/Kb7Ews4vKVJi4h2MGUV36do6ikXL2ljCgUSbh1KxEFM5yF+k50NrA==
X-Received: by 2002:a63:211a:0:b0:451:f444:3b55 with SMTP id h26-20020a63211a000000b00451f4443b55mr33826720pgh.60.1666741592829;
        Tue, 25 Oct 2022 16:46:32 -0700 (PDT)
Received: from macbook-pro-4.dhcp.thefacebook.com ([2620:10d:c090:500::5:9233])
        by smtp.gmail.com with ESMTPSA id w2-20020a63c102000000b0045ccc30e469sm1781935pgf.25.2022.10.25.16.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 16:46:32 -0700 (PDT)
Date:   Tue, 25 Oct 2022 16:46:29 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        arnaldo.melo@gmail.com
Subject: Re: [RFC bpf-next 00/12] Use uapi kernel headers with vmlinux.h
Message-ID: <20221025234629.xsjnhobxl2ky35i5@macbook-pro-4.dhcp.thefacebook.com>
References: <20221025222802.2295103-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025222802.2295103-1-eddyz87@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 26, 2022 at 01:27:49AM +0300, Eduard Zingerman wrote:
> 
> Include the following system header:
> - /usr/include/sys/socket.h (all via linux/if.h)
> 
> The sys/socket.h conflicts with vmlinux.h in:
> - types: struct iovec, struct sockaddr, struct msghdr, ...
> - constants: SOCK_STREAM, SOCK_DGRAM, ...
> 
> However, only two types are actually used:
> - struct sockaddr
> - struct sockaddr_storage (used only in linux/mptcp.h)
> 
> In 'vmlinux.h' this type originates from 'kernel/include/socket.h'
> (non UAPI header), thus does not have a header guard.
> 
> The only workaround that I see is to:
> - define a stub sys/socket.h as follows:
> 
>     #ifndef __BPF_SOCKADDR__
>     #define __BPF_SOCKADDR__
>     
>     /* For __kernel_sa_family_t */
>     #include <linux/socket.h>
>     
>     struct sockaddr {
>         __kernel_sa_family_t sa_family;
>         char sa_data[14];
>     };
>     
>     #endif
> 
> - hardcode generation of __BPF_SOCKADDR__ bracket for
>   'struct sockaddr' in vmlinux.h.

we don't need to hack sys/socket.h and can hardcode
#ifdef _SYS_SOCKET_H as header guard for sockaddr instead, right?
bits/socket.h has this:
#ifndef _SYS_SOCKET_H
# error "Never include <bits/socket.h> directly; use <sys/socket.h> instead."

So that ifdef is kinda stable.

> Another possibility is to move the definition of 'struct sockaddr'
> from 'kernel/include/socket.h' to 'kernel/include/uapi/linux/socket.h',
> but I expect that this won't fly with the mainline as it might break
> the programs that include both 'linux/socket.h' and 'sys/socket.h'.
> 
> Conflict with vmlinux.h
> ----
> 
> Uapi header:
> - linux/signal.h
> 
> Conflict with vmlinux.h in definition of 'struct sigaction'.
> Defined in:
> - vmlinux.h: kernel/include/linux/signal_types.h
> - uapi:      kernel/arch/x86/include/asm/signal.h
> 
> Uapi headers:
> - linux/tipc_sockets_diag.h
> - linux/sock_diag.h
> 
> Conflict with vmlinux.h in definition of 'SOCK_DESTROY'.

Interesting one!
I think we can hard code '#undef SOCK_DESTROY' in vmlinux.h

The goal is not to be able to mix arbitrary uapi header with
vmlinux.h, but only those that could be useful out of bpf progs.
Currently it's tcp.h and few other network related headers
because they have #define-s in them that are useful inside bpf progs.
As long as the solution covers this small subset we're fine.
