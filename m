Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A146C6A58
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 15:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjCWOBf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Mar 2023 10:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjCWOBP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 10:01:15 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB9B38B72
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 07:00:33 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id y14so20622733wrq.4
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 07:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679580028;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aD5dgg32lUHch62xwzd5QkGTM33R6/TU2XSBbE44wd0=;
        b=XlkqvU5i5UxhspJxeSJg3HEL8ig5lurJckjC40VTqd8J+Xv2dE8s5m58ZHrAjCtgTi
         ywcdRcUxd4nQUnjfhRSI2npY/wKNlxFyLDFDvgr0qGDSDPsyyQvYWkT7wWqRhdj++GXZ
         AbDiKSMIewzRD1N82xxI2blkfCM4DxzjPqThcLoIR35qNB7d+x6MJTYXWhZ29oCGmwFB
         ESXdhsbbXi8rab9ZBgINYQqwDjHwNXHhKa2ruwLGZYRz89yhvlvvQV0+Z4i7A8qREV+9
         XBPupvanF9CirBN2KhOQav8CB7O+IoAmDN9fHz3F/dxkeOlDo1rtH/Tz0406we6xB7r5
         qsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679580028;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aD5dgg32lUHch62xwzd5QkGTM33R6/TU2XSBbE44wd0=;
        b=KnHEF7E6Ut47pzfGQwsptSYnL4nWz9R23vtM/ULDmrgwqlGXeysaK4PHNija3FezZP
         fCLhGOynEe9HoPYFPyFdHZOh0Jg8I/yBQ/9chKPwQe44O0tX+iFoX+ebT+tZlDU3POMr
         mp0hrZXrMZtgw1kAZNRRc8bI8zePQwn5tVa+GDXGwurBwMutiaA0zBwhPP0+Y/dcrO6E
         xGcAyHzujxmSyamhbxXigoOwbyuqEb840qXh43rH/9NeLfdLYNr0FedKfZ2dzH1Ri0Pz
         t5TiOb7z2zKMnERJBtI7FmYd3WbsmAhFwT1P3rT0jLJDUJl/+MK8yapcr2dzjZ6hGhHf
         zdng==
X-Gm-Message-State: AAQBX9fDqKLC7+Etxzd2I3RfYZ1P9s+FljLc3XeohLCCzeZXXymaDWDO
        Oz22jCC19ztjdWForrCe6XsDlyYtS0lOWlpLKUE=
X-Google-Smtp-Source: AKy350Zxy+DNgd0WQmo0O6Ks6f+DwYf4c3Gf0dxBJOrI0D29ZVkUSapQQ2ZgJ+svTtCbY5Jk8dtGsQ==
X-Received: by 2002:adf:ffca:0:b0:2bf:f4f7:be9c with SMTP id x10-20020adfffca000000b002bff4f7be9cmr2465613wrs.14.1679580027886;
        Thu, 23 Mar 2023 07:00:27 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a7-20020a5d5087000000b002c55306f6edsm16177563wrt.54.2023.03.23.07.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 07:00:27 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 23 Mar 2023 15:00:25 +0100
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, Viktor Malik <vmalik@redhat.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
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
Message-ID: <ZBxbeYZ/+tOtEiNB@krava>
References: <cover.1676542796.git.vmalik@redhat.com>
 <e627742ab86ed28632bc9b6c56ef65d7f98eadbc.1676542796.git.vmalik@redhat.com>
 <Y+40os27pQ8det/o@krava>
 <1992d09a-0ef8-66e3-1da0-5d13c2fecc3d@redhat.com>
 <Y+5Q0UK09HsxM4ht@krava>
 <ZBrPMkv8YVRiWwCR@samus.usersys.redhat.com>
 <ZBrxMWfmE/1RG/u0@krava>
 <CAADnVQLwvZyQXyRNn_oaBKx-EH_NauZHTg8+-MOMXo91MibX=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLwvZyQXyRNn_oaBKx-EH_NauZHTg8+-MOMXo91MibX=A@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 22, 2023 at 09:03:46AM -0700, Alexei Starovoitov wrote:
> On Wed, Mar 22, 2023 at 5:14 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Wed, Mar 22, 2023 at 10:49:38AM +0100, Artem Savkov wrote:
> >
> > SNIP
> >
> > > > > Hm, do we even need to preempt_disable? IIUC, preempt_disable is used
> > > > > in module kallsyms to prevent taking the module lock b/c kallsyms are
> > > > > used in the oops path. That shouldn't be an issue here, is that correct?
> > > >
> > > > btf_try_get_module calls try_module_get which disables the preemption,
> > > > so no need to call it in here
> > >
> > > It does, but it reenables preemption right away so it is enabled by the
> > > time we call find_kallsyms_symbol_value(). I am getting the following
> > > lockdep splat while running module_fentry_shadow test from test_progs.
> > >
> > > [   12.017973][  T488] =============================
> > > [   12.018529][  T488] WARNING: suspicious RCU usage
> > > [   12.018987][  T488] 6.2.0.bpf-test-13063-g6a9f5cdba3c5 #804 Tainted: G           OE
> > > [   12.019898][  T488] -----------------------------
> > > [   12.020391][  T488] kernel/module/kallsyms.c:448 suspicious rcu_dereference_check() usage!
> > > [   12.021335][  T488]
> > > [   12.021335][  T488] other info that might help us debug this:
> > > [   12.021335][  T488]
> > > [   12.022416][  T488]
> > > [   12.022416][  T488] rcu_scheduler_active = 2, debug_locks = 1
> > > [   12.023297][  T488] no locks held by test_progs/488.
> > > [   12.023854][  T488]
> > > [   12.023854][  T488] stack backtrace:
> > > [   12.024336][  T488] CPU: 0 PID: 488 Comm: test_progs Tainted: G           OE      6.2.0.bpf-test-13063-g6a9f5cdba3c5 #804
> > > [   12.025290][  T488] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.1-2.fc37 04/01/2014
> > > [   12.026108][  T488] Call Trace:
> > > [   12.026381][  T488]  <TASK>
> > > [   12.026649][  T488]  dump_stack_lvl+0xb4/0x110
> > > [   12.027060][  T488]  lockdep_rcu_suspicious+0x158/0x1f0
> > > [   12.027541][  T488]  find_kallsyms_symbol_value+0xe8/0x110
> > > [   12.028028][  T488]  bpf_check_attach_target+0x838/0xa20
> > > [   12.028511][  T488]  check_attach_btf_id+0x144/0x3f0
> > > [   12.028957][  T488]  ? __pfx_cmp_subprogs+0x10/0x10
> > > [   12.029408][  T488]  bpf_check+0xeec/0x1850
> > > [   12.029799][  T488]  ? ktime_get_with_offset+0x124/0x1d0
> > > [   12.030247][  T488]  bpf_prog_load+0x87a/0xed0
> > > [   12.030627][  T488]  ? __lock_release+0x5f/0x160
> > > [   12.031010][  T488]  ? __might_fault+0x53/0xb0
> > > [   12.031394][  T488]  ? selinux_bpf+0x6c/0xa0
> > > [   12.031756][  T488]  __sys_bpf+0x53c/0x1240
> > > [   12.032115][  T488]  __x64_sys_bpf+0x27/0x40
> > > [   12.032476][  T488]  do_syscall_64+0x3e/0x90
> > > [   12.032835][  T488]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> >
> >
> > hum, for some reason I can't reproduce, but looks like we need to disable
> > preemption for find_kallsyms_symbol_value.. could you please check with
> > patch below?
> >
> > also could you please share your .config? not sure why I can't reproduce
> >
> > thanks,
> > jirka
> >
> >
> > ---
> > diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
> > index ab2376a1be88..bdc911dbcde5 100644
> > --- a/kernel/module/kallsyms.c
> > +++ b/kernel/module/kallsyms.c
> > @@ -442,7 +442,7 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
> >  }
> >
> >  /* Given a module and name of symbol, find and return the symbol's value */
> > -unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name)
> > +static unsigned long __find_kallsyms_symbol_value(struct module *mod, const char *name)
> >  {
> >         unsigned int i;
> >         struct mod_kallsyms *kallsyms = rcu_dereference_sched(mod->kallsyms);
> > @@ -466,7 +466,7 @@ static unsigned long __module_kallsyms_lookup_name(const char *name)
> >         if (colon) {
> >                 mod = find_module_all(name, colon - name, false);
> >                 if (mod)
> > -                       return find_kallsyms_symbol_value(mod, colon + 1);
> > +                       return __find_kallsyms_symbol_value(mod, colon + 1);
> >                 return 0;
> >         }
> >
> > @@ -475,7 +475,7 @@ static unsigned long __module_kallsyms_lookup_name(const char *name)
> >
> >                 if (mod->state == MODULE_STATE_UNFORMED)
> >                         continue;
> > -               ret = find_kallsyms_symbol_value(mod, name);
> > +               ret = __find_kallsyms_symbol_value(mod, name);
> >                 if (ret)
> >                         return ret;
> >         }
> > @@ -494,6 +494,16 @@ unsigned long module_kallsyms_lookup_name(const char *name)
> >         return ret;
> >  }
> >
> > +unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name)
> > +{
> > +       unsigned long ret;
> > +
> > +       preempt_disable();
> > +       ret = __find_kallsyms_symbol_value(mod, name);
> > +       preempt_enable();
> > +       return ret;
> > +}
> 
> That doesn't look right.
> I think the issue is misuse of rcu_dereference_sched in
> find_kallsyms_symbol_value.

it seems to be using rcu pointer to keep symbols for module init time and
then core symbols for after init.. and switch between them when module is
loaded, hence the strange rcu usage I think

Petr, Zhen, any idea/insight?

thanks,
jirka
