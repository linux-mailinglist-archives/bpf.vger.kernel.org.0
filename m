Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271A14E4857
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 22:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbiCVVjV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Mar 2022 17:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiCVVjU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Mar 2022 17:39:20 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A4C28E1D
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 14:37:51 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id r64so12099396wmr.4
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 14:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=26rbbh0Rc+t58fCPLrjVyxltmsz2gfaAhKsT3lin0qU=;
        b=E4pneTceurMqMrK/ctTcQD8Ux5MsPoAf7fXe0dR1Vi4+NasJnWwgPDWsS6IXE9SFsC
         K1mTPuhYcB3HpxJ3GEoMt51U3jeaO33AhpL9EhWKpmlv7h+yq2ib41Gzqf2UnxTK9lFe
         lIgfBHrtuhDX/MQbhz14gDLxT4el9mInINuuKPju736gzx84bNf2sCrZElIomNmnijXu
         jxWc82KJL8l2Lt6orpyEBw05omUgb/E4mNF9v8fCam3yWbwaksgIqrexxXEa7F9cbCQ4
         WjouLCEeXkVb0xOFv6iujceESI7xqmeY4d3POejaRm5rslth8ExLDhKZOvTTIpdH6JAd
         3fqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=26rbbh0Rc+t58fCPLrjVyxltmsz2gfaAhKsT3lin0qU=;
        b=hIV0Ca823MN8ihqycewp3InH5dKkZvoKVxcspx9uaCydOUD6pU/C1l1Y/OGp79W5K5
         RtVEHzCvfEFrevexkReC5N4spLm5ndNyl780x2oozD/aPHpZVzGZgAsdkzDMCq88ARYV
         8dfcV2s7TcylWfqBvcJPq7PsSPXLEGDxPX8ZWQpXDloc9aFuWClM/WCDyjB9655usfHf
         oLSg/dQRFyUJ28mI9SWVZRD/XovJ2byzk29CB/D4DP3Z8nJ1nyvpobiYIalUHPtvtZrR
         Qtqeu70HYMPtssAUCLMeVR3YYkmTNoT2kh4eNVAANlQXFRfPMU0CvGClViOygAHxtFys
         7mqw==
X-Gm-Message-State: AOAM532nwNBQqhI1EQAAHCTLnq4sNzHT/8ylvusN3F0CVTtg0CMP2Z4P
        vm1mNErGSkyW0RLslJgzOJQLp3Tu0ZVM2Rc0jjARwg==
X-Google-Smtp-Source: ABdhPJzY+0z4BHVsf8We2C79D5dl6jKrbqOozKCmCl71iCXf7SCI56T7IFhb+A0USGMYR3NGtuLZI7lZ3ehDt5Z3lhI=
X-Received: by 2002:a1c:f605:0:b0:37b:b5de:89a0 with SMTP id
 w5-20020a1cf605000000b0037bb5de89a0mr5795110wmc.88.1647985069723; Tue, 22 Mar
 2022 14:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkbQNpeX8MGw9dXa5gi6am=VNXwgwUoTd6+K=foixEm1fw@mail.gmail.com>
 <Yi7ULpR70HatVP/8@slm.duckdns.org> <CAJD7tkYGUaeeFMJSWNbdgaoEq=kFTkZzx8Jy1fwWBvt2WEfqAA@mail.gmail.com>
 <f049c2f6-499b-ff7a-3910-38487878606a@fb.com>
In-Reply-To: <f049c2f6-499b-ff7a-3910-38487878606a@fb.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 22 Mar 2022 14:37:38 -0700
Message-ID: <CA+khW7jFSmm5sTyAVfEZhYnKDhVZKRRGLgAmCqgZzgON8NJOGg@mail.gmail.com>
Subject: Re: [RFC bpf-next] Hierarchical Cgroup Stats Collection Using BPF
To:     Yonghong Song <yhs@fb.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>, Tejun Heo <tj@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        David Rientjes <rientjes@google.com>,
        bpf <bpf@vger.kernel.org>, KP Singh <kpsingh@kernel.org>,
        cgroups@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 22, 2022 at 11:09 AM Yonghong Song <yhs@fb.com> wrote:
>
> Hi, Yosry, I heard this was discussed in bpf office hour which I
> didn't attend. Could you summarize the conclusion and what is the
> step forward? We also have an internal tool which collects cgroup
> stats and this might help us as well. Thanks!
>

Hi Yonghong,

Yosry is out of office this entire week. I don't know whether he has
access to corp email account, so please allow me to reply on his
behalf.

So instead of using rstat in bpf (by providing a map interface), it's
better to leverage the flexibility provided by bpf to extend rstat.
"We can achieve a similar outcome with a less intrusive design." Yosry
"will look at programs providing their own aggregators and maintaining
their own stats, and only making callbacks to/from rstat." As the next
step, Yosry is going to work on an RFC patchset to drive the
discussion, when he is back.

It's great to see that this is helpful to you as well! I am looking
forward to collaboration if there is a need.

Hao
