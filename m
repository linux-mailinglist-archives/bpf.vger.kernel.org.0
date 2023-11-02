Return-Path: <bpf+bounces-13938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E3C7DEFFA
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 11:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F07F61C20EA6
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 10:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8AA13FED;
	Thu,  2 Nov 2023 10:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B1314267
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 10:30:40 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49E4187
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 03:30:38 -0700 (PDT)
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 3A2AU3gr097599;
	Thu, 2 Nov 2023 19:30:03 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Thu, 02 Nov 2023 19:30:03 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 3A2AU3Hh097595
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 2 Nov 2023 19:30:03 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <cdd87907-e75a-46fd-884f-29fc07f62c32@I-love.SAKURA.ne.jp>
Date: Thu, 2 Nov 2023 19:30:03 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/5] Reduce overhead of LSMs with static calls
Content-Language: en-US
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com,
        song@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        renauld@google.com, pabeni@redhat.com
References: <20231102005521.346983-1-kpsingh@kernel.org>
 <b0186178-0338-4db1-9065-b6bbda10d58f@I-love.SAKURA.ne.jp>
 <CACYkzJ48EOFEgeWyX=mTwPhZk2Wb=LzngPGCo8Hn=KoBcgCJHg@mail.gmail.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CACYkzJ48EOFEgeWyX=mTwPhZk2Wb=LzngPGCo8Hn=KoBcgCJHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2023/11/02 19:01, KP Singh wrote:
> On Thu, Nov 2, 2023 at 10:42 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> I didn't get your response on https://lkml.kernel.org/r/c588ca5d-c343-4ea2-a1f1-4efe67ebb8e3@I-love.SAKURA.ne.jp .
>>
>> Do you agree that we cannot replace LKM-based LSMs with eBPF-based access control mechanisms,
>> and do you admit that this series makes LKM-based LSMs more difficult to use?
> 
> If you want to do a proper in-tree version of dynamic LSMs. There can
> be an exported symbol that allocates a dynamic slot and registers LSM
> hooks to it. This is very doable, but it's not my use case so, I am
> not going to do it.
> 
> No it does not make LKM based LSMs difficult to use. I am not ready to
> have that debate again.  I suggested multiple extensions in my replies
> which you chose to ignore.

You said

  I think this needs to be discussed if and when we allow LKM based LSMs."

as a response to

  It is Casey's commitment that the LSM infrastructure will not forbid LKM-based LSMs.
  We will start allowing LKM-based LSMs. But it is not clear how we can make it possible to
  allow LKM-based LSMs.

, and you suggested combination of static calls (for built-in LSMs) and
linked list (for LKM-based LSMs).

So, what is your answer to

  Until I hear the real limitations of using BPF, it's a NAK from me.

? Do you agree to allow dynamically appendable LSM modules?


