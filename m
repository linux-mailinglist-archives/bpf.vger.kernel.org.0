Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7318A4CB151
	for <lists+bpf@lfdr.de>; Wed,  2 Mar 2022 22:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbiCBVbY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 16:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbiCBVbY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 16:31:24 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1205C12F4;
        Wed,  2 Mar 2022 13:30:40 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id em10-20020a17090b014a00b001bc3071f921so5916725pjb.5;
        Wed, 02 Mar 2022 13:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nyusHpS8EmL1VoCHpGz/00LI2WKioPnqvVUuwj+fb94=;
        b=bCIPC+IGt237jnLACRmj4g3rZLB6nirJw+6cX9ZdxeUVtQq1hD3iEhzdPM7VS3351W
         S/uwkeKqkhxUWBZuJuq1N+Uwhupzuxc+wz2/YaSFK8nTsFsTlYLjJPe7y/RyBmcx+XH9
         RKK4crAnQLdX6by3X9bWGpD4H6KctF5i+/vPxo7zxYcLpa4AAiDLDYglyaAVziC1Jm1O
         nn++D8xKXFFH1PcqydXYHCZl3C+q5pz7r5T6JS0Qh80Y6Pv/oyJee8VlhGFuAuvN1A+T
         yf7ZiPwx9k7wKJDoynJJft9iYkjlB1us/UPNAUNr4XUUqZBGcuHyD3V73mg8agYJpxn7
         lSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nyusHpS8EmL1VoCHpGz/00LI2WKioPnqvVUuwj+fb94=;
        b=minvKuBSMqXgK/+N36nb/j9XENIPpllZhjjRaqCyTQF4amKO6ttuHPmfiEVLnXWNT1
         vmBGcJ5LPxUcZEytqLjQoLN0nlL7kGcV+u4PTlQjTEwRKuce1SVd4U/t6MI/S1Y+O4Cm
         MyJHwxYBMv3kSa8OdaXG34CNmSROeZQNASe1QtT4Q1+w9yx4WnZzV8+SsAVDoTU2ae7l
         veXWnzxr1S43Un0Qhl4fJw/kDb16vm2rUW8QoOVOw3zDnCxEEz5LW14HeW+H47fYMc76
         9Q8jtqZw85mIJFqwSn4/4cTA0U65/JFXvrCpbBE4Fz2uNawNsZWVIzveDMw3e4Tp+lNf
         6o7w==
X-Gm-Message-State: AOAM532dURwXayOwK9/D9v5WpWX4E4BbzLkW29kH0k9rx4UOuFzkF/Mm
        MkQh9IdabZlWNncsveW+jhB3QU4+RILKwt9UIV4jJyTO
X-Google-Smtp-Source: ABdhPJxb0WmJSWX+kj8ZQe0C71q4wm97dExymAGgXb1TROVss43903mrcR+0YFfKcZHgdY0feLuDga0xZ/2rbclEl1E=
X-Received: by 2002:a17:903:32c1:b0:14f:8ba2:2326 with SMTP id
 i1-20020a17090332c100b0014f8ba22326mr32606268plr.34.1646256640328; Wed, 02
 Mar 2022 13:30:40 -0800 (PST)
MIME-Version: 1.0
References: <20220225234339.2386398-1-haoluo@google.com> <20220225234339.2386398-5-haoluo@google.com>
 <c323bce9-a04e-b1c3-580a-783fde259d60@fb.com>
In-Reply-To: <c323bce9-a04e-b1c3-580a-783fde259d60@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 2 Mar 2022 13:30:28 -0800
Message-ID: <CAADnVQ+q0vF03cH8w0c50XMZU1yf_0UjZ+ZarQ_RqMQrVpOFPA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 4/9] bpf: Introduce sleepable tracepoints
To:     Yonghong Song <yhs@fb.com>
Cc:     Hao Luo <haoluo@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, joshdon@google.com,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Wed, Mar 2, 2022 at 1:23 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 2/25/22 3:43 PM, Hao Luo wrote:
> > Add a new type of bpf tracepoints: sleepable tracepoints, which allows
> > the handler to make calls that may sleep. With sleepable tracepoints, a
> > set of syscall helpers (which may sleep) may also be called from
> > sleepable tracepoints.
>
> There are some old discussions on sleepable tracepoints, maybe
> worthwhile to take a look.
>
> https://lore.kernel.org/bpf/20210218222125.46565-5-mjeanson@efficios.com/T/

Right. It's very much related, but obsolete too.
We don't need any of that for sleeptable _raw_ tps.
I prefer to stay with "sleepable" name as well to
match the rest of the bpf sleepable code.
In all cases it's faultable.
