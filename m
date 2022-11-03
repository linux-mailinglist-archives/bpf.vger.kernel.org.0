Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1598B618401
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 17:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiKCQRw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 12:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiKCQRu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 12:17:50 -0400
X-Greylist: delayed 484 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Nov 2022 09:17:47 PDT
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fac])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1451838E
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 09:17:47 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4N37xc16zjzMpnTN;
        Thu,  3 Nov 2022 17:09:40 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4N37xb0B4pzMpphG;
        Thu,  3 Nov 2022 17:09:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1667491780;
        bh=nAGLkQKdFqX2PHeLP/p0EHiQdszCz61dANsujoabcoE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=N7JAAHTsCzpwdAZCamgd480C38UUIhZj3IfHifZ6XxGhVbPNmHSl2t+xd5RM0pd4N
         nysRkw+4JwMCVFCimEIVztaYcX+x8aVW6VVR32kJzfgONL7ANm79koMM6v/xpbXARF
         YUybVOVwr/vVCprWG+Psou276VsbNqzCQODLb/cs=
Message-ID: <1fe5c84d-6f85-9ee8-76d4-d184a47ebff2@digikod.net>
Date:   Thu, 3 Nov 2022 17:09:38 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v2] LSM: Better reporting of actual LSMs at boot
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20221102000525.gonna.409-kees@kernel.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20221102000525.gonna.409-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 02/11/2022 01:05, Kees Cook wrote:
> Enhance the details reported by "lsm.debug" in several ways:
> 
> - report contents of "security="
> - report contents of "CONFIG_LSM"
> - report contents of "lsm="
> - report any early LSM details
> - whitespace-align the output of similar phases for easier visual parsing
> - change "disabled" to more accurate "skipped"
> - explain what "skipped" and "ignored" mean in a parenthetical
> 
> Upgrade the "security= is ignored" warning from pr_info to pr_warn,
> and include full arguments list to make the cause even more clear.
> 
> Replace static "Security Framework initializing" pr_info with specific
> list of the resulting order of enabled LSMs.
> 
> For example, if the kernel is built with:
> 
> CONFIG_SECURITY_SELINUX=y
> CONFIG_SECURITY_APPARMOR=y
> CONFIG_SECURITY_LOADPIN=y
> CONFIG_SECURITY_YAMA=y
> CONFIG_SECURITY_SAFESETID=y
> CONFIG_SECURITY_LOCKDOWN_LSM=y
> CONFIG_SECURITY_LANDLOCK=y
> CONFIG_INTEGRITY=y
> CONFIG_BPF_LSM=y
> CONFIG_DEFAULT_SECURITY_APPARMOR=y
> CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"
> 
> Booting without options will show:
> 
> LSM: initializing lsm=lockdown,capability,landlock,yama,loadpin,safesetid,integrity,selinux,bpf
> landlock: Up and running.
> Yama: becoming mindful.
> LoadPin: ready to pin (currently not enforcing)
> SELinux:  Initializing.
> LSM support for eBPF active
> 
> Boot with "lsm.debug" will show:
> 
> LSM: legacy security= *unspecified*
> LSM: CONFIG_LSM=landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf
> LSM: boot arg lsm= *unspecified*
> LSM:   early started: lockdown (enabled)
> LSM:   first ordered: capability (enabled)
> LSM: builtin ordered: landlock (enabled)
> LSM: builtin ignored: lockdown (not built into kernel)
> LSM: builtin ordered: yama (enabled)
> LSM: builtin ordered: loadpin (enabled)
> LSM: builtin ordered: safesetid (enabled)
> LSM: builtin ordered: integrity (enabled)
> LSM: builtin ordered: selinux (enabled)
> LSM: builtin ignored: smack (not built into kernel)
> LSM: builtin ignored: tomoyo (not built into kernel)
> LSM: builtin ordered: apparmor (enabled)
> LSM: builtin ordered: bpf (enabled)
> LSM: exclusive chosen:   selinux
> LSM: exclusive disabled: apparmor
> LSM: initializing lsm=lockdown,capability,landlock,yama,loadpin,safesetid,integrity,selinux,bpf
> LSM: cred blob size       = 32
> LSM: file blob size       = 16
> LSM: inode blob size      = 72
> LSM: ipc blob size        = 8
> LSM: msg_msg blob size    = 4
> LSM: superblock blob size = 80
> LSM: task blob size       = 8
> LSM: initializing capability
> LSM: initializing landlock
> landlock: Up and running.
> LSM: initializing yama
> Yama: becoming mindful.
> LSM: initializing loadpin
> LoadPin: ready to pin (currently not enforcing)
> LSM: initializing safesetid
> LSM: initializing integrity
> LSM: initializing selinux
> SELinux:  Initializing.
> LSM: initializing bpf
> LSM support for eBPF active
> 
> And some examples of how the lsm.debug ordering report changes...
> 
> With "lsm.debug security=selinux":
> 
> LSM: legacy security=selinux
> LSM: CONFIG_LSM=landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf
> LSM: boot arg lsm= *unspecified*
> LSM:   early started: lockdown (enabled)
> LSM:   first ordered: capability (enabled)
> LSM: security=selinux disabled: apparmor (only one legacy major LSM)
> LSM: builtin ordered: landlock (enabled)
> LSM: builtin ignored: lockdown (not built into kernel)
> LSM: builtin ordered: yama (enabled)
> LSM: builtin ordered: loadpin (enabled)
> LSM: builtin ordered: safesetid (enabled)
> LSM: builtin ordered: integrity (enabled)
> LSM: builtin ordered: selinux (enabled)
> LSM: builtin ignored: smack (not built into kernel)
> LSM: builtin ignored: tomoyo (not built into kernel)
> LSM: builtin ordered: apparmor (disabled)
> LSM: builtin ordered: bpf (enabled)
> LSM: exclusive chosen:   selinux
> LSM: initializing lsm=lockdown,capability,landlock,yama,loadpin,safesetid,integrity,selinux,bpf
> 
> With "lsm.debug lsm=integrity,selinux,loadpin,crabability,bpf,loadpin,loadpin":
> 
> LSM: legacy security= *unspecified*
> LSM: CONFIG_LSM=landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf
> LSM: boot arg lsm=integrity,selinux,loadpin,capability,bpf,loadpin,loadpin
> LSM:   early started: lockdown (enabled)
> LSM:   first ordered: capability (enabled)
> LSM: cmdline ordered: integrity (enabled)
> LSM: cmdline ordered: selinux (enabled)
> LSM: cmdline ordered: loadpin (enabled)
> LSM: cmdline ignored: crabability (not built into kernel)
> LSM: cmdline ordered: bpf (enabled)
> LSM: cmdline skipped: apparmor (not in requested order)
> LSM: cmdline skipped: yama (not in requested order)
> LSM: cmdline skipped: safesetid (not in requested order)
> LSM: cmdline skipped: landlock (not in requested order)
> LSM: exclusive chosen:   selinux
> LSM: initializing lsm=lockdown,capability,integrity,selinux,loadpin,bpf
> 
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

I think this change would be useful to help users debug their LSM 
configuration. I'm not sure about the whitespace-aligned output though, 
I guess it could break some scripts, but it is not part of the ABI and 
only relevant for debug purpose.

Acked-by: Mickaël Salaün <mic@digikod.net>


> ---
> v2: en/dis-enabled expanded, example output in commit log, use pr_cont.
> v1: https://lore.kernel.org/lkml/20221018064825.never.323-kees@kernel.org/
> ---
>   security/security.c | 45 ++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 36 insertions(+), 9 deletions(-)
> 
> diff --git a/security/security.c b/security/security.c
> index 79d82cb6e469..abceabda103d 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -161,8 +161,8 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
>   		lsm->enabled = &lsm_enabled_true;
>   	ordered_lsms[last_lsm++] = lsm;
>   
> -	init_debug("%s ordering: %s (%sabled)\n", from, lsm->name,
> -		   is_enabled(lsm) ? "en" : "dis");
> +	init_debug("%s ordered: %s (%s)\n", from, lsm->name,
> +		   is_enabled(lsm) ? "enabled" : "disabled");
>   }
>   
>   /* Is an LSM allowed to be initialized? */
> @@ -224,7 +224,7 @@ static void __init prepare_lsm(struct lsm_info *lsm)
>   	if (enabled) {
>   		if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
>   			exclusive = lsm;
> -			init_debug("exclusive chosen: %s\n", lsm->name);
> +			init_debug("exclusive chosen:   %s\n", lsm->name);
>   		}
>   
>   		lsm_set_blob_sizes(lsm->blobs);
> @@ -252,7 +252,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>   	/* LSM_ORDER_FIRST is always first. */
>   	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
>   		if (lsm->order == LSM_ORDER_FIRST)
> -			append_ordered_lsm(lsm, "first");
> +			append_ordered_lsm(lsm, "  first");
>   	}
>   
>   	/* Process "security=", if given. */
> @@ -270,7 +270,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>   			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
>   			    strcmp(major->name, chosen_major_lsm) != 0) {
>   				set_enabled(major, false);
> -				init_debug("security=%s disabled: %s\n",
> +				init_debug("security=%s disabled: %s (only one legacy major LSM)\n",
>   					   chosen_major_lsm, major->name);
>   			}
>   		}
> @@ -291,7 +291,8 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>   		}
>   
>   		if (!found)
> -			init_debug("%s ignored: %s\n", origin, name);
> +			init_debug("%s ignored: %s (not built into kernel)\n",
> +				   origin, name);
>   	}
>   
>   	/* Process "security=", if given. */
> @@ -309,7 +310,8 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>   		if (exists_ordered_lsm(lsm))
>   			continue;
>   		set_enabled(lsm, false);
> -		init_debug("%s disabled: %s\n", origin, lsm->name);
> +		init_debug("%s skipped: %s (not in requested order)\n",
> +			   origin, lsm->name);
>   	}
>   
>   	kfree(sep);
> @@ -320,6 +322,24 @@ static void __init lsm_early_task(struct task_struct *task);
>   
>   static int lsm_append(const char *new, char **result);
>   
> +static void __init report_lsm_order(void)
> +{
> +	struct lsm_info **lsm, *early;
> +	int first = 0;
> +
> +	pr_info("initializing lsm=");
> +
> +	/* Report each enabled LSM name, comma separated. */
> +	for (early = __start_early_lsm_info; early < __end_early_lsm_info; early++)
> +		if (is_enabled(early))
> +			pr_cont("%s%s", first++ == 0 ? "" : ",", early->name);
> +	for (lsm = ordered_lsms; *lsm; lsm++)
> +		if (is_enabled(*lsm))
> +			pr_cont("%s%s", first++ == 0 ? "" : ",", (*lsm)->name);
> +
> +	pr_cont("\n");
> +}
> +
>   static void __init ordered_lsm_init(void)
>   {
>   	struct lsm_info **lsm;
> @@ -329,7 +349,8 @@ static void __init ordered_lsm_init(void)
>   
>   	if (chosen_lsm_order) {
>   		if (chosen_major_lsm) {
> -			pr_info("security= is ignored because it is superseded by lsm=\n");
> +			pr_warn("security=%s is ignored because it is superseded by lsm=%s\n",
> +				chosen_major_lsm, chosen_lsm_order);
>   			chosen_major_lsm = NULL;
>   		}
>   		ordered_lsm_parse(chosen_lsm_order, "cmdline");
> @@ -339,6 +360,8 @@ static void __init ordered_lsm_init(void)
>   	for (lsm = ordered_lsms; *lsm; lsm++)
>   		prepare_lsm(*lsm);
>   
> +	report_lsm_order();
> +
>   	init_debug("cred blob size       = %d\n", blob_sizes.lbs_cred);
>   	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);
>   	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
> @@ -395,13 +418,17 @@ int __init security_init(void)
>   {
>   	struct lsm_info *lsm;
>   
> -	pr_info("Security Framework initializing\n");
> +	init_debug("legacy security=%s\n", chosen_major_lsm ?: " *unspecified*");
> +	init_debug("  CONFIG_LSM=%s\n", builtin_lsm_order);
> +	init_debug("boot arg lsm=%s\n", chosen_lsm_order ?: " *unspecified*");
>   
>   	/*
>   	 * Append the names of the early LSM modules now that kmalloc() is
>   	 * available
>   	 */
>   	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
> +		init_debug("  early started: %s (%s)\n", lsm->name,
> +			   is_enabled(lsm) ? "enabled" : "disabled");
>   		if (lsm->enabled)
>   			lsm_append(lsm->name, &lsm_names);
>   	}
