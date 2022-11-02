Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86F56156BC
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 01:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiKBArT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 20:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKBArS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 20:47:18 -0400
Received: from sonic307-16.consmr.mail.ne1.yahoo.com (sonic307-16.consmr.mail.ne1.yahoo.com [66.163.190.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8065B1A811
        for <bpf@vger.kernel.org>; Tue,  1 Nov 2022 17:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1667350024; bh=rFMsRSvK76yXWYxv1sYQvrpSF0kCt3i9sjs7q7QMJBk=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=PyICtDzcNHhyONE0u+DgJoBX+wNWrshKGOEU5zsETeYQtuGz/Ot64VUzBagosUkWwloU0bBCYDiMjhRn3atvxBt6fonmniFTHfADBUAXQVzx7jxTR3AXYdgZIOjcLjaYmXYdbNXCeHcU0clDstvJCmnnwbnjFZESFRwW7vsIJl1rnhAkS3IZulz1IH/+xzla9lJwO/TD4WJjI41Y6gKjkaVXPgYHZHxKPOWvyrj7CObCLtaR1rRzKNABXUcchVUshH1zCIaA+44V5ka1DUbfYvkQMUXDhMaLbiu1yhWdvtckaWdlKLzluC9EEOmqfGYZQNmxEa7Q+wAZBWQgrOqqeA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1667350024; bh=YIMTkVKaLiufm1esWFi6si3SB4Xri8sxkq1E3guAK43=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=hj0mKBhtsfLCrb6LhsZAuh/Ir1ecRz43O7GDe/y3RPMMix2oPLKQSV/FSxLt/cLrE6CrjMAfhrCH4SXxvMZg7crKl5G7bpY9Eq6aBMq0LMPFi9Vrr9i75/fZJh5XiJq7nGuDhINcmSLioHCkFEHF8o2BSkSR4nwCV3Se2uuPSGIiovTigueurnRqa/iAdOximEvZ2vHU4ghHya5OQZiWagp72cxGYZUYhyLJygJTYjWv9/1JvceViA+rqKIWUgiiOKFDoBF4sUIW17SryS4DsG6zXcbPHZmr44XK09wb3EH1zaw5ru/7bmyHyJqsW7pjs5VB/0vWMpcXg6zDArZq0w==
X-YMail-OSG: ttK7sikVM1ms0f9E0Ho2gpWk8WUa.nrgYh2QqOEmF0qhCbqeiKeZstTjNIGo9qC
 4_09c8pzpgG5x.6zC0MwCmnGfuxWSP6irrrfg8dOcHWrC5jSBxA3YMwKr0Dzsql5KRVrp6SbcyQi
 D.koCUN.fT__kMFm5fQX.qK4qZiah8fu3YMZJHttv3Mn.71pdsYCCxR9pPmAyLs08ZpCItIrA9eD
 uEa2vVTjOEAjQn.I.EinTFzZfb3RlODIHUEsY1JVuRZPSazE1yp2SmcjLaOM4JCRA41uD8qLuDbn
 y5Ffp1xBUsA9YF2MMKvZBb6JM5rWQu7.oHtn.iHKjqOkpOR7m_stkhuSHv9pKKmo3w4XnTygvyec
 _d42hLSky7HOv7HMHJ8O7QBRiZ_FCUGmgy9EK3O4tcx4shh5iK5xB_SiqstV7CZXe5Ei0MI3cBKK
 nxGgCotwmoB1XVYDBPIems0BEmhKYgnhdL2DbORzCrke.LQhdO0H5CiFDB0nisqVK10eOMoRvRRJ
 mJp8krH64wW8Z.KsT0AvHemnG2vq3tqVm6BeKiLl16uRhwhoKbsnlUbWbICgR5nfTqGAd6epvF4u
 DZTCIqwg28S4lkr4AYux9mhcC_BVBrOCYljhB8_MuB2q52FEely81GDWBFEKBLT5DgJQiLH7OIvg
 12bP6Z6TCVyJC2dpc3MKaY2CkgWV8sSgBtkNSqkLwJJxgurlfiQwYCK1UcWqElOSwkpIV90pK8Zo
 2XVjRUzdXJTbC1hahKDzByuL01zBdRyiEkpBtWBhsEBdGr6vt7DOz8S0nomaTVNyETYRSabH0vPA
 dDPNOlENI5AeFWyCtnDZQFXTnAOEhF7S9Yd_W4HfTJZ9wDrbja_1geKFvoUNHJH.p5iMbhF_B9.p
 Re9ctJjCL1F0K4DoIduJHkblx33eB7kX__lp5VPtShgxYaI7VC4i4ZBaL137gqKguT35dare55vc
 3jkRI.v.Z__irwkhhpCHQM2Iw59CWVtm2dCJw9i80LE95_goYLI3AgZXhaGOimiMLdXBcHU89uQr
 oosyV9Cek0KfGuy8.W0ClNEZl5n5dytSoIg_6nB7bL_MoZ10W5oSyWtG6yHaHryUegqAS9h8Wbnp
 5.hQxmdi4riJuhmg3Ck79CZPbTVsCnjncyd_uKvbwimCz7FXhCnYRai9zqtF0oPkOki2d56jjKBi
 Nr95hPYr4gs2q6qxkQbpsy5U3kmX_cWCRKrsi2aAstYpDB0ADcfGrdpQeguujP3hXmoQCOdIqlKs
 dXS7hyP5wbf9GI94b6z7jNMz7FHOmHTDWOufU9sKd.o.wS09CoFugN7TYx1LuzFegSxOU0gm8Dz2
 VqrzCfvNU72z9v.GLMX27DAGmjXQYaePd4G9lrJpfhKDwBs9gmxN2VuBSuv1N_m_t_7gxo295pov
 fYcOsXo_HWcJ4rnyAxpuu4bqKkMOY_I8bzIAI8ba9RPaooJuWwWoo7B6uHB4GoZaTdoNVQ9Fy8bU
 BNWuSowxqWlA.S7kB5ST9vRyixiZKLP1CcNNju8DQHFN9R4hfIpLDnQ9luwY2u9saSjNIN.HMrc7
 90gghQF21mqbkTla6R1IJoNjFMj0YlyB7gKXP2Hxi7HFsRI9aifocM.lpQIYTp8cgggTivGwxBRS
 I9R459H4AMUhcS.7H89OJvndnwkhuuZd3GEYdL8wbxhYDQGU2Pf9NXZ.4IahRSMU7MutDy7m0pWu
 T7irLBiGKtTLGQubJZe8sRcvLDO2Nf1sWVBaa9reDyWjSOBTHgC2g6WMb4qJqqXrUVyDiiQboEBh
 Hu2VTvqJpvK.9WkrdtjaKjZr_pCeA_YfOqnSspptE8v9rihqBbNN5NKmowUCkTQpnJUHxsnRQjKH
 Twe2.x.fKqLTXXsdZzrpmRRz0RWuBvQY2kaUUWac.rKY9WR9og_3EOi6QKrS7QSlvBj3Im2yyXwv
 7vMGBVTlRTvmhJ6pcpdh208lOv9dIiyOJua2cfJYSSTyfe5OySnm_zvX2Qr.fBDuzFPdv5g1B64D
 rWmOmfPy.t1wnNfEwJYctLzR_4rmIAqR0fp._gDgLfl5X3vVO6AhbrDdzV2U0nZWyxTGs62L_ghn
 AvYXcRukc3BTvyt8P.O9_2tpFeH3SxnpnpH.osBpsfccUjK5_bYsKkwe.ULzUHbHGVzrg_XXGxD7
 j0HDLNeQr7jQxQKmySvUvKdtKbpKq_k4jzi6F5VR1x6Ns_3GMKqEk3pbrcOaPxMsVbQXURaznuwp
 wFD_H993IHm6hH_Lf2nVlH5A6sp7LE4CMrOWU4A--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Wed, 2 Nov 2022 00:47:04 +0000
Received: by hermes--production-bf1-5878955b5f-h4zdf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d0691bd8e6a40c3bfdb33866ea043b85;
          Wed, 02 Nov 2022 00:46:58 +0000 (UTC)
Message-ID: <a737ec91-0eba-94dc-46dc-683abdc96366@schaufler-ca.com>
Date:   Tue, 1 Nov 2022 17:46:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2] LSM: Better reporting of actual LSMs at boot
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, casey@schaufler-ca.com
References: <20221102000525.gonna.409-kees@kernel.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20221102000525.gonna.409-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20783 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/1/2022 5:05 PM, Kees Cook wrote:
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

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

I'm curious about what is driving this change.

> ---
> v2: en/dis-enabled expanded, example output in commit log, use pr_cont.
> v1: https://lore.kernel.org/lkml/20221018064825.never.323-kees@kernel.org/
> ---
>  security/security.c | 45 ++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 36 insertions(+), 9 deletions(-)
>
> diff --git a/security/security.c b/security/security.c
> index 79d82cb6e469..abceabda103d 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -161,8 +161,8 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
>  		lsm->enabled = &lsm_enabled_true;
>  	ordered_lsms[last_lsm++] = lsm;
>  
> -	init_debug("%s ordering: %s (%sabled)\n", from, lsm->name,
> -		   is_enabled(lsm) ? "en" : "dis");
> +	init_debug("%s ordered: %s (%s)\n", from, lsm->name,
> +		   is_enabled(lsm) ? "enabled" : "disabled");
>  }
>  
>  /* Is an LSM allowed to be initialized? */
> @@ -224,7 +224,7 @@ static void __init prepare_lsm(struct lsm_info *lsm)
>  	if (enabled) {
>  		if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
>  			exclusive = lsm;
> -			init_debug("exclusive chosen: %s\n", lsm->name);
> +			init_debug("exclusive chosen:   %s\n", lsm->name);
>  		}
>  
>  		lsm_set_blob_sizes(lsm->blobs);
> @@ -252,7 +252,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  	/* LSM_ORDER_FIRST is always first. */
>  	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
>  		if (lsm->order == LSM_ORDER_FIRST)
> -			append_ordered_lsm(lsm, "first");
> +			append_ordered_lsm(lsm, "  first");
>  	}
>  
>  	/* Process "security=", if given. */
> @@ -270,7 +270,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
>  			    strcmp(major->name, chosen_major_lsm) != 0) {
>  				set_enabled(major, false);
> -				init_debug("security=%s disabled: %s\n",
> +				init_debug("security=%s disabled: %s (only one legacy major LSM)\n",
>  					   chosen_major_lsm, major->name);
>  			}
>  		}
> @@ -291,7 +291,8 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  		}
>  
>  		if (!found)
> -			init_debug("%s ignored: %s\n", origin, name);
> +			init_debug("%s ignored: %s (not built into kernel)\n",
> +				   origin, name);
>  	}
>  
>  	/* Process "security=", if given. */
> @@ -309,7 +310,8 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  		if (exists_ordered_lsm(lsm))
>  			continue;
>  		set_enabled(lsm, false);
> -		init_debug("%s disabled: %s\n", origin, lsm->name);
> +		init_debug("%s skipped: %s (not in requested order)\n",
> +			   origin, lsm->name);
>  	}
>  
>  	kfree(sep);
> @@ -320,6 +322,24 @@ static void __init lsm_early_task(struct task_struct *task);
>  
>  static int lsm_append(const char *new, char **result);
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
>  static void __init ordered_lsm_init(void)
>  {
>  	struct lsm_info **lsm;
> @@ -329,7 +349,8 @@ static void __init ordered_lsm_init(void)
>  
>  	if (chosen_lsm_order) {
>  		if (chosen_major_lsm) {
> -			pr_info("security= is ignored because it is superseded by lsm=\n");
> +			pr_warn("security=%s is ignored because it is superseded by lsm=%s\n",
> +				chosen_major_lsm, chosen_lsm_order);
>  			chosen_major_lsm = NULL;
>  		}
>  		ordered_lsm_parse(chosen_lsm_order, "cmdline");
> @@ -339,6 +360,8 @@ static void __init ordered_lsm_init(void)
>  	for (lsm = ordered_lsms; *lsm; lsm++)
>  		prepare_lsm(*lsm);
>  
> +	report_lsm_order();
> +
>  	init_debug("cred blob size       = %d\n", blob_sizes.lbs_cred);
>  	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);
>  	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
> @@ -395,13 +418,17 @@ int __init security_init(void)
>  {
>  	struct lsm_info *lsm;
>  
> -	pr_info("Security Framework initializing\n");
> +	init_debug("legacy security=%s\n", chosen_major_lsm ?: " *unspecified*");
> +	init_debug("  CONFIG_LSM=%s\n", builtin_lsm_order);
> +	init_debug("boot arg lsm=%s\n", chosen_lsm_order ?: " *unspecified*");
>  
>  	/*
>  	 * Append the names of the early LSM modules now that kmalloc() is
>  	 * available
>  	 */
>  	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
> +		init_debug("  early started: %s (%s)\n", lsm->name,
> +			   is_enabled(lsm) ? "enabled" : "disabled");
>  		if (lsm->enabled)
>  			lsm_append(lsm->name, &lsm_names);
>  	}
