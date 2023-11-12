Return-Path: <bpf+bounces-14942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9ED7E91AE
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 17:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9AEEB20B45
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 16:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A8814AA6;
	Sun, 12 Nov 2023 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="dfnVPts4"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE641426E
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 16:45:42 +0000 (UTC)
Received: from sonic302-27.consmr.mail.ne1.yahoo.com (sonic302-27.consmr.mail.ne1.yahoo.com [66.163.186.153])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B981723
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 08:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699807540; bh=QkUjV5t8IJ0GXUPo0WqgUQD/kDQxsiveoip8QzmJqJ4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=dfnVPts4tAkCBb/7VhIM0HBO88QtaFHHdFX7LUzZItAfct9HLvY4SH4Xji1GEBqcap0BuQpLaVXrBnI7V8YEa4I1KSJ4xEb54SBsig0jhRXmyqe7/S4qH5cm0aFDro6H18EkiaezpDbbHFxNi18rL17LnAu4ImGcQ9/qzwugghCni796hDWev577UvaKC3+5AigThAtok8+uuI2ImZbP0tB0bnZDGydDrDMeNkISY8BocFPKwr4At73esnsY8nuhcauQDPjV2hRYXmYmzhvYAVQ0MpvjLuPmwnuJGhC7tP08T2BCFz1EwXzLluVK72vjVGdOKjw/SxW2oQuwKyg8HQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699807540; bh=1VpxShmE6qjr4iv0t6hoTD3r2fXLL7zBdXWyC6TONjh=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Fjp1cswf+tnNTyd1jSwlOTJW2BWemhfRTBWJhc9CyUt/ryDyYrva36ectNPY5WYHb4xWgNkUUfVDDNpiYnS2dzldenMuuMHQ7qrU/KRFzofwDj/fHM/zFHYqOgj3kPOjDbNwmcNpljSzvhRAJarkycEWpm6gk1fNfoGl0nHoQ3c0kNoicWqh2s4bOyJytxLiiTybzLivlIKsEqiItuIiJpBUl8+YCZRSqSSIMWUyP5jYp2NBi0684Omo2H4kLgYArGtos5sU2DyVZdehzdNCPamsgvE1tD2Zo1KgpXaD4+Wwgo60uZYn+QHsisowGKs4c1rbNoNmrW7pdE9uriMKlw==
X-YMail-OSG: GRlCGHQVM1kDISfaDg7rqBLZ28e3OEyiXnX.092G.bFlk1S3SXSlfjsU.40djcn
 XVRFOzUV64TK0_SbAO0mDyj4LWmvANmYG7kb541_qMCmSH4S6pwdsuZpPyKz5Rw.TQhQSPXgPPeq
 k3F5tEYHz5rZvsFRQ8KLBN5tPF1cW6xSCw3Il3AFZxY7qPL2OAVcx033TQ1zp15yAVKrD8u9pWB4
 Nm3PR8FcqySe3YObuODT7KABN2DMfqIZBcGeZ9leeqnBOpU28U5XshkfBrsds4HFNZcyI5tGX5SO
 VveaelgNY5HYv9a22DSaTimXRWbYozTc1vBfvI9QfxDSpWcOV0FL2YRdOfyKU51FUF67pOp3sNCi
 W_VzQqYBgG4k1B5EaB1_FWVAG3ZAYx40oX1yI3N2RryX4RH1PXWR5Zs2rYHcPLO0t.e_2xjz0Lfg
 Dir9uSFdc5ro72OgtUj4tHTC_51G.99fN0DQVTJkWq8.nCD2IWcYJl8J6pBpLgf65KpejC7DkXOz
 qOcsq8PUsamikc6ZtI2P10RwkgofRDq0JMCC1wEb_PcM7TyvYYq6IOop2cWBgR8Ls2AkZ1MLEY.9
 kFG.vVHKqnGKCU2.u1MRAiAaPwpkEwVwFI5lnBHWeDBaQusbRNVYdA9koQ8RmPr9S6FjTjs5egQt
 Pmh15nrPppojf5Ng5OKSsrkOVKC2moKkGpEAlbDS2fNVEbcUknySArbEJi4.bsLpeQ0Qr6Bsu.Uj
 CTq9abiW2fu7T3.iK0c7Vnhrc1yR8M1hDxr7AsO8QH8rqWe_t5j3xbH0ulIBOxETGuqyMSxURrbG
 uGQCwURKWeiYIRCbodaxPm5DnSNMdtT2KyoE0Y.Nwrvt2ZlC_m7EUgWuciD1wwR0tik9g64mnKkc
 5kaCB_CEo1EgPjDoKm5uN21jN7Xj2XCfVoqgATcCh3Lz5lKMN7BnSV8daE4NYNDzCYWgxdXwKCvu
 0uBVYyP2M.vs8OdAjmWo5sEG499fTFcY5XOtwc1mKrNlu.fIJDR_yhWo4NCK1LYfNYO9uEZkHQhQ
 sN4tGGbWkfnOGfYufeqheTx54kEnRSWZTT.QgfNZMxvNEg3YJb4yyMHaA5N0QJC6irBJ7LsoHXkK
 Yek4zxfZ.N5ffWnTz5aubnADNPL9aP.5Kg_e7_.imLieyL0CuB0Lv3xsoYmOMC_O6m2rg1K8Fa_x
 MTP1JBTCMNbmAy9MGUACB1E7_Wo76cbhTJYPMgdYra1sEEvPJqSp4uUcXepCGlaS.Zcf3T_d702Y
 5ZUM7mkZHqAAtqsruiWJKQ0oaf_5AnjKzOt0ZItw9NDjrCE8P3LBIeAk_fpLxz_r9ehDXdtEJvy9
 _0M70cmHD5LFUj0XQCNXNllZVoUkSTr2uU7ANjgujRwSSojw4YBWYJ.ZDm.AGEzbW0NkEZGlZVGc
 ptVvGQKGLv.TdvrFUWb61hqQQUu3MDmpiP4KZfF4_0EdpmffRHGEvebs2rIOJTYlM8u2nSDuGF2L
 UjyLaHmcX1FM8C7OeDhGbNJMW0fCzlFvqtfL0QucO6oBGjBxLQmBfDOirGIsoIpd1g56GQu3Ffu6
 TExPK_oYCoCXr.uHZmzE6h.XNya4d6A62d1AOPU_jF3t3_IbAMhF5UqmPZDVRzUN7DO6YuTEXhCZ
 tz7tOCCfrCD02xB27tt4DcTVVFLr.5U_zEOt6bRWED3HevLGfhMKYrAAJZf31G3lfl61WugBzhRj
 3In315niWtOvAqPQXxIv23JdyMqhh_xh89Ie5iTHmu9a_FGCxL1dCvfgSnYxnB.tjQGbvuObQkox
 evs4HQklb8cTU.aXM_Z4kFUjp.wnVnn2bOx4bSH95BFIbp3JFuJxYNFTO0AVhu0N25IB_myRKZKD
 CoM3JN7l3q8CmW7CyU87Qep8Ba6A3B4hu1YBMHLeXp8eSOWQY5qP5MfpEpxkkztT8M2RWWUWlFXq
 t5..IlfdVq.v_oKfDfoDErivdlDT734_DbjpkH5m5ThCkkIDxd5GEcZTSN.Xpt1n.wBS1TZmwqJv
 .EsPohx6KJ.jpzwT6nRl1eKKu1Fz4VEKGMWPeYabXdbDdaPg7JvJ6h_3XOgKLl5uAokS6I3p_W2S
 yp4l7VyzKs9.bW41N5OkDkYeJO39FtmYMKwrh__lZ21ex8HX_gCcz9nmhKzQGlKo2RUaNW9I0Kb9
 1DEyYkSEz8hVxYizProGTHGtszBbiyXsK.uhW73P3y_wiVcaewLO73UClLo8iRySI70CQ_A0mB3m
 gMHulXuODRjMuVQw7Xmj5is19T0LUeH0nlar288RNCMXHALeH1li9s6hNMIjbOAi4XXallIbd7MC
 ZM62vRgwRPFIpRA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: cfa27603-0734-49f6-ba07-41171bf30657
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Sun, 12 Nov 2023 16:45:40 +0000
Received: by hermes--production-bf1-5b945b6d47-jx96d (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 328aad92118f82324d3a6d13ce8cfcd6;
          Sun, 12 Nov 2023 16:45:37 +0000 (UTC)
Message-ID: <188dc90e-864f-4681-88a5-87401c655878@schaufler-ca.com>
Date: Sun, 12 Nov 2023 08:45:34 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH -mm 0/4] mm, security, bpf: Fine-grained control over
 memory policy adjustments with lsm bpf
Content-Language: en-US
To: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc: linux-mm@kvack.org, linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org, ligang.bdlg@bytedance.com, mhocko@suse.com,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20231112073424.4216-1-laoar.shao@gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231112073424.4216-1-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/11/2023 11:34 PM, Yafang Shao wrote:
> Background
> ==========
>
> In our containerized environment, we've identified unexpected OOM events
> where the OOM-killer terminates tasks despite having ample free memory.
> This anomaly is traced back to tasks within a container using mbind(2) to
> bind memory to a specific NUMA node. When the allocated memory on this node
> is exhausted, the OOM-killer, prioritizing tasks based on oom_score,
> indiscriminately kills tasks. This becomes more critical with guaranteed
> tasks (oom_score_adj: -998) aggravating the issue.

Is there some reason why you can't fix the callers of mbind(2)?
This looks like an user space configuration error rather than a
system security issue.

>
> The selected victim might not have allocated memory on the same NUMA node,
> rendering the killing ineffective. This patch aims to address this by
> disabling MPOL_BIND in container environments.
>
> In the container environment, our aim is to consolidate memory resource
> control under the management of kubelet. If users express a preference for
> binding their memory to a specific NUMA node, we encourage the adoption of
> a standardized approach. Specifically, we recommend configuring this memory
> policy through kubelet using cpuset.mems in the cpuset controller, rather
> than individual users setting it autonomously. This centralized approach
> ensures that NUMA nodes are globally managed through kubelet, promoting
> consistency and facilitating streamlined administration of memory resources
> across the entire containerized environment.

Changing system behavior for a single use case doesn't seem prudent.
You're introducing a bunch of kernel code to avoid fixing a broken
user space configuration.

>
> Proposed Solutions
> =================
>
> - Introduce Capability to Disable MPOL_BIND
>   Currently, any task can perform MPOL_BIND without specific capabilities.
>   Enforcing CAP_SYS_RESOURCE or CAP_SYS_NICE could be an option, but this
>   may have unintended consequences. Capabilities, being broad, might grant
>   unnecessary privileges. We should explore alternatives to prevent
>   unexpected side effects.
>
> - Use LSM BPF to Disable MPOL_BIND
>   Introduce LSM hooks for syscalls such as mbind(2), set_mempolicy(2), and
>   set_mempolicy_home_node(2) to disable MPOL_BIND. This approach is more
>   flexibility and allows for fine-grained control without unintended
>   consequences. A sample LSM BPF program is included, demonstrating
>   practical implementation in a production environment.
>
> Future Considerations
> =====================
>
> In addition, there's room for enhancement in the OOM-killer for cases
> involving CONSTRAINT_MEMORY_POLICY. It would be more beneficial to
> prioritize selecting a victim that has allocated memory on the same NUMA
> node. My exploration on the lore led me to a proposal[0] related to this
> matter, although consensus seems elusive at this point. Nevertheless,
> delving into this specific topic is beyond the scope of the current
> patchset.
>
> [0]. https://lore.kernel.org/lkml/20220512044634.63586-1-ligang.bdlg@bytedance.com/ 
>
> Yafang Shao (4):
>   mm, security: Add lsm hook for mbind(2)
>   mm, security: Add lsm hook for set_mempolicy(2)
>   mm, security: Add lsm hook for set_mempolicy_home_node(2)
>   selftests/bpf: Add selftests for mbind(2) with lsm prog
>
>  include/linux/lsm_hook_defs.h                      |  8 +++
>  include/linux/security.h                           | 26 +++++++
>  mm/mempolicy.c                                     | 13 ++++
>  security/security.c                                | 19 ++++++
>  tools/testing/selftests/bpf/prog_tests/mempolicy.c | 79 ++++++++++++++++++++++
>  tools/testing/selftests/bpf/progs/test_mempolicy.c | 29 ++++++++
>  6 files changed, 174 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/mempolicy.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_mempolicy.c
>

