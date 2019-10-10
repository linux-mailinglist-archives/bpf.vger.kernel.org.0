Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D10FD300C
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2019 20:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfJJSOY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Oct 2019 14:14:24 -0400
Received: from sonic315-48.consmr.mail.bf2.yahoo.com ([74.6.134.222]:46200
        "EHLO sonic315-48.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726920AbfJJSOY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Oct 2019 14:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1570731262; bh=zaME4nyMqJtWjsRvYUaqDCTHCgF4I360TrNfhU1lx1U=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=rsBY0mtfHdTBfLzAWvjwH0w7vnqUE+nGnhrcHvjLwJU0NHH7ez+VVLrn7BgMGP2/Ni9eJ60SaBn8aQMmmjmKdw2ktPIKVpFhKUBmJY4iyGzvZa0xQDWimVdArI8kzKWT8v54MVwA1MAiwo2RNfF/NXP51+1F/IJYfTVrweC1dA1ES7cH/0xKsyKbtXpR/qWJjc3IeRVK0Ff7k1wMQ3xZe8dg8BHeRWDsNbf6TLNV/k8m4WHgLZCoA0ssmjfpwSnS4Jm3IreLuz+hkeL5BiltW/zRFuYsG3jJoBlMGr3jtSLP1PSY4DhyQz3PYL+RYwRcyuk7eng4KqBuvL0vxnTmSQ==
X-YMail-OSG: Ce6YZYEVM1k93g59lNLFfHP4FBHYKdtTbpIDqwUFs4XVp0rr53Kf8Dk9vVpygZa
 mmf6Ld_DC6iRUb4itBdgSY5txaLvAWHzPpPYv6_6vIWd3opFidCKOK6GgK5gKKHN6a.WdYomz9B8
 tSeAmbdhCW08OdRXSjNiPl4EFF2CGOPZuuBqovjq3Y1Ph5Qm.qXQRL5wb6kqsYetvMRBC7npId_Z
 UTeGzuEYXTxAg2qIB9wVEAqQeOjN.AfcOd5_K9x0Z737CgxpZsWlyx8n5t6vkg_AkALjcpL1HuoP
 x8uCkBn_rDX72IpZluaXkTTp7bYVhKDvqh863USEdMulkELpDyNs1FUkGao9aUZZ8ZbxPi_6V3IY
 R6GFa9tC2n_mB.5xDjVYWHzd6zegp7FotA3TjIRnOHPDrq_Fyuqmu6LoE9NyNExLpM4cD3kTIEZM
 DdlnnXjyqkV3c_rbLvISvJRYv9A71pg2Ua86Uxb2uuX95pyC.lmGhUDo8rN58j0jlvnOjr9Lor.6
 JciMIV_3uLrWJy5GHnTPzOrPhhsyvAxI9BxZcne78t9dAZhDNki8859E6jQlCoYtk9Kpiq_Meefm
 Cmn1n9_t8SjzAM2yFtXFqsEUJFBj6iWaWlVe01a.AL4tXk57o_Lkd2E2B8Tx934oXXV3lAV_8ZX9
 BZ_vqyYCcaA7fvtX1Ex0S.b6X0hZDOYZtyf1lpjW.tVtpQBYGWaGzoAL6Vx6YNQ6X1dtn8lfeQK5
 mM1dtGaMoUsnuhrA.LpNakwtdwbycZyHaYicmaYTxtHJj4Ckz6K6wZP8mT9.fQnQeLubrxOeHAuu
 OaEe74_Duf_k.2X9tgEEDEBj7rXXpTWb44J2qmD8UKxyGF_CP6iYCy_lOE4czebGF9BS52ulVVjG
 xc0M_PJtSCg9ZR3LRDSxCGnEgJZxOwYWrYnxhCKJt7DNFphtVt9c_rKxMihjAaAevMbrFaqpgvYr
 KMQr0nz1eAY41DerRfFoV1VQZvd0_CieQtO90EzGQdDblWNfVxatl779Wgnp7mT.G9XAZb_8fk.d
 _sc9MeNwmm_dke.c5anI4SnY7oSNhh.3o73Wl1fvGpmBaywRuPt7YDWPFaMdZY1Nzg4ovVT5lJFE
 XBF46Y74FimJAWBa.CtOqK6LShx26J7pLWzvui0t5xLj0VnOb4cIOxY.qA8KcNe_eoOpQw2SwPd7
 Mmy7xunaqIlXsLP_RmJ4HlwAvGRmvaCguln_hY5xW8OynqJyXb7qgKe7TQyh8_4a2zuecwd2IJGq
 zPpAKV7U8Ez4eiHEyDYPm6ch4LU4RM3nelIP4wmrOj3Ac.ODrKkBi0HrRCOIBJJBIYQoiaS488KA
 GfSp5h1J2ioj9uShOxvveAnTpaG_FOZJXZCzWdEYBH1CCTGjX37Nobih6K0hPuZTwhbnQuCL1dzp
 trLcbBIEvnBR7GxtkA85ZTXS10p8wCvJrZ8g-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Thu, 10 Oct 2019 18:14:22 +0000
Received: by smtp416.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 704d4bedeb38f9e2c337e1f9d670721c;
          Thu, 10 Oct 2019 18:12:21 +0000 (UTC)
Subject: Re: [PATCH RFC] perf_event: Add support for LSM and SELinux checks
To:     James Morris <jmorris@namei.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, rostedt@goodmis.org,
        primiano@google.com, rsavitski@google.com, jeffv@google.com,
        kernel-team@android.com, Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Namhyung Kim <namhyung@kernel.org>, selinux@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Yonghong Song <yhs@fb.com>, casey@schaufler-ca.com
References: <20191009203657.6070-1-joel@joelfernandes.org>
 <710c5bc0-deca-2649-8351-678e177214e9@schaufler-ca.com>
 <alpine.LRH.2.21.1910100912210.29840@namei.org>
 <2b94802d-12ea-4f2d-bb65-eda3b3542bb2@schaufler-ca.com>
 <alpine.LRH.2.21.1910101343470.8343@namei.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <dc0cacef-fff5-b837-97a4-ed7336934bf6@schaufler-ca.com>
Date:   Thu, 10 Oct 2019 11:12:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1910101343470.8343@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/9/2019 7:44 PM, James Morris wrote:
> On Wed, 9 Oct 2019, Casey Schaufler wrote:
>
>> On 10/9/2019 3:14 PM, James Morris wrote:
>>> On Wed, 9 Oct 2019, Casey Schaufler wrote:
>>>
>>>> Please consider making the perf_alloc security blob maintained
>>>> by the infrastructure rather than the individual modules. This
>>>> will save it having to be changed later.
>>> Is anyone planning on using this with full stacking?
>>>
>>> If not, we don't need the extra code & complexity. Stacking should only 
>>> cover what's concretely required by in-tree users.
>> I don't believe it's any simpler for SELinux to do the allocation
>> than for the infrastructure to do it. I don't see anyone's head
>> exploding over the existing infrastructure allocation of blobs.
>> We're likely to want it at some point, so why not avoid the hassle
>> and delay by doing it the "new" way up front?
> Because it is not necessary.

The logic escapes me, but OK.

