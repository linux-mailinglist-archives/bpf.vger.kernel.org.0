Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A736619114
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 07:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiKDG2t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 02:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiKDG2s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 02:28:48 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2555C27FED
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 23:28:47 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id b2so10806235eja.6
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 23:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wA6aTyhHtiA49327ehnOK4qA0onh0RoDtDs47vTqAt0=;
        b=k7PsqxPcno4rY8xWVklVJaLuwjqRv9k4sGSleZo5eSZfw/rmcfkEOVtpoodzB8KrTq
         PpHf2+BRWbtxZj0Nqo5Tw/ZGL0BfP1/G30794mlCfzwV/X8oTE/sJWFtMqj16tE8qYrZ
         rNzovAjdPkwAWK4VHQcshDQa/t3Qn3xPdpeQ2MpDlhm/9YjAymBvRpBA2A0ffzcHfuJQ
         AAK+kI308dupsKzXsicXQyEXQ5DILULFud6xax31ZIFwrl2+fWEMSwxtS2sxV18Y3+do
         JcF2HO4RpAdvkJNCZ7YqbCTQMuo26J35xr4A1abyF66Lh2Ks0qoSZs7y9y8xdMC8R51Q
         /7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wA6aTyhHtiA49327ehnOK4qA0onh0RoDtDs47vTqAt0=;
        b=c4p2IgT9fsUTAabghryvkVnLC0XJxoP1wuaJNi7EIdb3MX0E88rbJlmJpsNPlibPxR
         vLAUEVFerVyhWdIcan7C0PZjN8PL2al5tYtv0StqVU8uh5SFwTpSMLRdOAYfc7xITkO4
         EixZq7F5ork1eHAWrbUHv0exfvOeNYtLqqhgOpgnx+DQezBAR5rPCnby+q8tLjdhPYCt
         az/joopyxEjBGBNLHgn0Xen2GM8s0lPqrtLZSaGK3PHExJhjPQ/YZjxHqNDPOBSIXiym
         bvaiLRsnl5CoU3JunWRpiDj004l8YOO8SEIPBVcTkGxLZSnPzD29uHWi9dhbOYB9dDEL
         cJrg==
X-Gm-Message-State: ACrzQf0FVFFpOF5xDt906M9yC34mEjg5SOutWYXY2g6CdwgF/nwzl2wz
        AtHDd89m7ADGypBYnhKoRi7HjNQ7IMMYwJHr118=
X-Google-Smtp-Source: AMsMyM5eLUP6CaTbDvhBoAFW2kzUKpyqDsu3ZOZPG4V2E1Hw5WHry2nfuTkcF50vOMUCu/3FWADd6WPqY7pT/dPIn8k=
X-Received: by 2002:a17:906:1f48:b0:7ae:77d:bac with SMTP id
 d8-20020a1709061f4800b007ae077d0bacmr11656145ejk.708.1667543325612; Thu, 03
 Nov 2022 23:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkYKmr0daXhCSkvNZYgx_rDuBaq1OExnw=AEMJ+fSzaHwg@mail.gmail.com>
In-Reply-To: <CAJD7tkYKmr0daXhCSkvNZYgx_rDuBaq1OExnw=AEMJ+fSzaHwg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 3 Nov 2022 23:28:34 -0700
Message-ID: <CAADnVQ+MgOdgQYXPWUOyqs4p7nFKtHCj_H1V_AWkYfnosy2PBg@mail.gmail.com>
Subject: Re: Question: BPF maps reliability
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 2, 2022 at 11:48 AM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> Hey everyone,
>
> TL;DR Are BPF map operations guaranteed to succeed if the map is
> configured correctly and accesses to the map do not interrupt each
> other? Can this be relied on in the future as well?
>
> I am looking into migrating some cgroup statistics we internally
> maintain to use BPF instead of in-kernel code. I am considering
> several aspects of that, including reliability. With in-kernel code
> things are really simple, we add the data structures containing the
> stats to cgroup controller struct, we update them as appropriate, and
> we export them when needed. With BPF, we need to hook progs to the
> right locations and store the stats in BPF maps (cgroup local
> storages, task local storages, hash tables, trees - in the future -)
> etc.
>
> The question I am asking here is about the reliability of such map
> operations. Looking at the code for lookups and updates for some map
> types, I can see a lot of failure cases. Looking deeper into them it
> *seems* to me like in an ideal scenario nothing should fail. By an
> ideal scenario I mean:
> - The map size is set correctly,
> - There is sufficient memory on the system,
> - We don't use the BPF maps in any progs attached to the BPF maps
> manipulation code itself,
> - We don't use the BPF maps in any progs that can interrupt each other
> (e.g. NMI context).
>
> IOW, there are no cases where we fail because two programs running in
> parallel are trying to access the same map (or map element) or because
> we couldn't acquire a resource that we don't want to wait on (that
> wouldn't result in a deadlock)., situations where we might prefer the
> caller to retry later or where we don't care about one missed
> operation.
>
> Maybe all of this is obvious and I am being paranoid, or maybe there
> are other obvious failure cases that I missed, or maybe this is just a
> dumb question, so I apologize in advance if any of this is true :)

It's a correct summary.
The reliability of map and local storage is certainly required in some cases.
The "new generation" map types with bpf_obj_new and explicit
map operation will make it easier to audit all the code when
memory allocation can fail or recursion prevention can kick in.
