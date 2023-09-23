Return-Path: <bpf+bounces-10699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F06C07AC459
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 20:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 065E6281FFF
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 18:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6B52110F;
	Sat, 23 Sep 2023 18:11:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC4E20B1B
	for <bpf@vger.kernel.org>; Sat, 23 Sep 2023 18:11:01 +0000 (UTC)
Received: from sonic315-26.consmr.mail.ne1.yahoo.com (sonic315-26.consmr.mail.ne1.yahoo.com [66.163.190.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE7910C
	for <bpf@vger.kernel.org>; Sat, 23 Sep 2023 11:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1695492658; bh=f7JY0QQJzun2xr22Ta9QICmi96dWMBEFpcxJDmdbcUw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=GHm/Ql+npb4WbkYWVm4h6IRMAiarssnv/rqC07PsuuloqT21oVbaCCUzzV8m6oScPsSQwkfuxzYuMXHOShzfdCKpgw/M04PeVv0525kEhVMvxpdSC+mZM0rVLDEsuxe50i7Fv/4eBENhcMQeZs3QlI1JruRtTckpbT8Xnuupw8I8ULZKpzZgLjOU0xzvBklgqodBvSKUqas3DOLZHkywVWFCM0wyZNxXnuoyeJrdREJRxir7qxvojipNl/TBk4PAPbpWEPAc11s1KqfNXwcFsX+OFbu2kWOZagQudyvhlMSktrx88tRodayz2hV8HEz63eY6v4Gqdw0j9tFAAFOorA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1695492658; bh=iJm8J305MTLTrFKDFz5qa+nUXvqyI5UxpGeIfzQ4/91=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=syA/WnV2m0niiq+ZHiIoRPe0XLy4nqH5Yo3MoWn4zbAZvoHIa84Xc5VDQbelW9o8uTYuuqAnDZyryZ9sEnmjJlC3yBG/QXQjHQivLy8Hlk6VTwPm/7Rg664JCoWMPMekXmOxexJNMSpsfDUWitjR1ixAhuAUhRM501PT9aClklz5kmDBrPNJH2jpvYEzHOLfubnghVHeN71XPxbKmRpQdLNMgNV0pOVmdwgRbxGiPCJnjuU3ZAn3y17Pyj2Vq2q047qKu1DY03oOJ8YUPwcbg2eVgZesvi8PutQVAN6CDAVCCRDoVStcidcUxyhq6m5NMHpiaO+4Ypq8UlfcF3fyGA==
X-YMail-OSG: uHqSvEAVM1nZYDLg4YIbm9vFGNGDaJoYoC7wEddzSMchpWSdg7zW8myJDWJ103c
 jiPjyfs5g79x7VC2g4jT3Qh.zuXdpGEZpeFsIoq.JJsoq88lsCcKQQxSG2.hCdo6VcMFpL9IJVSh
 tG7ONmDljzwXqziGWb0T4y9BN_BIc5VtLELXI4S4aEQLClboqXwVhhb_5qSUGzKq3hcRyhTFr6a2
 ZW3Ptfia..upsQzGEOjgSus5pHQkVZtxz0giQjTZ1Ta8VSs_Do0iuPGviCyPAtX8bAIYUEbGIkW1
 Da.Fb96qljhTtL6K8_gvDliFMZjiuaM12LnJK3d0lYXgGhDWXu5yRnA0y0GgvV02QFLH_ZPiO.4w
 h8E3I2eqnQtxKLHZQP_d8lvqUSC.9T6DgsdgO4B.JqXSc0hlXO2.4XI2rhDaP8oWbB8441X1O4w5
 7YqTbAtPVq2DPriOCjd7qrVHggeqRj7BpvKixz7LEfMLWCxvpOtniTH1PWVlhZeymvAh_KGq.w_Q
 NE6uBNLPuuemhytoguXjiEZVDgAMQV6RnkOu6HBpNvla6DVKyznQ2rIq_GtxEuwYggs_qnUAf8_A
 AyP8hl5uqi5ZPrXvb_ODaDa4cqrkqUZKnKAgW9GuVwqtc5ijXQ7saWh1SsANveaV2FxEtUEOZBJc
 1idVUNLN29FfV6Pg4m1DO7UDKeYlSDf0Hcbxbk7M.3r66ig4Wq5GTDvw_aYbqfaXxws2zM5mslPP
 vrQIuQYLWNc7vEKZcAj98bbe7Z9tvM2KvcBIPqCDaZM9OQsmK4fPhStv1DIB.kvLvbkZktOu_oW8
 gl77dMu5F4Mlt9S93cTBnHUh5DNHSPr7hZS9QSy2T1L2Kpv75_M8wekg2DfebY3uqIDDHoPN9nio
 XERmhBBsAfC3b9rLaSR4hmqAkeuBmRBFc_o3aVubPqerQ40TJvCHewSibbgGGRKppYPzNgOiT8a.
 AFWJN7kuVhU40bWgkON28AMdDqB7l8_E6y.eLne3KpBuuFr9GOlauKNI2ZRydioCJjEsS0txH6XX
 WUgcQbW5K0vf2S2WW.XVng5C0JZTnh_4D9QRy9.UK6q9.ZHffpuEjB9WN_EovlsC2vdTpuEv7skO
 T2Ild7p6eURX..kg7sSNkW6qOZ9wBcEE6b02q8HG40T8FXzvp_x63hL0VWhAM34yXyq3HQv1mg0y
 uRgLXme.JIMEiCnkWOI0GuV7heo6JHbYyv_9szd.0KvG0kaDVB8zK4xkpHudKwQvmW12O1BDJt.m
 Zay1m0NVjy9HD.hcJutjQxoGhVOMLMqF5dbFYN_nZjY.q0u1jD1C.ZdkD4qAQ80aJGdPYUmy3QGx
 vkxTaglE7QFCFtd.oL0xuaicsc.NL_TbMltyW7.BNEEFiqGfEoZJrjEQikYzhcCSNfZvaM70TRee
 raGad23g2dldce0UUPj7JOdTDSlpM.tLkinaQ8Ln1BOfgoNenH5ST_sbS6lmx1y6LduQPFIi8TOW
 0kFCBblO90p_.UoDkEqGSmxefChlw4fuGfGsakGzzX4w0gaupEAyEfnVr2sdv9za1wDL0XgxhrGS
 2gVSSjRdsiM.nVSbsI5gMWnaIFPyz1qb3rx.XwuyusUwQIN7mQZpQrRiqg0QwKqfNIWE8kJ38xgY
 Rnsm.FSI0e5cq8AjfIhF8acv6baP4BtblilUTukfgXuK3oiaXWveLWXbzREuTCKRx0wRDXupp73i
 NuNBnc7Uh6p79fGa2C7QaHiwU2FDouqUAY9NxEDNCBsIyKGc6AYghE0qfy_3M_dILYqDbBdDRjma
 OyB7Ot7TUameWJnbFmK6Dvp7mInx9VHwrLsLqNcuNwVCjR74jYNEKBPMK_6w5A03N2enCmXiH1X8
 rn5jVLF8WnfLB7gw7s8_WskO.in22GEpzyKug2OUA6yyJyOngWwTnve1QTiGeBYiDKgfcUTgqOCT
 UT1Szl6rpTuo1nFGZGksXWiMHikA0MoCuZzGPQHcLz55j9Q4jkj7YXZuuZ1dps243WUfE9SKMK4S
 QXO50TXFEbI9PPJiv2yEdBadqzNGsUVfEVHe5I5J7Vv3yHEpKAfwp6PjWdm1Htagv1td7St3kt_X
 mkZC9.mc.buKUkVEsp8pFaV18soBWtcBYGZP.PgV9YmaZSvdqrEY.2tOagNSENS9uMKOoQjzv16w
 0V_Va7oqRSZeI6IItMBr0Mzm4IfZ7.DkwKvQEV5NFfq2QPD9spdGPF3s9vDEa0XNudaFdzje7FBx
 0RDOUI50qwiwGX3llaXxgCDeY7PX64ubHkQ.9jKPu9kMZnaFUub37qBm02ncsW9_y99bJgVEbJw2
 8wryBQjcT8A--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: e48963c6-1a69-4abb-824c-8045c9eaa75a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Sat, 23 Sep 2023 18:10:58 +0000
Received: by hermes--production-bf1-678f64c47b-5k7bw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 26d11193dee3a4395e18ed1ff9a39ca4;
          Sat, 23 Sep 2023 18:10:53 +0000 (UTC)
Message-ID: <36c7cf74-508f-1690-f86a-bb18ec686fcf@schaufler-ca.com>
Date: Sat, 23 Sep 2023 11:10:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/5] security: Count the LSMs enabled at compile time
Content-Language: en-US
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
 paul@paul-moore.com, keescook@chromium.org, song@kernel.org,
 daniel@iogearbox.net, ast@kernel.org, Kui-Feng Lee <sinquersw@gmail.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20230918212459.1937798-1-kpsingh@kernel.org>
 <20230918212459.1937798-3-kpsingh@kernel.org>
 <cb67f607-3a9d-34d2-0877-a3ff957da79e@I-love.SAKURA.ne.jp>
 <CACYkzJ5GFsgc3vzJXH34hgoTc+CEf+7rcktj0QGeQ5e8LobRcw@mail.gmail.com>
 <dde20522-af01-c198-5872-b19ef378f286@I-love.SAKURA.ne.jp>
 <CACYkzJ5M0Bw9S_mkFkjR_-bRsKryXh2LKiurjMX9WW-d0Mr6bg@mail.gmail.com>
 <ed785c86-a1d8-caff-c629-f8a50549e05b@I-love.SAKURA.ne.jp>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <ed785c86-a1d8-caff-c629-f8a50549e05b@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/22/2023 11:56 PM, Tetsuo Handa wrote:
> ...
> The change that locks out out-of-tree LSMs (regardless of whether that LSM is LKM-based LSM
> or not) is a series including "[PATCH v15 01/11] LSM: Identify modules by more than name".

Please supply patches for your implementation of loadable security modules.
This will provide a base from which we can work out what needs changed to
accommodate your needs. I have more than 20 years worth of projects that I
hope to get to before I would even start to work on loadable security modules.


