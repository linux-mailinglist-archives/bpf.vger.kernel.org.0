Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC18C4B1E97
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 07:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbiBKGeF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 01:34:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244565AbiBKGeF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 01:34:05 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE78E56
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 22:34:04 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id z7so6169652ilb.6
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 22:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=m1DAp8PpK9HJkpCo7yTOCPf7Sx31QsT/5cMRfiv3pAs=;
        b=Hap+FerT8BsT/vJE2cj52zyZ9lGi6bfChLjvK5pMpNnAsVARsm/MwtBjyunEWrQtxu
         EmeW4ZcKzdmn9o7ANAyDlKQLn1TG+kyu2GV0nfeUtvNTIbQ9zc61gMx47zB5THQ9pIg/
         ClFiopawdlwLSs/S8/AiS9UNCECuTdF83f514Gm5Zd8dO758zoVbtSq8R2LEgxYwhkdj
         CkB/K+vN9wtWA6lN1/YaAYA2tqRLETYneYPwHtreur3klY4WSW4ymk+2pLsMHaK8LXlc
         B4E95z+VOBfE5KSofBAZMueAkYcMPJCzKbJMUvHgRGBw6el7jhGSnuaJX5rYDBcSqSgj
         RyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=m1DAp8PpK9HJkpCo7yTOCPf7Sx31QsT/5cMRfiv3pAs=;
        b=SqHezar3r8pip/cM1pmOA66fCcTysJjArQXNO5Rs0I5EYCODq0twHpD5xuzV04bOwW
         BahHjvvg9O6WzLCZwfk/yKNOkV5Ql3CKqn5l3+/Xk4fxyV5aJ58aNu2shEM/BZUaMxaw
         bPs9tbbliz5HFdML14ohuzRTB1LyUIVj8gFGpQq9Mi1wLDV3z34RsXrJ3ga8w0LDcM2O
         uPGBbL36EHgi+hCKPGZ55FbpFPfDrfnHo/SLgSqbKlfUZHycP3tSqpo9ldhfTEnW2OVJ
         qA2AaNDxjGijeFyAFsCrC99m6aa05Swe3sHa2ubJIExMvH7m2eqSq5GFO95Ehh/6fiUI
         DUfQ==
X-Gm-Message-State: AOAM532jT72wZuS9eQJIZAoV7/qwzoP+0ukMSf0+yG4vW2TpyWfcvBX8
        XCkp9N3XPMf08pTyczfqhqo=
X-Google-Smtp-Source: ABdhPJx2Wpitqk7wLqksDDz77QZ1nKVVN25xsvdIWFZ7rzxh/BOImafB0IgE/6cZ+IIOhMrgnICy9A==
X-Received: by 2002:a92:c24c:: with SMTP id k12mr197804ilo.45.1644561243934;
        Thu, 10 Feb 2022 22:34:03 -0800 (PST)
Received: from localhost ([99.197.200.79])
        by smtp.gmail.com with ESMTPSA id l7sm12033150ilv.75.2022.02.10.22.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 22:34:03 -0800 (PST)
Date:   Thu, 10 Feb 2022 22:33:55 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song <yhs@fb.com>
Cc:     Felix Maurer <fmaurer@redhat.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Message-ID: <620603531daa4_ad36d208b6@john.notmuch>
In-Reply-To: <CAADnVQ+T8j4sBX=URhSS19oNtnCVtCVirXC-+ZrNEJjv4hRUyA@mail.gmail.com>
References: <df69012695c7094ccb1943ca02b4920db3537466.1644421921.git.fmaurer@redhat.com>
 <cd545202-d948-2ce5-dfae-362822766f90@fb.com>
 <f18b9e66-8494-f335-13cc-a9b30a90e32e@redhat.com>
 <22d98cc5-26fa-8023-3a85-a082a9e08147@fb.com>
 <CAADnVQ+T8j4sBX=URhSS19oNtnCVtCVirXC-+ZrNEJjv4hRUyA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Do not try bpf_msg_push_data with len 0
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov wrote:
> On Thu, Feb 10, 2022 at 10:05 AM Yonghong Song <yhs@fb.com> wrote:
> >
> >
> >
> > On 2/10/22 7:45 AM, Felix Maurer wrote:
> > > On 09.02.22 18:06, Yonghong Song wrote:
> > >> On 2/9/22 7:55 AM, Felix Maurer wrote:
> > >>> If bpf_msg_push_data is called with len 0 (as it happens during
> > >>> selftests/bpf/test_sockmap), we do not need to do anything and can
> > >>> return early.
> > >>>
> > >>> Calling bpf_msg_push_data with len 0 previously lead to a wrong ENOMEM
> > >>> error: we later called get_order(copy + len); if len was 0, copy + len
> > >>> was also often 0 and get_order returned some undefined value (at the
> > >>> moment 52). alloc_pages caught that and failed, but then
> > >>> bpf_msg_push_data returned ENOMEM. This was wrong because we are most
> > >>> probably not out of memory and actually do not need any additional
> > >>> memory.
> > >>>
> > >>> v2: Add bug description and Fixes tag
> > >>>
> > >>> Fixes: 6fff607e2f14b ("bpf: sk_msg program helper bpf_msg_push_data")
> > >>> Signed-off-by: Felix Maurer <fmaurer@redhat.com>
> > >>
> > >> LGTM. I am wondering why bpf CI didn't catch this problem. Did you
> > >> modified the test with length 0 in order to trigger that? If this
> > >> is the case, it would be great you can add such a test to the
> > >> test_sockmap.
> > >
> > > I did not modify the tests to trigger that. The state of the selftests
> > > around that is unfortunately not very good. There is no explicit test
> > > with length 0 but bpf_msg_push_data is still called with length 0,
> > > because of what I consider to be bugs in the test. On the other hand,
> > > explicit tests with other lengths are sometimes not called as well. I'll
> > > elaborate on that in a bit.
> > >
> > > Something easy to fix is that the tests do not check the return value of
> > > bpf_msg_push_data which they probably should. That may have helped find
> > > the problem earlier.
> > >
> > > Now to the issue mentioned in the beginning: Only some of the BPF
> > > programs used in test_sockmap actually call bpf_msg_push_data. However,
> > > they are not always attached, just for particular scenarios:
> > > txmsg_pass==1, txmsg_redir==1, or txmsg_drop==1. If none of those apply,
> > > bpf_msg_push_data is never called. This happens for example in
> > > test_txmsg_push. Out of the four defined tests only one actually calls
> > > the helper.
> > >
> > > But after a test, the parameters in the map are reset to 0 (instead of
> > > being removed). Therefore, when the maps are reused in a subsequent test
> > > which is one of the scenarios above, the values are present and
> > > bpf_msg_push_data is called, albeit with the parameters set to 0. This
> > > is also what triggered the wrong behavior fixed in the patch.
> > >
> > > Unfortunately, I do not have the time to fix these issues in the test at
> > > the moment.
> >
> > Thanks for detailed explanation. Maybe for the immediate case, can you
> > just fix this in the selftest,
> >
> >    > Something easy to fix is that the tests do not check the return
> > value of
> >    > bpf_msg_push_data which they probably should. That may have helped find
> >    > the problem earlier.
> >
> > This will be enough to verify your kernel change as without it the
> > test will fail.
> >
> > The rest of test improvements can come later.
> 
> John,
> what is your take on this fix?

Fix looks good its nice to return 0 here instead of ENOMEM as a result
of paticulars of passing 0 to get_order(). Ack for me.

> bpf tree material?

I checked our code here and we would never pass '0' to pull data. Its hard
to imagine what type of code would do that, but on the other hand its a
bug and its only rc3... I've no strong opinion if I wrote the patch I would
have pointed it at bpf tree so slight preference to push it as a fix.

Acked-by: John Fastabend <john.fastabend@gmail.com>
