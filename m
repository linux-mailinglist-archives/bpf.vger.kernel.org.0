Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A9B6084CE
	for <lists+bpf@lfdr.de>; Sat, 22 Oct 2022 07:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiJVFzx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 22 Oct 2022 01:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJVFzw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 22 Oct 2022 01:55:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D881956FE;
        Fri, 21 Oct 2022 22:55:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A519B80D5C;
        Sat, 22 Oct 2022 05:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E2DC433D6;
        Sat, 22 Oct 2022 05:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666418147;
        bh=3kq5hK0aYi8nFlsQmgwwI6yjLYO0+cQb5xvgxXRv5LY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZMYI0/upfvGWZGpkrrCnCJYXnIiHoOLMmlPhFSByynalfzI/V0xqm+zKON0XsaJvo
         kbkxK3Fh3cFzPtM5SOGbuMNSRKQW06Nt10vbeZnDm8KmG7xjfpEIlndq6e0pPsSQM1
         z+piL1DSzqHcO9WzU+d0wsQFrjC3sbRGTy3Tltzg=
Date:   Sat, 22 Oct 2022 07:56:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     jinpeng Cui <cuijinpeng666@gmail.com>,
        Zeal Robot <zealci@zte.com.cn>, alan.maguire@oracle.com,
        ast@kernel.org, bpf@vger.kernel.org, cui.jinpeng2@zte.com.cn,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, stephen.s.brennan@oracle.com
Subject: Re: [PATCH linux-next] kallsyms: Use strscpy() instead of strlcpy()
Message-ID: <Y1OGELD2BP2KB1nG@kroah.com>
References: <20221020090547.398680-1-cui.jinpeng2@zte.com.cn>
 <Y1EVnZS9BalesrC1@kroah.com>
 <CANhqVYZ+trZzPdB=Vd9YV53DAJt0p5LZQH-u94+VRrDQ5+w2MA@mail.gmail.com>
 <Y1FCiH16RIetS0hZ@kroah.com>
 <202210210915.B177280DA8@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210210915.B177280DA8@keescook>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 21, 2022 at 09:17:10AM -0700, Kees Cook wrote:
> On Thu, Oct 20, 2022 at 02:43:52PM +0200, Greg KH wrote:
> > > I am very sorry if the patches from zte.com.cn
> > > in the past few months have made you angry,
> > > we have decided to fix the problem you pointed out
> > > as soon as possible.
> > > Our company's mailbox name@zte.com.cn
> > > cannot send emails to the external network,
> > > so we use name@gmail.com to send patches;
> > 
> > You all have been warned numerous times over many weeks and months and
> > never responded to our emails.
> > 
> > We have no proof that using gmail accounts is actually coming from a ZTE
> > employee, so until that happens, we can not take your changes (not to
> > mention the basic fact that you all keep ignoring our review comments,
> > which is a good enough reason to ignore them.)
> 
> Aren't there a few solutions here?
> 
> 1) Just send the emails from @gmail with matching S-o-b.

As we know these developers are claiming to be from a company that we
can not confirm they are actually working for, no, we can't take their
contributions as that goes against the DCO (anonymous contributions).

> 2) Send an @zte.com.cn to lkml to confirm their @gmail/@zte.com.cn mapping.

That would be great, but so far no one that I have contacted from ZTE
has been able to confirm that these are actually ZTE developers.

> 3) Fix the email systems.

That would be the best thing for them to do, and would solve the problem
for everyone at their company.  Hopefully that happens soon.

thanks,

greg k-h
