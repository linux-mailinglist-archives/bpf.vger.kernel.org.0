Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5753E53D783
	for <lists+bpf@lfdr.de>; Sat,  4 Jun 2022 17:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237417AbiFDPhE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Jun 2022 11:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237347AbiFDPhD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Jun 2022 11:37:03 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D116521BE
        for <bpf@vger.kernel.org>; Sat,  4 Jun 2022 08:37:01 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 25so13310806edw.8
        for <bpf@vger.kernel.org>; Sat, 04 Jun 2022 08:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=V22ZXHip9SCDa+6YauuaSnDPcl/SFLIeNWzWF5tFDcM=;
        b=WPGvdRzB+4frAc8o4+8+VpF+BVkjXV7dxWRccSDcCqeIO7Ku4txlMm8MYl+eOc1VeE
         cpGL3stPdSshdoV+SKpdsEWqy/0cLT876feojFdqU3pykE8gGNuBGpEu9kkLmEeFYYW3
         PbCMwOsNWkUADoLnIsN/TDQT4+mdOThIu4fXRBcwZWVsnjrTXiCQuuxPIR+mJyTWr9tg
         x6R0bHbTkS2rRSc+iwNu1uQdAEp7/nwSkpzPBWH/b1dvBJPquNl5nQpU6rmx9IWFXnxx
         DUQ1kIL6gEzOKdfMJC5mGgn8Pu/GxxnjbG4FUpIwEzQH77+wrFoR8hgERYAKPGHmItxL
         zI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=V22ZXHip9SCDa+6YauuaSnDPcl/SFLIeNWzWF5tFDcM=;
        b=Cdf0a3s0HY4DGuWiXAH1wmkylV7TNh19GcM3N+Hgxj4AreuklQbOC+VUDJFlMYS6Hl
         dRRyFfAhINAvmaaPgZ6tZ6SsdE0s8Ug0M/6Rq/a/MzUHdza+u5Vy4ub+LV1S+ksp5IOt
         Rw8sY12tVyvXJOTvASu5Z/JOzVRlm8KA9R46kTJhp9P722BQ6kdEXgdqDnOVfJIWxWlV
         u82CpVdqkt/mMPMPu9x14TVzhOnAWOOYOeXJKm+5g3+R6dWhKLQBfnc87piEph8hjRrm
         UZZTeJAZLdmZNmQW5E3bOb5on1BcrnB95Fhd4pPXMcEUqvT7ZJWrNByPb/AFOi+u+NE4
         UjrA==
X-Gm-Message-State: AOAM530GfedyFcIvU2nj+CiUlen5+c6QK6Ffar0J4fA5IiqPYEe/G8Y7
        HcShVdZ6zBRDU0dNrRdCwAE=
X-Google-Smtp-Source: ABdhPJztxs6G7aAR/hN3uiiBizZEdNZdU1Nm2koWTVXVBJE9O/HIhckZ4TSfhvKSbSrBYbsRnYglXw==
X-Received: by 2002:a05:6402:51d3:b0:428:ce4a:69b with SMTP id r19-20020a05640251d300b00428ce4a069bmr17334326edd.72.1654357020290;
        Sat, 04 Jun 2022 08:37:00 -0700 (PDT)
Received: from pluto (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id me3-20020a170906aec300b006ff01fbb7ccsm4099136ejb.40.2022.06.04.08.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 08:36:59 -0700 (PDT)
Message-ID: <04ff6e17e031becc8652b461ff465106b7c4024e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 3/5] bpf: Inline calls to bpf_loop when
 callback is known
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, song@kernel.org
Date:   Sat, 04 Jun 2022 18:36:57 +0300
In-Reply-To: <20220604144707.d7ehrmys5xeijba4@MacBook-Pro-3.local>
References: <20220603141047.2163170-1-eddyz87@gmail.com>
         <20220603141047.2163170-4-eddyz87@gmail.com>
         <20220604144707.d7ehrmys5xeijba4@MacBook-Pro-3.local>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Alexei,

> On Sat, 2022-06-04 at 16:47 +0200, Alexei Starovoitov wrote:
> > On Fri, Jun 03, 2022 at 05:10:45PM +0300, Eduard Zingerman wrote:
[...]
> > +		if (fit_for_bpf_loop_inline(aux)) {
> > +			if (!subprog_updated) {
> > +				subprog_updated = true;
> > +				subprogs[cur_subprog].stack_depth += BPF_REG_SIZE * 3;
> 
> Instead of doing += and keeping track that the stack was increased
> (if multiple bpf_loop happened to be in a function)
> may be add subprogs[..].stack_depth_extra variable ?
> And unconditionally do subprogs[cur_subprog].stack_depth_extra = BPF_REG_SIZE * 3;
> every time bpf_loop is seen?
> Then we can do that during inline_bpf_loop().
[...]
> > @@ -12963,6 +13047,8 @@ static int adjust_subprog_starts_after_remove(struct bpf_verifier_env *env,
> >  			 * in adjust_btf_func() - no need to adjust
> >  			 */
> >  		}
> > +
> > +		adjust_loop_inline_subprogno(env, i, j);
> 
> This special case isn't great.
> May be let's do inline_bpf_loop() earlier?
> Instead of doing it from do_misc_fixups() how about doing it as a separate
> pass right after check_max_stack_depth() ?
> Then opt_remove_dead_code() will adjust BPF_CALL_REL automatically
> as a part of bpf_adj_branches().
[...]
> >  	if (ret == 0)
> >  		ret = check_max_stack_depth(env);
> >  
> > +	if (ret == 0)
> > +		adjust_stack_depth_for_loop_inlining(env);
> 
> With above two suggestions this will become
> if (ret == 0)
>     optimize_bpf_loop(env);
> 
> where it will call inline_bpf_loop() and will assign max_depth_extra.
> And then one extra loop for_each_subporg() max_depth += max_depth_extra.
> 
> wdyt?

I will proceed with the suggested rewrite, it simplifies a few things,
thank you!

> Also is there a test for multiple bpf_loop in a func?

Yes, please see the test case "bpf_loop_inline stack locations for
loop vars" in the patch "v3 4/5" from this series.

Also, please note Joanne's comment from a sibiling thread:

> > +       if (ret == 0)
> > +               adjust_stack_depth_for_loop_inlining(env);
> 
> Do we need to do this before the check_max_stack_depth() call above
> since adjust_stack_depth_for_loop_inlining() adjusts the stack depth?

In short, what is the meaning of the `MAX_BPF_STACK` variable?

- Is it a hard limit on BPF program stack size?

  If so, `optimize_bpf_loop` should skip the optimization if not
  enough stack space is available. But this makes optimization a bit
  'flaky'. This could be achieved by passing maximal stack depth
  computed by `check_max_stack_depth` to `optimize_bpf_loop`.

- Or is it a soft limit used by verifier to guarantee that stack space
  needed by the BPF program is limited?
  
  If so, `optimize_bpf_loop` might be executed after
  `check_max_stack_depth` w/o any data passed from one to another. But
  this would mean that for some programs actual stack usage would be
  `MAX_BPF_STACK + 24*N`. Where N is a number of functions with
  inlined loops (which is easier to compute than the max number of
  functions with inlined loop that can occur on a same stack trace).
  
  This might affect the following portion of the `do_misc_fixups`:
  
 static int do_misc_fixups(struct bpf_verifier_env *env) {
	...
		if (insn->imm == BPF_FUNC_tail_call) {
			/* If we tail call into other programs, we
			 * cannot make any assumptions since they can
			 * be replaced dynamically during runtime in
			 * the program array.
			 */
			prog->cb_access = 1;
			if (!allow_tail_call_in_subprogs(env))
here ---->     			prog->aux->stack_depth = MAX_BPF_STACK;
			...
		}
	...
 }

Thanks,
Eduard

