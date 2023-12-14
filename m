Return-Path: <bpf+bounces-17809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69ADB812B6C
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 10:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A857B2129A
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 09:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B6F2E3E0;
	Thu, 14 Dec 2023 09:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZAPSxj9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92E4B7
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 01:15:39 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c38e292c8so2019515e9.0
        for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 01:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702545338; x=1703150138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pbcOHai15xJF29DlyqgPYoHcZL2rLagxR6/xxS4Qrmo=;
        b=MZAPSxj96uJP2fNAYmJPTzEv6IJnY1qUdbATYA48hDLHCEfe0BWBgkgDy0KFa8s3mi
         Gr8LdzhDNxLBGMXJKFPdr6QURO/SNSBIJvTE7MEnJDIIMpxUDXfmnyDMYSW78V/ya3pu
         i6vgpwmb8S60xL/unPJUaPi/8pG4VL+v/vCUPDYa8BFNBQMR1bUHuFWO/WAnIY6UIf3Z
         He1jBn29vO4F53tBJN2wxbmWGUJmMz4rF3hgDcx4ONKRsd1whItAW3uq2b6uwqr28MBi
         IL6N1LaxM//ZMIU1nvChaPz+w6TSmO+611QO/OK+VvedyXoopFtvN5JZcNj9MiKMfh0x
         ToBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702545338; x=1703150138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbcOHai15xJF29DlyqgPYoHcZL2rLagxR6/xxS4Qrmo=;
        b=b0740Sd644GMYtMCHKuD10+vMu9NphNk0IiF/XGuWQJJaiibDD6wXtv3qeuYguI8nJ
         V0h0aozLkvCemYRuiLmQer/a1n8/NM61VkPD3/aFv71CzRTWmSPfXJGNh1xAlGBy8ovf
         IG6lpXr7kvnUTGc2IvgOWwGKJYt4jqTKdkg7oQk7RqagGBx/ggtVGsbLjwB6GeG7GUun
         30dZJjsyYJozkzafNLsAPlzAhlOFBcAYZXdS5x+hsbY+csp8945XmlqBA8ZxGfUENKV5
         TtCL/vQ+Copn7vbpVvKKGbBZI6K4MvdI4bYMY0eTU7adFUQfygpqXVZXIXAdl1jB/xNg
         IVtQ==
X-Gm-Message-State: AOJu0YyQ5f/itrFmsh7QQlC18b4I+yqil9RLXIGuytw0JKhyGf//QUX/
	Pi7jS1rnrvxRFAZxjpdL+27Shv1BJzsu8w==
X-Google-Smtp-Source: AGHT+IGzDJS3ch79WaUgnbLBTqV1DxXw0k4c5twzp4GX2zH8Oz8f8KhBXONVQ82wW+ihi279ij48FQ==
X-Received: by 2002:a05:600c:4709:b0:40b:5e4a:2368 with SMTP id v9-20020a05600c470900b0040b5e4a2368mr4972686wmo.106.1702545337826;
        Thu, 14 Dec 2023 01:15:37 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c470900b0040c4acaa4bfsm12872917wmo.19.2023.12.14.01.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 01:15:37 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 14 Dec 2023 10:15:35 +0100
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC bpf-next 2/2] selftests/bpf: Add uprobe multi fail test
Message-ID: <ZXrHtwUQZHlXMP_D@krava>
References: <20231213141234.1210389-1-jolsa@kernel.org>
 <20231213141234.1210389-2-jolsa@kernel.org>
 <838a8857-505b-1dc1-cc7e-c8c0960e666a@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <838a8857-505b-1dc1-cc7e-c8c0960e666a@oracle.com>

On Wed, Dec 13, 2023 at 06:08:54PM +0000, Alan Maguire wrote:
> On 13/12/2023 14:12, Jiri Olsa wrote:
> > We fail to create uprobe if we pass negative offset,
> > adding test for that.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> 
> small suggestion below..
> 
> > ---
> >  .../bpf/prog_tests/uprobe_multi_test.c        | 27 +++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > index ece260cf2c0b..aebfa7e6bfd6 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > @@ -326,6 +326,31 @@ void test_link_api(void)
> >  	__test_link_api(child);
> >  }
> >  
> > +static void test_attach_api_fails(void)
> > +{
> > +	LIBBPF_OPTS(bpf_link_create_opts, opts);
> > +	const char *path = "/proc/self/exe";
> > +	struct uprobe_multi *skel = NULL;
> > +	int prog_fd, link_fd;
> > +	long offset = -1;
> > +
> > +	skel = uprobe_multi__open_and_load();
> > +	if (!ASSERT_OK_PTR(skel, "uprobe_multi__open_and_load"))
> > +		return;
> > +
> > +	/* fail_1 - attach on negative offset */
> > +	opts.uprobe_multi.path = path;
> > +	opts.uprobe_multi.offsets = (unsigned long *) &offset;
> > +	opts.uprobe_multi.cnt = 1;
> > +
> > +	prog_fd = bpf_program__fd(skel->progs.uprobe_extra);
> > +	link_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
> > +	if (!ASSERT_EQ(link_fd, -EINVAL, "link_fd"))
> > +		close(link_fd);
> > +
> 
> would it be worth exercising a few additional error cases here? not
> specifying offsets/cnt triggers an EINVAL too.

yes, I think we can add more tests in here, will check

thanks,
jirka

