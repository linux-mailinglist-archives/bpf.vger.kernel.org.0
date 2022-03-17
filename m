Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68DD4DC9C4
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 16:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbiCQPUt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Mar 2022 11:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbiCQPUs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Mar 2022 11:20:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631D2157589;
        Thu, 17 Mar 2022 08:19:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8402B81E90;
        Thu, 17 Mar 2022 15:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB9FC340E9;
        Thu, 17 Mar 2022 15:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647530369;
        bh=BpENNq9c5j2eyXFaAKoDXCluzS14HqF6oKhXkk1xNV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P7chehQi6B2mXVHEu6AUIO7CjWwaazsnQdQg5nI6FxXjwkkhQjZofbJbLKHkvskt0
         122kv5DNsp0BuIYU48Ej8wFLQHRq/PwPwIOiWUSyaK/5p9OwB96CqL/mLOVuIoE1Mw
         mm8WhcgQ+DnAgVzRE8AlSoor7tBS5WKeDZpeDNu9vuznoygMfS8xLWxRctJYo2BO0i
         36WVhenXsi+gWNxi6IBHsGSflBEnZ3fbQmSfK9zySmZtmJtPWLfnrrnuQCFs+HLY4b
         i3MfiQQCPrzg6VE1Q//tjl3SrOnmSjeiya6b5lw9mIJ8kShLdKfONDCVLk0eckiNF7
         enG6KrZ+yEmOw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D674740407; Thu, 17 Mar 2022 12:19:25 -0300 (-03)
Date:   Thu, 17 Mar 2022 12:19:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     kkourt@kkourt.io, dwarves@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kornilios Kourtis <kornilios@isovalent.com>
Subject: Re: [PATCH 2/2] dwarves: cus__load_files: set errno if load fails
Message-ID: <YjNRfXt8ZAAgHxSJ@kernel.org>
References: <YjHjLkYBk/XfXSK0@tinh>
 <20220316132354.3226908-1-kkourt@kkourt.io>
 <6232c089bbaf2_487f208db@john.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6232c089bbaf2_487f208db@john.notmuch>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Mar 16, 2022 at 10:00:57PM -0700, John Fastabend escreveu:
> kkourt@ wrote:
> > From: Kornilios Kourtis <kornilios@isovalent.com>
> > 
> > This patch improves the error seen by the user by setting errno in
> > cus__load_files(). Otherwise, we get a "No such file or directory" error
> > which might be confusing.
> > 
> > Before the patch, using a bogus file:
> > $ ./pahole -J ./vmlinux-5.3.18-24.102-default.debug
> > pahole: ./vmlinux-5.3.18-24.102-default.debug: No such file or directory
> > $ ls ./vmlinux-5.3.18-24.102-default.debug
> > /home/kkourt/src/hubble-fgs/vmlinux-5.3.18-24.102-default.debug
> > 
> > After the patch:
> > $ ./pahole -J ./vmlinux-5.3.18-24.102-default.debug
> > pahole: ./vmlinux-5.3.18-24.102-default.debug: Unknown error -22
> > 
> > Which is not very helpful, but less confusing.
> > 
> > Signed-off-by: Kornilios Kourtis <kornilios@isovalent.com>
> > ---
> 
> With the err to -err fix Arnaldo proposed.
> 
> Acked-by: John Fastabend <john.fastabend@gmail.com>

Thanks, did the ammendment and collected your Acked-by,

- Arnaldo
