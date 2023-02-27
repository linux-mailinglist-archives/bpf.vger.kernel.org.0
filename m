Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308F46A4DCB
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 23:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjB0WOv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 17:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjB0WOt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 17:14:49 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4790A25BA6
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 14:14:47 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 6457D2406AA
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 23:14:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1677536086; bh=Konz6P9DXR/k4BngGontrEWmC/Rw0sl7qT3yAxPeJz4=;
        h=Date:From:To:Cc:Subject:From;
        b=ItHQ46Ld11awRy+MFvAZ8ROfmS72jmxbTOEMTh3gNOEn9Jl/A9heBj9ERBTWVfHQo
         knz2/1pfyF8oMW/H6RniDlwUyx27AKvv0wM9HcVXcnDK2pcgfvNEowC4Kh/WABZS2G
         4DqDAmWGdRWjmXXsCAqIjzuB3q34xL2Grz/eqSaFW18RbrwhcQF08+qS8sjIbFXoxp
         2b1nSOXcxwQgyzGgF/p+Ni0SR1vBtRPy48I7kcYbaWuTobnTDPWZwxzrto2Zzwe9BH
         9eQ45BvdIdOR+ngSNp+gY9EnYEr10CbbUi2SkqjM+4GRYtBSf/4InKU5qs15Z4u5B+
         5vOyAls8Ejrew==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PQZYJ5bYbz6tpH;
        Mon, 27 Feb 2023 23:14:44 +0100 (CET)
Date:   Mon, 27 Feb 2023 22:14:41 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Batteries-included symbolization with blazesym
Message-ID: <20230227221441.tjd5eglpmp2invjs@muellerd-fedora-PC2BDTX9>
References: <20230227193456.jbxt3mba6xfntieu@muellerd-fedora-PC2BDTX9>
 <20230227200748.xdkhnht2w4mtbj2u@kashmir.localdomain>
 <20230227213430.qxfrupne3g4lvsla@muellerd-fedora-PC2BDTX9>
 <20230227214115.p5ohjcnkl2rz4mkt@kashmir.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230227214115.p5ohjcnkl2rz4mkt@kashmir.localdomain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Daniel,

On Mon, Feb 27, 2023 at 02:41:15PM -0700, Daniel Xu wrote:
> On Mon, Feb 27, 2023 at 09:34:30PM +0000, Daniel Müller wrote:
> > On Mon, Feb 27, 2023 at 01:07:48PM -0700, Daniel Xu wrote:
> > > So my question is this: can/will blazesym be able to map kernel
> > > addresses to line numbers / file names?
> > 
> > Blazesym should be able to help with the symbolization aspect, yes. That is, it
> > can convert the addresses you captured into symbol name + source file + line
> > information as you asked for (you may need DWARF debug information for anything
> > beyond mere symbol names). In general, the library is able to handle both user
> > space and kernel addresses.
> 
> Awesome, sounds great. After looking slightly more carefully, how about
> split debug info support and debuginfod support? Extremely unlikely
> anybody ships production kernels with debug symbols. But debuginfod
> service is more likely.

Good questions. Split debug information is definitely something we want to
support out of the box, but we still lack such support at this point (it's still
somewhat early days).

Regarding debuginfod, we had some discussions about it in the past and it is
also something we are interested in supporting in some form. The way it will
most likely work is that the library will provide an interface that accepts a
callback that is invoked as part of the symbolization process and which allows
the user to fetch debug info based on data such as the build ID of a binary
(passed to the callback).
So it will likely be up to the user to make an HTTP request to a debuginfod
instance and fetch the data. Once that is done (and the callback returns)
blazesym would take over again and use that debug information to complete the
symbolization request. (We may provide a default implementation for such a
callback that does all the heavy lifting; in the batteries-included spirit)

Daniel
