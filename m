Return-Path: <bpf+bounces-4179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5693574950F
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 07:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 519771C20CE1
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 05:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0898A10F8;
	Thu,  6 Jul 2023 05:46:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCC8A47
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 05:46:29 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E31319BE
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 22:46:28 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-314313f127fso216663f8f.1
        for <bpf@vger.kernel.org>; Wed, 05 Jul 2023 22:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688622386; x=1691214386;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gkso9NTOikj23OabiLWNMJqHDpqjFza09R/HLzpROjo=;
        b=S6D5nrYV02PqcKafqtT9iKZgb7oTQQQVw/oSOdH+LOcIHGPEhdYzcU/T7XLtwQ+dqq
         H03DtaPv2H/8q1AuITTkcKLx72EuAtmtACpSECwjArcBm6cnqdB/i8VBZACftXQtt18Z
         1cSnix3jp46nUUCOO+/gOYgEG0ndB9/MmTU7dYT2FMSeSWEwe9HRxdxYsXqR2Htho+gJ
         vya3s5EYRLNP89xwz3wGCDNtx/qcPZh6lKJEkpmxjMpGLwuVc3HM83Tf3e8R4eu6LMdf
         MWA44gF0J42OxKIJq5RmQjrIDkAyu8OyJ/nfVkeZ+iBWe6WzX3rNRCLiNfR0lZnCSmCa
         XEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688622386; x=1691214386;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gkso9NTOikj23OabiLWNMJqHDpqjFza09R/HLzpROjo=;
        b=eEPGn3yWgj8Sj1fJlX+bWKqzoujHAi4Grxun0jDVWdmuxrYprzi5M4Xy4Xnv4m72Xc
         9Y5rnh5WstEv+hOUNGvqlcaRcsd8mbtTtRHhUUqEgynpmdQ0pAPJbJLPeAP88Tw2UaTn
         OriikXKZEcbWur6rrxKdVru+SCIc847V4gM5hZXOiZdhT/l68ykg5K7C8yV8BBYUIzYT
         1BNUPif+UmLzOTPXGFtG9Tll2xq/6s4xER/Vd5Rkr64dQrl7QTpQ2IbcSv5k501E54W0
         2ypLnJ6PbcKQcEPjfAX5magidXdBn0BPFV3j4QUXvNrhah7xYIkcAE4vrt05N4no5Lh+
         s2AA==
X-Gm-Message-State: ABy/qLZ05ml418Z80yGWzYUB5NtyzpliXi+kxtHqr5AO9DopfJSsBIrM
	VLj7OAvY3RZiGW/1mzTxeWZmpA==
X-Google-Smtp-Source: APBJJlG/wAJcfIpju68VGFRcqr0TVHAHow4SvVhiMcS1KkxsdUVDMnk2DTz9xdfEs8bN6D4ZzbOOfQ==
X-Received: by 2002:a5d:48d2:0:b0:314:9b6:6362 with SMTP id p18-20020a5d48d2000000b0031409b66362mr545549wrs.57.1688622386493;
        Wed, 05 Jul 2023 22:46:26 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id f17-20020adfe911000000b0031416362e23sm882169wrm.3.2023.07.05.22.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 22:46:26 -0700 (PDT)
Date: Thu, 6 Jul 2023 05:47:36 +0000
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
Subject: Re: [PATCH v4 bpf-next 3/6] bpf: populate the per-cpu
 insertions/deletions counters for hashmaps
Message-ID: <ZKZVeJKyZ9XOgP8Y@zh-lab-node-5>
References: <20230705160139.19967-1-aspsk@isovalent.com>
 <20230705160139.19967-4-aspsk@isovalent.com>
 <CAADnVQKX5Lu-frv38AAe15UmzRNMztB9vYSZTk986Y_UkPR30Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKX5Lu-frv38AAe15UmzRNMztB9vYSZTk986Y_UkPR30Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 05, 2023 at 06:24:44PM -0700, Alexei Starovoitov wrote:
> On Wed, Jul 5, 2023 at 9:00 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
> > Initialize and utilize the per-cpu insertions/deletions counters for hash-based
> > maps. Non-trivial changes apply to preallocated maps for which the
> > {inc,dec}_elem_count functions are not called, as there's no need in counting
> > elements to sustain proper map operations.
> >
> > To increase/decrease percpu counters for preallocated hash maps we add raw
> > calls to the bpf_map_{inc,dec}_elem_count functions so that the impact is
> > minimal. For dynamically allocated maps we add corresponding calls to the
> > existing {inc,dec}_elem_count functions.
> >
> > For LRU maps bpf_map_{inc,dec}_elem_count added to the lru pop/free helpers.
> >
> > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > ---
> >  kernel/bpf/hashtab.c | 23 +++++++++++++++++++++--
> >  1 file changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index 56d3da7d0bc6..c23557bf9a1a 100644
> > --- a/kernel/bpf/hashtab.c
> > +++ b/kernel/bpf/hashtab.c
> > @@ -302,6 +302,7 @@ static struct htab_elem *prealloc_lru_pop(struct bpf_htab *htab, void *key,
> >         struct htab_elem *l;
> >
> >         if (node) {
> > +               bpf_map_inc_elem_count(&htab->map);
> >                 l = container_of(node, struct htab_elem, lru_node);
> >                 memcpy(l->key, key, htab->map.key_size);
> >                 return l;
> > @@ -581,10 +582,17 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
> >                 }
> >         }
> >
> > +       err = bpf_map_init_elem_count(&htab->map);
> > +       if (err)
> > +               goto free_extra_elements;
> > +
> >         return &htab->map;
> >
> > +free_extra_elements:
> > +       free_percpu(htab->extra_elems);
> >  free_prealloc:
> > -       prealloc_destroy(htab);
> > +       if (prealloc)
> > +               prealloc_destroy(htab);
> 
> This is a bit difficult to read.
> I think the logic would be easier to understand if bpf_map_init_elem_count
> was done right before htab->buckets = bpf_map_area_alloc()
> and if (err) goto free_htab
> where you would add bpf_map_free_elem_count.

Thanks, I will fix this.

