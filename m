Return-Path: <bpf+bounces-29486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2B18C291E
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74B191F24066
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 17:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCD717C6A;
	Fri, 10 May 2024 17:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="E0dfmbPL"
X-Original-To: bpf@vger.kernel.org
Received: from sonic301-38.consmr.mail.ne1.yahoo.com (sonic301-38.consmr.mail.ne1.yahoo.com [66.163.184.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BDA168BD
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 17:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715361070; cv=none; b=r2MLg4UwwuQ4Zs40wLtRKs12dg2/1X2RcZukqJG1p6/Cf0OFxu6A3IKMfz4iUAAK2JON4rCfaUbcqqF0mjAVc19BsJ6PKMYP1i8+MT8TraSiV8p9YzF9GfJVtm4LtOXbEQt1cbV6usp1hvYypIJ6kzpvWVTvmqsUW2wSeeK1MHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715361070; c=relaxed/simple;
	bh=J4jw99UZQhaWV9TBrFG1/+ogEq+zfiW2uamFrottctY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IaKiEE4+ta0uoWzMsvlJrL8xNJl/vbTs9RfegLoV2+JBxkGnQTyvR0p89Utl/UJwLvjm1BBNZBQsh8sg4jJ0VmFXTIq61dAYkC6rPo2FuEZWVO7z0QQID0ZCjUEW7SAIO7+QK4waY96fmSTAN5lt0J6ifvYGCsAmP/+er8ghY6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=E0dfmbPL; arc=none smtp.client-ip=66.163.184.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1715361067; bh=8PvcDS6xrsPjpXc6V6K4XXDCQmKdIRJzrT6DMnGmcGU=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=E0dfmbPL+l2ZaKGSCQ19dAAstR/CWCJ9TQbhpqjleB8qI7A8oNLraRDeTPwNp+45BJLQpLJB3Nbavw2Mb6F+ROGpNXyo4epJm1+AtKgnaLBq4AdxLimmCng1AwTYJ3HfSJmyNVIFZPoY3BDAenCMxILo+fYA2M+FNHapK96LDPoqxoyMFDy765hPttG8L+nlLZXqgl9swy2u710QCoVeg+VAAL4pwvHlWBA1hT+RsH3o5PgOseSUwS3HluI2VdV9DCabBAm2KPzOFR83EKm4btNupTH8FZb1oFDO0dC+R8EAZO+KqkA6VhW0G1yrlvQyC1lXsTdRR1VEKiGztMUCjQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1715361067; bh=NBS+rKgoK072ewIsBLwI8f/cizv6/RYuQPNcHq2nAR/=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=q9PwkIkzvm0tfCG12Tc445y1Cpp92Lbc7s/mnk+aqGTbBiNbbZ1fLk/yJCyym7pghBcG8UR1S+NuJR6Ejpqu5vYZI/csOFs+UFan07aODGPd0LYY1cyGsBm4mEm463ZSNLFO31ZfMLXccMsnXq7w6l0aDN456fSpjq0ufME0t05oALM4W9BN9HmWEbJNhrwlD7VI5BqXBt2Kji1baVi8ZIHFq5pl2KkBjgMavve1Gh0aadk/ZQessj1vlF1NYF2DZmjRrUw1BFKLR9etG1WLF3j6q9T3neEXPDTA19ru9EnMVSiNtnUhPO6+U5lYw2hazI3nVPEiA+7d114AepGmww==
X-YMail-OSG: w3.MSagVM1lbhV6iScExmTsdldOWEc5o9HsF2aXi4s3avb6p.IoctBm3iSvAgRE
 XTSWhQO.zsp6P_2ETbOXiM7NaU4lpGCYAoNNHkeDezgbGZEUzd1sOk5Ajj7GYWOk.XhAuwxOZ0jB
 ES3tQXF4QUyV2N_Wb7v01x2ela5yzcQrJ9b655d0VFjYnzyy0r_PGtG3xyoSuY7KXcHbLJA.CzCP
 rKzkHWdmqm3Tm41PlG_9Be7WqtyCLujcIgeq8sjcXSi7v1sFEIC6qu5TQqSRLqgbCqdAiinkP7Kx
 agZ4_ro.PRRR8MO5CQnO.pn3NtVMCoh2i6uoXzIrPG2qTL_9mBaXxGPvZxN6rDUyJxlRDXaiB0xq
 Zq9njs8azE4ifqQUUTI_I3eDo7YQCl1BrxhTanJBm8JzeclaQKy7WmVtVRs7AX.HaPEO9uRuTUCJ
 hy0wBIfRS.Sc86cqryplN9IsPizqOMN2JyqXaT3_ld2yKLTvaBlByiVOYPEAHW5WOdp9bL7Nhidu
 G8RXQLyD.PAdYVPpfnrv5DjHGSgT48APJDDvLaZcTMkVQJwhiVpStrBlell80rEIh8pn_svTzmnG
 yt97kS2_xrMezAb0CRoWiPmSjl2cDTKNOPvJQsiBpz7yvAA5pRGzDGlwMMHiy1RVo_TP2Tc5uUZD
 rxPG9TcK.ETwGuXKzcgjt4yP033F8Iz4y4.4RQVe9WPDifoJ8uzZdCJIz6_bmlqqK2c_0EElhDUf
 8y6b86JwGvzwBogwAHAd7681nAlDS8XRfFMCiPtUv9zgQUdAGxNz7HkYB2wKXZRLGXkD7xL0_Z7p
 g.ZDbdUomQUe4KAvmyh9lT0L9Mijbqa7uvE0JP_zFJ_.hoJ0cqaSzK4DAsp7Ofs1XziH09BhdP1t
 BHBFHT7i87x9Bqv_TBbFS.s1hQGqGSg6ZL5ICkvaPi_8ezPy7ODlIIQZfEQi.7DvGPu_iJ93vKEF
 x7gZgP_MHyxCb_vVF9TzPwwtxz.xUHy6Z_UgwJXQ7TyhBgsQoESjIhjLmUL1Lvv1Bm4Cc9.b2COi
 qOJq54hCE7BZJL.NTZPs2x2UhHVc9k.9AgKcPoNYx8o44kiG0TjOsVmO909_vA1IlKysvAsM57zH
 8.dXNmCPc5BekoN0JqUeoBwU7YKTQpqWdzwa9zxkB5A3q_0B_SpdldiUHs7u3rZxvnUGgWuPbP3B
 E9OE7PwgDQ9VzoSzihnIyjDK1mj4M90AkEJ5Ib6UW0ShtTeXSvxItMK7Z2gEGuBeN.KzTSY56G8Y
 FBGSHjTT4_N2KxsU6eOG2PbOKERPKakVPbaoyYZWyoXxG_.knS_WpRbsfCfap5TXl2GxIrOYyI5G
 HET0fYoi57Xv2PRqgJ3MxxCoiof4DFwW9ukXJjQeL9R3YCMgW8NQEiJjAR1qoyoerXy8_dBJr0Lh
 iV1_rFHl5cQpS5qvX1DTX.3oMIHjgQM75JMsLmr_LBvWxUVLz.iv1I1TdxDiG7_aXQPNA60tt9jm
 OZdlogNFZTjUJGIJokF4gic5fgc0wYubz0BaJ_hmLTKcUW2__7L0izMpWz9ZSGjBsNH6ZnhJLiqM
 4AEuRSQagNIJ010LBLSLdwwJ906tvN99MAopS0Ml1M_LXstk9u8OiCytKjkgZ4byvQL4ADvTBf9x
 VVH0GFDiGD_xOoKGEYBa4dVByopGcyOXg4H3QW.Atarw95NEhmmJaVxFEGN6PkPK0YGGgLpLL4gw
 nw5IP3.SQhG32kzZjLaJdIO8yxeGDjUooBbrVVVF.54l0HhfKICpBTmQpjH4XopOMb.2nxlwVoWC
 N.4iyPR9JUPgD_ZIQqbwTHVHHCXr6aKmX1TdYLTyZVjogFzvfPzcLzNRJXHjSbDCSyTkm1kHqcl7
 ZFWmtZ0dLxZ4HJFrbX4fypTp83KbSAXKR8RLyp0u3S7e3IaP4whk10EpRSXKd7gL5gabD_8B2kHz
 Y7J0pbJIWuKLmWTP8jJvkLwJ7cVM_wujseLiRaIhm9zUnTy21S9hYR.sSCpkm7Wu4lpekfhfWiZ2
 Aiv0.wIW6A4GLVGKrUDZzfoLqSGM99NgRmEeZrnYhUVIwVJ2.qDz8qI1wRw5UG.OaFxf0QyqVCUz
 lxg7ofNWh4ZWDnSqsqU96ZBmaNw23DoVQgt8KdCh28T01mV6T0dgTWt7Tb6EdgJVyfint7_fQvd3
 xraLxfjhFTZPKpumjVilnJc9lgymJaF0Q9L9rc8S2.mnxG2I0VRpgdOobmRJdZod2_CfBAfUtgmR
 x.M_oWW61ikabLof2DGErI56IYl8m.WzWt27kp9d2HVa99OQLooz3DWRzOEjYt05.hHNfQn3viti
 VGljsZ370HDApaXcing--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 4a6bcc65-2d47-41bd-934b-81b2ede12e81
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Fri, 10 May 2024 17:11:07 +0000
Received: by hermes--production-gq1-59c575df44-9fhd5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ddd4059f127aff04dd8bbec0a94323a9;
          Fri, 10 May 2024 17:11:02 +0000 (UTC)
Message-ID: <576d65ff-06c0-4a1d-a6a8-10e416519d95@schaufler-ca.com>
Date: Fri, 10 May 2024 10:11:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 5/5] bpf: Only enable BPF LSM hooks when an LSM
 program is attached
To: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org
Cc: ast@kernel.org, paul@paul-moore.com, andrii@kernel.org,
 keescook@chromium.org, daniel@iogearbox.net, renauld@google.com,
 revest@chromium.org, song@kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240509201421.905965-1-kpsingh@kernel.org>
 <20240509201421.905965-6-kpsingh@kernel.org>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240509201421.905965-6-kpsingh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22321 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 5/9/2024 1:14 PM, KP Singh wrote:
> BPF LSM hooks have side-effects (even when a default value's returned)
> as some hooks end up behaving differently due to the very presence of
> the hook.
>
> The static keys guarding the BPF LSM hooks are disabled by default and
> enabled only when a BPF program is attached implementing the hook
> logic. This avoids the issue of the side-effects and also the minor
> overhead associated with the empty callback.
>
> security_file_ioctl:
>    0xff...0e30 <+0>:	endbr64
>    0xff...0e34 <+4>:	nopl   0x0(%rax,%rax,1)
>    0xff...0e39 <+9>:	push   %rbp
>    0xff...0e3a <+10>:	push   %r14
>    0xff...0e3c <+12>:	push   %rbx
>    0xff...0e3d <+13>:	mov    %rdx,%rbx
>    0xff...0e40 <+16>:	mov    %esi,%ebp
>    0xff...0e42 <+18>:	mov    %rdi,%r14
>    0xff...0e45 <+21>:	jmp    0xff...0e57 <security_file_ioctl+39>
>    				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
>    Static key enabled for SELinux
>
>    0xff...0e47 <+23>:	xchg   %ax,%ax
>    			^^^^^^^^^^^^^^
>
>    Static key disabled for BPF. This gets patched when a BPF LSM
>    program is attached
>
>    0xff...0e49 <+25>:	xor    %eax,%eax
>    0xff...0e4b <+27>:	xchg   %ax,%ax
>    0xff...0e4d <+29>:	pop    %rbx
>    0xff...0e4e <+30>:	pop    %r14
>    0xff...0e50 <+32>:	pop    %rbp
>    0xff...0e51 <+33>:	cs jmp 0xff...0000 <__x86_return_thunk>
>    0xff...0e57 <+39>:	endbr64
>    0xff...0e5b <+43>:	mov    %r14,%rdi
>    0xff...0e5e <+46>:	mov    %ebp,%esi
>    0xff...0e60 <+48>:	mov    %rbx,%rdx
>    0xff...0e63 <+51>:	call   0xff...33c0 <selinux_file_ioctl>
>    0xff...0e68 <+56>:	test   %eax,%eax
>    0xff...0e6a <+58>:	jne    0xff...0e4d <security_file_ioctl+29>
>    0xff...0e6c <+60>:	jmp    0xff...0e47 <security_file_ioctl+23>
>    0xff...0e6e <+62>:	endbr64
>    0xff...0e72 <+66>:	mov    %r14,%rdi
>    0xff...0e75 <+69>:	mov    %ebp,%esi
>    0xff...0e77 <+71>:	mov    %rbx,%rdx
>    0xff...0e7a <+74>:	call   0xff...e3b0 <bpf_lsm_file_ioctl>
>    0xff...0e7f <+79>:	test   %eax,%eax
>    0xff...0e81 <+81>:	jne    0xff...0e4d <security_file_ioctl+29>
>    0xff...0e83 <+83>:	jmp    0xff...0e49 <security_file_ioctl+25>
>    0xff...0e85 <+85>:	endbr64
>    0xff...0e89 <+89>:	mov    %r14,%rdi
>    0xff...0e8c <+92>:	mov    %ebp,%esi
>    0xff...0e8e <+94>:	mov    %rbx,%rdx
>    0xff...0e91 <+97>:	pop    %rbx
>    0xff...0e92 <+98>:	pop    %r14
>    0xff...0e94 <+100>:	pop    %rbp
>    0xff...0e95 <+101>:	ret
>
> This patch enables this by providing a LSM_HOOK_INIT_TOGGLEABLE
> variant which allows the LSMs to opt-in to toggleable hooks which can
> be toggled on/off with security_toogle_hook.
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>

I know that there's still some bikeshedding to deal with, but
I don't see that significantly affecting the behavior.

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  include/linux/lsm_hooks.h | 30 ++++++++++++++++++++++++++++-
>  kernel/bpf/trampoline.c   | 40 +++++++++++++++++++++++++++++++++++----
>  security/bpf/hooks.c      |  2 +-
>  security/security.c       | 37 +++++++++++++++++++++++++++++++++++-
>  4 files changed, 102 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 5db244308c92..5c0918ed6b80 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -110,11 +110,14 @@ struct lsm_id {
>   * @scalls: The beginning of the array of static calls assigned to this hook.
>   * @hook: The callback for the hook.
>   * @lsm: The name of the lsm that owns this hook.
> + * @default_state: The state of the LSM hook when initialized. If set to false,
> + * the static key guarding the hook will be set to disabled.
>   */
>  struct security_hook_list {
>  	struct lsm_static_call	*scalls;
>  	union security_list_options	hook;
>  	const struct lsm_id		*lsmid;
> +	bool				toggleable;
>  } __randomize_layout;
>  
>  /*
> @@ -164,7 +167,19 @@ static inline struct xattr *lsm_get_xattr_slot(struct xattr *xattrs,
>  #define LSM_HOOK_INIT(NAME, HOOK)			\
>  	{						\
>  		.scalls = static_calls_table.NAME,	\
> -		.hook = { .NAME = HOOK }		\
> +		.hook = { .NAME = HOOK },		\
> +		.toggleable = false			\
> +	}
> +
> +/*
> + * Toggleable LSM hooks are enabled at runtime with
> + * security_toggle_hook and are initialized as inactive.
> + */
> +#define LSM_HOOK_INIT_TOGGLEABLE(NAME, HOOK)		\
> +	{						\
> +		.scalls = static_calls_table.NAME,	\
> +		.hook = { .NAME = HOOK },		\
> +		.toggleable = true			\
>  	}
>  
>  extern char *lsm_names;
> @@ -206,4 +221,17 @@ extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
>  extern int lsm_inode_alloc(struct inode *inode);
>  extern struct lsm_static_calls_table static_calls_table __ro_after_init;
>  
> +#ifdef CONFIG_SECURITY
> +
> +int security_toggle_hook(void *addr, bool value);
> +
> +#else
> +
> +static inline int security_toggle_hook(void *addr, bool value)
> +{
> +	return -EINVAL;
> +}
> +
> +#endif /* CONFIG_SECURITY */
> +
>  #endif /* ! __LINUX_LSM_HOOKS_H */
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index db7599c59c78..5758c5681023 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -521,6 +521,21 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
>  	}
>  }
>  
> +static int bpf_trampoline_toggle_lsm(struct bpf_trampoline *tr,
> +				      enum bpf_tramp_prog_type kind)
> +{
> +	struct bpf_tramp_link *link;
> +	bool found = false;
> +
> +	hlist_for_each_entry(link, &tr->progs_hlist[kind], tramp_hlist) {
> +		if (link->link.prog->type == BPF_PROG_TYPE_LSM) {
> +			found  = true;
> +			break;
> +		}
> +	}
> +	return security_toggle_hook(tr->func.addr, found);
> +}
> +
>  static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr)
>  {
>  	enum bpf_tramp_prog_type kind;
> @@ -560,11 +575,22 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_tr
>  
>  	hlist_add_head(&link->tramp_hlist, &tr->progs_hlist[kind]);
>  	tr->progs_cnt[kind]++;
> -	err = bpf_trampoline_update(tr, true /* lock_direct_mutex */);
> -	if (err) {
> -		hlist_del_init(&link->tramp_hlist);
> -		tr->progs_cnt[kind]--;
> +
> +	if (link->link.prog->type == BPF_PROG_TYPE_LSM) {
> +		err = bpf_trampoline_toggle_lsm(tr, kind);
> +		if (err)
> +			goto cleanup;
>  	}
> +
> +	err = bpf_trampoline_update(tr, true /* lock_direct_mutex */);
> +	if (err)
> +		goto cleanup;
> +
> +	return 0;
> +
> +cleanup:
> +	hlist_del_init(&link->tramp_hlist);
> +	tr->progs_cnt[kind]--;
>  	return err;
>  }
>  
> @@ -593,6 +619,12 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_
>  	}
>  	hlist_del_init(&link->tramp_hlist);
>  	tr->progs_cnt[kind]--;
> +
> +	if (link->link.prog->type == BPF_PROG_TYPE_LSM) {
> +		err = bpf_trampoline_toggle_lsm(tr, kind);
> +		WARN(err, "BUG: unable to toggle BPF LSM hook");
> +	}
> +
>  	return bpf_trampoline_update(tr, true /* lock_direct_mutex */);
>  }
>  
> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> index 57b9ffd53c98..ba1c3a19fb12 100644
> --- a/security/bpf/hooks.c
> +++ b/security/bpf/hooks.c
> @@ -9,7 +9,7 @@
>  
>  static struct security_hook_list bpf_lsm_hooks[] __ro_after_init = {
>  	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> -	LSM_HOOK_INIT(NAME, bpf_lsm_##NAME),
> +	LSM_HOOK_INIT_TOGGLEABLE(NAME, bpf_lsm_##NAME),
>  	#include <linux/lsm_hook_defs.h>
>  	#undef LSM_HOOK
>  	LSM_HOOK_INIT(inode_free_security, bpf_inode_storage_free),
> diff --git a/security/security.c b/security/security.c
> index 491b807a8a63..a89eb8fe302b 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -407,7 +407,9 @@ static void __init lsm_static_call_init(struct security_hook_list *hl)
>  			__static_call_update(scall->key, scall->trampoline,
>  					     hl->hook.lsm_func_addr);
>  			scall->hl = hl;
> -			static_branch_enable(scall->active);
> +			/* Toggleable hooks are inactive by default */
> +			if (!hl->toggleable)
> +				static_branch_enable(scall->active);
>  			return;
>  		}
>  		scall++;
> @@ -885,6 +887,39 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u32 *uctx_len,
>  	return rc;
>  }
>  
> +/**
> + * security_toggle_hook - Toggle the state of the LSM hook.
> + * @hook_addr: The address of the hook to be toggled.
> + * @state: Whether to enable for disable the hook.
> + *
> + * Returns 0 on success, -EINVAL if the address is not found.
> + */
> +int security_toggle_hook(void *hook_addr, bool state)
> +{
> +	struct lsm_static_call *scalls = ((void *)&static_calls_table);
> +	unsigned long num_entries =
> +		(sizeof(static_calls_table) / sizeof(struct lsm_static_call));
> +	int i;
> +
> +	for (i = 0; i < num_entries; i++) {
> +		if (!scalls[i].hl->toggleable)
> +			continue;
> +
> +		if (!scalls[i].hl)
> +			continue;
> +
> +		if (scalls[i].hl->hook.lsm_func_addr != hook_addr)
> +			continue;
> +
> +		if (state)
> +			static_branch_enable(scalls[i].active);
> +		else
> +			static_branch_disable(scalls[i].active);
> +		return 0;
> +	}
> +	return -EINVAL;
> +}
> +
>  /*
>   * The default value of the LSM hook is defined in linux/lsm_hook_defs.h and
>   * can be accessed with:

