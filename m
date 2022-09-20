Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F375BF191
	for <lists+bpf@lfdr.de>; Wed, 21 Sep 2022 01:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiITX7V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Sep 2022 19:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiITX7U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 19:59:20 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E7749B79
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 16:59:19 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id y3so10011970ejc.1
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 16:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=nWLqMmZDAsLPmXOe6xSzAq7bwAEIJYvjklD6Q1tPm0E=;
        b=SdTdm91OQQ5uBPcknDetdkKD79Stu43JrKIpC+k+RB+TO1xckSg8iZks/KDST1zzKX
         5g59wanfWKgdq1BfevJQ369XNfIeESstulDmydkx6uyIRthhrsSmuWF2c+ueVRWtughR
         4KYKKEWfa97N0rOts+FhH4Kn8TnC5kHU6opNpZtzs8l4dsyL552mY55eMqOKV4SwO73N
         PklAyQQiVl/csfbDjTlpxz3zP4FnJkQIwWp4ues9vPlfHzX7UGo+qy8JvbKSZHSO3TSI
         1W6h7BDQ/VLAycBJ7+SVbshZOTXa574tPJLB/Kw4Ovu4CbckVaWxvP0CNaGkasPmOjU4
         rKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=nWLqMmZDAsLPmXOe6xSzAq7bwAEIJYvjklD6Q1tPm0E=;
        b=P0+O3iRXcRfI+ki4U+7ls4dXTf2/mUFGGBQtXNC/kUrMm9PYxYQNu60t8E/ID7lAgj
         Sp0O8ci9B6TRHg/EW0KufJqUQT720WPBGTxCbRAN9E91GfQ8SnTI0uhoEfN2CnhXamuK
         SC2uxPkGauvmVdR69GOuIuL9+ro0AuGzaDalGm9w76eMYOL1WDDHenl8WBlJ2gALz17O
         lmIBwskYVti6UP1uDrQh0TVvyAzv2cpOE+oq/b0c9V299tMrTujWWDncDLhl/tagCPau
         xftppOckSY/+7jP2jxw2/0FdwbjUZPUoVnCPpDh/YSbSi9IG2RDS8I2Y06LkQuwMY+mI
         69AA==
X-Gm-Message-State: ACrzQf2cVOuSF9an8smVjUbfwVQIjOXQGwcBlb+gkrCYpPsX8pM8GhL+
        zuuaqOODYwgxGVWcNHcLn7KSi7F9eUNKiXqXk1tPFpgd
X-Google-Smtp-Source: AMsMyM7htBXoF3AqFOnbke/Cf8W9qB4HOiNzXaKwN3o9KkysDY2Fuy08Ls+S9zz5C1Vzx+4QIaRF6A6Gy6gpjrf5JRs=
X-Received: by 2002:a17:907:3d86:b0:782:1175:153f with SMTP id
 he6-20020a1709073d8600b007821175153fmr342637ejc.226.1663718356328; Tue, 20
 Sep 2022 16:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220920040736.342025-1-andrii@kernel.org> <20220920040736.342025-2-andrii@kernel.org>
 <7a882d19-f49e-1255-6a27-b1f3d935bd63@fb.com>
In-Reply-To: <7a882d19-f49e-1255-6a27-b1f3d935bd63@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 20 Sep 2022 16:59:05 -0700
Message-ID: <CAEf4BzbY6NKaTVWBftGZpGgtYvS=9aJLK=dEimdF++jVCtmgcQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: add CSV output mode for veristat
To:     Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com
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

On Tue, Sep 20, 2022 at 8:53 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 9/19/22 9:07 PM, Andrii Nakryiko wrote:
> > Teach veristat to output results as CSV table for easier programmatic
> > processing. Change what was --output/-o argument to now be --emit/-e.
> > And then use --output-format/-o <fmt> to specify output format.
> > Currently "table" and "csv" is supported, table being default.
> >
> > For CSV output mode veristat is using spec identifiers as column names.
> > E.g., instead of "Total states" veristat uses "total_states" as a CSV
> > header name.
> >
> > Internally veristat recognizes three formats, one of them
> > (RESFMT_TABLE_CALCLEN) is a special format instructing veristat to
> > calculate column widths for table output. This felt a bit cleaner and
> > more uniform than either creating separate functions just for this.
> >
> > Also fix double-free of bpf_object in process_prog, which didn't feel
> > important enough to have a separate patch for.
>
> Without this patch set, I do see the following failure:
>
> [$ ~/work/bpf-next/tools/testing/selftests/bpf] ./veristat -s
> insns,file,prog
> {pyperf,loop,test_verif_scale,strobemeta,test_cls_redirect,profiler}*.linked3.o
>
> double free or corruption (!prev)
>
>
> Aborted (core dumped)
>
> This patch set fixed the double free problem.
>

Bad wording on my part about "important enough". I'll split it out
into a separate patch with Fixes tag, I shouldn't have been lazy :)

> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >   tools/testing/selftests/bpf/veristat.c | 114 ++++++++++++++++---------
> >   1 file changed, 76 insertions(+), 38 deletions(-)
> >
> [...]
