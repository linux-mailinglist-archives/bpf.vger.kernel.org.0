Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064F2698181
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 18:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjBORBK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 12:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjBORBI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 12:01:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B563B303FB;
        Wed, 15 Feb 2023 09:01:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6588FB8225F;
        Wed, 15 Feb 2023 17:01:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F248C433D2;
        Wed, 15 Feb 2023 17:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676480465;
        bh=7NDzIefEbXiIJCEib3sr7gh8/H2KcWsCHwSr/TU1F/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a4CMP6ci0CdBOLo61RbH7msCByorysRMQT3XacNFmZxBVNn13P0YBA55+Me8718LR
         MjhlwFdtHhCSCp7P2mrAUoMjqq6+wFMMt+EB2LQ7rr7wo4PVq0YilbODEqJITiBV+z
         zXdi5HOpF7mTI1DXK+QeTWSIr2HUVQx83rASNGuK1DdkLLO+6zcIxcxPvyEbX8puD3
         cOvy9O5Yq4LdWQ1YMP4/CQ0KZgu16x4tgvy9hrUCS1xMr1JhO3SpJuWK1ZlmufGfNA
         YghVak6aTAD9SSZG/BiZnKEvJKt+QCIzDhCXsRdFBOJha++g9k6AIZlgRHWyFwNHkR
         N3Z4Ih9RVJPTA==
Date:   Wed, 15 Feb 2023 10:01:02 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, mcgrof@kernel.org,
        ndesaulniers@google.com, trix@redhat.com,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] module: Remove the unused function within
Message-ID: <Y+0PzlA0LijhfD8R@dev-arch.thelio-3990X>
References: <20230210064243.116335-1-jiapeng.chong@linux.alibaba.com>
 <Y+0MsMomkcDBdjNI@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+0MsMomkcDBdjNI@chrisdown.name>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 15, 2023 at 04:47:44PM +0000, Chris Down wrote:
> Jiapeng Chong writes:
> > The function within is defined in the main.c file, but not called
> > elsewhere, so remove this unused function.
> 
> Huh? It's used by __module_text_address(), no?

Not after commit 2ece476a2346 ("module: replace module_layout with
module_memory") in -next. This patch should have a fixes tag, even if
the warning is currently hidden behind W=1.

> > kernel/module/main.c:3007:19: warning: unused function 'within'.
> > 
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4035
> > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> > ---
> > kernel/module/main.c | 5 -----
> > 1 file changed, 5 deletions(-)
> > 
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index c598f11e7016..062065568b40 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -3004,11 +3004,6 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
> > 	return load_module(&info, uargs, flags);
> > }
> > 
> > -static inline int within(unsigned long addr, void *start, unsigned long size)
> > -{
> > -	return ((void *)addr >= start && (void *)addr < start + size);
> > -}
> > -
> > /* Keep in sync with MODULE_FLAGS_BUF_SIZE !!! */
> > char *module_flags(struct module *mod, char *buf, bool show_state)
> > {
> > -- 
> > 2.20.1.7.g153144c
> > 
