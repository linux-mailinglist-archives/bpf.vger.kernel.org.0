Return-Path: <bpf+bounces-11152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A0A7B3E97
	for <lists+bpf@lfdr.de>; Sat, 30 Sep 2023 08:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id C07C71C208D8
	for <lists+bpf@lfdr.de>; Sat, 30 Sep 2023 06:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE330539A;
	Sat, 30 Sep 2023 06:10:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E935247
	for <bpf@vger.kernel.org>; Sat, 30 Sep 2023 06:10:06 +0000 (UTC)
X-Greylist: delayed 147 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 29 Sep 2023 23:10:03 PDT
Received: from smtp.zfn.uni-bremen.de (smtp.zfn.uni-bremen.de [IPv6:2001:638:708:32::21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDB31A7
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 23:10:02 -0700 (PDT)
Received: from smtpclient.apple (eduroam-pool10-224.wlan.uni-bremen.de [134.102.90.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.zfn.uni-bremen.de (Postfix) with ESMTPSA id 4RyGw24ZCTzDCcm;
	Sat, 30 Sep 2023 08:07:30 +0200 (CEST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [Bpf] Signed modulo operations
From: Carsten Bormann <cabo@tzi.org>
In-Reply-To: <PH7PR21MB387814B98538D7D23A611E89A3C0A@PH7PR21MB3878.namprd21.prod.outlook.com>
Date: Sat, 30 Sep 2023 08:07:20 +0200
Cc: "bpf@ietf.org" <bpf@ietf.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2E2AEB25-CD5D-4F1F-80D5-42715BC69ACF@tzi.org>
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
 <20220927185958.14995-7-dthaler1968@googlemail.com>
 <20220930205211.tb26v4rzhqrgog2h@macbook-pro-4.dhcp.thefacebook.com>
 <DM4PR21MB3440CDB9D8E325CBEA20FFA7A3569@DM4PR21MB3440.namprd21.prod.outlook.com>
 <20220930215914.rzedllnce7klucey@macbook-pro-4.dhcp.thefacebook.com>
 <DM4PR21MB34402522B614257706D2F785A3569@DM4PR21MB3440.namprd21.prod.outlook.com>
 <PH7PR21MB387814B98538D7D23A611E89A3C0A@PH7PR21MB3878.namprd21.prod.outlook.com>
To: Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I didn=E2=80=99t follow the whole discussion, but it maybe it's worth =
pointing out that C=E2=80=99s % is not a modulo operator, but a =
remainder operator.

Gr=C3=BC=C3=9Fe, Carsten


> On 29. Sep 2023, at 23:03, Dave Thaler =
<dthaler=3D40microsoft.com@dmarc.ietf.org> wrote:
>=20
> In the email discussion below, we concluded it wasn't relevant at the =
time because
> there were no signed modulo instructions.  However, now there is and I =
believe the
> ambiguity in the current spec needs to be addressed.
>=20
>> -----Original Message-----
>> From: Dave Thaler
>> Sent: Friday, September 30, 2022 3:42 PM
>> To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>> Cc: dthaler1968@googlemail.com; bpf@vger.kernel.org
>> Subject: RE: [PATCH 07/15] ebpf-docs: Fix modulo zero, division by =
zero,
>> overflow, and underflow
>>=20
>>> -----Original Message-----
>>> From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>>> Sent: Friday, September 30, 2022 2:59 PM
>>> To: Dave Thaler <dthaler@microsoft.com>
>>> Cc: dthaler1968@googlemail.com; bpf@vger.kernel.org
>>> Subject: Re: [PATCH 07/15] ebpf-docs: Fix modulo zero, division by
>>> zero, overflow, and underflow
>>>=20
>>> On Fri, Sep 30, 2022 at 09:54:17PM +0000, Dave Thaler wrote:
>>>> [...]
>>>>>> +Also note that the modulo operation often varies by language
>>>>>> +when the dividend or divisor are negative, where Python, Ruby, =
etc.
>>>>>> +differ from C, Go, Java, etc. This specification requires that
>>>>>> +modulo use truncated division (where -13 % 3 =3D=3D -1) as
>>>>>> +implemented in C, Go,
>>>>>> +etc.:
>>>>>> +
>>>>>> +   a % n =3D a - n * trunc(a / n)
>>>>>> +
>>>>>=20
>>>>> Interesting bit of info, but I'm not sure how it relates to the =
ISA doc.
>>>>=20
>>>> It's because there's multiple definitions of modulo out there as =
the
>>>> paragraph notes, which differ in what they do with negative =
numbers.
>>>> The ISA defines the modulo operation as being the specific version =
above.
>>>> If you tried to implement the ISA in say Python and didn't know
>>>> that, you'd have a non-compliant implementation.
>>>=20
>>> Is it because the languages have weird rules to pick between signed =
vs
>>> unsigned mod?
>>> At least from llvm pov the smod and umod have fixed behavior.
>>=20
>> It's because there's different mathematical definitions and different =
languages
>> have chosen different definitions.  E.g., languages/libraries that =
follow Knuth
>> use a different mathematical definition than C uses.  For details =
see:
>>=20
>> =
https://en.wikipedia.org/wiki/Modulo_operation#Variants_of_the_definition
>>=20
>> https://torstencurdt.com/tech/posts/modulo-of-negative-numbers/
>>=20
>> Dave
>=20
> Perhaps text like the proposed snippet quoted in the exchange above =
should be
> added around the new text that now appears in the doc, i.e. the =
ambiguous text
> is currently:
>> For signed operations (``BPF_SDIV`` and ``BPF_SMOD``), for =
``BPF_ALU``,
>> 'imm' is interpreted as a 32-bit signed value. For ``BPF_ALU64``, =
'imm'
>> is first :term:`sign extended<Sign Extend>` from 32 to 64 bits, and =
then
>> interpreted as a 64-bit signed value. =20
>=20
> Dave
>=20
> --=20
> Bpf mailing list
> Bpf@ietf.org
> https://www.ietf.org/mailman/listinfo/bpf


