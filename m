Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8A16B2C0F
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 18:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCIRcL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 12:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjCIRcJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 12:32:09 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25854F92D1
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 09:32:08 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id i10so2756087plr.9
        for <bpf@vger.kernel.org>; Thu, 09 Mar 2023 09:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678383127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vV9EKl0m4ohtp3dQbfuzoemD5ze26lAIa4tY5258Im4=;
        b=V3J/hGfYXcydOTT2Iz+D30p9wrdBwH3U4EHRctBHm4aJ1KBfQ5rzQiHybxT4bX88co
         UMXbZPEdXgzcNe+8w6RcRGsgwIAimz56rIm5+aqvo/7omu6CeezD1+aYczOyOgFhvvPZ
         IfJhT1X479MVudXxLRvuzRK10rLQZbp4+kU2YOaIVKRaDvsszRr3u/cTwizgCZmCtnZA
         n1p10ZbmZNFXjMoOfYEYQ3CtlqbhhPhwTQXZPa3P33dqp9rvPCbxjCIbfCp8S7yDPSMV
         ZiXiTTQ1xuQBUncLXa8YHbaWyOijIVm1lTf6lhqeoRAyz2OPLGmwIDgupD95xRNHGrMx
         nGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678383127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vV9EKl0m4ohtp3dQbfuzoemD5ze26lAIa4tY5258Im4=;
        b=YCjvJ9tjmxAIjACT+qsT93QeVS0M2tfMwufryNgeOwsvnLi4wJGkhs6GlzOxuaLFMD
         2+g7XoKQuvqYjA8oO2Z3AQP5FE9KvL5/UUsC64Leq5k1BPOlJCb593hZebZz0jHH73v1
         9dHr2aXKSz09hxojsYx+G0ex6YSymeYJ0fv/blFFmP1Ed3Ti19pO6VReP2IMtDI9bgxh
         U/Kb9KG8rvzu+2UQcBwsP6D4F+OE3g+1banZteEkyzPMK1FKNJuAHAONKfSPhyX2k+s9
         4cTneWWBLZeRDdGwa7CfAcbav1JRs+Eq9AQFgd05UycGB0fbRl+b0K3E0YkNrDabCI+z
         GPTA==
X-Gm-Message-State: AO0yUKVm8ejx9v4JcDLnGEeSVVJDCe7ZU+gHbKRqN1S6lqY5MaqYNE6a
        cmcB2NPY0+ClrAregCIri4Pn16yEu8Wgh5wX9HuKOw==
X-Google-Smtp-Source: AK7set8jq0ISZU/4KwlkMOgTSQdZwTGdKaGzs6Y9NPKCQ4PfK8M8TD2nkjrqP0waGITKJ5IrolJ+0unA/nVokHsSeS0=
X-Received: by 2002:a17:902:f812:b0:19a:f153:b73e with SMTP id
 ix18-20020a170902f81200b0019af153b73emr8457693plb.4.1678383127384; Thu, 09
 Mar 2023 09:32:07 -0800 (PST)
MIME-Version: 1.0
References: <20230309004836.2808610-1-jesussanp@google.com>
 <167832601863.28104.18004021177531379064.git-patchwork-notify@kernel.org>
 <CAK4Nh0gOSHfwb8Yuv_YAhKHH+gTr=rqt+ZnQi1yXQ7qLiqu21w@mail.gmail.com> <CAEf4BzbggD36JS4Z1dukPBqpTBapO-ptbfa3Qc8m9j5j-7ue=A@mail.gmail.com>
In-Reply-To: <CAEf4BzbggD36JS4Z1dukPBqpTBapO-ptbfa3Qc8m9j5j-7ue=A@mail.gmail.com>
From:   Jesus Sanchez-Palencia <jesussanp@google.com>
Date:   Thu, 9 Mar 2023 09:31:56 -0800
Message-ID: <CAK4Nh0hjip7U4_oMYbCn1mx2j4n_y4FT67yMUDMY1ffu6RtOew@mail.gmail.com>
Subject: Re: [PATCH] Revert "libbpf: Poison strlcpy()"
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     andrii@kernel.org, bpf@vger.kernel.org, sdf@google.com,
        rongtao@cestc.cn, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Mar 9, 2023 at 9:27=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Mar 9, 2023 at 8:06=E2=80=AFAM Jesus Sanchez-Palencia
> <jesussanp@google.com> wrote:
> >
> > On Wed, Mar 8, 2023 at 5:40=E2=80=AFPM <patchwork-bot+netdevbpf@kernel.=
org> wrote:
> > >
> > > Hello:
> > >
> > > This patch was applied to bpf/bpf-next.git (master)
> > > by Andrii Nakryiko <andrii@kernel.org>:
> >
> > Andrii, are you planning to send this patch to 6.3-rc* since the build
> > is broken there?
> > Just double-checking since it was applied to bpf-next.
>
> I didn't intend to, feel free to do that.

Oh I always thought that fixes for the rc-* iterations had to come
from the maintainer
trees. Should I just send it to lkml directly?

>
> But just curious, why are you building libbpf from kernel sources
> instead of Github repo? Is it through perf build?

Yes, through the perf build. We build it altogether as part of our kernel b=
uild.

Thanks,
Jesus
