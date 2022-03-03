Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2D44CC5D9
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 20:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbiCCTQ5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Mar 2022 14:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiCCTQ4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 14:16:56 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D61F158D8C
        for <bpf@vger.kernel.org>; Thu,  3 Mar 2022 11:16:10 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id c4so5512495qtx.1
        for <bpf@vger.kernel.org>; Thu, 03 Mar 2022 11:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lsaEHQfA1sz4dIz7RuOmeFmwQ50xPsxwpOfXV6GcrSY=;
        b=WFhZgrwWbToo16XgHphmOomHbJQdCxEPHin71iF410pvZwItSq5Nm2njs/dGmhcbSn
         jSouYRwLqNZejipDZAyJ2kuJlJ1XNTSnrw89DVI6/fX78vv0IeoqgeZJd74pM6JfBlzS
         7Z1l6bEbCDApCjcas9a3MBSeDx9UDyIDfJqSNjtwasWUQVrJ2bcbnTaW/i6U85TRYBGK
         CUPcsg9EEObKittAM/kAsgK2XmEI2gnFcupNkEdXgo/yRrK4mEMFfTuZ9yJ5igIgf8Lq
         C8hmJgsJV/04ng4dsVVVVlHWs/e+PJPEtuHG4f6ECeu7ma3l/jZzVztpMwOJIVHgJNIi
         esRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lsaEHQfA1sz4dIz7RuOmeFmwQ50xPsxwpOfXV6GcrSY=;
        b=1ldHUut/YLbsgm5/5r7TnNg2FtlNLK6TDIu4/ykDkoAM+YmRdEvAgq+ogvX/eY/x4U
         t6fGRBkCvJa9f2PKcizzr45vpaoz/4VOR86/x5Obm2FjrRzlQB7nrti9LXWKp0L7As6i
         gZFEpHlBWpB/7JAM4jq7fmjsMZLfw8r1uJo7TdgLKu/usUNanFwE+wXYzkC5J8LWnPdl
         IwxsaXF8TnfN0ieNbaZY2f8GGj/UEGMNh/C2GgYg2skpUM+9Bdi2uAQm379suw0kRzx2
         XNfaK+soz4ZOXI2BoT76ndVNQOIzN7SjaQilb/qi0VnLv9eUchBu6UkgKzdgyG3cMorf
         C7UQ==
X-Gm-Message-State: AOAM532qWy7kdTKSAIeyvf8bJYQ9ENMKIUxOLIbSu94PAJj+lLoD3WBm
        TTstNZsbrq0JKg17YJk7PpmCxJkCGodCgc2jE110gQ==
X-Google-Smtp-Source: ABdhPJzJPCGk8ArcwoWa410V7JH5Qxelxo/TCDVm5c4FjKo3cKpoy7FtvUnKgndHbNrENPGGFBQf56Hao5X0VwJM+H8=
X-Received: by 2002:a05:622a:4d1:b0:2de:676:d2bd with SMTP id
 q17-20020a05622a04d100b002de0676d2bdmr29208228qtx.565.1646334969373; Thu, 03
 Mar 2022 11:16:09 -0800 (PST)
MIME-Version: 1.0
References: <20220225234339.2386398-1-haoluo@google.com> <20220225234339.2386398-2-haoluo@google.com>
 <7e862b1c-7818-6759-caf1-962598d2c8b3@fb.com> <CA+khW7gAEL+yBmXjWO28ns5hU4oHVZrEArfepuOfy6Q1y7VDKQ@mail.gmail.com>
 <2c5669f1-b9d9-ee78-c5ee-d29a41d4d70a@fb.com>
In-Reply-To: <2c5669f1-b9d9-ee78-c5ee-d29a41d4d70a@fb.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 3 Mar 2022 11:15:57 -0800
Message-ID: <CA+khW7h=VhCgw+gzAegu6BcNTgwHvdxh6ayueKM5qiAD+fk2Uw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/9] bpf: Add mkdir, rmdir, unlink syscalls
 for prog_bpf_syscall
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, joshdon@google.com, sdf@google.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 3, 2022 at 11:13 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 3/3/22 10:56 AM, Hao Luo wrote:
> > On Wed, Mar 2, 2022 at 12:55 PM Yonghong Song <yhs@fb.com> wrote:
> >> On 2/25/22 3:43 PM, Hao Luo wrote:
> >>> @@ -5086,6 +5086,29 @@ union bpf_attr {
> >>>     *  Return
> >>>     *          0 on success, or a negative error in case of failure. On error
> >>>     *          *dst* buffer is zeroed out.
> >>> + *
> >>> + * long bpf_mkdir(const char *pathname, int pathname_sz, u32 mode)
> >>
> >> Can we make pathname_sz to be u32 instead of int? pathname_sz should
> >> never be negative any way.
> >>
> >> Also, I think it is a good idea to add 'u64 flags' parameter for all
> >> three helpers, so we have room in the future to tune for new use cases.
> >>
> >
> > SG. Will make this change.
> >
> > Actually, I think I need to cap patthname_sz from above, to ensure
> > pathname_sz isn't too big. Is that necessary? I see there are other
> > helpers that don't have this type of check.
>
> There is no need. The verifier should ensure the memory held by pathname
> will have at least size of pathname_sz.
>

SG. Thanks!
