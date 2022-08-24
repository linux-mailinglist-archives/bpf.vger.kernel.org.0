Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF4C59F312
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 07:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiHXFc2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 01:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiHXFc1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 01:32:27 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3F47963C;
        Tue, 23 Aug 2022 22:32:26 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id pm13so7086759pjb.5;
        Tue, 23 Aug 2022 22:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc;
        bh=72C7eyfOAMUX8jcT7Qu98qir+uvidaQvpkSeo3hpZMI=;
        b=gxcCpwsQQuS52SzoC8DwG/M2dH6P8qkuS46Xqw7g1wyLdcbB6P+WFvwa8ejuHXAsoM
         UE2+tjBQNX6X2BkaATVV6PoB8Y53UCjqA7acluDXjF1LzT4sbCiofmjaG1LeaWhh8t8e
         a8GsFA7algDL9ipehga5O7txdScmzc87RP6y/5mMwQ9qL/GrdZn9IDJhWv2KCcZy68oa
         PfL3S9KvY76m9DJI4OcaS+C+WcHHRZvKx3kxApCWWuE92JqiwMPUVaIECRwFtqbQz8ln
         VAEMd6S4Oz46lnk7Qkp3M3gaExopg4Jy27h/vmC4Sv0XiOKFYKZKzLxAvv+PF/5iycfs
         srnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc;
        bh=72C7eyfOAMUX8jcT7Qu98qir+uvidaQvpkSeo3hpZMI=;
        b=psjInder2/6sl+YIlK1vJ8elXOulCCRYOvoLK/kCdn7JkI0hAPaDQlzeO3CvMD9SO8
         XUrQNnTVqTazoQQnEEomVMFcHfg/KwAJkxqw3rux+42kTJCdfkHJFJhPePBy+PNYiiH7
         hSLuD2mJvZ4O0HTNEklC2vj4t0fZk/BAkQgB27b3IMTB/T+1wS3PWBg8onZfrdWL0XhQ
         dx95IKYhKdlQWv73EDzr4Vf6F8qNzez7O8PrYcrmdkq4B5UAi+UaHZususRaP2V1pFrf
         qIrLb4OigTh1wCQYKxE22OBTs3yxMiNmn0r1NnrPJpqJCUbZ2t+xgWdEe/c3HkZ58zge
         6NyA==
X-Gm-Message-State: ACgBeo3HDCvBV+fPO50ewpfKkoYNLepupzvztc6r3RAV8KzY6wE/nqxD
        bE2gzT0AcFAbbL+FZxNo7SA=
X-Google-Smtp-Source: AA6agR65kqnXyz2syW+GUE8Zr+jyUMH7CB7RvtT34BbxlU6Lxevq5V/pt2M4jd4FMvRjMT9nndMYwA==
X-Received: by 2002:a17:90b:3684:b0:1fa:f48e:abd0 with SMTP id mj4-20020a17090b368400b001faf48eabd0mr6526270pjb.180.1661319146022;
        Tue, 23 Aug 2022 22:32:26 -0700 (PDT)
Received: from localhost ([98.97.33.232])
        by smtp.gmail.com with ESMTPSA id pg2-20020a17090b1e0200b001fb3aba374dsm366762pjb.31.2022.08.23.22.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 22:32:25 -0700 (PDT)
Date:   Tue, 23 Aug 2022 22:32:23 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <6305b7e7c7709_6d4fc20869@john.notmuch>
In-Reply-To: <CAM9d7cgxP6+R2BkVZfRAVvFUaJcknu8wAvKa_b1TBnTdKKiQvw@mail.gmail.com>
References: <20220823210354.1407473-1-namhyung@kernel.org>
 <95708205-66EA-4622-A580-FD234E6CE2DA@fb.com>
 <CAM9d7cgxP6+R2BkVZfRAVvFUaJcknu8wAvKa_b1TBnTdKKiQvw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add bpf_read_raw_record() helper
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Namhyung Kim wrote:
> Hi Song,
> 
> On Tue, Aug 23, 2022 at 3:19 PM Song Liu <songliubraving@fb.com> wrote:
> >
> >
> >
> > > On Aug 23, 2022, at 2:03 PM, Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > The helper is for BPF programs attached to perf_event in order to read
> > > event-specific raw data.  I followed the convention of the
> > > bpf_read_branch_records() helper so that it can tell the size of
> > > record using BPF_F_GET_RAW_RECORD flag.
> > >
> > > The use case is to filter perf event samples based on the HW provided
> > > data which have more detailed information about the sample.
> > >
> > > Note that it only reads the first fragment of the raw record.  But it
> > > seems mostly ok since all the existing PMU raw data have only single
> > > fragment and the multi-fragment records are only for BPF output attached
> > > to sockets.  So unless it's used with such an extreme case, it'd work
> > > for most of tracing use cases.
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > > I don't know how to test this.  As the raw data is available on some
> > > hardware PMU only (e.g. AMD IBS).  I tried a tracepoint event but it was
> > > rejected by the verifier.  Actually it needs a bpf_perf_event_data
> > > context so that's not an option IIUC.
> >
> > Can we add a software event that generates raw data for testing?
> 
> Ok, now I think that I can use a bpf-output sw event.  It would need
> another BPF program to write data to the event and the test program
> can read it from BPF using this helper. :)
> 
> Thanks,
> Namhyung

Ah good idea. Feel free to carry my ACK to the v2 with the test.
