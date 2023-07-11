Return-Path: <bpf+bounces-4763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F3374F118
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 16:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CBDA281879
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 14:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF5719BB1;
	Tue, 11 Jul 2023 14:04:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38B619BA9
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 14:04:18 +0000 (UTC)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C82E69
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 07:04:16 -0700 (PDT)
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <jemarch@gnu.org>)
	id 1qJDyQ-00006L-GR; Tue, 11 Jul 2023 10:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
	From; bh=NpaSxipqmX9poXsWhpR4q+yVnkTQK1VtwmJHQsc4V+4=; b=kDM2+rc6xNCwgr3roFyT
	PMNMjRFLZmusqaYHjXxSGSz++Umfqnx7TkydDsvYFqd+uoEJn0qxk1al/MDPg5+SOBlua9iU9rqs4
	WYW04kpTVkdQy7afgsuwyF4ofHnT3hFvF1/FClLSQ6eCipy0Lm8MmubqxeckAFVuAoVWBGjqnoAn7
	4L836Xd8jtNP7HeOMhL+A5xyN4LEXZUm49z9w1auWcKAX7Vwq57AZKreSw2UxAMC5y0OguEFgehxd
	tgMtDQo8IVZZdFKQYKXc8FuH5IJXLOu0WGEL/TdeMsKS2K2NJT29+AB43TgXzcuCOnzDA/+Fn9aF1
	wHKsaiwD0Dh6fg==;
Received: from [141.143.193.69] (helo=termi)
	by fencepost.gnu.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <jemarch@gnu.org>)
	id 1qJDyQ-0000RG-4q; Tue, 11 Jul 2023 10:04:14 -0400
From: "Jose E. Marchesi" <jemarch@gnu.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Will Hawkins <hawkinsw@obs.cr>,  bpf <bpf@vger.kernel.org>,  bpf@ietf.org
Subject: Re: [Bpf] [PATCH 1/1] bpf, docs: Specify twos complement as format
 for signed integers
In-Reply-To: <CAADnVQ+F5VT72LzONEo79ksqaRj=c7mJDd_Ebb87767v01Nosw@mail.gmail.com>
	(Alexei Starovoitov's message of "Mon, 10 Jul 2023 20:00:31 -0700")
References: <20230710215819.723550-1-hawkinsw@obs.cr>
	<20230710215819.723550-2-hawkinsw@obs.cr>
	<CAADnVQ+F5VT72LzONEo79ksqaRj=c7mJDd_Ebb87767v01Nosw@mail.gmail.com>
Date: Tue, 11 Jul 2023 16:04:11 +0200
Message-ID: <871qhe7des.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> On Mon, Jul 10, 2023 at 2:58=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> wr=
ote:
>>
>> In the documentation of the eBPF ISA it is unspecified how integers are
>> represented. Specify that twos complement is used.
>>
>> Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
>> ---
>>  Documentation/bpf/instruction-set.rst | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/i=
nstruction-set.rst
>> index 751e657973f0..63dfcba5eb9a 100644
>> --- a/Documentation/bpf/instruction-set.rst
>> +++ b/Documentation/bpf/instruction-set.rst
>> @@ -173,6 +173,11 @@ BPF_ARSH  0xc0   sign extending dst >>=3D (src & ma=
sk)
>>  BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ be=
low)
>>  =3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> +eBPF supports 32- and 64-bit signed and unsigned integers. It does
>> +not support floating-point data types. All signed integers are represen=
ted in
>> +twos-complement format where the sign bit is stored in the most-signifi=
cant
>> +bit.
>
> Could you point to another ISA document (like x86, arm, ...) that
> talks about signed and unsigned integers?

AFAIK the only signedness encoding aspect that is always found in ISA
specifications and should be specified is how numerical immediates are
encoded in stored instructions.

But that has nothing to do with "data types".

