Return-Path: <bpf+bounces-10210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B33697A3243
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 21:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B63041C20B4C
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 19:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9191BDFC;
	Sat, 16 Sep 2023 19:35:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACDB7E
	for <bpf@vger.kernel.org>; Sat, 16 Sep 2023 19:35:21 +0000 (UTC)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB57199
	for <bpf@vger.kernel.org>; Sat, 16 Sep 2023 12:35:19 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a640c23a62f3a-9a64619d8fbso420299566b.0
        for <bpf@vger.kernel.org>; Sat, 16 Sep 2023 12:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694892918; x=1695497718; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nFBRpjyc+ULsH4S4FfYVIIcMtkCKRohajB/mPUZt+oA=;
        b=bJHJGwWT1pGmsfQp4FDP31dOwj+VsPkVUIg0nQ8K75XN4H9UQP7017XPnIbSkcw5jO
         UaWyd6GLR8tL2gqQRMHAyXhWREJctL4Y3B+6E8sWNHP7yg0OdZ3rvTkEFTbOM6VRmJdP
         WI/gD08KDpRCpjm47HTLZa9Wx0ZbYPJ0D1FlE93JI+XKneBmluMXHyAZduh1gAiMFuSl
         Y0cjydfD4xYLR+0RtuBD3NZhIZVAaKJmKWtVN8BgLLlrjQuQCKYmPKkCbAv2jeWkAHDU
         o4KaMEvwZnrUYPf3qpK6lrPYDR8KdvYEg/H4nRgTob09cZ3qP/qg+QY6X1CZ+i9IEQpZ
         xm7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694892918; x=1695497718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nFBRpjyc+ULsH4S4FfYVIIcMtkCKRohajB/mPUZt+oA=;
        b=HcOBjba1D5x5A/n+Uv3hDbvv9uPtrIyjs5adLu1PY7iNTvD7ohb4mR4mkWaz7MbwbA
         lRci6Oo8hEkImeEwQTADDVi/oHeQ9R7xkGsYcQe4XlMPJvHTOlxJhXUOEdXjSQo/00MU
         rHg9hIU+mApLfdYLGYROfF7u722AJ8C9lpMTUXWq4DbGUT4pA1u8F1zK5Fxn68mdkd2U
         y7T7stu3jyAs6DkOzjFRkbrIykpziNF69ln23TTl5b1a6/6KUrSFdvr/gwH6rMsa37Sp
         Iecut4T4pogDTttWv7BvjIORtWuDTshZ3j2mTIpDjTX15uQenFHWWJU7wRyoyxry1CTn
         Ylrw==
X-Gm-Message-State: AOJu0YxYKfhDKaQo9Q0jfnn0xvQDp87tfp8JAvu1W0oHp9II+E8gMtbe
	WQ7hvM1yYsVsnWlSTuEzuXgXiGaX388GVmqkOgo=
X-Google-Smtp-Source: AGHT+IEmOZvm0ySoE6bU0X1NlCsF5nmCM8671cAKAfXcjhIWJI5x2ZMDIt4cwmrQCJdIE0SKcr3hCG0kDMepAIQaLZ4=
X-Received: by 2002:a17:907:7750:b0:9ad:c132:b93e with SMTP id
 kx16-20020a170907775000b009adc132b93emr4633718ejc.28.1694892918005; Sat, 16
 Sep 2023 12:35:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912233214.1518551-1-memxor@gmail.com> <20230912233214.1518551-13-memxor@gmail.com>
 <mb61pmsxq14h4.fsf@amazon.com> <CAP01T7691P9m4ZrDQk63waC9wGu3ToK-cznsHha-r6Lteh0fWw@mail.gmail.com>
 <CAADnVQK-DoX19C-rManYh2p99ixO7QKkd6NrvpaYuoRbco_ubA@mail.gmail.com> <CAP01T74ZG7q_=1=bbfk-5Q978dR7UN_zwch0KWYkZPObLNSy2Q@mail.gmail.com>
In-Reply-To: <CAP01T74ZG7q_=1=bbfk-5Q978dR7UN_zwch0KWYkZPObLNSy2Q@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 16 Sep 2023 21:34:41 +0200
Message-ID: <CAP01T746mMPhFp5=rJBLykAPOUrE96E=P7qFE6afHDTLJRQDog@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 12/17] bpf: Disallow fentry/fexit/freplace for
 exception callbacks
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Puranjay Mohan <puranjay12@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, David Vernet <void@manifault.com>
Content-Type: multipart/mixed; boundary="0000000000004f8d7506057f0222"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--0000000000004f8d7506057f0222
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 16 Sept 2023 at 19:30, Kumar Kartikeya Dwivedi <memxor@gmail.com> w=
rote:
>
> On Sat, 16 Sept 2023 at 18:44, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Sep 14, 2023 at 5:13=E2=80=AFAM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > > > >                       }
> > > > > +                     if (aux->func && aux->func[subprog]->aux->e=
xception_cb) {
> > > > > +                             bpf_log(log,
> > > > > +                                     "Extension programs cannot =
replace exception callback\n");
> > > > > +                             return -EINVAL;
> > > > > +                     }
> > > >
> > > > This check is redundant because you already did this check above if=
 (prog_extension branch)
> > > > Remove this as it will never be reached.
> > > >
> > >
> > > Good catch, will fix it in v4.
> >
> > No worries. I fixed this duplicate check while applying.
> > Everything else can be addressed in the follow ups.
> >
> > This spam is a bit annoying:
> > $ ./test_progs -t exceptions
> > func#0 @0
> > FENTRY/FEXIT programs cannot attach to exception callback
> > processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0
> > peak_states 0 mark_read 0
> >
> > func#0 @0
> > FENTRY/FEXIT programs cannot attach to exception callback
> > processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0
> > peak_states 0 mark_read 0
>
> Thanks for fixing it while applying. I will send a follow up to
> silence these logs today.

For some reason, I don't seem to see these when just running
./test_progs -t exceptions.
I am not sure what I'm doing differently when running the selftests.
A bit weird, but anyway, just guessing the cause, do you see them when
you apply this?

--0000000000004f8d7506057f0222
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-selftests-bpf-Printing-log-buffer-for-exceptions-tes.patch"
Content-Disposition: attachment; 
	filename="0001-selftests-bpf-Printing-log-buffer-for-exceptions-tes.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lmmfgbhy0>
X-Attachment-Id: f_lmmfgbhy0

RnJvbSAxNmM3NTczN2M0NGI1NzE5ZjVhY2MxODE5NDk1ZDA4MTY5ZmQ3ZTc2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLdW1hciBLYXJ0aWtleWEgRHdpdmVkaSA8bWVteG9yQGdtYWls
LmNvbT4KRGF0ZTogU2F0LCAxNiBTZXAgMjAyMyAyMTozMDoxMiArMDIwMApTdWJqZWN0OiBbUEFU
Q0ggYnBmLW5leHRdIHNlbGZ0ZXN0cy9icGY6IFByaW50aW5nIGxvZyBidWZmZXIgZm9yIGV4Y2Vw
dGlvbnMgdGVzdCBvbmx5CiBvbiBmYWlsdXJlCgpBbGV4ZWkgcmVwb3J0ZWQgc2VlaW5nIGxvZyBt
ZXNzYWdlcyBmb3Igc29tZSB0ZXN0IGNhc2VzIGV2ZW4gdGhvdWdoIHdlCmp1c3Qgd2FudGVkIHRv
IG1hdGNoIHRoZSBlcnJvciBzdHJpbmcgZnJvbSB0aGUgdmVyaWZpZXIuIE1vdmUgdGhlCnByaW50
aW5nIG9mIHRoZSBsb2cgYnVmZmVyIHRvIGEgZ3VhcmRlZCBjb25kaXRpb24gc28gdGhhdCB3ZSBv
bmx5IHByaW50Cml0IHdoZW4gd2UgZmFpbCB0byBtYXRjaCBvbiB0aGUgZXhwZWN0ZWQgc3RyaW5n
IGluIHRoZSBsb2cgYnVmZmVyLApwcmV2ZW50aW5nIHVubmVlZGVkIG91dHB1dCB3aGVuIHJ1bm5p
bmcgdGhlIHRlc3QuCgpSZXBvcnRlZC1ieTogQWxleGVpIFN0YXJvdm9pdG92IDxhc3RAa2VybmVs
Lm9yZz4KRml4ZXM6IGQyYTkzNzE1YmZiMCAoInNlbGZ0ZXN0cy9icGY6IEFkZCB0ZXN0cyBmb3Ig
QlBGIGV4Y2VwdGlvbnMiKQpTaWduZWQtb2ZmLWJ5OiBLdW1hciBLYXJ0aWtleWEgRHdpdmVkaSA8
bWVteG9yQGdtYWlsLmNvbT4KLS0tCiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ190
ZXN0cy9leGNlcHRpb25zLmMgfCA1ICsrKy0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2JwZi9wcm9nX3Rlc3RzL2V4Y2VwdGlvbnMuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Jw
Zi9wcm9nX3Rlc3RzL2V4Y2VwdGlvbnMuYwppbmRleCA1NjYzZTQyN2RjMDAuLjUxNmY0YTEzMDEz
YyAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvZXhj
ZXB0aW9ucy5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL2V4
Y2VwdGlvbnMuYwpAQCAtMTAzLDkgKzEwMywxMCBAQCBzdGF0aWMgdm9pZCB0ZXN0X2V4Y2VwdGlv
bnNfc3VjY2Vzcyh2b2lkKQogCQkJZ290byBkb25lOwkJCQkJCSAgXAogCQl9CQkJCQkJCQkgIFwK
IAkJaWYgKGxvYWRfcmV0ICE9IDApIHsJCQkJCQkgIFwKLQkJCXByaW50ZigiJXNcbiIsIGxvZ19i
dWYpOwkJCQkgIFwKLQkJCWlmICghQVNTRVJUX09LX1BUUihzdHJzdHIobG9nX2J1ZiwgbXNnKSwg
InN0cnN0ciIpKQkgIFwKKwkJCWlmICghQVNTRVJUX09LX1BUUihzdHJzdHIobG9nX2J1ZiwgbXNn
KSwgInN0cnN0ciIpKSB7CSAgXAorCQkJCXByaW50ZigiJXNcbiIsIGxvZ19idWYpOwkJCSAgXAog
CQkJCWdvdG8gZG9uZTsJCQkJCSAgXAorCQkJfQkJCQkJCQkgIFwKIAkJfQkJCQkJCQkJICBcCiAJ
CWlmICghbG9hZF9yZXQgJiYgYXR0YWNoX2VycikgewkJCQkJICBcCiAJCQlpZiAoIUFTU0VSVF9F
UlJfUFRSKGxpbmsgPSBicGZfcHJvZ3JhbV9fYXR0YWNoKHByb2cpLCAiYXR0YWNoIGVyciIpKSBc
Ci0tCjIuNDEuMAoK
--0000000000004f8d7506057f0222--

