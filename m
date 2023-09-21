Return-Path: <bpf+bounces-10532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9C77A9867
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 19:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25B06B21293
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 17:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1710915486;
	Thu, 21 Sep 2023 17:12:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E731BBE71
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 17:12:50 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EC84697;
	Thu, 21 Sep 2023 10:12:24 -0700 (PDT)
Received: from fsav314.sakura.ne.jp (fsav314.sakura.ne.jp [153.120.85.145])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 38LDKAiK029837;
	Thu, 21 Sep 2023 22:20:10 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav314.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp);
 Thu, 21 Sep 2023 22:20:10 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 38LDKACn029819
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 21 Sep 2023 22:20:10 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <cb67f607-3a9d-34d2-0877-a3ff957da79e@I-love.SAKURA.ne.jp>
Date: Thu, 21 Sep 2023 22:20:09 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/5] security: Count the LSMs enabled at compile time
Content-Language: en-US
To: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org,
        bpf@vger.kernel.org
Cc: paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com,
        song@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        Kui-Feng Lee <sinquersw@gmail.com>
References: <20230918212459.1937798-1-kpsingh@kernel.org>
 <20230918212459.1937798-3-kpsingh@kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20230918212459.1937798-3-kpsingh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/09/19 6:24, KP Singh wrote:
> These macros are a clever trick to determine a count of the number of
> LSMs that are enabled in the config to ascertain the maximum number of
> static calls that need to be configured per LSM hook.

As a LKM-based LSM user, indirect function calls using a linked list have
an advantage which this series kills. There always is a situation where a
LSM cannot be built into vmlinux (and hence has to be loaded as a LKM-based
LSM) due to distributor's support policy. Therefore, honestly speaking,
I don't want LSM infrastructure to define the maximum number of "slots" or
"static calls"...

> 
> Without this one would need to generate static calls for (number of
> possible LSMs * number of LSM hooks) which ends up being quite wasteful
> especially when some LSMs are not compiled into the kernel.

I can't interpret "number of possible LSMs * number of LSM hooks" part.
Is this tokenized as "number of possible LSMs" (an integer) * (multipled by)
"number of LSM hooks" (an integer) ? But the next patch includes

  struct lsm_static_calls_table {
  #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
  		struct lsm_static_call NAME[MAX_LSM_COUNT];
  	#include <linux/lsm_hook_defs.h>
  	#undef LSM_HOOK
  } __randomize_layout;

which seems to me that lsm_static_calls_table will get "number of possible
LSMs" static calls for each LSM hook defined in linux/lsm_hook_defs.h .
How did this patch help reducing static calls? What does "possible LSMs" mean?
Should "number of possible LSMs" be replaced with "number of built-in LSMs" ?

> Suggested-by: Andrii Nakryiko <andrii@kernel.org

Trailing ">" is missing.

> +/*
> + * Macros to count the number of LSMs enabled in the kernel at compile time.
> + */
> +#define MAX_LSM_COUNT			\
> +	___COUNT_COMMAS(		\
> +		CAPABILITIES_ENABLED	\
> +		SELINUX_ENABLED		\
> +		SMACK_ENABLED		\
> +		APPARMOR_ENABLED	\
> +		TOMOYO_ENABLED		\
> +		YAMA_ENABLED		\
> +		LOADPIN_ENABLED		\
> +		LOCKDOWN_ENABLED	\
> +		BPF_LSM_ENABLED		\
> +		LANDLOCK_ENABLED)

Since IS_ENABLED(CONFIG_FOO) is evaluated to either 1 or 0, why can't you directly
do like IS_ENABLED(CONFIG_FOO) + IS_ENABLED(CONFIG_BAR) + IS_ENABLED(CONFIG_BUZ) ?
If you can't do direct "+", can't you still do indirect "+" like something below?

#if IS_ENABLED(CONFIG_FOO)
#define FOO_ENABLED 1
#else
#define FOO_ENABLED 0
#endif


