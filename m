Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974A26478B9
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 23:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiLHWSO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 17:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiLHWSN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 17:18:13 -0500
Received: from sonic307-16.consmr.mail.ne1.yahoo.com (sonic307-16.consmr.mail.ne1.yahoo.com [66.163.190.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204EB70B9A
        for <bpf@vger.kernel.org>; Thu,  8 Dec 2022 14:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1670537891; bh=2dAILjLP69OS9FOb9YU5vIxnb/ja4jQMKeNfFXNX264=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=PRG2/oNnpGADGD83EeZtPq/kQrBymL9eocf9L0cafJvVP1JXHAZ43YtO0WAU79SFi+c5jCMCbtnjjqyQ4C3elOn/GLvcPzbp+cOkPhFClj0GlKIX15BRHFg96OP6IvRKlMLGkEmT5KnZxKDQ/ST8AjfIIDxnQGA1jFxI8HBdZEyxcXuhJ1mxbCC+RvxlyEoLToW3a6yE1n1eUgFKplpZMTCFla217dTohtfo+VkZJ2RbusnLV6zOeSFHWEXsF9915vzDH3An/ZvFWJ2m7mhp1saagrYiUHysW3IYn6RZatCW2gPARY/RrKF7ZVntHlKtSURn4uNB8ICaDF/3uP5DtQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1670537891; bh=5lRHWOPF5z14iBE75M6AOstxXbLwGCgN+49brGsVQ7j=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=tEfHCtNTBi1uMFSLdThHmzrkDfWfL/7qqnWQysCRr32DQy3BHYfZPYXsFXTUd0+y2pQQ+ARoqDJIV2/jCJYcRkiHt59uNdUz683mJl/3hWCpGu/clzSTCfpRNG+lfda4Lpk8l/ifFra9sVQlCbIs8q/smpP06Ffr1wSOaxM/cwYWFVUtb9MGmj8Rr4R7bDcl6PQW452GHRTy/DdT7+4nWq/qkAsApfp6JiKWm5Jv870Zzpjvaegw1uc6rKSo86P594ExgPXwVdxHxl4sRAraXMm95yMbKQkhOQghvbskHwtCmFeZePrdfTcG5oC3GaR02CZ3mqZZwfpyFxfNUh0M1Q==
X-YMail-OSG: O2RLWIEVM1kX0tTMjEkN_jNRv0FV8dAQtxZr6H8HYUI60J6CjCv37XMKD2CQwWN
 Ddfed.mH_vcnWG2nUNEqsnOreN7jUQTZS8PGx_1jTM9guhW2iIWje_2y7go.FqRYRsFY3ALFMukh
 a9fZgv_7UgWlKoxViHs2jAfPxFD4qOY_CFmX.RipjeQbbCv_PJumVHQZDLPhDqQK..FEBlgK83Dv
 AbCLZswRq46xiuYJgNLgSus6GY_nbYVlvPAVHnLV4yl5N_amkbYyGQBFPjABwfKDag9jJrKsStdS
 h3QkWoehd0UyuvjeEI5DcOo6LmgXjgMH5Bd8m6hQsaRyLeQ4j1pgOy.eTcwgN5oYkR.wDujEcRXB
 qUI9H5XrplDcZQI_jKkWNF131TepZFlvhW__88GDFZsRaaqkzbQWOzQ6SMdB8QyPEwYuRxWPWXHX
 xOR1Df3G4e9g9GE.7hXxnikp3oEImNX.woH4PRXUppDnSS2jmmG9sTxUIDV.yYG0Xmidc7JJGNvD
 IbxlJMkNAywH.GXUVlqxWBdt4nvki3HO8TX3egWbQqOY3i8Iag2V0c66UeQPuGaRQt4sMiCiGNLb
 o0nmGKZVeFKdM4Wl9UGBUFo63OO.dmAgpxFXgfjVWbIDIn_UK2PhjKzkMA1VyVpP6AgUVI0WVFhJ
 6BHe354D50k2fHcrJd90t7hILF1Ipy3Xii5yAYbsMF8viZNx.SgnJ2MHYU2CkB6xNlWQF1gJi.bj
 Vt6Uungp4S3T4ocKujUlhH4uFqT.SLxvTib5q6X5a.l9Jv5R.3teQh27uOTs34fd4kosf7cWUBVx
 82Eye6jsvatVpodREn9DIP1NqqaMWRkVmI7RLr67acpm3uLKrDPYrfIat6hFDyugpbTyEvnyVcLn
 OKCRKTXHavjiVVIkltCons.VnituJj6tSa6MECu..JCDZVvaMytU3JkRnTFs6dlefFTjb8ATp0Rz
 CYqYBGonBNLn3nnMLl2ZDI1l8Xd0WaFvh6JyuPl982QByrPHXFt6dUzR2sQeyhWQEglxIRElDKvU
 N8Ybe.ctuIfMcymEWpGWK0AAZWcWJqLXGsLeam02_C3sIPufZJByE2cUhpHs9CZropstg98r0jrm
 o93Zn910CuVR7CrxKvX5LvZswqEjil_23rBgc6IvzBNALYMhMCvRKPskZ4LGWo3HVpq7Q.S9e768
 zqIjFOiV5YBlII2OJ5_khv32rhg0jIsuM16asnWksK_75TtAFLMF.nzGMYtcl.7dhuGOxJXEErp1
 XXG5ucvON7T5lO9PZ7s0YqCOFxlAnYjy9_01G5Geo9OgeBbEuL0kCS8B4.F65I4I0RgboxYghWFa
 YtpkPIqkykPBGMhHFC3cgb8VZGFJrlosCfufPwnb2J.SCLZ6Va4xyWl4BKsBHvoULYLYAdJ_YGOk
 e1XUc1oVudyPcd_8vA9ngXAc.8gmvVHFybXZEFuEbhSOtyr21kry8Fv4wvmlhLKU704duD4TjAQP
 roYswyak9xhl7kHoaUHGZTPrGT21gMerg732sAspOtWXCIPyc6M6kXh4PmbgEmgn6Vo1XK9u.OBm
 Rujl2YaBeJU1KN1tpPDD9470OclWeuo66lc6ru.Q2hmjrVCLTv.fwjFBsdyZzAc26I4dxMC5F.eo
 qUakh_GR0UTa0r9p8WkVOPqEtlsgJWVV38V1KsdkeFBtJb.dNDLzCiNsl4glbFe.qwV2F2pdSsiD
 pBN08wNBpk7xAm5uW2nzHybDO8AxWwrf20K8PPbGZ3QrQNn25J4fcCOhSuTQGzlC8puv42yMH8Ia
 b8Z9ZZNU91ovq.g77l4kgCVKg2LCSlnhaONutWcF_m9qcGsbbGsSbrNSvRQFlbwu1_HSpy70rue7
 xnUtScSindofW98pEsvan.3HSln27hhuAauxvzwpI6rj.2kx_oQFrLg7a4WctSXA4ZIrLc97D61H
 GBw6IJWDaXASSSyskHvT52sJ_EM.V14upipGr2OVGxCpJiDBC89ViRgX5XFAnxXY2R2d8.exVEdm
 5N35uUNjYgt1Rzx24TlKnngNBC6TKJiHaG2o.HDobZKbprGhafgYqt.LoNa_fBQ9bZsBpBFYmXNN
 fVCDRYe6jAXUzuzvKnGRjVhOY902iVmsF5mvRJ4SErdLUNMNzPmvMFpAh0aJiCvanm1eg5T7CrOJ
 TpPIEt1zu2st9oeVZF_R9Yzv0Vwj2KuRJ_FDgDTWSEszmZUG9kqTeJVz6kkE4ABX9GohLtoC0Ck6
 YyrpH9x8kRTzlp4R1v9BTfOiJa50F1TIKlEGNWu7RiQ8cEatc2aLxGeccs6yIn3pItrV3ep.Q0op
 DpcXlYSw9SbSmNn0-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Thu, 8 Dec 2022 22:18:11 +0000
Received: by hermes--production-gq1-d898c4779-66ldg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e4990e6f66164b6f2d176bcbbed58160;
          Thu, 08 Dec 2022 22:18:07 +0000 (UTC)
Message-ID: <8d14fcbe-baab-4678-beb1-4f8ff6171eec@schaufler-ca.com>
Date:   Thu, 8 Dec 2022 14:18:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 2/2] lsm: Add/fix return values in lsm_hooks.h and fix
 formatting
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     David Howells <dhowells@redhat.com>, omosnace@redhat.com,
        john.johansen@canonical.com, kpsingh@kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        casey@schaufler-ca.com
References: <20221128144240.210110-1-roberto.sassu@huaweicloud.com>
 <20221128144240.210110-3-roberto.sassu@huaweicloud.com>
 <CAHC9VhRx=pCcAHMAX+51rpFT+efW7HH=X37YOwUG1tTLxyg=SA@mail.gmail.com>
 <7225e76c09c7ff68937e37ee041fefdd6ccac1c8.camel@huaweicloud.com>
 <0682348d9601ca3847ce9ba035e4ab1b586cf712.camel@huaweicloud.com>
 <CAHC9VhQZ3VKWsNarUGPcHZuoRLgb8owKgbdLymwR759qVyQ+2Q@mail.gmail.com>
 <b989b278a16c48e104b32ba7243e4298491a6056.camel@huaweicloud.com>
 <CAHC9VhSdcyOd01VYtqhJGrgKyG3oZmE_1d0RQymxKv1=ErhduQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhSdcyOd01VYtqhJGrgKyG3oZmE_1d0RQymxKv1=ErhduQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20926 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/8/2022 1:59 PM, Paul Moore wrote:
> On Thu, Dec 8, 2022 at 4:29 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
>> On Wed, 2022-12-07 at 14:34 -0500, Paul Moore wrote:
>>> On Wed, Dec 7, 2022 at 4:18 AM Roberto Sassu
>>> <roberto.sassu@huaweicloud.com> wrote:
>>>> For this patch, I saw it is already in lsm/next. Paul, should I do an
>>>> incremental patch or change the one in the repo and you force push it?
>>>> I would just remove the three lines after the parameters description.
>>> Just send a patch against the current lsm/next branch to remove those
>>> lines, and please do it ASAP as the merge window opens this
>>> weekend/Monday.
>> Ok, was about to send but I would need a clarification first.
>>
>> In mount_api.rst, there is for security_fs_context_parse_param():
>>
>>      The value pointed to by param may be modified (if a string) or stolen
>>      (provided the value pointer is NULL'd out).  If it is stolen, 0 must be
>>      returned to prevent it being passed to the filesystem.
>>
>> Looking at security.c:
>>
>>         hlist_for_each_entry(hp, &security_hook_heads.fs_context_parse_param,
>>                              list) {
>>                 trc = hp->hook.fs_context_parse_param(fc, param);
>>                 if (trc == 0)
>>                         rc = 0;
>>                 else if (trc != -ENOPARAM)
>>                         return trc;
>>         }
>>
>> If, as mount_api.rst says, the value is modified by an LSM or stolen,
>> should it be passed to other LSMs too?
> All of the LSMs should be using fs_parse() in their
> fs_context_parse_param() hook to identify the mount options that they
> own, skipping those they do not (fs_parse() would return -ENOPARAM in
> those cases).  I don't believe we currently have any mount options
> that are shared across the different LSMs, so I believe this is a
> non-issue.

There aren't any today. SELinux and Smack are the only LSMs with
mount options. Smack mount options all begin with "smack", so it's
unlikely there is going to be a future overlap. I'd hate to do the
/proc/self/attr/current battle over again, so I recommend that any
new LSM that uses mount options be required to use an identifying
prefix. I don't see any way that using the same option name for
mounts, even if the use is the same, won't end in tears.

>
> In the future if we ever find the need to share mount options across
> different LSMs we will need some additional work to ensure it is
> handled properly, but I don't think we need to worry too much about
> that now.
>
