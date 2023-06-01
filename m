Return-Path: <bpf+bounces-1606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9745471F0CE
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 19:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D65831C21092
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 17:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C8B4700F;
	Thu,  1 Jun 2023 17:32:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644EC42501
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 17:32:13 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61FDE4
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 10:32:11 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30ad458f085so1977291f8f.0
        for <bpf@vger.kernel.org>; Thu, 01 Jun 2023 10:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685640730; x=1688232730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+hq+xDJm2G+PaB/kBm8mdPsMc7jhuAPEG/uoiPCxUU=;
        b=YGGNnNybl6NHBNNw7uk8DVBTBmM2H5LuC1Bh63by4HQaEcw7/V+Y283MP7isEivWin
         RZ9gCB4ew8IVofFC43Ke/P0Z40Z8S7c0VodduVXocua8MSN0F8hCJGgUL2uZUOzqMeUs
         2T4EV/RxLlabJv8aQ/6hBsFg6XQQMTQTkn0dlXfEr1srzbX0em/oyET2wf8/g0xYgU66
         IC9l2JdvWUjhzhe6XRMH1LV69JZB2cMRhAXjZPJhOE8VmuVvdahwS+hQZ5usMFKDFbD0
         iRUagRX7OMXmLRnUiNnR3wKtOrL54MU63pMaJ5D1p8XTsuqHeRBi0Ps2/ddwFIh6ISXp
         ZSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685640730; x=1688232730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+hq+xDJm2G+PaB/kBm8mdPsMc7jhuAPEG/uoiPCxUU=;
        b=dzmZrlPnaQdskKUqSCp0+DuNyWDAxEsmsqGQHQDCjtQlPsMiHjo8q0NsvQlQi9h30H
         AcZx9l3y2qfH6c61BMONx+I8vtyJGPFSjAjy7k6R5N3fk47On3piQFje6Hmfr0GzCwFM
         gC7pkLemFI5C7O0xQprjXDIIRtfFuQHMuSjwyEeAbCVQeim56s7n3W3ehKlahXxv5TQs
         5gANYCANY58Jg1uZ938urPaFEDOeU5n97pwrL1/+lQdYh+TZ3IHz4k+b/0fD9z1dvNom
         RWqphK7lPIaji8ouYLnkGn+LFJ4oQoJnrUf+++8TRM/e03WEpirE5YDi5/mJhC837uxc
         xONg==
X-Gm-Message-State: AC+VfDz09korzq1O5OosIhVSQeY8Pegv0iGJTh0fdouZf/59lrdXzG//
	LXY2xBJH+66uoQquCSX3+zy53uXnvNgHMnEfWmqVyw==
X-Google-Smtp-Source: ACHHUZ4fjtmpidlY15ghe3F2QYVjNzaN/6pA2he/WLRVUBKKAu6mrWTBqAl3l7sV47dEO0GlGauC64nmzfe4XeeSZJg=
X-Received: by 2002:adf:f547:0:b0:30a:8fc5:4411 with SMTP id
 j7-20020adff547000000b0030a8fc54411mr2199999wrp.32.1685640730020; Thu, 01 Jun
 2023 10:32:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230601122622.513140-1-kpsingh@kernel.org> <CAPhsuW45Sb0TeOYouTvaVDhOGfz+2nBht0AmGyF4=yq15HE8AA@mail.gmail.com>
 <CACYkzJ7S7JwX77NSSurr1wWYnFQs0TZwUKcwW5Zmva3CkkAx5w@mail.gmail.com> <5486EA34-136F-45EA-BD9B-EA54EC436CA1@fb.com>
In-Reply-To: <5486EA34-136F-45EA-BD9B-EA54EC436CA1@fb.com>
From: Hao Luo <haoluo@google.com>
Date: Thu, 1 Jun 2023 10:31:58 -0700
Message-ID: <CA+khW7i1FeUFn5Tudwiqvz2O5fGsvLLhhGPzC4gy+4jkk335fg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix UAF in task local storage
To: Song Liu <songliubraving@meta.com>
Cc: KP Singh <kpsingh@kernel.org>, Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin Lau <kafai@meta.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, Kuba Piecuch <jpiecuch@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 1, 2023 at 9:54=E2=80=AFAM Song Liu <songliubraving@meta.com> w=
rote:
>
>
>
> > On Jun 1, 2023, at 9:27 AM, KP Singh <kpsingh@kernel.org> wrote:
> >
> > On Thu, Jun 1, 2023 at 6:18=E2=80=AFPM Song Liu <song@kernel.org> wrote=
:
> >>
> >> On Thu, Jun 1, 2023 at 5:26=E2=80=AFAM KP Singh <kpsingh@kernel.org> w=
rote:
> >>>
<...>
> >>> Fixes: a10787e6d58c ("bpf: Enable task local storage for tracing prog=
rams")
> >>> Reported-by: Kuba Piecuch <jpiecuch@google.com>
> >>> Signed-off-by: KP Singh <kpsingh@kernel.org>
> >>> ---
> >>>
> >>> This fixes the regression from the LSM blob based implementation, we =
can
> >>> still have UAFs, if bpf_task_storage_get is invoked after bpf_task_st=
orage_free
> >>> in the cleanup path.
> >>
> >> Can we fix this by calling bpf_task_storage_free() from free_task()?
> >
> > I think we can yeah. But, this is yet another deviation from how the
> > security blob is managed (security_task_free) frees the blob that we
> > were previously using.
>
> Yeah, this will make the code even more tricky.
>
> Another idea I had is to filter on task->__state in the helper. IOW,
> task local storage does not work on starting or died tasks. But I am
> not sure whether this will make BPF_LSM less effective (not covering
> certain tasks).
>

I thought about this as well. But I think some use cases would want to
use task local storage at task creation. At least attaching at the
sched_newtask tracepoints should be fine in those cases. But at the
time of sched_newtask, task->__state is still TASK_NEW.

Another idea, is it possible to allow LSM + local storage on
starting/dying tasks, but restrict tracing + local storage to created
tasks?

Hao

