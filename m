Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C2B6C4FF4
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 17:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjCVQEE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 12:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjCVQEC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 12:04:02 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB9D2CC57
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 09:03:59 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id h8so74978740ede.8
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 09:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679501037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vscEBiKqsGLJ/zWlSO8GR+b8WydVmddxW1sG/+dqHNI=;
        b=W5zaP6HfyO2f4ZnDXzKvtKf6Tw6ujmHMDl2ze1dibMUsbNnRzMUIplCBhWOU/tBHsX
         I33J96o69HnXDkUYohvfhsJHGRz2CV9/bEPisRksC+9t3v1MxBZXq7pbSj1THGt+opLY
         eyx6ZP5rnOsztYHzJL83uVRYr/u2SlsyMrYcB1SUTlU1lQhQYHofOyn0POqiaha4/XfI
         Ep45gINoziUd6u4cB5MpoJfcJulkqdGGCs1CX3iHme/PbcH18fCVHDGStJmzaZQ4lSko
         nYiLK8oshfZPK7fgF7o7bt4VXNVMqb8kf9JQcAk1bMFYTjavycVmyTVgcRojCg9oPGXr
         +QoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679501037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vscEBiKqsGLJ/zWlSO8GR+b8WydVmddxW1sG/+dqHNI=;
        b=ZlgZCa2nnFJ0nUMlxAgsJy1d3RghaqEwn6cMTeOxUAejhkZTk+DPcjAdJIGzSVGXNb
         DuMctWcr9y9tV5JhNXVaMIkt90YCqoNQ+uvKzy3D6v8ettKOqI31EwEZeMvu7A5mUK+v
         kolNoOAw8+A+eA1JJZzbCCXHkJCxjZIzgZlrlBTYQbhUm0+Bh/xGUqgZgOAcVnH6Qs3J
         b88wKFeoiRYk6G4LxGJF0MXCmY2Bvk7zJaNy+xbZNb5arMzUW+I8PlMdSKp8CWbKR+zZ
         3/Dm8LgUIr/UfSDljM3eMbrIUBCbtk5wB2LgqW1t9uSZ0sa24M1y3LkMAeUyO/3VF3DF
         b8YQ==
X-Gm-Message-State: AO0yUKXZGRfEgFINYUiLhZh36eBl0cW5wlbIwzTCrXYHrTFqrdsv6aje
        f58SnaRRcFEXl2JCmkP3FFYz+O3D3utNRSQrbqM=
X-Google-Smtp-Source: AK7set/PzqqU7t0FZNCKkAbmTQjg0exeq5kWTMjfICHZd34Hw/dlefC2v1KfT3eZr7TCxGPSwBDgDQBq8/LbGUoiE+I=
X-Received: by 2002:a17:906:2f02:b0:877:747d:4a85 with SMTP id
 v2-20020a1709062f0200b00877747d4a85mr3568984eji.3.1679501037334; Wed, 22 Mar
 2023 09:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1676542796.git.vmalik@redhat.com> <e627742ab86ed28632bc9b6c56ef65d7f98eadbc.1676542796.git.vmalik@redhat.com>
 <Y+40os27pQ8det/o@krava> <1992d09a-0ef8-66e3-1da0-5d13c2fecc3d@redhat.com>
 <Y+5Q0UK09HsxM4ht@krava> <ZBrPMkv8YVRiWwCR@samus.usersys.redhat.com> <ZBrxMWfmE/1RG/u0@krava>
In-Reply-To: <ZBrxMWfmE/1RG/u0@krava>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 22 Mar 2023 09:03:46 -0700
Message-ID: <CAADnVQLwvZyQXyRNn_oaBKx-EH_NauZHTg8+-MOMXo91MibX=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/2] bpf: Fix attaching fentry/fexit/fmod_ret/lsm
 to modules
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Viktor Malik <vmalik@redhat.com>, bpf <bpf@vger.kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 22, 2023 at 5:14=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Wed, Mar 22, 2023 at 10:49:38AM +0100, Artem Savkov wrote:
>
> SNIP
>
> > > > Hm, do we even need to preempt_disable? IIUC, preempt_disable is us=
ed
> > > > in module kallsyms to prevent taking the module lock b/c kallsyms a=
re
> > > > used in the oops path. That shouldn't be an issue here, is that cor=
rect?
> > >
> > > btf_try_get_module calls try_module_get which disables the preemption=
,
> > > so no need to call it in here
> >
> > It does, but it reenables preemption right away so it is enabled by the
> > time we call find_kallsyms_symbol_value(). I am getting the following
> > lockdep splat while running module_fentry_shadow test from test_progs.
> >
> > [   12.017973][  T488] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [   12.018529][  T488] WARNING: suspicious RCU usage
> > [   12.018987][  T488] 6.2.0.bpf-test-13063-g6a9f5cdba3c5 #804 Tainted:=
 G           OE
> > [   12.019898][  T488] -----------------------------
> > [   12.020391][  T488] kernel/module/kallsyms.c:448 suspicious rcu_dere=
ference_check() usage!
> > [   12.021335][  T488]
> > [   12.021335][  T488] other info that might help us debug this:
> > [   12.021335][  T488]
> > [   12.022416][  T488]
> > [   12.022416][  T488] rcu_scheduler_active =3D 2, debug_locks =3D 1
> > [   12.023297][  T488] no locks held by test_progs/488.
> > [   12.023854][  T488]
> > [   12.023854][  T488] stack backtrace:
> > [   12.024336][  T488] CPU: 0 PID: 488 Comm: test_progs Tainted: G     =
      OE      6.2.0.bpf-test-13063-g6a9f5cdba3c5 #804
> > [   12.025290][  T488] Hardware name: QEMU Standard PC (i440FX + PIIX, =
1996), BIOS 1.16.1-2.fc37 04/01/2014
> > [   12.026108][  T488] Call Trace:
> > [   12.026381][  T488]  <TASK>
> > [   12.026649][  T488]  dump_stack_lvl+0xb4/0x110
> > [   12.027060][  T488]  lockdep_rcu_suspicious+0x158/0x1f0
> > [   12.027541][  T488]  find_kallsyms_symbol_value+0xe8/0x110
> > [   12.028028][  T488]  bpf_check_attach_target+0x838/0xa20
> > [   12.028511][  T488]  check_attach_btf_id+0x144/0x3f0
> > [   12.028957][  T488]  ? __pfx_cmp_subprogs+0x10/0x10
> > [   12.029408][  T488]  bpf_check+0xeec/0x1850
> > [   12.029799][  T488]  ? ktime_get_with_offset+0x124/0x1d0
> > [   12.030247][  T488]  bpf_prog_load+0x87a/0xed0
> > [   12.030627][  T488]  ? __lock_release+0x5f/0x160
> > [   12.031010][  T488]  ? __might_fault+0x53/0xb0
> > [   12.031394][  T488]  ? selinux_bpf+0x6c/0xa0
> > [   12.031756][  T488]  __sys_bpf+0x53c/0x1240
> > [   12.032115][  T488]  __x64_sys_bpf+0x27/0x40
> > [   12.032476][  T488]  do_syscall_64+0x3e/0x90
> > [   12.032835][  T488]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
>
>
> hum, for some reason I can't reproduce, but looks like we need to disable
> preemption for find_kallsyms_symbol_value.. could you please check with
> patch below?
>
> also could you please share your .config? not sure why I can't reproduce
>
> thanks,
> jirka
>
>
> ---
> diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
> index ab2376a1be88..bdc911dbcde5 100644
> --- a/kernel/module/kallsyms.c
> +++ b/kernel/module/kallsyms.c
> @@ -442,7 +442,7 @@ int module_get_kallsym(unsigned int symnum, unsigned =
long *value, char *type,
>  }
>
>  /* Given a module and name of symbol, find and return the symbol's value=
 */
> -unsigned long find_kallsyms_symbol_value(struct module *mod, const char =
*name)
> +static unsigned long __find_kallsyms_symbol_value(struct module *mod, co=
nst char *name)
>  {
>         unsigned int i;
>         struct mod_kallsyms *kallsyms =3D rcu_dereference_sched(mod->kall=
syms);
> @@ -466,7 +466,7 @@ static unsigned long __module_kallsyms_lookup_name(co=
nst char *name)
>         if (colon) {
>                 mod =3D find_module_all(name, colon - name, false);
>                 if (mod)
> -                       return find_kallsyms_symbol_value(mod, colon + 1)=
;
> +                       return __find_kallsyms_symbol_value(mod, colon + =
1);
>                 return 0;
>         }
>
> @@ -475,7 +475,7 @@ static unsigned long __module_kallsyms_lookup_name(co=
nst char *name)
>
>                 if (mod->state =3D=3D MODULE_STATE_UNFORMED)
>                         continue;
> -               ret =3D find_kallsyms_symbol_value(mod, name);
> +               ret =3D __find_kallsyms_symbol_value(mod, name);
>                 if (ret)
>                         return ret;
>         }
> @@ -494,6 +494,16 @@ unsigned long module_kallsyms_lookup_name(const char=
 *name)
>         return ret;
>  }
>
> +unsigned long find_kallsyms_symbol_value(struct module *mod, const char =
*name)
> +{
> +       unsigned long ret;
> +
> +       preempt_disable();
> +       ret =3D __find_kallsyms_symbol_value(mod, name);
> +       preempt_enable();
> +       return ret;
> +}

That doesn't look right.
I think the issue is misuse of rcu_dereference_sched in
find_kallsyms_symbol_value.
