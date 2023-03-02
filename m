Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71536A8ADB
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 21:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjCBUw3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 15:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCBUw2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 15:52:28 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706C8423B
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 12:52:27 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id p6so287969pga.0
        for <bpf@vger.kernel.org>; Thu, 02 Mar 2023 12:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1677790347;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmhG+Vu/qwZ4ys3Y/VoUN1gZs9SPvHL28eMsff5jQ9Q=;
        b=FWUkJB++LPvBLTOFdmgmxi6XZKH4jEmykscgXHOErQxcTDMjyhCEDAGjAK3/dA62wN
         2sf29X6b712tiPnMbvh+TL2vIyi2wUoOcLXeU8oNdW+ahrEiXyISXP+2sDQ5LCw7Clyn
         vIu6go2Oqxn7Wej+YCObqDbIWgM+rccviabPeu8lap+jarL8q2bym6fi8lyFrLIlg59r
         X9nRgZzJdhhSJPpHCysZ596D6d5sbA+DCtayrpmTHsBE/+hfGKO6jVfssA6C2VmytAqw
         woxIFNWPmY6qlmP2wJE0lWBqM0VghCKcp1S73VPnoYUhQMHuLIbHVKakwl7XkWALklgh
         iMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677790347;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WmhG+Vu/qwZ4ys3Y/VoUN1gZs9SPvHL28eMsff5jQ9Q=;
        b=kEVuaBFJJCyqh+0/3Vj8B/lVVzxAZU1IDzz7aap2jeKEoW+aRgQFdWHj4aF0PkbDMS
         0hiuxKrXcwB9MtF14Q82lNyfGO24dhrFzE58twHc3ZrI4B1/C1955bLEy46QSs+Cp5d+
         UfE7ZR/yxWgh53V9T/tnKJCfP7k8lWvCQj6y8tGaLP3noACOhg0v19xqnvkdPBy10qIL
         9vOqdN1cNDg9Qz3TVIfRntV4ND7WiIhqcRv4pownRL2wslSM6R1W4H8756seKTflKaOm
         n3tbahzf9ad2hM1bYvNpRcUpTolXmiuHOQjJBBDYRexaP70WwCV191j1HOMJ0a8DfLs0
         A2TA==
X-Gm-Message-State: AO0yUKW1nluS0wgbi9/xyBjnzNnwkLA/DF8kzYAroH2j0vv5c4Ks2CPy
        gL6Jq951OhfvkWH4xi0Fsavpmg==
X-Google-Smtp-Source: AK7set/xdMcvCwtJze2phUqRnlRGqo50xf0q/z6/QJD0tROs5wtNNsBNaeA87rxaH39wIxep+icdkg==
X-Received: by 2002:a62:5bc6:0:b0:5a9:d4fa:d3c7 with SMTP id p189-20020a625bc6000000b005a9d4fad3c7mr10629928pfb.7.1677790346792;
        Thu, 02 Mar 2023 12:52:26 -0800 (PST)
Received: from [192.168.86.240] (c-67-160-222-115.hsd1.ca.comcast.net. [67.160.222.115])
        by smtp.gmail.com with ESMTPSA id x4-20020a63cc04000000b00502fd762a39sm118818pgf.3.2023.03.02.12.52.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Mar 2023 12:52:26 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v2 bpf-next 3/3] selftests/bpf: Add tests for
 bpf_sock_destroy
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <1b5db179-7411-2f38-9ecf-344cde0848a7@linux.dev>
Date:   Thu, 2 Mar 2023 12:52:23 -0800
Cc:     kafai@fb.com, Stanislav Fomichev <sdf@google.com>,
        edumazet@google.com, bpf@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F3B34E9C-9DBC-4F76-8727-4907F99ECF74@isovalent.com>
References: <20230223215311.926899-1-aditi.ghag@isovalent.com>
 <20230223215311.926899-4-aditi.ghag@isovalent.com>
 <2552f727-57f3-0d76-c0da-f6543a93a45f@linux.dev>
 <F6E6FEAD-5003-44BE-AA76-6CDAE40A0A71@isovalent.com>
 <1b5db179-7411-2f38-9ecf-344cde0848a7@linux.dev>
To:     Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On Mar 1, 2023, at 11:06 PM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>=20
> On 2/28/23 6:17 PM, Aditi Ghag wrote:
>>> On Feb 28, 2023, at 3:08 PM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>>>=20
>>> On 2/23/23 1:53 PM, Aditi Ghag wrote:
>>>> The test cases for TCP and UDP iterators mirror the intended usages =
of the
>>>> helper.
>>>> The destroy helpers set `ECONNABORTED` error code that we can =
validate in the
>>>> test code with client sockets. But UDP sockets have an overriding =
error code
>>>> from the disconnect called during abort, so the error code the =
validation is
>>>> only done for TCP sockets.
>>>> The `struct sock` is redefined as vmlinux.h forward declares the =
struct, and the
>>>> loader fails to load the program as it finds the BTF FWD type for =
the struct
>>>> incompatible with the BTF STRUCT type.
>>>> Here are the snippets of the verifier error, and corresponding BTF =
output:
>>>> ```
>>>> verifier error: extern (func ksym) ...: func_proto ... incompatible =
with kernel
>>>> BTF for selftest prog binary:
>>>> [104] FWD 'sock' fwd_kind=3Dstruct
>>>> [70] PTR '(anon)' type_id=3D104
>>>> [84] FUNC_PROTO '(anon)' ret_type_id=3D2 vlen=3D1
>>>> 	'(anon)' type_id=3D70
>>>> [85] FUNC 'bpf_sock_destroy' type_id=3D84 linkage=3Dextern
>>>> --
>>>> [96] DATASEC '.ksyms' size=3D0 vlen=3D1
>>>> 	type_id=3D85 offset=3D0 size=3D0 (FUNC 'bpf_sock_destroy')
>>>> BTF for selftest vmlinux:
>>>> [74923] FUNC 'bpf_sock_destroy' type_id=3D48965 linkage=3Dstatic
>>>> [48965] FUNC_PROTO '(anon)' ret_type_id=3D9 vlen=3D1
>>>> 	'sk' type_id=3D1340
>>>> [1340] PTR '(anon)' type_id=3D2363
>>>> [2363] STRUCT 'sock' size=3D1280 vlen=3D93
>>>> ```
>>>=20
>>>> +int bpf_sock_destroy(struct sock_common *sk) __ksym;
>>>=20
>>> This does not match the bpf prog's BTF dump above which has pointer =
[70] pointing to FWD 'sock' [104] as the argument. It should be at least =
FWD 'sock_common' if not STRUCT 'sock_common'. I tried to change the =
func signature to 'struct sock *sk' but cannot reproduce the issue in my =
environment also.
>>>=20
>>> Could you confirm the BTF paste and 'incompatible with kernel" error =
in the commit message do match the bpf_sock_destroy declaration? If not, =
can you re-paste the BTF output and libbpf error message that matches =
the bpf_sock_destroy signature.
>> I don't think you'll be able to reproduce the issue with =
`sock_common`, as `struct sock_common` isn't forward declared in =
vmlinux.h. But I find it odd that you weren't able to reproduce it with =
`struct sock`. Just to confirm, did you remove the minimal `struct sock` =
definition from the program? Per the commit description, I added that =
because libbpf was throwing this error -
>> `libbpf: extern (func ksym) 'bpf_sock_destroy': func_proto [83] =
incompatible with kernel [75285]`
>=20
> Yep, I changed the kfunc to 'struct sock *' and removed the =
define/undef dance.
>=20
>> Sending the BTF snippet again (full BTF - =
https://pastebin.com/etkFyuJk)
>> ```
>> 85] FUNC 'bpf_sock_destroy' type_id=3D84 linkage=3Dextern
>> 	type_id=3D85 offset=3D0 size=3D0 (FUNC 'bpf_sock_destroy')
>> [84] FUNC_PROTO '(anon)' ret_type_id=3D2 vlen=3D1
>> 	'(anon)' type_id=3D70
>> [70] PTR '(anon)' type_id=3D104
>> [104] FWD 'sock' fwd_kind=3Dstruct
>> ```
>> Compare this to the BTF snippet once I undef and define the struct in =
the test prog:
>> ```
>> [87] FUNC 'bpf_sock_destroy' type_id=3D84 linkage=3Dextern
>> 	type_id=3D87 offset=3D0 size=3D0 (FUNC 'bpf_sock_destroy')
>> [84] FUNC_PROTO '(anon)' ret_type_id=3D2 vlen=3D1
>> 	'(anon)' type_id=3D85
>> [85] PTR '(anon)' type_id=3D86
>> [86] STRUCT 'sock' size=3D136 vlen=3D1
>> 	'__sk_common' type_id=3D34 bits_offset=3D0
>> ```
>> (Anyway looks like I needed to define the struct in the test prog =
only when bpf_sock_destory had `struct sock` as the argument.)
>=20
> Right, I also think it is orthogonal to your set if the kfunc is =
taking 'struct sock_common *' anyway. [although I do feel a kernel =
function taking a 'struct sock_common *' is rather odd]

Yes, this wasn't a problem with the helper taking `struct sock` as the =
argument in v1 patch. I'm all ears if we can have a similar signature =
for the kfunc.

>=20
> I was only asking and also trying myself because it looks pretty wrong =
if it can be reproduced and it is something that should be fixed =
regardless. It is pretty normal to have forward declaration within a bpf =
prog itself (not from vmlinux.h). =46rom the paste, it feels like the =
kfunc bpf_sock_destroy btf is generated earlier than the 'struct sock'. =
Which llvm version are you using?

$ llvm-config --version
14.0.0=20

