Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACEC574589
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 09:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiGNHK3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 03:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235638AbiGNHK1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 03:10:27 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5DB1D330
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 00:10:26 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id sz17so1739656ejc.9
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 00:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AUYqFbV0cJeIrjQ2xG+x6K0R1EWu8kMUJIy2Y43cUgM=;
        b=HaxaEsE3J6coon/KVfBGfIPqhRcxTySZSlTAlMo85qNCt/x6yl5xyhOJhqv0GWXxnW
         xujd00yv3sYN5HNWE1+Vbl/IZnaNVnH47KCxEVY5SQocNiUUvy+O1eoDwRSmEqp/MUvr
         RBA41zq+ZM3F6gqt/oLvzlyIWDEwzCzV1cv/l1s4tdocbXZuwyvWWHEFm0GzUg+Tgkm5
         dHYj7Z7e4jNxYHTEJEVOFu7CEeTxynfkqH6gnybpBjgE8wUIX1vpG3ZjFnH/+d8v0VQG
         FlOZWigv5kuLZs41ADfZnEhnI1zTiespDIWUsAsxzIhSg/NXEOC/GBZjIloKD6sbSV1h
         b90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AUYqFbV0cJeIrjQ2xG+x6K0R1EWu8kMUJIy2Y43cUgM=;
        b=AOZbT5xA3Owrd+ggD+jVP5g7XGhDALzQMvqcM35OudFpc1Z9UAIZErL6VEPxPCdflE
         awnUVDCSvwqC7DECMVRZMCa90Noq+6KDj0S9w/M7z+pZU3/shHv4J3mP+yTh4ErbJO32
         PCPy5dWV9Ot5a7JYjIBxOu3bG+YGIyMJGcPFfKI33t65Al4sUZ/bqmn/y3nwNiiN40AF
         YQ28+Ou84iSACZOADXhDN0MAvJf5IX9IALGvJ8UhjPj+e6FvYPdBtP+HsoKCTnolSWgs
         OF63DhRFswnNb4N2BW3IvXbYdOjv+TzU4z40TDiMK68LFIO7mwFhtaEsjDz0n9iu03Id
         hc0A==
X-Gm-Message-State: AJIora8Ey9XqLkQssk7UZQWGO611ymo4cxIVQ2E4lVJPHcqAy8sdzSUT
        n+DK9Y97ssTmq3u98EwXhYERcFLWfXvRYo2x3Hbz6/WeNWY=
X-Google-Smtp-Source: AGRyM1t6Osxvkk/Nl4EpdTI3vPtDNi4MqZc+NoldY5WCpIDc1BCtGiRhqRKXMuYTj7akUks27V7Bf2+Wudyb58BubRM=
X-Received: by 2002:a17:907:75ef:b0:72b:2fd:1a92 with SMTP id
 jz15-20020a17090775ef00b0072b02fd1a92mr7230388ejc.745.1657782625516; Thu, 14
 Jul 2022 00:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220713222544.2355143-1-indu.bhagat@oracle.com>
 <CAEf4BzYqL_p61f_2HXSNuCSXPGxWbq7+kvZvmVGGgdLY1Z1ZWA@mail.gmail.com> <70edc9d0-9dab-c5d7-7f3e-9ce6c3b700de@fb.com>
In-Reply-To: <70edc9d0-9dab-c5d7-7f3e-9ce6c3b700de@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 14 Jul 2022 00:10:14 -0700
Message-ID: <CAEf4BzbfQzWsF=egHutsqz4tn_4qP3bs8Jb=iX5TbfuVaB5kHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] docs/bpf: Update documentation for BTF_KIND_FUNC
To:     Yonghong Song <yhs@fb.com>
Cc:     Indu Bhagat <indu.bhagat@oracle.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 13, 2022 at 11:42 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 7/13/22 11:00 PM, Andrii Nakryiko wrote:
> > On Wed, Jul 13, 2022 at 3:37 PM Indu Bhagat <indu.bhagat@oracle.com> wrote:
> >>
> >> The vlen bits in the BTF type of kind BTF_KIND_FUNC are used to convey the
> >> linkage information for functions.
> >>
> >> Signed-off-by: Indu Bhagat <indu.bhagat@oracle.com>
> >> ---
> >>   Documentation/bpf/btf.rst | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> >> index f49aeef62d0c..b3a9d5ac882c 100644
> >> --- a/Documentation/bpf/btf.rst
> >> +++ b/Documentation/bpf/btf.rst
> >> @@ -369,7 +369,7 @@ No additional type data follow ``btf_type``.
> >>     * ``name_off``: offset to a valid C identifier
> >>     * ``info.kind_flag``: 0
> >>     * ``info.kind``: BTF_KIND_FUNC
> >> -  * ``info.vlen``: 0
> >> +  * ``info.vlen``: linkage information (static=0, global=1)
> >
> > there is also extern=2, but I think we should just refer to enum
> > btf_func_linkage, defined in UAPI (include/uapi/linux/btf.h) ?
>
> Currently kernel rejects extern=2. In kernel btf.c, we have
>
>          if (btf_type_vlen(t) > BTF_FUNC_GLOBAL) {
>                  btf_verifier_log_type(env, t, "Invalid func linkage");
>                  return -EINVAL;
>          }
>
> and extern=2 will cause btf loading failure.
>
> The BTF_FUNC_EXTERN is generated when you call an extern *global*
> function. I suspect that during static linking, all these
> extern globals should become true global/static functions and
> not extern func's any more so kernel is okay.
>
> So looks like it is worthwhile to mention that BTF_KIND_FUNC
> supports all three modes as specified in enum btf_func_linkage.
> But only static/global is supported in the kernel.
>

Exactly. This is specification of BTF format (for clang and gcc to
agree upon, for example), while kernel BTF verifier puts extra
conditions on top of BTF format itself (as required by C and kernel
semantics). So it makes sense to document all possibilities and extra
kernel checks.

> >
> >>     * ``type``: a BTF_KIND_FUNC_PROTO type
> >>
> >>   No additional type data follow ``btf_type``.
> >> --
> >> 2.31.1
> >>
