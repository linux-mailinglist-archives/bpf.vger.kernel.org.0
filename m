Return-Path: <bpf+bounces-10751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3887AD699
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 13:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 727FF2823CB
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 11:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C00F182AB;
	Mon, 25 Sep 2023 11:03:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B5215EA2
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 11:03:49 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78936D3
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 04:03:48 -0700 (PDT)
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 38PB3HF0052907;
	Mon, 25 Sep 2023 20:03:17 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Mon, 25 Sep 2023 20:03:17 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 38PB3H5s052904
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 25 Sep 2023 20:03:17 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <6a80711e-edc4-9fab-6749-f1efa9e4231e@I-love.SAKURA.ne.jp>
Date: Mon, 25 Sep 2023 20:03:17 +0900
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
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com,
        song@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        Kui-Feng Lee <sinquersw@gmail.com>
References: <20230918212459.1937798-1-kpsingh@kernel.org>
 <20230918212459.1937798-3-kpsingh@kernel.org>
 <cb67f607-3a9d-34d2-0877-a3ff957da79e@I-love.SAKURA.ne.jp>
 <CACYkzJ5GFsgc3vzJXH34hgoTc+CEf+7rcktj0QGeQ5e8LobRcw@mail.gmail.com>
 <dde20522-af01-c198-5872-b19ef378f286@I-love.SAKURA.ne.jp>
 <CACYkzJ5M0Bw9S_mkFkjR_-bRsKryXh2LKiurjMX9WW-d0Mr6bg@mail.gmail.com>
 <ed785c86-a1d8-caff-c629-f8a50549e05b@I-love.SAKURA.ne.jp>
 <CACYkzJ4TLCMFEa5h-iEVC-58cakjduw44c-ct64SgBe0_jFKuQ@mail.gmail.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CACYkzJ4TLCMFEa5h-iEVC-58cakjduw44c-ct64SgBe0_jFKuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/09/24 1:06, KP Singh wrote:
>> I was not pushing LKM-based LSM because the LSM community wanted to make it possible to
>> enable arbitrary combinations (e.g. enabling selinux and smack at the same time) before
>> making it possible to use LKM-based LSMs.
(...snipped...)
>> As a reminder to tell that I still want to make LKM-based LSM officially supported again,
>> I'm responding to changes (like this patch) that are based on "any LSM must be built into
>> vmlinux". Please be careful not to make changes that forever make LKM-based LSMs impossible.

You did not recognize the core chunk of this post. :-(

It is Casey's commitment that the LSM infrastructure will not forbid LKM-based LSMs.
We will start allowing LKM-based LSMs. But it is not clear how we can make it possible to
allow LKM-based LSMs.

Suppose you replace the linked list (which does not need to limit number of LSMs activated)
with static calls (which limits number of LSMs activated, due to use of compile-time determined
MAX_LSM_COUNT value at

  struct lsm_static_calls_table {
  	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
  		struct lsm_static_call NAME[MAX_LSM_COUNT];
  	#include <linux/lsm_hook_defs.h>
  	#undef LSM_HOOK
  } __randomize_layout;

. If NAME[MAX_LSM_COUNT] were allocated like

  NAME = kcalloc(sizeof(struct lsm_static_call), number_of_max_lsms_to_activate, GFP_KERNEL | __GFP_NOFAIL);

(where number_of_max_lsms_to_activate is controlled using kernel command line parameter)
rater than

  struct lsm_static_call NAME[MAX_LSM_COUNT];

, it is easy to allow LKM-based LSMs.

But if NAME[MAX_LSM_COUNT] is allocated in a way which cannot be expanded using kernel
command line parameter (this is what "[PATCH v3 2/5] security: Count the LSMs enabled
at compile time" does), how can the LKM-based LSMs be registered? Introduce a LSM module
which revives the linked list and registration function (which this patch tried to remove) ?
If yes, do we want to use

  #define LSM_HOOK(RET, DEFAULT, NAME, ...) \

for built-in LSMs and a different macro for LKM-based LSMs?

Do we want/agree to manage two different set of macros/functions only for handling
both built-in LSMs and loadable LSMs?

That's a lot of complication, compared to temporarily making the security_hook_heads writable.



> You are trying to use an unexported symbol from the module with lots
> of hackery to write to be supported and bring it up in a discussion?
> Good luck!

Currently LKM-based LSMs is not officially supported. But LKM-based LSMs will become
officially supported in the future. Therefore, I respond to any attempt which tries
to make LKM-based LSMs impossible.

> 
> Regardless, if what you are doing really works after
> https://lore.kernel.org/all/20200107133154.588958-1-omosnace@redhat.com,
> then we need to fix this as the security_hook_heads should be
> immutable after boot.

You should learn how the __ro_after_init works. I will throw NACK if someone tries
to add an exception to __ro_after_init handling before we make it possible to allow
LKM-based LSMs.


