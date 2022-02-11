Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF6B4B1CD4
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 04:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiBKDIP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Feb 2022 22:08:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245120AbiBKDIN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Feb 2022 22:08:13 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA35DBC1
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 19:08:12 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id l19so8015715pfu.2
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 19:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MlhPE+pComRUNWepO2amkpvh8/OxaWeAGui2AE+S9RA=;
        b=pnyuol1APGSicitz7maGtMlw7Ks+J+4j/3CA+rfFC5IXqNkZLkjJB+i3FsuAixM/Dr
         2ahI7Pj3xHciJ3E0ko5viPZn2KOl945Mc5bBRssM8iUacIRCqj4KhsYCUKPy9WJqt1Ks
         BLqCVxtzxQMpubqZGSroazPGI/wPLGoR+G8+N6dSiwi1/le791oaNAQTjbhE7YVqyT3n
         Mn9VWXJTB4OccbSX37JlApeTYju6zIpdC9S/Ij1qzKseTmE0gJDAkL+1nwZJaEPX0HfH
         kTRO/bxVHOOWt94JPxNhE2IBgw0ok+hl1JU7Nn1ShTLYFlrgjp9j+yfV+gTWFNLka9aA
         nVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MlhPE+pComRUNWepO2amkpvh8/OxaWeAGui2AE+S9RA=;
        b=upBM3F0LmYBMo2bqiQgG0iLKjkg2M5TJPb9wg9S2u29ru5o0eEXhpYFFcwUOL72lMi
         qUOybQ16ciRFieA5EbLxh0EoyF4lKvAoR4VMtSX83F/mARs/zeklaVNmSpx9Q3SjL5t3
         d+33HADbdHybtN+2gdwLB8bblm7dZvQqc2yPMDeWDnljRP76u5js5SZIbEm7da2N1FBg
         FyM0bw+KY8mj9/bR7eo4bvO6kXQYt3u8kgBr2/YTp8ufT7mANVdCqfQv6iYQQuRURsHc
         fQp0CyM5ACJ19Oum8id7nB0jq0f/5O6/e4DOO8+VX/W42pqvRttsa0zW6RDlrBJxxBP7
         GTJw==
X-Gm-Message-State: AOAM533JCe59mnu1TNcikrcEIppJ4CdDGX5utzaOEcVPN9vcrS503t0C
        FbBBC6+zfr3e47i5qzwvrGEfuHB+WQnsmxNWac1rX5em
X-Google-Smtp-Source: ABdhPJx3+tYR0/gkLm5bZcLL0ZqxcRO2fuFXL6rMniHA6kSt44wG2ei771Ce5AH6M0SDrKtrvhZkk9XYc+E2WzZjNto=
X-Received: by 2002:aa7:8018:: with SMTP id j24mr10414418pfi.59.1644548892167;
 Thu, 10 Feb 2022 19:08:12 -0800 (PST)
MIME-Version: 1.0
References: <df69012695c7094ccb1943ca02b4920db3537466.1644421921.git.fmaurer@redhat.com>
 <cd545202-d948-2ce5-dfae-362822766f90@fb.com> <f18b9e66-8494-f335-13cc-a9b30a90e32e@redhat.com>
 <22d98cc5-26fa-8023-3a85-a082a9e08147@fb.com>
In-Reply-To: <22d98cc5-26fa-8023-3a85-a082a9e08147@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 10 Feb 2022 19:08:01 -0800
Message-ID: <CAADnVQ+T8j4sBX=URhSS19oNtnCVtCVirXC-+ZrNEJjv4hRUyA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Do not try bpf_msg_push_data with len 0
To:     Yonghong Song <yhs@fb.com>
Cc:     Felix Maurer <fmaurer@redhat.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 10, 2022 at 10:05 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 2/10/22 7:45 AM, Felix Maurer wrote:
> > On 09.02.22 18:06, Yonghong Song wrote:
> >> On 2/9/22 7:55 AM, Felix Maurer wrote:
> >>> If bpf_msg_push_data is called with len 0 (as it happens during
> >>> selftests/bpf/test_sockmap), we do not need to do anything and can
> >>> return early.
> >>>
> >>> Calling bpf_msg_push_data with len 0 previously lead to a wrong ENOMEM
> >>> error: we later called get_order(copy + len); if len was 0, copy + len
> >>> was also often 0 and get_order returned some undefined value (at the
> >>> moment 52). alloc_pages caught that and failed, but then
> >>> bpf_msg_push_data returned ENOMEM. This was wrong because we are most
> >>> probably not out of memory and actually do not need any additional
> >>> memory.
> >>>
> >>> v2: Add bug description and Fixes tag
> >>>
> >>> Fixes: 6fff607e2f14b ("bpf: sk_msg program helper bpf_msg_push_data")
> >>> Signed-off-by: Felix Maurer <fmaurer@redhat.com>
> >>
> >> LGTM. I am wondering why bpf CI didn't catch this problem. Did you
> >> modified the test with length 0 in order to trigger that? If this
> >> is the case, it would be great you can add such a test to the
> >> test_sockmap.
> >
> > I did not modify the tests to trigger that. The state of the selftests
> > around that is unfortunately not very good. There is no explicit test
> > with length 0 but bpf_msg_push_data is still called with length 0,
> > because of what I consider to be bugs in the test. On the other hand,
> > explicit tests with other lengths are sometimes not called as well. I'll
> > elaborate on that in a bit.
> >
> > Something easy to fix is that the tests do not check the return value of
> > bpf_msg_push_data which they probably should. That may have helped find
> > the problem earlier.
> >
> > Now to the issue mentioned in the beginning: Only some of the BPF
> > programs used in test_sockmap actually call bpf_msg_push_data. However,
> > they are not always attached, just for particular scenarios:
> > txmsg_pass==1, txmsg_redir==1, or txmsg_drop==1. If none of those apply,
> > bpf_msg_push_data is never called. This happens for example in
> > test_txmsg_push. Out of the four defined tests only one actually calls
> > the helper.
> >
> > But after a test, the parameters in the map are reset to 0 (instead of
> > being removed). Therefore, when the maps are reused in a subsequent test
> > which is one of the scenarios above, the values are present and
> > bpf_msg_push_data is called, albeit with the parameters set to 0. This
> > is also what triggered the wrong behavior fixed in the patch.
> >
> > Unfortunately, I do not have the time to fix these issues in the test at
> > the moment.
>
> Thanks for detailed explanation. Maybe for the immediate case, can you
> just fix this in the selftest,
>
>    > Something easy to fix is that the tests do not check the return
> value of
>    > bpf_msg_push_data which they probably should. That may have helped find
>    > the problem earlier.
>
> This will be enough to verify your kernel change as without it the
> test will fail.
>
> The rest of test improvements can come later.

John,
what is your take on this fix?
bpf tree material?
