Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C6A352EF5
	for <lists+bpf@lfdr.de>; Fri,  2 Apr 2021 20:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbhDBSJR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Apr 2021 14:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhDBSJQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Apr 2021 14:09:16 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18967C0613E6;
        Fri,  2 Apr 2021 11:09:15 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id q9so2828364qvm.6;
        Fri, 02 Apr 2021 11:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=IPJOwne4o7wbzQj2+cAsCdRql9z508cFM/cvqPCLTp0=;
        b=ZW3Bv5wiu+6ChQYfi1ZUcaF02LQXo6Lpan6RSfU3eTfC52Tx8uQy+5sodqvVX41MGB
         phVN9XkPOyY0epwOs7waazuli1vLSRw6fCX0QYbo0HecKDLmpV3VIil6qxwpY5qWDeHR
         Z2rzQiw9eucnjndZgjvxxPoGEAc+Xp06mQ5b1A+xSFdfd9R0cPN27hJOzYNenPCl1bGW
         T4SwXM/frb10/TXNEMCoUXXgGub/7vJiln95HJOq+GeQeAL2DyeIn2y3iu7G4H+djAwa
         fBCK5HUccvpifyN8pQKn3aJ9lEdXiM3ZS2m+Wyvdg7jKDZO6s/nDVSimbh9KgWuU+92P
         73DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=IPJOwne4o7wbzQj2+cAsCdRql9z508cFM/cvqPCLTp0=;
        b=QD+BAdDwgpBm6g89nSjNY+4Qh620VRqFH1ymHLXHVJrensiTBtERuv1/Oxe/eYxKx9
         G9Ib4G+FOFcPY55nkHi913Tf4cRPuj6oPkFqDqcBrjDlK5E/VvdIuv2XKD2dc9r5TMxB
         s6TUS0Bg3EqZwd2wCsJkJgOUQLqi4WXrD88Xbn5AyJmAnyJBzIg4zcDqTVCU2sw8wJ2B
         zxqYJfoJs7HfBBtKSXKpuxaYHsyL+ZtAFfs/tJP5+rCZJ9LUta9AQ9bfk6T98YJ2fZPd
         l0VLzeiQ356hQBRWiSm31GGsnc3RThZQOSeCx3Sbl532JDh+QYWS2xzLLoQJYuMFETs3
         srXg==
X-Gm-Message-State: AOAM530h2WcbtY2XW0K0n6Jq0hLY7mb1hwT5aJA1yrPxKV9l/O2qaqb9
        /aMBMMVlLdLHJP89vUV2h2Y=
X-Google-Smtp-Source: ABdhPJwtIDgf3Qf+o1mcR22MVcKNzflD/nb8s7sISm6sWRghXJ+T9pDchK1tJk8yQdXBvlCkqnlubw==
X-Received: by 2002:a05:6214:20ad:: with SMTP id 13mr13492012qvd.35.1617386954367;
        Fri, 02 Apr 2021 11:09:14 -0700 (PDT)
Received: from [192.168.86.185] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id k127sm8008449qkc.88.2021.04.02.11.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 11:09:13 -0700 (PDT)
Date:   Fri, 02 Apr 2021 15:08:27 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <82dfd420-96f9-aedc-6cdc-bf20042455db@fb.com>
References: <20210401213620.3056084-1-yhs@fb.com> <e6f77eb7-b1ce-5dc3-3db7-bf67e7edfc0b@fb.com> <CAENS6EsZ5OX9o=Cn5L1jmx8ucR9siEWbGYiYHCUWuZjLyP3E7Q@mail.gmail.com> <1ef31dd8-2385-1da1-2c95-54429c895d8a@fb.com> <CAENS6EsiRsY1JptWJqu2wH=m4fkSiR+zD8JDD5DYke=ZnJOMrg@mail.gmail.com> <YGckYjyfxfNLzc34@kernel.org> <YGcw4iq9QNkFFfyt@kernel.org> <2d55d22b-d136-82b9-6a0f-8b09eeef7047@fb.com> <82dfd420-96f9-aedc-6cdc-bf20042455db@fb.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH dwarves] dwarf_loader: handle subprogram ret type with abstract_origin properly
To:     Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     David Blaikie <dblaikie@gmail.com>, dwarves@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf <bpf@vger.kernel.org>,
        kernel-team@fb.com, Nick Desaulniers <ndesaulniers@google.com>,
        Jiri Olsa <jolsa@kernel.org>
From:   Arnaldo <arnaldo.melo@gmail.com>
Message-ID: <E9072F07-B689-402C-89F6-545B589EF7E4@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On April 2, 2021 2:42:21 PM GMT-03:00, Yonghong Song <yhs@fb=2Ecom> wrote:
>On 4/2/21 10:23 AM, Yonghong Song wrote:
:> Thanks=2E I checked out the branch and did some testing with latest
>clang=20
>> trunk (just pulled in)=2E
>>=20
>> With kernel LTO note support, I tested gcc non-lto, and llvm-lto
>mode,=20
>> it works fine=2E
>>=20
>> Without kernel LTO note support, I tested
>>  =C2=A0 gcc non-lto=C2=A0 <=3D=3D=3D ok
>>  =C2=A0 llvm non-lto=C2=A0 <=3D=3D=3D not ok
>>  =C2=A0 llvm lto=C2=A0=C2=A0=C2=A0=C2=A0 <=3D=3D=3D ok
>>=20
>> Surprisingly llvm non-lto vmlinux had the same "tcp_slow_start"
>issue=2E
>> Some previous version of clang does not have this issue=2E
>> I double checked the dwarfdump and it is indeed has the same reason
>> for lto vmlinux=2E I checked abbrev section and there is no cross-cu
>> references=2E
>>=20
>> That means we need to adapt this patch
>>  =C2=A0 dwarf_loader: Handle subprogram ret type with abstract_origin
>properly
>> for non merging case as well=2E
>> The previous patch fixed lto subprogram abstract_origin issue,
>> I will submit a followup patch for this=2E
>
>Actually, the change is pretty simple,
>
>diff --git a/dwarf_loader=2Ec b/dwarf_loader=2Ec
>index 5dea837=2E=2E82d7131 100644
>--- a/dwarf_loader=2Ec
>+++ b/dwarf_loader=2Ec
>@@ -2323,7 +2323,11 @@ static int die__process_and_recode(Dwarf_Die=20
>*die, struct cu *cu)
>         int ret =3D die__process(die, cu);
>         if (ret !=3D 0)
>                 return ret;
>-       return cu__recode_dwarf_types(cu);
>+       ret =3D cu__recode_dwarf_types(cu);
>+       if (ret !=3D 0)
>+               return ret;
>+
>+       return cu__resolve_func_ret_types(cu);
>  }
>
>Arnaldo, do you just want to fold into previous patches, or
>you want me to submit a new one?

I can take care of that=2E

And I think it's time for to look at Jiri's test suite=2E=2E=2E :-)

It's a holiday here, so I'll take some time to get to this, hopefully I'll=
 tag 1=2E21 tomorrow tho=2E

Cheers,

- Arnaldo=20

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
