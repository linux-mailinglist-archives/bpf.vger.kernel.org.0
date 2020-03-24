Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5DA119163B
	for <lists+bpf@lfdr.de>; Tue, 24 Mar 2020 17:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgCXQZR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Mar 2020 12:25:17 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com ([66.163.190.38]:34862
        "EHLO sonic307-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727133AbgCXQZR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 24 Mar 2020 12:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1585067114; bh=qdPQEgSTQB41Bal6ymFUiR/BsK6X7afGzWcEaJLoHCY=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=nrHTJeUw0AQJBDhA1F1a2M42iVMAemcpoCTq6OpwjNMKZAJvYb6N6KE8AWUm/MFNzqaDyfWJ0W097z63vstr1w1Pc7WyT+KxiPiM1Wi0NXt8dWG8wVNBRJettuS8J/bpyMM9xGfvLznUp7SLgEvMmKrN+NuCkfAF2pKm1TEautJxXanejaGd0Icjn0Ipkuz6kYL0y5ruB2XuVtQbSVflqoCYYj+1BBgnC+tq2PX818qPLa6Xt9TGW3cEoQ60PvxJB5H/Jn3CHww3LLa8kKoc9mZ6NINuwwtR0FzOwuM7S2zTrUwaHTPOhWSdOfRej0JwcxkPs2hERhXOlmC95Ud8fQ==
X-YMail-OSG: a1IeX9YVM1k5ZVMlytpka2.8Ex8SmU8lyydh2RD0CIOBkOfNO8tY9VLbc_4QODi
 XDhkXsAoK4.EejkZ8diDK7m3tWOVksbgrJ9TuH3.sBFmX7SYdDdZWL9dTpdMhYBZozwIpgx0Dm0u
 bXAh62dwtHYYvkvq_j_GufNgbChLCmZku7XnNO5oigo6M0qjuvX.hQ1hqdjGQrEC43FBLsm_4oJ_
 KX9uD1c_lCrnfqyQnXRSIzFisO0gWDlVuUwvuekaRpT_pl.mQZXY_PuuG6kXo4hKvMVyi.tlOUGY
 qvks3SeAv3cN4.ApS_KKEE1LrTkCZsYOmyavG9d2odER0rIagWGzU0YtpwErBNF9XcmTHD5gA1gA
 dT_a009zSdKk7t_MtVVtWLmWtINBjg0BZ2Qnlbae70npY_.aveOjBdLF5HJbkw31T0qMnTKDzyUf
 k4AMdyZVyDoidRuhRpuFWKa_Urbizdg_RllQH69qLvneSnPBhgaffQgVvFVKt4iuzPjl2MsRW1q3
 hwDV4oVfdVhRCzOi2rWeMSNjqHA4IW1pakTCpWWpBF2PNQ2h6gxYefVkgwjSw9oPgYqtWWhiL9Mi
 wVJgOyGinnXf_0ZqwtDCZ1lcTCCsLMnIZLXlAIvbgMQVuoh6I5E0WzV14kPeGiSzIXzmvdm0Nx31
 wMuE8Dc3YoCjMwEmmAQoFEDwJtCbl7CqoFun_JKyRnbr2eoWsghsaM.UfzjxwmB0O_NQwO5w540w
 u05AJNuaBMik6M4E4ar48d3VfNgAFyFEZC8MWQ.yeDAw_Aa3s4dv_B_tDEqLdvg8vbVJzj_IDylg
 XmAjYg2LDWEBfRejjfJ_vKKCwVwTlU4wnsLTRnk8gVldwGH8RL4aUVMr5CQF8NTtEgsnI020MvWb
 6trj1o0Wl05ZxWoNebmdbljlT2jnesajGvKg0GZyYsduRIF3tf4q8J2ofslGYD2tqcs_cTsp4OyE
 93iMhHOhTeoUOWMXihhtS5ujGoF9j5AC0TcHxjVdAr7N.u74vfp.7D3_HzSGbaL9wN7JfZ968Xcn
 cITBwxO3YIy69nyA5nHKV3hbTtjiCLk1mx9ByAGmpOMH9a18igPTr8E3bcLZoMZwHuAbeg.fGg6K
 BPJBoBJS.HH2aExhy4jMPcdc_fLMaFsvMyRORq2UTvaPsj7PEg8HMcLHdbSf7_tRzSuBXsz1J.qG
 aYr12P__.tVkzG3ZqvPvqg70NIANQ1pgkmeFhIs4kC2Ttb5FOZekQGRM2kgOY1Tr2SgkG1MhgP0_
 AFbqzRbSO0RIv53colcD00OuDBM2vpN2mu3YDAL69TCzg70r_d2StLC4DWI0DiGupl.e4DijrNpM
 naSOoKCzsS3EATzp4_sR5W_NJ6DDlDK4R45pSXdUAdCuDab2dEDrj2OwkJER4CCg4Q4SOdIhrv.a
 5XskMx5hmi8DjC2mFnwD7sOUfcabwdhj6GZi3Zjcr1vYN
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Tue, 24 Mar 2020 16:25:14 +0000
Received: by smtp424.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 01ec4449a7fc946d45d56f2d212b357d;
          Tue, 24 Mar 2020 16:25:10 +0000 (UTC)
Subject: Re: [PATCH bpf-next v5 4/7] bpf: lsm: Implement attach, detach and
 execution
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-5-kpsingh@chromium.org>
 <CAEjxPJ4MukexdmAD=py0r7vkE6vnn6T1LVcybP_GSJYsAdRuxA@mail.gmail.com>
 <20200324145003.GA2685@chromium.org>
 <CAEjxPJ4YnCCeQUTK36Ao550AWProHrkrW1a6K5RKuKYcPcfhyA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <d578d19f-1d3b-f60d-f803-2fcb46721a4a@schaufler-ca.com>
Date:   Tue, 24 Mar 2020 09:25:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ4YnCCeQUTK36Ao550AWProHrkrW1a6K5RKuKYcPcfhyA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15518 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_242)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/24/2020 7:58 AM, Stephen Smalley wrote:
> On Tue, Mar 24, 2020 at 10:50 AM KP Singh <kpsingh@chromium.org> wrote:=

>> On 24-M=C3=A4r 10:35, Stephen Smalley wrote:
>>> On Mon, Mar 23, 2020 at 12:46 PM KP Singh <kpsingh@chromium.org> wrot=
e:
>>>> From: KP Singh <kpsingh@google.com>
>>>> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
>>>> index 530d137f7a84..2a8131b640b8 100644
>>>> --- a/kernel/bpf/bpf_lsm.c
>>>> +++ b/kernel/bpf/bpf_lsm.c
>>>> @@ -9,6 +9,9 @@
>>>>  #include <linux/btf.h>
>>>>  #include <linux/lsm_hooks.h>
>>>>  #include <linux/bpf_lsm.h>
>>>> +#include <linux/jump_label.h>
>>>> +#include <linux/kallsyms.h>
>>>> +#include <linux/bpf_verifier.h>
>>>>
>>>>  /* For every LSM hook  that allows attachment of BPF programs, decl=
are a NOP
>>>>   * function where a BPF program can be attached as an fexit trampol=
ine.
>>>> @@ -27,6 +30,32 @@ noinline __weak void bpf_lsm_##NAME(__VA_ARGS__) =
{}
>>>>  #include <linux/lsm_hook_names.h>
>>>>  #undef LSM_HOOK
>>>>
>>>> +#define BPF_LSM_SYM_PREFX  "bpf_lsm_"
>>>> +
>>>> +int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
>>>> +                       const struct bpf_prog *prog)
>>>> +{
>>>> +       /* Only CAP_MAC_ADMIN users are allowed to make changes to L=
SM hooks
>>>> +        */
>>>> +       if (!capable(CAP_MAC_ADMIN))
>>>> +               return -EPERM;
>>> I had asked before, and will ask again: please provide an explicit LS=
M
>>> hook for mediating whether one can make changes to the LSM hooks.
>>> Neither CAP_MAC_ADMIN nor CAP_SYS_ADMIN suffices to check this for SE=
Linux.
>> What do you think about:
>>
>>   int security_check_mutable_hooks(void)
>>
>> Do you have any suggestions on the signature of this hook? Does this
>> hook need to be BPF specific?
> I'd do something like int security_bpf_prog_attach_security(const
> struct bpf_prog *prog) or similar.
> Then the security module can do a check based on the current task
> and/or the prog.  We already have some bpf-specific hooks.

I *strongly* disagree with Stephen on this. KRSI and SELinux are peers.
Just as Yama policy is independent of SELinux policy so KRSI policy shoul=
d
be independent of SELinux policy. I understand the argument that BDF prog=
rams
ought to be constrained by SELinux, but I don't think it's right. Further=
,
we've got unholy layering when security modules call security_ functions.=

I'm not saying there is no case where it would be appropriate, but this i=
s not
one of them.


