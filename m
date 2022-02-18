Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450214BB4C9
	for <lists+bpf@lfdr.de>; Fri, 18 Feb 2022 10:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbiBRJBu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Feb 2022 04:01:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbiBRJBs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Feb 2022 04:01:48 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1914C50476;
        Fri, 18 Feb 2022 01:01:31 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id u1so13322861wrg.11;
        Fri, 18 Feb 2022 01:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZYxZ73c+F4J6jMvbnzlZ5/TEHyIV+XiIyxVP9fH3B1M=;
        b=iPVKlwSPbFttDZnZ5Es+EotVr6BSKpP0TrQChOGASg6H20kOJzZuVDooyplF9ShgAZ
         IOSt5vS+zz6z2AvBGmQDpQomb3RkFLmAQCmFmgihBLjNbVMxKBbhMGPlAILWL60Z4shD
         7h3Lhi86Y2KukyWmn1/Xe2xecHKYglxNfTCD6YNrv87CbfyhhtcDI1KD5XsspbXxEGb+
         a18K9lVokQMyqKHURj9pZSZOZQUInuQvc1Zi7LBFmwl0YJUUBdE6SAAFHgSApRUpvBpS
         n0QhuM9KNTkmIcRGRDhKD8Nqejq2gh/m6K4WaCKsrxq+msSti+c2qvk17n7exbjLn8QB
         ODfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZYxZ73c+F4J6jMvbnzlZ5/TEHyIV+XiIyxVP9fH3B1M=;
        b=PWbM+r2wo8VqfvxLvaXfoQEzyEGy0LGqFCUHTK4/pFI7i/4e73Cp6K+V4vka05gRXI
         nRJ+O5PNRoHgYnOvgh+weyORCyPrre/PXlXBt8eTqN69/elyoskyNPzuRuDv5BKiZXcb
         Cpw/UF3WDH92T4N6m+8EUX4z4XLsmxDp0FBZ7Z1Yt1NBDRiyXLzJZiTZ3FBQbsglb4II
         RmSsS+c5q0AgJsYAFRBYS/Qz24OQisDSfpDLp5qxV88wwRz27N4OuPWgpEedt0zC18FA
         WNLsm9WX+U4gOz4Q1CdJYy8YaJ8qdnsZ5AxqjYF+IPz7+UGDZLMN6JZTxXBER4q0yLbP
         xGKw==
X-Gm-Message-State: AOAM533+CUJgQ9d+b8P1UIqMnFhS2ML7J8SeTr1ZYzjx0cgI6w+uwb2e
        B6sF8xhIW1sZ14P5PfujbmQ=
X-Google-Smtp-Source: ABdhPJzp9gaKEXAgzSOr/AqWCnj3GEq7kh3LRumz7b1qp29hfaGqB/mZ8t2sLgChGS5UTHKj0bGMIQ==
X-Received: by 2002:a5d:6b8b:0:b0:1e5:2d46:d150 with SMTP id n11-20020a5d6b8b000000b001e52d46d150mr5314811wrx.380.1645174889506;
        Fri, 18 Feb 2022 01:01:29 -0800 (PST)
Received: from krava ([2a00:102a:5012:d617:c924:e6ed:1707:a063])
        by smtp.gmail.com with ESMTPSA id r10sm1172969wrv.28.2022.02.18.01.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 01:01:29 -0800 (PST)
Date:   Fri, 18 Feb 2022 10:01:25 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 1/3] perf tools: Remove
 bpf_program__set_priv/bpf_program__priv usage
Message-ID: <Yg9gZa0hxfFcOk57@krava>
References: <20220217131916.50615-1-jolsa@kernel.org>
 <20220217131916.50615-2-jolsa@kernel.org>
 <CAEf4BzboYd4y53KjKwNMCqE6oV9ms0zbtKCGweEGtjZvCe1f0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzboYd4y53KjKwNMCqE6oV9ms0zbtKCGweEGtjZvCe1f0w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 17, 2022 at 01:47:16PM -0800, Andrii Nakryiko wrote:
> On Thu, Feb 17, 2022 at 5:19 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Both bpf_program__set_priv/bpf_program__priv are deprecated
> > and will be eventually removed.
> >
> > Using hashmap to replace that functionality.
> >
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/bpf-loader.c | 91 +++++++++++++++++++++++++++++-------
> >  1 file changed, 75 insertions(+), 16 deletions(-)
> >
> 
> [...]
> 
> > +
> > +static int program_set_priv(struct bpf_program *prog, void *priv)
> > +{
> > +       void *old_priv;
> > +
> > +       if (!bpf_program_hash) {
> > +               bpf_program_hash = hashmap__new(ptr_hash, ptr_equal, NULL);
> > +               if (!bpf_program_hash)
> 
> should use IS_ERR here

ah right, thanks

jirka

> 
> > +                       return -ENOMEM;
> > +       }
> > +
> > +       old_priv = program_priv(prog);
> > +       if (old_priv) {
> > +               clear_prog_priv(prog, old_priv);
> > +               return hashmap__set(bpf_program_hash, prog, priv, NULL, NULL);
> > +       }
> > +       return hashmap__add(bpf_program_hash, prog, priv);
> >  }
> 
> [...]
