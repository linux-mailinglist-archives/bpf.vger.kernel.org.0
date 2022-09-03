Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AEC5ABF62
	for <lists+bpf@lfdr.de>; Sat,  3 Sep 2022 16:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiICOon (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 3 Sep 2022 10:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiICOol (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 3 Sep 2022 10:44:41 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086431658A
        for <bpf@vger.kernel.org>; Sat,  3 Sep 2022 07:44:39 -0700 (PDT)
Received: from [192.168.1.138] ([37.4.248.23]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M3VAI-1oTwPy2kDq-000f5B; Sat, 03 Sep 2022 16:44:24 +0200
Message-ID: <d58ed1a8-99d5-c45a-975f-85b71a1f3928@i2se.com>
Date:   Sat, 3 Sep 2022 16:44:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [BUG] null pointer dereference when loading bpf_preload on
 Raspberry Pi
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        regressions@lists.linux.dev
Cc:     bpf@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        jpalus@fastmail.com
References: <f038d6f9-b96b-0749-111c-33ac8939a1c0@i2se.com>
 <56ffb198-8c93-1ec2-0b5e-9441e96359de@leemhuis.info>
 <76951173-ce4e-adda-e80e-7c313725e937@i2se.com>
In-Reply-To: <76951173-ce4e-adda-e80e-7c313725e937@i2se.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:+2wqmTWz5UK/XijbOhTsP53XMFGI+FaL6s6B4wNJgCMwtSICCx8
 4LD7ylUlgQ1XkYJT6EDV1WG7aCsmcDp6is+CDK83zjaZnNbCuoHU51tZhn9tk9SQ1DfwAFR
 KHkm37fSUuSyhirPEcxWOCu41rX2rdlzDVqhn1bZfdba6GmXLAdRIxxWClzgAv3dP+ghdPr
 5d0PKnT1BVPxFFoiO4dqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7oaClSOWpGk=:hjymvORhn7quqz3RChSFiQ
 BsuZRNmTMZ2x9CxzlPU1dn5Bj1OFweURUyH3se562VgueAW5WmHDs/sUfxf1AzrURXfbUsmGB
 Bl4rRKgqgLrNLQZD6tnxk52PjzCbMBmW5aMWvzVO5AwwYD18hkYifs6xMtBkgUDGD9+DvnQZr
 okAEF5kcHuIx09xKwyJH5uJaLN5+FWEBqO95ChbUBCbEmcgNi4yzw+XPd84KzBXE0GEuOc+SG
 ux3x9ih1QmOmr5nrGqtW2+3uTPgQeKk8Equi++L7YYCeYqcFFwIfvK2OoI82I47jJT3fNalsf
 JZVA/UBI3NUumKqrLjlIVk/6akjezvvSZ4ZPSpI2hKpfGq5oHIvFi8U/HJ2Lbpy1ObuhAJHaE
 w177vai/Di9fav4lI40bQu7B82k+ddKPdcng0iMyKFpmM99O/KDrs0kBD1VtKEmmKRwIG88Ee
 ntWuWSklWPySi7AwjUX3yNp8cjxvAzjA05aNUuj8BN6ermPOk692SRNThkQN2REKNVV30J1PE
 VJsp9mUfPd18zqysy74K20guP80uCOf5OT+dSpfbJ5Ex3MKr9HKlAauGSCXRxCuc0E35Fof95
 9082mgaPh4VZw0qJgY9zp03d95Q6X+P685o9SoAbNgqbhz60Yoie2/vYbY4+3hGOiqLqNlPW9
 fFk+0kLZ0AwyJ5F2iL7191p6FDsc6cMdiE0xS6tKd7F5Div3T/Vli6IRtymD7Q4rDZELd5/Tz
 wtDjsziuLsv5XbibHJJZ7rzVQMjw5E53xd9YfP6UqC3XRaKZqZo4kqhYNU9gSDkCPE0F+po2W
 GN/pzDkyoJQsOuYka4FVwipqiLrbg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Am 03.09.22 um 16:17 schrieb Stefan Wahren:
> Hi Thorsten,
>
> Am 19.06.22 um 19:06 schrieb Thorsten Leemhuis:
>> [TLDR: I'm adding this regression report to the list of tracked
>> regressions; all text from me you find below is based on a few templates
>> paragraphs you might have encountered already already in similar form.]
>
> as reported by Jan on Bugzilla [1] the issue has been resolved by
>
> e2dcac2f58f5 ("BPF: Fix potential bad pointer dereference in 
> bpf_sys_bpf()")
>
> I can confirm the fix.

sorry missed the link.

[1] - https://bugzilla.kernel.org/show_bug.cgi?id=216105

> #regzbot fixed-by: |e2dcac2f58f5
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
