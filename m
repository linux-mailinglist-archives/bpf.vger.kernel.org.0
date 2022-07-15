Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834A0575938
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 03:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiGOBvF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 21:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiGOBvE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 21:51:04 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CE226AF8
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 18:51:03 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id y14-20020a17090a644e00b001ef775f7118so10261296pjm.2
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 18:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T8putrVdgRM6VhB6LeVI64HYfGKLv8EZd6vcutbeUog=;
        b=c6/GdjXN/g896Az6Ipx7svxe4eZyBtWhGJBu2FkaPDjEJAvdljn30lrN2f6bPtaTT7
         1IbomU/D5Z0ABI07KeP7CHCHgSMTorrktajnzLU40VE3r6E7hxioOtXD4mWdVhjBRoac
         m7cglrzs7i1c+x+WsI0flt1ACk98rJA4nnOm1DMrlTcgno2tUOnud0n5xU9nLyX9tg1M
         5a/C3GopmgbFqfvA1OL6gCQxKQFH3TyBU4TzbndWKIwxMDsKM6iLZF/1a8zYI/Tr2UyC
         GPMvsbSDj7A54GT9TVpnqyllxjUyS3YXhDFXngBzfIu+LNTDKQ5Ep5JbajXAA3mCmA3+
         uR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T8putrVdgRM6VhB6LeVI64HYfGKLv8EZd6vcutbeUog=;
        b=Sau9+hdiQr42XkgVNgZNEfubs+oU6imLPpelBZ4BHte4evpX92b8DOv6jEGsYRkiJz
         JlLERNvSMmZxQHXhrxez93vD+4lo8A4YsQLert52YmvRcdRvtGgvBSex5dTrUBZSan26
         RRej3Maw7yBycIKh0Ix0ieXaq0uOj3SmgAIPLR7AtgyRATqkmhRfNExgWkWa7eM08EL8
         36yeG0zvqrMIiuFtzMlu2gIi3Bx4s4zTb6y2qfoMCYhveWLGa6aB27mjuN9FCrg0TIjq
         IEyq/ldYYDBGSnUAp3CIlMxy6Fm+pe6dARX/PjPTaBi8kNzQuzDACHb/zUAdOrmJMyad
         0Wkg==
X-Gm-Message-State: AJIora9h5vFCSMRKUPNyHaKIx0i4RJLTy4903oizTHRNPJ41IBY9jwKH
        fmiU8PT4+Yxbz66BGXafaC8=
X-Google-Smtp-Source: AGRyM1saFq274rrCAOj4Kbj5IASMvV4pLjZGn8KOLEiopphyXqj7Buo4Sl/Pa2IgrCtTAS39JAGNoA==
X-Received: by 2002:a17:902:db11:b0:16c:3e90:12e5 with SMTP id m17-20020a170902db1100b0016c3e9012e5mr10957707plx.73.1657849863369;
        Thu, 14 Jul 2022 18:51:03 -0700 (PDT)
Received: from MacBook-Pro-3.local ([2620:10d:c090:500::1:697a])
        by smtp.gmail.com with ESMTPSA id m5-20020a63f605000000b003fbb455040dsm2022062pgh.84.2022.07.14.18.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 18:51:02 -0700 (PDT)
Date:   Thu, 14 Jul 2022 18:51:00 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "sdf@google.com" <sdf@google.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH RFC bpf-next 0/3] Execution context callbacks
Message-ID: <20220715015100.p7fwr7dbjyfbjjad@MacBook-Pro-3.local>
References: <cover.1657576063.git.delyank@fb.com>
 <Ys24W4RJS0BAfKzP@google.com>
 <3a6294a44dfec84b3efbdebed6a0d8d9c5874815.camel@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a6294a44dfec84b3efbdebed6a0d8d9c5874815.camel@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 12, 2022 at 06:42:52PM +0000, Delyan Kratunov wrote:
> 
> > but have you though of maybe initially supporting something like:
> > 
> > bpf_timer_init(&timer, map, SOME_NEW_DEFERRED_NMI_ONLY_FLAG);
> > bpf_timer_set_callback(&timer, cg);
> > bpf_timer_start(&timer, 0, 0);
> > 
> > If you init a timer with that special flag, I'm assuming you can have
> > special cases in the existing helpers to simulate the delayed work?
> 
> Potentially but I have some reservations about drawing this equivalence.

hrtimer api has various: flags. soft vs hard irq, pinned and not.
So the suggestion to treat irq_work callback as special timer flag
actually fits well.

bpf_timer_init + set_callback + start can be a static inline function
named bpf_work_submit() in bpf_helpers.h
(or some new file that will mark the beginning libc-bpf library).
Reusing struct bpf_timer and adding zero-delay callback could probably be
easier for users to learn and consume.

Separately:
+struct bpf_delayed_work {
+       __u64 :64;
+       __u64 :64;
+       __u64 :64;
+       __u64 :64;
+       __u64 :64;
+} __attribute__((aligned(8)));
is not extensible.
It would be better to add indirection to allow kernel side to grow
independently from amount of space consumed in a map value.

Can you think of a way to make irq_work/sleepable callback independent of maps?
Assume bpf_mem_alloc is already available and NMI prog can allocate a typed object.
The usage could be:
struct my_work {
  int a;
  struct task_struct __kptr_ref *t;
};
void my_cb(struct my_work *w);

struct my_work *w = bpf_mem_alloc(allocator, bpf_core_type_id_local(*w));
w->t = ..;
bpf_submit_work(w, my_cb, SLEEPABLE | IRQ_WORK);

Am I day dreaming? :)
