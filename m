Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D82AD1C0B
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2019 00:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732447AbfJIWmF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Oct 2019 18:42:05 -0400
Received: from sonic314-22.consmr.mail.bf2.yahoo.com ([74.6.132.196]:35621
        "EHLO sonic314-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732438AbfJIWmF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Oct 2019 18:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1570660923; bh=v2Td2tc3Nuu9Fc2xrrxwO1PuJo7R10+DQaMFtPQaX8c=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=KzOz1Koc+TOuKQ2k/Qa8QagwDUC7rNO7FF6BEvHVMTOdxVEMi7sgUZ2C8DmoNvkJfcU3Ts4nl9tgA/eNObk+0576S0EebfbXitThTng3rFJMrDn37aLZVpDcPvj7uB2W44MzAOZQPbU1a93ZnGi9pJFQ/ORNhzHeG85+hRC1skVZ9xvyQVRWU79BCizl/q7LYxHIPkz/cJdd+O7fcj5L1xg3GbatCt7KWfwtWN98lIixxzhB7wlIi+mqtSEtrVtsylQM1vmFXK+0Of4bxH+3Vjbd5x+FD8KW6MPon4htvWbIXq2lvQXS3mCHfKnW+YubJvioWGDnAUY4u44OWevGSw==
X-YMail-OSG: cb5l.uMVM1n7IEPuUgCmpaAAts0o.YjV9DpB2qZbNr.Jd4Ffg9LTsfJcGTGzApO
 kCJJb4D15F5fETLAjkqPG3GY6a5.3Kx3yA1lYNeOBVtrt..SYYX5WBxm9T_mkGUNvMx3ZjQvaexT
 KMu8P2ZNPAfYC79bZ6.w19D19jvFyaayR9_lqy6EOjW_CwaZHUa5MR9GBCaIn.s2q4wO6bbtQM4X
 we5iHQvQRjW6sky4uRwZg2Mb19ty5arY2yMwujRFWR0EIYRccFnFTAB9TWeRoOf2xhg0L437Tseh
 9xjFK53akif_tyXfNmYUXpw33kI5wXJeRgtS2LOnLC.DQuETXk0a3iyIA8Z.kbyom06iCSl.cQ9s
 OwXcllFkOPPrzPSoPr.1R202qL_SltYfDakFDtC7eGJyKW3CiX4WvME07ZsitP1i5CK9kdTpgKES
 rUp_9onzQSHKonoqdwH9MXF3u_MIxPz1G67m4L6Hx6Y22hAYxF2Iit8dz3Weuxxt6N7QCs4JUvCU
 PCdm28kBXNieNH.oL6qvS5zt0uRQ8XYJS_Bu2N3pkN8N3tfPSvucgfX6uuciW8VkAUFpyrzXMeSn
 9wvTuwmMjZzpSum5olHn0gSh1ZBzKIdrO12a8Cdm4y9EJpgaxn5pbcQZPvZYCYtagUjelXqRkP6J
 1smds1o1Lv1.ZdoAZbEphjlKBwg_bRWdteJDpOu2HyzgLthDbTCz9d2pIrJQaADfzeOdG8d.8yhr
 OfGGXxyILX6D4SfFQkVsgt5EBLmTX3xtIrfalFWOlelwwq64oWc13.K85AQ2oQs1mq3LC1wevLHy
 pS29JrJpRjsaODC5nhX9ExW1sLrjz45vaHkuy2gvatIUt1dgUIJHFCml0BcteqI6hho_T3t2n41z
 u6ZhRaokAN08hmsH0rj9k0p0BohUJsFRasuAlmeKwmZf9fGg6mk4w1YeJuu4AZo9kai7_ja8xHlR
 7QVUthIf1IdWHNYIpGO8xrXNvJW1wv.oTTmeUZ4c1_avqa5dVoQDKdMfsVSvP8mg685iT978LAZW
 N68o052Qu4swRG2gszod9_V5JSKvaYBXMZjz23mm0MbdelzF4IGnPU5KmIT7t10zTi6TGSzCjFIN
 Ttk7IXlNAqtJfVrhiiLEzbRQGZ22.hQJs7HpTOLTvSiwmJNJR1cQ4CNXmfX.Pb9x0K5JOmpEc32k
 t4BcsfBeAT7ajbCChIClRmyB2geDkV1m89rWDlPTyxAlMGw64dDD0C4URAvgSjVGJiS_e0jRdRVP
 E7C4HHVOlCyeCpuKZ9SlkYZFBNVLSW1PHDbU1pedL8M1Xig5bbFhRrsN5P_c_w8x6vuffE4OpdO6
 LvgPPJnOKtdg10NbiZctxkjO.6j8nQ5UTdgZ6rmyRuw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.bf2.yahoo.com with HTTP; Wed, 9 Oct 2019 22:42:03 +0000
Received: by smtp409.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID f2244bd4f33168a3179553ba54d0c5c4;
          Wed, 09 Oct 2019 22:41:58 +0000 (UTC)
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
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <2b94802d-12ea-4f2d-bb65-eda3b3542bb2@schaufler-ca.com>
Date:   Wed, 9 Oct 2019 15:41:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1910100912210.29840@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/9/2019 3:14 PM, James Morris wrote:
> On Wed, 9 Oct 2019, Casey Schaufler wrote:
>
>> Please consider making the perf_alloc security blob maintained
>> by the infrastructure rather than the individual modules. This
>> will save it having to be changed later.
> Is anyone planning on using this with full stacking?
>
> If not, we don't need the extra code & complexity. Stacking should only=
=20
> cover what's concretely required by in-tree users.

I don't believe it's any simpler for SELinux to do the allocation
than for the infrastructure to do it. I don't see anyone's head
exploding over the existing infrastructure allocation of blobs.
We're likely to want it at some point, so why not avoid the hassle
and delay by doing it the "new" way up front?


