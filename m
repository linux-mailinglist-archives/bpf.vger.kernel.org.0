Return-Path: <bpf+bounces-9172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9467911CC
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 09:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEAC3280C32
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 07:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DD910EA;
	Mon,  4 Sep 2023 07:10:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D8C81E
	for <bpf@vger.kernel.org>; Mon,  4 Sep 2023 07:10:06 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B902B99
	for <bpf@vger.kernel.org>; Mon,  4 Sep 2023 00:10:04 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bcf2de59cso167501766b.0
        for <bpf@vger.kernel.org>; Mon, 04 Sep 2023 00:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693811403; x=1694416203; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o1KLRe0JFxiTGpjeg64XyZFwWF4NQXGEavCBaNioRJo=;
        b=fM+vaofkNjPu+5/3G21EhWq8kqIj5tv3kvBmCV996P8V1EEbDVoFH0aeXkRKuIUfN0
         VDL8mGTRflnOqkCFXJcxdPgl/ChCtXmRjNeWPM8LOVxK7O1SHi6SwxU9uwKMoMBhHhGM
         gVGzVIIlIAEnRCiWClU6L8ClUZjRF+0p0NmEj2RdWE2UMyPihoPXO4Vhz/OmUeoVAau0
         CTNiO4rUlDdfk32Pda7C5HucQE4eYClz6f/+59Sy0G7VGDRltwemoFTUY0k2j9zbI0Bd
         5iPLoZ81PQYzZq9kfBJ6fTp7jphv/SbC2Cgx5wMNR9yIbAnHmkGL//Dfddh53ztV1Sxs
         naTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693811403; x=1694416203;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o1KLRe0JFxiTGpjeg64XyZFwWF4NQXGEavCBaNioRJo=;
        b=CyBNQI7QuiUj4gOSenp2QGLtsZruoS9vi+kkyjzCDV408gZepvpivmxnajCvUJ2fSD
         F0u/X4K2yFy4117ncMjHYkh2FOqOnf7IhwuJfKbJQ5evpHVvlQDjALv4mY8OQJ+6vVKQ
         y/RsWMrheGifiGEXQFHjML27t7ODDTe8aXAAXU6vigjvSIo7cUH8FaLm5SrYY9ew8T7o
         91m4+u/8uhkOlEeUm9+sqcoJskDtatEWxuZ98NyywLLLqUBCGVuVJ3QIt3TtTONV4Aj+
         29fNJU1ZZm30q646yon4HMgMY67zjMDuEbkGemzhe/Y3Cae9xm0PNc7FM1iWLDM26BX6
         LUxQ==
X-Gm-Message-State: AOJu0YwxhxYeNgWUCGUIG0ntqxlFeqjMvEVUCbiD+rE6QAKV3XLiXW3J
	XuH+cJMhvP3FS10a6pj4KKQ=
X-Google-Smtp-Source: AGHT+IFXtt5eItWcIrpGCejr9VmmPHESZ/ATQGDQeMvpfAfjdotjkaB1X6dEXfmGQoxSTd3L+4FCiA==
X-Received: by 2002:a17:906:3299:b0:99d:e8da:c20b with SMTP id 25-20020a170906329900b0099de8dac20bmr5166346ejw.24.1693811402987;
        Mon, 04 Sep 2023 00:10:02 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-8b88-53b7-c55c-8535.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:8b88:53b7:c55c:8535])
        by smtp.gmail.com with ESMTPSA id ov22-20020a170906fc1600b00992c92af6f4sm5830399ejb.144.2023.09.04.00.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 00:10:02 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 4 Sep 2023 09:10:00 +0200
To: Song Liu <song@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Hou Tao <houtao1@huawei.com>
Subject: Re: [PATCHv2 bpf-next] selftests/bpf: Fix d_path test
Message-ID: <ZPWCyELkdspCPXP3@krava>
References: <20230831141103.359810-1-jolsa@kernel.org>
 <1fc894ed-0f54-ea4f-8b2f-d7120b6d9c0f@iogearbox.net>
 <CAPhsuW64KL9T2B9ePzLSvfW2UonCircVj48+GozagJi8xLNo7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW64KL9T2B9ePzLSvfW2UonCircVj48+GozagJi8xLNo7w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 01, 2023 at 04:09:31PM -0700, Song Liu wrote:
> On Thu, Aug 31, 2023 at 8:21 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >
> > On 8/31/23 4:11 PM, Jiri Olsa wrote:
> > > Recent commit [1] broken d_path test, because now filp_close is not called
> > > directly from sys_close, but eventually later when the file is finally
> > > released.
> > >
> > > As suggested by Hou Tao we don't need to re-hook the bpf program, but just
> > > instead we can use sys_close_range to trigger filp_close synchronously.
> > >
> > > [1] 021a160abf62 ("fs: use __fput_sync in close(2)")
> > > Suggested-by: Hou Tao <houtao@huaweicloud.com>
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> >
> > That did the trick, thanks everyone, applied!
> 
> I guess I am a bit late. But how about we use something like the following?
> I like this one better because it tests bpf_d_path() from retval at fexit.

right, that would have been an option as well

> 
> Thanks,
> Song
> 
> 
> 
> 
> diff --git i/kernel/trace/bpf_trace.c w/kernel/trace/bpf_trace.c
> index a7264b2c17ad..fe91836cedcd 100644
> --- i/kernel/trace/bpf_trace.c
> +++ w/kernel/trace/bpf_trace.c
> @@ -941,6 +941,7 @@ BTF_ID(func, vfs_fallocate)
>  BTF_ID(func, dentry_open)
>  BTF_ID(func, vfs_getattr)
>  BTF_ID(func, filp_close)
> +BTF_ID(func, close_fd_get_file)

I liked using the close_range syscall because we did not need to
add new allowed function.. however close_fd_get_file looks safe
enough so I wouldn't mind changing that if you insist ;-)

jirka


>  BTF_SET_END(btf_allowlist_d_path)
> 
>  static bool bpf_d_path_allowed(const struct bpf_prog *prog)
> diff --git i/tools/testing/selftests/bpf/progs/test_d_path.c
> w/tools/testing/selftests/bpf/progs/test_d_path.c
> index 84e1f883f97b..c880cfc95737 100644
> --- i/tools/testing/selftests/bpf/progs/test_d_path.c
> +++ w/tools/testing/selftests/bpf/progs/test_d_path.c
> @@ -40,8 +40,8 @@ int BPF_PROG(prog_stat, struct path *path, struct kstat *stat,
>         return 0;
>  }
> 
> -SEC("fentry/filp_close")
> -int BPF_PROG(prog_close, struct file *file, void *id)
> +SEC("fexit/close_fd_get_file")
> +int BPF_PROG(close_fd_get_file, int fd, struct file *file /* retval */)
>  {
>         pid_t pid = bpf_get_current_pid_tgid() >> 32;
>         __u32 cnt = cnt_close;

