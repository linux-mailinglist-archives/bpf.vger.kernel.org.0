Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F116E9D0D
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2019 15:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfJ3OEU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Oct 2019 10:04:20 -0400
Received: from smtp-sh2.infomaniak.ch ([128.65.195.6]:51351 "EHLO
        smtp-sh2.infomaniak.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfJ3OET (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Oct 2019 10:04:19 -0400
Received: from smtp7.infomaniak.ch (smtp7.infomaniak.ch [83.166.132.30])
        by smtp-sh2.infomaniak.ch (8.14.4/8.14.4/Debian-8+deb8u2) with ESMTP id x9UE3Eeb245292
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 15:03:15 +0100
Received: from ns3096276.ip-94-23-54.eu (ns3096276.ip-94-23-54.eu [94.23.54.103])
        (authenticated bits=0)
        by smtp7.infomaniak.ch (8.14.5/8.14.5) with ESMTP id x9UE3A91166781
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
        Wed, 30 Oct 2019 15:03:11 +0100
Subject: Re: [PATCH bpf-next v11 2/7] landlock: Add the management of domains
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Drysdale <drysdale@google.com>,
        Florent Revest <revest@chromium.org>,
        James Morris <jmorris@namei.org>, Jann Horn <jann@thejh.net>,
        John Johansen <john.johansen@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        KP Singh <kpsingh@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>,
        Paul Moore <paul@paul-moore.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>, Tejun Heo <tj@kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tycho Andersen <tycho@tycho.ws>,
        Will Drewry <wad@chromium.org>, bpf@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20191029171505.6650-1-mic@digikod.net>
 <20191029171505.6650-3-mic@digikod.net>
 <20191030025621.GA27626@mail.hallyn.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Openpgp: preference=signencrypt
Message-ID: <e6c59db1-0fb5-704d-6693-335fa199101c@digikod.net>
Date:   Wed, 30 Oct 2019 15:03:10 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <20191030025621.GA27626@mail.hallyn.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 30/10/2019 03:56, Serge E. Hallyn wrote:
> On Tue, Oct 29, 2019 at 06:15:00PM +0100, Mickaël Salaün wrote:
>> A Landlock domain is a set of eBPF programs.  There is a list for each
>> different program types that can be run on a specific Landlock hook
>> (e.g. ptrace).  A domain is tied to a set of subjects (i.e. tasks).  A
>> Landlock program should not try (nor be able) to infer which subject is
>> currently enforced, but to have a unique security policy for all
>> subjects tied to the same domain.  This make the reasoning much easier
>> and help avoid pitfalls.
>>
>> The next commits tie a domain to a task's credentials thanks to
>> seccomp(2), but we could use cgroups or a security file-system to
>> enforce a sysadmin-defined policy .
>>
>> Signed-off-by: Mickaël Salaün <mic@digikod.net>
>> Cc: Alexei Starovoitov <ast@kernel.org>
>> Cc: Andy Lutomirski <luto@amacapital.net>
>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>> Cc: James Morris <jmorris@namei.org>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Serge E. Hallyn <serge@hallyn.com>
>> Cc: Will Drewry <wad@chromium.org>
>> ---
>>
>> Changes since v10:
>> * rename files and names to clearly define a domain
>> * create a standalone patch to ease review
>> ---
> 
> [...]
> 
>> +/**
>> + * store_landlock_prog - prepend and deduplicate a Landlock prog_list
>> + *
>> + * Prepend @prog to @init_domain while ignoring @prog if they are already in
>> + * @ref_domain.  Whatever is the result of this function call, you can call
>> + * bpf_prog_put(@prog) after.
>> + *
>> + * @init_domain: empty domain to prepend to
>> + * @ref_domain: domain to check for duplicate programs
>> + * @prog: program to prepend
>> + *
>> + * Return -errno on error or 0 if @prog was successfully stored.
>> + */
>> +static int store_landlock_prog(struct landlock_domain *init_domain,
>> +		const struct landlock_domain *ref_domain,
>> +		struct bpf_prog *prog)
>> +{
>> +	struct landlock_prog_list *tmp_list = NULL;
>> +	int err;
>> +	size_t hook;
>> +	enum landlock_hook_type last_type;
>> +	struct bpf_prog *new = prog;
>> +
>> +	/* allocate all the memory we need */
>> +	struct landlock_prog_list *new_list;
>> +
>> +	last_type = get_hook_type(new);
>> +
>> +	/* ignore duplicate programs */
> 
> This comment should be "don't allow" rather than "ignore", right?

Exactly, fixed.

> 
>> +	if (ref_domain) {
>> +		struct landlock_prog_list *ref;
>> +
>> +		hook = get_hook_index(get_hook_type(new));
>> +		for (ref = ref_domain->programs[hook]; ref;
>> +				ref = ref->prev) {
>> +			if (ref->prog == new)
>> +				return -EINVAL;
>> +		}
>> +	}
>> +
>> +	new = bpf_prog_inc(new);
>> +	if (IS_ERR(new)) {
>> +		err = PTR_ERR(new);
>> +		goto put_tmp_list;
>> +	}
>> +	new_list = kzalloc(sizeof(*new_list), GFP_KERNEL);
>> +	if (!new_list) {
>> +		bpf_prog_put(new);
>> +		err = -ENOMEM;
>> +		goto put_tmp_list;
>> +	}
>> +	/* ignore Landlock types in this tmp_list */
>> +	new_list->prog = new;
>> +	new_list->prev = tmp_list;
>> +	refcount_set(&new_list->usage, 1);
>> +	tmp_list = new_list;
>> +
>> +	if (!tmp_list)
>> +		/* inform user space that this program was already added */
> 
> I'm not following this.  You just kzalloc'd new_list, pointed
> tmp_list to new_list, so how could tmp_list be NULL?  Was there
> a bad code reorg here, or am i being dense?

Indeed, this was introduce with a code refactoring (while removing a
program "chaining" concept) where this code snippet was in a loop, hence
the weird use of tmp_list. I'm cleaning this up (and simplifying this
whole code), and replacing the -EINVAL for the duplicate program check
with the -EEXIST.

Thanks!


> 
>> +		return -EEXIST;
>> +
>> +	/* properly store the list (without error cases) */
>> +	while (tmp_list) {
>> +		struct landlock_prog_list *new_list;
>> +
>> +		new_list = tmp_list;
>> +		tmp_list = tmp_list->prev;
>> +		/* do not increment the previous prog list usage */
>> +		hook = get_hook_index(get_hook_type(new_list->prog));
>> +		new_list->prev = init_domain->programs[hook];
>> +		/* no need to add from the last program to the first because
>> +		 * each of them are a different Landlock type */
>> +		smp_store_release(&init_domain->programs[hook], new_list);
>> +	}
>> +	return 0;
>> +
>> +put_tmp_list:
>> +	put_landlock_prog_list(tmp_list);
>> +	return err;
>> +}
>> +
>> +/* limit Landlock programs set to 256KB */
>> +#define LANDLOCK_PROGRAMS_MAX_PAGES (1 << 6)
>> +
>> +/**
>> + * landlock_prepend_prog - attach a Landlock prog_list to @current_domain
>> + *
>> + * Whatever is the result of this function call, you can call
>> + * bpf_prog_put(@prog) after.
>> + *
>> + * @current_domain: landlock_domain pointer, must be (RCU-)locked (if needed)
>> + *                  to prevent a concurrent put/free. This pointer must not be
>> + *                  freed after the call.
>> + * @prog: non-NULL Landlock prog_list to prepend to @current_domain. @prog will
>> + *        be owned by landlock_prepend_prog() and freed if an error happened.
>> + *
>> + * Return @current_domain or a new pointer when OK. Return a pointer error
>> + * otherwise.
>> + */
>> +struct landlock_domain *landlock_prepend_prog(
>> +		struct landlock_domain *current_domain,
>> +		struct bpf_prog *prog)
>> +{
>> +	struct landlock_domain *new_domain = current_domain;
>> +	unsigned long pages;
>> +	int err;
>> +	size_t i;
>> +	struct landlock_domain tmp_domain = {};
>> +
>> +	if (prog->type != BPF_PROG_TYPE_LANDLOCK_HOOK)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	/* validate memory size allocation */
>> +	pages = prog->pages;
>> +	if (current_domain) {
>> +		size_t i;
>> +
>> +		for (i = 0; i < ARRAY_SIZE(current_domain->programs); i++) {
>> +			struct landlock_prog_list *walker_p;
>> +
>> +			for (walker_p = current_domain->programs[i];
>> +					walker_p; walker_p = walker_p->prev)
>> +				pages += walker_p->prog->pages;
>> +		}
>> +		/* count a struct landlock_domain if we need to allocate one */
>> +		if (refcount_read(&current_domain->usage) != 1)
>> +			pages += round_up(sizeof(*current_domain), PAGE_SIZE)
>> +				/ PAGE_SIZE;
>> +	}
>> +	if (pages > LANDLOCK_PROGRAMS_MAX_PAGES)
>> +		return ERR_PTR(-E2BIG);
>> +
>> +	/* ensure early that we can allocate enough memory for the new
>> +	 * prog_lists */
>> +	err = store_landlock_prog(&tmp_domain, current_domain, prog);
>> +	if (err)
>> +		return ERR_PTR(err);
>> +
>> +	/*
>> +	 * Each task_struct points to an array of prog list pointers.  These
>> +	 * tables are duplicated when additions are made (which means each
>> +	 * table needs to be refcounted for the processes using it). When a new
>> +	 * table is created, all the refcounters on the prog_list are bumped
>> +	 * (to track each table that references the prog). When a new prog is
>> +	 * added, it's just prepended to the list for the new table to point
>> +	 * at.
>> +	 *
>> +	 * Manage all the possible errors before this step to not uselessly
>> +	 * duplicate current_domain and avoid a rollback.
>> +	 */
>> +	if (!new_domain) {
>> +		/*
>> +		 * If there is no Landlock domain used by the current task,
>> +		 * then create a new one.
>> +		 */
>> +		new_domain = new_landlock_domain();
>> +		if (IS_ERR(new_domain))
>> +			goto put_tmp_lists;
>> +	} else if (refcount_read(&current_domain->usage) > 1) {
>> +		/*
>> +		 * If the current task is not the sole user of its Landlock
>> +		 * domain, then duplicate it.
>> +		 */
>> +		new_domain = new_landlock_domain();
>> +		if (IS_ERR(new_domain))
>> +			goto put_tmp_lists;
>> +		for (i = 0; i < ARRAY_SIZE(new_domain->programs); i++) {
>> +			new_domain->programs[i] =
>> +				READ_ONCE(current_domain->programs[i]);
>> +			if (new_domain->programs[i])
>> +				refcount_inc(&new_domain->programs[i]->usage);
>> +		}
>> +
>> +		/*
>> +		 * Landlock domain from the current task will not be freed here
>> +		 * because the usage is strictly greater than 1. It is only
>> +		 * prevented to be freed by another task thanks to the caller
>> +		 * of landlock_prepend_prog() which should be locked if needed.
>> +		 */
>> +		landlock_put_domain(current_domain);
>> +	}
>> +
>> +	/* prepend tmp_domain to new_domain */
>> +	for (i = 0; i < ARRAY_SIZE(tmp_domain.programs); i++) {
>> +		/* get the last new list */
>> +		struct landlock_prog_list *last_list =
>> +			tmp_domain.programs[i];
>> +
>> +		if (last_list) {
>> +			while (last_list->prev)
>> +				last_list = last_list->prev;
>> +			/* no need to increment usage (pointer replacement) */
>> +			last_list->prev = new_domain->programs[i];
>> +			new_domain->programs[i] = tmp_domain.programs[i];
>> +		}
>> +	}
>> +	return new_domain;
>> +
>> +put_tmp_lists:
>> +	for (i = 0; i < ARRAY_SIZE(tmp_domain.programs); i++)
>> +		put_landlock_prog_list(tmp_domain.programs[i]);
>> +	return new_domain;
>> +}
>> diff --git a/security/landlock/domain_manage.h b/security/landlock/domain_manage.h
>> new file mode 100644
>> index 000000000000..5b5b49f6e3e8
>> --- /dev/null
>> +++ b/security/landlock/domain_manage.h
>> @@ -0,0 +1,23 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Landlock LSM - domain management headers
>> + *
>> + * Copyright © 2016-2019 Mickaël Salaün <mic@digikod.net>
>> + * Copyright © 2018-2019 ANSSI
>> + */
>> +
>> +#ifndef _SECURITY_LANDLOCK_DOMAIN_MANAGE_H
>> +#define _SECURITY_LANDLOCK_DOMAIN_MANAGE_H
>> +
>> +#include <linux/filter.h>
>> +
>> +#include "common.h"
>> +
>> +void landlock_get_domain(struct landlock_domain *dom);
>> +void landlock_put_domain(struct landlock_domain *dom);
>> +
>> +struct landlock_domain *landlock_prepend_prog(
>> +		struct landlock_domain *current_domain,
>> +		struct bpf_prog *prog);
>> +
>> +#endif /* _SECURITY_LANDLOCK_DOMAIN_MANAGE_H */
>> -- 
>> 2.23.0
> 
