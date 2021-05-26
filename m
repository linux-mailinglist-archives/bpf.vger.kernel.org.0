Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578BF39144D
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 12:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbhEZKEN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 06:04:13 -0400
Received: from smtp-42ad.mail.infomaniak.ch ([84.16.66.173]:39379 "EHLO
        smtp-42ad.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233264AbhEZKEL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 26 May 2021 06:04:11 -0400
X-Greylist: delayed 692 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 May 2021 06:04:11 EDT
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4FqmRM1fDqzMptYc;
        Wed, 26 May 2021 11:50:55 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4FqmRJ05YQzlmrrV;
        Wed, 26 May 2021 11:50:51 +0200 (CEST)
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
 <206971d6-70c7-e217-299f-1884310afa15@digikod.net>
 <1c3874c1-870a-ac60-03e6-2c16d49e185b@schaufler-ca.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <53108f3e-3297-3d8b-cba9-2b12ca30d666@digikod.net>
Date:   Wed, 26 May 2021 11:53:00 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <1c3874c1-870a-ac60-03e6-2c16d49e185b@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 26/05/2021 01:52, Casey Schaufler wrote:
> On 5/22/2021 1:39 AM, Mickaël Salaün wrote:
>> I like this design but there is an issue with Landlock though, see below.
>>
>> On 13/05/2021 22:07, Casey Schaufler wrote:
>>> When more than one security module is exporting data to
>>> audit and networking sub-systems a single 32 bit integer
>>> is no longer sufficient to represent the data. Add a
>>> structure to be used instead.
>>>
>>> The lsmblob structure is currently an array of
>>> u32 "secids". There is an entry for each of the
>>> security modules built into the system that would
>>> use secids if active. The system assigns the module
>>> a "slot" when it registers hooks. If modules are
>>> compiled in but not registered there will be unused
>>> slots.
>>>
>>> A new lsm_id structure, which contains the name
>>> of the LSM and its slot number, is created. There
>>> is an instance for each LSM, which assigns the name
>>> and passes it to the infrastructure to set the slot.
>>>
>>> The audit rules data is expanded to use an array of
>>> security module data rather than a single instance.
>>> Because IMA uses the audit rule functions it is
>>> affected as well.
>>>
>>> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
>>> Acked-by: Paul Moore <paul@paul-moore.com>
>>> Acked-by: John Johansen <john.johansen@canonical.com>
>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>> Cc: <bpf@vger.kernel.org>
>>> Cc: linux-audit@redhat.com
>>> Cc: linux-security-module@vger.kernel.org
>>> Cc: selinux@vger.kernel.org
>>> To: Mimi Zohar <zohar@linux.ibm.com>
>>> To: Mickaël Salaün <mic@linux.microsoft.com>
>>> ---
>>>  include/linux/audit.h               |  4 +-
>>>  include/linux/lsm_hooks.h           | 12 ++++-
>>>  include/linux/security.h            | 67 +++++++++++++++++++++++++--
>>>  kernel/auditfilter.c                | 24 +++++-----
>>>  kernel/auditsc.c                    | 13 +++---
>>>  security/apparmor/lsm.c             |  7 ++-
>>>  security/bpf/hooks.c                | 12 ++++-
>>>  security/commoncap.c                |  7 ++-
>>>  security/integrity/ima/ima_policy.c | 40 +++++++++++-----
>>>  security/landlock/cred.c            |  2 +-
>>>  security/landlock/fs.c              |  2 +-
>>>  security/landlock/ptrace.c          |  2 +-
>>>  security/landlock/setup.c           |  4 ++
>>>  security/landlock/setup.h           |  1 +
>>>  security/loadpin/loadpin.c          |  8 +++-
>>>  security/lockdown/lockdown.c        |  7 ++-
>>>  security/safesetid/lsm.c            |  8 +++-
>>>  security/security.c                 | 72 ++++++++++++++++++++++++-----
>>>  security/selinux/hooks.c            |  8 +++-
>>>  security/smack/smack_lsm.c          |  7 ++-
>>>  security/tomoyo/tomoyo.c            |  8 +++-
>>>  security/yama/yama_lsm.c            |  7 ++-
>>>  22 files changed, 262 insertions(+), 60 deletions(-)
>>>
>> [...]
>>
>>> diff --git a/security/landlock/setup.c b/security/landlock/setup.c
>>> index f8e8e980454c..4a12666a4090 100644
>>> --- a/security/landlock/setup.c
>>> +++ b/security/landlock/setup.c
>>> @@ -23,6 +23,10 @@ struct lsm_blob_sizes landlock_blob_sizes __lsm_ro_after_init = {
>>>  	.lbs_superblock = sizeof(struct landlock_superblock_security),
>>>  };
>>>  
>>> +struct lsm_id landlock_lsmid __lsm_ro_after_init = {
>>> +	.lsm = LANDLOCK_NAME,
>> It is missing: .slot = LSMBLOB_NEEDED,
> 
> Sorry for the delay.
> 
> Landlock does not provide any of the hooks that use a struct lsmblob.
> That would be secid_to_secctx, secctx_to_secid, inode_getsecid,
> cred_getsecid, kernel_act_as task_getsecid_subj task_getsecid_obj and
> ipc_getsecid. Setting .slot = LSMBLOB_NEEDED indicates that the LSM
> uses a slot in struct lsmblob. Landlock does not need a slot.

Indeed, the (generic) "blob" name misled me. Would it make sense to use
a name with "secid" in it instead?

Shouldn't the slot field be set to LSMBLOB_NOT_NEEDED (-3) then (instead
of the implicit 0)?

> 
>>
>> You can run the Landlock tests please?
>> make -C tools/testing/selftests TARGETS=landlock gen_tar
>> tar -xf kselftest.tar.gz && ./run_kselftest.sh
> 
> Sure. I'll add them to my routine.

Thanks.

> 
>>
>>
>>> +};
>>> +
>>>  static int __init landlock_init(void)
>>>  {
>>>  	landlock_add_cred_hooks();
>> [...]
>>
>>> diff --git a/security/security.c b/security/security.c
>>> index e12a7c463468..a3276deb1b8a 100644
>>> --- a/security/security.c
>>> +++ b/security/security.c
>>> @@ -344,6 +344,7 @@ static void __init ordered_lsm_init(void)
>>>  	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
>>>  	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
>>>  	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
>>> +	init_debug("lsmblob size         = %zu\n", sizeof(struct lsmblob));
>>>  
>>>  	/*
>>>  	 * Create any kmem_caches needed for blobs
>>> @@ -471,21 +472,36 @@ static int lsm_append(const char *new, char **result)
>>>  	return 0;
>>>  }
>>>  
>>> +/*
>>> + * Current index to use while initializing the lsmblob secid list.
>>> + */
>>> +static int lsm_slot __lsm_ro_after_init;
>>> +
>>>  /**
>>>   * security_add_hooks - Add a modules hooks to the hook lists.
>>>   * @hooks: the hooks to add
>>>   * @count: the number of hooks to add
>>> - * @lsm: the name of the security module
>>> + * @lsmid: the identification information for the security module
>>>   *
>>>   * Each LSM has to register its hooks with the infrastructure.
>>> + * If the LSM is using hooks that export secids allocate a slot
>>> + * for it in the lsmblob.
>>>   */
>>>  void __init security_add_hooks(struct security_hook_list *hooks, int count,
>>> -				char *lsm)
>>> +			       struct lsm_id *lsmid)
>>>  {
>>>  	int i;
>>>  
>> Could you add a WARN_ON(!lsmid->slot || !lsmid->name) here?
> 
> Yes. That's reasonable.

I guess my above comment makes sense if lsmid->slot should not be zero
but LSMBLOB_NOT_NEEDED instead, otherwise the Landlock lsmid would throw
a warning.

> 
>>
>>
>>> +	if (lsmid->slot == LSMBLOB_NEEDED) {
>>> +		if (lsm_slot >= LSMBLOB_ENTRIES)
>>> +			panic("%s Too many LSMs registered.\n", __func__);
>>> +		lsmid->slot = lsm_slot++;
>>> +		init_debug("%s assigned lsmblob slot %d\n", lsmid->lsm,
>>> +			   lsmid->slot);
>>> +	}
>>> +
>>>  	for (i = 0; i < count; i++) {
>>> -		hooks[i].lsm = lsm;
>>> +		hooks[i].lsmid = lsmid;
>>>  		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
>>>  	}
>>>  
> 
