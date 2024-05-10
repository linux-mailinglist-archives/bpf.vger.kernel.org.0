Return-Path: <bpf+bounces-29487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C018C292B
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A9F31C2180E
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 17:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B11317C6B;
	Fri, 10 May 2024 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="dRm22nbh"
X-Original-To: bpf@vger.kernel.org
Received: from sonic312-30.consmr.mail.ne1.yahoo.com (sonic312-30.consmr.mail.ne1.yahoo.com [66.163.191.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47701798C
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 17:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715361501; cv=none; b=s2dJilA5Dq1W5CZ9e1vvB9MprNaDE8t+Y0kLtXzcX6waLlMOyNiTak9P8FqsgkhREsURhffiVNU1xLYYuLIK1D58ZjtYf6xfTBNNzd5lJcjCGl/09KB0rIyHiGI55jNh02ICbHuNqP1ntfWo/TMbG0bndxOIpGGsbx3N+J9iKoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715361501; c=relaxed/simple;
	bh=9OM9BxBAlcx9JR6tbcOD4pzf/znKRwGdvp1zRai5QQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NpbJAv8ncI4rY/zY3Ka+lko4RTAIVseXHZQXOgFWUG3D4PEQ0b7v6sNXSGMOZmzdVVVqQAMeanPZHSTR68Tb84xsT4KQkmdTbNtt3Z2QWcRv3vNJAH7/UpU6Rj8dxF8/zveQRDHNq/y1Vpt2zo670Kpmp0KkJdA+QA88Qbio7no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=dRm22nbh; arc=none smtp.client-ip=66.163.191.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1715361499; bh=CUIC893JPgLDznQixg4v/EZ5F/YydGgEBAttMNitzmw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=dRm22nbhscMbxQXBC8Yj8PjYp7e23LVuZfjGBMNMjzH1MpXEX0mHtOmeanxzcCUS6Kv7TaxSdJEdY4SxCjgNMdG8Sc+JqZ+QfHxiwi0jEbb9bEqd02yiVVWvn/JsDpNvAES8wL13v6Pi4e3TMfqPX87En3SKekU8mGTbcuabmFg8zlowmpO3o/6+ZuvOID/63c/ayyrgzkh/WSxc2QXAMI4srN476511DGdsi4xKTUCZWo5VfGN3uWSwnHJN0/BDpDEspstdKreJvI26tXlki99hsPzXwlNfKGjfVjwDNr1spX3fTYuNaIP7XNJTpMw4zEXX4e7FC/d36SSNGBucfw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1715361499; bh=hyhr26Wn0CG8BayFRr90BB9hsisAnVbpX0q3WGfyDUe=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=kjpUszS5ry8vF5krQ0wrG9oPNIcD82FhazUtjKvEgNk6INQZorvbKTglLwwXDTsP4Dg6tUEt7npHTYAv191nldNH+UI5dm9n4xiDrfCIWqlVjnx4KN2/mZDXLpmfrxMtXUfby+KVxi4dUVGci9GqgRbUqXBJVhQ7/M6HP9bSMjMa1rnlCcXjJoVhRevJ8xArAeDzEFtdFgg6aMq6upGNGBparJJp9Pn7xpHHRf7UprF2qt53fVR2WiJ440sNt1UthXOtj9zIsjuoSLfR8DoSppmrTGOOeDq7otwV/UekVvct9Je12lX3PZ/j6S0re66Z2hJ+elcjyQez+o2sLuvdPQ==
X-YMail-OSG: 35ELR_UVM1mHruWrgaICnKwC5i_Twag6Dci4Mr3Pq27ckQQ4GhDyqraD0UPM9BU
 iS7CFXPU27WwDFdnV4lbBi4qm5fvClrtBI.La58Ro33.cVHr9glT76xubCfW7aw.SPI83lWEnORO
 Eb.T.rXHEUIKtOvm_uvksGG0yWMCIt1lY_t.R1H471TUkiyqZmrjlcUw.Sl4APmmtsRm4v5t3Bfm
 HIRONtxbpVB_2qgWCRvwliKZfTQh_7_qa6nD8DTu3if7Tqz6nvMgSGAhbdQSU4WevjP3dbbKHbZL
 JkEDknKRsOpAUt3rskfISGjjT45h6AVrRzf4vIEwmbnBw64AoLtzftOgyRanq4zAgEDXjQQXBA7i
 GTSEFomoIQ7WGIhEQ8uAvGufM7KSqykDY7QswGXQzQey.vgpZSTZrOc8BqlOmUcwCLM8J90d36yK
 U1y7AtkqRNhx9NT_O0hKi_5oviRPjTUAR_sXRQpiLxz6kgdFwjms.HXoo2PSSbwMDZiPuwpvPSel
 BFRLCUV5ju.Uwe3vNPMnhAdIppD47yDSAeNwn2W8Z60d.wJIm1J_LhKkK6qF5cGJVpn0oFeuFiT7
 H65WvEXedzwbsO.Emx_nzMBGIiCSOpaF4fNPJm.L7rtyGGBoHI7.C4dNkxsyfFN2uoRnYq_HlBsi
 hIBOQ.XTrNEZvXxc9AQAdf79gKvNArq2WRG5zBAwd.MeS6QBT1Bcs4Z42coNbgJYGpK8UoGhSoZ5
 vVuERwMZzDBwzO36TcQu.trajkqukWmSCx9mU3PlDMsqfV01eqNixsbQekmyndxUmHeIzUVCyLxB
 Gvzhzz1q0rDkEiOCx0sOSVjIhEaNMEvksi9EJMlL2jXj4VGMQUWAwTMKsVTnrjP16C6_9wJCQSPk
 5TW0OvOqRo_CaFW.rpN6NWufPMTrGOkdg5m7yH39QKbQ2sJTs2TzZ1mDE7HK5zJEK3ly8t.XHbb_
 2zmbWwG53GiHU1Nidocg5PUJ3.9ANh7dUYHg7W3zuu_Ph3huhy7ikbqtQm9n_fmQZYEwmQDk9oBU
 b4O29Vp2yUqcqJSLqtWF6qNWijKsV57cnaQuWhXlz6g1y1JoMwT6026T_nXVanpBVNlGi6OGpKmP
 0Ux.J.t9A4kCuRKW93wXJNRBMO_VO_IKSJ7RLYfoDkuUK2vMofiBwvQbBMocc7HQ.5HuZH7Q5S7c
 ti6Vlj2K9ntV1SB3vJ7JN3IzwgyhCkbeP6G7lsfY3rYpIBEb6q5OCSKEcpwqTxBK9O8aIngs6lqN
 6bpaDTV_EmUxet9fL60aLjVLRBxobWY3kOxe8eN2yLzQpO.uikafFG_RZjmuhi4WI_xj4oAgZG1I
 hlHhU0B.SHDnnKsx3QHVZXhuXrTxXWR0wAgM9Wl2BuJKtYLHe0QooULGPNAO.Ymqr7_oc0h8_pu6
 MWty2vffyKs5HmfVhIcLkQ.h21Zafvuk6NA5yDZBgEVordKJpliELAjjPWI5H3GmQmC70VzLwC48
 Wtz8IDS3m1hBql0fqK5t9f9hsOohgyS5yk8dC1ne6W97VNMw_DYouhXUSKR2trzTwne0hckhPQlp
 6HBsh2IIuEO91xQO_x2YoMw_6S3dLAfqtufwtKuhpQXe9QSXOMf5D3BIqzq_pqGEguXfPrMiKaTm
 W2GnN0EASOGXYk8HU6yVzH07MH1b9s0TWXHic_hMp79uYhh3J92oTuOu7C3NAHKONFI5Q8u9PA5.
 sjzHyILbBIaK4MJI7CYCqBXbGI0D3mrXBcPpdgRGyLclJE7f0oJglheSdjoyxs8xFnzDIX1laEo7
 b58_8duyZnolTcQVK0kCp08pPn0G8GQSp.82FeG2lKwp8MGXt5KjqSRyaOuKrI.8ZrOkJtPcvs0s
 lJeRh3wOKQkPn9GndYdDieko6Fx8zqu2r0RpbIgbtPkTsY4QvHsJxIhOmhDLSXgj13s5Q72hbeup
 7Bj.e62jrm2AJVuoP4104jZvDp1Rmvdt3xSpZEiUjSXjENuP2JzDj_DoYuiDHymdUMKpVDCuzUIz
 cBFADmXk97jmX5vX8QyOdEfYU3VwekP5LkLFpLqSVTNkUq60Eil3Ibcm5kuV2is3cMcuero_QFOf
 i7NgIwnmIU8U7nhAXaTOOJbFwoCxApxW_kltf7TfAomvO43m65wSOtSHslKIaYHfr9pzzSNzI.dD
 M68jvzNY_sdaK6lX781G.NcG.pewgUXXwFxArqTZJm41gUPrZsgb1S06.TQ3UGyMVwvLr82RR1_X
 RkBp7O6AG4HsbMSKzUdGrs_3UaSyuS1xdL1HRiDlcOnTj0riURK1woX1Yuw8JN9lPQLO5ZYDoLHe
 wvKbPhQd5TmqLGD0FWw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 5ea9c975-ad2a-4336-8106-2f9539c66b01
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Fri, 10 May 2024 17:18:19 +0000
Received: by hermes--production-gq1-59c575df44-2njcf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 02e28cfe366f359f4bff8812dfd7f276;
          Fri, 10 May 2024 17:08:05 +0000 (UTC)
Message-ID: <62a282e2-4cd5-4222-a223-9d38822a6b38@schaufler-ca.com>
Date: Fri, 10 May 2024 10:08:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 4/5] security: Update non standard hooks to use static
 calls
To: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org
Cc: ast@kernel.org, paul@paul-moore.com, andrii@kernel.org,
 keescook@chromium.org, daniel@iogearbox.net, renauld@google.com,
 revest@chromium.org, song@kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240509201421.905965-1-kpsingh@kernel.org>
 <20240509201421.905965-5-kpsingh@kernel.org>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240509201421.905965-5-kpsingh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22321 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 5/9/2024 1:14 PM, KP Singh wrote:
> There are some LSM hooks which do not use the common pattern followed
> by other LSM hooks and thus cannot use call_{int, void}_hook macros and
> instead use lsm_for_each_hook macro which still results in indirect
> call.
>
> There is one additional generalizable pattern where a hook matching an
> lsmid is called and the indirect calls for these are addressed with the
> newly added call_hook_with_lsmid macro which internally uses an
> implementation similar to call_int_hook but has an additional check that
> matches the lsmid.
>
> For the generic case the lsm_for_each_hook macro is updated to accept
> logic before and after the invocation of the LSM hook (static call) in
> the unrolled loop.
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>

A couple of comments below, nonetheless ...

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  security/security.c | 229 ++++++++++++++++++++++++--------------------
>  1 file changed, 125 insertions(+), 104 deletions(-)
>
> diff --git a/security/security.c b/security/security.c
> index 39ffe949e509..491b807a8a63 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -945,10 +945,41 @@ out:									\
>  	RC;								\
>  })
>  
> -#define lsm_for_each_hook(scall, NAME)					\
> -	for (scall = static_calls_table.NAME;				\
> -	     scall - static_calls_table.NAME < MAX_LSM_COUNT; scall++)  \
> -		if (static_key_enabled(&scall->active->key))
> +/*
> + * Can be used in the context passed to lsm_for_each_hook to get the lsmid of the
> + * current hook
> + */
> +#define current_lsmid() _hook_lsmid
> +
> +#define __CALL_HOOK(NUM, HOOK, RC, BODY_BEFORE, BODY_AFTER, ...)	     \
> +do {									     \
> +	int __maybe_unused _hook_lsmid;					     \
> +									     \
> +	if (static_branch_unlikely(&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM))) {  \
> +		_hook_lsmid = static_calls_table.HOOK[NUM].hl->lsmid->id;    \
> +		BODY_BEFORE						     \
> +		RC = static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__);   \
> +		BODY_AFTER						     \
> +	}								     \
> +} while (0);
> +
> +#define lsm_for_each_hook(HOOK, RC, BODY, ...)	\
> +	LSM_LOOP_UNROLL(__CALL_HOOK, HOOK, RC, ;, BODY, __VA_ARGS__)
> +
> +#define call_hook_with_lsmid(HOOK, LSMID, ...)				\
> +({									\
> +	__label__ out;							\
> +	int RC = LSM_RET_DEFAULT(HOOK);					\
> +									\
> +	LSM_LOOP_UNROLL(__CALL_HOOK, HOOK, RC, {			\
> +		if (current_lsmid() != LSMID)				\
> +			continue;					\
> +	}, {								\
> +		goto out;						\
> +	}, __VA_ARGS__);						\
> +out:									\
> +	RC;								\
> +})

I like how clean these macros look ...

>  
>  /* Security operations */
>  
> @@ -1184,7 +1215,6 @@ int security_settime64(const struct timespec64 *ts, const struct timezone *tz)
>   */
>  int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
>  {
> -	struct lsm_static_call *scall;
>  	int cap_sys_admin = 1;
>  	int rc;
>  
> @@ -1195,13 +1225,18 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
>  	 * agree that it should be set it will. If any module
>  	 * thinks it should not be set it won't.
>  	 */
> -	lsm_for_each_hook(scall, vm_enough_memory) {
> -		rc = scall->hl->hook.vm_enough_memory(mm, pages);
> -		if (rc <= 0) {
> -			cap_sys_admin = 0;
> -			break;
> -		}
> -	}
> +
> +	lsm_for_each_hook(
> +		vm_enough_memory, rc,
> +		{
> +			if (rc <= 0) {
> +				cap_sys_admin = 0;
> +				goto out;
> +			}
> +		},
> +		mm, pages);
> +
> +out:

... but the invocations are quite hideous. Because this looks like code that's
messed up I would like to see it commented, perhaps something like

+
+	lsm_for_each_hook(
+		vm_enough_memory, rc,
+		/* BLOCK BEFORE */
+		{
+			if (rc <= 0) {
+				cap_sys_admin = 0;
+				goto out;
+			}
+		},
+		/* END BLOCK BEFORE */
+		mm, pages);
+
+out:

>  	return __vm_enough_memory(mm, pages, cap_sys_admin);
>  }
>  
> @@ -1343,17 +1378,19 @@ int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
>  int security_fs_context_parse_param(struct fs_context *fc,
>  				    struct fs_parameter *param)
>  {
> -	struct lsm_static_call *scall;
> -	int trc;
> +	int trc = LSM_RET_DEFAULT(fs_context_parse_param);
>  	int rc = -ENOPARAM;
>  
> -	lsm_for_each_hook(scall, fs_context_parse_param) {
> -		trc = scall->hl->hook.fs_context_parse_param(fc, param);
> -		if (trc == 0)
> -			rc = 0;
> -		else if (trc != -ENOPARAM)
> -			return trc;
> -	}
> +	lsm_for_each_hook(
> +		fs_context_parse_param, trc,
> +		{
> +			if (trc == 0)
> +				rc = 0;
> +			else if (trc != -ENOPARAM)
> +				return trc;
> +		},
> +		fc, param);
> +
>  	return rc;
>  }
>  
> @@ -1578,15 +1615,17 @@ int security_sb_set_mnt_opts(struct super_block *sb,
>  			     unsigned long kern_flags,
>  			     unsigned long *set_kern_flags)
>  {
> -	struct lsm_static_call *scall;
>  	int rc = mnt_opts ? -EOPNOTSUPP : LSM_RET_DEFAULT(sb_set_mnt_opts);
>  
> -	lsm_for_each_hook(scall, sb_set_mnt_opts) {
> -		rc = scall->hl->hook.sb_set_mnt_opts(sb, mnt_opts, kern_flags,
> -					      set_kern_flags);
> -		if (rc != LSM_RET_DEFAULT(sb_set_mnt_opts))
> -			break;
> -	}
> +	lsm_for_each_hook(
> +		sb_set_mnt_opts, rc,
> +		{
> +			if (rc != LSM_RET_DEFAULT(sb_set_mnt_opts))
> +				goto out;
> +		},
> +		sb, mnt_opts, kern_flags, set_kern_flags);
> +
> +out:
>  	return rc;
>  }
>  EXPORT_SYMBOL(security_sb_set_mnt_opts);
> @@ -1777,7 +1816,6 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
>  				 const struct qstr *qstr,
>  				 const initxattrs initxattrs, void *fs_data)
>  {
> -	struct lsm_static_call *scall;
>  	struct xattr *new_xattrs = NULL;
>  	int ret = -EOPNOTSUPP, xattr_count = 0;
>  
> @@ -1795,18 +1833,19 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
>  			return -ENOMEM;
>  	}
>  
> -	lsm_for_each_hook(scall, inode_init_security) {
> -		ret = scall->hl->hook.inode_init_security(inode, dir, qstr, new_xattrs,
> -						  &xattr_count);
> -		if (ret && ret != -EOPNOTSUPP)
> -			goto out;
> +	lsm_for_each_hook(
> +		inode_init_security, ret,
> +		{
>  		/*
>  		 * As documented in lsm_hooks.h, -EOPNOTSUPP in this context
>  		 * means that the LSM is not willing to provide an xattr, not
>  		 * that it wants to signal an error. Thus, continue to invoke
>  		 * the remaining LSMs.
>  		 */
> -	}
> +			if (ret && ret != -EOPNOTSUPP)
> +				goto out;
> +		},
> +		inode, dir, qstr, new_xattrs, &xattr_count);
>  
>  	/* If initxattrs() is NULL, xattr_count is zero, skip the call. */
>  	if (!xattr_count)
> @@ -3601,16 +3640,19 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
>  {
>  	int thisrc;
>  	int rc = LSM_RET_DEFAULT(task_prctl);
> -	struct lsm_static_call *scall;
> -
> -	lsm_for_each_hook(scall, task_prctl) {
> -		thisrc = scall->hl->hook.task_prctl(option, arg2, arg3, arg4, arg5);
> -		if (thisrc != LSM_RET_DEFAULT(task_prctl)) {
> -			rc = thisrc;
> -			if (thisrc != 0)
> -				break;
> -		}
> -	}
> +
> +	lsm_for_each_hook(
> +		task_prctl, thisrc,
> +		{
> +			if (thisrc != LSM_RET_DEFAULT(task_prctl)) {
> +				rc = thisrc;
> +				if (thisrc != 0)
> +					goto out;
> +			}
> +		},
> +		option, arg2, arg3, arg4, arg5);
> +
> +out:
>  	return rc;
>  }
>  
> @@ -4010,7 +4052,6 @@ EXPORT_SYMBOL(security_d_instantiate);
>  int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
>  			 u32 __user *size, u32 flags)
>  {
> -	struct lsm_static_call *scall;
>  	struct lsm_ctx lctx = { .id = LSM_ID_UNDEF, };
>  	u8 __user *base = (u8 __user *)uctx;
>  	u32 entrysize;
> @@ -4048,31 +4089,40 @@ int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
>  	 * In the usual case gather all the data from the LSMs.
>  	 * In the single case only get the data from the LSM specified.
>  	 */
> -	lsm_for_each_hook(scall, getselfattr) {
> -		if (single && lctx.id != scall->hl->lsmid->id)
> -			continue;
> -		entrysize = left;
> -		if (base)
> -			uctx = (struct lsm_ctx __user *)(base + total);
> -		rc = scall->hl->hook.getselfattr(attr, uctx, &entrysize, flags);
> -		if (rc == -EOPNOTSUPP) {
> -			rc = 0;
> -			continue;
> -		}
> -		if (rc == -E2BIG) {
> -			rc = 0;
> -			left = 0;
> -			toobig = true;
> -		} else if (rc < 0)
> -			return rc;
> -		else
> -			left -= entrysize;
> +	LSM_LOOP_UNROLL(
> +		__CALL_HOOK, getselfattr, rc,
> +		/* BODY_BEFORE */
> +		{
> +			if (single && lctx.id != current_lsmid())
> +				continue;
> +			entrysize = left;
> +			if (base)
> +				uctx = (struct lsm_ctx __user *)(base + total);
> +		},
> +		/* BODY_AFTER */
> +		{
> +			if (rc == -EOPNOTSUPP) {
> +				rc = 0;
> +			} else {
> +				if (rc == -E2BIG) {
> +					rc = 0;
> +					left = 0;
> +					toobig = true;
> +				} else if (rc < 0)
> +					return rc;
> +				else
> +					left -= entrysize;
> +
> +				total += entrysize;
> +				count += rc;
> +				if (single)
> +					goto out;
> +			}
> +		},
> +		attr, uctx, &entrysize, flags);
> +
> +out:
>  
> -		total += entrysize;
> -		count += rc;
> -		if (single)
> -			break;
> -	}
>  	if (put_user(total, size))
>  		return -EFAULT;
>  	if (toobig)
> @@ -4103,9 +4153,8 @@ int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
>  int security_setselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
>  			 u32 size, u32 flags)
>  {
> -	struct lsm_static_call *scall;
>  	struct lsm_ctx *lctx;
> -	int rc = LSM_RET_DEFAULT(setselfattr);
> +	int rc;
>  	u64 required_len;
>  
>  	if (flags)
> @@ -4126,11 +4175,7 @@ int security_setselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
>  		goto free_out;
>  	}
>  
> -	lsm_for_each_hook(scall, setselfattr)
> -		if ((scall->hl->lsmid->id) == lctx->id) {
> -			rc = scall->hl->hook.setselfattr(attr, lctx, size, flags);
> -			break;
> -		}
> +	rc = call_hook_with_lsmid(setselfattr, lctx->id, attr, lctx, size, flags);
>  
>  free_out:
>  	kfree(lctx);
> @@ -4151,14 +4196,7 @@ int security_setselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
>  int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
>  			 char **value)
>  {
> -	struct lsm_static_call *scall;
> -
> -	lsm_for_each_hook(scall, getprocattr) {
> -		if (lsmid != 0 && lsmid != scall->hl->lsmid->id)
> -			continue;
> -		return scall->hl->hook.getprocattr(p, name, value);
> -	}
> -	return LSM_RET_DEFAULT(getprocattr);
> +	return call_hook_with_lsmid(getprocattr, lsmid, p, name, value);
>  }
>  
>  /**
> @@ -4175,14 +4213,7 @@ int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
>   */
>  int security_setprocattr(int lsmid, const char *name, void *value, size_t size)
>  {
> -	struct lsm_static_call *scall;
> -
> -	lsm_for_each_hook(scall, setprocattr) {
> -		if (lsmid != 0 && lsmid != scall->hl->lsmid->id)
> -			continue;
> -		return scall->hl->hook.setprocattr(name, value, size);
> -	}
> -	return LSM_RET_DEFAULT(setprocattr);
> +	return call_hook_with_lsmid(setprocattr, lsmid, name, value, size);
>  }
>  
>  /**
> @@ -5267,23 +5298,13 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
>  				       struct xfrm_policy *xp,
>  				       const struct flowi_common *flic)
>  {
> -	struct lsm_static_call *scall;
> -	int rc = LSM_RET_DEFAULT(xfrm_state_pol_flow_match);
> -
>  	/*
>  	 * Since this function is expected to return 0 or 1, the judgment
>  	 * becomes difficult if multiple LSMs supply this call. Fortunately,
>  	 * we can use the first LSM's judgment because currently only SELinux
>  	 * supplies this call.
> -	 *
> -	 * For speed optimization, we explicitly break the loop rather than
> -	 * using the macro
>  	 */
> -	lsm_for_each_hook(scall, xfrm_state_pol_flow_match) {
> -		rc = scall->hl->hook.xfrm_state_pol_flow_match(x, xp, flic);
> -		break;
> -	}
> -	return rc;
> +	return call_int_hook(xfrm_state_pol_flow_match, x, xp, flic);
>  }
>  
>  /**

