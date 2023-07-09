Return-Path: <bpf+bounces-4548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B28A474C61D
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 17:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E03C91C20749
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 15:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C176A941;
	Sun,  9 Jul 2023 15:22:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442158834
	for <bpf@vger.kernel.org>; Sun,  9 Jul 2023 15:22:52 +0000 (UTC)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10AE4203
	for <bpf@vger.kernel.org>; Sun,  9 Jul 2023 08:22:32 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-6348a8045a2so24183946d6.1
        for <bpf@vger.kernel.org>; Sun, 09 Jul 2023 08:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688916087; x=1691508087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXze9nUKh3L/uVH6x+jXJ18GdHQRruzVjV/78O4GZMY=;
        b=ohY/WFfA/sRGBA4R0KgzTo2+nxeftQxpFjbVxRLgXp18495Iww7oORay5zcJDyJUkn
         yU+c5Tyh8yOSCRHTmO89Go1wwVrV4rmVhWosQpjkXXxAbivjK0it2vLuOTw/Xg4MmHgu
         j1s1XS7HlzfJp1mEYexrp9VE9zsWA6tj01QJkiujCFvUrGoZ4UTFDts76qt6OQcRfXA4
         h6QabV0O1bjSGNeEhh1yMdtDVRXv+gXZYdo9e1+S59jeXundJdCReVswuhn1lRhzewoq
         GAp2ldJKB9qZQHqgxC5/mGMCTzU2q/xIhPPlxPkLGhBPeHIqchiI7eaaGwDgqPa8q6b9
         Iv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688916087; x=1691508087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXze9nUKh3L/uVH6x+jXJ18GdHQRruzVjV/78O4GZMY=;
        b=J8RwGXK7oeCGxKq9Cvwb0R4MdvqPXXBzs36Tg8+6zJNj2TBt+Uk6kDN41wzM145gov
         u0fBXKbgElm2iPnC93cJ/GxI4Wqn/1EjPPUVdgpL9ziM+gEp+2AViJJJi5KY6R3dBCap
         YxkaG0jYbkhAPH54vIEpaKh6NW0JOY6vNvUOL5zhK65vUXbpEyI6DwWdSQfQQyhISPLn
         y4LBWvJ8aCZNs9GiVml2tjAD98IMWF16WTQ1St66lDGTIxzhpyzw1FGnww7RwqDr5QDl
         FsmL+w/60C6a/lEC2Tjm/KOPcZPGk3Hh5LXICCHAHIDrtrocjh2PBHxstJWpvnhifq/I
         4hng==
X-Gm-Message-State: ABy/qLarq9m5c+RDC7GUWYAifiSjRgAsi14DLZTehBpRTLSbFSjzkY+1
	RtOXx0RXgg0msMLSSr07KDvgGOseqq0w08Ny06w=
X-Google-Smtp-Source: APBJJlEdq7rukVPmHWotJgyxWCHBi8Gz8rPkQHIFxIih/GG2D1LXUCqjvJoErcr42R7byp5T1pln5k3+OPMf3IluIDc=
X-Received: by 2002:a0c:f393:0:b0:636:14d4:4481 with SMTP id
 i19-20020a0cf393000000b0063614d44481mr9636969qvk.1.1688916086836; Sun, 09 Jul
 2023 08:21:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bd1477f2-a51e-a795-4f25-a32d6ab46530@gmail.com>
 <ZKcE+wMWGdVFSBX2@google.com> <32d67707-b831-9a98-4cb9-fcb27c8806ef@gmail.com>
 <ZKhEEJfzCyYI7BfH@google.com> <5d336a9a-8ae5-2b1f-7af3-a94818867b40@gmail.com>
In-Reply-To: <5d336a9a-8ae5-2b1f-7af3-a94818867b40@gmail.com>
From: Khalid Masum <khalid.masum.92@gmail.com>
Date: Sun, 9 Jul 2023 21:21:15 +0600
Message-ID: <CAABMjtHc4Vu=_L4rOhy1a-m0nQ-ptHe68qXJd__mSQAgO+t_iw@mail.gmail.com>
Subject: Re: [PATCH v2] samples/bpf: Add more instructions to build
 dependencies and, configuration in README.rst
To: Anh Tuan Phan <tuananhlfc@gmail.com>
Cc: Stanislav Fomichev <sdf@google.com>, daniel@iogearbox.net, martin.lau@linux.dev, 
	ast@kernel.org, andrii@kernel.org, bpf@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Sun, Jul 9, 2023 at 8:38=E2=80=AFPM Anh Tuan Phan <tuananhlfc@gmail.com>=
 wrote:
>
> Hi Stanislav,
>
> I have updated the Documentation according to your suggestion. Please
> see it in the below patch. Thanks!
>
> On 7/7/23 23:57, Stanislav Fomichev wrote:
> > On 07/07, Anh Tuan Phan wrote:
> >>
> >>
> >> On 7/7/23 01:16, Stanislav Fomichev wrote:
> >>> On 07/06, Anh Tuan Phan wrote:
> >>>> Update the Documentation to mention that some samples require pahole
> >>>> v1.16 and kernel built with CONFIG_DEBUG_INFO_BTF=3Dy
> >>>>
> >>>> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
> >>>> ---
> >>>>  samples/bpf/README.rst | 7 +++++++
> >>>>  1 file changed, 7 insertions(+)
> >>>>
> >>>> diff --git a/samples/bpf/README.rst b/samples/bpf/README.rst
> >>>> index 57f93edd1957..631592b83d60 100644
> >>>> --- a/samples/bpf/README.rst
> >>>> +++ b/samples/bpf/README.rst
> >>>> @@ -14,6 +14,9 @@ Compiling requires having installed:
> >>>>  Note that LLVM's tool 'llc' must support target 'bpf', list version
> >>>>  and supported targets with command: ``llc --version``
> >>>>
> >>>> +Some samples require pahole version 1.16 as a dependency. See
> >>>> +https://docs.kernel.org/bpf/bpf_devel_QA.html for reference.
> >>>> +
> >>>
> >>> Any reason no to add pahole 1.16 to this section above?
> >>>> Compiling requires having installed:
> >>>  * clang >=3D version 3.4.0
> >>>  * llvm >=3D version 3.7.1
> >>>  * pahole >=3D version 1.16
> >>>
> >>> Although clang 3.4 probably won't get you anywhere these days. The
> >>> whole README seems a bit outdated :-)
> >>>
> >>
> >> Put pahole requirement as your idea is better, thanks for suggestion.
> >> Will update it and clang version as well. For clang version, I think I
> >> can update min version as 11.0.0 (reference from
> >> https://www.kernel.org/doc/html/next/process/changes.html). Do you see
> >> any other potential outdated things in this document? I follow the abo=
ve
> >> steps and it help me compile the sample code successfully.
> >
> > Maybe we can reference that doc instead here? Otherwise that copy-paste=
d
> > 11.0.0 will also get old. Just mention here that we need
> > clang/llvm/pahole to compile the samples and for specific versions
> > put a link to process/changes.rst
> >
> >>>>  Clean and configuration
> >>>>  -----------------------
> >>>>
> >>>> @@ -28,6 +31,10 @@ Configure kernel, defconfig for instance::
> >>>>
> >>>>   make defconfig
> >>>>
> >>>> +Some samples require support for BPF Type Format (BTF). To enable i=
t,
> >>>> open the
> >>>> +generated config file, or use menuconfig (by "make menuconfig") to
> >>>> enable the
> >>>> +following configs: CONFIG_BPF_SYSCALL and CONFIG_DEBUG_INFO_BTF.
> >>>> +
> >>>
> >>> This is usually enabled by default, so why special case it here?
> >>> Maybe, if you want some hints about the config, we should add
> >>> a reference to tools/testing/selftests/bpf/config ?
> >>>
> >>
> >> The config CONFIG_DEBUG_INFO_BTF is disabled for some distros at least
> >> for mine. I ran "make defconfig" and it's not enabled by default so I
> >> think it worth to mention it here to help novice get started. I'll
> >> update it to reference to tools/testing/selftests/bpf/config .
> >>
> >>>>  Kernel headers
> >>>>  --------------
> >>>>
> >>>> --
> >>>> 2.34.1
>
> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
> ---
>
> Change from the original patch:
>
> - Move pahole to the list installed requirements
> - Remove minimal version and link the related doc
> - Add a reference of kernel configuration
>
>  samples/bpf/README.rst | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/samples/bpf/README.rst b/samples/bpf/README.rst
> index 57f93edd1957..e18500753ba5 100644
> --- a/samples/bpf/README.rst
> +++ b/samples/bpf/README.rst
> @@ -8,9 +8,12 @@ Build dependencies
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  Compiling requires having installed:
> - * clang >=3D version 3.4.0
> - * llvm >=3D version 3.7.1
> + * clang
> + * llvm
> + * pahole
>
> +The minimal version of the above software is referenced in
> +https://www.kernel.org/doc/html/next/process/changes.html.

I think it is better to not use docs from linux-next as it keeps changing
too frequently. How about using the latest documentation's link instead? :)

https://www.kernel.org/doc/html/latest/process/changes.html

However, something to think about is: If future versions of clang, llvm etc
do not support compiling our code as it is now, it may become misleading.


>  Note that LLVM's tool 'llc' must support target 'bpf', list version
>  and supported targets with command: ``llc --version``
>
> @@ -24,7 +27,8 @@ after some changes (on demand)::
>   make -C samples/bpf clean
>   make clean
>
> -Configure kernel, defconfig for instance::
> +Configure kernel, defconfig for instance
> +(see "tools/testing/selftests/bpf/config" for a reference config)::
>
>   make defconfig
>
> --

thanks,
  -- Khalid Masum

