Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4AA400953
	for <lists+bpf@lfdr.de>; Sat,  4 Sep 2021 04:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236244AbhIDC3n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Sep 2021 22:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236175AbhIDC3n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Sep 2021 22:29:43 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5545CC061575
        for <bpf@vger.kernel.org>; Fri,  3 Sep 2021 19:28:42 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id h9so1651777ejs.4
        for <bpf@vger.kernel.org>; Fri, 03 Sep 2021 19:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=JAWBtM7K7BMtnyPEm20N+4qU/k+yiQgGMrs50rQRJSw=;
        b=WiQ+iN9M5WdhGlk2j7SJKBPi78UZ52J7lG5sd1KIdu+Cr3m5DP+/jWfp8GjI7JLvcM
         crfHLPMNOFNtFnIBLG+BcWbTpofFy/JFtxmDo+/kDYSuDLAL2rdejvZg6Yh0F0ibWjdK
         djKErFB6nRYZtumnO5yAMoeh3ge3E/AYUChknzbihBL00C6PJjyr9joRNKyrQfk29NXy
         x0yjC+Y6R6SoEJ/t5wbV54whXdOUhS4TGkvGiEr0iqXdGiGDT8X2y6Lz9LnFXd+fs/OX
         JeXnSRVcGcFy0pzfl+u+1W/ubTQatE+aqpqYS9X66vnoUEt7rlX3hCBVmgSwBqLJm7Y2
         MU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=JAWBtM7K7BMtnyPEm20N+4qU/k+yiQgGMrs50rQRJSw=;
        b=jbIOsypsNJ2LnKmt51GYNsRv4lQnatxZ+H7mF2zray7QBZDaO+vqT3NqI0biOW29Bt
         XItb6neYx8KCnLwPLGtsuRpwjlmghiJjmAK97zQlW5v7x4qDpCMs4Ke5svYtn0epapbS
         zytQ2UuNWjOaucqOjO8h+DhhJCA7Acf1f9bNq8bWZth7xM9eoMJA4kfRhVmrvGB/FT6y
         MN3lMAMgKRVWh0Gh2PYt/ftGONP+kfbxaaDYaLVylTeYnJrf8DYoRKnPjwQVa+8ZKO4f
         3jjkAhOfxpkdpZWMl2XQE5isati9pZ1CdWppd1ZCHZRJA5DcGeR3S56CzL1V+D9uzvlG
         DxEA==
X-Gm-Message-State: AOAM533+anWBuQFBpKgNQGD4a23xG+yCw5zkdGCOG7PlIT3Uue+7isHg
        dQGIg5U5rsi+Wr4ieBSqxSM=
X-Google-Smtp-Source: ABdhPJxzqLuA0Z26aGHlzlcZHyUQOtpNilKoRp4Shh15UKJ3Qjj9U5U8nbR6YM/epGJWgBcA39Wimg==
X-Received: by 2002:a17:906:1c41:: with SMTP id l1mr2065122ejg.13.1630722520817;
        Fri, 03 Sep 2021 19:28:40 -0700 (PDT)
Received: from localhost (host-79-54-69-56.retail.telecomitalia.it. [79.54.69.56])
        by smtp.gmail.com with ESMTPSA id x11sm476618edq.58.2021.09.03.19.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 19:28:40 -0700 (PDT)
Date:   Sat, 4 Sep 2021 04:28:37 +0200
From:   Lorenzo Fontana <fontanalorenz@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next] bpf: add helpers documentation about GPL
 compatibility
Message-ID: <YTLZ1dEBdA+5fdat@riversong>
Mail-Followup-To: Lorenzo Fontana <fontanalorenz@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <20210822115900.26815-1-fontanalorenz@gmail.com>
 <20210824001013.mktbw4p6mn6desdv@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824001013.mktbw4p6mn6desdv@ast-mbp.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 23, 2021 at 05:10:13PM -0700, Alexei Starovoitov wrote:
> On Sun, Aug 22, 2021 at 01:59:00PM +0200, Lorenzo Fontana wrote:
> > When writing BPF programs one might refer to the man page
> > to lookup helpers. When you do so, however you don't have
> > a way to immediately know if you can use the helper
> > based on your program licensing requirements.
> > 
> > This patch adds a specific line in the man bpf-helpers
> > to show that information straight away.
> > 
> > Signed-off-by: Lorenzo Fontana <fontanalorenz@gmail.com>
> ...
> >   * long bpf_trace_printk(const char *fmt, u32 fmt_size, ...)
> >   * 	Description
> > @@ -1613,6 +1621,8 @@ union bpf_attr {
> >   * 	Return
> >   * 		The number of bytes written to the buffer, or a negative error
> >   * 		in case of failure.
> > + * 	GPL Compatibility
> > + * 		Required
> 
> I think manually annotating the docs is too easy to get wrong.
> I think scripts/bpf_doc.py should be able to pick it up from the code somehow?
> or rely on dynamic discovery by bpftool?

Thanks for the review Alexei. I agree it's not the best but I followed
the same approach as for the other elements. It might seem that the
script parses those from code but in reality it just parses them from
a comment in the helpers file. I tried to accomplish this by looking at
the various C files containing this information but it would mean
changing a lot the way the script works. I can still do that but wanted
to also note that it will be very unlikely that an helper changes
licensing and since the helper makers will always need to annotate the
helpers header file with information I thought that adding this
immediately would've been enough.

I'll explore the possibility of doing this with bpftool instead, that's
a great suggestion. Thank you!


Lore
