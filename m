Return-Path: <bpf+bounces-4178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DB874950D
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 07:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1B5A2811B4
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 05:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1304510F8;
	Thu,  6 Jul 2023 05:43:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1513A47
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 05:43:01 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAEE1BE1
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 22:42:57 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbc656873eso3978765e9.1
        for <bpf@vger.kernel.org>; Wed, 05 Jul 2023 22:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688622176; x=1691214176;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NuFo51aaO8EyUX/zUluAyH9hj+D07t7f58J/niwvCDY=;
        b=F/y+3AaDS2OyPMWoWQ4BBvChH8q3gw67VeKCMb+d/Px25kc/WTPkXOMVRqa924lZfz
         Q+dl7kQCnlkfNQqPYxk47HT9Gw6Qdeim9WWZDnPUiHkaRMjfOuq3SLcfmsm5U6ugIf1V
         YcRc0LB+o0SJOdR2BvE4sFIEynZhwJgccd+kMKu0tm/X/cytfL4JvSNML8AH0mV+Wi+a
         sC9+NG02Su8UY6bCPtkdZSvr/nLutLC/enJVfSiQl/tSVBGAPZHPhJxl+JBvxyXEgEC/
         egfgWStXqJi2AgYho7kA93C/Smpm2FIJmPid2XazrLSg2plvTbA5gAs8jthVEEB+bDRf
         lgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688622176; x=1691214176;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NuFo51aaO8EyUX/zUluAyH9hj+D07t7f58J/niwvCDY=;
        b=PJYmUEb6q25s7fT4tJFBdXIVWcOhtW2VOYHVgz570SuHLIIdMEzhZAJwrlQG69vh1Y
         ezulJ0+lUUMY5oakP7zxOaLpsrVNmcqwU7UEGEZ1VndlQq+c0OkaaIvQXyWQFatsyQIH
         3/9p7uvoFxFKpNYj0JLYAsG2f0cIwKJ+eYq5+sXADTn6AtlfUne9ytHr8TkfjEBQJKcg
         7P6zDXwqVU8S4ElsrIk7ZBnAIbleWiY/xkaN4gr+4aIg797Hy5W5SxrlO29tjNiRLAzd
         iOX8MMza7toRlBzYI0cxjXPdiwV4nF6s8U5Uq3Kt8AN25UaXNVgC6rEhnJ0jbg5CUY9P
         DN1A==
X-Gm-Message-State: ABy/qLYb5egC8d0akmecZkHbQW33urdu2nWBNog9jhA7YvtHCpnbXMtO
	dWVpBdqgfkwNWnP6Of6A4G369Q==
X-Google-Smtp-Source: APBJJlEIpWrGCrHHyVjyRMVejkjUz2KXqG9FwtP5ltFM3KoFaqsUBcWehoJLOLsx3esexIO866w9IA==
X-Received: by 2002:a7b:c7d9:0:b0:3fb:52c3:a17b with SMTP id z25-20020a7bc7d9000000b003fb52c3a17bmr1051798wmk.26.1688622175909;
        Wed, 05 Jul 2023 22:42:55 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id x16-20020a1c7c10000000b003fbe4cecc3bsm3943037wmc.16.2023.07.05.22.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 22:42:55 -0700 (PDT)
Date: Thu, 6 Jul 2023 05:44:05 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v4 bpf-next 6/6] selftests/bpf: check that ->elem_count
 is non-zero for the hash map
Message-ID: <ZKZUpW5QeOviHCne@zh-lab-node-5>
References: <20230705160139.19967-1-aspsk@isovalent.com>
 <20230705160139.19967-7-aspsk@isovalent.com>
 <CAADnVQLZMb3XqJFp8Oaz-83RzVHTV3EwJymKC817ekC57CNMBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLZMb3XqJFp8Oaz-83RzVHTV3EwJymKC817ekC57CNMBg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 05, 2023 at 06:26:25PM -0700, Alexei Starovoitov wrote:
> On Wed, Jul 5, 2023 at 9:00 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
> > Previous commits populated the ->elem_count per-cpu pointer for hash maps.
> > Check that this pointer is non-NULL in an existing map.
> >
> > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > ---
> >  tools/testing/selftests/bpf/progs/map_ptr_kern.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> > index db388f593d0a..d6e234a37ccb 100644
> > --- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> > +++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> > @@ -33,6 +33,7 @@ struct bpf_map {
> >         __u32 value_size;
> >         __u32 max_entries;
> >         __u32 id;
> > +       __s64 *elem_count;
> >  } __attribute__((preserve_access_index));
> >
> >  static inline int check_bpf_map_fields(struct bpf_map *map, __u32 key_size,
> > @@ -111,6 +112,8 @@ static inline int check_hash(void)
> >
> >         VERIFY(check_default_noinline(&hash->map, map));
> >
> > +       VERIFY(map->elem_count != NULL);
> > +
> 
> imo that's worse than no test.
> Just use kfunc here and get the real count?

Then, as I mentioned in the previous version, I will have to teach kfuncs to
recognize const_ptr_to_map args just for the sake of this selftest, while we
already testing all functionality in the new selftest for test_maps. So I would
just omit this one. Or am I missing something?

