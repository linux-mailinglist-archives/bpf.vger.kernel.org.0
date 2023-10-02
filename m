Return-Path: <bpf+bounces-11183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E027B4FD8
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 12:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 253012829FD
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 10:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A122D30A;
	Mon,  2 Oct 2023 10:04:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA18C126
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 10:04:46 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B951A7
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 03:04:44 -0700 (PDT)
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 392A4SNN079265;
	Mon, 2 Oct 2023 19:04:28 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Mon, 02 Oct 2023 19:04:28 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 392A4RDD079262
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 2 Oct 2023 19:04:28 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <51d6c605-25cc-71fc-9c11-707b78297b38@I-love.SAKURA.ne.jp>
Date: Mon, 2 Oct 2023 19:04:27 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 1/2] LSM: Allow dynamically appendable LSM modules.
Content-Language: en-US
To: Kees Cook <kees@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        KP Singh <kpsingh@kernel.org>, Paul Moore <paul@paul-moore.com>,
        bpf <bpf@vger.kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <cc8e16bb-5083-01da-4a77-d251a76dc8ff@I-love.SAKURA.ne.jp>
 <57295dac-9abd-3bac-ff5d-ccf064947162@schaufler-ca.com>
 <b2cd749e-a716-1a13-6550-44a232deac25@I-love.SAKURA.ne.jp>
 <06BC106C-E0FD-4ACA-83A8-DFD1400B696E@kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <06BC106C-E0FD-4ACA-83A8-DFD1400B696E@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/10/02 0:44, Kees Cook wrote:
> On October 1, 2023 4:31:05 AM PDT, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
>> Kees Cook said there is no problem if the policy of assigning LSM ID value were
>>
>>  1) author: "Hello, here is a new LSM I'd like to upstream, here it is. I assigned
>>              it the next LSM ID."
>>     maintainer(s): "Okay, sounds good. *review*"
>>
>>  2) author: "Hello, here is an LSM that has been in active use at $Place,
>>              and we have $Xxx many userspace applications that we cannot easily
>>              rebuild. We used LSM ID $Value that is far away from the sequential
>>              list of LSM IDs, and we'd really prefer to keep that assignment."
>>    maintainer(s): "Okay, sounds good. *review*"
>>
>> and I agreed at https://lkml.kernel.org/r/6e1c25f5-b78c-8b4e-ddc3-484129c4c0ec@I-love.SAKURA.ne.jp .
>>
>> But Paul Moore's response was
>>
>>  No LSM ID value is guaranteed until it is present in a tagged release
>>  from Linus' tree, and once a LSM ID is present in a tagged release
>>  from Linus' tree it should not change.  That's *the* policy.
>>
>> which means that the policy is not what Kees Cook has said.
> 
> These don't conflict at all! Paul is saying an ID isn't guaranteed in upstream
> until it's in upstream. I'm saying the id space is large enough that you could
> make a new out of tree LSM every second for the next billion years. The upstream
> assignment process is likely sequential, but that out of sequence LSMs that show
> a need to be upstream could make a case for their existing value.

Excuse me? If the LSM community wants the assignment sequential, the LSM community
cannot admit the LSM value assigned to a not-yet-in-tree LSM.

If "Okay, sounds good." does not imply that the LSM community admits the LSM value
assigned to a not-yet-in-tree LSM, what did "Okay, sounds good." mean?


