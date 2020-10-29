Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78FFE29E21D
	for <lists+bpf@lfdr.de>; Thu, 29 Oct 2020 03:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbgJ2CHj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Oct 2020 22:07:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44558 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727080AbgJ2CGz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 28 Oct 2020 22:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603937213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WiKrctRMP15lV20zK+4gtceZ71rNHyxvbqtsGTAZ6gU=;
        b=A73ToxLGVVHVegkkIuT5sekcpd+WiV60sjSKiR+FgTz/coAytvggXbtHfQQsJr/VEWQsfF
        /M7o62jcJz+Ex448CpaiIfJ/a7LpuMmAWAAdwdQJQ465EWS5rhIOASrp8OZMgg1flZbM02
        Huf/skqCuXKLt9JDjhgJRM0HoBV/mPA=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-w5q9WJbzO8OJI9dCKyob2Q-1; Wed, 28 Oct 2020 22:06:52 -0400
X-MC-Unique: w5q9WJbzO8OJI9dCKyob2Q-1
Received: by mail-pl1-f199.google.com with SMTP id q4so897633plr.11
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2020 19:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WiKrctRMP15lV20zK+4gtceZ71rNHyxvbqtsGTAZ6gU=;
        b=AoeywnVbT/M08ILU8vudhtbHhLWUkEnVow7Fex9OtLudXpwnjsFQ+rRn3ik74AE9hc
         5RETY72VfChnHGsieSAd0Mx+MBcgwKt7T1o6HTk77U1giUbYHRPItcluUBvaeWJVOGwu
         8bYAQwugt5J8n5V15a1eWnvE7X2jpc4HqzOvjtYFw1zln8/pkMQ20NMdFWB/JbfqfJ2f
         quw19LKpEJbwsxEy46DMoqXdIFwjV2UJFHbgtNilFTKNHktcVlUkOXk5jw+3ZdJ+3PEw
         MsX9zPqfhw1KRJ/7VG7tzRc5/Ob21AzdHsj2bKsSv5X5gISJmrmjo8ZvkyFrN1S3RoMp
         9k1Q==
X-Gm-Message-State: AOAM532boGhvnYbTlMYrk8jguiRwWEkWIuQ+5Bf4VJUo6aDFLJCc+Nsn
        v5n0RxkoupBDxR0gxtI1NQLN5q9/EBR9uZy7RUbU8zgrn1ogCr9TZfDnBoDDysV04OmpfbQeuIv
        i/wGVzOEVfKo=
X-Received: by 2002:a17:90a:d516:: with SMTP id t22mr1263713pju.118.1603937211118;
        Wed, 28 Oct 2020 19:06:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyMRb2uQE7ATVHZNR6LzlXGvxdkLkaB3eSdORGRWQ2lWVIA+j+MoIlCdPWs7FZrZGb6PJqag==
X-Received: by 2002:a17:90a:d516:: with SMTP id t22mr1263683pju.118.1603937210851;
        Wed, 28 Oct 2020 19:06:50 -0700 (PDT)
Received: from dhcp-12-153.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id ne17sm679818pjb.44.2020.10.28.19.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 19:06:49 -0700 (PDT)
Date:   Thu, 29 Oct 2020 10:06:37 +0800
From:   Hangbin Liu <haliu@redhat.com>
To:     David Ahern <dsahern@gmail.com>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: Re: [PATCHv2 iproute2-next 0/5] iproute2: add libbpf support
Message-ID: <20201029020637.GM2408@dhcp-12-153.nay.redhat.com>
References: <20201023033855.3894509-1-haliu@redhat.com>
 <20201028132529.3763875-1-haliu@redhat.com>
 <7babcccb-2b31-f9bf-16ea-6312e449b928@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7babcccb-2b31-f9bf-16ea-6312e449b928@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 28, 2020 at 05:02:34PM -0600, David Ahern wrote:
> fails to compile on Ubuntu 20.10:
> 
> root@u2010-sfo3:~/iproute2.git# ./configure
> TC schedulers
>  ATM	yes
>  IPT	using xtables
>  IPSET  yes
> 
> iptables modules directory: /usr/lib/x86_64-linux-gnu/xtables
> libc has setns: yes
> SELinux support: yes
> libbpf support: yes
> ELF support: yes
> libmnl support: yes
> Berkeley DB: no
> need for strlcpy: yes
> libcap support: yes
> 
> root@u2010-sfo3:~/iproute2.git# make clean
> 
> root@u2010-sfo3:~/iproute2.git# make -j 4
> ...
> /usr/bin/ld: ../lib/libutil.a(bpf_libbpf.o): in function `load_bpf_object':
> bpf_libbpf.c:(.text+0x3cb): undefined reference to
> `bpf_program__section_name'
> /usr/bin/ld: bpf_libbpf.c:(.text+0x438): undefined reference to
> `bpf_program__section_name'
> /usr/bin/ld: bpf_libbpf.c:(.text+0x716): undefined reference to
> `bpf_program__section_name'
> collect2: error: ld returned 1 exit status
> make[1]: *** [Makefile:27: ip] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:64: all] Error 2

You need to update libbpf to latest version.

But this also remind me that I need to add bpf_program__section_name() to
configure checking. I will see if I missed other functions' checking.

Thanks
Hangbin

