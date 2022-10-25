Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9C660CFB7
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 16:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbiJYO6F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 10:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbiJYO6C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 10:58:02 -0400
Received: from sonic308-14.consmr.mail.ne1.yahoo.com (sonic308-14.consmr.mail.ne1.yahoo.com [66.163.187.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDF519DD9E
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 07:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666709879; bh=JvE7okqUEhv95RTvB5ufWhFFnJ77ib/Bj4DcxAt8Wp8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=FRHuQIAIDc19wNOLQHQyprOh5m8IJpVL9BQp//wH2YKxKKuIf/0nPFf/eKloZCPH1GZ03FSP2+lQJ3zQLXEa0Xx1RPRhaPMxS3EPjaA63uYmdSDWkGnqTsxHt2EBEhvPimbjmfjou6/sKRHZ+ZFhFc7xlFeYjr+txUAv/fuWsNNVpZBDEc7jY3Ip34yPEBd58bhKoxWWN+E9lC6QQH32YIChgOSy+fHRVOtdQKHUoRzefQttfwoEcICOUmjX2JqXb3RlKJ3zCqJqr5lXizBpBx7wWAI2Kn5rUnuI5teKp87u1IrOvIsbA1gCVcaUSXSnP3K9nIMgInVX7fKd041iIg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666709879; bh=hkn6GihvHJvk/GCOoXjb+LO+J+9CEQZ+nH0oGBeB2JW=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=XbOQ1Hv7OCL6JxhdsapzvIFED+sBnb1qwCrGJvGiuEw4owDSC+02qu2UuRHsCF/6YFrl6Z5DR6IXvzKadSAbdTOj/8Qtz6EPOugxN5gbBGtszw/L8QFQ+aHqORWkhvlYtbgH9vFHoBPV7fzvQtWrDmxzol4w4Un4nYcBPkUB3ji9YxwtrNkQfQTUq9R6ovOjEjVybgMFYQ0nRYAJIZdL9zbCFsz8aRjPloTJ59eFO4A7UqT9Az+yG3AdUJ3EuwGaVPhtuyP9PMrqTVcrraotVUfIBUPQ58nEIm4uJ/qhbR5KCueii4mgBp2dTXnzOtMTIBbsoFdaR/IM7pZnWPPwYw==
X-YMail-OSG: J8Nqcf4VM1m2f6USkbHItCRE9VcMAWq5cKkL4pts8m8nTJ5OOfw53yAjHsqo9Yi
 0Ga15fFXPruxCjmQIvhnlz.cHKIICr94ono_8ckaAWjHCDjriVcz_iLQ4g8_XUnPeW0HBzK_QOk9
 3fy44bUazsMCon6Z7QqGycpyNo4WZV8.g_aGmgVka_xwYeUzBae8q2ZNG7KP.NP.yUviRmqmsIvM
 pqobBHAq1v9tl6RRKQwd2DhthLo3JVPsj2us8smpeU5Ms2sSwf2azTftj6_I_RnaJ8ocGRx4t4H.
 su07Qd6Qoc8To5LxTyF5KlNtw8N2XmdzrGflSVMaud65wEFM8uknhCRrb1PObGS4DO8RiYUlxbmI
 XMQa_GLzTWDY7x218u8zYwv8mhTUZjMONZlKdKgotX0xtTq6YUQ_MIql4QLplvUW8fqWGBq1hct9
 kbt54e16LPnhrO_YJdYg27oT1yxRt2l1Gc9gCC_AZB6wawd4a4A30Lw4VGrTtdANMD1E3mnICiUo
 HLx.Dngmcfbj.AXB0BdIHLiL2XBUoNoD6N46oyNLbdKoaP1VcBHNzJUNk1yalR77VvPjnCPWPMF9
 89a0tuj2a9D1L_9fVJguVOwUNs69Lm2jcSpqHpVZSvHZFV5LP7GvusqdRz3pjwOeNgB4J4iv4K1Q
 X_BtDDDhvZNnIdaODN1cAnKOVRKptIdXMx9wwN15dAzgiSlrcFu_TTO4NUL_2yrgWe3vQdAKx6bd
 YFwx2QpIIf_vuU3t9rjclTk8Mq7IEO6sc.v.DQDBIc3FMKVscYeFyHXqaf5YUbQ3p0uVwdNf3bt_
 FadZ9YWeewWPNmwjvPg1Y7Q2dcHMWx850cgRBHHITPFPFlYKSMaxxtNgcLeSDxUaMiFfa6h_4TTc
 NyiBYmktKQ3VQ8cSQ4hcQQymC6Pu1yHVdEzz2PJ2cdJtZSyU_7f4tnrPbYdiGffJGBE5Id.tmkXT
 x8SoZeUpi7hecY.MyzPwRoKcbU9cDJK..JaedDHzgy8Ezs_oXZXd.f9FGyFYexgBpFV8Apf386tp
 l5RRkS58bCQ.M_WUpXKIlwG.sfLXYEF_n0edyMUEBTsOry_6I88.PzRpZ_yHC0MZDniD_gD9dEW9
 dhO3ONCTZ_mxisZEj3J6q76lGra3MQnDNknH4KQVxDP6YUIteTlZQyUPETeZ4p8RQrkV5riMO28J
 N_rr5kVa36iKFK4aoROnRCFKN90CH.9qJ1v0Ud_wd_RbSdY7x5mXIr_FQSrURcDUedWTeJLcY7YZ
 cbxBFAlqvfC8pQErCoe6Ipdzr22Th3oxpbBcompPCkCDO1kBGzI0CcZB7frI2_0T6BagfNQmzai4
 d399LTdM9ZIYEr8zz_iVFJ4hfFvRUQZTQPshr9p9d6_YM4qmDtU..kAFKiwABZ.LPsxAC2Rne77t
 aVgKabDfquNG5O2ffJuJKuz1gX0ZyKB_AZVRLaaivjA1HwjBpN3oztBahhOHeRgH7htRKZKQkfDJ
 mosskYPgjMWUCDcCGRC8.YmN5CKD9BsXrCKB7DIbSzI4BuFyfow8ENSrF7QA87U8mPc6s3VRX0yl
 bVuX_UtqGkvCcm_J6qdVY0OZ374_yzmYCE02S026PLah9S7L0.hjQEuS5xG.Tw4L0L0fteGpkaEm
 PxBWRnWxECGw3rZbAta.tUEm8YBoHa1uuqea3rGVwAuTncxkGnfGK_XztjfauuiN2kTNlE6509Z3
 dQdIbwYAD72xFdnLsP02YDoULvbjfYUEofem8rNNqm33cpvAv4pK_wdGnGELy2NkDBTRTAE4uYKB
 lDNYKCaeYqenKN06XP1AQaJijlE1jsgdTHfHNBlGiiZ6No33T7te9Ir5AOd1dGOnYyG1N3qw3sXJ
 tihm7yR_Hon_piZyu6A5oVUyMlbZCCnEVhpjAs4_6WCA53r_08Gu5KNdIemO8CUDFWKL_K5U4Koj
 bc2G6NWMd9WkSYVrISzUEkiJsLAMvUPCg4SkKwuvR8k1IFrvA6qeFbFgurDNn5SIqosB4_91Pbuo
 HClG5Pzg6FTt5vmtbxt4j_dSMwO5I6RJHS1Ta4EQEMHNs7tzU4ei7gJh0oAbU0J1xCthMrVBcveK
 sVYVuSf6xKpDbmKV7M1MYoPhoTFc_HB0ma_IDhrBD1s92yJIpnPlJaqrTubsXLJTTTF9b6wBDzl6
 912704aAkIJfYMzbSmPnB79e_TAUQsKQPwGTtIbLLCKpa_54rnOBTjyhb9BTAF5dIViDRhb.JCnq
 7BbjyeMuX_1DfBzl3lzS2CF_DijuQF_B8XKqqlB_FsmVVwuRQKZ3Eir0LyIKLOq2TD7jVgEy9DS_
 Gy0QIFfduNkPuEVhXJiHMEQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 25 Oct 2022 14:57:59 +0000
Received: by hermes--production-gq1-754cb59848-zdkt4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d7658428b5132a7c8246ece5d283f1b4;
          Tue, 25 Oct 2022 14:57:56 +0000 (UTC)
Message-ID: <ffbdcfbe-0c63-2ced-62e3-a7248b7a24f0@schaufler-ca.com>
Date:   Tue, 25 Oct 2022 07:57:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RFC][PATCH] bpf: Check xattr name/value pair from
 bpf_lsm_inode_init_security()
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     KP Singh <kpsingh@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        nicolas.bouchinet@clip-os.org, Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        casey@schaufler-ca.com
References: <20221021164626.3729012-1-roberto.sassu@huaweicloud.com>
 <CAADnVQJHDboosqTy5LTHJtJaWJCWn9rv09jmd_sMgeV_OVQjGg@mail.gmail.com>
 <d7a17e482b7bbf945c92443b45de73f56afea08a.camel@huaweicloud.com>
 <bb7a5986f3d25706269d0fec9906ea73c174b808.camel@huaweicloud.com>
 <CAADnVQL1a2pPAJqzj6oUwupxxfaW38KQswzppAZeZPzmTFhjMg@mail.gmail.com>
 <98353f6c82d3dabdb0d434d7ecf0bfc5295015ad.camel@huaweicloud.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <98353f6c82d3dabdb0d434d7ecf0bfc5295015ad.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20754 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/25/2022 12:43 AM, Roberto Sassu wrote:
> On Mon, 2022-10-24 at 19:13 -0700, Alexei Starovoitov wrote:
>> I'm looking at security_inode_init_security() and it is indeed messy.
>> Per file system initxattrs callback that processes kmalloc-ed
>> strings.
>> Yikes.
>>
>> In the short term we should denylist inode_init_security hook to
>> disallow attaching bpf-lsm there. set/getxattr should be done
>> through kfuncs instead of such kmalloc-a-string hack.
> Inode_init_security is an example. It could be that the other hooks are
> affected too. What happens if they get arbitrary positive values too?

TL;DR - Things will go cattywampus.

The LSM infrastructure is an interface that has "grown organically",
and isn't necessarily consistent in what it requires of the security
module implementations. There are cases where it assumes that the
security module hooks are well behaved, as you've discovered. I have
no small amount of fear that someone is going to provide an eBPF
program for security_secid_to_secctx(). There has been an assumption,
oft stated, that all security modules are going to be reviewed as
part of the upstream process. The review process ought to catch hooks
that return unacceptable values. Alas, we've lost that with BPF.

It would take a(nother) major overhaul of the LSM infrastructure to
make it safe against hooks that are not well behaved. From what I have
seen so far it wouldn't be easy/convenient/performant to do it in the
BPF security module either. I personally think that BPF needs to
ensure that the eBPF implementations don't return inappropriate values,
but I understand why that is problematic.

> Thanks
>
> Roberto
>
