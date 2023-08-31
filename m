Return-Path: <bpf+bounces-9051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C6778ECFF
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 14:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1CC11C20A3C
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 12:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C460711708;
	Thu, 31 Aug 2023 12:25:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982169470
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 12:25:36 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241FA1A4
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 05:25:35 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4cbso911937a12.1
        for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 05:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693484733; x=1694089533; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3EpvPSlXRjhBhXH4X4arE+hYchCvdLs6qGXJVU7UjxI=;
        b=T/gydr4Mk+F4ffNCmCM+anVAEsypd9Xo/x2acXdo4kKOYiibCxnmqAWi6TaJZCaFXC
         DejP/DrhTAFhtxiEz8NSJ4GShWRxVPVg1fibGFT3HdAxgRGn27MmKY3WpkTyJcDRY9VY
         AsqyqsiqmeIrDTA5DVPn47xhYVHhvY2o5hs4SrVxOfZqYndIEy0XuZ/i1VOoYddyZHU0
         twv6H3oE0jXIVcbNflhnWP1MYzWwKWcJUM6KB1To8+in/2rR+YOZYNo7s10XXioX8I5Y
         HISNPfL8giXac+lJL5lOtXDVNeKgdjJmyKbjwHajHGKamotioUBTQ5oIa2L8TdRLnoq+
         j9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693484733; x=1694089533;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3EpvPSlXRjhBhXH4X4arE+hYchCvdLs6qGXJVU7UjxI=;
        b=fgBmHD+iC4EcP0nX1R8zctBuuwlAMK7kxl6dI3EIULfVsqUTojfF6he+kZpltWe9rP
         AUQIctPCRd17wq6hoJ6qOKHtr4gTQiKabTMf+MYh0Gqfx8dNnS1hPU4qReUTbejm+f60
         D2vB/h4nUcCwGvSnFePZ4KWnLbAzu3bHeffKr0hVJiG6ZED8cdjUiQMdqIIrurI0/81o
         lHG2zZNpjhakynTXUfCmXhkBjxvNifBGreVPQcraKZwp5rk3XNlbWNSaWIxdB/dBxzAP
         UDyYVS+sNowJv15JS0CVnMmQcP3OL0/l9SGwAPif3Z2dLUlQ6ggqRbdIYU8/oIz5pxDj
         3Idg==
X-Gm-Message-State: AOJu0Yx+h7iFUFP5vqHrteCYzkW5w64nJrLS+XzUFGGMPKSLIhWWgeQV
	mVucjH94pbM1qL+35V9ZH0aIMJ/tDk8=
X-Google-Smtp-Source: AGHT+IF1R3ksJUhYjHYisnjw803cTU2jTCc8BmyBLtXmFdg1vmLjtMG1P1JiHqxh1bHz0Cckpqc0kg==
X-Received: by 2002:a17:906:1019:b0:9a5:d16b:6631 with SMTP id 25-20020a170906101900b009a5d16b6631mr3776901ejm.70.1693484733335;
        Thu, 31 Aug 2023 05:25:33 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id s6-20020a1709066c8600b00989828a42e8sm705332ejr.154.2023.08.31.05.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 05:25:32 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 31 Aug 2023 14:25:30 +0200
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Hou Tao <houtao1@huawei.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix d_path test
Message-ID: <ZPCGukUcjyih8R+d@krava>
References: <20230831110020.290102-1-jolsa@kernel.org>
 <6c157270-52e9-774e-6641-bdd32ab69ddf@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c157270-52e9-774e-6641-bdd32ab69ddf@iogearbox.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 31, 2023 at 01:46:09PM +0200, Daniel Borkmann wrote:
> On 8/31/23 1:00 PM, Jiri Olsa wrote:
> > Recent commit [1] broken d_path test, because now filp_close is not called
> > directly from sys_close, but eventually later when the file is finally
> > released.
> > 
> > As suggested by Hou Tao we don't need to re-hook the bpf program, but just
> > instead we can use sys_close_range to trigger filp_close synchronously.
> > 
> > [1] 021a160abf62 ("fs: use __fput_sync in close(2)")
> > Suggested-by: Hou Tao <houtao@huaweicloud.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >   tools/testing/selftests/bpf/prog_tests/d_path.c | 8 +++++++-
> >   1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/testing/selftests/bpf/prog_tests/d_path.c
> > index 911345c526e6..81e34a4a05d1 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/d_path.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
> > @@ -90,7 +90,11 @@ static int trigger_fstat_events(pid_t pid)
> >   	fstat(indicatorfd, &fileStat);
> >   out_close:
> > -	/* triggers filp_close */
> > +	/* sys_close no longer triggers filp_close, but we can
> > +	 * call sys_close_range instead which still does
> > +	 */
> > +#define close(fd) close_range(fd, fd, 0)
> > +
> 
> The BPF CI selftest build says:
> 
>     [...]
>     TEST-OBJ [test_progs] lookup_key.test.o
>     TEST-OBJ [test_progs] migrate_reuseport.test.o
>     TEST-OBJ [test_progs] user_ringbuf.test.o
>   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/d_path.c: In function ‘trigger_fstat_events’:
>   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/d_path.c:96:19: error: implicit declaration of function ‘close_range’ [-Werror=implicit-function-declaration]
>      96 | #define close(fd) close_range(fd, fd, 0)
>         |                   ^~~~~~~~~~~
>   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/d_path.c:98:2: note: in expansion of macro ‘close’
>      98 |  close(pipefd[0]);
>         |  ^~~~~
>     TEST-OBJ [test_progs] task_pt_regs.test.o
>     [...]
> 
> Perhaps #include <linux/close_range.h> missing ?

yes, will send v2

thanks,
jirka

> 
> >   	close(pipefd[0]);
> >   	close(pipefd[1]);
> >   	close(sockfd);
> > @@ -98,6 +102,8 @@ static int trigger_fstat_events(pid_t pid)
> >   	close(devfd);
> >   	close(localfd);
> >   	close(indicatorfd);
> > +
> > +#undef close
> >   	return ret;
> >   }
> > 
> 

