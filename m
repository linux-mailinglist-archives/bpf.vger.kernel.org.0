Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 302E720B69D
	for <lists+bpf@lfdr.de>; Fri, 26 Jun 2020 19:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgFZRJr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Jun 2020 13:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728210AbgFZRJq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Jun 2020 13:09:46 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFA6C03E979
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2020 10:09:46 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id v8so10498303iox.2
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2020 10:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9FJhWQ6DJzhTxp5Gv7WI23ebr6dsFSZggRiHM0eeP+M=;
        b=R3ikkHbu/ghIHNDmJjeRdHsJBje2305VTLSxQNHBHrHgVC0+eWIgIIFziZK+/HgOhq
         I0WCsmrh0wPLAUFlRX/ZR8XwbbruhDtB0GaFt6uvgOWJFt2NZ/aHR1Q2mTrJ7R7ZfCKo
         A2hV/x6cgNmniUlEGTd4CH1k4X17xnQoVd8v5+xAZfZAdiAgseQTcZFndGi3ieJOL0f6
         MXXi0xGS9vab68tQOPtmeTgmBtcfaXw8UH+iWM15lVZnQR2IE/wgDSRVeebWv4ii4xUq
         3LI5eGwGUCoPhbFB8QVD8c6GE7bSNnLpWyi1BJdGXOLSFIAY+z7jd2ZHe5kETS2hbeR0
         ZYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9FJhWQ6DJzhTxp5Gv7WI23ebr6dsFSZggRiHM0eeP+M=;
        b=Yy1uoa+6tUglawXCcImkeBR/AlekyaojmXsfgdBztaXonWL1AONEVWAr4wVQIvuiEA
         HYZ6YdqNRlQ1/i0K/4JSkWX/caa+syPJpPCcy6sQPCYqGp0Zf6JZWir7t3NA4ex5zu7k
         xx3U4Rrm8rD3fkMIOZD+77qDNttetzggHH+Vy8WkQtXEAxNm0gIUJ1pMRTMY/7auO77n
         iPN+bUzSclze0+4EiG8vx+t2SLJMpZcTseN4UNBIG5OQbuLwxnFeXZkc0r1TPIykzoNz
         YhizUO43zAFGqpC2DG0AFHyL8+Q1l0N/DgeM5XPuWodHyMawS7Y2h9P+JFHTnoYGxbZ0
         4/ZA==
X-Gm-Message-State: AOAM530/XuLbJx9h7jUbKfx6XHqd1BHNUElA5bBhGVgVkLTno4imR/xx
        yloKT9j8sMybpKar6PyNIyPss63BYoOfh9sOfOs=
X-Google-Smtp-Source: ABdhPJw0Zr3Sn+BU5BpBnJHbvGWG2xvFUp9N2x2WFoE0eIHaOoIiQ2Wduv7DKa3hr++BW2exQWEhDNmB6EmHe1yfJ6Q=
X-Received: by 2002:a5e:9708:: with SMTP id w8mr4458917ioj.16.1593191385519;
 Fri, 26 Jun 2020 10:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAP5XGZejdCVA0rk9ctj3=i_QPSDVzJem+nbzz6KVwJaGUS_8GA@mail.gmail.com>
 <7e8f76ab-c130-36b7-91e4-e155a0a91aa8@fb.com>
In-Reply-To: <7e8f76ab-c130-36b7-91e4-e155a0a91aa8@fb.com>
From:   Simone Magnani <simonemagnani.96@gmail.com>
Date:   Fri, 26 Jun 2020 19:09:34 +0200
Message-ID: <CAP5XGZcus93WhxXAJ2j3MCB7kuBaGiR-j4YXidwDye+FOQNhKQ@mail.gmail.com>
Subject: Re: [LINUX-KERNEL] - bpf batch support for queue/stack
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thanks Yonghong, clear and straight to the point.
I'll update you if I will be able to make it, by now many thanks :)

Il giorno ven 26 giu 2020 alle ore 18:00 Yonghong Song <yhs@fb.com> ha scritto:
>
>
>
> On 6/26/20 5:01 AM, Simone Magnani wrote:
> > Hi,
> >
> > I'm Simone and I'm new to this community.
> > Lately, I've been working on in-kernel traffic analysis with eBPF and
> > the newest features released in the latest kernel versions
> > (queue/stack, batch operations,...).
> > For some reason, I couldn't help but notice that Queues and Stacks bpf
> > map types don't support batch operations at all, and I was wondering
> > why. Is there any reason why this decision has been made or it is just
> > temporary and you are planning to implement it later on?
>
> The initial implementation targets to specific use cases for
> hash and array maps. Yes, queue and stack batch operations could
> be supported. The necessary infrastructure and example implementation
> for hash/array maps are in the kernel tree. You or anyone interested
> are welcome to take a try.
>
> >
> > Reference file: linux/kernel/bpf/queue_stack_maps.c (and all the
> > others belonging to the same directory)
> >
> > Thanks in advance,
> >
> > Regards,
> > Simone
> >
