Return-Path: <bpf+bounces-9055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D2D78EDAA
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 14:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A777281514
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 12:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F381170E;
	Thu, 31 Aug 2023 12:52:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E909A7481
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 12:52:16 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CDFE45
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 05:52:09 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52a1132b685so996776a12.1
        for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 05:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693486328; x=1694091128; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yQq8wkX5iMLe5o2csF6c2vHzbD/t5F1yZiTopgw/xck=;
        b=UzuVDGOs00OyoI/AzulSb79oIbLSaAL6fw+WOFKBpNjnCrM4f1HG0MNcFzsWmkKDCg
         UbzeXqGhTSY6DVSC5YfoxEGxUaxj5FMZzBiBebU8oPBjCbshVmovbIERnqMsNhII48bI
         rsnF4VZ9kj0AVV2eUx/glsKSsgefrRCWh75RJpFkfebhHolBSwuLVchEFy4sVX9moa76
         v5vWxl/baYJHttUIj9cpO/MM0E/8wRlfn7V3dDvCJ/L7jJU365pqGa+3lqVWUwZtDAdR
         JzkdFxge/vH5Bqkiq/s9jqrku/akT0Nni2kpSh5twtRF1NF7OF5YAnYWRMRkHmRBaiLs
         AQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693486328; x=1694091128;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yQq8wkX5iMLe5o2csF6c2vHzbD/t5F1yZiTopgw/xck=;
        b=kW1+HRhfG54mmV1A6jeT0BPoIAvtVTeisiNc8hRFZaGRYjRFeGcvxT8sK/v0HHQLC3
         fh6GTzb8edIcXoCXcEgslnDkeXKcgA3pMPXfg0djhOe4F/puk3PKSlXwV8JBoZlf1srV
         5RSqxqrlQvrrnMRSwjLJwjMwjVp26PBzGY0ziiVN2usWlWNJuUOw/DX9qTvuU2+0x4Dh
         vxsWdHHuSOY7Hy1V8XtPyDSNmg+HAPcj+mXoOCzo6zb2OIRGsMrxTwdZRhAIETiYPA6V
         3Y6dCJBlUWN1bhpKyYBjPkuo4672fBXMpb/3uYQ3vCaTxVxcXMaBN1xhp1sa4VAf03eT
         TtQw==
X-Gm-Message-State: AOJu0YwdhzSDuqR7cMJlsLcevOgvUdgTJUfzdVquSQ80QNd9x481w7vq
	H5mgHDvyytWPzWCaicBLygE=
X-Google-Smtp-Source: AGHT+IHwqZ0PqH6WHflb8qs/VECcRlpi5Op434ZxUb9fUwOECQHUFWye4gZNaZi2r67woQLtYnCvZA==
X-Received: by 2002:a05:6402:8c7:b0:523:3754:a4e1 with SMTP id d7-20020a05640208c700b005233754a4e1mr3795938edz.22.1693486327768;
        Thu, 31 Aug 2023 05:52:07 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id w4-20020aa7da44000000b0052241b8fd0bsm758638eds.29.2023.08.31.05.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 05:52:07 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 31 Aug 2023 14:52:05 +0200
To: Hou Tao <houtao@huaweicloud.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Hou Tao <houtao1@huawei.com>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix d_path test
Message-ID: <ZPCM9W5pfJJ92P/t@krava>
References: <20230831110020.290102-1-jolsa@kernel.org>
 <6c157270-52e9-774e-6641-bdd32ab69ddf@iogearbox.net>
 <1f1d6589-5cf7-9d5e-e79e-39347f516e81@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f1d6589-5cf7-9d5e-e79e-39347f516e81@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 31, 2023 at 08:37:52PM +0800, Hou Tao wrote:
> Hi,
> 
> On 8/31/2023 7:46 PM, Daniel Borkmann wrote:
> > On 8/31/23 1:00 PM, Jiri Olsa wrote:
> >> Recent commit [1] broken d_path test, because now filp_close is not
> >> called
> >> directly from sys_close, but eventually later when the file is finally
> >> released.
> >>
> >> As suggested by Hou Tao we don't need to re-hook the bpf program, but
> >> just
> >> instead we can use sys_close_range to trigger filp_close synchronously.
> >>
> >> [1] 021a160abf62 ("fs: use __fput_sync in close(2)")
> >> Suggested-by: Hou Tao <houtao@huaweicloud.com>
> >> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> >> ---
> >>   tools/testing/selftests/bpf/prog_tests/d_path.c | 8 +++++++-
> >>   1 file changed, 7 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c
> >> b/tools/testing/selftests/bpf/prog_tests/d_path.c
> >> index 911345c526e6..81e34a4a05d1 100644
> >> --- a/tools/testing/selftests/bpf/prog_tests/d_path.c
> >> +++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
> >> @@ -90,7 +90,11 @@ static int trigger_fstat_events(pid_t pid)
> >>       fstat(indicatorfd, &fileStat);
> >>     out_close:
> >> -    /* triggers filp_close */
> >> +    /* sys_close no longer triggers filp_close, but we can
> >> +     * call sys_close_range instead which still does
> >> +     */
> >> +#define close(fd) close_range(fd, fd, 0)
> >> +
> >
> > The BPF CI selftest build says:
> >
> >     [...]
> >     TEST-OBJ [test_progs] lookup_key.test.o
> >     TEST-OBJ [test_progs] migrate_reuseport.test.o
> >     TEST-OBJ [test_progs] user_ringbuf.test.o
> >   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/d_path.c:
> > In function ‘trigger_fstat_events’:
> >  
> > /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/d_path.c:96:19:
> > error: implicit declaration of function ‘close_range’
> > [-Werror=implicit-function-declaration]
> >      96 | #define close(fd) close_range(fd, fd, 0)
> >         |                   ^~~~~~~~~~~
> >  
> > /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/d_path.c:98:2:
> > note: in expansion of macro ‘close’
> >      98 |  close(pipefd[0]);
> >         |  ^~~~~
> >     TEST-OBJ [test_progs] task_pt_regs.test.o
> >     [...]
> >
> > Perhaps #include <linux/close_range.h> missing ?
> 
> Including <linux/close_range.h> doesn't help because it only defines two
> macros.

right, just saw that ;-)

> 
> I got the same error when testing locally. It seems close_range() was
> introduced by glibc 2.34 [1] and it was defined in <unistd.h>, but the
> version of glibc in my local VM is 2.29. I modify d_path locally to call
> close_range through syscall():
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c
> b/tools/testing/selftests/bpf/prog_tests/d_path.c
> index 81e34a4a05d1..c5811843ce7e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/d_path.c
> +++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
> @@ -12,6 +12,14 @@
>  #include "test_d_path_check_rdonly_mem.skel.h"
>  #include "test_d_path_check_types.skel.h"
> 
> +#ifndef __NR_close_range
> +#ifdef __alpha__
> +#define __NR_close_range 546
> +#else
> +#define __NR_close_range 436
> +#endif
> +#endif
> +
>  static int duration;
> 
>  static struct {
> @@ -93,7 +101,7 @@ static int trigger_fstat_events(pid_t pid)
>         /* sys_close no longer triggers filp_close, but we can
>          * call sys_close_range instead which still does
>          */
> -#define close(fd) close_range(fd, fd, 0)
> +#define close(fd) syscall(__NR_close_range, fd, fd, 0)
> 
> [1]: 9b4feb630e8e arch: wire-up close_range()

nice, thanks for all the info

jirka

> 
> 
> >
> >>       close(pipefd[0]);
> >>       close(pipefd[1]);
> >>       close(sockfd);
> >> @@ -98,6 +102,8 @@ static int trigger_fstat_events(pid_t pid)
> >>       close(devfd);
> >>       close(localfd);
> >>       close(indicatorfd);
> >> +
> >> +#undef close
> >>       return ret;
> >>   }
> >>  
> 

