Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FED598B25
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 20:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345500AbiHRSap (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Aug 2022 14:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345543AbiHRSaf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 14:30:35 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF368D11E4
        for <bpf@vger.kernel.org>; Thu, 18 Aug 2022 11:30:33 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id m2so2210158pls.4
        for <bpf@vger.kernel.org>; Thu, 18 Aug 2022 11:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=6ROLa4ZfqviWlEMFXcRp6VAA1KQ/lC/7AStgE1s4zKU=;
        b=SQQVIoslHjPu/4WBCgcUPsBreWV6Sz81RX4eyor2i97mDm5fVoRczw2oRInNQNxzFq
         e8KVb2waP7U9OertTd6nB7eMu8HGKpNkRUmcCfqSvAdLOp/8kX6ZsoWzMmCnF37XsHwN
         vZ/sSNSO0fIgotjlqLdF9TSjpj2phTTNt/woJ+gCZwofcJon7iMF/gPn9tfcnQYB9qzc
         NfEKaOAJpcuYdpBiCwCP6h7QbicjRa9AfjLdulKG/1hhpT/eg8XGWUHLuIEwrEbtRMN/
         FXN57B2CDwMotDbbKuVzXq4kfRWuAZZoxfCVpXnKkGItCwWH03auUMlOWPPARd18S2PK
         uh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=6ROLa4ZfqviWlEMFXcRp6VAA1KQ/lC/7AStgE1s4zKU=;
        b=CI6HWdYZeYjaPLh0NGnhzw2peaheD4d0YnFGpQvK8JhQTonTEabQ5K92JrFn7DxhkW
         4Dbllh1XdfdXQ6PWtQJ69DXaIFcB+pIH/32ZnHIgdscI570xwzTg/sYStUTeD4CEDkhr
         f87ZHOhnsaHc/FnNZE9RjugxVVS+lZuHZ0Rk6jc7fZ5JMUf2UZYdSwcdf5R22wEnzxIm
         1RoEG3jvegst31c6vPT8G/DztZtcl5NsvRHq3kLjUerjuH1wlFRM7dIljzxnp0zJ6xYS
         X71EZAmt8IxKD3Jt2hmqU08iah3FdadLuruo/8JDhB+O1WPQr+5Bap/UWPJvOZ7sX7US
         mdbw==
X-Gm-Message-State: ACgBeo1jEja5lQ3/s8MgcSWt0S7F1TFQzZGPap9BPy+wiJT87cwpdpwA
        3GJNCMHZ/PAsgfXXx8B/mZsrUQFACqT6Em6R36KsoQ==
X-Google-Smtp-Source: AA6agR6an4f36h9ERDQyRwAN5skUFC3xhHIYkKNmmLrYwt0dLRH3zBPTmbmqYNs8SCq1Yb4+sf763PQs8EVnBqb37Z0=
X-Received: by 2002:a17:902:70c7:b0:170:9030:2665 with SMTP id
 l7-20020a17090270c700b0017090302665mr3556532plt.73.1660847432621; Thu, 18 Aug
 2022 11:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220816201214.2489910-1-sdf@google.com> <20220817190743.rgudkmzunhtd5vxf@kafai-mbp>
 <CAKH8qBukudivY5XMwq6k42oUmHdAnbBAw2AjMeBT+Qnj3OZZhQ@mail.gmail.com>
 <20220817232736.6j7axkx4qpujusco@kafai-mbp> <CAKH8qBuk_DWPohB5whU-7teqh5XKN+HiMeafAwkodkB8mEo1YQ@mail.gmail.com>
 <20220818002144.2rk4yrmhqgivlqke@kafai-mbp> <CAKH8qBtY2wUy4U+pkEr14LrJxJBFfDdGk8wQxbBn=42Muw0g1w@mail.gmail.com>
 <20220818181556.3o37jnz6ov63gftb@kafai-mbp>
In-Reply-To: <20220818181556.3o37jnz6ov63gftb@kafai-mbp>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 18 Aug 2022 11:30:21 -0700
Message-ID: <CAKH8qBsJFDW-a-PMVOssVXbYEPEhKKi2v2tZj+uTBeNHZ5wO4w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] bpf: expose bpf_{g,s}et_retval to more
 cgroup hooks
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 18, 2022 at 11:16 AM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Wed, Aug 17, 2022 at 08:42:54PM -0700, Stanislav Fomichev wrote:
> > On Wed, Aug 17, 2022 at 5:21 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > >
> > > On Wed, Aug 17, 2022 at 04:59:06PM -0700, Stanislav Fomichev wrote:
> > > > On Wed, Aug 17, 2022 at 4:27 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > > > >
> > > > > On Wed, Aug 17, 2022 at 03:41:26PM -0700, Stanislav Fomichev wrote:
> > > > > > On Wed, Aug 17, 2022 at 12:07 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > > > > > >
> > > > > > > On Tue, Aug 16, 2022 at 01:12:11PM -0700, Stanislav Fomichev wrote:
> > > > > > > > Apparently, only a small subset of cgroup hooks actually falls
> > > > > > > > back to cgroup_base_func_proto. This leads to unexpected result
> > > > > > > > where not all cgroup helpers have bpf_{g,s}et_retval.
> > > > > > > >
> > > > > > > > It's getting harder and harder to manage which helpers are exported
> > > > > > > > to which hooks. We now have the following call chains:
> > > > > > > >
> > > > > > > > - cg_skb_func_proto
> > > > > > > >   - sk_filter_func_proto
> > > > > > > >     - bpf_sk_base_func_proto
> > > > > > > >       - bpf_base_func_proto
> > > > > > > Could you explain how bpf_set_retval() will work with cgroup prog that
> > > > > > > is not syscall and can return flags in the higher bit (e.g. cg_skb egress).
> > > > > > > It will be a useful doc to add to the uapi bpf.h for
> > > > > > > the bpf_set_retval() helper.
> > > > > >
> > > > > > I think it's the same case as the case without bpf_set_retval? I don't
> > > > > > think the flags can be exported via bpf_set_retval, it just lets the
> > > > > > users override EPERM.
> > > > > eg. Before, a cg_skb@egress prog returns 3 to mean NET_XMIT_CN.
> > > > > What if the prog now returns 3 and also bpf_set_retval(-Exxxx).
> > > > > If I read how __cgroup_bpf_run_filter_skb() uses bpf_prog_run_array_cg()
> > > > > correctly,  __cgroup_bpf_run_filter_skb() will return NET_XMIT_DROP
> > > > > instead of the -Exxxx.  The -Exxxx is probably what the bpf prog
> > > > > is expecting after calling bpf_set_retval(-Exxxx) ?
> > > > > Thinking more about it, should __cgroup_bpf_run_filter_skb() always
> > > > > return -Exxxx whenever a -ve retval is set in bpf_set_retval() ?
> > > >
> > > > I think we used to have "return 0/1/2/3" to indicate different
> > > > conditions but then switched to "return 1/0" + flags.
> > > For 'int bpf_prog_run_array_cg(..., u32 *ret_flags)'?
> > > I think it is more like return "0 (OK)/-Exxxx" + ret_flags now.
> >
> > Yes, right now that's that case. What I meant to say is that for the
> > BPF program itself, the api is still "return a set of predefined
> > values". We don't advertise the flags to the bpf programs. 'return 2'
> > is a perfectly valid return for cgroup/egress that will tx the packet
> > with a cn. (where bpf_prog_run_array_cg sees it as a 'return 0 + (1 <<
> > 1)')
> >
> > > > So, technically, "return 3 + bpf_set_retval" is still fundamentally a
> > > > "return 3" api-wise.
> > > hm....for the exisiting usecase (eg. CGROUP_SETSOCKOPT), what does
> > > "bpf-prog-return 1 + bpf_set_retval(-EPERM)" mean?
> >
> > I think bpf_set_retval takes precedence and in this case bpf_prog_run
> > wrapper will return -EPERM to the caller.
> > Will try to document that as well.
> >
> > > > I guess we can make bpf_set_retval override that but let me start by
> > > > trying to document what we currently have.
> > > To be clear, for cg_skb case, I meant to clear the ret_flags only if
> > > run_ctx.retval is set.
> >
> > Are you suggesting something like the following?
> >
> > diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> > index fd113bd2f79c..c110cbe52001 100644
> > --- a/kernel/bpf/cgroup.c
> > +++ b/kernel/bpf/cgroup.c
> > @@ -61,6 +61,8 @@ bpf_prog_run_array_cg(const struct cgroup_bpf *cgrp,
> >         bpf_reset_run_ctx(old_run_ctx);
> >         rcu_read_unlock();
> >         migrate_enable();
> > +       if (IS_ERR_VALUE((long)run_ctx.retval))
> > +               *ret_flags = 0;
> >         return run_ctx.retval;
> >  }
> >
> > I think this will break the 'return 2' case? But is it worth it doing
> > it more carefully like this? LMKWYT.
> The below should work. Not sure it is worth it
> but before doing this...
>
> During this discussion, I think I am not clear what is the use case
> on bpf_{g,s}et_retval() for cg_skb.  Could you describe how it will be
> used in your use case?  Is it for another tracing program to get
> a different return value from (eg.) sk_filter_trim_cap or ip[6]_output?
>
> Not meaning the helper should not be exposed.  It is easier
> to think with some examples.

I don't really need them in cg_skb, I want them in cg_sock so I can
return a custom errno from socket() syscall.
You're probably right and it doesn't make sense to support them in
cg_skb. Most of the
BPF_CGROUP_RUN_PROG_INET_INGRESS/BPF_CGROUP_RUN_PROG_INET_EGRESS
callers don't seem to care about returned error code? (from my brief
grepping)
Let's maybe err on the safe side and special case cg_skb for now (in
cgroup_common_func_proto) and not expose retval helpers?
