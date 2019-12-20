Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 088F5127F18
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2019 16:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfLTPMo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Dec 2019 10:12:44 -0500
Received: from mail-qk1-f174.google.com ([209.85.222.174]:46265 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfLTPMo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Dec 2019 10:12:44 -0500
Received: by mail-qk1-f174.google.com with SMTP id r14so7839683qke.13;
        Fri, 20 Dec 2019 07:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IHi61ZO4N2TxTXDRb0qVYOix5FZH5i77yLyvReH1I6A=;
        b=BbT7FCDT4odjAl0Zy7AQJmuklSDWt+1P4hqlkWz+0lL4aODJcNceUnRqUpzlQlocAg
         QTwzQrI1ypcSmTIY2zO9sQdwEo+VMvSLFvcYb8sfmkXymsaKH1puK3srRU/cbFC/nrAA
         sNWF/HifIOYVqEbv7K6lrUklsR7rFHDKQHTyWaKHd2plhLrJUTVxjsTTpARVaT9uM/ve
         SFBCklhFBcmQkn8RMSDCYt7DPgMMM4i3XZUSurTfPzIFFK5w++iI679W6Cc7xdumjP7y
         ixdoDC32Q/Ned0ACKQUQo+I/R9z/ISPYQBFdX61X4ZWvp+QOLG+GErbrIJiE4sZwTB0q
         gT7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=IHi61ZO4N2TxTXDRb0qVYOix5FZH5i77yLyvReH1I6A=;
        b=tQTu6PjOcWrre9Mzx0LMxvSvi+tZCqPaXzLWrceiv42elkgkoNBoTcfSVg5IRTzZrw
         480YAGHzW0Tv7LS2i+kZqF9RyLaUEYSptj8l/MhKXDMiW1rZxQvy/ovLICGKJyceMf+b
         CV0M9xQY0Xv4O0jtG510z1NtG2VleLcolRfbJu36pNULABD5qIzCQqdIjtbJgdjXvhcw
         63AMIWiqz8pvmXubTqCG0R+8KdCPgNChynh/tqvg1pVdwJ9DaDb3CA1CqMA0yeM5rQKL
         7B2Ukri5vU52aC3MSF/nzBjmzGgNZn8tDO6d2Ycts83emxpvX5m0zwFwhq/kYIfa4n+V
         Xqgg==
X-Gm-Message-State: APjAAAX1fW01rRLAzjuJgMJzWDh/5kSrHHXuUL7f1Yjs2XwhS5/9B0Zg
        08fT9t/64z/pAXBFvlqVUCk=
X-Google-Smtp-Source: APXvYqzTbo9nrvCWuKzXMQFWRRYJMQDSkWc3FRa0b4eUgurK7Mv3sZSw4ccP1LjqE3PNfRehmXNMeA==
X-Received: by 2002:a05:620a:782:: with SMTP id 2mr13970138qka.169.1576854762744;
        Fri, 20 Dec 2019 07:12:42 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::11e7])
        by smtp.gmail.com with ESMTPSA id v125sm2973124qka.47.2019.12.20.07.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 07:12:42 -0800 (PST)
Date:   Fri, 20 Dec 2019 07:12:39 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Dennis Zhou <dennis@kernel.org>
Subject: Re: Percpu variables, benchmarking, and performance weirdness
Message-ID: <20191220151239.GE2914998@devbig004.ftw2.facebook.com>
References: <CAJ+HfNgNAzvdBw7gBJTCDQsne-HnWm90H50zNvXBSp4izbwFTA@mail.gmail.com>
 <20191220103420.6f9304ab@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220103420.6f9304ab@carbon>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 20, 2019 at 10:34:20AM +0100, Jesper Dangaard Brouer wrote:
> > So, my question to the uarch/percpu folks out there: Why are percpu
> > accesses (%gs segment register) more expensive than regular global
> > variables in this scenario.
> 
> I'm also VERY interested in knowing the answer to above question!?
> (Adding LKML to reach more people)

No idea.  One difference is that percpu accesses are through vmap area
which is mapped using 4k pages while global variable would be accessed
through the fault linear mapping.  Maybe you're getting hit by tlb
pressure?

Thanks.

-- 
tejun
