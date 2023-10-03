Return-Path: <bpf+bounces-11284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA657B6E02
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 18:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E9405281369
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 16:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D45238DC6;
	Tue,  3 Oct 2023 16:07:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56544101C2
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 16:07:42 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4774BB0
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 09:07:40 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-405505b07dfso26643305e9.0
        for <bpf@vger.kernel.org>; Tue, 03 Oct 2023 09:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696349259; x=1696954059; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4N2DA6xjNtZLMFGJ00tbj52FKU1BZ7PGfXeeABZFbts=;
        b=MVnedThZXxGrMyxzSbHklighXLag+0nYEhN5aDYBEYrVaGOWEcL6tcweJrsL7gnFPA
         WY++Qdi5NMNmbRSXYGNdju4TQYZn5XNwUU+I5JgchqmUwu5S/Md4Gjhqz70g8aE3HhuL
         ZuNc69uLtM/L9MBwI0Sw94wp1tcYiEEV5AL9K+kqGYQ57FFbqtQw1Eq3S9WB/3TW50Wx
         vB5ZG2OgJg3Xk9pkI1TOQ1UbAcMjjByLv6QTF5LycUH9uOlSPyvKn+1ev+xxkW7LSlb2
         UGfx2Q7zMlQwYOwmlXg3OUU7pcnVvy3HJIJPPbkqpjvOOGxf0pi8WqSN4+OBWSi5FV04
         k7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696349259; x=1696954059;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4N2DA6xjNtZLMFGJ00tbj52FKU1BZ7PGfXeeABZFbts=;
        b=MYWeqE8qktaCFbKqS1ImFtzAeSMkRrnAFh6wziQo3uq5BqAIYEHhbQJE9sJlp7LK5O
         W5nH0IctkSpNHVx2f+Z2mshrtFPJcEwO58jYkpNWSLffqeNaJUZEgzAI6DYJzOjIt++X
         iX5F2xkqpeZFG3WSJTpHywIGwsqITnw+f032OabT40RuL9I6XhYdYxgGgaCkWBXzgHm3
         d2EmPQJHz0tnG7TggYx09DGgJrfU0rK7qmbHsKLaNKaNvUUqupN90++2NklCjWSdCwOd
         QPsPabM6xaJCuHq4+BbhF4locdJOPV54vrUuilbfCEQBkdbgfwcOEgOrK+HG8+lY/m9I
         jZbg==
X-Gm-Message-State: AOJu0YwNyKN3UWz8Y2G4PQjs+oGE2UI81fbvZD+Oo4aNAFdRrcTybbzN
	heWM0GhcDt4dt2SyvpjAjWD4hCveiWl4hk4dxhVMpinahn4=
X-Google-Smtp-Source: AGHT+IHpobDLBlI6QKVBN+qv/ookn+ceQO4C0FK3BiNuVwfRDOfWtpE7AL2gbLGGVb9WKUjDg1rz2vW3Oot1vGf/DOM=
X-Received: by 2002:adf:f643:0:b0:316:fc03:3c66 with SMTP id
 x3-20020adff643000000b00316fc033c66mr2547035wrp.3.1696349258388; Tue, 03 Oct
 2023 09:07:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+vRuzPChFNXmouzGG+wsy=6eMcfr1mFG0F3g7rbg-sedGKW3w@mail.gmail.com>
 <CAADnVQJpLAzmUfwvWBr8a_PWHYHxHw9vdAXnWB4R4PbVY4S4mw@mail.gmail.com>
 <CAEf4Bzbubu7KjBv=98BZrVnTrcfPQrnsp-g1kOYKM=kUtiqEgw@mail.gmail.com>
 <dff1cfec20d1711cb023be38dfe886bac8aac5f6.camel@gmail.com>
 <CAP01T76duVGmnb+LQjhdKneVYs1q=ehU4yzTLmgZdG0r2ErOYQ@mail.gmail.com>
 <a2995c1d7c01794ca9b652cdea7917cac5d98a16.camel@gmail.com>
 <97a90da09404c65c8e810cf83c94ac703705dc0e.camel@gmail.com>
 <CAEf4BzYg8T_Dek6T9HYjHZCuLTQT8ptAkQRxrsgaXg7-MZmHDA@mail.gmail.com>
 <ee714151d7c840c82d79f9d12a0f51ef13b798e3.camel@gmail.com>
 <CAADnVQJn35f0UvYJ9gyFT4BfViXn8T8rPCXRAC=m_Jx_CFjrtw@mail.gmail.com>
 <5649df64315467c67b969e145afda8bbf7e60445.camel@gmail.com>
 <CAADnVQJO0aVJfV=8RDf5rdtjOCC-=57dmHF20fQYV9EiW2pJ2Q@mail.gmail.com>
 <4b121c3b96dcc0322ea111062ed2260d2d1d0ed7.camel@gmail.com>
 <CAEf4BzbUxHCLhMoPOtCC=6Y-OxkkC9GvjykC8KyKPrFxp6cLvw@mail.gmail.com>
 <52df1240415be1ee8827cb6395fd339a720e229c.camel@gmail.com>
 <ec118c24a33fb740ecaafd9a55416d56fcb77776.camel@gmail.com>
 <CAEf4BzZjut_JGnrqgPE0poJhMjJgtJcafRd6Z_0T0jrW3zARJw@mail.gmail.com>
 <44363f61c49bafa7901ae2aa43897b525805192c.camel@gmail.com>
 <CAEf4BzZ-NGiUVw+yCRCkrPQbJAS4wMBsT3e=eYVMuintqKDKqg@mail.gmail.com>
 <a777445dcb94c0029eb3bd3ddc96ddc493c85ad0.camel@gmail.com>
 <CAEf4BzZU0MxwLfz-dGbmHbEtqVhEMTxwSG+QfwCuCv09CqLcNw@mail.gmail.com>
 <ca9ac095cf1b3fff55eea8a3c87670a349bbfbcf.camel@gmail.com>
 <CAEf4BzZ6V2B5QvjuCEU-MB8V-Fjkgv_yP839r9=NDcuFsgBOLw@mail.gmail.com>
 <d68855da2d8595ed9db812cc12db0dab80c39fc4.camel@gmail.com>
 <CAADnVQJbKf5PgL5fokJAB4y5+5iqKd17W9e0P6q=vJPQM+9NJQ@mail.gmail.com>
 <9dd331b31755632f0528bfb1d0acbf904cedbd98.camel@gmail.com>
 <CAADnVQLNAzjTpyE7UcnD0Q0-p4fvL6u_3_B54o6ttBBvBv7rFw@mail.gmail.com>
 <680e69504eabbae2abd5e9e2b745319c561c86ef.camel@gmail.com>
 <CAADnVQL5ausgq5ERiMKn+Y-Nrp32e2WTq3s5JVJCDojsR0ZF+A@mail.gmail.com> <8b75e01d27696cd6661890e49bdc06b1e96092c7.camel@gmail.com>
In-Reply-To: <8b75e01d27696cd6661890e49bdc06b1e96092c7.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 3 Oct 2023 09:07:26 -0700
Message-ID: <CAADnVQJ0jO01fr5Ux2LEML1b09yqvOCvZOqP9Pj0USiC-tCyZQ@mail.gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrew Werner <awerner32@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Andrei Matei <andreimatei1@gmail.com>, 
	Tamir Duberstein <tamird@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, 
	Song Liu <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000f633330606d2160e"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--000000000000f633330606d2160e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 3, 2023 at 8:33=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
>
> Would lead to an infinite loop when using the patch shared in [1].

yeah. the first hacky patch was too buggy.
Attached is a better version, but the same idea.
It passes all existing tests and accurately detects num_iter_bug,
Then I took 5 from:
https://github.com/kernel-patches/bpf/commit/379c865e6b99302d69392d4f224b5c=
540247bcb2

It does the right thing for all of them
including iter_precision_fixed_point[12]
except loop_state_deps1.

>
> Note, that removal of `elem->st.looping_state =3D false;` from
> push_stack() is not safe either, precision marks and unsafe values
> could be concealed in nested iteration states as shown in example [2],
> so we are risking pruning some states too early.

it's loop_state_deps1, right?
fp-25 is a tricky one.

> SEC("?raw_tp")
> __success
> __naked int loop1(void)
> {
>         asm volatile (
>                 "r1 =3D r10;"
>                 "r1 +=3D -8;"
>                 "r2 =3D 0;"
>                 "r3 =3D 10;"
>                 "call %[bpf_iter_num_new];"
>         "loop_%=3D:"
>                 "r1 =3D r10;"
>                 "r1 +=3D -8;"
>                 "call %[bpf_iter_num_next];"
>                 "if r0 =3D=3D 0 goto loop_end_%=3D;"
>                 "call %[bpf_get_prandom_u32];"
>                 "if r0 !=3D 42 goto loop_%=3D;"
>                 "r0 +=3D 0;"
>                 "goto loop_%=3D;"
>         "loop_end_%=3D:"
>                 "r1 =3D r10;"
>                 "r1 +=3D -8;"
>                 "call %[bpf_iter_num_destroy];"
>                 "r0 =3D 0;"
>                 "exit;"
>                 :
>                 : __imm(bpf_get_prandom_u32),
>                   __imm(bpf_iter_num_new),
>                   __imm(bpf_iter_num_next),
>                   __imm(bpf_iter_num_destroy)
>                 : __clobber_all
>         );
> }

this one loads fine with the attached patch.

I still prefer to avoid two stack hacks if one is enough.

The key idea of the patch is:
@@ -7733,7 +7743,8 @@ static int process_iter_next_call(struct
bpf_verifier_env *env, int insn_idx,
                queued_st =3D push_stack(env, insn_idx + 1, insn_idx, false=
);
                if (!queued_st)
                        return -ENOMEM;
-
+               queued_st->looping_states++;
+               queued_st->branches--;

so deferred looping state from process_iter_next_call() are not
considered branches in _that_ state.
The push_stack still did branches++ in the parent.
So the verifier will process everything after process_iter_next_call()
before reducing its branches to zer0 and making it eligible
for state equality comparison.

--000000000000f633330606d2160e
Content-Type: application/octet-stream; name="0001-iter-hack-2.patch"
Content-Disposition: attachment; filename="0001-iter-hack-2.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lnaiflaf0>
X-Attachment-Id: f_lnaiflaf0

RnJvbSAwZDVmZDY3YWY2N2JjMTU4Mzk0ZmU5Njc0MmFiNGFkOTQwODVlYTA4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFzdEBrZXJuZWwub3JnPgpE
YXRlOiBNb24sIDIgT2N0IDIwMjMgMTg6MzA6MjMgLTA3MDAKU3ViamVjdDogW1BBVENIXSBpdGVy
IGhhY2sgMgoKU2lnbmVkLW9mZi1ieTogQWxleGVpIFN0YXJvdm9pdG92IDxhc3RAa2VybmVsLm9y
Zz4KLS0tCiBpbmNsdWRlL2xpbnV4L2JwZl92ZXJpZmllci5oIHwgIDEgKwoga2VybmVsL2JwZi92
ZXJpZmllci5jICAgICAgICB8IDM0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0K
IDIgZmlsZXMgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L2JwZl92ZXJpZmllci5oIGIvaW5jbHVkZS9saW51eC9icGZf
dmVyaWZpZXIuaAppbmRleCA5NGVjNzY2NDMyZjUuLjM0ZjdkZTU4M2FhZSAxMDA2NDQKLS0tIGEv
aW5jbHVkZS9saW51eC9icGZfdmVyaWZpZXIuaAorKysgYi9pbmNsdWRlL2xpbnV4L2JwZl92ZXJp
Zmllci5oCkBAIC0zNjcsNiArMzY3LDcgQEAgc3RydWN0IGJwZl92ZXJpZmllcl9zdGF0ZSB7CiAJ
ICogSW4gc3VjaCBjYXNlcyBCUEZfQ09NUExFWElUWV9MSU1JVF9JTlNOUyBsaW1pdCBraWNrcyBp
bi4KIAkgKi8KIAl1MzIgYnJhbmNoZXM7CisJdTMyIGxvb3Bpbmdfc3RhdGVzOwogCXUzMiBpbnNu
X2lkeDsKIAl1MzIgY3VyZnJhbWU7CiAKZGlmZiAtLWdpdCBhL2tlcm5lbC9icGYvdmVyaWZpZXIu
YyBiL2tlcm5lbC9icGYvdmVyaWZpZXIuYwppbmRleCBlZWQ3MzUwZTE1ZjQuLmNmMGE1Yjc3OTE0
OSAxMDA2NDQKLS0tIGEva2VybmVsL2JwZi92ZXJpZmllci5jCisrKyBiL2tlcm5lbC9icGYvdmVy
aWZpZXIuYwpAQCAtMTc2Miw2ICsxNzYyLDcgQEAgc3RhdGljIGludCBjb3B5X3ZlcmlmaWVyX3N0
YXRlKHN0cnVjdCBicGZfdmVyaWZpZXJfc3RhdGUgKmRzdF9zdGF0ZSwKIAlkc3Rfc3RhdGUtPmFj
dGl2ZV9sb2NrLnB0ciA9IHNyYy0+YWN0aXZlX2xvY2sucHRyOwogCWRzdF9zdGF0ZS0+YWN0aXZl
X2xvY2suaWQgPSBzcmMtPmFjdGl2ZV9sb2NrLmlkOwogCWRzdF9zdGF0ZS0+YnJhbmNoZXMgPSBz
cmMtPmJyYW5jaGVzOworCWRzdF9zdGF0ZS0+bG9vcGluZ19zdGF0ZXMgPSBzcmMtPmxvb3Bpbmdf
c3RhdGVzOwogCWRzdF9zdGF0ZS0+cGFyZW50ID0gc3JjLT5wYXJlbnQ7CiAJZHN0X3N0YXRlLT5m
aXJzdF9pbnNuX2lkeCA9IHNyYy0+Zmlyc3RfaW5zbl9pZHg7CiAJZHN0X3N0YXRlLT5sYXN0X2lu
c25faWR4ID0gc3JjLT5sYXN0X2luc25faWR4OwpAQCAtMTc4Myw3ICsxNzg0LDEyIEBAIHN0YXRp
YyBpbnQgY29weV92ZXJpZmllcl9zdGF0ZShzdHJ1Y3QgYnBmX3ZlcmlmaWVyX3N0YXRlICpkc3Rf
c3RhdGUsCiBzdGF0aWMgdm9pZCB1cGRhdGVfYnJhbmNoX2NvdW50cyhzdHJ1Y3QgYnBmX3Zlcmlm
aWVyX2VudiAqZW52LCBzdHJ1Y3QgYnBmX3ZlcmlmaWVyX3N0YXRlICpzdCkKIHsKIAl3aGlsZSAo
c3QpIHsKLQkJdTMyIGJyID0gLS1zdC0+YnJhbmNoZXM7CisJCXUzMiBiciA9IDA7CisKKwkJaWYg
KHN0LT5icmFuY2hlcykKKwkJCWJyID0gLS1zdC0+YnJhbmNoZXM7CisJCWVsc2UgaWYgKHN0LT5s
b29waW5nX3N0YXRlcykKKwkJCXN0LT5sb29waW5nX3N0YXRlcy0tOwogCiAJCS8qIFdBUk5fT04o
YnIgPiAxKSB0ZWNobmljYWxseSBtYWtlcyBzZW5zZSBoZXJlLAogCQkgKiBidXQgc2VlIGNvbW1l
bnQgaW4gcHVzaF9zdGFjaygpLCBoZW5jZToKQEAgLTE3OTEsNyArMTc5Nyw3IEBAIHN0YXRpYyB2
b2lkIHVwZGF0ZV9icmFuY2hfY291bnRzKHN0cnVjdCBicGZfdmVyaWZpZXJfZW52ICplbnYsIHN0
cnVjdCBicGZfdmVyaWZpCiAJCVdBUk5fT05DRSgoaW50KWJyIDwgMCwKIAkJCSAgIkJVRyB1cGRh
dGVfYnJhbmNoX2NvdW50czpicmFuY2hlc190b19leHBsb3JlPSVkXG4iLAogCQkJICBicik7Ci0J
CWlmIChicikKKwkJaWYgKGJyIHx8IHN0LT5sb29waW5nX3N0YXRlcykKIAkJCWJyZWFrOwogCQlz
dCA9IHN0LT5wYXJlbnQ7CiAJfQpAQCAtMTg0Nyw2ICsxODUzLDEwIEBAIHN0YXRpYyBzdHJ1Y3Qg
YnBmX3ZlcmlmaWVyX3N0YXRlICpwdXNoX3N0YWNrKHN0cnVjdCBicGZfdmVyaWZpZXJfZW52ICpl
bnYsCiAJZXJyID0gY29weV92ZXJpZmllcl9zdGF0ZSgmZWxlbS0+c3QsIGN1cik7CiAJaWYgKGVy
cikKIAkJZ290byBlcnI7CisJaWYgKGVsZW0tPnN0Lmxvb3Bpbmdfc3RhdGVzKSB7CisJCWVsZW0t
PnN0Lmxvb3Bpbmdfc3RhdGVzLS07CisJCWVsZW0tPnN0LmJyYW5jaGVzKys7CisJfQogCWVsZW0t
PnN0LnNwZWN1bGF0aXZlIHw9IHNwZWN1bGF0aXZlOwogCWlmIChlbnYtPnN0YWNrX3NpemUgPiBC
UEZfQ09NUExFWElUWV9MSU1JVF9KTVBfU0VRKSB7CiAJCXZlcmJvc2UoZW52LCAiVGhlIHNlcXVl
bmNlIG9mICVkIGp1bXBzIGlzIHRvbyBjb21wbGV4LlxuIiwKQEAgLTc3MzMsNyArNzc0Myw4IEBA
IHN0YXRpYyBpbnQgcHJvY2Vzc19pdGVyX25leHRfY2FsbChzdHJ1Y3QgYnBmX3ZlcmlmaWVyX2Vu
diAqZW52LCBpbnQgaW5zbl9pZHgsCiAJCXF1ZXVlZF9zdCA9IHB1c2hfc3RhY2soZW52LCBpbnNu
X2lkeCArIDEsIGluc25faWR4LCBmYWxzZSk7CiAJCWlmICghcXVldWVkX3N0KQogCQkJcmV0dXJu
IC1FTk9NRU07Ci0KKwkJcXVldWVkX3N0LT5sb29waW5nX3N0YXRlcysrOworCQlxdWV1ZWRfc3Qt
PmJyYW5jaGVzLS07CiAJCXF1ZXVlZF9pdGVyID0gJnF1ZXVlZF9zdC0+ZnJhbWVbaXRlcl9mcmFt
ZW5vXS0+c3RhY2tbaXRlcl9zcGldLnNwaWxsZWRfcHRyOwogCQlxdWV1ZWRfaXRlci0+aXRlci5z
dGF0ZSA9IEJQRl9JVEVSX1NUQVRFX0FDVElWRTsKIAkJcXVldWVkX2l0ZXItPml0ZXIuZGVwdGgr
KzsKQEAgLTE1ODI0LDcgKzE1ODM1LDcgQEAgc3RhdGljIHZvaWQgY2xlYW5fbGl2ZV9zdGF0ZXMo
c3RydWN0IGJwZl92ZXJpZmllcl9lbnYgKmVudiwgaW50IGluc24sCiAKIAlzbCA9ICpleHBsb3Jl
ZF9zdGF0ZShlbnYsIGluc24pOwogCXdoaWxlIChzbCkgewotCQlpZiAoc2wtPnN0YXRlLmJyYW5j
aGVzKQorCQlpZiAoc2wtPnN0YXRlLmJyYW5jaGVzIHx8IHNsLT5zdGF0ZS5sb29waW5nX3N0YXRl
cykKIAkJCWdvdG8gbmV4dDsKIAkJaWYgKHNsLT5zdGF0ZS5pbnNuX2lkeCAhPSBpbnNuIHx8CiAJ
CSAgICBzbC0+c3RhdGUuY3VyZnJhbWUgIT0gY3VyLT5jdXJmcmFtZSkKQEAgLTE2NDUxLDYgKzE2
NDYyLDcgQEAgc3RhdGljIGludCBpc19zdGF0ZV92aXNpdGVkKHN0cnVjdCBicGZfdmVyaWZpZXJf
ZW52ICplbnYsIGludCBpbnNuX2lkeCkKIAkJaWYgKHNsLT5zdGF0ZS5pbnNuX2lkeCAhPSBpbnNu
X2lkeCkKIAkJCWdvdG8gbmV4dDsKIAorCQl2ZXJib3NlKGVudiwgImJyYW5jaGVzPSVkLyVkICIs
IHNsLT5zdGF0ZS5icmFuY2hlcywgc2wtPnN0YXRlLmxvb3Bpbmdfc3RhdGVzKTsKIAkJaWYgKHNs
LT5zdGF0ZS5icmFuY2hlcykgewogCQkJc3RydWN0IGJwZl9mdW5jX3N0YXRlICpmcmFtZSA9IHNs
LT5zdGF0ZS5mcmFtZVtzbC0+c3RhdGUuY3VyZnJhbWVdOwogCkBAIC0xNjQ4MSw3ICsxNjQ5Myw3
IEBAIHN0YXRpYyBpbnQgaXNfc3RhdGVfdmlzaXRlZChzdHJ1Y3QgYnBmX3ZlcmlmaWVyX2VudiAq
ZW52LCBpbnQgaW5zbl9pZHgpCiAJCQkgKiBhY2NvdW50IGl0ZXJfbmV4dCgpIGNvbnRyYWN0IG9m
IGV2ZW50dWFsbHkgcmV0dXJuaW5nCiAJCQkgKiBzdGlja3kgTlVMTCByZXN1bHQuCiAJCQkgKi8K
LQkJCWlmIChpc19pdGVyX25leHRfaW5zbihlbnYsIGluc25faWR4KSkgeworCQkJaWYgKDAgJiYg
aXNfaXRlcl9uZXh0X2luc24oZW52LCBpbnNuX2lkeCkpIHsKIAkJCQlpZiAoc3RhdGVzX2VxdWFs
KGVudiwgJnNsLT5zdGF0ZSwgY3VyKSkgewogCQkJCQlzdHJ1Y3QgYnBmX2Z1bmNfc3RhdGUgKmN1
cl9mcmFtZTsKIAkJCQkJc3RydWN0IGJwZl9yZWdfc3RhdGUgKml0ZXJfc3RhdGUsICppdGVyX3Jl
ZzsKQEAgLTE2NjM4LDggKzE2NjUwLDE2IEBAIHN0YXRpYyBpbnQgaXNfc3RhdGVfdmlzaXRlZChz
dHJ1Y3QgYnBmX3ZlcmlmaWVyX2VudiAqZW52LCBpbnQgaW5zbl9pZHgpCiAJCWtmcmVlKG5ld19z
bCk7CiAJCXJldHVybiBlcnI7CiAJfQorCWlmIChuZXctPmxvb3Bpbmdfc3RhdGVzICYmIDApIHsK
KwkJbmV3LT5sb29waW5nX3N0YXRlcy0tOworCQluZXctPmJyYW5jaGVzKys7CisJfQorCWlmIChj
dXItPmxvb3Bpbmdfc3RhdGVzICYmIDApIHsKKwkJY3VyLT5sb29waW5nX3N0YXRlcy0tOworCQlj
dXItPmJyYW5jaGVzKys7CisJfQogCW5ldy0+aW5zbl9pZHggPSBpbnNuX2lkeDsKLQlXQVJOX09O
Q0UobmV3LT5icmFuY2hlcyAhPSAxLAorCVdBUk5fT05DRShuZXctPmJyYW5jaGVzICsgbmV3LT5s
b29waW5nX3N0YXRlcyAhPSAxLAogCQkgICJCVUcgaXNfc3RhdGVfdmlzaXRlZDpicmFuY2hlc190
b19leHBsb3JlPSVkIGluc24gJWRcbiIsIG5ldy0+YnJhbmNoZXMsIGluc25faWR4KTsKIAogCWN1
ci0+cGFyZW50ID0gbmV3OwpAQCAtMTY3NzksNyArMTY3OTksNyBAQCBzdGF0aWMgaW50IGRvX2No
ZWNrKHN0cnVjdCBicGZfdmVyaWZpZXJfZW52ICplbnYpCiAJCWluc24gPSAmaW5zbnNbZW52LT5p
bnNuX2lkeF07CiAJCWNsYXNzID0gQlBGX0NMQVNTKGluc24tPmNvZGUpOwogCi0JCWlmICgrK2Vu
di0+aW5zbl9wcm9jZXNzZWQgPiBCUEZfQ09NUExFWElUWV9MSU1JVF9JTlNOUykgeworCQlpZiAo
KytlbnYtPmluc25fcHJvY2Vzc2VkID4gMTAwMCkgey8vQlBGX0NPTVBMRVhJVFlfTElNSVRfSU5T
TlMpIHsKIAkJCXZlcmJvc2UoZW52LAogCQkJCSJCUEYgcHJvZ3JhbSBpcyB0b28gbGFyZ2UuIFBy
b2Nlc3NlZCAlZCBpbnNuXG4iLAogCQkJCWVudi0+aW5zbl9wcm9jZXNzZWQpOwotLSAKMi4zNC4x
Cgo=
--000000000000f633330606d2160e--

