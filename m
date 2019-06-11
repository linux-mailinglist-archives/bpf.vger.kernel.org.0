Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBD63CAE6
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2019 14:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfFKMRM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 11 Jun 2019 08:17:12 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34612 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbfFKMRL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Jun 2019 08:17:11 -0400
Received: by mail-ed1-f66.google.com with SMTP id c26so19793478edt.1
        for <bpf@vger.kernel.org>; Tue, 11 Jun 2019 05:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=U8VY/A+wnj+SF3sW6j7SiDJfywoPLecdIrzZ7ypp15k=;
        b=YLVD9hSIP8Kpn/3erZNy/67BJiqi1e2KJcCmzVUx6HoyDAd5cXIiEFsCs6jjO2w3vH
         bP/crzRBJ5seJbro56fVLf2MvYuxiWIjT373jN6hmF6ooEJlp2VK3fVQPz/0A/pfb1Ck
         vtPKnlMlj8jqpqcD+eI/7pgzzRXOfLE4jVXboOKn7Z0EjfmnYQh7vkR3vzEhCy4xcisQ
         36KPvNit0hRBlLMQlrYgxrz5B/SgarqwojrQE459qKNOW9N9nXE4xGf0PTSp84rkMKzL
         z21XMRCAMk3DeaWbNtmw0q9XSt83JKLqepsZqiC9VCVcVfrvJkI7IBV6rudHrEvfNNNp
         6EBQ==
X-Gm-Message-State: APjAAAVzxFrgUpVEWOpxcRoQGoZ0YxZ+NMgSNSyxbDNNgWBTn7Iw1q2i
        6L8ytWpB10KzXynlP6xz8F9krg==
X-Google-Smtp-Source: APXvYqyUV72kpi/fsmyIFOPBpWcZrl3YJx/kIYdSUNHlAo+2gBSIivUkoQVLD8G3mqqHvc232mijpQ==
X-Received: by 2002:a50:b3d0:: with SMTP id t16mr11639931edd.158.1560255429776;
        Tue, 11 Jun 2019 05:17:09 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id w50sm3649955edb.60.2019.06.11.05.17.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 05:17:08 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3BCF318037E; Tue, 11 Jun 2019 14:17:08 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        magnus.karlsson@intel.com, brouer@redhat.com, bpf@vger.kernel.org,
        saeedm@mellanox.com
Subject: Re: [PATCH bpf-next v3 0/5] net: xdp: refactor XDP program queries
In-Reply-To: <980c54f7-e270-f6cf-089d-969cebad8f38@intel.com>
References: <20190610160234.4070-1-bjorn.topel@gmail.com> <20190610152433.6e265d6c@cakuba.netronome.com> <980c54f7-e270-f6cf-089d-969cebad8f38@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 11 Jun 2019 14:17:08 +0200
Message-ID: <87v9xcgvuj.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Björn Töpel <bjorn.topel@intel.com> writes:

> On 2019-06-11 00:24, Jakub Kicinski wrote:
>> On Mon, 10 Jun 2019 18:02:29 +0200, Björn Töpel wrote:
>>> Jakub, what's your thoughts on the special handling of XDP offloading?
>>> Maybe it's just overkill? Just allocate space for the offloaded
>>> program regardless support or not? Also, please review the
>>> dev_xdp_support_offload() addition into the nfp code.
>> 
>> I'm not a huge fan of the new approach - it adds a conditional move,
>> dereference and a cache line reference to the fast path :(
>> 
>> I think it'd be fine to allocate entries for all 3 types, but the
>> potential of slowing down DRV may not be a good thing in a refactoring
>> series.
>> 
>
> Note, that currently it's "only" the XDP_SKB path that's affected, but
> yeah, I agree with out. And going forward, I'd like to use the netdev
> xdp_prog from the Intel drivers, instead of spreading/caching it all over.
>
> I'll go back to the drawing board. Any suggestions on a how/where the
> program should be stored in the netdev are welcome! :-) ...or maybe just
> simply store the netdev_xdp flat (w/o the additional allocation step) in
> net_device. Three programs and the boolean (remove the num_progs).

This seems reasonable to me (and thanks for keeping at this!).

-Toke
