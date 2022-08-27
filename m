Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB9E5A34CC
	for <lists+bpf@lfdr.de>; Sat, 27 Aug 2022 07:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbiH0FNq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Aug 2022 01:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345420AbiH0FNT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Aug 2022 01:13:19 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D43E9AA3
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 22:12:56 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w20so4284299edd.10
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 22:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=cX72LW4JrTaObKyeTtJLc3zaxO5RzOzQUM4a+/eR6hk=;
        b=S5ZIJvOX65xGOQmZBCsg5WUcIAlvraaTDWtDWBdGPE7aXYXpmIhfoad3LMi3a0n6oS
         H2fwkNcco9JJwfU22xr2e1xdPLcYkt1oMWgKCTr67OTr+8JyWqHcrWERsSufXCXgqkRd
         5e+9AREWPV+0XdRhE+3hqbxS8Dq912Vo8PJplcRQA9HQC/ZYJcnjVRaC3dkqDlbClOmD
         Q1Gqg+vi5meTBxmhPP16udFGt28sbS0HOzKSpZ40+5hPoEwdguBEC+kawv6+g3FADvFJ
         jmXE4yuAoeVsN89TYtI4bN0CkJHXw/0OrmtQscVSjACUP/gj3E4HwHR8pN/tnknoGixK
         hIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=cX72LW4JrTaObKyeTtJLc3zaxO5RzOzQUM4a+/eR6hk=;
        b=j6238ZrZcsqR6FnQwTvQB9k55EDUlSk7HxSWX2hPKRc4059qERNENI4Hw2uyY9bWxk
         o1lBBk9hGC92T4P3htkc6kIDJWiJtGuu6DssO0eF/su6KHv0vp0OOl2GPiuOEiY7frDB
         ECuZxrLi2UoktFOiIWOlm1E/rIfkSI/hwud5FGOZHPuuSYM01GVLXDOxQRPAjbFlxQnx
         /sIAHRc/LdNQ39mk+0TfVl/PxuPMVcY0HE79oSS+tYRblvu/ClG5AIflwV5RN7Kf/usM
         /l66luXWgdWehHtbOW30A2Nz1WoFiJQyU+EBBPMj+v4kWcxg4nopmTFBBVIpaAPvcn5P
         aURA==
X-Gm-Message-State: ACgBeo1Jdg1mwno97oQh+jmfYzPN/sBsfw+ucFVdnTm7oBdtuK9B5t+1
        FJrioW2Y3UaxWpzSa5ueFHN22IgI8mChr0GYueelTp6x
X-Google-Smtp-Source: AA6agR5YVVuHuZiao1Nh6YD6sFY3pZu/ZAYPD9KRwQuTOhsj/yVPK1AwNPS8xtwu9dvRgS2rCBpHkJgfimaNwM7n0CU=
X-Received: by 2002:a05:6402:10d2:b0:445:d9ee:fc19 with SMTP id
 p18-20020a05640210d200b00445d9eefc19mr8753082edu.81.1661577174803; Fri, 26
 Aug 2022 22:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220824033837.458197-1-weiyongjun1@huawei.com>
 <b942bf8f-204b-6bf1-7847-ec5f11c50ca0@isovalent.com> <CAEf4BzafSAZfhkun5PBGODw6v1s10Nh4JeH8azdqZY-62kBCKg@mail.gmail.com>
 <ee620e99-dc04-aa2c-f53b-b875dba79feb@isovalent.com>
In-Reply-To: <ee620e99-dc04-aa2c-f53b-b875dba79feb@isovalent.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 26 Aug 2022 22:12:43 -0700
Message-ID: <CAEf4BzbmaUygfMK_JZ7Q8UWNFLH-pGHJ_6LMy=M-CQOC7o2LRw@mail.gmail.com>
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

On Fri, Aug 26, 2022 at 3:45 AM Quentin Monnet <quentin@isovalent.com> wrote:
>
> Hi Andrii,
>
> On 25/08/2022 19:37, Andrii Nakryiko wrote:
> > On Thu, Aug 25, 2022 at 8:28 AM Quentin Monnet <quentin@isovalent.com> wrote:
> >>
> >> Hi Wei,
> >>
> >> Apologies for failing to answer to your previous email and for the delay
> >> on this one, I just found out GMail had classified them as spam :(.
> >>
> >> So as for your last message, yes: your understanding of my previous
> >> answer was correct. Thanks for the patch below! Some comments inline.
> >>
> >
> > Do we really want to add such a specific command to bpftool that would
> > attach BPF object files with programs of only RAW_TRACEPOINT and
> > RAW_TRACEPOINT_WRITABLE type?
> >
> > I could understand if we added something that would be equivalent of
> > BPF skeleton's auto-attach method. That would make sense in some
> > contexts, especially for some quick testing and validation, to avoid
> > writing (a rather simple) user-space loading code.
>
> Do you mean loading and attaching in a single step, or keeping the
> possibility to load first as in the current proposal?
>
> >
> > But "perf attach" for raw_tp programs only? Seem way too limited and
> > specific, just adding bloat to bpftool, IMO.
>
> We already support attaching some kinds of program types through
> "prog|cgroup|net attach". Here I thought we could add support for other
> types as a follow-up, but thinking again, you're probably right, it
> would be best if all the types were supported from the start. Wei, have
> you looked into how much work it would be to add support for
> tracepoints, k(ret)probes, u(ret)probes as well? The code should be
> mostly identical?

Are you thinking to allow to attach individual BPF programs within BPF
object, i.e., effectively bpftool as an interface to libbpf's
bpf_program__attach()?

Or you had more of BPF skeleton's auto-attach that attaches all
auto-attachable BPF programs?

>
> Quentin
>
