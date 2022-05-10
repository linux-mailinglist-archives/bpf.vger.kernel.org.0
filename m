Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D59520B8B
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 04:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbiEJC6Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 22:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbiEJC6X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 22:58:23 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3814F285EFB
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 19:54:28 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id p12so13830351pfn.0
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 19:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/R/vnZwyXnLsblsDrMrvcAuzLA2r147Io+3WUyx+PNE=;
        b=OGyR8jcpb7MLRuQLeSng2mE8djS7Dx8X2eiDjaBhInj+ZseSQIeEbariaHQZaXWHkW
         h1+++6S/MjaAThcPRtprLZOMZ0ljSggwvoSWMiWRHdnHbN0XL6GGVjrJddWQ82o6v0zZ
         QybORVyxCX5rVav4u/5j+B+WLsaiRkN+iB+H7wjQMBH+o9PIn7UhYwa2TILz7eZxnfGV
         /qmc1+5ctCk9j/YeuyDLDNSGnbIUiEX9vGmF9i/gmXRMO6qCtHvG4elMQ3yHTSsH+/MS
         RiqgObEADe28nsoymlNK+0h3cgxm+B8D6/GuiH3X69VWdDZt1jhD3AYH0JX2PlW/zMg0
         qAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/R/vnZwyXnLsblsDrMrvcAuzLA2r147Io+3WUyx+PNE=;
        b=K40MYQaThYfxUxB4Vq+SCweWU94lhfF1gIrwV9DqMyyegw2GeikHF2mJ/qfBXMVWyW
         4TGalP3bSBYGUDUkyezCVt7CQowSdS+Q5UsDJ1DQGpWd58OcUTPnpE47tHu6+mGVg0wk
         lrcgVBiUZ953IXZJzuuhFTlnRlHGtAAKSYO7g46jQMCwoMHZ3Ipi1I/nMkTsVVQo3Wh/
         1WUZvoazZAn682CNZcMZGc+Y+IFHJ8Pr9JC+u1J/IizkNjKuZ8bAng3vBkTb5e7GM1FJ
         9D6JVWz4p3JXZ289lf7qykQT5OwGYy8bKnqy8kLfDeQ4a0+HiIJr7JLBHnxCNM74vFor
         C4uw==
X-Gm-Message-State: AOAM531pfO20Mw9JPQDvpEd7xP/BVE4ryYZ62XtKpCAAEzvh9UG8PTqk
        0mh2VRdOIZ89mskglfe3d/0=
X-Google-Smtp-Source: ABdhPJyJnSTtcJlKXmb0BthhEJaIUebqD+0220cI9qJrr44C8d2Yuldf0gPndkkbKA24EvDphTt4gQ==
X-Received: by 2002:a63:1e64:0:b0:3c6:2d6f:c541 with SMTP id p36-20020a631e64000000b003c62d6fc541mr15147426pgm.134.1652151267658;
        Mon, 09 May 2022 19:54:27 -0700 (PDT)
Received: from MBP-98dd607d3435.dhcp.thefacebook.com ([2620:10d:c090:400::4:e8e5])
        by smtp.gmail.com with ESMTPSA id f11-20020a17090aa78b00b001d5e1b124a0sm501415pjq.7.2022.05.09.19.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 19:54:27 -0700 (PDT)
Date:   Mon, 9 May 2022 19:54:24 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>
Subject: Re: [PATCH bpf-next v2 2/5] bpf: implement sleepable uprobes by
 chaining tasks_trace and normal rcu
Message-ID: <20220510025424.yzxsij3kxlzxqnlw@MBP-98dd607d3435.dhcp.thefacebook.com>
References: <588dd77e9e7424e0abc0e0e624524ef8a2c7b847.1651532419.git.delyank@fb.com>
 <202205031441.1fhDuUQK-lkp@intel.com>
 <c7819d752137cf93be454c117812bb1c2c1866e4.camel@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7819d752137cf93be454c117812bb1c2c1866e4.camel@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 03, 2022 at 05:20:26PM +0000, Delyan Kratunov wrote:
> On Tue, 2022-05-03 at 14:30 +0800, kernel test robot wrote:
> > Hi Delyan,
> > 
> > Thank you for the patch! Yet something to improve:
> > 
> > [auto build test ERROR on bpf-next/master]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Delyan-Kratunov/sleepable-uprobe-support/20220503-071247
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> > config: i386-defconfig (https://download.01.org/0day-ci/archive/20220503/202205031441.1fhDuUQK-lkp@intel.com/config )
> > compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
> > reproduce (this is a W=1 build):
> >         # https://github.com/intel-lab-lkp/linux/commit/cfa0f114829902b579da16d7520a39317905c502
> >         git remote add linux-review https://github.com/intel-lab-lkp/linux
> >         git fetch --no-tags linux-review Delyan-Kratunov/sleepable-uprobe-support/20220503-071247
> >         git checkout cfa0f114829902b579da16d7520a39317905c502
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    kernel/trace/trace_uprobe.c: In function '__uprobe_perf_func':
> > > > kernel/trace/trace_uprobe.c:1349:23: error: implicit declaration of function 'uprobe_call_bpf'; did you mean 'trace_call_bpf'? [-Werror=implicit-function-declaration]
> >     1349 |                 ret = uprobe_call_bpf(call, regs);
> >          |                       ^~~~~~~~~~~~~~~
> >          |                       trace_call_bpf
> >    cc1: some warnings being treated as errors
> 
> Hm, CONFIG_BPF_EVENTS doesn't seem to guard the callsite from trace_uprobe.c, it's
> only gated by CONFIG_PERF_EVENTS there. A PERF_EVENTS=y && BPF_EVENTS=n config would
> lead to this error. 
> 
> This is  a pre-existing issue and I'll send a separate patch for it.

Maybe move uprobe_call_bpf into trace_uprobe.c so it gets a chance of being
fully inlined and will avoid this issue.
