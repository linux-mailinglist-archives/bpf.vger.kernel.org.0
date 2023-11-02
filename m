Return-Path: <bpf+bounces-13950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8007DF4B0
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 15:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B24C11F22767
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 14:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B241B282;
	Thu,  2 Nov 2023 14:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaErKdmA"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453FC19BC2
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 14:13:08 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1039D1B3
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 07:12:56 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53e08e439c7so1746354a12.0
        for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 07:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698934374; x=1699539174; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kgxFwcSmWe6FtFY/FLYmlMopsCy1zQj0uhNlXo3LlnI=;
        b=kaErKdmA8aByPLAZNCyNkhBaSkO0RBu6tv9sVfzrt0QgeoMGGgNixFZ/nvJqPvK1/M
         bjsr0DJYWLKu2N1/iynpRGpvKJOHD+NMZDY1FLKVrBrieSsRvOXTf4Gm736wmXqSkliu
         nJcRfBMeFExBONwCwI1WwcC6BzJQRpU63QSwJpxltHY9lmgZYnO+jNr3V5JnOXq7E6q6
         hAOJlXfnJqCq50w3PxPTyRWIDUFd7s32ZxYcY22UsC5B5QOoHrbnSpzeqPCCkDC8KuXf
         I/Jkg0u3TMxIJaSBC/bzlTn7fu3h0lWR0t760Ms8McByudLvl76WwslDgQ72MSciDJMo
         AVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698934374; x=1699539174;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kgxFwcSmWe6FtFY/FLYmlMopsCy1zQj0uhNlXo3LlnI=;
        b=MNRRJapvscET+2egn6JJphOH3vqlV8ZVQeBA0AdGdxV+7X38/qyHDn4abkHyTVXoTp
         R8kYZiSggqZMeG8KR0zaBa/Q4eFINlS19bUijtKfXnp476rzC29S+8igxhNH4Sf8Ph/q
         eMOs+sJJOHmEP9Y40a7Ga8xw/LPddzWZYw1V/ethbpajN0t9uHM7o+3karhQlmPWir5x
         u1itpBD8AaH/+afR34HFay2qy5pqurg8vMcq7YTJu/CXvlgYr/E5WOeotgQYG1jW8g1j
         lmoavTdrpx2BHWhw7i0YY0ELWYc09j7RQkL8FvvEO31RWCFK+BuWCWYDcTWeFwHyKwOX
         eVcA==
X-Gm-Message-State: AOJu0YzQ6N9SOE38raykeuL01wKPp7oROFEjSDEiYm5LWDciQXsa4CJx
	cNFU7abUlWZ9lK+KcbRjglM=
X-Google-Smtp-Source: AGHT+IE6ZstQm/SfxIX5OGV5zGrx4b4GtDjIR30z+Z1BcF8jz0MWfdhtKRH/j3dKdZjjn87ABCLU7g==
X-Received: by 2002:a17:907:1ca3:b0:9c7:5437:841e with SMTP id nb35-20020a1709071ca300b009c75437841emr4898689ejc.11.1698934374227;
        Thu, 02 Nov 2023 07:12:54 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id s19-20020a170906c31300b0098f99048053sm1204191ejz.148.2023.11.02.07.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 07:12:53 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 2 Nov 2023 15:12:51 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH bpf-next 4/6] selftests/bpf: Use bpf_link__destroy in
 fill_link_info tests
Message-ID: <ZUOuY8Wfh7UQgz88@krava>
References: <20231025202420.390702-1-jolsa@kernel.org>
 <20231025202420.390702-5-jolsa@kernel.org>
 <CAEf4BzbKCtON6qry3qpoO5FdNbwMUWV7F2FHzHi+K34qBv3pjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbKCtON6qry3qpoO5FdNbwMUWV7F2FHzHi+K34qBv3pjg@mail.gmail.com>

On Wed, Nov 01, 2023 at 03:24:36PM -0700, Andrii Nakryiko wrote:
> On Wed, Oct 25, 2023 at 1:25 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > The fill_link_info test keeps skeleton open and just creates
> > various links. We are wrongly calling bpf_link__detach after
> > each test to close them, we need to call bpf_link__destroy.
> >
> > Also we need to set the link NULL so the skeleton destroy
> > won't try to destroy them again.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../selftests/bpf/prog_tests/fill_link_info.c       | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> > index 97142a4db374..0379872c445a 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> > @@ -22,6 +22,11 @@ static __u64 kmulti_addrs[KMULTI_CNT];
> >  #define KPROBE_FUNC "bpf_fentry_test1"
> >  static __u64 kprobe_addr;
> >
> > +#define LINK_DESTROY(__link) ({                \
> > +       bpf_link__destroy(__link);      \
> > +       __link = NULL;                  \
> > +})
> > +
> >  #define UPROBE_FILE "/proc/self/exe"
> >  static ssize_t uprobe_offset;
> >  /* uprobe attach point */
> > @@ -157,7 +162,7 @@ static void test_kprobe_fill_link_info(struct test_fill_link_info *skel,
> >         } else {
> >                 kprobe_fill_invalid_user_buffer(link_fd);
> >         }
> > -       bpf_link__detach(skel->links.kprobe_run);
> > +       LINK_DESTROY(skel->links.kprobe_run);
> >  }
> >
> >  static void test_tp_fill_link_info(struct test_fill_link_info *skel)
> > @@ -171,7 +176,7 @@ static void test_tp_fill_link_info(struct test_fill_link_info *skel)
> >         link_fd = bpf_link__fd(skel->links.tp_run);
> >         err = verify_perf_link_info(link_fd, BPF_PERF_EVENT_TRACEPOINT, 0, 0, 0);
> >         ASSERT_OK(err, "verify_perf_link_info");
> > -       bpf_link__detach(skel->links.tp_run);
> > +       LINK_DESTROY(skel->links.tp_run);
> >  }
> >
> >  static void test_uprobe_fill_link_info(struct test_fill_link_info *skel,
> > @@ -189,7 +194,7 @@ static void test_uprobe_fill_link_info(struct test_fill_link_info *skel,
> >         link_fd = bpf_link__fd(skel->links.uprobe_run);
> >         err = verify_perf_link_info(link_fd, type, 0, uprobe_offset, 0);
> >         ASSERT_OK(err, "verify_perf_link_info");
> > -       bpf_link__detach(skel->links.uprobe_run);
> > +       LINK_DESTROY(skel->links.uprobe_run);
> >  }
> >
> >  static int verify_kmulti_link_info(int fd, bool retprobe)
> > @@ -295,7 +300,7 @@ static void test_kprobe_multi_fill_link_info(struct test_fill_link_info *skel,
> >         } else {
> >                 verify_kmulti_invalid_user_buffer(link_fd);
> >         }
> > -       bpf_link__detach(skel->links.kmulti_run);
> > +       LINK_DESTROY(skel->links.kmulti_run);
> 
> if we don't want skeleton to take care of these links, we shouldn't
> assign them into skel->links region, IMO
> 
> so perhaps the proper fix is to have local bpf_link variable in these tests?

ok, that looks cleaner

jirka

