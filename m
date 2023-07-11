Return-Path: <bpf+bounces-4746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5063F74E9D4
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 11:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88BDC1C20CC4
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 09:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF511774E;
	Tue, 11 Jul 2023 09:06:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076F117723
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 09:06:47 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CF093
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 02:06:46 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51e29ede885so6814757a12.3
        for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 02:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689066405; x=1691658405;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uzUpNagH054bao3jMe6zuB7Vr85Hqb1J2VS/teZFWkA=;
        b=Ys4xXQjOF98VpSFeBEloLXYiHJn8YhbO2gjF+vJ4MKCMsAKRKv4zlMU1WGq+hSogyB
         dnXLUwOEb5AEQYzzg+90Qg3IqZUBMllIw9cUqysxR4XuCONVa5CQbU6oXiMD+q5iFmWr
         qaZ/HfUAVe8DYhMgIP+7xQmQKqC3I5KZRLxN74QDIxpsYtBRyyabElVRpNd/nWSodEcu
         I3o+QhI89PNFg2SErRPOB+jpNjqFoaeMstwFweezsPcQXs1EUag/FgdXUXIE66FYBuIt
         D08YRYtTNq1lX+XobiDYdEMGkm81ox6Dws+CPHjtewOvBeWzarJzlKnWsLeS8exXxoXI
         d7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689066405; x=1691658405;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uzUpNagH054bao3jMe6zuB7Vr85Hqb1J2VS/teZFWkA=;
        b=Q46I6//4CTgEu8PmfJZBAvf2EUgSSHF9YqMYqaQyLB8HJ8cDVTza2aKjl6z4XCTfyR
         zVjiao9zs3D2J6pBMvJ223vQrGWb2pR+EhLm02rgt22AyqlEHQ3dQx1u5KBvhjIKEamq
         UPDpeHIK1Z3O04/dBy42XAyFmstVCmX/Tbzb0D3Z18g31lFQy+j5eF44HLkRyhxtXmLF
         X7MNibYlUD/pcEBFykIkHqg/TImPbXk0cIriici9rXD+/mlxkWIUdFkSYsDjJZ1b9i39
         fv2+UrWE5sQuXywohYNXvPTyenIjB0M+bZtxl9wr07H5oWjP99xZ5bV2XJ+/huBTjLw1
         QXCA==
X-Gm-Message-State: ABy/qLa+EQubCbuPN0gqN53VM8BOuVyH8/885utSPGEVJQkk20Ap+g/J
	IyGqyTLf7Wk6sq3pqWDld4CVgOx5/Ut4cQ==
X-Google-Smtp-Source: APBJJlGOhn+OCIyR+rFA8BtgeyWHyi4jY5taToQ2cR4DtREgLHZHMlFfbHfhwoEazuv0fS72nziOVQ==
X-Received: by 2002:aa7:d1c8:0:b0:51e:1b80:2f46 with SMTP id g8-20020aa7d1c8000000b0051e1b802f46mr11779503edp.15.1689066405039;
        Tue, 11 Jul 2023 02:06:45 -0700 (PDT)
Received: from krava (net-109-116-206-239.cust.vodafonedsl.it. [109.116.206.239])
        by smtp.gmail.com with ESMTPSA id m18-20020aa7d352000000b0051a4fcf7187sm932211edr.62.2023.07.11.02.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 02:06:44 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 11 Jul 2023 11:06:41 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv3 bpf-next 19/26] selftests/bpf: Add uprobe_multi link
 test
Message-ID: <ZK0boQS0DZhXgFIX@krava>
References: <20230630083344.984305-1-jolsa@kernel.org>
 <20230630083344.984305-20-jolsa@kernel.org>
 <CAEf4Bzbgvt3aCZmx2zTn4tFuHmc6AgfN1=uSdriBb8bnCzyb3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzbgvt3aCZmx2zTn4tFuHmc6AgfN1=uSdriBb8bnCzyb3g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 06, 2023 at 09:33:40PM -0700, Andrii Nakryiko wrote:
> On Fri, Jun 30, 2023 at 1:37 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding uprobe_multi test for bpf_link_create attach function.
> >
> > Testing attachment using the struct bpf_link_create_opts.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../bpf/prog_tests/uprobe_multi_test.c        | 68 +++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> >
> 
> [...]
> 
> > +       opts.kprobe_multi.flags = BPF_F_UPROBE_MULTI_RETURN;
> > +       prog_fd = bpf_program__fd(skel->progs.test_uretprobe);
> > +       link2_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
> > +       if (!ASSERT_GE(link2_fd, 0, "link2_fd"))
> > +               goto cleanup;
> > +
> > +       opts.kprobe_multi.flags = 0;
> > +       prog_fd = bpf_program__fd(skel->progs.test_uprobe_sleep);
> > +       link3_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
> > +       if (!ASSERT_GE(link1_fd, 0, "link3_fd"))
> 
> link3_fd
> 
> > +               goto cleanup;
> > +
> > +       opts.kprobe_multi.flags = BPF_F_UPROBE_MULTI_RETURN;
> > +       prog_fd = bpf_program__fd(skel->progs.test_uretprobe_sleep);
> > +       link4_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
> > +       if (!ASSERT_GE(link2_fd, 0, "link4_fd"))
> 
> link4_fd

right, will change

thanks,
jirka

> 
> > +               goto cleanup;
> > +       uprobe_multi_test_run(skel);
> > +
> > +cleanup:
> > +       if (link1_fd >= 0)
> > +               close(link1_fd);
> > +       if (link2_fd >= 0)
> > +               close(link2_fd);
> > +       if (link3_fd >= 0)
> > +               close(link3_fd);
> > +       if (link4_fd >= 0)
> > +               close(link4_fd);
> > +
> > +       uprobe_multi__destroy(skel);
> > +       free(offsets);
> > +}
> > +
> >  void test_uprobe_multi_test(void)
> >  {
> >         if (test__start_subtest("skel_api"))
> > @@ -144,4 +210,6 @@ void test_uprobe_multi_test(void)
> >                 test_attach_api_pattern();
> >         if (test__start_subtest("attach_api_syms"))
> >                 test_attach_api_syms();
> > +       if (test__start_subtest("link_api"))
> > +               test_link_api();
> >  }
> > --
> > 2.41.0
> >

