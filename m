Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F635F0295
	for <lists+bpf@lfdr.de>; Fri, 30 Sep 2022 04:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiI3CLK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Sep 2022 22:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiI3CLJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Sep 2022 22:11:09 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875F788DD7
        for <bpf@vger.kernel.org>; Thu, 29 Sep 2022 19:11:08 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id c7so2969659pgt.11
        for <bpf@vger.kernel.org>; Thu, 29 Sep 2022 19:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date;
        bh=Rih9MZ8YtvGSQosJRIulE+b+ghJJFqfxMCbhuIc2RHA=;
        b=URiULm+J/fR4UXBVbFnlxyOU95R5M5fnCiYWbU56knLv/GzSz5/ZYTOWZedNyZLAzu
         9TM08os7s5QNo+hQQT5voWoJf6a2XJMFVz6ga73Pcd/5yvB4sSLRTfzXAqzeSLtzsCe9
         5I05hi5WD+ItyDVXqNLupjtkb80pJEMO+XPWuD3ywEDAP0b/OsnawCaJCpP7Y6FkXSYb
         Bqj+x3Vv0fS2+LaamAPpf8achbzD1VJhOuA1TDEZQJ7k1huOTqodvPMsLsGodahylqfJ
         VfRmzCYfTXJVn297459bcUZ+vyqLWm94m/1InnkTGFPwsVhAjF8kxZoq5+C0KqMmmScV
         myBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Rih9MZ8YtvGSQosJRIulE+b+ghJJFqfxMCbhuIc2RHA=;
        b=Ibq5VQm+eZNfAag2Itx1xXBtggjU4NE7dAys6cVRYYbdOgJhucPzUOjMk5g6SGOJiA
         nO5qcH9aI2Dj1/cy9EeyTUbgHCFET838Orugg44vvMOvMAcBF/Ms5UmWmUOJGvBsOlFJ
         HB9cv84+Nw69zFQAKTOgyVZSbrtSaYm8gLWGarfi2muaMRutleVwbpP7lkj6lV0oCjLm
         9lWI8zcmIaOArIfaplDf5Qc+rXC1THYK44l90z923MOLl0xrRwMn/UtrIHYw7bH0fi9B
         a/b7XWsa2sbGgGQspUVBYAfogkIP0Xv/OBjyZpLW3OEcpiGwxF2x5K/ln+xzTxE1ZYX8
         jo0A==
X-Gm-Message-State: ACrzQf00OF7QCZo6El8ejWcYTWZkfFrXnh2yGsaAnoUkRrvSu/umeyTO
        bsx+Piy02K1xJvEdHCDwWcxE1yob6Nk=
X-Google-Smtp-Source: AMsMyM5kyl2xEtlBqJaul8O2WkLQGghR9JKmzZouMtHoVRNB3ger86VtLf+XenL11DixfoWSTmJfkg==
X-Received: by 2002:aa7:9717:0:b0:53e:84e4:dceb with SMTP id a23-20020aa79717000000b0053e84e4dcebmr6354571pfg.48.1664503867515;
        Thu, 29 Sep 2022 19:11:07 -0700 (PDT)
Received: from localhost ([98.97.42.14])
        by smtp.gmail.com with ESMTPSA id d17-20020aa797b1000000b0054a1534516dsm398681pfq.97.2022.09.29.19.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 19:11:06 -0700 (PDT)
Date:   Thu, 29 Sep 2022 19:11:05 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Owayss Kabtoul <owayssk@gmail.com>, bpf@vger.kernel.org
Message-ID: <63365039486df_233df208aa@john.notmuch>
In-Reply-To: <CAP-Vjpzqw=_t61tyJ7SPCLHresuX7XXv2gyQgO8NW1p5dNsViQ@mail.gmail.com>
References: <CAP-VjpyJxPNJ0438FbxEWxNbyL7zsCFwrEt6Tzw-vHz0ZQHxmg@mail.gmail.com>
 <CAP-Vjpzqw=_t61tyJ7SPCLHresuX7XXv2gyQgO8NW1p5dNsViQ@mail.gmail.com>
Subject: RE: Fwd: bpf syscall failing on aarch64 with "Invalid argument"
 (Asahi Linux on M1)
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

Owayss Kabtoul wrote:
> Hello.
> 
> I have built libbpf from source (a7c0f7e). When running any of the
> provided examples, the bpf syscall fails with "Invalid argument":
> 
> ```
> $ sudo strace ./minimal

Could you post the minimal C code. Its likely easier to read than
trying to parse the strace output. Sure we could probably figure
it out from strace but lets go the easier route.

Caveat I didn't bother to try and read the strace.

Thanks,
John
