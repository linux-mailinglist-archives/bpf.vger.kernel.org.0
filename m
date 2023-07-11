Return-Path: <bpf+bounces-4748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B7F74E9D9
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 11:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C91B280F55
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 09:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2448C17752;
	Tue, 11 Jul 2023 09:07:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E499C17738
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 09:07:25 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091E193
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 02:07:24 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51e526e0fe4so3948680a12.3
        for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 02:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689066442; x=1691658442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yUZUJ6S3GFGsGsi9SsNVIKj5ZwOUg0Wh4Bdxeu03r9k=;
        b=r3yClfQRePZdoA2THWQryVnS3oNv7Dq3xhkpcuR8NELBzXK1uQs8SoAhEfXoaaHVUc
         q1wVdV4i4OfsvMN1psWFAoHKBzvDZzYjbeQfCkHNRMOseqVIyL6iIvujlcHR2+eb6217
         g0b7YBZV/2/uS4438FPmiNL4eLJAN+dHk2w8gv2d9M/LlxdOuOEfso6THwvowdWeBpIX
         xDlCOMXScaXOWSoKmasQ1l1EFbXhSfKiad+zdmWJ117GHeqB+KbM3iozWyANnUUmrPAW
         Whf4Yg+64TviI01vQ719HIlNipLWFyQTI/9TE8nAx+5yP8Z/JaMEFEaD3slxxuX107+B
         17gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689066442; x=1691658442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUZUJ6S3GFGsGsi9SsNVIKj5ZwOUg0Wh4Bdxeu03r9k=;
        b=HRKIywc9lsGjshHXCxm3sb3p7BgvRCwtvYmliA68rU+yNu0Es4Q0jDIGO3mv8u+vpe
         F0duw5XbRTBd6GPxSLOXt332RWT1TU8MWBBT3MGsFLHTNPJAf0bvdFaQ6qDqBg6y4aio
         Z1lD5ocE/7AireVCd8ajSPEMIdwVZpeM8L8T0ke7aFpSX++C2PrGK6PT4ascgbcHIa4p
         j2qYUSFJe8Gb6jRRJ1XwzuxU4CjLtozpEDh4dSd2EZh4xxqBC12v1q50M4xHw0J/6CeZ
         r7VOp9L4zTx7MinFITwvFNJ5559ONFv4dh8RZGb+B7pmPwR5viIJwKe6baNTh3iNDGue
         iWtA==
X-Gm-Message-State: ABy/qLY4+Gw3R/lRkif0cGelc3jC9XENepgDvNyPaaC5Hn0dWAkEyOC2
	J6TKEGdMmkX+vatDaQbqOt/PDEg0A7+mJw==
X-Google-Smtp-Source: APBJJlEyDp3j9vnOYxmBYNuiEfT6/Ig7qfJF3ICZDnFBMFOWEOQRdT36vfbK54AnmS/VIBWZ1OFHFQ==
X-Received: by 2002:aa7:d741:0:b0:51d:f37c:e3b8 with SMTP id a1-20020aa7d741000000b0051df37ce3b8mr15207311eds.13.1689066442084;
        Tue, 11 Jul 2023 02:07:22 -0700 (PDT)
Received: from krava (net-109-116-206-239.cust.vodafonedsl.it. [109.116.206.239])
        by smtp.gmail.com with ESMTPSA id b1-20020a05640202c100b0051beb873d98sm942288edx.27.2023.07.11.02.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 02:07:21 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 11 Jul 2023 11:07:18 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv3 bpf-next 23/26] selftests/bpf: Add usdt_multi bench test
Message-ID: <ZK0bxo+eppeUE1zK@krava>
References: <20230630083344.984305-1-jolsa@kernel.org>
 <20230630083344.984305-24-jolsa@kernel.org>
 <CAEf4BzYgeoUfwqtnk_FWUo7-=ughWstWy8DDMjQi4sohvmU1Qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYgeoUfwqtnk_FWUo7-=ughWstWy8DDMjQi4sohvmU1Qg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 06, 2023 at 09:42:05PM -0700, Andrii Nakryiko wrote:

SNIP

> > +static void test_bench_attach_usdt(void)
> > +{
> > +       struct uprobe_multi_usdt *skel = NULL;
> > +       long attach_start_ns, attach_end_ns;
> > +       long detach_start_ns, detach_end_ns;
> > +       double attach_delta, detach_delta;
> > +       struct bpf_program *prog;
> > +       int err;
> > +
> > +       skel = uprobe_multi_usdt__open();
> > +       if (!ASSERT_OK_PTR(skel, "uprobe_multi__open"))
> > +               goto cleanup;
> > +
> > +       bpf_object__for_each_program(prog, skel->obj)
> > +               bpf_program__set_autoload(prog, false);
> > +
> > +       bpf_program__set_autoload(skel->progs.usdt0, true);
> 
> there is nothing else in that skeleton, why this set_autoload() business?

nah copy&paste error from the uprobe bench test.. will change ;-)

jirka

SNIP

