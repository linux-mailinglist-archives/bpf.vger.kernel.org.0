Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD1D3181F65
	for <lists+bpf@lfdr.de>; Wed, 11 Mar 2020 18:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbgCKR0z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Mar 2020 13:26:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46257 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730386AbgCKR0z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Mar 2020 13:26:55 -0400
Received: by mail-pg1-f195.google.com with SMTP id y30so1549692pga.13
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2020 10:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6DKjGI4X4OQ6qCX1w/gYFecM6PgqTtpRMuTNL+Kji+w=;
        b=K1ekukOe9CJewW08HwO+84B/ZOFHNak07HRIKDpnQ4asstPnsNUw432tBiYGqmOrQX
         QGOfYSObO/M/NGUPPCKxMwBf+dfPbjZpXnM0mMYRB7yQDo2Gzeo2aOYlgOgduDBebTDC
         +dH1arrub3omMk9fLNqX1neBpSkST0Admla8ntpzRIFUkkZn9o6izeQFTvg1VkyajmY3
         rr+s1fiq9X/4zHTfu4swcodkK5Cquo9nCD+Th72JBiWOE5/CvO7AyNPPYKsJ+YfTeYZe
         sqgOi4YSUzEyhtnN48Bma5vNppa9782F8y3Ke3Oe/2EdBMX/dfLxnxEcnG5Wm4SXFzU/
         Z3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6DKjGI4X4OQ6qCX1w/gYFecM6PgqTtpRMuTNL+Kji+w=;
        b=O2qs57Ookj0FdFSJM1c37YlAVaQyXo736C7gBiQfQJ1Y7kt4M7wplXmtR7ogfM9Boo
         8mg08KU6JfeipoAectTBL9nN3jTHOsVtDP6EN63priNEpaCvQaLMAXpk4ym/7t3zdXBp
         MiHi2zskTj9jlsvHKF5vhPepl2XzFPAFY/F8omYpW7gDGFFEBJmuURcmm7dDkcsy91g6
         hxk1abhmWLoWSraDzA8uEbIrnhys/4u3rb4eqx45JHoP9PysC1J7dAxpGmHmmwyEP2Hm
         MX+vzTPW019ejcZOergjrRK9LdlteXULB2Na0quKF/o/qzCyrBC3aFPexeKxi/yOGgFN
         tNCw==
X-Gm-Message-State: ANhLgQ1Y/4qTQDkY0CkuorakIk3Rp/aiSDzpxrrRDhc/ZKuykeV6+YoL
        +rv0XMYBb4HlttjHgPaYtEg=
X-Google-Smtp-Source: ADFU+vtwBH264i9OomcgZFPJtn+9xB5fy7wM72uoHS79vK5dQgt//6MMdaDFCWymyxziLLJ9sY+i1A==
X-Received: by 2002:aa7:93cd:: with SMTP id y13mr3850317pff.213.1583947613562;
        Wed, 11 Mar 2020 10:26:53 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:500::4:c1c5])
        by smtp.gmail.com with ESMTPSA id q12sm51813359pfh.158.2020.03.11.10.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 10:26:52 -0700 (PDT)
Date:   Wed, 11 Mar 2020 10:26:50 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] bpftool: fix profiler build on systems
 without /usr/include/asm symlink
Message-ID: <20200311172650.r3gfkqbyftc32iax@ast-mbp.dhcp.thefacebook.com>
References: <20200311123421.3634-1-tklauser@distanz.ch>
 <20200311161459.6310-1-tklauser@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311161459.6310-1-tklauser@distanz.ch>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 11, 2020 at 05:14:59PM +0100, Tobias Klauser wrote:
> When compiling bpftool on a system where the /usr/include/asm symlink
> doesn't exist (e.g. on an Ubuntu system without gcc-multilib installed),
> the build fails with:
> 
>     CLANG    skeleton/profiler.bpf.o
>   In file included from skeleton/profiler.bpf.c:4:
>   In file included from /usr/include/linux/bpf.h:11:
>   /usr/include/linux/types.h:5:10: fatal error: 'asm/types.h' file not found
>   #include <asm/types.h>
>            ^~~~~~~~~~~~~
>   1 error generated.

I think the issue is different.
profiler.bpf.c should have picked up
tools/include/uapi/linux/bpf.h (instead of global from /usr/inclde)
which should have included
tools/include/linux/types.h (instead of /usr/include/linux/types.h)

we also have a workaround for some cases:
./tools/testing/selftests/bpf/include/uapi/linux/types.h

>   make: *** [Makefile:123: skeleton/profiler.bpf.o] Error 1
> 
> In certain cases (e.g. for container builds), installing gcc-multilib
> and all its dependencies - which are otherwise not needed to build
> bpftool - unnecessarily increases the image size.
> 
> Thus, fix this by adding /usr/include/$(uname -m)-linux-gnu to the
> clang search path so <asm/types.h> can be found.

In general perf builds fine on all sorts of distros and configs.
I think bpftool should use the same includes from tools/
and skeleton too.
