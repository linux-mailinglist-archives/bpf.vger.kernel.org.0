Return-Path: <bpf+bounces-2951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DC173740B
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 20:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8C401C20CC7
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 18:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B183F17AB5;
	Tue, 20 Jun 2023 18:27:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F96E17722
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 18:27:49 +0000 (UTC)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC9910C2
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 11:27:48 -0700 (PDT)
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <jemarch@gnu.org>)
	id 1qBg4u-00076u-0A; Tue, 20 Jun 2023 14:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
	From; bh=Wm/qDe6Ulpe+BjyrYthYUY1BVdd7diYpFHNPkyoZnTU=; b=ROBr4pd4WDwa80awATO7
	YXHxAQH0BBztR86oQKN2i+hDxFrtKE+T6tanDE8ibkVM3P6EHRdMhnu6/M/UTmMxgAAHLEp91hjVU
	NFltJSzO4t13abBnpupFI550IiTdbnwvVXrd74Jrn2snilNTPhQq4eCr/sdfEKZ1a85iBXj6y/TTU
	TDrs8MHVOeAIOYHRBOasFMX2nHEzGAI9Mr8m+Q/ZrXohYDpbaOrGm34zF2Gcjmqn6zp38U0PvXHgi
	3x48T6JPOBbAutJPXLR2ZIuU6vOdhYaJSE4V9sN+ih/Ns8rN8zlVRocpsOTXtfcVxw21IF3BCPubm
	1pHPXqYOYGd2cQ==;
Received: from [141.143.193.75] (helo=termi)
	by fencepost.gnu.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <jemarch@gnu.org>)
	id 1qBg4t-0007d3-Bz; Tue, 20 Jun 2023 14:27:43 -0400
From: "Jose E. Marchesi" <jemarch@gnu.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>,  bpf@vger.kernel.org,
  ast@kernel.org,  andrii@kernel.org,  daniel@iogearbox.net,
  martin.lau@linux.dev,  kernel-team@fb.com,  yhs@fb.com,
  david.faust@oracle.com,  dzq.aishenghu0@gmail.com
Subject: Re: [RFC bpf-next] bpf: generate 'nomerge' for map helpers in
 bpf_helper_defs.h
In-Reply-To: <CAEf4Bzb4VJ7h02QAbg77sp9jgVFJBWoXrRuWGxHkXqQdPJ6EPw@mail.gmail.com>
	(Andrii Nakryiko's message of "Fri, 16 Jun 2023 10:03:01 -0700")
References: <20230615142520.10280-1-eddyz87@gmail.com>
	<CAEf4Bzb4VJ7h02QAbg77sp9jgVFJBWoXrRuWGxHkXqQdPJ6EPw@mail.gmail.com>
Date: Tue, 20 Jun 2023 20:27:39 +0200
Message-ID: <87ttv2f0pw.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> On Thu, Jun 15, 2023 at 7:25=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
>>
>> Update code generation for bpf_helper_defs.h by adding
>> __attribute__((nomerge)) for a set of helper functions to prevent some
>> verifier unfriendly compiler optimizations.
>>
>> This addresses a recent mailing list thread [1].
>> There Zhongqiu Duan and Yonghong Song discussed a C program as below:
>>
>>      if (data_end - data > 1024) {
>>          bpf_for_each_map_elem(&map1, cb, &cb_data, 0);
>>      } else {
>>          bpf_for_each_map_elem(&map2, cb, &cb_data, 0);
>>      }
>>
>> Which was converted by clang to something like this:
>>
>>      if (data_end - data > 1024)
>>        tmp =3D &map1;
>>      else
>>        tmp =3D &map2;
>>      bpf_for_each_map_elem(tmp, cb, &cb_data, 0);
>>
>> Which in turn triggered verification error, because
>> verifier.c:record_func_map() requires a single map address for each
>> bpf_for_each_map_elem() call.
>>
>> In fact, this is a requirement for the following helpers:
>> - bpf_tail_call
>> - bpf_map_lookup_elem
>> - bpf_map_update_elem
>> - bpf_map_delete_elem
>> - bpf_map_push_elem
>> - bpf_map_pop_elem
>> - bpf_map_peek_elem
>> - bpf_for_each_map_elem
>> - bpf_redirect_map
>> - bpf_map_lookup_percpu_elem
>>
>> I had an off-list discussion with Yonghong where we agreed that clang
>> attribute 'nomerge' (see [2]) could be used to prevent the
>> optimization hitting in [1]. However, currently 'nomerge' applies only
>> to functions and statements, hence I submitted change requests [3],
>> [4] to allow specifying 'nomerge' for function pointers as well.
>>
>> The patch below updates bpf_helper_defs.h generation by adding a
>> definition of __nomerge macro, and using this macro in definitions of
>> relevant helpers.
>>
>> The generated code looks as follows:
>>
>>     /* This is auto-generated file. See bpf_doc.py for details. */
>>
>>     #if __has_attribute(nomerge)
>>     #define __nomerge __attribute__((nomerge))
>>     #else
>>     #define __nomerge
>>     #endif
>>
>>     /* Forward declarations of BPF structs */
>>     ...
>>     static long (*bpf_for_each_map_elem)(void *map, ...) __nomerge =3D (=
void *) 164;
>>     ...
>>
>> (In non-RFC version the macro definition would have to be updated to
>>  check for supported clang version).
>>
>> Does community agree with such approach?
>
> Makes sense to me. Let's just be very careful to do proper detection
> of __nomerge "applicability" to ensure we don't cause compilation
> errors for unsupported Clang (which I'm sure you are well aware of)
> *and* make it compatible with GCC, so we don't fix it later.

GCC doesn't support the "nomerge" attribute at this point.  We will look
into adding it or find some other equivalent mechanism that can be
abstracted in the __nomerge macro.

>>
>> [1] https://lore.kernel.org/bpf/03bdf90f-f374-1e67-69d6-76dd9c8318a4@met=
a.com/
>> [2] https://clang.llvm.org/docs/AttributeReference.html#nomerge
>> [3] https://reviews.llvm.org/D152986
>> [4] https://reviews.llvm.org/D152987
>> ---
>>  scripts/bpf_doc.py | 37 ++++++++++++++++++++++++++++++-------
>>  1 file changed, 30 insertions(+), 7 deletions(-)
>>
>> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
>> index eaae2ce78381..dbd4893c793e 100755
>> --- a/scripts/bpf_doc.py
>> +++ b/scripts/bpf_doc.py
>> @@ -777,14 +777,33 @@ class PrinterHelpers(Printer):
>>          'bpf_get_socket_cookie',
>>          'bpf_sk_assign',
>>      ]
>> +    # Helpers that need __nomerge attribute
>> +    nomerge_helpers =3D set([
>> +       "bpf_tail_call",
>> +       "bpf_map_lookup_elem",
>> +       "bpf_map_update_elem",
>> +       "bpf_map_delete_elem",
>> +       "bpf_map_push_elem",
>> +       "bpf_map_pop_elem",
>> +       "bpf_map_peek_elem",
>> +       "bpf_for_each_map_elem",
>> +       "bpf_redirect_map",
>> +       "bpf_map_lookup_percpu_elem"
>> +    ])
>> +
>> +    macros =3D '''\
>> +#if __has_attribute(nomerge)
>> +#define __nomerge __attribute__((nomerge))
>> +#else
>> +#define __nomerge
>> +#endif'''
>>
>>      def print_header(self):
>> -        header =3D '''\
>> -/* This is auto-generated file. See bpf_doc.py for details. */
>> -
>> -/* Forward declarations of BPF structs */'''
>> -
>> -        print(header)
>> +        print('/* This is auto-generated file. See bpf_doc.py for detai=
ls. */')
>> +        print()
>> +        print(self.macros)
>> +        print()
>> +        print('/* Forward declarations of BPF structs */')
>>          for fwd in self.type_fwds:
>>              print('%s;' % fwd)
>>          print('')
>> @@ -846,7 +865,11 @@ class PrinterHelpers(Printer):
>>              comma =3D ', '
>>              print(one_arg, end=3D'')
>>
>> -        print(') =3D (void *) %d;' % helper.enum_val)
>> +        print(')', end=3D'')
>> +        if proto['name'] in self.nomerge_helpers:
>> +            print(' __nomerge', end=3D'')
>> +
>> +        print(' =3D (void *) %d;' % helper.enum_val)
>>          print('')
>>
>>  #######################################################################=
########
>> --
>> 2.40.1
>>

