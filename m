Return-Path: <bpf+bounces-8299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFA6784B95
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 22:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B45D01C20B39
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 20:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500291E500;
	Tue, 22 Aug 2023 20:44:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124672018C
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 20:44:31 +0000 (UTC)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C2210D
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 13:44:30 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40a9918ec08so31033731cf.0
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 13:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692737070; x=1693341870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIY4BW1aShtZa8JhSL2vZaOBbImwOM8Yqv8lPXle2d4=;
        b=RcPLdSE9Ac5lJwP/U4M8b9GIeQR6l6KExTMV2aSQQE77I77CnilBs59Wkshg1gVvA3
         JABSuD0Lg7N6cjRi40QQsmrh25uU+nVjapA4oAfyHkGQlIUZZIhTkOUExuCxEWSYzYpY
         Xvk819cryQL2TlWiG2i59IVhQrhtMuaYxtaEY4EdELY3NUAXWIKpgR3gvNALmqILReMF
         qIrn9K5gEMmiBN1DjtuIszZoRtEPHo96H/+E0cUg/J2nKaW4XYfXwDiIuMe2hv60UANq
         0Qvr3ZG/IdnO0/flDup/x+Tlur1UAXnClfrFi+f5JgiinlK6+oFkKOp44oOSxx3UZ1Bw
         BJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692737070; x=1693341870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SIY4BW1aShtZa8JhSL2vZaOBbImwOM8Yqv8lPXle2d4=;
        b=T5qjVablTXq88Ei5f+Wgt32zrFcZ+E8hwdKzZsgqJJhahp2yJ9CH5PcXFDeqAOlVng
         OEVH1EoUV5su02qdSjrMBBqutH15F9zBQV886uRL5v/bjq/UTDHXLvt3YXT4xjYFjt8c
         8tixkqASE3Lsq+taHdyC2va1y+O5e4zuF5xriVAFfipSz1514FLuYDvdfORqWQ4ssgTu
         vBkaWMtzYVXebW2BS1IYjUICTEhonryew4yW0Qz6F+Yiko/qsNpqss7RCt7xDvlEUCFW
         s17If9sIjIb+DvwFYktDXlMzHV3HQ5HLrUtHFmQ+Ot+Yg54iV6NEvhgIzGCRn/fHGMC0
         d4yQ==
X-Gm-Message-State: AOJu0YwgfCLfI22ilEGQuEf9KWviQiNH1LOzKf5flHjc4HagWIkAgBOx
	IgXAXQ2M1gQxFsXMjkGnWY8qLIsvQLytbN4x0decgw==
X-Google-Smtp-Source: AGHT+IEItiIS99pEWxLjSoVieTI8R1IXYPDlmg+/E07xYdBbSqpqBuMdrVaREPubfqFIjetTFi9B9cliBbZ4ltM2+GM=
X-Received: by 2002:ad4:4bb2:0:b0:647:2a0e:573f with SMTP id
 i18-20020ad44bb2000000b006472a0e573fmr11695239qvw.8.1692737069673; Tue, 22
 Aug 2023 13:44:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFhGd8ryUcu2yPC+dFyDKNuVFHxT-=iayG+n2iErotBxgd0FVw@mail.gmail.com>
In-Reply-To: <CAFhGd8ryUcu2yPC+dFyDKNuVFHxT-=iayG+n2iErotBxgd0FVw@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 22 Aug 2023 13:44:16 -0700
Message-ID: <CAKwvOd=p_7gWwBnR_RHUPukkG1A25GQy6iOnX_eih7u65u=oxw@mail.gmail.com>
Subject: Re: selftests: hid: trouble building with clang due to missing header
To: Justin Stitt <justinstitt@google.com>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
	linux-input@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Kees Cook <keescook@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

+ Ben, author of commit dbb60c8a26da ("selftests: add tests for the
HID-bpf initial implementation")

On Tue, Aug 22, 2023 at 1:34=E2=80=AFPM Justin Stitt <justinstitt@google.co=
m> wrote:
>
> Hi, I'd like to get some help with building the kselftest target.
>
> I am running into some warnings within the hid tree:
> | progs/hid_bpf_helpers.h:9:38: error: declaration of 'struct
> hid_bpf_ctx' will \
> |       not be visible outside of this function [-Werror,-Wvisibility]
> |     9 | extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
> |       |                                      ^
> | progs/hid.c:23:35: error: incompatible pointer types passing 'struct
> hid_bpf_ctx *' \
> |       to parameter of type 'struct hid_bpf_ctx *'
> [-Werror,-Wincompatible-pointer-types]
> |    23 |         __u8 *rw_data =3D hid_bpf_get_data(hid_ctx, 0 /*
> offset */, 3 /* size */);
>
> This warning, amongst others, is due to some symbol not being included.
> In this case, `struct hid_bpf_ctx` is not being defined anywhere that I
> can see inside of the testing tree itself.
>
> Instead, `struct hid_bpf_ctx` is defined and implemented at
> `include/linux/hid_bpf.h`. AFAIK, I cannot just include this header as
> the tools directory is a separate entity from kbuild and these tests are
> meant to be built/ran without relying on kernel headers. Am I correct in
> this assumption? At any rate, the include itself doesn't work. How can I
> properly include this struct definition and fix the warning(s)?
>
> Please note that we cannot just forward declare the struct as it is
> being dereferenced and would then yield a completely different
> error/warning for an incomplete type. We need the entire implementation
> for the struct included.
>
> Other symbols also defined in `include/linux/hid_bpf.h` that we need are
> `struct hid_report_type` and `HID_BPF_FLAG...`
>
> Here's the invocation I am running to build kselftest:
> `$ make LLVM=3D1 ARCH=3Dx86_64 mrproper headers && make LLVM=3D1 ARCH=3Dx=
86_64
> -j128 V=3D1 -C tools/testing/selftests`
>
> If anyone is currently getting clean builds of kselftest with clang,
> what invocation works for you?
>
>
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1698
> Full-build-log:
> https://gist.github.com/JustinStitt/b217f6e47c1d762e5e1cc6c3532f1bbb
> (V=3D1)
>
> Thanks.
> Justin



--=20
Thanks,
~Nick Desaulniers

