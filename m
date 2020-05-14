Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25151D3DC1
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 21:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgENTlg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 15:41:36 -0400
Received: from namei.org ([65.99.196.166]:59090 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbgENTlg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 May 2020 15:41:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 04EJfIHU008246;
        Thu, 14 May 2020 19:41:18 GMT
Date:   Fri, 15 May 2020 05:41:18 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Anders Roxell <anders.roxell@linaro.org>
cc:     ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] security: fix the default value of secid_to_secctx
 hook
In-Reply-To: <20200512174607.9630-1-anders.roxell@linaro.org>
Message-ID: <alpine.LRH.2.21.2005150539420.7929@namei.org>
References: <20200512174607.9630-1-anders.roxell@linaro.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 12 May 2020, Anders Roxell wrote:

> security_secid_to_secctx is called by the bpf_lsm hook and a successful
> return value (i.e 0) implies that the parameter will be consumed by the
> LSM framework. The current behaviour return success when the pointer
> isn't initialized when CONFIG_BPF_LSM is enabled, with the default
> return from kernel/bpf/bpf_lsm.c.
> 
> This is the internal error:
> 
> [ 1229.341488][ T2659] usercopy: Kernel memory exposure attempt detected from null address (offset 0, size 280)!
> [ 1229.374977][ T2659] ------------[ cut here ]------------
> [ 1229.376813][ T2659] kernel BUG at mm/usercopy.c:99!
> [ 1229.378398][ T2659] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> [ 1229.380348][ T2659] Modules linked in:
> [ 1229.381654][ T2659] CPU: 0 PID: 2659 Comm: systemd-journal Tainted: G    B   W         5.7.0-rc5-next-20200511-00019-g864e0c6319b8-dirty #13
> [ 1229.385429][ T2659] Hardware name: linux,dummy-virt (DT)
> [ 1229.387143][ T2659] pstate: 80400005 (Nzcv daif +PAN -UAO BTYPE=--)
> [ 1229.389165][ T2659] pc : usercopy_abort+0xc8/0xcc
> [ 1229.390705][ T2659] lr : usercopy_abort+0xc8/0xcc
> [ 1229.392225][ T2659] sp : ffff000064247450
> [ 1229.393533][ T2659] x29: ffff000064247460 x28: 0000000000000000
> [ 1229.395449][ T2659] x27: 0000000000000118 x26: 0000000000000000
> [ 1229.397384][ T2659] x25: ffffa000127049e0 x24: ffffa000127049e0
> [ 1229.399306][ T2659] x23: ffffa000127048e0 x22: ffffa000127048a0
> [ 1229.401241][ T2659] x21: ffffa00012704b80 x20: ffffa000127049e0
> [ 1229.403163][ T2659] x19: ffffa00012704820 x18: 0000000000000000
> [ 1229.405094][ T2659] x17: 0000000000000000 x16: 0000000000000000
> [ 1229.407008][ T2659] x15: 0000000000000000 x14: 003d090000000000
> [ 1229.408942][ T2659] x13: ffff80000d5b25b2 x12: 1fffe0000d5b25b1
> [ 1229.410859][ T2659] x11: 1fffe0000d5b25b1 x10: ffff80000d5b25b1
> [ 1229.412791][ T2659] x9 : ffffa0001034bee0 x8 : ffff00006ad92d8f
> [ 1229.414707][ T2659] x7 : 0000000000000000 x6 : ffffa00015eacb20
> [ 1229.416642][ T2659] x5 : ffff0000693c8040 x4 : 0000000000000000
> [ 1229.418558][ T2659] x3 : ffffa0001034befc x2 : d57a7483a01c6300
> [ 1229.420610][ T2659] x1 : 0000000000000000 x0 : 0000000000000059
> [ 1229.422526][ T2659] Call trace:
> [ 1229.423631][ T2659]  usercopy_abort+0xc8/0xcc
> [ 1229.425091][ T2659]  __check_object_size+0xdc/0x7d4
> [ 1229.426729][ T2659]  put_cmsg+0xa30/0xa90
> [ 1229.428132][ T2659]  unix_dgram_recvmsg+0x80c/0x930
> [ 1229.429731][ T2659]  sock_recvmsg+0x9c/0xc0
> [ 1229.431123][ T2659]  ____sys_recvmsg+0x1cc/0x5f8
> [ 1229.432663][ T2659]  ___sys_recvmsg+0x100/0x160
> [ 1229.434151][ T2659]  __sys_recvmsg+0x110/0x1a8
> [ 1229.435623][ T2659]  __arm64_sys_recvmsg+0x58/0x70
> [ 1229.437218][ T2659]  el0_svc_common.constprop.1+0x29c/0x340
> [ 1229.438994][ T2659]  do_el0_svc+0xe8/0x108
> [ 1229.440587][ T2659]  el0_svc+0x74/0x88
> [ 1229.441917][ T2659]  el0_sync_handler+0xe4/0x8b4
> [ 1229.443464][ T2659]  el0_sync+0x17c/0x180
> [ 1229.444920][ T2659] Code: aa1703e2 aa1603e1 910a8260 97ecc860 (d4210000)
> [ 1229.447070][ T2659] ---[ end trace 400497d91baeaf51 ]---
> [ 1229.448791][ T2659] Kernel panic - not syncing: Fatal exception
> [ 1229.450692][ T2659] Kernel Offset: disabled
> [ 1229.452061][ T2659] CPU features: 0x240002,20002004
> [ 1229.453647][ T2659] Memory Limit: none
> [ 1229.455015][ T2659] ---[ end Kernel panic - not syncing: Fatal exception ]---
> 
> Rework the so the default return value is -EOPNOTSUPP.
> 
> There are likely other callbacks such as security_inode_getsecctx() that
> may have the same problem, and that someone that understand the code
> better needs to audit them.
> 
> Thank you Arnd for helping me figure out what went wrong.
> 
> CC: Arnd Bergmann <arnd@arndb.de>
> Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Note, this patch should have been sent to me and cc'd the LSM list.


Acked-by: James Morris <jamorris@linux.microsoft.com>



-- 
James Morris
<jmorris@namei.org>

