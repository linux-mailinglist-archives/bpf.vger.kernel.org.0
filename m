Return-Path: <bpf+bounces-2915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB12736D3C
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 15:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11D7A1C20C36
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 13:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2C4156F5;
	Tue, 20 Jun 2023 13:25:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB2714286
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 13:25:00 +0000 (UTC)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC5D1991
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 06:24:59 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-53fa455cd94so2344159a12.2
        for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 06:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687267498; x=1689859498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=re+SyBILUicxlS34iUets7Pi+i9q+UR/ma+OQFUNz3A=;
        b=MYxidG8ghbS9JZpyM0oIyctDaxTcuG0OjKbKNW5EmF0G2lZtyabzimYhrZkGaI1XQ3
         UQmJwgKBI3acaQe8oPPZ0xWIvVQYUF5tEZjvjsek+aLid2jDgKfL91VBZSRhlJIS9BrD
         E7ALLVoCgge9Jk8TCSdpdFBuDz9UR6cXt3CSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687267498; x=1689859498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=re+SyBILUicxlS34iUets7Pi+i9q+UR/ma+OQFUNz3A=;
        b=fq5WCjjvIkxu+f8ATwyiqkbPBHLX2CLv9Tn5RXUOAqUjFJZCPdK8Bt5qhBVrkkTJmm
         auhPQB9h9yXB7humfmejpy3pLRoh2ToT/dEykHIzZaSv0v0kNgpw8KHdr8iuOgnTYcQP
         9/8A47mpAWRLNtCBYjrHfJT8GIqApb+TSJeQq5RI5B7KB41MPFw+BN2Dx1m4SDt3EREJ
         bKJBZHwC29CLAmG0omy/v0Bcvz+EIt2xqNZAJgym1CCkD9Df2cg9znQWeJ40SLb+gDHg
         3BhguRYMfDwSwLUelEqBKXdMy/EIxwBHZl3ZV9/VPMwWAsAj3l9AJwzW7QnlDLbqFXru
         9u5Q==
X-Gm-Message-State: AC+VfDw3IoI2p1uOgH+39VsIpFw335OBwQ7fheUybn18GaBg63MlGBpk
	N/IJB1R/a77/3P4JzCkPyteCLHrefTBEnFNI+HFdug==
X-Google-Smtp-Source: ACHHUZ5K3/8TLzGIfM4jjvCSa4fJcEYPFzG/qAHAv1A2vluglx+NqbztVcunHa0YS421ZIYE+QiMZfeSH0B6my2vaRA=
X-Received: by 2002:a17:902:e548:b0:1b6:788a:551d with SMTP id
 n8-20020a170902e54800b001b6788a551dmr2794705plf.44.1687267498470; Tue, 20 Jun
 2023 06:24:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230615145607.3469985-1-revest@chromium.org> <CAEf4BzbjCt3tKJ40tg12rMjCLXrm7UoGuOdC62vGnpTTt8-buw@mail.gmail.com>
 <CABRcYmK=yXDumZj3tdW7341+sSV1zmZw1UpQkfSF6RFgnBQjew@mail.gmail.com> <c26de68d-4a56-03a0-2625-25c7e2997d45@meta.com>
In-Reply-To: <c26de68d-4a56-03a0-2625-25c7e2997d45@meta.com>
From: Florent Revest <revest@chromium.org>
Date: Tue, 20 Jun 2023 15:24:47 +0200
Message-ID: <CABRcYm+-x-Dou0zMgTPEXL+7dLoE7xDFQSLR+sU_Pyjg9=Ub0g@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf/btf: Accept function names that contain dots
To: Yonghong Song <yhs@meta.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, martin.lau@linux.dev, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, song@kernel.org, 
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, nathan@kernel.org, 
	ndesaulniers@google.com, trix@redhat.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 19, 2023 at 8:17=E2=80=AFPM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 6/19/23 7:03 AM, Florent Revest wrote:
> > On Fri, Jun 16, 2023 at 6:57=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >>
> >> On Thu, Jun 15, 2023 at 7:56=E2=80=AFAM Florent Revest <revest@chromiu=
m.org> wrote:
> >>>
> >>> When building a kernel with LLVM=3D1, LLVM_IAS=3D0 and CONFIG_KASAN=
=3Dy, LLVM
> >>> leaves DWARF tags for the "asan.module_ctor" & co symbols. In turn,
> >>> pahole creates BTF_KIND_FUNC entries for these and this makes the BTF
> >>> metadata validation fail because they contain a dot.
> >>>
> >>> In a dramatic turn of event, this BTF verification failure can cause
> >>> the netfilter_bpf initialization to fail, causing netfilter_core to
> >>> free the netfilter_helper hashmap and netfilter_ftp to trigger a
> >>> use-after-free. The risk of u-a-f in netfilter will be addressed
> >>> separately but the existence of "asan.module_ctor" debug info under s=
ome
> >>> build conditions sounds like a good enough reason to accept functions
> >>> that contain dots in BTF.
> >>
> >> I don't see much harm in allowing dots. There are also all those .isra
> >> and other modifications to functions that we currently don't have in
> >> BTF, but with the discussions about recording function addrs we might
> >> eventually have those as well. So:
> >>
> >> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > Thanks Andrii! :)
> >
> >>> Cc: stable@vger.kernel.org
> >>> Fixes: 1dc92851849c ("bpf: kernel side support for BTF Var and DataSe=
c")
> >
> > So do you think these trailers should be kept ? I suppose we can
> > either see this as a "new feature" to accommodate .isra that should go
> > through bpf-next or as a bug fix that goes through bpf and gets
> > backported to stable (without this, BTF wouldn't work on old kernels
> > built under a new clang and with LLVM_IAS=3D0 and CONFIG_KASAN=3Dy so t=
his
> > sounds like a legitimate bug fix to me, I just wanted to double check)
>
> How many people really build the kernel with
>     LLVM=3D1 LLVM_IAS=3D0
> which uses clang compiler ans gcc 'as'.
> I think distro most likely won't do this if they intend to
> build the kernel with clang.

I tend to agree with you

> Note that
>     LLVM=3D1
> implies to use both clang compiler and clang assembler.

However, this is only true since:
f12b034afeb3 ("scripts/Makefile.clang: default to LLVM_IAS=3D1")

5.10 stable for example does not have that commit and LLVM_IAS=3D0 is
still the default there. (actually that's how I stumbled upon this: by
building a 5.10 LTS and then finding a way to reproduce it upstream by
disabling LLVM_IAS)

> Using clang17 and 'LLVM=3D1 LLVM_IAS=3D0', with latest bpf-next,
> I actually hit some build errors like:
>
> /tmp/video-bios-59fa52.s: Assembler messages:
> /tmp/video-bios-59fa52.s:4: Error: junk at end of line, first
> unrecognized character is `"'
> /tmp/video-bios-59fa52.s:4: Error: file number less than one
> /tmp/video-bios-59fa52.s:5: Error: junk at end of line, first
> unrecognized character is `"'
> /tmp/video-bios-59fa52.s:6: Error: junk at end of line, first
> unrecognized character is `"'
> /tmp/video-bios-59fa52.s:7: Error: junk at end of line, first
> unrecognized character is `"'
> /tmp/video-bios-59fa52.s:8: Error: junk at end of line, first
> unrecognized character is `"'
> /tmp/video-bios-59fa52.s:9: Error: junk at end of line, first
> unrecognized character is `"'
> /tmp/video-bios-59fa52.s:10: Error: junk at end of line, first
> unrecognized character is `"'
> /tmp/video-bios-59fa52.s:68: Error: junk at end of line, first
> unrecognized character is `"'
> clang: error: assembler command failed with exit code 1 (use -v to see
> invocation)
> make[4]: *** [/home/yhs/work/bpf-next/scripts/Makefile.build:252:
> arch/x86/realmode/rm/video-bios.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
> /tmp/wakemain-88777c.s: Assembler messages:
> /tmp/wakemain-88777c.s:4: Error: junk at end of line, first unrecognized
> character is `"'
> /tmp/wakemain-88777c.s:4: Error: file number less than one
> /tmp/wakemain-88777c.s:5: Error: junk at end of line, first unrecognized
> character is `"'
> /tmp/wakemain-88777c.s:6: Error: junk at end of line, first unrecognized
> character is `"'
> /tmp/wakemain-88777c.s:7: Error: junk at end of line, first unrecognized
> character is `"'
> /tmp/wakemain-88777c.s:8: Error: junk at end of line, first unrecognized
> character is `"'
> /tmp/wakemain-88777c.s:81: Error: junk at end of line, first
> unrecognized character is `"'
> /tmp/wakemain-88777c.s:312: Error: junk at end of line, first
> unrecognized character is `"'
> clang: error: assembler command failed with exit code 1 (use -v to see
> invocation)
>
> Potentially because of my local gnu assembler 2.30-120.el8 won't work
> with some syntax generated by clang. Mixing clang compiler and arbitrary
> gnu assembler are not a good idea (see the above example). It might
> work with close-to-latest gnu assembler.

I did not hit this bug with clang 17 and bpf-next so it's probably an
incompatibility with that gnu assembler indeed.

> To support function name like '<fname>.isra', some llvm work will be
> needed, and it may take some time.
>
> So in my opinion, this patch is NOT a bug fix. It won't affect distro.
> Whether we should backport to the old kernel, I am not sure whether it
> is absolutely necessary as casual build can always remove LLVM_IAS=3D0 or
> hack the kernel source itself.

If you think it's not worth backporting to 5.10 (where LLVM_IAS=3D0 is
the default) then I could drop these trailers and send it to bpf-next
with a different justification. Either way is fine by me.

