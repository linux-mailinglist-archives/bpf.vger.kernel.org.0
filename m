Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3660A597C62
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 05:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiHRDnK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 23:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239618AbiHRDnI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 23:43:08 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2ECD9352F
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 20:43:06 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id 2so518306pll.0
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 20:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=0bkI1/Rb5GXIrExbPxVs68zoyaF8wKShjeSudp3jPT4=;
        b=JTREYxyeMh7WhrRLp+iv4NEU3ejm6CvDaeR+d2lISzirbV5hn8UU/YSM7v8W0x+tqn
         ++NNHunBU0Uly7ed/f+Fs2OHIghbhHjemt4kcHFd0dEfjeAhm3PhQaoGl5cBnhqtYYEt
         qNYcUuPtzvXgt6jyBrJN6voAT3jhglVlqvFDeYv5nOF1SIosmG0IblHl83oNIELkVj7G
         ihSOpacEdqKA9Mx6+cT0XOLsIxu1rB4Jv8rt8mhVP1ErDUrKUs7Rkl4eaCNoT3b4zY1e
         vQzBSdP6yJUKy7PFo2zyTMa0juyQOhjTwpQstb6x2EiiJ/HFDvAAY4MKgGR6hEIRTlgi
         1a6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=0bkI1/Rb5GXIrExbPxVs68zoyaF8wKShjeSudp3jPT4=;
        b=WSyianP5GZshRa1PgaeEsGRP5qU5WDSlNbKGqG3vbUqx5BfJkjMhR7Vl5ej2ySmQZR
         JJG7xTENGQPUtjkpiKDCJ615gMzIO13WkglUm7HXwDMn07gLRxgVV4Fa3ks78tXQgeHO
         rorA+q9QX5XaPoKJDPEtXpgZYT7r9l9sf0wotOYvack0Cp8WJlQ7v2d6AZziIlAZ4ugK
         /L1yTqKrFZdPHAn1vhNPDSTg82uc6l2NDl/Zk3ytP7LEmQbIzmjzFiupTWXoipgximJy
         TTGVno7PQuzAFncS0SlXYY8RWKSMcIKqvse1T3+4No4AmbIhbYcIrTdbFaui7xOzRs5U
         Ww6w==
X-Gm-Message-State: ACgBeo2NhnRlUJ5o/l9XA57N23hO54S4hziS+ZWpUowpbstdL6RS3QcV
        yvWJYDk31a9rP237OKRTrcir6ggbxKDyP5ZlHicxxA==
X-Google-Smtp-Source: AA6agR6u0l0GMsgucwCO1ZD6SUmGyOxrv7PB9JlsInuXmEmWDWkDupbDypf+3h6adqLUY+fcLj8fTP0rTX45yTvBPj0=
X-Received: by 2002:a17:90b:388e:b0:1f5:40d4:828d with SMTP id
 mu14-20020a17090b388e00b001f540d4828dmr1127597pjb.31.1660794185771; Wed, 17
 Aug 2022 20:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220816201214.2489910-1-sdf@google.com> <20220817190743.rgudkmzunhtd5vxf@kafai-mbp>
 <CAKH8qBukudivY5XMwq6k42oUmHdAnbBAw2AjMeBT+Qnj3OZZhQ@mail.gmail.com>
 <20220817232736.6j7axkx4qpujusco@kafai-mbp> <CAKH8qBuk_DWPohB5whU-7teqh5XKN+HiMeafAwkodkB8mEo1YQ@mail.gmail.com>
 <20220818002144.2rk4yrmhqgivlqke@kafai-mbp>
In-Reply-To: <20220818002144.2rk4yrmhqgivlqke@kafai-mbp>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 17 Aug 2022 20:42:54 -0700
Message-ID: <CAKH8qBtY2wUy4U+pkEr14LrJxJBFfDdGk8wQxbBn=42Muw0g1w@mail.gmail.com>
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

On Wed, Aug 17, 2022 at 5:21 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Wed, Aug 17, 2022 at 04:59:06PM -0700, Stanislav Fomichev wrote:
> > On Wed, Aug 17, 2022 at 4:27 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > >
> > > On Wed, Aug 17, 2022 at 03:41:26PM -0700, Stanislav Fomichev wrote:
> > > > On Wed, Aug 17, 2022 at 12:07 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > > > >
> > > > > On Tue, Aug 16, 2022 at 01:12:11PM -0700, Stanislav Fomichev wrote:
> > > > > > Apparently, only a small subset of cgroup hooks actually falls
> > > > > > back to cgroup_base_func_proto. This leads to unexpected result
> > > > > > where not all cgroup helpers have bpf_{g,s}et_retval.
> > > > > >
> > > > > > It's getting harder and harder to manage which helpers are exported
> > > > > > to which hooks. We now have the following call chains:
> > > > > >
> > > > > > - cg_skb_func_proto
> > > > > >   - sk_filter_func_proto
> > > > > >     - bpf_sk_base_func_proto
> > > > > >       - bpf_base_func_proto
> > > > > Could you explain how bpf_set_retval() will work with cgroup prog that
> > > > > is not syscall and can return flags in the higher bit (e.g. cg_skb egress).
> > > > > It will be a useful doc to add to the uapi bpf.h for
> > > > > the bpf_set_retval() helper.
> > > >
> > > > I think it's the same case as the case without bpf_set_retval? I don't
> > > > think the flags can be exported via bpf_set_retval, it just lets the
> > > > users override EPERM.
> > > eg. Before, a cg_skb@egress prog returns 3 to mean NET_XMIT_CN.
> > > What if the prog now returns 3 and also bpf_set_retval(-Exxxx).
> > > If I read how __cgroup_bpf_run_filter_skb() uses bpf_prog_run_array_cg()
> > > correctly,  __cgroup_bpf_run_filter_skb() will return NET_XMIT_DROP
> > > instead of the -Exxxx.  The -Exxxx is probably what the bpf prog
> > > is expecting after calling bpf_set_retval(-Exxxx) ?
> > > Thinking more about it, should __cgroup_bpf_run_filter_skb() always
> > > return -Exxxx whenever a -ve retval is set in bpf_set_retval() ?
> >
> > I think we used to have "return 0/1/2/3" to indicate different
> > conditions but then switched to "return 1/0" + flags.
> For 'int bpf_prog_run_array_cg(..., u32 *ret_flags)'?
> I think it is more like return "0 (OK)/-Exxxx" + ret_flags now.

Yes, right now that's that case. What I meant to say is that for the
BPF program itself, the api is still "return a set of predefined
values". We don't advertise the flags to the bpf programs. 'return 2'
is a perfectly valid return for cgroup/egress that will tx the packet
with a cn. (where bpf_prog_run_array_cg sees it as a 'return 0 + (1 <<
1)')

> > So, technically, "return 3 + bpf_set_retval" is still fundamentally a
> > "return 3" api-wise.
> hm....for the exisiting usecase (eg. CGROUP_SETSOCKOPT), what does
> "bpf-prog-return 1 + bpf_set_retval(-EPERM)" mean?

I think bpf_set_retval takes precedence and in this case bpf_prog_run
wrapper will return -EPERM to the caller.
Will try to document that as well.

> > I guess we can make bpf_set_retval override that but let me start by
> > trying to document what we currently have.
> To be clear, for cg_skb case, I meant to clear the ret_flags only if
> run_ctx.retval is set.

Are you suggesting something like the following?

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index fd113bd2f79c..c110cbe52001 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -61,6 +61,8 @@ bpf_prog_run_array_cg(const struct cgroup_bpf *cgrp,
        bpf_reset_run_ctx(old_run_ctx);
        rcu_read_unlock();
        migrate_enable();
+       if (IS_ERR_VALUE((long)run_ctx.retval))
+               *ret_flags = 0;
        return run_ctx.retval;
 }

I think this will break the 'return 2' case? But is it worth it doing
it more carefully like this? LMKWYT.

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index fd113bd2f79c..dcd25561f8d4 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -39,6 +39,7 @@ bpf_prog_run_array_cg(const struct cgroup_bpf *cgrp,
        const struct bpf_prog_array *array;
        struct bpf_run_ctx *old_run_ctx;
        struct bpf_cg_run_ctx run_ctx;
+       bool seen_return0 = false;
        u32 func_ret;

        run_ctx.retval = retval;
@@ -54,13 +55,17 @@ bpf_prog_run_array_cg(const struct cgroup_bpf *cgrp,
                        *(ret_flags) |= (func_ret >> 1);
                        func_ret &= 1;
                }
-               if (!func_ret && !IS_ERR_VALUE((long)run_ctx.retval))
+               if (!func_ret && !IS_ERR_VALUE((long)run_ctx.retval)) {
                        run_ctx.retval = -EPERM;
+                       seen_return0 = true;
+               }
                item++;
        }
        bpf_reset_run_ctx(old_run_ctx);
        rcu_read_unlock();
        migrate_enable();
+       if (IS_ERR_VALUE((long)run_ctx.retval) && !seen_return0)
+               *ret_flags = 0;
        return run_ctx.retval;
 }

> > If it turns out to be super ugly, we can try to fix it. (not sure how
> > much of a uapi that is)
> sgtm.
>
> >
> >
> >
> > > > Let me verify and I can add a note to bpf_set_retval uapi definition
> > > > to mention that it just overrides EPERM. bpf_set_retval should
> > > > probably not talk about userspace/syscall and instead use the words
> > > > like "caller".
> > > yeah, it is no longer syscall return value only now.
