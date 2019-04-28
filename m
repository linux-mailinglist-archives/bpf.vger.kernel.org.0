Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2DAFBC13
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2019 00:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfD1WL6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Apr 2019 18:11:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35896 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfD1WL5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Apr 2019 18:11:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id o4so1047226wra.3
        for <bpf@vger.kernel.org>; Sun, 28 Apr 2019 15:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/IL43qS6udoTDftX6QDe2Hq5Yokp9Y3gaBgT9d3a0HA=;
        b=EDvp9iUTucXpt0CkeBi2nbSpeptQNs9i1I0AlLIsyuzqMepEElKGgJL3OKAB4qk7m1
         HVdRnEIIhUbJxR1lSDVBsPYLZC2ElbkDbOW+JKOHWjRSDCFNk2bgosrdc0q13s+qjEAE
         86XZmI9N7sT6FBK/nJwSqBZrCF7XMevPSo2HACKA+RvzSfZnZHbn7VhzBaFDP3O3H1yJ
         qe2COYCvny3n/ljW6jwh3Ryz5oEm8/MRmboqpCF8MSR4YZMb4GdJVeUy2t8OQpZjiHzv
         9WnE9tRi8o+aPAkSuZKuOd80B5xc7dLb0fnyYcvWJRtN054eXoRq8eyPzPgz56sx8HHi
         qcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/IL43qS6udoTDftX6QDe2Hq5Yokp9Y3gaBgT9d3a0HA=;
        b=L6c6+2s5K46vC690yUI27GAcRu4wiecneJY4H/kfvUvh8Er4Ia0j4s80L+X2P/6aVo
         C+U49uZF3pRtrgbEvr0n4dQNjiiQBtXzhv5tcLRafT1WXqM40AZmq1AM6cFs9ENquMfp
         O39WGDiClGl+z/x+7onuplHLxFB4q3enoWPH+UswoZ01snRqJNGJthY2l8jtTKSB3Cny
         i5b35PZlekpu9kBUK7P7A5zehGEDahjDdO0gP8/KV/doWaOEum6gk7qovm50SVBO0A4q
         W8V7GWVi0u/dxWOraaKaEjx8DMkwFT7jroFnWw7zi8otoaxYyiTGAaHIsjzrT4w7MV6+
         ixhw==
X-Gm-Message-State: APjAAAUFhs8FiJHRV4YJfKoO8YeF71xB2w/Mg3psH49EyRZIc2tRdyyJ
        C+DM3x+ctDS2wLgNrsX34ofBLA==
X-Google-Smtp-Source: APXvYqwEo/2IK9hxShmxq/tTuamaV+b8HCjzN+6sVKByA/bSot2+V8OUigDAfffmTOYA3POvLkmAZA==
X-Received: by 2002:a5d:684c:: with SMTP id o12mr3331059wrw.308.1556489515023;
        Sun, 28 Apr 2019 15:11:55 -0700 (PDT)
Received: from [192.168.0.23] (cpc1-cmbg19-2-0-cust104.5-4.cable.virginm.net. [82.27.180.105])
        by smtp.gmail.com with ESMTPSA id c6sm26047475wmb.21.2019.04.28.15.11.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 15:11:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: 32-bit zext time complexity (Was Re: [PATCH bpf-next]
 selftests/bpf: two scale tests)
From:   Jiong Wang <jiong.wang@netronome.com>
In-Reply-To: <20190427030512.zs3tfdudjbfpyawh@ast-mbp>
Date:   Sun, 28 Apr 2019 23:11:57 +0100
Cc:     Alexei Starovoitov <ast@kernel.org>, daniel@iogearbox.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "oss-drivers@netronome.com" <oss-drivers@netronome.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <760D400C-2548-41B6-AE34-F89A66397A75@netronome.com>
References: <20190412214132.2726285-1-ast@kernel.org>
 <lyimv3hujp.fsf@netronome.com>
 <20190425043347.pxrz5ln4m7khebt6@ast-mbp.dhcp.thefacebook.com>
 <lylfzyeebr.fsf@netronome.com>
 <20190425221021.ov2jj4piann7wmid@ast-mbp.dhcp.thefacebook.com>
 <lyk1fgrk4m.fsf@netronome.com> <20190427030512.zs3tfdudjbfpyawh@ast-mbp>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On 27 Apr 2019, at 04:05, Alexei Starovoitov =
<alexei.starovoitov@gmail.com> wrote:
>=20
> On Fri, Apr 26, 2019 at 02:06:33PM +0100, Jiong Wang wrote:

<snip>

>>=20
>>> Note that bpf_patch_insn_single() is calling bpf_adj_branches() =
twice too.
>>> And dead_code + convert_ctx + fixup_bpf_calls are calling
>>> bpf_patch_insn_single() a lot.
>>> How about before dead_code pass we convert the program into =
basic-block
>>> format, patch it all, and then convert from bb back to offsets.
>>> Patching will become very cheap, since no loop over program will be
>>> necessary. A jump from bb-N to bb-M will stay as-is regardless
>>> of amount of patching was done inside each bb.
>>> The loops inside these patching passes will be converted from:
>>> for (i =3D 0; i < insn_cnt; i++, insn++)
>>> into:
>>> for each bb
>>>  for each insn in bb
>>=20
>> Interesting. If I am understanding correctly, BB then needs to =
support
>> dynamic insn buffer resize. And after all insn patching finished, all =
BBs
>> are finalized, we then linearized BBs (in a best order) to generate =
the
>> final bpf image.
>=20
> dynamic BB resize could be done similar to existing prog resize.
> It grows in page increments.
>=20
>>> As far as option 1 "also pass aux_insn information to JITs"...
>>> in theory it's fine, but looks like big refactoring to existing =
code.
>>=20
>> Will do quick explore, might turn out to be small change.
>>=20
>>> So if you want to make this bb conversion as step 2 and unblock the
>>> current patch set faster I suggest to go with option 2 "Introduce =
zero
>>> extension insn".
>>=20
>> A second think, even zero extension insn introduced, it is inserted =
after
>> the sub-register write insn, so we are still doing insert *not*
>> replacement, insn_delta inside bpf_patch_insn_single will be 1, so =
the slow
>> path will always be taken (memmove + bpf_prog_realloc + 2 x
>> bpf_adj_branches).
>=20
> ahh. right.
>=20
>> For the 1M-scale test, bpf_patch_insn_single is triggered because of =
hi32
>> poisoning, not lo32 zext. So we just need to change MOV32 to MOV64 in =
the
>> testcase which doesn't break the initial testing purpose of this =
testcase
>> from my understanding. This then could avoid 1M call to
>> bpf_patch_insn_single and pass the test after 32-bit opt patch set =
applied.
>>=20
>> Without this change and with hi32 randomization enabled, scale tests =
will
>> still hang before insn patch infra improved.
>>=20
>> @@ -228,7 +228,7 @@ static void bpf_fill_scale1(struct bpf_test =
*self)          =20
>> -             insn[i++] =3D BPF_ALU32_IMM(BPF_MOV, BPF_REG_0, 42);
>> +             insn[i++] =3D BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 42);
>>=20
>> This is change is not to paperover the underlying issue. We now know =
the
>> existing insn patch infra doesn't scale to million level, so could =
work on
>> improving it in the next step.
>=20
> I'm hesitant to step back.
> Do you see a program that can hit this patch_insn issue already?
> (I mean without your hi32/lo32 zext changes).

No really on real world program which I feel won't do that much insn =
patching.  =20
                                                                         =
       =20
But on test_verifier, could be reproduced through enabling jit blinding, =
       =20
because the "scale" test contains imm insn.                              =
       =20
                                                                         =
       =20
For example, on bpf-next master, just run:                               =
       =20
                                                                         =
       =20
  sysctl net/core/bpf_jit_enable=3D1                                     =
         =20
  sysctl net/core/bpf_jit_harden=3D2                                     =
         =20
  test_verifier 732 (732 is the test number for =E2=80=9Cscale: scale =
test1=E2=80=9D on my env) =20
                                                                         =
       =20
This enables constant blinding which also needs insn patching.           =
       =20
test 732 contains nearly 1M BPF_MOV_IMM to be blinded, so could          =
       =20
have similar effect as hi32 poisoning.                                   =
       =20
                                                                         =
       =20
And benchmarking shows, once insn patch helper is called over 15000 =
times,    =20
then the user could fell the load delay, and when it is called around    =
  =20
50000 times, it will take about half minutes to finish verification.     =
       =20
                                                                         =
       =20
15000 :   3s                                                             =
       =20
45000 :  29s                                                             =
       =20
95000 : 125s                                                             =
       =20
195000: 712s=20

>=20
>> At the same time the issue exposed from hi32 poisoning does raise =
alarm
>> that there could be the same issue for lo32 zext, therefore this =
patch set
>> doesn't scale if there are lots of insns to be zero extended, even =
though
>> this may not happen in real world bpf prog.
>>=20
>> IMHO, avoid using insn patching when possible might always be better. =
So,
>> if option 1 turns out to also generate clean patch set and introduce =
small
>> changes, I am going to follow it in the update version.
>>=20
>> Please let me know if you have different opinion.
>=20
> if you can craft a test that shows patch_insn issue before your set,
> then it's ok to hack bpf_fill_scale1 to use alu64.

As described above, does the test_verifier 732 + jit blinding looks =
convincing?

> I would also prefer to go with option 2 (new zext insn) for JITs.

Got it.

> I still don't have good feeling about option 1.
> Exposing all of aux_data to JITs may become a headache
> in the verifier development. It needs to be done carefully.

OK, understood.

Just for clarification, I thought to just add a field, something like    =
       =20
"bool *zext_dst" inside bpf_prog_aux. Then only copy                     =
       =20
"env->insn_aux_data[*].zext_dst" to bpf_prog->aux->zext_dst, not copy =
all        =20
aux_data generated by verifier. The field in bpf_prog could latter be =
extended  =20
to a structure contains those analysis info verifier want to push down =
to       =20
JIT back-ends, and JIT back-end must free them as soon as JIT =
compilation is    =20
done.=
