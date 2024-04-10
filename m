Return-Path: <bpf+bounces-26410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DCF89F248
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 14:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 412E5B245B1
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 12:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31527129E6E;
	Wed, 10 Apr 2024 12:31:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AC317580;
	Wed, 10 Apr 2024 12:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712752260; cv=none; b=pGDgCP3NdADuTdBnJKZdHW9/6T/TgaJImDXn8eq5yrG8M8PAtsZCX1Q7GfgwDNLFi9ZTUgouVj21J6UcuwHsiq6I8fwOUcJz//af1RyonFMgdA6stzlxqdwt6K37CG+8lsrIQciXA49/ZeuaX0o3fdYxmkNSL/LdL6SWi7wzy1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712752260; c=relaxed/simple;
	bh=NoX58lyCjGsmci7Va03F0GXqr6dwr4pDKxHvTtYW/TU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cc+nLWEZuN498wcSptlTbpa4K0CHbCP4Jwp7o3YOB1v53DD6BSmBbZj3W95LLOaB2uVBmMr6B3snEgvsHdOZ/0afx5muc8ohPYjFLXYls0e7dKDM6rivom9rg2KLLOkfZfyxllou+6Qs/K1+DhrR7eF0mnvkaujaiCSC940mab4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VF2HF2y9Tz4f3jpq;
	Wed, 10 Apr 2024 20:30:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id CB6FD1A0D42;
	Wed, 10 Apr 2024 20:30:53 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP3 (Coremail) with SMTP id _Ch0CgDn9Jx8hhZm_YfiJQ--.22639S2;
	Wed, 10 Apr 2024 20:30:53 +0800 (CST)
Message-ID: <ad8fa463-cf58-4c00-b1c7-094fd6a7769a@huaweicloud.com>
Date: Wed, 10 Apr 2024 20:30:52 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/7] bpf, lsm: Add return value range
 description for lsm hook
Content-Language: en-US
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Florent Revest <revest@chromium.org>,
 Brendan Jackman <jackmanb@chromium.org>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>,
 Khadija Kamran <kamrankhadijadj@gmail.com>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, Kees Cook <keescook@chromium.org>,
 John Johansen <john.johansen@canonical.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Shung-Hsi Yu <shung-hsi.yu@suse.com>
References: <20240325095653.1720123-1-xukuohai@huaweicloud.com>
 <20240325095653.1720123-3-xukuohai@huaweicloud.com>
 <7FAC6C1E-B0C2-4743-AFF0-0DCC2B331D0A@kernel.org>
 <CACYkzJ5wExNrQYKckVrnbFbFXP8S6oWqG8GU8iaMJTMNbFTDSg@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <CACYkzJ5wExNrQYKckVrnbFbFXP8S6oWqG8GU8iaMJTMNbFTDSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDn9Jx8hhZm_YfiJQ--.22639S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF15Kry7ur4UJFW8uF1kGrg_yoW8tF4fpr
	45tFyDJrn7Ja429Fn2q3WxWF4Ik3yfWrW7KrsIvryDCF98JFnxKwsa9rW0kr18Ar1rG340
	qwnrZrsxAw1DC37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFYFCUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 4/9/2024 6:15 AM, KP Singh wrote:
> On Mon, Apr 8, 2024 at 7:09 PM KP Singh <kpsingh@kernel.org> wrote:
>>
>>
>>
>>> On 25 Mar 2024, at 10:56, Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>>
>>> From: Xu Kuohai <xukuohai@huawei.com>
>>>
>>> Add return value descriptions for lsm hook.
>>>
>>> Two integer ranges are added:
>>>
>>> 1. ERRNO: Integer between -MAX_ERRNO and 0, including -MAX_ERRNO and 0.
> 
> I also don't really like these special macros that imply a range. Why
> not do something like?
> 
>    LSM_RET_INT(default, min, max)
>

This also looks good to me, will update in next version.

> You seemed to have missed the values returned by these hooks:
> 
> security_inode_need_killpriv
> security_inode_getsecurity
> security_inode_listsecurity
> security_inode_copy_up_xattr
> security_task_prctl
> 
> security_getprocattr
> securitty_setprocattr
> ^^these two we should just disable in BPF LSM
> 
> security_ismaclabel
> ^^probably even this
>

Good catch! I've fixed the return value ranges based on the return value
description in file security/security.c.

Here are the fixed functions and their return ranges.

security_inode_need_killpriv			[-MAX_ERRNO, INT_MAX]
security_inode_getsecurity			[-MAX_ERRNO, INT_MAX]
security_inode_listsecurity			[-MAX_ERRNO, INT_MAX]
security_inode_copy_up_xattr			[-MAX_ERRNO, 1]
security_getselfattr				[-MAX_ERRNO, INT_MAX]
security_getprocattr				[-MAX_ERRNO, INT_MAX]
security_setprocattr				[-MAX_ERRNO, INT_MAX]
security_task_prctl				[-MAX_ERRNO, INT_MAX]
security_ismaclabel				[0, 1]
security_xfrm_state_pol_flow_match		[INT_MIN, INT_MAX]
security_key_getsecurity			[-MAX_ERRNO, INT_MAX]
security_audit_rule_known			[0, 1]
security_audit_rule_match			[-MAX_ERRNO, 1]

> There seem to be only a handful of these. Can we just manage it with a
> BTF set on the BPF side?
> 

I'll add a disabled bpf lsm hook list on the bpf side.

> - KP
>>> 2. ANY: Any integer
>>
>>
>> I think you should merge this patch and the first patch. It's not clear that the first value in this macro is actually used as the default value until one reads the code. I think you also need to make it clear that there is no logical change on the LSM side in the this patch.

OK.

>>
>> - KP


