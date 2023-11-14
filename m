Return-Path: <bpf+bounces-15064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E5E7EB52C
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 17:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B1552812A7
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 16:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C886B405EB;
	Tue, 14 Nov 2023 16:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="YBOIB2uk"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764323FE2A
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 16:58:13 +0000 (UTC)
Received: from sonic304-27.consmr.mail.ne1.yahoo.com (sonic304-27.consmr.mail.ne1.yahoo.com [66.163.191.153])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC73B8
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 08:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699981089; bh=GDJ5Xw7eIW1h0CD8YYo/VIQzHj9A7Sut1sTIsbNgDJg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=YBOIB2uk5eL4H/cXdU1Ed1Av/uS4/n+nGMTWkl0H1dZ5twvaeorIlj1XvbuF3hF+IQRHlagX3fu7EjOW4CZJ9kc/X0aYOiEZSxH9I+WIBCxdIQw0u808qrShwl6uP0iKjmF/UwXpr1v7wQ93kKD6HvL9eogDGGvB/b2H82ejVeCUelNbBVe+dKAjM6KssWHfrf4+qfwiA2YntmncAbLzZ4ybP9xlUnVaotfKzsYD1KoTGwJ2/UgF9BuXluFGIZf10Ol75rBGucx85IHY1VZBPKJrYFylMLx2gYItY409KpE9CoqK8Jw/aoZ8TPfSRKMHV7Op/eyeJ1YwNvJO4bZpig==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699981089; bh=8+nhCVC05YUDF7rvCX/1OY4jhw2+sh3dfE4loYTHX/P=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=uhoQW1IiD3qZ0AeFmWp7dE5BayZjgg06hYWqb177ooGVzhXUvQ0qG/JHdzY35Gxsf2wutWS586Rvevwguc/GgXRBXGVuEvpBA86atkh/qBOYbYW/Iax+emS7JN9Q3iRooih1emH1WNOzQqzhKrj0oVpcn+VF9ekWw4tMzFPEeC6z2gQZHbIsl/1ouaSuapub44PMlWZSAhdD7kX9/5L2spt62R5+2ZxJEkWTgC43iXLFB7zspJVyGlA4s5iMaXBVdCJtmTQJIzhz/MNwd+P/+ARpI+JXS5EMtGs7Ip3jS/YHNnwGBp7Q7runb+Nm9fle0PdAUXYcABTOU1j6QMx/mw==
X-YMail-OSG: kYyPSW4VM1nDp.GJeuaZ1G562mmiLDMvjVXl3.mqV9_G9bhgiP0c7Tntc60ok15
 Zu_NgVxrvqRAlafKLN45t4DquFrdH7_ZjNF0whpospzd5UcGp7vSETWYKqDgzYs7jscV004WATNE
 UV3xh1IjrIx.LgLwP1eiMSbF6p3S0dNxmNyVCB4iMVDdg3GZLAiHMBGZ5_T_KK3va.7bPO1x_o.t
 xHPicRIeC58DCMMzOBDZ88Hl6qJQcUfk04noOTfqX45QKjbFE.Dc4FiZOI2edKYqjZqM83vCgQaT
 .IyT31W9YpsQjZW0pFVr1RCkZMKPByZ02Zha4g..hX_hWhqYa9fU4q6SOl1Hvd1C181HgYpmA8PP
 13MEEoUVNMA.mrC3OoeG8ypMRFHtywSuOwlCwythFFeXwaB6qwAcTfDoHjjPTrfQg5S96zTQ_usL
 e1jRPJRMZx_JCMqQNM4SvxVwh_8z51zdXRV.crNPu47_ud.y1IzeLtDq3mLkfY1EiBKrTuRMH9ei
 UFLjuPNUmh8lrkSObv5viitp3g9Q9mOo1tPYN6f5tXHeU7s0kniRKoM8_Z3by1IfGVdBiSyBCI44
 6M6yVSa44oYF8AfK8h9ri3TZI2CcEEP4lcLjWuU7pY225ZoUZYak7Zz7E8jf0M.1vm8i_3QGnOwI
 oljTcCKmqUKF3i.DA3gtMhvIA521YkWVmwWGwfAvAmePGS6p7X12gFPNiDbRtYOdk3.x6UAIMhcH
 nx8Gm2OaGn_8QUWL143grXqqfcc0ncMJdfvY5r2tPjhN7snNo4ii5FXeec8EAqZXPdbXBI_lGaQe
 XNMzr4LOQB4QVNvCZlu7WnLPudBkLnZ7AvFI2n4KA0cKtmnC0zmQFrk3nfMJh7JESTMH8kYlW2nG
 .fYFG.yVLLC99iYcMBQqoMv7rgC8etkye4xYznBcKUT0_eGvf5wPzNcbLZTaZL3EPnjupiSz6QUy
 9h23Hzi2j.ENQnW3ksDSCBRB0._WX7iKR3ZhGEh2QTrqj8OlDzoWR4VWdJwaM5r30KPldap.RpfL
 Luhkh8ILdEFEkQJHAq403LaFG7vdmDiLJg7Gi_8gZJUA6TFgw2t7ORuOSBPF6gtxW1OXjhryefBy
 40OlpYX.7eNLxXOELzlVXJ5OmGyaJn1VYYTP7SHlVSQripnJpjTTm_jgV80cA4w90lbHEdj71E2c
 7Uxw8nGj1SVBACSmpViSZmWbC76lbEkqm83WpJ5pblpt0.xQQeZeZsW7UOmoCyh6qr_6fLDwPu53
 nj2RHKA_9dEADAsGn3JmIB3iF0.3F6TrYNCb4Scvvgd4ipa.Y.__HbLXH9veo15XJTMhz2v7DMc2
 cXsC.F7r1ek9qLVFH37tkG64j9qLJ86nMcMynEqLmbFAXPaW_UDpYYYYPJnEF0cyjgeyIBvCOKhp
 O4SDVKEPIthkf_kaSG4WtMlmSrvwausloEsmA1.ZLqOnAGy1FQXtk2k8bBTZsXWjkez10lntvhrY
 CZXwm_n7GZxKKfHMa0sFaDc59f4GLTAN2pp4hWJbYXdO_oxFZb0QXwyp1Pgo58WKkIjNcrTuhpGm
 _qLqSMlHkxaOxpHKz2cX50HThZzRhrjOkxb8e0HCL06_auNVu_Plcnc1KhvsnPNWiZ7hSIb6ULRM
 FTBzra2Z9D7Fafhw9NGKrQoWrfatlN2WoWzFv6vULSUy.vU7r1js2xR5xSMmWtJSwRbeHFx2hvie
 Jlgk3bDP4ZqHn.3RML_7mKgE_cUEfg_AUacHOeNp7Kr8d.rZoS.qrQ4ndHJSPnz3HFBpZcRewgi4
 YCUDxkbDSrVUlRR6H0I_QRm8flybJM2AM1G_2X383SEWCvGqOxH6S.Vy5dNTiAIKyPhT9Tcu.t2n
 uZDoRDzP230TM5.ZEjSiwA3g9YR8nlIn24N1xJTSnqiRKSLGONkLsyI7LOvGvPPS2kyP9VZO3s60
 Fi9LgvZXavwsvk6jNXVIFqmht6W62MDr3WO8EtPhuDh_d9I38ShvGpccntHSuJ83tj9CMA2fHxAh
 EIUsH6zE5bwgAQX3Tp6Nahthk5vM3A6gnzxp9V8dNirsQD6h1F5z0iw4wOcohKmPcdYUZ3Yryb2c
 xMtp2hZQRgKHXIR3kzAUbQH.RgOk1KaHWHXNODXvTGxZ.s3SNqzvFRaa933QvsH7kHiDrrRf_717
 Pl81Hu3Mbv8XauOwuiHAh3S9F2CigODrFXpR1ywR3uU4PAGSF4WbocZil1cdi6Iy532WGXjkV7VG
 iIsXtFZOfsvEMZQz6ok4C6I_7h3DRNqkp
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 4370bd34-8856-4583-8150-ab0931e637b0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 14 Nov 2023 16:58:09 +0000
Received: by hermes--production-bf1-5b945b6d47-h4jfj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7ee03597e617be2bba3f59ab1d14b26f;
          Tue, 14 Nov 2023 16:58:07 +0000 (UTC)
Message-ID: <b13050b3-54f8-431a-abcf-1323a9791199@schaufler-ca.com>
Date: Tue, 14 Nov 2023 08:57:58 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH -mm 0/4] mm, security, bpf: Fine-grained control over
 memory policy adjustments with lsm bpf
Content-Language: en-US
To: Yafang Shao <laoar.shao@gmail.com>, Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, linux-mm@kvack.org, linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org, ligang.bdlg@bytedance.com,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20231112073424.4216-1-laoar.shao@gmail.com>
 <188dc90e-864f-4681-88a5-87401c655878@schaufler-ca.com>
 <CALOAHbD+_0tHcm72Q6TM=EXDoZFrVWAsi4AC8_xGqK3wGkEy3g@mail.gmail.com>
 <ZVNIprbQU3NqwPi_@tiehlicka>
 <CALOAHbDi_8ERHdtPB6sJdv=qewoAfGkheCfriW+QLoN0rLUQAw@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CALOAHbDi_8ERHdtPB6sJdv=qewoAfGkheCfriW+QLoN0rLUQAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/14/2023 3:59 AM, Yafang Shao wrote:
> On Tue, Nov 14, 2023 at 6:15 PM Michal Hocko <mhocko@suse.com> wrote:
>> On Mon 13-11-23 11:15:06, Yafang Shao wrote:
>>> On Mon, Nov 13, 2023 at 12:45 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> On 11/11/2023 11:34 PM, Yafang Shao wrote:
>>>>> Background
>>>>> ==========
>>>>>
>>>>> In our containerized environment, we've identified unexpected OOM events
>>>>> where the OOM-killer terminates tasks despite having ample free memory.
>>>>> This anomaly is traced back to tasks within a container using mbind(2) to
>>>>> bind memory to a specific NUMA node. When the allocated memory on this node
>>>>> is exhausted, the OOM-killer, prioritizing tasks based on oom_score,
>>>>> indiscriminately kills tasks. This becomes more critical with guaranteed
>>>>> tasks (oom_score_adj: -998) aggravating the issue.
>>>> Is there some reason why you can't fix the callers of mbind(2)?
>>>> This looks like an user space configuration error rather than a
>>>> system security issue.
>>> It appears my initial description may have caused confusion. In this
>>> scenario, the caller is an unprivileged user lacking any capabilities.
>>> While a privileged user, such as root, experiencing this issue might
>>> indicate a user space configuration error, the concerning aspect is
>>> the potential for an unprivileged user to disrupt the system easily.
>>> If this is perceived as a misconfiguration, the question arises: What
>>> is the correct configuration to prevent an unprivileged user from
>>> utilizing mbind(2)?"
>> How is this any different than a non NUMA (mbind) situation?
> In a UMA system, each gigabyte of memory carries the same cost.
> Conversely, in a NUMA architecture, opting to confine processes within
> a specific NUMA node incurs additional costs. In the worst-case
> scenario, if all containers opt to bind their memory exclusively to
> specific nodes, it will result in significant memory wastage.

That still sounds like you've misconfigured your containers such
that they expect to get more memory than is available, and that
they have more control over it than they really do.


>> You can
>> still have an unprivileged user to allocate just until the OOM triggers
>> and disrupt other workload consuming more memory. Sure the mempolicy
>> based OOM is less precise and it might select a victim with only a small
>> consumption on a target NUMA node but fundamentally the situation is
>> very similar. I do not think disallowing mbind specifically is solving a
>> real problem.
> How would you recommend addressing this more effectively?
>

