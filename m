Return-Path: <bpf+bounces-7671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 555CA77A4D2
	for <lists+bpf@lfdr.de>; Sun, 13 Aug 2023 05:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 880FC280F54
	for <lists+bpf@lfdr.de>; Sun, 13 Aug 2023 03:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4B01386;
	Sun, 13 Aug 2023 03:15:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456FC110A
	for <bpf@vger.kernel.org>; Sun, 13 Aug 2023 03:15:28 +0000 (UTC)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5732DE8
	for <bpf@vger.kernel.org>; Sat, 12 Aug 2023 20:15:14 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-641897222f6so15359016d6.0
        for <bpf@vger.kernel.org>; Sat, 12 Aug 2023 20:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691896513; x=1692501313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x34r1GU/LzR0KC0QeUb0ffpzGZ6NXDXV0VC6qkaTMDk=;
        b=KX2oPHQptZrJx7qpv/IQ59dwc+lOvnasxZFwJXewVfobnG4vrLh5/qWZLFoXJxZIkH
         MCbfAEegnq3NiQ/Bw31+FAOpdroLpNeo0qWTdFbqx7mvLrf0ixcUjPnqxXjXqsHxx/V4
         gNJT3WEiuzVM7K4CdCEC3eO1V+JMvKekt/L26ur853v8/34C4i3dEza/xHBo0dzRnJ1l
         dYjvuuaFm6Vwct1R+Jdk8L9mhjLkmkcHVIDKqC9pGYW0eY6MP38uoOxtnPN8UUiLJ2tn
         EULS30z9/IQ6keizb5L2lmC0+KzuB6EVS1uM5vZmynjDrgqnnUPA26tBZoQmo4wQ3IDE
         ESwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691896513; x=1692501313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x34r1GU/LzR0KC0QeUb0ffpzGZ6NXDXV0VC6qkaTMDk=;
        b=N5GaiEXtuiOE8uScNcAcNW4MCPVNPz0fjWIScGmC54SRlh/Q+4dqs/kZuQixoZ1JcQ
         JQlhNyPD+U7svZSkb5ITj4CeZrKqWpYgmwmr2eTaePpBFzGinmQbAjtWlEFID4HyaEN8
         Ulm9PmPmsSmWXCHhxDwg2bAhCw1S6EtJyKvwtU0bTFsfvQFLM21eL3rYcIIF+Yud9nBQ
         Tu9IFctS+vVmu5VbYTBWYE26MnPRYHFWjJd/J+eGkNgxB2AoWShyDuTuk1tIIapUSJnx
         LsgQ5ckxPJ/E2rZFUCVgO8wcOc1tibljLMNy8lAKMoBs4VGxj3bIWf3LR15cTs74kSj6
         xTKg==
X-Gm-Message-State: AOJu0Yx23aH+vrZUz6H/j0BTcYmEqwwpq/xQjEAM0MsswZKGD0zc/qJy
	q6gZF6SW5Ay8eSylF6m/A+N5eeMnz9voGzlIsvU=
X-Google-Smtp-Source: AGHT+IGXtSByXQkpzTwRxoF1bqbkP8t/ou1UrPXEN1sEpg6JP/MgisMns3VN6Yo2L/c240b5qNpG5BsE31JgmgrKvYk=
X-Received: by 2002:a0c:f4d1:0:b0:63d:4813:6a74 with SMTP id
 o17-20020a0cf4d1000000b0063d48136a74mr5766832qvm.45.1691896513432; Sat, 12
 Aug 2023 20:15:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230811023647.3711-1-laoar.shao@gmail.com> <20230811023647.3711-3-laoar.shao@gmail.com>
 <ZNaU9rE6NH9T+O39@krava>
In-Reply-To: <ZNaU9rE6NH9T+O39@krava>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 13 Aug 2023 11:14:37 +0800
Message-ID: <CALOAHbDc+7QW8cq47gtf8HSERigOJQy9K-t19a+g7V7p2cuvMg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/2] selftests/bpf: Add selftest for fill_link_info
To: Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 12, 2023 at 4:07=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Fri, Aug 11, 2023 at 02:36:47AM +0000, Yafang Shao wrote:
>
> SNIP
>
> > +void test_fill_link_info(void)
> > +{
> > +     struct test_fill_link_info *skel;
> > +     int i;
> > +
> > +     skel =3D test_fill_link_info__open_and_load();
> > +     if (!ASSERT_OK_PTR(skel, "skel_open"))
> > +             return;
> > +
> > +     /* load kallsyms to compare the addr */
> > +     if (!ASSERT_OK(load_kallsyms_refresh(), "load_kallsyms_refresh"))
> > +             goto cleanup;
> > +
> > +     kprobe_addr =3D ksym_get_addr(KPROBE_FUNC);
> > +     if (test__start_subtest("kprobe_link_info"))
> > +             test_kprobe_fill_link_info(skel, BPF_PERF_EVENT_KPROBE, f=
alse);
> > +     if (test__start_subtest("kretprobe_link_info"))
> > +             test_kprobe_fill_link_info(skel, BPF_PERF_EVENT_KRETPROBE=
, false);
> > +     if (test__start_subtest("kprobe_invalid_ubuff"))
> > +             test_kprobe_fill_link_info(skel, BPF_PERF_EVENT_KPROBE, t=
rue);
> > +     if (test__start_subtest("tracepoint_link_info"))
> > +             test_tp_fill_link_info(skel);
> > +
> > +     uprobe_offset =3D get_uprobe_offset(&uprobe_func);
> > +     if (test__start_subtest("uprobe_link_info"))
> > +             test_uprobe_fill_link_info(skel, BPF_PERF_EVENT_UPROBE);
> > +     if (test__start_subtest("uretprobe_link_info"))
> > +             test_uprobe_fill_link_info(skel, BPF_PERF_EVENT_URETPROBE=
);
> > +
> > +     qsort(kmulti_syms, KMULTI_CNT, sizeof(kmulti_syms[0]), symbols_cm=
p_r);
>
> hum, what's the reason for sorting the symbols?

Kernel will sort the kprobe_multi symbols, and then store the
corresponding addresses in the same order into kmulti_link->addr. In
order to compare the addresses, we should sort them and then get the
addresses.

>
> other than that it looks good to me
>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
>
> jirka
>
> > +     for (i =3D 0; i < KMULTI_CNT; i++)
> > +             kmulti_addrs[i] =3D ksym_get_addr(kmulti_syms[i]);
> > +     if (test__start_subtest("kprobe_multi_link_info"))
> > +             test_kprobe_multi_fill_link_info(skel, false, false);
> > +     if (test__start_subtest("kretprobe_multi_link_info"))
> > +             test_kprobe_multi_fill_link_info(skel, true, false);
> > +     if (test__start_subtest("kprobe_multi_invalid_ubuff"))
> > +             test_kprobe_multi_fill_link_info(skel, true, true);
> > +
> > +cleanup:
> > +     test_fill_link_info__destroy(skel);
> > +}
>
> SNIP



--=20
Regards
Yafang

