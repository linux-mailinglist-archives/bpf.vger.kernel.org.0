Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74296A8B8A
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 23:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjCBWMl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 17:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjCBWMl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 17:12:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB00C166D9;
        Thu,  2 Mar 2023 14:12:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64304B815BB;
        Thu,  2 Mar 2023 22:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9301C433D2;
        Thu,  2 Mar 2023 22:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677795153;
        bh=FQCpt5AyS0TwI7TIk+cssKaAw5jVsuP/Q+yugoKl2tc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OVgRNHl8uC8Nw02bwIiIYdTIISo5ZWH9XW9sAueUGUrFXH+2VV7uUtgOhJ7871KU1
         vCq8JTzEZSq5s8AmwYx7qAMVcooxCrAsk7hle7DdbXxmbqO6reUBS0aAXO/SocxaJY
         P4mQvKGhvCkfGMGA/p2DaAY+NLWJaXG1uk95dcjdZPBFt0i5W9rDo9iblZXxeTaLTA
         S8ilBXWS/KYAfORr4NaJrxH8SfvqbQ9SK0A3Cu9FXYtaSk1kFh9UfwygQ4qhhfZCAo
         4pk18JMHQMoTRx7HXAB/velpGTtqQ+Wv1QwwuB6+dqyTcHNHaFKSd33ZuBpB7YeQm0
         CJolK1AZ2BNcg==
Date:   Thu, 2 Mar 2023 14:12:31 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kees Cook <kees@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: splat in ikheaders_read (bpftrace)
Message-ID: <20230302141231.2c0a3761@kernel.org>
In-Reply-To: <20230302140814.294aece0@kernel.org>
References: <20230302112130.6e402a98@kernel.org>
        <22EA7360-E2FC-4A23-BF0B-EFDE523F9605@kernel.org>
        <20230302140814.294aece0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2 Mar 2023 14:08:14 -0800 Jakub Kicinski wrote:
> > static ssize_t
> > ikheaders_read(struct file *file,  struct kobject *kobj,
> > 	       struct bin_attribute *bin_attr,
> > 	       char *buf, loff_t off, size_t len)
> > {
> > 	memcpy(buf, &kernel_headers_data + off, len);
> > 	return len;
> > }
> > 
> > I will take a look at the caller's allocation of "buf" and kernel_headers_data.  
> 
> Mm. Actually stopping to look at the code - I don't see it bound
> checking against kernel_headers_data_end :| Maybe we need:
> 
> @@ -34,6 +35,7 @@ ikheaders_read(struct file *file,  struct kobject *kobj,
>                struct bin_attribute *bin_attr,
>                char *buf, loff_t off, size_t len)
>  {
> +       len = min_t(size_t, kernel_headers_data_end - kernel_headers_data, len);
>         memcpy(buf, &kernel_headers_data + off, len);
>         return len;
>  }

Scratch that, the size is set at init time.
My guess was memcpy() thinks the size of kernel_headers_data
is 1 since it's declared as char?
