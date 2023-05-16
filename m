Return-Path: <bpf+bounces-665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AFE705574
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 19:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E31401C20951
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 17:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3B911C96;
	Tue, 16 May 2023 17:52:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FF7107BA
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 17:52:01 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2782103;
	Tue, 16 May 2023 10:51:57 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bc456cc39so21218355a12.1;
        Tue, 16 May 2023 10:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684259515; x=1686851515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBUTYcmTIeDy3K4mzo4idnbb/ymZlSyCtBTIKI1s66w=;
        b=edRAx+7f6GbWKhApHSW6q+Fu5n5ivFtqfmVm53slR0lBq1xT7rcoJjQMm99uawaSYI
         FgIAdaHXOn92XV+etSqjAJySNB/CutSg04GRPguAcYvIBcrhvvU9lZNDwJTB6XTwOJMK
         Jhl/V0tdRN3IVYTLjM5hiwNAZyJiga1Uotn3eo4D21kZRIh3ht4GCJLxVo8c5IX3SBQj
         PjZ6HfkuPDnv/Aw6fnQk8Jxv0bSrShd2kSXoq9sF4Fk4e8SqEKoDhWdQSYktn1xMXm43
         LcYlptkgWY69VB9hXrtNpmZVlxmJcVL3yZYV5X5z+uN8zz6ov6RlVWsh1qRvs63SDiFI
         bBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684259515; x=1686851515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QBUTYcmTIeDy3K4mzo4idnbb/ymZlSyCtBTIKI1s66w=;
        b=QGGiP/PtYYeqp/3NLOhpx565K2w17xcDA72aV4ODzEippJshhIgk7LN4pxa23UCR15
         lgSZOT8yc3dhpGlGxUxQ8c38E2e2htFzUZFnfL32rYBrDiGwhEMp92JdjQ/26mZ1QZbs
         lyaLbJWsLeZ8vuEcafumGSSpwW5YcL8d2k9Fa958blDhYKuvflYHFCPHCmGA6dPZrwfA
         6yEqba+iBBxekCQaChIjAoeITjWxDM5mDCHLCNDhV8zUz7rz8gk/voSW2QipdX6xXffd
         4RWQh+Pj+1+N1RjvdYjquGpFa8RkNjaxQiwoTSur2Y7V2sJjIt+OdZ5brLQDiPhE7dLp
         rO9g==
X-Gm-Message-State: AC+VfDyHh0RMX7XnN4vS/ZhiUtmrvSPTCnlyPkz4x47P5/Y79uGokrOe
	ZFvjDJHN1zI8kbWSfzB+jEYzv/4YGHjUX94iCW8=
X-Google-Smtp-Source: ACHHUZ6Seww63RcfA8KHY2lr/e/9upAwRVAwBZUITxn0EMPvS6w8AZju+SUleN3OFPyrlIanhQV+k8UkoWhd5TBxDpk=
X-Received: by 2002:a05:6402:151a:b0:50b:faa1:e1d5 with SMTP id
 f26-20020a056402151a00b0050bfaa1e1d5mr26217570edw.39.1684259515291; Tue, 16
 May 2023 10:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230501200410.3973453-1-indu.bhagat@oracle.com>
 <20230501200410.3973453-6-indu.bhagat@oracle.com> <20230502105353.GO1597476@hirez.programming.kicks-ass.net>
 <20230502112720.0c0d011b@gandalf.local.home> <CAEf4BzY498TqDDBYFWoUHi9RG3fdhfDmJPo0Nm-793N7A_eTLQ@mail.gmail.com>
 <20230516133850.4685e72c@gandalf.local.home>
In-Reply-To: <20230516133850.4685e72c@gandalf.local.home>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 May 2023 10:51:43 -0700
Message-ID: <CAEf4Bza2hWkVRMCmpok1_CGA3xgkpKBCzkxS2u6hnzkANnKV3A@mail.gmail.com>
Subject: Re: [POC 5/5] x86_64: invoke SFrame based stack tracer for user space
To: Steven Rostedt <rostedt@goodmis.org>
Cc: bpf <bpf@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, linux-toolchains@vger.kernel.org, 
	daandemeyer@meta.com, andrii@kernel.org, kris.van.hees@oracle.com, 
	elena.zannoni@oracle.com, nick.alcock@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 16, 2023 at 10:38=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Tue, 16 May 2023 10:25:52 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > As discussed in the halls of LSF/MM2023, such lazily mapped .sframe in
> > approach won't work with BPF's bpf_get_stack() approach, which expects
> > stack trace to be grabbed and returned synchronously from NMI context.
> > But we can probably retrofit it into bpf_get_stackid()+STACK_TRACE BPF
> > map API.
>
> Note that we will likely not be able to use sframe in NMI context, and if
> that's a requirement, then BPF will need to continue using the method it =
is
> currently using.

Yes, unfortunately. We should give users a way to use sframes, but
transition might be slow.

>
> The best way to access sframe reliable is in normal context. NMI is
> special, and really should never had been used to access user space
> addresses. That was just a simple solution but not a good one. There's a
> lot of hacks just to allow a page fault in NMI context.
> See https://lwn.net/Articles/484932/
>
> >
> > Indu, please cc bpf@vger.kernel.org for future revisions so we can
> > track and plan accordingly. Thank you!
>
> I'll likely be taking over the kernel side of sframes. I'll be happy to
> Cc that work to the bpf mailing list.

Thanks!


>
> -- Steve

