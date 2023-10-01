Return-Path: <bpf+bounces-11176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 067697B483D
	for <lists+bpf@lfdr.de>; Sun,  1 Oct 2023 17:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D82BE281EBF
	for <lists+bpf@lfdr.de>; Sun,  1 Oct 2023 15:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9315517985;
	Sun,  1 Oct 2023 15:01:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8EDFC07
	for <bpf@vger.kernel.org>; Sun,  1 Oct 2023 15:01:00 +0000 (UTC)
Received: from sonic315-26.consmr.mail.ne1.yahoo.com (sonic315-26.consmr.mail.ne1.yahoo.com [66.163.190.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19B0D9
	for <bpf@vger.kernel.org>; Sun,  1 Oct 2023 08:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1696172458; bh=dSdWBwbZMs1asO/s7xDDjMKbztpyK2MifnBfT0sV3D0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=l06K0VlasQwdaWu+hSRaIRMbgJFpCZP4SuzlejS+een/NsIWYCUEBfoIFsOutPSOQzz/38QigB3T+3CwdMujwsJL92pwnnMKBGXOEyp70v96DPorgcjPFI/owK+j+WtpDdgJhJIKiLi3v9uMDoGxUR95gAED3pYRY9L3r2VZfjew7X8qgH7xsgJCqXh/Dsf/V/GlrjbkKXERrHiSxh2YXKcXHwG0R2bkPjZKapfcE2A8pZa2gauHTjHuOJdY3fFKgK5a9YMfqrdKTGpRHKJPO5vNsH+I+tbx6CqX0nttZwujrCdL4UcZXnJimrZ4WkDEzqvVSw5YyWMuxGltlVV8yg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1696172458; bh=+qZF+16iXT1ca3AzJvicWqAXhx72Fa7qBnNt0Loj2Y0=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=r7zmJ/A6Ifp/YYhTtdP9fGn8YdozpZiDxmmWMovdQex9feP2eFdffWcxqXbmObAufqpffhIYEtosyv5O2+ctsQipzYUUZXOcT9Z8xGsX5BwrPingkgaNP18b6qzEq/hXbUsdpVBbDUJKkGxzhmbDFkdlpVEC97KOO5POUqU6pTczqX5J1SQ6mJk2q7DhTKNa8ptyNyUK/6aVYLCDP/AzZR+Tce+cm0sYk0ZlA+wYgKTPkRISzGbgc/z9vAVV23qHHoKG8CyTBU869fI9Dm0NTInMMLNtt81WL2JRz73mTXrsva7UlB9MrvklqYn7vIW7R8kzVYvTDyKMFXp4vkAEIg==
X-YMail-OSG: nv1DZNQVM1kpsqHLFrV132.pQI6BAeGsjYZxirfeJpwU3qVm815PGLIgVXT.h6z
 RqurjYC4RxrnOgUoaua7cvQW3Ab2sr6HbRV6.uj.JftebTMXuXYBZr63p5Ux9D6OS22MC84pHrZX
 iqCduMcawYgLyFVWTFXt8eNHs4URkzLUekqvyUmx8b8HYrUPiotCZV2E8mjXpJ_RgbTH6IWv4Vwf
 W2V.bsLxtwMKl._.bms2TpqV5xBkm9WQCpfVqZC5LDJyvFZlQPXjmpSrxNAAL24hK3vloBz6m1sk
 QsGCO2NivESinxyw.P7Wc0jE6s5ycwZr6YC5Wk_27QLZGKhTcCQtg1s6MhlAZA0BHO8MDf3Hbaw0
 VxjJrlYQVBPhQXRDJxMNaiH41KgmwZGPuxMFjgWlc6mTgmZ2UsxSa2_pJdXnLNxue2poRSJ1FfCT
 IUxCRwz0V0aLbDLs9ojBMlhRe5S_oi5.1tgfU2V4B4kCJJv9salIjhyk.UyaZlZbn0.MPjCVVTvh
 3icyqhzAzDlroQsFbRkr4tuJGAeVbxDHdaNDilBuYFRZoTNQJnoUuTnPRVEq7dmAuMP5XvU8OfXP
 e7fY.xYLLMzPrQtiwqwY9foT.E5IDlI3DLhz0kVrEqQyDO6I2QA8.7i8nXd2aLJv5lCY_5lpb_UO
 bNn5mmuCh6jMJxbQeMZzaDhskRmxD2cTjkUsUUp4F2LGdQu70uz9yuKBbajUvVfEc7cjlJf4e7hM
 RVd7WiIoE1.M81EH9LCHsDjjktT_PPHVetZ5ZRD_g8HI1OH1t.EcI8U0b7ujrATIJBnl9sayLQSW
 t4xLUMoHbbqtRv41tkUPRpmgeKWV4nyBClHiTF3Yhmiauo47kMOunozuQVkeraGZMRSKQ88qEACo
 Do4DoPpwar1VBmXjnIT7f36772Sbud3XodndtRNLbtnEjf1OLwI05CseAXD70zxTwdOfS_r5Rn0c
 A6s3qY7GL_KEORx2U9DSe0YYh6GE26h3AEFNAqLff5uYEdLnlsuLK8bHk1ptN.EdPT5GqksEbgzp
 hv1zmFoRS4S1AP6KCWWjnY70jYEAwbyT3uIuRra4rt3x8fD3oEfq_N1.Ec3zJRn_hYvqjUklk3gY
 tLsozmzGJUo2W56lIieB8ygQm4hXRj0vxHPZpB5KXqdj7lP647Xk0Dqv1kVTXc_lUoQWXPaIJnLi
 .d74qvJBFmRvRYT6TCOExrcU63o61CdrD4EYXx0i_KC8pRKlPVucy64gYAiL0dIqji.AHhBAVU.C
 272dfct81yOp9qStopi8d8GD6e3A0qI1tXcEjFqz4tUJVjzy2KXWReg4bpknGnsrBJ2XDSpJczxE
 5siilEsnLN7o50HyyCrIWEHtTYi5d3YS2pNF3pLYm8JND5x2P5HoYT70trQ96omCo6GApqKIezEq
 oqGtEtNvaWgK9RgToawLT28E7lzxSP8LvYlfD2GtRyV.zKQvM9qQyG_0jtN4hIFYhNS8jF3NvQwZ
 RTre05NMakLWYIiNM2cEzBHBUYk4ErLxQdSqvpvxqWMhD3giQR9U6pQpVXX852pISaM2ATzu4bDX
 dD8JiTtEyk24B1Xio6XrUvm7h215brVuWLgLwxZIsRnDTUu4.ESKPov9TdTySET2zUsDN1WY258H
 hVuyvDKLPANwtDb4.WBgtOYaj.vLDmTnCGGz.ySzvT5PWM5x0B_6Udvqaj50yfm1l2vytyYZ.xiM
 vniENa8EtP09QLxz1Y2dmH.nalmm8nhXHflxsGlyZ4CmPVIGLPLt3haW5tfWXEv6vmiBBi3TPU5K
 pQzxWW4VWX.gE3WkgXn4JFU5wPvrUPEW4eDcWbZbeCLLMBxfkS3B_V4o.iAdGDfqvtaTaF9ZBUUe
 ruhySu9HSk0O9_nL.aihDkeLKyLBNE.UKKLm7hi11.7jhz3VgYGamMVaqYlct9k6qgN2HP71ov5M
 YaGI7XYX18XZpoPX9g7HCTyNzAdJDVQV.qVBftjbBCSPORBzVuAMrEhaX2o3r0iRTxA_86G8ynr4
 3cb_5rajT7uZRlIlLTCqHanph5d.SmUy6ulnlB5MbXXfZp0bl95l0Wze8uvXsZmFUImzRiqfrbLS
 nA3nHQVdwQaEWGPkTHrqV9D.mdLxv3gFJ0b2xt7GLD7uvIpu6HESdDdZsqlXOmM4ftI8020hvW_l
 EzZx__.Oy5kWoBKpDF0fucYyTC8oH9f.fR11zYTUwieJdFIxASgKzlw0xlMZdI_Pg.uN7zT5CPip
 SKXW9OAnhdboptymEkH3sK73ddb1MSTYDcbLUPqc0TtvTE7.FyCMrdsmM6CtyO8TSjq98t7xBwba
 W_NHnHgd_
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 20fa143f-e6e0-4b10-850f-80ade4349e7a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Sun, 1 Oct 2023 15:00:58 +0000
Received: by hermes--production-bf1-7cf89fd98c-8m4br (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c60e63cfe2c6f03191142839472b68ee;
          Sun, 01 Oct 2023 15:00:53 +0000 (UTC)
Message-ID: <d9765991-45bb-ba9a-18d4-d29eab3e29b9@schaufler-ca.com>
Date: Sun, 1 Oct 2023 08:00:49 -0700
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
 <CACYkzJ4TLCMFEa5h-iEVC-58cakjduw44c-ct64SgBe0_jFKuQ@mail.gmail.com>
 <6a80711e-edc4-9fab-6749-f1efa9e4231e@I-love.SAKURA.ne.jp>
 <CACYkzJ4AGRcqLPqWY65OC778EPaUwTBpyOMfiVBXa4EmnHTXGQ@mail.gmail.com>
 <c1683052-aa5a-e0d5-25ae-40316273ed1b@I-love.SAKURA.ne.jp>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <c1683052-aa5a-e0d5-25ae-40316273ed1b@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/1/2023 3:51 AM, Tetsuo Handa wrote:
> On 2023/09/25 20:22, KP Singh wrote:
>>> It is Casey's commitment that the LSM infrastructure will not forbid LKM-based LSMs.
>>> We will start allowing LKM-based LSMs. But it is not clear how we can make it possible to
>>> allow LKM-based LSMs.
>> I think this needs to be discussed if and when we allow LKM based LSMs.
> It is *now* (i.e. before your proposal is accepted) that we need to discuss.
>
>> One needs to know MAX_LSM_COUNT at compile time (not via kernel
>> command line), I really suggest you try out your suggestions before
>> posting them. I had explained this to you earlier, you still chose to
>> ignore and keep suggesting stuff that does not work.
> Your proposal needs to know MAX_LSM_COUNT at compile time, that's why
> we need to discuss now.
>
>> We will see when this happens. I don't think it's a difficult problem
>> and there are many ways to implement this:
>>
>> * Add a new slot(s) for modular LSMs (One can add up to N fast modular LSMs)
>> * Fallback to a linked list for modular LSMs, that's not a complexity.
>> There are serious performance gains and I think it's a fair trade-off.
>> This isn't even complex.
> That won't help at all.

This is exactly the solution I have been contemplating since this
discussion began. It will address the bulk of the issue. I'm almost
mad/crazy enough to produce the patch to demonstrate it. Almost.
There are still a bunch of details (e.g. shared blobs) that it doesn't
address. On the other hand, your memory management magic doesn't
address those issues either.

>  You became so blind because what you want to use (i.e.
> SELinux and BPF) are already supported by Linux distributors. The reason I'm
> insisting on supporting LKM-based LSMs is that Linux distributors cannot afford
> supporting minor LSMs.
>
> Dave Chinner said
>
>   Downstream distros support all sorts of out of tree filesystems loaded
>   via kernel modules
>
> at https://lkml.kernel.org/r/ZQo94mCzV7hOrVkh@dread.disaster.area , and e.g.
> antivirus software vendors use out of tree filesystems loaded via kernel
> modules (because neither the upstream kernel community nor the Linux distributors
> can afford supporting out of tree filesystems used by antivirus software vendors).
>
> If Linux distributors decide "we don't allow loading out of tree filesystems
> via kernel modules because we can't support", that's the end of the world for
> such filesystems.
>
> What I'm saying is nothing but s/filesystem/LSM/g .
> If Linux distributors decide "we don't allow loading out of tree LSMs
> via kernel modules because we can't support", that's the end of the world for
> LKM-based LSMs.
>
> The mechanism which makes LKM-based LSMs possible must not be disabled by
> the person/organization who builds the vmlinux.
>
> You might still say that "You can build your vmlinux and distribute it", but
> that is also impossible in practice. Some device drivers are meant to be loaded
> for Linux distribution's prebuilt kernels. Also, debuginfo package is needed for
> analyzing vmcore. Building vmlinux and distributing it is not practical without
> becoming a well-known Linux distributors enough to get out-of-tree device drivers
> being prebuilt (such as Red Hat).
>
> Again, you are so blind.
>
>> Now, this patch and the patch that makes security_hook_heads
>> __ro_after_init by removing CONFIG_SECURITY_HOOKS_WRITABLE breaks your
>> hack.
> Like I demonstrated at https://lkml.kernel.org/r/cc8e16bb-5083-01da-4a77-d251a76dc8ff@I-love.SAKURA.ne.jp ,
> removing CONFIG_SECURITY_HOOKS_WRITABLE does not break my hack.
>

