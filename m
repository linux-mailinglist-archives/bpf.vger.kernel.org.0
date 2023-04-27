Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC336F0616
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 14:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243913AbjD0Mph (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 08:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243803AbjD0Mpf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 08:45:35 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA92E524F
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 05:45:31 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-2f4c431f69cso5205378f8f.0
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 05:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682599530; x=1685191530;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8ozVz+95ko8S+lF9Fp1SWg9FisFi/CZtRU4MN6gVhrU=;
        b=pkUZ+6qoxbtYIQ70qIAbQnOVunUViP0seXDAOvx5NOBypGsgrs8LFXce1QX8s2OBHG
         IMjeNHly4s4q4jkrqDrh+/ZvNjeqxw2Iw/yYNvuXBMOMw6oNtGkUMm1WAUyNsw0LC/az
         aGdi0hP/F09bwTLgmt/1dViBgLfNlP3RRCfme+miWwm2fuX3FwMxwJ1/TaOx8UotrEkT
         +pbYaWz5E2TgRN9FxVgeiuL+k86zU1YSGv6pQP8/KNOZr2hlS2WZckE+p//y7ArfVM+x
         80E8WyCXAuNB99h2zQZkBcwVi79OMEIyVRCOcT9qSIHruaOrzQXrGBS4/bTsu/nKVHBv
         b57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682599530; x=1685191530;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ozVz+95ko8S+lF9Fp1SWg9FisFi/CZtRU4MN6gVhrU=;
        b=BKQh0zSYmNtNa/syP9qIddeJy7j58C+/+qYNoUIqPhWPtxvmodPOSBcuao2voWD0TO
         Fxc/knmCq0BnydUp3ud7PM/9bRhHl3BN4OQS1Tk0Ix0hGppGoPgvwUK7sppUrDtsBC3D
         T7NSP+ebpLr87zqd+aiKCk4coEoty8Uy4wCOk6Jm5qHUxAR97px13X+e//ETbF3Z9L+q
         iy1QECHNTK1xjHtzfsePh0ZWX6QaFOq9j2Lc0N3L6K+++lQFQb7XhVcwWjD0LaYwbT/n
         SxEW25CNLy2ro+I4jhrx1IkNXLOjJP/n/+puHRRHCBpSTR4mUM2jBD5qtCIwhu+Uyckp
         +Ycg==
X-Gm-Message-State: AC+VfDxkvaPkATcNaTEnXsFyeUsbsFp/3ChRZeQ68oBAr3zU5CtLJFnn
        PEz+cHZh4h3zp5hPE7SZld8=
X-Google-Smtp-Source: ACHHUZ6vU0f1JIZgXcrDMXtMm28/84AZ1P+kZO66TGeASig4qoEWsHDrabEelx3hkc8htI94dJtKmA==
X-Received: by 2002:a5d:5390:0:b0:303:c151:8e69 with SMTP id d16-20020a5d5390000000b00303c1518e69mr1160934wrv.40.1682599530004;
        Thu, 27 Apr 2023 05:45:30 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-8b88-53b7-c55c-8535.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:8b88:53b7:c55c:8535])
        by smtp.gmail.com with ESMTPSA id i3-20020adff303000000b002f4cf72fce6sm18578272wro.46.2023.04.27.05.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 05:45:29 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 27 Apr 2023 14:45:27 +0200
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [RFC/PATCH bpf-next 03/20] bpf: Add bpf_get_func_ip helper
 support for uprobe link
Message-ID: <ZEpuZ6gjZl3or1A3@krava>
References: <20230424160447.2005755-1-jolsa@kernel.org>
 <20230424160447.2005755-4-jolsa@kernel.org>
 <CAEf4BzZvb5PsJAJO7A-UP3bb7vNiSc2x=QPUN=uFZT08mqw1Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZvb5PsJAJO7A-UP3bb7vNiSc2x=QPUN=uFZT08mqw1Dw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 26, 2023 at 12:11:41PM -0700, Andrii Nakryiko wrote:
> On Mon, Apr 24, 2023 at 9:05 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding support for bpf_get_func_ip helper being called from
> > ebpf program attached by uprobe_multi link.
> >
> > It returns the ip of the uprobe.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> 
> LGTM. I assume that IP will be user space address for uprobes, right?
> Might be worth calling this out explicitly (it's kind of obvious and
> expected, though, so maybe I'm overthinking this).

yes, it's user space address where the probe is attached,
I'll make it more obvious ;-)

thanks,
jirka

> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> >  kernel/trace/bpf_trace.c | 33 ++++++++++++++++++++++++++++++---
> >  1 file changed, 30 insertions(+), 3 deletions(-)
> >
> 
> [...]
