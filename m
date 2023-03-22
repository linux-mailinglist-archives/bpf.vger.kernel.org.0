Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF2D6C4A12
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 13:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjCVMOt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 08:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjCVMOs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 08:14:48 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07951367F4
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 05:14:47 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id eh3so71969828edb.11
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 05:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679487285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bPQjLhEIZsl6CuraRTYd6nPlSZxE0uzkYuZYTi48zv0=;
        b=RUA4eCTB/RZLEVHDk8ixsto3mZ/5r6ZDh4ctONxESVNY6hqHeHpWFDrxLbLKQKZmkF
         y7G3i0pkeDbfDvOGX8glan6JV7w31CMr/Q7GukE5Sy95wfjFovobFbda9BfD0i3qTS4a
         M/pvv1Mj0D2pEoyx0Uoiyjob25On3houeqE5QmxNKOAbPTsQghKxJdhX3UJUe971/y57
         Q5/9AgJqlnTNO+hT1h+KnyggLxj/ssAGJ3W7+5IQ4U50xjbg3HVDS5dz3cSRM76oVm1C
         H7MiDfFAMenjY9M5UuHjxuB3ox34FASz+2Qud5bmNg26BNJl5CVidAkAP34izAMcq59i
         glHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679487285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPQjLhEIZsl6CuraRTYd6nPlSZxE0uzkYuZYTi48zv0=;
        b=Ws4d23vBmlpOlRF5K031g5YQ5+8FoSdSJK8HOK5L4AEe8Z20D9O9Sgj7yOG+Fd9hhU
         aL0jyoegCKhhx3mz32/k/OdzNJkXS4Z1IqPcNgMR1UiV9gwIddKBqgS//4odKthAv+Hw
         3Y5M6Hp+W4dB055vW/OlhJQLZCXj+f3AxyYz8m4zXuyLR2XJr5yAvKkDrDg6FFOkCETs
         6xFFa57y6ygm3NRRagmqCpkmV283ofioqwNXHVo21rl/WYuiJR/cc8SqdbyGbfZSOJn9
         wupd5wRwvXShfz6j0MjYeB6LTIWRglCsENE1YExYyA4Vt3C/lYKcYkl0Tp4loER5D2oC
         TCRQ==
X-Gm-Message-State: AO0yUKWTB0TacPYWkm3B1AdI+ZkIui+Hv9WIDvwQ4IUHWDjEUBXyePhi
        NAmH/l8EMhu7mp8CE3xIb/4=
X-Google-Smtp-Source: AK7set//V+P9j8INwkW+OnIajr7PjpOKBpTEuNrXnyFlMtWB4iWDWKpINMANTz8xQPgbMsO5A02VGw==
X-Received: by 2002:a05:6402:1c0e:b0:4a3:43c1:8431 with SMTP id ck14-20020a0564021c0e00b004a343c18431mr2123144edb.5.1679487285204;
        Wed, 22 Mar 2023 05:14:45 -0700 (PDT)
Received: from krava (net-93-147-243-166.cust.vodafonedsl.it. [93.147.243.166])
        by smtp.gmail.com with ESMTPSA id q2-20020a1709066b0200b0092be0d267besm7241128ejr.142.2023.03.22.05.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 05:14:44 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 22 Mar 2023 13:14:41 +0100
To:     Jiri Olsa <olsajiri@gmail.com>, Viktor Malik <vmalik@redhat.com>,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
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
Message-ID: <ZBrxMWfmE/1RG/u0@krava>
References: <cover.1676542796.git.vmalik@redhat.com>
 <e627742ab86ed28632bc9b6c56ef65d7f98eadbc.1676542796.git.vmalik@redhat.com>
 <Y+40os27pQ8det/o@krava>
 <1992d09a-0ef8-66e3-1da0-5d13c2fecc3d@redhat.com>
 <Y+5Q0UK09HsxM4ht@krava>
 <ZBrPMkv8YVRiWwCR@samus.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBrPMkv8YVRiWwCR@samus.usersys.redhat.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 22, 2023 at 10:49:38AM +0100, Artem Savkov wrote:

SNIP

> > > Hm, do we even need to preempt_disable? IIUC, preempt_disable is used
> > > in module kallsyms to prevent taking the module lock b/c kallsyms are
> > > used in the oops path. That shouldn't be an issue here, is that correct?
> > 
> > btf_try_get_module calls try_module_get which disables the preemption,
> > so no need to call it in here
> 
> It does, but it reenables preemption right away so it is enabled by the
> time we call find_kallsyms_symbol_value(). I am getting the following
> lockdep splat while running module_fentry_shadow test from test_progs.
> 
> [   12.017973][  T488] =============================                                                          
> [   12.018529][  T488] WARNING: suspicious RCU usage                                                          
> [   12.018987][  T488] 6.2.0.bpf-test-13063-g6a9f5cdba3c5 #804 Tainted: G           OE                        
> [   12.019898][  T488] -----------------------------                                                          
> [   12.020391][  T488] kernel/module/kallsyms.c:448 suspicious rcu_dereference_check() usage!                
> [   12.021335][  T488]                                                                                        
> [   12.021335][  T488] other info that might help us debug this:                                              
> [   12.021335][  T488]                                                                                        
> [   12.022416][  T488]                                                                                        
> [   12.022416][  T488] rcu_scheduler_active = 2, debug_locks = 1                                              
> [   12.023297][  T488] no locks held by test_progs/488.                                                       
> [   12.023854][  T488]                                                                                        
> [   12.023854][  T488] stack backtrace:                                                                       
> [   12.024336][  T488] CPU: 0 PID: 488 Comm: test_progs Tainted: G           OE      6.2.0.bpf-test-13063-g6a9f5cdba3c5 #804
> [   12.025290][  T488] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.1-2.fc37 04/01/2014                                                                                                               
> [   12.026108][  T488] Call Trace:                                                                            
> [   12.026381][  T488]  <TASK>                                                                                
> [   12.026649][  T488]  dump_stack_lvl+0xb4/0x110                                                             
> [   12.027060][  T488]  lockdep_rcu_suspicious+0x158/0x1f0                                                    
> [   12.027541][  T488]  find_kallsyms_symbol_value+0xe8/0x110                                                 
> [   12.028028][  T488]  bpf_check_attach_target+0x838/0xa20                                                   
> [   12.028511][  T488]  check_attach_btf_id+0x144/0x3f0                                                      
> [   12.028957][  T488]  ? __pfx_cmp_subprogs+0x10/0x10                                                       
> [   12.029408][  T488]  bpf_check+0xeec/0x1850                                                                
> [   12.029799][  T488]  ? ktime_get_with_offset+0x124/0x1d0                                                   
> [   12.030247][  T488]  bpf_prog_load+0x87a/0xed0                                                             
> [   12.030627][  T488]  ? __lock_release+0x5f/0x160                                                           
> [   12.031010][  T488]  ? __might_fault+0x53/0xb0                                                            
> [   12.031394][  T488]  ? selinux_bpf+0x6c/0xa0                                                              
> [   12.031756][  T488]  __sys_bpf+0x53c/0x1240                                                                
> [   12.032115][  T488]  __x64_sys_bpf+0x27/0x40                                                              
> [   12.032476][  T488]  do_syscall_64+0x3e/0x90                                                              
> [   12.032835][  T488]  entry_SYSCALL_64_after_hwframe+0x72/0xdc                                             


hum, for some reason I can't reproduce, but looks like we need to disable
preemption for find_kallsyms_symbol_value.. could you please check with
patch below?

also could you please share your .config? not sure why I can't reproduce

thanks,
jirka


---
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index ab2376a1be88..bdc911dbcde5 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -442,7 +442,7 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 }
 
 /* Given a module and name of symbol, find and return the symbol's value */
-unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name)
+static unsigned long __find_kallsyms_symbol_value(struct module *mod, const char *name)
 {
 	unsigned int i;
 	struct mod_kallsyms *kallsyms = rcu_dereference_sched(mod->kallsyms);
@@ -466,7 +466,7 @@ static unsigned long __module_kallsyms_lookup_name(const char *name)
 	if (colon) {
 		mod = find_module_all(name, colon - name, false);
 		if (mod)
-			return find_kallsyms_symbol_value(mod, colon + 1);
+			return __find_kallsyms_symbol_value(mod, colon + 1);
 		return 0;
 	}
 
@@ -475,7 +475,7 @@ static unsigned long __module_kallsyms_lookup_name(const char *name)
 
 		if (mod->state == MODULE_STATE_UNFORMED)
 			continue;
-		ret = find_kallsyms_symbol_value(mod, name);
+		ret = __find_kallsyms_symbol_value(mod, name);
 		if (ret)
 			return ret;
 	}
@@ -494,6 +494,16 @@ unsigned long module_kallsyms_lookup_name(const char *name)
 	return ret;
 }
 
+unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name)
+{
+	unsigned long ret;
+
+	preempt_disable();
+	ret = __find_kallsyms_symbol_value(mod, name);
+	preempt_enable();
+	return ret;
+}
+
 int module_kallsyms_on_each_symbol(const char *modname,
 				   int (*fn)(void *, const char *,
 					     struct module *, unsigned long),
