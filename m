Return-Path: <bpf+bounces-3285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDED273BC63
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 18:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE8DB1C212AC
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 16:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A06100B3;
	Fri, 23 Jun 2023 16:13:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADC1100AE
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 16:13:57 +0000 (UTC)
Received: from sonic303-27.consmr.mail.ne1.yahoo.com (sonic303-27.consmr.mail.ne1.yahoo.com [66.163.188.153])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A761D19BF
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 09:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1687536834; bh=dleOjiy+EWKu1IA/tt01waz8TH37kiCZcuPZ4bSsdM8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=XIsglR+6dR8s9nMrwyeKdr9p3Oz6YaKtXjSEujhPFBwN4plipQ0I9ek4jkb6tuDCBYLOcGnZpV19NZJWGLMr5GlyKWQ4GDwfeGuosVBIrVfyGDdVvUffaEQ/+NjDfiJZfuSHgKvAaFauMFppt0KmhOwifZXd6jCEzupDUF0Ck4h7SWOF6QX+TJzatTJE46FeqI7USdU9kK9jBfhLlFuAo4jd8v+UzhbmT2itO+Q+/V5AkLEvsVW1+2fn9jMnPdzO9KsgOldh66Ye4EcVx7KllTUv0QTOXL9uM1TpqGsdwBPg3jxUofYlXuNTXdM5nikcNGp+QdcUf1eywI0wrLllcQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1687536834; bh=ObAfRogmZB+JWmr/DFsw7WUGBHsAB+bQLOxGjYJfLB+=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=JatIncfhTvb+2KRqk+XB7BIiEi89FuzED6E6om0xIf1WP6aJC6rQseE4wKNgrI2l2eEij1L7+xLL0GyN8PQpfiF0tXF+7aKfSQqw504vj43Wq+QPYh6oTSBwnq+1IJd2oBR6c0vyzleqdkPsPuJ6BDdBTPF50VzMfWE4fkIMzl0evw6z4F0sIFWbP/eO/aLE71JFMmqhEPVVPDBYAltBfa9Z0P5xxxr6eCfR1e1fxXJdOd0Zc1tkgVg8qLcsnoc6NmxZFn9/QgJwXCzHaPuZaaOs6oHWY8VR/AL7tAOxa+UY22skowiSkLjKNWiw48UHKVkhqcfEvET+umENpxK+SA==
X-YMail-OSG: aG6pKi4VM1mqJtPt1Fd43evXGhkChjyuA2tKw5CgooQPR17BMaAjbqo6zYimGGf
 YYNzUOHd7bsUWgAqfmVaqCRQvYIDx_Nean3w3PilbTC5oE23pJE0FK9Y6_7hA.uc.1m6JwH24fhZ
 xPXA9nTZk.Fi0laVTEkEjh8FCpneI5gqmzkGXOe9JR.qXwrEXQgWq0BMYMJ_zaeEzLY4B5xETv1S
 5MVUneFrBZsYaImSr69VgFHbNgvtotzWah9RgQyMPvmeZL6oH3U.e6D..qiIQ9svioD0BiyTjy6K
 DEIYJB.pI_RILrywQ5dh3KKJrMo6qgGHT9Kdr1si_kJcCencd2q2E3O_.gClW3ipBS6J30dmOAev
 YUSe.T1GpG1AbaZD1gbQQwIIDiKxtBoGbZ0IDApC2L7lewHpgPLcYCQNmKFdzVN7475O2X5ZAE6A
 QTnJ2bcp.0IrMmhmDpWCESmWof6vj3uskwmb.GeotsqdCpT9fb6Sl8TBNTljsR4iLAM18RoEloGZ
 wFhzCPD31o6y8tQ4yq1muV31UljiKTtjA1xoE.gnuakBXZ6lzSZn1GocZeeC5eoqjbavd1M5_hdD
 JBQE2SosdjMbHIPnZaG2SWGFKCSf4_.v71TfmKI9sLrb5MswmWYNGRfw0gLoGcFKaOOp7Inwblp5
 RUCf.OEtJukHmN7AVbGxL2zmkUwcsNFaPk6wnzfnGcKMIk43F89LKe5EsrUQfbrjNGr6Vhw8.NvJ
 0vecDtoBBO1FAHUbaXVEwMZDoai.Sy411NrQaZBk6ZA__jiCJ7RHcfTCLdAVpzaeb4rqSZLIi0Zd
 biZOGD0W5mcSScrO6jVzxCEd3EZhr7bbR3QEMokxOH_BOPznEylXk78OwN4avR.2bqp6I8aU00Cv
 cddvEB.XIgjghanCVixinY2TMjAJAi7nydWg2AR_5T4ezKgfenAFfmPoK8zjbuZ.8hBrWdEAYTzk
 gcUoy_wCp8H3hC0w_fKTN9z25g_1C17xakjjiq_9IhikJLxL6J0RbdnmxxPTr2.9DdWOtotUoZcX
 iYuVAZv7VQId3UEMvNJGOVTMU9gyHP58HrbjE3_KutiFapMtkzaLQ_3J_6FuL8pxNGYeL7LHwcju
 VFDrnMgiBgsbuVk6EgSx_Df8zPxIXE4XptenAx6Io2Ge7jCRPx3SaC.MUBrEk3fSTxb9XmgkEx3n
 a37fr9pn0Rlzp6DVihxqRkn_mjNtGHScvB3kgUqCpLGGIDV_DOdp5Qm7m4EgGx4Et2TGHDxGeW3u
 af1XOJNnc45ioJwucvs3kgpURTSg71NC4oBrqb5ODNF13Gpi85C3ZClPMWgtQyTOoSdirJuHGcT_
 9yabtb1rMM4J_UEcpL8IW6jBea_hklrn5r5yAoD94nQ1vTuJHdMlGzz2GYy3Sh4WkuResbXYdNs0
 qo_inpf56CWDP850p4mKZq9JdG2tEaI_1cKh8ohbUycq67nZPva1PjCOnrI75EV6Dbj.hDIyeehp
 lpsC.Vv_U3Uk3N0ylaxqT8eKCvPPH_82twkj9Zt6iG6Z_NdaUaXCzKQwL5PZx2TtkGSgL6ot80kx
 fyVrbX8uhj6Twsr8MRbKSAq4IRt8WH1EnAYDiCBAp4lbtHp4izpsmwWWf0LeCnmEl0Li7v2KhuXJ
 a.7BlpTXGl5N2l89posRxvJ9g5EfSGGCmnO2uEfDGQd.XrAIDoAWJtCuI8rys4FssB6qLMJQwkEZ
 ek8T1YWM8UT8c.f.rBFZpNVwfu4W0Vgw8Ceb6t6Tn6wRhXM3_GMOXokZC5kwAQldBQO9S9KrpKv5
 _QGIO5Sry0B4ej5LbR3N2BrFsqD65kEaSMbSSshwOs88SsVhGUgnh5Pi8xpEQicztD3w0_ubTa9Z
 qXkHz7CRP_rD2WKMdmdGR6_ofeWYcSBuOf73LQqar38fLwN3sVms1kJ6_h3rLi7C2jKcpbwSm2fI
 DQoyIxt4njjyxQyyNg1SV2jcAy8x1QrBXHtQSeVs4qaEx_aSi7mKKqEhVsIiUaVq8RLSOECA2UIj
 MHz7cSdebYzdgPwG7w5CO1CLuV1EmjqnK_QZzpombopJ2BTgO57oF9.DmaPZPetLmL8DTaGIrONX
 w9Xlf9I9DOsL7Zllwvhms40a9iqqwPm.NGg8twI.jKASc_PFsLGTm2ZzFN_hA46_jZF2wwn.35N1
 Cr6OZrnKpDXOXyJMp7MU83kR1zJjt.4OArF9orBaOPca8jqTaffetzKPZ9D36lcl_d4KXeNqTajL
 .Tr9cZhuJHvvfyt8cD2YMDnO.wTJPJzUB.AbUdFJv_1l2DBVdo6HRohijpwtHcyfUYMUE4arIcyH
 EFvSsRh5gOuIcnLw-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 4d2ceb33-228c-4999-96c3-10d3ef33e13a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Fri, 23 Jun 2023 16:13:54 +0000
Received: by hermes--production-bf1-54475bbfff-xh8w9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 53c6aa7ff0a5b9e90ac8fb0190892cd9;
          Fri, 23 Jun 2023 16:13:53 +0000 (UTC)
Message-ID: <741f2fee-984a-f607-115f-cec3ec422b2a@schaufler-ca.com>
Date: Fri, 23 Jun 2023 09:13:49 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
Content-Language: en-US
To: Andy Lutomirski <luto@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Maryam Tahhan <mtahhan@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
 Kees Cook <keescook@chromium.org>, Christian Brauner <brauner@kernel.org>,
 lennart@poettering.net, cyphar@cyphar.com, kernel-team@meta.com,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20230607235352.1723243-1-andrii@kernel.org>
 <c1a8d5e8-023b-4ef9-86b3-bdd70efe1340@app.fastmail.com>
 <CAEf4BzazbMqAh_Nj_geKNLshxT+4NXOCd-LkZ+sRKsbZAJ1tUw@mail.gmail.com>
 <a73da819-b334-448c-8e5c-50d9f7c28b8f@app.fastmail.com>
 <CAEf4Bzb__Cmf5us1Dy6zTkbn2O+3GdJQ=khOZ0Ui41tkoE7S0Q@mail.gmail.com>
 <5eb4264e-d491-a7a2-93c7-928b06ce264d@redhat.com>
 <bc4f99af-0c46-49b2-9f2d-9a01e6a03af3@app.fastmail.com>
 <CAEf4BzZz2yOkHZSuzpYd2Hv_6pxDJt2GdGVnd3yG8AUj0tSudw@mail.gmail.com>
 <56ede337-4370-44c7-b461-806dabc6feee@app.fastmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <56ede337-4370-44c7-b461-806dabc6feee@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21557 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/22/2023 8:28 PM, Andy Lutomirski wrote:
> On Thu, Jun 22, 2023, at 12:05 PM, Andrii Nakryiko wrote:
>> On Thu, Jun 22, 2023 at 9:50 AM Andy Lutomirski <luto@kernel.org> wrote:
>>>
>>>
>>> On Thu, Jun 22, 2023, at 1:22 AM, Maryam Tahhan wrote:
>>>> On 22/06/2023 00:48, Andrii Nakryiko wrote:
>>>>>>>> Giving a way to enable BPF in a container is only a small part of the overall task -- making BPF behave sensibly in that container seems like it should also be necessary.
>>>>>>> BPF is still a privileged thing. You can't just say that any
>>>>>>> unprivileged application should be able to use BPF. That's why BPF
>>>>>>> token is about trusting unpriv application in a controlled environment
>>>>>>> (production) to not do something crazy. It can be enforced further
>>>>>>> through LSM usage, but in a lot of cases, when dealing with internal
>>>>>>> production applications it's enough to have a proper application
>>>>>>> design and rely on code review process to avoid any negative effects.
>>>>>> We really shouldn’t be creating new kinds of privileged containers that do uncontained things.
>>>>>>
>>>>>> If you actually want to go this route, I think you would do much better to introduce a way for a container manager to usefully proxy BPF on behalf of the container.
>>>>> Please see Hao's reply ([0]) about his and Google's (not so rosy)
>>>>> experiences with building and using such BPF proxy. We (Meta)
>>>>> internally didn't go this route at all and strongly prefer not to.
>>>>> There are lots of downsides and complications to having a BPF proxy.
>>>>> In the end, this is just shuffling around where the decision about
>>>>> trusting a given application with BPF access is being made. BPF proxy
>>>>> adds lots of unnecessary logistical, operational, and development
>>>>> complexity, but doesn't magically make anything safer.
>>>>>
>>>>>    [0] https://lore.kernel.org/bpf/CA+khW7h95RpurRL8qmKdSJQEXNYuqSWnP16o-uRZ9G0KqCfM4Q@mail.gmail.com/
>>>>>
>>>> Apologies for being blunt, but  the token approach to me seems to be a
>>>> work around providing the right level/classification for a pod/container
>>>> in order to say you support unprivileged containers using eBPF. I think
>>>> if your container needs to do privileged things it should have and be
>>>> classified with the right permissions (privileges) to do what it needs
>>>> to do.
>>> Bluntness is great.
>>>
>>> I think that this whole level/classification thing is utterly wrong.  Replace "BPF" with basically anything else, and you'll see how absurd it is.
>> BPF is not "anything else", it's important to understand that BPF is
>> inherently not compratmentalizable. And it's vast and generic in its
>> capabilities. This changes everything. So your analogies are
>> misleading.
>>
> file descriptors are "vast and generic" -- you can open sockets, files, things in /proc, things in /sys, device nodes, etc.  They are infinitely extensible.  They work in containers.
>
> What is so special about BPF?
>
>>> "the token approach to me seems like a work around providing the right level/classification for a pod/container in order to say you support unprivileged containers using files on disk"
>>>
>>> That's very 1990's.  Maybe 1980's.  Of *course* giving access to a filesystem has some inherent security exposure.  So we can give containers access to *different* filesystems.  Or we can use ACLs.  Or MAC policy.  Or whatever.  We have many solutions, none of which are perfect, and we're doing okay.
>>>
>>> "the token approach to me seems like a work around providing the right level/classification for a pod/container in order to say you support unprivileged containers using the network"
>>>
>>> The network is a big deal.  For some reason, it's cool these days to treat TCP as highly privileged.  You can get secrets from your favorite (or least favorite) cloud provider with unauthenticated HTTP to a magic IP and port.  You can bypass a whole lot of authenticating/authorizing proxies with unauthenticated HTTP (no TLS!) if you're on the right network.
>>>
>>> This is IMO obnoxious, but we deal with it by having network namespaces and firewalls and rather outdated port <= 1024 rules.
>>>
>>> "the token approach to me seems like a work around providing the right level/classification for a pod/container in order to say you support unprivileged containers using BPF"
>>>
>>> My response is: what's wrong with BPF?  BPF has maps and programs and such, and we could easily apply 1990's style ownership and DAC rules to them.
>> Can you apply DAC rules to which kernel events BPF program can be run
>> on? Can you apply DAC rules to which in-kernel data structures a BPF
>> program can look at and make sure that it doesn't access a
>> task/socket/etc that "belongs" to some other container/user/etc?
> No, of course.
>
> If you have a BPF program that is granted the ability to read kernel data structures or to run in response to global events like this, it's basically a kernel module.  It may be subject to a verifier that imposes much stronger type safety than a kernel module is subject to, but it's still effectively a kernel module.
>
> We don't give containers special tokens that let them load arbitrary modules.  We should not give them special tokens that let them do things with BPF that are functionally equivalent to loading arbitrary kernel modules.
>
> But we do have ways that kernel modules (which are "vast and generic", too) can expose their functionality safely to containers.  BPF can learn to do this.
>
>> Can we limit XDP or AF_XDP BPF programs from seeing and controlling
>> network traffic that will be eventually routed to a container that XDP
>> program "should not" have access to? Without making everything so slow
>> that it's useless?
> Of course you can -- assign an entire NIC or virtual function to a container, and let the XDP program handle that.  Or a vlan or a macvlan or whatever.  (I'm assuming XDP can be scoped like this.  I'm not that familiar with the details.)
>
>>> I even *wrote the code*.
>> Did you submit it upstream for review and wide discussion?
> Yes.
>
>> Did you
>> test it and integrate it with production workloads to prove that your
>> solution is actually a viable real-world solution and not a toy?
> I did test it.  I did not integrate it with production workloads.
>
>> Writing the code doesn't mean solving the problem.
> Of course not.  My code was a little step in the right direction.  The BPF community was apparently not interested in it. 
>
>>> But for some reason, the BPF community wants to bury its head in the sand, pretend it's 1980, declare that BPF is too privileged to have access control, and instead just have a complicated switch to turn it on and off in different contexts.
>> I won't speak on behalf of the entire BPF community, but I'm trying to
>> explain that BPF cannot be reasonably sandboxed and has to be
>> privileged due to its global nature. And I haven't yet seen any
>> realistic counter-proposal to change that. And it's not about
>> ownership of the BPF map or BPF program, it's way beyond that..
>>
> It's really really hard to have a useful discussion about a security model when have, as what appears to be an axiom, that a security model can't be created.

Agreed. Complete security denial makes development so much easier.
In the 1980's we were told that there was no way UNIX could ever be
made secure, especially because of IP networking and window systems.
It wasn't easy, what with everybody screaming (often literally) about
the performance impact and code complexity of every single change, no
matter how small.

I'm *not* advocating adopting it, but you could look at the Zephyr
security model as a worked example of a system similar to BPF that
does have a security model. I understand that there are many ways to
argue that this won't work for BPF, or that the model has issues of
its own, but have a look.

https://docs.zephyrproject.org/latest/security/security-overview.html

>
> If you actually feel this way, then I think you should not be advocating for allowing unprivileged containers to do the things that you think can't have a security model.
>
> I'm saying that I think there *can* be a security model.  But until the maintainers start to believe that, there won't be one.

