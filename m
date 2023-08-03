Return-Path: <bpf+bounces-6871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A07D76EC85
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 16:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C76B7281A38
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 14:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A08723BC9;
	Thu,  3 Aug 2023 14:29:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F3C200CA
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 14:29:17 +0000 (UTC)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017B5A3
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 07:29:16 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-4085ee5b1e6so10147881cf.0
        for <bpf@vger.kernel.org>; Thu, 03 Aug 2023 07:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691072955; x=1691677755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4nL5fsCwChc4VHZsLb9ZueRVBeOfHqWLm2bJd9iO6s=;
        b=XZn8unxYrDJx7gUgFODQ72L6PHAZfKZ5mPnWfCfn08QVxeEx1iqgqZyDTRzsdQ0zUK
         /FLZXhcVqVLc3P29bCFB84NvuJb+0/W4w60ZaXRCm4TbfB5nmvhJHREU93gEDMF8JwcZ
         LIUHwp+pTJfakdKah/3jvN8YoyDsB8E5nNp2mIul7xMsVOtSjpKtnyoXlW/LD8EvYNNL
         Qj7ezZkOAAmdn0blqSeK5DLHKrx47ImBCFCP/2w3p/HaqN0mmlBSOUB0fauL+MVkt97C
         xEsVOdawvr2ZMZphFUP+YqCi4DswTbN+P5x7Q7yBrj6Ex4lvamkLgxiFovLaBKbgtnvo
         nXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691072955; x=1691677755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R4nL5fsCwChc4VHZsLb9ZueRVBeOfHqWLm2bJd9iO6s=;
        b=cb/q2T3T6zogGSsHvuAiswYDU7eEnh/yUUZsu6h4kOgwy9SZNIZHbTBIOwL0KuR0HH
         8C4xU9x4cd0uSd6eC8SxKSigudoNpXx2CRxnexdLy/9ynI0aCUUMuMcpXnIggZX8LiYK
         f6a/sTCG2QgzHKXfhDg2eu1dGG8lZYedB9z4Oh+gtzLf/dbx9avbZRp2allJxo5r3if3
         UVQrO2Z5Y/txtmsURT9pGkgX+hshXP5wjrP9tDPswhSv3emDWD5ZNy3Q9dA/aGPbfYnQ
         TDtrilANFjecxgxdFOzN5/dUuQtMqWzJ/1UMXUuzsTBM+FdeZ+Ax5MbebiEXfIOSOCdo
         f2eg==
X-Gm-Message-State: ABy/qLarsuouuunAp2zCYq3YpUKzdv+SJltvRKSH69+UrsFOxEu4Mm7E
	TY/R/9q0lTMvE2xJe8vLzxg0YgnQHR/4vvVBGNPAAUQ7l/A=
X-Google-Smtp-Source: APBJJlFtLDQPp62dpGFwPA9grRQxFnw0GUdnCW++47N1b2Q0PaMcaZTn7Z82Ke4FRPePhNYMEpKNuUxM+j5T9yLapIg=
X-Received: by 2002:ad4:4eaa:0:b0:63c:f325:bb03 with SMTP id
 ed10-20020ad44eaa000000b0063cf325bb03mr25981480qvb.8.1691072955055; Thu, 03
 Aug 2023 07:29:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230731111313.3745-1-laoar.shao@gmail.com> <20230731111313.3745-3-laoar.shao@gmail.com>
 <CAADnVQJZNdr5Wg3xFsNqZEjkguiB7T9hLcmnf-rsPR-Cq2njTw@mail.gmail.com>
In-Reply-To: <CAADnVQJZNdr5Wg3xFsNqZEjkguiB7T9hLcmnf-rsPR-Cq2njTw@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 3 Aug 2023 22:28:39 +0800
Message-ID: <CALOAHbA5ymZBqLy1OUT6viiBkV41y1EnnhySimyKWEwqD196ig@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/2] selftests/bpf: Add selftest for fill_link_info
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 3, 2023 at 4:57=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jul 31, 2023 at 4:13=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > Add selftest for the fill_link_info of uprobe, kprobe and tracepoint.
> > The result:
> >
> >   $ tools/testing/selftests/bpf/test_progs --name=3Dfill_link_info
> >   #79/1    fill_link_info/kprobe_link_info:OK
> >   #79/2    fill_link_info/kretprobe_link_info:OK
> >   #79/3    fill_link_info/kprobe_fill_invalid_user_buff:OK
> >   #79/4    fill_link_info/tracepoint_link_info:OK
> >   #79/5    fill_link_info/uprobe_link_info:OK
> >   #79/6    fill_link_info/uretprobe_link_info:OK
> >   #79/7    fill_link_info/kprobe_multi_link_info:OK
> >   #79/8    fill_link_info/kretprobe_multi_link_info:OK
> >   #79/9    fill_link_info/kprobe_multi_ubuff:OK
> >   #79      fill_link_info:OK
> >   Summary: 1/9 PASSED, 0 SKIPPED, 0 FAILED
> >
> > The test case for kprobe_multi won't be run on aarch64, as it is not
> > supported.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/DENYLIST.aarch64       |   3 +
> >  .../selftests/bpf/prog_tests/fill_link_info.c      | 369 +++++++++++++=
++++++++
> >  .../selftests/bpf/progs/test_fill_link_info.c      |  42 +++
> >  3 files changed, 414 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/fill_link_in=
fo.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_fill_link_in=
fo.c
> >
> > diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testi=
ng/selftests/bpf/DENYLIST.aarch64
> > index 3b61e8b..b2f46b6 100644
> > --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
> > +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
> > @@ -12,3 +12,6 @@ kprobe_multi_test/skel_api                       # li=
bbpf: failed to load BPF sk
> >  module_attach                                    # prog 'kprobe_multi'=
: failed to auto-attach: -95
> >  fentry_test/fentry_many_args                     # fentry_many_args:FA=
IL:fentry_many_args_attach unexpected error: -524
> >  fexit_test/fexit_many_args                       # fexit_many_args:FAI=
L:fexit_many_args_attach unexpected error: -524
> > +fill_link_info/kprobe_multi_link_info            # bpf_program__attach=
_kprobe_multi_opts unexpected error: -95
> > +fill_link_info/kretprobe_multi_link_info         # bpf_program__attach=
_kprobe_multi_opts unexpected error: -95
> > +fill_link_info/kprobe_multi_ubuff                # bpf_program__attach=
_kprobe_multi_opts unexpected error: -95
>
>
> BPF CI isn't happy, because s390 also needs to be updated?

I thought it was caused by other issues. The s390 server may not be so stab=
le.
kprobe_multi is supported by s390. Before sending this series, I have
verified the BPF CI on github, and it can run successfully on s390 :
https://github.com/kernel-patches/bpf/actions/runs/5711429876/job/154732516=
77#step:6:4972

> We'll just mark patches as 'changes requested' next time without
> explicit emails.


--=20
Regards
Yafang

