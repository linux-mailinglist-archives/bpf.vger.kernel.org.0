Return-Path: <bpf+bounces-4736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2470074E9B2
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 11:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5536D1C203AE
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 09:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981F417738;
	Tue, 11 Jul 2023 09:02:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABCC174C0
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 09:02:06 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B4E1712
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 02:01:55 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51e344efd75so10412678a12.1
        for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 02:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689066113; x=1691658113;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ew0tUClb2QKmmFqBePF0UPLbZ6aBSxYn/RmXBMAXtQ4=;
        b=CMyWVJvGTgocw17zGAMGGogvF5pFONG8FP+AtpbbAhkszsUamSDiElPw+j34LQApXt
         gcYN/c3Wba3RJvrOMMi2Qn2d23PLzIdKtFYzBuGv4OyNtvoLjHY/rTQdVjQ8fcjOgaws
         +UxGmXeCCBIqJGKtJ6cxf82cI755jRGEY7oPf7IyfZpgzhyrWPKPIeISCYDcGZrgRiOB
         zjttmHF7HpVwHKESYWlG5zgJHcN7sUgIZAEnyfWsdPMsxtu5bC6mBWxNSX1kARFQu6MN
         jsad+hZJAUSATGXcDwPwnRWaKVjauX7dTx+6asMm4ddP3uaXFfum1EN+CfSz/Tn5L56J
         lCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689066113; x=1691658113;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ew0tUClb2QKmmFqBePF0UPLbZ6aBSxYn/RmXBMAXtQ4=;
        b=PGSDWSqjIaUZGvca9D3sEuJEBx5xaB/U9xMZtxtwlSWTt4wf9djOVxC1oBNi5d+VVJ
         ojPtUTHHpUYVieGgOuJiiQog2G/LcW6DFfQwKfnUAtjgYapWCIcNXujlb5ptm0kLJ0f3
         wmEGVUr9itlFwSeL0wg3NNlTnUsj9eaoRzvnjAqfO+dD38d5G2EtRwbSR5p+6SqlVr88
         j66IA++I5uil2DiIIzWYVNACm9UJayfMUPzFU8Bab6z7IBAWA9Qtp/iTKDk3cREBvNXR
         kdEdTAR5LICjhI9ma2RT3VdPH3a2NPPK659EHyykI9C9+dzHJju7PHrOUkcUJBS0Dmne
         2UJw==
X-Gm-Message-State: ABy/qLZrEnlLb2T8hc6VT/6RC+YCq8Pi5zUgbenleZx4Wb/Qo+GdxNle
	OM+a5Uxg8Gju37Cs424HuU0=
X-Google-Smtp-Source: APBJJlG8lo4ANepoUob7kWI0Vh46m1paemXvZPf5vaH/fpYp+S3DV1MNW8uCW0fm5wAgYFnrkbTR6g==
X-Received: by 2002:aa7:d983:0:b0:51e:1c5c:b97f with SMTP id u3-20020aa7d983000000b0051e1c5cb97fmr19421610eds.2.1689066113468;
        Tue, 11 Jul 2023 02:01:53 -0700 (PDT)
Received: from krava (net-109-116-206-239.cust.vodafonedsl.it. [109.116.206.239])
        by smtp.gmail.com with ESMTPSA id a19-20020a50ff13000000b0051bed498851sm931909edu.54.2023.07.11.02.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 02:01:53 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 11 Jul 2023 11:01:49 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv3 bpf-next 08/26] libbpf: Add elf_open/elf_close functions
Message-ID: <ZK0affmyyb6v8HMm@krava>
References: <20230630083344.984305-1-jolsa@kernel.org>
 <20230630083344.984305-9-jolsa@kernel.org>
 <CAEf4BzaT8-81ooHjgwmR8F+e9++ZewdXJMGqVfFi+y-g4BFYww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaT8-81ooHjgwmR8F+e9++ZewdXJMGqVfFi+y-g4BFYww@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 06, 2023 at 04:09:29PM -0700, Andrii Nakryiko wrote:
> On Fri, Jun 30, 2023 at 1:35 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding elf_open/elf_close functions and using it in
> > elf_find_func_offset_from_file function. It will be
> > used in following changes to save some common code.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/bpf/elf.c        | 59 +++++++++++++++++++++++++-------------
> >  tools/lib/bpf/libbpf_elf.h |  8 ++++++
> >  tools/lib/bpf/usdt.c       | 31 ++++++--------------
> >  3 files changed, 56 insertions(+), 42 deletions(-)
> >
> 
> one nit below
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> > diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
> > index 2b62b4af28ce..74e35071d22e 100644
> > --- a/tools/lib/bpf/elf.c
> > +++ b/tools/lib/bpf/elf.c
> > @@ -11,6 +11,40 @@
> >
> >  #define STRERR_BUFSIZE  128
> >
> > +int elf_open(const char *binary_path, struct elf_fd *elf_fd)
> > +{
> > +       char errmsg[STRERR_BUFSIZE];
> > +       int fd, ret;
> > +       Elf *elf;
> > +
> > +       if (elf_version(EV_CURRENT) == EV_NONE) {
> > +               pr_warn("elf: failed to init libelf for %s\n", binary_path);
> > +               return -LIBBPF_ERRNO__LIBELF;
> > +       }
> > +       fd = open(binary_path, O_RDONLY | O_CLOEXEC);
> > +       if (fd < 0) {
> > +               ret = -errno;
> > +               pr_warn("elf: failed to open %s: %s\n", binary_path,
> > +                       libbpf_strerror_r(ret, errmsg, sizeof(errmsg)));
> > +               return ret;
> > +       }
> > +       elf = elf_begin(fd, ELF_C_READ_MMAP, NULL);
> > +       if (!elf) {
> > +               pr_warn("elf: could not read elf from %s: %s\n", binary_path, elf_errmsg(-1));
> > +               close(fd);
> > +               return -LIBBPF_ERRNO__FORMAT;
> > +       }
> > +       elf_fd->fd = fd;
> > +       elf_fd->elf = elf;
> > +       return 0;
> > +}
> > +
> > +void elf_close(struct elf_fd *elf_fd)
> > +{
> > +       elf_end(elf_fd->elf);
> > +       close(elf_fd->fd);
> 
> nit: I'd make elf_close() work correctly with a) NULL elf_fd and b)

right, ok

> NULL elf_fd->elf, just to never have to think about this

there's NULL check in elf_end

thanks,
jirka

