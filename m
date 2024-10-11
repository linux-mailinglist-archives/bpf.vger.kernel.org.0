Return-Path: <bpf+bounces-41692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EEC999A69
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 04:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62C991F24482
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 02:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039D01EF940;
	Fri, 11 Oct 2024 02:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZY7CcCe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F5C23BB;
	Fri, 11 Oct 2024 02:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728613833; cv=none; b=fwBj2XFa4DG3w0NtTk49PPR2IcESM5RvA/eExMV1COoKp+OCTqgHu4S6FCuGtVx9zcjrHmkw7m5EKFTi7nL4h2zSytH8eGl0HEqjm/rwTvclYlV080I06yBi6VJ55/8+r5noEDcLgO5qRBBXp/lbhdUFktu/qnJe78yQiKXrL/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728613833; c=relaxed/simple;
	bh=IM+HtZSUYKnaPbgnWT66jPxOHNKmQlndka0ivP75k8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GRFqdXUiWJASEuo6xl4RScU2mZchlWVyxhT/ocXJ9YlOrp+VvAUI2q/oeER4HvkYR9FSOpHUx0/nEDscARioSTLxmh9szBIPRcoVNI30RDp6PIlQZhnlaq/19JqYL9cz/CwfzwvaZJ7lyznku5CeiGkGRZ8F6NE7TpeSNZjGueQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZY7CcCe; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e221a7e7baso1134317a91.0;
        Thu, 10 Oct 2024 19:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728613831; x=1729218631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+rv2yGapHHL0pAzQCpkDvYvkJ5oH7bg79lxOk/DwIA=;
        b=iZY7CcCePJ8hssyHvVw3GN3mYAXAhM87dZnGYbxfku8tic5+cmQhawtSTNP3fk6Yaz
         ewOaXyUQiFBARTqnbJWGIBtjfICiBM0D5nSTQSOfksTzBxCWCE1zWj8CixylqT3zPjan
         GP5BnL/4PFtONgIBRQkczLUIqEBla29Oy8KYUkun/t2mygHeFwrDd9pI1ohOfYe9zkvN
         A3baN4AaQFheGrD0umPIfALJeH5Hd1RAwaGGoGt7wrmAqnRpaOuYzag9fxjysu76uYW9
         91ivJtpteobYroHO3nFSfM+NqajfushveMdGCUYk2uggKUSswQJjBOEynVX4pJlTusQK
         dA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728613831; x=1729218631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+rv2yGapHHL0pAzQCpkDvYvkJ5oH7bg79lxOk/DwIA=;
        b=gLXADk2YI4n4TM494GAmIlbgNEalUty355HSNEXViZVH/y4h5ACWf3DwpsEIKPMXgJ
         si6GunOij5XzzFSZpRDpyf/2Q3yEbGduBOpb0RQ1fFSLhGAPtZnrcEjb0U+TSK8+7v6I
         +A7uD+mFMrcAf2G62/gk8jOKVh3VIcc/7OmpQADPHWV0plmXsRC2VdIeu2WaxZt88upQ
         DZmOs+DOo4vvGUONy05NDPjMyt0M2ENvxJBKb9NPWvOnMemU6WoNLge7sum/GopFm1S9
         bjVgyYiSSafeWQHPm9KQm5D2uhybEnc3OZjWva0SNOKwzmvsxUHwVb6C1jaNzBn9Cl4g
         4ynw==
X-Forwarded-Encrypted: i=1; AJvYcCUOyKNrF0MkqXLIg7/Z449j0IyBsjnGZaqWEL2mGunTdLx/Ge0Q//NIX/EtbGnZJH4CV4g=@vger.kernel.org, AJvYcCUT0CYduDadwag3mZdhJfccSmqNK7z+tcuo5n2yUhVVUmajoaKkmEuj9283iaZx2gya6NFiNpG6nNKjLNUHNe4n8nLp@vger.kernel.org, AJvYcCXaqNRo4DA70c7R49+WSQ8d2Z+6YXiTekeX9sil4tNNszUO5YxiwZYU4yzI/+oXYqrVVVny9Chvt+gfSCFH@vger.kernel.org
X-Gm-Message-State: AOJu0YwdGBbpIdjV7uggJhUBXMq8s5bXSEp/Xwxwvrr9/Ergj8I90QoR
	WZ/yobNQDj7PPxlz8ZNZw2ThJTD7m2ln6PsqXPJJoVXAKNKAjJja1uPlcj3u+JkS/jVSSpKOA8k
	H/sBvREHlDD+tKT8484HaaEg10lU=
X-Google-Smtp-Source: AGHT+IFo7/gVkJ4Od+lqya4IS5vMNWEttRQMoQAZjbMJO+90QHbf6/O97lNsugzv+/kr2Vnd/E2wAzLHsh2/05rytwY=
X-Received: by 2002:a17:90a:8cb:b0:2e2:d7db:41fc with SMTP id
 98e67ed59e1d1-2e2f0a9d22dmr1764010a91.10.1728613831503; Thu, 10 Oct 2024
 19:30:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010200957.2750179-1-jolsa@kernel.org> <20241010200957.2750179-16-jolsa@kernel.org>
In-Reply-To: <20241010200957.2750179-16-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 10 Oct 2024 19:30:19 -0700
Message-ID: <CAEf4BzY5zgoYAgJG7tfa84F2Zzjq=YFjh3=OzWqA6h39FfXB4Q@mail.gmail.com>
Subject: Re: [PATCHv6 bpf-next 15/16] selftests/bpf: Add uprobe sessions to
 consumer test
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 1:13=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding uprobe session consumers to the consumer test,
> so we get the session into the test mix.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../bpf/prog_tests/uprobe_multi_test.c        | 63 +++++++++++++++----
>  .../bpf/progs/uprobe_multi_consumers.c        | 16 ++++-
>  2 files changed, 66 insertions(+), 13 deletions(-)
>

you are undoing most of the changes done in the previous patch... it
seems like it would be better to just combine  both patches

> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b=
/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> index 2effe4d693b4..df9314309bc3 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> @@ -761,6 +761,10 @@ get_program(struct uprobe_multi_consumers *skel, int=
 prog)
>                 return skel->progs.uprobe_0;
>         case 1:
>                 return skel->progs.uprobe_1;
> +       case 2:
> +               return skel->progs.uprobe_2;
> +       case 3:
> +               return skel->progs.uprobe_3;
>         default:
>                 ASSERT_FAIL("get_program");
>                 return NULL;

[...]

