Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3042A6C46FE
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 10:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjCVJxK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 05:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjCVJwd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 05:52:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8EB3C27
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 02:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679478587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N6hCFiFwqwVfd2jwaXgqDKadCO8jMDOdiE7giRI1G34=;
        b=bHzsHTyD3hC1Y9aTbWgZbtD4+tum6XH/opUHYPD7DQMZR51tnXAk+CyBoZFDXGxmmC12fy
        TavVe4a3gxLGOsyxGOHrV0nCA0v3ngkHtQu3vpVL80SlPSqiEwQSZgGxsvE70piZToX7EC
        Kr1NfHqs+Vvq/8R67tQGTyy1AYiCwC0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-tYTn6NLzMaWLP-ugFqDH7A-1; Wed, 22 Mar 2023 05:49:44 -0400
X-MC-Unique: tYTn6NLzMaWLP-ugFqDH7A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E9D9B1C041B1;
        Wed, 22 Mar 2023 09:49:43 +0000 (UTC)
Received: from samus.usersys.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 18FEC4619F5;
        Wed, 22 Mar 2023 09:49:40 +0000 (UTC)
Date:   Wed, 22 Mar 2023 10:49:38 +0100
From:   Artem Savkov <asavkov@redhat.com>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org,
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
Message-ID: <ZBrPMkv8YVRiWwCR@samus.usersys.redhat.com>
Mail-Followup-To: Jiri Olsa <olsajiri@gmail.com>,
        Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>
References: <cover.1676542796.git.vmalik@redhat.com>
 <e627742ab86ed28632bc9b6c56ef65d7f98eadbc.1676542796.git.vmalik@redhat.com>
 <Y+40os27pQ8det/o@krava>
 <1992d09a-0ef8-66e3-1da0-5d13c2fecc3d@redhat.com>
 <Y+5Q0UK09HsxM4ht@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+5Q0UK09HsxM4ht@krava>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 16, 2023 at 04:50:41PM +0100, Jiri Olsa wrote:
> On Thu, Feb 16, 2023 at 03:45:11PM +0100, Viktor Malik wrote:
> 
> SNIP
> 
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index 388245e8826e..6a19bd450558 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -24,6 +24,7 @@
> > > >   #include <linux/bpf_lsm.h>
> > > >   #include <linux/btf_ids.h>
> > > >   #include <linux/poison.h>
> > > > +#include "../module/internal.h"
> > > >   #include "disasm.h"
> > > > @@ -16868,6 +16869,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
> > > >   	const char *tname;
> > > >   	struct btf *btf;
> > > >   	long addr = 0;
> > > > +	struct module *mod = NULL;
> > > >   	if (!btf_id) {
> > > >   		bpf_log(log, "Tracing programs must provide btf_id\n");
> > > > @@ -17041,7 +17043,17 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
> > > >   			else
> > > >   				addr = (long) tgt_prog->aux->func[subprog]->bpf_func;
> > > >   		} else {
> > > > -			addr = kallsyms_lookup_name(tname);
> > > > +			if (btf_is_module(btf)) {
> > > > +				preempt_disable();
> > > 
> > > btf_try_get_module takes mutex, so you can't preempt_disable in here,
> > > I got this when running the test:
> > > 
> > > [  691.916989][ T2585] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:580
> > > 
> > 
> > Hm, do we even need to preempt_disable? IIUC, preempt_disable is used
> > in module kallsyms to prevent taking the module lock b/c kallsyms are
> > used in the oops path. That shouldn't be an issue here, is that correct?
> 
> btf_try_get_module calls try_module_get which disables the preemption,
> so no need to call it in here

It does, but it reenables preemption right away so it is enabled by the
time we call find_kallsyms_symbol_value(). I am getting the following
lockdep splat while running module_fentry_shadow test from test_progs.

[   12.017973][  T488] =============================                                                          
[   12.018529][  T488] WARNING: suspicious RCU usage                                                          
[   12.018987][  T488] 6.2.0.bpf-test-13063-g6a9f5cdba3c5 #804 Tainted: G           OE                        
[   12.019898][  T488] -----------------------------                                                          
[   12.020391][  T488] kernel/module/kallsyms.c:448 suspicious rcu_dereference_check() usage!                
[   12.021335][  T488]                                                                                        
[   12.021335][  T488] other info that might help us debug this:                                              
[   12.021335][  T488]                                                                                        
[   12.022416][  T488]                                                                                        
[   12.022416][  T488] rcu_scheduler_active = 2, debug_locks = 1                                              
[   12.023297][  T488] no locks held by test_progs/488.                                                       
[   12.023854][  T488]                                                                                        
[   12.023854][  T488] stack backtrace:                                                                       
[   12.024336][  T488] CPU: 0 PID: 488 Comm: test_progs Tainted: G           OE      6.2.0.bpf-test-13063-g6a9f5cdba3c5 #804
[   12.025290][  T488] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.1-2.fc37 04/01/2014                                                                                                               
[   12.026108][  T488] Call Trace:                                                                            
[   12.026381][  T488]  <TASK>                                                                                
[   12.026649][  T488]  dump_stack_lvl+0xb4/0x110                                                             
[   12.027060][  T488]  lockdep_rcu_suspicious+0x158/0x1f0                                                    
[   12.027541][  T488]  find_kallsyms_symbol_value+0xe8/0x110                                                 
[   12.028028][  T488]  bpf_check_attach_target+0x838/0xa20                                                   
[   12.028511][  T488]  check_attach_btf_id+0x144/0x3f0                                                      
[   12.028957][  T488]  ? __pfx_cmp_subprogs+0x10/0x10                                                       
[   12.029408][  T488]  bpf_check+0xeec/0x1850                                                                
[   12.029799][  T488]  ? ktime_get_with_offset+0x124/0x1d0                                                   
[   12.030247][  T488]  bpf_prog_load+0x87a/0xed0                                                             
[   12.030627][  T488]  ? __lock_release+0x5f/0x160                                                           
[   12.031010][  T488]  ? __might_fault+0x53/0xb0                                                            
[   12.031394][  T488]  ? selinux_bpf+0x6c/0xa0                                                              
[   12.031756][  T488]  __sys_bpf+0x53c/0x1240                                                                
[   12.032115][  T488]  __x64_sys_bpf+0x27/0x40                                                              
[   12.032476][  T488]  do_syscall_64+0x3e/0x90                                                              
[   12.032835][  T488]  entry_SYSCALL_64_after_hwframe+0x72/0xdc                                             
[   12.033313][  T488] RIP: 0033:0x7f174ea0e92d                                                              
[   12.033668][  T488] Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 e4 0c 00 f7 d8 64 89 0
1 48
[   12.035197][  T488] RSP: 002b:00007ffee5cefc68 EFLAGS: 00000202 ORIG_RAX: 0000000000000141                
[   12.035864][  T488] RAX: ffffffffffffffda RBX: 00007ffee5cf02a8 RCX: 00007f174ea0e92d                     
[   12.036495][  T488] RDX: 0000000000000080 RSI: 00007ffee5cefd20 RDI: 0000000000000005                     
[   12.037123][  T488] RBP: 00007ffee5cefc80 R08: 00007ffee5cefea0 R09: 00007ffee5cefd20                     
[   12.037752][  T488] R10: 0000000000000002 R11: 0000000000000202 R12: 0000000000000000                     
[   12.038382][  T488] R13: 00007ffee5cf02c8 R14: 0000000000f2edb0 R15: 00007f174eb59000                     
[   12.039022][  T488]  </TASK>                       


> jirka
> 
> > 
> > > > +				mod = btf_try_get_module(btf);
> > > > +				if (mod)
> > > > +					addr = find_kallsyms_symbol_value(mod, tname);
> > > > +				else
> > > > +					addr = 0;
> > > > +				preempt_enable();
> > > > +			} else {
> > > > +				addr = kallsyms_lookup_name(tname);
> > > > +			}
> > > >   			if (!addr) {
> > > >   				bpf_log(log,
> > > >   					"The address of function %s cannot be found\n",
> > > > @@ -17105,6 +17117,12 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
> > > >   	tgt_info->tgt_addr = addr;
> > > >   	tgt_info->tgt_name = tname;
> > > >   	tgt_info->tgt_type = t;
> > > > +	if (mod) {
> > > > +		if (!prog->aux->mod)
> > > > +			prog->aux->mod = mod;
> > > 
> > > can this actually happen? would it be better to have bpf_check_attach_target
> > > just to take take the module ref and return it in tgt_info->tgt_mod and it'd
> > > be up to caller to decide what to do with that
> > 
> > Ok, I'll try to do it that way.
> > 
> > Thanks for the review!
> > Viktor
> > 
> > > 
> > > thanks,
> > > jirka
> > > 
> > > > +		else
> > > > +			module_put(mod);
> > > > +	}
> > > >   	return 0;
> > > >   }
> > > > diff --git a/kernel/module/internal.h b/kernel/module/internal.h
> > > > index 2e2bf236f558..5cb103a46018 100644
> > > > --- a/kernel/module/internal.h
> > > > +++ b/kernel/module/internal.h
> > > > @@ -256,6 +256,11 @@ static inline bool sect_empty(const Elf_Shdr *sect)
> > > >   static inline void init_build_id(struct module *mod, const struct load_info *info) { }
> > > >   static inline void layout_symtab(struct module *mod, struct load_info *info) { }
> > > >   static inline void add_kallsyms(struct module *mod, const struct load_info *info) { }
> > > > +static inline unsigned long find_kallsyms_symbol_value(struct module *mod
> > > > +						       const char *name)
> > > > +{
> > > > +	return 0;
> > > > +}
> > > >   #endif /* CONFIG_KALLSYMS */
> > > >   #ifdef CONFIG_SYSFS
> > > > -- 
> > > > 2.39.1
> > > > 
> > > 
> > 

-- 
 Artem

