Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313A36A6560
	for <lists+bpf@lfdr.de>; Wed,  1 Mar 2023 03:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjCACSE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 21:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjCACSD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 21:18:03 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C57303CC
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 18:18:02 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so15675491pjb.3
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 18:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwBdzkIp9Jm1ZEIol7Dej8LrimQca15xJfR/hwVoVxc=;
        b=ToZnIUlV4TFpiQTd/PG54nOTTcrMkh5j3ig7eTnDtLzx1OlJe7Z7RE6QJzcZtk2gQN
         phBiWF/2FREXA30quz3Qh5Fb1IBduDkIX4JEntViXqReIdWM6CkfCXpYq8h83XDHZD1t
         ODQwVMvGVqKguCbUebTjfnlUQ0vyXzOFpwkCmJBirrJz6G+bUwoqmurpr3vyXY94Y5IP
         +fTe+5vK3hFBZkuAZZx8TSaQR0cKYrL4u2PCeTrRrxQQl+vuO2Kp3SwC7+uVxYOTE/Ub
         dNSN9kmqiQo7qfjxbb1/7iJrmwp8K3aygTx5d08O6uPIVMTQtgVK9U/KsCo3FCYzaT5v
         vSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pwBdzkIp9Jm1ZEIol7Dej8LrimQca15xJfR/hwVoVxc=;
        b=gB+sofrT/RoDm+Hl1Ui6zLJrTEXVrHgOKkLp6XD77yk1qXL+MyYHlJqbQME3QO2G/i
         oBeCPsEvGh6KEOgDoD1PhesJyiz9kh5tsxNrSZSJR79fl2t35W8KszNv6ib8pqSVm/XX
         UykkrIGzc2VXFTAiX3dP1i915vMYjS22gyUHuAecfFqTvfqkzOMXK0tbOSRcli2EB/kk
         FP70plsvjjBdvUjmgpVK+naDc1smAHqzC+aBca78hnMnxQz1bET4XGe24ZrS7q/827MU
         gNMKCfsOCqYc2M1n4aTwgzgskHGH7IZFqp0lJKd8PwigEl2+poee2bt1aY10f8WHkmvB
         BMZA==
X-Gm-Message-State: AO0yUKU3uTugA8NfdNvnQFNioPZv6kLY9/SMSSnjLGVxuCYw9SBIK+HU
        6v7bjn2f2Hr/W+6rwQkLr1cDCA==
X-Google-Smtp-Source: AK7set8bFK327WDZ4UP3Ju6Nhsrqz64Di1oJrdDkoce6QnHHUdaDFcUV3jb2LKJ5Q3wLVAAvGm4OVw==
X-Received: by 2002:a17:902:d488:b0:19d:1230:439b with SMTP id c8-20020a170902d48800b0019d1230439bmr5901478plg.63.1677637081580;
        Tue, 28 Feb 2023 18:18:01 -0800 (PST)
Received: from ?IPv6:2601:647:4900:b6:d435:3c0:a2bd:c7c? ([2601:647:4900:b6:d435:3c0:a2bd:c7c])
        by smtp.gmail.com with ESMTPSA id w11-20020a1709029a8b00b0019a7363e752sm7121111plp.276.2023.02.28.18.18.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Feb 2023 18:18:01 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v2 bpf-next 3/3] selftests/bpf: Add tests for
 bpf_sock_destroy
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <2552f727-57f3-0d76-c0da-f6543a93a45f@linux.dev>
Date:   Tue, 28 Feb 2023 18:17:59 -0800
Cc:     kafai@fb.com, Stanislav Fomichev <sdf@google.com>,
        edumazet@google.com, bpf@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F6E6FEAD-5003-44BE-AA76-6CDAE40A0A71@isovalent.com>
References: <20230223215311.926899-1-aditi.ghag@isovalent.com>
 <20230223215311.926899-4-aditi.ghag@isovalent.com>
 <2552f727-57f3-0d76-c0da-f6543a93a45f@linux.dev>
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



> On Feb 28, 2023, at 3:08 PM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>=20
> On 2/23/23 1:53 PM, Aditi Ghag wrote:
>> The test cases for TCP and UDP iterators mirror the intended usages =
of the
>> helper.
>> The destroy helpers set `ECONNABORTED` error code that we can =
validate in the
>> test code with client sockets. But UDP sockets have an overriding =
error code
>> from the disconnect called during abort, so the error code the =
validation is
>> only done for TCP sockets.
>> The `struct sock` is redefined as vmlinux.h forward declares the =
struct, and the
>> loader fails to load the program as it finds the BTF FWD type for the =
struct
>> incompatible with the BTF STRUCT type.
>> Here are the snippets of the verifier error, and corresponding BTF =
output:
>> ```
>> verifier error: extern (func ksym) ...: func_proto ... incompatible =
with kernel
>> BTF for selftest prog binary:
>> [104] FWD 'sock' fwd_kind=3Dstruct
>> [70] PTR '(anon)' type_id=3D104
>> [84] FUNC_PROTO '(anon)' ret_type_id=3D2 vlen=3D1
>> 	'(anon)' type_id=3D70
>> [85] FUNC 'bpf_sock_destroy' type_id=3D84 linkage=3Dextern
>> --
>> [96] DATASEC '.ksyms' size=3D0 vlen=3D1
>> 	type_id=3D85 offset=3D0 size=3D0 (FUNC 'bpf_sock_destroy')
>> BTF for selftest vmlinux:
>> [74923] FUNC 'bpf_sock_destroy' type_id=3D48965 linkage=3Dstatic
>> [48965] FUNC_PROTO '(anon)' ret_type_id=3D9 vlen=3D1
>> 	'sk' type_id=3D1340
>> [1340] PTR '(anon)' type_id=3D2363
>> [2363] STRUCT 'sock' size=3D1280 vlen=3D93
>> ```
>=20
>> +int bpf_sock_destroy(struct sock_common *sk) __ksym;
>=20
> This does not match the bpf prog's BTF dump above which has pointer =
[70] pointing to FWD 'sock' [104] as the argument. It should be at least =
FWD 'sock_common' if not STRUCT 'sock_common'. I tried to change the =
func signature to 'struct sock *sk' but cannot reproduce the issue in my =
environment also.
>=20
> Could you confirm the BTF paste and 'incompatible with kernel" error =
in the commit message do match the bpf_sock_destroy declaration? If not, =
can you re-paste the BTF output and libbpf error message that matches =
the bpf_sock_destroy signature.

I don't think you'll be able to reproduce the issue with `sock_common`, =
as `struct sock_common` isn't forward declared in vmlinux.h. But I find =
it odd that you weren't able to reproduce it with `struct sock`. Just to =
confirm, did you remove the minimal `struct sock` definition from the =
program? Per the commit description, I added that because libbpf was =
throwing this error -
`libbpf: extern (func ksym) 'bpf_sock_destroy': func_proto [83] =
incompatible with kernel [75285]`

Sending the BTF snippet again (full BTF - https://pastebin.com/etkFyuJk)

```
85] FUNC 'bpf_sock_destroy' type_id=3D84 linkage=3Dextern
	type_id=3D85 offset=3D0 size=3D0 (FUNC 'bpf_sock_destroy')
[84] FUNC_PROTO '(anon)' ret_type_id=3D2 vlen=3D1
	'(anon)' type_id=3D70
[70] PTR '(anon)' type_id=3D104
[104] FWD 'sock' fwd_kind=3Dstruct
```

Compare this to the BTF snippet once I undef and define the struct in =
the test prog:

```
[87] FUNC 'bpf_sock_destroy' type_id=3D84 linkage=3Dextern
	type_id=3D87 offset=3D0 size=3D0 (FUNC 'bpf_sock_destroy')
[84] FUNC_PROTO '(anon)' ret_type_id=3D2 vlen=3D1
	'(anon)' type_id=3D85
[85] PTR '(anon)' type_id=3D86
[86] STRUCT 'sock' size=3D136 vlen=3D1
	'__sk_common' type_id=3D34 bits_offset=3D0
```

(Anyway looks like I needed to define the struct in the test prog only =
when bpf_sock_destory had `struct sock` as the argument.)=
