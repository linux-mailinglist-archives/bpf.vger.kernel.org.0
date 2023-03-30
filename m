Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21216CFCB7
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 09:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjC3HaF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 03:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjC3HaE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 03:30:04 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3E64224
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 00:30:01 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b20so72875085edd.1
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 00:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680161400;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EA4/EfP9wSlCtySB/qVZexNGzWK3PsyamY+mTpV6Nwc=;
        b=SsDK/zMBeGdQKuoMpIXaimAJeFrD34HODOgw+KW1UOAocyP12/sCoSK/OBmIPOZX9h
         G8Sih+vIimijneI/LJEkF89NNTpuceDCwY8tOpAGK3cWrInwo0c/RFZve6e1ZqrZB5BT
         7UbrzUpI//UkrU2a1nowjqJSGVEpWqIopn+aSMoa5LIj/7e8DQ/jSPP0WpGNlPG6JXsy
         XdcfvgthzzPJ9EXwG44GsweCZHBKu/bil3ds2O04idNNzWhHY9oY0BlOpBt4m8cRLT8/
         +pzHZ1hIzRL5UVsWyfQZIjKspM5hGWJoQXUxtnxP0SZv/Sk1VAr6KfTc0oejVFntHDkD
         sw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680161400;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EA4/EfP9wSlCtySB/qVZexNGzWK3PsyamY+mTpV6Nwc=;
        b=utojd8X6wZSIE/WdszwG2dU1aj+loj717gsRamrlsmQii/BcpVc6Q4sIiMgJwe7KVT
         0031No6L6j6jl96wnj7ZIdaBbKM0iGX7jCCREfk7Hrd0LZHDT1XUWdXTFD1u5sFmEctC
         RfRwSd5TnKGMjKFo2pcTixLm+xAP+KM3t5iy2oYjyjWN482XftPGOvGhZGy69O/s7vEU
         TwUFFfyYMU14an2Pg1zjus56qPuahOdtFc2U3XeMwaBu9Qhc9OWooAB/GVkpHaXQEF/n
         uCGiZZT29yCLxopc6bRCBI0UQA59xvZznr5c6MNluZyFzqO2bF0uV+HfPeYbMjtBDvTi
         R36A==
X-Gm-Message-State: AAQBX9cjkvD33jm9IKqbfE6Og/awJw7rWyN1bfQGE5DNa7v6YpqC0Ayr
        AmniTJqbkTcBodfTMEwq+Zk=
X-Google-Smtp-Source: AKy350Y6PrXz6XtubddTiAB1ymb67OPngxGTyPPSFgXYPHFPImJzoL6yDrBEAKKNsP674ebcfbg0HQ==
X-Received: by 2002:a17:907:a50d:b0:878:481c:c49b with SMTP id vr13-20020a170907a50d00b00878481cc49bmr27031701ejc.1.1680161399928;
        Thu, 30 Mar 2023 00:29:59 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id c5-20020a170906924500b0092be625d981sm17407154ejx.91.2023.03.30.00.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 00:29:59 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 30 Mar 2023 09:29:56 +0200
To:     Jiri Olsa <olsajiri@gmail.com>, Petr Mladek <pmladek@suse.com>,
        Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
Message-ID: <ZCU6dPDXZ0h7hT4w@krava>
References: <cover.1676542796.git.vmalik@redhat.com>
 <e627742ab86ed28632bc9b6c56ef65d7f98eadbc.1676542796.git.vmalik@redhat.com>
 <Y+40os27pQ8det/o@krava>
 <1992d09a-0ef8-66e3-1da0-5d13c2fecc3d@redhat.com>
 <Y+5Q0UK09HsxM4ht@krava>
 <ZBrPMkv8YVRiWwCR@samus.usersys.redhat.com>
 <ZBrxMWfmE/1RG/u0@krava>
 <CAADnVQLwvZyQXyRNn_oaBKx-EH_NauZHTg8+-MOMXo91MibX=A@mail.gmail.com>
 <ZBxbeYZ/+tOtEiNB@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZBxbeYZ/+tOtEiNB@krava>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

ping,

Petr, Zhen, any comment on discussion below?

thanks,
jirka

On Thu, Mar 23, 2023 at 03:00:25PM +0100, Jiri Olsa wrote:
> On Wed, Mar 22, 2023 at 09:03:46AM -0700, Alexei Starovoitov wrote:
> > On Wed, Mar 22, 2023 at 5:14 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Wed, Mar 22, 2023 at 10:49:38AM +0100, Artem Savkov wrote:
> > >
> > > SNIP
> > >
> > > > > > Hm, do we even need to preempt_disable? IIUC, preempt_disable is used
> > > > > > in module kallsyms to prevent taking the module lock b/c kallsyms are
> > > > > > used in the oops path. That shouldn't be an issue here, is that correct?
> > > > >
> > > > > btf_try_get_module calls try_module_get which disables the preemption,
> > > > > so no need to call it in here
> > > >
> > > > It does, but it reenables preemption right away so it is enabled by the
> > > > time we call find_kallsyms_symbol_value(). I am getting the following
> > > > lockdep splat while running module_fentry_shadow test from test_progs.
> > > >
> > > > [   12.017973][  T488] =============================
> > > > [   12.018529][  T488] WARNING: suspicious RCU usage
> > > > [   12.018987][  T488] 6.2.0.bpf-test-13063-g6a9f5cdba3c5 #804 Tainted: G           OE
> > > > [   12.019898][  T488] -----------------------------
> > > > [   12.020391][  T488] kernel/module/kallsyms.c:448 suspicious rcu_dereference_check() usage!
> > > > [   12.021335][  T488]
> > > > [   12.021335][  T488] other info that might help us debug this:
> > > > [   12.021335][  T488]
> > > > [   12.022416][  T488]
> > > > [   12.022416][  T488] rcu_scheduler_active = 2, debug_locks = 1
> > > > [   12.023297][  T488] no locks held by test_progs/488.
> > > > [   12.023854][  T488]
> > > > [   12.023854][  T488] stack backtrace:
> > > > [   12.024336][  T488] CPU: 0 PID: 488 Comm: test_progs Tainted: G           OE      6.2.0.bpf-test-13063-g6a9f5cdba3c5 #804
> > > > [   12.025290][  T488] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.1-2.fc37 04/01/2014
> > > > [   12.026108][  T488] Call Trace:
> > > > [   12.026381][  T488]  <TASK>
> > > > [   12.026649][  T488]  dump_stack_lvl+0xb4/0x110
> > > > [   12.027060][  T488]  lockdep_rcu_suspicious+0x158/0x1f0
> > > > [   12.027541][  T488]  find_kallsyms_symbol_value+0xe8/0x110
> > > > [   12.028028][  T488]  bpf_check_attach_target+0x838/0xa20
> > > > [   12.028511][  T488]  check_attach_btf_id+0x144/0x3f0
> > > > [   12.028957][  T488]  ? __pfx_cmp_subprogs+0x10/0x10
> > > > [   12.029408][  T488]  bpf_check+0xeec/0x1850
> > > > [   12.029799][  T488]  ? ktime_get_with_offset+0x124/0x1d0
> > > > [   12.030247][  T488]  bpf_prog_load+0x87a/0xed0
> > > > [   12.030627][  T488]  ? __lock_release+0x5f/0x160
> > > > [   12.031010][  T488]  ? __might_fault+0x53/0xb0
> > > > [   12.031394][  T488]  ? selinux_bpf+0x6c/0xa0
> > > > [   12.031756][  T488]  __sys_bpf+0x53c/0x1240
> > > > [   12.032115][  T488]  __x64_sys_bpf+0x27/0x40
> > > > [   12.032476][  T488]  do_syscall_64+0x3e/0x90
> > > > [   12.032835][  T488]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > >
> > >
> > > hum, for some reason I can't reproduce, but looks like we need to disable
> > > preemption for find_kallsyms_symbol_value.. could you please check with
> > > patch below?
> > >
> > > also could you please share your .config? not sure why I can't reproduce
> > >
> > > thanks,
> > > jirka
> > >
> > >
> > > ---
> > > diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
> > > index ab2376a1be88..bdc911dbcde5 100644
> > > --- a/kernel/module/kallsyms.c
> > > +++ b/kernel/module/kallsyms.c
> > > @@ -442,7 +442,7 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
> > >  }
> > >
> > >  /* Given a module and name of symbol, find and return the symbol's value */
> > > -unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name)
> > > +static unsigned long __find_kallsyms_symbol_value(struct module *mod, const char *name)
> > >  {
> > >         unsigned int i;
> > >         struct mod_kallsyms *kallsyms = rcu_dereference_sched(mod->kallsyms);
> > > @@ -466,7 +466,7 @@ static unsigned long __module_kallsyms_lookup_name(const char *name)
> > >         if (colon) {
> > >                 mod = find_module_all(name, colon - name, false);
> > >                 if (mod)
> > > -                       return find_kallsyms_symbol_value(mod, colon + 1);
> > > +                       return __find_kallsyms_symbol_value(mod, colon + 1);
> > >                 return 0;
> > >         }
> > >
> > > @@ -475,7 +475,7 @@ static unsigned long __module_kallsyms_lookup_name(const char *name)
> > >
> > >                 if (mod->state == MODULE_STATE_UNFORMED)
> > >                         continue;
> > > -               ret = find_kallsyms_symbol_value(mod, name);
> > > +               ret = __find_kallsyms_symbol_value(mod, name);
> > >                 if (ret)
> > >                         return ret;
> > >         }
> > > @@ -494,6 +494,16 @@ unsigned long module_kallsyms_lookup_name(const char *name)
> > >         return ret;
> > >  }
> > >
> > > +unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name)
> > > +{
> > > +       unsigned long ret;
> > > +
> > > +       preempt_disable();
> > > +       ret = __find_kallsyms_symbol_value(mod, name);
> > > +       preempt_enable();
> > > +       return ret;
> > > +}
> > 
> > That doesn't look right.
> > I think the issue is misuse of rcu_dereference_sched in
> > find_kallsyms_symbol_value.
> 
> it seems to be using rcu pointer to keep symbols for module init time and
> then core symbols for after init.. and switch between them when module is
> loaded, hence the strange rcu usage I think
> 
> Petr, Zhen, any idea/insight?
> 
> thanks,
> jirka
