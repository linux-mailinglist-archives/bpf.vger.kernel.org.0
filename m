Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E489F5A18DA
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 20:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbiHYShu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 14:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238683AbiHYSht (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 14:37:49 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42A28E0EA
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 11:37:48 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id w19so41256161ejc.7
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 11:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=9qQ8ZmlxfyXw+EtrhkezKCshSnI/4a41yn2NAFgScQY=;
        b=G9iJ+8vqn7V99++Y793JRJaw8Wh9txn4QnYk+0S7mhIFoXTe+1dMk/StuluDEbpw0y
         7jh74BaSbL6OMuqjq9fx0++h2zz47X/ICZ/cqr38EOBeWJcX20I7UW83RWu2VoLEIawc
         ZP8Za6i7Ox2KGyDA00jaEOX/39xNqZG3hMFqhFxQBV2KaszIS1rYCci5h9Zby411JUSB
         LVnrFwBeJBdzsp/YJ6hSO5Iw7ANWJ5Q5xLS8eVu3L857UDMJc5VPUIBeO4dChxXeRAET
         9jxEEaAgK8no9JzgaIXg1ZuhseFyxQ2qmG1xDjmJet5YxKUWWD9g+0vRb82Y+q0OYzH3
         1zQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9qQ8ZmlxfyXw+EtrhkezKCshSnI/4a41yn2NAFgScQY=;
        b=oyfKsqpF+3aeVlmpecP7mg0B8kPI87Q0VYT++IhF5hbZq8pSLOlxcej7yLhu/9dO/H
         4shz+mcGfPBKvkm37yjCYxAEGjtAZLK6m4EhgjzPeqsV6yOjejjzxYYGfoqMvQfhjG+r
         ysQwjN5Fihjnb3lcXiQrMP6lahmFFzCByWacgxtq5OpXiJrtGPaJ6nMni9eEHs+3jew7
         IWqJhjcgHnGZAcdI4+JUEpqkmmWzyn/yOUPWJvOYuY/+SWA1p9JVi3gKWFHemjIDNrkv
         E1MrvcG5uXQeQfws4BnxN3PD9rlMcR+YcMjo7RPHn6EUqqxf4n5vHJ5H5yf9VEbvy5co
         BZDg==
X-Gm-Message-State: ACgBeo2r//HuUoWVhWyM8CbLnnktWx2VPf92pTPhlxWWwghZNQQp3AKD
        kJoVDzETWXSerD046x/tbFzzeu5nERzl3fvJ01Y=
X-Google-Smtp-Source: AA6agR73CQy1Soss7aKsshp859yAlbxC065TUXOBrNA6+rmSejKdzfEliLpffi4b9SLxYbJ6MPEn32pa15Z4u9a5oPc=
X-Received: by 2002:a17:906:99c5:b0:73d:70c5:1a4f with SMTP id
 s5-20020a17090699c500b0073d70c51a4fmr3207460ejn.302.1661452667222; Thu, 25
 Aug 2022 11:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220824033837.458197-1-weiyongjun1@huawei.com> <b942bf8f-204b-6bf1-7847-ec5f11c50ca0@isovalent.com>
In-Reply-To: <b942bf8f-204b-6bf1-7847-ec5f11c50ca0@isovalent.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Aug 2022 11:37:35 -0700
Message-ID: <CAEf4BzafSAZfhkun5PBGODw6v1s10Nh4JeH8azdqZY-62kBCKg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpftool: implement perf attach command
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
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

On Thu, Aug 25, 2022 at 8:28 AM Quentin Monnet <quentin@isovalent.com> wrote:
>
> Hi Wei,
>
> Apologies for failing to answer to your previous email and for the delay
> on this one, I just found out GMail had classified them as spam :(.
>
> So as for your last message, yes: your understanding of my previous
> answer was correct. Thanks for the patch below! Some comments inline.
>

Do we really want to add such a specific command to bpftool that would
attach BPF object files with programs of only RAW_TRACEPOINT and
RAW_TRACEPOINT_WRITABLE type?

I could understand if we added something that would be equivalent of
BPF skeleton's auto-attach method. That would make sense in some
contexts, especially for some quick testing and validation, to avoid
writing (a rather simple) user-space loading code.

But "perf attach" for raw_tp programs only? Seem way too limited and
specific, just adding bloat to bpftool, IMO.

> On 24/08/2022 04:38, Wei Yongjun wrote:
> > This patch introduces a new bpftool command: perf attach,
> > which used to attaching/pinning tracepoints programs.
> >
> >   bpftool perf attach PROG TP_NAME FILE
> >
> > It will attach bpf program PROG to tracepoint TP_NAME and
> > pin tracepoint program as FILE, FILE must be located in
> > bpffs mount.
> >

[...]
