Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A216D106B
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 22:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjC3U7T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 16:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjC3U7S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 16:59:18 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E05CDFD
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 13:59:16 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso12643192wmo.0
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 13:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680209955;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z62lhEF812RohRzl6GrU0HNPBWyCyWRe9LiASd6oZeA=;
        b=mwbdV5XakQ1KlY/hO03ePyXVOQtX332dOXXB7aJ8qumnoTvc031k6maYPQWaK/681Y
         aP8TCGjv7Ns9+PpR8J006Ug1eaAbZrKy4cD0FJIs20axh0xd8gjLnmNdl5jpCHE3eDGw
         l0AbZR9i53s3x9UIbX39oRBwYljfbvylfkkSwhswujFeW7Dj5EP/lLiQlYZQfZ3Vur1h
         1OwOPuh/hY89Z2soxNWvCJTCJOIJyc1BaNc6fxNBSq+d6nXJmGO2OxEaYyRlTJewwO9m
         b0CzqjJXjO3/YIBjWdZuL3r2PesYxz6OHsE7nAI+/5qN+M/5g5Q0WZi/r5aXHHIHKtAm
         EBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680209955;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z62lhEF812RohRzl6GrU0HNPBWyCyWRe9LiASd6oZeA=;
        b=ieMVoZNSwMNAIBqsxQ21r6tpZ7UB8VY5HRzJ+cCU74NXWiOTseriXUad5MjLicrdcj
         jqavDrS1cu1jrVrk9OguCXd+OHib5e6122FdO7ZtWxLk1Wh50tN8kXLYFvHPRipYbxli
         WrQp8TIHgN1JnvKT24HnTcSBGVYOj62XSfVbBW6Eb963Vs2uhxoqYsos8+HKnib76JPZ
         lUQlxGWxM/4S8FKqKiuf9oVBfgIRf4MVn2Wp9vYu6EpTHgqoyiXjYCykVPyjM5FNjv2z
         UWtEh3VS9SvmCQJGjmtH1yk341MRAam7Gi34foA5whpXnnxnL+u6JnVtYLYqi82w2LU0
         0diQ==
X-Gm-Message-State: AAQBX9eYLJCn5Y5P/0+vcxlfRXAW2rqYClUxF+C4AHb4nlvdniSZBaFY
        TWSGiQJpi7rBwvRjtLA1pFI=
X-Google-Smtp-Source: AKy350b3JtUS12VUMrmNruLN8ShxX5HPpISyhCo8ZfbCMtKbK5NEM1QViiyzDlGbUztF/Ucofv8JSA==
X-Received: by 2002:a05:600c:2313:b0:3eb:2e27:2d0c with SMTP id 19-20020a05600c231300b003eb2e272d0cmr5751604wmo.1.1680209955076;
        Thu, 30 Mar 2023 13:59:15 -0700 (PDT)
Received: from krava ([83.240.63.154])
        by smtp.gmail.com with ESMTPSA id s17-20020a05600c45d100b003ed51cdb94csm7448340wmo.26.2023.03.30.13.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 13:59:14 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 30 Mar 2023 22:59:12 +0200
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, Petr Mladek <pmladek@suse.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Viktor Malik <vmalik@redhat.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH bpf-next v6 1/2] bpf: Fix attaching
 fentry/fexit/fmod_ret/lsm to modules
Message-ID: <ZCX4IMGp/aalXHSL@krava>
References: <e627742ab86ed28632bc9b6c56ef65d7f98eadbc.1676542796.git.vmalik@redhat.com>
 <Y+40os27pQ8det/o@krava>
 <1992d09a-0ef8-66e3-1da0-5d13c2fecc3d@redhat.com>
 <Y+5Q0UK09HsxM4ht@krava>
 <ZBrPMkv8YVRiWwCR@samus.usersys.redhat.com>
 <ZBrxMWfmE/1RG/u0@krava>
 <CAADnVQLwvZyQXyRNn_oaBKx-EH_NauZHTg8+-MOMXo91MibX=A@mail.gmail.com>
 <ZBxbeYZ/+tOtEiNB@krava>
 <ZCU6dPDXZ0h7hT4w@krava>
 <98077109-02be-a708-cde7-5dc827e1f3ea@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98077109-02be-a708-cde7-5dc827e1f3ea@huawei.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 30, 2023 at 08:26:41PM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2023/3/30 15:29, Jiri Olsa wrote:
> > ping,
> > 
> > Petr, Zhen, any comment on discussion below?
> > 
> > thanks,
> > jirka
> > 
> > On Thu, Mar 23, 2023 at 03:00:25PM +0100, Jiri Olsa wrote:
> >> On Wed, Mar 22, 2023 at 09:03:46AM -0700, Alexei Starovoitov wrote:
> >>> On Wed, Mar 22, 2023 at 5:14 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >>>>
> >>>> On Wed, Mar 22, 2023 at 10:49:38AM +0100, Artem Savkov wrote:
> >>>>
> >>>> SNIP
> >>>>
> >>>>>>> Hm, do we even need to preempt_disable? IIUC, preempt_disable is used
> >>>>>>> in module kallsyms to prevent taking the module lock b/c kallsyms are
> >>>>>>> used in the oops path. That shouldn't be an issue here, is that correct?
> >>>>>>
> >>>>>> btf_try_get_module calls try_module_get which disables the preemption,
> >>>>>> so no need to call it in here
> >>>>>
> >>>>> It does, but it reenables preemption right away so it is enabled by the
> >>>>> time we call find_kallsyms_symbol_value(). I am getting the following
> >>>>> lockdep splat while running module_fentry_shadow test from test_progs.
> >>>>>
> >>>>> [   12.017973][  T488] =============================
> >>>>> [   12.018529][  T488] WARNING: suspicious RCU usage
> >>>>> [   12.018987][  T488] 6.2.0.bpf-test-13063-g6a9f5cdba3c5 #804 Tainted: G           OE
> >>>>> [   12.019898][  T488] -----------------------------
> >>>>> [   12.020391][  T488] kernel/module/kallsyms.c:448 suspicious rcu_dereference_check() usage!
> >>>>> [   12.021335][  T488]
> >>>>> [   12.021335][  T488] other info that might help us debug this:
> >>>>> [   12.021335][  T488]
> >>>>> [   12.022416][  T488]
> >>>>> [   12.022416][  T488] rcu_scheduler_active = 2, debug_locks = 1
> >>>>> [   12.023297][  T488] no locks held by test_progs/488.
> >>>>> [   12.023854][  T488]
> >>>>> [   12.023854][  T488] stack backtrace:
> >>>>> [   12.024336][  T488] CPU: 0 PID: 488 Comm: test_progs Tainted: G           OE      6.2.0.bpf-test-13063-g6a9f5cdba3c5 #804
> >>>>> [   12.025290][  T488] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.1-2.fc37 04/01/2014
> >>>>> [   12.026108][  T488] Call Trace:
> >>>>> [   12.026381][  T488]  <TASK>
> >>>>> [   12.026649][  T488]  dump_stack_lvl+0xb4/0x110
> >>>>> [   12.027060][  T488]  lockdep_rcu_suspicious+0x158/0x1f0
> >>>>> [   12.027541][  T488]  find_kallsyms_symbol_value+0xe8/0x110
> >>>>> [   12.028028][  T488]  bpf_check_attach_target+0x838/0xa20
> >>>>> [   12.028511][  T488]  check_attach_btf_id+0x144/0x3f0
> >>>>> [   12.028957][  T488]  ? __pfx_cmp_subprogs+0x10/0x10
> >>>>> [   12.029408][  T488]  bpf_check+0xeec/0x1850
> >>>>> [   12.029799][  T488]  ? ktime_get_with_offset+0x124/0x1d0
> >>>>> [   12.030247][  T488]  bpf_prog_load+0x87a/0xed0
> >>>>> [   12.030627][  T488]  ? __lock_release+0x5f/0x160
> >>>>> [   12.031010][  T488]  ? __might_fault+0x53/0xb0
> >>>>> [   12.031394][  T488]  ? selinux_bpf+0x6c/0xa0
> >>>>> [   12.031756][  T488]  __sys_bpf+0x53c/0x1240
> >>>>> [   12.032115][  T488]  __x64_sys_bpf+0x27/0x40
> >>>>> [   12.032476][  T488]  do_syscall_64+0x3e/0x90
> >>>>> [   12.032835][  T488]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> >>>>
> >>>>
> >>>> hum, for some reason I can't reproduce, but looks like we need to disable
> >>>> preemption for find_kallsyms_symbol_value.. could you please check with
> >>>> patch below?
> >>>>
> >>>> also could you please share your .config? not sure why I can't reproduce
> >>>>
> >>>> thanks,
> >>>> jirka
> >>>>
> >>>>
> >>>> ---
> >>>> diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
> >>>> index ab2376a1be88..bdc911dbcde5 100644
> >>>> --- a/kernel/module/kallsyms.c
> >>>> +++ b/kernel/module/kallsyms.c
> >>>> @@ -442,7 +442,7 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
> >>>>  }
> >>>>
> >>>>  /* Given a module and name of symbol, find and return the symbol's value */
> >>>> -unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name)
> >>>> +static unsigned long __find_kallsyms_symbol_value(struct module *mod, const char *name)
> >>>>  {
> >>>>         unsigned int i;
> >>>>         struct mod_kallsyms *kallsyms = rcu_dereference_sched(mod->kallsyms);
> >>>> @@ -466,7 +466,7 @@ static unsigned long __module_kallsyms_lookup_name(const char *name)
> >>>>         if (colon) {
> >>>>                 mod = find_module_all(name, colon - name, false);
> >>>>                 if (mod)
> >>>> -                       return find_kallsyms_symbol_value(mod, colon + 1);
> >>>> +                       return __find_kallsyms_symbol_value(mod, colon + 1);
> >>>>                 return 0;
> >>>>         }
> >>>>
> >>>> @@ -475,7 +475,7 @@ static unsigned long __module_kallsyms_lookup_name(const char *name)
> >>>>
> >>>>                 if (mod->state == MODULE_STATE_UNFORMED)
> >>>>                         continue;
> >>>> -               ret = find_kallsyms_symbol_value(mod, name);
> >>>> +               ret = __find_kallsyms_symbol_value(mod, name);
> >>>>                 if (ret)
> >>>>                         return ret;
> >>>>         }
> >>>> @@ -494,6 +494,16 @@ unsigned long module_kallsyms_lookup_name(const char *name)
> >>>>         return ret;
> >>>>  }
> >>>>
> >>>> +unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name)
> >>>> +{
> >>>> +       unsigned long ret;
> >>>> +
> >>>> +       preempt_disable();
> >>>> +       ret = __find_kallsyms_symbol_value(mod, name);
> >>>> +       preempt_enable();
> >>>> +       return ret;
> >>>> +}
> >>>
> >>> That doesn't look right.
> >>> I think the issue is misuse of rcu_dereference_sched in
> >>> find_kallsyms_symbol_value.
> >>
> >> it seems to be using rcu pointer to keep symbols for module init time and
> >> then core symbols for after init.. and switch between them when module is
> >> loaded, hence the strange rcu usage I think
> >>
> >> Petr, Zhen, any idea/insight?
> 
> Commit 91fb02f31505 ("module: Move kallsyms support into a separate file") hides
> the answer. find_kallsyms_symbol_value() was originally a static function, and it
> is only called by module_kallsyms_lookup_name() and is preemptive-protected.
> 
> Now that we've added a call to function find_kallsyms_symbol_value(), it seems like
> we should do the same thing as function module_kallsyms_lookup_name().
> 
> Like this?
> +				mod = btf_try_get_module(btf);
> +				if (mod) {
> +					preempt_disable();
> +					addr = find_kallsyms_symbol_value(mod, tname);
> +					preempt_enable();
> +				} else
> +					addr = 0;

yes, that's what I did above, but I was just curious about the strange
RCU usage Alexei commented on earlier:

	>>> +unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name)
	>>> +{
	>>> +       unsigned long ret;
	>>> +
	>>> +       preempt_disable();
	>>> +       ret = __find_kallsyms_symbol_value(mod, name);
	>>> +       preempt_enable();
	>>> +       return ret;
	>>> +}
	>>
	>> That doesn't look right.
	>> I think the issue is misuse of rcu_dereference_sched in
	>> find_kallsyms_symbol_value.
	>
	> it seems to be using rcu pointer to keep symbols for module init time and
	> then core symbols for after init.. and switch between them when module is
	> loaded, hence the strange rcu usage I think
	>
	> Petr, Zhen, any idea/insight?

thanks,
jirka
