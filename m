Return-Path: <bpf+bounces-11177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FBE7B485E
	for <lists+bpf@lfdr.de>; Sun,  1 Oct 2023 17:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 973501C208C6
	for <lists+bpf@lfdr.de>; Sun,  1 Oct 2023 15:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B87182C8;
	Sun,  1 Oct 2023 15:19:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1DAFC06
	for <bpf@vger.kernel.org>; Sun,  1 Oct 2023 15:19:22 +0000 (UTC)
Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8819EDF
	for <bpf@vger.kernel.org>; Sun,  1 Oct 2023 08:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1696173558; bh=9rlilZFmsz0PzRQI+2WFbHi+I5LRAOXqfNvuqjCQUrc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=f3WDTOqmBhzYRBe9+SFYshoFQQVrI8xLcOWajsZ6Z1XwI6orYnYmNIYTgObJk4uy+n3XquImtho1wxv962U3/IBL3weJKIMsVg//ghTXzKxs3JAwFp/os3YRCcDiIShsz/d85JEw7Ga3ZcTmoJjXSJHVI0Qf2O4NFBQ03WKYZhnSwPCA8cVdZQN8JaquZhXZr4UosvBn5NFzjePjtpm06iee/CaO4SQNDJS0OScFSySzFPKAEaDs+q+8GB79fRSA20w4F9LSA7vMM6ZvSkxO2JlsmdZz3DCX0crYB3fyGbwQJkQ7umOLK8CSGlqNJN8vUJt0X/qUHfrbs7IJQXppNw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1696173558; bh=poJfC4Rnt57BuGfv9t7zEbxLcH/M2Ps6SFmiVsvGWhl=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=IMExafy7Bwb3SRammONs7m4YRV6pcOSgFBE9wg7Fs5503brxHZ0Kyj3p9DQzNrORFnjZW6R72VDPhU0hYOREsAec3CUSOkT/iUTv99aufh5MPEZ2VBKvJYFD2n20z+fz0AzJ5L1hnWWEt6+zlFBskrf8qqGlEUhO77QRZHQ0pnM+N8I7DWLiqrFNgLZ4/21MkwxHlZk1ZmVr34GDtsfoPvvGAtVcXAQhq1lD4BTCkDCqmQEfuhDtcWw1nU557dJ6HfQeopYukIV99XfUCWWxnuswMlC+GwRj/r+i7BQhIwd0zveYyfEIgzFg+jhxxa5ZGu+CkN+GsS3CURUIpOg45w==
X-YMail-OSG: dyjFUjwVM1mBYiIpe.FKxoRc1wk_TmGHwUCyVYPD.gJYDDtX00a2uwFJ0_HkebL
 5ia9it0sX.kO6JUeUDYzFd21g0dyXKC6wcMjGUBgxjY2TEbbk4Udz_nwfCrl009zshGwF1qy66PL
 z6GCZ7nq6bTAkGhGxpcFQbPVyu.HXJOIexQC4QuJmG.KO4h4NtX7xL04WoDeLDsDtxu2ttD.NkIH
 xcdug2vqYdBBaJdZQgYReYOyLY0TlMyRD7SmEy7mU8PB9.ToGDKg_Z4eUSGu122GsD2560Ua6.XD
 _BmRmn9ts.JCxCGiUe9ng_USJJSRvqnwNUxxql5V4aeMoeqWfHEeoxIE.lw9irM1VO2Hyr5cuKDX
 JEUmmwJzVnOHKVS8bsE1MdJh_XXExQSZ1S1oLVm3lGdUwfFmGTLZyDyH5ApFPcTh3xKoLgHIQEbI
 BTbv.6bER4xxnjctwRDyzL0p7VYN66XIL2V_P16moq_wNj9GVFWj65_7GSoHKbyRT0_Ey38A4Gi_
 J65LGrHkENVRtiAzwYVukVHvYsrNHFDexksjxqFkpuGTuVQRZkWQqkbK9XBL4f7OleRvYKcrsUnY
 ia1OcgDeRpSbAIn1w2q47xr0EQjW_MiFSWh4.rcaAS_oTo57WqQLPqaJ1oBzAJeFCMjeMKj9P3J_
 k1ZRFhj1REBXVg1GK6y1dGFye6osGQ.TNEkVpUQsbZG166hjPfNVN9bt_YVb869h1.O7_DdyvKGp
 _qLsgypUd7PBd7qsS9UM1uqEReFFVnRL8DBxpzvoaOlgl7iDo4fk7BE53Uz59pScwz_UjgLguImK
 FuF3Yt8gtD5V.SlaxacKYQbs0aZsNc6353_pt_NcnGDXw_1WG5whzKCCNNco7oxZgNVAXUhGMEsQ
 dAqx_DDAdo0pxEBbpF0QiW9PfpDnSzTmnn9Bv0Yhy9E7aDFf7n.mqtc0Cy70yKbqzqBJrWMr0KCR
 W_sBvHwOG5qV0J3WaV6Q27cgUeVVu8B1qBhCElqkG28nKkNxugxCA3qjDEmrAnxThMYxL0wHHqK2
 Zacd4vFK_WgKOa.JPJYH6cXEpKms3sk_siAAfGCopEvupetfyh7F.x.fBEnS7H4wabrWeVnF1DAH
 2i.1_IBIdMpoLmNhv22jgB7D79aBozYfBm32KAwdz9wpIibrWrcUwTCKZuFuypFa49lFTZ8PP_ib
 .3iICD7HF0i9wmFLz6R_iNWD1mMgpAbOeegbyZADlYR9SGAh3njglc93ezwjbDRyvffkh6jQg6Ee
 pMLAY0LP.nPq9CahCj6.zGdQTx9L2N5UZr.foHEzGKYHq674_FO7uDrE6ndiX2osaBdkvM6CoyLP
 bW9foT0bz_X0dYWvSH5Rw.SD7tPs9Q_WffbsPRk8bIs2kZYM.vW87qkUBuNjaIRO8OkgRVNiY99T
 xaDa36dk1NdFJTaNolgWvmS8FLJFhVy2.CvuYZHnwkYj6sAD8f5mPML9R5DzVjnfRdWAFhskJoib
 MxePhFwKL8Oej_hp64vOe9J022dDa0h0cgbU1oyEg8hnqCwB.cHEexfcZDbMPSSWvD8wubIoV_pv
 U4RagMTAqwrFXLJR1hQIz5yNuBBzDRayLeSLdRgxMJDijqb0PQzBdQj0VbEZtaeaoMMI1Xd3G1d1
 eSnKgpGOmnmDXmdWghuueWzPfronqn1ZsQRZoebzE0GHnW.GNaex_H6d77xo9IjteispvgKoXwvM
 m13Op_hEMNWybWrJpuVMpICRz.ki.lVihO9t54wVVI3sJwH_wByYyEnav3YFyI8irMyBLvpuWlTZ
 pQXwPptFuoc6mrSfNdua5WWE5nggJX4xtR11yV6oglBJrFjAAJdaq4Ckzh8wOuy172UMLgxsThBn
 9iew5rADGDoS3lzlIrw0HdBXINRgGWtsqwHWu3MaVwr56UCxtll2SDOR_ra2Oi_XfcB0rvAkN8Vb
 vURSfBgTDUoYtvHP5LWIiSFDQtYRoMVCxGrh55kSgvnk.nh4ZjHQAadOIg4Uh4nrOE0MR_7mooIB
 1QmpwveH8q4n2XTPCBXMYU6eERuFQXoKq77FY1xWMlo1qcRKzjr2dT2Sj62uude9whCxPVTSPfaf
 BBPpavL7WGdq_hmcNMFkOj4NdqHwPPtUD6PqYwGcRdZebI9vfU3rYpDclWzU02QoERSohirVbw4m
 2ZOIVUDY5xp5ZheN50aTjGU1j5LdGbehUDBEDLnoZ63OmpL.db9bNLpFfiX2f17JAwPPvpord4ch
 O4DEdo1Pvk56OI0iTf9mA_dkAvoR4bdtC
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 50063048-7130-49af-a010-4410bae41a16
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Sun, 1 Oct 2023 15:19:18 +0000
Received: by hermes--production-bf1-7cf89fd98c-ff8xs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f6f7c70494fd01fb862427598fd93bba;
          Sun, 01 Oct 2023 15:19:16 +0000 (UTC)
Message-ID: <1b9f0e3f-0ff3-5b2d-19fa-dfa83afab8a6@schaufler-ca.com>
Date: Sun, 1 Oct 2023 08:19:13 -0700
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
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 linux-security-module <linux-security-module@vger.kernel.org>,
 KP Singh <kpsingh@kernel.org>, Paul Moore <paul@paul-moore.com>,
 bpf <bpf@vger.kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <cc8e16bb-5083-01da-4a77-d251a76dc8ff@I-love.SAKURA.ne.jp>
 <57295dac-9abd-3bac-ff5d-ccf064947162@schaufler-ca.com>
 <b2cd749e-a716-1a13-6550-44a232deac25@I-love.SAKURA.ne.jp>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <b2cd749e-a716-1a13-6550-44a232deac25@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/1/2023 4:31 AM, Tetsuo Handa wrote:
> On 2023/09/28 1:37, Casey Schaufler wrote:
>> On 9/27/2023 8:08 AM, Tetsuo Handa wrote:
>>> Recently, the LSM community is trying to make drastic changes.
>> I'd call them "significant" or "important" rather than "drastic".
>>
>>> Crispin Cowan has explained
>>>
>>>   It is Linus' comments that spurred me to want to start this undertaking.  He
>>>   observes that there are many different security approaches, each with their own
>>>   advocates.  He doesn't want to arbitrate which of them should be "the" Linux
>>>   security approach, and would rather that Linux can support any of them.
>>>
>>>   That is the purpose of this project:  to allow Linux to support a variety of
>>>   security models, so that security developers don't have to have the "my dog's
>>>   bigger than your dog" argument, and users can choose the security model that
>>>   suits their needs.
>>>
>>> when the LSM project started [1].
>>>
>>> However, Casey Schaufler is trying to make users difficult to choose the
>>> security model that suits their needs, by requiring LSM ID value which is
>>> assigned to only LSM modules that succeeded to become in-tree [2].
>> This statement is demonstrably false, and I'm tired of hearing it.
> This statement is absolutely true.
>
> Kees Cook said there is no problem if the policy of assigning LSM ID value were
>
>   1) author: "Hello, here is a new LSM I'd like to upstream, here it is. I assigned
>               it the next LSM ID."
>      maintainer(s): "Okay, sounds good. *review*"
>
>   2) author: "Hello, here is an LSM that has been in active use at $Place,
>               and we have $Xxx many userspace applications that we cannot easily
>               rebuild. We used LSM ID $Value that is far away from the sequential
>               list of LSM IDs, and we'd really prefer to keep that assignment."
>     maintainer(s): "Okay, sounds good. *review*"
>
> and I agreed at https://lkml.kernel.org/r/6e1c25f5-b78c-8b4e-ddc3-484129c4c0ec@I-love.SAKURA.ne.jp .
>
> But Paul Moore's response was
>
>   No LSM ID value is guaranteed until it is present in a tagged release
>   from Linus' tree, and once a LSM ID is present in a tagged release
>   from Linus' tree it should not change.  That's *the* policy.
>
> which means that the policy is not what Kees Cook has said.
>
>
>>>  struct security_hook_heads security_hook_heads __ro_after_init;
>>> +EXPORT_SYMBOL_GPL(security_hook_heads);
>> Why disrupt the protection of security_hook_heads? You could easily add
>>
>> struct security_hook_heads security_loadable_hook_heads
>> EXPORT_SYMBOL_GPL(security_loadable_hook_heads);
>>
>> and add the loaded hooks there. A system that does not use loadable
>> modules would be unaffected by the ability to load modules.
>
> I'm fine if security_loadable_hook_heads() (and related code) cannot be
> disabled by the kernel configuration.

CONFIG_SECURITY ensures that you will be unhappy.
Even setting that aside, it's the developer's job to sell the code to
the communities involved. I could rant at certain distros for not including
Smack, but until such time as I've made doing that attractive it really
doesn't make any sense to do so. You don't think I've spent years on stacking
because I want to run Android containers on Ubuntu, do you?

>
> Pasting https://lkml.org/lkml/2007/10/1/192 here again.
>
>   On Mon, 1 Oct 2007, James Morris wrote:
>   > 
>   > Merging Smack, however, would lock the kernel into the LSM API.  
>   > Presently, as SELinux is the only in-tree user, LSM can still be removed.
>   
>   Hell f*cking NO!
>   
>   You security people are insane. I'm tired of this "only my version is 
>   correct" crap. The whole and only point of LSM was to get away from that.
>   
>   And anybody who claims that there is "consensus" on SELinux is just in 
>   denial.
>   
>   People are arguing against other peoples security on totally bogus points. 
>   First it was AppArmor, now this.
>   
>   I guess I have to merge AppArmor and SMACK just to get this *disease* off 
>   the table. You're acting like a string theorist, claiming that t here is 
>   no other viable theory out there. Stop it. It's been going on for too damn 
>   long.
>   
>   			Linus
>
> The situation with LKM-based LSMs is symmetry of that post.
> Those who are suspicious about supporting LKM-based LSMs is nothing but
>
>   "Presently, as all in-tree users are built-in, LSM does not need to support LKM-based LSMs."
>
> . That's "only LSM modules which are built into vmlinux are correct" crap.
>
>> On a less happy note, you haven't addressed security blobs in any way. You
>> need to provide a mechanism to allow an LSM to share security blobs with
>> builtin LSMs and other loadable LSMs.
> Not all LKM-based LSMs need to use security blobs.

If you only want to support "minor" LSMs, those that don't use shared blobs,
the loadable list implementation will suit you just fine. And because you won't
be using any of the LSM infrastructure that needs the LSM ID, that won't be
an issue.

You can make something that will work. Whether you can sell it upstream will
depend on any number of factors. But working code is always a great start.

>  What the LSM infrastructure
> needs to do is manage which callback is called (so that undo operation is possible
> when something went wrong while traversing the linked list). Everything else can
> be managed by individual LSM implementations.
>

