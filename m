Return-Path: <bpf+bounces-10483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0624F7A8B5C
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 20:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B058E281B63
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 18:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FE53CCF7;
	Wed, 20 Sep 2023 18:11:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FF83CCE0
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 18:11:56 +0000 (UTC)
Received: from sonic301-38.consmr.mail.ne1.yahoo.com (sonic301-38.consmr.mail.ne1.yahoo.com [66.163.184.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65576D7
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 11:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1695233513; bh=vPlGKZP3+92YQKyILPjX5xVPtUajFeumWj9XYnIxdL8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=iGM8QwcQPsErvvt1td3SdTRK77V+kKZfsRArRobZ7pVHLNrcZwlURWQYBEQO33skNOZ4iV1DNTQG1JZwdKrT5ytg8ssy7BbQ5WiX4UuMhD8DVsu61s4FTUVz7RJKsFh+DOmUh0x1rsjjRu0hCZKQs3Mv2wUZVQ1t6tZdQzoXxS9UOY3KccpdYYA5MHBkuhGZVyEmzUdanFZJcXZB0wMXwoEx3p1doxumaohGNeji9OnSxkHDykJRZBCg9Uf5jV4Dc3fUNeFuzoLSloPmcZCGMZw+64V3EhrVqhfLDZ/vJTKx2RfmQ+7/vG3V2rGgIpDUtfYjZFFUHWoeR5OeElPiSQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1695233513; bh=EKy1avPmSWf4/PY4UTVRAKbEQ0u2WLJz7aTy5w2QM49=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=JHGnBFhu/T2AwAi/Po6KIOP0WveVGd03XpsAhpjXltF7aPD3m74cw4w8PHS32CpQMnEpSQhkk3JKU6ZxRcs8XoGe5XRESCLvFndfVhPo9r/q8HeKZrEJn/PENi/GCiHTBxPPKQKPrbX3/bKaaN+Y7E2tlgcrW3G/CadxWCrqZMAC0edRO0kI2YYBjtUd8nAQJRqbW7Iba9nwEbDMhjbjUeOWIDmeFaF81q+HBSPP1DscDcukipAZzlp5slzbllC1TTWNhOJ708VtnnBnL2iov2ORRzNvNykXbcyuDeIf9NSWrLfLJuY1GIjYx2nxfvRPfoZcKJRiJ/TdYrhfP/g5Fw==
X-YMail-OSG: Xm.RkLcVM1n9zH0ZQ2P7bx9.7hYZ1lvA.7cF9kTLWzsVzrqZVwucfYTE82YZXve
 iFCorQcD.xM6Tje2PDsbIjG3uJEnKtWua8pPg2R8VuaF2Zexk2BKFasM2OUMTu7BeKuOvfL9yMXC
 ptrd8xWOkC9W4nugh_fQRaTX92Cps7viqu7uikdCH2A_mGs1dma4kdtCfGnwwnZmO5mGCXE1Q_7l
 Chyqne_ppIvRXJjW6wpIjTQgsYC1vc4Nja5qFz.JatyFbfQNxm9BX_Rtu5UJiTkYSX59z55hdJeQ
 5Qn615c19UoaaKAvZPeIC6FQTkn2MXHhPqP_WOWgPYpIFe3OleB2sLL5am4YVrAH60wAXijlIlZ8
 mDiY7b8XlMUe8jdwFJQYTLiXjniw6SqOtboZF9Kh.wQ0IqfHUy2Xs35uTekzZJDMocx6wDhattl4
 P2ucGTZeCNFlzWipJw6tGV6uPX6QMxrWzPkexOBu5foHX_Mihd4papM0jYipNc0wmV.tjcrExHW5
 0tJUFDocVSQb8oEx7HAHkoJMW_3Jqx5cRLAyyi.Iucl1oMi3_8JFWCXeL_dWpHSshv6XoQeOx9ZM
 LCIg.HAhHJUs3CAYZWndp3Ixakb98n56zIWbSF2Q_.G6OIjXAmVg_hEiBHWdpMasTyjszLXXJGJ4
 e5KR56aMLPCySK5SNegxn2BSAFKKcYVuvea9IETDb3NniSxOABCjT_h1_tZalimpF6qd7OgMIPma
 g44p5dPYeA6wySCBfS4xRilpYIy1aCaqLocdm9W_chay5EH280sxf4KqD4jOQs8tS9BoJSTeT4YO
 UkNTnLHc5B46a0xuX56UQlVI7MceDIC_ev47WFDuPP2vso901eFBJ1EpbTqm.QnTG_48S6ctgsH6
 _v3kV3kZwU44h46KtucqjkvqotCEPzqQHgnkjdAdiR5lKQwD1b1PUdg.xwZVRbXEK89QLz5RGt6T
 eILGljYkoTm7Kidq7w2bLUWZ1DLTscIJmebJFc5Sty5d8a9LPG99riw6B3cXwrOoueVDxMNK5Zps
 oJEdcR0nk._tes0nQMzPPBIRzN_hxBf8QR6jWy7t7sUeinfcW.02d5Vz83Uwor6GC_Tpwsrrfj1B
 jfvOKgo8vEtuYKjJ.SZLFaVoicGP.58CpWkSAmyhZkVbj.rjKW0u47tcF3avT88OBbMGe9rMwDKb
 W.yz9Fi.5sA5ZvDaie1f4fenv1xHlUgJl1e3bIcpaUZdGT0ZkueBWF5VTJpAXgtxIz8P7ZnOTFI1
 SI4DdrXho7iWIYFmAs9hGFqleyIQ.gSFjBDKiFY_hzBDmiJbTbzQTzRmlDGBLmWUAUAu.E8aXz2z
 XJZNTzga.R6KUyTjGZo7mNscKGOeB4D.3RgkC4N0DksChxO7RgNyAaM5ShhP5eZZjIXQMzxAgk.u
 rymNlxCTup3F719csXQSCg3wDnDB1XVZ3iH.uJKwcuB0adxF.dmxeKJI7ZtITjD4A17GeMy_VcGr
 WESC3l37sT51XGxMKIshRkp_VZwXLpGL6M2GRF56wCoPT7S4fJmXQnjNVnKz5sLxnxFp7bmMjdfF
 CD81LVMAb0klclESTZsixp_QLvADO5PZbio3h77kFd4kh6UnxAvCeLsygGxDuw6RnlF33YCcrO5D
 FaiyFiNPjjR.yYlqCu1bcuLPq1SxGNWxHh7OaoWqM0QfShghyDZUd4siLZBVH9JGlj7UBv0c1KEi
 6L4Ygm2o2FV1.BOYWLBUNRA7njp7AAzVDxNBt5EJ0zRyQk8SMNNT19VteXZHqF5TgjhRW4wKquPh
 rTfY5eue4Ypt_ebmYZRLCo1QG5v773V.Vlt97.m5z3goE0mHqfCAd4oevWjKchGO5KTNS3Kbg30x
 Guf.MuT5k_AkGcK6UT8mgeWvFRk0UmIi7hrc9QCKLxaRBK7c9uqvr01HmVTr44J6ltkuRXuBDTTn
 YVorUUD5p1YsE9LduQiAte79R0u1ozGc5lH6A1Hb4q4V98zwjgBCClSws4lchv3IQz0OqXIvo1Vx
 ikiZhx5R94VbRCAfLwysZXLpk7.6LZe3DBw5V0.aXuf189gGKZLmM4ig2rq5CRlIHEZtJfJdspvV
 eqon5VK8gS6mgWggfypOzOPPChPs1b5_UGliZsCG0Gfz._CkNpsxJpC_NpXvOocSqgenLqvxE6SQ
 G.KpS1DlorZIYdONnwV_8TIDBaFrrbCrHZbSL82k2G9xF4xp.IyNZhPGAKbZy5Tw_O9nCGgWAg.Y
 lzDBySMvChXGxHprZbckk_ZCxR2.i4B8ec65WOSB4rinO_LPu5YCRKy3MVYEf1velaXWBAK2pUI3
 pLGpuFvNsfphRmQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: bbfe443d-ff78-471f-9c10-286912d3c33e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Wed, 20 Sep 2023 18:11:53 +0000
Received: by hermes--production-bf1-678f64c47b-7r85z (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 772b52d14bca51e9f21795d741e05aa3;
          Wed, 20 Sep 2023 18:11:49 +0000 (UTC)
Message-ID: <895efc3d-8d9c-563b-fb4c-b8ef4aca91d1@schaufler-ca.com>
Date: Wed, 20 Sep 2023 11:11:46 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 4/5] bpf: Only enable BPF LSM hooks when an LSM program
 is attached
Content-Language: en-US
To: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org
Cc: paul@paul-moore.com, keescook@chromium.org, song@kernel.org,
 daniel@iogearbox.net, ast@kernel.org
References: <20230918212459.1937798-1-kpsingh@kernel.org>
 <20230918212459.1937798-5-kpsingh@kernel.org>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230918212459.1937798-5-kpsingh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/18/2023 2:24 PM, KP Singh wrote:
> BPF LSM hooks have side-effects (even when a default value is returned),
> as some hooks end up behaving differently due to the very presence of
> the hook.
>
> The static keys guarding the BPF LSM hooks are disabled by default and
> enabled only when a BPF program is attached implementing the hook
> logic. This avoids the issue of the side-effects and also the minor
> overhead associated with the empty callback.
>
> security_file_ioctl:
>    0xffffffff818f0e30 <+0>:	endbr64
>    0xffffffff818f0e34 <+4>:	nopl   0x0(%rax,%rax,1)
>    0xffffffff818f0e39 <+9>:	push   %rbp
>    0xffffffff818f0e3a <+10>:	push   %r14
>    0xffffffff818f0e3c <+12>:	push   %rbx
>    0xffffffff818f0e3d <+13>:	mov    %rdx,%rbx
>    0xffffffff818f0e40 <+16>:	mov    %esi,%ebp
>    0xffffffff818f0e42 <+18>:	mov    %rdi,%r14
>    0xffffffff818f0e45 <+21>:	jmp    0xffffffff818f0e57 <security_file_ioctl+39>
>    				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
>    Static key enabled for SELinux
>
>    0xffffffff818f0e47 <+23>:	xchg   %ax,%ax
>    				^^^^^^^^^^^^^^
>
>    Static key disabled for BPF. This gets patched when a BPF LSM program
>    is attached
>
>    0xffffffff818f0e49 <+25>:	xor    %eax,%eax
>    0xffffffff818f0e4b <+27>:	xchg   %ax,%ax
>    0xffffffff818f0e4d <+29>:	pop    %rbx
>    0xffffffff818f0e4e <+30>:	pop    %r14
>    0xffffffff818f0e50 <+32>:	pop    %rbp
>    0xffffffff818f0e51 <+33>:	cs jmp 0xffffffff82c00000 <__x86_return_thunk>
>    0xffffffff818f0e57 <+39>:	endbr64
>    0xffffffff818f0e5b <+43>:	mov    %r14,%rdi
>    0xffffffff818f0e5e <+46>:	mov    %ebp,%esi
>    0xffffffff818f0e60 <+48>:	mov    %rbx,%rdx
>    0xffffffff818f0e63 <+51>:	call   0xffffffff819033c0 <selinux_file_ioctl>
>    0xffffffff818f0e68 <+56>:	test   %eax,%eax
>    0xffffffff818f0e6a <+58>:	jne    0xffffffff818f0e4d <security_file_ioctl+29>
>    0xffffffff818f0e6c <+60>:	jmp    0xffffffff818f0e47 <security_file_ioctl+23>
>    0xffffffff818f0e6e <+62>:	endbr64
>    0xffffffff818f0e72 <+66>:	mov    %r14,%rdi
>    0xffffffff818f0e75 <+69>:	mov    %ebp,%esi
>    0xffffffff818f0e77 <+71>:	mov    %rbx,%rdx
>    0xffffffff818f0e7a <+74>:	call   0xffffffff8141e3b0 <bpf_lsm_file_ioctl>
>    0xffffffff818f0e7f <+79>:	test   %eax,%eax
>    0xffffffff818f0e81 <+81>:	jne    0xffffffff818f0e4d <security_file_ioctl+29>
>    0xffffffff818f0e83 <+83>:	jmp    0xffffffff818f0e49 <security_file_ioctl+25>
>    0xffffffff818f0e85 <+85>:	endbr64
>    0xffffffff818f0e89 <+89>:	mov    %r14,%rdi
>    0xffffffff818f0e8c <+92>:	mov    %ebp,%esi
>    0xffffffff818f0e8e <+94>:	mov    %rbx,%rdx
>    0xffffffff818f0e91 <+97>:	pop    %rbx
>    0xffffffff818f0e92 <+98>:	pop    %r14
>    0xffffffff818f0e94 <+100>:	pop    %rbp
>    0xffffffff818f0e95 <+101>:	ret
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  include/linux/bpf.h       |  1 +
>  include/linux/bpf_lsm.h   |  5 +++++
>  include/linux/lsm_hooks.h | 13 ++++++++++++-
>  kernel/bpf/trampoline.c   | 29 +++++++++++++++++++++++++++--
>  security/bpf/hooks.c      | 25 ++++++++++++++++++++++++-
>  security/security.c       |  3 ++-
>  6 files changed, 71 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index b9e573159432..84c9eb6ae07a 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1159,6 +1159,7 @@ struct bpf_attach_target_info {
>  	struct module *tgt_mod;
>  	const char *tgt_name;
>  	const struct btf_type *tgt_type;
> +	bool is_lsm_target;
>  };
>  
>  #define BPF_DISPATCHER_MAX 48 /* Fits in 2048B */
> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> index 1de7ece5d36d..5bbc31ac948c 100644
> --- a/include/linux/bpf_lsm.h
> +++ b/include/linux/bpf_lsm.h
> @@ -29,6 +29,7 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
>  
>  bool bpf_lsm_is_sleepable_hook(u32 btf_id);
>  bool bpf_lsm_is_trusted(const struct bpf_prog *prog);
> +void bpf_lsm_toggle_hook(void *addr, bool value);
>  
>  static inline struct bpf_storage_blob *bpf_inode(
>  	const struct inode *inode)
> @@ -78,6 +79,10 @@ static inline void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog,
>  {
>  }
>  
> +static inline void bpf_lsm_toggle_hook(void *addr, bool value)
> +{
> +}
> +
>  #endif /* CONFIG_BPF_LSM */
>  
>  #endif /* _LINUX_BPF_LSM_H */
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index eb9afe93496f..0797e9f97cb3 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -97,11 +97,14 @@ struct lsm_static_calls_table {
>   * @scalls: The beginning of the array of static calls assigned to this hook.
>   * @hook: The callback for the hook.
>   * @lsm: The name of the lsm that owns this hook.
> + * @default_state: The state of the LSM hook when initialized. If set to false,
> + * the static key guarding the hook will be set to disabled.
>   */
>  struct security_hook_list {
>  	struct lsm_static_call	*scalls;
>  	union security_list_options	hook;
>  	const char			*lsm;
> +	bool				default_state;
>  } __randomize_layout;
>  
>  /*
> @@ -151,7 +154,15 @@ static inline struct xattr *lsm_get_xattr_slot(struct xattr *xattrs,
>  #define LSM_HOOK_INIT(NAME, CALLBACK)			\
>  	{						\
>  		.scalls = static_calls_table.NAME,	\
> -		.hook = { .NAME = CALLBACK }		\
> +		.hook = { .NAME = CALLBACK },		\
> +		.default_state = true			\
> +	}
> +
> +#define LSM_HOOK_INIT_DISABLED(NAME, CALLBACK)		\
> +	{						\
> +		.scalls = static_calls_table.NAME,	\
> +		.hook = { .NAME = CALLBACK },		\
> +		.default_state = false			\
>  	}
>  
>  extern char *lsm_names;
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index e97aeda3a86b..df9699bce372 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -13,6 +13,7 @@
>  #include <linux/bpf_verifier.h>
>  #include <linux/bpf_lsm.h>
>  #include <linux/delay.h>
> +#include <linux/bpf_lsm.h>
>  
>  /* dummy _ops. The verifier will operate on target program's ops. */
>  const struct bpf_verifier_ops bpf_extension_verifier_ops = {
> @@ -514,7 +515,7 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_tr
>  {
>  	enum bpf_tramp_prog_type kind;
>  	struct bpf_tramp_link *link_exiting;
> -	int err = 0;
> +	int err = 0, num_lsm_progs = 0;
>  	int cnt = 0, i;
>  
>  	kind = bpf_attach_type_to_tramp(link->link.prog);
> @@ -545,8 +546,14 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_tr
>  			continue;
>  		/* prog already linked */
>  		return -EBUSY;
> +
> +		if (link_exiting->link.prog->type == BPF_PROG_TYPE_LSM)
> +			num_lsm_progs++;
>  	}
>  
> +	if (!num_lsm_progs && link->link.prog->type == BPF_PROG_TYPE_LSM)
> +		bpf_lsm_toggle_hook(tr->func.addr, true);
> +
>  	hlist_add_head(&link->tramp_hlist, &tr->progs_hlist[kind]);
>  	tr->progs_cnt[kind]++;
>  	err = bpf_trampoline_update(tr, true /* lock_direct_mutex */);
> @@ -569,8 +576,10 @@ int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline
>  
>  static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr)
>  {
> +	struct bpf_tramp_link *link_exiting;
>  	enum bpf_tramp_prog_type kind;
> -	int err;
> +	bool lsm_link_found = false;
> +	int err, num_lsm_progs = 0;
>  
>  	kind = bpf_attach_type_to_tramp(link->link.prog);
>  	if (kind == BPF_TRAMP_REPLACE) {
> @@ -580,8 +589,24 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_
>  		tr->extension_prog = NULL;
>  		return err;
>  	}
> +
> +	if (link->link.prog->type == BPF_PROG_TYPE_LSM) {
> +		hlist_for_each_entry(link_exiting, &tr->progs_hlist[kind],
> +				     tramp_hlist) {
> +			if (link_exiting->link.prog->type == BPF_PROG_TYPE_LSM)
> +				num_lsm_progs++;
> +
> +			if (link_exiting->link.prog == link->link.prog)
> +				lsm_link_found = true;
> +		}
> +	}
> +
>  	hlist_del_init(&link->tramp_hlist);
>  	tr->progs_cnt[kind]--;
> +
> +	if (lsm_link_found && num_lsm_progs == 1)
> +		bpf_lsm_toggle_hook(tr->func.addr, false);
> +
>  	return bpf_trampoline_update(tr, true /* lock_direct_mutex */);
>  }
>  
> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> index cfaf1d0e6a5f..1957244196d0 100644
> --- a/security/bpf/hooks.c
> +++ b/security/bpf/hooks.c
> @@ -8,7 +8,7 @@
>  
>  static struct security_hook_list bpf_lsm_hooks[] __ro_after_init = {
>  	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> -	LSM_HOOK_INIT(NAME, bpf_lsm_##NAME),
> +	LSM_HOOK_INIT_DISABLED(NAME, bpf_lsm_##NAME),
>  	#include <linux/lsm_hook_defs.h>
>  	#undef LSM_HOOK
>  	LSM_HOOK_INIT(inode_free_security, bpf_inode_storage_free),
> @@ -32,3 +32,26 @@ DEFINE_LSM(bpf) = {
>  	.init = bpf_lsm_init,
>  	.blobs = &bpf_lsm_blob_sizes
>  };
> +
> +void bpf_lsm_toggle_hook(void *addr, bool value)
> +{
> +	struct lsm_static_call *scalls;
> +	struct security_hook_list *h;
> +	int i, j;
> +
> +	for (i = 0; i < ARRAY_SIZE(bpf_lsm_hooks); i++) {
> +		h = &bpf_lsm_hooks[i];
> +		scalls = h->scalls;
> +		if (h->hook.lsm_callback == addr)
> +			continue;
> +
> +		for (j = 0; j < MAX_LSM_COUNT; j++) {
> +			if (scalls[j].hl != h)
> +				continue;
> +			if (value)
> +				static_branch_enable(scalls[j].active);
> +			else
> +				static_branch_disable(scalls[j].active);
> +		}
> +	}
> +}
> diff --git a/security/security.c b/security/security.c
> index c2c2cf6b711f..d1ee72e563cc 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -382,7 +382,8 @@ static void __init lsm_static_call_init(struct security_hook_list *hl)
>  			__static_call_update(scall->key, scall->trampoline,
>  					     hl->hook.lsm_callback);
>  			scall->hl = hl;
> -			static_branch_enable(scall->active);
> +			if (hl->default_state)
> +				static_branch_enable(scall->active);
>  			return;
>  		}
>  		scall++;

