Return-Path: <bpf+bounces-302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFCE6FE2F6
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 19:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E2D8281570
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 17:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52635171AC;
	Wed, 10 May 2023 17:03:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D3B8C0F
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 17:03:16 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42F25FCA
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 10:02:53 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1ab0c697c84so57580805ad.3
        for <bpf@vger.kernel.org>; Wed, 10 May 2023 10:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683738173; x=1686330173;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n8aWkDUgATggTfnBR/pAYGkp/ZYTVfPZyaKMihMg+7I=;
        b=IhBrtUWjqA1wH54EuiofrqcakhWviBga1+o6F70aOaYlY9kV79rauCU0W9HN57a0Pq
         2hJzwlYO/GReTKcWdfI62o/eJGY8VoVZCNuGE52AxqBhNX0scg3ocCnht9bhA8BNJV8p
         EVuWrKhtRLwm+oOPMH+Aw5arlJSXOQWJVE4alwx6OtQm/EbZH7KUqNb2Idxgzgfh8EXw
         4HDqnyHVFc2x6hKlE9fZcbr24JpUgyirdSMvD/uPQUK53Czj01c5ubmGYV4den8slivV
         iwlxlux/VWd+cMJCC5WYLjd2cgnK+ws1M2vQnMEK7ThRhBAxKhKSKWb9GKrmyk/9W+JU
         UFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683738173; x=1686330173;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n8aWkDUgATggTfnBR/pAYGkp/ZYTVfPZyaKMihMg+7I=;
        b=P4rKs40q4Q/0WZ7DyhBRX4LfwbOVSfaPF1soV1KDoVIY/OuxmhEeu1l6XYLZbDc9sR
         v/vzIUJ5IYkpnr01TeRchXyiHWIbvLV3QWa7hHAo3hkB0IsyJGg1nM6qydJAvmbe0mBG
         1CxaAsr0d92gh0i0be66J5l0vwzbWzFg4m1MHuTSIOU5+tT/H0OOBmDD5J+K+OpLGXuZ
         Ip417iDRDO51FZxZ21TOxu6R84leTLUVXjhgQSlJq8ABmIlV1k4axi9s+bDLKZQufL+1
         oqDMERrX8aqkiqLc444gdo7v0XP0WFJ8afa2MdJoZFyosnZRxqqj6kZebg31WccGJnG3
         j1lg==
X-Gm-Message-State: AC+VfDz5MXlXj5G4sI1rToCVbTZMtX953BIatVMSb28iz+tyts7rB+Fi
	J59ujP0MiNPtDDvvfR9DvgovaTZt7gdujg==
X-Google-Smtp-Source: ACHHUZ5P3TmSdZKra+6l9NHT4OTo4+oEHS9f8tm2C935yzVAfpKBmRRV2/Jo71a6rI9DLx1TVVH2KA==
X-Received: by 2002:a17:902:a5cc:b0:1ac:8ff7:a4 with SMTP id t12-20020a170902a5cc00b001ac8ff700a4mr7275666plq.4.1683738172824;
        Wed, 10 May 2023 10:02:52 -0700 (PDT)
Received: from krava ([2001:4958:15a0:30:84fc:2d48:aeac:9034])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902aa8200b00199193e5ea1sm4025120plr.61.2023.05.10.10.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 10:02:52 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 10 May 2023 10:02:50 -0700
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Song Liu <song@kernel.org>, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/2] bpf: Show total linked progs cnt instead of
 selector in trampoline ksym
Message-ID: <ZFvOOlrmHiY9AgXE@krava>
References: <20230509151511.3937-1-laoar.shao@gmail.com>
 <20230509151511.3937-3-laoar.shao@gmail.com>
 <CAPhsuW6qXXgGkp1DVvHEQCVHvM=yw8nFFhA8LLHgCazwyaoXhA@mail.gmail.com>
 <CALOAHbCZfCbGP-gaVKnG_9HGkbVnArCn+EcqweGtA8+wRmJDvQ@mail.gmail.com>
 <CAPhsuW55iK4i_dYsbszkqAdDz4gpwgWU4LATw3Tzj9O63GfOmA@mail.gmail.com>
 <CALOAHbAKEU7Q1LySsotjJ9yPD3E4rSjvXg2ToM=F34dR_2oBmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbAKEU7Q1LySsotjJ9yPD3E4rSjvXg2ToM=F34dR_2oBmg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 10, 2023 at 11:33:21PM +0800, Yafang Shao wrote:
> On Wed, May 10, 2023 at 2:30 PM Song Liu <song@kernel.org> wrote:
> >
> > On Tue, May 9, 2023 at 7:56 PM Yafang Shao <laoar.shao@gmail.com> wrote:
> > >
> > > On Wed, May 10, 2023 at 1:43 AM Song Liu <song@kernel.org> wrote:
> > > >
> > > > On Tue, May 9, 2023 at 8:15 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> > > > >
> > > > > After commit e21aa341785c ("bpf: Fix fexit trampoline."), the selector
> > > > > is only used to indicate how many times the bpf trampoline image are
> > > > > updated and been displayed in the trampoline ksym name. After the
> > > > > trampoline is freed, the count will start from 0 again.
> > > > > So the count is a useless value to the user, we'd better
> > > > > show a more meaningful value like how many progs are linked to this
> > > > > trampoline. After that change, the selector can be removed eventally.
> > > > > If the user want to check whether the bpf trampoline image has been updated
> > > > > or not, the user can also compare the address. Each time the trampoline
> > > > > image is updated, the address will change consequently.
> > > >
> > > > I wonder whether this will cause confusion to some users. Maybe the saving
> > > > doesn't worth the churn.
> > >
> > > The trampoline ksym name as such:
> > > ffffffffc06c3000 t bpf_trampoline_6442453466_1  [bpf]
> > >
> > > I don't know what the user may use the selector for. It seems that the
> > > selector is meaningless. While the cnt of linked progs can really help
> > > users, with which the user can easily figure out how many progs are
> > > linked to a kernel function.
> >
> > Hmm, agreed that the chance to break user space is low. Maybe we can just
> > remove it? IOW, only keep bpf_trampoline_6442453466
> >
> 
> Agree. I will do it as you suggested.

perf is actually is still trying parse the old name

        /* .. and only for trampolines and dispatchers */
        if ((sscanf(name, "bpf_trampoline_%lu", &id) == 1) ||
            (sscanf(name, "bpf_dispatcher_%s", disp) == 1))
                err = process_bpf_image(name, start, data);

so this change would actualy fix it ;-)

thanks,
jirka

