Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC8252F007
	for <lists+bpf@lfdr.de>; Fri, 20 May 2022 18:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351333AbiETQH0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 May 2022 12:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351323AbiETQHZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 May 2022 12:07:25 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CB6179C0A
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 09:07:24 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m20so968014wrb.13
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 09:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vjm4J0UEt15jqND8yu0VfF/JH1EN98mQjkeJ7hl8/Ec=;
        b=pPChiNi8weWzvtqUuLzWWN2Kgh2JKNWRx5//iF1unO8QpnGtgal2d+z5kUsLbQsqKy
         iHC3AYYDtLWRRgw2yCAySZ8Ywti0zeA2fYn2pv1Xe4XdvkmRTRyUHnRjCLoEL43VJa0g
         1J8laDrC6/zJaUOeTtGsHCUINSBHrKxQ7oXtFbZabduDuf43ww/MDXDlbez6NkDjViSO
         LsjWN1wqp7T6IXSp894JQqkMs270xetYAn1vvBHxJ++4OeXX48qWMWNLUTLtcY1aSWDJ
         pnmt8q1zLR1CrKceQKXburkrirj3qSugVm3o12bP8B2MFxjXwSKaUfM01FpwzqTdSzsH
         J+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vjm4J0UEt15jqND8yu0VfF/JH1EN98mQjkeJ7hl8/Ec=;
        b=ecLnUiqbk/F2QTVd/zY1PXoAjRJkQq2pt8bbtNtlwGnCqedHSVQtzjAzlyXtiVPvnw
         oqHEEBgzeRkE6kK1ua3upbzzlJo3DY3Ql4KOa63E0txdUDHL6HbNHbv+Nn99ShBEUwIY
         P+Rqk5L6Fbet6AY9/u2nbQHmNGXkC4J0pFL9vSnbwTKxnX86P28QrVaht5ilRmvtfaFw
         yVPzcWXtLOej5cAbvpbz32iKLlQbiPNACfAlxQ+J57ziro5fV8+RBw25Jc/hltGFlWZh
         D9czeFaCgC0qHs7ICVFhfLsKQMV6KRSDZovmc+JJSG/UOs4gc2OvczLvH3ttIItKQnng
         UGdA==
X-Gm-Message-State: AOAM530BizHYxXw7+jxV6lIheDqPcjJKiKEgdN119syZUSQIk1hGcFyz
        MnSTM/q+wBc+lgdCNByslWHn7O/sdR5/qGWF+yjjQw==
X-Google-Smtp-Source: ABdhPJyvrAp0ppwCu/vsoKM0hStCVU3p6mote7hU6XHEUMdo4mKSp8lLrUmaB2i0ZQ9fpvWW0qLPhEi2esy86EUcAKM=
X-Received: by 2002:a5d:6146:0:b0:20d:d42:e954 with SMTP id
 y6-20020a5d6146000000b0020d0d42e954mr8938736wrt.372.1653062842564; Fri, 20
 May 2022 09:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220520012133.1217211-1-yosryahmed@google.com>
 <20220520012133.1217211-3-yosryahmed@google.com> <YodCPWqZodr7Shnj@slm.duckdns.org>
 <CAJD7tkYDLc9irHLFROcYSg1shwCw+Stt5HTS08FW3ceQ5b8vqQ@mail.gmail.com>
 <20220520093607.sadvim2igfde6x22@apollo.legion> <Yod4cN+HayIDhR/c@slm.duckdns.org>
In-Reply-To: <Yod4cN+HayIDhR/c@slm.duckdns.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 20 May 2022 09:06:45 -0700
Message-ID: <CAJD7tkaPD94+61hrdr8qTV66RtfWOC+35=nGb9id_N1LrisCPA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/5] cgroup: bpf: add cgroup_rstat_updated()
 and cgroup_rstat_flush() kfuncs
To:     Tejun Heo <tj@kernel.org>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 20, 2022 at 4:16 AM Tejun Heo <tj@kernel.org> wrote:
>
> On Fri, May 20, 2022 at 03:06:07PM +0530, Kumar Kartikeya Dwivedi wrote:
> > With static noinline, the compiler will optimize away the function. With global
> > noinline, it can still optimize away the call site, but will keep the function
> > definition, so attach works. Therefore __weak is needed to ensure call is still
> > emitted. With GCC __attribute__((noipa)) might have been more appropritate, but
> > LLVM doesn't support it, so __weak is the next best thing supported by both with
> > the same side effect.

Thanks a lot for the explanation!

>
> Ah, okay, so it's to prevent compiler from optimizing away call to a noop
> function by telling it that we don't know what the function might eventually
> be. Thanks for the explanation. Yosry, can you please add a comment
> explaining what's going on?

Will add a comment explaining things in the next section.  Thanks for
reviewing this, Tejun!

>
> Thanks.
>
> --
> tejun
