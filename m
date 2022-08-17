Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B53597A6C
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 02:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiHQX7W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 19:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241653AbiHQX7T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 19:59:19 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7CA76756
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 16:59:17 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id p125so111717pfp.2
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 16:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=19wjQql1tvvpnZC5dEdzDq0Vuzp2Qu6Vd29uIiXf1Tc=;
        b=MN3/QIn66O27h1s5jhss4Tr5rKpU2rCsWF5X0r59TP6/zc4sxP+fMvImTP2aKRAZ+Q
         BvR2M5GKNY95apdTOMOoab2PT8I1BLpcSlIjMV39Z8/70hsXKO2QZH21KLYPVnji2dht
         FdBL/zC+/8HEQCL4qP92O1XcpQvWVLpQN1/lSwdr7R8o/ioELmxiQZ9tZlbQEG2MzqNu
         RLneZa/OQogfIRCnlYe/Sb963bttkMsQZt/j0X84yLGyILhEtf6mUexVk8grl9iQSbBE
         +66PKksjWPk6JMdQnQK95VGApkI8wLgI1XXPJPkHtwg6UhBCt16JLVTY5mbIdmWO9V4O
         AiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=19wjQql1tvvpnZC5dEdzDq0Vuzp2Qu6Vd29uIiXf1Tc=;
        b=dSxdyhCpg9rWweBP2lEPxH/fBofVd4NucIrC/PxcoXyOcL4TqhTu8++rhxHRsIF5NR
         YbUqJeJIlGTjZL5InOTg+ZSi+ZmOU9svyZn0Cr+wMktv15Mr7Gv0oVe3KB76HJvFTfNk
         OhvZSKQeSDBNErMyGFSNUBSL+5AK+85CyPxVjOD+d/bRVYAXcDQYHlQEBVAdMT5vHaQ/
         xhT75GBlsfhFGv4lK4eeReUpAA9V0pfIlqo3AWfYiXhhUWzzKBqPMnl9/zjtfHc/lg8B
         XIqvkKZ5+ua1i8P65WnaHnZNbzk/9Dgh8mOzgVR7RpYfrKSYu6eCjy/D7+wjqSrVrq8M
         wwcg==
X-Gm-Message-State: ACgBeo0OzU6AES/fuB5M69mr/ivaw87W19bz/BTC7fRliBX/HPS0+miG
        gEGHTTf+XTZpaYmoomoT7dy/oyziRlCvdf9z9O06NQ==
X-Google-Smtp-Source: AA6agR6oo36lIlxmomUJ/Ta8BbO58uzcjN5WMqaTnQlPltKSPiG0RtDRSOS2RCIdGYRdHVSTcuXCQHMhXChr80JR4NY=
X-Received: by 2002:aa7:8895:0:b0:52e:c742:2f3d with SMTP id
 z21-20020aa78895000000b0052ec7422f3dmr500703pfe.69.1660780757028; Wed, 17 Aug
 2022 16:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220816201214.2489910-1-sdf@google.com> <20220817190743.rgudkmzunhtd5vxf@kafai-mbp>
 <CAKH8qBukudivY5XMwq6k42oUmHdAnbBAw2AjMeBT+Qnj3OZZhQ@mail.gmail.com> <20220817232736.6j7axkx4qpujusco@kafai-mbp>
In-Reply-To: <20220817232736.6j7axkx4qpujusco@kafai-mbp>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 17 Aug 2022 16:59:06 -0700
Message-ID: <CAKH8qBuk_DWPohB5whU-7teqh5XKN+HiMeafAwkodkB8mEo1YQ@mail.gmail.com>
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

On Wed, Aug 17, 2022 at 4:27 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Wed, Aug 17, 2022 at 03:41:26PM -0700, Stanislav Fomichev wrote:
> > On Wed, Aug 17, 2022 at 12:07 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > >
> > > On Tue, Aug 16, 2022 at 01:12:11PM -0700, Stanislav Fomichev wrote:
> > > > Apparently, only a small subset of cgroup hooks actually falls
> > > > back to cgroup_base_func_proto. This leads to unexpected result
> > > > where not all cgroup helpers have bpf_{g,s}et_retval.
> > > >
> > > > It's getting harder and harder to manage which helpers are exported
> > > > to which hooks. We now have the following call chains:
> > > >
> > > > - cg_skb_func_proto
> > > >   - sk_filter_func_proto
> > > >     - bpf_sk_base_func_proto
> > > >       - bpf_base_func_proto
> > > Could you explain how bpf_set_retval() will work with cgroup prog that
> > > is not syscall and can return flags in the higher bit (e.g. cg_skb egress).
> > > It will be a useful doc to add to the uapi bpf.h for
> > > the bpf_set_retval() helper.
> >
> > I think it's the same case as the case without bpf_set_retval? I don't
> > think the flags can be exported via bpf_set_retval, it just lets the
> > users override EPERM.
> eg. Before, a cg_skb@egress prog returns 3 to mean NET_XMIT_CN.
> What if the prog now returns 3 and also bpf_set_retval(-Exxxx).
> If I read how __cgroup_bpf_run_filter_skb() uses bpf_prog_run_array_cg()
> correctly,  __cgroup_bpf_run_filter_skb() will return NET_XMIT_DROP
> instead of the -Exxxx.  The -Exxxx is probably what the bpf prog
> is expecting after calling bpf_set_retval(-Exxxx) ?
> Thinking more about it, should __cgroup_bpf_run_filter_skb() always
> return -Exxxx whenever a -ve retval is set in bpf_set_retval() ?

I think we used to have "return 0/1/2/3" to indicate different
conditions but then switched to "return 1/0" + flags.
So, technically, "return 3 + bpf_set_retval" is still fundamentally a
"return 3" api-wise.
I guess we can make bpf_set_retval override that but let me start by
trying to document what we currently have.
If it turns out to be super ugly, we can try to fix it. (not sure how
much of a uapi that is)



> > Let me verify and I can add a note to bpf_set_retval uapi definition
> > to mention that it just overrides EPERM. bpf_set_retval should
> > probably not talk about userspace/syscall and instead use the words
> > like "caller".
> yeah, it is no longer syscall return value only now.
