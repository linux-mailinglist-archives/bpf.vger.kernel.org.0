Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110B7692D61
	for <lists+bpf@lfdr.de>; Sat, 11 Feb 2023 03:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjBKCdB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Feb 2023 21:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjBKCdB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 21:33:01 -0500
Received: from sonic311-31.consmr.mail.ne1.yahoo.com (sonic311-31.consmr.mail.ne1.yahoo.com [66.163.188.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAEA474E6
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 18:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1676082778; bh=lYPar4aMdkFTDZQiAG6gyHoVgxRfxS1Y3drGjiFVA5M=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=BwujI7xdzvmYTecWZGO4f/U6E0CX+IrXaYosBzWP6fjXJHBCBuQhfqnm47UkUzzdzt2ATiXXcd6+Jd9XZbYjrPafsrF2hOu7lNb3q/tkjdVpdSBVRX4tVuwj4Btbr1lRPp340NL6FGWCqkaseutWCF93U8fYSI3IfVrVJZ22xdKw+tkjO9V3THk1C/3UAIOdO4PqZXrVUb7Ux7D+ffwctwhWLJSKphOwlRnWUxQLh/fgKNujYTIZPh1ZttOWeKC1Pi0RkJg1gYk01bzwfROUR3SEkbL0N7d9nAWx0Ub3Vd4DRMXpFfFMDv36c7gGzDv41XArwBaAq5bsPxhA8idKAA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1676082778; bh=C3K1KpoZbVmfvXKu7l/SklhI3BwGUr1Uq6iHuDi1Q4g=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=qY30A5GyHBAHbJsZAgbnQU9QD6p6o6U25Cmgr0LGQSCmcpZqmzk+aXjUdn354Mr6re169Q8p4xWJTibAlZA7gzyWEbo1v2UTnak5v6vv2Y8R9OMDDrn3MARgprdl0XisYgcKluwP6ixQkeueWUmWs8fxzcGrJC8tkM1iKXKURUCNWfeKYHdhQNY67ybe9eiRUm4byfCbcHMCLuWQIaAZX9XLvY2AYE1YYOB+QoRbbOgP9ioX2Vk2ajuksJ0vagIZaIyQnw0UT7g4wXuIgkgGmM7nyy+/efRKjiSRQuS75XUnDEwua7i0f33HRB1dgwWCUOMzS7Pnq7XuDgO8IHBEvg==
X-YMail-OSG: Cz.zGKoVM1lTKu0fureOESq3I3iEHnX4abnxjZAYsjuECRWDwydHVZ5bwWKKnhw
 j7xDIyxHH1f0DaV.SEdbr2RSqF9b0hp2YqgLKOJAiKzfmc56XRh4AxyFVqg9zggryj1l.a1eyZQC
 vkN5qaU3dZ4pqr_fm9ZVYW1AyMF1acSZktfmO2OuShyH4Vo53IrvqLSw409MZGJ7iWiKxxVxCrQZ
 8n8AYNo_Iup1mVTux9aAxlE3GYm9kG0g5CYklJbl9P98ZI8ALee2rWAry0Fd6ouIPmSKEFbs0Bfx
 2.43EErJb4FEezUJpYm.SNl9WvxK6YvuasIIutCXce5Hp449Jqcmh0Fk4vYVb1HO5aBn1YuMmsNa
 dhyfTZJ8KsDkA2yT4iRZo5SbbW9juwjUjPrnl6_ulXjWz11KoZJoyNZLtmt04DBvsfQAkmbC9luF
 ilNTjfXOQq8pYKUwdYjPO7xcbePyuFE3HO6D5Sac2y_IF7CYaTBg7lTkYpzPa0YzPAu7qX1WPO.e
 emmwO8nvxhdRvUX2.vF83kg43F1os1E2WNib_yzuSsptmgqhOt.9WUTlcXbI1URHr3_S4p9Pdf8B
 M706xsW9yLdCjzJBagQQBBzGSBumsZiAEb6SbN7iZ_69A82j9eLumDzMvEUu.0ISk6IEGy2aiQdE
 NnvVCmXXSSrNzmjmyBeLGMvUL4w6i8riu.MVnNdqMH4y6_iEsz.VevrqYcf_Qszkds7oOkG5IHBP
 de1f0oMXv3EKR11KuIGSfI5Ww6UEJF.lDaCYNcDklzoRf5mX4XMZbpM3.qKt.DTekYufu1F1QuVw
 KYPxtzJk5QExwVEDvEp5J4rCSehjxDp8osn.xwyftl0jyFkl1jdO7ITerrAp6y3wvYzLtUyhoBMR
 DGsa5LZdQ0w41VWO6xAbT_oFeKMLlSfjaxr5EbxT6kojGQ4a_1jwuusCLE11yV.RcqJ5YIRq9pJN
 MSg.GW5ajhxe5YASnQymY0AhlaAXD44JY2ua8FvwfFOk6exO9QX_vu8pG7mHZetmgok81bxZqyod
 p_Sa0A51NtVBWFqwfmqphobaqvY486PqIVGWFKIa1X6nSNKLOhTwqmsvFLKTvASZ4g7o32VTr7AI
 J4kzUj0iBGeTLL9Wt2XoyEKpK.8PU6Ijy1iUJqFaDlqt7lqJ432ezyuiAYiB.0dRbfTCKEcPtNdV
 b0rZ8auhs_pR9ep2vdqH2.IQ8Xjy0d1XlgImMKbrMZSN03IoLapLmYXHSmdPc7XTwJ_D81Od6ZjN
 QCKcyifZf_zpAYD.Ok0iOpvEs1FDDir3Aew8NNSlEFtmTCsny9P9W9faS4Yle4X.7WxeeaK__yaZ
 bqjmTtCsryUnRFZqVC3dFLWq9p1OxpLMlbugHEJ1XNxPt2rMbO_aC62Mc6Bi8rATA_FnzudB9j4R
 gdutt77QBZJ_qal_GDfdJ.GfPpSUJYGPDDl7EhegGnSg05Bk9z2dK.gJLeptPlAHbQFhKeErKyhy
 NSU.bLmbN7zi7_feTWShQvdrvLIEObxq.BbEY9QPaf6pAsk04gK_hUnMCZgzehgvvWHeD0Sej..n
 6qD9Yyepk0KSBxbtPd9DrUYBddik5nzaq7aHqQV8Q76k0Wt5wL8L_ruZTWvBzlYR7FFDqzv3gL__
 omMouN8JORpOJu481iAoma19.vfcM1hiGkU_AH5B5Zpv7bnBVsCZVXoFawRX_hZa0O9nreGbHHv5
 Un9rCZi7lnuHftGmvaJzhQVCpi0f2HBPPcqZoyHoIgtd_mHPb5MG_BpdmHHMaFnliuz_KneC_7pz
 UdoQbA21TbX6MHQQtBJA2EEXW8Me_ocih0FqBQHZ56cAv5dKvQkFMmy7cNl2HJ2IrKtzDSid0Ke7
 .hmMwfsR6_LCWjSY7Y7TYuO68ZpcExTxdcPieF1_C2t1yv7tREA5AT.wYTF9KPpCKVcKSF50wSuP
 q.3KPjdSer375rzBTeKtTZGtI2Y5mJYL_anfwEZlV8Ndkmb0HKz9JZ9OOPn2PoCFCpL1384pz9RE
 3K8BMQ0hZ3Po8pC1RX_RiT6oqOcF9mNadxy.GBcZ2nbrE10ciIh4v37QcnYw6aEEDesPAWJLIBvY
 UR70TkndPKbYtbAHkx1e7.hjqKR2xYeX9G7YNDLpHJ4FlbwmwW4.5rViYtP90YllOlfu1oWSwBx7
 yCTlMKvYMTrEpiHrvISRuv0RriI6O7elx4818ke46Vzex4Ug3eQR1W9A4tRtYlfdm406cOy3dF84
 2pBzICEGCTCVd6xqC2hNsVN7ozj68OokWeGv8WTf_MJluQUGyMaWCGcyNuvO9vWsIur5hv2kPB._
 YFBia
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Sat, 11 Feb 2023 02:32:58 +0000
Received: by hermes--production-gq1-655ddccc9-zfzhj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID bd9f4e524eb555cdd35249fbe182c74f;
          Sat, 11 Feb 2023 02:32:56 +0000 (UTC)
Message-ID: <98799a20-1025-3677-d215-69b13ac73ee5@schaufler-ca.com>
Date:   Fri, 10 Feb 2023 18:32:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH bpf-next 0/4] Reduce overhead of LSMs with static calls
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>, Kees Cook <keescook@chromium.org>
Cc:     KP Singh <kpsingh@kernel.org>,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, song@kernel.org, revest@chromium.org,
        casey@schaufler-ca.com
References: <20230119231033.1307221-1-kpsingh@kernel.org>
 <CAHC9VhRpsXME9Wht_RuSACuU97k359dihye4hW15nWwSQpxtng@mail.gmail.com>
 <63e525a8.170a0220.e8217.2fdb@mx.google.com>
 <CAHC9VhTCiCNjfQBZOq2DM7QteeiE1eRBxW77eVguj4=y7kS+eQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhTCiCNjfQBZOq2DM7QteeiE1eRBxW77eVguj4=y7kS+eQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21183 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/10/2023 12:03 PM, Paul Moore wrote:
> On Thu, Feb 9, 2023 at 11:56 AM Kees Cook <keescook@chromium.org> wrote:
>> On Fri, Jan 27, 2023 at 03:16:38PM -0500, Paul Moore wrote:
>>> On Thu, Jan 19, 2023 at 6:10 PM KP Singh <kpsingh@kernel.org> wrote:
>>>> # Background
>>>>
>>>> LSM hooks (callbacks) are currently invoked as indirect function calls. These
>>>> callbacks are registered into a linked list at boot time as the order of the
>>>> LSMs can be configured on the kernel command line with the "lsm=" command line
>>>> parameter.
>>> Thanks for sending this KP.  I had hoped to make a proper pass through
>>> this patchset this week but I ended up getting stuck trying to wrap my
>>> head around some network segmentation offload issues and didn't quite
>>> make it here.  Rest assured it is still in my review queue.
>>>
>>> However, I did manage to take a quick look at the patches and one of
>>> the first things that jumped out at me is it *looks* like this
>>> patchset is attempting two things: fix a problem where one LSM could
>>> trample another (especially problematic with the BPF LSM due to its
>>> nature), and reduce the overhead of making LSM calls.  I realize that
>>> in this patchset the fix and the optimization are heavily
>>> intermingled, but I wonder what it would take to develop a standalone
>>> fix using the existing indirect call approach?  I'm guessing that is
>>> going to potentially be a pretty significant patch, but if we could
>>> add a little standardization to the LSM hooks without adding too much
>>> in the way of code complexity or execution overhead I think that might
>>> be a win independent of any changes to how we call the hooks.
>>>
>>> Of course this could be crazy too, but I'm the guy who has to ask
>>> these questions :)
>> Hm, I am expecting this patch series to _not_ change any semantics of
>> the LSM "stack". I would agree: nothing should change in this series, as
>> it should be strictly a mechanical change from "iterate a list of
>> indirect calls" to "make a series of direct calls". Perhaps I missed
>> a logical change?
> I might be missing something too, but I'm thinking of patch 4/4 in
> this series that starts with this sentence:
>
>  "BPF LSM hooks have side-effects (even when a default value is
>   returned), as some hooks end up behaving differently due to
>   the very presence of the hook."

My understanding of the current "agreement" is that we keep BPF
hooks at the end for this very reason. 

> Ignoring the static call changes for a moment, I'm curious what it
> would look like to have a better mechanism for handling things like
> this.  What would it look like if we expanded the individual LSM error
> reporting back to the LSM layer to have a bit more information, e.g.
> "this LSM erred, but it is safe to continue evaluating other LSMs" and
> "this LSM erred, and it was too severe to continue evaluating other
> LSMs"?  Similarly, would we want to expand the hook registration to
> have more info, e.g. "run this hook even when other LSMs have failed"
> and "if other LSMs have failed, do not run this hook"?

I really don't want another LSM to have sway over Smack enforcement.
I would hate to see, for example, an LSM decide that because it has
initialized an inode no other LSM should be allowed to, even in an
error situation. There are really only two options Call all the hooks
every time and either succeed on all or report the most important
error. Or, "bail on fail", and acknowledge that following hooks may
not be called. Really, does "I failed, but it's not that important"
make sense as a return value?

If the return isn't important, make it a void hook.

> I realize that loading a BPF LSM is a privileged operation so we've
> largely mitigated the risk there, but with stacking on it's way to
> being more full featured, and IMA slowly working its way to proper LSM
> status, it seems to me like having a richer, and proper way to handle
> individual LSM failures would be a good thing.  I feel like patch 4/4
> definitely hints at this, but I could be mistaken.

We have bigger issues with BPF. There's nothing to prevent BPF from
implementing a secid_to_secctx() hook and making a system with SELinux
go cattywampus. BPF is stacked as if it isn't a "major" LSM, while
allowing it to do "major" LSM things. One reason we need full stacking
is to address this.

My $0.02. That and $1.98 will get you a beer on Tuesdays, 3-5pm.

>
> --
> paul-moore.com
