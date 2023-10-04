Return-Path: <bpf+bounces-11348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1B07B778A
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 07:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8CB9A2814BB
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 05:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A383C5670;
	Wed,  4 Oct 2023 05:50:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE97539D
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 05:50:39 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BE9A7
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 22:50:37 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-327b7e08456so1730239f8f.2
        for <bpf@vger.kernel.org>; Tue, 03 Oct 2023 22:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696398636; x=1697003436; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FKHhxuIlr/c77XZaUaUoCKzU1hgbqTecaQRJ3kU4bOY=;
        b=P8V8DOYttIxlGNX2ckl4+RIHHlr+yLmd7Y3XU+t6P8af3s9c13PGJJoVlYGXNXTU1U
         t6me23KPJS4FBxgKfKuc2bAl2fKN/3QVXKr3amJm9OtQApWgnqrbTNU0Dky/EzqgIrQ5
         LC2pDWmgfLCqhNIoT4KjsoZTBv5DC66kpaXE+tlZGRl9daTTTwfKXIgxw3w5o7fWe25n
         Npjo0nN8oP2tO0UIPiKJAunTQqp7DmIPuXRQgs1qgrzgdar72lpKrSh/RGLLn1Zm6H+m
         riA+hngug/H1uO/rJrxXwUfGTlZmuHz/gPsKXsWDAm7nxSnqHOPRUiZqdMfy1Qo6iKlW
         MdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696398636; x=1697003436;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FKHhxuIlr/c77XZaUaUoCKzU1hgbqTecaQRJ3kU4bOY=;
        b=i8FpdXFSQK0t5k83FS1mVrfvZboHO9tUiR1xh4V1BBXTN0sQFcn/rLdsNmCO/bO3Wt
         SK+8M7gRrSV2UkGSHMkLxPOX3W6Fb6ZQJB1Na7c7/cJBAIrSI7GyM7S+FHovdBO6gT8K
         5CZ5kbkszEUgoIF3uYH4AGL+n8i3m1gvE89egiW3KpO2pBrCmOAUGl72P7UPJgp1Sf9R
         2r1vcDKaLASbUqmNWu1SkBTLgpBKtG6w70wqqme6B2tse1sVoF98A5Sachefl0GqxLm3
         HssHhbeA1zw4kG6V7dLK3joUqYfdt77lzfMCKr8t2KuF5BtzzOBk9jfUf5/ueQGj4lie
         KfDA==
X-Gm-Message-State: AOJu0YxiICI/CtmWyYAxCMepZpIam2e2523l2nvYqU3pa3/yZtzyUZoi
	4zZn3BTmU0BJxxaIhO3tyHpcZB16R1OfMNLElFH2DtXyXVA=
X-Google-Smtp-Source: AGHT+IH28Hqr1BsV+/zk6YCEk5JOsmU2Klxk6dp71eroVQH/b18OcSDKV2oN9NI8McPIyuRq+ByHOO1k+Sd+fARiOKU=
X-Received: by 2002:adf:f290:0:b0:321:8181:601e with SMTP id
 k16-20020adff290000000b003218181601emr1147738wro.8.1696398636057; Tue, 03 Oct
 2023 22:50:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQJbKf5PgL5fokJAB4y5+5iqKd17W9e0P6q=vJPQM+9NJQ@mail.gmail.com>
 <9dd331b31755632f0528bfb1d0acbf904cedbd98.camel@gmail.com>
 <CAADnVQLNAzjTpyE7UcnD0Q0-p4fvL6u_3_B54o6ttBBvBv7rFw@mail.gmail.com>
 <680e69504eabbae2abd5e9e2b745319c561c86ef.camel@gmail.com>
 <CAADnVQL5ausgq5ERiMKn+Y-Nrp32e2WTq3s5JVJCDojsR0ZF+A@mail.gmail.com>
 <8b75e01d27696cd6661890e49bdc06b1e96092c7.camel@gmail.com>
 <CAADnVQLTe2=K1nTk+Ry8WmBU1C724paoT8p8_7jYL9oymchp_A@mail.gmail.com>
 <5b7f4b6199decf266a9218b674c232662ed13db5.camel@gmail.com>
 <20231003230820.iazvofhysfmurwon@MacBook-Pro-49.local> <3d88ede5cbe38ae96be0c148770454b2344fdcce.camel@gmail.com>
 <20231004025731.ft7xjnr2nxdhxjq5@MacBook-Pro-49.local>
In-Reply-To: <20231004025731.ft7xjnr2nxdhxjq5@MacBook-Pro-49.local>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 3 Oct 2023 22:50:24 -0700
Message-ID: <CAADnVQK9OjhmXOUSUy4=ZvwUiPBmtB=g99=OcOCnT6ZqsPCJGA@mail.gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrew Werner <awerner32@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Andrei Matei <andreimatei1@gmail.com>, 
	Tamir Duberstein <tamird@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, 
	Song Liu <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000199fd90606dd96df"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--000000000000199fd90606dd96df
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 3, 2023 at 7:57=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> ok. discard that idea.

Attached is a 3rd version of the same idea I argued earlier.
Let normal DFS go as normal,
do states_equal() on V which has 1 looping branch remain
and all other explored.
To achieve that when iter_next() is seen do parent->looping_states +=3D 2;

then when processing any children do parent->looping_states++;
in the correct parent.
Since there could be many intermediate states have to walk back
parentage chain to increment correct parent.
When the state reaches bpf_exit or safety, walk back
the parentage chain and do looping_states--.
The state is ok to use in states_equal() if looping_states=3D=3D1.

With this patch all existing iter tests still pass,
and all Ed's special tests pass or fail as needed.
Ex: loop_state_deps1 is rejected with misaligned stack,
loop1 loads with success, num_iter_bug fails with bad pointer.

Please review.
I could be just lucky with the way tests are constructed,
but I feel this is a better path to fix this issue instead
of DFS/BFS combo that I have doubts about.

--000000000000199fd90606dd96df
Content-Type: application/octet-stream; name="0001-iter-hack-3.patch"
Content-Disposition: attachment; filename="0001-iter-hack-3.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lnbbxohb0>
X-Attachment-Id: f_lnbbxohb0

RnJvbSA0ZTAxZmNlMjY2NjE4OGIyZjIwM2M4YjgwNDdhNDBhOTExNjkwMGM2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFzdEBrZXJuZWwub3JnPgpE
YXRlOiBNb24sIDIgT2N0IDIwMjMgMTg6MzA6MjMgLTA3MDAKU3ViamVjdDogW1BBVENIXSBpdGVy
IGhhY2sgMwoKU2lnbmVkLW9mZi1ieTogQWxleGVpIFN0YXJvdm9pdG92IDxhc3RAa2VybmVsLm9y
Zz4KLS0tCiBpbmNsdWRlL2xpbnV4L2JwZl92ZXJpZmllci5oIHwgIDEgKwoga2VybmVsL2JwZi92
ZXJpZmllci5jICAgICAgICB8IDQ4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0t
LQogMiBmaWxlcyBjaGFuZ2VkLCA0NiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvYnBmX3ZlcmlmaWVyLmggYi9pbmNsdWRlL2xpbnV4L2Jw
Zl92ZXJpZmllci5oCmluZGV4IDk0ZWM3NjY0MzJmNS4uMzRmN2RlNTgzYWFlIDEwMDY0NAotLS0g
YS9pbmNsdWRlL2xpbnV4L2JwZl92ZXJpZmllci5oCisrKyBiL2luY2x1ZGUvbGludXgvYnBmX3Zl
cmlmaWVyLmgKQEAgLTM2Nyw2ICszNjcsNyBAQCBzdHJ1Y3QgYnBmX3ZlcmlmaWVyX3N0YXRlIHsK
IAkgKiBJbiBzdWNoIGNhc2VzIEJQRl9DT01QTEVYSVRZX0xJTUlUX0lOU05TIGxpbWl0IGtpY2tz
IGluLgogCSAqLwogCXUzMiBicmFuY2hlczsKKwl1MzIgbG9vcGluZ19zdGF0ZXM7CiAJdTMyIGlu
c25faWR4OwogCXUzMiBjdXJmcmFtZTsKIApkaWZmIC0tZ2l0IGEva2VybmVsL2JwZi92ZXJpZmll
ci5jIGIva2VybmVsL2JwZi92ZXJpZmllci5jCmluZGV4IGVlZDczNTBlMTVmNC4uZmI1MmQ0MWI3
MGYzIDEwMDY0NAotLS0gYS9rZXJuZWwvYnBmL3ZlcmlmaWVyLmMKKysrIGIva2VybmVsL2JwZi92
ZXJpZmllci5jCkBAIC0xNzYyLDYgKzE3NjIsNyBAQCBzdGF0aWMgaW50IGNvcHlfdmVyaWZpZXJf
c3RhdGUoc3RydWN0IGJwZl92ZXJpZmllcl9zdGF0ZSAqZHN0X3N0YXRlLAogCWRzdF9zdGF0ZS0+
YWN0aXZlX2xvY2sucHRyID0gc3JjLT5hY3RpdmVfbG9jay5wdHI7CiAJZHN0X3N0YXRlLT5hY3Rp
dmVfbG9jay5pZCA9IHNyYy0+YWN0aXZlX2xvY2suaWQ7CiAJZHN0X3N0YXRlLT5icmFuY2hlcyA9
IHNyYy0+YnJhbmNoZXM7CisJZHN0X3N0YXRlLT5sb29waW5nX3N0YXRlcyA9IHNyYy0+bG9vcGlu
Z19zdGF0ZXM7CiAJZHN0X3N0YXRlLT5wYXJlbnQgPSBzcmMtPnBhcmVudDsKIAlkc3Rfc3RhdGUt
PmZpcnN0X2luc25faWR4ID0gc3JjLT5maXJzdF9pbnNuX2lkeDsKIAlkc3Rfc3RhdGUtPmxhc3Rf
aW5zbl9pZHggPSBzcmMtPmxhc3RfaW5zbl9pZHg7CkBAIC0xNzgyLDkgKzE3ODMsMjMgQEAgc3Rh
dGljIGludCBjb3B5X3ZlcmlmaWVyX3N0YXRlKHN0cnVjdCBicGZfdmVyaWZpZXJfc3RhdGUgKmRz
dF9zdGF0ZSwKIAogc3RhdGljIHZvaWQgdXBkYXRlX2JyYW5jaF9jb3VudHMoc3RydWN0IGJwZl92
ZXJpZmllcl9lbnYgKmVudiwgc3RydWN0IGJwZl92ZXJpZmllcl9zdGF0ZSAqc3QpCiB7CisJc3Ry
dWN0IGJwZl92ZXJpZmllcl9zdGF0ZSAqc2F2ZSA9IHN0OworCisJd2hpbGUgKHN0KSB7CisJCWlm
IChzdC0+bG9vcGluZ19zdGF0ZXMpIHsKKwkJCXN0LT5sb29waW5nX3N0YXRlcy0tOworCQkJdmVy
Ym9zZShlbnYsICJ1cGRhdGVfYnIxICVseCBicmFuY2hlcz0lZC8lZFxuIiwKKwkJCQkoKGxvbmcp
c3QpID4+IDMgJiAweEZGRkYsIHN0LT5icmFuY2hlcywgc3QtPmxvb3Bpbmdfc3RhdGVzKTsKKwkJ
fQorCQlzdCA9IHN0LT5wYXJlbnQ7CisJfQorCXN0ID0gc2F2ZTsKIAl3aGlsZSAoc3QpIHsKIAkJ
dTMyIGJyID0gLS1zdC0+YnJhbmNoZXM7CiAKKwkJdmVyYm9zZShlbnYsICJ1cGRhdGVfYnIyICVs
eCBicmFuY2hlcz0lZC8lZFxuIiwKKwkJCSgobG9uZylzdCkgPj4gMyAmIDB4RkZGRiwgc3QtPmJy
YW5jaGVzLCBzdC0+bG9vcGluZ19zdGF0ZXMpOworCiAJCS8qIFdBUk5fT04oYnIgPiAxKSB0ZWNo
bmljYWxseSBtYWtlcyBzZW5zZSBoZXJlLAogCQkgKiBidXQgc2VlIGNvbW1lbnQgaW4gcHVzaF9z
dGFjaygpLCBoZW5jZToKIAkJICovCkBAIC0xODExLDYgKzE4MjYsOCBAQCBzdGF0aWMgaW50IHBv
cF9zdGFjayhzdHJ1Y3QgYnBmX3ZlcmlmaWVyX2VudiAqZW52LCBpbnQgKnByZXZfaW5zbl9pZHgs
CiAJCWVyciA9IGNvcHlfdmVyaWZpZXJfc3RhdGUoY3VyLCAmaGVhZC0+c3QpOwogCQlpZiAoZXJy
KQogCQkJcmV0dXJuIGVycjsKKwkJdmVyYm9zZShlbnYsICIlZDogcG9wX3N0YWNrICVseCBicmFu
Y2hlcz0lZC8lZFxuIiwgaGVhZC0+aW5zbl9pZHgsCisJCQkoKGxvbmcpJmhlYWQtPnN0KSA+PiAz
ICYgMHhGRkZGLCBjdXItPmJyYW5jaGVzLCBjdXItPmxvb3Bpbmdfc3RhdGVzKTsKIAl9CiAJaWYg
KHBvcF9sb2cpCiAJCWJwZl92bG9nX3Jlc2V0KCZlbnYtPmxvZywgaGVhZC0+bG9nX3Bvcyk7CkBA
IC0xODI2LDYgKzE4NDMsMTYgQEAgc3RhdGljIGludCBwb3Bfc3RhY2soc3RydWN0IGJwZl92ZXJp
Zmllcl9lbnYgKmVudiwgaW50ICpwcmV2X2luc25faWR4LAogCXJldHVybiAwOwogfQogCitzdGF0
aWMgdm9pZCBpbmNyZWFzZV9sb29waW5nKHN0cnVjdCBicGZfdmVyaWZpZXJfc3RhdGUgKnN0KQor
eworCXdoaWxlIChzdCkgeworCQlpZiAoc3QtPmxvb3Bpbmdfc3RhdGVzKSB7CisJCQlzdC0+bG9v
cGluZ19zdGF0ZXMrKzsKKwkJCWJyZWFrOworCQl9CisJCXN0ID0gc3QtPnBhcmVudDsKKwl9Cit9
CiBzdGF0aWMgc3RydWN0IGJwZl92ZXJpZmllcl9zdGF0ZSAqcHVzaF9zdGFjayhzdHJ1Y3QgYnBm
X3ZlcmlmaWVyX2VudiAqZW52LAogCQkJCQkgICAgIGludCBpbnNuX2lkeCwgaW50IHByZXZfaW5z
bl9pZHgsCiAJCQkJCSAgICAgYm9vbCBzcGVjdWxhdGl2ZSkKQEAgLTE4NDcsNiArMTg3NCw5IEBA
IHN0YXRpYyBzdHJ1Y3QgYnBmX3ZlcmlmaWVyX3N0YXRlICpwdXNoX3N0YWNrKHN0cnVjdCBicGZf
dmVyaWZpZXJfZW52ICplbnYsCiAJZXJyID0gY29weV92ZXJpZmllcl9zdGF0ZSgmZWxlbS0+c3Qs
IGN1cik7CiAJaWYgKGVycikKIAkJZ290byBlcnI7CisJdmVyYm9zZShlbnYsICIlZDogcHVzaF9z
dGFjayAlbHggYnJhbmNoZXM9JWQvJWQgcGFyZW50ICVseFxuIiwgaW5zbl9pZHgsCisJCSgobG9u
ZykmZWxlbS0+c3QpID4+IDMgJiAweEZGRkYsIGN1ci0+YnJhbmNoZXMsIGN1ci0+bG9vcGluZ19z
dGF0ZXMsCisJCSgobG9uZyllbGVtLT5zdC5wYXJlbnQpID4+IDMgJiAweEZGRkYpOwogCWVsZW0t
PnN0LnNwZWN1bGF0aXZlIHw9IHNwZWN1bGF0aXZlOwogCWlmIChlbnYtPnN0YWNrX3NpemUgPiBC
UEZfQ09NUExFWElUWV9MSU1JVF9KTVBfU0VRKSB7CiAJCXZlcmJvc2UoZW52LCAiVGhlIHNlcXVl
bmNlIG9mICVkIGp1bXBzIGlzIHRvbyBjb21wbGV4LlxuIiwKQEAgLTE4NTUsNiArMTg4NSw3IEBA
IHN0YXRpYyBzdHJ1Y3QgYnBmX3ZlcmlmaWVyX3N0YXRlICpwdXNoX3N0YWNrKHN0cnVjdCBicGZf
dmVyaWZpZXJfZW52ICplbnYsCiAJfQogCWlmIChlbGVtLT5zdC5wYXJlbnQpIHsKIAkJKytlbGVt
LT5zdC5wYXJlbnQtPmJyYW5jaGVzOworCQlpbmNyZWFzZV9sb29waW5nKGVsZW0tPnN0LnBhcmVu
dCk7CiAJCS8qIFdBUk5fT04oYnJhbmNoZXMgPiAyKSB0ZWNobmljYWxseSBtYWtlcyBzZW5zZSBo
ZXJlLAogCQkgKiBidXQKIAkJICogMS4gc3BlY3VsYXRpdmUgc3RhdGVzIHdpbGwgYnVtcCAnYnJh
bmNoZXMnIGZvciBub24tYnJhbmNoCkBAIC03NzM0LDYgKzc3NjUsMTEgQEAgc3RhdGljIGludCBw
cm9jZXNzX2l0ZXJfbmV4dF9jYWxsKHN0cnVjdCBicGZfdmVyaWZpZXJfZW52ICplbnYsIGludCBp
bnNuX2lkeCwKIAkJaWYgKCFxdWV1ZWRfc3QpCiAJCQlyZXR1cm4gLUVOT01FTTsKIAorCQlxdWV1
ZWRfc3QtPnBhcmVudC0+bG9vcGluZ19zdGF0ZXMgKz0gMjsKKwkJdmVyYm9zZShlbnYsICJwcm9j
ZXNzX2l0ZXJfbmV4dF9jYWxsICVseCBicmFuY2hlcz0lZC8lZFxuIiwKKwkJCSgobG9uZylxdWV1
ZWRfc3QpID4+IDMgJiAweEZGRkYsIHF1ZXVlZF9zdC0+YnJhbmNoZXMsIHF1ZXVlZF9zdC0+bG9v
cGluZ19zdGF0ZXMpOworCQl2ZXJib3NlKGVudiwgInByb2Nlc3NfaXRlcl9uZXh0X2NhbGwgcGFy
ZW50ICVseCBicmFuY2hlcz0lZC8lZFxuIiwKKwkJCSgobG9uZylxdWV1ZWRfc3QtPnBhcmVudCkg
Pj4gMyAmIDB4RkZGRiwgcXVldWVkX3N0LT5wYXJlbnQtPmJyYW5jaGVzLCBxdWV1ZWRfc3QtPnBh
cmVudC0+bG9vcGluZ19zdGF0ZXMpOwogCQlxdWV1ZWRfaXRlciA9ICZxdWV1ZWRfc3QtPmZyYW1l
W2l0ZXJfZnJhbWVub10tPnN0YWNrW2l0ZXJfc3BpXS5zcGlsbGVkX3B0cjsKIAkJcXVldWVkX2l0
ZXItPml0ZXIuc3RhdGUgPSBCUEZfSVRFUl9TVEFURV9BQ1RJVkU7CiAJCXF1ZXVlZF9pdGVyLT5p
dGVyLmRlcHRoKys7CkBAIC0xNjQ1MSw3ICsxNjQ4NywxMSBAQCBzdGF0aWMgaW50IGlzX3N0YXRl
X3Zpc2l0ZWQoc3RydWN0IGJwZl92ZXJpZmllcl9lbnYgKmVudiwgaW50IGluc25faWR4KQogCQlp
ZiAoc2wtPnN0YXRlLmluc25faWR4ICE9IGluc25faWR4KQogCQkJZ290byBuZXh0OwogCi0JCWlm
IChzbC0+c3RhdGUuYnJhbmNoZXMpIHsKKwkJdmVyYm9zZShlbnYsICJzZWFyY2ggJWx4IGJyYW5j
aGVzPSVkLyVkICIsICgobG9uZykmc2wtPnN0YXRlKSA+PiAzICYgMHhGRkZGLAorCQkJc2wtPnN0
YXRlLmJyYW5jaGVzLCBzbC0+c3RhdGUubG9vcGluZ19zdGF0ZXMpOworCQlpZiAoc2wtPnN0YXRl
LmJyYW5jaGVzICYmCisJCSAgICAhKHNsLT5zdGF0ZS5sb29waW5nX3N0YXRlcyA9PSAxICYmCisJ
CSAgICAgIGlzX2l0ZXJfbmV4dF9pbnNuKGVudiwgaW5zbl9pZHgpKSkgewogCQkJc3RydWN0IGJw
Zl9mdW5jX3N0YXRlICpmcmFtZSA9IHNsLT5zdGF0ZS5mcmFtZVtzbC0+c3RhdGUuY3VyZnJhbWVd
OwogCiAJCQlpZiAoZnJhbWUtPmluX2FzeW5jX2NhbGxiYWNrX2ZuICYmCkBAIC0xNjQ4MSw3ICsx
NjUyMSw3IEBAIHN0YXRpYyBpbnQgaXNfc3RhdGVfdmlzaXRlZChzdHJ1Y3QgYnBmX3ZlcmlmaWVy
X2VudiAqZW52LCBpbnQgaW5zbl9pZHgpCiAJCQkgKiBhY2NvdW50IGl0ZXJfbmV4dCgpIGNvbnRy
YWN0IG9mIGV2ZW50dWFsbHkgcmV0dXJuaW5nCiAJCQkgKiBzdGlja3kgTlVMTCByZXN1bHQuCiAJ
CQkgKi8KLQkJCWlmIChpc19pdGVyX25leHRfaW5zbihlbnYsIGluc25faWR4KSkgeworCQkJaWYg
KDAgJiYgaXNfaXRlcl9uZXh0X2luc24oZW52LCBpbnNuX2lkeCkpIHsKIAkJCQlpZiAoc3RhdGVz
X2VxdWFsKGVudiwgJnNsLT5zdGF0ZSwgY3VyKSkgewogCQkJCQlzdHJ1Y3QgYnBmX2Z1bmNfc3Rh
dGUgKmN1cl9mcmFtZTsKIAkJCQkJc3RydWN0IGJwZl9yZWdfc3RhdGUgKml0ZXJfc3RhdGUsICpp
dGVyX3JlZzsKQEAgLTE2NjM4LDYgKzE2Njc4LDggQEAgc3RhdGljIGludCBpc19zdGF0ZV92aXNp
dGVkKHN0cnVjdCBicGZfdmVyaWZpZXJfZW52ICplbnYsIGludCBpbnNuX2lkeCkKIAkJa2ZyZWUo
bmV3X3NsKTsKIAkJcmV0dXJuIGVycjsKIAl9CisJdmVyYm9zZShlbnYsICIlZDogYWRkX3N0YXRl
ICVseCBicmFuY2hlcz0lZC8lZFxuIiwgaW5zbl9pZHgsICgobG9uZyluZXcpID4+IDMgJiAweEZG
RkYsIG5ldy0+YnJhbmNoZXMsIG5ldy0+bG9vcGluZ19zdGF0ZXMpOworCiAJbmV3LT5pbnNuX2lk
eCA9IGluc25faWR4OwogCVdBUk5fT05DRShuZXctPmJyYW5jaGVzICE9IDEsCiAJCSAgIkJVRyBp
c19zdGF0ZV92aXNpdGVkOmJyYW5jaGVzX3RvX2V4cGxvcmU9JWQgaW5zbiAlZFxuIiwgbmV3LT5i
cmFuY2hlcywgaW5zbl9pZHgpOwpAQCAtMTY3NzksNyArMTY4MjEsNyBAQCBzdGF0aWMgaW50IGRv
X2NoZWNrKHN0cnVjdCBicGZfdmVyaWZpZXJfZW52ICplbnYpCiAJCWluc24gPSAmaW5zbnNbZW52
LT5pbnNuX2lkeF07CiAJCWNsYXNzID0gQlBGX0NMQVNTKGluc24tPmNvZGUpOwogCi0JCWlmICgr
K2Vudi0+aW5zbl9wcm9jZXNzZWQgPiBCUEZfQ09NUExFWElUWV9MSU1JVF9JTlNOUykgeworCQlp
ZiAoKytlbnYtPmluc25fcHJvY2Vzc2VkID4gMTAwMCkgey8vQlBGX0NPTVBMRVhJVFlfTElNSVRf
SU5TTlMpIHsKIAkJCXZlcmJvc2UoZW52LAogCQkJCSJCUEYgcHJvZ3JhbSBpcyB0b28gbGFyZ2Uu
IFByb2Nlc3NlZCAlZCBpbnNuXG4iLAogCQkJCWVudi0+aW5zbl9wcm9jZXNzZWQpOwotLSAKMi4z
NC4xCgo=
--000000000000199fd90606dd96df--

