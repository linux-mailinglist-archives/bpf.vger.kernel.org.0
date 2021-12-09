Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBD446E42C
	for <lists+bpf@lfdr.de>; Thu,  9 Dec 2021 09:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbhLIIbR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Dec 2021 03:31:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54187 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234802AbhLIIbQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 9 Dec 2021 03:31:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639038462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vI6c58+KogxxW+mn2T8IAIamTxq7omRdilnleuHfMf8=;
        b=XrjiLaDDdgTPjMwvLczD57/jRgNPUfOOAyJzWI9KqvwP+OZwp0OJ6qORnb+XtbpGd7mHIz
        pGGgOTbUKxOETVDJ/L4t/19nvyebf4AbVm6p/8sQ6thbjYtLme8+Nm/bs8U+mZ5+9gwmQ8
        H/EVIDP8zBcGeuuDWGJKEUOcVIT7gsI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-364-oLAxAG2AMl-HdOGPcwoCyw-1; Thu, 09 Dec 2021 03:27:41 -0500
X-MC-Unique: oLAxAG2AMl-HdOGPcwoCyw-1
Received: by mail-lf1-f69.google.com with SMTP id u20-20020ac24c34000000b0041fcb2ca86eso127290lfq.0
        for <bpf@vger.kernel.org>; Thu, 09 Dec 2021 00:27:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent:cc
         :subject:content-language:to:references:in-reply-to
         :content-transfer-encoding;
        bh=vI6c58+KogxxW+mn2T8IAIamTxq7omRdilnleuHfMf8=;
        b=fSf9Tln60DAqm9amTXiQcv/lq5X43imLwiNsjL7bWgYIfzklZJz2LT4PF3ErzyErg7
         ho46vudY45Deiz8piMp/05uEMN5WkE4fp0j5T7iO5zjzumDr0X1APkpeeFxPxsz07P3g
         2QWH0cIuBirb7nRju4KCb/n4E9RmIS6ZAmTxW8AMX0Eo3l5GSxnkaTKXFwYTYiVnFEDV
         njzlYvtWbsBq4m7I2tnAtBmBHssnKy7l/U+MU7/GQas/CGe5Yqc499XwAHQnTMR0rrKG
         dki0F7a+d/bVZ58vPERLYI6pnzi5UisyGyAooH+Gt+NECp3ePRyGxVVVLkw0+m7Itfoh
         Kf1Q==
X-Gm-Message-State: AOAM53219Xuo920vJgTxadE7oB0Xpv1MZ7hpS1KqfbuFHna97+PwOouW
        ywYs7vV4aVFaDd3RqOqrAVJRtnKZ65T6nODRowGWyNFnhIlDJkRF5k9kFmmHggwljX54ypoQZs2
        Tgjc5uK64Pk2P
X-Received: by 2002:ac2:58c3:: with SMTP id u3mr4511448lfo.103.1639038459920;
        Thu, 09 Dec 2021 00:27:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxKqCqbVpt51CaUwHpbqJX0HXKDsb6ux7hU+HGfDgbZtG4GXp/sOpGTWxlKjSvSjzEtXMq55A==
X-Received: by 2002:ac2:58c3:: with SMTP id u3mr4511426lfo.103.1639038459683;
        Thu, 09 Dec 2021 00:27:39 -0800 (PST)
Received: from [192.168.0.50] (87-59-106-155-cable.dk.customer.tdc.net. [87.59.106.155])
        by smtp.gmail.com with ESMTPSA id i3sm462850lfu.156.2021.12.09.00.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 00:27:38 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <2811b35a-9179-88ce-d87a-e1f824851494@redhat.com>
Date:   Thu, 9 Dec 2021 09:27:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Cc:     brouer@redhat.com, Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4 net-next 2/9] i40e: respect metadata on XSK Rx to skb
Content-Language: en-US
To:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        intel-wired-lan@lists.osuosl.org
References: <20211208140702.642741-1-alexandr.lobakin@intel.com>
 <20211208140702.642741-3-alexandr.lobakin@intel.com>
In-Reply-To: <20211208140702.642741-3-alexandr.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 08/12/2021 15.06, Alexander Lobakin wrote:
> For now, if the XDP prog returns XDP_PASS on XSK, the metadata will
> be lost as it doesn't get copied to the skb.

I have an urge to add a newline here, when reading this, as IMHO it is a 
paragraph with the problem statement.

> Copy it along with the frame headers. Account its size on skb
> allocation, and when copying just treat it as a part of the frame
> and do a pull after to "move" it to the "reserved" zone.

Also newline here, as next paragraph are some extra details, you felt a 
need to explain to the reader.

> net_prefetch() xdp->data_meta and align the copy size to speed-up
> memcpy() a little and better match i40e_costruct_skb().
                                      ^^^^^^xx^^^^^^^^^

You have a general misspelling of this function name in all of your 
commit messages.

--Jesper

