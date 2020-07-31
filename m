Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B23B2343C7
	for <lists+bpf@lfdr.de>; Fri, 31 Jul 2020 11:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732363AbgGaJ4n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Jul 2020 05:56:43 -0400
Received: from mout.web.de ([212.227.15.4]:56461 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732162AbgGaJ4n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Jul 2020 05:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1596189393;
        bh=SGN3k5ZRgUnvZCii3C+/Ng2G3/ftOX2dhLBx5dsxz68=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ZVmGxQJHTN53IwPB/InJ/oZwWU/0EESlvrbeySxpHRGuCnXcY9D8NJAU30NKUAJyh
         5WM3A7ewSqDwTAzs2i215vkkr1v7dFJHKG+jdDlU0bd7iNF2yQnjopXqDS9rTAsHWI
         fUw5x5YweEdHSzpIGkKSkubdOlQHOGeVaX2jm7JM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([95.115.7.237]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LtkCj-1kk27h3kwv-011Duu; Fri, 31
 Jul 2020 11:56:32 +0200
Subject: Re: [PATCH bpf] libbpf: Fix register in PT_REGS MIPS macros
To:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
References: <05fb9d72-d1a7-5346-b55b-4495cdf54124@web.de>
 <76288d74-3110-952a-f068-e040d63dbd7d@iogearbox.net>
From:   Jerry Crunchtime <jerry.c.t@web.de>
Message-ID: <a6cdc832-1142-f1e0-4393-b982c51eac89@web.de>
Date:   Fri, 31 Jul 2020 11:56:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <76288d74-3110-952a-f068-e040d63dbd7d@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WVt5QOi5nRk/VVoU0E1LMeqnbKQ24dLqIQ++d9L2Cg3uCan8rkK
 IOpMeWePVyWvn5Eii5rWKsmIJL6M9dAG2LpBluUwb8tIEwtoYXDsrahSrwqEI4pHAYF/Fn8
 HNBHrtpqsBE3b8D8o91P4nUDyhZEI68Rj9AYrgKbMmWAuMeYL84CjPiKT/gGgxCBskM5ng3
 g4X5r18Z7gmUne4RA1KiQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RrY2vgm5bI4=:FppHYiBE2wOtBHFO994FFE
 AsIcGQDuywBuqd9qdGCPY6WNK0CEa+cWL1iMWUKmpYsP+JTWr6+j4Bu7GnI+rnWmlFSQMA4zI
 uIA4TEboewkX554UhvmbqSmLWChYgtEUGyfmWIxUJgWKB6nFcpOtNXK2Rge3UR8odbzpf01os
 Yb6v+Uru6Nzeqg5ymh/S3+2y6FCw4DJfnGpGyS0n+qBUy2yIUOGZeszv3vOHBXQUite6Vo889
 9M2jw/euCelK28iG8og10jFamlMtdRs90jKDGh1pWE1MDSaD0n5wXYGgTzgio8p5YigahnFSe
 GHXiCbC2+ZxvWzVrstKp2/Xllw/h+GUe43BZUUCCA8TrvPPK1vr3wCi1T3qCfwsLbaDi/Jujm
 j2xQwRK59/CYxUCZwhaN6Fj70W+qYSzqX7ug8JCD19O81JaXxsHCtBoU521pcJseF0EqjwaPc
 UF9fIsY516SSQX9kM91EpKAyATkxNeopQhKcDc/PlLv2mM1AEP+KUrSStTF4QuNFNClrFd4iR
 6bfJ9Bq98LBMhjhA+Nl0m4IXeqg6CZRs3F9/Z0g4x79fsidd/yPmmgL1tNY4/XaqmAR6x2VPe
 fhKDOcPK3Sm/Lv93Qdfwkg2vCKazxlC73vpgUOZGw8h9xyKlsUC7Cbl2pWklQhBFnr8ZM3HfW
 jzyQU663SJESxOYUlfz1Xu5bXIapu1rMhXuEmlFG71SUjClrvEa+w1c6AEcesvzxa4lohrwMJ
 kZgO4Z9y9coqH+nH/t3+332FOi5GHNxF6jAdWLqAtiX4NUdNosM8CCWi4NAkJ1DhyFFy880Xp
 v9WFhyB5YIA4g8bPpMWUK9eATs3prxIY6hUSQMVWsT143Xy4UySJCVGjOh4uV4em0ZkuiUxIH
 edMTX7RowJkkah5hwGYv5pHh1rUP2F6ZGofq05ZT8yZJOn9flvptX1XYWjqj4EFdqs1Yd5HKR
 PwPw4nX1wXT5bX9t0J4avHUaCXzYyvsy4Sak1Mog7EDUdjXlIXejr+gCQjKkt1uIDij0/eRDX
 B3/S0U9TY+oW2DWnS22TL04/MMED8xvbf0rRXGVsKaDAXrWefFi46h/GA3UhypqzklHQvEyXt
 WoY+kcEBzNwUx89JEP+tjCrfmdOhjSHeNMupP/UHfCaKr/+Rn7jtqvXLkm4vOeSmMtvs9aDXB
 JJ/Czfsy53IavaGTIFnbq25UvctE4sqAfD7LNcuJ3+pu2w6aBIX04Seh9HKprXMEmmh+EoUNW
 /3dW6pBHQDhfLF8Kg
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

 > Jerry, your patch is missing a Signed-off-by from you.

Signed-off-by: Jerry Crunchtime <jerry.c.t@web.de>

On 7/31/20 1:00 AM, Daniel Borkmann wrote:
> On 7/30/20 1:44 PM, Jerry Crunchtime wrote:
>> The o32, n32 and n64 calling conventions require the return
>> value to be stored in $v0 which maps to $2 register, i.e.,
>> the second register.
>>
>> Fixes: c1932cd ("bpf: Add MIPS support to samples/bpf.")
>
> Jerry, your patch is missing a Signed-off-by from you. It should be
> enough if
> you just reply with one in here that I'll add to the commit message and
> I'll
> take it via bpf tree then, thanks.
>
>> ---
>> =C2=A0=C2=A0tools/lib/bpf/bpf_tracing.h | 2 +-
>> =C2=A0=C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
>> index 58eceb884..ae205dcf8 100644
>> --- a/tools/lib/bpf/bpf_tracing.h
>> +++ b/tools/lib/bpf/bpf_tracing.h
>> @@ -215,7 +215,7 @@ struct pt_regs;
>> =C2=A0=C2=A0#define PT_REGS_PARM5(x) ((x)->regs[8])
>> =C2=A0=C2=A0#define PT_REGS_RET(x) ((x)->regs[31])
>> =C2=A0=C2=A0#define PT_REGS_FP(x) ((x)->regs[30]) /* Works only with
>> CONFIG_FRAME_POINTER */
>> -#define PT_REGS_RC(x) ((x)->regs[1])
>> +#define PT_REGS_RC(x) ((x)->regs[2])
>> =C2=A0=C2=A0#define PT_REGS_SP(x) ((x)->regs[29])
>> =C2=A0=C2=A0#define PT_REGS_IP(x) ((x)->cp0_epc)
>>
>> --
>> 2.17.1
>
