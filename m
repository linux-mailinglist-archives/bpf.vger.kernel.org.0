Return-Path: <bpf+bounces-34263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CC192C1FB
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 19:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B48B1C22D77
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 17:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26E018784A;
	Tue,  9 Jul 2024 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="AGZhYBAf"
X-Original-To: bpf@vger.kernel.org
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED77C185636
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720544014; cv=none; b=rE05tr/hjPpm9wS26S2xHABMbSUiEqKSSVMm/5mpdLzhRvMXGQKtissAi4GV31HIa3u8ZIASId1YgL0zyvrUEat460i7U3CW88w/BlLZv+W5sJjc4h/L/tKy+2/dqeXEJH9NaL695H0Nx5LpITukReJHckTqLslijEQTDH5HsRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720544014; c=relaxed/simple;
	bh=vV2q/M9xg7rhVC0frNHaFrSjD0knRTYv4BY6k3F6mdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oVmkMjh1JYr1wbQ6qwrVxtdZvsLipcJltR7s18EGvryD9KDlIVb8qMYnGLNCgXItGqrPaO0PvmTURzKgbXaIdESa5wIcmDV4iGdROzWcWDu0XjLvbsWPVW/Cu0DkfjSK4FVVc1hPkhTmqSlb4C4/bBA+wRv+143mRiIdwq990l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=AGZhYBAf; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720544010; bh=leZH3b5F6yUi07zOUNc5L0Z8Iq3rSUIRy3dFmRObZn8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=AGZhYBAfcnw5PFXGWVedBOtABEFlnD7+hq3MV/Dop634jSyuug208AzH7fwT00CrdgFtrBR/jOXMn5wO47d9lzmZacMZD3kU1bpnTBPh+WJzoVXICZdNFfKahZrnrr8t6su42dWM9NK9r7sqDdraXfRcoQq1xj2npCmPcDNxhdGTh8iBe9xCy3P0ujkL1OrdmpozAYvQckFkBUg4SSfkIByvIYEmkXdBnDMVA6w+zqYMTR0G8jCsIQR3S2ZrZZtAb4nkEKeQHy7r6gHtW2qjIrDRLmImVk7FVuFCzHJCgv91zknadrHSH3G9d8tO2sdwoXDKOC56MckdgAgvp5B4Fw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720544010; bh=xoQrS2PVwSwHBK7uZyGrhi/sU/8hpG3gGr3iQVvccny=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=KleVrPJoBqdYeIxWg5Y+J1mQ7kxMNneWgOgCfprM4oTunJCGARbM1mL6ghuHzrbVQWaHmGLibrXnxjV8H+I0k2rW7Oyxv7t61cLh/zTcimZ783PmQ+B0EbHxBoGUB4gDFscXtgVGaBLKZXegqQWDOdczRpTh3mo6a1WNtMVBQ+qehU04ztoaOGkoSDHB33JCPSs5PQvjEWeo8EfAyEYc03+TJv67lYXVTSce0tzd2Ps8BT3dIMGbdbZBVgDg7XoD8FctncANIPO4wfXat/HbvreL6GHatqD3Xyac7Eex/7UBCiOBD0CYDT1dYwk//KwiWuxpB4qUOd/KJsPBDLiZYg==
X-YMail-OSG: UmZapFsVM1litozc92tF3odbF20xS.BPEyCh.kT_GfYiB3ADF0fvaKCXT9xNxx1
 NZOZ0uuOXw72u8xpeIm3Bsyz5clVvkuVjjes9aW4xPxSQ7e4b33RzI15vvSP.3K0EWGXIyYKAoAs
 oowo6QOpOsuJXIElOGoXaQ.xUR5HWJbSFmO8fM3BvkO_elUnt4NFxAB7sbkz4mYwAXILLzoNp_MA
 bRS1U5HP0qOLDfmpBXTPIKtYy2owV0LQ0uu5ZufhIL6vRxrTG4oDaR1C0kO0WWUwbb25B8ULydjp
 2UVF3GiPI_QHxtGrSYaVjDCyJyXDEtgcLtnAsAegjukv8EM.dTFItwui0QoJEueJbkUSNNo10rJC
 uZx5Amx9NuG_XPz7MrE9sQhvggrYC5OOxIJdWx9CXKO2fyr7dqdNEqVPenopwewrZiDIBRYhXE3o
 pvQ9Mkr5Sr5kmjLNJDjRJdk.sVp0BW9beBQOcThdivuc4P5rhGjaBjV4X3VwxSzsUsenbKM4bq.f
 w4hve_yx4YxIOMvKqyF.Mo8Eq1JdsD939NAH.qAxuQpogj.43Ce2Q9BniLciKoT50.MXXK2rpGjX
 jaNBvxDWaoAaIXN.6Ba9fzEP4qC3I9znMxaOk_CLCpiYhhtaweG6s2jKQ7gt.4o7ltwAO88WqGAw
 GBTd55AKYCNnkCDzR_SO4OLj.tUNHFaCAPGDqH9zgoi8OXqgt7g6TKDa_0686F.fdDctJiPpZszI
 qtBfwldCRhaC.s2WC82OBy.M0YTiZHMvgSjZHAaz5TUX.Z4aG338HtEr8XIoC_6rqIKEU2_3Vit7
 FtBiDaXx7s9aLI5wMdS7xFlixHiPsYLsleUNXsGekvXvtMEsySBLdaUwGlYYh3tnbVAnlt5YrGSw
 Y0QrtDXoBx2OoV59QCW4gk3Fi8upcnT9RiSvP4atDubYyDCCtSjaz5.ZtnssSO6FSEBxQVOx..Jg
 2ey0GDDOUbW6D5r1DItu87RN.Oa8KwgAyaqT.tUVqokRJqsz4HZbiZIVMIvpZdkWLY9CG34sgclU
 Bzdf8R8QMaLML8ce9kTbmpbdoR5td6_UZ0leYFoU8BvkPwO8LMBluOiV7nV4SX22waBNdH2W1.67
 kJ69R7SkYcLNe5iof2TEzLirz7VoQ_ceHT05KyYGACYDKjsrOKShQenpxp0vr3YZ18pWqAFt5iOn
 RYUuTiLeL0nlWmilWBHyxvHLb.ErHPlDIwRt30Uxdx4YEI4Yrsz.UGozs0SiBIZTD4Gl3HXGxJsE
 5BA7qWBGCOt.oZg_vmRtRP.CcqQltM8ASaU9z_tO7LJPJ_vxPYzbkkf1e394mA3dzMRXZ8HeLgfV
 SZ3JlVZSh2Aez0SKRIKRGIcjzNDYR5.KwY.d83dDjsxl5IDt00hOQAA9eqlVkG1XC3TgOIWnZgrp
 2KArMGt27P6BrTFYaGdpH868LpctMRrvLQe5AEFegpOivLIkk_1Ow13ZhO2II8XNptBghtSgA_g8
 HIJz2pTkeEngcnsTuAoURjDhQAhvClsYZzP4l9h3.Ioil7eo4iTl9dnlTsUYZJiN1YN6lMbOY4xH
 sT6T_dF05t69usW_kZ74bxNUpcVs71Nr1TGvi9Bs5eIy1aqt1JxLqhaC0CTvYY_2uVvxsvCW.JmA
 Kpanv7HHXzDUE4DI1DFW52pNMOXrs1YD.KCkYk7Fislt8wrQSnHHQY05QbJzc_TfeXdfEkVyPmjP
 ecEkeYQD3sf5eNRI3250m2rpsbYVZ0UFRlYTVj4Jynk7KIMGfPr7eT.Q3mJkB_aXnSvc0.TZC4Cs
 v_dRYWGeVe6u_aRE_scQiPHR9tCdkfp2aIjU7Lu5Adbs1zQ_cqYjf7HylmqXa6aQP.AUel26FOOb
 IAuGbLA2RBi9t3XEXS3eAmp4yu2RL4aaHy0OcomYuxWopwJX7iNWx9boTbpmRiiLWfDZ8OuD_.cI
 nKTwod3LClwxYHf.zvyKDm2ukk9H7f7ll7YbC6BUzRvb3h_n9ATMSO6vZsSASn6HgkUkHKoQL7xX
 tQMNHu9ygjzvh5Bd6BdYVMhJaQscF8SyckK6iPiOtXqnYOmD27d.UYEgS6XjPT3f6a0aKCBGHMyi
 DFZMzJi0FxEN2oSTSTY7FYeCPTsECjzTtfwXZnOZiS_FAIQ9qHcBAxhCiFKOm_7FGSzuix2smYfQ
 ZqwF5tJWDEOGKgcJMZOiwcawYt8AIVslk9qsJd6CjvJLBV8gyk0Xzgo2ZjljkDTjJb0IG69fcIHu
 aH0tNpxN5TeEjHn1bBor9Gx56PidDcK7VG817SfpQGIAvmrnx3GTIsRP7ZNK_WdyiBonvIMO5rPa
 ._rYbGGI5dit9qU1l
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: ed6fc5cb-8837-4d14-b8f3-9330c6986f9e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Jul 2024 16:53:30 +0000
Received: by hermes--production-gq1-5b4c49485c-pghqv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a2fac11dfba52b4f2bff7214c3e0c0a0;
          Tue, 09 Jul 2024 16:53:23 +0000 (UTC)
Message-ID: <e170a720-c6e7-480c-a54d-c6ae7cf9a77a@schaufler-ca.com>
Date: Tue, 9 Jul 2024 09:53:21 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 4/5] security: Update non standard hooks to use static
 calls
To: KP Singh <kpsingh@kernel.org>, Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, keescook@chromium.org,
 daniel@iogearbox.net, renauld@google.com, revest@chromium.org,
 song@kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20240629084331.3807368-5-kpsingh@kernel.org>
 <f40a3d1bc1cd69442f4524118c3e2956@paul-moore.com>
 <CACYkzJ4R-zG8=Xet4v-mf-Dmi_V9cHL7f0EiOEKhnPDxwsqx1Q@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CACYkzJ4R-zG8=Xet4v-mf-Dmi_V9cHL7f0EiOEKhnPDxwsqx1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22464 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/9/2024 5:36 AM, KP Singh wrote:
> [...]
>
>>> --- a/security/security.c
>>> +++ b/security/security.c
>>> @@ -948,10 +948,48 @@ out:                                                                    \
>>>       RC;                                                             \
>>>  })
>>>
>>> -#define lsm_for_each_hook(scall, NAME)                                       \
>>> -     for (scall = static_calls_table.NAME;                           \
>>> -          scall - static_calls_table.NAME < MAX_LSM_COUNT; scall++)  \
>>> -             if (static_key_enabled(&scall->active->key))
>>> +/*
>>> + * Can be used in the context passed to lsm_for_each_hook to get the lsmid of the
>>> + * current hook
>>> + */
>>> +#define current_lsmid() _hook_lsmid
>> See my comments below about security_getselfattr(), I think we can drop
>> the current_lsmid() macro.  If we really must keep it, we need to rename
>> it to something else as it clashes too much with the other current_XXX()
>> macros/functions which are useful outside of our wacky macros.
> call_hook_with_lsmid is a pattern used by quite a few hooks, happy to
> update the name.
>
> What do you think about __security_hook_lsm_id().

I really dislike it. The security prefix (even with __) tells the
developer in security.c that the code is used elsewhere. How about
lsm_hook_current_id()?

>
>>> +#define __CALL_HOOK(NUM, HOOK, RC, BLOCK_BEFORE, BLOCK_AFTER, ...)        \
>>> +do {                                                                      \
>>> +     int __maybe_unused _hook_lsmid;                                      \
>>> +                                                                          \
>>> +     if (static_branch_unlikely(&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM))) {  \
>>> +             _hook_lsmid = static_calls_table.HOOK[NUM].hl->lsmid->id;    \
>>> +             BLOCK_BEFORE                                                 \
>>> +             RC = static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__);   \
>>> +             BLOCK_AFTER                                                  \
>>> +     }                                                                    \
>>> +} while (0);
>>> +
>>> +#define lsm_for_each_hook(HOOK, RC, BLOCK_AFTER, ...)        \
>>> +     LSM_LOOP_UNROLL(__CALL_HOOK, HOOK, RC, ;, BLOCK_AFTER, __VA_ARGS__)
>>> +
>>> +#define call_hook_with_lsmid(HOOK, LSMID, ...)                               \
>>> +({                                                                   \
>>> +     __label__ out;                                                  \
>>> +     int RC = LSM_RET_DEFAULT(HOOK);                                 \
>>> +                                                                     \
>>> +     LSM_LOOP_UNROLL(__CALL_HOOK, HOOK, RC,                          \
>>> +     /* BLOCK BEFORE INVOCATION */                                   \
>>> +     {                                                               \
>>> +             if (current_lsmid() != LSMID)                           \
>>> +                     continue;                                       \
>>> +     },                                                              \
>>> +     /* END BLOCK BEFORE INVOCATION */                               \
>>> +     /* BLOCK AFTER INVOCATION */                                    \
>>> +     {                                                               \
>>> +             goto out;                                               \
>>> +     },                                                              \
>>> +     /* END BLOCK AFTER INVOCATION */                                \
>>> +     __VA_ARGS__);                                                   \
>>> +out:                                                                 \
>>> +     RC;                                                             \
>>> +})
>>>
>>>  /* Security operations */
>> ...
>>
>>> @@ -1581,15 +1629,19 @@ int security_sb_set_mnt_opts(struct super_block *sb,
>>>                            unsigned long kern_flags,
>>>                            unsigned long *set_kern_flags)
>>>  {
>>> -     struct lsm_static_call *scall;
>>>       int rc = mnt_opts ? -EOPNOTSUPP : LSM_RET_DEFAULT(sb_set_mnt_opts);
>>>
>>> -     lsm_for_each_hook(scall, sb_set_mnt_opts) {
>>> -             rc = scall->hl->hook.sb_set_mnt_opts(sb, mnt_opts, kern_flags,
>>> -                                           set_kern_flags);
>>> -             if (rc != LSM_RET_DEFAULT(sb_set_mnt_opts))
>>> -                     break;
>>> -     }
>>> +     lsm_for_each_hook(
>>> +             sb_set_mnt_opts, rc,
>>> +             /* BLOCK AFTER INVOCATION */
>>> +             {
>>> +                     if (rc != LSM_RET_DEFAULT(sb_set_mnt_opts))
>>> +                             goto out;
>>> +             },
>>> +             /* END BLOCK AFTER INVOCATION */
>>> +             sb, mnt_opts, kern_flags, set_kern_flags);
>>> +
>>> +out:
>>>       return rc;
>>>  }
>>>  EXPORT_SYMBOL(security_sb_set_mnt_opts);
>> I know I was the one who asked to implement the static_calls for *all*
>> of the LSM functions - thank you for doing that - but I think we can
>> all agree that some of the resulting code is pretty awful.  I'm probably
>> missing something important, but would an apporach similar to the pseudo
>> code below work?
> This does not work.
>
> The special macro you are defining does not have the static_call
> invocation and if you add that bit it's basically the __CALL_HOOK
> macro or __CALL_STATIC_INT, __CALL_STATIC_VOID macro inlined
> everywhere, I tried implementing it but it gets very dirty.
>
>>   #define call_int_hook_special(HOOK, RC, LABEL, ...) \
>>     LSM_LOOP_UNROLL(HOOK##_SPECIAL, RC, HOOK, LABEL, __VA_ARGS__)
>>
>>   int security_sb_set_mnt_opts(...)
>>   {
>>       int rc = LSM_RET_DEFAULT(sb_set_mnt_opts);
>>
>>   #define sb_set_mnt_opts_SPECIAL \
>>       do { \
>>         if (rc != LSM_RET_DEFAULT(sb_set_mnt_opts)) \
>>           goto out; \
>>       } while (0)
>>
>>       rc = call_int_hook_special(sb_set_mnt_opts, rc, out, ...);
>>
>>   out:
>>     return rc;
>>   }
>>
>>> @@ -4040,7 +4099,6 @@ EXPORT_SYMBOL(security_d_instantiate);
>>>  int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
>>>                        u32 __user *size, u32 flags)
>>>  {
>>> -     struct lsm_static_call *scall;
>>>       struct lsm_ctx lctx = { .id = LSM_ID_UNDEF, };
>>>       u8 __user *base = (u8 __user *)uctx;
>>>       u32 entrysize;
>>> @@ -4078,31 +4136,42 @@ int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
>>>        * In the usual case gather all the data from the LSMs.
>>>        * In the single case only get the data from the LSM specified.
>>>        */
>>> -     lsm_for_each_hook(scall, getselfattr) {
>>> -             if (single && lctx.id != scall->hl->lsmid->id)
>>> -                     continue;
>>> -             entrysize = left;
>>> -             if (base)
>>> -                     uctx = (struct lsm_ctx __user *)(base + total);
>>> -             rc = scall->hl->hook.getselfattr(attr, uctx, &entrysize, flags);
>>> -             if (rc == -EOPNOTSUPP) {
>>> -                     rc = 0;
>>> -                     continue;
>>> -             }
>>> -             if (rc == -E2BIG) {
>>> -                     rc = 0;
>>> -                     left = 0;
>>> -                     toobig = true;
>>> -             } else if (rc < 0)
>>> -                     return rc;
>>> -             else
>>> -                     left -= entrysize;
>>> +     LSM_LOOP_UNROLL(
>>> +             __CALL_HOOK, getselfattr, rc,
>>> +             /* BLOCK BEFORE INVOCATION */
>>> +             {
>>> +                     if (single && lctx.id != current_lsmid())
>>> +                             continue;
>>> +                     entrysize = left;
>>> +                     if (base)
>>> +                             uctx = (struct lsm_ctx __user *)(base + total);
>>> +             },
>>> +             /* END BLOCK BEFORE INVOCATION */
>>> +             /* BLOCK AFTER INVOCATION */
>>> +             {
>>> +                     if (rc == -EOPNOTSUPP) {
>>> +                             rc = 0;
>>> +                     } else {
>>> +                             if (rc == -E2BIG) {
>>> +                                     rc = 0;
>>> +                                     left = 0;
>>> +                                     toobig = true;
>>> +                             } else if (rc < 0)
>>> +                                     return rc;
>>> +                             else
>>> +                                     left -= entrysize;
>>> +
>>> +                             total += entrysize;
>>> +                             count += rc;
>>> +                             if (single)
>>> +                                     goto out;
>>> +                     }
>>> +             },
>>> +             /* END BLOCK AFTER INVOCATION */
>>> +             attr, uctx, &entrysize, flags);
>>> +
>>> +out:
>>>
>>> -             total += entrysize;
>>> -             count += rc;
>>> -             if (single)
>>> -                     break;
>>> -     }
>>>       if (put_user(total, size))
>>>               return -EFAULT;
>>>       if (toobig)
>> I think we may need to admit defeat with security_getselfattr() and
>> leave it as-is, the above is just too ugly to live.  I'd suggest
>> adding a comment explaining that it wasn't converted due to complexity
>> and the resulting awfulness.
>>
> I think your position on fixing everything is actually a valid one for
> security, which is why I did not contest it.
>
> The security_getselfattr is called very close to the syscall boundary
> and the closer to the boundary the call is, the greater control the
> attacker has over arguments and the easier it is to mount the attack.
> This is why LSM indirect calls are a lucrative target because they
> happen fairly early in the transition from user to kernel.
> security_getselfattr is literally just in a SYSCALL_DEFINE
>
> >From a security perspective we should not leave this open.
>
> - KP
>
>> --
>> paul-moore.com

