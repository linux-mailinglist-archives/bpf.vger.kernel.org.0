Return-Path: <bpf+bounces-2691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E2A73247D
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 03:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 947222815E8
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 01:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A807362A;
	Fri, 16 Jun 2023 01:15:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7491A36D
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 01:15:08 +0000 (UTC)
Received: from sonic313-16.consmr.mail.ne1.yahoo.com (sonic313-16.consmr.mail.ne1.yahoo.com [66.163.185.39])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1740A26A9
	for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 18:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686878105; bh=HGwnpOucEWlvUG4zfmWlVllruBXwes6EOI79jM/EmR8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=NWvaoROvrlajrz2bGb883WyCn7fu9HL7RUL+1blnd/+tXqpe+N+Kvw7v7hmoQu6ii9qLBCgk+pgGtqj+tj/A2y6LTFNj+2vll+ZOjyjXx7KuCoW8uISjfNBJ0K1eTTn51dbzG+aT9kViGv3MIYymI9GQ5QMM2kf6dVuSQ+WbvrXt5SNvTIYMLsXhbrDfuS6v+Te/Q+SAP+nAlq+CL0yuXJ3/UjUfKr7PpARPbrYF1jdr/QuMMkqKsfhq8v5gCun65YSMsViG/xDb1O8m8CDeBi5KnrzB5XeLq47mNJAuq6SEcwtyWeBR8b7YGl5CNR095lvDSMu0BVmLE4k4M/qOQw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686878105; bh=qJEYcaz7zusAVf8S85Oe7RlkOIXoxpTVd1TGs6kQO2U=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=m/cW3g3v7R6VDo1YHa4dZEXCU11rPx64xC+AenNqP4Ht/PmkbCUHWQNTGXPWCuaiNSDGOh9SdvhNWrGSM8RmjAop6Tqnz2dAta48XxyOuZGFCYQRKXbN09/kGAQHcaqIgwyk+qlcBhxtp8TwMRekxWpGumtP22sEaaXyqvLV0fgAckpc9g1YoVWi5ZGHDZ5I8vZyFwMH/KtngyxXK4V5qCXxwqN9s0kHpkTBRAEJEmutyWCtP9Xyk3CylS9VcES1LgcpYNHrgtuPK0C+JrfI0bSv+qnhgQCA5gUxwY/kD/2pP2MUHsogld6VGl8CYrbp3q4AQ1eMPh1UoURCfWbUWQ==
X-YMail-OSG: R.rM5aAVM1m.fq5t2qs1Xejg3QqUto.ThIcalQ1Cq07EDCjJsm5WD9I7jr84F7X
 qUQ9SpmNB0svEW6Ug_hC9WSJOxIU6GxYVeZzGus5QivekCiq5XR403pRoYc3SyZoadw4BxMJ0oUk
 maqS.vS7HrfOHa2nZLNzm4VCjvroiVo.cr4mM9G1ktL4rBybbe9Oo6ZYgW9ys_JRnXhzNXHwZE38
 5eEVPwJeK4ZVxMqE0KBzg7iopbRGNkOV6238wlHKgsFM8AH9CgJzv1yEM2yPy44agd3jz_FIZedR
 .o6aWwcJt2gXI3huz8gyzvdCQJCqGL871H5Pthjxoz33CZb4ULhYX.3DXGNlTm0YaDGKgulWOw.W
 D7tARJlHBdwlLvSay92MOtKoSEL70.6uQmfPTlKlGNLTfQhZHOhyqYkfRwFL02KRZ.lqVbOVBVot
 BX9B1pXxNfkF.pQItykjHmt8cjyn53fNzLMRS54aBTRLid60Bc93JjW_BvSfH8pV5TJXmyXh0HQz
 t0QPSQhkCNs2amEmpl_..48X.TIWuVzrzQbWBRBTtkCoJuvXWwgFNvfBRw.ku8fjggvxN2Av2i2U
 NlbN45Ev.su9HJ0tCu295xLYUng9puqNLB69sZ3OmlG9P5r6Q1hn85QfIHkxSkKhLNhUmL5orjLu
 y9hvWo75bWEoMKNo9KyKig3Iy.s3E7joyhqc46TtiQJk8YAG_97DE_5sa46SlvwPMQqJBR0NDTof
 8EKmUKab1qH8zo8DxIvyMBCCCZEnYwpAnwl43SIaWmxjHNJboDFZnTbTAW1_cqECwIYxk4WdjS0s
 avcV5yfoQB5wdCxl0rKQarSZwOKuRSFsaxh9qLFc0DntWViW24G.Nrf8gOW.PGARMLpIIYlWizxX
 n5WC7WvOrbl7F_oDyGx5euduQFRp3XKLJmtXcEeOJdfRrYKi_dnH2V07HRbj72FYF38AupOArwLE
 wjTeNxxZNKmOCRnRtYiSx7UuaK4LZ_CJWfOdnMzmdpu82QKwZXGYzmhBGovBbLQ.1rGSOXgMJSbO
 JsWsiLroK0Y9.DTaniUcnMD8z1.WwO5pcIGIcpBmrHG4nRuOYiSrPx6S9snbmowViWEvgL8FllNq
 UtHE7DjIt465hKZieYMdWCKTGMYzlci9DuCz9oOGpDZzWX_Cny1Vx15gsnu1Po9pQtHAszfenNlu
 HlXZc2nMPnW8g1ndJvR_FExPOo5I44fogEkoMvszc2B1YFwfecwC6I5.38kEgw9Blppdo4UhpylC
 NtAfklmpQluLp6Z96_I4fd.e.jhAfFd50LpsEOifXf3me4C9OKkMt6HOBe4PAC02XuAxTOcqGSnO
 SJ6BAc6wowN9Ah5qCqS8hLvjLhOCEvbkpNe3QfZggAXXAZwb_9QAoH9p5aPJ652M2L9FqS5ge2af
 kwu57dlJereHB_zI2nVnBAJz060q0kTq0uczIEczIX4ZZrKWOUOA_oQEX9s30G02JCDz0IW.03jK
 K5DX3jYNTlV1WD.F9nlKyJ0nuyhU3HMrVpCiPMJBiZaZwxC187M62dMgt_FQt2emeXrSrt0S6QUN
 QDps0.D88f99vpV4woDTdewsc1Xd8haquR5bRx9xx3xWVdjIf9nC_G.koOI0b_m2V0eIro3iF0EC
 X9V0fnR_O.Rlwt6GJFES5qDGNZrWjXFNp4qEDMgFC7G0JEJT4lg98IcTAobnfKeYy5oePnjM71aK
 AExDK.CLwQmA4FOOT7P_MJLJWwHV54VCRFrsbzr4HboMkh87PUTdtGuOPTBdY01tTAkIWQSEMZkp
 A7w1CEuYEl1F8jc_aKVuOc2r.i.XxHW78ZCK3xMjoM1SKqj_V03o1U5t_lfr0Lp9GBYo8AShO27q
 ImV2IBUr1XNumS3oQYLLRXde60TBPm6egBeMU7XlN2PionRm2YxN0StwZMf3_Fi7tniaT.VoKi2g
 57lXSbr6_soVZyrx0TmThlb5dZEXW16vpXi4yU1RXcpSjQcpvEAutIGeCHBiq2FT0K_PkxOfoDiM
 LbVfynG8kASexIuRzQ27Zr29BE26QHjo0W8iiCqBx83cOcKlPxQKnCMZKXR7SzQsz_ULUkwhwnDf
 Hevow5hOlmkylJw9GuxS3DmOCOBMB1M0gn4eR6NFWX6cGNkm3OHRImjSc4jJR8D85ga9njfva_MK
 Z3WL93NFr0gMvspV.yPtp7qzmVWQVl_K8l4UxprMKLZsQf0tiB5T74MxTPyzwSBJ4puudYraSNlL
 ZXtnUmhgjWXSVvEgYeEoulZN6EUH3Kos2n5sSmfmoJIb8UTO40YeYqGHS_nVoScrJzT9CoJfO.iN
 d4cupX1P3ECCSfpxk
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 55bd0c2d-87e2-4313-9c2d-07a1b25eff9a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Fri, 16 Jun 2023 01:15:05 +0000
Received: by hermes--production-bf1-54475bbfff-xh8w9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 78a28526a973406a89010d0bbac67dc3;
          Fri, 16 Jun 2023 01:14:59 +0000 (UTC)
Message-ID: <578a54c4-8d62-12b2-1a6b-0e242da9fcab@schaufler-ca.com>
Date: Thu, 15 Jun 2023 18:14:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 5/5] security: Add CONFIG_SECURITY_HOOK_LIKELY
Content-Language: en-US
To: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org
Cc: paul@paul-moore.com, keescook@chromium.org, song@kernel.org,
 daniel@iogearbox.net, ast@kernel.org, jannh@google.com,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20230616000441.3677441-1-kpsingh@kernel.org>
 <20230616000441.3677441-6-kpsingh@kernel.org>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230616000441.3677441-6-kpsingh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21557 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/15/2023 5:04 PM, KP Singh wrote:
> This config influences the nature of the static key that guards the
> static call for LSM hooks.
>
> When enabled, it indicates that an LSM static call slot is more likely
> to be initialized. When disabled, it optimizes for the case when static
> call slot is more likely to be not initialized.
>
> When a major LSM like (SELinux, AppArmor, Smack etc) is active on a
> system the system would benefit from enabling the config. However there
> are other cases which would benefit from the config being disabled
> (e.g. a system with a BPF LSM with no hooks enabled by default, or an
> LSM like loadpin / yama). Ultimately, there is no one-size fits all
> solution.
>
> with CONFIG_SECURITY_HOOK_LIKELY enabled, the inactive /
> uninitialized case is penalized with a direct jmp (still better than
> an indirect jmp):
>
> function security_file_ioctl:
>    0xffffffff818f0c80 <+0>:	endbr64
>    0xffffffff818f0c84 <+4>:	nopl   0x0(%rax,%rax,1)
>    0xffffffff818f0c89 <+9>:	push   %rbp
>    0xffffffff818f0c8a <+10>:	push   %r14
>    0xffffffff818f0c8c <+12>:	push   %rbx
>    0xffffffff818f0c8d <+13>:	mov    %rdx,%rbx
>    0xffffffff818f0c90 <+16>:	mov    %esi,%ebp
>    0xffffffff818f0c92 <+18>:	mov    %rdi,%r14
>    0xffffffff818f0c95 <+21>:	jmp    0xffffffff818f0ca8 <security_file_ioctl+40>
>
>    jump to skip the inactive BPF LSM hook.
>
>    0xffffffff818f0c97 <+23>:	mov    %r14,%rdi
>    0xffffffff818f0c9a <+26>:	mov    %ebp,%esi
>    0xffffffff818f0c9c <+28>:	mov    %rbx,%rdx
>    0xffffffff818f0c9f <+31>:	call   0xffffffff8141e3b0 <bpf_lsm_file_ioctl>
>    0xffffffff818f0ca4 <+36>:	test   %eax,%eax
>    0xffffffff818f0ca6 <+38>:	jne    0xffffffff818f0cbf <security_file_ioctl+63>
>    0xffffffff818f0ca8 <+40>:	endbr64
>    0xffffffff818f0cac <+44>:	jmp    0xffffffff818f0ccd <security_file_ioctl+77>
>
>    jump to skip the empty slot.
>
>    0xffffffff818f0cae <+46>:	mov    %r14,%rdi
>    0xffffffff818f0cb1 <+49>:	mov    %ebp,%esi
>    0xffffffff818f0cb3 <+51>:	mov    %rbx,%rdx
>    0xffffffff818f0cb6 <+54>:	nopl   0x0(%rax,%rax,1)
>   				^^^^^^^^^^^^^^^^^^^^^^^
> 				Empty slot
>
>    0xffffffff818f0cbb <+59>:	test   %eax,%eax
>    0xffffffff818f0cbd <+61>:	je     0xffffffff818f0ccd <security_file_ioctl+77>
>    0xffffffff818f0cbf <+63>:	endbr64
>    0xffffffff818f0cc3 <+67>:	pop    %rbx
>    0xffffffff818f0cc4 <+68>:	pop    %r14
>    0xffffffff818f0cc6 <+70>:	pop    %rbp
>    0xffffffff818f0cc7 <+71>:	cs jmp 0xffffffff82c00000 <__x86_return_thunk>
>    0xffffffff818f0ccd <+77>:	endbr64
>    0xffffffff818f0cd1 <+81>:	xor    %eax,%eax
>    0xffffffff818f0cd3 <+83>:	jmp    0xffffffff818f0cbf <security_file_ioctl+63>
>    0xffffffff818f0cd5 <+85>:	mov    %r14,%rdi
>    0xffffffff818f0cd8 <+88>:	mov    %ebp,%esi
>    0xffffffff818f0cda <+90>:	mov    %rbx,%rdx
>    0xffffffff818f0cdd <+93>:	pop    %rbx
>    0xffffffff818f0cde <+94>:	pop    %r14
>    0xffffffff818f0ce0 <+96>:	pop    %rbp
>    0xffffffff818f0ce1 <+97>:	ret
>
> When the config is disabled, the case optimizes the scenario above.
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
>    0xffffffff818f0e45 <+21>:	xchg   %ax,%ax
>    0xffffffff818f0e47 <+23>:	xchg   %ax,%ax
>
>    The static keys in their disabled state do not create jumps leading
>    to faster code.
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
>    0xffffffff818f0e63 <+51>:	call   0xffffffff8141e3b0 <bpf_lsm_file_ioctl>
>    0xffffffff818f0e68 <+56>:	test   %eax,%eax
>    0xffffffff818f0e6a <+58>:	jne    0xffffffff818f0e4d <security_file_ioctl+29>
>    0xffffffff818f0e6c <+60>:	jmp    0xffffffff818f0e47 <security_file_ioctl+23>
>    0xffffffff818f0e6e <+62>:	endbr64
>    0xffffffff818f0e72 <+66>:	mov    %r14,%rdi
>    0xffffffff818f0e75 <+69>:	mov    %ebp,%esi
>    0xffffffff818f0e77 <+71>:	mov    %rbx,%rdx
>    0xffffffff818f0e7a <+74>:	nopl   0x0(%rax,%rax,1)
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
> ---
>  security/Kconfig    | 11 +++++++++++
>  security/security.c | 13 ++++++++-----
>  2 files changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/security/Kconfig b/security/Kconfig
> index 52c9af08ad35..bd2a0dff991a 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -32,6 +32,17 @@ config SECURITY
>  
>  	  If you are unsure how to answer this question, answer N.
>  
> +config SECURITY_HOOK_LIKELY
> +	bool "LSM hooks are likely to be initialized"
> +	depends on SECURITY
> +	default y
> +	help
> +	  This controls the behaviour of the static keys that guard LSM hooks.
> +	  If LSM hooks are likely to be initialized by LSMs, then one gets
> +	  better performance by enabling this option. However, if the system is
> +	  using an LSM where hooks are much likely to be disabled, one gets
> +	  better performance by disabling this config.
> +
>  config SECURITYFS
>  	bool "Enable the securityfs filesystem"
>  	help
> diff --git a/security/security.c b/security/security.c
> index 4aec25949212..da80a8918e7d 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -99,9 +99,9 @@ static __initdata struct lsm_info *exclusive;
>   * Define static calls and static keys for each LSM hook.
>   */
>  
> -#define DEFINE_LSM_STATIC_CALL(NUM, NAME, RET, ...)			\
> -	DEFINE_STATIC_CALL_NULL(LSM_STATIC_CALL(NAME, NUM),		\
> -				*((RET(*)(__VA_ARGS__))NULL));		\
> +#define DEFINE_LSM_STATIC_CALL(NUM, NAME, RET, ...)               \
> +	DEFINE_STATIC_CALL_NULL(LSM_STATIC_CALL(NAME, NUM),       \
> +				*((RET(*)(__VA_ARGS__))NULL));    \

This is just a cosmetic change, right? Please fix it in the original
patch when you respin, not here. I spent way to long trying to figure out
why you had to make a change.

>  	DEFINE_STATIC_KEY_FALSE(SECURITY_HOOK_ACTIVE_KEY(NAME, NUM));
>  
>  #define LSM_HOOK(RET, DEFAULT, NAME, ...)				\
> @@ -110,6 +110,9 @@ static __initdata struct lsm_info *exclusive;
>  #undef LSM_HOOK
>  #undef DEFINE_LSM_STATIC_CALL
>  
> +#define security_hook_active(n, h) \
> +	static_branch_maybe(CONFIG_SECURITY_HOOK_LIKELY, &SECURITY_HOOK_ACTIVE_KEY(h, n))
> +

Please don't use the security_ prefix here. It's a local macro, use hook_active()
or, if you must, lsm_hook_active().

>  /*
>   * Initialise a table of static calls for each LSM hook.
>   * DEFINE_STATIC_CALL_NULL invocation above generates a key (STATIC_CALL_KEY)
> @@ -816,7 +819,7 @@ static int lsm_superblock_alloc(struct super_block *sb)
>   */
>  #define __CALL_STATIC_VOID(NUM, HOOK, ...)				     \
>  do {									     \
> -	if (static_branch_unlikely(&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM))) {    \
> +	if (security_hook_active(NUM, HOOK)) {    			     \
>  		static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__);	     \
>  	}								     \
>  } while (0);
> @@ -828,7 +831,7 @@ do {									     \
>  
>  #define __CALL_STATIC_INT(NUM, R, HOOK, LABEL, ...)			     \
>  do {									     \
> -	if (static_branch_unlikely(&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM))) {  \
> +	if (security_hook_active(NUM, HOOK)) {    \
>  		R = static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__);    \
>  		if (R != 0)						     \
>  			goto LABEL;					     \

