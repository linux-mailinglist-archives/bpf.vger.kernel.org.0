Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77BF540D410
	for <lists+bpf@lfdr.de>; Thu, 16 Sep 2021 09:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbhIPHup (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Sep 2021 03:50:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54469 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229908AbhIPHug (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Sep 2021 03:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631778555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UWyWiu8lmLKSnwT/n684r2szfzzyT+xXhGueBd2kHG8=;
        b=L1p0EBFgwlfL3BFW4G+BEz8esi4JIjKSdjgrA8lqSXaazbks8Ec8yGQFChKk0S4EICNOvV
        vVTgDEkJEwYwA/7xUtIyQHt5Cd/KeAHMHLdktI1ZpcMjHZGxBF8jNDiV8BwOKqQeIdvmKO
        fFZOs9WVsYGPR8HHw81XY0EAdhtLs7k=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-j4PoB_4SMoyy34yAhHAcUA-1; Thu, 16 Sep 2021 03:49:14 -0400
X-MC-Unique: j4PoB_4SMoyy34yAhHAcUA-1
Received: by mail-lf1-f71.google.com with SMTP id a28-20020a056512021c00b003f5883dcd4bso3149705lfo.1
        for <bpf@vger.kernel.org>; Thu, 16 Sep 2021 00:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:cc:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UWyWiu8lmLKSnwT/n684r2szfzzyT+xXhGueBd2kHG8=;
        b=Wg79XYCexBrjAook9bYovui5AQjLdlt6GTy105ACRunfCe6c8v+3a3IuGwKNDvzAU8
         sE0hldBdqub9PunT8mDGcw5+F4TIR6eEVn6lvxpLerdeIls8xS+S9yoQBZ385g5gMU+8
         Q8YGuGGRvxgOdYWd/HUxABQ6HKZvWHQ5grykCeg44xcahVo1HajVecvQB29DyrOM0yW7
         mSmwbywOCv69jvx7pACYMoZfc/UxkwZCL0KqT2ZvZW5FZOY/GvJ7icSlQ4SkbZ28s0HQ
         a4VSRQxINktU091zZ7kFkuf93Zw5mnI9HlNfn6mXWxVG3K8lRpnh9y3r+ZLSuH63ft6D
         +s4A==
X-Gm-Message-State: AOAM533+nR5f0QY/8LA0DpmqQCgp20kdBlKKWqLbvyex3KXkArdnxrBW
        kkgCpR4bRy2ns88GOeJRg/jR9vm/sENgsUPdPF35LgXx98wpeiY43V/J29sNwZ0rfkfzd3CE4YS
        pq0gJUB061jXb
X-Received: by 2002:a2e:81c3:: with SMTP id s3mr3905654ljg.181.1631778552971;
        Thu, 16 Sep 2021 00:49:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDeXtKHmd9q3QVtiFXQb9vFArgWBjssBwLZCdGeI3Fk+2GVhuxaxjEVzS7LvgE8/e5kwGs6w==
X-Received: by 2002:a2e:81c3:: with SMTP id s3mr3905632ljg.181.1631778552733;
        Thu, 16 Sep 2021 00:49:12 -0700 (PDT)
Received: from [192.168.42.238] (87-59-106-155-cable.dk.customer.tdc.net. [87.59.106.155])
        by smtp.gmail.com with ESMTPSA id l2sm190193lfe.1.2021.09.16.00.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 00:49:12 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     brouer@redhat.com, daniel@iogearbox.net, kuba@kernel.org,
        andrii@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH bpf-next] bpf: Document BPF licensing.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        davem@davemloft.net
References: <20210916032104.35822-1-alexei.starovoitov@gmail.com>
Message-ID: <0d82359a-067b-b590-ae19-d360ccc7c0dd@redhat.com>
Date:   Thu, 16 Sep 2021 09:49:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210916032104.35822-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 16/09/2021 05.21, Alexei Starovoitov wrote:
> From: Alexei Starovoitov<ast@kernel.org>
>
> Document and clarify BPF licensing.
>
> Signed-off-by: Alexei Starovoitov<ast@kernel.org>
> Acked-by: Toke Høiland-Jørgensen<toke@redhat.com>
> Acked-by: Daniel Borkmann<daniel@iogearbox.net>
> Acked-by: Joe Stringer<joe@cilium.io>
> Acked-by: Lorenz Bauer<lmb@cloudflare.com>
> Acked-by: Dave Thaler<dthaler@microsoft.com>
> ---
>   Documentation/bpf/bpf_licensing.rst | 91 +++++++++++++++++++++++++++++
>   1 file changed, 91 insertions(+)
>   create mode 100644 Documentation/bpf/bpf_licensing.rst


Thanks for working on this, it is good this gets clarified.


Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

