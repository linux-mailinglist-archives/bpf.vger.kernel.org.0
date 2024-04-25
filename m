Return-Path: <bpf+bounces-27785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F668B1A5C
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 07:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD3828505D
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 05:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A10B3BBEA;
	Thu, 25 Apr 2024 05:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z59Uzafe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C77D2B9C8
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 05:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714023431; cv=none; b=qVKIsuZeNljCZBr9sqO7YN4GmjKJw8XcOj6K8sLfygNN4fsFppJJSV2zEBLQjf13czHLJESX3IK69NKtzqPPBroCXK0ENnbYZ2vPbcKNMJIZDdeR3vKOU07R49Twa22fuvTiThgAK6KO8YLzADK4h28ShUyVfpGfnwJENx5gREk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714023431; c=relaxed/simple;
	bh=0T0+kIYSOTRr6ztkvbIcuis/OuZdar1hp7Qj+FVJpUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fxXSsbofkGx2d5BH/+AiUP6kacXmf6/WjD6x5rKcCT4Xafw2RbknxKh/xDn94CgmiDFk409mmXt0033ZIkSD1xAQ6/NF0VNxurVGMyypG4rbwur5KVUdl8kGDeMDYB2EfkNWiP5GnwdNQdFGFZivax4ixHEy7qVz/SAYhxP5Irc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z59Uzafe; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6a0406438b5so2869146d6.1
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 22:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714023429; x=1714628229; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sHkeWcX1aWi8r2lArpYdqJjzH8JdxfX3kOw9zY41oxU=;
        b=Z59UzafepPuKbvL/3VUEKxSbJhFpxsNZ1IDH/XrfnJTdWEz0Btsk3CVX3kqfyLHxGb
         i39oRZR/fp2BB7m0QXO+jsFEQ0rBFRx4ieiS0PoEVYEZ6qcAGxkEyNy2r4v78HzsTlXu
         ZYkFhRYdepovZ1W2EgljMrsn8TIJsdgQr/ckJ1wIqCJl/sQluCUeTxbEsQx9FR/qLdpE
         TLGaQ/eCgNiYgvkzP6K25etMqc7cwM2HPprdiG+2OnYJBHhNV6/DIpggR58rMH21rj98
         kF634CpCHiuuJKNovRmz0NVXkKHtcBVnrnBiE7bECpqDOG8zE0TJIZ7HhMjc4U4CxTP6
         fENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714023429; x=1714628229;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sHkeWcX1aWi8r2lArpYdqJjzH8JdxfX3kOw9zY41oxU=;
        b=Hz+lwB0WuX13zwnz58+5CLbs1CL4xCvDm2FP55STrgy47LCaHoAdw2dxuDi1QeNofI
         lInQjHkRi5FH0jGUqJ+xnGyIwsPsxV15EZBx2093ysPJjved8jGbBvpEosHJ5B4y325M
         2j2VacbI6Ai8/LMR6B95VXpg3NnBwVURWPG5OpQoX0g3GojKDPSai/Pp/Gf6j5JZWNmK
         Y49B6amJj9MKgzZvVk4G0M7YMO6gIzjGcdqlUsmD3H+b+S4ZvU8kiEqGor35wI9cULEw
         MT8PWSS7/mS3tUOOMcYrZo6N6qP+qgwKKM9rNIoK06X9SvoAcIFIn2vCYR3jVDOtWqR4
         5F1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHo1DUWzY2KVtxeSCoXFg5khcb4uo0TAChnGqnRk1waQWDxeHxMipN/bk7sDr8t/94f8qaSK7LAXS+ZSXmHI5ygbfZ
X-Gm-Message-State: AOJu0Yyudnu2dH1bxpZxFHicoh3mJsM49jNmhRx2T90KDzTSKnP3xjdU
	EHQW6/SFb6YCZRzXWm8AK0h3gTe9QoKErgUGIzkHA2JFW0KGuOmOCyJRz5RoCucWXkmat12L8t0
	jXSiermOdijACrBLoVbbn62MZ7Vg=
X-Google-Smtp-Source: AGHT+IGuuWVqeKe6dkeiAnou9yd2cNbhVPBTxLo+iY9JxR40IkT0mS9KebG34AnTcLKxjp/hpwg3FYXmATRXWkl1S3c=
X-Received: by 2002:a0c:c686:0:b0:69b:7c92:d880 with SMTP id
 d6-20020a0cc686000000b0069b7c92d880mr3993705qvj.52.1714023428790; Wed, 24 Apr
 2024 22:37:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411131127.73098-1-laoar.shao@gmail.com> <CALOAHbCBxGbLH0+1fSTQtt3K8yXX9oG4utkiHn=+dxpKZ+64cw@mail.gmail.com>
 <CAEf4BzbynKkK_sct2WdTrF2F+RJ1tD3F6nYAew+Gq82qokgQGA@mail.gmail.com>
In-Reply-To: <CAEf4BzbynKkK_sct2WdTrF2F+RJ1tD3F6nYAew+Gq82qokgQGA@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 25 Apr 2024 13:36:32 +0800
Message-ID: <CALOAHbBBDwxBGOrDWqGf2b8bRRii8DnBHCU9cAbp_Sw-Q6XKBA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 0/2] bpf: Add a generic bits iterator
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000009c5ecc0616e52df9"

--0000000000009c5ecc0616e52df9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 8:34=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Apr 11, 2024 at 6:51=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > On Thu, Apr 11, 2024 at 9:11=E2=80=AFPM Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > >
> > > Three new kfuncs, namely bpf_iter_bits_{new,next,destroy}, have been
> > > added for the new bpf_iter_bits functionality. These kfuncs enable th=
e
> > > iteration of the bits from a given address and a given number of bits=
.
> > >
> > > - bpf_iter_bits_new
> > >   Initialize a new bits iterator for a given memory area. Due to the
> > >   limitation of bpf memalloc, the max number of bits to be iterated
> > >   over is (4096 * 8).
> > > - bpf_iter_bits_next
> > >   Get the next bit in a bpf_iter_bits
> > > - bpf_iter_bits_destroy
> > >   Destroy a bpf_iter_bits
> > >
> > > The bits iterator can be used in any context and on any address.
> > >
> > > Changes:
> > > - v5->v6:
> > >   - Add positive tests (Andrii)
> > > - v4->v5:
> > >   - Simplify test cases (Andrii)
> > > - v3->v4:
> > >   - Fix endianness error on s390x (Andrii)
> > >   - zero-initialize kit->bits_copy and zero out nr_bits (Andrii)
> > > - v2->v3:
> > >   - Optimization for u64/u32 mask (Andrii)
> > > - v1->v2:
> > >   - Simplify the CPU number verification code to avoid the failure on=
 s390x
> > >     (Eduard)
> > > - bpf: Add bpf_iter_cpumask
> > >   https://lwn.net/Articles/961104/
> > > - bpf: Add new bpf helper bpf_for_each_cpu
> > >   https://lwn.net/Articles/939939/
> > >
> > > Yafang Shao (2):
> > >   bpf: Add bits iterator
> > >   selftests/bpf: Add selftest for bits iter
> > >
> > >  kernel/bpf/helpers.c                          | 120 ++++++++++++++++=
+
> > >  .../selftests/bpf/prog_tests/verifier.c       |   2 +
> > >  .../selftests/bpf/progs/verifier_bits_iter.c  | 127 ++++++++++++++++=
++
> > >  3 files changed, 249 insertions(+)
> > >  create mode 100644 tools/testing/selftests/bpf/progs/verifier_bits_i=
ter.c
> > >
> > > --
> > > 2.39.1
> > >
> >
> > It appears that the test case failed on s390x when the data is
> > a u32 value because we need to set the higher 32 bits.
> > will analyze it.
> >
>
> Hey Yafang, did you get a chance to debug and fix the issue?
>

Hi Andrii,

Apologies for the delay; I recently returned from an extended holiday.

The issue stems from the limitations of bpf_probe_read_kernel() on
s390 architecture. The attachment provides a straightforward example
to illustrate this issue. The observed results are as follows:

    Error: #463/1 verifier_probe_read/probe read 4 bytes
    8897 run_subtest:PASS:obj_open_mem 0 nsec
    8898 run_subtest:PASS:unexpected_load_failure 0 nsec
    8899 do_prog_test_run:PASS:bpf_prog_test_run 0 nsec
    8900 run_subtest:FAIL:659 Unexpected retval: 2817064 !=3D 512

    Error: #463/2 verifier_probe_read/probe read 8 bytes
    8903 run_subtest:PASS:obj_open_mem 0 nsec
    8904 run_subtest:PASS:unexpected_load_failure 0 nsec
    8905 do_prog_test_run:PASS:bpf_prog_test_run 0 nsec
    8906 run_subtest:FAIL:659 Unexpected retval: 0 !=3D 512

More details can be found at:  https://github.com/kernel-patches/bpf/pull/6=
872

Should we consider this behavior of bpf_probe_read_kernel() as
expected, or is it something that requires fixing?

--=20
Regards
Yafang

--0000000000009c5ecc0616e52df9
Content-Type: application/octet-stream; 
	name="0001-selftests-bpf-Add-test-for-probe_read_kernel.patch"
Content-Disposition: attachment; 
	filename="0001-selftests-bpf-Add-test-for-probe_read_kernel.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lvet0t420>
X-Attachment-Id: f_lvet0t420

RnJvbSBiYTZiYmJiYzI2NDhhYzM3NDE0NThhNjJmMzM2Njk0NDE1ZDQ5ZDUyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZYWZhbmcgU2hhbyA8bGFvYXIuc2hhb0BnbWFpbC5jb20+CkRh
dGU6IFRodSwgMjUgQXByIDIwMjQgMTM6MDc6NDcgKzA4MDAKU3ViamVjdDogW1BBVENIXSBzZWxm
dGVzdHMvYnBmOiBBZGQgdGVzdCBmb3IgcHJvYmVfcmVhZF9rZXJuZWwKCkl0IHdpbGwgZmFpbCBv
biBzMzkwIHdoaWNoIGlzIGJpZy1lbmRpYW4uCgpTaWduZWQtb2ZmLWJ5OiBZYWZhbmcgU2hhbyA8
bGFvYXIuc2hhb0BnbWFpbC5jb20+Ci0tLQogLi4uL3NlbGZ0ZXN0cy9icGYvcHJvZ190ZXN0cy92
ZXJpZmllci5jICAgICAgIHwgIDIgKwogLi4uL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvdmVyaWZpZXJf
cHJvYmVfcmVhZC5jIHwgMzcgKysrKysrKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAz
OSBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvYnBmL3Byb2dzL3ZlcmlmaWVyX3Byb2JlX3JlYWQuYwoKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL3ZlcmlmaWVyLmMgYi90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9icGYvcHJvZ190ZXN0cy92ZXJpZmllci5jCmluZGV4IGM0ZjlmMzA2NjQ2ZS4u
ZWRhYzY3ZDQzNDQ3IDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJv
Z190ZXN0cy92ZXJpZmllci5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9n
X3Rlc3RzL3ZlcmlmaWVyLmMKQEAgLTg0LDYgKzg0LDcgQEAKICNpbmNsdWRlICJ2ZXJpZmllcl94
YWRkLnNrZWwuaCIKICNpbmNsdWRlICJ2ZXJpZmllcl94ZHAuc2tlbC5oIgogI2luY2x1ZGUgInZl
cmlmaWVyX3hkcF9kaXJlY3RfcGFja2V0X2FjY2Vzcy5za2VsLmgiCisjaW5jbHVkZSAidmVyaWZp
ZXJfcHJvYmVfcmVhZC5za2VsLmgiCiAKICNkZWZpbmUgTUFYX0VOVFJJRVMgMTEKIApAQCAtMTk4
LDYgKzE5OSw3IEBAIHZvaWQgdGVzdF92ZXJpZmllcl92YXJfb2ZmKHZvaWQpICAgICAgICAgICAg
ICB7IFJVTih2ZXJpZmllcl92YXJfb2ZmKTsgfQogdm9pZCB0ZXN0X3ZlcmlmaWVyX3hhZGQodm9p
ZCkgICAgICAgICAgICAgICAgIHsgUlVOKHZlcmlmaWVyX3hhZGQpOyB9CiB2b2lkIHRlc3RfdmVy
aWZpZXJfeGRwKHZvaWQpICAgICAgICAgICAgICAgICAgeyBSVU4odmVyaWZpZXJfeGRwKTsgfQog
dm9pZCB0ZXN0X3ZlcmlmaWVyX3hkcF9kaXJlY3RfcGFja2V0X2FjY2Vzcyh2b2lkKSB7IFJVTih2
ZXJpZmllcl94ZHBfZGlyZWN0X3BhY2tldF9hY2Nlc3MpOyB9Cit2b2lkIHRlc3RfdmVyaWZpZXJf
cHJvYmVfcmVhZCh2b2lkKSB7IFJVTih2ZXJpZmllcl9wcm9iZV9yZWFkKTsgfQogCiBzdGF0aWMg
aW50IGluaXRfdGVzdF92YWxfbWFwKHN0cnVjdCBicGZfb2JqZWN0ICpvYmosIGNoYXIgKm1hcF9u
YW1lKQogewpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL3Zl
cmlmaWVyX3Byb2JlX3JlYWQuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9ncy92
ZXJpZmllcl9wcm9iZV9yZWFkLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAw
MDAwLi5kMGE3YzkxMDk5NjAKLS0tIC9kZXYvbnVsbAorKysgYi90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9icGYvcHJvZ3MvdmVyaWZpZXJfcHJvYmVfcmVhZC5jCkBAIC0wLDAgKzEsMzcgQEAKKyNp
bmNsdWRlICJ2bWxpbnV4LmgiCisjaW5jbHVkZSA8YnBmL2JwZl9oZWxwZXJzLmg+CisjaW5jbHVk
ZSA8YnBmL2JwZl90cmFjaW5nLmg+CisKKyNpbmNsdWRlICJicGZfbWlzYy5oIgorCitjaGFyIF9s
aWNlbnNlW10gU0VDKCJsaWNlbnNlIikgPSAiR1BMIjsKKworU0VDKCJzeXNjYWxsIikKK19fZGVz
Y3JpcHRpb24oInByb2JlIHJlYWQgNCBieXRlcyIpCitfX3N1Y2Nlc3MgX19yZXR2YWwoMHgyMDAp
Cit1NjQgcHJvYmVfcmVhZF80KHZvaWQpCit7CisJdTMyIGRhdGEgPSAweDIwMDsKKwl1NjQgZGF0
YV9kc3Q7CisJaW50IGVycjsKKworCWVyciA9IGJwZl9wcm9iZV9yZWFkX2tlcm5lbCgmZGF0YV9k
c3QsIDQsICZkYXRhKTsKKwlpZiAoZXJyKQorCQlyZXR1cm4gMDsKKwlyZXR1cm4gZGF0YV9kc3Q7
Cit9CisKK1NFQygic3lzY2FsbCIpCitfX2Rlc2NyaXB0aW9uKCJwcm9iZSByZWFkIDggYnl0ZXMi
KQorX19zdWNjZXNzIF9fcmV0dmFsKDB4MjAwKQordTY0IHByb2JlX3JlYWRfOCh2b2lkKQorewor
CXUzMiBkYXRhID0gMHgyMDA7CisJdTY0IGRhdGFfZHN0OworCWludCBlcnI7CisKKwllcnIgPSBi
cGZfcHJvYmVfcmVhZF9rZXJuZWwoJmRhdGFfZHN0LCA4LCAmZGF0YSk7CisJaWYgKGVycikKKwkJ
cmV0dXJuIDA7CisJcmV0dXJuIGRhdGFfZHN0OworfQotLSAKMi4zOS4xCgo=
--0000000000009c5ecc0616e52df9--

