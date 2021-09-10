Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21767406A9F
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 13:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbhIJLSD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 07:18:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21220 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232662AbhIJLSD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Sep 2021 07:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631272611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KhW6lv8OKl3JGjPb0UK3/lNvMXBnjiEjWe2PmfSiYnI=;
        b=IBABTqVmARxw7YVL1JZmkX37iI/HEXiGvnDEP7eSwOwK5GI0RGa3ZSgBA/tXhRrRsdilwU
        XZh4CwFCFoLYWc+LyxmnCL8U//25m4jy7Cjd3s7cSDshkna3bTfNk31iN6KikrLIuHpr+S
        i/uHCN7asr3405rVZk7o0rIh2K9Csx0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-qEw8aawjPvqHc7Mk4etdQQ-1; Fri, 10 Sep 2021 07:16:50 -0400
X-MC-Unique: qEw8aawjPvqHc7Mk4etdQQ-1
Received: by mail-lj1-f197.google.com with SMTP id v2-20020a2e2f02000000b001dc7ee2a7b8so719510ljv.20
        for <bpf@vger.kernel.org>; Fri, 10 Sep 2021 04:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:cc:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KhW6lv8OKl3JGjPb0UK3/lNvMXBnjiEjWe2PmfSiYnI=;
        b=NHySY/fruvqmVbqWjZwVg0jcMtMigzoBT4VaQbC3lzwLHgwxceMmdvBFkxKusHQynt
         4sqmYuEgY7C0MJ7VZkh1GxH5noafRSDzKcfVNZvEY6gO2vnTpwLQW+FDFst/sRiA6ZNx
         n32qeFdU2e42P/5/2VF+/APL+fnDRzN/3Hvt+5hR+S6P6PtDzg8DD+Zxpa+6n/H9LseO
         Li+AI5HOng+otSboHRvOkTJtJtc4NNd1Y3ZyIjYEf+SMO+zsbDydlTdbGmxgjjEMDitN
         EtlHwZLFUd8Ardi8eBpdy+SgfUYsbdn9epRXaFPm7Kc6tr0gP9CdC/JGLteQC3bsBQ9z
         eoYw==
X-Gm-Message-State: AOAM533GC7a3OTwbFJyUh59k4qJpocxgi5kvSrrbXWQwJivCFqdEOOG1
        h6absOqELNkByB+vtUTPUFqkM7QsgdXinjDfNYHKL7OqmnIpptzWKXlhluX91XYsSA8m68dv477
        bZH90S39ED9pL
X-Received: by 2002:a05:6512:2249:: with SMTP id i9mr3432145lfu.219.1631272609201;
        Fri, 10 Sep 2021 04:16:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzH59BTrtM3dOTuC2ud0FCBAi8NLgaYur2PMsOqbkfm5Sp/MKqxhOdAgBgLurc1d1SzcgHpYQ==
X-Received: by 2002:a05:6512:2249:: with SMTP id i9mr3432122lfu.219.1631272608969;
        Fri, 10 Sep 2021 04:16:48 -0700 (PDT)
Received: from [192.168.42.238] (87-59-106-155-cable.dk.customer.tdc.net. [87.59.106.155])
        by smtp.gmail.com with ESMTPSA id m28sm534168ljc.46.2021.09.10.04.16.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 04:16:48 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     brouer@redhat.com,
        Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        BPF-dev-list <bpf@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        William Tu <u9012063@gmail.com>, xdp-hints@xdp-project.net,
        Zaremba Larysa <larysa.zaremba@intel.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: XDP-hints: Howto support multiple BTF types per packet basis?
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
References: <60b6cf5b6505e_38d6d208d8@john-XPS-13-9370.notmuch>
 <20210602091837.65ec197a@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <YNGU4GhL8fZ0ErzS@localhost.localdomain> <874kdqqfnm.fsf@toke.dk>
 <YNLxtsasQSv+YR1w@localhost.localdomain> <87mtrfmoyh.fsf@toke.dk>
 <YOa4JVEp20JolOp4@localhost.localdomain> <8735snvjp7.fsf@toke.dk>
 <YTA7x6BIq85UWrYZ@localhost.localdomain>
 <190d8d21-f11d-bb83-58aa-08e86e0006d9@redhat.com>
 <YTcGUbRpvWK+633g@localhost.localdomain>
 <936bfbdf-e194-b676-d28a-acf526120155@redhat.com>
 <CAEf4BzabVVPgRB9V=DAFjzYSx-q59bmBsQQAupKYWy5eUxqVkw@mail.gmail.com>
Message-ID: <2ed2a06c-6796-229d-05d4-9a6464330e9e@redhat.com>
Date:   Fri, 10 Sep 2021 13:16:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzabVVPgRB9V=DAFjzYSx-q59bmBsQQAupKYWy5eUxqVkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 09/09/2021 20.19, Andrii Nakryiko wrote:
> Depending on what IDs we are talking about (sorry, I don't follow this
> thread very closely, so if you are curious about some aspects of BTF
> or libbpf APIs, it would be good to have a specific questions with
> some context). BTF as kernel object has it's own ID allocated through
> idr, so yes, they are unique. so vmlinux BTF object will have it's own
> ID, while each module's BTF will have it's own.
> 
> But if we are talking about BTF type IDs, that's entirely different
> thing. BTF type IDs start from 1 (0 is reserved for special 'VOID'
> type) all the way to number of types in vmlinux BTF. Then each module
> extends vmlinx BTF starting at N + 1 and going to N + M, where N is
> number of BTF types in vmlinux BTF and M is number of added types in
> module BTF.
> 
> So in that regard each module has BTF type IDs that are overlapping
> with other modules, which is why for unique fetching of BTF types from
> modules you also need BTF object FD or ID of a module BTF, and then
> BTF type ID within that module. But as I said, I didn't follow along
> closely, so not sure if I'm answering the right question, sorry.

Thanks for answering.  This N vmlinux IDs + M module IDs was important 
to know, thanks for correcting my understanding on this, as this does 
affect our ideas for using BTF for XDP-hints.

This "just" means that the BTF ID will be per driver.  I think we can 
still make this work, as the AF_XDP userspace program will already need 
to bind to a device.  Thus, we can still send a simple btf_id in 
metadata, and AF_XDP prog will just have device-map with expected 
btf_id's from this device (to validate if it knows howto decode contents).
It is slightly more annoying for my xdp_frame + cpumap use-case, as it 
can get XDP_REDIRECT'ed frames from many net_devices, but we do have 
xdp_frame->dev_rx (net_device) avail, so I can resolve this.

--Jesper

Finding some random BTF ID in two module and notice they point to 
different types.

  # bpftool btf dump file /sys/kernel/btf/ixgbe | grep 95905
  [95905] FUNC 'ixgbe_set_rx_mode' type_id=95829 linkage=static

  # bpftool btf dump file /sys/kernel/btf/igc | grep 95905
  [95905] FUNC 'igc_ethtool_get_link_ksettings' type_id=95904 linkage=static


