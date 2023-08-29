Return-Path: <bpf+bounces-8887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8096378BFDB
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 10:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64C741C20911
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 08:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7286AA5;
	Tue, 29 Aug 2023 08:04:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B053063D7
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 08:04:09 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7A3BE
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 01:04:08 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so61625291fa.3
        for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 01:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693296246; x=1693901046;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x+Xy5u/abU5fIybPgpWygiWKfp/E61rxjN9tn1Y4doc=;
        b=m406M+EmPZ6i4o+3PGQhUJ3cqSW7UjXlLwfWouDNKdpVCoMzKWkcVrP8d0n6/cPF3m
         uTJnpyzzLBNIxrqrSBERL8e65J+bL70chXGqDS23aL6MduQQQ0OQbntYj9sre00zw6su
         WU1VEOaNdLgQO7Asu4dCE6X2ccYGwb0t3LCgHb/KxTHBRSANTN8m8qfQXxBCXwsLxWi7
         fVJ+3X/RQxkraewShgcxnY+nXS69Kd5bceRpg8gyg9cDF5vy+Tr6umD2faKkoPYzpjwK
         2GOEpP07C6X60WXTdMzLFWJww9yGSfxNdoUFCg+9uJ1sHSmD67uuMwZDUePcUZpEeAy0
         Gs1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693296246; x=1693901046;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x+Xy5u/abU5fIybPgpWygiWKfp/E61rxjN9tn1Y4doc=;
        b=WMUe6ZlucoECLZU167W7mCKA/lfNvuqRokyD+ax0ZTmdvXJKMoIwVZctOYO1QeycNs
         GrQNtGjfbZ1DZWZ9yUTUvBZ0oJ4wpcHnPXFffGJ5NRv90yflTsrK2XFr5cMCOh25+1Xm
         QdPCUYwGsoYzJCIXDIMeBkv8CJIhjdfeCH2A+wt6EF2c8/eJQYxYzDHhC6Wzn1C/Wpq7
         zuF0Hxcy+aqO8VolqG89UIGGvV+zy2Aic+xtg4UZIxg03C0kbuG9mSaqRFDqLSFubqnV
         9tB5GubhTptmP2bL4drgbppCUdNZTw9rv5Flp50cVYfOfcyQcfA1TKvVZV12v16lprTT
         mrHQ==
X-Gm-Message-State: AOJu0Ywzz1G5HYFfGzPE69JytOR8hGiEFo5n+XsqC9TgLdWNKo/Q72CM
	hfv+CdypA5sZCj4hx8Guv5Wz1QAx44j1Gw==
X-Google-Smtp-Source: AGHT+IExlcMjitnSV17+pdB9eGKdmwDrZdpOHDYEw7Kl2XqbOUwQShcmJSK1sxQq57TIn6XgWarp0g==
X-Received: by 2002:a2e:9f44:0:b0:2bc:cdcf:d888 with SMTP id v4-20020a2e9f44000000b002bccdcfd888mr14347778ljk.46.1693296246095;
        Tue, 29 Aug 2023 01:04:06 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id b22-20020a170906039600b0099c53c4407dsm5653360eja.78.2023.08.29.01.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 01:04:05 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 29 Aug 2023 10:04:03 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Hou Tao <houtao1@huawei.com>, Daniel Xu <dxu@dxuuu.xyz>
Subject: Re: [PATCH bpf-next 06/12] bpf: Count missed stats in trace_call_bpf
Message-ID: <ZO2mc/VOzjFAphG3@krava>
References: <20230828075537.194192-1-jolsa@kernel.org>
 <20230828075537.194192-7-jolsa@kernel.org>
 <CAADnVQJgGvsmr4Sug+ZWa68i9p4xLkW4OS8n4Afk3sZSdd0F5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJgGvsmr4Sug+ZWa68i9p4xLkW4OS8n4Afk3sZSdd0F5A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 28, 2023 at 10:32:05AM -0700, Alexei Starovoitov wrote:
> On Mon, Aug 28, 2023 at 12:56 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Increase misses stats in case bpf array execution is skipped
> > because of recursion check in trace_call_bpf.
> >
> > Adding bpf_prog_missed_array that increase misses counts for
> > all bpf programs in bpf_prog_array.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/bpf.h      | 16 ++++++++++++++++
> >  kernel/trace/bpf_trace.c |  3 +++
> >  2 files changed, 19 insertions(+)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 23a73f52c7bc..71154e991730 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -2932,6 +2932,22 @@ static inline int sock_map_bpf_prog_query(const union bpf_attr *attr,
> >  #endif /* CONFIG_BPF_SYSCALL */
> >  #endif /* CONFIG_NET && CONFIG_BPF_SYSCALL */
> >
> > +static __always_inline void
> > +bpf_prog_missed_array(const struct bpf_prog_array *array)
> 
> The name hardly explains the purpose.
> Please give it a better name.
> Maybe bpf_prog_inc_misses_counters ?
> Just extra "s".

I thought making it similar to bpf_prog_run_array,
but bpf_prog_inc_misses_counters sounds better

thanks,
jirka

