Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E670463BBEF
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 09:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiK2Ips (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 03:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiK2Ipq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 03:45:46 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B97B24F18
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 00:45:45 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h11so13609226wrw.13
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 00:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nYOiFh0O5fHhs5PivAYynaFc3zdwIOfw8CsMjTkTsdo=;
        b=Qo+ACEzwAY/0Bhr4LKc8ZeGHXsg0xOXLnotVO9LoEvIBXlcG5rhFO7uVKWwnhq+k8m
         dE4/G46DdvOWNfukovTuvHVDSAYTWZGE00QR/yIWP6fKhMRdkxgIWBzfqgR1euLyAtfs
         SqADAkwmrFliU4Mux9RzWvEqPVBa8krLLWVMQFGz3T70RZkx4xSNgcC6jfAdMzsjYad3
         AYpxkq1dYOOok46gjB3n5s/V+rH2GH+YS46RFnaBylnE40OLIN6Ztj1r7Y1bP1PxnNHh
         ZNFehiPunTZ5dHt/E4cyUELf3DCq4xR36hgqlUVArjl84RSk5QS2rZ8PiEZkmxwnikef
         hsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYOiFh0O5fHhs5PivAYynaFc3zdwIOfw8CsMjTkTsdo=;
        b=pIru9hOBP3/7H+u1u/wVnfl4D1OgvnwJe5vdocEX542yEf+fQHNhI9nQme6f0bOSeD
         FjlGMoRyFtF/pdGx6pWhOXxTiec40IUIheniueQsf871K19fxIfGwBZHNvuypFyVLuU8
         lWlq1DvdeBljRGqLMNeezfPo3KgsI6IRz9+BgLD0uXoAAhwc0LU3TrQjI4jcTlHbqedy
         wG2WR0DGU3J+Uvzj6D4ymzTyLr3Mxb4XAgf5SegAQVrGMApQRlxiuPmLrvLTZqgqj5t2
         OTqGc36Qu1tW4WhpcqVuyIDjVE0F7G8oyEwQNPAKS42/d1nI3umcYO5RxZwB/ZMiIGca
         8txg==
X-Gm-Message-State: ANoB5pmPPrZa4FHRAG6HGxVWSyFxiqkd94MYRtcHI7o5x2GvgthNHasg
        oWXbUMfGdLLLa4H/faInAj0=
X-Google-Smtp-Source: AA0mqf7uIx8NYB6xzQWr0AekWPq+SJifdqOz7KZHvnqDxHHHgK7KDfFpLVfytgG0qzfwUTXunz5LKg==
X-Received: by 2002:a5d:5914:0:b0:236:57f3:c9e6 with SMTP id v20-20020a5d5914000000b0023657f3c9e6mr33622981wrd.21.1669711543567;
        Tue, 29 Nov 2022 00:45:43 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id i9-20020adfdec9000000b00228dbf15072sm12585334wrn.62.2022.11.29.00.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 00:45:43 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 29 Nov 2022 09:45:41 +0100
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv4 bpf-next 2/4] bpf: Add bpf_vma_build_id_parse function
 and kfunc
Message-ID: <Y4XGtR9OkHSZumnI@krava>
References: <20221128132915.141211-1-jolsa@kernel.org>
 <20221128132915.141211-3-jolsa@kernel.org>
 <CAADnVQLD0s07y=K1cEisnwFDgFEVw0egbLhx-PzVHTDQ9SOmdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLD0s07y=K1cEisnwFDgFEVw0egbLhx-PzVHTDQ9SOmdg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 28, 2022 at 01:36:03PM -0800, Alexei Starovoitov wrote:
> On Mon, Nov 28, 2022 at 5:29 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding bpf_vma_build_id_parse function to retrieve build id from
> > passed vma object and making it available as bpf kfunc.
> >
> > We can't use build_id_parse directly as kfunc, because we would
> > not have control over the build id buffer size provided by user.
> >
> > Instead we are adding new bpf_vma_build_id_parse function with
> > 'build_id__sz' argument that instructs verifier to check for the
> > available space in build_id buffer.
> >
> > This way we check that there's always available memory space
> > behind build_id pointer. We also check that the build_id__sz is
> > at least BUILD_ID_SIZE_MAX so we can place any buildid in.
> >
> > The bpf_vma_build_id_parse kfunc is marked as KF_TRUSTED_ARGS,
> > so it can be only called with trusted vma objects. These are
> > currently provided only by find_vma callback function and
> > task_vma iterator program.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/bpf.h      |  4 ++++
> >  kernel/trace/bpf_trace.c | 31 +++++++++++++++++++++++++++++++
> >  2 files changed, 35 insertions(+)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index c6aa6912ea16..359c8fe11779 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -2839,4 +2839,8 @@ static inline bool type_is_alloc(u32 type)
> >         return type & MEM_ALLOC;
> >  }
> >
> > +int bpf_vma_build_id_parse(struct vm_area_struct *vma,
> > +                          unsigned char *build_id,
> > +                          size_t build_id__sz);
> > +
> >  #endif /* _LINUX_BPF_H */
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 3bbd3f0c810c..7340de74531a 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/sort.h>
> >  #include <linux/key.h>
> >  #include <linux/verification.h>
> > +#include <linux/buildid.h>
> >
> >  #include <net/bpf_sk_storage.h>
> >
> > @@ -1383,6 +1384,36 @@ static int __init bpf_key_sig_kfuncs_init(void)
> >  late_initcall(bpf_key_sig_kfuncs_init);
> >  #endif /* CONFIG_KEYS */
> >
> > +int bpf_vma_build_id_parse(struct vm_area_struct *vma,
> > +                          unsigned char *build_id,
> > +                          size_t build_id__sz)
> > +{
> > +       __u32 size;
> > +       int err;
> > +
> > +       if (build_id__sz < BUILD_ID_SIZE_MAX)
> > +               return -EINVAL;
> > +
> > +       err = build_id_parse(vma, build_id, &size);
> > +       return err ?: (int) size;
> 
> if err is positive the caller won't be able
> to distinguish it vs size.

that should not happen, build_id_parse returns either < 0 for error, or 0 for success

> 
> > +}
> > +
> > +BTF_SET8_START(tracing_btf_ids)
> > +BTF_ID_FLAGS(func, bpf_vma_build_id_parse, KF_TRUSTED_ARGS)
> > +BTF_SET8_END(tracing_btf_ids)
> > +
> > +static const struct btf_kfunc_id_set tracing_kfunc_set = {
> > +       .owner = THIS_MODULE,
> > +       .set   = &tracing_btf_ids,
> > +};
> > +
> > +static int __init kfunc_tracing_init(void)
> > +{
> > +       return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &tracing_kfunc_set);
> > +}
> > +
> > +late_initcall(kfunc_tracing_init);
> 
> Its own btf_id set and its own late_initcall just for one kfunc?
> Please reduce this boilerplate code.
> Move it to kernel/bpf/helpers.c ?

ok, will move it

thanks,
jirka
