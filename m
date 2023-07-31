Return-Path: <bpf+bounces-6489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F83176A4E5
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 01:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D55282814D8
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 23:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E711EA85;
	Mon, 31 Jul 2023 23:35:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C15E1DDC1
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 23:35:27 +0000 (UTC)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D21EE
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 16:35:25 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-267f870e6ffso2967081a91.0
        for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 16:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690846525; x=1691451325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ey2ryvOz6VZwjtSUJUm3tN7LBBt048JuDhewPiwIObA=;
        b=WzbBom19lBHnQPMF8nc6G0Lnicm/MLSIz7DYZXzAduSft4tjQZJkozYl1MYdLHy6Sg
         7j7Z/+vr7/5o6Zl+FQ76NcUjeY0jliTEAvQCVu2B1eGNp/cYkhnCQakfig51B6HftzIp
         yiOVbltI59IkyGt8pqQrawZOS7XcevCDpMIZz9pme1w4+G1m0IG9uLhhl3q9Etxw/NoF
         E4Ik0CxpFww2uKqx0JBIguLP74jFElNOAj8xaPz7ckW6EMjQmuVHW4bydOE4UNcs0SYG
         CkxhlMupHipTd5LwCltWX1AnqceRw8AN1ynROtvWeT7f58yEBCdXcYjLXXq6EcL2N81+
         cg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690846525; x=1691451325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ey2ryvOz6VZwjtSUJUm3tN7LBBt048JuDhewPiwIObA=;
        b=FFPf0mJXHVu2TgGYKMYkgR18dezM97vsMKl+NfQysIRVfoMQK8Hjp4FE4oAc7JwQrL
         iJVQo5ka+SeO0BMQTMLVjTji/Lg2xKbelF213sLUs1EvNIYGKtXeOE/tx/N3xSQVTXEM
         WDPb0+IpTJXpfTDyQ2Dr1mRgq/ywVmr4h29fq8Z7VZUvUFbKupNsD2B0XoQXX7xPOiEp
         pQpeUzQ0LefGjP7dCQz0Q0yg1jlPORq4A0JQw6F2prGQBTwfesixuUoAcDGe3Mmx7sK6
         n8pqObApX1Yg6f7FNQIH7xqwe+BtjS9HFdaADzrFJH/XxPpwI/ATS1vXeF0AfKIgYma2
         DNAg==
X-Gm-Message-State: ABy/qLYUlQFCV85Gh3bY4u//ewvV/Sn8pa/LE2k0J1ZgXUezd7Ccvgng
	JIlYKYboGQxAz1UNaMOM5a7ZNwEFTo0ULEi1xdsgYiPJurkkoghNUFYtvg==
X-Google-Smtp-Source: APBJJlEoVEJ84b8bOcUTpt8QC4lRahBum4SQXUxwYE3M/ewlJ5GhZs6YEq++ynhhcMs++N54EcqXpwjumimge3l2+ac=
X-Received: by 2002:a17:90a:f284:b0:268:36c1:4204 with SMTP id
 fs4-20020a17090af28400b0026836c14204mr10094145pjb.4.1690846525114; Mon, 31
 Jul 2023 16:35:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230722052248.1062582-1-kuifeng@meta.com> <20230722052248.1062582-2-kuifeng@meta.com>
 <ZL7Ery1lzqj4as7N@google.com> <00dbd930-5ec2-7fb6-202b-38d09e13eb0b@gmail.com>
In-Reply-To: <00dbd930-5ec2-7fb6-202b-38d09e13eb0b@gmail.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Mon, 31 Jul 2023 16:35:13 -0700
Message-ID: <CAKH8qBvcD7r0e-0oZryLHyGnsNnZ66w6tHj5t4Qi1SzONnwN+w@mail.gmail.com>
Subject: Re: [RFC bpf-next 1/5] bpf: enable sleepable BPF programs attached to cgroup/{get,set}sockopt.
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com, 
	andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 31, 2023 at 3:02=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.com> =
wrote:
>
> Sorry for the late reply! I just backed from a vacation.
>
>
> On 7/24/23 11:36, Stanislav Fomichev wrote:
> > On 07/21, kuifeng@meta.com wrote:
> >> From: Kui-Feng Lee <kuifeng@meta.com>
> >>
> >> Enable sleepable cgroup/{get,set}sockopt hooks.
> >>
> >> The sleepable BPF programs attached to cgroup/{get,set}sockopt hooks m=
ay
> >> received a pointer to the optval in user space instead of a kernel
> >> copy. ctx->user_optval and ctx->user_optval_end are the pointers to th=
e
> >> begin and end of the user space buffer if receiving a user space
> >> buffer. ctx->optval and ctx->optval_end will be a kernel copy if recei=
ving
> >> a kernel space buffer.
> >>
> >> A program receives a user space buffer if ctx->flags &
> >> BPF_SOCKOPT_FLAG_OPTVAL_USER is true, otherwise it receives a kernel s=
pace
> >> buffer.  The BPF programs should not read/write from/to a user space b=
uffer
> >> dirrectly.  It should access the buffer through bpf_copy_from_user() a=
nd
> >> bpf_copy_to_user() provided in the following patches.
> >>
> >> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> >> ---
> >>   include/linux/filter.h         |   3 +
> >>   include/uapi/linux/bpf.h       |   9 ++
> >>   kernel/bpf/cgroup.c            | 189 ++++++++++++++++++++++++++-----=
--
> >>   kernel/bpf/verifier.c          |   7 +-
> >>   tools/include/uapi/linux/bpf.h |   9 ++
> >>   tools/lib/bpf/libbpf.c         |   2 +
> >>   6 files changed, 176 insertions(+), 43 deletions(-)
> >>
> >> diff --git a/include/linux/filter.h b/include/linux/filter.h
> >> index f69114083ec7..301dd1ba0de1 100644
> >> --- a/include/linux/filter.h
> >> +++ b/include/linux/filter.h
> >> @@ -1345,6 +1345,9 @@ struct bpf_sockopt_kern {
> >>      s32             level;
> >>      s32             optname;
> >>      s32             optlen;
> >> +    u32             flags;
> >> +    u8              *user_optval;
> >> +    u8              *user_optval_end;
> >>      /* for retval in struct bpf_cg_run_ctx */
> >>      struct task_struct *current_task;
> >>      /* Temporary "register" for indirect stores to ppos. */
> >> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >> index 739c15906a65..b2f81193f97b 100644
> >> --- a/include/uapi/linux/bpf.h
> >> +++ b/include/uapi/linux/bpf.h
> >> @@ -7135,6 +7135,15 @@ struct bpf_sockopt {
> >>      __s32   optname;
> >>      __s32   optlen;
> >>      __s32   retval;
> >> +
> >> +    __bpf_md_ptr(void *, user_optval);
> >> +    __bpf_md_ptr(void *, user_optval_end);
> >
> > Can we re-purpose existing optval/optval_end pointers
> > for the sleepable programs? IOW, when the prog is sleepable,
> > pass user pointers via optval/optval_end and require the programs
> > to do copy_to/from on this buffer (even if the backing pointer might be
> > in kernel memory - we can handle that in the kfuncs?).
> >
> > The fact that the program now needs to look at the flag
> > (BPF_SOCKOPT_FLAG_OPTVAL_USER) and decide which buffer to
> > use makes the handling even more complicated; and we already have a
> > bunch of hairy stuff in these hooks. (or I misreading the change?)
> >
> > Also, regarding sleepable and non-sleepable co-existence: do we really =
need
> > that? Can we say that all the programs have to be sleepable
> > or non-sleepable? Mixing them complicates the sharing of that buffer.
>
> I considered this approach as well. This is an open question for me.
> If we go this way, it means we can not attach a BPF program of a type
> if any program of the other type has been installed.

If we pass two pointers (kernel copy buffer + real user mem) to the
sleepable program, we'll make it even more complicated by inheriting
all existing warts of the non-sleepable version :-(
IOW, feels like we should try to see if we can have some
copy_to/from_user kfuncs in the sleepable version that transparently
support either kernel or user memory (and prohibit direct access to
user_optval in the sleepable version).
And then, if we have one non-sleepable program in the chain, we can
fallback everything to the kernel buffer (maybe).
This way seems like we can support both versions in the same chain and
have a more sane api?

