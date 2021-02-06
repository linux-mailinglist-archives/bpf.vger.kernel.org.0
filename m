Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40227311C95
	for <lists+bpf@lfdr.de>; Sat,  6 Feb 2021 11:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbhBFKYr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Feb 2021 05:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhBFKYp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Feb 2021 05:24:45 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537EEC061788;
        Sat,  6 Feb 2021 02:24:05 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id u20so9860384iot.9;
        Sat, 06 Feb 2021 02:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=DrSEeR5XXqjciPqvAEERURwzS3+CTGHiv1S1iJCiwto=;
        b=k3rLnJajP4OtSJ4mo+L15VXSc16RPcGXO/bTQOhvCRmPyE2P7MvV1xRm+lQ+LmQ/Ss
         Ck8UUgq8fWWaLcUsvLbKmasGwvXDZT4f1VUbyWFZXMYTDT2RSLAvJRpBaXmtOCx9lxpG
         z430Hy7qqhZBjVjtcSaHYKAfoNcqmsCiS9YIZiyPeiN7HPoSTgLPRDbBIZQtzh6um5YA
         jsv5U3CPJGjtpvTxk/D2wzYmvuSUid6PRs75JFudPuVU3zLpeMkW1NnmrIXZENkj9P57
         Xmy4eCI7EMmT3LYX3MnWagnwKoj7rsPKn/LJh11WWglc7RSX9sRAp3uFPQSTNe0KJsrR
         BiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=DrSEeR5XXqjciPqvAEERURwzS3+CTGHiv1S1iJCiwto=;
        b=kVPdQ0cnbRavrzC5+igItNHSVHUmahRJ7T31hhhuPtygy4VYVJq9w4y/foJgkkNgVn
         flCK3USM323X3/pQnmacFDJDfAMZknGgK1qoWad35juVCHueR/xl4JGNDnOim8c8fdwJ
         yMtQSaBWi5BNDlSqfZ4INaedDwGvpWcIcMqw0DmGo2czLFz47mcvhHXxFvOL6+V4lh9x
         uywmNE3jKyk2Ms3qiTAQ9inbJPHDPTOs5We0KKpW84LTcgXNBtokbxyldG/6nS3+tg/s
         b+2F/bW0Qz5ZkBA4EwKHzeJcIEp1hallnfMky0F2sZ0IeAj2+3pw0FGDc4FdyEzvfcI/
         OeRg==
X-Gm-Message-State: AOAM531ogeIKp+npWXRkbXKTZ843sLJEq85JBTKZdGp+BEAY0ehLCqH5
        Fpq8JlvXikMIIN4yt87YqyEIxvyqfaOaOChJMeo=
X-Google-Smtp-Source: ABdhPJxCIlVXkCHBMWBO5WsjiZCHJDGOjMEgSBgd5jWHch5ifAX+sDLE9KWVjHuJxptmZvLyGZ9XUDbBIhtzOgAJZPQ=
X-Received: by 2002:a6b:e006:: with SMTP id z6mr8037925iog.110.1612607044683;
 Sat, 06 Feb 2021 02:24:04 -0800 (PST)
MIME-Version: 1.0
References: <20210204220741.GA920417@kernel.org> <CA+icZUVyB3qaqq3pwOyJY_F4V6KU9hdF=AJM_D7iEW4QK4Eo6w@mail.gmail.com>
 <20210205152823.GD920417@kernel.org> <CA+icZUWzMdhuHDkcKMHAd39iMEijk65v2ADcz0=FdODr38sJ4w@mail.gmail.com>
 <CA+icZUXb1j-DrjvFEeeOGuR_pKmD_7_RusxpGQy+Pyhaoa==gA@mail.gmail.com>
 <CA+icZUVZA97V5C3kORqeSiaxRbfGbmzEaxgYf9RUMko4F76=7w@mail.gmail.com>
 <baa7c017-b2cf-b2cd-fbe8-2e021642f2e3@fb.com> <20210205192446.GH920417@kernel.org>
 <cb743ab8-9a66-a311-ed18-ecabf0947440@fb.com> <CA+icZUUcjJASPN8NVgWNp+2h=WO-PT4Su3-yHZpynNHCrHEb-w@mail.gmail.com>
 <d59c2a53-976c-c304-f208-67110bdd728a@fb.com> <CA+icZUVhgnJ9j7dnXxLQi3DcmLrqpZgcAo2wmHJ_OxSQyS6DQg@mail.gmail.com>
 <CA+icZUWFx47jWJsV6tyoS5f18joPLyE8TOeeyVgsk65k9sP2WQ@mail.gmail.com>
 <CA+icZUUj1P_PAj=E8iF=C4m6gYm9zqb+WWbOdoTqemTeGnZbww@mail.gmail.com>
 <CA+icZUWY0zkOb36gxMOuT5-m=vC5_e815gkSEyM45sO+jgcCZg@mail.gmail.com>
 <CA+icZUW+4=WUexA3-qwXSdEY2L4DOhF1pQfw9=Bf2invYF1J2Q@mail.gmail.com>
 <8ff11fa8-46cd-5f20-b988-20e65e122507@fb.com> <CA+icZUVwM9VY5huMpbMtGL-rs16JYvBM2MDiebx6taptH3m-Jg@mail.gmail.com>
 <CA+icZUU=qnLmZWsjeU2G=R0sTkx9+6qtG6Cni1xit=-p_vG_Pw@mail.gmail.com>
 <CA+icZUUSTXqACW=0d9k4fC2y8TJEDjQ7WWwnnSR7KxsmC-SJhw@mail.gmail.com> <CA+icZUUOS03BgOoSFdUWP8G61b2wjhAx0bUGNstqS7OTm3+7iQ@mail.gmail.com>
In-Reply-To: <CA+icZUUOS03BgOoSFdUWP8G61b2wjhAx0bUGNstqS7OTm3+7iQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 6 Feb 2021 11:23:52 +0100
Message-ID: <CA+icZUUjy5cR5cq6PqSA0+KDsovqAx-zH9CozH8TpETu9jYYPw@mail.gmail.com>
Subject: Re: ERROR: INT DW_ATE_unsigned_1 Error emitting BTF type
To:     Yonghong Song <yhs@fb.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Mark Wieelard <mjw@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Tom Stellard <tstellar@redhat.com>
Content-Type: multipart/mixed; boundary="0000000000000faae705baa85682"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

--0000000000000faae705baa85682
Content-Type: text/plain; charset="UTF-8"

[ SNIP ]

> > > > > Please help do a test. I can submit a formal patch tomorrow.
> > > >
> > > > Thanks for the patch.
> > > >
> > > > Can you attach the diff as Gmail has totally truncated/malformed it?
> > > >
> > > > For the Linux breakage - you will need some additional Clang specific patches.
> > > > Is this Linux 5.11-rcX?
> > > > The "Blocking bugs" are listed in the first post of "Linux 5.11 release cycle".
> > > > Hope this helps.
> > > >
> > > > This is cool co-working :-).
> > > >
> > > > - Sedat -
> > > >
> > > > [1] https://github.com/ClangBuiltLinux/linux/issues/1228
> > >
> > > With the attached diff and new selfmade pahole looks good here.
> > >
> > > Passed (see line-numbers):
> > >
> > > 11090:+ info LD .tmp_vmlinux.btf
> > > 11099:+ info BTF .btf.vmlinux.bin.o
> > > 11103:+ LLVM_OBJCOPY=llvm-objcopy /opt/pahole/bin/pahole -J .tmp_vmlinux.btf
> > > 11121:+ info LD .tmp_vmlinux.kallsyms1
> > > 11139:+ info KSYMS .tmp_vmlinux.kallsyms1.S
> > > 11145:+ info AS .tmp_vmlinux.kallsyms1.S
> > > 11160:+ info LD .tmp_vmlinux.kallsyms2
> > > 11178:+ info KSYMS .tmp_vmlinux.kallsyms2.S
> > > 11184:+ info AS .tmp_vmlinux.kallsyms2.S
> > > 11200:+ info LD vmlinux
> > > 11210:+ info BTFIDS vmlinux
> > > 11216:+ info SORTTAB vmlinux
> > >
> > > Still building linux-kernel...
> > >
> > > Will report later if I was able to boot on bare metal.
> > >
> >
> > When running scripts/Makefile.modfinal:
> >
> > ...
> > not supported bit_size 160
> > Encountered error while encoding BTF.
> > ...
> > make[5]: *** [scripts/Makefile.modfinal:59:
> > drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko] Error 1
> > make[5]: *** Deleting file
> > 'drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko'
> >
>
> I added "bit_size 160" to libbtf.c:
>
> static int bits_to_int_bytes(uint16_t bit_size)
> {
>        if (bit_size <= 8)
>                return 1;
>        if (bit_size <= 16)
>                return 2;
>        if (bit_size <= 32)
>                return 4;
>        if (bit_size <= 64)
>                return 8;
>        if (bit_size <= 128)
>                return 16;
>        if (bit_size <= 160)
>                return 20;
>        /* BTF supports upto 16byte int (__int128). */
>        return -1;
> }
>
> It still breaks with:
>
> [521367] INT DW_ATE_unsigned_160 Error emitting BTF type
> Encountered error while encoding BTF.
> make[5]: *** [scripts/Makefile.modfinal:58:
> drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko] Error 1
> make[5]: *** Deleting file
> 'drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko'
>
> Comments?
>

Indeed there is DW_ATE_unsigned_160:

$ /opt/llvm-toolchain/bin/llvm-dwarfdump
drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.o | grep DW_AT_name
| grep DW_ATE_ | sort -u
               DW_AT_name      ("DW_ATE_signed_32")
               DW_AT_name      ("DW_ATE_signed_64")
               DW_AT_name      ("DW_ATE_unsigned_1")
               DW_AT_name      ("DW_ATE_unsigned_128")
               DW_AT_name      ("DW_ATE_unsigned_16")
               DW_AT_name      ("DW_ATE_unsigned_160")
               DW_AT_name      ("DW_ATE_unsigned_32")
               DW_AT_name      ("DW_ATE_unsigned_64")
               DW_AT_name      ("DW_ATE_unsigned_8")

Attached is diff v2 with the "bit_size 160" fix.

- Sedat -

--0000000000000faae705baa85682
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="DW_ATE_unsigned_1-pahole_1_20-dileks-v2.diff"
Content-Disposition: attachment; 
	filename="DW_ATE_unsigned_1-pahole_1_20-dileks-v2.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_kktkjr0l0>
X-Attachment-Id: f_kktkjr0l0

ZGlmZiAtLWdpdCBhL2R3YXJmX2xvYWRlci5jIGIvZHdhcmZfbG9hZGVyLmMKaW5kZXggYjczZDc4
NjdlMWU2Li5hYmExNDY3OWEwN2UgMTAwNjQ0Ci0tLSBhL2R3YXJmX2xvYWRlci5jCisrKyBiL2R3
YXJmX2xvYWRlci5jCkBAIC00NjcsOCArNDY3LDE1IEBAIHN0YXRpYyBzdHJ1Y3QgYmFzZV90eXBl
ICpiYXNlX3R5cGVfX25ldyhEd2FyZl9EaWUgKmRpZSwgc3RydWN0IGN1ICpjdSkKIAogCWlmIChi
dCAhPSBOVUxMKSB7CiAJCXRhZ19faW5pdCgmYnQtPnRhZywgY3UsIGRpZSk7Ci0JCWJ0LT5uYW1l
ID0gc3RyaW5nc19fYWRkKHN0cmluZ3MsIGF0dHJfc3RyaW5nKGRpZSwgRFdfQVRfbmFtZSkpOwot
CQlidC0+Yml0X3NpemUgPSBhdHRyX251bWVyaWMoZGllLCBEV19BVF9ieXRlX3NpemUpICogODsK
KwkJY29uc3QgY2hhciAqbmFtZSA9IGF0dHJfc3RyaW5nKGRpZSwgRFdfQVRfbmFtZSk7CisJCWJ0
LT5uYW1lID0gc3RyaW5nc19fYWRkKHN0cmluZ3MsIG5hbWUpOworCQkvKiBEV19BVEVfdW5zaWdu
ZWRfMSBoYXMgRFdfQVRfYnl0ZV9zaXplID09IDAuCisJCSogc3BlY2lhbGx5IHByb2Nlc3MgaXQu
CisJCSovCisJCWlmIChzdHJjbXAobmFtZSwgIkRXX0FURV91bnNpZ25lZF8xIikgPT0gMCkKKwkJ
CWJ0LT5iaXRfc2l6ZSA9IDE7CisJCWVsc2UKKwkJCWJ0LT5iaXRfc2l6ZSA9IGF0dHJfbnVtZXJp
YyhkaWUsIERXX0FUX2J5dGVfc2l6ZSkgKiA4OwogCQl1aW50NjRfdCBlbmNvZGluZyA9IGF0dHJf
bnVtZXJpYyhkaWUsIERXX0FUX2VuY29kaW5nKTsKIAkJYnQtPmlzX2Jvb2wgPSBlbmNvZGluZyA9
PSBEV19BVEVfYm9vbGVhbjsKIAkJYnQtPmlzX3NpZ25lZCA9IGVuY29kaW5nID09IERXX0FURV9z
aWduZWQ7CmRpZmYgLS1naXQgYS9saWJidGYuYyBiL2xpYmJ0Zi5jCmluZGV4IDlmNzYyODMwNDQ5
NS4uNDhiYTU3Mzk0MDkwIDEwMDY0NAotLS0gYS9saWJidGYuYworKysgYi9saWJidGYuYwpAQCAt
MzY3LDEzICszNjcsMzQgQEAgc3RhdGljIHZvaWQgYnRmX2xvZ19mdW5jX3BhcmFtKGNvbnN0IHN0
cnVjdCBidGZfZWxmICpidGZlLAogCX0KIH0KIAorLyogYnRmIHJlcXVpcmVzIHBvd2VyLW9mLTIg
Ynl0ZXMsIHlldCBkd2FyZiBtYXkgaGF2ZSBzb21ldGhpbmcgbGlrZQorICogRFdfQVRFX3Vuc2ln
bmVkXzI0IHdoaWNoIGVuY29kZXMgYXMgMjQgYml0cyAoMyBieXRlcykuCisgKi8KK3N0YXRpYyBp
bnQgYml0c190b19pbnRfYnl0ZXModWludDE2X3QgYml0X3NpemUpCit7CisgICAgICAgaWYgKGJp
dF9zaXplIDw9IDgpCisgICAgICAgICAgICAgICByZXR1cm4gMTsKKyAgICAgICBpZiAoYml0X3Np
emUgPD0gMTYpCisgICAgICAgICAgICAgICByZXR1cm4gMjsKKyAgICAgICBpZiAoYml0X3NpemUg
PD0gMzIpCisgICAgICAgICAgICAgICByZXR1cm4gNDsKKyAgICAgICBpZiAoYml0X3NpemUgPD0g
NjQpCisgICAgICAgICAgICAgICByZXR1cm4gODsKKyAgICAgICBpZiAoYml0X3NpemUgPD0gMTI4
KQorICAgICAgICAgICAgICAgcmV0dXJuIDE2OworICAgICAgIGlmIChiaXRfc2l6ZSA8PSAxNjAp
CisgICAgICAgICAgICAgICByZXR1cm4gMjA7CisgICAgICAgLyogQlRGIHN1cHBvcnRzIHVwdG8g
MTZieXRlIGludCAoX19pbnQxMjgpLiAqLworICAgICAgIHJldHVybiAtMTsKK30KKwogaW50MzJf
dCBidGZfZWxmX19hZGRfYmFzZV90eXBlKHN0cnVjdCBidGZfZWxmICpidGZlLCBjb25zdCBzdHJ1
Y3QgYmFzZV90eXBlICpidCwKIAkJCSAgICAgICBjb25zdCBjaGFyICpuYW1lKQogewogCXN0cnVj
dCBidGYgKmJ0ZiA9IGJ0ZmUtPmJ0ZjsKIAljb25zdCBzdHJ1Y3QgYnRmX3R5cGUgKnQ7CiAJdWlu
dDhfdCBlbmNvZGluZyA9IDA7Ci0JaW50MzJfdCBpZDsKKwlpbnQzMl90IGlkLCBuYnl0ZXM7CiAK
IAlpZiAoYnQtPmlzX3NpZ25lZCkgewogCQllbmNvZGluZyA9IEJURl9JTlRfU0lHTkVEOwpAQCAt
Mzg0LDcgKzQwNSwxMyBAQCBpbnQzMl90IGJ0Zl9lbGZfX2FkZF9iYXNlX3R5cGUoc3RydWN0IGJ0
Zl9lbGYgKmJ0ZmUsIGNvbnN0IHN0cnVjdCBiYXNlX3R5cGUgKmJ0LAogCQlyZXR1cm4gLTE7CiAJ
fQogCi0JaWQgPSBidGZfX2FkZF9pbnQoYnRmLCBuYW1lLCBCSVRTX1JPVU5EVVBfQllURVMoYnQt
PmJpdF9zaXplKSwgZW5jb2RpbmcpOworCW5ieXRlcyA9IGJpdHNfdG9faW50X2J5dGVzKGJ0LT5i
aXRfc2l6ZSk7CisJaWYgKG5ieXRlcyA8IDApIHsKKwkJZnByaW50ZihzdGRlcnIsICJub3Qgc3Vw
cG9ydGVkIGJpdF9zaXplICVodVxuIiwgYnQtPmJpdF9zaXplKTsKKwkJcmV0dXJuIC0xOworCX0K
KworCWlkID0gYnRmX19hZGRfaW50KGJ0ZiwgbmFtZSwgbmJ5dGVzLCBlbmNvZGluZyk7CiAJaWYg
KGlkIDwgMCkgewogCQlidGZfZWxmX19sb2dfZXJyKGJ0ZmUsIEJURl9LSU5EX0lOVCwgbmFtZSwg
dHJ1ZSwgIkVycm9yIGVtaXR0aW5nIEJURiB0eXBlIik7CiAJfSBlbHNlIHsK
--0000000000000faae705baa85682--
