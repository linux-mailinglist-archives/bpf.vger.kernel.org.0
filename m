Return-Path: <bpf+bounces-3387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CCC73CDCA
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 03:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1D61C2031C
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 01:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B63C62C;
	Sun, 25 Jun 2023 01:20:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B537F
	for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 01:20:10 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5382F2
	for <bpf@vger.kernel.org>; Sat, 24 Jun 2023 18:20:08 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-98dfb3f9af6so137454566b.2
        for <bpf@vger.kernel.org>; Sat, 24 Jun 2023 18:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687656007; x=1690248007;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sCaa+9GxBgbeIc/hx6cs6QHzLBUPO5KeZrzKyyKHNrY=;
        b=rzyjLTPxOUEbcAuxTBJGBJdWfwsIdRIjSef3MOOi3pVrGPSF168KiwiClg25OMKApx
         nA6U6ScOgKl3oYko5aM1YdQJEQVgYJX1I6m2udqYCLkpZ8pe1mKWP8jMeNZA8dGgYYFT
         LHmIrW5tM4hd3tLy8OXni07chFxEDGsmH9xE9xnmbSMH2FDAsDTd9PomLMfN7dqoRjV/
         vh5f2he+CS41Uu5hbyFAQAxpnanK5qX1vD7orSJkQJEzRfHA+b2M8Q7FHu+/LyKQa18N
         5kHwmWeybAewXoAaPsDU/oD82JXarMmAj2pYPbGwCgTQoaaDFOEPPAoD0RAhbZFRkat4
         nnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687656007; x=1690248007;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sCaa+9GxBgbeIc/hx6cs6QHzLBUPO5KeZrzKyyKHNrY=;
        b=JlViZtKoQhcC/ynfaobOT+Y/JuBO0RUlIYf9SjTiz5WxSVuGxbLJe6ZoTuv5YqYozN
         gOQSCrmHoR+WNkaavf+JxExdHUlrD3YHpqfKmxF/Asu9NG65AJrRebT7mAP8cgtg5+HY
         HsRBlv0UouPCQUCUgEf0Keer6hIxtuU7Px84Lq2Stvoy7Ji7i5MGdfkPUwuGNfsyEc9/
         qlMZvaIuTdEW2aNjIIWYAuqndJx098cZs+cVGZpkJzDWaunISDNvo/KUl6rDAja/ct68
         yadI6DFBi7O0JJEtp7jc2Q9Rz0AzSAgLU6dwslybRSa9R3LI9PpPpdoZdTqruCTOL/y4
         13ZA==
X-Gm-Message-State: AC+VfDyzbtZV2t2dOqtD8LKcHPXKJHb6d5PbrKBFfymblnCPQ+3fi9CN
	VRVwx/iUfLHK+ntkI6IZk0I=
X-Google-Smtp-Source: ACHHUZ5k7hhrROuAz4AZShch0Ncn22tKL4ND4yn42Klp32NaLSN1ysxey8tppkKFPzUPLJsMTNyv+w==
X-Received: by 2002:a17:907:94c6:b0:97a:588f:766 with SMTP id dn6-20020a17090794c600b0097a588f0766mr24662761ejc.42.1687656006919;
        Sat, 24 Jun 2023 18:20:06 -0700 (PDT)
Received: from krava (brn-rj-tbond05.sa.cz. [185.94.55.134])
        by smtp.gmail.com with ESMTPSA id e17-20020a05600c219100b003f809461162sm3439060wme.16.2023.06.24.18.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 18:20:06 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 25 Jun 2023 03:20:03 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv2 bpf-next 12/24] libbpf: Add support for
 u[ret]probe.multi[.s] program sections
Message-ID: <ZJeWQzu3kIMhD/52@krava>
References: <20230620083550.690426-1-jolsa@kernel.org>
 <20230620083550.690426-13-jolsa@kernel.org>
 <CAEf4BzYg8objHgvCtWegVk6JpGxYO6+F4GcSaeEFG5m+Y7Jv-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYg8objHgvCtWegVk6JpGxYO6+F4GcSaeEFG5m+Y7Jv-Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 01:40:13PM -0700, Andrii Nakryiko wrote:
> On Tue, Jun 20, 2023 at 1:37 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding support for several uprobe_multi program sections
> > to allow auto attach of multi_uprobe programs.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/bpf/libbpf.c | 40 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index d972cea4c658..e42080258ec7 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -8652,6 +8652,7 @@ static int attach_tp(const struct bpf_program *prog, long cookie, struct bpf_lin
> >  static int attach_raw_tp(const struct bpf_program *prog, long cookie, struct bpf_link **link);
> >  static int attach_trace(const struct bpf_program *prog, long cookie, struct bpf_link **link);
> >  static int attach_kprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
> > +static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
> >  static int attach_lsm(const struct bpf_program *prog, long cookie, struct bpf_link **link);
> >  static int attach_iter(const struct bpf_program *prog, long cookie, struct bpf_link **link);
> >
> > @@ -8667,6 +8668,10 @@ static const struct bpf_sec_def section_defs[] = {
> >         SEC_DEF("uretprobe.s+",         KPROBE, 0, SEC_SLEEPABLE, attach_uprobe),
> >         SEC_DEF("kprobe.multi+",        KPROBE, BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
> >         SEC_DEF("kretprobe.multi+",     KPROBE, BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
> > +       SEC_DEF("uprobe.multi+",        KPROBE, BPF_TRACE_UPROBE_MULTI, SEC_NONE, attach_uprobe_multi),
> > +       SEC_DEF("uretprobe.multi+",     KPROBE, BPF_TRACE_UPROBE_MULTI, SEC_NONE, attach_uprobe_multi),
> > +       SEC_DEF("uprobe.multi.s+",      KPROBE, BPF_TRACE_UPROBE_MULTI, SEC_SLEEPABLE, attach_uprobe_multi),
> > +       SEC_DEF("uretprobe.multi.s+",   KPROBE, BPF_TRACE_UPROBE_MULTI, SEC_SLEEPABLE, attach_uprobe_multi),
> >         SEC_DEF("ksyscall+",            KPROBE, 0, SEC_NONE, attach_ksyscall),
> >         SEC_DEF("kretsyscall+",         KPROBE, 0, SEC_NONE, attach_ksyscall),
> >         SEC_DEF("usdt+",                KPROBE, 0, SEC_NONE, attach_usdt),
> > @@ -10728,6 +10733,41 @@ static int attach_kprobe_multi(const struct bpf_program *prog, long cookie, stru
> >         return libbpf_get_error(*link);
> >  }
> >
> > +static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link)
> > +{
> > +       char *probe_type = NULL, *binary_path = NULL, *func_name = NULL;
> > +       LIBBPF_OPTS(bpf_uprobe_multi_opts, opts);
> > +       int n, ret = -EINVAL;
> > +
> > +       *link = NULL;
> > +
> > +       n = sscanf(prog->sec_name, "%m[^/]/%m[^:]:%ms",
> > +                  &probe_type, &binary_path, &func_name);
> > +       switch (n) {
> > +       case 1:
> > +               /* handle SEC("u[ret]probe") - format is valid, but auto-attach is impossible. */
> > +               ret = 0;
> > +               break;
> > +       case 2:
> > +               pr_warn("prog '%s': section '%s' missing ':function[+offset]' specification\n",
> 
> message copy/pasted? We don't support +offset part, and it's not
> "function", but "pattern" or something along those lines?

yes, will fix

> 
> > +                       prog->name, prog->sec_name);
> > +               break;
> > +       case 3:
> > +               opts.retprobe = strcmp(probe_type, "uretprobe.multi");
> 
> == 0

ok, thanks

jirka

> 
> 
> > +               *link = bpf_program__attach_uprobe_multi_opts(prog, -1, binary_path, func_name, &opts);
> > +               ret = libbpf_get_error(*link);
> > +               break;
> > +       default:
> > +               pr_warn("prog '%s': invalid format of section definition '%s'\n", prog->name,
> > +                       prog->sec_name);
> > +               break;
> > +       }
> > +       free(probe_type);
> > +       free(binary_path);
> > +       free(func_name);
> > +       return ret;
> > +}
> > +
> >  static void gen_uprobe_legacy_event_name(char *buf, size_t buf_sz,
> >                                          const char *binary_path, uint64_t offset)
> >  {
> > --
> > 2.41.0
> >

