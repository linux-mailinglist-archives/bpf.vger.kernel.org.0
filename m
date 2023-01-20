Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BAC675CB0
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 19:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjATS00 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 13:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjATS0Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 13:26:25 -0500
Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4106673EF6
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 10:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1674239183; bh=Hav3ZgX1lqEdu0BQZEXNw7mzjmdUviR9C1EjsBgT8Oo=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=BycWevzzKHVtfB2E+oFO+3ta3wtYjKclCreaMwiu98ZxPkjJvqfTL9rJloBiZRvVhGBW1yrZD1hVQ/Ad+yMsIRxuI2cmeFmEgA8ASPyXBE+pyFe7s5V/JSDzpr+D+9vyxQVMJ+bSzeqrd+kWBbJAlclYdqp0jG5VsxHd7A5+EqvoIjI9co+6rfvm2VXCdH/7Eu4hNaxC2UG8V7a5YApJQHS1GIBeRv59L/CYoaFnPiZGAoEiBql7Kzh2KxE+KLyzIqP7JXQN2bzKH+TcgA86o3pJyP39iccT+SrGYCTjDKDU61QO21PoSq8uytwv8VGtSGUky9cfk/YA/yN1q0q55g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1674239183; bh=nF6E9ps3DfnEH0wGBLm83PGsRSSJuCfzeYW6gZWkCkO=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Ey4GOs/6z7k/rwRcCItCN17q7kUDuceg7sbCZ5/1Jz/av/BlspCj42QImQUgFW0dE0YaoEP0MSR6AvJfSXrhDuM7d3BCtyB09muA8+xCmmcnYK9MOgKaYMlXh6rBHBjfhSrg8mi0dmRbdkMvqZO9Beg8Pu3mNfuc6C3+SfVC1bX5sWLpoLidHPAG16DW46rX4Mu3WMw8DUPONzhai2Q9xwqvYACrVOesmtfFzNJJMd4LylKcb0/zVmQA9IxahCggZJHokvQiPb7H/AeorM8iEzDzVtqQrfaoF420p4AJwnfdGE+gWHiuZ02P/eFATyyzOcozZc3PjrYYgD768w+vXw==
X-YMail-OSG: JUmbcDMVM1lmKDej4tI0Es1Dec866RzjFka960gf2bG6lTTx3pkWEOwsBM7lCay
 lJAlqzvvmJutgc4ZuPj9jNhuPBtQLaq53c3dfO_KIGg6K7Ly3dprLUVjkyOBr4RI1CMmj5.Pktrq
 bvR.4K3ytyBC.nSJfV2b8VuakH7SNXrHccQjcVhaIp0mIZ52DVxqynZHfNJbTk0Ij_kkgx.btaKM
 MCbuXO6kpdg09drQRImlNy5mY525UCJKiIx8LKXrzzgoj4hFwAuUkFBfuUU0aELsj5e0fpEJduBp
 wyoGK8cU9g.0GjCEdcUv8Aqq1NgyDFPP8FVf3WeS5flPQO_joK_JxEbaksxT1P1TKkI6owPqbpvg
 VY_M8UAbSEyKBhx3JEsvf8Ogeia4ucwXgh9tT5NNsIdL1_CCRg3.nV_BIZxAHyMSkMkRuYk5lJR6
 .Nfj1AfQqRcAKvwBM8SYvdSp3VC.WEkFlPD3AH3pyJJpD9xqHt4lKQN0vtRySOwSRhtLjnje4NNM
 YVuA7.aMtHK3Oiv3fPfC5TzdmYAC2oTjxq.UcZxMx0oRic_KjbQ477r1yJlg.VfPJ.CoahMdiiBq
 NKBrp1O3xKBRbXh1IDj9FNngMMS366kE978rUB83gUAyEdIqOI16DVNTkZIIgDetRJmX6kD0HFrr
 VHbnsmKnh7od44ctQ4scDndsu8vmVQ2rxLTzalf6bhi0origywkjesATTXtxTe9n56j.JGJMTZEV
 mn88hO9QArAEVChiq39s8TIrMGIautUdvBbwcTVHHPvS_k3louaHlHuMg4Ss5Y.7AoR7TI69fbpB
 ybVUo9zEl4NXsTWiiTtAm1dNVvJfUxKEyOpAKmZaPJCtHgqn6_Dhaik9vR2mqPqHSmeACkJbV32m
 HoanYU7ORJi59uPEY5ySnVX0WfSs1lHiS1mJFi435dF97HyGcRUC26awdIu8SjUAZ1WCB2bwB57l
 8MYBPncUIGpWloqcWYj6xeGs57lbGKDMV0lU.GkoFRtl7lifSeKwJ4fTaeBhZrirdb_IYvBFJNF3
 5SQqaYF88IYW50r4wxQKLcsWDmuS0oXZ9Z8DMMIoliI51okCXPy7yuYheG0y6sVMoGv0AHCrYFdL
 __qGjBsNsRlCphrRHCsDQ1GiD5oFDEeYSebvJ8BotfaVCUZqueZNPo4n2Y8_kxRKCUUIILb..Q22
 xpgkPGp8ShW_6QMXM1h3NBE1n3WCZde19CxnN0YZ1kRGQKUS83Kt2BKluB7Ka3R_65XxaOeVF9oE
 UmAWtQIGDnVbbRLmoX5wXJKyFDBQswxKq_SSOIfUM_gYMARl5WoQNuZk97rnYEml2.dekRC6rU2k
 rDj1as9o.LuLxVGQVlQPh_Pa5adLHqjZs1mghGoXB9SmXYcNfqDKEHv5JDh3quVKbc3GkE4EU7n3
 6bj.umlfGz9ARoNGnup6HaDQ3x1OYDV6p7NCIDvywiJmdJPO8Q1u4DaVEtWtDmT6vY.QdGrdYmDh
 1VyG0f6WB5GCJIlt9NdZixDxhUlo9JKd1SP_EViCXObkWPFCj9FN27sx1tW8ZKWhrbkY.7nwPaKk
 6KOMQKhw2yi5qQDG3pbNnUSEWp83TSfUYbXZtmjI353VRF03h5caGG.ZOctwrNfs5Q7GMBF2zpY2
 6dXGkXJjJfjiJ5wD3yqT.sZ..n1b00kxiSomNMmGmTMbF48N8clrCER.lhUSBR1l9kkBHDuCTpF7
 d1LAAv24tS._phEwa8CFkdAsceaZQai_suh6nuqInsVNqUmJmm7QRt7y6PUbv6EVrUznUjq2LiMB
 I8joQsa3B5KG4cEUHHzOH7VIpcz0q7McPaaveYzgZGDAlOBRGWY7DV6SrFTBz01fpcZKZ4HMzBHh
 z6cevRMWFARF_BMUmvx.EoJI_4iEjd3vyN4RoKmqClg6S6FZf1AA1QR08sm8O82yZOjJDZ68LvlO
 E3HD9jtv7CVPu8CrKQX90Xyc_vh3n9FpkPhITqKitz2KtHn4zj.67OnYXc.miz33yXR6F.HsnkZ.
 ToFJvrSF5N3EjGuUeoCB8Afo8wT1pTnLaH4Vbat87CSEpC_dWt0nP4tm2NJ5lQYRCYr0QM.dACVd
 cR8gs5lnsmF0x9lZMFFg.aEOc4DsSh69WQ5RWhEIjfCFx24PJ74zVJ5Wfis9QXR60X_0BjWNC9Y1
 zbT3CP6LNwUcUfteL7fOmpCek9obsb37VPu5wsa8GIOwPcM9oMRo.KzP3mVE0GbRD1biw1vRp.H0
 Q6GckW9yh0G8xRMCEboTXlSSs2UAsoUjjzYWtKqBrOdG0vuDloPVPyvrI_IEKR47QKi3IT2pRRX6
 uNTdjK.rb37SBcw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Fri, 20 Jan 2023 18:26:23 +0000
Received: by hermes--production-ne1-749986b79f-rgmsx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e925b559c2c754fb5016bc30d598d72a;
          Fri, 20 Jan 2023 18:26:21 +0000 (UTC)
Message-ID: <2328965b-4a19-c34d-5c4e-f309f924d10b@schaufler-ca.com>
Date:   Fri, 20 Jan 2023 10:26:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH RESEND bpf-next 3/4] security: Replace indirect LSM hook
 calls with static calls
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, KP Singh <kpsingh@kernel.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, paul@paul-moore.com, song@kernel.org,
        revest@chromium.org, casey@schaufler-ca.com
References: <20230120000818.1324170-1-kpsingh@kernel.org>
 <20230120000818.1324170-4-kpsingh@kernel.org>
 <202301192004.777AEFFE@keescook>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <202301192004.777AEFFE@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21096 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/19/2023 8:36 PM, Kees Cook wrote:
> On Fri, Jan 20, 2023 at 01:08:17AM +0100, KP Singh wrote:
>> The indirect calls are not really needed as one knows the addresses of
>> enabled LSM callbacks at boot time and only the order can possibly
>> change at boot time with the lsm= kernel command line parameter.
>>
>> ...
> Then these replacements don't look weird. This would just be:
>
> 	security_for_each_hook(scall, vm_enough_memory) {
> 		rc = scall->hl->hook.vm_enough_memory(mm, pages);
>   		if (rc <= 0) {
>   			cap_sys_admin = 0;
>   			break;
>   		}
> 	}

That's a whole lot easier to swallow than what was originally proposed.

>
> I'm excited to have this. The speed improvements are pretty nice.
>
