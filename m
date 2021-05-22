Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E99338D49C
	for <lists+bpf@lfdr.de>; Sat, 22 May 2021 10:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhEVIqw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 22 May 2021 04:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhEVIqv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 22 May 2021 04:46:51 -0400
X-Greylist: delayed 485 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 22 May 2021 01:45:27 PDT
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [IPv6:2001:1600:4:17::190e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1F3C061574
        for <bpf@vger.kernel.org>; Sat, 22 May 2021 01:45:27 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4FnH0H2rnPzMpwvM;
        Sat, 22 May 2021 10:37:19 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4FnH0B6q19zlmrrn;
        Sat, 22 May 2021 10:37:14 +0200 (CEST)
Subject: Re: [PATCH v26 02/25] LSM: Add the lsmblob data structure.
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20210513200807.15910-1-casey@schaufler-ca.com>
 <20210513200807.15910-3-casey@schaufler-ca.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <206971d6-70c7-e217-299f-1884310afa15@digikod.net>
Date:   Sat, 22 May 2021 10:39:01 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <20210513200807.15910-3-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I like this design but there is an issue with Landlock though, see below.

On 13/05/2021 22:07, Casey Schaufler wrote:
> When more than one security module is exporting data to
> audit and networking sub-systems a single 32 bit integer
> is no longer sufficient to represent the data. Add a
> structure to be used instead.
> 
> The lsmblob structure is currently an array of
> u32 "secids". There is an entry for each of the
> security modules built into the system that would
> use secids if active. The system assigns the module
> a "slot" when it registers hooks. If modules are
> compiled in but not registered there will be unused
> slots.
> 
> A new lsm_id structure, which contains the name
> of the LSM and its slot number, is created. There
> is an instance for each LSM, which assigns the name
> and passes it to the infrastructure to set the slot.
> 
> The audit rules data is expanded to use an array of
> security module data rather than a single instance.
> Because IMA uses the audit rule functions it is
> affected as well.
> 
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Acked-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: <bpf@vger.kernel.org>
> Cc: linux-audit@redhat.com
> Cc: linux-security-module@vger.kernel.org
> Cc: selinux@vger.kernel.org
> To: Mimi Zohar <zohar@linux.ibm.com>
> To: Mickaël Salaün <mic@linux.microsoft.com>
> ---
>  include/linux/audit.h               |  4 +-
>  include/linux/lsm_hooks.h           | 12 ++++-
>  include/linux/security.h            | 67 +++++++++++++++++++++++++--
>  kernel/auditfilter.c                | 24 +++++-----
>  kernel/auditsc.c                    | 13 +++---
>  security/apparmor/lsm.c             |  7 ++-
>  security/bpf/hooks.c                | 12 ++++-
>  security/commoncap.c                |  7 ++-
>  security/integrity/ima/ima_policy.c | 40 +++++++++++-----
>  security/landlock/cred.c            |  2 +-
>  security/landlock/fs.c              |  2 +-
>  security/landlock/ptrace.c          |  2 +-
>  security/landlock/setup.c           |  4 ++
>  security/landlock/setup.h           |  1 +
>  security/loadpin/loadpin.c          |  8 +++-
>  security/lockdown/lockdown.c        |  7 ++-
>  security/safesetid/lsm.c            |  8 +++-
>  security/security.c                 | 72 ++++++++++++++++++++++++-----
>  security/selinux/hooks.c            |  8 +++-
>  security/smack/smack_lsm.c          |  7 ++-
>  security/tomoyo/tomoyo.c            |  8 +++-
>  security/yama/yama_lsm.c            |  7 ++-
>  22 files changed, 262 insertions(+), 60 deletions(-)
> 

[...]

> diff --git a/security/landlock/setup.c b/security/landlock/setup.c
> index f8e8e980454c..4a12666a4090 100644
> --- a/security/landlock/setup.c
> +++ b/security/landlock/setup.c
> @@ -23,6 +23,10 @@ struct lsm_blob_sizes landlock_blob_sizes __lsm_ro_after_init = {
>  	.lbs_superblock = sizeof(struct landlock_superblock_security),
>  };
>  
> +struct lsm_id landlock_lsmid __lsm_ro_after_init = {
> +	.lsm = LANDLOCK_NAME,

It is missing: .slot = LSMBLOB_NEEDED,

You can run the Landlock tests please?
make -C tools/testing/selftests TARGETS=landlock gen_tar
tar -xf kselftest.tar.gz && ./run_kselftest.sh


> +};
> +
>  static int __init landlock_init(void)
>  {
>  	landlock_add_cred_hooks();

[...]

> diff --git a/security/security.c b/security/security.c
> index e12a7c463468..a3276deb1b8a 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -344,6 +344,7 @@ static void __init ordered_lsm_init(void)
>  	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
>  	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
>  	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
> +	init_debug("lsmblob size         = %zu\n", sizeof(struct lsmblob));
>  
>  	/*
>  	 * Create any kmem_caches needed for blobs
> @@ -471,21 +472,36 @@ static int lsm_append(const char *new, char **result)
>  	return 0;
>  }
>  
> +/*
> + * Current index to use while initializing the lsmblob secid list.
> + */
> +static int lsm_slot __lsm_ro_after_init;
> +
>  /**
>   * security_add_hooks - Add a modules hooks to the hook lists.
>   * @hooks: the hooks to add
>   * @count: the number of hooks to add
> - * @lsm: the name of the security module
> + * @lsmid: the identification information for the security module
>   *
>   * Each LSM has to register its hooks with the infrastructure.
> + * If the LSM is using hooks that export secids allocate a slot
> + * for it in the lsmblob.
>   */
>  void __init security_add_hooks(struct security_hook_list *hooks, int count,
> -				char *lsm)
> +			       struct lsm_id *lsmid)
>  {
>  	int i;
>  

Could you add a WARN_ON(!lsmid->slot || !lsmid->name) here?


> +	if (lsmid->slot == LSMBLOB_NEEDED) {
> +		if (lsm_slot >= LSMBLOB_ENTRIES)
> +			panic("%s Too many LSMs registered.\n", __func__);
> +		lsmid->slot = lsm_slot++;
> +		init_debug("%s assigned lsmblob slot %d\n", lsmid->lsm,
> +			   lsmid->slot);
> +	}
> +
>  	for (i = 0; i < count; i++) {
> -		hooks[i].lsm = lsm;
> +		hooks[i].lsmid = lsmid;
>  		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
>  	}
>  
