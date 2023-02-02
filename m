Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976D7688A83
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 00:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbjBBXLT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 18:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjBBXLS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 18:11:18 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C957E6C3;
        Thu,  2 Feb 2023 15:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=VAk2iSonWR2CNUR3YDs4R251h30dkaNOFz6qNY0ijSM=; b=SPGvTtegRKMQ50FQT1ai1VSmj4
        qB6HhcHC1srkWgp1Tx0KWYZmDAbLU/J3V6UIDmvukssZYCnGrmo2U96z6+H+gmQjaqEZhXFYINitn
        weNCCrv1l5Lm5uRLHRBSfKJxgM1H04Qs1A8/IGIIVjr68kAFur2YqGN2gDm+bTmNwwhdF6yPebdZR
        FMsKfApNBzOP+m/ILOEUzzbGRLeaNyxNeH2j91m1faCiKgpdPeXy7vrPau1fXzSiL4+VlnaZAiszM
        2bkG5LL1bP+aFYd2e0y6G0b8AlzgkDu4mb4IO4bH4DsAItDgMYSjDGjQOFWb3ZeQY9BdBB/cXo4VI
        rzmwd1Tg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pNijZ-000CDg-On; Fri, 03 Feb 2023 00:11:13 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pNijZ-0006nR-68; Fri, 03 Feb 2023 00:11:13 +0100
Subject: Re: [PATCH bpf-next 2/3] bpf: Add KF_DEPRECATED kfunc flag
To:     David Vernet <void@manifault.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@meta.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20230202163056.658641-1-void@manifault.com>
 <20230202163056.658641-3-void@manifault.com>
 <CAADnVQJjmnEpXWL8-SAPt5zYXnFYeF8-wXXpA9shOhqUXNPw=g@mail.gmail.com>
 <Y9wq1Fy8sgpGB+pe@maniforge>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <1ea9adb3-851c-0c04-1655-07d9f3b7f3b0@iogearbox.net>
Date:   Fri, 3 Feb 2023 00:11:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <Y9wq1Fy8sgpGB+pe@maniforge>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26800/Thu Feb  2 09:47:56 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/2/23 10:27 PM, David Vernet wrote:
> On Thu, Feb 02, 2023 at 01:21:19PM -0800, Alexei Starovoitov wrote:
>> On Thu, Feb 2, 2023 at 8:31 AM David Vernet <void@manifault.com> wrote:
>>>
>>> Now that we have our kfunc lifecycle expectations clearly documented,
>>> and that KF_DEPRECATED is documented as an optional method for kfunc
>>> developers and maintainers to provide a deprecation story to BPF users,
>>> we need to actually implement the flag.
>>>
>>> This patch adds KF_DEPRECATED, and updates the verifier to issue a
>>> verifier log message if a deprecated kfunc is called. Currently, a BPF
>>> program either has to fail to verify, or be loaded with log level 2 in
>>> order to see the message. We could eventually enhance this to always
>>> be logged regardless of log level or verification status, or we could
>>> instead emit a warning to dmesg. This seems like the least controversial
>>> option for now.
>>>
>>> A subsequent patch will add a selftest that verifies this behavior.
>>>
>>> Signed-off-by: David Vernet <void@manifault.com>
>>> ---
>>>   include/linux/btf.h   | 1 +
>>>   kernel/bpf/verifier.c | 8 ++++++++
>>>   2 files changed, 9 insertions(+)
>>>
>>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>>> index 49e0fe6d8274..a0ea788ee9b0 100644
>>> --- a/include/linux/btf.h
>>> +++ b/include/linux/btf.h
>>> @@ -71,6 +71,7 @@
>>>   #define KF_SLEEPABLE    (1 << 5) /* kfunc may sleep */
>>>   #define KF_DESTRUCTIVE  (1 << 6) /* kfunc performs destructive actions */
>>>   #define KF_RCU          (1 << 7) /* kfunc only takes rcu pointer arguments */
>>> +#define KF_DEPRECATED   (1 << 8) /* kfunc is slated to be removed or deprecated */
>>>
>>>   /*
>>>    * Tag marking a kernel function as a kfunc. This is meant to minimize the
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index 4cc0e70ee71e..22adcf24f9e1 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -8511,6 +8511,11 @@ static bool is_kfunc_rcu(struct bpf_kfunc_call_arg_meta *meta)
>>>          return meta->kfunc_flags & KF_RCU;
>>>   }
>>>
>>> +static bool is_kfunc_deprecated(const struct bpf_kfunc_call_arg_meta *meta)
>>> +{
>>> +       return meta->kfunc_flags & KF_DEPRECATED;
>>> +}
>>> +
>>>   static bool is_kfunc_arg_kptr_get(struct bpf_kfunc_call_arg_meta *meta, int arg)
>>>   {
>>>          return arg == 0 && (meta->kfunc_flags & KF_KPTR_GET);
>>> @@ -9646,6 +9651,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>>                          mark_btf_func_reg_size(env, regno, t->size);
>>>          }
>>>
>>> +       if (is_kfunc_deprecated(&meta))
>>> +               verbose(env, "calling deprecated kfunc %s\n", func_name);
>>> +
>>
>> Since prog will successfully load, no one will notice this message.
>>
>> I think we can skip patches 2 and 3 for now.

+1, the KF_DEPRECATED could probably for the time being just mentioned
in doc.

> I can leave them out of the v2 version of the patch set, but the reason
> I included them here is because I thought it would be odd to document
> KF_DEPRECATED without actually upstreaming it. Agreed that it is
> essentially 0 signal in its current form. Hopefully it could be expanded
> soon to be louder and more noticeable by not relying on the env log,
> which is wiped if the verifier passes, but that's separate from whether
> KF_DEPRECATED in general is the API that we want to provide kfunc
> developers (in which case at least 2 and 3 would add that in a
> non-controversial form).

This ideally needs some form of prog load flag which would error upon
use of kfuncs with deprecation tag, such that tools probing kernel for
feature availability can notice.
