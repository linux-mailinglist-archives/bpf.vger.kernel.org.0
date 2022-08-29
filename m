Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4299C5A4575
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 10:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiH2Ivn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 04:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiH2Ivm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 04:51:42 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1496A5A156;
        Mon, 29 Aug 2022 01:51:41 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id k18-20020a05600c0b5200b003a5dab49d0bso4049398wmr.3;
        Mon, 29 Aug 2022 01:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc;
        bh=9BnMApz7EUoCqZtEzBOgAZrc7q/eJ//ESREAsdZ4UCg=;
        b=ilwyWGCbbXanymXRpkD8QyInA1ccP/64utCam9miS7PH4TH4kIBubUYb1TRk9t/9bR
         WYHKhLshr5FIfvphNx1j07LjFHrVL0ylXO1XqoUZXBKMhO87sCselqX5Fp/FyeNJo6z7
         eZXlMnIA2Yx4JkBLngNuf/M4Bd3BabXZeAz74eEOjaIuZ/t7/qAqYq6tWRmXdz/5oBA7
         uQwzgPYpWUdiaW951f4wOxFjand8ZbSrV3Ox/vsTo29ZokVsYfEyc2lpyVSpxW/ycArM
         Xckzoa9I+0RCo6D/N+sVLSPEdvUbvPykq4mVcl2NIhxnAthD0I6VdknojpZktH5wYDD7
         3XRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=9BnMApz7EUoCqZtEzBOgAZrc7q/eJ//ESREAsdZ4UCg=;
        b=awZZe7dbQM6f06R7nj0AqQSEnibhvSLSN6ZFl0IwkGU9NqbYdCCUitIcVKC/hlykof
         mAKkZFpvkcjjIHdXMiViMdiD313zmheV84Fc6TjC0hIXEqAboOtbrFazKXnEtT+YzKvS
         b7t252Oir48p8To0+NevT+xzPBxH7f+XFghtOgyVtl25bPciwy28CSEPmPD2cy5/b+eP
         XHf5rUOGnreWFqKdYzggLigllL5LX0Chdq8txlITXEUi4Lm7vZe3jHNDOtuXY4sVZ4Uo
         3sRkMw1+DSnZPlsQw9TrSrJbeqqsg7iFbRZLFIDTgvHKWyJTS/wYF0vLRfUAHrDJ81XO
         gCfA==
X-Gm-Message-State: ACgBeo20imDVWrx90WM1g1Bh47kZMgLZghadajuNQSto1xfp68Iusb+N
        BWyx4OEjZw88am/ycz5Chl8=
X-Google-Smtp-Source: AA6agR7MakByQn2IdGMObBjMlsRW2NGxzJna+CdHogR+7/p5NBhFzsg2HqAZVb4va1i1XmoB5m8hJg==
X-Received: by 2002:a1c:ac02:0:b0:3a6:6cd8:1cdd with SMTP id v2-20020a1cac02000000b003a66cd81cddmr5949487wme.143.1661763099576;
        Mon, 29 Aug 2022 01:51:39 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:612e:4c5:1fc2:7d5d])
        by smtp.gmail.com with ESMTPSA id a15-20020a056000050f00b0021f0af83142sm6407482wrf.91.2022.08.29.01.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 01:51:38 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH bpf-next v2 2/2] Add table of BPF program types to
 libbpf docs
In-Reply-To: <CAEf4BzZnsEAGOXY0KGAN6ZcLsHeMYEfRGaO20jEJk_soqLnD7w@mail.gmail.com>
        (Andrii Nakryiko's message of "Thu, 25 Aug 2022 13:35:40 -0700")
Date:   Mon, 29 Aug 2022 09:26:56 +0100
Message-ID: <m2czcj78vj.fsf@gmail.com>
References: <20220824221018.24684-1-donald.hunter@gmail.com>
        <20220824221018.24684-3-donald.hunter@gmail.com>
        <CAEf4BzZnsEAGOXY0KGAN6ZcLsHeMYEfRGaO20jEJk_soqLnD7w@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (darwin)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
>>  libbpf
>>  =3D=3D=3D=3D=3D=3D
>>
>> @@ -9,6 +11,7 @@ libbpf
>>     API Documentation <https://libbpf.readthedocs.io/en/latest/api.html>
>
> I'd put program_types here, it's more relevant and important than
> libbpf naming conventions

Good suggestion, thanks.

>>     libbpf_naming_convention
>>     libbpf_build
>> +   program_types
>>
>>  This is documentation for libbpf, a userspace library for loading and
>>  interacting with bpf programs.
>> diff --git a/Documentation/bpf/libbpf/program_types.rst b/Documentation/=
bpf/libbpf/program_types.rst
>> new file mode 100644
>> index 000000000000..dc65ede09eef
>> --- /dev/null
>> +++ b/Documentation/bpf/libbpf/program_types.rst
>> @@ -0,0 +1,18 @@
>> +.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>> +
>> +.. _program_types_and_elf:
>> +
>> +Program Types  and ELF Sections
>
> nit: two spaces?

Ack.

>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +The table below lists the program types, their attach types where relev=
ant and the ELF section
>> +names supported by libbpf for them. The ELF section names follow these =
rules:
>> +
>> +- ``type`` is an exact match, e.g. ``SEC("socket")``
>> +- ``type+`` means it can be either exact ``SEC("type")`` or well-formed=
 ``SEC("type/extras")``
>> +  with a =E2=80=98``/``=E2=80=99 separator, e.g. ``SEC("tracepoint/sysc=
alls/sys_enter_open")``
>
> '/' is always going to be a type and "extras" separator, but extra
> section format is not formalized. We have cases where it's all '/'s
> (like tracepoint you mentioned), but newer and more complicated format
> uses ':' as separator, e.g.
> SEC("usdt/<path-to-binary>:<usdt_provide>:<usdt_name>") (let's mention
> the latter as well to not create false impression of only ever having
> '/' as separator)

I will add a more detailed description extras format and include the
USDT example.

>> +
>> +.. csv-table:: Program Types and Their ELF Section Names
>> +   :file: ../../output/program_types.csv
>> +   :widths: 40 30 20 10
>> +   :header-rows: 1
>
> it would be helpful to include a short snippet from generated CSV file
> to give a general idea of the output

Ack.

