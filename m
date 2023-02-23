Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9B26A064C
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 11:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbjBWKcK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 05:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbjBWKcJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 05:32:09 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553BA2CFEA;
        Thu, 23 Feb 2023 02:32:08 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 309CC320091A;
        Thu, 23 Feb 2023 05:32:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 23 Feb 2023 05:32:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1677148326; x=
        1677234726; bh=fc6qcoPy6n7YikuoryogjuIfcTxPHRlRaGS0scjDKWc=; b=J
        BYJ0M43GhECBwOqalrZnwTDLimk3b5QRFq8imVP6LpkqwN8p0WK7T3GL/GFPf8Po
        j3ukVk6cV8BzzjwmeRlMmKGQEGNzSZ1O+KxVScWfq+JqpqXVBZTFB5DPSQ5TtZrO
        7iMCZ6qAKd8qqEcJ1VcMRzTqCrgJFqQRwFP7RcDKBFgMq8sTeVfiWnL1pokHFhE3
        zX8d8vWMkeOoNOQr12nLh3xjEiY+HhC9sVVoQHQFumgbZORU9/etqwNBCDXTONwd
        eUkaJONBOXwkQtSBkakqQU2vSCwfssZ4UtZMacllPBYWxzsZUv4j/iV9YToqcAPq
        z8S+WY08tSNSa4I4Q1MDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1677148326; x=
        1677234726; bh=fc6qcoPy6n7YikuoryogjuIfcTxPHRlRaGS0scjDKWc=; b=n
        k5Yf6muj/fSpns25I0A9XuM1Xj8rENVZGu/ujbjJPTXMSpe1zPCkm/pmRdVQ1K3T
        UD+cs3f8DWRm02K8IUJdIxXncakskm+4ltBAgEAVSyHKndkQybgk71ZxFKmnFKB0
        deifqzKj7EbyNEwir+vsx7qndZaf/ZAiI0RvZwv1IExQvVsR9wuuxkivhZFC402R
        wSq4xAtyvK21i0hUQQ5hNuSAZ58fjEi5qIWEIVBGzltv19YXf99XJ8ung5Ml0sjg
        s+E/mXchymMlWYRDWgqDrXgddsizkwq89V8P7ytZAULW32jnegQof+ButKDdYeRZ
        1rRUtBeviLQsFzrtQ0m+A==
X-ME-Sender: <xms:pkD3YxXqElu85bywT2wMPkTuCHtFE9GOT7eZijsfBcbuIklO7Wy-mg>
    <xme:pkD3Yxmlrg6A1gF24O6ZbyzkPKuEsZJEK21H9on5xpmgQPluIp-c0Qg6TTjMLNpKB
    LRQrh5YNmRJ8PCI5lI>
X-ME-Received: <xmr:pkD3Y9YZHQHP3gK6OZ5ZFRorDQgEF2dVePLnHaOJGN84QUAmEmmfYvWTjEKpRfon8pUJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekuddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepuddtjeffteetfeekjeeiheefueeigeeutdevieejveeihfff
    ledvgfduiefhvddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:pkD3Y0WwxUj4P88dPhx5khsK2sT9atie-6Sc2lPhnnp_XooL65pZdw>
    <xmx:pkD3Y7nPaSo-xRi_k-EaJrsxkLZxLS4N68mkovRQ5DLhOsQXtqKTGg>
    <xmx:pkD3YxdEII287xNhn5yEmb4-Hu8tiYxjYoX8DrCNBBMwjCjLKZ3dWg>
    <xmx:pkD3Y5WnXzn9o5oM8ryb90cQ5AjPVqGflRPoLRa8DGwoGPlDJM8ZnQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Feb 2023 05:32:05 -0500 (EST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH 2/2] MIPS: ebpf jit: Implement R4000 workarounds
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <CAM1=_QTDkYJANgxYwkgPZB+hUX6Rr_Pvnn7cFwSJFHQtLrpQMA@mail.gmail.com>
Date:   Thu, 23 Feb 2023 10:31:54 +0000
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "paulburton@kernel.org" <paulburton@kernel.org>,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <70C80F6D-A727-48FD-A767-A2CA54AA7C1E@flygoat.com>
References: <20230222161222.11879-1-jiaxun.yang@flygoat.com>
 <20230222161222.11879-3-jiaxun.yang@flygoat.com>
 <CAM1=_QTDkYJANgxYwkgPZB+hUX6Rr_Pvnn7cFwSJFHQtLrpQMA@mail.gmail.com>
To:     Johan Almbladh <johan.almbladh@anyfinetworks.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> 2023=E5=B9=B42=E6=9C=8823=E6=97=A5 10:22=EF=BC=8CJohan Almbladh =
<johan.almbladh@anyfinetworks.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Wed, Feb 22, 2023 at 5:12 PM Jiaxun Yang <jiaxun.yang@flygoat.com> =
wrote:
>>=20
>> For R4000 erratas around multiplication and division instructions,
>> as our use of those instructions are always followed by mflo/mfhi
>> instructions, the only issue we need care is
>>=20
>> "MIPS R4000PC/SC Errata, Processor Revision 2.2 and 3.0" Errata 28:
>> "A double-word or a variable shift may give an incorrect result if
>> executed while an integer multiplication is in progress."
>>=20
>> We just emit a mfhi $0 to ensure the operation is completed after
>> every multiplication instruction accorading to workaround suggestion
>> in the document.
>>=20
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>> arch/mips/Kconfig              | 4 +---
>> arch/mips/net/bpf_jit_comp32.c | 4 ++++
>> arch/mips/net/bpf_jit_comp64.c | 3 +++
>> 3 files changed, 8 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>> index df0910e3895c..5ea07c833c5b 100644
>> --- a/arch/mips/Kconfig
>> +++ b/arch/mips/Kconfig
>> @@ -63,9 +63,7 @@ config MIPS
>>        select HAVE_DEBUG_STACKOVERFLOW
>>        select HAVE_DMA_CONTIGUOUS
>>        select HAVE_DYNAMIC_FTRACE
>> -       select HAVE_EBPF_JIT if !CPU_MICROMIPS && \
>> -                               !CPU_R4000_WORKAROUNDS && \
>> -                               !CPU_R4400_WORKAROUNDS
>=20
> Is the R4400 errata also covered by this workaround?

Yes, R4400 errata is basically a reduced version of R4000 one.
They managed to fix some parts of the issue but not all.

>=20
>> +       select HAVE_EBPF_JIT if !CPU_MICROMIPS
>>        select HAVE_EXIT_THREAD
>>        select HAVE_FAST_GUP
>>        select HAVE_FTRACE_MCOUNT_RECORD
>> diff --git a/arch/mips/net/bpf_jit_comp32.c =
b/arch/mips/net/bpf_jit_comp32.c
>> index ace5db3fbd17..fee334544d2f 100644
>> --- a/arch/mips/net/bpf_jit_comp32.c
>> +++ b/arch/mips/net/bpf_jit_comp32.c
>> @@ -446,6 +446,9 @@ static void emit_mul_i64(struct jit_context *ctx, =
const u8 dst[], s32 imm)
>>                } else {
>>                        emit(ctx, multu, hi(dst), src);
>>                        emit(ctx, mflo, hi(dst));
>> +                       /* Ensure multiplication is completed */
>> +                       if (IS_ENABLED(CONFIG_CPU_R4000_WORKAROUNDS))
>> +                               emit(ctx, mfhi, MIPS_R_ZERO);
>>                }
>>=20
>>                /* hi(dst) =3D hi(dst) - lo(dst) */
>> @@ -504,6 +507,7 @@ static void emit_mul_r64(struct jit_context *ctx,
>>        } else {
>>                emit(ctx, multu, lo(dst), lo(src));
>>                emit(ctx, mflo, lo(dst));
>> +               /* No need for workaround because we have this mfhi =
*/
>>                emit(ctx, mfhi, tmp);
>>        }
>=20
> R4000 is a 64-bit CPU, so the 32-bit JIT implementation will not be
> used. =46rom the Makefile:
>=20
> ifeq ($(CONFIG_32BIT),y)
>        obj-$(CONFIG_BPF_JIT) +=3D bpf_jit_comp32.o
> else
>        obj-$(CONFIG_BPF_JIT) +=3D bpf_jit_comp64.o
> endif

It=E2=80=99s common practice to run 32-bit kernel on R4000 based systems =
to save some memory :-)

Thanks.
- Jiaxun

>=20
>>=20
>> diff --git a/arch/mips/net/bpf_jit_comp64.c =
b/arch/mips/net/bpf_jit_comp64.c
>> index 0e7c1bdcf914..5f5a93f997bc 100644
>> --- a/arch/mips/net/bpf_jit_comp64.c
>> +++ b/arch/mips/net/bpf_jit_comp64.c
>> @@ -228,6 +228,9 @@ static void emit_alu_r64(struct jit_context *ctx, =
u8 dst, u8 src, u8 op)
>>                } else {
>>                        emit(ctx, dmultu, dst, src);
>>                        emit(ctx, mflo, dst);
>> +                       /* Ensure multiplication is completed */
>> +                       if (IS_ENABLED(CONFIG_CPU_R4000_WORKAROUNDS))
>> +                               emit(ctx, mfhi, MIPS_R_ZERO);
>>                }
>>                break;
>>        /* dst =3D dst / src */
>> --
>> 2.37.1 (Apple Git-137.1)


