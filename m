Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78F26DA279
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 22:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238745AbjDFURH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 16:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238444AbjDFURG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 16:17:06 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B827AAC
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 13:17:05 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j1so1348550wrb.0
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 13:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680812223;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1DPNUgTaT7LF6n+6QjcYQjgaf1X9o6ibLb1RBG0Kwus=;
        b=DxvSmwJkd2Yc7IN+wwbKR8o5splOF6A0CDRb6s42elAVe76zA6/9z17mRD6tZxbrt4
         HEuSsYX2xdSUmspbkwzOAMIzFmxo7sh19sxH86lf9mnxRgOekWY1NWORi8qQ3GZR4tke
         sat7wa/vKCe8xKc/bwm5ZMQPoAEph04i4jPwA2FlmiquuzPlXWB/ivamx0M8iHkpp+XJ
         /7f+4OCSnMlPWTOuwZ4OZU4BdfMXir+Bh2y2JBMYc2VU8Y+EidwMQojMSN93nJE8T04i
         au2FhrbnjJFg7Rh4a44TmRsUwU/RLy6teVavc6viQ5uk+xnRekvS0EFB/fhwjr+wbzXI
         tsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680812223;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1DPNUgTaT7LF6n+6QjcYQjgaf1X9o6ibLb1RBG0Kwus=;
        b=Zeye0psaZfFNsz2DsF37lgLpYXy0UBzHb0gLyj52YHm5H1tybo8z03dvSrYG+apsUo
         Acq/jItbXOBFah9o8KMPiQkmZlJoBwhj7kvQyfYNDJeHKH9SEc1j++senPv0k9Jt+xQ/
         oD64xxFdrlkZRib0ZUhg89r4CFO/GQ2QqUuN2YthKvYR6de+sTrY0TXkaVl/1EEZOxev
         2Cjta1rwUKB9pMCvsu9NCClLCO1WzpOFARd3Gc9/jHvwT3/2+tnHpx65vQmK59fuSyvx
         IKOFw615vdCDIBiSwAiYZQAftaLIgy1TQ5q02B+f74W6TJ8y00ikDIrjeCrTNsvr5uQc
         Ip2Q==
X-Gm-Message-State: AAQBX9e4sSMlYT0X0fVO5+GCUX3X6DXZ1EbEU8TYzdnOKYtFYHEvb4ZD
        puHk9zwfQbOvzSJ1fe1rV4Q=
X-Google-Smtp-Source: AKy350YW6tmugVYZwYi7jzv78eSYA1ufDsMa8CkXg/ZOX+HO0a/i98hgxJpNrO6Zzp0V8H/oQT5sKw==
X-Received: by 2002:adf:fccf:0:b0:2d1:46eb:3f98 with SMTP id f15-20020adffccf000000b002d146eb3f98mr7001604wrs.36.1680812223479;
        Thu, 06 Apr 2023 13:17:03 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id g17-20020a05600c001100b003dd1bd0b915sm6104301wmc.22.2023.04.06.13.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:17:02 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id DE717BE2DE0; Thu,  6 Apr 2023 22:17:01 +0200 (CEST)
Date:   Thu, 6 Apr 2023 22:17:01 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Florian Lehner <dev@der-flo.net>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        X86 ML <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hsin-Wei Hung <hsinweih@uci.edu>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Rik van Riel <riel@surriel.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf 1/2] mm: Fix copy_from_user_nofault().
Message-ID: <ZC8ovRMLxL5ehzWu@eldamar.lan>
References: <20230118051443.78988-1-alexei.starovoitov@gmail.com>
 <ZB8LX/BKPgvzfvcm@der-flo.net>
 <CAADnVQKyRpg=-uxCH6eNxPfvUCS8tKSe-AV-1304rRdTYxG1JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKyRpg=-uxCH6eNxPfvUCS8tKSe-AV-1304rRdTYxG1JQ@mail.gmail.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On Sat, Mar 25, 2023 at 12:47:17PM -0700, Alexei Starovoitov wrote:
> On Sat, Mar 25, 2023 at 7:55 AM Florian Lehner <dev@der-flo.net> wrote:
> >
> > With this patch applied on top of bpf/bpf-next (55fbae05) the system no longer runs into a total freeze as reported in https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1033398.
> >
> > Tested-by: Florian Lehner <dev@der-flo.net>
> 
> Thanks for testing and for bumping the thread.
> The fix slipped through the cracks.
> 
> Looking at the stack trace in bugzilla the patch set
> should indeed fix the issue, since the kernel is deadlocking on:
> copy_from_user_nofault -> check_object_size -> find_vmap_area -> spin_lock
> 
> I'm travelling this and next week, so if you can take over
> the whole patch set and roll in the tweak that was proposed back in January:
> 
> -       if (is_vmalloc_addr(ptr)) {
> +       if (is_vmalloc_addr(ptr) && !pagefault_disabled())
> 
> and respin for the bpf tree our group maintainers can review and apply
> while I'm travelling.

Anyone can pick it up as suggested by Alexei, and propose that to the
bpf tree maintainers?

Regards,
Salvatore
