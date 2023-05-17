Return-Path: <bpf+bounces-822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEFD707253
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 21:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1026E1C20F7D
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 19:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB65B34CF6;
	Wed, 17 May 2023 19:38:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915AC111AD
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 19:38:00 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E36EE67
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 12:37:33 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-510d9218506so760579a12.1
        for <bpf@vger.kernel.org>; Wed, 17 May 2023 12:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684352250; x=1686944250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EGKI6H/r7fSXnuBx9f0+4FVv9qKurvHdpDRXkzgKVVE=;
        b=dST0i2fL5crJmyksJX0862DQUmET9sHJlkPm04jxbIwsJnbNUW7+0b9DaPO9SxViNp
         8CzG00bl4e2iNhYUUIqZpckBCyAUm20fVCmG2RA76lWUFaM4nC8fP1fK2o1BbU/ipu7m
         Bu3FNI0mAQY4PxO8q5NtnD+m9tmxVXzdQOtzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684352250; x=1686944250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EGKI6H/r7fSXnuBx9f0+4FVv9qKurvHdpDRXkzgKVVE=;
        b=LjC4shQ5tTybdNTeebqT8zI4flbZZ6URYgW8bIFxlkkGDQ9faTJKkcmRExw9ltD7Zq
         xQU6zS3rDmzdNYUNFTOJcpJd8sqPsJosmEbqj7AvaBoU2pctAOLvtuZYfmRKDh4dV4AE
         8tZQIeJnMWKBdM6gCPr/psm+S6N3KaypARW3YyKDhI6Zq9+cg+VUcqM8tjYhPTP2NLmh
         /wRD+YJtnu8wTdti194snQlQWEAV2A03KbOoT0hFlD1SoapekqYiTKxTdmb9Exlfr9+1
         sbh8aFTD+2TmtPZOfaizrLuqsuwQ05kYfNsp6KurcDIdV3JqLw8wA66cnIfZBY30h6dW
         +s2Q==
X-Gm-Message-State: AC+VfDypZQBAv5J1QERM+AaB/i2J871b8sUNmciwPb9lTG4N/BgdPUO4
	Cz3evS09Iij5MJ1sBg4RRAJ6DR+HepGFZB3asMteW3Xm
X-Google-Smtp-Source: ACHHUZ7zbE/s16RtftFbff1RFLUqp2/PsnPtec1Z3qsdv7peAlBeu22nrwCp6PDR1yfXj3l+rPvMDw==
X-Received: by 2002:aa7:ca59:0:b0:50c:804:20bb with SMTP id j25-20020aa7ca59000000b0050c080420bbmr3459741edt.16.1684352249794;
        Wed, 17 May 2023 12:37:29 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id l9-20020a056402124900b005067d6b06efsm9666019edw.17.2023.05.17.12.37.28
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 12:37:29 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-95fde138693so80366566b.0
        for <bpf@vger.kernel.org>; Wed, 17 May 2023 12:37:28 -0700 (PDT)
X-Received: by 2002:a17:907:3f9e:b0:96a:2b4:eb69 with SMTP id
 hr30-20020a1709073f9e00b0096a02b4eb69mr3422885ejc.31.1684352248662; Wed, 17
 May 2023 12:37:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230509163050.127d5123@rorschach.local.home> <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local>
 <20230515192407.GA85@W11-BEAU-MD.localdomain> <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local>
 <CAHk-=whBKoovtifU2eCeyuBBee-QMcbxdXDLv0mu0k2DgxiaOw@mail.gmail.com>
 <CAHk-=wj1hh=ZUriY9pVFvD1MjqbRuzHc4yz=S2PCW7u3W0-_BQ@mail.gmail.com>
 <20230516222919.79bba667@rorschach.local.home> <CAHk-=wh_GEr4ehJKwMM3UA0-7CfNpVH7v_T-=1u+gq9VZD70mw@mail.gmail.com>
 <20230517172243.GA152@W11-BEAU-MD.localdomain> <CAHk-=whzzuNEW8UcV2_8OyuKcXPrk7-j_8GzOoroxz9JiZiD3w@mail.gmail.com>
 <20230517190750.GA366@W11-BEAU-MD.localdomain> <CAHk-=whTBvXJuoi_kACo3qi5WZUmRrhyA-_=rRFsycTytmB6qw@mail.gmail.com>
 <CAHk-=wi4w9bPKFFGwLULjJf9hnkL941+c4HbeEVKNzqH04wqDA@mail.gmail.com>
In-Reply-To: <CAHk-=wi4w9bPKFFGwLULjJf9hnkL941+c4HbeEVKNzqH04wqDA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 May 2023 12:37:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiiBfT4zNS29jA0XEsy8EmbqTH1hAPdRJCDAJMD8Gxt5A@mail.gmail.com>
Message-ID: <CAHk-=wiiBfT4zNS29jA0XEsy8EmbqTH1hAPdRJCDAJMD8Gxt5A@mail.gmail.com>
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	David Vernet <void@manifault.com>, dthaler@microsoft.com, brauner@kernel.org, 
	hch@infradead.org
Content-Type: multipart/mixed; boundary="000000000000759fcb05fbe8d165"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--000000000000759fcb05fbe8d165
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2023 at 12:36=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> .. this is the patch that I think should go on top of it to fix the
> misleading "safe" and the incorrect RCU walk.

Let's actually attach the patch too. Duh.

               Linus

--000000000000759fcb05fbe8d165
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lhs3trhk0>
X-Attachment-Id: f_lhs3trhk0

IGtlcm5lbC90cmFjZS90cmFjZV9ldmVudHNfdXNlci5jIHwgOCArKysrLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9rZXJu
ZWwvdHJhY2UvdHJhY2VfZXZlbnRzX3VzZXIuYyBiL2tlcm5lbC90cmFjZS90cmFjZV9ldmVudHNf
dXNlci5jCmluZGV4IGIyYWVjYmZiYmQyNC4uMDU0ZTI4Y2M1YWQ0IDEwMDY0NAotLS0gYS9rZXJu
ZWwvdHJhY2UvdHJhY2VfZXZlbnRzX3VzZXIuYworKysgYi9rZXJuZWwvdHJhY2UvdHJhY2VfZXZl
bnRzX3VzZXIuYwpAQCAtNDM5LDcgKzQzOSw3IEBAIHN0YXRpYyBib29sIHVzZXJfZXZlbnRfZW5h
Ymxlcl9leGlzdHMoc3RydWN0IHVzZXJfZXZlbnRfbW0gKm1tLAogCXN0cnVjdCB1c2VyX2V2ZW50
X2VuYWJsZXIgKmVuYWJsZXI7CiAJc3RydWN0IHVzZXJfZXZlbnRfZW5hYmxlciAqbmV4dDsKIAot
CWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShlbmFibGVyLCBuZXh0LCAmbW0tPmVuYWJsZXJzLCBs
aW5rKSB7CisJbGlzdF9mb3JfZWFjaF9lbnRyeShlbmFibGVyLCBuZXh0LCAmbW0tPmVuYWJsZXJz
LCBsaW5rKSB7CiAJCWlmIChlbmFibGVyLT5hZGRyID09IHVhZGRyICYmCiAJCSAgICAoZW5hYmxl
ci0+dmFsdWVzICYgRU5BQkxFX1ZBTF9CSVRfTUFTSykgPT0gYml0KQogCQkJcmV0dXJuIHRydWU7
CkBAIC00NTUsMTkgKzQ1NSwxOSBAQCBzdGF0aWMgdm9pZCB1c2VyX2V2ZW50X2VuYWJsZXJfdXBk
YXRlKHN0cnVjdCB1c2VyX2V2ZW50ICp1c2VyKQogCXN0cnVjdCB1c2VyX2V2ZW50X21tICpuZXh0
OwogCWludCBhdHRlbXB0OwogCisJbG9ja2RlcF9hc3NlcnRfaGVsZCgmZXZlbnRfbXV0ZXgpOwor
CiAJd2hpbGUgKG1tKSB7CiAJCW5leHQgPSBtbS0+bmV4dDsKIAkJbW1hcF9yZWFkX2xvY2sobW0t
Pm1tKTsKLQkJcmN1X3JlYWRfbG9jaygpOwogCi0JCWxpc3RfZm9yX2VhY2hfZW50cnlfcmN1KGVu
YWJsZXIsICZtbS0+ZW5hYmxlcnMsIGxpbmspIHsKKwkJbGlzdF9mb3JfZWFjaF9lbnRyeShlbmFi
bGVyLCAmbW0tPmVuYWJsZXJzLCBsaW5rKSB7CiAJCQlpZiAoZW5hYmxlci0+ZXZlbnQgPT0gdXNl
cikgewogCQkJCWF0dGVtcHQgPSAwOwogCQkJCXVzZXJfZXZlbnRfZW5hYmxlcl93cml0ZShtbSwg
ZW5hYmxlciwgdHJ1ZSwgJmF0dGVtcHQpOwogCQkJfQogCQl9CiAKLQkJcmN1X3JlYWRfdW5sb2Nr
KCk7CiAJCW1tYXBfcmVhZF91bmxvY2sobW0tPm1tKTsKIAkJdXNlcl9ldmVudF9tbV9wdXQobW0p
OwogCQltbSA9IG5leHQ7Cg==
--000000000000759fcb05fbe8d165--

