Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8563C195B36
	for <lists+bpf@lfdr.de>; Fri, 27 Mar 2020 17:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgC0QgZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Mar 2020 12:36:25 -0400
Received: from sonic313-14.consmr.mail.ne1.yahoo.com ([66.163.185.37]:33763
        "EHLO sonic313-14.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727740AbgC0QgY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 27 Mar 2020 12:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1585326983; bh=oU5zcAPB2SkuXW2hCS2U3NXubF8yFf0U9e5WSRAAonM=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=T2g7taMqkgEX/XrGV+/k5vCiB4u0+wR+nSpe7/DT1aqiK3/ammePovKmefnlxGoDHqQh7ljohWcce4YRlSmU7floxLE69njFk8Kjla3e/mz2npUXS5YwgHJ4Idq0tCXyRs7tXblKH1sPR+3qae7M0skwS6xp27Wj1eizUnBV6d8HfXodgpmOA9zM0IgMMQgqB9eW68YqEXKFFvnd3zlDmkee/60TarIqQoN31rwwA6QDo2N3/Dc64BAzEZOlzvEWTGKjXKebO3JiXOyU3PmNGbJuCfmbtPFYXbaLXpcnmdu0StA6pZOIRJUltO/qnALUtIQ84J+ahb8QLv/5xOAXuw==
X-YMail-OSG: HJWjnLUVM1ldViaQGmxzRshWcb6C0woOXnGj.PHbvlykCz5DiCeCp2ObNGOXEWg
 5xMSAUswTTD6TwPwCp7HaDy8cSAQX01_2pWosX_7KFicE24AYNTsxCPg7AYZHxTOM1BjRMT11ABQ
 GcaA_Mnzt5Vblg70_sml3bEKjH_2ERAplQRwxnhD_PCmiEBNgq0uwKrErZ3WlzE1h0jqrv5c9BdN
 Q0f2JzTC9hNPjJ8iU561W.mt1WlHx8GQ_E1tL_7KMXiJouEMNXjcbQwjFHEOmUa8MOICeGTtptyg
 MXS3brVKe8c4lwt5vr60ZcfieU0skZGjUnzxrBHG9qYWFd3u2Y5hZ7..ok0Xmkef3MoqBZSboUUf
 JjiByeKPwDk1cvi81EgXvqNZQI4q6UO5w55ehp2WzwHyXItlykooAoLPQrD5MbLwygrQzPOjS1gV
 YUG6u0UCsQfckUsUSzEcGYxWXvi1F1ZchT8FGe.KEhcZihmhRgZgpP.WEH6K5_23I2RMTq6jrsCA
 3dAUGwc6h9rVHrA.R.5vNTeTeqqFTzf2lCIUvoVDtrvIiFCzKMQFkC9N8apFoEhH3k85golfmIby
 pzpgbicfeD_6pAU5miS4GzJNk6Thkz3oWuZYI8moeDWM258TxuIeT.8CUAITGhIXtBPxJ7jQbqrw
 GDxhMW5yyc_XtJvu1W3EHaFTw4Jj6pClmMAvNRvgyisgh9Tbb_kVsFsW9yg0r1i3tLrjEYHbWoUH
 dwVxNkaNSlICgZvTN77MUKaTj24W7iJEvu9p2FfncieDdUfKTfmvi0tk9ut1_t69EVYnvK2Ndbx_
 eiUEvMt72ymFfPokF4h0mi76Xuc00ELrC9qkVOPk4okLkV55e3WxlCCtLFG681cbCN0sqjyUW04G
 FYdJnoYlA4sWji37O_5TmG_fIUAmbku_rB8JD2dsRvNmo_HgCdh9F9dlWko4YDwJrzXnpSMCOnY9
 hZY2nMo0Hf_QTaKUFZVMBMoxfl3aNU58lsKe3abQkXIPmHFKLRQ9Xdn724NyIwsUOUx.32Y8bLu3
 gAgBgYPw79Vjj3XVIe9EBhhPVwY2S12u8rHI5.dC7k.7GmM2ma2rFQBFe7YcHLlg0G5PX3qClarW
 iUg2X6PkI8JLmZHpEmmllK0pbkR7jU2v30eRuOKuhPhKjTYiyWH4cOT2rbfoRlXFJQs2T30p1da5
 9WnmVkxvqoJUrFAQvALP48TpCK3iYwAeqnLP717QJ__wvB37A0AbbuxCckQL7wxJJ7lNyl7RHatX
 ceYiFoUQG74cZKNkEs28ZJGMA9.b46QkJ.4GZXeyAqZkHRH7ZYHtd9tozFFKI08dch_BRnM7c2El
 isMalkviuhBDBtFAVa_3zTC4eb.mU4P3b9NyQJKaAtMi1w8kXgO6zp9xp97IuEwh6ztRFuDRMj16
 qM2fzCO5gx_IKHOxrIp3zoLkN.1ANYyK9xl7HH08msL_0rieLioYUeik_c3Audvw.g9Ta33O8pg1
 TVqx5zoZlJ3FUVA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Fri, 27 Mar 2020 16:36:23 +0000
Received: by smtp417.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 1f531044ee13811a271dc4f05871c6be;
          Fri, 27 Mar 2020 16:36:17 +0000 (UTC)
Subject: Re: [PATCH bpf-next v7 4/8] bpf: lsm: Implement attach, detach and
 execution
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        KP Singh <kpsingh@chromium.org>
Cc:     James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200326142823.26277-1-kpsingh@chromium.org>
 <20200326142823.26277-5-kpsingh@chromium.org>
 <alpine.LRH.2.21.2003271119420.17089@namei.org>
 <2241c806-65c9-68f5-f822-9a245ecf7ba0@tycho.nsa.gov>
 <20200327124115.GA8318@chromium.org>
 <14ff822f-3ca5-7ebb-3df6-dd02249169d2@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <a3f6d9f8-6425-af28-d472-fad642439b69@schaufler-ca.com>
Date:   Fri, 27 Mar 2020 09:36:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <14ff822f-3ca5-7ebb-3df6-dd02249169d2@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.15518 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_242)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/27/2020 6:43 AM, Stephen Smalley wrote:
> On 3/27/20 8:41 AM, KP Singh wrote:
>> On 27-Mär 08:27, Stephen Smalley wrote:
>>> On 3/26/20 8:24 PM, James Morris wrote:
>>>> On Thu, 26 Mar 2020, KP Singh wrote:
>>>>
>>>>> +int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
>>>>> +            const struct bpf_prog *prog)
>>>>> +{
>>>>> +    /* Only CAP_MAC_ADMIN users are allowed to make changes to LSM hooks
>>>>> +     */
>>>>> +    if (!capable(CAP_MAC_ADMIN))
>>>>> +        return -EPERM;
>>>>> +
>>>>
>>>> Stephen, can you confirm that your concerns around this are resolved
>>>> (IIRC, by SELinux implementing a bpf_prog callback) ?
>>>
>>> I guess the only residual concern I have is that CAP_MAC_ADMIN means
>>> something different to SELinux (ability to get/set file security contexts
>>> unknown to the currently loaded policy), so leaving the CAP_MAC_ADMIN check
>>> here (versus calling a new security hook here and checking CAP_MAC_ADMIN in
>>> the implementation of that hook for the modules that want that) conflates
>>> two very different things.  Prior to this patch, there are no users of
>>> CAP_MAC_ADMIN outside of individual security modules; it is only checked in
>>> module-specific logic within apparmor, safesetid, selinux, and smack, so the
>>> meaning was module-specific.
>>
>> As we had discussed, We do have a security hook as well:
>>
>> https://lore.kernel.org/bpf/20200324180652.GA11855@chromium.org/
>>
>> The bpf_prog hook which can check for BPF_PROG_TYPE_LSM and implement
>> module specific logic for LSM programs. I thougt that was okay?
>>
>> Kees was in favor of keeping the CAP_MAC_ADMIN check here:
>>
>> https://lore.kernel.org/bpf/202003241133.16C02BE5B@keescook
>>
>> If you feel strongly and Kees agrees, we can remove the CAP_MAC_ADMIN
>> check here, but given that we already have a security hook that meets
>> the requirements, we probably don't need another one.
>
> I would favor removing the CAP_MAC_ADMIN check here, and implementing it in a bpf_prog hook for Smack and AppArmor if they want that.  SELinux would implement its own check in its existing bpf_prog hook.
>
The whole notion of one security module calling into another for permission
to do something still gives me the heebee jeebees, but if more nimble minds
than mine think this is a good idea I won't nack it.

