Return-Path: <bpf+bounces-10482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 333DF7A8B50
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 20:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8784DB209C8
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 18:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CA73CCE7;
	Wed, 20 Sep 2023 18:11:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9F63CCE0
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 18:11:12 +0000 (UTC)
Received: from sonic301-38.consmr.mail.ne1.yahoo.com (sonic301-38.consmr.mail.ne1.yahoo.com [66.163.184.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53494C6
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 11:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1695233468; bh=xl2z8Y0zaOOdtGovcFSwMr2qAX0M1xebygAwExKh8Xk=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=RCrohzEJzUeI5kl/uNQsUrN5NnjI0SdonCr8hp5Wl28vHHsAhZVGXyE4Uud979vTEucC1Ctvmr6+NSkJtbMYYt+jz/Q9KuzzYN/yQ/sjbWGkz87MXZygVExWcF22QO6XLK6n347bo3ueb3ctJ0lZzmLJOotC/SnSu47f/DpG8RWSehk/iEzp2AFY9vFc9qtvbm/fQ/ipspeMz+6pY6JQdeoepuNLSobWN17pWBpAFlyXcJZAkRKB8YzKy/U8hlNaLGNVQ6U0PAR57f4iWwjw4JjxDaRgbwAhBLAMXxbtd0hhPnx+8kTpymJiFUGIHMo9D3tSfJ5cnxOm3trn+P1fZw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1695233468; bh=mQywjSfzEcb49t+KjYzVav+wyKjyRdg5rqgLgXj8WyI=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=N6pxiaI/bV7HX8JsZBmY9y7buRPfMQWcuQLV/9WmZHsn0PNOHQ+kX3zZRyBSW/CWTWN9jisTX0X/vVaQQHHh4PMSWuvPSo7Eky7JSGpHMF6cd1m8A2JmEb1U98A3QvtFdu+Vb+qtbr1z6q81RER9XJAHOqS7wQ1xNlZukX14ax9/YiIwReTpcM8649XggcEu9Bh7oZBtvW+ijZUCsn8MJ4H/nmKUr68htDgtn/tf3Q2CrzZWUnFZybyv5Mym+FW/UkVVHApJs7wQx/ZmO5LyBVlwpAV2INihyB0BY5jRpbfHcHrlDtsFFAHtv+CMTmbl5yrui+xw+I/aG/8MHhOxxw==
X-YMail-OSG: mxckHIEVM1noGEXyVlD43867pPqLMMn26v1QUGMlItBZE8SyecLooJy7Atqg41v
 OLIb24EtE1swAVJ_rXxf.MK_cdn4nP9U93HFaqVcOo1pm1170x8Ipw.o8QwMctjjxRpsd7YtIvoN
 km6zdKg6aoqBZLzT3tCZSCMA4G0lraOCfoV3XRExuMowZZGr4T.alzmp_CTbb5r9RnnZ0c_qf_30
 tTYp5pOc2xroU7TFJkWCBfNtQmR80ncMYcfn9ihxkWN5OVFWmWsauOFc4ADf0ZJzD6Wze4XR1B6w
 2m7mt_sP.JrctrKEGsIeeaur1cpMmb_2azCVeocYzl8O0fTCqS43ZQnC3IxlPrT_q8VCdRmmDIR9
 bEx1Gi9v9z9H8ZG1lOrJ_UmACGsJL26SfKjUdTNFFVRAvoE0YlHcQS3XT.JVXzHzqrSB6M2m.t95
 XQm70eT.LmBhgD7Y2BDADQ29ETzBsKOJ_Dho7LnIfc1kfywUI_aVRMCZzZ55X3KQwk6KcwlQY1Q6
 A_7FbXIyZ5B4KDYTdjyNHqFZD.KS1Kt.UwHJKFlRn_DCTfmqW1IC1k.t2BgBVPH5ip_h42NUZaAV
 76glo3ORR1aDHCwHtbQ_.SvgImMaZ6b104BMUMASe9ezBPoyFd65m0LpTqTXfY6_UXZ_ach26aOz
 42Upz6_D38sqpANsXveleXDUG7VdeAGQ2ZjS1Z91V_5JKje3gIDS4WXUyaGlStHMRKY4kCptj8bz
 xQiR5lA0Bizpf9agCGcgQM._HP2Tp4lmj79FTPGdDh_YMHdVrhcFjsrtb1K9ZVfrD11Amgw4oYYS
 Ybk.R8xuxYzBx6vumb5hT15lGDtHY5NiWAirD7q3KaeVdIX.b9.ihNTQRbLBsvetg3kClz98oBxr
 WpvjKf28qY3Sc076JfGYby3luPZATmHfpuWmTgBtJI7ZzlUHs7qThp8Z5ueZ2xfP6b87_nZui8EH
 0hrxuHEos4L0i0F3NVK5BiqxG7Nl2wJBtiQ0y2uET0qXk5OrnKEl1csMDpq94bsSZPHh1g6Hhwn4
 pWlbCVQsJlbMvL2CB9r..Zh_gE4wI22kq7d1AhKzhC2FIQSYvSkH.Ez7dHI.ajjg1y9BuwdJufy6
 iclCFmmhq3PBmqyDeuJs0YJ2dGXbB07Q4.arEoYAW5X4lzsmjrQFsYHPoHZ2ll.17FCmfIY23Wj6
 3Dw4z41wxuGqNiCLDHLFV_mR08NAsYThGOncW3oM4wo2RG5Rp8Pov0JCiazu28zIhaYpYfdybUeQ
 7I1TEoHH0kxsbGXoUn0Kq_LTL.NgoP7ybDJzlLDeu0wpoV7k7vT2URVoxX3FDA0Cvn_KKIH5A0lB
 5WDziuKSPCnUYOjn7qWZKnUCoZG5ke1pRdoKN13nPYWTFOD9N3p5xdaMSVbG2OWsaKRbrwZw0wZ9
 B8t3UUVnrYc.Om3dGeX1mhVzNzRMY9K0GWE3X9ari5r.O9q8jHReegAuQ69wRNDDw8hzf3fmp_NC
 HJIqNmGP_QmhzY6eLfI0IuNpzL507GkAkKdGx.fzmfKPclAbgSV1iiqCh8vSzVTHDSCXvhwn.Y2T
 bUwZHJcZuq35BC6iW.8U4KEOKFJt6kG4Zg.Y.fdCbFy7kFanvIvEMXrRpSOdJ2YnUVyFAIYPQda1
 oBeiyAlYcRxeHWiVuJUujVAUcBkhzTTpkMbCkqvgao1c0pZezwYIHsj1g2aH2XDTnpzr935Rxd7z
 e_g7xbi5P46Ihoeje6o3fmQRxDsxdrxsHeeH.cQ92Hs2guvVjyX0kn6mgjvayAuQZh13eBTTvPKp
 9uycpG44VsqL1zSntS7.m9aq0KvFlIdDa2EOSeUnYEsvz32E_igdB7lD8_jgBMCrBK9uoXy1Ag0L
 siymmKVOqwFxwJ5jaTo1OsN6I6nbC7SeTEHv_HvQlNLjyWpUb3In1u_4LL3tuxeIYI9bJcypME.E
 Ptt31gvWXejsY6Wc72Ag26Oh7r2BPRSDvmd_k_2O8V.IosUuOPAsCccQ2LPY91B1KWT3OLYaBadK
 riERQZepXEP15It643ns.xRMxlEMBecR4x1FFFx6pQwDSQq2icgOBa7SOzDk87yJoHba4PVdcA1W
 qHAwzPm5sEaQpxPYM7GXRTrD3zA37o5njqhbOm7A8TFPSWe82708kEZhXLrTQf51J5FHe3rXpzmt
 wEcMGKvqGa1UVhSDQooO..3zdHM_mKjPIzQXgFm3vhsumhVYE17Tzd2ooR9y6SaTa4tJFtSY_kSg
 swImK9p1RG6avg9fB5ckzlb0C.u221SmUbBfnw4ZHE97zg2m7m_ex3jNSnL9LfBXTRDtXFr3MQ6b
 Q25bslg3jSPcuew--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 1fd366a4-4137-4b70-b783-87dba0ec6e5e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Wed, 20 Sep 2023 18:11:08 +0000
Received: by hermes--production-bf1-678f64c47b-qxjnq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b8427bc8587d86af6150a86731ed2dae;
          Wed, 20 Sep 2023 18:11:03 +0000 (UTC)
Message-ID: <c97a7e4a-e209-2648-b741-fd882b933ddd@schaufler-ca.com>
Date: Wed, 20 Sep 2023 11:10:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 3/5] security: Replace indirect LSM hook calls with
 static calls
Content-Language: en-US
To: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org
Cc: paul@paul-moore.com, keescook@chromium.org, song@kernel.org,
 daniel@iogearbox.net, ast@kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20230918212459.1937798-1-kpsingh@kernel.org>
 <20230918212459.1937798-4-kpsingh@kernel.org>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230918212459.1937798-4-kpsingh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/18/2023 2:24 PM, KP Singh wrote:
> LSM hooks are currently invoked from a linked list as indirect calls
> which are invoked using retpolines as a mitigation for speculative
> attacks (Branch History / Target injection) and add extra overhead which
> is especially bad in kernel hot paths:
>
> security_file_ioctl:
>    0xffffffff814f0320 <+0>:	endbr64
>    0xffffffff814f0324 <+4>:	push   %rbp
>    0xffffffff814f0325 <+5>:	push   %r15
>    0xffffffff814f0327 <+7>:	push   %r14
>    0xffffffff814f0329 <+9>:	push   %rbx
>    0xffffffff814f032a <+10>:	mov    %rdx,%rbx
>    0xffffffff814f032d <+13>:	mov    %esi,%ebp
>    0xffffffff814f032f <+15>:	mov    %rdi,%r14
>    0xffffffff814f0332 <+18>:	mov    $0xffffffff834a7030,%r15
>    0xffffffff814f0339 <+25>:	mov    (%r15),%r15
>    0xffffffff814f033c <+28>:	test   %r15,%r15
>    0xffffffff814f033f <+31>:	je     0xffffffff814f0358 <security_file_ioctl+56>
>    0xffffffff814f0341 <+33>:	mov    0x18(%r15),%r11
>    0xffffffff814f0345 <+37>:	mov    %r14,%rdi
>    0xffffffff814f0348 <+40>:	mov    %ebp,%esi
>    0xffffffff814f034a <+42>:	mov    %rbx,%rdx
>
>    0xffffffff814f034d <+45>:	call   0xffffffff81f742e0 <__x86_indirect_thunk_array+352>
>    				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
>     Indirect calls that use retpolines leading to overhead, not just due
>     to extra instruction but also branch misses.
>
>    0xffffffff814f0352 <+50>:	test   %eax,%eax
>    0xffffffff814f0354 <+52>:	je     0xffffffff814f0339 <security_file_ioctl+25>
>    0xffffffff814f0356 <+54>:	jmp    0xffffffff814f035a <security_file_ioctl+58>
>    0xffffffff814f0358 <+56>:	xor    %eax,%eax
>    0xffffffff814f035a <+58>:	pop    %rbx
>    0xffffffff814f035b <+59>:	pop    %r14
>    0xffffffff814f035d <+61>:	pop    %r15
>    0xffffffff814f035f <+63>:	pop    %rbp
>    0xffffffff814f0360 <+64>:	jmp    0xffffffff81f747c4 <__x86_return_thunk>
>
> The indirect calls are not really needed as one knows the addresses of
> enabled LSM callbacks at boot time and only the order can possibly
> change at boot time with the lsm= kernel command line parameter.
>
> An array of static calls is defined per LSM hook and the static calls
> are updated at boot time once the order has been determined.
>
> A static key guards whether an LSM static call is enabled or not,
> without this static key, for LSM hooks that return an int, the presence
> of the hook that returns a default value can create side-effects which
> has resulted in bugs [1].
>
> With the hook now exposed as a static call, one can see that the
> retpolines are no longer there and the LSM callbacks are invoked
> directly:
>
> security_file_ioctl:
>    0xffffffff818f0ca0 <+0>:	endbr64
>    0xffffffff818f0ca4 <+4>:	nopl   0x0(%rax,%rax,1)
>    0xffffffff818f0ca9 <+9>:	push   %rbp
>    0xffffffff818f0caa <+10>:	push   %r14
>    0xffffffff818f0cac <+12>:	push   %rbx
>    0xffffffff818f0cad <+13>:	mov    %rdx,%rbx
>    0xffffffff818f0cb0 <+16>:	mov    %esi,%ebp
>    0xffffffff818f0cb2 <+18>:	mov    %rdi,%r14
>    0xffffffff818f0cb5 <+21>:	jmp    0xffffffff818f0cc7 <security_file_ioctl+39>
>   				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    Static key enabled for SELinux
>
>    0xffffffff818f0cb7 <+23>:	jmp    0xffffffff818f0cde <security_file_ioctl+62>
>    				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
>    Static key enabled for BPF LSM. This is something that is changed to
>    default to false to avoid the existing side effect issues of BPF LSM
>    [1] in a subsequent patch.
>
>    0xffffffff818f0cb9 <+25>:	xor    %eax,%eax
>    0xffffffff818f0cbb <+27>:	xchg   %ax,%ax
>    0xffffffff818f0cbd <+29>:	pop    %rbx
>    0xffffffff818f0cbe <+30>:	pop    %r14
>    0xffffffff818f0cc0 <+32>:	pop    %rbp
>    0xffffffff818f0cc1 <+33>:	cs jmp 0xffffffff82c00000 <__x86_return_thunk>
>    0xffffffff818f0cc7 <+39>:	endbr64
>    0xffffffff818f0ccb <+43>:	mov    %r14,%rdi
>    0xffffffff818f0cce <+46>:	mov    %ebp,%esi
>    0xffffffff818f0cd0 <+48>:	mov    %rbx,%rdx
>    0xffffffff818f0cd3 <+51>:	call   0xffffffff81903230 <selinux_file_ioctl>
>    				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    Direct call to SELinux.
>
>    0xffffffff818f0cd8 <+56>:	test   %eax,%eax
>    0xffffffff818f0cda <+58>:	jne    0xffffffff818f0cbd <security_file_ioctl+29>
>    0xffffffff818f0cdc <+60>:	jmp    0xffffffff818f0cb7 <security_file_ioctl+23>
>    0xffffffff818f0cde <+62>:	endbr64
>    0xffffffff818f0ce2 <+66>:	mov    %r14,%rdi
>    0xffffffff818f0ce5 <+69>:	mov    %ebp,%esi
>    0xffffffff818f0ce7 <+71>:	mov    %rbx,%rdx
>    0xffffffff818f0cea <+74>:	call   0xffffffff8141e220 <bpf_lsm_file_ioctl>
>    				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    Direct call to BPF LSM.
>
>    0xffffffff818f0cef <+79>:	test   %eax,%eax
>    0xffffffff818f0cf1 <+81>:	jne    0xffffffff818f0cbd <security_file_ioctl+29>
>    0xffffffff818f0cf3 <+83>:	jmp    0xffffffff818f0cb9 <security_file_ioctl+25>
>    0xffffffff818f0cf5 <+85>:	endbr64
>    0xffffffff818f0cf9 <+89>:	mov    %r14,%rdi
>    0xffffffff818f0cfc <+92>:	mov    %ebp,%esi
>    0xffffffff818f0cfe <+94>:	mov    %rbx,%rdx
>    0xffffffff818f0d01 <+97>:	pop    %rbx
>    0xffffffff818f0d02 <+98>:	pop    %r14
>    0xffffffff818f0d04 <+100>:	pop    %rbp
>    0xffffffff818f0d05 <+101>:	ret
>    0xffffffff818f0d06 <+102>:	int3
>    0xffffffff818f0d07 <+103>:	int3
>    0xffffffff818f0d08 <+104>:	int3
>    0xffffffff818f0d09 <+105>:	int3
>
> While this patch uses static_branch_unlikely indicating that an LSM hook
> is likely to be not present, a subsequent makes it configurable. In most
> cases this is still a better choice as even when an LSM with one hook is
> added, empty slots are created for all LSM hooks (especially when many
> LSMs that do not initialize most hooks are present on the system).
>
> There are some hooks that don't use the call_int_hook and
> call_void_hook. These hooks are updated to use a new macro called
> security_for_each_hook where the lsm_callback is directly invoked as an
> indirect call. Currently, there are no performance sensitive hooks that
> use the security_for_each_hook macro. However, if, some performance
> sensitive hooks are discovered, these can be updated to use static calls
> with loop unrolling as well using a custom macro.
>
> [1] https://lore.kernel.org/linux-security-module/20220609234601.2026362-1-kpsingh@kernel.org/
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>

Good job on reducing the impact in security.c.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  include/linux/lsm_hooks.h |  70 +++++++++++--
>  security/security.c       | 208 +++++++++++++++++++++++++-------------
>  2 files changed, 199 insertions(+), 79 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index dcb5e5b5eb13..eb9afe93496f 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -29,26 +29,77 @@
>  #include <linux/init.h>
>  #include <linux/rculist.h>
>  #include <linux/xattr.h>
> +#include <linux/static_call.h>
> +#include <linux/unroll.h>
> +#include <linux/jump_label.h>
> +#include <linux/lsm_count.h>
> +
> +#define SECURITY_HOOK_ACTIVE_KEY(HOOK, IDX) security_hook_active_##HOOK##_##IDX
> +
> +/*
> + * Identifier for the LSM static calls.
> + * HOOK is an LSM hook as defined in linux/lsm_hookdefs.h
> + * IDX is the index of the static call. 0 <= NUM < MAX_LSM_COUNT
> + */
> +#define LSM_STATIC_CALL(HOOK, IDX) lsm_static_call_##HOOK##_##IDX
> +
> +/*
> + * Call the macro M for each LSM hook MAX_LSM_COUNT times.
> + */
> +#define LSM_LOOP_UNROLL(M, ...) 		\
> +do {						\
> +	UNROLL(MAX_LSM_COUNT, M, __VA_ARGS__)	\
> +} while (0)
> +
> +#define LSM_DEFINE_UNROLL(M, ...) UNROLL(MAX_LSM_COUNT, M, __VA_ARGS__)
>  
>  union security_list_options {
>  	#define LSM_HOOK(RET, DEFAULT, NAME, ...) RET (*NAME)(__VA_ARGS__);
>  	#include "lsm_hook_defs.h"
>  	#undef LSM_HOOK
> +	void *lsm_callback;
>  };
>  
> -struct security_hook_heads {
> -	#define LSM_HOOK(RET, DEFAULT, NAME, ...) struct hlist_head NAME;
> -	#include "lsm_hook_defs.h"
> +/*
> + * @key: static call key as defined by STATIC_CALL_KEY
> + * @trampoline: static call trampoline as defined by STATIC_CALL_TRAMP
> + * @hl: The security_hook_list as initialized by the owning LSM.
> + * @active: Enabled when the static call has an LSM hook associated.
> + */
> +struct lsm_static_call {
> +	struct static_call_key *key;
> +	void *trampoline;
> +	struct security_hook_list *hl;
> +	/* this needs to be true or false based on what the key defaults to */
> +	struct static_key_false *active;
> +};
> +
> +/*
> + * Table of the static calls for each LSM hook.
> + * Once the LSMs are initialized, their callbacks will be copied to these
> + * tables such that the calls are filled backwards (from last to first).
> + * This way, we can jump directly to the first used static call, and execute
> + * all of them after. This essentially makes the entry point
> + * dynamic to adapt the number of static calls to the number of callbacks.
> + */
> +struct lsm_static_calls_table {
> +	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> +		struct lsm_static_call NAME[MAX_LSM_COUNT];
> +	#include <linux/lsm_hook_defs.h>
>  	#undef LSM_HOOK
>  } __randomize_layout;
>  
>  /*
>   * Security module hook list structure.
>   * For use with generic list macros for common operations.
> + *
> + * struct security_hook_list - Contents of a cacheable, mappable object.
> + * @scalls: The beginning of the array of static calls assigned to this hook.
> + * @hook: The callback for the hook.
> + * @lsm: The name of the lsm that owns this hook.
>   */
>  struct security_hook_list {
> -	struct hlist_node		list;
> -	struct hlist_head		*head;
> +	struct lsm_static_call	*scalls;
>  	union security_list_options	hook;
>  	const char			*lsm;
>  } __randomize_layout;
> @@ -97,10 +148,12 @@ static inline struct xattr *lsm_get_xattr_slot(struct xattr *xattrs,
>   * care of the common case and reduces the amount of
>   * text involved.
>   */
> -#define LSM_HOOK_INIT(HEAD, HOOK) \
> -	{ .head = &security_hook_heads.HEAD, .hook = { .HEAD = HOOK } }
> +#define LSM_HOOK_INIT(NAME, CALLBACK)			\
> +	{						\
> +		.scalls = static_calls_table.NAME,	\
> +		.hook = { .NAME = CALLBACK }		\
> +	}
>  
> -extern struct security_hook_heads security_hook_heads;
>  extern char *lsm_names;
>  
>  extern void security_add_hooks(struct security_hook_list *hooks, int count,
> @@ -138,5 +191,6 @@ extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
>  		__aligned(sizeof(unsigned long))
>  
>  extern int lsm_inode_alloc(struct inode *inode);
> +extern struct lsm_static_calls_table static_calls_table __ro_after_init;
>  
>  #endif /* ! __LINUX_LSM_HOOKS_H */
> diff --git a/security/security.c b/security/security.c
> index 7b0052e96806..c2c2cf6b711f 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -30,6 +30,8 @@
>  #include <linux/string.h>
>  #include <linux/msg.h>
>  #include <net/flow.h>
> +#include <linux/static_call.h>
> +#include <linux/jump_label.h>
>  
>  /* How many LSMs were built into the kernel? */
>  #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
> @@ -73,7 +75,6 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
>  
> -struct security_hook_heads security_hook_heads __ro_after_init;
>  static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
>  
>  static struct kmem_cache *lsm_file_cache;
> @@ -92,6 +93,51 @@ static __initconst const char *const builtin_lsm_order = CONFIG_LSM;
>  static __initdata struct lsm_info **ordered_lsms;
>  static __initdata struct lsm_info *exclusive;
>  
> +
> +#ifdef CONFIG_HAVE_STATIC_CALL
> +#define LSM_HOOK_TRAMP(NAME, NUM) \
> +	&STATIC_CALL_TRAMP(LSM_STATIC_CALL(NAME, NUM))
> +#else
> +#define LSM_HOOK_TRAMP(NAME, NUM) NULL
> +#endif
> +
> +/*
> + * Define static calls and static keys for each LSM hook.
> + */
> +
> +#define DEFINE_LSM_STATIC_CALL(NUM, NAME, RET, ...)			\
> +	DEFINE_STATIC_CALL_NULL(LSM_STATIC_CALL(NAME, NUM),		\
> +				*((RET(*)(__VA_ARGS__))NULL));		\
> +	DEFINE_STATIC_KEY_FALSE(SECURITY_HOOK_ACTIVE_KEY(NAME, NUM));
> +
> +#define LSM_HOOK(RET, DEFAULT, NAME, ...)				\
> +	LSM_DEFINE_UNROLL(DEFINE_LSM_STATIC_CALL, NAME, RET, __VA_ARGS__)
> +#include <linux/lsm_hook_defs.h>
> +#undef LSM_HOOK
> +#undef DEFINE_LSM_STATIC_CALL
> +
> +/*
> + * Initialise a table of static calls for each LSM hook.
> + * DEFINE_STATIC_CALL_NULL invocation above generates a key (STATIC_CALL_KEY)
> + * and a trampoline (STATIC_CALL_TRAMP) which are used to call
> + * __static_call_update when updating the static call.
> + */
> +struct lsm_static_calls_table static_calls_table __ro_after_init = {
> +#define INIT_LSM_STATIC_CALL(NUM, NAME)					\
> +	(struct lsm_static_call) {					\
> +		.key = &STATIC_CALL_KEY(LSM_STATIC_CALL(NAME, NUM)),	\
> +		.trampoline = LSM_HOOK_TRAMP(NAME, NUM),		\
> +		.active = &SECURITY_HOOK_ACTIVE_KEY(NAME, NUM),		\
> +	},
> +#define LSM_HOOK(RET, DEFAULT, NAME, ...)				\
> +	.NAME = {							\
> +		LSM_DEFINE_UNROLL(INIT_LSM_STATIC_CALL, NAME)		\
> +	},
> +#include <linux/lsm_hook_defs.h>
> +#undef LSM_HOOK
> +#undef INIT_LSM_STATIC_CALL
> +};
> +
>  static __initdata bool debug;
>  #define init_debug(...)						\
>  	do {							\
> @@ -152,7 +198,7 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
>  	if (exists_ordered_lsm(lsm))
>  		return;
>  
> -	if (WARN(last_lsm == LSM_COUNT, "%s: out of LSM slots!?\n", from))
> +	if (WARN(last_lsm == LSM_COUNT, "%s: out of LSM static calls!?\n", from))
>  		return;
>  
>  	/* Enable this LSM, if it is not already set. */
> @@ -325,6 +371,25 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  	kfree(sep);
>  }
>  
> +static void __init lsm_static_call_init(struct security_hook_list *hl)
> +{
> +	struct lsm_static_call *scall = hl->scalls;
> +	int i;
> +
> +	for (i = 0; i < MAX_LSM_COUNT; i++) {
> +		/* Update the first static call that is not used yet */
> +		if (!scall->hl) {
> +			__static_call_update(scall->key, scall->trampoline,
> +					     hl->hook.lsm_callback);
> +			scall->hl = hl;
> +			static_branch_enable(scall->active);
> +			return;
> +		}
> +		scall++;
> +	}
> +	panic("%s - Ran out of static slots.\n", __func__);
> +}
> +
>  static void __init lsm_early_cred(struct cred *cred);
>  static void __init lsm_early_task(struct task_struct *task);
>  
> @@ -404,11 +469,6 @@ int __init early_security_init(void)
>  {
>  	struct lsm_info *lsm;
>  
> -#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> -	INIT_HLIST_HEAD(&security_hook_heads.NAME);
> -#include "linux/lsm_hook_defs.h"
> -#undef LSM_HOOK
> -
>  	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
>  		if (!lsm->enabled)
>  			lsm->enabled = &lsm_enabled_true;
> @@ -524,7 +584,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>  
>  	for (i = 0; i < count; i++) {
>  		hooks[i].lsm = lsm;
> -		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
> +		lsm_static_call_init(&hooks[i]);
>  	}
>  
>  	/*
> @@ -762,29 +822,41 @@ static int lsm_superblock_alloc(struct super_block *sb)
>   * call_int_hook:
>   *	This is a hook that returns a value.
>   */
> +#define __CALL_STATIC_VOID(NUM, HOOK, ...)				     \
> +do {									     \
> +	if (static_branch_unlikely(&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM))) {    \
> +		static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__);	     \
> +	}								     \
> +} while (0);
>  
> -#define call_void_hook(FUNC, ...)				\
> -	do {							\
> -		struct security_hook_list *P;			\
> -								\
> -		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
> -			P->hook.FUNC(__VA_ARGS__);		\
> +#define call_void_hook(FUNC, ...)                                 \
> +	do {                                                      \
> +		LSM_LOOP_UNROLL(__CALL_STATIC_VOID, FUNC, __VA_ARGS__); \
>  	} while (0)
>  
> -#define call_int_hook(FUNC, IRC, ...) ({			\
> -	int RC = IRC;						\
> -	do {							\
> -		struct security_hook_list *P;			\
> -								\
> -		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
> -			RC = P->hook.FUNC(__VA_ARGS__);		\
> -			if (RC != 0)				\
> -				break;				\
> -		}						\
> -	} while (0);						\
> -	RC;							\
> +#define __CALL_STATIC_INT(NUM, R, HOOK, LABEL, ...)			     \
> +do {									     \
> +	if (static_branch_unlikely(&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM))) {  \
> +		R = static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__);    \
> +		if (R != 0)						     \
> +			goto LABEL;					     \
> +	}								     \
> +} while (0);
> +
> +#define call_int_hook(FUNC, IRC, ...)					\
> +({									\
> +	__label__ out;							\
> +	int RC = IRC;							\
> +	LSM_LOOP_UNROLL(__CALL_STATIC_INT, RC, FUNC, out, __VA_ARGS__);	\
> +out:									\
> +	RC;								\
>  })
>  
> +#define lsm_for_each_hook(scall, NAME)					\
> +	for (scall = static_calls_table.NAME;				\
> +	     scall - static_calls_table.NAME < MAX_LSM_COUNT; scall++)  \
> +		if (static_key_enabled(&scall->active->key))
> +
>  /* Security operations */
>  
>  /**
> @@ -1020,7 +1092,7 @@ int security_settime64(const struct timespec64 *ts, const struct timezone *tz)
>   */
>  int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
>  {
> -	struct security_hook_list *hp;
> +	struct lsm_static_call *scall;
>  	int cap_sys_admin = 1;
>  	int rc;
>  
> @@ -1031,8 +1103,8 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
>  	 * agree that it should be set it will. If any module
>  	 * thinks it should not be set it won't.
>  	 */
> -	hlist_for_each_entry(hp, &security_hook_heads.vm_enough_memory, list) {
> -		rc = hp->hook.vm_enough_memory(mm, pages);
> +	lsm_for_each_hook(scall, vm_enough_memory) {
> +		rc = scall->hl->hook.vm_enough_memory(mm, pages);
>  		if (rc <= 0) {
>  			cap_sys_admin = 0;
>  			break;
> @@ -1184,13 +1256,12 @@ int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
>  int security_fs_context_parse_param(struct fs_context *fc,
>  				    struct fs_parameter *param)
>  {
> -	struct security_hook_list *hp;
> +	struct lsm_static_call *scall;
>  	int trc;
>  	int rc = -ENOPARAM;
>  
> -	hlist_for_each_entry(hp, &security_hook_heads.fs_context_parse_param,
> -			     list) {
> -		trc = hp->hook.fs_context_parse_param(fc, param);
> +	lsm_for_each_hook(scall, fs_context_parse_param) {
> +		trc = scall->hl->hook.fs_context_parse_param(fc, param);
>  		if (trc == 0)
>  			rc = 0;
>  		else if (trc != -ENOPARAM)
> @@ -1553,19 +1624,19 @@ int security_dentry_init_security(struct dentry *dentry, int mode,
>  				  const char **xattr_name, void **ctx,
>  				  u32 *ctxlen)
>  {
> -	struct security_hook_list *hp;
> +	struct lsm_static_call *scall;
>  	int rc;
>  
>  	/*
>  	 * Only one module will provide a security context.
>  	 */
> -	hlist_for_each_entry(hp, &security_hook_heads.dentry_init_security,
> -			     list) {
> -		rc = hp->hook.dentry_init_security(dentry, mode, name,
> +	lsm_for_each_hook(scall, dentry_init_security) {
> +		rc = scall->hl->hook.dentry_init_security(dentry, mode, name,
>  						   xattr_name, ctx, ctxlen);
>  		if (rc != LSM_RET_DEFAULT(dentry_init_security))
>  			return rc;
>  	}
> +
>  	return LSM_RET_DEFAULT(dentry_init_security);
>  }
>  EXPORT_SYMBOL(security_dentry_init_security);
> @@ -1625,7 +1696,7 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
>  				 const struct qstr *qstr,
>  				 const initxattrs initxattrs, void *fs_data)
>  {
> -	struct security_hook_list *hp;
> +	struct lsm_static_call *scall;
>  	struct xattr *new_xattrs = NULL;
>  	int ret = -EOPNOTSUPP, xattr_count = 0;
>  
> @@ -1643,9 +1714,8 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
>  			return -ENOMEM;
>  	}
>  
> -	hlist_for_each_entry(hp, &security_hook_heads.inode_init_security,
> -			     list) {
> -		ret = hp->hook.inode_init_security(inode, dir, qstr, new_xattrs,
> +	lsm_for_each_hook(scall, inode_init_security) {
> +		ret = scall->hl->hook.inode_init_security(inode, dir, qstr, new_xattrs,
>  						  &xattr_count);
>  		if (ret && ret != -EOPNOTSUPP)
>  			goto out;
> @@ -2405,7 +2475,7 @@ int security_inode_getsecurity(struct mnt_idmap *idmap,
>  			       struct inode *inode, const char *name,
>  			       void **buffer, bool alloc)
>  {
> -	struct security_hook_list *hp;
> +	struct lsm_static_call *scall;
>  	int rc;
>  
>  	if (unlikely(IS_PRIVATE(inode)))
> @@ -2413,9 +2483,8 @@ int security_inode_getsecurity(struct mnt_idmap *idmap,
>  	/*
>  	 * Only one module will provide an attribute with a given name.
>  	 */
> -	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecurity, list) {
> -		rc = hp->hook.inode_getsecurity(idmap, inode, name, buffer,
> -						alloc);
> +	lsm_for_each_hook(scall, inode_getsecurity) {
> +		rc = scall->hl->hook.inode_getsecurity(idmap, inode, name, buffer, alloc);
>  		if (rc != LSM_RET_DEFAULT(inode_getsecurity))
>  			return rc;
>  	}
> @@ -2440,7 +2509,7 @@ int security_inode_getsecurity(struct mnt_idmap *idmap,
>  int security_inode_setsecurity(struct inode *inode, const char *name,
>  			       const void *value, size_t size, int flags)
>  {
> -	struct security_hook_list *hp;
> +	struct lsm_static_call *scall;
>  	int rc;
>  
>  	if (unlikely(IS_PRIVATE(inode)))
> @@ -2448,9 +2517,8 @@ int security_inode_setsecurity(struct inode *inode, const char *name,
>  	/*
>  	 * Only one module will provide an attribute with a given name.
>  	 */
> -	hlist_for_each_entry(hp, &security_hook_heads.inode_setsecurity, list) {
> -		rc = hp->hook.inode_setsecurity(inode, name, value, size,
> -						flags);
> +	lsm_for_each_hook(scall, inode_setsecurity) {
> +		rc = scall->hl->hook.inode_setsecurity(inode, name, value, size, flags);
>  		if (rc != LSM_RET_DEFAULT(inode_setsecurity))
>  			return rc;
>  	}
> @@ -2524,7 +2592,7 @@ EXPORT_SYMBOL(security_inode_copy_up);
>   */
>  int security_inode_copy_up_xattr(const char *name)
>  {
> -	struct security_hook_list *hp;
> +	struct lsm_static_call *scall;
>  	int rc;
>  
>  	/*
> @@ -2532,9 +2600,8 @@ int security_inode_copy_up_xattr(const char *name)
>  	 * xattr), -EOPNOTSUPP if it does not know anything about the xattr or
>  	 * any other error code in case of an error.
>  	 */
> -	hlist_for_each_entry(hp,
> -			     &security_hook_heads.inode_copy_up_xattr, list) {
> -		rc = hp->hook.inode_copy_up_xattr(name);
> +	lsm_for_each_hook(scall, inode_copy_up_xattr) {
> +		rc = scall->hl->hook.inode_copy_up_xattr(name);
>  		if (rc != LSM_RET_DEFAULT(inode_copy_up_xattr))
>  			return rc;
>  	}
> @@ -3414,10 +3481,10 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
>  {
>  	int thisrc;
>  	int rc = LSM_RET_DEFAULT(task_prctl);
> -	struct security_hook_list *hp;
> +	struct lsm_static_call *scall;
>  
> -	hlist_for_each_entry(hp, &security_hook_heads.task_prctl, list) {
> -		thisrc = hp->hook.task_prctl(option, arg2, arg3, arg4, arg5);
> +	lsm_for_each_hook(scall, task_prctl) {
> +		thisrc = scall->hl->hook.task_prctl(option, arg2, arg3, arg4, arg5);
>  		if (thisrc != LSM_RET_DEFAULT(task_prctl)) {
>  			rc = thisrc;
>  			if (thisrc != 0)
> @@ -3814,12 +3881,12 @@ EXPORT_SYMBOL(security_d_instantiate);
>  int security_getprocattr(struct task_struct *p, const char *lsm,
>  			 const char *name, char **value)
>  {
> -	struct security_hook_list *hp;
> +	struct lsm_static_call *scall;
>  
> -	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
> -		if (lsm != NULL && strcmp(lsm, hp->lsm))
> +	lsm_for_each_hook(scall, getprocattr) {
> +		if (lsm != NULL && strcmp(lsm, scall->hl->lsm))
>  			continue;
> -		return hp->hook.getprocattr(p, name, value);
> +		return scall->hl->hook.getprocattr(p, name, value);
>  	}
>  	return LSM_RET_DEFAULT(getprocattr);
>  }
> @@ -3839,12 +3906,12 @@ int security_getprocattr(struct task_struct *p, const char *lsm,
>  int security_setprocattr(const char *lsm, const char *name, void *value,
>  			 size_t size)
>  {
> -	struct security_hook_list *hp;
> +	struct lsm_static_call *scall;
>  
> -	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
> -		if (lsm != NULL && strcmp(lsm, hp->lsm))
> +	lsm_for_each_hook(scall, setprocattr) {
> +		if (lsm != NULL && strcmp(lsm, scall->hl->lsm))
>  			continue;
> -		return hp->hook.setprocattr(name, value, size);
> +		return scall->hl->hook.setprocattr(name, value, size);
>  	}
>  	return LSM_RET_DEFAULT(setprocattr);
>  }
> @@ -3896,15 +3963,15 @@ EXPORT_SYMBOL(security_ismaclabel);
>   */
>  int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
>  {
> -	struct security_hook_list *hp;
> +	struct lsm_static_call *scall;
>  	int rc;
>  
>  	/*
>  	 * Currently, only one LSM can implement secid_to_secctx (i.e this
>  	 * LSM hook is not "stackable").
>  	 */
> -	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
> -		rc = hp->hook.secid_to_secctx(secid, secdata, seclen);
> +	lsm_for_each_hook(scall, secid_to_secctx) {
> +		rc = scall->hl->hook.secid_to_secctx(secid, secdata, seclen);
>  		if (rc != LSM_RET_DEFAULT(secid_to_secctx))
>  			return rc;
>  	}
> @@ -4947,7 +5014,7 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
>  				       struct xfrm_policy *xp,
>  				       const struct flowi_common *flic)
>  {
> -	struct security_hook_list *hp;
> +	struct lsm_static_call *scall;
>  	int rc = LSM_RET_DEFAULT(xfrm_state_pol_flow_match);
>  
>  	/*
> @@ -4959,9 +5026,8 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
>  	 * For speed optimization, we explicitly break the loop rather than
>  	 * using the macro
>  	 */
> -	hlist_for_each_entry(hp, &security_hook_heads.xfrm_state_pol_flow_match,
> -			     list) {
> -		rc = hp->hook.xfrm_state_pol_flow_match(x, xp, flic);
> +	lsm_for_each_hook(scall, xfrm_state_pol_flow_match) {
> +		rc = scall->hl->hook.xfrm_state_pol_flow_match(x, xp, flic);
>  		break;
>  	}
>  	return rc;

