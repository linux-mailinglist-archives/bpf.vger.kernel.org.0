Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0436B6E3B54
	for <lists+bpf@lfdr.de>; Sun, 16 Apr 2023 20:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjDPSwR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 16 Apr 2023 14:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDPSwR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 16 Apr 2023 14:52:17 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8771810CB;
        Sun, 16 Apr 2023 11:52:15 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f167d0c91bso9848175e9.2;
        Sun, 16 Apr 2023 11:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681671134; x=1684263134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6Ku0+NTC8bNTjbCgiexuYfINosTStnT3+TeJKf99Zo=;
        b=Cp048Icg72JbeFDMoVykKwpDz/bTi153C+AfD7d5gNJ8CW9QC24hK6bGnS7eS8ZmxK
         /t8C12OZT7bBHsSYOlvspz2gubETrpyl+GaCUD6bl4ZEXI3eh5ZOSJ/rj8g9ZxXlNTCK
         02G8PlQL9d1p7h01NbayN7jPurDbecZLbu/vakzt9p5uF91KDRtL8L7Hmx6vl+GYXLuG
         fBZN5Xib8V6N2nYZ5+Z5roXsCU5hNQAJ827SykuWIYMw7cNE7FhL3NrihRtHYyYBXE1J
         qoP85ZdnZGtQ3IwJKH+nj+0G0xGF2y/TeHd6oWOjOyUkIkgnKTUqaS9QXnB3m5b1Y6Yg
         e9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681671134; x=1684263134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6Ku0+NTC8bNTjbCgiexuYfINosTStnT3+TeJKf99Zo=;
        b=llggdFbf2YpUonfYv2SLSfe8JR+x3TjTdj1fF9QdGBJwgt629bPCV/sj1V5DMpaF5r
         Yet21LtjHOzqMRKwUjVVHIjUaLsZZo/hKMcnjr1ZJeK67ualQz4FbENR2ztj5DgU7GRn
         qe/V59jIXVk8IeBYq9OLFikBoHz4bCK51gM5gtFoQMxn/bpXSsJFH2yHm9w1uEHdwHta
         HwlvKMOJaDyLQRFlrhB9zlueX7JRWi0fc/vjfcBNuwS2dM+lhiNVf7MKTs73AB7iGXBx
         1TDi7ItpW79lZY19HykXk06TWNUX/3sfGpTaY1FfgILqmvff0Yst9V6FzXa664uFZbTQ
         07FA==
X-Gm-Message-State: AAQBX9eV6OmBv59fpUf4mRjy6rBuQwTyTAjqKd8ufsWOa4jfD8vM8Vyv
        Xt+PmQhuBBVRUyZ9zQkIxbI=
X-Google-Smtp-Source: AKy350YkCc4ZGEuIKujbX6AaGd6LZRdZ6QK0UwncHLVlScZ655mI6QUblZznWeZ0EJCtBaOACnLtIg==
X-Received: by 2002:adf:ee8a:0:b0:2f9:cee4:b7d with SMTP id b10-20020adfee8a000000b002f9cee40b7dmr1672567wro.70.1681671133706;
        Sun, 16 Apr 2023 11:52:13 -0700 (PDT)
Received: from solpc.. (67.pool90-171-92.dynamic.orange.es. [90.171.92.67])
        by smtp.gmail.com with ESMTPSA id m13-20020adffe4d000000b002efb139ce72sm8641882wrs.36.2023.04.16.11.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 11:52:13 -0700 (PDT)
From:   =?UTF-8?q?Joan=20Bruguera=20Mic=C3=B3?= <joanbrugueram@gmail.com>
To:     jpoimboe@kernel.org, i.pear@outlook.com
Cc:     acme@kernel.org, alan.maguire@oracle.com, alexandref75@gmail.com,
        bpf@vger.kernel.org, dxu@dxuuu.xyz, jforbes@redhat.com,
        linux-kernel@vger.kernel.org, olsajiri@gmail.com,
        peterz@infradead.org, ptalbert@redhat.com, yhs@fb.com
Subject: Re: [PATCH] vmlinux.lds.h: Force-align ELF notes section to four bytes
Date:   Sun, 16 Apr 2023 18:52:04 +0000
Message-Id: <20230416185204.2592590-1-joanbrugueram@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <SY4P282MB108438B241E26EB9DC76A4469D989@SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM>
References: <SY4P282MB108438B241E26EB9DC76A4469D989@SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 13, 2023 at 12:54:19PM +0800, Tianyi Liu wrote:
> On Wed, Apr 12, 2023 at 16:30PM UTC, Josh Poimboeuf wrote:
> > On Wed, Apr 12, 2023 at 03:10:14PM +0800, Tianyi Liu wrote:
> > > On Tue, Apr 11, 2023 at 17:00 , Josh Poimboeuf wrote:
> > > > On Tue, Feb 14, 2023 at 02:33:02PM +0800, Tianyi Liu wrote:
> > > > > > LLVM_OBJCOPY=objcopy pahole -J --btf_gen_floats -j
> > > > > > --skip_encoding_btf_inconsistent_proto --btf_gen_optimized
> > > > > > .tmp_vmlinux.btf
> > > > > > btf_encoder__encode: btf__dedup failed!
> > > > > > Failed to encode BTF
> > > > > >
> > > > > > Thanks,
> > > > > >
> > > > >
> > > > > I encountered the same problem when building a new kernel and I found some
> > > > > reasons for the error.
> > > > >
> > > > > In short, enabling CONFIG_X86_KERNEL_IBT will change the order of records in
> > > > > .notes section. In addition, due to historical problems, the alignment of
> > > > > records in the .notes section is not unified, which leads to the inability of
> > > > > gelf_getnote() to read the records after the wrong one.
> > > >
> > > > Alexandre, Tianyi, are you still seeing this issue with the latest
> > > > dwarves?  If so can you confirm the below patch fixes it?
> > > >
> > >
> > > Josh, first of all, thank you very much for your help. However, this patch
> > > doesn't work in my environment. I am using gcc 12.2.1 20230201.
> > > After compiling, when I use readelf -S to view ELF sections,
> > > the align of .notes section is still 8:
> > >
> > > $ readelf -S .tmp_vmlinux.btf
> > > [20] .notes            NOTE             ffffffff8250b570  0170b570
> > >      0000000000000084  0000000000000000   A       0     0     8
> > 
> > Hm, weird.
> 
> I have consulted some materials and found that using ALIGN() in linker
> scripts can only "increase" alignment, not decrease it.
> 
> Perhaps could you try modifying your patch to use ALIGN(2) and SUBALIGN(2)
> and see if the .notes section in the output file is aligned to 2?
> In my tests, this had no effect.
> 
> [1] https://sourceware.org/binutils/docs/ld/Forced-Output-Alignment.html

Not sure about the ld documentation (it may just be ambiguous wording)
but while doing some tests, I have found that Josh's ALIGN/SUBALIGN(4)
patch only works for certain kernel configs and fails for others.
This likely explains why Josh's patch worked for me but not for Tianyi.

I haven't investigated why or when it works though, but here's a config
where Josh's ALIGN(4) patch works and or where it doesn't (for me):
https://zealcharm.com/20230416-btf-dedup-bug-sample-configs/align-4-working
https://zealcharm.com/20230416-btf-dedup-bug-sample-configs/align-4-not-working

OTOH the new patch to discard .note.gnu.property works in both cases.
