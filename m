Return-Path: <bpf+bounces-7772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B6F77C15E
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 22:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EDE92811F0
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 20:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D175D530;
	Mon, 14 Aug 2023 20:16:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3442CCA4B
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 20:16:19 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FC913E
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 13:16:15 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1c0fff40ec6so3176877fac.2
        for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 13:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692044174; x=1692648974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqX3ldQL378WfN0uOHOZtZ5I06R4ar9Vbej/rWbI9mw=;
        b=j/Wg7Ebtb5bysDyT5Ov9RO1DV1KLJe2XLooEH2O3LjR/R6/Im0IocLmgVNN01hf+CH
         6tA0iGXGgc2IO74RDDmQSHJPz4ykXKWeMYmQuDSfKT6idXw1PZFylAbBlkgEsbi6bh2w
         4h78KbtrWewH264By8zvVghuXFbSKOjJMA6Y7s8h4gb18f6G9W92wF47fdp0uvMxEqYn
         KZGfLHg80nS6zAwE5RX+WfLR0bXg9hyfy1B3T63caDIU/+w0+BtG998iPl+AUDGqtOlW
         7KhS96R2QJh3KgHBh3ji2qxbQ+RcIwBySWgkJd6bB/inKg65PONh6vuornPDwo7Oapbb
         1SsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692044174; x=1692648974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqX3ldQL378WfN0uOHOZtZ5I06R4ar9Vbej/rWbI9mw=;
        b=SkMDRCP7rTS6Y/MLb2AY4WPDZNpgxR9bN0T+QHRRcE24bFQyhLhSs/y3k11djskpho
         TZhTmwwA72Anf9zJ99EfdyxYCivjLFZqC6mBn8qTfx9RghUTRCzV5UzxHIyPYisx2lKg
         ZuGq8B8S719qqzWB2j4cqStOZesgVZPyDOa0s54eyweo+0hPxvSXTBbrwEhXdhx/1E5f
         6qp69eeVdH2qXHr/S1B1OXkbNbhY5aRHsCTU8Q96m6LFHJQK4osgO273V63M+K5Dl228
         z4oUI0rJgSe5iLkWNasMoFX2fRAvo/T3e+Ffpt1ls9RLMAsyCyjQ/WycbAphRIjfg5fS
         Msyg==
X-Gm-Message-State: AOJu0YybFGHNbmM/CxensDVix1uqPJOu+24qsTk4FIFYEU6V6qEq9cbK
	VOAQP61/mV9ThCk9oSbHnvtih9LiW0MicEkirfvpx3WkOXER5WQ6E9FafA==
X-Google-Smtp-Source: AGHT+IHs79P1IZjO95aOED25rACR3z3yRd9cziOyVfHygagJVYvupMa0Fdxcz3Z9CvtyPls3oOwVnE4bQ+dCaAuysAY=
X-Received: by 2002:a05:6870:7a3:b0:1bb:5bc3:7f23 with SMTP id
 en35-20020a05687007a300b001bb5bc37f23mr10291712oab.46.1692044174421; Mon, 14
 Aug 2023 13:16:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230811043127.1318152-1-thinker.li@gmail.com>
 <20230811043127.1318152-5-thinker.li@gmail.com> <ZNa+vhzXxYYOzk96@google.com>
 <6a634e79-db63-df29-9d18-93387191f937@gmail.com> <0164ca41-01bc-be14-2f99-b1c4400850b8@gmail.com>
 <ZNpfTBh4cC1oW8Cf@google.com> <b3c8c714-088b-6c9e-5e23-fd1817d8cfae@gmail.com>
In-Reply-To: <b3c8c714-088b-6c9e-5e23-fd1817d8cfae@gmail.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Mon, 14 Aug 2023 13:16:03 -0700
Message-ID: <CAKH8qBsbz0YUb9o2qf-hYoFX7CJ8i9aw2+2s80txCZawgPPZbQ@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 4/6] bpf: Provide bpf_copy_from_user() and bpf_copy_to_user().
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: thinker.li@gmail.com, bpf@vger.kernel.org, ast@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com, 
	andrii@kernel.org, yonghong.song@linux.dev, kuifeng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 14, 2023 at 12:20=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.com>=
 wrote:
>
>
>
> On 8/14/23 10:07, Stanislav Fomichev wrote:
> > On 08/11, Kui-Feng Lee wrote:
> >>
> >>
> >> On 8/11/23 16:27, Kui-Feng Lee wrote:
> >>>
> >>>
> >>> On 8/11/23 16:05, Stanislav Fomichev wrote:
> >>>> On 08/10, thinker.li@gmail.com wrote:
> >>>>> From: Kui-Feng Lee <kuifeng@meta.com>
> >>>>>
> >>>>> Provide bpf_copy_from_user() and bpf_copy_to_user() to the BPF prog=
rams
> >>>>> attached to cgroup/{set,get}sockopt. bpf_copy_to_user() is a new
> >>>>> kfunc to
> >>>>> copy data from an kernel space buffer to a user space buffer.
> >>>>> They are only
> >>>>> available for sleepable BPF programs. bpf_copy_to_user() is only
> >>>>> available
> >>>>> to the BPF programs attached to cgroup/getsockopt.
> >>>>>
> >>>>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> >>>>> ---
> >>>>>    kernel/bpf/cgroup.c  |  6 ++++++
> >>>>>    kernel/bpf/helpers.c | 31 +++++++++++++++++++++++++++++++
> >>>>>    2 files changed, 37 insertions(+)
> >>>>>
> >>>>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> >>>>> index 5bf3115b265c..c15a72860d2a 100644
> >>>>> --- a/kernel/bpf/cgroup.c
> >>>>> +++ b/kernel/bpf/cgroup.c
> >>>>> @@ -2461,6 +2461,12 @@ cg_sockopt_func_proto(enum bpf_func_id
> >>>>> func_id, const struct bpf_prog *prog)
> >>>>>    #endif
> >>>>>        case BPF_FUNC_perf_event_output:
> >>>>>            return &bpf_event_output_data_proto;
> >>>>> +
> >>>>> +    case BPF_FUNC_copy_from_user:
> >>>>> +        if (prog->aux->sleepable)
> >>>>> +            return &bpf_copy_from_user_proto;
> >>>>> +        return NULL;
> >>>>
> >>>> If we just allow copy to/from, I'm not sure I understand how the buf=
fer
> >>>> sharing between sleepable/non-sleepable works.
> >>>>
> >>>> Let's assume I have two progs in the chain:
> >>>> 1. non-sleepable - copies the buffer, does some modifications; since
> >>>>      we don't copy the buffer back after every prog run, the modific=
ations
> >>>>      stay in the kernel buffer
> >>>> 2. sleepable - runs and just gets the user pointer? does it mean thi=
s
> >>>>     sleepable program doesn't see the changes from (1)?
> >>
> >> It is still visible from sleepable programs.  Sleepable programs
> >> will receive a pointer to the buffer in the kernel.
> >> And, BPF_SOCKOPT_FLAG_OPTVAL_USER is clear.
> >>
> >>>>
> >>>> IOW, do we need some custom sockopt copy_to/from that handle this
> >>>> potential buffer location transparently or am I missing something?
> >>>>
> >>>> Assuming we want to support this at all. If we do, might deserve a
> >>>> selftest.
> >>>
> >>> It is why BPF_SOCKOPT_FLAG_OPTVAL_USER is there.
> >>> It helps programs to make a right decision.
> >>> However, I am going to remove bpf_copy_from_user()
> >>> since we have bpf_so_optval_copy_to() and bpf_so_optval_copy_to_r().
> >>> Does it make sense to you?
> >
> > Ah, so that's where it's handled. I didn't read that far :-)
> > In this case yes, let's have only those helpers.
> >
> > Btw, do we also really need bpf_so_optval_copy_to_r? If we are doing
> > dynptr, let's only have bpf_so_optval_copy_to version?
>
> Don't you think bpf_so_optval_copy_to_r() is handy to copy
> a simple string to the user space?

Yeah, it is convenient, but it feels like something we can avoid if we
are using dynptrs (exclusively)?
Can the programs have a simple wrapper around
bpf_so_optval_from+bpf_so_optval_copy_to to provide the same ptr-based
api?

static inline void bpf_so_optval_copy_to_r(sopt, ptr, sz) {
   bpf_so_optval_alloc(sopt, sz, &dynptr);
   some_dynptr_copy_to(&dynptr, ptr, siz);
   bpf_so_optval_copy_to(sopt, &dynptr);
   bpf_so_optval_release(&dynptr);
}

Or maybe we should instead have a new kfunc that turns sopt ptr+sz
into a dynptr?

static inline void bpf_so_optval_copy_to_r(sopt, ptr, sz) {
   bpf_so_optval_from_user_ptr(sopt, &dynptr);
   bpf_so_optval_copy_to(sopt, &dynptr);
   bpf_so_optval_release(&dynptr);
}

That probably fits better into dynptr world?

