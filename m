Return-Path: <bpf+bounces-5680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2E075DFA8
	for <lists+bpf@lfdr.de>; Sun, 23 Jul 2023 04:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F8A81C20A14
	for <lists+bpf@lfdr.de>; Sun, 23 Jul 2023 02:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637757F4;
	Sun, 23 Jul 2023 02:02:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389DE655
	for <bpf@vger.kernel.org>; Sun, 23 Jul 2023 02:02:43 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E868119;
	Sat, 22 Jul 2023 19:02:42 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b961822512so46494171fa.2;
        Sat, 22 Jul 2023 19:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690077761; x=1690682561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxXqztj5OtaboYjZJG2RhBj3enmq0GMAVkQwjxk3WaM=;
        b=KzmI0GVDBAVsb+2SsO5TF0mSZnnJB9lI55c9iArQ7WqfJtwhG0Y53aJp6aYCqQrenY
         7w6K1l3hUJpYBUI2na591nMv5ukdZXBX0wTQR69L75a1MlemSZ1PJN78gM9xg+A4BneO
         SDa5q1spEGrwRCVFhwb6ENzdriiMJltHJpGu896p0Zcl+7N2bn8owTQEousVkhZrVqTT
         VcqgH/qkI+XqZ5NPkcaGYf39SaOXHN/WOFZfvkA5O1Qs8LamYoSvN/dAYZMwAIeKXweM
         seN4KjzldN/0lrnL51NOV4KA6AoZtm4p1v21gx9yEd6eLrRvwA9q6V5D6+PtijPH668i
         pfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690077761; x=1690682561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CxXqztj5OtaboYjZJG2RhBj3enmq0GMAVkQwjxk3WaM=;
        b=gh8Vd3MMLua80cBe3N7cjYU8Q1S1h7YnZ+r4Z1uqFomU3IdbXR1ov6yLZLkgob0wLR
         lmdgiK7JbrPraBWJePkuexlPbL5J43j0cB10yD7NTSMTJjCN1Zlw4vzOze2k22u2EIdu
         /btQS3fZg/FP5peVnY5utNnkxuiOl11miyY4BErqSS6FthikruE7VrbPUXxusbwFCXKx
         EUYWmQvXI9GlH34D+cs3VQcXiG9eDRRmONeD5e7voA2eXi7fzW83oAJjushGzfBeGz5r
         WJ4KeEOrYwD1jwIro67h06583UhZxrYpwgyjKSraIXiJCOIAwCUOnvhmeJkvHZ+7Tnb8
         oezg==
X-Gm-Message-State: ABy/qLbtg+tLj5hUbbveud3IunbnVIFKe0dp9YnTa1vVQQvaCWTSXmFo
	i9ljCsxwj237UFGpOZkNfwt5xKoQp2S1OY6mXhw=
X-Google-Smtp-Source: APBJJlFOUkirrJ9kb1G3aNFcsCoIimvObe12ggBhf/OK/05/RgMz+f8feFW2/xIRgU1rXbAWhHF8M23AQtCKrawjxXg=
X-Received: by 2002:a2e:9283:0:b0:2b6:eeb3:da94 with SMTP id
 d3-20020a2e9283000000b002b6eeb3da94mr3695037ljh.22.1690077760516; Sat, 22 Jul
 2023 19:02:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bba66a5f-3605-e36b-2bf3-f25a48307a46@gmail.com>
In-Reply-To: <bba66a5f-3605-e36b-2bf3-f25a48307a46@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 22 Jul 2023 19:02:29 -0700
Message-ID: <CAADnVQKJ+SzCEaXxpSKemJo8p0bCOGcoOv1NDsJMsTsMmJmiZQ@mail.gmail.com>
Subject: Re: bpf: bpf_probe_read_user_str() returns 0 for empty strings
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>, Max Froehling <Maximilian.Froehling@gdata.de>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux BPF <bpf@vger.kernel.org>, 
	Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 22, 2023 at 6:53=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> Hi,
>
> I notice a bug report on Bugzilla [1]. Quoting from it:
>
> > Overview:
> >
> > From within eBPF, calling the helper function bpf_probe_read_user_str(v=
oid *dst, __u32 size, const void *unsafe_ptr returns 0 when the source stri=
ng (void *unsafe_ptr) consists of a string containing only a single null-by=
te.
> >
> > This violates various functions documentations (the helper and various =
internal kernel functions), which all state:

Sounds like the bugzilla author believes it's a documentation issue.
If so, please encourage the author to send the patch to fix the doc.

> >
> >> On success, the strictly positive length of the output string,
> >> including the trailing NUL character. On error, a negative value.
> >
> > To me, this states that the function should return 1 for char myString[=
] =3D ""; However, this is not the case. The function returns 0 instead.
> >
> > For non-empty strings, it works as expected. For example, char myString=
[] =3D "abc"; returns 4.
> >
> > Steps to Reproduce:
> > * Write an eBPF program that calls bpf_probe_read_user_str(), using a u=
serspace pointer pointing to an empty string.
> > * Store the result value of that function
> > * Do the same thing, but try out bpf_probe_read_kernel_str(), like this=
:
> > char empty[] =3D "";
> > char copy[5];
> > long ret =3D bpf_probe_read_kernel_str(copy, 5, empty);
> > * Compare the return value of bpf_probe_read_user_str() and bpf_probe_r=
ead_kernel_str()
> >
> > Expected Result:
> >
> > Both functions return 1 (because of the single NULL byte).
> >
> > Actual Result:
> >
> > bpf_probe_read_user_str() returns 0, while bpf_probe_read_kernel_str() =
returns 1.
> >
> > Additional Information:
> >
> > I believe I can see the bug on the current Linux kernel master branch.
> >
> > In the file/function mm/maccess.c::strncpy_from_user_nofault() the help=
er implementation calls strncpy_from_user(), which returns the length witho=
ut trailing 0. Hence this function returns 0 for an empty string.
> >
> > However, in line 192 (as of commit fdf0eaf11452d72945af31804e2a1048ee1b=
574c) there is a check that only increments ret, if it is > 0. This appears=
 to be the logic that adds the trailing null byte. Since the check only doe=
s this for a ret > 0, a ret of 0 remains at 0.
> >
> > This is a possible off-by-one error that might cause the behavior.
>
> See Bugzilla for the full thread.
>
> FYI, the culprit line is introduced by commit 3d7081822f7f9e ("uaccess: A=
dd
> non-pagefault user-space read functions"). I Cc: culprit SoB so that they
> can look into this bug.
>
> Thanks.
>
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D217679
>
> --
> An old man doll... just what I always wanted! - Clara
>

