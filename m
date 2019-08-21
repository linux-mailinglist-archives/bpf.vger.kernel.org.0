Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92D9698530
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2019 22:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbfHUUHI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Aug 2019 16:07:08 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42403 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbfHUUHI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Aug 2019 16:07:08 -0400
Received: by mail-qt1-f196.google.com with SMTP id t12so4612151qtp.9;
        Wed, 21 Aug 2019 13:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ncn6eYm4JSkQlweNtA3S5RYrt/VpHG9HsAGzGWdObeM=;
        b=cATKvr0xSWCkFzxywIUjL6lQn9V6IunbrJZkXS/gQl+YK0zoqooppTi4ndkH/MW5g2
         kFlCNBoe6jvpzfU3jL0u3XiuF8XilYu35MqtRxfEaR9igu+1JDRG+fbAUOC/H3KZ9lOE
         +UhP6sD25uXWkBRrDaaTXaSmihyzfD4aDPa6hBxwExsVBkWTyn08gw73lP54nORkWBw+
         7x6XRzMenV+sFHT2Tuo3e6e6/j75sdpz8Y7Q3NKsnICEd4u0sKLS5cxzC39xVUanvnYy
         Y4fRdyXDbvaWN64K+P7+V0tLZKZleGLRYmSx8cJ3OSTNv6L6Xl2ApAGESnHMHC7d2yF7
         Cc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ncn6eYm4JSkQlweNtA3S5RYrt/VpHG9HsAGzGWdObeM=;
        b=JGGqx8jecws5Aw9eYYbYglzyLHTlkSGSzAPbVk/Sb9bZuGJOrzVdhtw4RKt3kbJYmQ
         hP9TvHfMiiHKv5zxSASo3ujmMx0AeZs8G0l1iSpphTfbapQ6Y3kCcRPlfFKmDfad/Mo8
         qDcZ2vzYV7TFIphb9uHVuVHlci8hhxKyKdMOY4ycj8dcRBGyPbINBZpNOzO8bJoKnJLK
         lPHGp00WhXRuBQ9rX+xLARJ305DMGeTXK9NwyB396xkC3oT1FwKUVOUieQKKfwUiTRVw
         lqz6/SJjV8ZnkYXgvF34C72SiPPmd1K+y/Xc2sxl+LLTk64eTITlFCCdZmArpQ5ducjB
         3oZg==
X-Gm-Message-State: APjAAAWzmGskZ9/R+2yXHdZ0N31dMW1drpskBFeirzC9IbqvagWHADlj
        n57adlZS+wht/hK5q+U+Rzo8EgBdJ30=
X-Google-Smtp-Source: APXvYqzFBpvKYFLywp49wq7pnQMywApD6zvVMaIqNjWR9zl6SZTds2nNI0IEyhyUbFu++TjNucYitw==
X-Received: by 2002:aed:2a86:: with SMTP id t6mr32542840qtd.391.1566418027658;
        Wed, 21 Aug 2019 13:07:07 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.195.211.175])
        by smtp.gmail.com with ESMTPSA id t13sm10559914qkm.117.2019.08.21.13.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 13:07:06 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 30FE140340; Wed, 21 Aug 2019 17:07:01 -0300 (-03)
Date:   Wed, 21 Aug 2019 17:07:01 -0300
To:     Yonghong Song <yhs@fb.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, Daniel Xu <dxu@dxuuu.xyz>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Alexei Starovoitov <ast@fb.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v3 bpf-next 1/4] tracing/probe: Add
 PERF_EVENT_IOC_QUERY_PROBE ioctl
Message-ID: <20190821200701.GI3929@kernel.org>
References: <20190820144503.GV2332@hirez.programming.kicks-ass.net>
 <BWENHQJIN885.216UOYEIWNGFU@dlxu-fedora-R90QNFJV>
 <20190821110856.GB2349@hirez.programming.kicks-ass.net>
 <62874df3-cae0-36a1-357f-b59484459e52@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62874df3-cae0-36a1-357f-b59484459e52@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Aug 21, 2019 at 04:54:47PM +0000, Yonghong Song escreveu:
> Arnaldo has a question on bcc mailing list about the hit/miss
> counting of bpf program missed to process events.
 
> https://lists.iovisor.org/g/iovisor-dev/message/1783

PERF_FORMAT_LOST seems to be a good answer to that? See my other reply
to this thread.

- Arnaldo
