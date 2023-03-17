Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FE06BF07F
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 19:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjCQSOx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 14:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjCQSOv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 14:14:51 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6E910CF;
        Fri, 17 Mar 2023 11:14:39 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id bc12so5582866plb.0;
        Fri, 17 Mar 2023 11:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679076879;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otfyDpFCPzxMzK3GkuSY9i91p07sQSN8bJCLl3mN8gw=;
        b=IpeaH88/UcBSShOdjtOpThXWEaK79KyxFMsBfpJOMq7IC1VpSMtIICkJhD7FjVFvwZ
         8c3lVnAQm1+yNPOk+W8flbvHLrOxA7UugQbu6TNEqVXAFux35MSsf8V4AuUTYoy1HgPp
         CRy1X0rLz7Rp1T6T0rl8LYkBclHXMSp36V0HSjr64E4M7TbEdi9XqHF1u/pbOyfGiZ8e
         FmPWnnIAPDpdunrsPWZvRtzKxM97RfKADzDk1A3CLN31UO2aqdUrvuuVjnoW/Ecihrj0
         6zevmqBWuJ+ToO0XTvuWBrS7i70xxKlkNQDu4zhgPDherHdUj/5vzHJFrRCzVKBWwS1y
         XYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679076879;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=otfyDpFCPzxMzK3GkuSY9i91p07sQSN8bJCLl3mN8gw=;
        b=Q1dcFgqHxc5P7Ug7hgplSLjnuS/d2J0nFU5hMJys37ap6wzZH5pLpPT+QjCBlKWP9i
         k106wRGaP0a3hZyC9Ebfw0oMUCY3MN1e39WeztaL1J7gfzHZTo5HTbatKO74RKD3G9Hp
         wYNavHd6urG1Dfv1t1crkTyPsET9tdAQNCUJUepILoK8Dyf1KRQHLCRN4pzZWq2kqyvc
         Ew/udH1d23oFSOvikg7HdnVkwd2E3C0eLuEFQkXEP/uw+1Me02SF0eGQ/G2xqehPFtgr
         92CZIboMt2Ijf6JxZ+U3RKrVMNlpLZOVjriC9so7hGchMbXtYCG3QT3zDHtQUzfA14se
         ryCA==
X-Gm-Message-State: AO0yUKWrygK9Yq6jCprGBs17dG7aVtugJjfunUruZMzMkUqrQXRdwC/J
        Inu4vVgDzziD1HQS+DyUAac=
X-Google-Smtp-Source: AK7set+mFvRissBVGakA2MSl/xYt6xf64Ra6tLA5iH2TEqHcJJ6TurwwK13mSni8Yy9GAYVPJIeakQ==
X-Received: by 2002:a17:90b:3143:b0:234:d3a:2a38 with SMTP id ip3-20020a17090b314300b002340d3a2a38mr8906804pjb.43.1679076879274;
        Fri, 17 Mar 2023 11:14:39 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id x21-20020a170902ea9500b0019c2cf12d15sm1835138plb.116.2023.03.17.11.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 11:14:38 -0700 (PDT)
Date:   Fri, 17 Mar 2023 11:14:37 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        starmiku1207184332@gmail.com
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, baijiaju1990@outlook.com
Message-ID: <6414ae0db3f69_984f8208cb@john.notmuch>
In-Reply-To: <20230317171636.ftelyp6ty7mgo4rt@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230317035227.22293-1-starmiku1207184332@gmail.com>
 <20230317171636.ftelyp6ty7mgo4rt@dhcp-172-26-102-232.dhcp.thefacebook.com>
Subject: Re: [PATCH v2] kernel: bpf: stackmap: fix a possible sleep-in-atomic
 bug in bpf_mmap_unlock_get_irq_work()
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov wrote:
> On Fri, Mar 17, 2023 at 03:52:27AM +0000, starmiku1207184332@gmail.com wrote:
> > context because of its possible sleep operation. However, mmap_read_unlock()
> > is unsafely called in a preempt disabled context when spin_lock() or
> > rcu_read_lock() has been called.
> 
> Why is that unsafe?
> See __up_read(). It's doing preempt_disable().

Yep I didn't see the issue either that is why I asked for the stack trace. If
its a bug we would want a reproducer as well seems like it should be trivially
tested in selftests.

> 
> 
> > -	if (irqs_disabled()) {
> > +	if (in_atomic() || irqs_disabled()) {
> 
> We cannot do this. It will significantly hurt stack traces with build_id.


