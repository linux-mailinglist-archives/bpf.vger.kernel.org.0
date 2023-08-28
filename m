Return-Path: <bpf+bounces-8862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BAA78B67F
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 19:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE95280EAB
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 17:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546C913AF6;
	Mon, 28 Aug 2023 17:32:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C21A12B87
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 17:32:19 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EC6E1
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 10:32:18 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50078eba7afso5505462e87.0
        for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 10:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693243936; x=1693848736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tb1yoWbmBUWX9cWLnrgLX31IDmfBgz0Z+KBgou32oo=;
        b=eMIUpi+Au69gdeBN9EtJrJhGofsJjVsc+ALfGhYYMxMrLerZM8/UyPTSmQ++BqNgys
         mfH0eoDx2zgiCsXuwQMua70EwhfmkAN5AfjnSGGFXFk9cIR4xjHhW/AFjiGCeiL4wyav
         bqefCUqXR5EVoO+f1df+w0I5IbmXuzgdyozdOj+FQ2AF0nkuVsen0Zt8K3KZoNjdQj05
         sNhBGO1F79gctRbhuVOIWqBpUkwLKWBI51x7VNyndZGg4etZf4EuKKR4/xwKX9s/todr
         ujTLW1ugCJtltPJYOWrO8TL4izV66TTwypF48Ksg8qr+SbFoHowP5MkrQRedoOfFXB80
         3UEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693243936; x=1693848736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4tb1yoWbmBUWX9cWLnrgLX31IDmfBgz0Z+KBgou32oo=;
        b=OLXFGeCQLHeTr8bi6P6QYRZCvO1pceMGuYBVkisVXjFSCZtj7tgVKPcgEujG89KaKP
         ZMtm8EyLn4hSbSj9ZgkaFzBFsIaRmJH0oGs2BbqLbmktB3947GWkYTTrAv81ReJRPyXB
         M/HwB5iQ2/eiQIIj6Y80xfOPzfquokrsXtcxmbxE90ZKmf7NKQqBvi5WjtOdp7FsgxlZ
         sfb4l9CodyADoy/UBir2FCKO2d0wfhTFjFnj3OdqMYl6kExs+MSRyMtXdVrZ42+UXgpK
         m7VpGHfq8xZ0DPM7KTivj13xphOhn5apgoVqFv70cqGDJWwUIZfv67p926ku9DXqpEoZ
         mQpQ==
X-Gm-Message-State: AOJu0Yxc8AZJPzVLc+SPAphGApe4iPdXp6q84RtrSD5Ukho+/kYjYTFW
	fCKM9wzz5Qk00guMmAVC8YxglVKXcGc3LaV4JQg=
X-Google-Smtp-Source: AGHT+IHAQsIGE5aFVZGJGrNfNojic0lWt8SlfRboQIR5Zk9hA/Hp0mPZvFddF6RRGKquZlPV97MjhWMRjRUXV6kmAc8=
X-Received: by 2002:a2e:b164:0:b0:2bb:bfa5:b72c with SMTP id
 a4-20020a2eb164000000b002bbbfa5b72cmr18826599ljm.15.1693243936211; Mon, 28
 Aug 2023 10:32:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230828075537.194192-1-jolsa@kernel.org> <20230828075537.194192-7-jolsa@kernel.org>
In-Reply-To: <20230828075537.194192-7-jolsa@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 28 Aug 2023 10:32:05 -0700
Message-ID: <CAADnVQJgGvsmr4Sug+ZWa68i9p4xLkW4OS8n4Afk3sZSdd0F5A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 06/12] bpf: Count missed stats in trace_call_bpf
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Hou Tao <houtao1@huawei.com>, 
	Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 28, 2023 at 12:56=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote=
:
>
> Increase misses stats in case bpf array execution is skipped
> because of recursion check in trace_call_bpf.
>
> Adding bpf_prog_missed_array that increase misses counts for
> all bpf programs in bpf_prog_array.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/bpf.h      | 16 ++++++++++++++++
>  kernel/trace/bpf_trace.c |  3 +++
>  2 files changed, 19 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 23a73f52c7bc..71154e991730 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2932,6 +2932,22 @@ static inline int sock_map_bpf_prog_query(const un=
ion bpf_attr *attr,
>  #endif /* CONFIG_BPF_SYSCALL */
>  #endif /* CONFIG_NET && CONFIG_BPF_SYSCALL */
>
> +static __always_inline void
> +bpf_prog_missed_array(const struct bpf_prog_array *array)

The name hardly explains the purpose.
Please give it a better name.
Maybe bpf_prog_inc_misses_counters ?
Just extra "s".

