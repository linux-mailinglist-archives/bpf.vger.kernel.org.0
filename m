Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89424CB50E
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 03:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbiCCCac (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 21:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbiCCCab (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 21:30:31 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C46D3EF3C;
        Wed,  2 Mar 2022 18:29:47 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id z12-20020a17090ad78c00b001bf022b69d6so2432055pju.2;
        Wed, 02 Mar 2022 18:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t11rGjeJbaPKo4iIzfdlK+BfedmdNwblLmmUNHyIl/s=;
        b=LaBwsIw262WVf/mDTL0709lGkwF46Jcxad+J+nwwx7JjWd4qP096eOqaCM2VAmSIht
         wGxm4Dsv9k9gRui1sH4PxWNSfMr07ZeSTBdu1yvsxFYMayiLCpAJGOXhwznx97zPCd2W
         1t93LsQ18l0E1hu4RqFZVvUk1p86GbTKRhnUeH8akfZt/XrDqNqDkrZzcOipXqJ+L7ml
         uIVGnzLKp3MVN2HSwJwj+7wpJxJiyPXq4Gi12UuFMWI8IOxJkUUBRD2AkEogjNA0i68d
         4BpnbqaKb2RkRn1asKsRKgctWPsFugfnLi8nIQ9HUAfJDJzzJrhcSFNGHxuV2Zed0enA
         0qTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t11rGjeJbaPKo4iIzfdlK+BfedmdNwblLmmUNHyIl/s=;
        b=mQoPCob4Vj1yweEyvBDCP5q2qtkq++HQfSMtCjgelS2ECRD9k6oiIeRz44yY6kDumr
         I/KaOHo8HP5WQTyRZHhCqGqOTOGVKvIYSx3MbgxsA+6fOWw38Va3Z4IEAJiEGRc5V3sb
         YNC4U+B/zFMRXqO4c4qSquCRA2+AjDEI8pu7KaVUGsHIiV85CzJjfMqPG2O1EWTNmqXT
         Mc9lnyxpp/xcfItQyaB5KfVmaSqnbd+qMJUY+b2upW7ZmftqtrcVraXudYYahhQkffu5
         09brjf4FUUHSzt2quyJwIrbA9VJFLHllEpQ5dHky7WOhx+Ym7EKA9ZjlWtLi74N/H9NB
         pKiQ==
X-Gm-Message-State: AOAM532n0/RKzPPrqxiA99a2ilNmiwA/dWG2ay35cli26MaWCFV3lwxB
        c9vIHzh1qKCGdKlVuSK4RbdU9lVqwwaHvli/JgGe60Cm
X-Google-Smtp-Source: ABdhPJy+6x4bAj139bTUUQWuKIgLLPNL9DSC9ipZnEz5zg+b/vDIpT/n1lv2gwAmOJsh8qZWpnxAfkTDbypHY+zBp3E=
X-Received: by 2002:a17:902:76c5:b0:14e:e325:9513 with SMTP id
 j5-20020a17090276c500b0014ee3259513mr33748266plt.55.1646274586726; Wed, 02
 Mar 2022 18:29:46 -0800 (PST)
MIME-Version: 1.0
References: <20220225234339.2386398-1-haoluo@google.com> <20220225234339.2386398-5-haoluo@google.com>
 <c323bce9-a04e-b1c3-580a-783fde259d60@fb.com> <CAADnVQ+q0vF03cH8w0c50XMZU1yf_0UjZ+ZarQ_RqMQrVpOFPA@mail.gmail.com>
 <93c3fc30-ad38-96fa-cf8e-20e55b267a3b@fb.com>
In-Reply-To: <93c3fc30-ad38-96fa-cf8e-20e55b267a3b@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 2 Mar 2022 18:29:35 -0800
Message-ID: <CAADnVQL4yxhDCLjvCCmpOtg0+8-HSg32KG07TCxx+L+Gji7n6g@mail.gmail.com>
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
        Tejun Heo <tj@kernel.org>, Josh Don <joshdon@google.com>,
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

On Wed, Mar 2, 2022 at 5:09 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 3/2/22 1:30 PM, Alexei Starovoitov wrote:
> > On Wed, Mar 2, 2022 at 1:23 PM Yonghong Song <yhs@fb.com> wrote:
> >>
> >>
> >>
> >> On 2/25/22 3:43 PM, Hao Luo wrote:
> >>> Add a new type of bpf tracepoints: sleepable tracepoints, which allows
> >>> the handler to make calls that may sleep. With sleepable tracepoints, a
> >>> set of syscall helpers (which may sleep) may also be called from
> >>> sleepable tracepoints.
> >>
> >> There are some old discussions on sleepable tracepoints, maybe
> >> worthwhile to take a look.
> >>
> >> https://lore.kernel.org/bpf/20210218222125.46565-5-mjeanson@efficios.com/T/
> >
> > Right. It's very much related, but obsolete too.
> > We don't need any of that for sleeptable _raw_ tps.
> > I prefer to stay with "sleepable" name as well to
> > match the rest of the bpf sleepable code.
> > In all cases it's faultable.
>
> sounds good to me. Agree that for the bpf user case, Hao's
> implementation should be enough.

Just remembered that we can also do trivial noinline __weak
nop function and mark it sleepable on the verifier side.
That's what we were planning to do to trace map update/delete ops
in Joe Burton's series.
Then we don't need to extend tp infra.
I'm fine whichever way. I see pros and cons in both options.
