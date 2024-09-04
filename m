Return-Path: <bpf+bounces-38856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A9396AD83
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 02:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 947DA1F2594A
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 00:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2E41EC00B;
	Wed,  4 Sep 2024 00:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DucihuOh"
X-Original-To: bpf@vger.kernel.org
Received: from sonic310-31.consmr.mail.ne1.yahoo.com (sonic310-31.consmr.mail.ne1.yahoo.com [66.163.186.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF23E804
	for <bpf@vger.kernel.org>; Wed,  4 Sep 2024 00:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725411208; cv=none; b=jPDra9rYor7vabZsDCu/jZRvwFEdwfrbPetvFFhDxgo5tRTn3NyJO4Sv+a4BncIe9IKEov7wisC2zGYNex+xOiTjLfUOfw2QM9dNgPpmXFcADJxufKe3zZt+EaInlybMsxFB3BaIJvKtvQPAuDta+jHxxSgwaOwpjN6nGaOztoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725411208; c=relaxed/simple;
	bh=PICU/c4IzyFbj5kShebHmcrkZo8eNAWBTOUHveubbI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NnZi7mCJ+qO0hz5ljKmFqsGrp4qNadVcE06CIKsxQ+2VfV4EbSanka2B2zzsNVUWhP/CpNtsVSxnPhAlD6PKyogi3HOozagMQuGjTOvHyn5DuUAhb1AT/xN5Ilx+XQqdLV1ILGMZevSdSAqjGfZ8QXmysB7ZuPPF9jNytiCUGzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=DucihuOh; arc=none smtp.client-ip=66.163.186.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725411199; bh=cJEmUh/NbvsOKNf1MEOgEwDsYaVPBLk5V1GXeWksbcI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=DucihuOhzDv+8iuDi7ZQeMbDYX4YQBT2XKS3nny5/xuz54OyMBNpbVNe8HY9bb7LfdFCW6j8vL2bV0iQ4XcXNZTfoAddCuyCoEbVts+lgBVmA1YwF2GAeywzmxHgtOtqAdbaAoyHZHlu3mCLC9Kpal7VvhPYxxxGLr8g9T1p3lA+9Xrp/5b50cuB7YhM0+i1RpsvCfffORT896MqR96MsLuktiDdQvH0NZuZ6YNNBCOBJgra/QRFRZpX/w/HD4UXS3b1YjP47wl6Pq4E4K65p1B6ONWSaRN8b1hO9UO7sB9e8itiY54o2c0Znfsx3Puw6Eff5E8PTgwSkcxar/4SYg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725411199; bh=UAq6MNu4Ra62a0AA66ys+4LWE1FM3YUGCwQq7bovjei=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=TUUBGnsat4f+qZwlq/a92qrjUq+QODMGcK+jxcE6Skx9DeWmR80EdgVPuhK3C+ePe9nM1SrUtXYpjpWVqNwNYRfaZNXzXQVxhnJc14KpLJI3x4VqaJWaE28oDyYiWr3fSM0JS+Fs+Vq2SIDQQ4cdZmxMLQDCTjX/Fgyt+WfgGPL1hCaUPYTIGqUGCHATqY8p5MlhG+eLVpgo77paZv2ZKPUz92k1cJhxBnnya5hLmnIfpbrYP5oTgJIqj2lCFn5JQXWVMGbnkvUNram8V0gGaMCH1X2YCWw7CB3Cy6o3mqO7U9X3shlybaih/hTh/vRdcDVltYhPR8Bqjk8sdf9rRA==
X-YMail-OSG: zTBjjQ8VM1nuq9mM9y5d2bPogM7qTRfA.ojLrRY0Z2GGZ5KVv95rImdCAbyUcRK
 EHPp5OICSdJ4KbE12c93_rgVTjiXOm83AnUL.aDMNZxBRd1JxMoasyjAUtGSc9zK99.t5ldpd8UO
 _cwASC27NkmBtsTg.7Z0oHvW9TikJKhTvRVbhK7A8bFJ6t_vLxqyDnjVqNbZESInNWQJVLRzNoEu
 O72lUkEtTYY.kwu1PcjgP5qVu5lnfpywmaGTtzN6aIhcwKfnz27AuheE5o9e_Dwj.79AkR6JzLGD
 KKvOfbfqJkIX5.1oeMjaGo33clSuMGKULc_3BGwKoNTrnCdLB2nsE0WU9sWM0flx988qkpzFakjM
 xaqDWJv_0HV_pp6ikZReRmglf0XeY_aBinat698e20_PkhU5F26mxshq6aSDI.qCPd62q.U3xSDS
 0INwM2XkpLS782RYiJfsHR6kZMBLBSQQO90GZNTQh2ptStPtq9Kqm82eFcX757tqA9oB.7iRBSoK
 pE3sL9d7vPXrdwscltlFnf.s44FbNGLg2BiMRlwe42ihVwTcqmQWX6G0Vzt6IrBsfjl2pwPZxJo9
 .HU5TuEZqHcrCfMRZJrLXVSSyzU6yj4h675uFQgJ6juOrhI7b.AlNueJgTj8pjCRn1Cbv6ofOsVj
 cko6w0XoflyLB9osLliHwA_C83FMUl0fGwS9Lbke6mWYIrtogtjkEmg14EDNS9W5ftDyu_PE6ajZ
 Ut78OtsMKx6Z3.o.HkADCHv5aOKR4zfFQxB0QRC8AOrgClo1Wv3tc5Ghx0p.aaZXkUvu7fld5ml7
 rDew.pkhZT8aJpPLEgbkEzmANp4.ht57FhxSZPZ90LCHlvynAqqD.zNx2qWQ9ZY9UQGT1uFH7zcT
 JLOQ.mHudCqglegb2Ei2Dj9AGxLcCNPUovPnbYNij7Kmqo9BZ9ptKJdX1iW7uDMXHnEwqIFMjEKC
 6tOScd2oesfq9P.QyV4nng34epW3Rp4lhD.7n5_EZMGL_cqgDCVChZ.9CqFccnNjcVXFjV2IvnI2
 OA7DSra0Z2nWUKRJjS88ViiKcOuENnE7CsIYSEH7masH3fug.yoaZvEfMYMg54EDVWAB0lwhwQPh
 KxPhrHW0uOuQbVbLhn9S97UyKzXqTuC8VafOUCRslmsl_uBJ.TSUUV5nT6TUHiwVgDCIDKHdd4YQ
 cr7K2sCICmoj8ZK_B6PyUhZ4XEnDHWyNM1sAEiiqt3muZ1VCUp3.eTdn5Em56gfC6D1Ofuu1zFK1
 WR0RxsToCC2UAyobSt89jdYR2N8.jaICHkvRRWznnER2iQd.LztuoX55nqKXI6S0Ce7dcMsJ_PCk
 N2fo2qKHWDif7wY0vVAPtat0UyomqWVFQ0gs0F4G..tzHTklOxcHk0ZK.pnWp_6CNPcXM_cmpn__
 lH6K8jIaME8OblvcYKoHs9Dl.BcDBKjetQjN4Ta0LObfWpSIlF.rQF5cbIJzcBuLDlKMf5rLAB2a
 KHEQOb4a3IsSNopLVaO14MQvB2v3.e4jM_fZui6OcFhiNsCDiTmVvmd5ea_a.WrMOs_7liKGoZke
 pLrw3FYyGKVAvaTy0fGHywkxBjkT9MYnhBPHs1h5udr3SrKZqaL4qnu8FKGxxiZBgVkAcX8NDcJi
 e__E4W6VfMZnt9RBTwj3oURfl4j6H.GySoUJMmMUFGwORBNMAh313BLpuHWqK4pEdgaBM_LXeJbT
 Uh0EO7AmL0drqOqloTXLBbQBVoru5pKuqimsO0FUAPfxLaXpcPb6bR0kZuZ5jRp4qCS08bpxOYkq
 p.iXc.ulxP1xlWkCQB3gpgT1Ng_qy6yYCoLCSTMxcV3bXABQB50wH1a3b5MMXs2y5FD68vgLlgoa
 wg7kKFJE3fkGzEicyTeftXEun5XGLpDsSS_lxFTez6I3UXMKXTgBO9Gn7O4OrrLNRVcyOGStshuR
 5oTL0BDmsWDNZ0OO99YO4w5vYRjezizZ5sbXaac7ip6rqvw.V23Qz7UJ99wlbGjRjpoqJ8D8bVYD
 sDsmDWZgRTz4HXJySouAzcwUDGj39w__pFKkDY4km1DFqsgadt1xfjOdjgtWwXa35WBjpfzlfRU4
 ufDLstxdb8uAgiY7URWoMHKh18AppX7eLJoypFBKwYQ6c8n8LQKNkfAPXLYGXUlQi3nwOoPNRFmW
 4T02Z2nD4.wtIrWHxGZwSilm_FeC.HTAsvegJJ4ntbUTTi2iLQGP4ZNAge1Xj5ev2SjNxnOYDX_F
 jW8an43vQ5KbopaNjcjiLFbPOamdI4zz8q.eS2dQ2QOy0K2zjmqb3WPgmaAuYGmKVjcFX4ITCWot
 MgXj0kTrHVtdW_K2PqjteyFXhDju.sydo
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 674286a3-8968-4a56-b0e8-2745b80b1b69
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 4 Sep 2024 00:53:19 +0000
Received: by hermes--production-gq1-5d95dc458-sd55t (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 038bc3b4eb896bb153065162065cdc85;
          Wed, 04 Sep 2024 00:53:15 +0000 (UTC)
Message-ID: <b444ffb9-3ea3-4ef4-b53c-954ea66f7037@schaufler-ca.com>
Date: Tue, 3 Sep 2024 17:53:13 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/13] LSM: Add the lsmblob data structure.
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
 stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
 selinux@vger.kernel.org, mic@digikod.net, apparmor@lists.ubuntu.com,
 bpf@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20240830003411.16818-2-casey@schaufler-ca.com>
 <0a6ba6a6dbd423b56801b84b01fa8c41@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <0a6ba6a6dbd423b56801b84b01fa8c41@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 9/3/2024 5:18 PM, Paul Moore wrote:
> On Aug 29, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
>> When more than one security module is exporting data to audit and
>> networking sub-systems a single 32 bit integer is no longer
>> sufficient to represent the data. Add a structure to be used instead.
>>
>> The lsmblob structure definition is intended to keep the LSM
>> specific information private to the individual security modules.
>> The module specific information is included in a new set of
>> header files under include/lsm. Each security module is allowed
>> to define the information included for its use in the lsmblob.
>> SELinux includes a u32 secid. Smack includes a pointer into its
>> global label list. The conditional compilation based on feature
>> inclusion is contained in the include/lsm files.
>>
>> Suggested-by: Paul Moore <paul@paul-moore.com>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> Cc: apparmor@lists.ubuntu.com
>> Cc: bpf@vger.kernel.org
>> Cc: selinux@vger.kernel.org
>> Cc: linux-security-module@vger.kernel.org
>> ---
>>  include/linux/lsm/apparmor.h | 17 +++++++++++++++++
>>  include/linux/lsm/bpf.h      | 16 ++++++++++++++++
>>  include/linux/lsm/selinux.h  | 16 ++++++++++++++++
>>  include/linux/lsm/smack.h    | 17 +++++++++++++++++
>>  include/linux/security.h     | 20 ++++++++++++++++++++
>>  5 files changed, 86 insertions(+)
>>  create mode 100644 include/linux/lsm/apparmor.h
>>  create mode 100644 include/linux/lsm/bpf.h
>>  create mode 100644 include/linux/lsm/selinux.h
>>  create mode 100644 include/linux/lsm/smack.h
> ..
>
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index 1390f1efb4f0..0057a22137e8 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -34,6 +34,10 @@
>>  #include <linux/sockptr.h>
>>  #include <linux/bpf.h>
>>  #include <uapi/linux/lsm.h>
>> +#include <linux/lsm/selinux.h>
>> +#include <linux/lsm/smack.h>
>> +#include <linux/lsm/apparmor.h>
>> +#include <linux/lsm/bpf.h>
>>  
>>  struct linux_binprm;
>>  struct cred;
>> @@ -140,6 +144,22 @@ enum lockdown_reason {
>>  	LOCKDOWN_CONFIDENTIALITY_MAX,
>>  };
>>  
>> +/* scaffolding */
>> +struct lsmblob_scaffold {
>> +	u32 secid;
>> +};
>> +
>> +/*
>> + * Data exported by the security modules
>> + */
>> +struct lsmblob {
>> +	struct lsmblob_selinux selinux;
>> +	struct lsmblob_smack smack;
>> +	struct lsmblob_apparmor apparmor;
>> +	struct lsmblob_bpf bpf;
>> +	struct lsmblob_scaffold scaffold;
>> +};
> Warning, top shelf bikeshedding follows ...

Not unexpected. :)

> I believe that historically when we've talked about the "LSM blob" we've
> usually been referring to the opaque buffers used to store LSM state that
> we attach to a number of kernel structs using the `void *security` field.
>
> At least that is what I think of when I read "struct lsmblob", and I'd
> like to get ahead of the potential confusion while we still can.
>
> Casey, I'm sure you're priority is simply getting this merged and you
> likely care very little about the name (as long as it isn't too horrible),

I would reject lsmlatefordinner out of hand.

> but what about "lsm_ref"?  Other ideas are most definitely welcome.

I'm not a fan of the underscore, and ref seems to imply memory management.
How about "struct lsmsecid", which is a nod to the past "u32 secid"?
Or, "struct lsmdata", "struct lsmid", "struct lsmattr".
I could live with "struct lsmref", I suppose, although it pulls me toward
"struct lsmreference", which is a bit long.

> I'm not going to comment on all the other related occurrences in the
> patchset, but all the "XXX_lsmblob_XXX" functions should be adjusted based
> on what we name the struct, e.g. "XXX_lsmref_XXX".
>
> --
> paul-moore.com
>

