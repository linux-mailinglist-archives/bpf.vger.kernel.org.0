Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8400D546CD7
	for <lists+bpf@lfdr.de>; Fri, 10 Jun 2022 21:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346862AbiFJTA3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jun 2022 15:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239072AbiFJTA0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jun 2022 15:00:26 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com (sonic301-38.consmr.mail.ne1.yahoo.com [66.163.184.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2582C27A8
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 12:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654887624; bh=CoHFBlqP5GXHtUUHwPpf8gQLqlpn60neJTGXZxwigKA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=qVypmjzldOE4h9POK4gUbJiaat5QsqyXwdX2RKZVEqurlRFw/ROsC/JBxx+Tz5l8n/Nl99+js6KQLvvZJ2RE/HvlsUp03EDfag2q8byc63qmaYrIVNGMXf7OdGsQGVpJTQ02QCaIEGYRgjYplBW42c9vMLi6vZfXWVKWww4uL6anHtkoXfsWVpYCyZ8u8MkLFBQVk9abpv8rkH4gpCIQOLM+RiODS0Iks4gjS93Qd+1Pfa9cphmC3N87OtKQ3xlZuuMc5kVs9r95JhZieBagnGuFGvdSQTZTen1wZLDZn/5wQyQlLi1ZdbIRrnOyb4r1yqC0Nd4RP6GIW+OsLPoSiA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654887624; bh=MQwMgz8gP1L6+pq7ni+hvxp72eFJL09Ejr9u8PNch9n=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=LZGBv1cXc2C3LmYx2BHev74mQipnNvBxm9ML63irp01m+yzDckHbC5cQ7Y8MfpB2RFcKiqUOfpde6pJjmtw9aWf+kegC4ElraQwSuSsFTjTIXceMCjQml4dUfvEPh/P/ypEEcicYUkoxddnfMbIm67wFiVOFqroKFkctsiFg66O3lHLECIqz3unoNvadv+d3BWX93HwXdFqu9iHXmDQm/JBU1OoWHyht1MSZa9g4MrrhHp5cSP2edaYsKCdkmnztca4sr86t3O+k7Fd18mjC/+FQQ2pf5AMBx8NZoRxIRiQ4tW70I4obqQ+ICho/GSsb6XMOwOtY4dpQ1FIBRhqkkw==
X-YMail-OSG: 4GKpoBQVM1n0rCZqisqJ5zDEkiOU00YJqbZOsw8oQiR6u9E9l2usSrQYSXOkrGe
 CbggZlFTriZlHvxIbr_Hag9anyR2iL11Eif2doEqDsLYrYiDyisg6uu0wLM.KcPNFwJeRIaZVNxR
 S2Q5_pIiZ_W7CROD8OE5lneU8c8LRc5LAHZpqOqS3i1kSqqstqpj7WQODQccr_5LNiDS8XKv06F_
 5kCQQesP3LI114JkNpRvxsx5ziqrpmzsDVymzF3KoMSLXZZQRp.FfS1v35uFnDJaNZqEkIYYhEPI
 FAD5X3uKtpkEzqyAEuVVK5MlDchk75uoL.h5lj2_pLhHxPyr2dHoRQCQExC_X6atqq66PwfclHaL
 IneYvBSVwUsmGVPurknO5JWDILRQzhjG_F8jKmcTwmh3UQafIUZWG_VYQ3ZXg_arrFvkoKCLnlVZ
 TSUsmvj6WF3zvWsJpPrkc6RiOBEEFG2vrPv.B6iCf4U7Oslomk501kwNlathbgV3UkbdOQBQi8.F
 J4k0FQ1oSSNFttfj9Lie3Xw7k6xQneB2faIc5eBaX86d5kXZC2a5xvDzxMqTwyLscaUlhSMdGubX
 kxPJ5arSZ8W1PXoT5kAy.CkKdNIVqjZIMIUItxHrvcZiqRIKsTYyEH2_a7ojfWoOxWDLiPk.7RcU
 0nBTnFmyy4OO_kVNEhf4vQqS3ew.xE30GOWKqu5iutypG0BiRrUcDrqfiHwlpt_VMUsIcbW9m_Vy
 MR_7VyRLAnkTGsrHOVyh2CClCJCsW3Qt52PzDc2ffd8PKeKRm.6Hv3_rJut4TSS9UJadRoZgc6GI
 ukfHvltEFtBSSFLp_fCgaqga.JVEFyMMwXJWrbD5.BpLvSmgZN5NYGPZgIQkeNx8utNzHxoSQIlD
 aUBHO0tBZU31eak81UEPw78AATn62cgxb_cQ4JIFG36dHBploFMXHxXUFeAMgJ5SvNxQs8Q3jb7n
 uLPS7DhSJLkOeYsAbmkO0oWMjx_qFxMXW6ApntCWO._atLX55Heol9.V8.r3AmxqJjbNuuzUNt2y
 RhC2pdVmNHsPP8i4bxFl4dgVxQVkTgUWL.wEJKNwz7N4xHeqfqTMIp.Hj37hGcKEuXcmPF5JyuOm
 dxNxw_oY749Gl1xlX.CI04olSwH9YpEzzce_tuC.CtlYJVmkjuWQu33W4nMtgQx6GR5rfMusOiwG
 Pt1joEnN6SVaE6p2zq.MEJk2njsquFsc2Q.AM82XmMtyocwsBqcp0PB2oeU8xmnf4U2wjo0fvtZa
 L59TVnqSfHGtd1VmE3enaC2XXX5GwAl6yfhzBqvLb642KVcdpdHsqMx6g064QI6qNytZOiAhHkIj
 HSEcIML5v2XgqWUL5ydubEv52HW4K93IVMbdNhTDWNNwWEUygz.BqqmoJ5HIiDAwmSHPKpn05d2s
 RY0McYNfDt367ZF8HJnxGrv8PBa3tal1q1j78iS0V.drFD_e8Eu6JPYrAhmLslLQgIxlbrMDg.lo
 YI6E7DMiraduiMABQkJMYyyygTAiyBacIIC49ZQOqInV9d6RJLbuuA_dwHboEB9pSr9zqdQ7Elm3
 KLoPmp_MKgGqhLK1kVRhh6pXN6RObnm3f7afHiVTrCNVT7lPoRL7fqg2.EQs0JzJ6Of3bEib9jL2
 lvQ_GRD_j_qQ0NlDUakYXjhOdHk.Y755xoFIxx9lAPfQdEZ0LQQJGOyjIC4rZBm6cbvaXdgM9sWW
 VzP4tre3UMAXcCDhbTgMCi4ETVacOtsZQfEvo9jjnSYffYAcd_S1a.BJbfOj6pi_P4bGB_t0jUHC
 dwD2hIRwepYqXgPRg6JkIsw_dyoKlzQWs4BlfCNh.drxZlE0qrAzUtjwZhPMPJbv4beM4K50qnuk
 AyxjZvKL5H.unaYLHB.3OXz9LU.HhbQDtLPQcwQ8hIfLl4w7IbAKlAt.LQ_1j4geCNYDjXBszfPn
 dYSlUjmKzxHyYMGcKxH3wTzOokt2zP1A9UMOPHQKC2G.wYWUuuNzwMPWOFTa2wAI5so76gh3mie4
 8nlJtJXgctbZS0.DMrIP8B3nkfzVhGbeewY8128ECD9W4tPFUXSTbqw2YjsrzRLmaG5JQtWWLZLt
 pf6DrzptVTykcdzzumpsmc9nFVeZ9cjVpDeq7ya6SwrGydM29JoUFTIf31FYfGF.y0VcGZmpMgz4
 a8kqDxzlIiUXvQlPy59hLQ6PcH.wHzcyHmHRe6SFWlrihvqVJFd07l0Gc0EvvUacit4aXzllAo73
 1aIGcLHt6Lyiud8JWFm3IOXHGiJEL4RZfxlvktfL26MlepjToLPhXvXNo
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Fri, 10 Jun 2022 19:00:24 +0000
Received: by hermes--canary-production-gq1-54945cc758-2fhnd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e47e41f11a8babd86c4090dc16771578;
          Fri, 10 Jun 2022 19:00:21 +0000 (UTC)
Message-ID: <07babe1c-5ae9-a619-b159-f1bb7f3108ca@schaufler-ca.com>
Date:   Fri, 10 Jun 2022 12:00:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH linux-next] security: Fix side effects of default BPF LSM
 hooks
Content-Language: en-US
To:     KP Singh <kpsingh@kernel.org>,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20220609234601.2026362-1-kpsingh@kernel.org>
 <bc4fe45a-b730-1832-7476-8ecb10ae5f90@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <bc4fe45a-b730-1832-7476-8ecb10ae5f90@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20280 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/10/2022 11:50 AM, Casey Schaufler wrote:
> On 6/9/2022 4:46 PM, KP Singh wrote:
>> BPF LSM currently has a default implementation for each LSM hooks which
>> return a default value defined in include/linux/lsm_hook_defs.h. These
>> hooks should have no functional effect when there is no BPF program
>> loaded to implement the hook logic.

What I failed to point out earlier is that you really want general
LSM stacking for BPF to work the way you want it to. Reviewed-bys,
Acked-bys and other participation in that effort would be most
appreciated.

