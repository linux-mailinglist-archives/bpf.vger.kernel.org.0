Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECA06F067D
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 15:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243614AbjD0NPt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 09:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243741AbjD0NPq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 09:15:46 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A93040CF
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 06:15:45 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f178da21b5so58540365e9.3
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 06:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682601345; x=1685193345;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Iz6IP8A/+uBmGbiwBWq6TnJ/gMqBLkXgDIurx6kCrkk=;
        b=jHkVECuGjs63n6cF0zPfHumqYZsbUhSlEabBnltY5cMGFae10+qSmhMM3I5XucOA5h
         O9Xtkqw7ORKEdGOuce77PGoBocFsx0fXFntN/+CMwYvC9A1HMiYK99b7nVg/qKgslYRS
         EnKi65g/oSTyE5VVWm9TnGbs9poTDirolF1FvGq7oeSYVY1SIxbR91CToNUhJcqiIK4G
         QRjuRLgW2AiOWab79fhIA4gWXNqOH1Y47ShvkuJhsIaCWzuYC0rAGd6jVJMz1MJedUfc
         fcVq+Ms7MrzXV+fK5J/Q2f/v9rqkpiAkHNhuQ7H0fii75OQIjUq5HyVoBmyC5cUtRw+d
         u0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682601345; x=1685193345;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iz6IP8A/+uBmGbiwBWq6TnJ/gMqBLkXgDIurx6kCrkk=;
        b=dEyO7vRbWKzmhBM7LLgcHD8EdylPr0P/LzY+wJc8rixTW44+LS0RtoMqmGG9Vd3uJj
         NrzniHeVCZ5eQQLBFEvjRhUJJkLYjbHOkiRi6iTbb1vrN7CKr4wKrtMTYhAKAZs3Qc41
         qqs/DK+zZIO2+YqB/k/v0+pqNzPvT1GF/vkPKcv8P/cW5oxcGlFGlCuZtNbAjyqVyzfV
         heJDwF9BDHwxgeN4SK4NjGgEGlIemudXaRYo+tUYHuc9OLWOdOiwtcNGX8Eyu69rsbo0
         sDI1rvUnWZb4qNd50O295ycVaw9oK3x3aiTHJljCskAP+BUdTNJKpJ4WV/9T178LbvTG
         IGeQ==
X-Gm-Message-State: AC+VfDz0aZERAZ3Yw437pcrKAAQAfkBGBoUqwIG7Crjv9Tu7y6qKaB+p
        cH2UA5sgkZaqkOsK8L0NkdA=
X-Google-Smtp-Source: ACHHUZ71MO7oYxfY078zgJufe+BoDUsBci4A8QCYOJ+1Zf/ilJvtqIKnT7QOgoxrXAMapxfuiKTfnQ==
X-Received: by 2002:a05:600c:22d2:b0:3f2:549b:3ede with SMTP id 18-20020a05600c22d200b003f2549b3edemr1480158wmg.5.1682601344830;
        Thu, 27 Apr 2023 06:15:44 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-8b88-53b7-c55c-8535.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:8b88:53b7:c55c:8535])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c450e00b003f0a6a1f969sm24874097wmo.46.2023.04.27.06.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 06:15:44 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 27 Apr 2023 15:15:42 +0200
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [RFC/PATCH bpf-next 01/20] bpf: Add multi uprobe link
Message-ID: <ZEp1fuL3WRrVO+8X@krava>
References: <20230424160447.2005755-1-jolsa@kernel.org>
 <20230424160447.2005755-2-jolsa@kernel.org>
 <CAEf4Bzayo2gUTyBZGUsv5LbgRY+wLrwNsP_1=hc4HU5SOGVjrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzayo2gUTyBZGUsv5LbgRY+wLrwNsP_1=hc4HU5SOGVjrA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 26, 2023 at 12:17:45PM -0700, Andrii Nakryiko wrote:
> On Mon, Apr 24, 2023 at 9:05 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding new multi uprobe link that allows to attach bpf program
> > to multiple uprobes.
> >
> > Uprobes to attach are specified via new link_create uprobe_multi
> > union:
> >
> >   struct {
> >           __u32           flags;
> >           __u32           cnt;
> >           __aligned_u64   paths;
> >           __aligned_u64   offsets;
> >           __aligned_u64   ref_ctr_offsets;
> >   } uprobe_multi;
> >
> > Uprobes are defined in paths/offsets/ref_ctr_offsets arrays with
> > the same 'cnt' length. Each uprobe is defined with a single index
> > in all three arrays:
> >
> >   paths[idx], offsets[idx] and/or ref_ctr_offsets[idx]
> >
> > The 'flags' supports single bit for now that marks the uprobe as
> > return probe.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/trace_events.h |   6 +
> >  include/uapi/linux/bpf.h     |  14 +++
> >  kernel/bpf/syscall.c         |  16 ++-
> >  kernel/trace/bpf_trace.c     | 231 +++++++++++++++++++++++++++++++++++
> >  4 files changed, 265 insertions(+), 2 deletions(-)
> >
> 
> [...]
> 
> > +static void bpf_uprobe_multi_link_dealloc(struct bpf_link *link)
> > +{
> > +       struct bpf_uprobe_multi_link *umulti_link;
> > +
> > +       umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
> > +       kvfree(umulti_link->uprobes);
> > +       kfree(umulti_link);
> > +}
> > +
> > +static const struct bpf_link_ops bpf_uprobe_multi_link_lops = {
> > +       .release = bpf_uprobe_multi_link_release,
> > +       .dealloc = bpf_uprobe_multi_link_dealloc,
> > +};
> > +
> 
> let's implement show_fdinfo and fill_link_info as well? At least we
> can display how many instances of uprobe are attached for a given
> link? And depending on what we decide with single or multi paths per
> link, we could output path to the binary, right? And PID as well, if
> we agree that it's possible to support it. Thanks!

ok, will check

jirka
