Return-Path: <bpf+bounces-8674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFC0788EDF
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 20:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3DA228187A
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 18:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD0C182BA;
	Fri, 25 Aug 2023 18:43:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C672915
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 18:43:58 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1434210A
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 11:43:55 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50087d47d4dso1889305e87.1
        for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 11:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692989034; x=1693593834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYSfp/hJXHq/B0YD9et1LH88tk0Lo74CWxlLhC7LFkE=;
        b=jcrtslxWKZ2TqiyYkXlurjaSW6gSYTbA0wEq5kPTCt5DCXpeXfo632CA+61taA03VP
         P581dc6yqP17s6iKXN8yaZolKljQOzS7AexPTOfBLiV/LmxSB592/WX0Y5MWfcjPsCLl
         actM1+B8SMKX6ImnXovWbjC4VWtcuKMB3svitHuJ372orpTbd2NrQjH10sJVBLI0WvBP
         DZP74QgBtVfzjz23hv8JpDRZVHXv8TNCinfZ1+aKyznbX4AJKBbGpTSYynPzoUySSHT+
         VLG47c7QWi/ZIC2GMdzUd3YE5xVSucOxTEdHE+StpUWWNXnWqByqi6d5kAxMBIwUTNUJ
         FIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692989034; x=1693593834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYSfp/hJXHq/B0YD9et1LH88tk0Lo74CWxlLhC7LFkE=;
        b=HF+EHnidlmGBDJy5KRkwgR8GpuUiyZqP7pjngcpJQKIstSqqkmSInJ0Ua7UHyd9EzA
         a/tMf77MuUhi+iuQqPnYTsqFmVDDDrJlzqGb6vgoRQH4m1xoTLtnZemBmjfqNLy3WhHP
         QuV3waK2s/327KwpSiEuOa/sg1y4grwMOIeoGT1S5+OA8Q1F4iZ8XAJlnR935ncRnkE0
         Pj7QRzYvnmV+DOrMTZH2xMV/Gx6IX1vydWNjYCBHD17w7iyy+NE+GOUJW5maPHURNHGD
         tR8OrU5VsL7kZsa/i4UECMRVC5EPULuJdu5e+TAWZKvWYFTOX88QOBeWNR0eBbWqZcG+
         gNPw==
X-Gm-Message-State: AOJu0YxChL28lz2S+2hIZqPRWR8FpKETbuPaEZ04eHqHb+7ntczzjAhv
	nPN5fdHlSe82WEYaR2ku6NC8pWRcxlXkn/y56jCeJ8gSdcw=
X-Google-Smtp-Source: AGHT+IFiTEE3wpcFIr90BSeftEXPbL7OQQVDLvtzcYlzxVn5foImC0SVduCyS8dMF+OuLzTu8brTWwIov8okIYESkQA=
X-Received: by 2002:a05:6512:1587:b0:4fd:d470:203b with SMTP id
 bp7-20020a056512158700b004fdd470203bmr16583594lfb.69.1692989033875; Fri, 25
 Aug 2023 11:43:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230809114116.3216687-1-memxor@gmail.com> <20230809114116.3216687-13-memxor@gmail.com>
In-Reply-To: <20230809114116.3216687-13-memxor@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 25 Aug 2023 11:43:42 -0700
Message-ID: <CAEf4BzbReLRegBDM0JLCQC+fg5jR_HAEMxzCORMz_EDEW590yg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 12/14] libbpf: Add support for custom
 exception callbacks
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 9, 2023 at 4:44=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> Add support to libbpf to append exception callbacks when loading a
> program. The exception callback is found by discovering the declaration
> tag 'exception_callback:<value>' and finding the callback in the value
> of the tag.
>
> The process is done in two steps. First, for each main program, the
> bpf_object__sanitize_and_load_btf function finds and marks its
> corresponding exception callback as defined by the declaration tag on
> it. Second, bpf_object__reloc_code is modified to append the indicated
> exception callback at the end of the instruction iteration (since
> exception callback will never be appended in that loop, as it is not
> directly referenced).
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Just two point before you send next version:

a) it seems like this appending of exception callback logically fits
bpf_object__relocate() step, where other subprogs are appended. Any
reason we can't do it there?

b) all the callbacks are static functions, right? Which means in the
case of static linking, we can have multiple subprogs with the same
name. So this whole look up by name thing doesn't guarantee unique
match. At the very least libbpf should check that the match is unique
and error out otherwise.

Ideally though, would be great if something like this would be
supported instead (but I know it's way more complex, Alexei already
mentioned that in person and on the list):

try (my_callback) {
    ... code that throws ...
}

try (my_other_callback) {
    ... some other code that throws ...
}


This try() macro can be implemented in a form similar to bpf_for() by
using fancy for() loop. It would look and feel way more like
try/catch.

>  tools/lib/bpf/libbpf.c | 166 +++++++++++++++++++++++++++++++++++------
>  1 file changed, 142 insertions(+), 24 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 17883f5a44b9..7c607bac8204 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -432,9 +432,11 @@ struct bpf_program {
>         int fd;
>         bool autoload;
>         bool autoattach;
> +       bool sym_global;
>         bool mark_btf_static;
>         enum bpf_prog_type type;
>         enum bpf_attach_type expected_attach_type;
> +       int exception_cb_idx;
>
>         int prog_ifindex;
>         __u32 attach_btf_obj_fd;

[...]

