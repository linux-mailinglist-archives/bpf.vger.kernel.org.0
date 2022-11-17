Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03D962D0EF
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 03:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbiKQCFA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 21:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiKQCE7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 21:04:59 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E6C7678
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 18:04:57 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id m14so399492pji.0
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 18:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ENt41aSYAKKS0MdfjEdw37urPf6GfQJJPjq1htFuX5o=;
        b=SpHDHaBC1v4kdqx8Dzddc1BXIAdQUdtK4pK7RXgPw9d+nkdwu2hNp6Jj+DlRbWYZdx
         PgtQDOCwMqVWp8jFedPWQcPd27R6xV585AQlH4+vJ43eEjaqAnBotFEFQJfVWM0nWAMO
         tVj9bDFfKvp4O9iKMlpcOBnb4QcIcWghQuwV49kwtHsA/vwSjqmuyUxdqmgmbDpDm71R
         d2yaz3+vHRi2Wqh5Kznli0zRaXACms2d6RYXD+ltuVWkVQzUJuVDO8e1QgW5kXsxI/Db
         Ed6AIP0guiUvvr/XN2nnDJeNHkdt1KVCu3sWYXjJJVhIePDx7cfmPtfGUb2I5CCtPJWY
         PNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ENt41aSYAKKS0MdfjEdw37urPf6GfQJJPjq1htFuX5o=;
        b=h0DHQWLtWyOG3AXhF+tuvMkneNZcLMZKo6D6tz82JqkU96bClx54jBMtBOgbNKdc3Q
         AXReZXzY9aNwjaYN021AAKdhHVdlLnDUs50I+EwJBQ+/4ctM3B+CAjBgCSfERiJFDmG5
         xwnVlVUwG6ffOr+frqTIS5wQbTf/Uqdxq8/cfp/Zouy76FjxDUsZUdFjTZvSUkdyrNI3
         b/8Ok0FL4Q8N+8mZpSAX4kvRn3hQA85Caq39hW0cojndobW83JCnNSrjdE7CKLBHQtIe
         SRQ5u3XXkKi0HbnSPms/sMNpsIXR+ASKClGHlgTf8a9i9GctwtqQuRpNrfqhG/5Jm1gs
         CEYw==
X-Gm-Message-State: ANoB5plZVNzx4EZVdBA5nik1qC49Ju1myEaeZk0AYa7kOCc5/oEzz74+
        UZ3eRU0mOsGoqefk0S25uSc=
X-Google-Smtp-Source: AA0mqf4uKlE37fjQAByuIuybeOTIQXzGvI/KTFb0Aovq5rnwt3Q4UlCoRA5mcUhp9C+5NRIBWSmn9A==
X-Received: by 2002:a17:90a:d58a:b0:20d:48bc:6666 with SMTP id v10-20020a17090ad58a00b0020d48bc6666mr577474pju.98.1668650697005;
        Wed, 16 Nov 2022 18:04:57 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id v8-20020a170902b7c800b0017d97d13b18sm12909127plz.65.2022.11.16.18.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 18:04:56 -0800 (PST)
Message-ID: <4b591f4c-d3d7-7958-33cd-b09afaaf4125@gmail.com>
Date:   Thu, 17 Nov 2022 11:04:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH bpf-next] docs/bpf: Document how to run CI without patch
 submission
Content-Language: en-US
To:     =?UTF-8?Q?Daniel_M=c3=bcller?= <deso@posteo.net>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, eddyz87@gmail.com, kafai@fb.com,
        kernel-team@fb.com, quentin@isovalent.com,
        Akira Yokosawa <akiyks@gmail.com>
References: <20221114211501.2068684-1-deso@posteo.net>
 <52151d09-92c5-f6cb-c426-f36ee0c44282@gmail.com>
 <20221116172019.mmoocxhkhan6kuhx@muellerd-fedora-MJ0AC3F3>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20221116172019.mmoocxhkhan6kuhx@muellerd-fedora-MJ0AC3F3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 16 Nov 2022 17:20:19 +0000, Daniel M=C3=BCller wrote:
> Hi Akira,
>=20
> On Wed, Nov 16, 2022 at 07:01:17PM +0900, Akira Yokosawa wrote:
>> I know this has already been applied, but am seeing new warning msgs
>> from "make htmldocs" due to this change. Please see inline comment
>> below.
>>
>> On Mon, 14 Nov 2022 21:15:01 +0000, Daniel M=C3=BCller wrote:
>>> This change documents the process for running the BPF CI before
>>> submitting a patch to the upstream mailing list, similar to what happ=
ens
>>> if a patch is send to bpf@vger.kernel.org: it builds kernel and
>>> selftests and runs the latter on different architecture (but it notab=
ly
>>> does not cover stylistic checks such as cover letter verification).
>>> Running BPF CI this way can help achieve better test coverage ahead o=
f
>>> patch submission than merely running locally (say, using
>>> tools/testing/selftests/bpf/vmtest.sh), as additional architectures m=
ay
>>> be covered as well.
>>>
>>> Signed-off-by: Daniel M=C3=BCller <deso@posteo.net>
>>> ---
>>>  Documentation/bpf/bpf_devel_QA.rst | 24 ++++++++++++++++++++++++
>>>  1 file changed, 24 insertions(+)
>>>
>>> diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/b=
pf_devel_QA.rst
>>> index 761474..08572c7 100644
>>> --- a/Documentation/bpf/bpf_devel_QA.rst
>>> +++ b/Documentation/bpf/bpf_devel_QA.rst
>>> @@ -44,6 +44,30 @@ is a guarantee that the reported issue will be ove=
rlooked.**
>>>  Submitting patches
>>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> =20
>>> +Q: How do I run BPF CI on my changes before sending them out for rev=
iew?
>>> +--------------------------------------------------------------------=
----
>>> +A: BPF CI is GitHub based and hosted at https://github.com/kernel-pa=
tches/bpf.
>>> +While GitHub also provides a CLI that can be used to accomplish the =
same
>>> +results, here we focus on the UI based workflow.
>>> +
>>> +The following steps lay out how to start a CI run for your patches:
>>
>> Lack of a blank line here results in warning msgs from "make htmldocs"=
:
>>
>> /linux/Documentation/bpf/bpf_devel_QA.rst:55: ERROR: Unexpected indent=
ation.
>> /linux/Documentation/bpf/bpf_devel_QA.rst:56: WARNING: Block quote end=
s without a blank line; unexpected unindent.
>>
>> Can you please fix it?
>>
>> For your reference, here is a link to reST documentation on bullet lis=
ts:
>>
>>     https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html=
#bullet-lists
>>
>>         Thanks, Akira
>=20
> Thanks for pointing that out. I had not found any references to this rs=
t file
> being included in automated doc generation. Will fix it up.

JFYI,

bpf_devel_QA is listed under the toctree directive in Documentation/bpf/f=
aq.rst.

If you failed to enlist a new .rst file in a toctree somewhere, you would=
 see
a complaint from "make htmldocs", in this case:

  Documentation/bpf/bpf_devel_QA.rst: WARNING: document isn't included in=
 any toctree

        Thanks, Akira

>=20
> Daniel
