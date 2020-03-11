Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7251818BB
	for <lists+bpf@lfdr.de>; Wed, 11 Mar 2020 13:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbgCKMuA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Mar 2020 08:50:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35369 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729232AbgCKMuA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Mar 2020 08:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583930998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n2skqypV0WbKscpH+y+Xz0GGse3P9JxjCr/Hb6FAnoY=;
        b=SEDdqhXN7q1gOeRswHK2+t++jUetKWeZW4/jRHZXvJhiKXKoio69iG0pcNjV9AuBE5EnT1
        L0qfUf7Oq+okIyeJ9MawjF51Y+iK/ieVXJoqe3Us15kZYnhWfIZpxvEYvAccotNlZm316s
        JZGU+WvFaybhBKplbFJrvgi3IYlb+Dg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-3pK9oJgQPYyaivEpIjx7BQ-1; Wed, 11 Mar 2020 08:49:57 -0400
X-MC-Unique: 3pK9oJgQPYyaivEpIjx7BQ-1
Received: by mail-wr1-f72.google.com with SMTP id 31so941714wrq.0
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2020 05:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=n2skqypV0WbKscpH+y+Xz0GGse3P9JxjCr/Hb6FAnoY=;
        b=gN9oD2TxDe0v/76dr5LwD981dr3YKJyr3tdN8+COsBsugUuHwtYqic97J4p0yBlTgG
         wd9v9XRXIxC+kHqR+kSGtVJqrFOLtBhxg7WPxcbyPRQPGQDolQhe3wkz9w2IwxCaoWSq
         DKnwFH/8qsu4MEdyRLp+N5o306ICKw56djLfCE9mhfrw+zLcoyp9lv86ZlAACnA0ZYJp
         wvzknr0Mi8Pph7G+k7Kf4zU85pt/N7GuyPDUzZobkvjEy1exYIISpdVyFLUVCi7K/exM
         NbqCFbopIXOkl41v+Co0ypNzUdCAUaLgaPXuYzXOt2An+nlaIZJtOQec8GjdFlNWfyxu
         HyrQ==
X-Gm-Message-State: ANhLgQ3ZuoMfx1i+1iwkO1DTS7A6F2jHVz3UnsWPCWIlCVaZZKcg8YSf
        gDAR55G9QdJQ3uP91XV4vJ6JmPGWb9WkyWBTIxO5kCCGz74V2sLpYGNj2VzmrjsXs6Cu6EoOqby
        OcpTeJIa3iZCP
X-Received: by 2002:adf:fe41:: with SMTP id m1mr4308438wrs.355.1583930995953;
        Wed, 11 Mar 2020 05:49:55 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt4zNfYs/ftJBAodN6dOV584zEZvHOZaR9C+G3JkTjWHlpDVHfkN+AAgzr395srYq5FOuaDtQ==
X-Received: by 2002:adf:fe41:: with SMTP id m1mr4308416wrs.355.1583930995794;
        Wed, 11 Mar 2020 05:49:55 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id z11sm8075051wmd.47.2020.03.11.05.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 05:49:54 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DD22A18033D; Wed, 11 Mar 2020 13:49:53 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Tobias Klauser <tklauser@distanz.ch>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Quentin Monnet <quentin.monnet@netronome.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org
Subject: Re: [PATCH] bpftool: fix iprofiler build on systems without /usr/include/asm symlink
In-Reply-To: <20200311123421.3634-1-tklauser@distanz.ch>
References: <20200311123421.3634-1-tklauser@distanz.ch>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 11 Mar 2020 13:49:53 +0100
Message-ID: <87tv2voy32.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Tobias Klauser <tklauser@distanz.ch> writes:

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
>   make: *** [Makefile:123: skeleton/profiler.bpf.o] Error 1
>
> To fix this, add /usr/include/$(uname -m)-linux-gnu to the clang search
> path so <asm/types.h> can be found.

Isn't the right thing here to just install gcc-multilib?

-Toke

