Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B304063FFD9
	for <lists+bpf@lfdr.de>; Fri,  2 Dec 2022 06:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbiLBFgl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Dec 2022 00:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbiLBFgk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Dec 2022 00:36:40 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0101D159F
        for <bpf@vger.kernel.org>; Thu,  1 Dec 2022 21:36:39 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id z192so4857452yba.0
        for <bpf@vger.kernel.org>; Thu, 01 Dec 2022 21:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tCv9Z7M/a3VWHf5u+7Fmnwj6/+WEaOp1f80aBf2vp3Y=;
        b=iKrybUqIs1uJdT21B9xcHZ28GQIKbnRluqTIzSJOUVogBxLBhztjedYsSdEHdwmeWY
         loigN7rjNelp46wyfltDPlbOVI8sp7wDEKZW49rgHMpd0a/LFTDD/RqRfUsq4Fxh5nGY
         nvd6x7N/xfIo98jLLhKVwG6QnaLG7e5W77EGx8CYAvPa42y0Fsv1aWF+EJ+mydOeY0Rx
         qpqLFr4DqOzlc5jOJrVHPVTxlmTmqiFXEemRZQexnp3y2PFkG6UorYplcxu9BPodIAgX
         zmgxeDX3+bbmtCtfDtLp4jZxOj4ligUPUS6ztiU4/cb5v1WyjSnmcmzkbYEMnY2mo4s5
         +i/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tCv9Z7M/a3VWHf5u+7Fmnwj6/+WEaOp1f80aBf2vp3Y=;
        b=GEdCTCgQ19ANut1dNPdMD/sXGf3QmAQXG7cFGv6/3hsoMB91guoCocmvRu00z8NEVf
         UnD885WXH084ORA5EnvhlyOkb44kq3MS6XLcfygjQbuy3zDsQFZO5Wq2jIlntbwpdYAo
         tVvBGhYcQ5IMly+AqMJYwCRXROLEJVuRxVM5KMhbk6VNEYmYnbvxon6RxVWREbUtRE0Q
         6qCXgFKpvb7PkWMxsZCv2T9Ysvncq/MRwDnltDCh9Z1+khyRVB63Zkhp3vEm1Ro1/Qgr
         5C1TOrNOIDTVCjRLZJtt3kTid6xPdh/lNewvAThMTLW4wnY924y23wzmxGK33NQZbyGf
         xPmQ==
X-Gm-Message-State: ANoB5pn8mWiI7TDhGvDTaC0XTmDSmt99BbuxH8sFsII5nI/dPGAP7U8Y
        Y8NAASjQK6riG/oiydzLpdZmjVgkGm3PiL3LLLMiUA==
X-Google-Smtp-Source: AA0mqf4Bk+xHoGBb0xjBLMJmTQhvW4eCa9ZeyY5gF1NGDR4cDYPxKf8v/15OBxS0PbnxkVpij4pNccbahHj3aThKV/g=
X-Received: by 2002:a25:7204:0:b0:6f0:9ff5:1151 with SMTP id
 n4-20020a257204000000b006f09ff51151mr40480396ybc.543.1669959399020; Thu, 01
 Dec 2022 21:36:39 -0800 (PST)
MIME-Version: 1.0
References: <20221129161612.45765-1-laoar.shao@gmail.com> <CA+khW7jjfQOLnx6-4UyJ8sYTj12qzp_NmiZJ-uiSwGU754hbXg@mail.gmail.com>
 <CALOAHbCGSigE9vjvw6DczLbRF=TaQ3vmh6SHvMvoAChM_6Mdfg@mail.gmail.com>
 <CAPhsuW7B1fM=JYG0OeHPZU7isv+O2_OPc22EBsdC6ZNEWusqXA@mail.gmail.com>
 <CA+khW7gLUrBYLoCKPAOO8evofNjr97crX=Gw59FpZu-gM8FTHQ@mail.gmail.com> <CALOAHbCqR6Qmx9n4Sq9Vdh=9ba_L1nfh9BpAwnAMq2d9xHFiiQ@mail.gmail.com>
In-Reply-To: <CALOAHbCqR6Qmx9n4Sq9Vdh=9ba_L1nfh9BpAwnAMq2d9xHFiiQ@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 1 Dec 2022 21:36:28 -0800
Message-ID: <CA+khW7jSh8hOTBPjVFBXX0xi+BRadA+_GzAvW4wD1st33CmhMg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next] bpf: Allow get bpf object with CAP_BPF
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Song Liu <song@kernel.org>, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 1, 2022 at 6:47 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> On Thu, Dec 1, 2022 at 8:38 AM Hao Luo <haoluo@google.com> wrote:
<...>
> > 3. IIRC, Song proposed introducing a namespace for BPF isolation, not
> > just isolating IDs [1]. How does it relate to the BPF_ID namespace?
> >
> > [1] https://lore.kernel.org/all/CAPhsuW6c17p3XkzSxxo7YBW9LHjqerOqQvt7C1+S--8C9omeng@mail.gmail.com/
>
> I have looked through the slides of this proposal, but failed to
> figure out how Song will design the BPF namespace. Maybe Song can give
> us a better explanation.
> Per my understanding, the goal of Song's proposal should be combined
> by many namespaces and other isolation mechanisms.  For example, with
> the help of PID namespace, we can make sure only the tasks in this
> container can be traced by the bpf programs running in it.
>

Among the 5 items in [1], it looks like the third item "Limit which
BPF programs are accessible to non-root users" is what you proposed
here. The other items are more about isolation, I think. So, the
question is, if we have a BPF_ID namespace, would that be sufficient
for debugging in containers? If yes, at least it's something useful.
We can start from the BPF_ID namespace, bring it for discussion, and
gather other requirements gradually.
