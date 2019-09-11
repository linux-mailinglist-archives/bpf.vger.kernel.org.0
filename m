Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF57AFC36
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2019 14:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfIKMJG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 11 Sep 2019 08:09:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53088 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727601AbfIKMJF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Sep 2019 08:09:05 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7EDBF2A09B0
        for <bpf@vger.kernel.org>; Wed, 11 Sep 2019 12:09:05 +0000 (UTC)
Received: by mail-ed1-f69.google.com with SMTP id h23so12119600edv.4
        for <bpf@vger.kernel.org>; Wed, 11 Sep 2019 05:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=wiKMwbrFTWMlvoFQ+WcXmY6U5v89DRZRbjwpcrU0/0g=;
        b=QDg8gx+o86d1UA9E4HTGYPeQzDSf9446O9oNCbfIosCxkDPjRnOINd9sZIAaHyDZBr
         tcEwY2tKc58ElY95dLq1RV8EbjVcjJr3OvsdGfC3H2X9SA9qM7FMIlJrdUwIxFmM4TmD
         fGd0YkZ8Vr7zy+9E7ixTWfI90R+0xXET+Vw59bbymJzq+DOvC2mzdmRFCfxxSg+9+nqx
         iAA/gZKci9pJdOZxBWQxiRvjccQYYh6/5lE9jD8QQpl4jIyJfvJodaxMyGhTg5d3GXRD
         uqlNcuyTQbjHactyhwbMu9PhTWVI1NkATbs/SxkghuCrWk8vsL8L2x/5gWOp8azCry7V
         ohhA==
X-Gm-Message-State: APjAAAUzHI5eGo4Hs0zT3GNnBnyKQBRu/OVmu4bUSs+8hYHlcIIs59Oo
        DHmrwwnd8TdU79qtTe4eAShfpNOdHgGecry6Mgi1d+27IyOMzPZPDoc933evFfGWzPssGZHx8cA
        8g77cjPqG7kj6
X-Received: by 2002:a50:baab:: with SMTP id x40mr10586827ede.60.1568203744070;
        Wed, 11 Sep 2019 05:09:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzBwHHyUEXDcXl266h1mS0CBQ840+QtMXzXaW5MgM+DIbavLEYSLwUZNv6e85xX5gKfbNSrNw==
X-Received: by 2002:a50:baab:: with SMTP id x40mr10586809ede.60.1568203743936;
        Wed, 11 Sep 2019 05:09:03 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id o4sm4097666edq.84.2019.09.11.05.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 05:09:03 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0D6111804C6; Wed, 11 Sep 2019 13:09:02 +0100 (WEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Yonghong Song <yhs@fb.com>,
        Sami Tolvanen <samitolvanen@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf\@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH] bpf: validate bpf_func when BPF_JIT is enabled
In-Reply-To: <fd8b6f04-3902-12e9-eab1-fa85b7e44dd5@intel.com>
References: <20190909223236.157099-1-samitolvanen@google.com> <4f4136f5-db54-f541-2843-ccb35be25ab4@fb.com> <20190910172253.GA164966@google.com> <c7c7668e-6336-0367-42b3-2f6026c466dd@fb.com> <fd8b6f04-3902-12e9-eab1-fa85b7e44dd5@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 11 Sep 2019 13:09:01 +0100
Message-ID: <87impzt4pu.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Björn Töpel <bjorn.topel@intel.com> writes:

> On 2019-09-11 09:42, Yonghong Song wrote:
>> I am not an expert in XDP testing. Toke, Björn, could you give some
>> suggestions what to test for XDP performance here?
>
> I ran the "xdp_rxq_info" sample with and without Sami's patch:

Thanks for doing this!

> $ sudo ./xdp_rxq_info --dev enp134s0f0 --action XDP_DROP
>
> Before:
>
> Running XDP on dev:enp134s0f0 (ifindex:6) action:XDP_DROP options:no_touch
> XDP stats       CPU     pps         issue-pps
> XDP-RX CPU      20      23923874    0
> XDP-RX CPU      total   23923874
>
> RXQ stats       RXQ:CPU pps         issue-pps
> rx_queue_index   20:20  23923878    0
> rx_queue_index   20:sum 23923878
>
> After Sami's patch:
>
> Running XDP on dev:enp134s0f0 (ifindex:6) action:XDP_DROP options:no_touch
> XDP stats       CPU     pps         issue-pps
> XDP-RX CPU      20      22998700    0
> XDP-RX CPU      total   22998700
>
> RXQ stats       RXQ:CPU pps         issue-pps
> rx_queue_index   20:20  22998705    0
> rx_queue_index   20:sum 22998705
>
>
> So, roughly ~4% for this somewhat naive scenario.

Or (1/22998700 - 1/23923874) * 10**9 == 1.7 nanoseconds of overhead.

I guess that is not *too* bad; but it's still chipping away at
performance; anything we could do to lower the overhead?

-Toke
