Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F9259D03F
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 06:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238337AbiHWEu3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 00:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239829AbiHWEu0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 00:50:26 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F45742AF1
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 21:50:25 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gi31so18644047ejc.5
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 21:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=GXcJiqy+AjhlJ/fiPR3W5nhZF/5+XHe0GqIYOBdaB28=;
        b=JuGXVZew6W8HSfbAwsmwIhzd5lP5kdCo3dSxaZtczbApeOXcQHWj9XwnqIEnaHOMMx
         +vh12EN8nL8LuV/tG8zLNtSu1d4dXJcsJNwZSXyETzkL7XVg8E2o6ADGoVJHgh4M4nRY
         pGDCxfEK1zvB3v/H4fVIzj3BywYpI1CpilgQT4x4AGyM50ZiQ2wZ/z3oZeJrOBBlqSrm
         3nfyJozg+bu/PHBcSpQjroUECT/LyYnASNiX2pgS4yD55wQazn2IeR+NPAWcYEsHWsWP
         SHA79bfrd+wq8D3yzavX6SCkD8GlV2x3g46ZvtuFTwZqdCKj0wBJ9LVX1ZyF+V5NmXdT
         RF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=GXcJiqy+AjhlJ/fiPR3W5nhZF/5+XHe0GqIYOBdaB28=;
        b=VjykqVaxCyREwPUFAYA77cw6kni9RuUAit+Qg83qAq8+rkUkB9mKQoTuF09rgrYc+L
         7t1SoHI0ltikNzu+tWJSPDCS4rnfKmWU9lzrdW4eMwgW/uTmP7UgOKltthR022YMCSp5
         2P+8/T66bgNX7XJ71zMjuRw+Jqfl+JNJyFEDlKC2AQwt1fn6Jc67HUDtSU0VDg2mDjdf
         gSitkBY8Au3AzOL+1O6jvLr2t4Ym2xhTSZtIng2SkKTgmBL+2EjFcvxl+eYAQ9t9JX8Z
         syac6ipLWW1/kZkYexNVvnqqmZ8X4jCfnKmWVjoCWzmlWSbTytmqC7cVoaLzfCKV7ulC
         /EVA==
X-Gm-Message-State: ACgBeo2BuGRGrl0J81pNdS5Ke1fNGdVdeniPbzzS7vJQ9UjZVxkBgqB1
        jbnsyQMcDWM+ZdSHGkYxVh7VTtbmJmD2709AWLc=
X-Google-Smtp-Source: AA6agR6a3ZRjACiADob9f836JwXyDEEMTFm9Z9JzWgvL+JjV0m3y+oXzwycuETt8jb8R0mNv9fSaoP6So/uBiYzH8oU=
X-Received: by 2002:a17:906:a089:b0:72f:826b:e084 with SMTP id
 q9-20020a170906a08900b0072f826be084mr15776460ejy.708.1661230223602; Mon, 22
 Aug 2022 21:50:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220821033223.2598791-1-houtao@huaweicloud.com>
 <20220821033223.2598791-2-houtao@huaweicloud.com> <CA+khW7jv6J9FSqNvaHNzYNpEBoQX6wPEEdoD4OwkPQt844Wwmw@mail.gmail.com>
 <3287b95c-30e1-5647-fe2c-1feff673291d@huaweicloud.com> <CA+khW7h1OK2oqGyCipGfySV_kcHW4=SHo6123nk2WTTXMOMUxQ@mail.gmail.com>
 <387c851f-03ae-9b34-4ec0-9667fb26ec18@huaweicloud.com> <CA+khW7jgvZR8azSE3gEJvhT_psgEeHCdU3uWAQUkkKFLgh0a4Q@mail.gmail.com>
 <CA+khW7iv+zX0XzC++i-F7QZju9QGufh6+SVN3JWp9WyJe2qhMg@mail.gmail.com>
 <CAADnVQ+udaAy5OZ-BXpfeQZdPRHD6F+FUD7KxJfxcjiyvh2Dsg@mail.gmail.com> <67c5da0b-e5af-0934-6e17-1c43d0f96165@huaweicloud.com>
In-Reply-To: <67c5da0b-e5af-0934-6e17-1c43d0f96165@huaweicloud.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 22 Aug 2022 21:50:12 -0700
Message-ID: <CAADnVQ+nd3p0=nNoa4kKOXgAbscm+k0EQeSupwF2Rs3vhftTAQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] bpf: Disable preemption when increasing per-cpu map_locked
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Hao Sun <sunhao.th@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, Hou Tao <houtao1@huawei.com>
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

On Mon, Aug 22, 2022 at 7:57 PM Hou Tao <houtao@huaweicloud.com> wrote:
>
> Hi,
>
> On 8/23/2022 9:29 AM, Alexei Starovoitov wrote:
> > On Mon, Aug 22, 2022 at 5:56 PM Hao Luo <haoluo@google.com> wrote:
> >>
> SNIP
> >> Tao, thanks very much for the test. I played it a bit and I can
> >> confirm that map_update failures are seen under CONFIG_PREEMPT. The
> >> failures are not present under CONFIG_PREEMPT_NONE or
> >> CONFIG_PREEMPT_VOLUNTARY. I experimented with a few alternatives I was
> >> thinking of and they didn't work. It looks like Hou Tao's idea,
> >> promoting migrate_disable to preempt_disable, is probably the best we
> >> can do for the non-RT case. So
> > preempt_disable is also faster than migrate_disable,
> > so patch 1 will not only fix this issue, but will improve performance.
> >
> > Patch 2 is too hacky though.
> > I think it's better to wait until my bpf_mem_alloc patches land.
> > RT case won't be special anymore. We will be able to remove
> > htab_use_raw_lock() helper and unconditionally use raw_spin_lock.
> > With bpf_mem_alloc there is no inline memory allocation anymore.
> OK. Look forwards to the landing of BPF specific memory allocator.
> >
> > So please address Hao's comments, add a test and
> > resubmit patches 1 and 3.
> > Also please use [PATCH bpf-next] in the subject to help BPF CI
> > and patchwork scripts.
> Will do. And to bpf-next instead of bpf ?

bpf-next is almost always prefered for fixes for corner
cases that have been around for some time.
bpf tree is for security and high pri fixes.
bpf-next gives time for fixes to prove themselves.
